Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3106FD9
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694098827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrPMlY95Wkcd1rHdgAJJ7DCZVxJSXQy1fxhpo61ufck=;
	b=Fr77XOKRaf8bASGx9S5UURR2q/RNKob54NibFJr850Dhl9X26hdRB42Q5WfHlqgwx++csA
	j2dwQ8826uFHBsC/rKypFwmRMyS6G3zU1dBPSKCFAbQbBXA3jt2MbCtb8yIKypu0A0n8/w
	XHvKB6Jc7zXDH9+Xw2NlgpMkDmOXdak=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-u0X4jaXtOuSjIK6BKCZ38A-1; Thu, 07 Sep 2023 11:00:26 -0400
X-MC-Unique: u0X4jaXtOuSjIK6BKCZ38A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DA151C0CCBB
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 15:00:26 +0000 (UTC)
Received: from vishnu.users.ipa.redhat.com (unknown [10.22.8.234])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9ACA2026D4B
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 15:00:25 +0000 (UTC)
From: Bob Peterson <rpeterso@redhat.com>
To: gfs2 <gfs2@lists.linux.dev>
Subject: [PATCH] gfs2: glock shrinker reform
Date: Thu,  7 Sep 2023 10:00:25 -0500
Message-ID: <20230907150025.685598-1-rpeterso@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Before this patch the gfs2 glock shrinker had several problems. Inode
glocks would often be put onto the LRU with a reference count of 2,
in the EX state, until a demote request came in from another node.

When the shrinker called count_objects, gfs2_glock_shrink_count returned
the number of glocks on the LRU, which is wrong. According to shrinker.h
it should return "value for the number of freeable objects" but not all
of glocks on the LRU are freeable.

The shrinker itself only freed glocks if the reference count was zero.
But if the reference count ever got to zero, __gfs2_glock_put would have
already removed them from the LRU and freed them (via lm_put_lock).

The net result is that, under memory pressure, the vfs shrinker asked
gfs2 how many glocks were eligible to be freed, and it responded "All of
them on the LRU." But when it tried to free them, the reference counts
were 1 or 2, so none were freed. Since none were freed, the vfs shrinker
would repeatedly call the gfs2 shrinker hundreds or thousands of times,
none of which did any real work.

This patch changes gfs2_scan_glock_lru so glocks are counted as freeable
if their reference count is <= 2 AND if they are in the Unlocked state
or can be demoted. A parameter was added to indicate whether the
eligible glocks should be freed or merely counted.

The gfs2_glock_shrink_count function then calls it with false, and if
none are returned, returns SHRINK_EMPTY as per the shrinker requirements.
The gfs2_glock_shrink_scan calls it with true, and frees any that
qualify.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/glock.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9cbf8d98489a..f31c2e040595 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1990,17 +1990,18 @@ __acquires(&lru_lock)
 /**
  * gfs2_scan_glock_lru - Scan the LRU looking for locks to demote
  * @nr: The number of entries to scan
+ * @do_free: if true, eligible glocks are freed, if false, they are counted.
  *
  * This function selects the entries on the LRU which are able to
  * be demoted, and then kicks off the process by calling
  * gfs2_dispose_glock_lru() above.
  */
 
-static long gfs2_scan_glock_lru(int nr)
+static long gfs2_scan_glock_lru(int nr, bool do_free)
 {
 	struct gfs2_glock *gl, *next;
 	LIST_HEAD(dispose);
-	long freed = 0;
+	long freeable = 0;
 
 	spin_lock(&lru_lock);
 	list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
@@ -2010,10 +2011,14 @@ static long gfs2_scan_glock_lru(int nr)
 		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
 			if (!spin_trylock(&gl->gl_lockref.lock))
 				continue;
-			if (!gl->gl_lockref.count) {
-				list_move(&gl->gl_lru, &dispose);
-				atomic_dec(&lru_count);
-				freed++;
+			if (gl->gl_lockref.count <= 2 &&
+			    (gl->gl_state == LM_ST_UNLOCKED ||
+			     demote_ok(gl))) {
+				if (do_free) {
+					list_move(&gl->gl_lru, &dispose);
+					atomic_dec(&lru_count);
+				}
+				freeable++;
 			}
 			spin_unlock(&gl->gl_lockref.lock);
 		}
@@ -2022,7 +2027,7 @@ static long gfs2_scan_glock_lru(int nr)
 		gfs2_dispose_glock_lru(&dispose);
 	spin_unlock(&lru_lock);
 
-	return freed;
+	return freeable;
 }
 
 static unsigned long gfs2_glock_shrink_scan(struct shrinker *shrink,
@@ -2030,13 +2035,15 @@ static unsigned long gfs2_glock_shrink_scan(struct shrinker *shrink,
 {
 	if (!(sc->gfp_mask & __GFP_FS))
 		return SHRINK_STOP;
-	return gfs2_scan_glock_lru(sc->nr_to_scan);
+	return gfs2_scan_glock_lru(sc->nr_to_scan, true);
 }
 
 static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
 					     struct shrink_control *sc)
 {
-	return vfs_pressure_ratio(atomic_read(&lru_count));
+	long freeable = gfs2_scan_glock_lru(INT_MAX, false);
+
+	return freeable ? vfs_pressure_ratio(freeable) : SHRINK_EMPTY;
 }
 
 static struct shrinker glock_shrinker = {
-- 
2.41.0

