Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25721830B
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012395; cv=none; b=WS/PnwKgYMa9p/PDrISCVqbJsTtepgHbiKs1hWBp8JMUUJdR4hfpkhSTu+Y42V2omp+DTvRpWJd2U6S4xmUqcQfL5Evpv17Notuk8VieQrkHmPaF4tukgm+mHRdn4L0s9ilb2U0dG+DVPFgbF32WNzar4LPjnfKqpAf8radgSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012395; c=relaxed/simple;
	bh=qkPYJJujX1ghdcHhf8Vh8FtqimEltRiCVBtTmy7o+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4Ns5B6klmA+dn14g0b9YhgVPguxzInCdAZuFW+dHhU097YoNPL+1C+wcPc211x48FiYY+rodQ9ZplbwX24+IrLBsNo0+mYKk83JvaXse6+ZZHg86S9PdnbiDyVzTCec9deY2CrQCXJu6KTpdXguFsrHt3KeLvNGDlxNq0xabXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZ1gIWu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZ1gIWu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85LuOGMgDQhfUvm1bsamSfQxWA6Ycle4RE0M7nvpLH4=;
	b=DZ1gIWu/U/D/QcQZY18D1+WQ6hnSa+W9K1MsDu+hpDfLuxzMPtepyW2JKbuoBkSRuPlGxi
	DNWyh+0SfTLDwvhkuhERtGMa+NLwv9sXLIOVjKo3hJxVEct0XJGDKvLhPUvO7KS/wovBEs
	83+yHAvbiMC0wzTtfXE6rzasttY8YWQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-HfTsu9p4NkOwJtAwOyo-iQ-1; Thu,
 07 Nov 2024 15:46:30 -0500
X-MC-Unique: HfTsu9p4NkOwJtAwOyo-iQ-1
X-Mimecast-MFC-AGG-ID: HfTsu9p4NkOwJtAwOyo-iQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D00195419F
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:29 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5483530001A0;
	Thu,  7 Nov 2024 20:46:29 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 10/11] dlm: void convert, cancel and unlock requests
Date: Thu,  7 Nov 2024 15:46:16 -0500
Message-ID: <20241107204617.147842-11-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: GwxaXCkTzHWOJplMJ6hFQOl0bYxiL0F9WDC3_qjOg_Q_1731012390
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Ad the new lkb refcount model does not require to evaluate the return
value of request functions we can change those function to return no
value. Before the return value was just always zeroed out if any of the
non-zero return value was returned. This is not necessary anymore.

The _request_lock() function need an additional handling as the user
request functionality still needs to evaluate the return value.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1de8598d7451..28c312410527 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -84,7 +84,7 @@ static void send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode);
 static void send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void send_remove(struct dlm_rsb *r);
 static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void __receive_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
 				    const struct dlm_message *ms, bool local);
 static int receive_extralen(const struct dlm_message *ms);
@@ -3268,9 +3268,9 @@ static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 /* change some property of an existing lkb, e.g. mode */
 
-static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error = 0;
+	int error;
 
 	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
 
@@ -3283,15 +3283,13 @@ static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 		   between do_convert and do_convert_effects */
 		do_convert_effects(r, lkb, error);
 	}
-
-	return error;
 }
 
 /* remove an existing lkb from the granted queue */
 
-static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error = 0;
+	int error;
 
 	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_REQUEST &&
 		lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
@@ -3305,15 +3303,13 @@ static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 		   between do_unlock and do_unlock_effects */
 		do_unlock_effects(r, lkb, error);
 	}
-
-	return error;
 }
 
 /* remove an existing lkb from the convert or wait queue */
 
-static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error = 0;
+	int error;
 
 	WARN_ON(lkb->lkb_rq_state != DLM_LKB_RQ_STATE_REQUEST &&
 		lkb->lkb_rq_state != DLM_LKB_RQ_STATE_CONVERT);
@@ -3327,8 +3323,6 @@ static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 		   between do_cancel and do_cancel_effects */
 		do_cancel_effects(r, lkb, error);
 	}
-
-	return error;
 }
 
 /*
@@ -3385,7 +3379,7 @@ static int convert_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	error = _convert_lock(r, lkb);
+	_convert_lock(r, lkb);
  out:
 	unlock_rsb(r);
 	put_rsb(r);
@@ -3407,7 +3401,7 @@ static int unlock_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	error = _unlock_lock(r, lkb);
+	_unlock_lock(r, lkb);
  out:
 	unlock_rsb(r);
 	put_rsb(r);
@@ -3429,7 +3423,7 @@ static int cancel_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	if (error)
 		goto out;
 
-	error = _cancel_lock(r, lkb);
+	_cancel_lock(r, lkb);
  out:
 	unlock_rsb(r);
 	put_rsb(r);
@@ -3482,13 +3476,11 @@ int dlm_lock(dlm_lockspace_t *lockspace,
 	else
 		error = request_lock(ls, lkb, name, namelen, &args);
 
-	if (error == -EINPROGRESS)
-		error = 0;
  out_put:
 	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, true);
 
 	__put_lkb(ls, lkb);
-	if (error == -EAGAIN || error == -EDEADLK)
+	if (error == -EAGAIN || error == -EINPROGRESS)
 		error = 0;
  out:
 	dlm_unlock_recovery(ls);
@@ -3528,8 +3520,6 @@ int dlm_unlock(dlm_lockspace_t *lockspace,
 	else
 		error = unlock_lock(ls, lkb, &args);
 
-	if (error == -DLM_EUNLOCK || error == -DLM_ECANCEL)
-		error = 0;
 	if (error == -EBUSY && (flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)))
 		error = 0;
  out_put:
@@ -4497,7 +4487,6 @@ static int receive_request_reply(struct dlm_ls *ls,
 			confirm_master(r, result);
 		} else {
 			_request_lock(r, lkb);
-
 			if (r->res_master_nodeid == dlm_our_nodeid())
 				confirm_master(r, 0);
 		}
@@ -5884,8 +5873,6 @@ int dlm_user_convert(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 
 	error = convert_lock(ls, lkb, &args);
 
-	if (error == -EINPROGRESS || error == -EAGAIN || error == -EDEADLK)
-		error = 0;
  out_put:
 	trace_dlm_lock_end(ls, lkb, NULL, 0, mode, flags, error, false);
 	dlm_put_lkb(lkb);
@@ -6092,7 +6079,7 @@ int dlm_user_deadlock(struct dlm_ls *ls, uint32_t flags, uint32_t lkid)
 		goto out_r;
 	set_bit(DLM_IFL_DEADLOCK_CANCEL_BIT, &lkb->lkb_iflags);
 
-	error = _cancel_lock(r, lkb);
+	_cancel_lock(r, lkb);
  out_r:
 	unlock_rsb(r);
 	put_rsb(r);
-- 
2.43.0

