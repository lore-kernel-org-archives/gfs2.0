Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B9155A4E
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587637; cv=none; b=rS8ZE/kTHYENDil+M7RNIv133QYF3vSPQ+es+QufZKhxVypZK40k4lRbTBrzXxOzFlAtlmOk2asKgTiWyn3PD8pL8c2KE0iAFriimpcTkBG1qqg+eBAPN7/Os7vNRvTrJooTQDTrtk5SHfeIFrTPhG9WnhnSuOBII5iOukx0G7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587637; c=relaxed/simple;
	bh=EIuqb+bEXzHKheYSg8/gT99wnpLEGYyBUdzthx12unM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwrU6W0yad/BuWk3cB2jJoEmS5x14zbU0KxJrRODFelJeoPO85tWVxhKM/0Wfwxf8pMuNN2V5ovLTFQhzYzRL4XrKi0V4ZWny8Xg6jaKy494c6o6T7k3RLwBLebWWy09sa3jElGTOs7M7wMzu4euXjI+IHFJjWHJ28eU0XQEdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV9HHQaE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV9HHQaE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269af38418aso53749015ad.1
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587635; x=1759192435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=FV9HHQaEL+rxch0bU73pF0ZCx62g0MRt6EfhN5ZHQwhAtQ3NCTSWK46jjdQbimkV5J
         LYZiqUzIySkpdpUbZoj7z10j2kzgbdhtP1eCWoY6Gi5IBI5A4CfZ0fq4rYrvFhuJd6Ki
         o/+2wUnN2uqHlsM0WXFp5bawcvdh4eQzsVkdOqF7wPJtoSeACzz/DFm0Owt9FK7eJnzM
         bxM9Gq/RNTymTl9xq6J44iPjn7lQtBixLl0hiGKN0xZlkfEhhEC8CAIBeuW3w25k1WRI
         BubNBg6w2ALmtihQQX3YRFY6Em/MxH21bL9uAgMG6yH5obhzWIW/kKF2ZQO8W1q/jQX0
         1vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587635; x=1759192435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=UxVYYi04+277Bnndgq4WcCMtwfQu9lpoa/s4nEaiNNms2MI9ulrl7ONWD+rWpa04Lk
         MX3ZNXzdTUuTUMSZCAdK28QtmYyWlJKtTZQLRSO9WSPY8FjLo0+//F7ui6MvIAOfUMbn
         AsQeU+SiiUdM7guEhwpPs+1VHIt6FoPWoOiX7OW1a7nh4PREb7SdCkRkp9RXZnQaGhqI
         GeTJX5jqxY27SGv0Um6KVaZtP8MOkmMYZe+NZ0CefJKx6BnqWnL3xbGJPY7D4jQ5ncd9
         Rb29mp5toCsCLoiVemCaEmFSLjhKOQ1br5X9ZL+NKB6xKMkql++PvoHOSUYTQGqacglo
         qOKw==
X-Forwarded-Encrypted: i=1; AJvYcCUZo4TZgsxYarfpe2NmDwnDtyUM1wUqVjc2gNXZI6RQdtjbEfn4bQsLTHAiht7EmObPq/Nm@lists.linux.dev
X-Gm-Message-State: AOJu0YxgA/jcKVUsD0B2ceFmI0rLh8ufDATKQwnhCOhzwNSmrqnLsILk
	vguGfrz10C1OtvA0T5WfQKDRVtL1bSe6B7SH64XBEPne8gUP2jYbXe8IH7XuCg==
X-Gm-Gg: ASbGncuVtHJapaQe6mBvmDnrBjpvkVQ/KtiqB419RWEfCh9sqENUguoiF08w1OHxs4K
	SrkX1JLRDczD2jeodKG+Kg9E+VQJE4MxKID7LXZetUN7fDCfMC0vNFqfo6YLT1ec+lh80KFKlr/
	emyc/aJ5rlEcaYxHs0uI6bUzYYAI3Cvyj3irS3thQkbv/6DHFZyOySmLKh81EtrmWBVczJUXsw0
	wrEMiN85/i2fLu1B11mlzBPmUVDZSeFFlLXNbXXYLQVAWAsJs1fkawPesIx160aY7+bE3crg5gw
	gzAHQYUAVt7jpgfG/qYvHN1EoyPyeQz3g5a2Iu7cK0PHszltzlWJ/ltotS4h3Ltd+psWkf3rQgp
	f21hIofO160px7b3EVp+TmGp7xnZCUEHcT72jbPFgLV3E44AOYXQ54B8Puy0=
X-Google-Smtp-Source: AGHT+IFYTpNSjfUD4M2hqi+bqTZwEMz3Dj9iqDCa9q6c/0wRbqwF/PnO6+RzUOlJ1m1U0d+6bAdDOA==
X-Received: by 2002:a17:902:fc8f:b0:25c:982e:2b1d with SMTP id d9443c01a7336-27cc7da64famr8085685ad.59.1758587635368;
        Mon, 22 Sep 2025 17:33:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df446sm144936935ad.68.2025.09.22.17.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:55 -0700 (PDT)
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
Subject: [PATCH v4 02/15] iomap: move read/readahead bio submission logic into helper function
Date: Mon, 22 Sep 2025 17:23:40 -0700
Message-ID: <20250923002353.2961514-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper.
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7e65075b6345..f8b985bb5a6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,6 +367,14 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
+static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+{
+	struct bio *bio = ctx->bio;
+
+	if (bio)
+		submit_bio(bio);
+}
+
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
@@ -392,8 +400,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -488,13 +495,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+	iomap_bio_submit_read(&ctx);
+
+	if (!ctx.cur_folio_in_bio)
 		folio_unlock(folio);
-	}
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -560,12 +564,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	iomap_bio_submit_read(&ctx);
+
+	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3

