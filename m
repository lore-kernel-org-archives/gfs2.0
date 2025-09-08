Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8631C596
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357548; cv=none; b=ga6rH2nWsjd7Z84iJnSIlxMfeSK2PQKgheeI4qZkZ5/S9q03vZ9q0/Gcp0dVtdlZYHSBGI1XZ7O5PFP6z0PEHBjVWxV/19LvQAtlxP5IWJffU5vQ7NrVUrcnS0RnfhkhDL5B9eJrya/hP/Z9EGbjcr4ywG/OHBHI1rK8sH+c90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357548; c=relaxed/simple;
	bh=tuTPPcv0GhCEg9ZlUjj/sQ51KnHH3/BIZc7oNrNtdXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecqyYhZ//umAvd+NsosjItyyX0s6NP/qFbR/fqQcLO7g10jeSKhIIU6I9IC7iV5RzefT5HG0LcKopD8siZBvOemvLM5oELD/ZBxhxMxgILY4bA5v9T/qqGULzg6w0LdPNV0ae5P8LzOcfJLSSh5PxH26xER5R7lF801KUL+M0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnNqFzzW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnNqFzzW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-25221fa3c9bso15592135ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357546; x=1757962346; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goWt39Fkq+eCOLTjHWSeRjr3Nh1DdyDKEBWyEMT6i6I=;
        b=SnNqFzzWqAIrmhyit8Vdm8fw029951goEyMqgWyPpHAPpsI1WOHSSlMiiIYtEIkilF
         En4eWdhbasI8TVn2v5Rqm1JhXl2Y/aSlFPolXkumyeY5SO++70QaklUzxXoQraP+2x1h
         wUvjmqQii5l1fF5ArfybmrAKR4X2YdhnXYVng39l322OeF0OSlopnybxOyYhWf6E7Bt3
         ULGlCKlTwHYtGaLi/5hSocnBIlNhaGjHnygs2WE19wP/bkSKSm8126kep/F/EzW8hPxh
         muqHcj/3V56oU7JmV1jFyqu2bZfSvL4msNPxznXlCO6fE8pT3ro9HlPu/yG0LRH/gwc/
         7Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357546; x=1757962346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goWt39Fkq+eCOLTjHWSeRjr3Nh1DdyDKEBWyEMT6i6I=;
        b=TPtHurEWcM4FfB/9DCF7k5MEmA9k0nFiC6YWHdwpi7R351k9tDKWQ5OBOeUwQbvM2r
         FEqAIjDogkIDSmPVDud6U7826LLlaIoD61FtN9/XjKtQLxcT4bPQfusUDEsaSQBY4Hjg
         gI6uY95nSM+2pHuQoeeSuNuFAJNgWjRiYFBISXdnsH1HX9dIJ7tKST/lXpmjcQGzd3BZ
         cVUW1wegRsukOFd7UKVLaFTOwFklnF5tE3/HHs90z4AfyRhTBwcTiul/gKrt383aROPK
         nWQWKD1NzcZgjN4h2aql1/9FuI+xMYMaebeoSBuIdu6kjyXPEriQBdGRbwlBg7kl1NvD
         2eIg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKSiRjXh3K0RpuVF84BAEo8J8Rfo50kfjxFonsd+1J1fcIMdtlbJlV+ahdlrbwtLgUgJR@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj6dLPbOdPsTE7Lg8+c/nUy/RJBD2zbkImKEDJQf+NsbGoXLQm
	ecJXOjM0PvD36CVPH0Faxweid35p2Mx82Pj25tmugjVHm9PSF6OM9gh6
X-Gm-Gg: ASbGncuX+60xFFwrDi5/0ppjGZLZWWuee+lgQysC/6DpRfSAcRPGOZUZ9lME5kkSv3A
	ETTmD6G9pViFo2XspBE72lotMTzeTMxMqWCknBAp2iXbQit94Lhhn148AQbp2FnvIVHCjS2ldk7
	hLoNgjsHdDkPMjaVgV1TyctEMXlbvhpWznnsnsDAE6aGjsRTKNKbhj7cB1lk7CWz36+LqIoQvt/
	74WYGY6H350YHgnltw3x3oiL/esBWegGgq+7ZrOcFvlZvwssxBlm0hq0Rb9G/m9Qqih1v36bVSP
	0c7EHaZ8sjLBDKs4nrBZRpis14VKbw9xnorZ1Qn3yYqq/DtGanz9t0aZIXyGy8nEgt9r7cVhb1w
	nMjfeYgThrgRInAz7Eg==
X-Google-Smtp-Source: AGHT+IERAAhYd0bg8my/cBytIc4RRvJX/gC9A2p0elhQ8hhrMITVukT4Yx0WzfIBjBYY53LZCUNutA==
X-Received: by 2002:a17:903:22c3:b0:253:65e4:205f with SMTP id d9443c01a7336-25365e4e33dmr95057825ad.3.1757357545748;
        Mon, 08 Sep 2025 11:52:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm134446375ad.89.2025.09.08.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:25 -0700 (PDT)
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
Subject: [PATCH v2 06/16] iomap: iterate over entire folio in iomap_readpage_iter()
Date: Mon,  8 Sep 2025 11:51:12 -0700
Message-ID: <20250908185122.3199171-7-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges in a single call to
iomap_readpage_iter() instead of leaving the partial folio iteration to
the caller.

This will be useful for supporting caller-provided async folio read
callbacks (added in later commit) because that will require tracking
when the first and last async read request for a folio is sent, in order
to prevent premature read completion of the folio.

This additionally makes the iomap_readahead_iter() logic a bit simpler.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 67 ++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 51d204f0e077..fc8fa24ae7db 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -431,6 +431,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -442,39 +443,29 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
-	}
-
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, &length);
-}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos,
+				length, &poff, &plen);
+		count = pos - iter->pos + plen;
+		if (plen == 0)
+			return iomap_iter_advance(iter, &count);
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
+		}
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		length -= count;
+		ret = iomap_iter_advance(iter, &count);
 		if (ret)
 			return ret;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -493,7 +484,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_submit_read_bio(&ctx);
 
@@ -510,16 +501,16 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->folio_owned)
-				folio_unlock(ctx->cur_folio);
-			ctx->cur_folio = NULL;
-		}
-		if (!ctx->cur_folio) {
-			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->folio_owned = false;
-		}
+		if (ctx->cur_folio && !ctx->folio_owned)
+			folio_unlock(ctx->cur_folio);
+		ctx->cur_folio = readahead_folio(ctx->rac);
+		/*
+		 * We should never in practice hit this case since
+		 * the iter length matches the readahead length.
+		 */
+		if (WARN_ON_ONCE(!ctx->cur_folio))
+			return -EINVAL;
+		ctx->folio_owned = false;
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
 			return ret;
-- 
2.47.3

