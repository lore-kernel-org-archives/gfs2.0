Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD9320CB1
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357554; cv=none; b=RnpvSbD3lGbK7+PSL7KfRsMU2+oSittSpvTLto93r3vftz993azZ9/IdAhqI7bx6ku04J5gffB8OuVaHRXYQSjRti61MxvaK6nRfm36p9nuJiNIURqo1yMj6FSUlL0F2C5RWkomZRADFsdWq4LLQQ6lY60CtvuDLeWGH6aiMHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357554; c=relaxed/simple;
	bh=1ijod9ueXQ4SSnlq4mOIvyMyfYnUffGvbM8owg25iAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STetY0ElZEZeimdqUubc9xDvnYC9twXLCFCc3ZBPyMebJVmmiux7iUZregEBMWGngKVwGMK/l2pXCqWPSJzY8tVjwglp7J9I2SxDRcX0LGwXq5Pg5he2IC0JSVfLONhZQvtZi67oozXbW84ZFWwDuyZdrPYSNkqHBNvb4pw0TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnibkGrH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnibkGrH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b1622788dso32657895ad.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357552; x=1757962352; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhEE3c+8uQGuRrR/KCqLBGF4v8yEMjYf0S5ji0Yl468=;
        b=OnibkGrHV+Aw3sYIgrVstLtoQWawTrRDKG9jWQ+ZvQDdpT3YtokZ1UvxfD6km/IrI6
         TQZUaYYf/0pqfnTXwp6AP2Xv75u/PBZ5vt8B910dqrrrP5nT8Q/a+yyzbC+qeJD2Vl7v
         xiBLLjyKGQjuptehybeoqqZ0rGWzDrJTN6izH52gSUo8Rb0Uuso40U90ba8HRn8YGflo
         U6FzaKtCZUs6/ziXxO5g6z1MmT1h00r6OhpRBPGGpUMLv2U4bIpG3pCOCX7RIKiCrMaS
         Zf33fMBTxBgRNOltY086vOlmD1/4avuGL8KL/bumaVxYGlcbq6Hr+UzGgKe13at0i0tK
         Fl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357552; x=1757962352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhEE3c+8uQGuRrR/KCqLBGF4v8yEMjYf0S5ji0Yl468=;
        b=MG+HZ1eOuXNuoIAK+04pGGtiS54RhHPbFsKqdBrQ9UIwN54XI/KLtAqP4xeHsYiwnj
         MEHaqcxPPFK/F5r9SfNzIJoItdSWt4rkIE00clcYjIPU0LPtN2RdxZuF68DJ9fL/gW0x
         fuR+82dajjLUbafNlpgUnkz0mi9L00HusS+YVX9pKwlhxhQQfBz5l6XlfkJCDMBtuhw8
         fYySPvNfNOeJWcB1Xpz1kyEpSj9XOxxUfqvJzlnAz/K/xFMOWxpIIvTwCJDC9kkxVTWo
         TKj35oYwVKEaaTEIiKU4N1llYeONomE6ksXoKOsaiZl+vwqzmfYMVpSGnp0nrlChsPgT
         +6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUXmqApqF8V8SVg5WFGGPc+L2zDfLyR168M9dCIy3bp+Vxy2NvtmDsHARC90Rz/EyYQvZlE@lists.linux.dev
X-Gm-Message-State: AOJu0YzP1gn1MxqRmGbAoKaokPaiXqCQKd+B7KdYLbkO5hrcyBqYCs4m
	KfruXcJZBbLNRm622T5CbtTkxd/J6cpifePUN/2SNo2v0kus7xA2sCrm
X-Gm-Gg: ASbGncu5o4SVaSFOTiIoELEA0vCG7q6Y1Yhc6S0Rf0Tq0cltqf9nacEcxDQiazdAa+w
	9oSxwwP2KC24+D/IY4EJuRGh7F9hTvPNvRhDyZzD73Ca2zH2Cj8Sur2jAoTQuUMNjO5hLcynTte
	AVYOZjaOn9WuZewxTYEJ9NItXn6s/Ybem3lRhmJZUzSb12EvJw26s3J0cMncZuHaAz146xD4Gde
	ECsw+E5DLydxbEaTBqfJA1RAMM1bsXiQPKnM1VIi2/hPM06CJkwEtaESu+W3SPoUkJ5RukelmrY
	zWiNfOOLu/p10JaBFaKQiO1z4xeG4GjGEwNHU5a7At4LxxELqrTE9KerXIu0CmUUEJ0RPhCJJfy
	ZtPT4JijUyZsbIAViPEnW2Q8+r07t
X-Google-Smtp-Source: AGHT+IHj2AZh7WLOlDTRFjKet08p3W+JhKEPAKQcEvWvYOnGDlm2VnfwamI/+unisK2bFixMd+3Omg==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr130706265ad.44.1757357552184;
        Mon, 08 Sep 2025 11:52:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c180f82cbsm166544935ad.100.2025.09.08.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:31 -0700 (PDT)
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
Subject: [PATCH v2 10/16] iomap: make iomap_read_folio_ctx->folio_owned internal
Date: Mon,  8 Sep 2025 11:51:16 -0700
Message-ID: <20250908185122.3199171-11-joannelkoong@gmail.com>
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

struct iomap_read_folio_ctx will be made a public interface when
read/readahead takes in caller-provided callbacks.

To make the interface simpler for end users, keep track of the folio
ownership state internally instead of exposing it in struct
iomap_read_folio_ctx.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 50de09426c96..d38459740180 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -365,12 +365,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	/*
-	 * Is the folio owned by this readpage context, or by some
-	 * external IO helper?  Either way, the owner of the folio is
-	 * responsible for unlocking it when the read completes.
-	 */
-	bool			folio_owned;
 	void			*private;
 	struct readahead_control *rac;
 };
@@ -399,7 +393,6 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	sector_t sector;
 	struct bio *bio = ctx->private;
 
-	ctx->folio_owned = true;
 	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
@@ -432,7 +425,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -465,6 +458,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			*cur_folio_owned = true;
 			iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
 		}
 
@@ -487,16 +481,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio,
+	 * it is responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&cur_folio_owned);
 
 	iomap_submit_read_bio(&ctx);
 
-	if (!ctx.folio_owned)
+	if (!cur_folio_owned)
 		folio_unlock(folio);
 
 	return ret;
@@ -504,12 +504,13 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx,
+		bool *cur_folio_owned)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio && !ctx->folio_owned)
+		if (ctx->cur_folio && !*cur_folio_owned)
 			folio_unlock(ctx->cur_folio);
 		ctx->cur_folio = readahead_folio(ctx->rac);
 		/*
@@ -518,8 +519,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
-		ctx->folio_owned = false;
-		ret = iomap_read_folio_iter(iter, ctx);
+		*cur_folio_owned = false;
+		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
 		if (ret)
 			return ret;
 	}
@@ -552,15 +553,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio,
+	 * it is responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx,
+					&cur_folio_owned);
 
 	iomap_submit_read_bio(&ctx);
 
-	if (ctx.cur_folio && !ctx.folio_owned)
+	if (ctx.cur_folio && !cur_folio_owned)
 		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.47.3

