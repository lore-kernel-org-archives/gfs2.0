Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC112D1F1
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846568; cv=none; b=mVxMEaJ5nX0MJtM3P4aSnAkcTJ2nwAh14PxiwKF4MJr+geOMQ/9U0JwGxEl0HTURVWyveRVm0fRjdFr+tNFWwMdTocB0vny7B/I3NMdZlnSl0AVV72uhh6L0zu3u9imuWSJd3Kt/lDqivkAzJkY8IdhcVdUHK2Ti0ONdJPuT5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846568; c=relaxed/simple;
	bh=CSiGtKrWb8zqpNUe8yL7Pevqy9qFJhFmaY58ZJGrYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgfozFoq8OxlUlW3gIJEqxTtRopfoVIWLCEDgdUTgaHPb6vAQww2Z784SnM3ycg1g5VIqMGJLg84cOrTGJHfh+rbACA8Ejcoe/2ZY6Bh34afENXkMVB0qzv4HqR4u0Rhil+5+oY+i++GQjV82SjtGDBiX2o8NzngQj4iWUtz1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT+IFjmz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT+IFjmz"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1259418a12.1
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846565; x=1759451365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=LT+IFjmz/n3X+qXWmrObavS2l3X8L6r1MasWC6hAsCiTXCW8H2kXCuLixpBAr+ot47
         GG7qDSlsU4I1t2Q9Eq37g+SABL2E8dOkEi+ZU+0rPVQrUgly8T5ffCHqOBijzbxQF6YL
         dh1UnYOXU1/ufrjEgVdajYTij17dSa3geult3uoleZgMZtAU85cbhd6smlRmDsojGRyW
         xD7caS9DMoLRT68tA4HljDFybIR+dLEghCdU7DcFqDgsG9ZUSKt6oqiFaW9z/nqtbrzm
         zMqmSRMZYURbpjFQEPTU/8be98pArlNc5u9LnV0eBZDMLEgY4J6ahbJaG8/7l88KZ2Ud
         1VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846565; x=1759451365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=AJv0hgJmW1LhkMr+64CeAbr9PnInykPid6zqTCmEpS1n+X6sosZF+cWGxUJmZ0UWZP
         wKxTXgwfItKBaBg+wML7zZjdlPOMgcOkzT1fSvB8jFDG7WAQD4jQr/kVverOG2TbfX36
         0V4EudUasq+8KKJQG0uxC86JpW0hDTFhpbPbnXF4Ys2+v2eyfUzuGPIBe3ZspXa1Qx24
         7kW3C2FhcFCakPGFVye9CzsqG5KNAzj2VZfOqngZ/NDNhhao4K7gSasDZHZ7wXxzdMSS
         tdEntXSDNjahmNoZJlfR2hqvSfwXy1IAlU1i8ChtlbUqRxFCyOo0W1M8DsKWpqR/X0a7
         pXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7w9Wk4XsiymDoxUOQYGkaO6e/RY6FCp5re/gF7e2038md6Btq/kkYM7nGMunptTIqdjq@lists.linux.dev
X-Gm-Message-State: AOJu0YziRY8wRA+vFcBQuP3+W/xr6TX++CNVq8PSxtZGdlDkHjYwwegc
	RC59sHHuwRjOgp64mankIl64dWtr/DEYHc0UOQ6wmbbhqqJ7ocFl2+Dt
X-Gm-Gg: ASbGncvHc0c9n4Ol7ug9sv9fIEdKzUBrYnOvVmJ+ETtgnhYl24Hj8Kcd5cwzDMMfUX2
	orPlftFCeBstuCRTe7QeGl+H+YvCQbNQZ4SfEQfn75tPTZ9b8GVBfL/ARX8eV9MzIOL4h1an5pb
	brPyq3HE0tg4MAz+QYLM9ChiECh8256oek/srx3PkyUfUcGquRPTwkx3tTbxgoElBkg0gzXgRnm
	vQPYd+V834wUASYNaHq5cM3BxZnI9xSpv0itE6M3UjWPyRCOPoz871Lm95htg3MKodq2xA2hyBi
	sKbZ99/WFUpCRvTKQFeY1Qvi+C944cpQxzrhaPgn9S+RJZIFz+SPM+DFKXg+yD11iMGtnmqwctv
	ofB92b1uoGztMgGKD9vPUuDVrLODcAeDE78PCYuI2baqKJtja
X-Google-Smtp-Source: AGHT+IHNIEbxa6UAWQsKzdL61JfAyD30h+IPFl21tAc/+urvhLse02Zgh6O344jn51W+QYvc3zIEvQ==
X-Received: by 2002:a17:902:db06:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-27ed4a2d078mr55247085ad.33.1758846565475;
        Thu, 25 Sep 2025 17:29:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671225fsm37637505ad.43.2025.09.25.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:25 -0700 (PDT)
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
Subject: [PATCH v5 01/14] iomap: move bio read logic into helper function
Date: Thu, 25 Sep 2025 17:25:56 -0700
Message-ID: <20250926002609.1302233-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9535733ed07a..7e65075b6345 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,36 +367,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -435,6 +414,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -559,7 +569,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -572,7 +582,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -749,7 +759,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3

