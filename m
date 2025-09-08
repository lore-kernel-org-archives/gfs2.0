Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99916320CBD
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357562; cv=none; b=boN5KseS83TCxLtKg0UwzW4f+snfhB9s6LV6h5gqqc7oKFNXrlcc4EtOf4tNufBiy2DCZ0n3VskXHwH9/ESfXpKzIYjSUquTnVBV9t+cCnXyFZMpuB+TmhFZJStcR5aFEJ5vRlp4uq9kyNeKw5HiXHbI9+4ZQ3lRcCDAz8GsBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357562; c=relaxed/simple;
	bh=ENwi4DO1DhkFAbdGM8UHbOMn7Ao1iZRX47ZuoN1VdK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr6+Hz1gDZ+YntC5cdg6JLpZbCrY08iajFnQz7RNclbnldEjsZpVHUWOTGa/LrFvgtUjdyIsXhSQt0/XiZuvTmnJ5pI+Y+mvJii7pzKgolcUPsuHugR0LHdIOpddtlwDU4GVU2JSR2KGwPsak27ifXIouvGtRcg0yhnVVupVDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btwaDwo2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btwaDwo2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25221fa3c9bso15593965ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357560; x=1757962360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNhHc1Pq7t/O//ofoKIAyED7To1mRzYJL45Fx5MHeFk=;
        b=btwaDwo2WX2FTF51e6F38ioQEHN0QCtJqYsXvHUomEg784Dvlhius7/fc4t+4HFEzV
         5pbFgvX5HZAUqFfvCQWqcZ7/eQh0IvmJCdK5vGrWJTJjBvsqQIPxG/aTEH0CYEAkGsgw
         zEIodxSf1itqS1V+CEuvp7NxYiQgv77CYGNvyohTsvgGRRKUEfT+s0wvE83hw4nEjnUu
         +Xe+F/HU46pnc1pnRCbQS3epUca/Wlhz5XytpvjABK5+Ggo+xC4OZwC72NOxoUdEfxgJ
         7D7SzsI1if1a7iJQdNYIFbkrgkfVFhrl9DoPrCcRhGPCHUo2rzTwq5H5P82q/SJv+jCs
         KxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357560; x=1757962360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNhHc1Pq7t/O//ofoKIAyED7To1mRzYJL45Fx5MHeFk=;
        b=wS7A+uHBgIQxcFeSC8toJUtYs0sjU2HriBbZBMUuBXhd4pQWftg6sb1HcvX6wUtZaO
         x8njwHwCJwVnvbhyqJdWD/XJagc1DsX8rBnRQtFhvKeBWG6xxkNGbuCCjWuljSzWPeNY
         Yl2cDVQS3VIyoUrGiYuz8gHm0lQ9PrceDoDtNy8T3PXZwLNuiHWIozpGhSk+tARjmiST
         lN1KbVdsxQGjfoaA5OP69M0wcq4s7iWYgI+Oe/QDfQCXe6RpMp4iV1q9jql6V6xtVm7y
         xZQrJ+5LSQaUG6cw625VI0UHgQ5KYpnHcFThEL1AbLo71duYDWnDjk+r0cOI48BpM0QM
         B4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd3CNvj5GnYQYflmsIYVgVu5wMg/G3frEWKbK/ajEUZ+MblGYipztgc9Y9lAbFKT3FU2XZ@lists.linux.dev
X-Gm-Message-State: AOJu0YymShDWxT5OdXyMRPTTUdgHsm1G8CvrZQJEqzDgWoVOXmaK0qCY
	UNVATEF3+WFAd/u5JMpsLMu3QD8VqBtCtMEuDKksVCJ0QaZQyYC1I5EX
X-Gm-Gg: ASbGnctKYBISTUp/18UE9qb0Q/J2fiOA+yL9HIPn5aGWFb5QayUbPJ9vamq3HLnNrU/
	P145sxu8a2kiVQUGGyHyBmv2WsJvg7MW0BuAHK2opvS+ypNeTZT6ZeMHSFpCjT7W5aIgU72jjAG
	EysjDuv5aO00iuNnQwHuASBtPIe/09XsKA2qb0dj7ieaisZR4aeyH9bBBcj1PxP41jgMXOmhPgO
	g6VbdsuHn/7lZwiKZndWmXjsPMkrqFqmQTG+ASrsRlkdN3TMf2QAEHkgXWME2XVIqUj6hQOs01C
	OthtsJRwVzH2IeF5bReBwWvqTsyUSbzzvPxGDQCavSDPTni1M6lSNm/HwvJe32AvL4ElY00ATQk
	ALwfX2r+Jhnjy9j9spn6jKW6B8QOJ
