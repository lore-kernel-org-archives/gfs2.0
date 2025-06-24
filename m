Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0D204C36
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731794; cv=none; b=BoJX8XAkObz0KRsGoGCHAHk6U+wl3n+y78whMuT9JOCEu72Y2I7ZV+L7oPaj/oYUFATOYPtakBCWh8Nh0yKuKRFtMrboNDY7BOmXlMWgUC4ZpRDZdL+gmqXKKDrDHrSZPnQfYJFyeff1PqJoWVskX0r7u6GZ+A1hyRC17CpZHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731794; c=relaxed/simple;
	bh=CxZRgLbpF13BKeJx8W6kiMi8llIec+n4YSNb1JNrhxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcngjYPhmci6WZw/UFd4nSfjJRGcC1Sxaw6owvLmcpgc2+YaNWGwATe6he1bJZ7rVmH+2mRsCDrP5gBaALzmWVR/2LQJcSZ63yP1npBzQvvIaFeWTZJDdIaAH9xqbg8ZWVv2OyfhQwL677M4Bm3ZlDME86Oxo7qBIVXHYF0EhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FImvUl4u; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FImvUl4u"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23526264386so52809815ad.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731792; x=1751336592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj+twMBBlNLDrfWEaJoBKnjjy6lZDI73gXn/kSji+X8=;
        b=FImvUl4udB/fkyw5s4B9RbBngBh5ZD4M42YiHqVvp6RtI4EoJCKXicdlxj8QP+Sp8N
         NzpXMbOvBMlTsbHlLfx5fxIxIfRIWGrUWRo1jq6OR4DNy+1j86hYgP60hwc/LE982UyG
         iO3iYp6ZeFUk8SBuCDh0eqmzq2g80nQGlthCFaX+HqZy5QcnLdqUHNPPTdcuISzmPLrj
         yCsP+OTAGmRMHRWuLP/mf5cyAIKxjEu3OTlUKMv5JHnqVeRx9nfa6GuK9e3mbGHObSAA
         OOD2MqMxFwUGv1OZDHkA2DCHRxoJ2kk5WHeDXJx/UdnDt9C9Ny/8Xntioz51kueL54aF
         tnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731792; x=1751336592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj+twMBBlNLDrfWEaJoBKnjjy6lZDI73gXn/kSji+X8=;
        b=HWTxS6FDqTBNkjmJ7qTcg2StvMOSiu0WSJWFFmTiO/OMUauZ7w0jYO4prZi/5Z9rvz
         ehCPivRRZ9W7Bmr9BbtizrnHAjJUAIeNVYUb2GWmMKww0D1mxJbwjThVTbuu9GABYSCg
         9uHzWkxBeIoEa1vEEYSnWTWEO0BVBLsuH2sKfUJQPiXkWWC4VTwEnufvVhPzkY5eoYla
         D0Mmyle9bq9z31zMcPxwxbY8KLVb9Rp6K7aqqEUlukh6nCU74+LlNpKkDKbg05zAnSfQ
         kC3gyrCw91BCD08WhID7WK5nC/b+gLIMct1tZ73r+g14NDK6JA3RdVSci80V7noLOaOh
         oh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWH621fDfgqK7YMXAtwpvYFlngsv4ZqpvVfz/UM/H9uDSPevKYOmWIW9ZXOwcODFxaPtZgp@lists.linux.dev
X-Gm-Message-State: AOJu0YwVUbHmxMP1XOt/X67qvjLoRecQ5K9S6TQTT7pb/R0qXQxAHzVl
	GzQCyC+VkoOqNhRCJW4zs7y6g+8kZXoz6i+rGst3tZoFPZk+dLaHmj9Q
