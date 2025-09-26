Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154F1C700D
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846581; cv=none; b=VppAPRAdRHzdHRDWIKIn+UYru0pq4UONcYqx6rdyr7Qx/pi82hUTu9OhqvBHHzRGNNYvUgjQGNnjay9vY7kiFNftHOwfpFJ1XU3YgA7IQef0LdG3tdzjJX/aXWeBGueFUvqdhTg6b/ED2MKJc3I8Wv58O571uUFshSlgGT3nFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846581; c=relaxed/simple;
	bh=rt1isFInQxllpcfl3QCLI12GNpQ6cUlRy8gE36LhVIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcoYgUlrmYZrVnvGjYr8eZjkIt+qR2u29KHegrBesLJb7g2EOryW6+lMNy/UqvLkxTdZqag1mnH4HwIlszr0PFNM9I559l8viEbPcPFLz5TiG8891HantsfSCbafk0G5diuj8wmrglqDKFJjPfZZEuGECgHJr0Kjx//5IeH8ndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGa8vZRP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGa8vZRP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781001e3846so1567611b3a.2
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846579; x=1759451379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o90CilnlDORkQUotqZTiq4jbdbUEWuSngf/+jporYJA=;
        b=kGa8vZRPgBHy2jWyXHt526O20ybCwW69o7ZajcLGKyS8/hDW5kLg9U+gR/Vm4spiX5
         1PrwrybSfLdlb8b87Kjph6I0ISTlGW2xvCYZbUfvzeIM/ZN3Tt/TWAnwDjDH6mFiLazt
         95VC30dT9VK/5c+146KStCUQcuoTrhWXYva5qG7Bmpd8WwQsyQmKHQRmFFpJZNkw5IL1
         IFEGzzHF8MUsD3Pnvryp2PDbmuW+DQfH4wUSwvCOZVG5ioh7iDUnXz46V/iju86RO2ld
         +2jC7t40v38sH0tVUM95pR7qeqVukasxvQWASORSjfPRefE32uUXuV5NzozTCBSrD5sU
         1O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846579; x=1759451379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o90CilnlDORkQUotqZTiq4jbdbUEWuSngf/+jporYJA=;
        b=LxXl5ZH/MCHLzjx/BJER/w7AeHFnFBNeHybUfEqWDzC6E1dWzaFph3Ff6u0m/v4gLO
         LryNNPPoqmbC06/wR7VLQNt9kQCLwOU6rPn6xXpPoFSxVKU5IoHFQmUqXzDFljG++Ilg
         QdbR+URa0rB4wib2g3/hChd2+7nOqgyNVhQrsYK3tYztW7N7a3goF1WgSQPHVSKLaBri
         ETgkB34MU6oTVcuSgGJ2QAVnITJ3V2j4eCEQtxOlkfSt9eKzpG9SRQA5jjMyWdLPLWVm
         a3xjo7n56gLQ8fJd5FRuVJBCbacVgtzBXwmFNbLzCLQxexyBrawLuGG5JQtkE8dhOZr0
         IxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyngUWnMF/exTWfdmQU2ZHxY5EdAiWCY/E+gHa6OwkDIq+hQ5rOGiabRpxyqABS/wqwxU/@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4tJF7360hAI+rLCDPMgi+zAxzmygl1XMauysq3jCu5AoFd4oH
	Z8wLWK8rTVZx5cFEcQV8hOba9HhwZL7NNeP4WbmPsBvx1gVGTcwjbNqW
X-Gm-Gg: ASbGncsH82JNZpwYvLK98cUah7h+T5pddfbOv19saneuWTVosYRCWfv0g/iOaavhf34
	YMImWZdu7tINTGIgmSpdBXpl9eMYix3xaj2ukcBmQbrYl/wVs/PArLajWksHBAY9b2YvsEk5Odj
	LuodAvK+rgE7xSEN6bCdVeisWbWEj57jANmxvlVcjO19lZWXXftafd0bAnD99U+oegGTmvYzTqd
	mrHjf1+YzDOlJIJ6iiCw8nUgo4hOlgXmILF2DIJ9LNxKckKoVMYkxRMUAbZM/5yl3n//qxk+Y2p
	qKFUsqj/mpJ5xMDhEI7K/bzkoltq30EsEh3nZi37UInxPEEYBERUewBMJ/b2uJfhkNQim+fNn0K
	Q00OzjUNNX69GJtKpbitm7KPSbpnGMXjHbEjdh1I0qF50aalBqYCdyAQAMRM=
