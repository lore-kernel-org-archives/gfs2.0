Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4B2F3C11
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066649; cv=none; b=XuyJDwsdr5a2CsBOPful8OYmRfFkPIJ1B/mjX8TPrlXN1OpljACB7cQIHfY2WF8ICdxkrvKZWBFxkXuZHmnO4F42UauOOcx3NDbp3gyyy2E4kOxe7E6fHqB2mjhnBNZKyWyhCC761Cd2gQxkHwVub6tcW685XIIpPk+a87IDWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066649; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYwoIQUNfC4oooItoNXONGursZEZxX+/VURKHI/V2F7MMIvjhDH6YECVfvg939v+leTfu3+T0tZFZI1lYlttWBp/pNWlCQyZaLPwp1gY49xlQK2OK8QJni7XwztgghjnwBQyynbJS+RpGzd8X6BdJ2dvItfI4VUEivHZmfp3Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9E79+qm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9E79+qm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-266a0e83662so20233805ad.0
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066647; x=1758671447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=c9E79+qm+xmq0VWeZVINiz2CgAMVsG3yoyXzjlDZTGWTkY+60W+/gC7QY+TyL3ARGx
         /IRRMz+9FO/BfGfLxPdJqAz8n90YIpMrlsOoOQKzm782KhbztJ+mNyRkwcplOkFqlhHb
         TZo805oENL7QgoRJYa0xRbPop6rPNpyVIgjskl05Ht7nrjy2ek40eL6758Wi+JnJUEL6
         PypD2qtSLN1ct8DXWLmZFUyGhL/O2fTRtzxpr+qW5EFVwYETipX4M7SOQCMe9NqBD/yO
         cap6C6ao1LcteVaeVLwXXj9cirJgdGJGSNd7j1MQoHgB3iNWgGXUZVoPjP30K5q/kc2G
         28mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066647; x=1758671447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=cZOi/AyKwMqcDIpFijxGZk/EXNHDEj+/R3WH7nBwyWGC7fGIfGgVd+peeJUTZXmAU5
         zR6LqHNj72/uljmivOB4aOZJ/QXAIplThZAGyw4VUwVP7tJjM0bqP+ICTkF00cMxIciV
         /bqIJRMvbpfIvcoLk9W81qIMHr+V9Q+eEwfBPQlDH8SX+WEysqEoql+ogEs9Zn0ncOVp
         A1m6uT3hNWvvsaCWsZ9kuMXBnImAtXakE0qNBhnGQbhelepIlScwFT6xuDoJ3+eZW1N1
         QPFql2Tw/fyKPmfT+w7r5SDyVMwKGlboU3Hh+WWobYQIArw6nvIjxAg2LUnWLkfZj9Yl
         WWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJg+gURL9Hkl0f1MxiEv0c2OQ6aIxzK6PB57PwV2HCHk8TDAFt8LI+8p5hGxwKUC/0BT4y@lists.linux.dev
X-Gm-Message-State: AOJu0YxOiAKMAzQQNppdvmUXAgifOrrgmFRTQQ2JZaXKTUr8+mnWf7xT
	R2NqPPAtz9D8lfeFDCuZTLrwOpOn2u1PqKNfDtGkI7Kdzfb4OUtXIyGp
X-Gm-Gg: ASbGncv3BYiRnI4+rdEqK59F2+69OmMPtxqXtnEUYmIoO1HWYirVOO6B42KZrpH5+pc
	n/DXKCuUS3RDtjaqs+angR2g8LM4gAoD+XdgkpGGgVSD1NToT7a/giPUh/iBCH8HytzRVWfy65K
	oX/lsVCeiK5Ef5QuIMDR37lOFgbAZbIICsQqAcWaJn7kgkXVuZWU5i4kZVkYsh7Usohs4q3MUBY
	WQ/o/yQv8nqcMjdH4XG+EkcLZv1n+vf57ipNFA1DGlj0H23kkVQfYU6omLcw96I7GS12mNy9reB
	hZ9OomHBcTDWW+OlL2JyphdqoyWZI3riMESmq3HKGL+6DuIKa5W5QOhrnepuVsthkx1Hl1OH2r/
	kmEw+3pIYHx7hQiMGE0fx/hmJtf9ySCGN4taL5vMKoPvK2H41zQ==
X-Google-Smtp-Source: AGHT+IEDsgdnT7+nNQrDhXR5m+p9OqwQpqgyiqsnD7pJqTnVO6zC/tJ8dk2Wmo0J+/77Bc7uR5fcOA==
X-Received: by 2002:a17:903:1a68:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-268121808e6mr1290225ad.23.1758066646820;
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267e52d1621sm22110075ad.40.2025.09.16.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:46 -0700 (PDT)
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
Subject: [PATCH v3 13/15] fuse: use iomap for read_folio
Date: Tue, 16 Sep 2025 16:44:23 -0700
Message-ID: <20250916234425.1274735-14-joannelkoong@gmail.com>
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

Read folio data into the page cache using iomap. This gives us granular
uptodate tracking for large folios, which optimizes how much data needs
to be read in. If some portions of the folio are already uptodate (eg
through a prior write), we only need to read in the non-uptodate
portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 81 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..4f27a3b0c20a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,23 +828,70 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
 	return 0;
 }
 
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
+struct fuse_fill_read_data {
+	struct file *file;
+};
+
+static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
+					     struct iomap_read_folio_ctx *ctx,
+					     size_t len)
+{
+	struct fuse_fill_read_data *data = ctx->read_ctx;
+	struct folio *folio = ctx->cur_folio;
+	loff_t pos =  iter->pos;
+	size_t off = offset_in_folio(folio, pos);
+	struct file *file = data->file;
+	int ret;
+
+	/*
+	 *  for non-readahead read requests, do reads synchronously since
+	 *  it's not guaranteed that the server can handle out-of-order reads
+	 */
+	iomap_start_folio_read(folio, len);
+	ret = fuse_do_readfolio(file, folio, off, len);
+	iomap_finish_folio_read(folio, off, len, ret);
+	return ret;
+}
+
+static const struct iomap_read_ops fuse_iomap_read_ops = {
+	.read_folio_range = fuse_iomap_read_folio_range_async,
+};
+
 static int fuse_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
-	int err;
+	struct fuse_fill_read_data data = {
+		.file = file,
+	};
+	struct iomap_read_folio_ctx ctx = {
+		.cur_folio = folio,
+		.ops = &fuse_iomap_read_ops,
+		.read_ctx = &data,
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
+	};
 
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	iomap_read_folio(&fuse_iomap_ops, &ctx);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
-	return err;
+	return 0;
 }
 
 static int fuse_iomap_read_folio_range(const struct iomap_iter *iter,
@@ -1394,20 +1441,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
 	.read_folio_range = fuse_iomap_read_folio_range,
 };
 
-static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			    unsigned int flags, struct iomap *iomap,
-			    struct iomap *srcmap)
-{
-	iomap->type = IOMAP_MAPPED;
-	iomap->length = length;
-	iomap->offset = offset;
-	return 0;
-}
-
-static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
-};
-
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.47.3

