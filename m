Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279728BA8C
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422540; cv=none; b=tHtoAWtQGwgFN1jMAD6f4WSuCL8YUDxPICTfzS2+n0vhT26B4p6r2BN+YEBvPJlarx5SQk483RvWrCjLCwkD7nhgcEQRKwnsEnQ+0cIStrwb35A+txx97Gyt3q6VEyV/4aH2ShJcPW6oh2Jli3XVJdGFv9gTmPZIzXBGZjlAYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422540; c=relaxed/simple;
	bh=pfmMrPu0nzrNsD4InjIq7jrEfWwTbXNNUYLYujB0bTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=B84iv+SQSItxBlJD2BcpHOWyqXoc5bfJVPqfTHBtXevNgmwUProfI9iXQwVDMWSvSOaCuIztbVOAAvTeM0u68jPv4z6Wu2zAADMLqCZ9sFWvWP2DECg7V05mFBs8hkcmybDiBUJPGHVxox+7efRCoPmSpGiyVLNbvYBfpazmxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+7/RO/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+7/RO/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745422536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=73egXBpacwTeemc6EI3hJSxxV65hYhyvoGxv9s8KRUU=;
	b=S+7/RO/Dwor+Sr0uH/vEJ2oGVFnC2dlbF75SNfz4snDV8Rqnnce7eov4T8OY2U48IcfWPq
	Zoj+pijVi+DQGK1Dmcp43G4eXgRHw2eTe4pwMhOyQcAqRpjrWokPLN/JvL3ASXvM6qyH1s
	RXKMvuyMcpyulwJBp4CGtqt5CDhtoxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-3EDbS82mOM2IvZmElI3sug-1; Wed,
 23 Apr 2025 11:35:34 -0400
X-MC-Unique: 3EDbS82mOM2IvZmElI3sug-1
X-Mimecast-MFC-AGG-ID: 3EDbS82mOM2IvZmElI3sug_1745422534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06ACD1800374
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 15:35:34 +0000 (UTC)
Received: from b.redhat.com (unknown [10.42.28.212])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A7C7195608D;
	Wed, 23 Apr 2025 15:35:31 +0000 (UTC)
From: Andrew Price <anprice@redhat.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH] gfs2: Fix usage of bio->bi_status in gfs2_end_log_write
Date: Wed, 23 Apr 2025 16:35:28 +0100
Message-ID: <20250423153528.251736-1-anprice@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZX5OWVAbSMt5tNOJOtu1Hnq1smjNKiaAr3lzeMbFdfc_1745422534
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

bio->bi_status is an index into the blk_errors array, not an errno. Its
__bitwise tag is cast away here, resulting in a sparse warning:

  fs/gfs2/lops.c:207:22: warning: cast from restricted blk_status_t

We could either add __force to the cast and continue logging bi_status
in the error message, or we could look up the errno in the array and log
that. As sdp->sd_log_error is used as an errno in all other cases, look
up the errno here for consistency.

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/lops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 0fd3b5ec7d8cc..a1022635abc98 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -204,9 +204,11 @@ static void gfs2_end_log_write(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	if (bio->bi_status) {
-		if (!cmpxchg(&sdp->sd_log_error, 0, (int)bio->bi_status))
+		int err = blk_status_to_errno(bio->bi_status);
+
+		if (!cmpxchg(&sdp->sd_log_error, 0, err))
 			fs_err(sdp, "Error %d writing to journal, jid=%u\n",
-			       bio->bi_status, sdp->sd_jdesc->jd_jid);
+			       err, sdp->sd_jdesc->jd_jid);
 		gfs2_withdraw_delayed(sdp);
 		/* prevent more writes to the journal */
 		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
-- 
2.49.0

