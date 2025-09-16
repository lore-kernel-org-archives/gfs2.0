Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2122D7DE0
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066633; cv=none; b=rHIoLSsvv0NTXav6Id7OV2Vzww696AU290rsHzoItNRVCkvnpZX8K3FGN5IWL2bEJVcdnUn2ah/4w2E//Kle4aAxzsW+gXqn9fi92fsorBms2Y757WbQfjjC7pW3EjG3AyPz+Ma+dRgbULRXmUFaNJNz2gb0H/FZINpWJ12nWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066633; c=relaxed/simple;
	bh=rjAgCi3/eMn5KyVZd+dOJ4WV8eyPp2yZu1uzgiUzyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/9SnLaAf4KoNilHie0YtbMlW3LmyHBoacagavovXAsJgB7R4WVS11suksTJTzsaIaCodWTUGWat0y+tWORycsvT/84+XK7FvcKFrVdqsYUbZ0f6S3USJegjT0h1Fvup0SHe72CloriNwtaZxYmXdk3ot1Bhcs2i7cpoBXJOk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVpZF8u7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVpZF8u7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806df50so49078625ad.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066632; x=1758671432; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nMNXXiW55M+I0FZncr65g30DqrOJDGj0I2j26ezOyk=;
        b=iVpZF8u7msO2IEzpj3/OdDy1L2LHmSOWJQsi+kfM53TGE9igATD/beQpdbnhrHtSoE
         IAMALwWzeHK+4SxgmRTXL5X6YTP03Fx5X5qHGVV+SAbua9PlZHAyHITasZK0zek+FSud
         8v4LMi5dvDQ+pnbZiffIJQwZxv2kO32vhSsGJePaLq2HfyFVMNEVtcIpJuHIUwEnmAoK
         yphrU4x5Qdq+QkE3heZ4LuR0X19iepMnvR7Wp/LcV+FPlqDjXOBF2MEifzIItDtBbj6S
         4IqBDTE5L0iQ0ygo5iYgI7fU/jLh0seMwwD7GriiVVsT0aaGix9RDAkRM5ZvmyhEcwKv
         D1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066632; x=1758671432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nMNXXiW55M+I0FZncr65g30DqrOJDGj0I2j26ezOyk=;
        b=KyoXfKFTTU6QXs0WINLtb4TVJtrH+doORKwtpZFvs226dQSVzxkBN4DiNTHK5WvZUf
         3qBxL4oEkaAzmYgKc6vYm//9//5nB4ijnGARw2dXrjjMAJdRdJeUfiK20dbFR+z8Os23
         JGcI+vybctOTkzYf1GHuyrFmti75JTbxWQ1jAh2ACBPGJJWUQDGhtPli2ftp0dCU3WBi
         9YSLyiTUiRCj61RjlUVQrQwfJrH8gL8X7PJXhtx69MgY5cy2QhXbp+trfb9GqMl1gMvJ
         K34FsJy+XZokuzvYBEvhGyLVzNiY6U+t0y0aByK+A+l/DpNaKV2ODV505KS9e1V2H3l2
         awow==
X-Forwarded-Encrypted: i=1; AJvYcCWypYF1Z5IT1f7jC9PqpyJVKsShdcFVNctGSC+K2XHAAyD6OXVyT8bE+2qx7Gjz+AUd1vV8@lists.linux.dev
X-Gm-Message-State: AOJu0YzBS6T7gG4dNMZGdVK3lM3gfinzreAD8sTx124+2WKZZCO8A+op
	jsuaMGvz5GfjBa8dbsha6olY9CQDudh4BzDwLlhpOrqdAeqCDEUUyHmg
X-Gm-Gg: ASbGncsteDSNPEQBLR7C6TYKv+BPeXz7icED+Qd/qBa73QCSDRM2/vpWA9Hi4kOdlno
	w9AtFugFKeOY3+F3z8OeJtbeVQzhKzDPypDdaD/3o4mCee+67R5/y21urmx5hZxZcCJbvihNG5l
	XOpqIUneimqM6JnYf01grVvdxMOGHaUY5TJlEa+i4d8jspxI+CBd3mFxEemwyuaWMAL3OIiRppl
	O6KXOjmhkYcZBYdJwA/oXCsbZ/jXxf1ohzUSUsOL4X/WvX03egRTVqBrhPYlnYEz4Ck9BvR5Nk0
	/oDWK0EqJYhq5HykDx8fXtJ7lu8qnT7aOAwg2OCCpb/Pul/zyFlVkHaCnho+y03BBqdaIeBagpn
	Ax6xY13nxvhG6MXN6ftTlWEzFJ34XwzRTHh8lKPGJ3pYNg6vASA==
X-Google-Smtp-Source: AGHT+IGG9poxGSaItOpERv7KdyBVrmiU9DM8ctL/8CBjU6dxWdiXC+MY/afeQfS1uk7JGq3+BJJyuQ==
X-Received: by 2002:a17:903:2b0d:b0:24c:1a84:f73e with SMTP id d9443c01a7336-26813f1bb6emr618025ad.60.1758066631648;
        Tue, 16 Sep 2025 16:50:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267fa950089sm9719725ad.100.2025.09.16.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:31 -0700 (PDT)
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
Subject: [PATCH v3 03/15] iomap: store read/readahead bio generically
Date: Tue, 16 Sep 2025 16:44:13 -0700
Message-ID: <20250916234425.1274735-4-joannelkoong@gmail.com>
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

Store the iomap_readpage_ctx bio generically as a "void *read_ctx".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee96558b6d99..2a1709e0757b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -353,13 +353,13 @@ static void iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
-	struct bio		*bio;
+	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
 static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->read_ctx;
 
 	if (bio)
 		submit_bio(bio);
@@ -374,6 +374,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->read_ctx;
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -383,9 +384,8 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 
 	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -394,22 +394,21 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+				     gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
 		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->read_ctx = bio;
 	}
 }
 
-- 
2.47.3

