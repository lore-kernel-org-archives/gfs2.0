Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B53256D
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731781; cv=none; b=XtjM9TnOamTRYP8QJRckA+0jBJdknPbUEc4d2XbK4VMVp1/GFuo2kdaxWHkKG0eLZYUSGV9OzlZoY2OfokoykHpv48HSsjNZSeiueTMoOaG+L9tY1gl4J9ufxaV1BpUQQL3/VLSUpqSNcnvhzFiVIDup2TTjI5sCwJx3w0ZIWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731781; c=relaxed/simple;
	bh=HEPwOlaKio49vMBsbtjRO4EOSKFAJ7JKDj8UZIrcqOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEtIJec2W794yiACaJJCIoapYFSc4Ouftt4pxs7J7wzl25OVIQsE85T8EvDgeTiKz69toSNzP/PN7rt/tnRwpxcbSC6HBpOAxf0T9YU5velZ/xhqAGkLmH4AadSpI31AIGNyHT60wsBgdzVEVXtGAqtAnw8cpE3coAmkH0kzcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYXueh+3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYXueh+3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23694cec0feso45201495ad.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731779; x=1751336579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEXaJ/DMwwHCSfV250GaxLGmNj6bmYkxW+MNyVMHbe4=;
        b=aYXueh+3Jo/HfzlDcizcD5NrgmnMbcijGUtKzc+9PHbdkyr4upQ0h6Lsqw9zQZ/sBE
         sFhMvxYyGzW+sRpjqaNXFPiwp7xbP6OmIouVX6UByANIvC3mUsb3SGihiJmbIzPMqPWC
         OFmKWcQQTXbe2ODiGKLA7VniDXBCptNw0PjYkTDBVkrgseTy7llw4f5zaQOtlDKhRyw+
         Gz7n7zLZpQbmLxjPWtJu6shD9drckI+TkDQMLMMfpZEHS5smbU3ImlAVkdHjymZQ5kMU
         JGB7jWKPn6lSnjrgmjSN8MPoAo+fSOiiGO4351Rn2+dWqsd3b6sbkudoUW9mfW+ZK5Ii
         GFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731779; x=1751336579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEXaJ/DMwwHCSfV250GaxLGmNj6bmYkxW+MNyVMHbe4=;
        b=P+SsY/4DnnWxcpOvv/E5AsjFqiAiGgph6NaLyCpuxnU4hmSFJDprcJ9pJF+cPuw4YC
         ++7czJV2ruBHsnt9V6rePvZkmPh6L9rpHHGDM3+pLy4bNjbExjsilYkmElBwo6l/aZly
         0Ex6FPwjNylNZmUCbECs47kH+9ad+2AVyLYliiwRAHyN25ulGhB1BOSVZl82NUsw1Jfx
         m7hD/hi50BaTWSxVpSOTyhZ0AzS74W+X/k+34Wbjjxgghju2lr7vYVqrhuTbkhjCaa9c
         uPSK5vrdA7xF4aYYxPFAhLMibnes6kupjPkXI9JVr4B+gHU6Bf7uaqftxDnUVNbUre1r
         3LGA==
X-Forwarded-Encrypted: i=1; AJvYcCUEZUPBXjZk6v+71B8ap2Zd4fiPHTuZ5mnZB2IvqNTW+4SM0LtXCWX7XWxYtE3zoswHWySh@lists.linux.dev
X-Gm-Message-State: AOJu0YxUnXGbk+ukNlukwUXoCqHRC/9q+hsk1JC9isp5EWxbQHVv+kl7
	YFMmoP2dbrypurBBTin31pfKv6+FH8UqK6mPVNmaND+r19XmbtAHEwm/
X-Gm-Gg: ASbGncuNtpA1JRIrjgOYxEJ/hcfyTrNqg7ligEN/pSYOIkcvhwdrldV4uzckIShqPqg
	dqRlwjS62M+6rVIgD31NIXSiOTvdgCJ7Ho6EnrvMcb4Hd+gXqmEx57Yjuc7EfaeTHeiuxp9VlVI
	cKuLttLsl1MisqfR7ZkOMqggOPZv+FXrHpTaGx+z1rYp1GsR1bHlzYMyUB7LMNYUpqObo9+wj+3
	7xY5eCTC/7c4NE2ayxfJ2+vEYTLp9N4AvtxLPRwNK/r6JA9R2eQWlyWvoxtaAKuviea+fIRGhWP
	BrbrzqpBiRbR6RuXS9AbnMz54YQXkRCdOvzZnqU8JyfEV/wiEKOSMAXH
X-Google-Smtp-Source: AGHT+IHymgMpmoJgH2Zwou4WZ8WGr7n988EMOnaa8ygfI1eltuHseE6Kh+Iv6PBrk+c0k/a82yyuEA==
X-Received: by 2002:a17:903:32c5:b0:235:779:ede0 with SMTP id d9443c01a7336-237d98a09edmr259664355ad.35.1750731779023;
        Mon, 23 Jun 2025 19:22:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8700ab7sm95794215ad.224.2025.06.23.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:22:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 01/16] iomap: pass more arguments using struct iomap_writepage_ctx
