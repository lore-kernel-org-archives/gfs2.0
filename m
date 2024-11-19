Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AA149C7A
	for <gfs2@lists.linux.dev>; Tue, 19 Nov 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049812; cv=none; b=uOWZ++eFwkg2CE6tAprJy1FhJJ51t+HDUlVHQsLEGwcLFWJX6xO6vZtFKw74VhNnqcXsEmLpoWoVQ7T0CbotO1x+nN21JSmVYidwjcAQPbTcUWEnu4ZDCIg1jXO8J+osirUrHiro8eusS1LiWN9fB4XrkC1imdRFpzxVZIW7J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049812; c=relaxed/simple;
	bh=OSm/jIQql7RYudrg0EZfgpMSzIlMKBvpNRNY/6UCUyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLqI88czwVsGcYBLItpvOFwsH4rCG0qkC/UnvZckzeZqX2s3MGBibv/4d32lGE0bVJPiC4xpCHzdReEgxQSVFIgUPMGsDfwpOoPFDbpjB21yUz5IjuRxTIOLei1QgOshldgks92AJp4C8UHJWeLGjIBy5QgEHy4Fskc7dGHRQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrLHuE5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrLHuE5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732049809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SddY0X8vkOjMr8jZL9QQFkq7v0vmuiDE4QiLQaTJjVk=;
	b=VrLHuE5l0sI2RlRFJxub5eVLizkXnLGOtYevvPKpX3HY/o3hwJHud0RsF8u5QaEUHA0HoG
	mu2OcnRZQpeITC+HmXyQKVtSkL7eSGzk5tSUXe7NY1GFuYun4X+HgHMqNw8WKxBS0U8HhI
	xgz5WVcf6vQsPLCjOgNWzymLRZb+xfs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-IZ80jvMnOei93nfkAw5ouw-1; Tue,
 19 Nov 2024 15:56:48 -0500
X-MC-Unique: IZ80jvMnOei93nfkAw5ouw-1
X-Mimecast-MFC-AGG-ID: IZ80jvMnOei93nfkAw5ouw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8345219560AA
	for <gfs2@lists.linux.dev>; Tue, 19 Nov 2024 20:56:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0311195DF81;
	Tue, 19 Nov 2024 20:56:46 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next] dlm: fix missing rsb put on scan timer
Date: Tue, 19 Nov 2024 15:56:44 -0500
Message-ID: <20241119205644.999314-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nuLqhyorusG5-YpQuMJjM06ANcG2nikFFlX1ejbAJQs_1732049807
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

I figured out we don't cleanup all rsb on toss list right now if all
locks are unlocked in the cluster for a resource. After investigation
I figured out the condition to add_scan() is wrong and I added a comment
for the second important condition for all possible permuations of the
boolean expression.

The current expression:

"(r->res_master_nodeid != our_nodeid &&
  dlm_dir_nodeid(r) != our_nodeid))"

it only covers the case when we are not the master and not the dir node
which is the second case of the added comment in 2. Case 1 and 3 are
forgotten.

Remove also the del_scan() as it always should remove the rsb out of the
scan timer when it's on, if it's not on del_scan() will do nothing.

For find_rsb_nodir() the del_scan() need to be moved before clearing the
RSB_INACTIVE flag as del_scan() is has a WARN_ON() on it.

Fixes: c217adfc8caa ("dlm: fix add_scan and del_scan usage")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 53 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index b406322f26a7..5ea3919b62a0 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -906,9 +906,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
-	/* A dir record will not be on the scan list. */
-	if (r->res_dir_nodeid != our_nodeid)
-		del_scan(ls, r);
+	/* we always deactivate scan timer for the rsb, when
+	 * we move it out of the inactive state as rsb state
+	 * can be changed and scan timers are only for inactive
+	 * rsbs.
+	 */
+	del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref); /* ref is now used in active state */
@@ -1071,10 +1074,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
+	del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref);
-	del_scan(ls, r);
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	goto out;
@@ -1419,9 +1422,13 @@ static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *na
 	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
 			    r_nodeid, result);
 
-	/* A dir record rsb should never be on scan list. */
-	/* Try to fix this with del_scan? */
-	WARN_ON(!list_empty(&r->res_scan_list));
+	/* A dir record rsb should never be on scan list.
+	 * Except when we are the dir and master node.
+	 * This function should only be called by the dir
+	 * node.
+	 */
+	WARN_ON(!list_empty(&r->res_scan_list) &&
+		r->res_master_nodeid != our_nodeid);
 
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -1513,15 +1520,31 @@ static void deactivate_rsb(struct kref *kref)
 
 	/*
 	 * When the rsb becomes unused:
-	 * - If it's not a dir record for a remote master rsb,
-	 *   then it is put on the scan list to be freed.
-	 * - If it's a dir record for a remote master rsb,
-	 *   then it is kept in the inactive state until
-	 *   receive_remove() from the master node.
+	 * - It's on scan list when there is no directory
+	 *   node functionality
+	 * or
+	 * - If we are the rsb master we need to call
+	 *   send_remove() to the dir node and delete ourself.
+	 *
+	 *   The second case is if we are not the dir node we
+	 *   need to delete ourself as well but don't call
+	 *   send_remove() as we are not the master.
+	 *
+	 *   There is a thrid case when the node is master and
+	 *   dir node at the same time. Then the rsb need to be
+	 *   added to the scan timer as well because the scan
+	 *   acts like a local send_remove() that is done
+	 *   immediately.
+	 *
+	 *   The fourth case is the one we need to avoid here,
+	 *   when we are the directory node and not the master.
+	 *   Then we never should be on the scan timer and
+	 *   waiting of receive_remove() of the second case.
+	 *   Then the condition is false.
 	 */
-	if (!dlm_no_directory(ls) &&
-	    (r->res_master_nodeid != our_nodeid) &&
-	    (dlm_dir_nodeid(r) != our_nodeid))
+	if (dlm_no_directory(ls) ||
+	    (r->res_master_nodeid == our_nodeid ||
+	     dlm_dir_nodeid(r) != our_nodeid))
 		add_scan(ls, r);
 
 	if (r->res_lvbptr) {
-- 
2.43.0

