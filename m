Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF21F4190
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587645; cv=none; b=UiADsmqYRZg0J2rfKX1F3mB1sJpEc2esyH55aS2N2La/Qy4RADLwtLGfh45dR51Jb13PFN4C9OfgMtkYT8bYziIscFhDjw5rEWdewrfm/skf0r3hfbxmujl30gacXHUbT1qkXlqvC1T8eH6ZeKDVs5PmPLLDwfOEJKd5ouA4Dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587645; c=relaxed/simple;
	bh=EYt7dCnbv1WdNsWBo8OON9ZEzcHLtnoEPgeM+z1gNyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL5wjwUo7JnSlookYd0yIFyWqeaP2Q7LpCj6w50ApzlOl5+NZr+Mxfdbo0m5Fp+oCPJ+CIdwIePK+TJWTeg8WWQHm5EHY2oSp85wx8/RwVpEX6chse3jaxFk/3D10YDNC8+RqX4zXGQNctBhe5UgnmbE343lUA9yPU6Bq4G7ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe2UQMs4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe2UQMs4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-279e2554b6fso11703825ad.2
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587642; x=1759192442; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U11mrEsklOyGoG+ah0Y0223e+PC7aMyCc8N4lhMP5fo=;
        b=Xe2UQMs4LaD1r+oWNsg+JHNDfbA8q8AIR1UDxzy8RZnj3Do7QpgA60BEgfS4CaMGSf
         Bz/1ldqnjksUIQxFJBWTdi2cz6xEgKibhLH2Lwpc5ITVl+5Ix8rIoXGBTl818e7nW8mo
         HtHvAiaWLL7B+HzufYcr9Em9jYgGZcVmjGW7sDOAmxZE+tR+uzkNcclmAqmTdmsQO6RN
         8xmJ+MLtgiSycgljoS24qMO2xRWALQ1ajDX6maiDU/PaMXWq4xQbyM+84h/pfWEF/PYD
         8SJaqY8PZktxbKmdkFnctm9BIOTOK2X6wo/2IROqbpZIHdithE8KQ68u18JWjE6cuipV
         SWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587642; x=1759192442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U11mrEsklOyGoG+ah0Y0223e+PC7aMyCc8N4lhMP5fo=;
        b=GmGtBSKMSwQgydpBNoAdjO0P5pRsXs9uJ9fNCAjrpyl1Rr6rrHMk/JflJkKPwnO1pn
         OJv0Kl7spaey8BBZ1B4oyDoMnDDkO5NGamGfRP6Zp9U/kqEfpfdXjgZ+NML74Zl+jpgw
         xJO9fphK1s1cakwmr9kyV92A+cT1HIiLyeb9WTFnQWylDvLT4omQ1ZgEDhNKQ6ckgcer
         ZLmPUA+KvqU57sVo6aLVsDB6ycudfpDN/4tTuGZMf6xR0mVVmHU+23kaWzobtFJ+bTjW
         XhiagZhkxrjVsAmS5Aa9ql6e+ItzxsVH4uteRrcdNDlCAr4mN0PGrmD7a2JGuczJ867T
         dGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/3Y8EIx3c8UtfD1C1OARo2mBOYT9YUmq/Cx+4TDuwYgH/3p6qGmEUpLfTPdVHD204kv5@lists.linux.dev
X-Gm-Message-State: AOJu0YxZaw7cCMF2HNAJpNEBBoXtphWVuJx/4AYIMgmr6uGwvHY2LXw1
	3tbgkeFGlP1xeBrcFp3t3hWsWmkfknwGr1JHoN3FJFgel1FqHiTIbKzu
X-Gm-Gg: ASbGncuHoftP3QYpu3y8eW/7aDk22zHKHHRmIqDeRpyFaoXGCSTIPxXW3DFpIr55nJm
	wrC6UiKehpqKYOFqn5xC1iaHa7nF5lEwrAjgVOnaxeax6F8JzBsiFumENloRt7sR8CoD2Rk4wKy
	NaF4YMcmXc2jEqt+Hi7yxjtqYXyQxb1alyVCCJdWIjkYI7/4x/sVPsF9ErpgwNXLKzZ4iyuKyYY
	dPPwnXMV2+LAoSGEKFLLh1fbBmAoTDW243wa7/ePVBZdyAGJEEX6TZx+IRyPRURcEdLRFCavdvz
	4k3J4cTf0aJJ6TNXbINgtrjZpahb03+Eyw/NnQSuNv8/0gus276iLDKxK2/HT4YL6rsFpo8kt4d
	j1aEXpdtiCAZJwQh1QS7WlGRMS2x+25Xp84GSYfG/+4x4PfhCG+BU+JOMPNs=
X-Google-Smtp-Source: AGHT+IGMA0cPE2R/eep3lFhZE4wE7iE8qhOhR6c724oiDvW6uLYQwIWJa0jSbnPosxnhtfnxB7mH6g==
X-Received: by 2002:a17:903:1904:b0:27a:6c30:49c with SMTP id d9443c01a7336-27cc2d8f60fmr7678505ad.27.1758587642453;
        Mon, 22 Sep 2025 17:34:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c076sm145590885ad.42.2025.09.22.17.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:02 -0700 (PDT)
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
Subject: [PATCH v4 07/15] iomap: track read/readahead folio ownership internally
Date: Mon, 22 Sep 2025 17:23:45 -0700
Message-ID: <20250923002353.2961514-8-joannelkoong@gmail.com>
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
index 09e65771a947..34df1cddf65c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -362,7 +362,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
@@ -386,7 +385,6 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	ctx->cur_folio_in_bio = true;
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
@@ -423,7 +421,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -460,6 +458,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			*folio_owned = true;
 			iomap_bio_read_folio_range(iter, ctx, pos, plen);
 		}
 
@@ -482,16 +481,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	/*
+	 * If an IO helper takes ownership of the folio, it is responsible for
+	 * unlocking it when the read completes.
+	 */
+	bool folio_owned = false;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&folio_owned);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (!ctx.cur_folio_in_bio)
+	if (!folio_owned)
 		folio_unlock(folio);
 
 	/*
@@ -504,14 +509,15 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx,
+		bool *cur_folio_owned)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->cur_folio_in_bio)
+			if (!*cur_folio_owned)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
 		}
@@ -519,9 +525,9 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
-			ctx->cur_folio_in_bio = false;
+			*cur_folio_owned = false;
 		}
-		ret = iomap_read_folio_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
 		if (ret)
 			return ret;
 	}
@@ -554,15 +560,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	/*
+	 * If an IO helper takes ownership of the folio, it is responsible for
+	 * unlocking it when the read completes.
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

