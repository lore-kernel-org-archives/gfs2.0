Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07A320CDC
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357559; cv=none; b=kktrNJb3NeBND3QpYeY7E1Nz1s5zAJvrhXLWCWhEy9TX2JrAj0Dl4uDT1Qy49976h7BGekdhAioI/H9tBfnbRo69BPzbLTZXVL3y0eFiKxunOQIHDIiC8+a1TkbcHxIkU6FdfEmlRJrDzAskeilmCMwN+3X1NEv0X8eFamJXrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357559; c=relaxed/simple;
	bh=BVHH2oEGwhwo7ow3sZ4AdznwXo/wREEoF3kV7H69pU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjXBDDOwFumI2Qs/1IajQFvskxDYL9uEei45T3CAIufe403qEpSQMppSMAgdkUOzyA9TFU9fa5H4zu508ETHM5wp0gjzWplSLXl6gKKZbXTfzHNSNfZikTzGAmXK/KxKvtYP+juVibVNZEQmXjtBU6HCM65UWk/zpikLg/Vmdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKIHy2Gw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKIHy2Gw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2570bf6058aso14308025ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357557; x=1757962357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5iaIVvSnv6dy53ZNAW4os4OkbWvNlAu4AJs/GGHBY4=;
        b=DKIHy2Gw0BvXIDsYycd9b8n38w7G5KPmq0YQ+L8Nj8JCIT5O+8KzdY4w76VwdqOTZC
         m++us51Qqc6ZubpR7IFLAXS69TvttsTqXZK949S+6+NTZnezCUWRcB0rTrwf3Mn1nU5w
         skZV9Sq+nwp/U8W3RXj63UzPm5rPFOs3QmNZJdCvVtJM7ORVYZEffc0Y16ANN0JH7Bvg
         g9NzGJAGVXBGy1AI5DOZOdxYryj2aPuGyumSwL9waMQ4s98THILaNkUmxgr1fnVIkE2Q
         oCcizbUjmH5lFLy8SO0WBWxw4hqeg0l8w2RgmpzlMQjp/Hfyhkxa1nBTHp13fXV8CE6s
         /tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357557; x=1757962357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5iaIVvSnv6dy53ZNAW4os4OkbWvNlAu4AJs/GGHBY4=;
        b=NY+4ag44M4FlLRHnb9NTZYKE0Ac038V8z8o/DTr3EQPT7Kr/t35t9Xrs41mN6vwRTQ
         o9b484D/tyXH7zVdJE31HeQTcbVnSw8xXVCel0o11aV2LUDgCrwigKayrNEfow8+hbpj
         toh3MtseUpyokRL6CQQISpGzJVjhYFFreFTMkIWzwWKdGv6E+x1xz+qLKHMaAuGOZl9e
         y7UDP8aU6p21J76ZNQQ0LIjip4z4Hwc5zVM0PEQQKfTVHfV8NQQKuA2ap8NwFKcBpuNN
         zvSlwnIPQh/bLEhBGmH6dXmU+u0zCkHqxS8QS5YUMb+FkEiLbCi9Bd8gtZRMhKvmJxn7
         9Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCXctKc6rcF3t5f0z7fBG6xV6TRMmsrOnetIy9XeS04hh6rN750v8GdUMm0PTq1vbXX5x9pD@lists.linux.dev
X-Gm-Message-State: AOJu0YyDLnanFbxoXBWV76DZr3/nHbyQh0QDq4qgDwiNxoYTltF1jkWJ
	8eD+d7hjsk0MGrhivKE19E1bovT3ccoEBi34INN1l8Sbx64fqy+Yh3sK7TnFww==
X-Gm-Gg: ASbGncvGlhU/8HfG9qk5cx2GWXsmG6FbYlNydqhCXTerKndGyjnSbiYdSZzBPCeiR/Q
	wRgv7MuJYBc0SwsfN+1AoCpRXbew/rzvJufDbh269seXp5qHZX4l1L8yAVOOETfuNoBdPzA+Frv
	WlgJ2+gOvZJUhMenHRKZJAsJJPRJMuutqvpEP3lJradXq/fpfcE5zWRvHDL0qFtZA6AFVH5zIqT
	U9zehHFGzZeEugS1NUeIBScfHcAokCwSF0eFLYkT/wamFXfvWNg5Fz2BJ8Rwl6Tpmxvn5UyYM1L
	RplRbma/fdKDtCFZQz0ljvlKBOjdek4YxoYyHE2+1LnLo6RAU2C225n5JpWo3BldLfPxVhJz5bs
	U13MmVB1QZQWBTlzZyNPTMo6yZKOX
