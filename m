Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB1130A59
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640930; cv=none; b=llpglKShV9Zk+NH12LjpQLX+Z+uTdJN5phrZyzILW3RawfsHsvxAAEl0lJ9oW9hTCuKPS8nr02mjiatLmyuAxoOZHsbFw1WnNCJ6foMCkKeSryWU/SIJ1r40MVBKxl/qisvecvq5ZlZ77dVobegxGvUvf+dKj2/JToYTo23xIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640930; c=relaxed/simple;
	bh=8fPAf2OYO4QK5ibvV0TeXZQgWN21NG6nGF20K2RnPw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnoxPPvWn5oofKLQp61z4FrrFUj9SHHKJEkeJC+557bUWPxjG1uav73XbFGnuQVS5I2YB5q9L6GB4BGDgcTZa3ou6sUcD61GjaslaqNg1J423L3xU9H6t2s1qK64+q1TR0jisxMt8vvRiumpOl3jpi4YOW+g2cJEgZNjOM/EPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2zGP9kn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2zGP9kn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg0zkmf0jRZMJhIPIT7ISCBIEYsqxcCu5+N3pisNYX0=;
	b=S2zGP9knSPyhi8qFtojByx1wKLh+ke0ZWcWVSce5SAbLxFfGg2LI/iPxcg4oItThNaRxih
	R9eQAiP6G21TsG2VEWSPP11gRFh8b3dl+K4ayfFpUX/JdMh06Ya4nmXo4dxWqu6iNXMQVC
	0+i3v78Va/+eIjknZLl2WesOlKRsibw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-1GoFJhzsM6y4qY5W4F325A-1; Thu,
 28 Mar 2024 11:48:45 -0400
X-MC-Unique: 1GoFJhzsM6y4qY5W4F325A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E38183C0C102
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D86E7C04128;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 09/10] dlm: fix race between final callback and remove
Date: Thu, 28 Mar 2024 11:48:41 -0400
Message-ID: <20240328154842.1099288-9-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch fixes the following issue (described by David Teigland):

node 1 is dir
node 2 is master
node 3 is other

1->2: unlock
2: put final lkb, rsb moved to toss
2->1: unlock_reply
1: queue lkb callback with EUNLOCK  (*)
2->1: remove
1: receive_remove ignored (rsb on keep because of queued lkb callback)
1: complete lkb callback, put_lkb, move rsb to toss
3->1: lookup
1->3: lookup_reply master=2
3->2: request
2->3: request_reply EBADR

(*) When queuing the unlock callback, perhaps we could save the callback
information in another struct, and not keep the lkb/rsb referenced for
the callback.  Then the lkb would be freed immediately in unlock_reply,
and the rsb would be moved to the toss list in the unlock_reply.

This theory assumes some large delay in delivering the unlock callback,
because the remove message from 2->1 only happens after some seconds.

When node 3 does the request and 2 replies wrongly with EBADR because
the dir node 1 wrongly replies the master is 2 but it isn't anymore. We
have a deadlock situation that is not resolveable anymore. The problem
became a bigger issue when we reverted commit 96006ea6d4ee ("dlm: fix
missing dir remove") that was probably a "bandaid" fix for this issue
without knowing the real source of it by resending the remove message.

The root of this issue is a unexpected refcount situation when receiving
a remove message. This is however with default configuration parameters
are very unlikely race but could occur in some certain situations. A
specific case would be a final unlock request as described above but the
callback workqueue still hold a reference of the lkb so the rsb is not
on the toss list as it is required and expected to handle the remove
message.

This patch is fixing this issue by not keeping the lkb reference when
handling the callback anymore. User space callback handling is also
being effected because there is a unknown time until the user space
program does a device_read().

This patch slowers the callback handling but future patches will mark
the callback workqueue handling as deprecated and call the DLM callbacks
directly which should not have this problem for kernel locks. For user
space locks the locking behaviour is known to be slow. Before looking
again at it to maybe improve the behaviour that is not deprecated we
fixing this potential issue.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c          | 166 ++++++++++++++++--------------------------
 fs/dlm/ast.h          |  10 +--
 fs/dlm/dlm_internal.h |  60 +++++++++------
 fs/dlm/lock.c         |  20 ++---
 fs/dlm/user.c         |  86 ++++++----------------
 5 files changed, 129 insertions(+), 213 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 5ea0b62f276b..e9da812352b4 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -37,12 +37,32 @@ void dlm_callback_set_last_ptr(struct dlm_callback **from,
 	*from = to;
 }
 
-int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
-			     int status, uint32_t sbflags)
+static void dlm_callback_work(struct work_struct *work)
 {
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	struct dlm_callback *cb = container_of(work, struct dlm_callback, work);
+
+	if (cb->flags & DLM_CB_BAST) {
+		trace_dlm_bast(cb->ls_id, cb->lkb_id, cb->mode, cb->res_name,
+			       cb->res_length);
+		cb->bastfn(cb->astparam, cb->mode);
+	} else if (cb->flags & DLM_CB_CAST) {
+		trace_dlm_ast(cb->ls_id, cb->lkb_id, cb->sb_status,
+			      cb->sb_flags, cb->res_name, cb->res_length);
+		cb->lkb_lksb->sb_status = cb->sb_status;
+		cb->lkb_lksb->sb_flags = cb->sb_flags;
+		cb->astfn(cb->astparam);
+	}
+
+	kref_put(&cb->ref, dlm_release_callback);
+}
+
+int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
+			   int status, uint32_t sbflags,
+			   struct dlm_callback **cb)
+{
+	struct dlm_rsb *rsb = lkb->lkb_resource;
 	int rv = DLM_ENQUEUE_CALLBACK_SUCCESS;
-	struct dlm_callback *cb;
+	struct dlm_ls *ls = rsb->res_ls;
 	int copy_lvb = 0;
 	int prev_mode;
 
@@ -88,57 +108,46 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		}
 	}
 