Date: Mon, 23 Jun 2025 19:21:20 -0700
Message-ID: <20250624022135.832899-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Add inode and wpc fields to pass the inode and writeback context that
are needed in the entire writeback call chain, and let the callers
initialize all fields in the writeback context before calling
iomap_writepages to simplify the argument passing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c           |  8 +++++--
 fs/gfs2/aops.c         |  8 +++++--
 fs/iomap/buffered-io.c | 52 +++++++++++++++++++-----------------------
 fs/xfs/xfs_aops.c      | 24 +++++++++++++------
 fs/zonefs/file.c       |  8 +++++--
 include/linux/iomap.h  |  6 ++---
 6 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 1309861d4c2c..3394263d942b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_writeback_ops = {
 static int blkdev_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &blkdev_writeback_ops
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 const struct address_space_operations def_blk_aops = {
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 14f204cd5a82..47d74afd63ac 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -159,7 +159,11 @@ static int gfs2_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &gfs2_writeback_ops,
+	};
 	int ret;
 
 	/*
@@ -168,7 +172,7 @@ static int gfs2_writepages(struct address_space *mapping,
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
-	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
+	ret = iomap_writepages(&wpc);
 	if (ret == 0 && wbc->nr_to_write > 0)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..71ad17bf827f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1626,20 +1626,19 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos,
-		u16 ioend_flags)
+		loff_t pos, u16 ioend_flags)
 {
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
-			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
+			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
-	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
+	bio->bi_write_hint = wpc->inode->i_write_hint;
+	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
-	return iomap_init_ioend(inode, bio, pos, ioend_flags);
+	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
 }
 
 static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
@@ -1678,9 +1677,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * writepage context that the caller will need to submit.
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos,
-		unsigned len)
+		struct folio *folio, loff_t pos, loff_t end_pos, unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
@@ -1701,8 +1698,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		error = iomap_submit_ioend(wpc, 0);
 		if (error)
 			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
-				ioend_flags);
+		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
 
 	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
@@ -1756,24 +1752,24 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
 		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
 
-	wbc_account_cgroup_owner(wbc, folio, len);
+	wbc_account_cgroup_owner(wpc->wbc, folio, len);
 	return 0;
 }
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, u64 end_pos,
-		unsigned dirty_len, unsigned *count)
+		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
+		unsigned *count)
 {
 	int error;
 
 	do {
 		unsigned map_len;
 
-		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
+		error = wpc->ops->map_blocks(wpc, wpc->inode, pos, dirty_len);
 		if (error)
 			break;
-		trace_iomap_writepage_map(inode, pos, dirty_len, &wpc->iomap);
+		trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
+				&wpc->iomap);
 
 		map_len = min_t(u64, dirty_len,
 			wpc->iomap.offset + wpc->iomap.length - pos);
@@ -1787,8 +1783,8 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		case IOMAP_HOLE:
 			break;
 		default:
-			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					end_pos, map_len);
+			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
+					map_len);
 			if (!error)
 				(*count)++;
 			break;
@@ -1870,10 +1866,10 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 }
 
 static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio)
+		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
-	struct inode *inode = folio->mapping->host;
+	struct inode *inode = wpc->inode;
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
@@ -1920,8 +1916,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 */
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, end_pos, rlen, &count);
+		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
+				rlen, &count);
 		if (error)
 			break;
 		pos += rlen;
@@ -1957,10 +1953,9 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 }
 
 int
-iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
-		struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops)
+iomap_writepages(struct iomap_writepage_ctx *wpc)
 {
+	struct address_space *mapping = wpc->inode->i_mapping;
 	struct folio *folio = NULL;
 	int error;
 
@@ -1972,9 +1967,8 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 			PF_MEMALLOC))
 		return -EIO;
 
-	wpc->ops = ops;
-	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, wbc, folio);
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+		error = iomap_writepage_map(wpc, folio);
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 63151feb9c3f..65485a52df3b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -636,19 +636,29 @@ xfs_vm_writepages(
 	xfs_iflags_clear(ip, XFS_ITRUNCATED);
 
 	if (xfs_is_zoned_inode(ip)) {
-		struct xfs_zoned_writepage_ctx	xc = { };
+		struct xfs_zoned_writepage_ctx	xc = {
+			.ctx = {
+				.inode	= mapping->host,
+				.wbc	= wbc,
+				.ops	= &xfs_zoned_writeback_ops
+			},
+		};
 		int				error;
 
-		error = iomap_writepages(mapping, wbc, &xc.ctx,
-					 &xfs_zoned_writeback_ops);
+		error = iomap_writepages(&xc.ctx);
 		if (xc.open_zone)
 			xfs_open_zone_put(xc.open_zone);
 		return error;
 	} else {
-		struct xfs_writepage_ctx	wpc = { };
-
-		return iomap_writepages(mapping, wbc, &wpc.ctx,
-				&xfs_writeback_ops);
+		struct xfs_writepage_ctx	wpc = {
+			.ctx = {
+				.inode	= mapping->host,
+				.wbc	= wbc,
+				.ops	= &xfs_writeback_ops
+			},
+		};
+
+		return iomap_writepages(&wpc.ctx);
 	}
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 42e2c0065bb3..edca4bbe4b72 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -152,9 +152,13 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 static int zonefs_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	struct iomap_writepage_ctx wpc = { };
+	struct iomap_writepage_ctx wpc = {
+		.inode		= mapping->host,
+		.wbc		= wbc,
+		.ops		= &zonefs_writeback_ops,
+	};
 
-	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
+	return iomap_writepages(&wpc);
 }
 
 static int zonefs_swap_activate(struct swap_info_struct *sis,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 522644d62f30..00179c9387c5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -448,6 +448,8 @@ struct iomap_writeback_ops {
 
 struct iomap_writepage_ctx {
 	struct iomap		iomap;
+	struct inode		*inode;
+	struct writeback_control *wbc;
 	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
@@ -461,9 +463,7 @@ void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
-int iomap_writepages(struct address_space *mapping,
-		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
-		const struct iomap_writeback_ops *ops);
+int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
  * Flags for direct I/O ->end_io:
-- 
2.47.1

