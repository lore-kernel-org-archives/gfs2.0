Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550E214801
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731799; cv=none; b=lTq817vEqfF3TUWLQ9TUiYl+tndpqhkCefaqS2d2dPLf2qcvxQrdWsiBdw5u8zYz00DKtqQ8X6Aohi7+kT09VK5ZofWRYOTblxdbyOzyK5O4LoeFfvG+ogpULsBVzp4YLBIrNb5iZ9D9kF5wA0kks0RzFb6DNSpDTxok9hBk+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731799; c=relaxed/simple;
	bh=xPI4TWcQbS7M7QVCzpfeAKRtMJX614jM/7cR7a+1Vmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URv31uNftq5s3+/1zkjq5A93j5KBDBCxNFpt613R0ROqrt5GZvw6ipQEz453mc14GQCgNkU4XNz9DS7ikzaF43icWZKlqXreLonmBLYVg6947Myoslu8SQxWBlCQ9dy7lax5d8cxK/4SreND6env0aDJcCakMp//4XIDbHcgxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTxuJSGE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTxuJSGE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-237311f5a54so47778075ad.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731796; x=1751336596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpKKxlFsnVnwGn9tqqMouy+P4/pVETZ3pfuH3gqobfw=;
        b=MTxuJSGE+emet+xx9CyL1F2czoWu+4FZ7duCUhkpr2nz3RGdPv+RpaDL/Wzl5UCG/2
         rikPwMOj53xIA2dwdq+DT9u443KO5HTZVKKms6sZqRqsIOXWkZw9wS4iP6YZzy8tNFzb
         8m2MWkyHwCZwsW0GMczFCLh2zUDbGqNsXg1zODKO5thfMqiAMSDHLlk3IRI/FprFtnog
         KYGdVQdc2jT74TwOvzWcbeQ14eAH5kcNR3A5kHF7VV4ShVAOXCA5iBrP13iz4HN+b/3j
         Y2bk3DpgBYRMzBKnGLyZt6Ynpc8DwPeynfRHm/vG9RqiobUuzUB9Bj9IpOwnATP7Em66
         MwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731796; x=1751336596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpKKxlFsnVnwGn9tqqMouy+P4/pVETZ3pfuH3gqobfw=;
        b=rvZyMuPa2onKob7uzlwyRWauWBhEs0BckgM8My0S7Zd60KkBoYYopL2n7fJQdFx+Wj
         P55SYRvwWyEOOLPZiWWFcR4o1HaZSV2G8UN1zetG5Sr75oy4Wd5RQxoXOBfpjGkP4YOX
         v1TjQqoPCAjlwcjIYxPKyk/6N5BWxpExFKqsckbUz3HOPcFcM3B5ZATk4KKb0dPoQOjJ
         ZvIwH4XExWH+P9rmvqm4/8D492KzSh3V5cXk5Q1EngSesG0FuyN+Zr3nlg5RhRZBi6In
         Ouh4xdHVSYXaEx06FQe/HII124ZTGF/MdeoL59R+lqZL3arMOy/SFVJ9Mp0XSSqOqHeC
         m2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEkUweiNgTaVkWDVl0eU43XPjLyET0BqkGoRVnTeBQDrhENEuGmnSNwPsrBhMt+fU2X22W@lists.linux.dev
X-Gm-Message-State: AOJu0YwCpxXWq/yW3OcQs+9pEOw5Y1uVH1gG0QQ+w8Pd8OlETxRNNQji
	9unEj2hH2FsxguG65QDd5hDwjXW+V+2N9ZBccWomgkbv+ei0UyXSM4OB
X-Gm-Gg: ASbGncvKJl8y12enxlrLDpr4t9Vamkp36bqKP97kmhEh7X3s6ig8QOlykRvz5n7Ob17
	t4rlreYzKY1gsCO4pO6l/ns+AmIffZtsjxCiihkSdbMrGsB/7+tvooZxGyt69+Tdf+ZZulGg4ph
	Yljj5jzI7u+JcPLnZ0pgTxHBziFJTBQ5I6J7HAmkptw7SuP366ctfknPmwmKDGCzRlIpF6p/kgv
	m01Av/Hnq54wSRKJC+kd+bgDFo7wwmQkzATXb8D8311wsO5QLu70YCzkjL/1Dh7kQrQV4p8sW4d
	1TKiv9o+ECZ0XDj2tp88mPZ6mAUm85meb+F59VSoGqJtFM/QZQYNbFnc
X-Google-Smtp-Source: AGHT+IHyOQ/+PMnBaCWpHdXh0kkik6NWpgz9bIa4pG6Fcdcb1I1Efz19MvlCcAblBRm5gyV4SxJNEg==
X-Received: by 2002:a17:902:f68b:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-237d9875dffmr251963385ad.5.1750731796353;
        Mon, 23 Jun 2025 19:23:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b55sm7693494a12.61.2025.06.23.19.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:16 -0700 (PDT)
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
Subject: [PATCH v3 13/16] fuse: use iomap for writeback
Date: Mon, 23 Jun 2025 19:21:32 -0700
Message-ID: <20250624022135.832899-14-joannelkoong@gmail.com>
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

Use iomap for dirty folio writeback in ->writepages().
This allows for granular dirty writeback of large folios.

Only the dirty portions of the large folio will be written instead of
having to write out the entire folio. For example if there is a 1 MB
large folio and only 2 bytes in it are dirty, only the page for those
dirty bytes will be written out.

.dirty_folio needs to be set to iomap_dirty_folio so that the bitmap
iomap uses for dirty tracking correctly reflects dirty regions that need
to be written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 124 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a7f11c1a4f89..2b4b950eaeed 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1837,7 +1837,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
-		folio_end_writeback(ap->folios[i]);
+		iomap_finish_folio_write(inode, ap->folios[i], 1);
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		wb_writeout_inc(&bdi->wb);
 	}
