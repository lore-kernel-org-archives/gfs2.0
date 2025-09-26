Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1F1A5BBE
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846579; cv=none; b=GU/2cJPhzyMeW5biKaequki6mzLgzZ1YUwecDaULjEE6O58yr+bsOfd1fJd2qMWtfrYgNaediMMImJCc7TiGINpYyNlUy+InIP5vtCQ9i66kkayj82De+BkLeEK6mBb+mckyJGxtgkkz0m2r1RnEb/XJzNGsPpLkNrZUd5Jjmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846579; c=relaxed/simple;
	bh=C6U83VEYSG/nf0iVBKW4dK4jfu0KJiEa+HZsT26LBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUZ9eshV0d98bZZSpcLnQ/LJeMZCsC+7frbLwHu8Ule4a/f43JDMIfu82qwr+k9G5lX1iPL8sRrhm9DMWB5gJ/BxwTlN2fSN9QXRRNV1JWcuUkXZtLlMUgQ2vf8psWIL6R4srVJ1AzpkBlDSZi24C2OaDPB1SFVtw2cg8AsomZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc9xWIhc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc9xWIhc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-279e2554b5fso13911065ad.1
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846577; x=1759451377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nulppb3Fi7XzxQvs4wndp69uE/z4zY5omf8b0JzfU50=;
        b=cc9xWIhcyFE+hKbnzd+ddpAbiAGE20SBdAfZMfHLlRsAH+PZPXnkETjQyFfQassOyq
         wZ0yYDGTKCT7mXKOVplmPykMWX2CNSTOVsvKc661X/n4xb1QqpxuAvwHeusurUXSaB0p
         gxHQA8VVxFSR/xIxlpHcTUgfQz3CoZuLjOyVMYw3sgWleLFbELPbx9j30z89OtkyUWeu
         HDjG7T5zaO82avpSdMZnHsKAGQbhindMbA9FFgDzwe1alvLeXCxAk2UsEEdQTUwn8VKk
         55ZQxGpBl5pmJD/lDCkirvxlBaj3flt9UJheDNd6ZLQpgEGWL20ZtbsY07uVaiJE0NuV
         iY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846577; x=1759451377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nulppb3Fi7XzxQvs4wndp69uE/z4zY5omf8b0JzfU50=;
        b=E3TPyXgPpzXWTHiPqUhSAky7EaRx1/6bRfejzOku0tijktaMpCvUqd2anxUHVwEdSF
         HCQtH02EjoVoO95BbW5v/O9X6MbOlxvZym3I1etbE+bECtecYfR+n4gwSCzM62gZN1gL
         ggdYOtYWZtkBARk7AyJeVL+RLF0vzpJA4yddx3l7Oz04goKVE/N0ikRwWN0s8gVpt0tg
         BkIkiLSHeT4nfGqkmYWJCvdoNR3JsHTpvm/JMMG0bhK8mmgqBbE3AAIdc3B7fsNgGkBp
         EnX5z7RP6rJq+E09g5n+Iosm9IrDcO6G1rLo+u3HqnA3aIVyjVnetfbd8ZUfxPwRavhm
         QpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUugmy1UagSOXWKc6FZ8W+0JvnyJKUhO5RmGfXQHMB+8EdmO9WyMfTZ4bzNYSMyVKE/KLr8@lists.linux.dev
X-Gm-Message-State: AOJu0YwxVjE7vvYcQXoZCzyUPSl786iWYrM5m9XwbmNos1RPik1w68Fq
	dWdTa2c86hGVt09lB7NSS8guY2wy2KAK8TPyWcgjEzZ3bspTuhvMGFND
X-Gm-Gg: ASbGnctk8rYoyOn3hk3mRN/d8Rc917xHCvphM5UFab/ubW6lQLalcvHfOs03CCBYPNy
	u15hJ8Y5WGTEI3coR609SC7W6UjR4eiLiyFe7ccQmRxwZYyEcKFTMxqCKdwP6eiJeRnsN6TMDCn
	u8X2cdo0B13S5AMaSPXQvlUBICqrM77fTI3QVkKYNcRo0B6nBXauvkU9dkNTW9Kna0iyStSuKu+
	llgy4v2nu2qMiCKE9VsMuKv7eyz82JvJWwTQp6skRdy1XeBIlyC6+qONDizgU9Xq/WLR+3FeE2f
	gg4xO9jNstcMtS+a/tVGQVosLvPp1e8ynDeuw6009qOwHjr9MencMwcO7ZykdbpG34BzpglMTaI
	+mDhHaoG2OvHIBDRAPaeo3sUfB4Yh7OwvZeU2tdlKDGTcfoAy
X-Google-Smtp-Source: AGHT+IHaOiCcNeqvYIRT0C5rvKbkak1Uwjw+eScH/ni7itDdwd8uftP18tKx1Ss8wB6a4YBQSmVuJA==
X-Received: by 2002:a17:903:1a07:b0:26c:4280:4860 with SMTP id d9443c01a7336-27ed6bdf53emr46606545ad.8.1758846577537;
        Thu, 25 Sep 2025 17:29:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882210sm36174305ad.79.2025.09.25.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:37 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 08/14] iomap: set accurate iter->pos when reading folio ranges
Date: Thu, 25 Sep 2025 17:26:03 -0700
Message-ID: <20250926002609.1302233-9-joannelkoong@gmail.com>
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

Advance iter to the correct position before calling an IO helper to read
in a folio range. This allows the helper to reliably use iter->pos to
determine the starting offset for reading.

This will simplify the interface for reading in folio ranges when iomap
read/readahead supports caller-provided callbacks.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e6258fdb915..82bdf7c5e03c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -375,10 +375,11 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
@@ -470,7 +471,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
-	loff_t count;
+	loff_t pos_diff;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -488,12 +489,16 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
 
-		count = pos - iter->pos + plen;
-		if (WARN_ON_ONCE(count > length))
+		pos_diff = pos - iter->pos;
+		if (WARN_ON_ONCE(pos_diff + plen > length))
 			return -EIO;
 
+		ret = iomap_iter_advance(iter, pos_diff);
+		if (ret)
+			return ret;
+
 		if (plen == 0)
-			return iomap_iter_advance(iter, count);
+			return 0;
 
 		/* zero post-eof blocks as the page may be mapped */
 		if (iomap_block_needs_zeroing(iter, pos)) {
@@ -503,13 +508,13 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			if (!*bytes_pending)
 				iomap_read_init(folio);
 			*bytes_pending += plen;
-			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+			iomap_bio_read_folio_range(iter, ctx, plen);
 		}
 
-		ret = iomap_iter_advance(iter, count);
+		ret = iomap_iter_advance(iter, plen);
 		if (ret)
 			return ret;
-		length -= count;
+		length -= pos_diff + plen;
 		pos = iter->pos;
 	}
 	return 0;
-- 
2.47.3

