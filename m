Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2C31D754
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357556; cv=none; b=ZRs4ebmnkHu6Gg/XkRah6czeSkPeP+zVDvg5rGH9N4RAW6FHVoaM9kv9yPduYjCTOzjwLhY9RSU+X5pU2+MGa+hLLZnxN2YXj9vxqOymoy9MFR4q4hg1EKh+Yp+cEZlWB83VcnX+gEjFtN27/BX/gH8e4MrDWMCOX/BQe/0mfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357556; c=relaxed/simple;
	bh=imjZfGc18QSsMq5Xt/DCXcnIVjHmMqxpuVliNwzlC8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm5CY5wN7nGYP33R6PgoNv3rny2La348ucqZ4ceE7VF4pGKPk2dw/CtJIW3ObZvWVSB9WjewBmmNFHXCPr3q57TNQXDm4RmMd60HVs0ftjDVh48ww9dcZfZ1TsziRnAWDmnEsJ0CT3yNPfDZg67ReOhNFYESmhS+1Gq0IgUesXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf0NgNp6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf0NgNp6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722bcb989aso3564443b3a.1
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357554; x=1757962354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C96XpnzTSF9KRMm4NMH5mhHv5VwfBRFJyqZl8dti1Tw=;
        b=mf0NgNp6mu0puXF0bWUZMQ5Pk0JsWOkhMtM8BftFOu/d5ffPal4efkqRDyesBsdYU8
         f7X+uLyHYkrNkLcViKTi+y7mGs01V4RMtkYLec7wXY+wpJ597+u+5OY4icbBrGlLzaVV
         a2eidScjsChIdg3TLDFqYOdqi1hrj9vwcTc2i/oT4WH7/oKWftDGkgQxsFX/X1YEXarW
         2a39R3/TpCminUPw2lUnprYVsR4KwK2hBXaa7s3BHzAJ0iicu/4ZakTApkDir/JOnrwG
         A3BZdqR4nPf57MXv1Qhk5eW+DH1lGN9/GH7XRVC12xH+uKelma2R787IiFxEaUcgqoC/
         /Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357554; x=1757962354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C96XpnzTSF9KRMm4NMH5mhHv5VwfBRFJyqZl8dti1Tw=;
        b=K/LEeX4aL8zg3IBqfPycHGYoO/WNyY01JShT1ov+vwAc9hlemrKPvG19f/T4C+ey2L
         +AWsjKmXm/mD18+DaAefdO37iQuUIJjYgy7Gt4kD4UN9OuUUJOPwdiyKJiZsRqqUCsl0
         HyXgbGUYi28OwjFRGkxxe2inOgtNZYa4FT2+gG30jF/yoAcOHS0zKb5tvRyCAwaT+pPi
         S1VTrbxnpY1iJRnIcGqO3CU0y3syEiOAyYEUm1XWLliLkhqKpB2P46MpZsyuoQIhI4na
         XXpOaAhbpayWiXt5e+2vIGCH8iveTHeDwsgqZ5uoGSgcdiFc1TkB10+pXUJo3iqQ0Yd1
         dCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8TpWSdxUB5OtP4T0XihbaqM0pW22qaLdUtXB5aqKqGi0ULpIAH0g/0d5dBvQ43cKVIxO0@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6p+1mie/kznTsdmY4pgCDbSHT8MIu8dpwdnuQWkW7QnmnihSi
	ukIY4C5ZNJ3wmOBI6JC874pV2Blhb4J6FNL5UKnxQ+lCZLAGVgHQnQ3q
X-Gm-Gg: ASbGncsnI14gxGZCAehznD7Ax3s2hYrUk/3hDPuQueuuyvueInmy0WW7wh3zIfTOcau
	+aMZtj0tHuD7BuIktQ52yT1r5k0x+ZYx6dnuspbvLX1S1l1nBRtqEYN+VqHF8zoJS3q6bysO6Zg
	tWzwxf5MGgbUwxYHbLvXtOnEbBSO40JqMtK4koJdQzUDoUWPmo+bWCfEiWS/ekCeDp4lPZEhDHT
	Fbp+loSIQLMqzr5kgw6715inj9E48oeqMsGAWFDFO5u4mA3T4u37SExzi4A2EnJ4zCWWkw+5Bg3
	3zPxi3oB1NSFDqVdFrrczOGiJlsL3yojtSr6Nxq2Yi0ZT/V10aPMj6fHAfimAXBXXN2K5TnfryF
	FNi/qVpC39Hi8CMhTnA==
X-Google-Smtp-Source: AGHT+IG8NuxnMFPAq8Getj8lN9M8fk1FoXnuERVwFnWu0FwMud0UkoyIOzYwiKwQvJvenH1D+frEbA==
X-Received: by 2002:a05:6300:210e:b0:250:720a:2928 with SMTP id adf61e73a8af0-253448ecce9mr11380520637.37.1757357553809;
        Mon, 08 Sep 2025 11:52:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm26011250a12.13.2025.09.08.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:33 -0700 (PDT)
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
Subject: [PATCH v2 11/16] iomap: add caller-provided callbacks for read and readahead
Date: Mon,  8 Sep 2025 11:51:17 -0700
Message-ID: <20250908185122.3199171-12-joannelkoong@gmail.com>
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

