Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49A1DED5B
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587640; cv=none; b=UkT6gw6SqLVYc3gfm2hnnBiUOjdyYbstwjbcI/EOxEK6a4XHuPxHKdPXWSuRC5D8MfC2FHjSgsA+MnqOhMMi41RSIFqJ1RidEER1Qr3aq25kSgnkTPzpuZa6/m4QRorEhq5dHRyLBuMOrZDG6HDTo2LKzZhLdabdreaUDMCueaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587640; c=relaxed/simple;
	bh=a/zyIEvLQc/XUbs4Regz+PNxwhBjl1k4o/jZih5gfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4k7FxSUtXonKhbx9bm9eMOwwM+2VBE2vaHqFFz84/iJI4ar51mR04RiWY3LJIh5wOgOOb6sFiNtS+vZTKYmntu+j1vq7L9ml4hoXCwSAhwPTkH/wOaBfMugcFPtSpHragHvewfiUtz0ypzb2Z1OnDhs82bOTbQurnGW2+0qFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3s8JJFd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3s8JJFd"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-271d1305ad7so28282975ad.2
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587638; x=1759192438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=h3s8JJFds8awzZ3cH84T/fJ5eXDBVNcwnGm2zY07sit5W3zRtvP0MySavv4ttf038Q
         7z85Ei58UFfBHW08mznmFleAo8XHUzT3ujPc6Url6fF4khbx6RnLjaikR7wfWJVFu96E
         VaOWRKLeU+X3tn0xb/YVm+KlWUA+BlrICrdqKOMHJrmGrW22WI9ZEfjvNyHEllTjoPFx
         oQtcaMNqQ0lJ7e8X64iFaGAcGeeaudxO7swdtr1Vk4CF6Ydzyz2z0c4CMQGUJpLgMo15
         uIODGzC5avYVCRIlDzy8GJftoKgD6Sq8RoI9ZQ/1an9uMFocTMfdKVzhmcyKrhITtcwa
         F5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587638; x=1759192438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=rUvJtrN/iobRoCh7/ZDVhKSLDp86n6zolpMVxegOIQdq22rj5tK8fKxV9W/jwnICo3
         DAthDWa01BEler9nQ4pLhVvY1RcPpa65Dtq6VZNs+zB5069YoF6RwmKN+EWldKT9VxYB
         00BuFySd7uMAS161Ftas5qSov1haYCGmWsT2xA40NexA7uORoNkzTFcHaHfhchK1pqdK
         r+n0cKco5frpOAFi9OJ43tcI7NjhAB7no9vZEIVEtQRFbBEJ37ieFYXTgkIM1H/SkIX5
         cR3YF2/GhXHHlbHazeA5Wu6bCmoPErOybmoNxoJNhwHMPiwY1P+PKdNiuydO9dUVgkDK
         amtw==
X-Forwarded-Encrypted: i=1; AJvYcCWRnttWBrSDKuWWk0mIh2IOKThOJybTJ/ert/4QWzoVFLH5CRZSgp6W41UWqeoIySieKWis@lists.linux.dev
X-Gm-Message-State: AOJu0YxiEOUI6pVD8RQ8wEjdgVZ3n9SLEet7pue2h/B1yMfTk8SHo91a
	LLha83A6DPG56S8xo/xEhs/lZ0fCp+PyNej3Ryy85tZxxLEVOwJhNKOb
X-Gm-Gg: ASbGncuc+FWJ1WtJQF9abRxVijbY3n8vo9dBjrHDOXGBkp6lOzbuZygSMB01jpsuyTK
	eS60cwa78cm0qsR9MFqU9F0n1Rfd+C0ck/SRJ8sAVcjFwhhAwfbhwbji80Df6BJ24IMvOCsDBNR
	5RXhkyM1M+VHFVfmk3VFbPeRb8pHJGnZFkWlBSljCNpDmC5sog8moRSvMsEpjC7beNKr453qUGH
	yh+0B8wowFueqEx2kG3s9+/x5QNiAtpKI6kLwCdplAVZqYBznfpFGmTjmIfEDLU2sIlh+1TOQTE
	YWbEkCGOBNreWPecdsgLWPd8qBKjkSzTpjc9oe02tFS0e+n5n2CkW/LtK8qUlDTQrKEctBjPdhc
	42lSVn1XqU52K9rZUtbuRJN6/VK+sQ817poXeJ6GILoNaSLquTQ==
X-Google-Smtp-Source: AGHT+IGQISl64Y5Qz4l069Hr+dg6JwXOBP5WOcZIs2GDXy1YtKD9sDPga2/FeznyhaigCtWuIUSimw==
X-Received: by 2002:a17:903:46c4:b0:267:cd93:cba9 with SMTP id d9443c01a7336-27cc696e79cmr8418715ad.35.1758587638366;
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dd5sm145263185ad.26.2025.09.22.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
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
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 04/15] iomap: iterate over folio mapping in iomap_readpage_iter()
Date: Mon, 22 Sep 2025 17:23:42 -0700
Message-ID: <20250923002353.2961514-5-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges of a folio mapping in a single call
to iomap_readpage_iter() instead of leaving the partial iteration to the
caller.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b06b532033ad..dbe5783ee68c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -439,41 +440,35 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_bio_read_folio_range(iter, ctx, pos, plen);
-	}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
+				&plen);
 
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, length);
-}
+		count = pos - iter->pos + plen;
+		if (WARN_ON_ONCE(count > length))
+			return -EIO;
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (plen == 0)
+			return iomap_iter_advance(iter, count);
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		/* zero post-eof blocks as the page may be mapped */
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+		}
+
+		ret = iomap_iter_advance(iter, count);
 		if (ret)
 			return ret;
+		length -= count;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -492,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -522,6 +517,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
+			if (WARN_ON_ONCE(!ctx->cur_folio))
+				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
-- 
2.47.3

