Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75C34041B
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256896; cv=none; b=eTfChhV/3YbQIld4uHHiPhIId8zkKyJXgsi+7L9K1gVUjssjkGrMpv0mbgPPFlC5/8as+2v94hWdsgmZyS+RETrUIZMbo+JLr2cys4bMhrfr7n1ZF/LnI6LRNgfpyHc7USHf9mbajjCiqhfc+6EjXhEmGf+MmC95BO+T1U4AxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256896; c=relaxed/simple;
	bh=h43SupSyGiWpYve5+dTnum+YvuJh7v7mH+hMvZ1vSho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YzV2X6RmvaDR/FGdFFKnRjsQFeIGp1Je8qNSxFjPUF+RUe0wwTWRrOrr5tJtImQqwSys7yh2/Xtq2l6jh9afvgEAdDmscjeEgU0A1EbVE752Cw7caWjslPIno77U8vCc9T7llzuNLU7m82h5f4yU1DeFtpgADR98Up27tm2eScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeTJfqFa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeTJfqFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785256894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rBOBeD6eqcZgb1535Xbm/mLgkj0tNbqvMO6douXuoY=;
	b=VeTJfqFaj0WGgFNuxM4gzWeiWmR75DeBEBIu2Mri4w7HpTl21uTGfPZm+apuX4Zv/y1pOJ
	L0gAkirwXEDhV9PIvr5k8FrWiyGgOsVo/MKeztIpXa+Rn4q1NPBQtc7BsYy4m4bsddU5HY
	PUCm12GP+VqZhsJ7PSplKQo04CZu+u0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-il2mSdvWO6KDPqD4yhzPhw-1; Tue,
 28 Jul 2026 12:41:32 -0400
X-MC-Unique: il2mSdvWO6KDPqD4yhzPhw-1
X-Mimecast-MFC-AGG-ID: il2mSdvWO6KDPqD4yhzPhw_1785256892
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B41FC195608F
	for <gfs2@lists.linux.dev>; Tue, 28 Jul 2026 16:41:31 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD779300019F;
	Tue, 28 Jul 2026 16:41:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/4] gfs2: Enable automatic glock hash table shrinking
Date: Tue, 28 Jul 2026 18:41:21 +0200
Message-ID: <20260728164127.791843-2-agruenba@redhat.com>
In-Reply-To: <20260728164127.791843-1-agruenba@redhat.com>
References: <20260728164127.791843-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JcJG2IV1wsRlJ__bK_genBLu4U4opibRxkJBIAU3YfA_1785256892
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

All of the examiner functions passed to glock_hash_walk() can deal with glock
hash table resizes and the resulting repeat visiting of glocks, so we can allow
automatic glock hash table shrinking.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a73b..0a93824424d5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -78,6 +78,7 @@ static const struct rhashtable_params ht_parms = {
 	.key_len = offsetofend(struct lm_lockname, ln_type),
 	.key_offset = offsetof(struct gfs2_glock, gl_name),
 	.head_offset = offsetof(struct gfs2_glock, gl_node),
+	.automatic_shrinking = true,
 };
 
 static struct rhashtable gl_hash_table;
-- 
2.55.0

