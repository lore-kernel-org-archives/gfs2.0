Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC16186E58
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012389; cv=none; b=IlJN66Br2epciPMRQFaUiSrVF6I8rPfO5RxM9HGbXNufSvvHKswsvBg+hllJ+JtCC0Ku3cFN5hcv2KTqAcX11YaIBaNJG9ZgkI4Hfojjpnjyab4lDQCw4cPLHKuACjDI4sM/2Xp35cJC32OkuYU7gThNZEbARBsXl21CF0b9brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012389; c=relaxed/simple;
	bh=5TEV30r84qHvNiYsToRwLa1yP1wuy1XrjYnv7PoJAvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLC0h8wYC/qkFLWlw4lEYJ2xEszDgxIs9Dzd7EZhvP1y6yGm0IR+v2DXrH9qdZMFLdegqsiy6EWzj+U0qCzd8V+2HuxNFNhvPQvnwQpeAuz7UqYjM8FSvhcDqFsqW4ggCjGu7B2SFecZlK6PQsQPKsAm+ob3R6+MloFd1S0j0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuULpclW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuULpclW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731012387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmgBKvWsP7rBKI1MhaCrkU+yVJn/SH6pEpBWl/E4/Z4=;
	b=PuULpclWv832SUSfdNMFhNYoksVJvzGM39zyNNKNFh6/9qByahjgx6IRLf5w2Fh5mgcGjt
	NUilB6VQW+TjD5bQi/F77iR75HvNPx4OKo7GnlVFvbi9U9n+weGYHDyNM/B7oUEEDwSZjl
	Ley1ZTaFZc+J/FsGFJtQJNSt31u00/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-JALrQ8s6N-iQRbDee1sTOg-1; Thu,
 07 Nov 2024 15:46:25 -0500
X-MC-Unique: JALrQ8s6N-iQRbDee1sTOg-1
X-Mimecast-MFC-AGG-ID: JALrQ8s6N-iQRbDee1sTOg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3125195608A
	for <gfs2@lists.linux.dev>; Thu,  7 Nov 2024 20:46:24 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AD33300019E;
	Thu,  7 Nov 2024 20:46:24 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 04/11] dlm: don't track references on move_lkb()
Date: Thu,  7 Nov 2024 15:46:10 -0500
Message-ID: <20241107204617.147842-5-aahringo@redhat.com>
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
X-Mimecast-MFC-PROC-ID: k8PcnR5gunFH1bJe1GjmiDMdhlBtaq2-3Izq4O7AqKc_1731012385
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A move_lkb() is to move an lkb to one statequeue to another. There is no
need to drop the reference and add the reference again after the
move is done. Adding helpers for statequeue that does not track
references so move_lkb() can use them.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 42cef3d2af47..378234b42593 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1637,10 +1637,8 @@ static void lkb_add_ordered(struct list_head *new, struct list_head *head,
 
 /* add/remove lkb to rsb's grant/convert/wait queue */
 
-static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
+static void add_lkb_noref(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
 {
-	hold_lkb(lkb);
-
 	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
 
 	lkb->lkb_timestamp = ktime_get();
@@ -1671,17 +1669,28 @@ static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
 	}
 }
 
-static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
+{
+	hold_lkb(lkb);
+	add_lkb_noref(r, lkb, status);
+}
+
+static void del_lkb_noref(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	lkb->lkb_status = 0;
 	list_del(&lkb->lkb_statequeue);
+}
+
+static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	del_lkb_noref(r, lkb);
 	unhold_lkb(lkb);
 }
 
 static void move_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int sts)
 {
-	del_lkb(r, lkb);
-	add_lkb(r, lkb, sts);
+	del_lkb_noref(r, lkb);
+	add_lkb_noref(r, lkb, sts);
 }
 
 static int msg_reply_type(int mstype)
-- 
2.43.0

