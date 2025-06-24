Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B5214801
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731797; cv=none; b=uS0mF0W9nPdX9n1MCUHWnZ0iQq1mDM0oTjtSQ/q/k2psngYaopNTOQ8O6Mx+ScKbWmpAliSJDZWgr2CUEQEcHx3nguWCCMBRlLoKd+amOAMzLxF0EwFq+qewzJcQATcsu5eAzmQ1f9QKtnGQvWiSnIUuTVqJCOR0+HHH5jBURf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731797; c=relaxed/simple;
	bh=KaEENeORTXrmqWYQ5hHfMcbKfIeeGt8BFnL2C3XtLCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mta75ZO4ezLpdbGKy9f/MyoQ67GSJjZsH5naRoe1V2c1Pazn3p2vmTwQwjkLZdYNT/UUf9r6lHF7TxhUcXJYDWxNbSQ0QizBpJKOHAeeYRE/mwSdHtu1KU8ftbNkKVrtwT3VX/z5znerJpsQOTL9xuBzI4fmnhBItQcQEIVOJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3D3Ir/G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3D3Ir/G"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23694cec0feso45202815ad.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731795; x=1751336595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6456fru7r0FoKBUVBKuyPigmRLRE2hEngcyD/5OrYsQ=;
        b=g3D3Ir/GizSQ1bBzOehpARG5hhe3ZBFcMp4Yj5IcsHaNTFD16ohqKEpCpg4rtvTe2C
         k9oaI9KJeBxiu8gRxX3a71KO+UdgzMWMmolcCsbht4TxofllCYUiBHr/1wGXr6jxKLS/
         vqOiNO61qwfWR+HqN47nV1tnSNddnyHE31a0MMQh31Bpd1UfT9t2RSiQMjB3ouoeMjKO
         e9C3eNDDp14w5paONngBeSuaikqRyLze/yAY8G9loZ4F/zGPpxTvzzMBBxfqGtmdFW7M
         1Z5TEMTUpq4fa0chFdlVJszrno22nH0V1ccc1QYrVoX625bfot8QVs5IRe1hQuiJm+qu
         xIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731795; x=1751336595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6456fru7r0FoKBUVBKuyPigmRLRE2hEngcyD/5OrYsQ=;
        b=iTIgvhGrSg0MvrTwgKyvF/lQj0QYW+xxTEkMBnlpo3/pxAHoMO5SPBrblYk/LqzLrm
         xJcSgc+oLayiNsCJAV1i3O+IKsBjjKUhJ7Z9u+RJIaRS0//oQB4XzFHjXePqNt5tc3XA
         3HuYuVaTl90N9wF86FVGvByLjf1J7nfWQ1UqwW2PuCL20En7t1+Q0DLCynGY3mMognHN
         XHlCIw2EIoBuOuJir2ZYjHvcdlmNcHpEVl8TMbh/MQfOkC4O+AxyTjYQyI3WF9ISZx5H
         M7uPEHc+2i1CsazpAn2iMXEaqkLmfv1MbEGuntjBSKqDpYbWykrBkfBiG1j65kDa8m/C
         mUGw==
X-Forwarded-Encrypted: i=1; AJvYcCV8UNRel657i3MOlesCIYUNTukfevJ3mDRES4mZYPCqLK9oRuEkV3S32A5QuxVze4jx4TLL@lists.linux.dev
X-Gm-Message-State: AOJu0YwK1ev8eYrIjZxRq5ynYtAjhYsozNI+RcmsBIOO3FjOQY3cHY+k
	9FQg+MyDLeLdiZCjzJkyXCJeqYlxKGaWJZYN4vC9p+3iWvsp0L8i3tYT
