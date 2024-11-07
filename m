Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B84322E
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012396; cv=none; b=Z/hGvKWNvcjx6/faPMfZbvA4F3UI1X+6RdB7WTAsxY7GW7Xh0MFqfEanitoTPppk2pzwpGibGnre5ScSC1FW/pZHVFfD04miZhwK8cpU4/sl1UkDA0DGbruDpSdkISnBi1yKmRxo0Q9t7xsnPK9WWAGIRIfWmCuk9uGAj1K9lTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012396; c=relaxed/simple;
	bh=R+nlzACWdZpf8FTFSBFz7hG16F3RDf09XONmAcHh+kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7MnxaycUHAClWz8ZyRRjfuYwkzTp1IhuRRAUN5tAMe93j3SBzP3M0DqBr+9i1Z/Ls+aHlMM6UR7iwXLe8aNn6P5251m9NURGuyFAj5rcPfcrUS6dEcwRGbpaH6PPFW4AWJWxD7j3D3jluUKLp+LmWWS/4SOh1Krw8zzeAKAJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpMZMnR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpMZMnR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgsiCXo0EXLm1GUcn13v0DviYjhwpfzrm3mpl7oQIrA=;
	b=CpMZMnR0NLZSgxT+0r+Pb6Ay2N01nkXdfEBRixtzdMjYW7uIo5fp4qDhMQ8/CWPtR3zu0f
	oXFeyDL8G2SdGcOVErslYex6xiOLkcTykipTi2GkmJYAwxqbiBgpQFaPG8yTB+GOLR6uS0
	dw4WJ08c55QoRA2WH5TNOPmkQYwMVA4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-aXHx3tW0OqujyUKLDE5oNA-1; Thu,
 07 Nov 2024 15:46:29 -0500
X-MC-Unique: aXHx3tW0OqujyUKLDE5oNA-1
X-Mimecast-MFC-AGG-ID: aXHx3tW0OqujyUKLDE5oNA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 205D219560B4
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:29 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8146B300019F;
	Thu,  7 Nov 2024 20:46:28 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 09/11] dlm: introduce new lkb refcount model
Date: Thu,  7 Nov 2024 15:46:15 -0500
Message-ID: <20241107204617.147842-10-aahringo@redhat.com>
In-Reply-To: <20241107204617.147842-1-aahringo@redhat.com>
References: <20241107204617.147842-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M_cxY_LocXl79fLbJTGC2PCOv74MzkgeYJvBSWu26eg_1731012389
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The current lkb refcount requires to evaluate return values from
functions e.g. _request_lock(). We do that sometimes and we don't do
that sometimes. If we don't do that the lkb referencing to a lock
resource need to associated with a remote lock master. If this is the
case or not requires a lot of thinking as recovery can also change
states.

The new lkb refcount model drops all the necessarily evaluation of the
return value as it introduce a lkb request state model. A lkb has a
specific lifetime that is tight to an ast callback, depending on the lkb
request state and the ast return value it signals when an lkb lifetime
ends or not.

This new model is more robust to being broken as we would notice more a
missing ast callback than a missing return value check of e.g.
_request_lock(). Additional we can check for invalid lkb request states
over the lifetime or invalid ast result codes depending on this state.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  13 ++++
 fs/dlm/lock.c         | 146 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 132 insertions(+), 27 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index d534a4bc162b..cd07077550c5 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -250,6 +250,17 @@ struct dlm_callback {
 	struct list_head	list;
 };
 
