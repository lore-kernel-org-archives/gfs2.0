Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839B2264A3
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357544; cv=none; b=ru9aPuEQkLE9p5Nl3kVh8rTIMhcA2Q2BUolDMecqKJOFstlb27rmF6B4ezhWTfNLJ4gRuytZHAMLBf36OD7HTjgnjxexOATnKSH4/v7vNu5j5cI3s7mX1rUd/z2NnK+eUBYjxhd6rJrUvwsR8GVXvkmToleZk2TpyPi1Bs+9ZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357544; c=relaxed/simple;
	bh=HlWf+60XajNJzrOv/o6ql21t9thkZ3f7qfmma60hGSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/0PD5HrQEsKRpmuvglY/GSCn5r/7dBo9HmILJsPe526SZMwQmuNWcei/4R+0OpI+fCsH7Sn9ff64m98kuix45Ti3dhMHs81jmiNRCLapDOcB0Jn4AXd3RGy+ir419NxOJfW4dCFBakjrFxettvukpI5fvPOriDGZUPDdzw32dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfTgNvqA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfTgNvqA"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso4177649a12.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357542; x=1757962342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbAhfZzoGj7BINNVnRQfg3QUv+j5nbtzByJhIRBZ6BI=;
        b=BfTgNvqAukN9nF475al3pitmpjjk+ICr0UsbLmzfivZ0lhvvoAyeL88pjR4iXBpnNX
         s8t29NEFj1n8gRgB6fq2r2gLUebtvfnBGXYGintIMcovXDEVmgBLL6gFBdrI+47S6cGl
         5GDL7Rx2TiEnXBP2TmcybvqVc+6gMMJtnhx9JqfILFm6TDhED3lVlvsoPlR6LAbZQs3f
         GU4G/39TjH5SWExjrGUQRyzvItnoIE3nfAgJGZnqksUdtKtYIc2Zgqz7jshR78hkVdCq
         eFJZW6eAwy8saDrCfwetaBAek4HmS042wONeayNEXDE1NOsgief+D6B+sGcVoZZGjJCp
         8OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357542; x=1757962342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbAhfZzoGj7BINNVnRQfg3QUv+j5nbtzByJhIRBZ6BI=;
        b=Tb7WP1yxjL59T9geMJTq/j/3gZZvDqaF9oT88kq77x/sK+2aa2dJe4vwQ55vpqOKfV
         e+4aPav8EGA4Y8QRsW3x41goWcacoIW4QEI6wjghgJ5e+VrmPAF1chca54OQ40OPMbDT
         K8eBPiRv71zoM7WYxLX7+/Bxx57Z0dBKZnfmcTnH2PMm0NJ9fdezPy0j1+2cMtPs8gjY
         wf5DlhzUCvenUEy7mbzleKFqfn2oSZrc8Kb5C8FLiCzA9vqu5K043sGXLkEzaYhxZNiQ
         Zr74FoY0MLqaUyaXYdQhXHcrbOtI5hZOdnjCmiEGY2F77P0DpADuZ19Ec491ha8SYp5u
         DJQw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCnQZuisC8wU7O/4ylsS70RLoUURvSwueBv6krYMmE/V8J35gUpf6c3pvqfoD7esEH2kY@lists.linux.dev
X-Gm-Message-State: AOJu0YzJA1t6IgkzcOFBssTp7S1270qK1eOl0BELUCPKNK0ZB2VIyNuJ
	d+IyB9BL5L8jf2T0jRY7wIbpQZRimKbPoscwzX6an2phq7HrQeNgNano
X-Gm-Gg: ASbGncv8LjeY6k1IAnh68tIu1CdkXGBEmPZWWevOXr5IooXWqDJ9MDWfUNR8lU66o+d
	VOWDzbezk5Tmv8p0RArvUWPkKlBodWf8CTzWFmA9dJtf7nFgIC/GPJ0boIRFZ03b/6gejNFHN/p
	HbFjXu0IeCoaNHmqV8QeQAdq8baLzY/BSAgkil6sBc8lQx1UqVe2Yjb8pK68dznGfNJPrkBLdGm
	OCbD6qhCxj2e+h/GMG9n8TDV+QRbDj8i2F5+J7CqaU7rfTSDyWb90g2aGG8EVRZ1hH8Q9uNvU7V
	4GhTQ3J8nf9JBFyxPTT8EgJT9R4UigD4f1c+MVuR6bzJIYpcKRqLfOxoEiMRlcOJNDYvR+zYC5N
	Xa4lnBLy/yOPjAD4I
X-Google-Smtp-Source: AGHT+IH5oWGt7OEC4zYedM4irtBrlr8Zu6x8woV1tHH464aupZ9uvD16MfYmjd8ehMyotB7fyPyi4A==
X-Received: by 2002:a17:90b:5343:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-32d43f937dbmr11422558a91.27.1757357542549;
        Mon, 08 Sep 2025 11:52:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b227sm37661021a91.6.2025.09.08.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:22 -0700 (PDT)
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
Subject: [PATCH v2 04/16] iomap: store read/readahead bio generically
Date: Mon,  8 Sep 2025 11:51:10 -0700
Message-ID: <20250908185122.3199171-5-joannelkoong@gmail.com>
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

Store the iomap_readpage_ctx bio generically as a "void *private".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 598998269107..a83a94bc0be9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,13 +358,13 @@ struct iomap_readpage_ctx {
 	 * responsible for unlocking it when the read completes.
 	 */
 	bool			folio_owned;
-	struct bio		*bio;
+	void			*private;
 	struct readahead_control *rac;
 };
 
 static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->private;
 
 	if (bio)
 		submit_bio(bio);
@@ -385,6 +385,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->private;
 
 	ctx->folio_owned = true;
 	if (ifs) {
@@ -394,9 +395,8 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
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
@@ -405,22 +405,21 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
 				     REQ_OP_READ, gfp);
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
+		ctx->private = bio;
 	}
 }
 
-- 
2.47.3

