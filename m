Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC31D432D
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846582; cv=none; b=WrcKlvGSYHwY7DRCPh98l2l/67HllCop8MBUUYkQ+ksgkd+LORG865+Uz+rZup6g1uLJcgyjgZvG5tawKl0LeyyM6uhXkKTBBD8vXoQQUXXw1NujZyK7aR/awdMvsY3wWeRL2n8Diy5qUHbNsbVeKRC1eyE2k3AgX0B4QZyxXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846582; c=relaxed/simple;
	bh=O9qtDq9sFKUOE/lrS3Cg6/7mYSKjDy+Btt/lvfixp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uy5iqLy8xsz2EdYErSecrh3JdMXaTxYhCAOMN+FZd3B3xGFJo3hNNwC0PfsOk9V7V7Bbb9mSW9JqB3GX5yTtGbi1klTzNsr92p+7hMb27GXEXpjjOKEtsaEtBM6llfiyvdAsGEeL/acAKdTe3VWqTpSw6cnwlCzGehqYnM6r4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D34/qs+v; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D34/qs+v"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1375663a91.3
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846580; x=1759451380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/4IeqmlouwvNLMfxa0at9kmqfujKoN4n1TXu28g8B8=;
        b=D34/qs+vU5sbjOK+zvN4WnYBK1CfZwf31fzK4vkaMUlTV/bQjRqTryDmHuU/bLmOZP
         aI8dnA32mXBRXzht3IDf8cIZSGAulFks75rArPF5XCfqggQrsQafc/b1Bj+v3nDviQm0
         6tVYkbm7Uxdz3o0eR/cKcl/NO0MuNi6zludIJYsyJAkj16SbX4esaDQRScJOxTVY8G6O
         r8+Oz54JrN2YywxSCo/DGNFUuHMxKjTpPW8QLtqxxn/rWPdSgYhlt8vF1WbEwLw2SKPp
         pGyKNi49tTAZ+z5dbUvhte+u7Th7ebbeg2GRcTHVmr2SKTqrwFe4r/TO5tUGxNbVQWSi
         Redw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846580; x=1759451380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/4IeqmlouwvNLMfxa0at9kmqfujKoN4n1TXu28g8B8=;
        b=hwNezm1MCKwO3HPIgDfwwALrivpG9f8CCE58a34FtH++th5DOq6Kn3ktYsJOSCtN0p
         Tlisno9KqIr+e/N9zxfdx7jyTFVw95gqkMQMRy2qmQeF+tVB6qSl24YCkmJ668itoS0l
         kiR/2SVkfSRYCaGlrVDfPGuq2zgynUnwEhI4/wmd/gLOnD1HFlOwwXYQsxAtZdCjqjNG
         1iRa5zNVO1hmn8IF2ztVVDushcrTNMhs3LVguEEkv6PoqmYCkgSoTovqvTsnroQHjtPK
         s8dTORlftCoWZyn9O/afEbgu0Nt3R1AAXB1exg5dJbsz3wex8vXfkdGGClB2kY4Lkj1F
         l9kw==
X-Forwarded-Encrypted: i=1; AJvYcCUGq97h1P5LWsdWqYSHluoMx/B4qAG0ndPmg6FNQuchfuRNXxiqYS9Mae1mtfcC141K2gEl@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0LdL2aVAW6VHIOYlCZf2vKWyvz1oeBAClXoyvmT1g9KwvFiR5
	30FaDwZwlmwXptrjcmZ+BL23eIHQKYAbS7NPE+N5FqyPy/jgKD+3qeE7
X-Gm-Gg: ASbGncvD8V6c0Q8QOZAPeB8ABQxzSq5VUq/Nw7Ea+NQSfa3EVaTcdtZy7k48c1p090X
	HUGNg9sPF1G2u6ksyO6o+wrDbrYoCTL3f7U1ldDnJwN65VXEmt/f+vHXzdwIa9DOBIIuQRVfmXY
	QIzyNNDLUKnXL56MW6WxJrJHrXlhLxvojZkYoWUyjEtJJXD428MKonTNRQ66nPamzs1oMW6SzY2
	qGfo24RoNCPt3zDEUDX2iiYpHQkKUR8VH4gfuXX9Z35HKOjL+yAd+5cSI3Gp7EhgRuXX+Idz/47
	epr0CSKeCvHLk/RVrGYagyirSFAQlCrjLuEopHnjKeS+NVGgc3dvpHgDpZMig5GJTPEQ7Fg6fVs
	WCOq5GEXgmT1cxLnNyS0Btzf4s6Iqev5dRqMS8z3M33/yRlQeIY3Tb4hg8ns=
