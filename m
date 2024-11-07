Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D322E
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012393; cv=none; b=FLIFeEtYSv+8I4dPHf23Sym1XJ0/XZZvLgeMZa2GXfOC9o35vYvQlMHDHj6dJA1VJacmMItOcPHPFl7w1dVVjPh8gedxtL8KXeN39a8yl81mqv/DoxdeFvaeOAFJmzV4WLDgq28T+8Fh4CUqIDXZVlZw+pjwolWNTdkc661QnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012393; c=relaxed/simple;
	bh=brpC7gd9iQs4pHaOm/0/rSQoxJG0I48e5AFgFdvWDzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyXoIBlm4GRJ/+iEoHl2W0rFHWgpjVMXuMTpAy8ry8M6wlvfYXiHfasy/qy7YcVXkLOI8hNUFq+pJxUokbmwUmwhB0eCkg0B1+J/R9o4X2n5GXgQCejPynZrJ/heXjzRj6FG6yHLa92i0rd4weOf8mXQXkbd2Ls8sf6eP9cN7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhQjQTKg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhQjQTKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Te+azpKM47EWhNF5d02GZ57dXm/Hen7y7KtBYJojDPI=;
	b=JhQjQTKg/sGqXFMw2MYAQdSSA684j64IH/s/BOuQL1615WmZZC9QLkLAHN+CjinpcyJgkn
	Hakske7r8EPrxERuOEnRupHU1SxjSCNew/m5rlVp5MFk0HAJDTYzaYaucbo+lQ6KYb6rIv
	LNq68tkRzzObc38o1KYaGaWHNOJVlL0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-nZ-68I9iMpq1CxiCjoL2Wg-1; Thu,
 07 Nov 2024 15:46:29 -0500
X-MC-Unique: nZ-68I9iMpq1CxiCjoL2Wg-1
X-Mimecast-MFC-AGG-ID: nZ-68I9iMpq1CxiCjoL2Wg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D5741956048
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:28 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92EC9300019E;
	Thu,  7 Nov 2024 20:46:27 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 08/11] dlm: make send dlm message as non-failure
Date: Thu,  7 Nov 2024 15:46:14 -0500
Message-ID: <20241107204617.147842-9-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: GVIK2Ny7edL96x8GPDt0ww4tByNXJ_Q14PifvAlaHsE_1731012388
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

We cannot handle if any DLM message being send out fails so we change
every send message as it cannot fail.

There might be in future other ways to handle send failures internally
but from a caller prospective it should never fail.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 235 ++++++++++++++++++--------------------------------
 fs/dlm/lock.h |   4 +-
 fs/dlm/user.c |   5 +-
 3 files changed, 86 insertions(+), 158 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index f2060a9d78f3..9d2d3567bf9d 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -75,14 +75,14 @@
 #include "user.h"
 #include "config.h"
 
-static int send_request(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode);
-static int send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb);
-static int send_remove(struct dlm_rsb *r);
+static void send_request(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode);
+static void send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb);
+static void send_remove(struct dlm_rsb *r);
 static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
 static void __receive_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
@@ -1693,23 +1693,6 @@ static void move_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int sts)
 	add_lkb_noref(r, lkb, sts);
 }
 
-static int msg_reply_type(int mstype)
-{
-	switch (mstype) {
-	case DLM_MSG_REQUEST:
-		return DLM_MSG_REQUEST_REPLY;
-	case DLM_MSG_CONVERT:
-		return DLM_MSG_CONVERT_REPLY;
-	case DLM_MSG_UNLOCK:
-		return DLM_MSG_UNLOCK_REPLY;
-	case DLM_MSG_CANCEL:
-		return DLM_MSG_CANCEL_REPLY;
-	case DLM_MSG_LOOKUP:
-		return DLM_MSG_LOOKUP_REPLY;
-	}
-	return -1;
-}
-
 /* add/remove lkb from global waiters list of lkb's waiting for
    a reply from a remote node */
 