X-Google-Smtp-Source: AGHT+IFMnKZdNK9NBwmOCSTQ3eO2IANH00bHS5GPR1akE8ZsHzvjnWsh1OP0ONzV9ZVSjTpODH2aGA==
X-Received: by 2002:a17:902:e801:b0:24b:1589:5046 with SMTP id d9443c01a7336-2516d52d41amr127897625ad.5.1757357556917;
        Mon, 08 Sep 2025 11:52:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-252184a16c2sm66265655ad.38.2025.09.08.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:36 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 13/16] iomap: move read/readahead logic out of CONFIG_BLOCK guard
Date: Mon,  8 Sep 2025 11:51:19 -0700
Message-ID: <20250908185122.3199171-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no longer a dependency on CONFIG_BLOCK in the iomap read and
readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
allows non-block-based filesystems to use iomap for reads/readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 151 +++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 75 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f673e03f4ffb..c424e8c157dd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
-#ifdef CONFIG_BLOCK
-static void iomap_read_end_io(struct bio *bio)
-{
-	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
-
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
-	bio_put(bio);
-}
-
-static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
-{
-	struct bio *bio = ctx->private;
-
-	if (bio)
-		submit_bio(bio);
-
-	return 0;
-}
-
-/**
- * Read in a folio range asynchronously through bios.
- *
- * This should only be used for read/readahead, not for buffered writes.
- * Buffered writes must read in the folio synchronously.
- */
-static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
-{
-	struct folio *folio = ctx->cur_folio;
-	const struct iomap *iomap = &iter->iomap;
-	size_t poff = offset_in_folio(folio, pos);
-	loff_t length = iomap_length(iter);
-	sector_t sector;
-	struct bio *bio = ctx->private;
-
-	iomap_start_folio_read(folio, plen);
-
-	sector = iomap_sector(iomap, pos);
-	if (!bio || bio_end_sector(bio) != sector ||
-	    !bio_add_folio(bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		iomap_submit_read_bio(ctx);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!bio)
-			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
-		if (ctx->rac)
-			bio->bi_opf |= REQ_RAHEAD;
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(bio, folio, plen, poff);
-		ctx->private = bio;
-	}
-	return 0;
-}
-
-const struct iomap_read_ops iomap_read_bios_ops = {
-	.read_folio_range = iomap_read_folio_range_bio_async,
-	.read_submit = iomap_submit_read_bio,
-};
-EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
-
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
@@ -601,6 +526,82 @@ void iomap_readahead(const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
+#ifdef CONFIG_BLOCK
+static void iomap_read_end_io(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio)
+		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_put(bio);
+}
+
+static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
+{
+	struct bio *bio = ctx->private;
+
+	if (bio)
+		submit_bio(bio);
+
+	return 0;
+}
+
+/**
+ * Read in a folio range asynchronously through bios.
+ *
+ * This should only be used for read/readahead, not for buffered writes.
+ * Buffered writes must read in the folio synchronously.
+ */
+static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
+{
+	struct folio *folio = ctx->cur_folio;
+	const struct iomap *iomap = &iter->iomap;
+	size_t poff = offset_in_folio(folio, pos);
+	loff_t length = iomap_length(iter);
+	sector_t sector;
+	struct bio *bio = ctx->private;
+
+	iomap_start_folio_read(folio, plen);
+
+	sector = iomap_sector(iomap, pos);
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
+		gfp_t orig_gfp = gfp;
+		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+
+		if (bio)
+			submit_bio(bio);
+
+		if (ctx->rac) /* same as readahead_gfp_mask */
+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				     REQ_OP_READ, gfp);
+		/*
+		 * If the bio_alloc fails, try it again for a single page to
+		 * avoid having to deal with partial page reads.  This emulates
+		 * what do_mpage_read_folio does.
+		 */
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
+		if (ctx->rac)
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->private = bio;
+	}
+	return 0;
+}
+
+const struct iomap_read_ops iomap_read_bios_ops = {
+	.read_folio_range = iomap_read_folio_range_bio_async,
+	.read_submit = iomap_submit_read_bio,
+};
+EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
+
 static int iomap_read_folio_range(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
-- 
2.47.3

