Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9322B8C5
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731789; cv=none; b=Nv0PrHRLO4Sua5UUxb4UFzLZDeyaVTjGhpQKp1TuovBY7Hg3UksHUZODZCXHqpZDwCoBHWpZEp2lesnyzijEoDKVeoe/gTFMaEhLqSHibqG8WrmVjyVfTUT16h1Ef0TwKnk4VWxfzWnNgMQBQr5d3i4HxvV5sMYOt3xCmofkHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731789; c=relaxed/simple;
	bh=3nKlE5VC0LlEbV7ukou8eVdPj4LvKIiAtYaDhhdxxPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THRPhxORsdPsZu/sPdXAXvlmnhzOFSk8XwDBfnj12ZhJ0sW2RCosxbbVaxMU9BI6F2Z7SLoBLq4SDqFHzv+BRLoySBUDPeHcXOY6+Op0X+vpZ7uCYg1hvdgm3bD9LE4/G28jRN8+Vo7p5Qmfi1QNlY4tZfSQHHTH5jfAUXmCTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjUcf7Pe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjUcf7Pe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235a3dd4f0dso33196915ad.0
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731786; x=1751336586; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOybouhKwFglQApl9HPGZaZZkkV0YHgnyDvNFgjI7c=;
        b=CjUcf7PeuAOROVYvtC2g6QNy6lUKpCAX2e3TelvRCGtX1stwDuHtYeaB7pCKwKBJJl
         qglPZHklbj/44E16vaxDCJY2hc9jFMKdR4rMZJTPyH98c1Ska+7ZYICnKgPoPf/DuicK
         qdrdOV0XcX+DXpJwh9LTq+w1Np4jGs3LrHcSgS1Gv9Ny6zrxgSJXxB1zJ3p80r6SsidX
         L2Q4DtKVAML5qwVml6fB4zvtTqVyGaK+vHoXQFSb7kD/AMGBobwnGhDjaA51xotcfuBJ
         4Jde2AVuiwzI9z+xcDz0ymchXDJXY2M7uKcelUJuvnRHqq2PSU0RUdBGJjfCau5ST7In
         JuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731786; x=1751336586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOybouhKwFglQApl9HPGZaZZkkV0YHgnyDvNFgjI7c=;
        b=aip6toBdFrGLgneaZFnjYDi419cwvbcasIUFusa0vAqHVQ3ls11ssZ2h3LFH7idqxo
         oht5vd1ZU06if4gTtLCK88+Y+O4OWW3gkUL/SutVe4LQgu0ct2iVg4Q7Y1EOT6fGVa3m
         f9eUwTc7CAlTQDAREb72u2IEPkqj2ICoKq6lVjqQm7AMULn5p62BUDXdkMLmF4+kXHZk
         tIw1Inozf7qBpOAQW/czaOkUoKsYmM/8IdMVD6/3v7d2+UOfRqhlhtbaELBhE/vYbbho
         is9WVUlQ5tOTHX3hMpjgu1XxT/UN6btV/F76QFUjQScblJYcEeFnc0/Q2lgFHHZdByte
         DOGw==
X-Forwarded-Encrypted: i=1; AJvYcCXbIENGgOpiCthM174EFSeZoRJbdSQt8yKzx9QmlS1TceE7BA09EY4V8VGR0Ff//4RS6vL+@lists.linux.dev
X-Gm-Message-State: AOJu0YyHoPs23HoY6DzUvZvqd3zO9Hw3SQVG/ciSykJmCciWlCnXN9Ou
	FPtOKzp5VPqRqLF1JXOeReNu4Z3DPXqZz381dOzaaTVOohy3PnD2JJJR
X-Gm-Gg: ASbGnct5CmZfzIfEw5ha6iZbRycDnBK5VG0s5BLwCdsWHmf5Bs1ZLcn5YlpP7yHTJm6
	VCFUi/JLO5lxuYVS0/XlBng0E+1veprl/btMcJnPTf867Qq/XZxyauRetuPC54Fney+g6qL4IOj
	u5IRrfTxZAeUUFuoxxW4JhjAvg2dp/SlIWRYVAn8adt/im50vGS5pbG4rPepxD+0TTmW39qWtxZ
	tSUj+RQ4Q4l9ZCftul7kenVdXaHnBmQCfUMy0qHI8b+RgrOyCw24SfthLBO1wU+u+Mu46XczP9T
	Rn/A3yYNNTunCpWOX+rTFG26ZEoPV511imS4/genHlwMFknIvS5Ij1v4
