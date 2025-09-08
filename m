Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE2320CC8
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357560; cv=none; b=mjLvbeAHCY/8R7tetOP5HNdJwaqwJCHtvrKfLZ/Cs/F9GTWeBsIbHEDz+SwHylXSnWzcMcPT6sqWc+dWSxJC80wq2CpurBiGY0tNI/ezTFLOaKyzmW/EXhGW50r3XJpAS28uT1Xb3wl6PZihMTtbWVakZmUd1WSwI16tlngk8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357560; c=relaxed/simple;
	bh=tepfHzH5hZwS5wTpe51uts0VZgTsorR+gn3Z+N6t91w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQWYvIgw78cJ7LNNJz+j3pu+IyAkG6E1wf5ydT9UlLJ+IDw6zvcdVo4W0cg1uW0vHchV02UxHh/cDj9lmTZaHYom5qBAPVIWFm3+bmZXJNX0qZoqJ61oFQm9NkCMfBcAEi1ZbxU2NHm2Yt0PPvloTV6QSHibaIvjwuoFtsdMmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6PANuPU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6PANuPU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3748239b3a.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357558; x=1757962358; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Eb8aM+Y/JVeKEnqwZVjBjPkl+JL1qOEt3ClFoOdOx0=;
        b=C6PANuPUtbSUQBXTZWvCcgl3r4/s6q3JAHTEX8wdVxfsvF9vIbbL1ZMIWohD8EmilF
         W6h+6byPHpyypC8dL0IXutFECW9ZNpsoOeEFJDKoH/t4aJotvaJQ1frafYUo1KjySQxU
         1KwHR6bLwRd5SkZhm/LikHWeVkGftYPpabUcj3o8qTcnf+5vDsc7cMDOVTwPmWn2yWZi
         eB/vnhFBKxYuF2i/IWfzXrVewbgXmLRBCNfDAgmmJrrQPMjvSY1ZyU13qmLZ4XoGNaOo
         BRqNky3qjWa8+wKP+sz4Kye3wdxyvfjS0Gx7YGtad70Oc0yDlV63Du2MRwHFMjRJwukQ
         cCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357558; x=1757962358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Eb8aM+Y/JVeKEnqwZVjBjPkl+JL1qOEt3ClFoOdOx0=;
        b=n/EwYdG7NvRZdhBdh0/xlJJ6vimiGHqgvsfUqhC6NKfSN3+Ahqc+KeXnaLGmIq948/
         0sKZ0kNu+V/QV3Q5MxrMY8TiDM9kFs1f5rxLC0+/8IZlBh0mmXrOSzoKWvt2mUXOHzx5
         oJnMW/50ESaOK347PtYcWNk3r2aBi9rYorBorNda8X026HL164PxLwRIKSwXhqu+W+s+
         WIuzKrwCOAzXTmh/Sk6wyk4uXmAqWbI1PiMasje5IVtjORdO5tQ2t0k3NjhKZEOoNuby
         1koBZ1A/SGpQQHWESNi64CDzY81L05XedySfCg+Ic8kPBk/eIg5zxvOXI2YU56VYFeqH
         sbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnCwO2t63mnnvhh9i7swbbgrJg2fOonSOgxwU0W7B7vh8Lzi8OIMtms/o2FjVilWk7vj66@lists.linux.dev
X-Gm-Message-State: AOJu0YwmV1CNUTtbHGGPvxOWibcVpOukPZmm29+qZ7KiMqLqRx5O6c0g
	E4iavQm6ZoPuq8IILRgGYhltlNSyim6cOSQT15h/IljOi4Bzer4nP+K3
X-Gm-Gg: ASbGncu2eF69xgMkg3ioJzc76haE2VpM+sIq6d/oRaGoAzNYhxJrtfiZT0SvjH42uAn
	4nAGs2rmnesQvT8n0B7ImO/dMFnm+osJa8lgTwNfbQez9gLjsRFfvVr3fMmJGURbIMEqhWlZwRa
	YdpWb4Icv8Guc0VqJxfl+UMK6L/7uEckoMsRwXul4RX+mPL9lxm1hmOAlJNAx2JUVmVEfXrEXM6
	xDPFyog2A2lqeZwbUOyJ9mPcVk+sAA9xtvntqBqOySQGgYMddgZgX5vumc8O2N9jcJ2wTm21vfd
	U4Rvi2T+S7NzMTfpEVF4DxWecA9qqLpZvnED32d6KqwijO2Iud+8kEYryd6+kH6gX1Scyc9uMd2
	96X9fxNxbQcSyflBpbQ==
X-Google-Smtp-Source: AGHT+IFdkSkXuivdmkkLCkNDzHHH2j2oNa8Rw15o+okITyX+2rUE6eDXA/1am5MRLtz/aJ7axJnRAA==
X-Received: by 2002:a17:902:cf01:b0:24c:cb6b:105b with SMTP id d9443c01a7336-2516e4ae7e2mr117896905ad.25.1757357558378;
        Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm293986985ad.109.2025.09.08.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:38 -0700 (PDT)
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
Subject: [PATCH v2 14/16] fuse: use iomap for read_folio
Date: Mon,  8 Sep 2025 11:51:20 -0700
Message-ID: <20250908185122.3199171-15-joannelkoong@gmail.com>
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

Read folio data into the page cache using iomap. This gives us granular
uptodate tracking for large folios, which optimizes how much data needs
to be read in. If some portions of the folio are already uptodate (eg
through a prior write), we only need to read in the non-uptodate
portions.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 79 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..5b75a461f8e1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,22 +828,69 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
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
+					     loff_t pos, size_t len)
+{
+	struct fuse_fill_read_data *data = ctx->private;
+	struct folio *folio = ctx->cur_folio;
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
+		.private = &data,
 
-	err = -EIO;
-	if (fuse_is_bad(inode))
-		goto out;
+	};
+	int err;
 
-	err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
-	if (!err)
-		folio_mark_uptodate(folio);
+	if (fuse_is_bad(inode)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
 
+	err = iomap_read_folio(&fuse_iomap_ops, &ctx);
 	fuse_invalidate_atime(inode);
- out:
-	folio_unlock(folio);
 	return err;
 }
 
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

