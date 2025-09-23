Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F691D54E2
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587639; cv=none; b=Uou878p74fug6y+dZ+yrCkU/QN5kLbmvXOib0ZNP9H1TtJG2Boe3FL6asZ4oY7E9ot/gnvdfnQoV8Uj7r8DAGPi19F+SHHek/bRidSz27WGghvKQ+AqoE8O5kp06T0/9OWQXBoZbIv0zYPaghhF2HjKZD+LVVySwpLr8HQQQov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587639; c=relaxed/simple;
	bh=Bb9XHeMlSIhgxocJi7zMkwUhCzQElY81IHbj2qnvjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chvJloXIN9d+2EJWACK8uWBAqvKkZjEDz8jEG/vFxwczYaBX+VfpoXm6xP1MvE+fwW2nQ9U2OcYhs5HTeo359kPnCJ/Hlt+WVSlRxX76JNTp4DXwN0X8BDAFTsjf9hlX3n+gRFy33S3TaJDBre5m6yMErJXqQlz8Ogg7Zj0zarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXeOTC/G; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXeOTC/G"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1680563a12.2
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587637; x=1759192437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcpVeAYougECMqYDjv+WTibeO0LuSWTiGkan9JcZFA0=;
        b=SXeOTC/Gh2RgrkAw5kCmgaGUibN+5Pu20ZumHW8pU3eIvtSUjptMPjOxPMzI2BvnZr
         P88nbO8jPgvIJNzVyZ6Ao/Zoim95x5BvrsOSlJfB+53/LzBHbknK5tkkrFIaTCd1WxSj
         /N5i8JmEQQ9c8Dc2D5hd6BhbhDDM+RKBB/cTdWhzZwKlfOq/GwImak8XMflyUWB/8Mv1
         lIDxdyfgQZLmI/VYYCeBwso5SXtiSenPlnP3HfXC2ThW6Q7QkLDwrv72/KUfgFWgvSik
         RDWRh4ofnBCFA3Hkghs6e3Yo5F46QFCIfDcPzdTYwUUiHV5me4CitL153O887bnwPrBP
         eJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587637; x=1759192437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcpVeAYougECMqYDjv+WTibeO0LuSWTiGkan9JcZFA0=;
        b=mCI9MSm7w+zrbf6Go4Bv9JPLOFl//ipsruF8WWYvOQxefnK9bR+wUCLBT3dp6hPcLm
         hDwqFJamRq4aOJozwbwbikEBue5pivGOdRWrnEi+v5r6z2llSAxlpCpyUwAl0z7mt8Ro
         hKt6yKu1btRTbihsUqOBeinIbhcqG/YOPS2Fc/dJrFZBUNs/xIuhRsbOq3Z5PAIbH5qY
         F686wKZK/PRc06kWYP0HGBX+0VZGrPR7fAd3guVX+unNFMVAdccJXK3EcO/unDy3iNE1
         GMinUDwZYMuImyJM4dxT2JVJS3d7SpNOu4A4Zh1jO17gZs/lIVMe6Bl6DKnUkOkwgYRI
         AGOw==
X-Forwarded-Encrypted: i=1; AJvYcCXX6Bor9noIrBc7jp8BQ/SKRx2KgX2v/KSuiMrn7lS8mZ6g8vQD8LZ9ZRO/ucM6LCOewAWj@lists.linux.dev
X-Gm-Message-State: AOJu0YzR30n2Hr10OwB8E8oh8OIC06ghOpxp7hqW5t+KHOJTsC7Ao5ir
	dIR3gG1A1uhPXmiCUo4ac6KP5M7VwGR9lpn40751KVer/68TSF3ilVDj
X-Gm-Gg: ASbGncsfPcXSH0YMvxtmvIAyKYiNvowCTPVqYitcGb0ZRSHXgrIqqi3WA8ipsHHLrV2
	UV5KLCziuHZd+T8FZ0mkiGtsUK0BeiQDTKGuOJzsG84HOhULW97kg62ROc5iF30+Ly+/MhAgNB2
	cnfp8EZuV78ILUispLer6NB9x4/iApprkXxQ7y4WSo5MXvpMLiiPaLq3IL68iCGgHAOAccKzf5x
	RCH0eRhoqbZsDWvjQ2+duN8Zpika9cG1JsDtC1znVGEtbq+3tdiGqft6Z+ehAHaUUePhNpKBKqR
	FNSDSqVLbrKmthrFIV7IzG+Mv7A5IH8JLH1nwaVDsrpIO4iOGK/3HEMCz/qRgbncW67zIwTZ2wS
	hSF7NP6SXy3/T+Bm0bh6rEXXZ5+6tD223b5uAXRm1/DfupkjPkAMVfKi8lT8=
X-Google-Smtp-Source: AGHT+IHVFfzg8x4eRcM+QJ3isKvKIKmIsBBStLAEhVGVKIoSb3CxXZfaFZoSTi2VN706ZbNtC20t5w==
X-Received: by 2002:a17:903:11c3:b0:270:ba81:14d9 with SMTP id d9443c01a7336-27cc5434ee4mr9156995ad.36.1758587636816;
        Mon, 22 Sep 2025 17:33:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deea6sm141157835ad.75.2025.09.22.17.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:56 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 03/15] iomap: store read/readahead bio generically
Date: Mon, 22 Sep 2025 17:23:41 -0700
Message-ID: <20250923002353.2961514-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the iomap_readpage_ctx bio generically as a "void *read_ctx".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f8b985bb5a6b..b06b532033ad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -363,13 +363,13 @@ static void iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
-	struct bio		*bio;
+	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
 static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->read_ctx;
 
 	if (bio)
 		submit_bio(bio);
@@ -384,6 +384,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->read_ctx;
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -393,9 +394,8 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 
 	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -404,22 +404,21 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+				     gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
 		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->read_ctx = bio;
 	}
 }
 
-- 
2.47.3

