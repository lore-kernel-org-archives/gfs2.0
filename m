Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038E2F28F4
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066641; cv=none; b=EkmzQNH4Sda0noH4N3g/rbtm5PEfjgJJNk3OKPKBt91d3Sdk1qhyDSmVo0nVmuyBy84BhB9zvOfVzO5g3RtSzNA5LfyauF2g0HbhZIXj4Z/cXnYjCXcPGHuo7tHUb0Dgy6DMalqgB1pgU4494Ao0llKRyIj3Go/T8bu6zvLfSkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066641; c=relaxed/simple;
	bh=VGunh0uENs1oKVEipOlQeeSZnl9YmLScA2w1/AQ6cfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As4tZJ7L5d7YjarzbSGg5AyGnoM1cm5YcSXe443GWeiZQncVcYaLwwfL522wsaB0r+5uJ9Vwo90BpN+Xn1XMmKn46k7gTNwLfuKsuNcnZoujkb0oszuFlGw9xkdmSf6C3OKjUTP5f2pnRcs2o7h91Tdue7JtiRj+YQ4Y1Pi8aOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alA+sD2d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alA+sD2d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-251fc032d1fso68144225ad.3
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066640; x=1758671440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu5+EirSaOm4rVQJq+asKnmescHkhWbNcqUv5AEv4JM=;
        b=alA+sD2dN8FfQQpqbZCIM0huouc8l8yhwBNChS03Lo+U2MJlzglbdUQHidzHElKJWo
         5dE1gqrBp5iwFGkxAMp+ZxCWfsR04p6zeM1yX3QQEtEp5DNWzz24XgY24OQh/s6dgGpm
         NVlSYbuxTC0flINlnHZ2JyCASenSgled3Qta92Tkxq23ZGduA3r7Nk3W0j6O/f05fBqh
         LT4g6Mo8zJ8QJjbA91bAnIVIVuz2dKqaVpY66bqaHzaO3d61y84jpV6zgpgbFQJZ4oqm
         1Yg7WNjx9DvMfrj4J4ZPM4ItwKS7DXE8Rnmy142P/9qLHnDtpGq9xWLRfiAsXuqNax++
         YAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066640; x=1758671440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu5+EirSaOm4rVQJq+asKnmescHkhWbNcqUv5AEv4JM=;
        b=g4ofHa5cKouPCw6PocVHBEfmwS1067Yfx3U8mPHDl7LDljrQzWboNFcCUBw1Th9vWP
         RqGhxPrmh9PNS14F8WI3B9+GzFqGxudeV+d1WvwE4GLGKvcMRJ9mihn2K/8Xr8bmUpZ6
         E5W40mWUdQx6NblxPMGHiFWg6BcpvZnxR/muGqq6ALH8Nfio1dg2RWvzUrZ9kpJbNZT4
         JJ0LxD6mi4LxuCSRo5fuiPr35PdxNeBb4M377wgx/juuEM27sNNEzjPxdCAqWe4YrKkG
         0Ajm8rMZJv+yQpEdXbZJP1UhiHM5pN3hKskMcGi/JF80LgmFShNnKSCQmGQ7kCvhzpmY
         dW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZUj1A9+Y1JlNHacnkwBqsRkx+OW0EIGCEKZe7kmGvptwFQbDQcpO9FNrCToWwWalxjAt1@lists.linux.dev
X-Gm-Message-State: AOJu0YzPcTMv8Oj7RO3NgrWEuKjpi7rwAcHrtDexbBU91B/bs5kc3/ct
	HkZ5yygQR7OhIiTWivuNrad5HnLYVp/6sxJonXbTgOZCacxFaIideKb9cmHxdg==
X-Gm-Gg: ASbGnctRT5rTfp94rPAI291xMueJXQiZ/pDNDm+CwweXkFOuc1L3yAaXejWxS43pHRR
	j0qWWZLi3p9/OcFY620AdZuYcZ19frWUyAbIt0RCjltBJ/9c2NGW61xYM9x4/0LO7lTd7v/03BW
	eQ0tllpEyFKvWj7EAJOCkPoIjkQBlvF8YEzTdQWXEtw3p/tEJ/RkNXy8rxWJ0F6tovmHSjcSYZF
	chqBjsNYjGrC1G/hen3uwOKhWofr4laJKiDKvAXWCSPbwDeOkZnVQ2f3CbBSaPB78GnocIqAmDD
	mB6VIxMLGWlYoqOY6gqApqK3MSjNY7Kky44/XmFX+vLglj7gkZzYfqeMaidIc86lniwWRJzDo0x
	wzYnytlRGob6VpLVsjudl9IEteNSCy6UtZ3bIP2xauwED9xPzsw==
X-Google-Smtp-Source: AGHT+IHXWaeobMccRHFmyjLsVkTTEzUvEQdZmGHGgnJY3NdcpQ/VkaAqzQfWkHRXLscEGvW5AibjWQ==
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id d9443c01a7336-268118b9516mr1315115ad.1.1758066639177;
        Tue, 16 Sep 2025 16:50:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2631ee2ceb2sm100151495ad.141.2025.09.16.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:38 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 08/15] iomap: add public start/finish folio read helpers
Date: Tue, 16 Sep 2025 16:44:18 -0700
Message-ID: <20250916234425.1274735-9-joannelkoong@gmail.com>
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

Move ifs read_bytes_pending increment logic into a separate helper,
iomap_start_folio_read(), which will be needed later on by
caller-provided read callbacks (added in a later commit) for
read/readahead. This is the counterpart to the currently existing
iomap_finish_folio_read().

Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
accessible. These need to be accessible in order for caller-provided
read callbacks to use.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 26 +++++++++++++++++---------
 include/linux/iomap.h  |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 587bbdbd24bc..379438970347 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -317,9 +317,20 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
-#ifdef CONFIG_BLOCK
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
+void iomap_start_folio_read(struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += len;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_read);
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -339,7 +350,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
+#ifdef CONFIG_BLOCK
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
@@ -369,17 +382,12 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
+	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..0938c4a57f4c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -467,6 +467,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_start_folio_read(struct folio *folio, size_t len);
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error);
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-- 
2.47.3

