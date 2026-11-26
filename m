Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733062;
	b=A5cM34LhBeaTsy3pjTraKZSVh3D77qndW76x2fATBxVoOgtGomw+9Pp+rr6W4EhWWqkQ
	 Y0M94MmrH8qny33IDofvcQErCLg0d6V8qfWy1brhrk8qz07hI7guk2w79jcNu4LqZR6mR
	 9cVcHHkSAWqTdFgoHAHuH912nHmcNYKCeXyhQzSKhhFJHBbVAHycNjob78ndemBeMsLnE
	 wrQudsS6l6/qOstHN2Guhgpv2GaMFoWbPRHtH3sFvCUrGhdr0yc8OPdeKAhTDPhVnVOvr
	 p2Gz/B10azHHBjkkjUMWh7AmlLfThtPLsTbqppvwzIiJ3qIqLoK+WgA7EVaLfCtPUGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733062;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=tPLV8B4YEouOUvpVNdOnUw4VOSBC1dyErDRYoclHJwI=;
	b=C9f4LxsRGDy0tAIhUZOzY1ln3/aBfk2++kxyJNXPNE2lrnlkjZU8COxbROABmb93ZmOJ
	 FWnDw05CQMKt9IGtM3MLNy8Ae0eQ1RjSzwmHTilDwvJnp2CEYDk0QXcatAs6TDf6U+4fC
	 8DR0PNS7P3b1npEc3s6Y39Xr7A+vliE7TeZlgMmquEj+yNXa8EEN8xKiNZxH89xXMde5r
	 H9qHAiGOggEyRqQV1xPvd04g8QQAROWFke5s0EsxbAhH7tFafBLpCNvSw4Vy6K14bUdTv
	 uuaKOZq+d2DEVPSlqxL2OYrB/b4EsFbwjov62xNCr30IJ4mN1Hy1y+GIjll+WasUL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jG6o+4L7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82D606A31C
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 22:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C82D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jG6o+4L7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795733060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tPLV8B4YEouOUvpVNdOnUw4VOSBC1dyErDRYoclHJwI=;
	b=jG6o+4L7Jhew5fEG7h2XSqOfPB7MgAQ0eeA4YIRAVDYBvkSV4CpIz8X/xan0EoyxvCayad
	18XZ3cypO65cFKHS8s0JktvU4am2RsiBPCAXowAkjeVdb6haKt1FYejopLasgfKLTB9nnO
	XQ7GidUXFXD9XIdROVRCJyzhG+PEobo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-7Y8wd2D3OrGR5yyshCTsQg-1; Thu,
 26 Nov 2026 22:44:18 +0000
X-MC-Unique: 7Y8wd2D3OrGR5yyshCTsQg-1
X-Mimecast-MFC-AGG-ID: 7Y8wd2D3OrGR5yyshCTsQg_1795733057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EB081956049
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 22:44:17 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 974421800286;
	Thu, 26 Nov 2026 22:44:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: wait for bio in gfs2_write_log_header
Date: Thu, 26 Nov 2026 23:44:15 +0100
Message-ID: <20261126224415.3049791-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d4nYDMH--NvXHX5CP8doQXr0f_pnPL-Y4GvxInkEKNI_1795733057
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

During journal recovery, clean_journal() calls gfs2_write_log_header(),
which allocates a page from gfs2_page_pool, puts that page in a bio, and
submits the bio.  If a subsequent step in gfs2_fill_super() fails after
journal replay, or a read-only mount that replayed a journal is
unmounted (where gfs2_put_super() skips gfs2_make_fs_ro()), the journal
glock can get dropped before the bio completes.  Also, if the module is
immediately removed, gfs2_page_pool can get destroyed before the page is
freed.

This very unlikely race was pointed out by Sashiko.

Fix by moving the call to log_flush_wait() from log_write_header() to
gfs2_write_log_header().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 1baaaf30c4fa..db40045ee2d0 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -908,6 +908,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock,
 		       REQ_OP_WRITE | op_flags);
 	gfs2_log_submit_write(&jd->jd_log_bio);
+	log_flush_wait(sdp);
 }
 
 /**
@@ -935,7 +936,6 @@ static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
 			      sdp->sd_log_flush_tail, sdp->sd_log_flush_head,
 			      flags, op_flags);
 	gfs2_log_incr_head(sdp);
-	log_flush_wait(sdp);
 	log_pull_tail(sdp);
 	gfs2_log_update_head(sdp);
 }
-- 
2.56.1

