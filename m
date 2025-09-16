Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0D2D3EE1
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066633; cv=none; b=OwhHu0NW6/B19G5YsKFUbQsJNH9wONcGYIsuBTfsA/u9nK+pofoECuvBg2tItNml12Y9uqh4OjYocVOYnp1owmunhSq0HSqvWR0pZLD/YIA4ivqtZlGKd9DvqNVb72wajfH+q7LSYewqDbIh5MLjLhchXBprE37zP+0U8YjtIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066633; c=relaxed/simple;
	bh=oQMvt3x5Q2N+uSt74k4pmpTEp6W00XYhfBugSskMdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TY3kJi5wUpLW9oeiO0K0yKUXJbpHevfMvtC8YOcTBhOzvgdJQcYgU1YWjourCa5zjvzWyuGFsikcJnu/PWozKkA5Znws4+s8mlJJlNQi/gySLWaf6kB278EP2S2xBUiQ6Utoir9kKlMXtevGvRV96eAW2Fg/qsvYsOrnTMJhc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV3Vm0oT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV3Vm0oT"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54d23714adso315519a12.0
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066630; x=1758671430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=TV3Vm0oT0NpQcHbNeWrpBKoKzl1L03DI8/oxYZV6zDSeSyPSlFiiipaKS6PwRDRx+0
         SgpQGd7yyFkXTovxBYtgwXZeHOKzCwQX2Q57hzrScNCylC8f0zK/jJKZ/yqK2qpd1X34
         JD78zr6+WmxXTJzRxOOaXe5E9+Rt0PH/qY2VQb1KIEWtr17kN4BryCuv8x9ibprPWBn0
         o5ul2+5d6/zLBTxpskdVrLf4XkablapRB4Ki+S7jww74d2bskVlo8oqx/BxyZKKeatD5
         XZDcutmmeAd5AXJndC2q++DJXsUL7EE/DmDq+U03zCeZmUUAc2rtpa+caC5Rji21+nII
         MaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066630; x=1758671430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=TqbhrC6CiKML/10DocBSriB+iMc8w20wBkzskUfVnE7GEz1Mn4zSVQj32VCrwTFHU7
         I/yMeFCQ5lCGOBQRMA4A2lu4il06RHx3qn0ZZnIyskoZy0fXYXxh4S5oflJ+knXLtcfC
         fcNGH+d8pbWETBLR0rvFIUFYIWfVikt1bH1ZdLwoPUhjZrXHZNWlySm7vpOzsMH2iusn
         oXDe0uSbB03Dr/3664/FIKgwnJiSOnxurCARO3Cex20okKCrDdN5dIDjGnrkpNWH04Vj
         Ox8L95zpKbdpuJGM6T4A3BIuzvGwpE79bu9AaMfGOWuSrf7qG5fp5NqCHuSnrkUbneRm
         SgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpXzJR8nXGa0Gsqcc1W/99S8qf4AP2ZaD3cYBggyEOhhWOeuYb0CP0a04tGthPBOON1o8u@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5JHyxUOciJ3f/oDfKulyZ7gROAV1gHhmlq9w2GaNvA3IlGT88
	olxOaeqnN9Djqgw9zGzapKTKNbU34RgISVDtBkOo/ZkGn9/irq1XWYWX
X-Gm-Gg: ASbGnctPu+EZ68g8cDyff+/3lprgUKuoeeOgmHsQ6Axvq2fosXY9P3PJrIsBopnNVzw
	O/p5arwgtGzmh3wLslXF/rpaWDY410+bxkVmvSr/V2haMgPQA1/mpJkK3ulJK9f2PTJRFU2c2bx
	yun7vWa41C2AseqTQqfxOkqdGsv+dl1jyWeG4rQpCb4Qc3flQOyPg0Wi8YZlCePJcDUauXUnV6M
	eEDWdNnV4s+dv+8BtcagSmDuBXwhMM80hC7a/0naD1FbvDKa1zd1cxoej4rFjcjNiGdkTJPwwuG
	wARTbHiIfFs+XqYP9xrY6yoeSLDii8snyDnX/elf3R9a+I6tKlhXFa1qaCq7t7rnTZVyyuoxQ6A
	Dn1eKK/XM4THBnZ7Cs3ENbfr7ilNAtKdJBNAb/tZLq5wJtjRy
X-Google-Smtp-Source: AGHT+IEBXsoPFEqPmLi3eim0ez8AD7ra+R5wqscn78wj7CppFc2BDvERHIUoydzeJ3XEBjfYKljMBg==
X-Received: by 2002:a05:6a20:3ca6:b0:261:ed47:c9b5 with SMTP id adf61e73a8af0-266e5bf9c68mr6068804637.13.1758066630224;
        Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398aa76sm15413902a12.44.2025.09.16.16.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
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
Subject: [PATCH v3 02/15] iomap: move read/readahead bio submission logic into helper function
Date: Tue, 16 Sep 2025 16:44:12 -0700
Message-ID: <20250916234425.1274735-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper.
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 05399aaa1361..ee96558b6d99 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
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
@@ -382,8 +390,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -478,13 +485,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
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
@@ -550,12 +554,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
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

