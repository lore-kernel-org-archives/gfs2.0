Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF3157A6B
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587636; cv=none; b=sQY81qaA9cSJifuNE/EjTVU73lkExZJjlWGgW+bRt6egv3mpWLGpkNiikQIpEceP6vQdFYEC3K9IGlYkT2ZNaaFywagsUFVaPUibbgo7WMoVipwdCgKeuRXp8Yc2dEjimcc+ht5rADDaulbRS5d6GJx6cXG88b5UAX9dLaSjcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587636; c=relaxed/simple;
	bh=CSiGtKrWb8zqpNUe8yL7Pevqy9qFJhFmaY58ZJGrYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/1dyhWgZHRJVrhm5Uj1ZHTontThDRO9aHNwEpkK8Z/HsbP8TFvd7ofjsR1puT3jX2igwtLSx/D8yv311UlxPs/7ooUOu9cvcqOjJL8Ta/fhQn8otuB8XbN/d22UXRD7O1Hblk2NFN2dDrBhDEEv5JWy5j8Giq65JOBXTd0Q2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZv3bgsv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZv3bgsv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77dedf198d4so5391311b3a.0
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587634; x=1759192434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=AZv3bgsviNvgXJKcCefGcT93hf8PJo2BG/pA34GNuly992OYryHbfD8lltQKEWqm1T
         XVP7BWwZhI8kwweFomxzt7Gy/wLDo0d7lxxshGUUjhmvwGwogzlMbULHkO1S7QRO/pJu
         xr+Ql5FHt+2023MIHLqoQ/bMLBzxRUp/Vc3QchvgU07IaI+tCGj4cNbxUjurqmFxeXbT
         sPFmEMtvR1gaUoEQsY+y85FKT/ipWiJoFIEnsnADpmUPSEzZ1DBm7LvgROKVnIzJrziv
         sM4TXmHt2IXbxczhJ4i2Pay+/IHhRe/H1jS7rEEtTSky5l7Pu6Cp7VQMpaS7yZc4vsI+
         Zfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587634; x=1759192434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=AeZljaCVQ7PeqmILlFoK26+/e0KA06fXjc5fbsrW0R/Bicr0bs15w0CJ4QAFXanXRj
         UdjCaNSkmL1BxMkjr799CXFte8+tI1zJbyGNptrBd72TCBwAqP+KFKi1nGS08eAHpZAe
         Ac6tzIw1NNsYin5RAaC0f4m1VgKYCG3pDuR+zUmSegby2VJzy8/g1+pN8zXADam2jzAE
         AQ2CK3KiqgvjYq2wCHD7FWR7VPIQRda7ComHEEV+6n9rkc58psxEYRSKRWQ+xWUHx2YY
         PCNa+gBsUy+Y9N1Wx0v5eEvnbU+2I2ACq6EWvYx4IPwOT4ZEZgjLGIke9snJaE1I2ekD
         03sA==
X-Forwarded-Encrypted: i=1; AJvYcCUhIUzdLIE/uzCyHqtc8johOUAURQ93Aiw64O6S9BuhFXApsbLhEpenaJh4qVPfl0S8twir@lists.linux.dev
X-Gm-Message-State: AOJu0Ywky/Kd+XRYzie+h00FTbdQEU6teEMg4Y6MyWn/xyzYbhxpPVra
	JddFW1Jm7SNbT5UzxC+lm+gGLKe2HIOVK70RB/GvJlRz1Vg0EfKdN9EM
X-Gm-Gg: ASbGncvN21xeNB8rFGku+6KsdJ0D8O4GnbHYUm2OFmBiH2vnndGkUyJ5qUxCDNmsQ1Q
	l/LMxiMj6j9UPw1NcQNDtDiBifKA9SMs7koS0J496uM4p0OomJrcI5nkcwcJ8nG9qoQFgUlrxOS
	6r7Y3L311IC4wJZwtIJaKQrcuv6G1bmaudegjlw2t7vKGSMwje6iNvBQpzeCP0+Q6lePUUczxRT
	G7eg+m9iltrndC7nfH7lI8rpaObCx9VR9oS2w+8oLi2jCLSwh2sc6qr1MKhl6Pb17mbn+oW1zLQ
	T92tKmSkyJFNaPevSaHbYmn4LszzOMGvuGKbLAOLrSZmgSWH2leDTHZHIssWzlI9Ay0W7wo4d+c
	mfsP8tmuRsX//TXQxE4sXYPpOr3+Fk4yrjpqWLHVGJiZQJg==
X-Google-Smtp-Source: AGHT+IE9UTk9DOOxHIk7V9AusMOVMJaA+o0ouKvy94Kuhd+S63mgnV20FB06J29O2ckAhaW6BtwlSg==
X-Received: by 2002:a05:6a20:258b:b0:262:c083:bb38 with SMTP id adf61e73a8af0-2cfbb09d4e3mr1348063637.0.1758587633950;
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff445dd7sm12934627a12.51.2025.09.22.17.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
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
Subject: [PATCH v4 01/15] iomap: move bio read logic into helper function
Date: Mon, 22 Sep 2025 17:23:39 -0700
Message-ID: <20250923002353.2961514-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9535733ed07a..7e65075b6345 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,36 +367,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -435,6 +414,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -559,7 +569,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -572,7 +582,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -749,7 +759,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3

