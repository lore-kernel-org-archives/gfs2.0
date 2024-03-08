Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6433FBAD
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914707; cv=none; b=sVeLKBdIoeIKW8jXlQ5HIGGvVGyuT36iXFwj0hTC1kCvGbbiv64NFHYmwYttC8xprOGk2y6gSOQvyrLGXjO517Zg2n5dKs2oxMd477yZjoX1+gI3zzgKK0oSdY7xd+vq3yivNpyWXwAjGAFKJbOiyj9DZse9zsWHOvL/ZMongSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914707; c=relaxed/simple;
	bh=oBvRLgGbfs7MVeCod7SRl6iAS1zslCxBrvsMuWrCfNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtSSrfT6LRz7hVopEviBcLWNchtoFBPfJ9rSDdcxSaXI3bvMaQydotfIrlcDkbmD7Yb5MJbGF/faXtr0oLKNNx3VzxUQWWF7bns748QmwApTa0YzE6LYodeb/qeu6Dhcu5Yprd4LcZocSvGigq9T0WtrkMIZ87VrvM3SWzOQF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JagFsIbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JagFsIbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709914704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0whlHm1MY/ZgDUmI9H0O0fPg1iTqmlboiQr8Xo5Xww=;
	b=JagFsIbAqzkhkXEpxR2fXflZdzVdyhfWHU50U2LRN9u32eThCCJc06aXmYpCmgZdMt8WiN
	UD/8+PTYRAszoFHufnaWzQyf3jVYWJi0gNORrsg+1t/Us9lS/JgWPPju2Umu5PFlBCbQTq
	+eJUk8rBryiu5ekjbxIKAHF/ugfx0kk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-pqrucvqKPKa98VDAFUx29w-1; Fri,
 08 Mar 2024 11:18:23 -0500
X-MC-Unique: pqrucvqKPKa98VDAFUx29w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E2853CBDF73
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:23 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 138C8492BD5;
	Fri,  8 Mar 2024 16:18:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC v6.8-rc6 7/7] dlm: remove callback reference counting
Date: Fri,  8 Mar 2024 11:18:18 -0500
Message-ID: <20240308161818.2388451-8-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-1-aahringo@redhat.com>
References: <20240308161818.2388451-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since we copying all necessary callback information from the lkb to the
per callback structure this structure increased in the amount of memory
being used. As each lkb structure holds a callback structure reference
for the last callback that occurred this can hold more memory than
necessary. We just copy the necessary information as it was before since
commit 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks").

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c          | 51 ++++++++++++-------------------------------
 fs/dlm/ast.h          |  3 ---
 fs/dlm/debug_fs.c     |  2 +-
 fs/dlm/dlm_internal.h |  7 +++---
 fs/dlm/lock.c         |  8 ++++---
 fs/dlm/memory.c       |  4 ----
 fs/dlm/user.c         |  2 +-
 7 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index f324d6487ac2..fdc02885bec3 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -18,25 +18,6 @@
 #include "user.h"
 #include "ast.h"
 
-void dlm_release_callback(struct kref *ref)
-{
-	struct dlm_callback *cb = container_of(ref, struct dlm_callback, ref);
-
-	dlm_free_cb(cb);
-}
-
-void dlm_callback_set_last_ptr(struct dlm_callback **from,
-			       struct dlm_callback *to)
-{
-	if (*from)
-		kref_put(&(*from)->ref, dlm_release_callback);
-
-	if (to)
-		kref_get(&to->ref);
-
-	*from = to;
-}
-
 static void dlm_callback_work(struct work_struct *work)
 {
 	struct dlm_callback *cb = container_of(work, struct dlm_callback, work);
@@ -53,7 +34,7 @@ static void dlm_callback_work(struct work_struct *work)
 		cb->astfn(cb->astparam);
 	}
 
-	kref_put(&cb->ref, dlm_release_callback);
+	dlm_free_cb(cb);
 }
 
 int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
@@ -70,11 +51,11 @@ int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		/* if cb is a bast, it should be skipped if the blocking mode is
 		 * compatible with the last granted mode
 		 */
-		if (lkb->lkb_last_cast) {
-			if (dlm_modes_compat(mode, lkb->lkb_last_cast->mode)) {
+		if (lkb->lkb_last_cast_cb_mode != -1) {
+			if (dlm_modes_compat(mode, lkb->lkb_last_cast_cb_mode)) {
 				log_debug(ls, "skip %x bast mode %d for cast mode %d",
 					  lkb->lkb_id, mode,
-					  lkb->lkb_last_cast->mode);
+					  lkb->lkb_last_cast_cb_mode);
 				goto out;
 			}
 		}
@@ -85,8 +66,8 @@ int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		 * is a bast for the same mode or a more restrictive mode.
 		 * (the addional > PR check is needed for PR/CW inversion)
 		 */
-		if (lkb->lkb_last_cb && lkb->lkb_last_cb->flags & DLM_CB_BAST) {
-			prev_mode = lkb->lkb_last_cb->mode;
+		if (lkb->lkb_last_cb_flags & DLM_CB_BAST) {
+			prev_mode = lkb->lkb_last_cb_mode;
 
 			if ((prev_mode == mode) ||
 			    (prev_mode > mode && prev_mode > DLM_LOCK_PR)) {
@@ -97,19 +78,24 @@ int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		}
 
 		lkb->lkb_last_bast_time = ktime_get();
-		lkb->lkb_last_bast_mode = mode;
+		lkb->lkb_last_bast_cb_mode = mode;
 	} else if (flags & DLM_CB_CAST) {
-		if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags) && lkb->lkb_last_cast) {
-			prev_mode = lkb->lkb_last_cb->mode;
+		if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags) &&
+		    lkb->lkb_last_cast_cb_mode != -1) {
+			prev_mode = lkb->lkb_last_cast_cb_mode;
 
 			if (!status && lkb->lkb_lksb->sb_lvbptr &&
 			    dlm_lvb_operations[prev_mode + 1][mode + 1])
 				copy_lvb = true;
 		}
 
