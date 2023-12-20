Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C929487A7
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf8ooP8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g6v+LOsuzGD1jI5ZaxTp/8zeNQaAa6ovOEQrOLVxK/w=;
	b=Nf8ooP8YhtmjjTbZhcbqZ2K61150RhVCsFWEMNAXujySjL8u6/DL52Mz0f6JPhv+XXMkjY
	6QtxWEmDLxaa/qgjUwhZL+KAUU9UwVmBT0TMxtO36bC5GMdyhGWDfxkoFDunwFUu4vfAOh
	zVzOfoC3/DBvpyi3zeIYyRfkqJVR24E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Mv39Lic3OsufhCZcoIe0lw-1; Wed, 20 Dec 2023 15:12:23 -0500
X-MC-Unique: Mv39Lic3OsufhCZcoIe0lw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65F17833AE1
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:23 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E18B1492BE6;
	Wed, 20 Dec 2023 20:12:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/4] gfs2: Minor gfs2_ail1_empty cleanup
Date: Wed, 20 Dec 2023 21:12:19 +0100
Message-ID: <20231220201222.1581061-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Change gfs2_ail1_empty() to return %true when the ail1 list is empty.

Based on that, make the loop in empty_ail1_list() more obvious.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e5271ae87d1c..61cd52a579d9 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -352,14 +352,15 @@ static int gfs2_ail1_empty_one(struct gfs2_sbd *sdp, struct gfs2_trans *tr,
  * @sdp: The superblock
  * @max_revokes: If non-zero, add revokes where appropriate
  *
- * Tries to empty the ail1 lists, starting with the oldest first
+ * Tries to empty the ail1 lists, starting with the oldest first.
+ * Returns %true if the ail1 list is now empty.
  */
 
-static int gfs2_ail1_empty(struct gfs2_sbd *sdp, int max_revokes)
+static bool gfs2_ail1_empty(struct gfs2_sbd *sdp, int max_revokes)
 {
 	struct gfs2_trans *tr, *s;
 	int oldest_tr = 1;
-	int ret;
+	bool empty;
 
 	spin_lock(&sdp->sd_ail_lock);
 	list_for_each_entry_safe_reverse(tr, s, &sdp->sd_ail1_list, tr_list) {
@@ -369,7 +370,7 @@ static int gfs2_ail1_empty(struct gfs2_sbd *sdp, int max_revokes)
 			oldest_tr = 0;
 	}
 	gfs2_log_update_flush_tail(sdp);
-	ret = list_empty(&sdp->sd_ail1_list);
+	empty = list_empty(&sdp->sd_ail1_list);
 	spin_unlock(&sdp->sd_ail_lock);
 
 	if (test_bit(SDF_WITHDRAWING, &sdp->sd_flags)) {
@@ -377,7 +378,7 @@ static int gfs2_ail1_empty(struct gfs2_sbd *sdp, int max_revokes)
 		gfs2_withdraw(sdp);
 	}
 
-	return ret;
+	return empty;
 }
 
 static void gfs2_ail1_wait(struct gfs2_sbd *sdp)
@@ -974,8 +975,9 @@ void gfs2_ail_drain(struct gfs2_sbd *sdp)
 static void empty_ail1_list(struct gfs2_sbd *sdp)
 {
 	unsigned long start = jiffies;
+	bool empty = false;
 
-	for (;;) {
+	while (!empty) {
 		if (time_after(jiffies, start + (HZ * 600))) {
 			fs_err(sdp, "Error: In %s for 10 minutes! t=%d\n",
 			       __func__, current->journal_info ? 1 : 0);
@@ -984,8 +986,7 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 		}
 		gfs2_ail1_start(sdp);
 		gfs2_ail1_wait(sdp);
-		if (gfs2_ail1_empty(sdp, 0))
-			return;
+		empty = gfs2_ail1_empty(sdp, 0);
 	}
 }
 
-- 
2.43.0

