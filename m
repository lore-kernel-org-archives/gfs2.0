Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760808F60
	for <gfs2@lists.linux.dev>; Tue, 12 Sep 2023 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694523954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NpQ4v7QsEDDnWuMllANNk00pJCh80ZGkZFSUEBUn72Q=;
	b=SQZW1AlYTAT8H2ZKX8VCTgTIO8HiHgmKs1q3WgnRrFY+9gwk9OpCpRti6je8+kgnBlzeaS
	ULOUShvMz/H+ppj6Kkiub0Ofxkp1YvX2PP+UXuki4cvkMaHqbyO4UETjFbPe1edx8DKOEv
	ELTCRaFlIOUFaNWUSENTB0+a+rZFc+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-gKKWFvUBPoODHC4tDaKLLw-1; Tue, 12 Sep 2023 09:05:52 -0400
X-MC-Unique: gKKWFvUBPoODHC4tDaKLLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACDBE8564EF
	for <gfs2@lists.linux.dev>; Tue, 12 Sep 2023 13:05:52 +0000 (UTC)
Received: from vishnu.users.ipa.redhat.com (unknown [10.22.32.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 861A440C6EA8
	for <gfs2@lists.linux.dev>; Tue, 12 Sep 2023 13:05:52 +0000 (UTC)
From: Bob Peterson <rpeterso@redhat.com>
To: gfs2 <gfs2@lists.linux.dev>
Subject: [PATCH] gfs2: fix glock shrinker ref issues
Date: Tue, 12 Sep 2023 08:05:51 -0500
Message-ID: <20230912130551.70709-1-rpeterso@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Before this patch, function gfs2_scan_glock_lru would only try to free
glocks that had a reference count of 0. But if the reference count ever
got to 0, the glock should have already been freed.

Shrinker function gfs2_dispose_glock_lru checks whether glocks on the
LRU are demote_ok, and if so, tries to demote them. But that's only
possible if the reference count is at least 1.

This patch changes gfs2_scan_glock_lru so it will try to demote and/or
dispose of glocks that have a reference count of 1 and which are either
demotable, or are already unlocked.

Here is the life cycle of an inode glock from start to finish with
"touch /mnt/gfs2/test" along with changes to gl->gl_lockref.count:

1. gfs2_glock_get - glock created                               = 1
2. gfs2_create_inode calls gfs2_glock_nq_init (glock_hold)   1 -> 2
3. do_xmote calls gfs2_glock_hold to call lm_lock() for the
   dlm request gl->gl_lockref.count++;                       2 -> 3
4. State_change gl->gl_lockref.count++;                      3 -> 4
5. gfs2_glock_put                                            4 -> 3
6. gfs2_permission                                           3 -> 4
7. gfs2_glock_put                                            4 -> 3
8. gfs2_setattr                                              3 -> 4
9. gfs2_glock_put                                            4 -> 3
10. glock_work_func drop_refs == 1                           3 -> 2
11. gfs2_add_revoke gfs2_glock_hold                          2 -> 3
12. glock_work_func drop_refs == 1                           3 -> 2

So now the inode glock is cached in EX. Here is what happens to it when
you then do "rm /mnt/gfs2/test":

13. gfs2_unlink                                              2 -> 3
14. gfs2_glock_put                                           3 -> 2
15. evict_should_delete, gfs2_glock_nq_init                  2 -> 3
16. gfs2_glock_put                                           3 -> 2
17. gfs2_glock_put                                           2 -> 1

So now it's on the LRU with a ref count of 1 after being deleted.
When you dump the glock list, however, it takes an additional reference:

18 - gfs2_glock_iter_next                                    1 -> 2

So it shows up in the list as having a ref count of 2, although the ref
should be immediately dropped after the glock dump.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/glock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9cbf8d98489a..4a280be229a6 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2010,7 +2010,9 @@ static long gfs2_scan_glock_lru(int nr)
 		if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
 			if (!spin_trylock(&gl->gl_lockref.lock))
 				continue;
-			if (!gl->gl_lockref.count) {
+			if (gl->gl_lockref.count <= 1 &&
+			    (gl->gl_state == LM_ST_UNLOCKED ||
+			     demote_ok(gl))) {
 				list_move(&gl->gl_lru, &dispose);
 				atomic_dec(&lru_count);
 				freed++;
-- 
2.41.0