X-Google-Smtp-Source: AGHT+IGK08SudC1ue8d61NkvBaqPkfJvNpSbZRI9l5vMIq3ZUNqA0l07unaQN6AJWUPd13kK8xnVPA==
X-Received: by 2002:a17:90b:3e8a:b0:330:ba05:a799 with SMTP id 98e67ed59e1d1-3342a2613famr5258891a91.16.1758846580261;
        Thu, 25 Sep 2025 17:29:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be383b4sm7019912a91.27.2025.09.25.17.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:39 -0700 (PDT)
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
Subject: [PATCH v5 10/14] iomap: move buffered io bio logic into new file
Date: Thu, 25 Sep 2025 17:26:05 -0700
Message-ID: <20250926002609.1302233-11-joannelkoong@gmail.com>
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

From: Christoph Hellwig <hch@lst.de> [1]

Move bio logic in the buffered io code into its own file and remove
CONFIG_BLOCK gating for iomap read/readahead.

[1] https://lore.kernel.org/linux-fsdevel/aMK2GuumUf93ep99@infradead.org/

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/Makefile      |  3 +-
 fs/iomap/bio.c         | 88 ++++++++++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c | 88 +-----------------------------------------
 fs/iomap/internal.h    | 12 ++++++
 4 files changed, 103 insertions(+), 88 deletions(-)
 create mode 100644 fs/iomap/bio.c

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index f7e1c8534c46..a572b8808524 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -14,5 +14,6 @@ iomap-y				+= trace.o \
 iomap-$(CONFIG_BLOCK)		+= direct-io.o \
 				   ioend.o \
 				   fiemap.o \
-				   seek.o
+				   seek.o \
+				   bio.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
new file mode 100644
index 000000000000..fc045f2e4c45
--- /dev/null
+++ b/fs/iomap/bio.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (C) 2016-2023 Christoph Hellwig.
+ */
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include "internal.h"
+#include "trace.h"
+
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
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
+{
+	struct bio *bio = ctx->read_ctx;
+
+	if (bio)
+		submit_bio(bio);
+}
+
+static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, size_t plen)
+{
+	struct folio *folio = ctx->cur_folio;
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	size_t poff = offset_in_folio(folio, pos);
+	loff_t length = iomap_length(iter);
+	sector_t sector;
+	struct bio *bio = ctx->read_ctx;
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
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+				     gfp);
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
+		ctx->read_ctx = bio;
+	}
+	return 0;
+}
+
+const struct iomap_read_ops iomap_bio_read_ops = {
+	.read_folio_range = iomap_bio_read_folio_range,
+	.submit_read = iomap_bio_submit_read,
+};
+EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
+
+int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct bio_vec bvec;
+	struct bio bio;
+
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
+	return submit_bio_wait(&bio);
+}
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9e1f1f0f8bf1..86c8094e5cc8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -8,6 +8,7 @@
 #include <linux/writeback.h>
 #include <linux/swap.h>
 #include <linux/migrate.h>
+#include "internal.h"
 #include "trace.h"
 
 #include "../internal.h"
@@ -327,7 +328,6 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
-#ifdef CONFIG_BLOCK
 void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		int error)
 {
@@ -351,71 +351,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
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
-static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
-{
-	struct bio *bio = ctx->read_ctx;
-
-	if (bio)
-		submit_bio(bio);
-}
-
-static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t plen)
-{
-	struct folio *folio = ctx->cur_folio;
-	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	size_t poff = offset_in_folio(folio, pos);
-	loff_t length = iomap_length(iter);
-	sector_t sector;
-	struct bio *bio = ctx->read_ctx;
-
-	sector = iomap_sector(iomap, pos);
-	if (!bio || bio_end_sector(bio) != sector ||
-	    !bio_add_folio(bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		iomap_bio_submit_read(ctx);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
-				     gfp);
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
-		ctx->read_ctx = bio;
-	}
-	return 0;
-}
-
-const struct iomap_read_ops iomap_bio_read_ops = {
-	.read_folio_range	= iomap_bio_read_folio_range,
-	.submit_read		= iomap_bio_submit_read,
-};
-EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
-
 static void iomap_read_init(struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -620,27 +555,6 @@ void iomap_readahead(const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
-		struct folio *folio, loff_t pos, size_t len)
-{
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct bio_vec bvec;
-	struct bio bio;
-
-	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
-	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
-	return submit_bio_wait(&bio);
-}
-#else
-static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
-		struct folio *folio, loff_t pos, size_t len)
-{
-	WARN_ON_ONCE(1);
-	return -EIO;
-}
-#endif /* CONFIG_BLOCK */
-
 /*
  * iomap_is_partially_uptodate checks whether blocks within a folio are
  * uptodate or not.
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index d05cb3aed96e..3a4e4aad2bd1 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -6,4 +6,16 @@
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
+#ifdef CONFIG_BLOCK
+int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len);
+#else
+static inline int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+#endif /* CONFIG_BLOCK */
+
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.3

