Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24C14AD20
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516423; cv=none; b=u6c11pH/WGb+Dqt1sGc6ywSlt7fVL+56odq9NmJYxdT9OQJ2dP1YDF1qhT86aWNaoO9TdOwftWyTNRw0g7XSJzjXwTmNhW8b+DtIX5vE4lu0whIk0slb+R9oLekcHaYHR2mTQWu8XPxtuXfZToA09fjEnB2LHYlkBJ0VYTSWLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516423; c=relaxed/simple;
	bh=PFWsrAKc0v9reYE+nGZLeDo+nLenJmvW58QvZVX62gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9ZxY2xf16p3Rw7Xae6j+1ZYLf/c+CWnFi2Um3KXoqdRzywapRN8L3Ub2wm+UqhF/6EwNMITOLm28iE8Ehv78aRQJuzSToh99aO95p+HEdDWIR4u0g1rkcLyI0JOVn3j6YQCUi6GmEHTEgKvqEzGAf9t8JpGD2tFo1fbHacUdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViEjyjqV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViEjyjqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmBn5Cw4GeCQ/A7h2Bwsi+8skdSTEASxH5QBPEj9FCI=;
	b=ViEjyjqVnbuC01CaoUvn5dS3B2uiLWrZ70iuRO3ZbUN6tM7l8OzCaxpHu2TyQ0tMgsK9Bi
	N0dEmE1wJ/vE73SghV/AcYeaGy9/YtZNaxZWXIN5IR41810v3nU1edhiD9u/LeqEQM6qj8
	1u+kw4ldCLt/AjhgjWtlcWkpzcJpAuU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-HZYirynaO3OP9NPV7OGVMw-1; Wed,
 13 Nov 2024 11:46:56 -0500
X-MC-Unique: HZYirynaO3OP9NPV7OGVMw-1
X-Mimecast-MFC-AGG-ID: HZYirynaO3OP9NPV7OGVMw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DADE1955F41
	for <gfs2@lists.linux.dev>; Wed, 13 Nov 2024 16:46:54 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF1061955F40;
	Wed, 13 Nov 2024 16:46:53 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 5/5] dlm: more debug info on invalid lock requests
Date: Wed, 13 Nov 2024 11:46:43 -0500
Message-ID: <20241113164643.464055-5-aahringo@redhat.com>
In-Reply-To: <20241113164643.464055-1-aahringo@redhat.com>
References: <20241113164643.464055-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lU8UqU4-iALCVUwywQ-LlM48z_s9poDbSM4tEK9aq_8_1731516414
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Recently there was an issue coming up about an invalid lkb state when a
convert was triggered. After investigation an recovery issue was the
root of the problem. However we only saw it because QUECVT flag was
being set that was leading DLM to return with -EINVAL on such invalid
state. To cover also such case without QUECVT is set we introduce more
conditions that are required to be checked before initial a DLM lock
conversion.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1e809f591d1a..7217cc566175 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2830,6 +2830,11 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 		if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
 			goto out;
 
+		/* sanity check to do a conversion on a invalid lkb state */
+		if (lkb->lkb_grmode == DLM_LOCK_IV ||
+		    lkb->lkb_status != DLM_LKSTS_GRANTED)
+			goto out;
+
 		if (args->flags & DLM_LKF_QUECVT &&
 		    !__quecvt_compat_matrix[lkb->lkb_grmode+1][args->mode+1])
 			goto out;
@@ -2852,14 +2857,16 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	case -EINVAL:
 		/* annoy the user because dlm usage is wrong */
 		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d", __func__,
+		log_error(ls, "%s %d %x %x %x %d %d %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
+			  lkb->lkb_status, lkb->lkb_wait_type,
+			  lkb->lkb_rqmode, lkb->lkb_grmode);
 		break;
 	default:
-		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
+		log_debug(ls, "%s %d %x %x %x %d %d %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
+			  lkb->lkb_status, lkb->lkb_wait_type,
+			  lkb->lkb_rqmode, lkb->lkb_grmode);
 		break;
 	}
 
-- 
2.43.0

