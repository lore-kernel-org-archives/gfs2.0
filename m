Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3778635C
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846570; cv=none; b=qJiB60RoF2y1aVwRKI7FQiiv5+C/AL7IWWMgjWFrH0rgKj8l3DUpqpO4FjMb6g7LU3yBNVpwD0WYAUqCi14GJwaqSFgF2BQBY5woNEELkAyjjGv68MuUeQdNtkgu2DBq++betLM2dl9uMyeVpiwkiyWe8UJcsd3c2W8lvf2VCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846570; c=relaxed/simple;
	bh=EIuqb+bEXzHKheYSg8/gT99wnpLEGYyBUdzthx12unM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avfv1PXpcyl6l7aTpW8Fbly29jfwX0vNylIZkdU8A+UIjwhlnefKyEbA+rPbjDD8VWz/KMl2c0Waez2EKmObpdKXkrto/Zq4K/sE8JY6AjFLm7PBBQkhtjat1rWUaznjB3uuqodPTpUNcsl5IqkyFOfnWC7uwlPj3o/Qyf/Tt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI6AYwJ0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI6AYwJ0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1471648a91.0
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846568; x=1759451368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=MI6AYwJ013M3DuC1TWI8FveMt9WSFeocb+dOqAzFHrRGGnXbctgzkm53GK5z//BlcV
         pJZw7pt++Mp3grdtn18+uL52X2332c93Pvk2Z1fjjpT1VyUYfNrFhJP8OY4QJqE/4xJL
         XJalRiEaitO47Dr+YxVRe6Vnt6s6ei/LskqVYFyPfp4nMmE5+piVSNO+IEk9dZweuIRj
         PB4DO9Gods+skgFESduKUPKUUr+1Ss1VxEax8W2HArhV6CJZQx/I7WIDXvn/zGgrgo9s
         DsnmRkk/PaXZVZ5jSTN7HpHz22s2gi0NoCJ7KWGsXjKHmJMBqKPd0R5lOlfrTp4fMIlk
         X/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846568; x=1759451368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=rIMUtSmFh7s2K/z0qM/rEmFfvWZ1l0okPpnvGNLZ/TWHdgnxLXNLJo8SSM0M35Trq4
         M8cy/josaCq65Zecv/5m5XAPlZsCA2yYHPS6HEFLC98DafYSZPQ1NWZzBropmnYZTtXd
         +Wyb/+zyM/I/76GnBmvgVHyS1FyXTR+SuCxADDRIQkVlQMCWhzKnHbWLfZ7QgmlO/yS/
         2EtVOiK7EbZcu30bLTFCAZX2SXq3Vf5bFY7QRhqXsWs7Y6IXziOpXEaZDCasTPqrPeGc
         uOG+nZKDCpAHJjK3HXSccvQWUfr9ZLimetsd70NqM0eR/ksBWk/cxpAmPhhTMqubLnX1
         yFFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2/+h0f5SOv+w3GHmZ1lztLIvHYrf9YDmLSIzWpEANdWxO2w1kqQecGh7JxlRkbW96l9nw@lists.linux.dev
X-Gm-Message-State: AOJu0Yx439/VoFEXborg3Qi5cHR8n+EXkNRDEPXfZ1IAoujZo3Kifxmx
	Vq15Ohc/sCkwMMKfsXuEui2MbSfWtd6bV8/V0bskHKPEM3M4sibmuLFc
X-Gm-Gg: ASbGnctishjY7VivBya8Ww3e1f5cBakNzgwcS/PTJgeGF/hYHM0J5WicSmcNkfVp6Z4
	MHHn6bfVRrJzkgw15IPKdSi5xd7xOU7Tbskd31nslN+B+6GG9uVjqfVIDbvvsVQxwqzMpqWU98x
	BJ3HbbYkDoZL6sbQQmuddYuZ64cocuNYjX3+FVypdV3wIcEH3Mh2SQvNszwpJSe8O0mC0dmwdMU
	FbAYNReq+mm8YJsewg2IQloXYvu8Aseql8xZ8ujhbgTVHPhB/5HTGr7idhhwUCAGV1TiF4hGHw8
	tvfEIIEUvY7Tqv/lmL/oZI+f/eZzmrS0EXpNdyJIFmDFp91Njk0i9Xh42iUEFFynm8y1jl+oHLg
	df/MZ+2JFJduGf4+4gy8ZJHc6tROzYmuvXoK46wa9xC73q2jjxw==
X-Google-Smtp-Source: AGHT+IH23dwF1NgLX5PleNnijXd7QbsowqYTMDXXK2Av0KZS7klqMtWV6FrRS8eSIiqXbBxh0MCuvg==
X-Received: by 2002:a17:902:d4c2:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-27ed49fbd2fmr63113575ad.18.1758846568053;
        Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm36331395ad.30.2025.09.25.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:27 -0700 (PDT)
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
Subject: [PATCH v5 02/14] iomap: move read/readahead bio submission logic into helper function
Date: Thu, 25 Sep 2025 17:25:57 -0700
Message-ID: <20250926002609.1302233-3-joannelkoong@gmail.com>
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