X-Gm-Gg: ASbGnctLBNbnzlKCT5egLp2SUN2FzWxTSrrrL/IJRkqSx/juOhrcSYIrZygC1bJWbkm
	X0R+scTcumoSpu+Kz4XSMSYFVDMXSOrkOTa5/WMLtwyMWN5BbYI6PBFlngrObN/q5aV2FPlOBLl
	Jjq2fYz+CQK+shEh5zWoc8o/6Z87h4NyUf//NMMQe4ACp3MCXvLjdSqsMLXnj15cs32E/c0sNOg
	lbgnVn6kNkW/rh27QOq5hn32jD//VEF1H5IcPfUdYn582PNvTAtRev8n7wLzcfSJVrF2JAWH/4+
	aEhPJmluu7IjMJcJRC5v+6pH5liBk9B/amN7waJml2mnBZBRe/d0b7zv
X-Google-Smtp-Source: AGHT+IH67Nl3TV2noemevffK/ACyU1//Pzac31xVqANulkrhjShG4g3C/l1VLon8FrFXmYD1bzmTgQ==
X-Received: by 2002:a17:902:e889:b0:235:f4f7:a62b with SMTP id d9443c01a7336-237d9901b08mr220089015ad.41.1750731794904;
        Mon, 23 Jun 2025 19:23:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237f7579cddsm38419105ad.202.2025.06.23.19.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:14 -0700 (PDT)
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
Subject: [PATCH v3 12/16] fuse: use iomap for buffered writes
Date: Mon, 23 Jun 2025 19:21:31 -0700
Message-ID: <20250624022135.832899-13-joannelkoong@gmail.com>
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

Have buffered writes go through iomap. This has two advantages:
* granular large folio synchronous reads
* granular large folio dirty tracking

If for example there is a 1 MB large folio and a write issued at pos 1
to pos 1 MB - 2, only the head and tail pages will need to be read in
and marked uptodate instead of the entire folio needing to be read in.
Non-relevant trailing pages are also skipped (eg if for a 1 MB large
folio a write is issued at pos 1 to 4099, only the first two pages are
read in and the ones after that are skipped).

iomap also has granular dirty tracking. This is useful in that when it
comes to writeback time, only the dirty portions of the large folio will
be written instead of having to write out the entire folio. For example
if there is a 1 MB large folio and only 2 bytes in it are dirty, only
the page for those dirty bytes get written out. Please note that
granular writeback is only done once fuse also uses iomap in writeback
(separate commit).

.release_folio needs to be set to iomap_release_folio so that any
allocated iomap ifs structs get freed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/Kconfig |   1 +
 fs/fuse/file.c  | 140 ++++++++++++++++++------------------------------
 2 files changed, 53 insertions(+), 88 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e..a774166264de 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -2,6 +2,7 @@
 config FUSE_FS
 	tristate "FUSE (Filesystem in Userspace) support"
 	select FS_POSIX_ACL
+	select FS_IOMAP
 	help
 	  With FUSE it is possible to implement a fully functional filesystem
 	  in a userspace program.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f102afc03359..a7f11c1a4f89 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -21,6 +21,7 @@
 #include <linux/filelock.h>
 #include <linux/splice.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/iomap.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -788,12 +789,16 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	}
 }
 
-static int fuse_do_readfolio(struct file *file, struct folio *folio)
+static int fuse_do_readfolio(struct file *file, struct folio *folio,
+			     size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
-	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = folio_size(folio) };
+	loff_t pos = folio_pos(folio) + off;
+	struct fuse_folio_desc desc = {
+		.offset = off,
+		.length = len,
+	};
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
@@ -820,8 +825,6 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	if (res < desc.length)
 		fuse_short_read(inode, attr_ver, res, &ia.ap);
 
-	folio_mark_uptodate(folio);
-
 	return 0;
 }
 
@@ -834,13 +837,26 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
 	if (fuse_is_bad(inode))
 		goto out;
 
-	err = fuse_do_readfolio(file, folio);
+	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
+	if (!err)
+		folio_mark_uptodate(folio);
+
 	fuse_invalidate_atime(inode);
  out:
 	folio_unlock(folio);
 	return err;
 }
 