X-Google-Smtp-Source: AGHT+IFjWXyeSBB4vEagfFJo66emyHzDoUCphjpNXBVkkpqo5GR1of5TgEWph3TLmAvUPBoNfbYFHQ==
X-Received: by 2002:a17:903:2d0:b0:220:ea90:191e with SMTP id d9443c01a7336-237d96dfe20mr224271575ad.4.1750731786251;
        Mon, 23 Jun 2025 19:23:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867df7asm93037765ad.178.2025.06.23.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 06/16] iomap: move all ioend handling to ioend.c
Date: Mon, 23 Jun 2025 19:21:25 -0700
Message-ID: <20250624022135.832899-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Now that the writeback code has the proper abstractions, all the ioend
code can be self-contained in ioend.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 215 ----------------------------------------
 fs/iomap/internal.h    |   1 -
 fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 219 insertions(+), 217 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b4a8d2241d70..c262f883f9f9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1559,221 +1559,6 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
-/*
- * We're now finished for good with this ioend structure.  Update the page
- * state, release holds on bios, and finally free up memory.  Do not use the
- * ioend after this.
- */
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
-{
-	struct inode *inode = ioend->io_inode;
-	struct bio *bio = &ioend->io_bio;
-	struct folio_iter fi;
-	u32 folio_count = 0;
-
-	if (ioend->io_error) {
-		mapping_set_error(inode->i_mapping, ioend->io_error);
-		if (!bio_flagged(bio, BIO_QUIET)) {
-			pr_err_ratelimited(
-"%s: writeback error on inode %lu, offset %lld, sector %llu",
-				inode->i_sb->s_id, inode->i_ino,
-				ioend->io_offset, ioend->io_sector);
-		}
-	}
-
-	/* walk all folios in bio, ending page IO on them */
-	bio_for_each_folio_all(fi, bio) {
-		iomap_finish_folio_write(inode, fi.folio, fi.length);
-		folio_count++;
-	}
-
-	bio_put(bio);	/* frees the ioend */
-	return folio_count;
-}
-
-static void ioend_writeback_end_bio(struct bio *bio)
-{
-	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
-
-	ioend->io_error = blk_status_to_errno(bio->bi_status);
-	iomap_finish_ioend_buffered(ioend);
-}
-
-/*
- * We cannot cancel the ioend directly in case of an error, so call the bio end
- * I/O handler with the error status here to run the normal I/O completion
- * handler.
- */
-int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-
-	if (!ioend->io_bio.bi_end_io)
-		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
-
-	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
-		error = -EIO;
-
-	if (error) {
-		ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&ioend->io_bio);
-		return error;
-	}
-
-	submit_bio(&ioend->io_bio);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ioend_writeback_submit);
-
-static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		loff_t pos, u16 ioend_flags)
-{
-	struct bio *bio;
-
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
-			       GFP_NOFS, &iomap_ioend_bioset);
-	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
-	bio->bi_write_hint = wpc->inode->i_write_hint;
-	wbc_init_bio(wpc->wbc, bio);
-	wpc->nr_folios = 0;
-	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
-}
-
-static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
-		u16 ioend_flags)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-
-	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
-		return false;
-	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
-	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
-		return false;
-	if (pos != ioend->io_offset + ioend->io_size)
-		return false;
-	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
-	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
-		return false;
-	/*
-	 * Limit ioend bio chain lengths to minimise IO completion latency. This
-	 * also prevents long tight loops ending page writeback on all the
-	 * folios in the ioend.
-	 */
-	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
-		return false;
-	return true;
-}
-
-/*
- * Test to see if we have an existing ioend structure that we could append to
- * first; otherwise finish off the current ioend and start another.
- *
- * If a new ioend is created and cached, the old ioend is submitted to the block
- * layer instantly.  Batching optimisations are provided by higher level block
- * plugging.
- *
- * At the end of a writeback pass, there will be a cached ioend remaining on the
- * writepage context that the caller will need to submit.
- */
-ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
-		loff_t pos, loff_t end_pos, unsigned int dirty_len)
-{
-	struct iomap_ioend *ioend = wpc->wb_ctx;
-	size_t poff = offset_in_folio(folio, pos);
-	unsigned int ioend_flags = 0;
-	unsigned int map_len = min_t(u64, dirty_len,
-		wpc->iomap.offset + wpc->iomap.length - pos);
-	int error;
-
-	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
-
-	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
-
-	switch (wpc->iomap.type) {
-	case IOMAP_INLINE:
-		WARN_ON_ONCE(1);
-		return -EIO;
-	case IOMAP_HOLE:
-		return map_len;
-	default:
-		break;
-	}
-
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
-		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
-	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
-		ioend_flags |= IOMAP_IOEND_BOUNDARY;
-
-	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
-new_ioend:
-		if (ioend) {
-			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
-				return error;
-		}
-		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
-	}
-
-	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
-		goto new_ioend;
-
-	iomap_start_folio_write(wpc->inode, folio, map_len);
-
-	/*
-	 * Clamp io_offset and io_size to the incore EOF so that ondisk
-	 * file size updates in the ioend completion are byte-accurate.
-	 * This avoids recovering files with zeroed tail regions when
-	 * writeback races with appending writes:
-	 *
-	 *    Thread 1:                  Thread 2:
-	 *    ------------               -----------
-	 *    write [A, A+B]
-	 *    update inode size to A+B
-	 *    submit I/O [A, A+BS]
-	 *                               write [A+B, A+B+C]
-	 *                               update inode size to A+B+C
-	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
-	 *    <power failure>
-	 *
-	 *  After reboot:
-	 *    1) with A+B+C < A+BS, the file has zero padding in range
-	 *       [A+B, A+B+C]
-	 *
-	 *    |<     Block Size (BS)   >|
-	 *    |DDDDDDDDDDDD0000000000000|
-	 *    ^           ^        ^
-	 *    A          A+B     A+B+C
-	 *                       (EOF)
-	 *
-	 *    2) with A+B+C > A+BS, the file has zero padding in range
-	 *       [A+B, A+BS]
-	 *
-	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
-	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
-	 *    ^           ^             ^           ^
-	 *    A          A+B           A+BS       A+B+C
-	 *                             (EOF)
-	 *
-	 *    D = Valid Data
-	 *    0 = Zero Padding
-	 *
-	 * Note that this defeats the ability to chain the ioends of
-	 * appending writes.
-	 */
-	ioend->io_size += map_len;
-	if (ioend->io_offset + ioend->io_size > end_pos)
-		ioend->io_size = end_pos - ioend->io_offset;
-
-	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
-	return map_len;
-}
-EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
-
 static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
 		bool *wb_pending)
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index f6992a3bf66a..d05cb3aed96e 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -4,7 +4,6 @@
 
 #define IOEND_BATCH_SIZE	4096
 
