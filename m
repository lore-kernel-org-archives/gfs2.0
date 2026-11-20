Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204857;
	b=4+Byz+Iv5EpuARwOYrwX5UNPhOfp1qJbMjocMxOCxqGHOBo+DjqFrW5aH1PXb7JeB0If
	 oM6QBPToyKvT/gH0RiwZPeCPP5XtFPcX4fykb9iTqGTVxAu8n8PFkB3CorsqYJblc3ANe
	 YYVm4grJ3ZCpsO8EdCgLIg8BqDrUCAl5Gcal8clRg7QrZAcIAtCGl/aasG9xmtZk2gbF2
	 fGOtXNhsZxCKfXQa0s8P8jUnWn1al9xMeWvpQx4OuBhdFt/1gGEEzgfxCdCXrMUCQMU3Z
	 TRC6KQwNDjKw+Vi97Peq6zdVtY6cn66Ca2e5UADDb7v/XjDEfSughjdMGy0vhQ5COBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204857;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=4XoDl4pR/ZqPHmdwDKWhpo878INuhEJ4dtltOdyYZJU=;
	b=QC6eCgttV+whAPK/KZKc/GpH8OAuijurnpRwOqL0PeI9LhkJ3qxUtZCckotLyZegFxA5
	 TY2paRCVOdi2NfEXIMZNVNOP7KuQbKa+O//8dZzEoIYS1oXI02k3nB2CT/cd2gotL965A
	 TPqvZimaHD2o8NUasXD88r7EhW8Y7BwXiWb4jSy9Pp4t02EtvfshstT2ubXu/JarlFhS8
	 R2bqIKHALiR+xOEMZoVbvdVfdgvV0wTozASRb23O5Ty9wQmkmAGrlcvxUsf2Cy1V3a/SD
	 44CMzGMn2UILFgUwy7IaIvoRJ4x0aFiWuzMYEs5sqWgdyQdUuszTn4uP0w41TuvgvGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWFk51yv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617660A2602
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6617660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWFk51yv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795204848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XoDl4pR/ZqPHmdwDKWhpo878INuhEJ4dtltOdyYZJU=;
	b=WWFk51yv0y8j/lyrPYiIuc0qtNwZZZZmeUIT68hP63opnrJ4zOBW5ga7c1FYYUK1dncTPW
	fyRpJ9zhdE1Ci9na/4/0IyMu+eILm4wMoJ1mbHe/g0YbM5zVqaP9Qz9tV3MrfkgtgC+xQg
	NehqsfOpHRelLH2fYJBmmy1Xuyn6ml0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-aGGKCqL4NMWtGPlP-dVj3Q-1; Fri,
 20 Nov 2026 20:00:46 +0000
X-MC-Unique: aGGKCqL4NMWtGPlP-dVj3Q-1
X-Mimecast-MFC-AGG-ID: aGGKCqL4NMWtGPlP-dVj3Q_1795204845
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F9DD1956073
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:45 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A111141F;
	Fri, 20 Nov 2026 20:00:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCHv2 RESEND v7.4-rc3 3/5] dlm: don't publish a lkb in ls_lkbxa before it has an rsb
Date: Fri, 20 Nov 2026 15:00:38 -0500
Message-ID: <20261120200040.257152-4-aahringo@redhat.com>
In-Reply-To: <20261120200040.257152-1-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dRHu6A4iS7l-HgJdgyVa0-ItlpB6AHXmd9SaX1b80yk_1795204845
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