+/* This enum values represents the LKB lifetime states.
+ * A lkb can be over the time in an initial request state,
+ * then only conversions as requests are allowed until the
+ * lifetime ends by calling unlock.
+ */
+enum dlm_lkb_rq_state {
+	DLM_LKB_RQ_STATE_REQUEST,
+	DLM_LKB_RQ_STATE_CONVERT,
+	DLM_LKB_RQ_STATE_UNLOCK,
+};
+
 struct dlm_lkb {
 	struct dlm_rsb		*lkb_resource;	/* the rsb */
 	struct kref		lkb_ref;
@@ -263,6 +274,8 @@ struct dlm_lkb {
 	unsigned long		lkb_iflags;	/* internal flags */
 	uint32_t		lkb_lvbseq;	/* lvb sequence number */
 
+	enum dlm_lkb_rq_state	lkb_rq_state;
+
 	int8_t			lkb_status;     /* granted, waiting, convert */
 	int8_t			lkb_rqmode;	/* requested lock mode */
 	int8_t			lkb_grmode;	/* granted lock mode */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 9d2d3567bf9d..1de8598d7451 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -287,17 +287,99 @@ static inline int is_overlap(struct dlm_lkb *lkb)
 	       test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
 }
 
-static void queue_cast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static void dlm_lkb_queue_cb_may_put(struct dlm_lkb *lkb, int status)
 {
-	if (is_master_copy(lkb))
-		return;
+	switch (status) {
+	case 0:
+		switch (lkb->lkb_rq_state) {
+		case DLM_LKB_RQ_STATE_REQUEST:
+			lkb->lkb_rq_state = DLM_LKB_RQ_STATE_CONVERT;
+			break;
+		case DLM_LKB_RQ_STATE_CONVERT:
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
 
-	DLM_ASSERT(lkb->lkb_lksb, dlm_print_lkb(lkb););
+		break;
+	case -DLM_ECANCEL:
+		switch (lkb->lkb_rq_state) {
+		case DLM_LKB_RQ_STATE_REQUEST:
+			/* cancel on a request will end the lkb lifetime
+			 * as it is the initial lock request.
+			 */
+			dlm_put_lkb(lkb);
+			break;
+		case DLM_LKB_RQ_STATE_CONVERT:
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+
+		break;
+	case -EAGAIN:
+		switch (lkb->lkb_rq_state) {
+		case DLM_LKB_RQ_STATE_REQUEST:
+			/* -EAGAIN ends the lkb lifetime as the initial lock
+			 * request failed.
+			 */
+			dlm_put_lkb(lkb);
+			break;
+		case DLM_LKB_RQ_STATE_CONVERT:
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+
+		break;
+	case -EDEADLK:
+		switch (lkb->lkb_rq_state) {
+		case DLM_LKB_RQ_STATE_CONVERT:
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+
+		break;
+	case -DLM_EUNLOCK:
+		switch (lkb->lkb_rq_state) {
+		case DLM_LKB_RQ_STATE_REQUEST:
+			fallthrough;
+		case DLM_LKB_RQ_STATE_CONVERT:
+			lkb->lkb_rq_state = DLM_LKB_RQ_STATE_UNLOCK;
+			break;
+		default:
+			WARN_ON(1);
+			break;
+		}
+
+		/* for any case an unlock ends the lifetime of a lkb */
+		dlm_put_lkb(lkb);
+		break;
+	default:
+		/* something we should check */
+		WARN_ON(1);
+		break;
+	}
+}
 
+static void queue_cast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+{
 	if (rv == -DLM_ECANCEL &&
 	    test_and_clear_bit(DLM_IFL_DEADLOCK_CANCEL_BIT, &lkb->lkb_iflags))
 		rv = -EDEADLK;
 
+	dlm_lkb_queue_cb_may_put(lkb, rv);
+
+	if (is_master_copy(lkb))
+		return;
+
+	DLM_ASSERT(lkb->lkb_lksb, dlm_print_lkb(lkb););
+
 	dlm_add_cb(lkb, DLM_CB_CAST, lkb->lkb_grmode, rv, dlm_sbflags_val(lkb));
 }
 
@@ -1495,6 +1577,8 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	if (!lkb)
 		return -ENOMEM;
 
+	/* every lkb starts with a request as init request state */
+	lkb->lkb_rq_state = DLM_LKB_RQ_STATE_REQUEST;
 	lkb->lkb_last_bast_cb_mode = DLM_LOCK_IV;
 	lkb->lkb_last_cast_cb_mode = DLM_LOCK_IV;
 	lkb->lkb_last_cb_mode = DLM_LOCK_IV;
@@ -1982,9 +2066,6 @@ static void _remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	del_lkb(r, lkb);
 	lkb->lkb_grmode = DLM_LOCK_IV;
-	/* this unhold undoes the original ref from create_lkb()
-	   so this leads to the lkb being freed */
-	unhold_lkb(lkb);
 }
 
 static void remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
@@ -2018,9 +2099,6 @@ static int revert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	case DLM_LKSTS_WAITING:
 		del_lkb(r, lkb);
 		lkb->lkb_grmode = DLM_LOCK_IV;
-		/* this unhold undoes the original ref from create_lkb()
-		   so this leads to the lkb being freed */
-		unhold_lkb(lkb);
 		rv = -1;
 		break;
 	default:
@@ -2070,6 +2148,7 @@ static void grant_lock_pending(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	grant_lock(r, lkb);
 	if (is_master_copy(lkb))
 		send_grant(r, lkb);
+
 	queue_cast(r, lkb, 0);
 }
 
@@ -2888,7 +2967,6 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 			queue_cast(lkb->lkb_resource, lkb,
 				   args->flags & DLM_LKF_CANCEL ?
 				   -DLM_ECANCEL : -DLM_EUNLOCK);
-			unhold_lkb(lkb); /* undoes create_lkb() */
 			/* for lkb_rsb_lookup */
 			dlm_put_lkb(lkb);
 		}
@@ -3194,6 +3272,8 @@ static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	int error = 0;
 
+	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
+
 	if (is_remote(r)) {
 		/* receive_convert() calls do_convert() on remote node */
 		send_convert(r, lkb);
@@ -3213,6 +3293,9 @@ static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	int error = 0;
 
+	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_REQUEST &&
+		lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
+
 	if (is_remote(r)) {
 		/* receive_unlock() calls do_unlock() on remote node */
 		send_unlock(r, lkb);
@@ -3232,6 +3315,9 @@ static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	int error = 0;
 
+	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_REQUEST &&
+		lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
+
 	if (is_remote(r)) {
 		/* receive_cancel() calls do_cancel() on remote node */
 		send_cancel(r, lkb);
@@ -3265,6 +3351,13 @@ static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	if (error)
 		return error;
 
+	/* this reference is for the lkb lifetime that can
+	 * end on a ast callback, see dlm_lkb_queue_cb_may_put().
+	 *
+	 * at this point the request must return an ast callback.
+	 */
+	hold_lkb(lkb);
+
 	lock_rsb(r);
 
 	attach_lkb(r, lkb);
@@ -3394,8 +3487,7 @@ int dlm_lock(dlm_lockspace_t *lockspace,
  out_put:
 	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, true);
 
-	if (convert || error)
-		__put_lkb(ls, lkb);
+	__put_lkb(ls, lkb);
 	if (error == -EAGAIN || error == -EDEADLK)
 		error = 0;
  out:
@@ -3968,13 +4060,15 @@ static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
 	send_request_reply(r, lkb, error);
 	do_request_effects(r, lkb, error);
 
+	/* no dlm_put_lkb() because the lkb is created and the request
+	 * is sent out. The answer cannot be handled yet because we
+	 * still hold the rsb lock. The initial refcount of 1 from
+	 * create_lkb() is the lkb lifetime refcount.
+	 */
+
 	unlock_rsb(r);
 	put_rsb(r);
 
-	if (error == -EINPROGRESS)
-		error = 0;
-	if (error)
-		dlm_put_lkb(lkb);
 	return 0;
 
  fail:
@@ -4363,7 +4457,6 @@ static int receive_request_reply(struct dlm_ls *ls,
 		/* request would block (be queued) on remote master */
 		queue_cast(r, lkb, -EAGAIN);
 		confirm_master(r, -EAGAIN);
-		unhold_lkb(lkb); /* undoes create_lkb() */
 		break;
 
 	case -EINPROGRESS:
@@ -4402,7 +4495,6 @@ static int receive_request_reply(struct dlm_ls *ls,
 			/* we'll ignore error in cancel/unlock reply */
 			queue_cast_overlap(r, lkb);
 			confirm_master(r, result);
-			unhold_lkb(lkb); /* undoes create_lkb() */
 		} else {
 			_request_lock(r, lkb);
 
@@ -4688,7 +4780,6 @@ static void receive_lookup_reply(struct dlm_ls *ls,
 		log_debug(ls, "receive_lookup_reply %x unlock %x",
 			  lkb->lkb_id, dlm_iflags_val(lkb));
 		queue_cast_overlap(r, lkb);
-		unhold_lkb(lkb); /* undoes create_lkb() */
 		goto out_list;
 	}
 
@@ -5215,6 +5306,7 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 
 		/* Forcibly remove from waiters list */
 		spin_lock_bh(&ls->ls_waiters_lock);
+		/* above unhold_lkb() contains waiters list ref */
 		list_del_init(&lkb->lkb_wait_reply);
 		spin_unlock_bh(&ls->ls_waiters_lock);
 
@@ -5231,7 +5323,6 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 			case DLM_MSG_REQUEST:
 				queue_cast(r, lkb, ou ? -DLM_EUNLOCK :
 							-DLM_ECANCEL);
-				unhold_lkb(lkb); /* undoes create_lkb() */
 				break;
 			case DLM_MSG_CONVERT:
 				if (oc) {
@@ -5268,6 +5359,7 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		}
 		unlock_rsb(r);
 		put_rsb(r);
+		/* for find_resend_waiter() */
 		dlm_put_lkb(lkb);
 	}
 
@@ -5686,7 +5778,6 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
 {
 	struct dlm_lkb *lkb;
 	struct dlm_args args;
-	bool do_put = true;
 	int error;
 
 	dlm_lock_recovery(ls);
@@ -5740,11 +5831,9 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
 	hold_lkb(lkb);
 	list_add_tail(&lkb->lkb_ownqueue, &ua->proc->locks);
 	spin_unlock_bh(&ua->proc->locks_spin);
-	do_put = false;
  out_put:
 	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, false);
-	if (do_put)
-		__put_lkb(ls, lkb);
+	__put_lkb(ls, lkb);
  out:
 	dlm_unlock_recovery(ls);
 	return error;
@@ -6062,8 +6151,11 @@ static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 }
 
 /* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
+ * (which does lock_rsb) due to deadlock with receiving a message that does
+ * lock_rsb followed by dlm_user_add_cb()
+ *
+ * caller needs to call dlm_put_lkb() when lkb returns
+ */
 
 static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
 				     struct dlm_user_proc *proc)
-- 
2.43.0

