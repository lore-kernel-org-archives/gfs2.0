Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CB2D46DA
	for <gfs2@lists.linux.dev>; Fri, 25 Jul 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449131; cv=none; b=r8C0rNUxxTh6psC26asVYDiPmsRw2yDWHdEGjSO5Bvgrj1P5CB4X0AqL54Ldx+7ly4Wm2AT4CHU1R/8fBxRBsKSIB2FUvcOhWxlDUGOT736bjQiBYgEaz1kDh0MPJemE8appN3DEdmtSYMKETH3G5aMxL8n2+ykSV3ggYAj9i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449131; c=relaxed/simple;
	bh=QI3P+Uip4+NKZtJcxfa7Kl6tdDiNRYaLM/2YpNI5h1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=JZho8prsqCtZSnEd807vuhKpDXFggyqEsZES3ARIRSzjgfm1vForyQqjJ7XHgei3AX6CtRLEX4XVXdayDNspI4yTgAppKOjvxE2k5aMyVeo7gTOvJEIeyRQJA/+6pHv4kg2i8hp1bAOKhBb6ExckcNQjZfl59MiNh8+7nHszrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUjEbZw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUjEbZw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753449128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1WmxjtkOHxDvd0ObNzMLIJwUFp7ycmnx1fORgYpR9cE=;
	b=YUjEbZw15lI2xpBta2M+C/j8TNojZkBCgE5yFPqcx+4ldC/eBuXmvSuevrSB8dBVMc7Aen
	t8wvo7awV+C/42AW/o0AZ9lFyzDKe+Pzk+fW8Ks2llGgdKHUUgANSIu/+bsx6iAmxvYNyA
	fNAVVFP3yfGLs5TQBsfuygt3edsoWXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-bJTbsMV1Op-AflZqnUtpkg-1; Fri,
 25 Jul 2025 09:12:07 -0400
X-MC-Unique: bJTbsMV1Op-AflZqnUtpkg-1
X-Mimecast-MFC-AGG-ID: bJTbsMV1Op-AflZqnUtpkg_1753449126
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C983180045C
	for <gfs2@lists.linux.dev>; Fri, 25 Jul 2025 13:12:06 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.226])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A48191800D89;
	Fri, 25 Jul 2025 13:12:05 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Remove unused GIF_* flag
Date: Fri, 25 Jul 2025 15:12:04 +0200
Message-ID: <20250725131204.111546-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oC8xGMOPoKOuYaZSes7rzEzP5tADpyBaO4JefVLn868_1753449126
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since commit 38552ff676f0 ("gfs2: Fix and clean up create / evict
interaction"), the GIF_FREE_VFS_INODE flag isn't used anymore.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index d4ad82f47eee..e3a8a28acb99 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -376,7 +376,6 @@ struct gfs2_glock {
 enum {
 	GIF_QD_LOCKED		= 1,
 	GIF_SW_PAGED		= 3,
-	GIF_FREE_VFS_INODE      = 5,
 	GIF_GLOP_PENDING	= 6,
 };
 
-- 
2.50.0

