Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672431C59A
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357550; cv=none; b=uTpaRGmhx/NkOJ82unolWiM2Mvq5n4smCRcKNkzXXnEb2h37OAfO3++pI4V3Tlrbv8hWXyJWWlNh5hg+UsItB1WbnluhJEWTrQwnrO0Cf0rT9RGbxjesQ6ZWP5rxLrcbWppmJtgGIh7VsT04Epb6nWon5tMLngD7bSC4EaP2b9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357550; c=relaxed/simple;
	bh=6XccISsz+ntFq8fevte/A5CjKeD+krT4OR6S/88mrlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AB9S4MTLrH7j2BD1fnm1Vxd3zy+mTQLBXHvJ74dqEZYIq7NSjrzfTt+YYkk9bR4KLGMLga0R8bt8idQ+t/caOPLdmQYrfPTXGu6C/cofg+76lTce69KMYFifDqhtAIwzNtMBQgPEXOUnMgoKxg/V9q942pAapUBTPsUz7FCl7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqkEnoo3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqkEnoo3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cbd9d9f09so63336075ad.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357549; x=1757962349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOMiqM1QeSbN4ac7J913ToJx9WAvKVveBeJyEZuKF2U=;
        b=DqkEnoo35BzxRGe1yWoDmq0YC6MGEYZXkD216G8b+azPOpf06YkNpU0TaFqkIp3uie
         IfKjc0GBcesMDCGGTZqxmIjjIJBHcczOzXqIHjtWwNOfUbX0z+rCDhcO3G5n02hkTGoM
         K/SmAwFJ475D7rzBRgjznUFRKWE3fnG6pXjtUY58U2XezM/mnO1ZsVAQYT954l2tLJwf
         rsgXFbRZw2MDHtDDhfkq+RyFYmvRN9yIRLJG04w3R0A42+wiroG8dRwoBRR7ieKUqHKt
         Jcvz7GXW6yqU9SAzMKNUwUq1lDdssx6KA3RRg1mONPlSH3bC1rhEpKeMuZIuWyTHvFi0
         qINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357549; x=1757962349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOMiqM1QeSbN4ac7J913ToJx9WAvKVveBeJyEZuKF2U=;
        b=gHf1rwa6yuPFbEa74r9dO7JbKiB2AOS+UoTqrmneOGV1jtm5DS9/xZDOd80+x4Au9A
         kHlGqfc9br6Iin0+inqqzbmDLonYkrvr/exWi7vH/3p872f0HGTi3nIMpxq/Kg0OFZPr
         F6uwFPki+FLtsJj6NRkkYjgKoB82p24VDb12XL32dzTvv/1NHknLmPnMLWyW4nntwh67
         vgcf8WJ9K7++V15JvEQcI9C+6EKp5zwCpgS5Nf9iqPFfV7U/ekSoSYQ1CvRT6ro8quZ5
         hKw+gwkBMlFVTGEYPJNd5HkrQNibikCsjxgHIW04+Awo0ERYr/zLh2qecoeYTViWGHZH
         HPGA==
X-Forwarded-Encrypted: i=1; AJvYcCXrfSFGSdJ1zLT2bHSjg+eMMy83zQNyf9cxTi73qG59T3mSYWzozzLwlH/wviJMM67bpIMH@lists.linux.dev
X-Gm-Message-State: AOJu0YyvWiFCQscvEWAFKxK2J3kXSiEgbNw8UVQy89Cqv9buaQDAR0G3
	aWOozoFZD1rrwu1AZJw5bPAmnsZoWIwgNR1zveWwUZVNkCHevKMCt8XV
X-Gm-Gg: ASbGncs2r2HqMaTsTU6H+wz7Nh9nOc8OyuY5BiCkKzTnBEH1EegYE4Eoy4M4+hTc+Dw
	t3MzOJpNBQm238u4fknPI3YA/sNT2tTbk5+DVUg5bWt7P4CftK22RnDMI7ZnWlwMTEGNQQVY4sh
	5vebCjdhkzDdH6Ho46D6OKWnxG8aY8DDOjJ7ByooBNQf2D/LWR4DekUlOwHKu5fi6j8vArY7DaV
	BdgSi1LirYkgD6xuxQd+J2gdDnf/NE9oZDvpHKkY5o98Vs1FztmS0PhE4wWt1pK9mXy7MFosFzR
	5RGV52DO1a+7g8gdn+DgeRj1s+IFdy25zTSkPXmIxTu14ag6BVn+Vl93vw+BMXIwsq+iA/yHaoX
	lqJ0m5Iu0fN5fCpvALw==
X-Google-Smtp-Source: AGHT+IHi1MFyQZT07vphTAJQQWiqcbxVXuRnoTuCifv2FfLggyElxludiM3V7rni+FTWE8DVZOm1MQ==
X-Received: by 2002:a17:903:1c2:b0:249:1213:6725 with SMTP id d9443c01a7336-251753d88d0mr123342085ad.50.1757357548763;
        Mon, 08 Sep 2025 11:52:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc56ec1sm117436505ad.59.2025.09.08.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:28 -0700 (PDT)
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
Subject: [PATCH v2 08/16] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Mon,  8 Sep 2025 11:51:14 -0700
Message-ID: <20250908185122.3199171-9-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c376a793e4c5..008042108c68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -350,7 +350,7 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	/*
 	 * Is the folio owned by this readpage context, or by some
@@ -362,7 +362,7 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
+static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->private;
 
@@ -377,7 +377,7 @@ static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
  * Buffered writes must read in the folio synchronously.
  */
 static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -424,7 +424,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -476,7 +476,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -496,7 +496,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -541,7 +541,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3