X-Gm-Gg: ASbGncsfx4JCs1UYMrYHhoKB38WoIGlNWyrEy/6KwGerxFduIwLZMhlrViZDDPxqsBV
	MPqTS0NIKXadRPVdfy7J0V2T3yllTitT/TRfcyYmBFkDX9l45nHaNGZWwiIaOGUSQue2gA60gLt
	wnk+j+rthlsTVlqBGO+HvSyvZqOwa1ohns137n7L7C2z2ga8Xohn67KRbJrD69fzBlUbtI2hM7i
	p1lxb/uFUTHsH76BeHhME+NQB5HLPUROwS4T0JZOLC8sAXUUSFKb6wYb/U6VSNnpTXpMSKvwaI0
	o6AArrPblV7+p0Kjg4ZxQOeLcjWRoWny7zNLUTD4Aa/8o7xjAQ6Z62Ox
X-Google-Smtp-Source: AGHT+IGdMJjZOVl7aNXwNYpT+3KkItrE7ykuIrjQO56awFgqZDbXbATmp/a0LDEKkvWFfI4wHMm9JQ==
X-Received: by 2002:a17:902:d58d:b0:234:a033:b6f6 with SMTP id d9443c01a7336-237d9917e17mr249756375ad.31.1750731792030;
        Mon, 23 Jun 2025 19:23:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86d1b2asm94246065ad.204.2025.06.23.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:11 -0700 (PDT)
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
Subject: [PATCH v3 10/16] iomap: replace iomap_folio_ops with iomap_write_ops
Date: Mon, 23 Jun 2025 19:21:29 -0700
Message-ID: <20250624022135.832899-11-joannelkoong@gmail.com>
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

The iomap_folio_ops are only used for buffered writes, including
the zero and unshare variants.  Rename them to iomap_write_ops
to better describe the usage, and pass them through the callchain
like the other operation specific methods instead of through the
iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/iomap/design.rst    |  3 -
 .../filesystems/iomap/operations.rst          |  8 +-
 block/fops.c                                  |  3 +-
 fs/gfs2/bmap.c                                | 21 ++---
 fs/gfs2/bmap.h                                |  1 +
 fs/gfs2/file.c                                |  3 +-
 fs/iomap/buffered-io.c                        | 79 +++++++++++--------
 fs/xfs/xfs_file.c                             |  6 +-
 fs/xfs/xfs_iomap.c                            | 12 ++-
 fs/xfs/xfs_iomap.h                            |  1 +
 fs/xfs/xfs_reflink.c                          |  3 +-
 fs/zonefs/file.c                              |  3 +-
 include/linux/iomap.h                         | 22 +++---
 13 files changed, 89 insertions(+), 76 deletions(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index f2df9b6df988..0f7672676c0b 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -167,7 +167,6 @@ structure below:
      struct dax_device   *dax_dev;
      void                *inline_data;
      void                *private;
-     const struct iomap_folio_ops *folio_ops;
      u64                 validity_cookie;
  };
 
@@ -292,8 +291,6 @@ The fields are as follows:
    <https://lore.kernel.org/all/20180619164137.13720-7-hch@lst.de/>`_.
    This value will be passed unchanged to ``->iomap_end``.
 
- * ``folio_ops`` will be covered in the section on pagecache operations.
-
  * ``validity_cookie`` is a magic freshness value set by the filesystem
    that should be used to detect stale mappings.
    For pagecache operations this is critical for correct operation
diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index ead56b27ec3f..1f5732835567 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -57,16 +57,12 @@ The following address space operations can be wrapped easily:
  * ``bmap``
  * ``swap_activate``
 
-``struct iomap_folio_ops``
+``struct iomap_write_ops``
 --------------------------
 
-The ``->iomap_begin`` function for pagecache operations may set the
-``struct iomap::folio_ops`` field to an ops structure to override
-default behaviors of iomap:
-
 .. code-block:: c
 