@@ -3194,7 +3177,7 @@ static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 	if (is_remote(r)) {
 		/* receive_request() calls do_request() on remote node */
-		error = send_request(r, lkb);
+		send_request(r, lkb);
 	} else {
 		error = do_request(r, lkb);
 		/* for remote locks the request_reply is sent
@@ -3209,11 +3192,11 @@ static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error;
+	int error = 0;
 
 	if (is_remote(r)) {
 		/* receive_convert() calls do_convert() on remote node */
-		error = send_convert(r, lkb);
+		send_convert(r, lkb);
 	} else {
 		error = do_convert(r, lkb);
 		/* for remote locks the convert_reply is sent
@@ -3228,11 +3211,11 @@ static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error;
+	int error = 0;
 
 	if (is_remote(r)) {
 		/* receive_unlock() calls do_unlock() on remote node */
-		error = send_unlock(r, lkb);
+		send_unlock(r, lkb);
 	} else {
 		error = do_unlock(r, lkb);
 		/* for remote locks the unlock_reply is sent
@@ -3247,11 +3230,11 @@ static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 
 static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error;
+	int error = 0;
 
 	if (is_remote(r)) {
 		/* receive_cancel() calls do_cancel() on remote node */
-		error = send_cancel(r, lkb);
+		send_cancel(r, lkb);
 	} else {
 		error = do_cancel(r, lkb);
 		/* for remote locks the cancel_reply is sent
@@ -3489,10 +3472,10 @@ int dlm_unlock(dlm_lockspace_t *lockspace,
  * receive_lookup_reply		send_lookup_reply
  */
 
-static int _create_message(struct dlm_ls *ls, int mb_len,
-			   int to_nodeid, int mstype,
-			   struct dlm_message **ms_ret,
-			   struct dlm_mhandle **mh_ret)
+static void _create_message(struct dlm_ls *ls, int mb_len,
+			    int to_nodeid, int mstype,
+			    struct dlm_message **ms_ret,
+			    struct dlm_mhandle **mh_ret)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
@@ -3503,8 +3486,8 @@ static int _create_message(struct dlm_ls *ls, int mb_len,
 	   write our data into */
 
 	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, &mb);
-	if (!mh)
-		return -ENOBUFS;
+	if (WARN_ON(!mh))
+		return;
 
 	ms = (struct dlm_message *) mb;
 
@@ -3518,13 +3501,12 @@ static int _create_message(struct dlm_ls *ls, int mb_len,
 
 	*mh_ret = mh;
 	*ms_ret = ms;
-	return 0;
 }
 
-static int create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			  int to_nodeid, int mstype,
-			  struct dlm_message **ms_ret,
-			  struct dlm_mhandle **mh_ret)
+static void create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			   int to_nodeid, int mstype,
+			   struct dlm_message **ms_ret,
+			   struct dlm_mhandle **mh_ret)
 {
 	int mb_len = sizeof(struct dlm_message);
 
@@ -3548,14 +3530,10 @@ static int create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
 			       ms_ret, mh_ret);
 }
 
-/* further lowcomms enhancements or alternate implementations may make
-   the return value from this function useful at some point */
-
-static int send_message(struct dlm_mhandle *mh, struct dlm_message *ms,
-			const void *name, int namelen)
+static void send_message(struct dlm_mhandle *mh, struct dlm_message *ms,
+			 const void *name, int namelen)
 {
 	dlm_midcomms_commit_mhandle(mh, name, namelen);
-	return 0;
 }
 
 static void send_args(struct dlm_rsb *r, struct dlm_lkb *lkb,
@@ -3602,216 +3580,173 @@ static void send_args(struct dlm_rsb *r, struct dlm_lkb *lkb,
 	}
 }
 
-static int send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
+static void send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = r->res_nodeid;
 
 	add_to_waiters(lkb, mstype, to_nodeid);
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
-	if (error)
-		goto fail;
+	create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
 
 	send_args(r, lkb, ms);
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
-	if (error)
-		goto fail;
-	return 0;
-
- fail:
-	remove_from_waiters(lkb, msg_reply_type(mstype));
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	return send_common(r, lkb, DLM_MSG_REQUEST);
+	send_common(r, lkb, DLM_MSG_REQUEST);
 }
 
