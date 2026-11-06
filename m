Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997646;
	b=iFEfgAOiz8ygHCqebxkoYwTAVxfkbiwQfqVuEbI3myXazRaWW6NpayNkjkCA4q7mbWhd
	 frHcD+mynuXGxc0Ss5bgCsTLDvBsvMJAhbG8JfV4pittFGHRN8Yxi1aIaT8oroUhGYrdy
	 Fo7poUmo+G2/NeZk7z6q5SkYyL7aWkGimwpf05/CCPMOSuhMdHZHgV/PfUTQx3oVx5HVo
	 UuVZFxP21a1YniKtYJI/NwKj2lXq9HDGQ74KdQJznSiLKA/UIP9esv9rErSVXblfsD7Yh
	 hAxrdg3IKvA3gyEvSwuJlgWpRs2DKsozv7B0tBEWe5vzkedO0HjDeut6IMwnqhl7i1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997646;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=VJLzlQpaxF8WMhiE1FgESMKoXSjnqvxy3fQSpbNjZNo=;
	b=lA+SU0Ky0g1hrakGQD622eJeJBquwrheVu6udBVgoavUDQmrfiaoOen8U935X5QA4Qa9
	 JKDZfxpHjHh5EUN1emcHWNtBQQEws/CCA258K6wJQOewAoaVgUV2yjH2TCryBWd79R4Yr
	 XTxRn95eMDUKI8ywzQHWAFzBz4k4VvXVtQsiChnHzaZ8O0g3x2I+w6+ndDW7Ws9ATQnKf
	 e72h3+PH4Ms5s7uOEyyLUISPWkKUMu6jYU1GDxzetnFrvKuzCo/vn5nz+XJScrQDiDc5Z
	 UuZ1EefLXgej/pmy8HaJGGIX62zWXKKKntIgE+pinhZiFS412MUzBTmbB/7Np7soqxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hySDOKZr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9976606A329
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9976606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hySDOKZr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793997644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJLzlQpaxF8WMhiE1FgESMKoXSjnqvxy3fQSpbNjZNo=;
	b=hySDOKZrzD0YuSLt+KvAR0OyULGTOP11UiaogY9oDgYUjfo47tO+axtNBX6MMF/+hLiaG2
	TmSjz9CH1qqgPof5QzC9VyRToTEDrQfQniQSuGyVc1KTucXCKJ5UQOfGf3+YpaqG2Mrkoc
	fK2wyFvmXfLk0zGIH9PPA4CBLVt71Xw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-hquDNSA7NpCWKE_HDUcBkQ-1; Fri,
 06 Nov 2026 15:40:41 -0500
X-MC-Unique: hquDNSA7NpCWKE_HDUcBkQ-1
X-Mimecast-MFC-AGG-ID: hquDNSA7NpCWKE_HDUcBkQ_1793997640
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D29A1801332
	for <gfs2@lists.linux.dev>; Fri,  6 Nov 2026 20:40:40 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9DFC1956044;
	Fri,  6 Nov 2026 20:40:39 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.4-rc1 2/4] dlm: don't publish a lkb in ls_lkbxa before it has an rsb
Date: Fri,  6 Nov 2026 15:40:33 -0500
Message-ID: <20261106204035.3794411-3-aahringo@redhat.com>
In-Reply-To: <20261106204035.3794411-1-aahringo@redhat.com>
References: <20261106204035.3794411-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -m17tAB9SYcaiF2ABMrEvb_CjlSdQuCF0b5cyKfsO8Y_1793997640
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Yogesh Gaur <yogeshgaur.83@gmail.com>

_create_lkb() puts a new lkb into ls_lkbxa straight away, which is also
what assigns its lkb_id, but the lkb only gets an rsb later, when
request_lock(), receive_request(), dlm_recover_master_copy() or
dlm_debug_add_lkb() call attach_lkb(). In between, find_lkb() hands the
lkb out with lkb_resource still NULL, and its callers go straight for
the rsb:

	r = lkb->lkb_resource;

	hold_rsb(r);
	lock_rsb(r);

For the userspace API the lkid is simply whatever was written to the
misc device, so a lkid can be aimed at a lkb that another thread is
still building, and hold_rsb() reads res_flags off NULL:

  BUG: KASAN: null-ptr-deref in rsb_flag fs/dlm/dlm_internal.h:386 [inline]
  BUG: KASAN: null-ptr-deref in hold_rsb fs/dlm/lock.c:334 [inline]
  BUG: KASAN: null-ptr-deref in unlock_lock fs/dlm/lock.c:3333 [inline]
  BUG: KASAN: null-ptr-deref in dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
  Read of size 8 at addr 0000000000000050 by task syz.3.570/7893
   rsb_flag fs/dlm/dlm_internal.h:386 [inline]
   hold_rsb fs/dlm/lock.c:334 [inline]
   unlock_lock fs/dlm/lock.c:3333 [inline]
   dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
   device_user_unlock+0x1ca/0x260 fs/dlm/user.c:321

Make it impossible for ls_lkbxa to hold a lkb without an rsb, rather
than filtering such lkbs in find_lkb() or reserving a NULL entry that
every walker would have to know about.  create_lkb() no longer touches
ls_lkbxa; attach_lkb() sets lkb_resource and only then allocates the
lkb_id and stores the lkb, so the lkb becomes visible already attached.
dlm_debug_add_lkb() presets the id it wants and attach_lkb() allocates
exactly that one.

