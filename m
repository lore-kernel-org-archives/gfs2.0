Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795734037;
	b=C9f0vHqTnEhnn2J6cXS6eTTAWlAXbF5pWuyM6uapleiuWcUsbkgHCeRLIHFizeoVKSO6
	 ZPsQY+14jVtf6wePTwaOZy2i/rScFPPAo5CEKG6AXuyi2BEwRDUeZlJpQRXpcAWqraa55
	 KLnYZ2L4UwMwnjdy8u6G0Px2s3NFzyOUy+454XUQAO4BsJ394YcTzIboL6c/1Mu+avQrc
	 F/HCqmuVis4EviJgfpbyAWfW2Z92Xkll6HFje2QnClUxDRM/sPB6elyKH6yPOLWP6APzy
	 9m7T8Fsdb1EaPzPyaVOvvNVXZbd6S8BhvQAGE6EccY9D0G5nnVSGyfWMgbW5K2Py7ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795734037;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=KesKPOx9CVPBYAtfT99r4GUlMvmgp/WWj7+oODIZU9o=;
	b=N5i9cohhfh8xo9dPhk7LLMytyJaby9HmuePTBEJvPTuYpTndswLfe+GJzUP3uxxpKVsR
	 oFHbQQER5/U16Zd0S2aaHPkXocKKZCPbz9kKTDRJs8ir5ymqvlHsdvBc/1BoHIJ1GjfX1
	 y5HZBIAkH/iUBjLcGxDhpPRyX2T6+amldN2g8UFiTp/vpsTN4km1ikj3yJs7YD7+kCBug
	 vklY4074rH6JxB1FK8BaB7YsCkvcSLDEuImVzpL7DpZSs+j5lUggo5Ebc+EN2+n3Im0f0
	 UYBpeWoc5wSa++dQ9jcTXrkwgS/G8ZbWINtfCzDLAbPtmgdOEnQzZIXHJTnpLiUwaYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UjlI+tgH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC4606A321
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 23:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61FC4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UjlI+tgH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795734036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KesKPOx9CVPBYAtfT99r4GUlMvmgp/WWj7+oODIZU9o=;
	b=UjlI+tgHNl18QSCyOlOXtnJq9DrsQRgWbVVBI/BnazjaAYSWAasYbfnR143dW1ZYn3xS3g
	qTEZNE+BkobibjHZK7Tyr4r3w0VsowhUYUuZimJjk8f67ulv9SNWK6NzVFSLF52wdpqjgy
	DaNknFk3Z8hso9mehA7F95jYcYYeDMU=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-pC4HNJO8OYiZUF0jq57mYQ-1; Thu,
 26 Nov 2026 23:00:33 +0000
X-MC-Unique: pC4HNJO8OYiZUF0jq57mYQ-1
X-Mimecast-MFC-AGG-ID: pC4HNJO8OYiZUF0jq57mYQ_1795734032
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FB3F193FA80
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 23:00:32 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7788A436;
	Thu, 26 Nov 2026 23:00:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: free page leak on gfs2_write_log_header error path
Date: Fri, 27 Nov 2026 00:00:30 +0100
Message-ID: <20261126230030.3056456-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ijWxwWPD1uHgd8-O7NwFGNwVT6BBHvfpugoG1kuYZc_1795734032
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When gfs2_get_extent() fails, gfs2_write_log_header() needs to free the
page it has just allocated.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index db40045ee2d0..d6876d2091c9 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -877,8 +877,10 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 
 		extlen = 1;
 		ret = gfs2_get_extent(jd->jd_inode, lblock, &dblock, &extlen);
-		if (gfs2_assert_withdraw(sdp, ret == 0))
+		if (gfs2_assert_withdraw(sdp, ret == 0)) {
+			mempool_free(page, gfs2_page_pool);
 			return;
+		}
 	}
 	lh->lh_addr = cpu_to_be64(dblock);
 	lh->lh_jinode = cpu_to_be64(GFS2_I(jd->jd_inode)->i_no_addr);
-- 
2.56.1

