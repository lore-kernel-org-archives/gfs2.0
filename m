Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC21C84A1
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846585; cv=none; b=orCRLN0j+1UZq8dtcejSfQZSs17BroZ/r+DDFtL17U9PUZAW7//FmeVH+pF89FMheWx8vyGBitxwggPBFPnsYzZDnRJb6wEG5h7AonK3cT1En/zohEglr5Jm/1KHpeqhhoC3fXnuerhFO41GhNha7kn+E4vwCKO1aIA+Zc3g848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846585; c=relaxed/simple;
	bh=K4U/CA7tbg/bUek9YcVC9Q6ozcjFrUj/3jdxNsXhIUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do350Zphn+PnwZ82kzEUN63hIAfldEMuXuK5DkhZNYcBsYGkNTf3WBZMzw98kGAOY0Gzgfrr/aoblr1WTOg0AAEaXJrDlBglhwDEq4e2Ea/bZq9Xvi3bTCtlb/PShKTYjkeyHczla02jLlp4dDb6mWwRjmkxlUZ6ppAqTpSnAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr2B6D/I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr2B6D/I"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-780292fcf62so1287466b3a.0
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846583; x=1759451383; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnw5A92oVT9gS4E1+yrEsisFkg+/g1YXgFVE1vK/hEw=;
        b=nr2B6D/IbLLVK6p18O12Y15FEXYqyyP3S3/mOLLq2NW8FY9TENrWyyf1tgGs6EtcTB
         gNWLqzyCOOIHazjhayYEde3hkSNsw0AfqInGDjVn+fy6kyzAu2R/hkbVpozfzGh6rtgu
         /ZjZcQwA/FUb2shsKmdnrDxyQU30eV/wYome1J96rEP0cFJo86oDsSMriq3+vHquLUa9
         DRs5qcz64TJlt1d/1z3FnAHwIVSVgHS0S8TM27lJ04/5U5V3AjzglLpD2OgvNcgr3/bZ
         tdtjNML4xsoQXOqUm+2801ZCp608xYLWhLzxO1aHtAaIDVEh2uIWIJV4gtvPMtkdRESR
         1ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846583; x=1759451383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnw5A92oVT9gS4E1+yrEsisFkg+/g1YXgFVE1vK/hEw=;
        b=SjUPuc41ELTSh3w+I+7Dr679g+eQ/kcHQssNior0pTuZ8wMryi+0IoxszHtWxXg1Tl
         6RtnxnVpxwgtwY+TiKik5yDCryJBEXFSK/eXO+KJpXzt84zqU03HSxzMOF8dytAyjmYv
         GpoSjGmh7TYpX8h9IAZQp9MpIxJGRSzxUa5WJMRrU9+AOkP/X9AkOR/D537S4HSZWsEN
         1K0X99e/x5m4MAcHA4A6Lh/c+M0EMKEusH87dUJ7VvRw9zwKbssTgWj385sbVS/NxSJG
         37iEPDJaTJ5XyKylyErZ8x/Le1C5gWshlvaRnyJr81itdsOm7AM+f5DdZOCNIlvmZg0r
         G8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVCmU9qNWaR4IbvKeDxVvKjzf3XHyOoMO3TCEkyY10sUirJoInEt/x2pcF7m4iVWvcs2+Kr@lists.linux.dev
X-Gm-Message-State: AOJu0YyK2UYSZpzXdNNkqKsBVAHzhOubW5m07Gu3uFlZC9aDGv1b0IKr
	9jjxN/wPuE9sgv87h/JUONb2ScLFV16Y9JnCMb0Qm5Dv7W40ewQjN7Hh
X-Gm-Gg: ASbGncsODXBTVcwXZ6QyZHGOBzu6COTm6FCmsY6dI+XLJtSmqzHk5toBsWdPP89axgD
	3vS2IcPPybxlqyxshNuXAEUdRQAilwvoAmHzGLbaLYnpr/3L6DQp0JvjI0JwYScc7W/3Uu1aZaZ
	EKoi6/XW8s9KGNfDmfHxY9+vwFH78ZOQDLTE6Iynemnz45f2X+eYwJCZ9AXaRYzHt1rsqTlGUzA
	Q6b+/S0BqXihGvb8arbfMthUei3vH0V5xdcpZuzvWmNjPfVMw7qrM87NvAPSIoIUypBbsLiy3Ll
	bkKDoCy77/zB7LFf9c28RmSWJSCgT2i2oQ1fVveg+xkrFAA3YP28ZkT8zwQvgYcs6iFmyNBxnkb
	Df2xxGIwcrL9By9ktbHLzD1l4M7BrX4pIfGCRBiHGpcuW9llw
X-Google-Smtp-Source: AGHT+IFgIIl1rPGc21eAT8naPz071UhBkST8ixc2RolNH6OJ4L9deyZJbJu4MjaCN5pTwkxEVsJ2zA==
X-Received: by 2002:a17:90b:1808:b0:32d:4187:7bc8 with SMTP id 98e67ed59e1d1-3342a2b11acmr5934143a91.27.1758846582994;
        Thu, 25 Sep 2025 17:29:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347472e49esm3605217a91.21.2025.09.25.17.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:42 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 12/14] fuse: use iomap for read_folio
Date: Thu, 25 Sep 2025 17:26:07 -0700
Message-ID: <20250926002609.1302233-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 80 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..db93c83ee4a3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -828,23 +828,69 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio,
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
@@ -1394,20 +1440,6 @@ static const struct iomap_write_ops fuse_iomap_write_ops = {
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

