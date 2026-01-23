Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8219C553
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182281; cv=none; b=Zll332DYsM+B2E2GfN77uqA/DfU8R0MzF946IIYCABbUP2ybRmizhJZyLSAx23WJgHYIjFIcYmqpCUCR6ubFEm043ceDh7KzwKDhVeG4mWp0qWteL73uX4bjPYGwuzPtVuP0WRZD9sn21jw6ye0jKLgo5mwVRvugtAiA7gNtSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182281; c=relaxed/simple;
	bh=Qfseu9kA7i1NupyCpbD/vwawJSbjEOxONurOC5suXtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ognPLS2csJJH1oaIJzam4SLHgxk/vIWuPnj4fgSd95vAxoaYP3nTQ2jNqiI7hrCGBAMiq6j+M1eJG+wvAEOtzrg5cO7sdc5vA/vg8vCeQHZtLHRpNRpy/9xT9VH5BRddJEDMg4z8f15HHMSxCHu+9YW0b2lmSMNJp5Riw3AMO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTeCinbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTeCinbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNzto65/7huM3ydvebqfxF7J1JZ5kdaPqxrXxZPOa88=;
	b=YTeCinbqV/z0KXmJrxkwuAExbNlQpLQe0MCjJfP//OmhIsxHrTYGr7n+/IEdz80E+wfFnU
	gxwqQuB0FT2jG6WNRROI+kUtnobygU625I0/xvlpc9REU2MM8rje5m4y3EHd0HkYXeibJo
	TzbittUt/fVQPhPc0/P1/e0sRk9Ptzg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-cbs8WTDzPEiEvreFF5izOA-1; Fri,
 23 Jan 2026 10:31:17 -0500
X-MC-Unique: cbs8WTDzPEiEvreFF5izOA-1
X-Mimecast-MFC-AGG-ID: cbs8WTDzPEiEvreFF5izOA_1769182276
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B15DC193E8C3
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC62430002D1;
	Fri, 23 Jan 2026 15:31:15 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/13] gfs2: Rename gfs2_log_submit_{bio -> write}
Date: Fri, 23 Jan 2026 16:30:56 +0100
Message-ID: <20260123153105.797382-7-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: nLGewC0koM5ndKE7JaCbeWll07FQmwnO4dzh887GMRg_1769182276
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Rename gfs2_log_submit_bio() to gfs2_log_submit_write(): this function
isn't used for submitting log reads.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c  | 4 ++--
 fs/gfs2/lops.c | 6 +++---
 fs/gfs2/lops.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8312cd2cdae4..2a3b9d10eba7 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -889,7 +889,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	lh->lh_crc = cpu_to_be32(crc);
 
 	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock);
-	gfs2_log_submit_bio(&jd->jd_log_bio, REQ_OP_WRITE | op_flags);
+	gfs2_log_submit_write(&jd->jd_log_bio, REQ_OP_WRITE | op_flags);
 }
 
 /**
@@ -1096,7 +1096,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 	if (sdp->sd_jdesc)
-		gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
+		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index d27a0b1080a9..aa9e9fe25c2f 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -229,7 +229,7 @@ static void gfs2_end_log_write(struct bio *bio)
 }
 
 /**
- * gfs2_log_submit_bio - Submit any pending log bio
+ * gfs2_log_submit_write - Submit a pending log write bio
  * @biop: Address of the bio pointer
  * @opf: REQ_OP | op_flags
  *
@@ -237,7 +237,7 @@ static void gfs2_end_log_write(struct bio *bio)
  * there is no pending bio, then this is a no-op.
  */
 
-void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf)
+void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf)
 {
 	struct bio *bio = *biop;
 	if (bio) {
@@ -303,7 +303,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 		nblk >>= sdp->sd_fsb2bb_shift;
 		if (blkno == nblk && !flush)
 			return bio;
-		gfs2_log_submit_bio(biop, op);
+		gfs2_log_submit_write(biop, op);
 	}
 
 	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io);
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index be740bf33666..010a4696406b 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -17,7 +17,7 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
 void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		    struct page *page, unsigned size, unsigned offset,
 		    u64 blkno);
-void gfs2_log_submit_bio(struct bio **biop, blk_opf_t opf);
+void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf);
 void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
 int gfs2_find_jhead(struct gfs2_jdesc *jd,
 		    struct gfs2_log_header_host *head);
-- 
2.52.0