-static int send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int error;
-
-	error = send_common(r, lkb, DLM_MSG_CONVERT);
+	send_common(r, lkb, DLM_MSG_CONVERT);
 
 	/* down conversions go without a reply from the master */
-	if (!error && down_conversion(lkb)) {
+	if (down_conversion(lkb)) {
 		remove_from_waiters(lkb, DLM_MSG_CONVERT_REPLY);
 		r->res_ls->ls_local_ms.m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
 		r->res_ls->ls_local_ms.m_result = 0;
 		__receive_convert_reply(r, lkb, &r->res_ls->ls_local_ms, true);
 	}
-
-	return error;
 }
 
 /* FIXME: if this lkb is the only lock we hold on the rsb, then set
    MASTER_UNCERTAIN to force the next request on the rsb to confirm
    that the master is still correct. */
 
-static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	return send_common(r, lkb, DLM_MSG_UNLOCK);
+	send_common(r, lkb, DLM_MSG_UNLOCK);
 }
 
-static int send_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	return send_common(r, lkb, DLM_MSG_CANCEL);
+	send_common(r, lkb, DLM_MSG_CANCEL);
 }
 
-static int send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh);
-	if (error)
-		goto out;
-
+	create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh);
 	send_args(r, lkb, ms);
 
 	ms->m_result = 0;
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode)
+static void send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_BAST, &ms, &mh);
-	if (error)
-		goto out;
+	create_message(r, NULL, to_nodeid, DLM_MSG_BAST, &ms, &mh);
 
 	send_args(r, lkb, ms);
 
 	ms->m_bastmode = cpu_to_le32(mode);
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = dlm_dir_nodeid(r);
 
 	add_to_waiters(lkb, DLM_MSG_LOOKUP, to_nodeid);
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh);
-	if (error)
-		goto fail;
+	create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh);
 
 	send_args(r, lkb, ms);
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
-	if (error)
-		goto fail;
-	return 0;
-
- fail:
-	remove_from_waiters(lkb, DLM_MSG_LOOKUP_REPLY);
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_remove(struct dlm_rsb *r)
+static void send_remove(struct dlm_rsb *r)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = dlm_dir_nodeid(r);
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_REMOVE, &ms, &mh);
-	if (error)
-		goto out;
+	create_message(r, NULL, to_nodeid, DLM_MSG_REMOVE, &ms, &mh);
 
 	memcpy(ms->m_extra, r->res_name, r->res_length);
 	ms->m_hash = cpu_to_le32(r->res_hash);
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_common_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			     int mstype, int rv)
+static void send_common_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			      int mstype, int rv)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	int to_nodeid;
 
 	to_nodeid = lkb->lkb_nodeid;
 
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
-	if (error)
-		goto out;
+	create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
 
 	send_args(r, lkb, ms);
 
 	ms->m_result = cpu_to_le32(to_dlm_errno(rv));
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+	send_message(mh, ms, r->res_name, r->res_length);
 }
 
-static int send_request_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static void send_request_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
 {
-	return send_common_reply(r, lkb, DLM_MSG_REQUEST_REPLY, rv);
+	send_common_reply(r, lkb, DLM_MSG_REQUEST_REPLY, rv);
 }
 
-static int send_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static void send_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
 {
-	return send_common_reply(r, lkb, DLM_MSG_CONVERT_REPLY, rv);
+	send_common_reply(r, lkb, DLM_MSG_CONVERT_REPLY, rv);
 }
 
-static int send_unlock_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static void send_unlock_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
 {
-	return send_common_reply(r, lkb, DLM_MSG_UNLOCK_REPLY, rv);
+	send_common_reply(r, lkb, DLM_MSG_UNLOCK_REPLY, rv);
 }
 
-static int send_cancel_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static void send_cancel_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
 {
-	return send_common_reply(r, lkb, DLM_MSG_CANCEL_REPLY, rv);
+	send_common_reply(r, lkb, DLM_MSG_CANCEL_REPLY, rv);
 }
 
