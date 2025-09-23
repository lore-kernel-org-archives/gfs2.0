Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687321FF30
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587652; cv=none; b=GJAIH6OX0SaV4Wm5e86c/wmeX0Z0fa2KbJ1u3faqw9HwTWynhOTBRNR1/YKl2TwkLV3o5fgCcANWO+Zb2Dy3uoYOcs94INxKQ1qAYF5Fx8kQFVAxGRgUwE7YAfxbzO/BFzgzZACC++Oh8B7uyE8GYjNJJAuI7pG0v9BnlCd6qT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587652; c=relaxed/simple;
	bh=LyOsg2Bu1m9/Q4KGCsDW7iDLciMuCVOGZhuLWbBDsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkfvMpzsJEE2sc9dI+zyjd8tSSR9sFiD5EMvgd4v7qEzVBCTDjEj6gTPkwR67f39abCO2PJlBE55v8sLQMDsslt/+d7gOyoOeyJcfc9K0Sg5x3jk1GcpUDYu2kDalnlaNi51qjrka6jakhCRGmsQTnvuyDMwsaGebsQAgMs1aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+KwWxW4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+KwWxW4"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77dedf198d4so5391650b3a.0
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587650; x=1759192450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=Y+KwWxW4SaoTRNteBg2Hq2kiAtj6iVHcqxGZtsANUJgE+PsxZ2CGjtQjNQCawjRlf+
         u2UblKVaDBnfYmziuCIwRwppYyhhI2r+99WfGLx3pVrEDbe2ZvdYFVYkk9zllh0HJ0pm
         wyYtC2Zz1DYZPGzejRhos950SGAkMODP61goM3FnFtaa5WlRZ/w5Iz9kG4aA+zwA+skg
         YJrJBAQaaWc12mdpihORsJHJl89WdQqTM6mHY2iynzT1Dd7esU4YUjxUPTaQ/JQbgIEQ
         VAJUDkExRkWrRGRgwyHZK+YUtOY6VIf62Y4VBLPWxKIcptZY+/8SbeTNMQRlm3MlxvQi
         5nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587650; x=1759192450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGUNyWs1OxmiVEgLdMH+/qyYZ15HscPzayJVEDJfjsE=;
        b=JJJhdwJmOZ9DpzLaaKY2TgAYmVYfrvH2nba0Hv629xRDtNcbGpxqf9wggz7zbLGUw5
         Dp/t4x0ZIjQOY+lfaml0ApV3i9mMMB1ilep5F2XBMs2KAmoC7SjaScsl+m+MUv79AeF4
         e8vczQNH2H+jt0uMa4yQ2COnAOrTQ4Ij+UhBkDUkDyuT1cm2HjEzop+AfclTIyB0tMXM
         qfaGYm1fiLntQPffl6tMaDMEV3hkXNpoHQRio/RVq3nzQEGPo/A5QucEWD5u08qfZSgF
         EWLvnwvnxdGQtFG7v1Kt26+V3D+IdvtLwR0rkqB6Q4h5BfvKpkQRwjuiyGi43a4y4qQw
         LeMw==
X-Forwarded-Encrypted: i=1; AJvYcCVQtNozMiMhP93MppX+EsBv8ox7CPlkVpvaIw+yMOHp2csG2vLDm+0QllUZEP4f0Vc/iXyO@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+fE5RHGd6O1v25/sfBCzmqS9nYWx+vEY0S83DslVauOr/Znr0
	PWGn17MtfUNpGnnOk8ejaQcpIJCIGo7/Vsa5eQOUkrxtJzC36GVhwFGQ
X-Gm-Gg: ASbGnct0uwMaZRt8X086ylJOiBpk12j0X/NVpXe9QO/wSuwu61muX8407M/3em82CY0
	5fWBuBgK8dVmjQdRiNv0Q+V9VL6Blgnuqued+MBLaFsIuBMsyj8ZWBwqnbea0LGawvsHKkUdKmR
	g/MLzQN/32+udTo4DfspzluXnedIWEfSEHjS5ggMd8Fu+GkrDnbsBhzh3/xKWyHcRa9i14zdVFd
	lF9n9GmR+FXi68sY0v5XkY2FZAM1G/8BUetN/yxg45rjgwZRXS2fzJFQNw1pp9zCwJTVYeqzn2Q
	ILSx/zDJ2Y8MyczkFIZ+dV8/E8xz2raVcj6lS77dI6647uFTQ0dpcLi8i4Xkby0eVH4G48ZgwoV
	mEHqjbvRTr0FAignkv//Yn1PsBDRJ3ZR2GD0m0v57/qJHLaph
X-Google-Smtp-Source: AGHT+IFDRYIdyBl04iBYoDUtSI9mRjhTN7zVi/dDiSEIGK216VfDG1RkUSAPcnJWtf4ohk7umhb2Jg==
X-Received: by 2002:a05:6a00:a93:b0:77f:4306:d248 with SMTP id d2e1a72fcca58-77f53ab8044mr872603b3a.22.1758587650623;
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0ef2db80sm9374730b3a.24.2025.09.22.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 13/15] fuse: use iomap for read_folio
Date: Mon, 22 Sep 2025 17:23:51 -0700
Message-ID: <20250923002353.2961514-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
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

