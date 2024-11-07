Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2832194C92
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012395; cv=none; b=UbmTMw2ZhteUk+I/eiAWbjtwrfCirQe6U7fYrTBg2I6KcDmfNfhtUl4ReHjeKThnS6xC18LY8uTLDwQnV+BqCXk/HYvbYDBlv/kYe0Pq3d1Vk4jec0ooVEocqMizHQLrULSVlf3kaPayzvZMW1QytvFPUb/vtbjyApRt/9IDHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012395; c=relaxed/simple;
	bh=Ee+WJSUpDXPY5+fqcd/6Bb51V7VLe4YMi7LPs6z31+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffujhbIQPHGhLRQrQ+Yjc5I/wIFyh7JRytSuA+LAWR7M0WTgsdktmtkABFgep2kq5Sf8i+QvwnhhRZQKp3vcZd3ToisINSYgqSGLJzov85BH4ucNI0YEZQGKriQzSzdfBfpPh+DsFdrllQCV/mhhZh7BIuyzKkDNWxF/UTyuLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcAIv9Os; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcAIv9Os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dS5qIbk6i6lTGbg/Td4Wtrq8An2AssxBtAu1lat2js=;
	b=YcAIv9Osz96416tY86bEx0qADM7JgK1MLiIR6+31BQTVxIWMYacGFfIUiNEpaCozwPfZ6w
	oMQFC4mY+jU/aZFSxiO8De060Q9OKI1glWYgj7nS4eP4a0g5fK616y27ZWax+L45bd0i8w
	jQwvDRoN0YAOGxWA6RLXCFmraGuRoMw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-siRTfZwHNAimpShChOH0Hg-1; Thu,
 07 Nov 2024 15:46:31 -0500
X-MC-Unique: siRTfZwHNAimpShChOH0Hg-1
X-Mimecast-MFC-AGG-ID: siRTfZwHNAimpShChOH0Hg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA7ED19560B2
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:30 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26B0E300019E;
	Thu,  7 Nov 2024 20:46:30 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 11/11] dlm: return void for _request_lock function
Date: Thu,  7 Nov 2024 15:46:17 -0500
Message-ID: <20241107204617.147842-12-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: v5xiP7rAJbGJBhKgOzuJ06NnWGiuryUsNow77rCqeNA_1731012390
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Change the _request_lock() function that it cannot fail as the recent
changes to the lkb refcounting model does not require to evaluate the
return value to may call a put.

For the dlm_user_request() function we still need to know if the result
-EAGAIN was happening as the lkb lifetime ends to not add the lkb to the
ownqueue. This is the only user, we use a call-by-reference result
parameter to allow the user to know if the lkb lifetime ended
immediately on the lock request as dlm_user_request() requires.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 28c312410527..10058c89c811 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -83,7 +83,7 @@ static void send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode);
 static void send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void send_remove(struct dlm_rsb *r);
-static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb, int *result);
 static void _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void __receive_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
 				    const struct dlm_message *ms, bool local);
@@ -2761,7 +2761,7 @@ static void process_lookup_list(struct dlm_rsb *r)
 
 	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
 		list_del_init(&lkb->lkb_rsb_lookup);
-		_request_lock(r, lkb);
+		_request_lock(r, lkb, NULL);
 		dlm_put_lkb(lkb);
 	}
 }
@@ -2796,7 +2796,7 @@ static void confirm_master(struct dlm_rsb *r, int error)
 					 lkb_rsb_lookup);
 			list_del_init(&lkb->lkb_rsb_lookup);
 			r->res_first_lkid = lkb->lkb_id;
-			_request_lock(r, lkb);
+			_request_lock(r, lkb, NULL);
 			dlm_put_lkb(lkb);
 		}
 		break;
@@ -3241,7 +3241,7 @@ static void do_cancel_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
 
 /* add a new lkb to a possibly new rsb, called by requesting process */
 
-static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb, int *result)
 {
 	int error;
 
@@ -3263,7 +3263,8 @@ static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 		do_request_effects(r, lkb, error);
 	}
  out:
-	return error;
+	if (result)
+		*result = error;
 }
 
 /* change some property of an existing lkb, e.g. mode */
@@ -3332,7 +3333,7 @@ static void _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 			const void *name, int len,
-			struct dlm_args *args)
+			struct dlm_args *args, int *result)
 {
 	struct dlm_rsb *r;
 	int error;
@@ -3357,11 +3358,11 @@ static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	attach_lkb(r, lkb);
 	lkb->lkb_lksb->sb_lkid = lkb->lkb_id;
 
-	error = _request_lock(r, lkb);
+	_request_lock(r, lkb, result);
 
 	unlock_rsb(r);
 	put_rsb(r);
-	return error;
+	return 0;
 }
 
 static int convert_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
@@ -3474,14 +3475,12 @@ int dlm_lock(dlm_lockspace_t *lockspace,
 	if (convert)
 		error = convert_lock(ls, lkb, &args);
 	else
-		error = request_lock(ls, lkb, name, namelen, &args);
+		error = request_lock(ls, lkb, name, namelen, &args, NULL);
 
  out_put:
 	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, true);
 
 	__put_lkb(ls, lkb);
-	if (error == -EAGAIN || error == -EINPROGRESS)
-		error = 0;
  out:
 	dlm_unlock_recovery(ls);
 	dlm_put_lockspace(ls);
@@ -4486,7 +4485,7 @@ static int receive_request_reply(struct dlm_ls *ls,
 			queue_cast_overlap(r, lkb);
 			confirm_master(r, result);
 		} else {
-			_request_lock(r, lkb);
+			_request_lock(r, lkb, NULL);
 			if (r->res_master_nodeid == dlm_our_nodeid())
 				confirm_master(r, 0);
 		}
@@ -4772,7 +4771,7 @@ static void receive_lookup_reply(struct dlm_ls *ls,
 		goto out_list;
 	}
 
-	_request_lock(r, lkb);
+	_request_lock(r, lkb, NULL);
 
  out_list:
 	if (do_lookup_list)
@@ -5328,7 +5327,7 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 			switch (mstype) {
 			case DLM_MSG_LOOKUP:
 			case DLM_MSG_REQUEST:
-				_request_lock(r, lkb);
+				_request_lock(r, lkb, NULL);
 				if (r->res_nodeid != -1 && is_master(r))
 					confirm_master(r, 0);
 				break;
@@ -5767,7 +5766,7 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
 {
 	struct dlm_lkb *lkb;
 	struct dlm_args args;
-	int error;
+	int error, result;
 
 	dlm_lock_recovery(ls);
 
@@ -5800,20 +5799,16 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
 	   When DLM_DFL_USER_BIT is set, the dlm knows that this is a userspace
 	   lock and that lkb_astparam is the dlm_user_args structure. */
 	set_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags);
-	error = request_lock(ls, lkb, name, namelen, &args);
+	error = request_lock(ls, lkb, name, namelen, &args, &result);
+	if (error)
+		goto out_put;
 
-	switch (error) {
-	case 0:
-		break;
-	case -EINPROGRESS:
-		error = 0;
-		break;
-	case -EAGAIN:
-		error = 0;
-		fallthrough;
-	default:
+	/* the lkb lifetime ended because request_lock() handled
+	 * internally an -EAGAIN, so we don't add it to the
+	 * ownqueue.
+	 */
+	if (result == -EAGAIN)
 		goto out_put;
-	}
 
 	/* add this new lkb to the per-process list of locks */
 	spin_lock_bh(&ua->proc->locks_spin);
-- 
2.43.0

