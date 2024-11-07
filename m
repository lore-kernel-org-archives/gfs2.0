Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0228212EEC
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012390; cv=none; b=pWlLe1Ji4IvTWRFSUu59T4/imjZ1+pNUM7FuVv9suf5doMVQfYw9xiP8aAAkwDu9cWfjOBhPlZDrxV/S6NAhn8W7EM9saExi97WqzJRDZ0sC0vtiAQCSY/aM2d6bLBcm/6NtY8Ara9OS+6SYtEig2riWpYE4AC10Msz7WTgDIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012390; c=relaxed/simple;
	bh=dWPnAsqbuo70I+7vRtPFZjPVVjtovnRtqCpCk+unuxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBvH1P4PG5mihUOBW5MnixtqaI6Q+ipU3xdabx7p/DAcGPOFn5I+8gGw/UZkt7chrBJoJfDIrIQJgDeblGcHRxkqLlV/xpArfPm6KWu+7D/OUTHaWvJVcmqriPL+jbslpU9MCaOjLQrC5VNEiOPWuPEBioGH5YG65qPO3qaOR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fkci0zH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fkci0zH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4agAIrDQik0O60dkVc2OymJ2NdL699Qjg/vdD8jFS0=;
	b=Fkci0zH5P6mOAocsbTcTyIW2X3Wjv1xbeE6d/v1f+whS88uI6IAlmLSqt7ZVGvj+Zb9X7a
	hYFWDmaizLLNIvYp076t0Ac1+Lny3HT+WEa8gM7K1QWJjUtkdB9RxzO+5k1NIVNDtwiQrN
	EAXNPJfngQw/mtF0/UhLxyULrupy0SQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-4cBAI6fFOmW6R0q42V_PZg-1; Thu,
 07 Nov 2024 15:46:26 -0500
X-MC-Unique: 4cBAI6fFOmW6R0q42V_PZg-1
X-Mimecast-MFC-AGG-ID: 4cBAI6fFOmW6R0q42V_PZg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A9EA19560B4
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:25 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 034D0300019E;
	Thu,  7 Nov 2024 20:46:24 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 05/11] dlm: drop lkb hold for waiter conversion handling
Date: Thu,  7 Nov 2024 15:46:11 -0500
Message-ID: <20241107204617.147842-6-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hdVTeRClzLhda4-A03J2AfAXdbjcKUpLtMin0ZPOmAY_1731012385
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Drop the extra reference holding when handling a conversion as a
conversion should never free a lkb. Adding more comments for unlock and
cancel case because internal remove_from_waiters() can end the lkb
lifetime.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 378234b42593..1f4f2d24bef4 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5005,7 +5005,6 @@ static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 				   struct dlm_message *ms_local)
 {
 	if (middle_conversion(lkb)) {
-		hold_lkb(lkb);
 		memset(ms_local, 0, sizeof(struct dlm_message));
 		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
 		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
@@ -5015,7 +5014,6 @@ static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
 		/* Same special case as in receive_rcom_lock_args() */
 		lkb->lkb_grmode = DLM_LOCK_IV;
 		rsb_set_flag(lkb->lkb_resource, RSB_RECOVER_CONVERT);
-		unhold_lkb(lkb);
 
 	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
 		set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
@@ -5120,10 +5118,17 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 			break;
 
 		case DLM_MSG_CONVERT:
+			/* a convert should never end lkbs lifetime */
 			recover_convert_waiter(ls, lkb, ms_local);
 			break;
 
 		case DLM_MSG_UNLOCK:
+			/* _receive_unlock_reply() can call remove_from_waiters()
+			 * that leads to free the lkb and the reference of ther
+			 * iterating lkb for ls_waiters get drops. To prevent this
+			 * we need to hold the lkb here to prevent use after free
+			 * when the lkb is removed from the waiter.
+			 */
 			hold_lkb(lkb);
 			memset(ms_local, 0, sizeof(struct dlm_message));
 			ms_local->m_type = cpu_to_le32(DLM_MSG_UNLOCK_REPLY);
@@ -5134,6 +5139,12 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 			break;
 
 		case DLM_MSG_CANCEL:
+			/* _receive_cancel_reply() can call remove_from_waiters()
+			 * that leads to free the lkb and the reference of ther
+			 * iterating lkb for ls_waiters get drops. To prevent this
+			 * we need to hold the lkb here to prevent use after free
+			 * when the lkb is removed from the waiter.
+			 */
 			hold_lkb(lkb);
 			memset(ms_local, 0, sizeof(struct dlm_message));
 			ms_local->m_type = cpu_to_le32(DLM_MSG_CANCEL_REPLY);
-- 
2.43.0

