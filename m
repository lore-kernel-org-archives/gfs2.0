Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616C2C21D5
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066639; cv=none; b=oFrG/KOfRr4ThVCLA5ggVmktC77mlrbigSXtS4m8ZYrjwLvrLDzxPydoLRQEiLu5Y+UN2LM0Kkde6GAXIzF5VFnrIJp3fNiZkrsAMaqyhq5pE2wk/zgNwZHojIDW92qmBhV88F4ZjZSbRfg6454pP2sfRndW6fvcFs3iiOIUXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066639; c=relaxed/simple;
	bh=eIOFnuBbEEhNrCRJgPMN/EYiLsFJzBzjn8Hty6/2sSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfS5dKNpNK9A1ocOgfqXYQevW3xzszMaICOKnJKt57q4VWFOiElZvPtzAAK0Exlt5r+Sp0kbEaiHFnzrfVMlEYO7M2P7dW/yybQaJ6M5LNenDQP94z2SUTqvoKkfnK6nRnbcuw4ezmoZRX1DOqugSl2GlQsuA5i1FvvB6gMhFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1Ee4x5m; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1Ee4x5m"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7761b392d50so5402933b3a.0
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066638; x=1758671438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTOBSsCSO8daJuxMquSbd6R0XZgS18qgaXRjlxCtvSo=;
        b=V1Ee4x5m4TNYQhXBd5JoVrwRdN6aw+2G3tIDdmdsqgixIvhnKX7Wr243f4Mm5jZMgP
         4GusxY3n3j3muZFPOEfJJQT243rkfbQywEfOPijcDDdsVSXykwXwkyzfZ/VH62Yx0LDA
         mjQ3OhWe84xvAA9zqzgHkmJLPKQype3dPgxXaONyA9uSdNILk4SRrtvEx+J1eY+bQBod
         rFmi7mP99uqggPFt+ZRSYIS6BR1gaKIcK9i09YbYV+n8G3FPlXKdcUDGlEcxmRylwYvO
         tOdv8LIIb+jE8FOuBO87S54/lceNzwAG3sPrKTVqnrh9+wzTP3rTF/+5s/fxjpsUq3EI
         l54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066638; x=1758671438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTOBSsCSO8daJuxMquSbd6R0XZgS18qgaXRjlxCtvSo=;
        b=Luerqp3sA/lufcez5f1b8gnqxVYxKcr2URIGyE9pIQwKQI5jxKsl9eydW7ZzMrF8Go
         x6or0lukhDPWkHNoRcKnJxayWIOWvj/j4Sn9hXMnpAOjitkZugRqS+wAPcm6J0NV4f9+
         ozVDONBHTatLrQd+REfuiKuohgln9cT4PvZjlvftYAg6JuQ2w+ALRP1kYGc1ziuH/Zln
         ilChzqsiDTAZtnVjvn516rQpNbjiQ/eXOFHrLEYuv0EurtnGehDbz3jK9BojluwGRh7X
         oQkY6u2S2wxkFgwwCSFVVWTp+pS91/xAtv2oKV9c7Mprc6xmBFAAydUocR9jw9BAkLKY
         pMXA==
X-Forwarded-Encrypted: i=1; AJvYcCVdLoeZi+6E+VqfKlGxCbZoYQxIk/E2369G3kMfvqJev08KrdVSaA/rhK62dwDXhkcMlDnN@lists.linux.dev
X-Gm-Message-State: AOJu0YwRQkIDXdswYeVi2GQyagjjcuAafvVozr1BEmGnv1LkuHs3/gQj
	Xmxp1skBRDK5ItpLivmstO86e5hw3dDlIztuG4bk2tVJZJRltZZQ84Oa
X-Gm-Gg: ASbGnctv0zq6TpKZRrbT9NetEcbHYNhTxh7z+CzArieiWtnaRV1BKkgt+bON3aSZQGr
	+2OYZMUDHOzJHivmk8C5KTg+rMAP9qRcfgc3SmAlxwrEUIab7pWFr0OcNvU+l4i3l4bJFrWNMsT
	aebZFKTFK/U3SEt78zQMTrN4X/yE40DyvNzzC3hkoFUpH/NHbOV13V+9yLmNXdh7N9FpQ67t8Hw
	/at8TH/Slp4YXjV3kqeUY7nclOLqDhs1CBwtB8I2ELhrALk0HqvDZ1aPCIh4yOldFT1kPMPCSnb
	ExTOKkaPckq7oSk/JaOQAFHNDGKUITOhH7DGOMjHuFfOSi8DwryfwYs4jvNc5ag3iS6G9ge16ZP
	Tsuy9TVMZpBoTNkhrw+oOf3pqXpJCszKqfUlvQ1qIfw/ZzqVSoA==
X-Google-Smtp-Source: AGHT+IECDExDzeNFXpW8LF+8Eh4/U2VcB9ARfSR+udYUrCEyTsOh9fUUukMEN4AkshjPHgZP49IV8g==
X-Received: by 2002:a05:6a20:244d:b0:262:4378:9dd5 with SMTP id adf61e73a8af0-27aaf1ce777mr50260637.34.1758066637658;
        Tue, 16 Sep 2025 16:50:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b5568a82sm11608169a12.34.2025.09.16.16.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:37 -0700 (PDT)
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
Subject: [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
Date: Tue, 16 Sep 2025 16:44:17 -0700
Message-ID: <20250916234425.1274735-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
track folio ownership to know who is responsible for unlocking it.
Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
purpose and so that this can be generically used later on by filesystems
that are not block-based.

Since "struct iomap_read_folio_ctx" will be made a public interface
later on when read/readahead takes in caller-provided callbacks, track
the folio ownership state internally instead of exposing it in "struct
iomap_read_folio_ctx" to make the interface simpler for end users.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c5a631848b7..587bbdbd24bc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
@@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	ctx->cur_folio_in_bio = true;
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
@@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			*cur_folio_owned = true;
 			iomap_bio_read_folio_range(iter, ctx, pos, plen);
 		}
 
@@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio, it is
+	 * responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&cur_folio_owned);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (!ctx.cur_folio_in_bio)
+	if (!cur_folio_owned)
 		folio_unlock(folio);
 
 	/*
@@ -494,12 +499,13 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx,
+		bool *cur_folio_owned)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio && !ctx->cur_folio_in_bio)
+		if (ctx->cur_folio && !*cur_folio_owned)
 			folio_unlock(ctx->cur_folio);
 		ctx->cur_folio = readahead_folio(ctx->rac);
 		/*
@@ -508,8 +514,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
-		ctx->cur_folio_in_bio = false;
-		ret = iomap_read_folio_iter(iter, ctx);
+		*cur_folio_owned = false;
+		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
 		if (ret)
 			return ret;
 	}
@@ -542,15 +548,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio, it is
+	 * responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx,
+					&cur_folio_owned);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+	if (ctx.cur_folio && !cur_folio_owned)
 		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.47.3