X-Google-Smtp-Source: AGHT+IEBDOXt6cQgXUZ/5vE62ev68j9buQADdEA7oY7aBRZUeKQTFam19nyr0TNNF/Czv5j7tK7UIw==
X-Received: by 2002:a05:6a00:1745:b0:77f:1b90:faaf with SMTP id d2e1a72fcca58-780fce29513mr5668896b3a.14.1758846578906;
        Thu, 25 Sep 2025 17:29:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2ab1dsm2902342b3a.100.2025.09.25.17.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 09/14] iomap: add caller-provided callbacks for read and readahead
Date: Thu, 25 Sep 2025 17:26:04 -0700
Message-ID: <20250926002609.1302233-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
	void *read_ctx;
  };

  where struct iomap_read_ops is defined as:

  struct iomap_read_ops {
      int (*read_folio_range)(const struct iomap_iter *iter,
                             struct iomap_read_folio_ctx *ctx,
                             size_t len);
      void (*read_submit)(struct iomap_read_folio_ctx *ctx);
  };

  read_folio_range() reads in the folio range and is required by the
  caller to provide. read_submit() is optional and is used for
  submitting any pending read requests.

* Modifies existing filesystems that use iomap for read and readahead to
  use the new API, through the new statically inlined helpers
  iomap_bio_read_folio() and iomap_bio_readahead(). There is no change
  in functionality for those filesystems.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 44 +++++++++++++
 block/fops.c                                  |  5 +-
 fs/erofs/data.c                               |  5 +-
 fs/gfs2/aops.c                                |  6 +-
 fs/iomap/buffered-io.c                        | 55 ++++++++--------
 fs/xfs/xfs_aops.c                             |  5 +-
 fs/zonefs/file.c                              |  5 +-
 include/linux/iomap.h                         | 63 ++++++++++++++++++-
 8 files changed, 149 insertions(+), 39 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 067ed8e14ef3..cef3c3e76e9e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -135,6 +135,28 @@ These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_DONTCACHE``: Turns on ``IOMAP_DONTCACHE``.
 
+``struct iomap_read_ops``
+--------------------------
+
+.. code-block:: c
+
+ struct iomap_read_ops {
+     int (*read_folio_range)(const struct iomap_iter *iter,
+                             struct iomap_read_folio_ctx *ctx, size_t len);
+     void (*submit_read)(struct iomap_read_folio_ctx *ctx);
+ };
+
+iomap calls these functions:
+
+  - ``read_folio_range``: Called to read in the range. This must be provided
+    by the caller. The caller is responsible for calling
+    iomap_finish_folio_read() after reading in the folio range. This should be
+    done even if an error is encountered during the read. This returns 0 on
+    success or a negative error on failure.
+
+  - ``submit_read``: Submit any pending read requests. This function is
+    optional.
+
 Internal per-Folio State
 ------------------------
 
@@ -182,6 +204,28 @@ The ``flags`` argument to ``->iomap_begin`` will be set to zero.
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
+    void *read_ctx;
+ };
+
+``iomap_readahead`` must set:
+ * ``ops->read_folio_range()`` and ``rac``
+
+``iomap_read_folio`` must set:
+ * ``ops->read_folio_range()`` and ``cur_folio``
+
+``ops->submit_read()`` and ``read_ctx`` are optional. ``read_ctx`` is used to
+pass in any custom data the caller needs accessible in the ops callbacks for
+fulfilling reads.
+
 Buffered Writes
 ---------------
 
