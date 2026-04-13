Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668283C9EF1
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091964; cv=none; b=E6Z4bNcoohm8HET11c5fr0si7VYAV0NsSCSq7H8sS9lQZ9/59J6XNUcm6kOOVs1Lp4jEovVrX/eg5YAzzI6VdHZzMqZNAyBrhBzN78aWnKXFQUSj1oRQXfSAlIJvVPD2bfJgUZPD9lmh3xSqzJsoYTmAivTTOa+7Q1TSxVMBSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091964; c=relaxed/simple;
	bh=L7q4lqLNraxR2WMeeg6kdNnWspqih69Fa5c0UV+PV70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AYB6NJQHTwZkW7UG9KrhIa/GI+CdokF3kCd66JDJ/d+QfkzfBlcBQBeVtO1Wacs90tyMd8NGzFwyynBTBKVbXfVwPiQz7Dy0a4mHHDKBG740Z2pA8z6Y1dxsIqJNlN+D1Ttech7ZgLUXAt1ojz1bM1fOsmGKuatVXHOJ/WdKcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PawKxA91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PawKxA91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwtQS+j+rYAiG/WZSitGpQo+KxEgaL+WkvXFyBFe3Ng=;
	b=PawKxA91D8AlN2OTwghKPAcZWeeZDm/GTT+IVI4rqnGshGBt6A79k1YYn6w89ckP6373h9
	mn/3WJ3HJiPr06su+H1fG5YjSqHv6PItSVb0jv4/wtYu+6jynpwUX3ApQEpTE35zjB5Foy
	ykfN+IAuBTcnUglNk+8hXOOzwtZnujI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-w1bGzDwDMPq8c1OfYX47Mg-1; Mon,
 13 Apr 2026 10:52:40 -0400
X-MC-Unique: w1bGzDwDMPq8c1OfYX47Mg-1
X-Mimecast-MFC-AGG-ID: w1bGzDwDMPq8c1OfYX47Mg_1776091959
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7287318011FF
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7580219560AB;
	Mon, 13 Apr 2026 14:52:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 17/18] gfs2: hide error messages after withdraw
Date: Mon, 13 Apr 2026 16:52:10 +0200
Message-ID: <20260413145211.881752-18-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: aIX3uuzy6ZR0Ya7umDoiD0TfNHQHf2USgWdv981Ns4k_1776091959
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_evict_inode(), don't issue error messages once a withdraw has already
occurred.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b0b0bc5c9d20..938d271ae226 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1483,7 +1483,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (gfs2_rs_active(&ip->i_res))
 		gfs2_rs_deltree(&ip->i_res);
 
-	if (ret && ret != -EROFS)
+	if (ret && !gfs2_withdrawn(sdp) && ret != -EROFS)
 		fs_warn(sdp, "gfs2_evict_inode: %d\n", ret);
 out:
 	if (gfs2_holder_initialized(&gh))
-- 
2.53.0

