Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C01E9B0B
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587643; cv=none; b=LD2KvfA8jJojVxgbDBg0iQcr7/Xhdw++qf5zgeCgnFej/NJ8tVjTHC2ZgrY5ffqvWiW1iV6pFwJ8LwbdTeZhvWZWNsJFGzZk93fMOe7+rajZ2UE8U0EZqnQ/WL5IxtnTaXNgYkHhtCl94pyrwfQ/yg7XtJRcBYbT4utAjfYcvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587643; c=relaxed/simple;
	bh=vIAY62bPonaFy7vGVNyvqO/mtaIvl07zVQLoOf2yQSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP0p616GcYJsfx85HuMp3gyWcRW3YhMaiCGBeKjE4v1DUjkzA8LxwAj43JYBDlQKnSPjsDqSwTRfieiSv3Ox1W/z/gEk/5rYWyJUBLoJsFQti+sp/8ZvtTo6c4fI4UMch6Mt9ottc3qSvmZfG9UbP6zyEiVsnukFufxL5Pto268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHAMBxJ2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHAMBxJ2"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3723435a12.2
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587641; x=1759192441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=JHAMBxJ2TED30DeEsvZzKIZBIxbe4I9tVVN3MgMsDc6so+EqGZmq+qQWxiUc3q3nnP
         NHgtlRwyZwIyFuR/jX5tjMj+hbltGVnCvtoHmSRaEKJhWC1bPRdCG95OeAtVle2V9v/o
         xk8c2pSqHMQqu7xYRGwyxl0XqqaQTlQKB7WPIEE/uZ1R2aefVQRmn4+qh2++GOceWSrO
         zF79tG52WgUqbV0M2Ueg81SHY97Jf3AMRgUTFNX/H/RRQLKMTvVcZtMGpnx3IUtYPNJs
         dtsa07aYazHAHmPfdu6c7RYP+AtaFafY6lqZYtFXN6pgg7tqrZJmlitjdM/nEnWbbhW6
         ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587641; x=1759192441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=NISIwfDtE6LJ/+E6+umvGzMH6MlEs52pi12tQ0L3YbNdDK8jBsKxHDpcvagKoUcGJe
         CkxrVHf2DZqZERNJejXqBN1UeK2ZzVEsKOOWD0ywZShYYFTv7+F0u6c27c7fVWi9uQ7j
         znAYtaiKj4Gs9VGfh9M7ThIfRkJt1Zv8YEsJLau7RkKg/jGp4Vaz0vXkx5Tq9lB6k7Gk
         YHppUUxJ15ko7RqKTicPqQVM4br6XXLaFK+A+Fq+G2OyjwrUaacUZc3OMtpnKURZf2jU
         qo+GqE2/OoGB1viVbKohmJQq9IB3L3Nzz+ZdeZn0Nmdb2euwOCKZA4SyulR/woysrTf6
         gNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdhCS0kY40ePT0JetJJVGExpsalCbj5POD/YiUe6JO/7c3mQsHu7TvUnHsoFnQ47jaY5vJ@lists.linux.dev
X-Gm-Message-State: AOJu0YyBIv/IYXOm7HgB0V94WiXNPDEJIUnirOyHUr5bRQfjrKe3FHQX
	SD2Q3U/AHvoFlXOcpeysOhD+N8d3g3yXlvDWwKSk5p7gz/Vzd3aCk1lk
X-Gm-Gg: ASbGncteWPYMf/nsvlXPe3zp2IItw0XdqEHPBm2FsVMGXu/64cVM5ieyp2Lm0q4ISPT
	3A5XYlySlGUrUuNM/dROVyiNsXEgQNrEsA4+UF9Y948KbBDKDzVTLUVP58fAxhjrTwXwVrUgjtt
	/XhyCWoIiKesaKc9PoVd4zuQHL2g67YaC6Wlh6zOdSb+P8NgpTWvA005+NttLDP93gFSWrXln9N
	x0QXNutE48oftgv0vIJUEvFLwRNb4pxw/ZhkF0UrPRceZr3h25MFa1Oc1jUWlQtn0UCBoCrAxgq
	rHYi2z+wAPZ0/CgXQ4mpsfoOdWiueXj97H9nduv9pTSAatFo7c+MDwGjVe/eVptJGxfcOx38uQH
	0U1nx2mRH3w2pEz9MXpZNOMqqnSJUeMAAoliBn+ZN1SDEi+Dg
X-Google-Smtp-Source: AGHT+IF5uyA51QP5B/v0aEpZwjC0gnuJm8CE+r/VEqv2kg+QAhCE4gI4DiBuU/4bl7VHU9GQ+zierw==
X-Received: by 2002:a17:902:f70b:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27cc5431730mr8985485ad.38.1758587641125;
        Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm144543225ad.64.2025.09.22.17.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
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
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Mon, 22 Sep 2025 17:23:44 -0700
Message-ID: <20250923002353.2961514-7-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23601373573e..09e65771a947 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -360,14 +360,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
-static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
@@ -376,7 +376,7 @@ static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -423,7 +423,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -479,7 +479,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -504,7 +504,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -551,7 +551,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3