diff --git a/block/fops.c b/block/fops.c
index ddbc69c0922b..a2c2391d8dfa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,12 +533,13 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	iomap_bio_read_folio(folio, &blkdev_iomap_ops);
+	return 0;
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	iomap_bio_readahead(rac, &blkdev_iomap_ops);
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..be4191b33321 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -371,7 +371,8 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	iomap_bio_read_folio(folio, &erofs_iomap_ops);
+	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
@@ -379,7 +380,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	iomap_bio_readahead(rac, &erofs_iomap_ops);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..38d4f343187a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -424,11 +424,11 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	int error;
+	int error = 0;
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		iomap_bio_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_bio_readahead(rac, &gfs2_iomap_ops);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 82bdf7c5e03c..9e1f1f0f8bf1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -328,8 +328,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 }
 
 #ifdef CONFIG_BLOCK
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -349,6 +349,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
 static void iomap_read_end_io(struct bio *bio)
 {
@@ -360,12 +361,6 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_read_folio_ctx {
-	struct folio		*cur_folio;
-	void			*read_ctx;
-	struct readahead_control *rac;
-};
-
 static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
@@ -374,7 +369,7 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 		submit_bio(bio);
 }
 
-static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -412,8 +407,15 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		bio_add_folio_nofail(bio, folio, plen, poff);
 		ctx->read_ctx = bio;
 	}
+	return 0;
 }
 
+const struct iomap_read_ops iomap_bio_read_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= iomap_bio_submit_read,
+};
+EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
+
 static void iomap_read_init(struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -508,7 +510,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			if (!*bytes_pending)
 				iomap_read_init(folio);
 			*bytes_pending += plen;
-			iomap_bio_read_folio_range(iter, ctx, plen);
+			ret = ctx->ops->read_folio_range(iter, ctx, plen);
+			if (ret)
+				return ret;
 		}
 
 		ret = iomap_iter_advance(iter, plen);
@@ -520,26 +524,25 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
 	size_t bytes_pending = 0;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx,
-				&bytes_pending);
+		iter.status = iomap_read_folio_iter(&iter, ctx, &bytes_pending);
 
-	iomap_bio_submit_read(&ctx);
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
 
 	iomap_read_end(folio, bytes_pending);
 
@@ -579,8 +582,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 
 /**
  * iomap_readahead - Attempt to read pages from a file.
- * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @ctx: The ctx used for issuing readahead.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -592,28 +595,28 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
 	size_t cur_bytes_pending;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx,
+		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_pending);
 
-	iomap_bio_submit_read(&ctx);
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
 
-	if (ctx.cur_folio)
-		iomap_read_end(ctx.cur_folio, cur_bytes_pending);
+	if (ctx->cur_folio)
+		iomap_read_end(ctx->cur_folio, cur_bytes_pending);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..0c2ed00733f2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -742,14 +742,15 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
+	return 0;
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..4d6e7eb52966 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,13 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	iomap_bio_read_folio(folio, &zonefs_read_iomap_ops);
+	return 0;
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_bio_readahead(rac, &zonefs_read_iomap_ops);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4469b2318b08..37435b912755 100644
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
@@ -337,8 +338,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
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
@@ -465,6 +468,8 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error);
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
@@ -473,6 +478,34 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
+struct iomap_read_folio_ctx {
+	const struct iomap_read_ops *ops;
+	struct folio		*cur_folio;
+	struct readahead_control *rac;
+	void			*read_ctx;
+};
+
+struct iomap_read_ops {
+	/*
+	 * Read in a folio range.
+	 *
+	 * The caller is responsible for calling iomap_finish_folio_read() after
+	 * reading in the folio range. This should be done even if an error is
+	 * encountered during the read.
+	 *
+	 * Returns 0 on success or a negative error on failure.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct iomap_read_folio_ctx *ctx, size_t len);
+
+	/*
+	 * Submit any pending read requests.
+	 *
+	 * This is optional.
+	 */
+	void (*submit_read)(struct iomap_read_folio_ctx *ctx);
+};
+
 /*
  * Flags for direct I/O ->end_io:
  */
@@ -538,4 +571,30 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 
 extern struct bio_set iomap_ioend_bioset;
 
+#ifdef CONFIG_BLOCK
+extern const struct iomap_read_ops iomap_bio_read_ops;
+
+static inline void iomap_bio_read_folio(struct folio *folio,
+		const struct iomap_ops *ops)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.cur_folio	= folio,
+	};
+
+	iomap_read_folio(ops, &ctx);
+}
+
+static inline void iomap_bio_readahead(struct readahead_control *rac,
+		const struct iomap_ops *ops)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.rac		= rac,
+	};
+
+	iomap_readahead(ops, &ctx);
+}
+#endif /* CONFIG_BLOCK */
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.3

