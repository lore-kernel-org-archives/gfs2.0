Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3012FB2D
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640928; cv=none; b=fmFRMAeMJtxFIfHfc2X+gJUAiTUWjn9lHI7lFE2f2gRKtPsHdj0L4NtAlDHUMfrkGtXZn1PuuQ29qsiHldI45xSYqwXCAOFePqpTAZ9eFjjNquoptVv3kx0e5Pz8rT/7KJGnCTiFeVPf5Ai5NBBXfG89oQNeMPwEDg20ez2TVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640928; c=relaxed/simple;
	bh=6REmMFFu+nLEwESZWeBoKYRWb0LsSEI0lM7poO0NR4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnSnRTT1D4LLc3iDQIwmohlQMClL72Shz98MFeAGHjdXfHrWT+gMQMP1a66irDCYr6tZ7XGMSi5X9/sP02DKd/ISrhTlwr55l0izXuEFRRDb8yGC+NNUl5Fz2dNbSd8e3tMuxHnPOlTpwNIkMlizPXKwXRSyGlGDJLdcBEAZLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHGpLJqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHGpLJqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQThA9f5LGx0H/P8t/XmpfJ2+96Ynz6NiJiIoe4DRBs=;
	b=dHGpLJqES4lAyb9HWix3PmAYztDsdKYRb8zfcaUS23d1zC829LQQ7vbRD03Uy+IeCOX6Fr
	47flwdihqKfb1gpaXLbr0bdPyvOapItCMVRWmUygPAx/12G9cWcj+aYfH/HplmhbiVQRdV
	X36bKwsdjxPdFzta2Ah59sOpLLh1xHk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-MVj1YrVNNSiU_azY8jRhwg-1; Thu,
 28 Mar 2024 11:48:44 -0400
X-MC-Unique: MVj1YrVNNSiU_azY8jRhwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C732B2800C38
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C06ADC04123;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 07/10] dlm: move lkb debug information out of callback
Date: Thu, 28 Mar 2024 11:48:39 -0400
Message-ID: <20240328154842.1099288-7-aahringo@redhat.com>
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

This patch removes per lkb callback debug information to the
functionality when we queue the callback. As we need to remove any lkb
reference in the callback handling this functionality will be move to an
earlier point of execution. It is so far only used for debugging and the
exact timing doesn't matter.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index dd7cca3c1472..cadbcbe0786b 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -105,8 +105,13 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 
 	list_add_tail(&cb->list, &lkb->lkb_callbacks);
 
-	if (flags & DLM_CB_CAST)
+	if (flags & DLM_CB_BAST) {
+		lkb->lkb_last_bast_time = ktime_get();
+		lkb->lkb_last_bast_mode = cb->mode;
+	} else if (flags & DLM_CB_CAST) {
 		dlm_callback_set_last_ptr(&lkb->lkb_last_cast, cb);
+		lkb->lkb_last_cast_time = ktime_get();
+	}
 
 	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, cb);
 
@@ -194,8 +199,6 @@ void dlm_callback_work(struct work_struct *work)
 			trace_dlm_bast(ls->ls_global_id, lkb->lkb_id,
 				       cb->mode, rsb->res_name,
 				       rsb->res_length);
-			lkb->lkb_last_bast_time = ktime_get();
-			lkb->lkb_last_bast_mode = cb->mode;
 			bastfn(lkb->lkb_astparam, cb->mode);
 		} else if (cb->flags & DLM_CB_CAST) {
 			lkb->lkb_lksb->sb_status = cb->sb_status;
@@ -203,7 +206,6 @@ void dlm_callback_work(struct work_struct *work)
 			trace_dlm_ast(ls->ls_global_id, lkb->lkb_id,
 				      cb->sb_flags, cb->sb_status,
 				      rsb->res_name, rsb->res_length);
-			lkb->lkb_last_cast_time = ktime_get();
 			castfn(lkb->lkb_astparam);
 		}
 
-- 
2.43.0

