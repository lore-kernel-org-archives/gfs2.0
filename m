Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E419C553
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182283; cv=none; b=AahSF2L9Q2e1JM8T4W59sABjxhr7Or9zvzjtDKoOW86tcFy7GIu0OclR1Oy4u8t2smvlzlJlIda1+mJEfmGtMym5OED6StdK9rs5r8KgLBLj331phONC4ReR2N2AJGe/qhN29W9tS5wJUAHypgLn5GHNh3rlMJTAfZ5X6ETvTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182283; c=relaxed/simple;
	bh=bDGchwHdpQYyENgk4vl4mWakb+/rN/DOQVEK2DIXw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mpzUteRzq0e9sExtIEVYww+HVQ8UBWJpB6q0H6Xjvv1G//T/RipP8HtdHa5bI0vtogPzVRHZaRM2hCfbRqQDXxeRiebibNPxK5KOaVOJS9MAVVBRfEuZOpZm0x/PIAhNSo+QQKYC26pOlQzMU4UQmRJVzM6S6Ex+P0FGfI/+d1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxxKlRGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxxKlRGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvFIfXXD74MaPCBa0O02ZaKdtzCXiU0Zy1obcOfo63o=;
	b=BxxKlRGgaDYEbAwMK5rYBh7GWEJWtowlqkaMcmN4Ksg68sEb8pk+4Lh6wErc9ZTXmBs1I/
	bdcK0RXrnU9+tASgUYywSsBUQrTSlCPpJXCcBzoHny65FOt/MDwgtZptiXt92HFjatTgLW
	A3MbTyJzhqIUE9UsMCJ2mdW6Uebgn8w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-o9amTFseMty5uZ107E0l_Q-1; Fri,
 23 Jan 2026 10:31:19 -0500
X-MC-Unique: o9amTFseMty5uZ107E0l_Q-1
X-Mimecast-MFC-AGG-ID: o9amTFseMty5uZ107E0l_Q_1769182278
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ECFC1944EA8;
	Fri, 23 Jan 2026 15:31:18 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28BA830002DC;
	Fri, 23 Jan 2026 15:31:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
Subject: [PATCH 07/13] gfs2: Initialize bio->bi_opf early
Date: Fri, 23 Jan 2026 16:30:57 +0100
Message-ID: <20260123153105.797382-8-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4uW5AhIyQrvJLo9zJ5x_yDs1fQTIPv58AxHcOG64nwk_1769182278
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass the right blk_opf_t value to bio_alloc() so that ->bi_ops is
initialized correctly and doesn't have to be changed later.  Adjust the
call chain to pass that value through to where it is needed (and only
there).

Add a separate blk_opf_t argument to gfs2_chain_bio() instead of copying
the value from the previous bio.

Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6539d4ce3f775aee0cc
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c  |  7 ++++---
 fs/gfs2/lops.c | 37 ++++++++++++++++++++-----------------
 fs/gfs2/lops.h |  4 ++--
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 2a3b9d10eba7..347df29d610e 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -888,8 +888,9 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		     sb->s_blocksize - LH_V1_SIZE - 4);
 	lh->lh_crc = cpu_to_be32(crc);
 
-	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock);
-	gfs2_log_submit_write(&jd->jd_log_bio, REQ_OP_WRITE | op_flags);
+	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock,
+		       REQ_OP_WRITE | op_flags);
+	gfs2_log_submit_write(&jd->jd_log_bio);
 }
 
 /**
@@ -1096,7 +1097,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 	if (sdp->sd_jdesc)
-		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
+		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
 	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index aa9e9fe25c2f..c3317432a25b 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -231,19 +231,17 @@ static void gfs2_end_log_write(struct bio *bio)
 /**
  * gfs2_log_submit_write - Submit a pending log write bio
  * @biop: Address of the bio pointer
- * @opf: REQ_OP | op_flags
  *
  * Submit any pending part-built or full bio to the block device. If
  * there is no pending bio, then this is a no-op.
  */
 
-void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf)
+void gfs2_log_submit_write(struct bio **biop)
 {
 	struct bio *bio = *biop;
 	if (bio) {
 		struct gfs2_sbd *sdp = bio->bi_private;
 		atomic_inc(&sdp->sd_log_in_flight);
-		bio->bi_opf = opf;
 		submit_bio(bio);
 		*biop = NULL;
 	}
@@ -254,6 +252,7 @@ void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf)
  * @sdp: The super block
  * @blkno: The device block number we want to write to
  * @end_io: The bi_end_io callback
+ * @opf: REQ_OP | op_flags
  *
  * Allocate a new bio, initialize it with the given parameters and return it.
  *
@@ -261,10 +260,10 @@ void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf)
  */
 
 static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
