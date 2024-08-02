Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516C15C131
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619637; cv=none; b=fDtfQdnxaBulEq7g9BVfG51C7457X96tUlCm8rzHXSdk6sfZeM6Wn7w+Ed7v6LrphVV9VK5uFIeT1iBGFaGAesAdaMdPbwPZRQHU6RfXiXpiY+yfkvQVIGGTraNYpqXFP//o8bUoi5iKCpG+wF4E1RUiBybimGV/My0bPdq80KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619637; c=relaxed/simple;
	bh=sW5IT7bduj/9w7OHkHGjqzSeRo3b9ZIQMPFLtPeJ0CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVyMhRcge7+BAeSydmly4Q9E88nR8O67cwcUsYruct/HH3bYkVfNqNNhutxR5OMOhU6Q2Yv9CbOXhrqSP89lxCxhb54HNkEmHjhJwMd/6rhf6wH0l0Ga8LCETHh3yMSKAPefQ18Q7STqyv7PTxuoOaW8fj4DE+gFRBDKy5B3E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPC/qdnQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPC/qdnQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI1gsXb+wikO0ReKALvyEGF8NNehIkanF6BL2WXavn4=;
	b=PPC/qdnQNCiZE50r/AYuSihxvuqcxgyJIkAYn5B0wPrhE2KYLRMc/okD7mfgc4z3Mi5tDI
	xew27euu3xdeiS/MiY7+63AYdzis0p5OcUcLU7us1aatZYUu0xEQuZ9hw5Ri3UFb9Tk7vf
	E1NIvwEf4oIES4zHaAXVsCzUqx+8k0E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-Wvrl6Ep5P46QSMHG3ipCzA-1; Fri,
 02 Aug 2024 13:27:13 -0400
X-MC-Unique: Wvrl6Ep5P46QSMHG3ipCzA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 487EF1955F69
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:09 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89EC719560AE;
	Fri,  2 Aug 2024 17:27:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 06/10] dlm: async freeing of lockspace resources
Date: Fri,  2 Aug 2024 13:26:43 -0400
Message-ID: <20240802172647.582745-6-aahringo@redhat.com>
In-Reply-To: <20240802172647.582745-1-aahringo@redhat.com>
References: <20240802172647.582745-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch handles freeing of lockspace resources asynchronously besides
the release_lockspace() context. The release_lockspace() context is
sometimes called in a time critical context, e.g. umount syscall. Most
every user space init system will timeout if it takes too long. To
reduce the potential waiting time we deregister in release_lockspace()
the lockspace from the DLM subsystem and do the actual releasing of
lockspace resource in a worker of a workqueue following recommendation
of:

https://lore.kernel.org/all/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp/T/#u

as flushing of system workqueues are not allowed. The most time to
release the DLM resources are spent to release the data structures
"ls->ls_lkbxa" and "ls->ls_rsbtbl" as they iterate over each entries and
those data structures can contain millions of entries. This patch handles
for now only freeing of those data structures as those operations are
the most reason why release_lockspace() blocking of being returned.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  4 +++
 fs/dlm/lockspace.c    | 77 ++++++++++++++++++++++++-------------------
 fs/dlm/main.c         | 10 ++++++
 3 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 32d98e63d25e..0562099e60eb 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -660,6 +660,8 @@ struct dlm_ls {
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
 
+	struct work_struct	ls_free_work;
+
 	int			ls_namelen;
 	char			ls_name[DLM_LOCKSPACE_LEN + 1];
 };
@@ -803,6 +805,8 @@ static inline void dlm_set_sbflags_val(struct dlm_lkb *lkb, uint32_t val)
 			  __DLM_SBF_MAX_BIT);
 }
 
+extern struct workqueue_struct *dlm_wq;
+
 int dlm_plock_init(void);
 void dlm_plock_exit(void);
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index bf14016d53e1..8afac6e2dff0 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -315,6 +315,44 @@ static int threads_start(void)
 	return error;
 }
 
