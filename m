Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C8257459
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182279; cv=none; b=g0CKQl+IiZLeqgk95FhykICrbgRTbtTKlBzqVavaHkt210Zz6SFtvzFgTQ1z4dvK0u3RRBYz+bNl4bPyFNotFw5v6iB37Pna9kCLNNe6SL+Gkws6Txsliqqu5L8dIcv8jYfF/SXNARHiO8ghAKDobJ1zaBFOFqUd0HtvmzAT/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182279; c=relaxed/simple;
	bh=7pIeIxE3ygLIZHfflYqUypOEYTJy8PMjMYBDhdL038I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lGZ5mwxDakDP3RPlhBVEsU3N4H3lvOpvixJ82RApqgpBH9ARjTqC69FhHc4mCY/W+9zF76PW84K09CJ2ykBtgLLCBNVCa8jRxE5tM0fwf3rn4Sd/O+M+175R0ZHfMyq6rn3EYwwZrbG8hV2hYgI/LVqEE0AjuXvnvuOg5pUuLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKNTknYQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKNTknYQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtCFLfGT+nEmSDgH73DPrgNYfvVLcD5T2Z+sbaOiJlU=;
	b=TKNTknYQDScDSm1kDEMpveUMhQrWkv0V5tALE9zeI5qyQ9IccfJ4wsvGzfuVrlxtWnKlZs
	zHYcM9Wk8FNXvKX19Zb8hVDd0MCEPk73gmktuIO6g5l66SasrJjnX+KEi1PtpvJrBrutc/
	w2/o7TujGrVQ+JPSbZGFnlKGUfc+F6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-dcikQxJ4MGmGWt21FhQnjg-1; Fri,
 23 Jan 2026 10:31:14 -0500
X-MC-Unique: dcikQxJ4MGmGWt21FhQnjg-1
X-Mimecast-MFC-AGG-ID: dcikQxJ4MGmGWt21FhQnjg_1769182273
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A30021955DA7
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:13 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADEEA30002D1;
	Fri, 23 Jan 2026 15:31:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/13] gfs2: Do not cancel internal demote requests
Date: Fri, 23 Jan 2026 16:30:54 +0100
Message-ID: <20260123153105.797382-5-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9KRnD-PacT3EBqN1gIQtNw-MUQ-iMOFRrpxK1FOHFoE_1769182273
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Trying to change the state of a glock may result in a "conversion
deadlock" error, indicating that the requested state transition would
cause a deadlock.  In this case, we unlock and retry the state change.
It makes no sense to try canceling those unlock requests, but the
current code is not aware of that.

In addition, if a locking request is canceled shortly after it is made,
the cancelation request can currently overtake the locking request.
This may result in deadlocks.

Fix both of these bugs by repurposing the GLF_PENDING_REPLY flag into a
GLF_MAY_CANCEL flag which is set only when the current locking request
can be canceled.  When trying to cancel a locking request in
gfs2_glock_dq(), wait for this flag to be set.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 46 +++++++++++++++++++++++++++++++-------------
 fs/gfs2/incore.h     |  2 +-
 fs/gfs2/trace_gfs2.h |  2 +-
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 776179933315..7c3d488327ee 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -60,7 +60,8 @@ struct gfs2_glock_iter {
 
 typedef void (*glock_examiner) (struct gfs2_glock * gl);
 
-static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int target);
+static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh,
+		     unsigned int target, bool may_cancel);
 static void request_demote(struct gfs2_glock *gl, unsigned int state,
 			   unsigned long delay, bool remote);
 
@@ -600,12 +601,14 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 		switch(gl->gl_state) {
 		/* Unlocked due to conversion deadlock, try again */
 		case LM_ST_UNLOCKED:
-			do_xmote(gl, gh, gl->gl_target);
+			do_xmote(gl, gh, gl->gl_target,
+				 !test_bit(GLF_DEMOTE_IN_PROGRESS,
+					   &gl->gl_flags));
 			break;
 		/* Conversion fails, unlock and try again */
 		case LM_ST_SHARED:
 		case LM_ST_DEFERRED:
-			do_xmote(gl, gh, LM_ST_UNLOCKED);
+			do_xmote(gl, gh, LM_ST_UNLOCKED, false);
 			break;
 		default: /* Everything else */
 			fs_err(gl->gl_name.ln_sbd,
@@ -638,7 +641,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	}
 out:
 	if (!test_bit(GLF_CANCELING, &gl->gl_flags))
-		clear_bit(GLF_LOCK, &gl->gl_flags);
+		clear_and_wake_up_bit(GLF_LOCK, &gl->gl_flags);
 }
 
 /**
@@ -646,11 +649,12 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
  * @gl: The lock state
  * @gh: The holder (only for promotes)
  * @target: The target lock state
+ * @may_cancel: Operation may be canceled
  *
  */
 
 static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh,
-					 unsigned int target)
+		     unsigned int target, bool may_cancel)
 __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