@@ -2024,19 +2024,20 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 }
 
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
-					  uint32_t folio_index)
+					  uint32_t folio_index, loff_t offset, unsigned len)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
 	ap->folios[folio_index] = folio;
-	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = folio_size(folio);
+	ap->descs[folio_index].offset = offset;
+	ap->descs[folio_index].length = len;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
+							     size_t offset,
 							     struct fuse_file *ff)
 {
 	struct inode *inode = folio->mapping->host;
@@ -2049,7 +2050,7 @@ static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio
 		return NULL;
 
 	fuse_writepage_add_to_bucket(fc, wpa);
-	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
+	fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->inode = inode;
 	wpa->ia.ff = ff;
@@ -2075,7 +2076,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	if (!ff)
 		goto err;
 
-	wpa = fuse_writepage_args_setup(folio, ff);
+	wpa = fuse_writepage_args_setup(folio, 0, ff);
 	error = -ENOMEM;
 	if (!wpa)
 		goto err_writepage_args;
@@ -2084,7 +2085,7 @@ static int fuse_writepage_locked(struct folio *folio)
 	ap->num_folios = 1;
 
 	folio_start_writeback(folio);
-	fuse_writepage_args_page_fill(wpa, folio, 0);
+	fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio));
 
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
@@ -2105,7 +2106,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
-	unsigned int nr_pages;
+	unsigned int nr_bytes;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2147,21 +2148,28 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 }
 
 static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
+				     loff_t offset, unsigned len,
 				     struct fuse_args_pages *ap,
 				     struct fuse_fill_wb_data *data)
 {
+	struct folio *prev_folio;
+	struct fuse_folio_desc prev_desc;
+
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
+	if ((data->nr_bytes + len) / PAGE_SIZE > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
+	if (data->nr_bytes + len > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio->index)
+	prev_folio = ap->folios[ap->num_folios - 1];
+	prev_desc = ap->descs[ap->num_folios - 1];
+	if ((folio_pos(prev_folio) + prev_desc.offset + prev_desc.length) !=
+	    folio_pos(folio) + offset)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2171,85 +2179,103 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	return false;
 }
 
-static int fuse_writepages_fill(struct folio *folio,
-		struct writeback_control *wbc, void *_data)
+static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
+					  struct folio *folio, u64 pos,
+					  unsigned len, u64 end_pos)
 {
-	struct fuse_fill_wb_data *data = _data;
+	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	int err;
+	loff_t offset = offset_in_folio(folio, pos);
+
+	WARN_ON_ONCE(!data);
+	/* len will always be page aligned */
+	WARN_ON_ONCE(len & (PAGE_SIZE - 1));
 
 	if (!data->ff) {
-		err = -EIO;
 		data->ff = fuse_write_file_get(fi);
 		if (!data->ff)
-			goto out_unlock;
+			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
+	iomap_start_folio_write(inode, folio, 1);
+
+	if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
-		data->nr_pages = 0;
+		data->nr_bytes = 0;
 	}
 
 	if (data->wpa == NULL) {
-		err = -ENOMEM;
-		wpa = fuse_writepage_args_setup(folio, data->ff);
+		wpa = fuse_writepage_args_setup(folio, offset, data->ff);
 		if (!wpa)
-			goto out_unlock;
+			return -ENOMEM;
 		fuse_file_get(wpa->ia.ff);
 		data->max_folios = 1;
 		ap = &wpa->ia.ap;
 	}
-	folio_start_writeback(folio);
 
-	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
-	data->nr_pages += folio_nr_pages(folio);
+	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios,
+				      offset, len);
+	data->nr_bytes += len;
 
-	err = 0;
 	ap->num_folios++;
 	if (!data->wpa)
 		data->wpa = wpa;
-out_unlock:
-	folio_unlock(folio);
 
-	return err;
+	return len;
 }
 
+static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
+				       int error)
+{
+	struct fuse_fill_wb_data *data = wpc->wb_ctx;
+
+	WARN_ON_ONCE(!data);
+
+	if (data->wpa) {
+		WARN_ON(!data->wpa->ia.ap.num_folios);
+		fuse_writepages_send(data);
+	}
+
+	if (data->ff)
+		fuse_file_put(data->ff, false);
+
+	return error;
+}
+
+static const struct iomap_writeback_ops fuse_writeback_ops = {
+	.writeback_range	= fuse_iomap_writeback_range,
+	.writeback_submit	= fuse_iomap_writeback_submit,
+};
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_wb_data data;
-	int err;
+	struct fuse_fill_wb_data data = {
+		.inode = inode,
+	};
+	struct iomap_writepage_ctx wpc = {
+		.inode = inode,
+		.iomap.type = IOMAP_MAPPED,
+		.wbc = wbc,
+		.ops = &fuse_writeback_ops,
+		.wb_ctx	= &data,
+	};
 
-	err = -EIO;
 	if (fuse_is_bad(inode))
-		goto out;
+		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fc->num_background >= fc->congestion_threshold)
 		return 0;
 
-	data.inode = inode;
-	data.wpa = NULL;
-	data.ff = NULL;
-	data.nr_pages = 0;
-
-	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
-	if (data.wpa) {
-		WARN_ON(!data.wpa->ia.ap.num_folios);
-		fuse_writepages_send(&data);
-	}
-	if (data.ff)
-		fuse_file_put(data.ff, false);
-
-out:
-	return err;
+	return iomap_writepages(&wpc);
 }
 
 static int fuse_launder_folio(struct folio *folio)
@@ -3109,7 +3135,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.readahead	= fuse_readahead,
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
-- 
2.47.1