+static int lkb_idr_free(struct dlm_lkb *lkb)
+{
+	if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
+		dlm_free_lvb(lkb->lkb_lvbptr);
+
+	dlm_free_lkb(lkb);
+	return 0;
+}
+
+static void rhash_free_rsb(void *ptr, void *arg)
+{
+	struct dlm_rsb *rsb = ptr;
+
+	dlm_free_rsb(rsb);
+}
+
+static void free_lockspace(struct work_struct *work)
+{
+	struct dlm_ls *ls  = container_of(work, struct dlm_ls, ls_free_work);
+	struct dlm_lkb *lkb;
+	unsigned long id;
+
+	/*
+	 * Free all lkb's in xa
+	 */
+	xa_for_each(&ls->ls_lkbxa, id, lkb) {
+		lkb_idr_free(lkb);
+	}
+	xa_destroy(&ls->ls_lkbxa);
+
+	/*
+	 * Free all rsb's on rsbtbl
+	 */
+	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
+
+	kfree(ls);
+}
+
 static int new_lockspace(const char *name, const char *cluster,
 			 uint32_t flags, int lvblen,
 			 const struct dlm_lockspace_ops *ops, void *ops_arg,
@@ -445,6 +483,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	spin_lock_init(&ls->ls_cb_lock);
 	INIT_LIST_HEAD(&ls->ls_cb_delay);
 
+	INIT_WORK(&ls->ls_free_work, free_lockspace);
+
 	ls->ls_recoverd_task = NULL;
 	mutex_init(&ls->ls_recoverd_active);
 	spin_lock_init(&ls->ls_recover_lock);
@@ -627,15 +667,6 @@ int dlm_new_user_lockspace(const char *name, const char *cluster,
 				   ops_arg, ops_result, lockspace);
 }
 
-static int lkb_idr_free(struct dlm_lkb *lkb)
-{
-	if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
-		dlm_free_lvb(lkb->lkb_lvbptr);
-
-	dlm_free_lkb(lkb);
-	return 0;
-}
-
 /* NOTE: We check the lkbxa here rather than the resource table.
    This is because there may be LKBs queued as ASTs that have been unlinked
    from their RSBs and are pending deletion once the AST has been delivered */
@@ -667,17 +698,8 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	return rv;
 }
 
-static void rhash_free_rsb(void *ptr, void *arg)
-{
-	struct dlm_rsb *rsb = ptr;
-
-	dlm_free_rsb(rsb);
-}
-
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
-	struct dlm_lkb *lkb;
-	unsigned long id;
 	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
@@ -735,19 +757,6 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	xa_destroy(&ls->ls_recover_xa);
 	kfree(ls->ls_recover_buf);
 
-	/*
-	 * Free all lkb's in xa
-	 */
-	xa_for_each(&ls->ls_lkbxa, id, lkb) {
-		lkb_idr_free(lkb);
-	}
-	xa_destroy(&ls->ls_lkbxa);
-
-	/*
-	 * Free all rsb's on rsbtbl
-	 */
-	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
-
 	/*
 	 * Free structures on any other lists
 	 */
@@ -757,9 +766,11 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	dlm_clear_members(ls);
 	dlm_clear_members_gone(ls);
 	kfree(ls->ls_node_array);
-	log_rinfo(ls, "release_lockspace final free");
-	kfree(ls);
 
+	log_rinfo(ls, "%s final free", __func__);
+
+	/* delayed free of data structures see free_lockspace() */
+	queue_work(dlm_wq, &ls->ls_free_work);
 	module_put(THIS_MODULE);
 	return 0;
 }
diff --git a/fs/dlm/main.c b/fs/dlm/main.c
index 6ca28299c9db..cb15db8ba9bf 100644
--- a/fs/dlm/main.c
+++ b/fs/dlm/main.c
@@ -22,6 +22,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/dlm.h>
 
+struct workqueue_struct *dlm_wq;
+
 static int __init init_dlm(void)
 {
 	int error;
@@ -50,10 +52,16 @@ static int __init init_dlm(void)
 	if (error)
 		goto out_user;
 
+	dlm_wq = alloc_workqueue("dlm_wq", 0, 0);
+	if (!dlm_wq)
+		goto out_plock;
+
 	printk("DLM installed\n");
 
 	return 0;
 
+ out_plock:
+	dlm_plock_exit();
  out_user:
 	dlm_user_exit();
  out_debug:
@@ -70,6 +78,8 @@ static int __init init_dlm(void)
 
 static void __exit exit_dlm(void)
 {
+	/* be sure every pending work e.g. freeing is done */
+	destroy_workqueue(dlm_wq);
 	dlm_plock_exit();
 	dlm_user_exit();
 	dlm_config_exit();
-- 
2.43.0

