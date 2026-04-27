Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56246342517
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305589; cv=none; b=S+Q5sL/xl4txsMM+NyDagg3Fdpeb4zXsqa8GmZmB/ozbYMlBj4eKk/1LWXPfexCDgIs410iDI6yLwG/iYjwiD1qNvAXXWVfEkpJhpQDiiYT8+OI/4fFmFCUpFQxQ2b3famQj3nUc4aN519aX1ylM6nZZoJ5RP3FPcAftfbfl2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305589; c=relaxed/simple;
	bh=uliq9ezvmb7n2BG9G47QqLsuQ1398hL5jepMXHgC70E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Y4OMNcGnXfbLM0q/WdKhIzkMzgSn2XRJ+s8RYV278McddRPcTqM3Oxwkz0SqFvumPoRZM19ZDuH66WP72uazCO5aRZrN8L7A42cIjPVcYtg6Vp8IPvQC2/KQGGXaH26eVNTHmXTsrKX4xibB7wopHYtdy9Xyk4ddcrzoJ+jdNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBZLLVaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBZLLVaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777305587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4jo9b/gzVft3BH7SsAUnNAYZzWHIl0K6kwIs8iNHtI=;
	b=TBZLLVaXaAMhLY3nZoL86UCF2zXU+Mx3F7XLgzKKieZu7Mu3sR4ItNFuZFRFX9X/8iMN/s
	WMAx4ZORrk74aNrk9zCjsieGG5miEhmmLY6NXPiJ7AOpc3lKx+rBZHwxtGC3lvSZZbA4SW
	d4x03a5PDQPH1XnvNcaQso3XKiWJeUU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-HseM0GwBOC-soT04sCuOkw-1; Mon,
 27 Apr 2026 11:59:43 -0400
X-MC-Unique: HseM0GwBOC-soT04sCuOkw-1
X-Mimecast-MFC-AGG-ID: HseM0GwBOC-soT04sCuOkw_1777305583
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E0701956089
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD69D300070A;
	Mon, 27 Apr 2026 15:59:42 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.1-rc1 2/4] dlm: add usercopy whitelist to dlm_cb cache
Date: Mon, 27 Apr 2026 11:59:33 -0400
Message-ID: <20260427155935.2415989-3-aahringo@redhat.com>
In-Reply-To: <20260427155935.2415989-1-aahringo@redhat.com>
References: <20260427155935.2415989-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n1Zdyj_3bTVGtJXzo3Z0e1sIjx6mb-ahz5seYuqlFqQ_1777305583
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

The dlm_cb slab cache is created with kmem_cache_create(), which
provides no usercopy whitelist. When a callback carries LVB data,
dlm_user_add_ast() copies the LVB into the inline lvbptr[] array within
the slab-allocated struct dlm_callback and redirects ua->lksb.sb_lvbptr
to point to it. copy_result_to_user() then calls copy_to_user() with
this pointer. With CONFIG_HARDENED_USERCOPY enabled, this triggers
usercopy_abort().

Switch to kmem_cache_create_usercopy() with a whitelist covering the
lvbptr field.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 5c35cc67aca4c..ee55994ce90d8 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -48,8 +48,10 @@ int __init dlm_memory_init(void)
 	if (!rsb_cache)
 		goto rsb;
 
-	cb_cache = kmem_cache_create("dlm_cb", sizeof(struct dlm_callback),
+	cb_cache = kmem_cache_create_usercopy("dlm_cb", sizeof(struct dlm_callback),
 				     __alignof__(struct dlm_callback), 0,
+					 offsetof(struct dlm_callback, lvbptr),
+					 sizeof_field(struct dlm_callback, lvbptr),
 				     NULL);
 	if (!cb_cache)
 		goto cb;
-- 
2.43.0

