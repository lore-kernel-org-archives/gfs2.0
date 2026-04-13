Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C703CAE6E
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091944; cv=none; b=CdRYkm7wirCW/mRoiypL/ccmJB6lSQ3hwB4pJQsrggXjS0NxYwNNMjv5XNTiuCGy8RnKsH7BWm842JWQT4wNkYySsilQtB1x1aZguob/zBzwshANixzq3EkmdqHhnyt0WVtjdq3S52Pc6Z1qgSgJa22SAdGKP3U6r4LwwY1+k20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091944; c=relaxed/simple;
	bh=jPBYi0lQaISsj4gMzyUww6AvglT+e9dCCKbUqnvoeGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QuqNQS+YH7yR1lwXmHxfkh4Chh5vr/N0/NxMoY/ViGBZF+8NHXpIAqRY7xXi0A0qb1mnYdoyWfOUWPKbnsbXR8J5Ex5ehdHOd1LD54EGkxMZZFjHGWhp3X8RnlMR+IERQXjbuEM0juurTyo9v9q3JBX46oJyzOXUeZAXjAdiipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Idbx4oRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Idbx4oRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RO/ZYSG1eiaOTfSd94w5xyipvPx4si+9s6qbsM7lBo=;
	b=Idbx4oRxUliQcmVSnXNh3VJCzaVeU0vCqMyMNxh17S/k0lvNDnbgO7mnlUVgG5dKnNyDLT
	l0vxP8Ol9aHUwFuWFawuYXxyy9PPzdocAGV0hVAGFDkTAi0WRkuNifkPN84hzNo32s7/Ec
	Js5CUZXrzZC+VmSbAIbPhd5uE2PRXMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-A9EwHLX5NC2qLl9zSf_Ylw-1; Mon,
 13 Apr 2026 10:52:18 -0400
X-MC-Unique: A9EwHLX5NC2qLl9zSf_Ylw-1
X-Mimecast-MFC-AGG-ID: A9EwHLX5NC2qLl9zSf_Ylw_1776091937
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6B5A195607E
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:17 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9AC819560AB;
	Mon, 13 Apr 2026 14:52:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/18] gfs2: Remove unnecessary check in gfs2_evict_inode
Date: Mon, 13 Apr 2026 16:51:55 +0200
Message-ID: <20260413145211.881752-3-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qJGBExzURCB_knLOsfQ2l5Ng7LpckIbOxcjvrKXKCbo_1776091937
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We are no longer using LM_FLAG_TRY or LM_FLAG_TRY_1CB during inode
evict, so ret cannot be GLR_TRYFAILED here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index d96160636161..fd8eb9e15719 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1420,7 +1420,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (gfs2_rs_active(&ip->i_res))
 		gfs2_rs_deltree(&ip->i_res);
 
-	if (ret && ret != GLR_TRYFAILED && ret != -EROFS)
+	if (ret && ret != -EROFS)
 		fs_warn(sdp, "gfs2_evict_inode: %d\n", ret);
 out:
 	if (gfs2_holder_initialized(&gh))
-- 
2.53.0

