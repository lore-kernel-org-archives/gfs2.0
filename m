Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC1342538
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857602; cv=none; b=OtmSv5MqqJbVnwBJTbrg6EkC1iz636rfGlqinUK7BvmDOfi+T+e1s+9iaZA9HdoqzewZOKbM1TI9R39y82OFfNvES+BXAo5cJ/R2Zt3ps1r4MZu8Bhs3fqnhwFvTJGONL6bNs2amuiifab0+lJgTpZ7Te7zRssr5eL8qo7Ly0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857602; c=relaxed/simple;
	bh=WGI8yShIQFtngZiHHDP1OgooBbekYi8XO9/jsatp7IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Lrrvkxk0lJ0dmPzvgJhlDrBIEguAuOGFelbzzUoqx1K4TLvSg326swV1CVh4amL6kq+7DzDeNfkVtDxg+qwFtJAccQmED/MbdIkKhh0rVT9Y52Dx/W+NQFv6AlbkPpS1etx203mLE4f0wSqx8FepuwEktczDoGS+/0FyYXOUTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4Z2nDFS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4Z2nDFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787857600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ns4y4hW9Nk6XNaVogI64EzW6ovRZ8GH1JBumlPIe7ZA=;
	b=B4Z2nDFSIrt8eGlVoVBVaxeAUTRaQb1oVzYXg8oeIQj2HjvMIKx+YIOrgGuIbjWU6tP5NL
	AGFaooDLklqeKDAo5MGXIAUfX4Oci3Dr+diyCs+B3uZ0PdD7iuxHk6e6jj2l9vxlMPwQUx
	1gvLt+B2W+F9Uhdxu0kCCp8+EtZ6558=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-5e1qk4PvOQy9R59yD_EqKQ-1; Thu,
 27 Aug 2026 15:06:36 -0400
X-MC-Unique: 5e1qk4PvOQy9R59yD_EqKQ-1
X-Mimecast-MFC-AGG-ID: 5e1qk4PvOQy9R59yD_EqKQ_1787857596
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B49C0195606F
	for <gfs2@lists.linux.dev>; Thu, 27 Aug 2026 19:06:35 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D57018005AD;
	Thu, 27 Aug 2026 19:06:34 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gf2: Do not dereference sdp->sd_jdesc in status_show
Date: Thu, 27 Aug 2026 21:06:32 +0200
Message-ID: <20260827190632.686583-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vr98aU9fphbwODiKlVvVivOYoKC5cjKnSYZsPV5BErc_1787857596
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Do not dereference sdp->sd_jdesc->jd_jid in status_show() to prevent a
potential NULL pointer dereference during filesystem shutdown.  Instead, get
the journal ID from sdp->sd_lockstruct.ls_jid.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index ea2c7b9e4a77..eecd4e7b12f4 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -99,7 +99,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "sd_log_thresh2:           %d\n",
 		     test_bit(SDF_JOURNAL_CHECKED, &f),
 		     test_bit(SDF_JOURNAL_LIVE, &f),
-		     (sdp->sd_jdesc ? sdp->sd_jdesc->jd_jid : 0),
+		     sdp->sd_lockstruct.ls_jid,
 		     (sdp->sd_args.ar_spectator ? 1 : 0),
 		     test_bit(SDF_WITHDRAWN, &f),
 		     test_bit(SDF_NOBARRIERS, &f),
-- 
2.55.0