Add caller-provided callbacks for read and readahead so that it can be
used generically, especially by filesystems that are not block-based.

In particular, this:
* Modifies the read and readahead interface to take in a
  struct iomap_read_folio_ctx that is publicly defined as:

  struct iomap_read_folio_ctx {
	const struct iomap_read_ops *ops;
	struct folio *cur_folio;
	struct readahead_control *rac;
	void *private;
  };

  where struct iomap_read_ops is defined as:

  struct iomap_read_ops {
      int (*read_folio_range)(const struct iomap_iter *iter,
                             struct iomap_read_folio_ctx *ctx,
                             loff_t pos, size_t len);
      int (*read_submit)(struct iomap_read_folio_ctx *ctx);
  };

  read_folio_range() reads in the folio range and is required by the
  caller to provide. read_submit() is optional and is used for
  submitting any pending read requests.

  iomap_read_folio() must set ops->read_folio_range() and
  cur_folio, and iomap_readahead() must set
  ops->read_folio_range() and rac.

* Modifies existing filesystems that use iomap for read and readahead to
  use the new API. There is no change in functionality for these
  filesystems.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 42 ++++++++++++++
 block/fops.c                                  | 14 ++++-
 fs/erofs/data.c                               | 14 ++++-
 fs/gfs2/aops.c                                | 21 +++++--
 fs/iomap/buffered-io.c                        | 58 ++++++++++---------
 fs/xfs/xfs_aops.c                             | 14 ++++-
 fs/zonefs/file.c                              | 14 ++++-
 include/linux/iomap.h                         | 42 +++++++++++++-
 8 files changed, 178 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 067ed8e14ef3..be890192287c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -135,6 +135,30 @@ These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_DONTCACHE``: Turns on ``IOMAP_DONTCACHE``.
 
+``struct iomap_read_ops``
+--------------------------
+
+.. code-block:: c
+
+ struct iomap_read_ops {
+     int (*read_folio_range)(const struct iomap_iter *iter,
+                             struct iomap_read_folio_ctx *ctx, loff_t pos,
+                             size_t len);
+     int (*read_submit)(struct iomap_read_folio_ctx *ctx);
+ };
+
+iomap calls these functions:
+
+  - ``read_folio_range``: Called to read in the range (read can be done
+    synchronously or asynchronously). This must be provided by the caller.
+    The caller is responsible for calling iomap_start_folio_read() and
+    iomap_finish_folio_read() before and after reading the folio range. This
+    should be done even if an error is encountered during the read. This
+    returns 0 on success or a negative error on failure.
+
+  - ``read_submit``: Submit any pending read requests. This function is
+    optional. This returns 0 on success or a negative error on failure.
+
 Internal per-Folio State
 ------------------------
 
@@ -182,6 +206,24 @@ The ``flags`` argument to ``->iomap_begin`` will be set to zero.
 The pagecache takes whatever locks it needs before calling the
 filesystem.
 
+Both ``iomap_readahead`` and ``iomap_read_folio`` pass in a ``struct
+iomap_read_folio_ctx``:
+
+.. code-block:: c
+
+ struct iomap_read_folio_ctx {
+    const struct iomap_read_ops *ops;
+    struct folio *cur_folio;
+    struct readahead_control *rac;
+    void *private;
+ };
+
+``iomap_readahead`` must set ``ops->read_folio_range()`` and ``rac``.
+``iomap_read_folio`` must set ``ops->read_folio_range()`` and ``cur_folio``.
+Both can optionally set ``ops->read_submit()`` and/or ``private``. ``private``
+is used to pass in any custom data the caller needs accessible in the ops
+callbacks.
+
 Buffered Writes
 ---------------
 
diff --git a/block/fops.c b/block/fops.c
index ddbc69c0922b..00d9728a9b08 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,12 +533,22 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&blkdev_iomap_ops, &ctx);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.rac = rac,
+	};
+
+	iomap_readahead(&blkdev_iomap_ops, &ctx);
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..3f27db03310d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -369,17 +369,27 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.cur_folio = folio,
+	};
+
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return iomap_read_folio(&erofs_iomap_ops, &ctx);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.rac = rac,
+	};
+
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	return iomap_readahead(&erofs_iomap_ops, &ctx);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..1a8567a41f03 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -428,7 +428,12 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		struct iomap_read_folio_ctx ctx = {
+			.ops = &iomap_read_bios_ops,
+			.cur_folio = folio,
+		};
+
+		error = iomap_read_folio(&gfs2_iomap_ops, &ctx);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -498,12 +503,18 @@ static void gfs2_readahead(struct readahead_control *rac)
 	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 