- struct iomap_folio_ops {
+ struct iomap_write_ops {
      struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
                                 unsigned len);
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
diff --git a/block/fops.c b/block/fops.c
index cf79cbcf80f0..9e77be5ccb5f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -723,7 +723,8 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL);
+	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
+			NULL);
 }
 
 /*
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 3cd46a09e820..a7832636da34 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -963,12 +963,16 @@ static struct folio *
 gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
 {
 	struct inode *inode = iter->inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	unsigned int blockmask = i_blocksize(inode) - 1;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	unsigned int blocks;
 	struct folio *folio;
 	int status;
 
+	if (!gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
+		return iomap_get_folio(iter, pos, len);
+
 	blocks = ((pos & blockmask) + len + blockmask) >> inode->i_blkbits;
 	status = gfs2_trans_begin(sdp, RES_DINODE + blocks, 0);
 	if (status)
@@ -987,7 +991,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	if (!gfs2_is_stuffed(ip))
+	if (gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
 		gfs2_trans_add_databufs(ip->i_gl, folio,
 					offset_in_folio(folio, pos),
 					copied);
@@ -995,13 +999,14 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (tr->tr_num_buf_new)
-		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-
-	gfs2_trans_end(sdp);
+	if (gfs2_is_jdata(ip) || gfs2_is_stuffed(ip)) {
+		if (tr->tr_num_buf_new)
+			__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		gfs2_trans_end(sdp);
+	}
 }
 
-static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
+const struct iomap_write_ops gfs2_iomap_write_ops = {
 	.get_folio = gfs2_iomap_get_folio,
 	.put_folio = gfs2_iomap_put_folio,
 };
@@ -1078,8 +1083,6 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 		gfs2_trans_end(sdp);
 	}
 
-	if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
-		iomap->folio_ops = &gfs2_iomap_folio_ops;
 	return 0;
 
 out_trans_end:
@@ -1304,7 +1307,7 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from, loff_t length
 		return 0;
 	length = min(length, inode->i_size - from);
 	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
-			NULL);
+			&gfs2_iomap_write_ops, NULL);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
diff --git a/fs/gfs2/bmap.h b/fs/gfs2/bmap.h
index 4e8b1e8ebdf3..6cdc72dd55a3 100644
--- a/fs/gfs2/bmap.h
+++ b/fs/gfs2/bmap.h
@@ -44,6 +44,7 @@ static inline void gfs2_write_calc_reserv(const struct gfs2_inode *ip,
 }
 
 extern const struct iomap_ops gfs2_iomap_ops;
+extern const struct iomap_write_ops gfs2_iomap_write_ops;
 extern const struct iomap_writeback_ops gfs2_writeback_ops;
 
 int gfs2_unstuff_dinode(struct gfs2_inode *ip);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fd1147aa3891..2908f5bee21d 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1058,7 +1058,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	pagefault_disable();
-	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops, NULL);
+	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops,
+			&gfs2_iomap_write_ops, NULL);
 	pagefault_enable();
 	if (ret > 0)
 		written += ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7fa885b1a0c..f6e410c9ea7b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -742,28 +742,27 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 	return 0;
 }
 
-static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
+static struct folio *__iomap_get_folio(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	loff_t pos = iter->pos;
 
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (folio_ops && folio_ops->get_folio)
-		return folio_ops->get_folio(iter, pos, len);
-	else
-		return iomap_get_folio(iter, pos, len);
+	if (write_ops && write_ops->get_folio)
+		return write_ops->get_folio(iter, pos, len);
+	return iomap_get_folio(iter, pos, len);
 }
 
-static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
+static void __iomap_put_folio(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t ret,
 		struct folio *folio)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	loff_t pos = iter->pos;
 
-	if (folio_ops && folio_ops->put_folio) {
-		folio_ops->put_folio(iter->inode, pos, ret, folio);
+	if (write_ops && write_ops->put_folio) {
+		write_ops->put_folio(iter->inode, pos, ret, folio);
 	} else {
 		folio_unlock(folio);
 		folio_put(folio);
@@ -800,10 +799,10 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
  * offset, and length. Callers can optionally pass a max length *plen,
  * otherwise init to zero.
  */