+		lkb->lkb_last_cast_cb_mode = mode;
 		lkb->lkb_last_cast_time = ktime_get();
 	}
 
+	lkb->lkb_last_cb_mode = mode;
+	lkb->lkb_last_cb_flags = flags;
+
 	*cb = dlm_allocate_cb();
 	if (!*cb) {
 		rv = DLM_ENQUEUE_CALLBACK_FAILURE;
@@ -130,15 +116,6 @@ int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	(*cb)->lkb_lksb = lkb->lkb_lksb;
 	kref_init(&(*cb)->ref);
 
-	if (flags & DLM_CB_BAST) {
-		lkb->lkb_last_bast_time = ktime_get();
-		lkb->lkb_last_bast_mode = mode;
-	} else if (flags & DLM_CB_CAST) {
-		dlm_callback_set_last_ptr(&lkb->lkb_last_cast, *cb);
-		lkb->lkb_last_cast_time = ktime_get();
-	}
-
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, *cb);
 	rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
 
 out:
diff --git a/fs/dlm/ast.h b/fs/dlm/ast.h
index 9bd12409e1ee..9093ff043bee 100644
--- a/fs/dlm/ast.h
+++ b/fs/dlm/ast.h
@@ -19,10 +19,7 @@ int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 			   struct dlm_callback **cb);
 void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
                 uint32_t sbflags);
-void dlm_callback_set_last_ptr(struct dlm_callback **from,
-			       struct dlm_callback *to);
 
-void dlm_release_callback(struct kref *ref);
 int dlm_callback_start(struct dlm_ls *ls);
 void dlm_callback_stop(struct dlm_ls *ls);
 void dlm_callback_suspend(struct dlm_ls *ls);
diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 289d959c7700..19cdedd56629 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -247,7 +247,7 @@ static void print_format3_lock(struct seq_file *s, struct dlm_lkb *lkb,
 		   lkb->lkb_status,
 		   lkb->lkb_grmode,
 		   lkb->lkb_rqmode,
-		   lkb->lkb_last_bast_mode,
+		   lkb->lkb_last_bast_cb_mode,
 		   rsb_lookup,
 		   lkb->lkb_wait_type,
 		   lkb->lkb_lvbseq,
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 8fabf908fd4a..8fd548bd9b83 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -289,9 +289,10 @@ struct dlm_lkb {
 	struct list_head	lkb_ownqueue;	/* list of locks for a process */
 	ktime_t			lkb_timestamp;
 
-	struct dlm_callback	*lkb_last_cast;
-	struct dlm_callback	*lkb_last_cb;
-	int			lkb_last_bast_mode;
+	int8_t			lkb_last_cast_cb_mode;
+	int8_t			lkb_last_bast_cb_mode;
+	int8_t			lkb_last_cb_mode;
+	uint8_t			lkb_last_cb_flags;
 	ktime_t			lkb_last_cast_time;	/* for debugging */
 	ktime_t			lkb_last_bast_time;	/* for debugging */
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 7306e6db5361..a2d93ffbee17 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1197,7 +1197,9 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	if (!lkb)
 		return -ENOMEM;
 
-	lkb->lkb_last_bast_mode = -1;
+	lkb->lkb_last_bast_cb_mode = DLM_LOCK_IV;
+	lkb->lkb_last_cast_cb_mode = DLM_LOCK_IV;
+	lkb->lkb_last_cb_mode = DLM_LOCK_IV;
 	lkb->lkb_nodeid = -1;
 	lkb->lkb_grmode = DLM_LOCK_IV;
 	kref_init(&lkb->lkb_ref);
@@ -5989,7 +5991,7 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 
 	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
 		list_del(&cb->list);
-		kref_put(&cb->ref, dlm_release_callback);
+		dlm_free_cb(cb);
 	}
 
 	spin_unlock(&ls->ls_clear_proc_locks);
@@ -6030,7 +6032,7 @@ static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 	spin_lock(&proc->asts_spin);
 	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
 		list_del(&cb->list);
-		kref_put(&cb->ref, dlm_release_callback);
+		dlm_free_cb(cb);
 	}
 	spin_unlock(&proc->asts_spin);
 }
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 64f212a066cf..be9398ddf357 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -127,10 +127,6 @@ void dlm_free_lkb(struct dlm_lkb *lkb)
 		}
 	}
 
-	/* drop references if they are set */
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cast, NULL);
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, NULL);
-
 	kmem_cache_free(lkb_cache, lkb);
 }
 
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 741dbc532d0b..fbae97c6e4fb 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -864,7 +864,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	rv = copy_result_to_user(&cb->ua,
 				 test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
 				 cb->flags, cb->mode, cb->copy_lvb, buf, count);
-	kref_put(&cb->ref, dlm_release_callback);
+	dlm_free_cb(cb);
 	return rv;
 }
 
-- 
2.43.0