-static int send_lookup_reply(struct dlm_ls *ls,
-			     const struct dlm_message *ms_in, int ret_nodeid,
-			     int rv)
+static void send_lookup_reply(struct dlm_ls *ls,
+			      const struct dlm_message *ms_in, int ret_nodeid,
+			      int rv)
 {
 	struct dlm_rsb *r = &ls->ls_local_rsb;
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int error, nodeid = le32_to_cpu(ms_in->m_header.h_nodeid);
+	int nodeid = le32_to_cpu(ms_in->m_header.h_nodeid);
 
-	error = create_message(r, NULL, nodeid, DLM_MSG_LOOKUP_REPLY, &ms, &mh);
-	if (error)
-		goto out;
+	create_message(r, NULL, nodeid, DLM_MSG_LOOKUP_REPLY, &ms, &mh);
 
 	ms->m_lkid = ms_in->m_lkid;
 	ms->m_result = cpu_to_le32(to_dlm_errno(rv));
 	ms->m_nodeid = cpu_to_le32(ret_nodeid);
 
-	error = send_message(mh, ms, ms_in->m_extra, receive_extralen(ms_in));
- out:
-	return error;
+	send_message(mh, ms, ms_in->m_extra, receive_extralen(ms_in));
 }
 
 /* which args we save from a received message depends heavily on the type
@@ -6258,29 +6193,24 @@ static void do_purge(struct dlm_ls *ls, int nodeid, int pid)
 	spin_unlock_bh(&ls->ls_orphans_lock);
 }
 
-static int send_purge(struct dlm_ls *ls, int nodeid, int pid)
+static void send_purge(struct dlm_ls *ls, int nodeid, int pid)
 {
 	struct dlm_message *ms;
 	struct dlm_mhandle *mh;
-	int error;
 
-	error = _create_message(ls, sizeof(struct dlm_message), nodeid,
-				DLM_MSG_PURGE, &ms, &mh);
-	if (error)
-		return error;
+	_create_message(ls, sizeof(struct dlm_message), nodeid,
+			DLM_MSG_PURGE, &ms, &mh);
 	ms->m_nodeid = cpu_to_le32(nodeid);
 	ms->m_pid = cpu_to_le32(pid);
 
-	return send_message(mh, ms, NULL, 0);
+	send_message(mh, ms, NULL, 0);
 }
 
-int dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
-		   int nodeid, int pid)
+void dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
+		    int nodeid, int pid)
 {
-	int error = 0;
-
 	if (nodeid && (nodeid != dlm_our_nodeid())) {
-		error = send_purge(ls, nodeid, pid);
+		send_purge(ls, nodeid, pid);
 	} else {
 		dlm_lock_recovery(ls);
 		if (pid == current->pid)
@@ -6289,7 +6219,6 @@ int dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
 			do_purge(ls, nodeid, pid);
 		dlm_unlock_recovery(ls);
 	}
-	return error;
 }
 
 /* debug functionality */
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b23d7b854ed4..45ffe149ae3b 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -55,8 +55,8 @@ int dlm_user_unlock(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 	uint32_t flags, uint32_t lkid, char *lvb_in);
 int dlm_user_cancel(struct dlm_ls *ls,  struct dlm_user_args *ua_tmp,
 	uint32_t flags, uint32_t lkid);
-int dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
-	int nodeid, int pid);
+void dlm_user_purge(struct dlm_ls *ls, struct dlm_user_proc *proc,
+		    int nodeid, int pid);
 int dlm_user_deadlock(struct dlm_ls *ls, uint32_t flags, uint32_t lkid);
 void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc);
 int dlm_debug_add_lkb(struct dlm_ls *ls, uint32_t lkb_id, char *name, int len,
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 5cb3896be826..4b1f5679907f 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -390,16 +390,15 @@ static int device_user_purge(struct dlm_user_proc *proc,
 			     struct dlm_purge_params *params)
 {
 	struct dlm_ls *ls;
-	int error;
 
 	ls = dlm_find_lockspace_local(proc->lockspace);
 	if (!ls)
 		return -ENOENT;
 
-	error = dlm_user_purge(ls, proc, params->nodeid, params->pid);
+	dlm_user_purge(ls, proc, params->nodeid, params->pid);
 
 	dlm_put_lockspace(ls);
-	return error;
+	return 0;
 }
 
 static int device_create_lockspace(struct dlm_lspace_params *params)
-- 
2.43.0