-	cb = dlm_allocate_cb();
-	if (!cb) {
+	*cb = dlm_allocate_cb();
+	if (!*cb) {
 		rv = DLM_ENQUEUE_CALLBACK_FAILURE;
 		goto out;
 	}
 
-	cb->flags = flags;
-	cb->mode = mode;
-	cb->sb_status = status;
-	cb->sb_flags = (sbflags & 0x000000FF);
-	cb->copy_lvb = copy_lvb;
-	kref_init(&cb->ref);
-	if (!test_and_set_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags))
-		rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
+	/* for tracing */
+	(*cb)->lkb_id = lkb->lkb_id;
+	(*cb)->ls_id = ls->ls_global_id;
+	memcpy((*cb)->res_name, rsb->res_name, rsb->res_length);
+	(*cb)->res_length = rsb->res_length;
 
-	list_add_tail(&cb->list, &lkb->lkb_callbacks);
+	(*cb)->flags = flags;
+	(*cb)->mode = mode;
+	(*cb)->sb_status = status;
+	(*cb)->sb_flags = (sbflags & 0x000000FF);
+	(*cb)->copy_lvb = copy_lvb;
+	(*cb)->lkb_lksb = lkb->lkb_lksb;
+	kref_init(&(*cb)->ref);
 
 	if (flags & DLM_CB_BAST) {
 		lkb->lkb_last_bast_time = ktime_get();
-		lkb->lkb_last_bast_mode = cb->mode;
+		lkb->lkb_last_bast_mode = mode;
 	} else if (flags & DLM_CB_CAST) {
-		dlm_callback_set_last_ptr(&lkb->lkb_last_cast, cb);
+		dlm_callback_set_last_ptr(&lkb->lkb_last_cast, *cb);
 		lkb->lkb_last_cast_time = ktime_get();
 	}
 
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, cb);
+	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, *cb);
+	rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
 
- out:
+out:
 	return rv;
 }
 
-int dlm_dequeue_lkb_callback(struct dlm_lkb *lkb, struct dlm_callback **cb)
-{
-	/* oldest undelivered cb is callbacks first entry */
-	*cb = list_first_entry_or_null(&lkb->lkb_callbacks,
-				       struct dlm_callback, list);
-	if (!*cb)
-		return DLM_DEQUEUE_CALLBACK_EMPTY;
-
-	/* remove it from callbacks so shift others down */
-	list_del(&(*cb)->list);
-	if (list_empty(&lkb->lkb_callbacks))
-		return DLM_DEQUEUE_CALLBACK_LAST;
-
-	return DLM_DEQUEUE_CALLBACK_SUCCESS;
-}
-
 void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
-		uint32_t sbflags)
+		  uint32_t sbflags)
 {
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	struct dlm_callback *cb;
 	int rv;
 
 	if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags)) {
@@ -146,18 +155,20 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		return;
 	}
 
