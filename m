Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627332D7DD3
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066637; cv=none; b=Tj10P+5puiLnndEJLiVIzNBkQWN6OS3e5/HT/MHD5UwlK7SY/lf1uPuvqxEv4cYoMKs1DjRkKvjQOhi6WKyHiSGEy0980/RrR3cxq/ctKKrMemZLwmRV2WC7G/1gtRZNbPH+XsG6Rv29hlLK87ms4bjG3x4UEOB25kZJI2HXZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066637; c=relaxed/simple;
	bh=98GkOjzNEJqwvQK/4lUwfHNtYdVVuLzxJ15LQCdn1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XckbMmuZy7yqlFU3+M/TViY8/iI2g401OBzTiZ0yReIzHygYU636fu/odKZxRulsy0Zy/JbxiWKRQ0HFHZHRdhxa49w7FJ0aJta0MqBrzrwWCko/SAjBoP1m6yqoGgHkiX/0+Ex6lEY/fG4tHx/lp+1wCqZTG3tK8oNv1/mZ1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLIElB9x; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLIElB9x"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso259534a12.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066634; x=1758671434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=TLIElB9xzzssRvp55IVrDgNvREns7OevvlNgrzXqxZvV9Zjc3x9Gb2g++Vq/stbHM5
         EX2TvmwUFY4SadBUEpbg9mpk9MjhBav/Rzqe9weO+noWRQ4Sz1Y6kAnrCgqKmZzHBrI8
         Pj+YJlcfOWWcje7gFNtW/PXLVq2NdtNrM7xdTh3j5vs2YmsNEHOydE4hE+b09kpV+ZYK
         DJ8FfZupnjSRVxB5UEtJK/PTLX0IcoUpy7kdZ+g6pGM2zYSiQJASDsF3enF0/de5xig8
         8F3GedPhYa31gxsTjKo2vI0A6/S6PNsMIUH9TRuivSUT3XBW93FvmrCYcz99W7xZNFe5
         UwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066634; x=1758671434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=wzKEfpt6VRdFumaDIQuGVlf5+3FRAwYq/5b8jzAdIYxtkn+1ataJspjyRoGOq9H5Z/
         VJUBLGBxo09mhxt4Nk1iqyym9T+71uDF7TV3xcoTiA3w/UTDLGW2f+iAKaLcmH/47rqP
         +twxV2GIZ73SBFzr2CdzljHfIhYJhey+PV3ce4WaspgE5+WfD777UOUQabsIOJVMgrR9
         gbQLcedxmL+WU/1R0VmvLCGIg5mCXOCpzR2cBoBEttuO/rFQJb9IO9jkSKvMLisfMJkH
         byq1yr979Ku51Sn2HB1o4fDqELuoMIXr56stZXb6lenjUapVtV5VIRMzXaW0K288BJlb
         OdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYpsHGv3oSViA70iKQ8kS/HLmF5WEzeckhD+Rn43wq+rDuUVUg781nvkY1VXbQDTr3rnzn@lists.linux.dev
X-Gm-Message-State: AOJu0YyKo3HgvafAaFIpdpnAeJ+/6wRGg2r8+JSEuWDEfOKo+iFxMBKF
	4QVc2fACJdE8PEdr80vhvH7fc2/SV80t/5eWGmY89U+sWJp7SLrTxaAP
X-Gm-Gg: ASbGncsm2AoWVLqWb4gqezzNsu6wWJrmJMDCKrwFPJUdFvuFaBHjTAl3TxG3W6OejGH
	P2WbaY4xWNmxMhHfXQmIOgm2rU7+xoXB9zj5BJun+y85g4MWoisqR1yV6iApbe/brtloOGHz3fI
	z2fdFMvhsw5ao38A1vxav8vckIKHaRWVblNUokAXcQJI4ltv07l0fVmFfc0SvRxNfHmVDr8Pcrw
	GMxX5EwHkp3ahu1whw9EhzwqyFjxKf4PGUoX3D50yQ4yQoVmxutxTVg8yWBauxpDXrZO8xIYmHS
	htsxr/CwfLz9wK4iCy+Fo/9dAQiJ5Ob6DqlxqSLy8vLECytw2pV/nGHBM9xxw0YmDcmP8vGWF8d
	iaR4bR3XueAlJdng5rF8/JWH9UQI6ku2Qr1hOxqRt94uuL0cO3OADHRkG3UTQMUmUAt7gPCHrpC
	xk8Hjv04d8/gRGv2k8t9b/iqUy
X-Google-Smtp-Source: AGHT+IGDxK1TSJHJMfjQoDefaoarnOiH5p2F5ClNqiomMKUWzK7J0G8impfhFApU6S2QB8fO6tB6Vw==
X-Received: by 2002:a17:90b:33cd:b0:32b:d8a9:8725 with SMTP id 98e67ed59e1d1-32ea631cd58mr4496407a91.18.1758066634546;
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
Received: from localhost (fwdproxy-prn-054.fbsv.net. [66.220.149.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea101ef2fsm1520309a91.5.2025.09.16.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Tue, 16 Sep 2025 16:44:15 -0700
Message-ID: <20250916234425.1274735-6-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0c4ba2a63490..d6266cb702e3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -412,7 +412,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -477,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -509,7 +509,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
 		ctx->cur_folio_in_bio = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