-u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 
 #endif /* _IOMAP_INTERNAL_H */
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 18894ebba6db..81f4bac5a3a9 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2024-2025 Christoph Hellwig.
+ * Copyright (c) 2016-2025 Christoph Hellwig.
  */
 #include <linux/iomap.h>
 #include <linux/list_sort.h>
+#include <linux/pagemap.h>
+#include <linux/writeback.h>
 #include "internal.h"
+#include "trace.h"
 
 struct bio_set iomap_ioend_bioset;
 EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
@@ -28,6 +31,221 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(iomap_init_ioend);
 
+/*
+ * We're now finished for good with this ioend structure.  Update the folio
+ * state, release holds on bios, and finally free up memory.  Do not use the
+ * ioend after this.
+ */
+static u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
+{
+	struct inode *inode = ioend->io_inode;
+	struct bio *bio = &ioend->io_bio;
+	struct folio_iter fi;
+	u32 folio_count = 0;
+
+	if (ioend->io_error) {
+		mapping_set_error(inode->i_mapping, ioend->io_error);
+		if (!bio_flagged(bio, BIO_QUIET)) {
+			pr_err_ratelimited(
+"%s: writeback error on inode %lu, offset %lld, sector %llu",
+				inode->i_sb->s_id, inode->i_ino,
+				ioend->io_offset, ioend->io_sector);
+		}
+	}
+
+	/* walk all folios in bio, ending page IO on them */
+	bio_for_each_folio_all(fi, bio) {
+		iomap_finish_folio_write(inode, fi.folio, fi.length);
+		folio_count++;
+	}
+
+	bio_put(bio);	/* frees the ioend */
+	return folio_count;
+}
+
+static void ioend_writeback_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
+
+	ioend->io_error = blk_status_to_errno(bio->bi_status);
+	iomap_finish_ioend_buffered(ioend);
+}
+
+/*
+ * We cannot cancel the ioend directly in case of an error, so call the bio end
+ * I/O handler with the error status here to run the normal I/O completion
+ * handler.
+ */
+int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	if (!ioend->io_bio.bi_end_io)
+		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
+
+	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
+		error = -EIO;
+
+	if (error) {
+		ioend->io_bio.bi_status = errno_to_blk_status(error);
+		bio_endio(&ioend->io_bio);
+		return error;
+	}
+
+	submit_bio(&ioend->io_bio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ioend_writeback_submit);
+
+static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
+		loff_t pos, u16 ioend_flags)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
+			       GFP_NOFS, &iomap_ioend_bioset);
+	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
+	bio->bi_write_hint = wpc->inode->i_write_hint;
+	wbc_init_bio(wpc->wbc, bio);
+	wpc->nr_folios = 0;
+	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
+}
+
+static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
+		u16 ioend_flags)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+
+	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
+		return false;
+	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
+		return false;
+	if (pos != ioend->io_offset + ioend->io_size)
+		return false;
+	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
+	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
+		return false;
+	/*
+	 * Limit ioend bio chain lengths to minimise IO completion latency. This
+	 * also prevents long tight loops ending page writeback on all the
+	 * folios in the ioend.
+	 */
+	if (wpc->nr_folios >= IOEND_BATCH_SIZE)
+		return false;
+	return true;
+}
+
+/*
+ * Test to see if we have an existing ioend structure that we could append to
+ * first; otherwise finish off the current ioend and start another.
+ *
+ * If a new ioend is created and cached, the old ioend is submitted to the block
+ * layer instantly.  Batching optimisations are provided by higher level block
+ * plugging.
+ *
+ * At the end of a writeback pass, there will be a cached ioend remaining on the
+ * writepage context that the caller will need to submit.
+ */
+ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
+		loff_t pos, loff_t end_pos, unsigned int dirty_len)
+{
+	struct iomap_ioend *ioend = wpc->wb_ctx;
+	size_t poff = offset_in_folio(folio, pos);
+	unsigned int ioend_flags = 0;
+	unsigned int map_len = min_t(u64, dirty_len,
+		wpc->iomap.offset + wpc->iomap.length - pos);
+	int error;
+
+	trace_iomap_add_to_ioend(wpc->inode, pos, dirty_len, &wpc->iomap);
+
+	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+
+	switch (wpc->iomap.type) {
+	case IOMAP_INLINE:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	case IOMAP_HOLE:
+		return map_len;
+	default:
+		break;
+	}
+
+	if (wpc->iomap.type == IOMAP_UNWRITTEN)
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
+		ioend_flags |= IOMAP_IOEND_SHARED;
+	if (folio_test_dropbehind(folio))
+		ioend_flags |= IOMAP_IOEND_DONTCACHE;
+	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+
+	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+new_ioend:
+		if (ioend) {
+			error = wpc->ops->writeback_submit(wpc, 0);
+			if (error)
+				return error;
+		}
+		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
+	}
+
+	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
+		goto new_ioend;
+
+	iomap_start_folio_write(wpc->inode, folio, map_len);
+
+	/*
+	 * Clamp io_offset and io_size to the incore EOF so that ondisk
+	 * file size updates in the ioend completion are byte-accurate.
+	 * This avoids recovering files with zeroed tail regions when
+	 * writeback races with appending writes:
+	 *
+	 *    Thread 1:                  Thread 2:
+	 *    ------------               -----------
+	 *    write [A, A+B]
+	 *    update inode size to A+B
+	 *    submit I/O [A, A+BS]
+	 *                               write [A+B, A+B+C]
+	 *                               update inode size to A+B+C
+	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
+	 *    <power failure>
+	 *
+	 *  After reboot:
+	 *    1) with A+B+C < A+BS, the file has zero padding in range
+	 *       [A+B, A+B+C]
+	 *
+	 *    |<     Block Size (BS)   >|
+	 *    |DDDDDDDDDDDD0000000000000|
+	 *    ^           ^        ^
+	 *    A          A+B     A+B+C
+	 *                       (EOF)
+	 *
+	 *    2) with A+B+C > A+BS, the file has zero padding in range
+	 *       [A+B, A+BS]
+	 *
+	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
+	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
+	 *    ^           ^             ^           ^
+	 *    A          A+B           A+BS       A+B+C
+	 *                             (EOF)
+	 *
+	 *    D = Valid Data
+	 *    0 = Zero Padding
+	 *
+	 * Note that this defeats the ability to chain the ioends of
+	 * appending writes.
+	 */
+	ioend->io_size += map_len;
+	if (ioend->io_offset + ioend->io_size > end_pos)
+		ioend->io_size = end_pos - ioend->io_offset;
+
+	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
+	return map_len;
+}
+EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
+
 static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 {
 	if (ioend->io_parent) {
-- 
2.47.1