attach_lkb() can now fail, and each of its four callers releases the
lkb on the error path it already has for a failure just before the
attach.  On failure attach_lkb() also clears lkb_id, so that
__put_lkb() cannot erase another lkb's entry when a requested id was
busy.  All four callers hold the rsb lock, and nothing takes an rsb
lock under ls_lkbxa_lock, so taking it there adds no new lock ordering.

As a side effect an lkb has no lkb_id until it is attached, so
trace_dlm_lock_start() and the validate_lock_args() and
receive_rcom_lock_args() error messages report 0 for a new lock.

The unchecked r = lkb->lkb_resource goes back to the original DLM
import, but an untrusted lkid only became possible once the userspace
device interface was added, so that is the tag below.

Fixes: 597d0cae0f99 ("[DLM] dlm: user locks")
Reported-by: syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=da6dc573ce5e6624f505
Suggested-by: Alexander Aring <aahringo@redhat.com>
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 90 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c715e171bab7..3b3e15157f4c 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1488,10 +1488,38 @@ void free_inactive_rsb(struct dlm_rsb *r)
 /* Attaching/detaching lkb's from rsb's is for rsb reference counting.
    The rsb must exist as long as any lkb's for it do. */
 
-static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/*
+ * An lkb is only put into ls_lkbxa here, once it has an rsb, so
+ * find_lkb() never returns an lkb without one.  The lkb_id is assigned
+ * here too; dlm_debug_add_lkb() presets the one it wants.
+ */
+static int attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
+	struct dlm_ls *ls = r->res_ls;
+	struct xa_limit limit = XA_LIMIT(1, U32_MAX);
+	int rv;
+
+	if (lkb->lkb_id)
+		limit = XA_LIMIT(lkb->lkb_id, lkb->lkb_id);
+
 	hold_rsb(r);
 	lkb->lkb_resource = r;
+
+	write_lock_bh(&ls->ls_lkbxa_lock);
+	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
+	write_unlock_bh(&ls->ls_lkbxa_lock);
+
+	if (rv < 0) {
+		log_error(ls, "%s xa error %d", __func__, rv);
+		/* the caller still holds its own rsb reference */
+		lkb->lkb_resource = NULL;
+		put_rsb(r);
+		/* don't let __put_lkb() erase another lkb's id */
+		lkb->lkb_id = 0;
+		return rv;
+	}
+
+	return 0;
 }
 
 static void detach_lkb(struct dlm_lkb *lkb)
@@ -1502,15 +1530,9 @@ static void detach_lkb(struct dlm_lkb *lkb)
 	}
 }
 
-static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
-		       unsigned long start, unsigned long end)
+static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 {
-	struct xa_limit limit;
 	struct dlm_lkb *lkb;
-	int rv;
-
-	limit.max = end;
-	limit.min = start;
 
 	lkb = dlm_allocate_lkb();
 	if (!lkb)
@@ -1525,25 +1547,10 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
 	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
 
-	write_lock_bh(&ls->ls_lkbxa_lock);
-	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
-	write_unlock_bh(&ls->ls_lkbxa_lock);
-
-	if (rv < 0) {
-		log_error(ls, "create_lkb xa error %d", rv);
-		dlm_free_lkb(lkb);
-		return rv;
-	}
-
 	*lkb_ret = lkb;
 	return 0;
 }
 
-static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
-{
-	return _create_lkb(ls, lkb_ret, 1, ULONG_MAX);
-}
-
 static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
@@ -3294,7 +3301,12 @@ static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 
 	lock_rsb(r);
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		return error;
+	}
 	lkb->lkb_lksb->sb_lkid = lkb->lkb_id;
 
 	error = _request_lock(r, lkb);
@@ -4038,7 +4050,14 @@ static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
 		}
 	}
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		__put_lkb(ls, lkb);
+		goto fail;
+	}
+
 	error = do_request(r, lkb);
 	send_request_reply(r, lkb, error);
 	do_request_effects(r, lkb, error);
@@ -5642,7 +5661,12 @@ int dlm_recover_master_copy(struct dlm_ls *ls, const struct dlm_rcom *rc,
 		goto out_unlock;
 	}
 
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		__put_lkb(ls, lkb);
+		goto out_unlock;
+	}
+
 	add_lkb(r, lkb, rl->rl_status);
 	ls->ls_recover_locks_in++;
 
@@ -6300,12 +6324,14 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 	if (!lksb)
 		return -ENOMEM;
 
-	error = _create_lkb(ls, &lkb, lkb_id, lkb_id + 1);
+	error = create_lkb(ls, &lkb);
 	if (error) {
 		kfree(lksb);
 		return error;
 	}
 
+	lkb->lkb_id = lkb_id;
+
 	dlm_set_dflags_val(lkb, lkb_dflags);
 	lkb->lkb_nodeid = lkb_nodeid;
 	lkb->lkb_lksb = lksb;
@@ -6321,7 +6347,15 @@ int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
 	}
 
 	lock_rsb(r);
-	attach_lkb(r, lkb);
+	error = attach_lkb(r, lkb);
+	if (error) {
+		unlock_rsb(r);
+		put_rsb(r);
+		kfree(lksb);
+		__put_lkb(ls, lkb);
+		return error;
+	}
+
 	add_lkb(r, lkb, lkb_status);
 	unlock_rsb(r);
 	put_rsb(r);
-- 
2.43.0