-	spin_lock(&lkb->lkb_cb_lock);
-	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
+	rv = dlm_queue_lkb_callback(lkb, flags, mode, status, sbflags,
+				    &cb);
 	switch (rv) {
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
-		kref_get(&lkb->lkb_ref);
+		cb->astfn = lkb->lkb_astfn;
+		cb->bastfn = lkb->lkb_bastfn;
+		cb->astparam = lkb->lkb_astparam;
+		INIT_WORK(&cb->work, dlm_callback_work);
 
 		spin_lock(&ls->ls_cb_lock);
-		if (test_bit(LSFL_CB_DELAY, &ls->ls_flags)) {
-			list_add(&lkb->lkb_cb_list, &ls->ls_cb_delay);
-		} else {
-			queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work);
-		}
+		if (test_bit(LSFL_CB_DELAY, &ls->ls_flags))
+			list_add(&cb->list, &ls->ls_cb_delay);
+		else
+			queue_work(ls->ls_callback_wq, &cb->work);
 		spin_unlock(&ls->ls_cb_lock);
 		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
@@ -168,67 +179,12 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	spin_unlock(&lkb->lkb_cb_lock);
-}
-
-void dlm_callback_work(struct work_struct *work)
-{
-	struct dlm_lkb *lkb = container_of(work, struct dlm_lkb, lkb_cb_work);
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	struct dlm_rsb *rsb = lkb->lkb_resource;
-	void (*castfn) (void *astparam);
-	void (*bastfn) (void *astparam, int mode);
-	struct dlm_callback *cb;
-	int rv;
-
-	spin_lock(&lkb->lkb_cb_lock);
-	rv = dlm_dequeue_lkb_callback(lkb, &cb);
-	if (WARN_ON_ONCE(rv == DLM_DEQUEUE_CALLBACK_EMPTY)) {
-		clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-		spin_unlock(&lkb->lkb_cb_lock);
-		goto out;
-	}
-	spin_unlock(&lkb->lkb_cb_lock);
-
-	for (;;) {
-		castfn = lkb->lkb_astfn;
-		bastfn = lkb->lkb_bastfn;
-
-		if (cb->flags & DLM_CB_BAST) {
-			trace_dlm_bast(ls->ls_global_id, lkb->lkb_id,
-				       cb->mode, rsb->res_name,
-				       rsb->res_length);
-			bastfn(lkb->lkb_astparam, cb->mode);
-		} else if (cb->flags & DLM_CB_CAST) {
-			lkb->lkb_lksb->sb_status = cb->sb_status;
-			lkb->lkb_lksb->sb_flags = cb->sb_flags;
-			trace_dlm_ast(ls->ls_global_id, lkb->lkb_id,
-				      cb->sb_flags, cb->sb_status,
-				      rsb->res_name, rsb->res_length);
-			castfn(lkb->lkb_astparam);
-		}
-
-		kref_put(&cb->ref, dlm_release_callback);
-
-		spin_lock(&lkb->lkb_cb_lock);
-		rv = dlm_dequeue_lkb_callback(lkb, &cb);
-		if (rv == DLM_DEQUEUE_CALLBACK_EMPTY) {
-			clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-			spin_unlock(&lkb->lkb_cb_lock);
-			break;
-		}
-		spin_unlock(&lkb->lkb_cb_lock);
-	}
-
-out:
-	/* undo kref_get from dlm_add_callback, may cause lkb to be freed */
-	dlm_put_lkb(lkb);
 }
 
 int dlm_callback_start(struct dlm_ls *ls)
 {
-	ls->ls_callback_wq = alloc_workqueue("dlm_callback",
-					     WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	ls->ls_callback_wq = alloc_ordered_workqueue("dlm_callback",
+						     WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!ls->ls_callback_wq) {
 		log_print("can't start dlm_callback workqueue");
 		return -ENOMEM;
@@ -257,7 +213,7 @@ void dlm_callback_suspend(struct dlm_ls *ls)
 
 void dlm_callback_resume(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_callback *cb, *safe;
 	int count = 0, sum = 0;
 	bool empty;
 
@@ -266,9 +222,9 @@ void dlm_callback_resume(struct dlm_ls *ls)
 
 more:
 	spin_lock(&ls->ls_cb_lock);
-	list_for_each_entry_safe(lkb, safe, &ls->ls_cb_delay, lkb_cb_list) {
-		list_del_init(&lkb->lkb_cb_list);
-		queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work);
+	list_for_each_entry_safe(cb, safe, &ls->ls_cb_delay, list) {
+		list_del(&cb->list);
+		queue_work(ls->ls_callback_wq, &cb->work);
 		count++;
 		if (count == MAX_CB_QUEUE)
 			break;
diff --git a/fs/dlm/ast.h b/fs/dlm/ast.h
index ce007892dc2d..9bd12409e1ee 100644
--- a/fs/dlm/ast.h
+++ b/fs/dlm/ast.h
@@ -14,19 +14,15 @@
 #define DLM_ENQUEUE_CALLBACK_NEED_SCHED	1
 #define DLM_ENQUEUE_CALLBACK_SUCCESS	0
 #define DLM_ENQUEUE_CALLBACK_FAILURE	-1
-int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
-			     int status, uint32_t sbflags);
-#define DLM_DEQUEUE_CALLBACK_EMPTY	2
-#define DLM_DEQUEUE_CALLBACK_LAST	1
-#define DLM_DEQUEUE_CALLBACK_SUCCESS	0
-int dlm_dequeue_lkb_callback(struct dlm_lkb *lkb, struct dlm_callback **cb);
+int dlm_queue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
+			   int status, uint32_t sbflags,
+			   struct dlm_callback **cb);
 void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
                 uint32_t sbflags);
 void dlm_callback_set_last_ptr(struct dlm_callback **from,
 			       struct dlm_callback *to);
 
 void dlm_release_callback(struct kref *ref);
-void dlm_callback_work(struct work_struct *work);
 int dlm_callback_start(struct dlm_ls *ls);
 void dlm_callback_stop(struct dlm_ls *ls);
 void dlm_callback_suspend(struct dlm_ls *ls);
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index a9137c90f348..cda1526fd15b 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -16,6 +16,7 @@
  * This is the main header file to be included in each DLM source file.
  */
 
+#include <uapi/linux/dlm_device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/types.h>
@@ -204,8 +205,7 @@ struct dlm_args {
 #define DLM_IFL_OVERLAP_CANCEL_BIT 20
 #define DLM_IFL_ENDOFLIFE_BIT	21
 #define DLM_IFL_DEADLOCK_CANCEL_BIT 24
-#define DLM_IFL_CB_PENDING_BIT	25
-#define __DLM_IFL_MAX_BIT	DLM_IFL_CB_PENDING_BIT
+#define __DLM_IFL_MAX_BIT	DLM_IFL_DEADLOCK_CANCEL_BIT
 
 /* lkb_dflags */
 
@@ -217,12 +217,45 @@ struct dlm_args {
 #define DLM_CB_CAST		0x00000001
 #define DLM_CB_BAST		0x00000002
 
+/* much of this is just saving user space pointers associated with the
+ * lock that we pass back to the user lib with an ast
+ */
+
+struct dlm_user_args {
+	struct dlm_user_proc	*proc; /* each process that opens the lockspace
+					* device has private data
+					* (dlm_user_proc) on the struct file,
+					* the process's locks point back to it
+					*/
+	struct dlm_lksb		lksb;
+	struct dlm_lksb __user	*user_lksb;
+	void __user		*castparam;
+	void __user		*castaddr;
+	void __user		*bastparam;
+	void __user		*bastaddr;
+	uint64_t		xid;
+};
+
 struct dlm_callback {
 	uint32_t		flags;		/* DLM_CBF_ */
 	int			sb_status;	/* copy to lksb status */
 	uint8_t			sb_flags;	/* copy to lksb flags */
 	int8_t			mode; /* rq mode of bast, gr mode of cast */
-	int			copy_lvb;
+	bool			copy_lvb;
+	struct dlm_lksb		*lkb_lksb;
+	unsigned char		lvbptr[DLM_USER_LVB_LEN];
+
+	union {
+		void			*astparam;	/* caller's ast arg */
+		struct dlm_user_args	ua;
+	};
+	struct work_struct	work;
+	void			(*bastfn)(void *astparam, int mode);
+	void			(*astfn)(void *astparam);
+	char			res_name[DLM_RESNAME_MAXLEN];
+	size_t			res_length;
+	uint32_t		ls_id;
+	uint32_t		lkb_id;
 
 	struct list_head	list;
 	struct kref		ref;
@@ -256,10 +289,6 @@ struct dlm_lkb {
 	struct list_head	lkb_ownqueue;	/* list of locks for a process */
 	ktime_t			lkb_timestamp;
 
-	spinlock_t		lkb_cb_lock;
-	struct work_struct	lkb_cb_work;
-	struct list_head	lkb_cb_list; /* for ls_cb_delay or proc->asts */
-	struct list_head	lkb_callbacks;
 	struct dlm_callback	*lkb_last_cast;
 	struct dlm_callback	*lkb_last_cb;
 	int			lkb_last_bast_mode;
@@ -688,23 +717,6 @@ struct dlm_ls {
 #define LSFL_CB_DELAY		9
 #define LSFL_NODIR		10
 
-/* much of this is just saving user space pointers associated with the
-   lock that we pass back to the user lib with an ast */
-
-struct dlm_user_args {
-	struct dlm_user_proc	*proc; /* each process that opens the lockspace
-					  device has private data
-					  (dlm_user_proc) on the struct file,
-					  the process's locks point back to it*/
-	struct dlm_lksb		lksb;
-	struct dlm_lksb __user	*user_lksb;
-	void __user		*castparam;
-	void __user		*castaddr;
-	void __user		*bastparam;
-	void __user		*bastaddr;
-	uint64_t		xid;
-};
-
 #define DLM_PROC_FLAGS_CLOSING 1
 #define DLM_PROC_FLAGS_COMPAT  2
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index a39c2c49bff8..1c0d01dc7eca 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1203,10 +1203,6 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	kref_init(&lkb->lkb_ref);
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
-	INIT_LIST_HEAD(&lkb->lkb_cb_list);
-	INIT_LIST_HEAD(&lkb->lkb_callbacks);
-	spin_lock_init(&lkb->lkb_cb_lock);
-	INIT_WORK(&lkb->lkb_cb_work, dlm_callback_work);
 
 	idr_preload(GFP_NOFS);
 	spin_lock(&ls->ls_lkbidr_spin);
@@ -6003,6 +5999,7 @@ static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
 
 void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
+	struct dlm_callback *cb, *cb_safe;
 	struct dlm_lkb *lkb, *safe;
 
 	dlm_lock_recovery(ls);
@@ -6032,10 +6029,9 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 		dlm_put_lkb(lkb);
 	}
 
-	list_for_each_entry_safe(lkb, safe, &proc->asts, lkb_cb_list) {
-		dlm_purge_lkb_callbacks(lkb);
-		list_del_init(&lkb->lkb_cb_list);
-		dlm_put_lkb(lkb);
+	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
+		list_del(&cb->list);
+		kref_put(&cb->ref, dlm_release_callback);
 	}
 
 	spin_unlock(&ls->ls_clear_proc_locks);
@@ -6044,6 +6040,7 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 
 static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
+	struct dlm_callback *cb, *cb_safe;
 	struct dlm_lkb *lkb, *safe;
 
 	while (1) {
@@ -6073,10 +6070,9 @@ static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 	spin_unlock(&proc->locks_spin);
 
 	spin_lock(&proc->asts_spin);
-	list_for_each_entry_safe(lkb, safe, &proc->asts, lkb_cb_list) {
-		dlm_purge_lkb_callbacks(lkb);
-		list_del_init(&lkb->lkb_cb_list);
-		dlm_put_lkb(lkb);
+	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
+		list_del(&cb->list);
+		kref_put(&cb->ref, dlm_release_callback);
 	}
 	spin_unlock(&proc->asts_spin);
 }
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index fa99b6074e5c..334a6d64d413 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -21,6 +21,7 @@
 #include "dlm_internal.h"
 #include "lockspace.h"
 #include "lock.h"
+#include "lvb_table.h"
 #include "user.h"
 #include "ast.h"
 #include "config.h"
@@ -144,24 +145,6 @@ static void compat_output(struct dlm_lock_result *res,
 }
 #endif
 
-/* should held proc->asts_spin lock */
-void dlm_purge_lkb_callbacks(struct dlm_lkb *lkb)
-{
-	struct dlm_callback *cb, *safe;
-
-	list_for_each_entry_safe(cb, safe, &lkb->lkb_callbacks, list) {
-		list_del(&cb->list);
-		kref_put(&cb->ref, dlm_release_callback);
-	}
-
-	clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-
-	/* invalidate */
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cast, NULL);
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, NULL);
-	lkb->lkb_last_bast_mode = -1;
-}
-
 /* Figure out if this lock is at the end of its life and no longer
    available for the application to use.  The lkb still exists until
    the final ast is read.  A lock becomes EOL in three situations:
@@ -198,6 +181,7 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	struct dlm_ls *ls;
 	struct dlm_user_args *ua;
 	struct dlm_user_proc *proc;
+	struct dlm_callback *cb;
 	int rv;
 
 	if (test_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags) ||
@@ -229,11 +213,18 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 
 	spin_lock(&proc->asts_spin);
 
-	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
+	rv = dlm_queue_lkb_callback(lkb, flags, mode, status, sbflags, &cb);
 	switch (rv) {
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
-		kref_get(&lkb->lkb_ref);
-		list_add_tail(&lkb->lkb_cb_list, &proc->asts);
+		cb->ua = *ua;
+		cb->lkb_lksb = &cb->ua.lksb;
+		if (cb->copy_lvb) {
+			memcpy(cb->lvbptr, ua->lksb.sb_lvbptr,
+			       DLM_USER_LVB_LEN);
+			cb->lkb_lksb->sb_lvbptr = cb->lvbptr;
+		}
+
+		list_add_tail(&cb->list, &proc->asts);
 		wake_up_interruptible(&proc->wait);
 		break;
 	case DLM_ENQUEUE_CALLBACK_SUCCESS:
@@ -801,10 +792,8 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 			   loff_t *ppos)
 {
 	struct dlm_user_proc *proc = file->private_data;
-	struct dlm_lkb *lkb;
 	DECLARE_WAITQUEUE(wait, current);
 	struct dlm_callback *cb;
-	struct dlm_rsb *rsb;
 	int rv, ret;
 
 	if (count == sizeof(struct dlm_device_version)) {
@@ -824,8 +813,6 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 #endif
 		return -EINVAL;
 
- try_another:
-
 	/* do we really need this? can a read happen after a close? */
 	if (test_bit(DLM_PROC_FLAGS_CLOSING, &proc->flags))
 		return -EINVAL;
@@ -860,55 +847,24 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	   without removing lkb_cb_list; so empty lkb_cb_list is always
 	   consistent with empty lkb_callbacks */
 
-	lkb = list_first_entry(&proc->asts, struct dlm_lkb, lkb_cb_list);
-
-	rv = dlm_dequeue_lkb_callback(lkb, &cb);
-	switch (rv) {
-	case DLM_DEQUEUE_CALLBACK_EMPTY:
-		/* this shouldn't happen; lkb should have been removed from
-		 * list when last item was dequeued
-		 */
-		log_print("dlm_rem_lkb_callback empty %x", lkb->lkb_id);
-		list_del_init(&lkb->lkb_cb_list);
-		spin_unlock(&proc->asts_spin);
-		/* removes ref for proc->asts, may cause lkb to be freed */
-		dlm_put_lkb(lkb);
-		WARN_ON_ONCE(1);
-		goto try_another;
-	case DLM_DEQUEUE_CALLBACK_LAST:
-		list_del_init(&lkb->lkb_cb_list);
-		clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-		break;
-	case DLM_DEQUEUE_CALLBACK_SUCCESS:
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	cb = list_first_entry(&proc->asts, struct dlm_callback, list);
+	list_del(&cb->list);
 	spin_unlock(&proc->asts_spin);
 
-	rsb = lkb->lkb_resource;
 	if (cb->flags & DLM_CB_BAST) {
-		trace_dlm_bast(rsb->res_ls->ls_global_id, lkb->lkb_id,
-			       cb->mode, rsb->res_name, rsb->res_length);
+		trace_dlm_bast(cb->ls_id, cb->lkb_id, cb->mode, cb->res_name,
+			       cb->res_length);
 	} else if (cb->flags & DLM_CB_CAST) {
-		lkb->lkb_lksb->sb_status = cb->sb_status;
-		lkb->lkb_lksb->sb_flags = cb->sb_flags;
-		trace_dlm_ast(rsb->res_ls->ls_global_id, lkb->lkb_id,
-			      cb->sb_flags, cb->sb_status, rsb->res_name,
-			      rsb->res_length);
+		cb->lkb_lksb->sb_status = cb->sb_status;
+		cb->lkb_lksb->sb_flags = cb->sb_flags;
+		trace_dlm_ast(cb->ls_id, cb->lkb_id, cb->sb_status,
+			      cb->sb_flags, cb->res_name, cb->res_length);
 	}
 
-	ret = copy_result_to_user(lkb->lkb_ua,
+	ret = copy_result_to_user(&cb->ua,
 				  test_bit(DLM_PROC_FLAGS_COMPAT, &proc->flags),
 				  cb->flags, cb->mode, cb->copy_lvb, buf, count);
-
 	kref_put(&cb->ref, dlm_release_callback);
-
-	/* removes ref for proc->asts, may cause lkb to be freed */
-	if (rv == DLM_DEQUEUE_CALLBACK_LAST)
-		dlm_put_lkb(lkb);
-
 	return ret;
 }
 
-- 
2.43.0