-static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
+static int iomap_write_begin(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, struct folio **foliop,
 		size_t *poffset, u64 *plen)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
@@ -818,7 +817,7 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	folio = __iomap_get_folio(iter, len);
+	folio = __iomap_get_folio(iter, write_ops, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
@@ -832,8 +831,8 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	 * could do the wrong thing here (zero a page range incorrectly or fail
 	 * to zero) and corrupt data.
 	 */
-	if (folio_ops && folio_ops->iomap_valid) {
-		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
+	if (write_ops && write_ops->iomap_valid) {
+		bool iomap_valid = write_ops->iomap_valid(iter->inode,
 							 &iter->iomap);
 		if (!iomap_valid) {
 			iter->iomap.flags |= IOMAP_F_STALE;
@@ -859,8 +858,7 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	return 0;
 
 out_unlock:
-	__iomap_put_folio(iter, 0, folio);
-
+	__iomap_put_folio(iter, write_ops, 0, folio);
 	return status;
 }
 
@@ -932,7 +930,8 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
-static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
+static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+		const struct iomap_write_ops *write_ops)
 {
 	ssize_t total_written = 0;
 	int status = 0;
@@ -976,7 +975,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			break;
 		}
 
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, iter->pos, bytes);
 			break;
@@ -1005,7 +1005,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
-		__iomap_put_folio(iter, written, folio);
+		__iomap_put_folio(iter, write_ops, written, folio);
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
@@ -1038,7 +1038,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= iocb->ki_filp->f_mapping->host,
@@ -1055,7 +1056,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 		iter.flags |= IOMAP_DONTCACHE;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_write_iter(&iter, i);
+		iter.status = iomap_write_iter(&iter, i, write_ops);
 
 	if (unlikely(iter.pos == iocb->ki_pos))
 		return ret;
@@ -1289,7 +1290,8 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 }
 EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 
-static int iomap_unshare_iter(struct iomap_iter *iter)
+static int iomap_unshare_iter(struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops)
 {
 	struct iomap *iomap = &iter->iomap;
 	u64 bytes = iomap_length(iter);
@@ -1304,14 +1306,15 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (unlikely(status))
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, bytes, folio);
+		__iomap_put_folio(iter, write_ops, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1329,7 +1332,8 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 
 int
 iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
@@ -1344,7 +1348,7 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 
 	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_unshare_iter(&iter);
+		iter.status = iomap_unshare_iter(&iter, write_ops);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
@@ -1363,7 +1367,8 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 	return filemap_write_and_wait_range(mapping, i->pos, end);
 }
 
-static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
+		const struct iomap_write_ops *write_ops)
 {
 	u64 bytes = iomap_length(iter);
 	int status;
@@ -1374,7 +1379,8 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
-		status = iomap_write_begin(iter, &folio, &offset, &bytes);
+		status = iomap_write_begin(iter, write_ops, &folio, &offset,
+				&bytes);
 		if (status)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
@@ -1387,7 +1393,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, bytes, folio);
+		__iomap_put_folio(iter, write_ops, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1403,7 +1409,8 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
@@ -1433,7 +1440,8 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
-			iter.status = iomap_zero_iter(&iter, did_zero);
+			iter.status = iomap_zero_iter(&iter, did_zero,
+					write_ops);
 
 		iter.len = len - (iter.pos - pos);
 		if (ret || !iter.len)
@@ -1464,7 +1472,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 			continue;
 		}
 
-		iter.status = iomap_zero_iter(&iter, did_zero);
+		iter.status = iomap_zero_iter(&iter, did_zero, write_ops);
 	}
 	return ret;
 }
@@ -1472,7 +1480,8 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops, void *private)
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
@@ -1481,7 +1490,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	if (!off)
 		return 0;
 	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
