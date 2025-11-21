Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DF33EAF9
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713108; cv=none; b=Yg89D7Euli2I2p6qx7VSlbGjokZT3sX9I9/x+8Sln8L9zNHZweNOXofeEAIcMg/rJLJgRN1M245sxiz99HbUsAAgEuCy3JrE8V1SoHO80N0QU3tYGDa27cQMYWu8rYp04bNE1HHSi1EEzKbIkE91HvPa8tvIT0fNLF4YPI5hkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713108; c=relaxed/simple;
	bh=IQk4UzcYY75MLGhtAKmFDWXe3EWxpLfeGLiZbBZmOTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6zgzpRuvGAWsDq4bvqlc/AMy+B0/hkhE90R5AYl933ogvsnMKSBExKGCkoc4WEI20EqemCTfO3OhKn1B4h8zFtUCN43UjOGkWmhWnfWP/BFVi7Uz3wiD6GIMAVRGUpvZoXR59k2eQzKDFYP1b+yJdi4GqrKLo8gn/PGPHyuxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNn2zvaH; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNn2zvaH"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2695358eec.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713105; x=1764317905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=VNn2zvaH1dla8AYLvTewYko7Ry4+H1pNkClbU0EHjR4Pjax9W1Z5AeUzKGkGmapwhu
         Zn/eAHO2juPdsB+bdpwRogURwMXs8AjraBZkeEUWo4Y0hBjlpmviRmvj2PRGII8MZZ/W
         02vzTPtd6NbjOs/QdX7o5rEld+t9ZNsnTSSTG6M9Vm+3TGaAfXtITwX3dBqopZ64U4o3
         dQB0I/BumzvDR3g9L+V56HYdYVsP9rWr9pWOM3z5qNrAzwA4jw0CiCGhUCIafLlbJkNW
         sFCBTEoUlAorSrrXs5VOvL9XCDjYwx3SpOEHu05B/XNz8ZDg63tj5kt5NErXdmAqTR6w
         A/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713105; x=1764317905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=LH0dZfP9PGk9oFMSSjpOeqW5W224//lgk3oF+yhA7Nx8HJc2v5n/kWhmIZZBtRrrw9
         X90gH0Gq1RlOjl+yLd+stB7uvrIs/gvVmhjV8SAjymHcX7T+Ery2AZqTUbDedYOMLWlJ
         HEHwhiiZyU5dKg/uh1tlAbLAniqZOZLxzEL7Csc+mdSS6tyWHBTzEF795wo55bJGMt3n
         uHXzZBdROe1dKwxFaJMhRqs+v4Qo8r21dyX+45UDeWNoI7meDl6ePMHnsn+E4FYnuKss
         5lrvYS6/+y6SAxT0wgA+8CNkbpmlTZgzJfnyYYyfquFfIKkNwTpVsHrS8QXsymrbiHm6
         GhIw==
X-Forwarded-Encrypted: i=1; AJvYcCXyZZR6fRjooKgcJPXl2pPx/DOEb0Eig8wRuHToU/lazLWPv9GEbKbDTyfSpnK+ZQ9DNzkz@lists.linux.dev
X-Gm-Message-State: AOJu0YxLgBjAz9Ro4/K3hbJ0RsatIQpjJruQueKI/gvtNDoCIozy8Yoy
	8njtKBWZH/mPuB6eW4whW+4ZXoeC66YUF62u3FZHG5nAdcT4mrO//8go
X-Gm-Gg: ASbGncuVTOh63ILnM8bYia52ZyneiF1PmWCOGkP1o1uvoN0mLV9kBt5qSKnStFwHx8V
	2hRsXA+72x4ObFPDC4hpTo8KO/akPyvuGQPejAMbJcKp7VITEad+cl0a6OmH1E4DwMiuuCHAXSE
	x2b3QAiyq4nCuAptXBQLb60I8jv1kh+aNDYcbMOPYujj2v0eT0l1vNyKt7DVivW072m1w9CnG7T
	SblClyhWzuRQK9Zb/YMdzpTxb98BNFL9gZejvwWe5VUntv2Y/gauNb6J6dqfg5Y/rxoyHQBGx9r
	sEs5mFfTVkLB5Vycw7oCzhkU6TT+UCc6QWMhRBoVbyFg8gqAeJ/RM69x1SoS1n24pBVBBXhQl8D
	gdeHQgfunbbOHBhAYQMJ1BjUv7Uk/P81HatdcM1vJtEIYvHdiJBdrCyQiq6zjEtZw4BB4WGoxF+
	sV2Y7t4VytQZVDoDdsgu73QGRKDQ==
X-Google-Smtp-Source: AGHT+IHMz3ddZnRtvaJ/THHwP1wUMl1t1R0JBJZczRRfd42vINt7DVj8VsCW+6dMTczCFjZ0JXIsxw==
X-Received: by 2002:a05:7022:a93:b0:11b:a738:65b2 with SMTP id a92af1059eb24-11c94aefcabmr2003355c88.5.1763713104659;
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 6/9] fs/ntfs3: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:45 +0800
Message-Id: <20251121081748.1443507-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ntfs3/fsntfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c7a2f191254..35685ee4ed2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1514,11 +1514,7 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		len = ((u64)clen << cluster_bits) - off;
 new_bio:
 		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		while (len) {
@@ -1611,11 +1607,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		len = (u64)clen << cluster_bits;
 new_bio:
 		new = bio_alloc(bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		for (;;) {
-- 
2.34.1

