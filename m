Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E481A5BBE
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357540; cv=none; b=qE+0+biheZlltO/s1lyuNdLwBzFZ6XFIL/kIyRA0jK6xa291tbC63t5pdiY9TPjR/7hCF0sPXBYaTj8WHBKXLNI76QVrTt69ZLBxSqBzssuAEGiAweC2gkrRaMuwuFixwwvdV39pcaY64jYbnBkz4dRlVpETN4/coboE9xOWsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357540; c=relaxed/simple;
	bh=mKseg24DgTQpi06pk2MwjDbMG0wYTGbtYibipXYcGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HibsU5PfZ+ZklWQDtPwCMuVSzd4WSzuq8NJmPa0Ywo9LnL+GCwN3hioudHdXeZ5xWhXfbsfZox/3xyfKYRylYlPohP4r9FvU3DZYWYEO4RkjE2tf0+FTpavVO0Omb0aMb+ERRnBivT9LtYImDPc4h1sQVv9C2/lzV/AgGdLXpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLXKZisO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLXKZisO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so3963940b3a.3
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357538; x=1757962338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIeVhf/GaWLdHkNpayC1qTsZDGwWA9sTHoMGLVj+54s=;
        b=aLXKZisOILO0hjikcfu8bbettB8z8CF0j66EhGzWX7XLutqpr2fI/or+2uGmCqKpIR
         JrkU55cepyZd0lIlLxyOZ34ii9YsLBaGg2omCUYmXjTxPOqRyqAKLH1YHmpYdxkt1uXS
         z+Mg3C+yd/5nDuKGt2dSjzxmAZ7M8z2ql7XshC655EMfFaeru4f/l0NRsUmX7XkC3hz6
         ohsZCzrckgvygWjWQ8Sb14/9ZxRNTZvr6TX8Lx5RcDUe+86c5ygydx8ts/loP12Sg+WY
         KNMxuYXzovGDjYb2ctT5rl5HlmgsPxTlc1awVCS2Bt58shoyVltFHR9R5MCP0F8f1+Ks
         FwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357538; x=1757962338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIeVhf/GaWLdHkNpayC1qTsZDGwWA9sTHoMGLVj+54s=;
        b=i8ZIbUL2/asTTyuIdRi6GDM8KQDS6olNrwQCsbfYhBKgZx2YE3T7do8oRaEHSzq1K9
         86thwZV6f1lc0OfU3FmnGSl1OKC3smWGISW9Xw/UfpFnxqIUrFxqiIwgDLRhNwE4Jydm
         gGsXbCoVAo3FqnGiBPGIrJO6lFqpoS4Pgrpo33MCW9DKQbUuuGZD50xpX0xKlrfAYV5Y
         K8g1affk2UlC2BUG+lv8yAjdIIvkuJRHZv2bWrtc4ptf3nO1h6BsVtSY8D9m60LTZF3d
         ngAH4kmfwiLe9M8KxHIHh4vreqFt0pehG3Gk1U8iUlHyJVWu+2W5IAJDoXXC5HDr8Tlb
         ba6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGWriU4d29kbOSYhNsIdbiiT617CndUGRxaBlgtcetKj+ycNbyWwGKF4GyhpZ6ZBnImIvk@lists.linux.dev
X-Gm-Message-State: AOJu0Ywzk73Uitanqazz41IxkMqZzavEr0UXVJwCq49LzBWzZ7k53ABU
	xMlcMimKrvOzZgsaB35Ux6DdxIoIWgmPQw/8ExMMdRyrIRcY2mcESnjdEy9TnQ==
X-Gm-Gg: ASbGnctYGj18UBK3t/GC6oI+gCdlfS5PbN17Vrh20YQPZQW3gQrBPlgHl29J9I083UG
	GKxCLmErkRn/YY+4KcnfXV0U5Mzd9KNL5fK8Dq1RT12EOLb0KcJumv9U3cnzXxBYwzaWWBRtdEy
	Fva7q8t6SnKKRsmOs0Bs6hCTbrlzeZmi0PnRBmQGIPYMUPOF2OI5sKsZrGiDoh1XBS0xeGG1j+o
	pEUVMZGTkmKgyreDFSk/GA2kyk/Tzie9GYAgAf4CnVzS25mvEPaw1AQtZz8z4TlGbUGb9+yrpl+
	rxet4T3n8Q4ydOPDl32bvIBWiGFtLwtD9crZogRsLbQMmLDB9uqEV4vbDXqOeNGhq4ahNJIC3TO
	qmXehcmZmSu1z9PKD4w==
X-Google-Smtp-Source: AGHT+IHIeFc3reqItOkoNY6BMOQV0VjpxZyofFhYsEk3kbis5gUV4G41jZkE1649r+xsPMAzeYbqbA==
X-Received: by 2002:a05:6a20:3d89:b0:246:f1:bec3 with SMTP id adf61e73a8af0-25344415094mr12739543637.42.1757357537850;
        Mon, 08 Sep 2025 11:52:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b617b104csm16042737a91.21.2025.09.08.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:17 -0700 (PDT)
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
Subject: [PATCH v2 01/16] iomap: move async bio read logic into helper function
Date: Mon,  8 Sep 2025 11:51:07 -0700
Message-ID: <20250908185122.3199171-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() async bio read logic into a separate
helper function. This is needed to make iomap read/readahead more
generically usable, especially for filesystems that do not require
CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..13854fb6ad86 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,21 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+/**
+ * Read in a folio range asynchronously through bios.
+ *
+ * This should only be used for read/readahead, not for buffered writes.
+ * Buffered writes must read in the folio synchronously.
+ */
+static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
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
-		return iomap_iter_advance(iter, &length);
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
@@ -425,6 +410,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		return iomap_iter_advance(iter, &length);
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
+		iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
-- 
2.47.3