@@ -703,17 +707,20 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (ls->ls_ops->lm_lock) {
-		set_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 		spin_unlock(&gl->gl_lockref.lock);
 		ret = ls->ls_ops->lm_lock(gl, target, gh ? gh->gh_flags : 0);
 		spin_lock(&gl->gl_lockref.lock);
 
 		if (!ret) {
+			if (may_cancel) {
+				set_bit(GLF_MAY_CANCEL, &gl->gl_flags);
+				smp_mb__after_atomic();
+				wake_up_bit(&gl->gl_flags, GLF_LOCK);
+			}
 			/* The operation will be completed asynchronously. */
 			gl->gl_lockref.count++;
 			return;
 		}
-		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 
 		if (ret == -ENODEV) {
 			/*
@@ -774,7 +781,7 @@ __acquires(&gl->gl_lockref.lock)
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
 		set_bit(GLF_LOCK, &gl->gl_flags);
-		do_xmote(gl, NULL, gl->gl_target);
+		do_xmote(gl, NULL, gl->gl_target, false);
 		return;
 	}
 
@@ -791,7 +798,7 @@ __acquires(&gl->gl_lockref.lock)
 	if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
 		do_error(gl, 0); /* Fail queued try locks */
 	set_bit(GLF_LOCK, &gl->gl_flags);
-	do_xmote(gl, gh, gl->gl_target);
+	do_xmote(gl, gh, gl->gl_target, true);
 	return;
 
 out_sched:
@@ -1588,6 +1595,7 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
 
+again:
 	spin_lock(&gl->gl_lockref.lock);
 	if (!gfs2_holder_queued(gh)) {
 		/*
@@ -1602,13 +1610,25 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 	    test_bit(GLF_LOCK, &gl->gl_flags) &&
 	    !test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags) &&
 	    !test_bit(GLF_CANCELING, &gl->gl_flags)) {
+		if (!test_bit(GLF_MAY_CANCEL, &gl->gl_flags)) {
+			struct wait_queue_head *wq;
+			DEFINE_WAIT(wait);
+
+			wq = bit_waitqueue(&gl->gl_flags, GLF_LOCK);
+			prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+			spin_unlock(&gl->gl_lockref.lock);
+			schedule();
+			finish_wait(wq, &wait);
+			goto again;
+		}
+
 		set_bit(GLF_CANCELING, &gl->gl_flags);
 		spin_unlock(&gl->gl_lockref.lock);
 		gl->gl_name.ln_sbd->sd_lockstruct.ls_ops->lm_cancel(gl);
 		wait_on_bit(&gh->gh_iflags, HIF_WAIT, TASK_UNINTERRUPTIBLE);
 		spin_lock(&gl->gl_lockref.lock);
 		clear_bit(GLF_CANCELING, &gl->gl_flags);
-		clear_bit(GLF_LOCK, &gl->gl_flags);
+		clear_and_wake_up_bit(GLF_LOCK, &gl->gl_flags);
 		if (!gfs2_holder_queued(gh))
 			goto out;
 	}
@@ -1838,7 +1858,7 @@ void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
 
 	spin_lock(&gl->gl_lockref.lock);
-	clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
+	clear_bit(GLF_MAY_CANCEL, &gl->gl_flags);
 	gl->gl_reply = ret;
 
 	if (unlikely(test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))) {
@@ -2245,8 +2265,8 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'y';
 	if (test_bit(GLF_LFLUSH, gflags))
 		*p++ = 'f';
-	if (test_bit(GLF_PENDING_REPLY, gflags))
-		*p++ = 'R';
+	if (test_bit(GLF_MAY_CANCEL, gflags))
+		*p++ = 'c';
 	if (test_bit(GLF_HAVE_REPLY, gflags))
 		*p++ = 'r';
 	if (test_bit(GLF_INITIAL, gflags))
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index d05d8fe4e456..f7909607936a 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -326,7 +326,7 @@ enum {
 	GLF_BLOCKING			= 15,
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
 	GLF_VERIFY_DELETE		= 18, /* iopen glocks only */
-	GLF_PENDING_REPLY		= 19,
+	GLF_MAY_CANCEL			= 19,
 	GLF_DEFER_DELETE		= 20, /* iopen glocks only */
 	GLF_CANCELING			= 21,
 };
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index fcfbf68ec725..a308228d5c2d 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -52,7 +52,7 @@
 	{(1UL << GLF_DEMOTE_IN_PROGRESS),	"p" },		\
 	{(1UL << GLF_DIRTY),			"y" },		\
 	{(1UL << GLF_LFLUSH),			"f" },		\
-	{(1UL << GLF_PENDING_REPLY),		"R" },		\
+	{(1UL << GLF_MAY_CANCEL),		"c" },		\
 	{(1UL << GLF_HAVE_REPLY),		"r" },		\
 	{(1UL << GLF_INITIAL),			"a" },		\
 	{(1UL << GLF_HAVE_FROZEN_REPLY),	"F" },		\
-- 
2.52.0