X-Google-Smtp-Source: AGHT+IGiI7Qhq5OYluJANV0Nkto+66mAzQa9awlU3cX43aLUBp3N0DTRFQuV6w7zIE2+iBewWEhRUA==
X-Received: by 2002:a17:902:f78f:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-251788fcff7mr113077325ad.17.1757357559846;
        Mon, 08 Sep 2025 11:52:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm144137415ad.95.2025.09.08.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:39 -0700 (PDT)
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
Subject: [PATCH v2 15/16] fuse: use iomap for readahead
Date: Mon,  8 Sep 2025 11:51:21 -0700
Message-ID: <20250908185122.3199171-16-joannelkoong@gmail.com>
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

Do readahead in fuse using iomap. This gives us granular uptodate
tracking for large folios, which optimizes how much data needs to be
read in. If some portions of the folio are already uptodate (eg through
a prior write), we only need to read in the non-uptodate portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 224 ++++++++++++++++++++++++++++---------------------
 1 file changed, 128 insertions(+), 96 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5b75a461f8e1..3f57b5c6e037 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -844,8 +844,68 @@ static const struct iomap_ops fuse_iomap_ops = {
 
 struct fuse_fill_read_data {
 	struct file *file;
+
+	/*
+	 * Fields below are used if sending the read request
+	 * asynchronously.
+	 */
+	struct fuse_conn *fc;
+	struct fuse_io_args *ia;
+	unsigned int nr_bytes;
 };
 
+/* forward declarations */
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write);
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count, bool async);
+
+static int fuse_handle_readahead(struct folio *folio,
+				 struct readahead_control *rac,
+				 struct fuse_fill_read_data *data, loff_t pos,
+				 size_t len)
+{
+	struct fuse_io_args *ia = data->ia;
+	size_t off = offset_in_folio(folio, pos);
+	struct fuse_conn *fc = data->fc;
+	struct fuse_args_pages *ap;
+	unsigned int nr_pages;
+
+	if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_bytes,
+					false)) {
+		fuse_send_readpages(ia, data->file, data->nr_bytes,
+				    fc->async_read);
+		data->nr_bytes = 0;
+		data->ia = NULL;
+		ia = NULL;
+	}
+	if (!ia) {
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			return -EAGAIN;
+
+		nr_pages = min(fc->max_pages, readahead_count(rac));
+		data->ia = fuse_io_alloc(NULL, nr_pages);
+		if (!data->ia)
+			return -ENOMEM;
+		ia = data->ia;
+	}
+	folio_get(folio);
+	ap = &ia->ap;
+	ap->folios[ap->num_folios] = folio;
+	ap->descs[ap->num_folios].offset = off;
+	ap->descs[ap->num_folios].length = len;
+	data->nr_bytes += len;
+	ap->num_folios++;
+
+	return 0;
+}
+
 static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 					     struct iomap_read_folio_ctx *ctx,
 					     loff_t pos, size_t len)
@@ -856,18 +916,41 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 	struct file *file = data->file;
 	int ret;
 
-	/*
-	 *  for non-readahead read requests, do reads synchronously since
-	 *  it's not guaranteed that the server can handle out-of-order reads
-	 */
 	iomap_start_folio_read(folio, len);
-	ret = fuse_do_readfolio(file, folio, off, len);
-	iomap_finish_folio_read(folio, off, len, ret);
+	if (ctx->rac) {
+		ret = fuse_handle_readahead(folio, ctx->rac, data, pos, len);
+		/*
+		 * If fuse_handle_readahead was successful, fuse_readpages_end
+		 * will do the iomap_finish_folio_read, else we need to call it
+		 * here
+		 */
+		if (ret)
+			iomap_finish_folio_read(folio, off, len, ret);
+	} else {
+		/*
+		 *  for non-readahead read requests, do reads synchronously
+		 *  since it's not guaranteed that the server can handle
+		 *  out-of-order reads
+		 */
+		ret = fuse_do_readfolio(file, folio, off, len);
+		iomap_finish_folio_read(folio, off, len, ret);
+	}
 	return ret;
 }
 
+static int fuse_iomap_read_submit(struct iomap_read_folio_ctx *ctx)
+{
+	struct fuse_fill_read_data *data = ctx->private;
+
+	if (data->ia)
+		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
+				    data->fc->async_read);
+	return 0;
+}
+
 static const struct iomap_read_ops fuse_iomap_read_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range_async,
+	.read_submit = fuse_iomap_read_submit,
 };
 
 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -930,7 +1013,8 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	for (i = 0; i < ap->num_folios; i++) {
-		folio_end_read(ap->folios[i], !err);
+		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
+					ap->descs[i].length, err);
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
@@ -940,7 +1024,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 }
 
 static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
-				unsigned int count)
+				unsigned int count, bool async)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
@@ -962,7 +1046,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -979,81 +1063,20 @@ static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	unsigned int max_pages, nr_pages;
-	struct folio *folio = NULL;
+	struct fuse_fill_read_data data = {
+		.file = rac->file,
+		.fc = fc,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.ops = &fuse_iomap_read_ops,
+		.rac = rac,
+		.private = &data
+	};
 
 	if (fuse_is_bad(inode))
 		return;
 