-				      bio_end_io_t *end_io)
+				      bio_end_io_t *end_io, blk_opf_t opf)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	struct bio *bio = bio_alloc(sb->s_bdev, BIO_MAX_VECS, 0, GFP_NOIO);
+	struct bio *bio = bio_alloc(sb->s_bdev, BIO_MAX_VECS, opf, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = blkno << sdp->sd_fsb2bb_shift;
 	bio->bi_end_io = end_io;
@@ -303,10 +302,10 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 		nblk >>= sdp->sd_fsb2bb_shift;
 		if (blkno == nblk && !flush)
 			return bio;
-		gfs2_log_submit_write(biop, op);
+		gfs2_log_submit_write(biop);
 	}
 
-	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io);
+	*biop = gfs2_log_alloc_bio(sdp, blkno, end_io, op);
 	return *biop;
 }
 
@@ -318,6 +317,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
  * @size: the size of the data to write
  * @offset: the offset within the page 
  * @blkno: block number of the log entry
+ * @opf: REQ_OP | op_flags
  *
  * Try and add the page segment to the current bio. If that fails,
  * submit the current bio to the device and create a new one, and
@@ -326,17 +326,17 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *sdp, u64 blkno,
 
 void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		    struct page *page, unsigned size, unsigned offset,
-		    u64 blkno)
+		    u64 blkno, blk_opf_t opf)
 {
 	struct bio *bio;
 	int ret;
 
-	bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, REQ_OP_WRITE,
+	bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio, opf,
 			       gfs2_end_log_write, false);
 	ret = bio_add_page(bio, page, size, offset);
 	if (ret == 0) {
 		bio = gfs2_log_get_bio(sdp, blkno, &jd->jd_log_bio,
-				       REQ_OP_WRITE, gfs2_end_log_write, true);
+				       opf, gfs2_end_log_write, true);
 		ret = bio_add_page(bio, page, size, offset);
 		WARN_ON(ret == 0);
 	}
@@ -359,7 +359,7 @@ static void gfs2_log_write_bh(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	dblock = gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
 	gfs2_log_incr_head(sdp);
 	gfs2_log_write(sdp, sdp->sd_jdesc, folio_page(bh->b_folio, 0),
-			bh->b_size, bh_offset(bh), dblock);
+			bh->b_size, bh_offset(bh), dblock, REQ_OP_WRITE);
 }
 
 /**
@@ -380,7 +380,8 @@ static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
 
 	dblock = gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
 	gfs2_log_incr_head(sdp);
-	gfs2_log_write(sdp, sdp->sd_jdesc, page, sb->s_blocksize, 0, dblock);
+	gfs2_log_write(sdp, sdp->sd_jdesc, page, sb->s_blocksize, 0, dblock,
+		       REQ_OP_WRITE);
 }
 
 /**
@@ -477,11 +478,12 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	folio_put_refs(folio, 2);
 }
 
-static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
+static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs,
+				  blk_opf_t opf)
 {
 	struct bio *new;
 
-	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
+	new = bio_alloc(prev->bi_bdev, nr_iovecs, opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
 	bio_chain(new, prev);
@@ -546,7 +548,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 					unsigned int blocks =
 						(PAGE_SIZE - off) >> bsize_shift;
 
-					bio = gfs2_chain_bio(bio, blocks);
+					bio = gfs2_chain_bio(bio, blocks,
+							     REQ_OP_READ);
 					goto add_block_to_new_bio;
 				}
 			}
@@ -556,8 +559,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs2_log_header_host *head)
 				submit_bio(bio);
 			}
 
-			bio = gfs2_log_alloc_bio(sdp, dblock, gfs2_end_log_read);
-			bio->bi_opf = REQ_OP_READ;
+			bio = gfs2_log_alloc_bio(sdp, dblock, gfs2_end_log_read,
+						 REQ_OP_READ);
 add_block_to_new_bio:
 			bio_add_folio_nofail(bio, folio, bsize, off);
 block_added:
diff --git a/fs/gfs2/lops.h b/fs/gfs2/lops.h
index 010a4696406b..772557b63b48 100644
--- a/fs/gfs2/lops.h
+++ b/fs/gfs2/lops.h
@@ -16,8 +16,8 @@ void gfs2_log_incr_head(struct gfs2_sbd *sdp);
 u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int lbn);
 void gfs2_log_write(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 		    struct page *page, unsigned size, unsigned offset,
-		    u64 blkno);
-void gfs2_log_submit_write(struct bio **biop, blk_opf_t opf);
+		    u64 blkno, blk_opf_t opf);
+void gfs2_log_submit_write(struct bio **biop);
 void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh);
 int gfs2_find_jhead(struct gfs2_jdesc *jd,
 		    struct gfs2_log_header_host *head);
-- 
2.52.0

