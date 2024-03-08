Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEE40849
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914708; cv=none; b=LmZ3O4jQg3SmY+jxqv7AeWqWVfV+zMsejUoJvATSP9+A/3iYDsw+M3G3l0EfSgN3KmxHnZWzcWT98WiB9JgGGUvGcUw2kc7+spatXs/9DSaRiWzRyZCV7dZGrC8MWJ5LNiOvY9fLWlgbL6ijjQk3J8iplVzrC1p6uonWBanD9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914708; c=relaxed/simple;
	bh=rHi3DnXEAbcCiLI+aAyrU0ANRef+XEfqAS0pDyIyJBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0cAFZmdlKBYB2oup0KIG+BVZz6C7fVHRPUZnofX0ZVcHgUZy61hmpVg93zKOOLOHrc4/09D3z+Hn9rL7oRXi4sfy6WKRyb+oiG+hJh2H5jZYGV/OVv7LviEXgwiFfCU4PxD63bVC6wwYoL83K0I/2ywfEMN8GgU3kdTsgkdWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LERSBf3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LERSBf3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709914704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoE8PNO04t3RtscPUElcgsXqmnl8hBRkpZ29nX9+mRc=;
	b=LERSBf3u4YR0Yny3irZzF2CZomsmQOUin29z8SK6eqk/rKOnUK6G6Q4/6YYagETsB/1X+k
	1fLAQRqgCMpkw3uyD/IU4fO63bOzKlJBcO4k+BTeXGPcEmPyxmB7WbRb/3+MCWyYUrWRyA
	XSjcsRh4D06yfsuUNaUO4BgjHVSeGEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-xLFtbPN7OGKUKBRlyCjsjg-1; Fri, 08 Mar 2024 11:18:23 -0500
X-MC-Unique: xLFtbPN7OGKUKBRlyCjsjg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F339D10189B9
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EACFD492BDB;
	Fri,  8 Mar 2024 16:18:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC v6.8-rc6 4/7] dlm: move lkb debug information out of callback
Date: Fri,  8 Mar 2024 11:18:15 -0500
Message-ID: <20240308161818.2388451-5-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-1-aahringo@redhat.com>
References: <20240308161818.2388451-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
index 76e1e3886076..ee9b27646682 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -107,8 +107,13 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 
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
 
@@ -196,8 +201,6 @@ void dlm_callback_work(struct work_struct *work)
 			trace_dlm_bast(ls->ls_global_id, lkb->lkb_id,
 				       cb->mode, rsb->res_name,
 				       rsb->res_length);
-			lkb->lkb_last_bast_time = ktime_get();
-			lkb->lkb_last_bast_mode = cb->mode;
 			bastfn(lkb->lkb_astparam, cb->mode);
 		} else if (cb->flags & DLM_CB_CAST) {
 			lkb->lkb_lksb->sb_status = cb->sb_status;
@@ -205,7 +208,6 @@ void dlm_callback_work(struct work_struct *work)
 			trace_dlm_ast(ls->ls_global_id, lkb->lkb_id,
 				      cb->sb_flags, cb->sb_status,
 				      rsb->res_name, rsb->res_length);
-			lkb->lkb_last_cast_time = ktime_get();
 			castfn(lkb->lkb_astparam);
 		}
 
-- 
2.43.0