-	if (gfs2_is_stuffed(ip))
+	if (gfs2_is_stuffed(ip)) {
 		;
-	else if (gfs2_is_jdata(ip))
+	} else if (gfs2_is_jdata(ip)) {
 		mpage_readahead(rac, gfs2_block_map);
-	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+	} else {
+		struct iomap_read_folio_ctx ctx = {
+			.ops = &iomap_read_bios_ops,
+			.rac = rac,
+		};
+
+		iomap_readahead(&gfs2_iomap_ops, &ctx);
+	}
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d38459740180..6fafe3b30563 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -363,18 +363,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_read_folio_ctx {
-	struct folio		*cur_folio;
-	void			*private;
-	struct readahead_control *rac;
-};
-
-static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
+static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->private;
 
 	if (bio)
 		submit_bio(bio);
+
+	return 0;
 }
 
 /**
@@ -383,7 +379,7 @@ static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
  * This should only be used for read/readahead, not for buffered writes.
  * Buffered writes must read in the folio synchronously.
  */
-static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
+static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -422,8 +418,15 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 		bio_add_folio_nofail(bio, folio, plen, poff);
 		ctx->private = bio;
 	}
+	return 0;
 }
 
+const struct iomap_read_ops iomap_read_bios_ops = {
+	.read_folio_range = iomap_read_folio_range_bio_async,
+	.read_submit = iomap_submit_read_bio,
+};
+EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
@@ -459,7 +462,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			*cur_folio_owned = true;
-			iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
+			ret = ctx->ops->read_folio_range(iter, ctx, pos,
+						plen);
+			if (ret)
+				return ret;
 		}
 
 		length -= count;
@@ -471,35 +477,35 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return 0;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx)
 {
+	struct folio *folio = ctx->cur_folio;
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_read_folio_ctx ctx = {
-		.cur_folio	= folio,
-	};
 	/*
 	 * If an external IO helper takes ownership of the folio,
 	 * it is responsible for unlocking it when the read completes.
 	 */
 	bool cur_folio_owned = false;
-	int ret;
+	int ret, submit_ret = 0;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx,
+		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&cur_folio_owned);
 
-	iomap_submit_read_bio(&ctx);
+	if (ctx->ops->read_submit)
+		submit_ret = ctx->ops->read_submit(ctx);
 
 	if (!cur_folio_owned)
 		folio_unlock(folio);
 
-	return ret;
+	return ret ? ret : submit_ret;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
@@ -530,8 +536,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 
 /**
  * iomap_readahead - Attempt to read pages from a file.
- * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @ctx: The ctx used for issuing readahead.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -543,16 +549,15 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx)
 {
+	struct readahead_control *rac = ctx->rac;
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_read_folio_ctx ctx = {
-		.rac	= rac,
-	};
 	/*
 	 * If an external IO helper takes ownership of the folio,
 	 * it is responsible for unlocking it when the read completes.
@@ -562,13 +567,14 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx,
+		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_folio_owned);
 
-	iomap_submit_read_bio(&ctx);
+	if (ctx->ops->read_submit)
+		ctx->ops->read_submit(ctx);
 
-	if (ctx.cur_folio && !cur_folio_owned)
-		folio_unlock(ctx.cur_folio);
+	if (ctx->cur_folio && !cur_folio_owned)
+		folio_unlock(ctx->cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 1ee4f835ac3c..124f30e567f4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -742,14 +742,24 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&xfs_read_iomap_ops, &ctx);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.rac = rac,
+	};
+
+	iomap_readahead(&xfs_read_iomap_ops, &ctx);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..254562842347 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,22 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&zonefs_read_iomap_ops, &ctx);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &iomap_read_bios_ops,
+		.rac = rac,
+	};
+
+	iomap_readahead(&zonefs_read_iomap_ops, &ctx);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0938c4a57f4c..0c6424f70237 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -16,6 +16,7 @@ struct inode;
 struct iomap_iter;
 struct iomap_dio;
 struct iomap_writepage_ctx;
+struct iomap_read_folio_ctx;
 struct iov_iter;
 struct kiocb;
 struct page;
@@ -339,8 +340,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+int iomap_read_folio(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx);
+void iomap_readahead(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
@@ -478,6 +481,41 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
+struct iomap_read_folio_ctx {
+	const struct iomap_read_ops *ops;
+	struct folio		*cur_folio;
+	struct readahead_control *rac;
+	void			*private;
+};
+
+struct iomap_read_ops {
+	/*
+	 * Read in a folio range.
+	 *
+	 * The read can be done synchronously or asynchronously. The caller is
+	 * responsible for calling iomap_start_folio_read() and
+	 * iomap_finish_folio_read() before and after reading in the folio
+	 * range. This should be done even if an error is encountered during the
+	 * read.
+	 *
+	 * Returns 0 on success or a negative error on failure.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct iomap_read_folio_ctx *ctx, loff_t pos,
+			size_t len);
+
+	/*
+	 * Submit any pending read requests.
+	 *
+	 * This is optional.
+	 *
+	 * Returns 0 on success or a negative error on failure.
+	 */
+	int (*read_submit)(struct iomap_read_folio_ctx *ctx);
+};
+
+extern const struct iomap_read_ops iomap_read_bios_ops;
+
 /*
  * Flags for direct I/O ->end_io:
  */
-- 
2.47.3

