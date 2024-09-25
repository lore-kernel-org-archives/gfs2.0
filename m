Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D4146A93
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301843; cv=none; b=UumEaNF7J/JPu7W2b0K4uXMxQMQJYnaUey4Nc7IxzkG9c3/oxQTBqH4nXcJeCr6egCtSknudx/YvVE6Z7qLvAMymSzwzj6ZnmkBHY3sgUpd72LGJRW+WlvnnLgoZ8Z55Gf+lcreLANLWpia2CfM4hdhPhuQRDeNZC/qZPJLiylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301843; c=relaxed/simple;
	bh=5aSDfZM6QZybL/Ba0n087GV8MSsd5h4fGKWVkUJP5tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKsEuiYN1kyhlsKVEm4moUAQOc7vHlm9W3K0NT83Xx1WiL83b/6dKves13f4zqVtC53O3O0N67TCM5ht8dCGz3g2PiTbot2BIHM/lDK3H2kfT9Cr/FnQSqOyeJcYTKZdX5zNRRm7Pz9xinKu2PELf6/2m8Xf5c0kSsXIav1Zy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJvtay9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJvtay9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd3QMK8jBH4fI7thLNhYC2SZtgN+BeH346AISCS00qk=;
	b=hJvtay9yvRIvNIx2GN+Szx1kdiiCyhgjeR9apHFc2fj+B0g+nxY1mFDfx3V0JxldxlVDr0
	B06VIPtq4af8GfQMRhvNwI+LbDMJMruBzM8RH1LBVK+6GjaAeNfbT/fFbIrDrGOopP+E5E
	a5Hr3zzF6KnVbsG31Gv8jGgy5CCGJ1g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-synAE00NMfS5b-I1yxoZyQ-1; Wed,
 25 Sep 2024 18:04:00 -0400
X-MC-Unique: synAE00NMfS5b-I1yxoZyQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD1A919772DB
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:59 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DC8F19560AA;
	Wed, 25 Sep 2024 22:03:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/16] gfs2: Use get_random_u32 in gfs2_orlov_skip
Date: Thu, 26 Sep 2024 00:03:25 +0200
Message-ID: <20240925220331.417856-16-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Use get_random_u32() instead of get_random_bytes() to remove the last
remaining call to get_random_bytes().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/rgrp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 539303129715..b14e54b38ee8 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1987,10 +1987,8 @@ static bool gfs2_rgrp_used_recently(const struct gfs2_blkreserv *rs,
 static u32 gfs2_orlov_skip(const struct gfs2_inode *ip)
 {
 	const struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	u32 skip;
 
-	get_random_bytes(&skip, sizeof(skip));
-	return skip % sdp->sd_rgrps;
+	return get_random_u32() % sdp->sd_rgrps;
 }
 
 static bool gfs2_select_rgrp(struct gfs2_rgrpd **pos, const struct gfs2_rgrpd *begin)
-- 
2.46.0

