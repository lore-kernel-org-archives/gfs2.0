Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A3208992
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153214; cv=none; b=INsZtAKXZuNziS4gNjxd8qJ5MUmJWIWhvtmIczTDp9JcgemGugQjYiQUkHy4r+a3dlcrQC8Jcq/4XHUxCcpmk4cr/CHRY60nEjMaOgZoeNTqZ/kMKTicndkfIKzFdA+5lJgWu4CxgfM3mCZESNj1nHt4vVqDctn0s7+XvjRz62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153214; c=relaxed/simple;
	bh=S8OhKo0B7IesewDQvCidUyomDEBO3iq8jquoJHGiVaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tK8zggVgtcCjdfJ11HIptCCY/rBaxn4DRId8+8swR6/HRGGM7MuNRFZn5f9rM3Q1aWnSgKEafNwBmMzgb8SzWrM5tVNIeJr/mS3jEPVek0KchmHtXYQ6xYmadWPF5YxI+JPOaxwW5SnL5yb6mGcpm/JzjHhsj4ZYnrlSzVpws9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKEh8c/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKEh8c/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733153211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7o+Vc1wXhLeDpA+FBMbUhMwNHvtcH8LrO0DwWqlsrco=;
	b=KKEh8c/xJOMsA6Sr3qLKbcJ7aTrbKe6YKFWH76cvcBSoTO1JdbsKxzXxe5fp2VZAQgaVoa
	prxmtv+lflAdvRov2eLUpQdOu24HHxXMHYwUxAGKpafrjuMLE69YjMx9Np90lCrXohFJRC
	1cW9ZdlAjPs6GJB3AS/kdQtO1l/2+gY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-MSEEBBYbPNqS6Xo8TxFc8w-1; Mon,
 02 Dec 2024 10:26:50 -0500
X-MC-Unique: MSEEBBYbPNqS6Xo8TxFc8w-1
X-Mimecast-MFC-AGG-ID: MSEEBBYbPNqS6Xo8TxFc8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A0391944CFC
	for <gfs2@lists.linux.dev>; Mon,  2 Dec 2024 15:26:49 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DE9E30000DF;
	Mon,  2 Dec 2024 15:26:48 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.13-rc1 2/5] dlm: fix missing rsb put on scan timer
Date: Mon,  2 Dec 2024 10:26:38 -0500
Message-ID: <20241202152641.3395369-2-aahringo@redhat.com>
In-Reply-To: <20241202152641.3395369-1-aahringo@redhat.com>
References: <20241202152641.3395369-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yC-dm7BypTvAOi9TwBq63O4Xg0Fa5GCM-VxyHAXCqRc_1733153209
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
 fs/dlm/lock.c | 52 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index fc1d710166e9..a8885cf82913 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -824,8 +824,11 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
-	/* A dir record will not be on the scan list. */
-	if (r->res_dir_nodeid != our_nodeid)
+	/* A dir record will not be on the scan list.
+	 * Except if we are the master of the rsb.
+	 */
+	if (r->res_master_nodeid == our_nodeid ||
+	    r->res_dir_nodeid != our_nodeid)
 		del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
@@ -989,10 +992,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
+	del_scan(ls, r);
 	list_move(&r->res_slow_list, &ls->ls_slow_active);
 	rsb_clear_flag(r, RSB_INACTIVE);
 	kref_init(&r->res_ref);
-	del_scan(ls, r);
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	goto out;
@@ -1337,9 +1340,13 @@ static int _dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *na
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
 
@@ -1431,15 +1438,32 @@ static void deactivate_rsb(struct kref *kref)
 
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
+	 * - First case is if we are the rsb master we need to
+	 *   call send_remove() to the dir node and delete
+	 *   ourself.
+	 *
+	 *   The second case is if we are not the dir node we
+	 *   need to delete ourself as well but don't call
+	 *   send_remove() as we are not the master.
+	 *
+	 *   The thrid case when the node is master and
+	 *   dir node at the same time. Then the rsb need to be
+	 *   added to the scan timer as well because the scan
+	 *   acts like a local send_remove() that is done
+	 *   immediately.
+	 *
+	 *   The fourth case is the one we need to avoid here,
+	 *   when we are the directory node and not the master.
+	 *   This is the inverse of the condition below.
+	 *   Then we never should be on the scan timer and
+	 *   waiting of receive_remove() of the first case.
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

