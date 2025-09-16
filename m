Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78968236A73
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066631; cv=none; b=QW69qtEaxDhRyCqh0mbViDGIAJtdyoy7kOhsav7WDeBj7K05uwtRE62JP8HVzadL338buqjKkHoYpl8dQZY31/KaVamJRxyxkuaqSYGx5ZpXjKf88mhjya2Or3TWCAGmHsP4WCCSYCPV0nO8oOcEwTXn2/03jQev7hN9ZZ035q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066631; c=relaxed/simple;
	bh=w7oHmQ9XFnwraqw2yEaSdByUgxP5t881lYwL3uOQXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0JAp3Pdcvha01uP5hLSH/ACivoNYIhwIk+tBeCA/3tObT1aEFqjIVt8lwlMXbcH6oEZX2mB4WgdzHwNdC7YAEldHksfq1GTJDf6Ik5aICaut+WGR4At599Bk1fwFdzNpcFk4vMjzVxZJ+nvNcIQSHMHjJl37+tynou9fv7V4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3pWNIAW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3pWNIAW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so4003096a12.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066629; x=1758671429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=j3pWNIAWVoWHi/dn9Zf5hRKnebmdObw31VkSxmc8hwW1z4UtFthGW0eprwhfRc6H+1
         fQakRd2dLtMIgYYEkRX30E6NAmgOsu4l3qHtn1pxHvD3TZsbsUcoMoz07BfeAEg8X5za
         f01jb2ylRtWnBoqIT2D2/biOSO+vs7XoNgysQQSJhBGDDt2lGyJ+wj7omm/Ro151s6+x
         AQqM3Njni8SMEHlnjZNDJffY/w4fjMH65iN4MeBouRRiFe+Y7WutwdObSNwdZVOYc1lR
         tKdsDf0fxA7SSinoDatLooDupvK+XR0bU+kFHRRlPskGYTwp18u9CwcbCU95jkYGZud+
         QDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066629; x=1758671429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=tslPbs5sp0GSwyNEXuYWA1Eph4t5qhO17z153Sw59cnkxZJ0aRFdDcPt0jRlKzHFwF
         bkCwS3kDXCNKKujTfSfEnk0XEcA+/k2C5/3uETmdNIvl7PwbQfkhHLZQ7viUE4GBRbe6
         GKqFSHuIeZdmsURaAVFITPDRBwSYxGR9KQqpZpDJ3CXvU1cpPYAndH5eqeJi0cEeuMGX
         qcspPnTgur07tQvhX4zWc6d+o7GnpA+7Z6Wh/U8KmhDc2lTtcd1k0GNjyHEnXQXi8vW0
         8MWKu79qEyRRPYNyAvpa7043VUirUcisf1Fi3XXf3TZrBnjUoiEyeDeg00dTc8tT/zVm
         3i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU3hib1uxlqGXyC+RaY36A3LAdX+HCm4LlYUmqpWyv1393tQsY1F5tZTuy+DDkIX/P/PpC@lists.linux.dev
X-Gm-Message-State: AOJu0YyUvfXTH2CQvtghkJZGQL8umG6vk6LZkgRhuxtbyNPml3u7USeL
	uY2tI0zM/prOcUOleyC+fyBDNXEMqsLILh/wny/ckRzQ/BzNKZJOdoEL
X-Gm-Gg: ASbGncuJ0L87ZDt8MMD0zsdDfcQrXMl6WY6/z13F/UFlwzgdHXUOhT1ZQLnkAW/E7nx
	kjdhHVXWqSFP/LwDHc+mOBO4mBhBSke9RZ7yE53CxS7EfEiUO4gP5ZuNkoRnUxkNeA9ROL7WIWe
	mElsuULRaXtwNClyzOb7qO1zFpxDyzJd5bTcKHqV6Zupj0vFsgEIcRLAxx2p7Pb/WUi/G/D5pHi
	uiBdzLRCNJvBoVbtG4Qyj8f28x+PMxJYrnUCDjfIxSLs+GizMCDMORS1UI3XiKkTli7pDxVJYJc
	FKyxYNYv9fYZVmtbZdNq5NHyDr0wQBvXGXt4YKLHd4NecLimRf06OhNHpl79cEbaxqkTiMHr4XW
	Qxv3imCI08OQLaVlbt2aiWoCZR8Q5HRao53U2ws9hIXcX3CyJXA==
X-Google-Smtp-Source: AGHT+IEwM37n6OeuEIlANEEpCI0EjMz/gqdNYw7ssUAAFOa4ZLo8dnWTZo/sk9QfoO9n62XpLdWOZw==
X-Received: by 2002:a17:902:db0d:b0:265:c476:9a53 with SMTP id d9443c01a7336-26813cf234fmr721615ad.41.1758066628820;
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2680889f486sm3438975ad.137.2025.09.16.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
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
Subject: [PATCH v3 01/15] iomap: move bio read logic into helper function
Date: Tue, 16 Sep 2025 16:44:11 -0700
Message-ID: <20250916234425.1274735-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..05399aaa1361 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
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
-		return iomap_iter_advance(iter, &length);
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
@@ -425,6 +404,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		return iomap_iter_advance(iter, &length);
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
@@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
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

