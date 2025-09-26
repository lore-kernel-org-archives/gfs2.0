Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091919E7F9
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846577; cv=none; b=baYfEKTa6DtrfBF9PFQTp6PW2Ep+HqDBwB2seIs87XwRTh+04XYNRv9/aemEvCGQE3WgWPpmDIFzXXxMl5Vs/7HT5zDlBK05Z++oKpaTIXQweME4fLu9w9kEZBqn1ec8c8hO+ZZLwV7IVty2lFYphkR03d3I8WM6Cgqo+6+lD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846577; c=relaxed/simple;
	bh=vIAY62bPonaFy7vGVNyvqO/mtaIvl07zVQLoOf2yQSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU2fDTn1YQBwvEOT5aMIj/AZSpeo242pGdAHoGbQ+83oHA/XtINWGM7PHoYixRCqzw1taOk7/XVkmK93HtQs9OFirPAwmFDnGera35GRVmFZrheunAOfL32IMrP3pp2oX+Fe3Ol13j7jW+PfwwZNwPEy3tZtYGshPJ2xGH9obds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExmJWdcM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExmJWdcM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3352018e051so1035613a91.0
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846575; x=1759451375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=ExmJWdcM6AXyvXpoF2LCXzUZp808bqXIcTEG1X2TzXEWJFUj+a6/J5z72fEuUF3ezZ
         th4tJ0yVXO3jSEBUp3aUe/HTSLXqYJcyQwOXrnOrct/1IYCl3jtj/Z5ellRXH/ICdfK7
         iKySVdFyuhEvY02OvQu2wFIJH7B0qU0P6DNFVnoqqq4nj/k8pUG7RAjBfm/FZnaaKakN
         46OJha92VdhnoTl8hxPPusy0EJmXVpX/ROJtnPZaQOBmNCkSpXAKLebcwAljBswcyZqv
         JQxdRXFVK30Zza/zQ5Z77J7EjRXvkHT8yAUI7Bc1ihiTnnNNeMfQjbYoUTCfJosuiGVk
         ZhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846575; x=1759451375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=fNOwP3ZXNKksel1hG5kEp542dQvDiN6drj+BtIvTyAUJ2JskHsaJJPj4i0vNBx+q2C
         MQAA5ZMnEKr2fS2tuTa2AUGxcdDOjz3ecpVmOrI0rFgjOEllYVpRTtKCTjBdvlkHvf7G
         2c4zsS5imL7xPJMouBV2H+TMa0iqGGGud5tfHZfGg9ZBe3yOvqdPpH7d2cO95XV9dHVG
         3TTOBMG9MP1zLIklYmun8NNCd99dw5NlecfqJ3rIaJ5WvuNFpstqBG0XWc6MQPicQypo
         klOqDKkK+N4xSAZi4sGOlOL7CIZjWjWP2LZAzN5aNnCtA4Qg109t20jhpMGTndMrY+El
         uWHw==
X-Forwarded-Encrypted: i=1; AJvYcCVh3zh8ocJ+yF07+QmyFh4NaSMjLHzIc9aVA29FuUvqFlm9Pc3cGyyF7fDiV26DcrpTZ8D9@lists.linux.dev
X-Gm-Message-State: AOJu0YzU8AVf4geGEKtRagoNzDHgpZnqb8icvj2mRTVWBSufRVUaodGx
	amhf+o5HgfyfOpHWsZuYJ9NWgTHvMMjPcqYVNDlVEV67N08p5hnAmxDv
X-Gm-Gg: ASbGncuC12Aw2P+SrBdGYjpo8AFkqgPdi7i9n+xnLTkFql3C0ZeCK/89iFVs7ETwikZ
	I2+s+5EyCPxUBcSKcrPP1vRuIYcRvnvNLRkIZeBed+CuEDsEiKUOXYE+QERQ+f1EXy9Yb6wIwlv
	trYQ3U50284cpqIBfKYEbvnmND3dn5aJfA4uAToqiIJkZ117zsY0c/NeNMDMNkevhufhjb187TK
	kdQRThzSYznqVAi9XsOLgH4h6m4sdJlNvebpO6S9jBVeemeDRBgsbDKGoLld0vb6K1IXkisERki
	CNtwNXG45aD/NNMrpTGi1QFYZWEiNyFGFjblhj99nlTP8iW3XGRupcsEncfFjWCf+X3Qv0FGMzj
	P7ofM8sPIZISxB9wiJvnJwYsibPLB04CABWA3y6r2C59FPbbrQg==
X-Google-Smtp-Source: AGHT+IFjaZEdrafbvd2zyiTkt6VCFBB0ZO2mwZEYv3mz1oaOZduHe0Q3Y+mjwZVDt2v6FhCaKr5ObQ==
X-Received: by 2002:a17:90b:4ac2:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-3342a3070d5mr5430211a91.34.1758846574661;
        Thu, 25 Sep 2025 17:29:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a339dsm3185031a12.40.2025.09.25.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:34 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/14] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Thu, 25 Sep 2025 17:26:01 -0700
Message-ID: <20250926002609.1302233-7-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23601373573e..09e65771a947 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -360,14 +360,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
-static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
@@ -376,7 +376,7 @@ static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -423,7 +423,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -479,7 +479,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -504,7 +504,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -551,7 +551,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3

