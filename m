Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017431D72A
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357541; cv=none; b=uAStom7eZBFU4z7uPloKX7/iZj4Chg2/9wOt8HkRZTZYqgbf/f7DldB0MRo/n+IiTWTMkEXlDUnyU1I5BDKmTzqG/qeWfhqGphj57VU9YteVi1J2/mGdbxpEQMB1wdDb5zhezuEtlJPJbfSkZXDeGEpPn+c0sazUcs9yesPTMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357541; c=relaxed/simple;
	bh=dmjQNCdEMtXZ68orYoy7VaC5n4q3qVKlf0rQscQcUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdNqviJfAZ1ffsOjT4NCxGsABSjjwQgr1LANlNdM67Dzwfsx9Q/tXgxdkI/m2ff1mNq/hn0zAxKsUSfUfwHmt6K+veWXLTvBkLR+MVpm//BogWjU6ynrq/mNkHko8/YnC/F7B92dtx9O3f3+oodG2XmWe3AMaH+VtXX7/q5uxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El+pOXT+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El+pOXT+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24af8cd99ddso60173135ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357540; x=1757962340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX+m1+nAD426im6+oubkUf1KY/aIRrScfpZiZHj8kyc=;
        b=El+pOXT+Rz6DZOWbHsmXbcTTnH08gHk5Nd+JcFg9rDQKn8q8BAwZrDUhDZeihstjlW
         AYHhfRebd2/5WQjwRcNNtcwvLQc+Z9coYvRZuCeq2QBrtb+IYg3+WmD52jLg57N3xRHf
         5h65LbmA0oZ8V4VWfB+eJqL4jyf1NfJw5ebX0IzwBjWyZRH5ps891pxBiHaUZtOBv+Ud
         HY4tw/J9mOP1OvPAt6B5UfOOS2SyRh81VYe8YHgINSX3YdXltl3/H2y7yZ+WzqgJNGFu
         5eIrNQdY8292iEyo4O7S9VZXDBkKFyNhIZRONRqKRANkx3sd/ea8CJQ5Xs4crr4LEJS5
         ViOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357540; x=1757962340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX+m1+nAD426im6+oubkUf1KY/aIRrScfpZiZHj8kyc=;
        b=D8oiebARQ21I5GTmN/fGD4jsEiB9waCWTNEVs+D+Uolk5xl55RTlwLSEpHhiPmXFKl
         U2/7U4d9+WOyiqb9dZBLqf5o9xNsMgRGnXtaX+PrnOOUIIxUYTJpX6r2uV6OF/Q0wtlr
         9bBI44sOvH3xebGDS9RmqavRWhB1j9ypmJrWp6W632hLJANhrK89adr7u0z/4mEI/wfV
         bXgWY14VbclctWyN5COMkyJZAicQ+FepbdxaQBSl0PI4vrWiBXl7Mfi6JCyHsBB2KzPx
         Kumx+hMhvIzUHot7xi5deSXLyuDSCAi6r5Zfci5jElJ1Xriy9b7dXfhumunkhrRLTVs7
         VjLA==
X-Forwarded-Encrypted: i=1; AJvYcCVM7fD0twdLYreE2fHxzkieIDTuEOTZ3wWFYfO77Fjrep6LtbfZEE0Qwq3zUiD9fcV6s+XJ@lists.linux.dev
X-Gm-Message-State: AOJu0YybTKulvB32uzmpSiowqI3AqkO24KW2hZMZM+htldCjKtj4RBQA
	yGXnfHIkhjnTqqUkjVl4BKT0IYRniWZAVSVab5VQjW8c4M5sKFMB6L+Q
X-Gm-Gg: ASbGnct9A9DLM/WtAxJBskxQ5rrfwjpDNQayqC9M9uLt3towLQvvvIUV8x+uqY8oZ5V
	lq8xsLbvqJQViItPFQjFlD2WeKHvv20HPuqnn7qmdV/7RCReb+K5zxqs81yx61V1cfroGohlj3p
	+RzgedsdeSLf/wJffWDtaw4rSjXICQMxOgD9nPQmlcLaL63iMtvpCp+0fW10lGHFwFuI6XMCE2a
	+h2ir0XOXDpFKkssvrovPBrbbqVxTRkLF+pSwCRN5ggo3NGzvcN6qqLWf2V020u5ePpb12yH7/h
	AUh/r96AuNddN9H4zaL3rvbXTtxgoKa47ooZsEVBK3Yy/x8j3ImdTkuORbEc7EJqD3HykD5eYNr
	NlA5WsfcAVq19nxJRmFGfv1UcZOgS
X-Google-Smtp-Source: AGHT+IGMIOa4tR9asY85ktd8K/WzmNPGqpzx3UT2MHs6YS3aCfimlBQ0a6hVrfam2YKMflIzE75mLQ==
X-Received: by 2002:a17:902:d505:b0:24e:8118:cc28 with SMTP id d9443c01a7336-2516d817d4dmr125296655ad.11.1757357539540;
        Mon, 08 Sep 2025 11:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b790sm150291985ad.67.2025.09.08.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:19 -0700 (PDT)
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
Subject: [PATCH v2 02/16] iomap: move read/readahead bio submission logic into helper function
Date: Mon,  8 Sep 2025 11:51:08 -0700
Message-ID: <20250908185122.3199171-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 13854fb6ad86..a3b02ed5328f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
+static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
+{
+	struct bio *bio = ctx->bio;
+
+	if (bio)
+		submit_bio(bio);
+}
+
 /**
  * Read in a folio range asynchronously through bios.
  *
@@ -388,8 +396,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_submit_read_bio(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -484,13 +491,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+	iomap_submit_read_bio(&ctx);
+
+	if (!ctx.cur_folio_in_bio)
 		folio_unlock(folio);
-	}
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -556,12 +560,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	iomap_submit_read_bio(&ctx);
+
+	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3