+static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
+				       struct folio *folio, loff_t pos,
+				       size_t len)
+{
+	struct file *file = iter->private;
+	size_t off = offset_in_folio(folio, pos);
+
+	return fuse_do_readfolio(file, folio, off, len);
+}
+
 static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 			       int err)
 {
@@ -1375,6 +1391,24 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 	}
 }
 
+static const struct iomap_write_ops fuse_iomap_write_ops = {
+	.read_folio_range = fuse_iomap_read_folio_range,
+};
+
+static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+			    unsigned int flags, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->length = length;
+	iomap->offset = offset;
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin	= fuse_iomap_begin,
+};
+
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = mapping->host;
 	ssize_t err, count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	bool writeback = false;
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 						file_inode(file))) {
 			goto writethrough;
 		}
-
-		return generic_file_write_iter(iocb, from);
+		writeback = true;
 	}
 
 writethrough:
@@ -1420,6 +1454,15 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
+	} else if (writeback) {
+		/*
+		 * Use iomap so that we can do granular uptodate reads
+		 * and granular dirty tracking for large folios.
+		 */
+		written = iomap_file_buffered_write(iocb, from,
+						    &fuse_iomap_ops,
+						    &fuse_iomap_write_ops,
+						    file);
 	} else {
 		written = fuse_perform_write(iocb, from);
 	}
@@ -2209,84 +2252,6 @@ static int fuse_writepages(struct address_space *mapping,
 	return err;
 }
 
-/*
- * It's worthy to make sure that space is reserved on disk for the write,
- * but how to implement it without killing performance need more thinking.
- */
-static int fuse_write_begin(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, struct folio **foliop, void **fsdata)
-{
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
-	struct folio *folio;
-	loff_t fsize;
-	int err = -ENOMEM;
-
-	WARN_ON(!fc->writeback_cache);
-
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
-	if (IS_ERR(folio))
-		goto error;
-
-	if (folio_test_uptodate(folio) || len >= folio_size(folio))
-		goto success;
-	/*
-	 * Check if the start of this folio comes after the end of file,
-	 * in which case the readpage can be optimized away.
-	 */
-	fsize = i_size_read(mapping->host);
-	if (fsize <= folio_pos(folio)) {
-		size_t off = offset_in_folio(folio, pos);
-		if (off)
-			folio_zero_segment(folio, 0, off);
-		goto success;
-	}
-	err = fuse_do_readfolio(file, folio);
-	if (err)
-		goto cleanup;
-success:
-	*foliop = folio;
-	return 0;
-
-cleanup:
-	folio_unlock(folio);
-	folio_put(folio);
-error:
-	return err;
-}
-
-static int fuse_write_end(struct file *file, struct address_space *mapping,
-		loff_t pos, unsigned len, unsigned copied,
-		struct folio *folio, void *fsdata)
-{
-	struct inode *inode = folio->mapping->host;
-
-	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
-	if (!copied)
-		goto unlock;
-
-	pos += copied;
-	if (!folio_test_uptodate(folio)) {
-		/* Zero any unwritten bytes at the end of the page */
-		size_t endoff = pos & ~PAGE_MASK;
-		if (endoff)
-			folio_zero_segment(folio, endoff, PAGE_SIZE);
-		folio_mark_uptodate(folio);
-	}
-
-	if (pos > inode->i_size)
-		i_size_write(inode, pos);
-
-	folio_mark_dirty(folio);
-
-unlock:
-	folio_unlock(folio);
-	folio_put(folio);
-
-	return copied;
-}
-
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
@@ -3145,11 +3110,10 @@ static const struct address_space_operations fuse_file_aops  = {
 	.writepages	= fuse_writepages,
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= filemap_dirty_folio,
+	.release_folio	= iomap_release_folio,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-	.write_begin	= fuse_write_begin,
-	.write_end	= fuse_write_end,
 };
 
 void fuse_init_file_inode(struct inode *inode, unsigned int flags)
-- 
2.47.1

