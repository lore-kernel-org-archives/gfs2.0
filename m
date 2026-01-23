Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237011FECBA
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182285; cv=none; b=cUKmJdNqO1JX6rNBRKWy4wqqT0QHPqbghNRp4D839QjC3ljaWAnHc9Xa8rOgYJAvBJmZUXfHq8QaEmU3obyJDDc/9cTXhBEcAlxbZVInb4k0nsczqWqC5YDN4m9t+7VlOovEkRRSXys7c8xEk5VQGILdkHKbdIlv+AcdVXgmHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182285; c=relaxed/simple;
	bh=TNF4wXwFUssA581QQv8qW0H721ykoei9D1PpPPu2xNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tMKKAyt0uA0AV0vWGr8RaiDjidKMDZJdwvP3Dg2o8yv9rtsyAxR6mIDYOpoOE/3WP2Ekgd+jAVetp5qfs2O4/K/BAPb6SEzJjawB0ufBrYdgq1YURXygIHTaHxB0oVXmuRg9uN8KuTlCXDK3SWewmLCvNDhGrPWMNIs4nmfT768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yj9cudQt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yj9cudQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6otsXpjMDtRHx6VffWCkmUirg3lRCTca+MjStrypEEw=;
	b=Yj9cudQtatwmutjLbfEjFhAgSojUSSx6obU46xFPbGYziu+HoSRRc5VJpCToXlXjftpS6H
	IfR9bt+rUof8DS4nOXdMeDa9ty0m46pg/1t285D8eLUdejvidAHoCNFXnddJvMy8DtuKl7
	ZNjRcf53eHpr20Az4Mo5U4TC6rsbLsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-0e8s07xvPXW5KFliEBC0vg-1; Fri,
 23 Jan 2026 10:31:22 -0500
X-MC-Unique: 0e8s07xvPXW5KFliEBC0vg-1
X-Mimecast-MFC-AGG-ID: 0e8s07xvPXW5KFliEBC0vg_1769182281
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3463719775AA
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:21 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E6AC30002DC;
	Fri, 23 Jan 2026 15:31:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/13] gfs2: Fix gfs2_log_get_bio argument type
Date: Fri, 23 Jan 2026 16:30:59 +0100
Message-ID: <20260123153105.797382-10-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3U32mfFQxttrfkf3a1UV8ySAq8I9HQvPQDWuPHjYEYk_1769182281
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix the type of gfs2_log_get_bio()'s op argument: callers pass in a
blk_opf_t value and the function passes that value on as a blk_opf_t
value, so the current argument type makes no sense.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 879635ebddae..df7916bf49c1 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -277,7 +277,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
  * @sdp: The super block
  * @blkno: The device block number we want to write to
  * @biop: The bio to get or allocate
- * @op: REQ_OP
+ * @opf: REQ_OP | op_flags
  * @end_io: The bi_end_io callback
  * @flush: Always flush the current bio and allocate a new one?
  *
@@ -290,7 +290,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
  */
 
 static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
-				    struct bio **biop, enum req_op op,
+				    struct bio **biop, blk_opf_t opf,
 				    bio_end_io_t *end_io, bool flush)
 {
 	struct bio *bio = *biop;
@@ -305,7 +305,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 		gfs2_log_submit_write(biop);
 	}
 
-	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io, op);
+	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io, opf);
 	return *biop;
 }
 
-- 
2.52.0