-			private);
+			write_ops, private);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 48254a72071b..6e0970f24df5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -979,7 +979,8 @@ xfs_file_buffered_write(
 
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, NULL);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			NULL);
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
@@ -1059,7 +1060,8 @@ xfs_file_buffered_write_zoned(
 retry:
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, &ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			&ac);
 	if (ret == -ENOSPC && !cleared_space) {
 		/*
 		 * Kick off writeback to convert delalloc space and release the
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ff05e6b1b0bb..2e94a9435002 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -79,6 +79,9 @@ xfs_iomap_valid(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 
+	if (iomap->type == IOMAP_HOLE)
+		return true;
+
 	if (iomap->validity_cookie !=
 			xfs_iomap_inode_sequence(ip, iomap->flags)) {
 		trace_xfs_iomap_invalid(ip, iomap);
@@ -89,7 +92,7 @@ xfs_iomap_valid(
 	return true;
 }
 
-static const struct iomap_folio_ops xfs_iomap_folio_ops = {
+const struct iomap_write_ops xfs_iomap_write_ops = {
 	.iomap_valid		= xfs_iomap_valid,
 };
 
@@ -151,7 +154,6 @@ xfs_bmbt_to_iomap(
 		iomap->flags |= IOMAP_F_DIRTY;
 
 	iomap->validity_cookie = sequence_cookie;
-	iomap->folio_ops = &xfs_iomap_folio_ops;
 	return 0;
 }
 
@@ -2198,7 +2200,8 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops, ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			ac);
 }
 
 int
@@ -2214,5 +2217,6 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops, ac);
+			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
+			ac);
 }
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 674f8ac1b9bd..ebcce7d49446 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -57,5 +57,6 @@ extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
 extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
+extern const struct iomap_write_ops xfs_iomap_write_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index ad3bcb76d805..3f177b4ec131 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1881,7 +1881,8 @@ xfs_reflink_unshare(
 				&xfs_dax_write_iomap_ops);
 	else
 		error = iomap_file_unshare(inode, offset, len,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops,
+				&xfs_iomap_write_ops);
 	if (error)
 		goto out;
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 0c64185325d3..6fd3b23858db 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -572,7 +572,8 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 	if (ret <= 0)
 		goto inode_unlock;
 
-	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops, NULL);
+	ret = iomap_file_buffered_write(iocb, from, &zonefs_write_iomap_ops,
+			NULL, NULL);
 	if (ret == -EIO)
 		zonefs_io_error(inode, true);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7e06b3a392f8..8d20a926b645 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -101,8 +101,6 @@ struct vm_fault;
  */
 #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
 
-struct iomap_folio_ops;
-
 struct iomap {
 	u64			addr; /* disk offset of mapping, bytes */
 	loff_t			offset;	/* file offset of mapping, bytes */
@@ -113,7 +111,6 @@ struct iomap {
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
-	const struct iomap_folio_ops *folio_ops;
 	u64			validity_cookie; /* used with .iomap_valid() */
 };
 
@@ -143,16 +140,11 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
 }
 
 /*
- * When a filesystem sets folio_ops in an iomap mapping it returns, get_folio
- * and put_folio will be called for each folio written to.  This only applies
- * to buffered writes as unbuffered writes will not typically have folios
- * associated with them.
- *
  * When get_folio succeeds, put_folio will always be called to do any
  * cleanup work necessary.  put_folio is responsible for unlocking and putting
  * @folio.
  */
-struct iomap_folio_ops {
+struct iomap_write_ops {
 	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
 			unsigned len);
 	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
@@ -335,7 +327,8 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 }
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
-		const struct iomap_ops *ops, void *private);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
@@ -344,11 +337,14 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-		bool *did_zero, const struct iomap_ops *ops, void *private);
+		bool *did_zero, const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops, void *private);
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 		void *private);
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
-- 
2.47.1