-	max_pages = min_t(unsigned int, fc->max_pages,
-			fc->max_read / PAGE_SIZE);
-
-	/*
-	 * This is only accurate the first time through, since readahead_folio()
-	 * doesn't update readahead_count() from the previous folio until the
-	 * next call.  Grab nr_pages here so we know how many pages we're going
-	 * to have to process.  This means that we will exit here with
-	 * readahead_count() == folio_nr_pages(last_folio), but we will have
-	 * consumed all of the folios, and read_pages() will call
-	 * readahead_folio() again which will clean up the rac.
-	 */
-	nr_pages = readahead_count(rac);
-
-	while (nr_pages) {
-		struct fuse_io_args *ia;
-		struct fuse_args_pages *ap;
-		unsigned cur_pages = min(max_pages, nr_pages);
-		unsigned int pages = 0;
-
-		if (fc->num_background >= fc->congestion_threshold &&
-		    rac->ra->async_size >= readahead_count(rac))
-			/*
-			 * Congested and only async pages left, so skip the
-			 * rest.
-			 */
-			break;
-
-		ia = fuse_io_alloc(NULL, cur_pages);
-		if (!ia)
-			break;
-		ap = &ia->ap;
-
-		while (pages < cur_pages) {
-			unsigned int folio_pages;
-
-			/*
-			 * This returns a folio with a ref held on it.
-			 * The ref needs to be held until the request is
-			 * completed, since the splice case (see
-			 * fuse_try_move_page()) drops the ref after it's
-			 * replaced in the page cache.
-			 */
-			if (!folio)
-				folio =  __readahead_folio(rac);
-
-			folio_pages = folio_nr_pages(folio);
-			if (folio_pages > cur_pages - pages) {
-				/*
-				 * Large folios belonging to fuse will never
-				 * have more pages than max_pages.
-				 */
-				WARN_ON(!pages);
-				break;
-			}
-
-			ap->folios[ap->num_folios] = folio;
-			ap->descs[ap->num_folios].length = folio_size(folio);
-			ap->num_folios++;
-			pages += folio_pages;
-			folio = NULL;
-		}
-		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
-		nr_pages -= pages;
-	}
-	if (folio) {
-		folio_end_read(folio, false);
-		folio_put(folio);
-	}
+	iomap_readahead(&fuse_iomap_ops, &ctx);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -2084,7 +2107,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	unsigned int max_folios;
 	/*
-	 * nr_bytes won't overflow since fuse_writepage_need_send() caps
+	 * nr_bytes won't overflow since fuse_folios_need_send() caps
 	 * wb requests to never exceed fc->max_pages (which has an upper bound
 	 * of U16_MAX).
 	 */
@@ -2129,14 +2152,15 @@ static void fuse_writepages_send(struct inode *inode,
 	spin_unlock(&fi->lock);
 }
 
-static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
-				     unsigned len, struct fuse_args_pages *ap,
-				     struct fuse_fill_wb_data *data)
+static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
+				  unsigned len, struct fuse_args_pages *ap,
+				  unsigned cur_bytes, bool write)
 {
 	struct folio *prev_folio;
 	struct fuse_folio_desc prev_desc;
-	unsigned bytes = data->nr_bytes + len;
+	unsigned bytes = cur_bytes + len;
 	loff_t prev_pos;
+	size_t max_bytes = write ? fc->max_write : fc->max_read;
 
 	WARN_ON(!ap->num_folios);
 
@@ -2144,8 +2168,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
 		return true;
 
-	/* Reached max write bytes */
-	if (bytes > fc->max_write)
+	if (bytes > max_bytes)
 		return true;
 
 	/* Discontinuity */
@@ -2155,11 +2178,6 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, loff_t pos,
 	if (prev_pos != pos)
 		return true;
 
-	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios &&
-	    !fuse_pages_realloc(data, fc->max_pages))
-		return true;
-
 	return false;
 }
 
@@ -2183,10 +2201,24 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 			return -EIO;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, pos, len, ap, data)) {
-		fuse_writepages_send(inode, data);
-		data->wpa = NULL;
-		data->nr_bytes = 0;
+	if (wpa) {
+		bool send = fuse_folios_need_send(fc, pos, len, ap,
+						  data->nr_bytes, true);
+
+		if (!send) {
+			/*
+			 * Need to grow the pages array?  If so, did the
+			 * expansion fail?
+			 */
+			send = (ap->num_folios == data->max_folios) &&
+				!fuse_pages_realloc(data, fc->max_pages);
+		}
+
+		if (send) {
+			fuse_writepages_send(inode, data);
+			data->wpa = NULL;
+			data->nr_bytes = 0;
+		}
 	}
 
 	if (data->wpa == NULL) {
-- 
2.47.3

