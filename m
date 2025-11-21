Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9A33BBA1
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713097; cv=none; b=ayht75jDas/KW1GQNWLSng3KXg1Q1pyMRsmIXieaX2l5rfAkZxBdhqnOdPGLbBOQHHTCRVY5sBZ56Hsei4fmp7lzIsYVH+khiKoeKy6SaKYbJp0po9dzm5RfsBrKi/AvzDhEMdTeV/wPtPDIR3XE4o1eqGBYjrcSRU5DknEOESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713097; c=relaxed/simple;
	bh=ERpHvRnw+l3wstR+WAIvwtnoTvXWleFvGGT+ROO3fSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INm0wcTTC4syt//xHGHMNzrhGmlGvT6yRhzmZBQnPWV2lvjUA2lJsvm4RSCqWEq/IPfoIJmwEpJ3AshUpSN8tTFD1J2c+5ZMLSVIHN0E33CCwCPfo/jWb9hvPEWpIx5JDrMNMH4D2Qn24Xew5/9trEKAkiv8YeuS+65U4ETDoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzrvxciq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzrvxciq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2003704b3a.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713095; x=1764317895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=bzrvxciqo/CnwlsezPt6oLQQqLXos5pkXOQx8mW4vyTqKzcpJeNCKQepdZjvw3r5qh
         jEvF8x1lnKeTaA7AP9xeb5UISIi852pSILFeUVo8vb6mi3nWCGs0U+87K3pq+d34Tg5B
         x8eYtq21Wxj3uHvDpQfp8BVwp7sjpJumzd+WtdZneZ2ck2SMY2YgQfiAb/koymStrQgy
         To164Gxv5i51wgsoPtD9iRqqPgHkmQPZ9cKWK1+vocZVXFGpScBhW+HGrS5Zn8jUAgp4
         OrxfubssrFxHv6V9GcLIPitkaclsGyvU1jvevoGznuFM+wOtlNmOjOjURVuBTUbEfgy6
         /KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713095; x=1764317895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=arLoZUa7fIkMIcCD4DUBVHAU/d81ruMb1x8HWmUZgU02pR8Jfh44cFJvDiLSwWfnWK
         c8wJwNwzZ9/uDYkPzue2HYmDSneWk/lJw8kiXVbEGhZOmPP0WR5J/F8Idx9m/KpUnZs4
         WS/LomVvdPELLqeTv8sNvjjGcCnAvyLlSLt+nb0NoBlCyagXigkQn5EF7OAN6EREFPE/
         5cuIE3Ud2duw9pFcXOsWbR+UOUCItFz1ylyX4FkcAh9v0QZroLDfmyWk2QvmZcvJ0e/X
         WuEe3BEOlh/ykVgoHXrP6xlp9yyWHfc2MRvzdYNaTYko6S8hZYWznxwJxKDakmG39LJl
         6Avw==
X-Forwarded-Encrypted: i=1; AJvYcCVkTAp8iOoQhjCCos5ELm+zISrTT2Y8IXgzRI9tEoJFC1Nt6haGEmsZ3q/jJxlhfJ9CG0qw@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkc632y976kbxzf7BI82oB7IVZ2mweo0HBqauvWahXmOJslwMw
	naXL1YDZUIbPb6PvEada8HSxDX/h/hXy30p3AGoeYiaeDKHkvraj3qcV
X-Gm-Gg: ASbGncurbi3WsRelRM8JHX3A8VllQ+9bhwcWetXXiOL4l9h4sUrin7kblaYMywmWoZd
	wfFJxIi62+jC5KGqHWaQtLA9vPbsCKScaFbgBvksA0xqZuC5vNftbRncR4OPYFmL1TFQRYqYpbY
	4X+idxFvD9cbWhHvkAWoW+h11qes+sQXybg8qAJ9ONpGTuEQe/aHbZBZ82OhdRUzVO9bSe/NCii
	XYeyffBFz/xTjhpciPn0DSXsmTko0Mmlh4uHHt8L2jeWBGJo/N1n20/JCRQbCtdjmHekbVl9bSY
	WE+/vrf/PatPq/ev9kgqzpBHFJckXpwkaCuJ30jM5CDGpKV1A8IYKLo6EtPnPj5KnhqT+LhUBNm
	YNd04oUU3k4wom2833QI30M+holmcpJeF2IiIjVQYULAbVsKeuRtusQXOp/cWUGzCpUP1l0yd1r
	8OvXLGiNqFeB2EFv1Z2VI5IO8c5A==
X-Google-Smtp-Source: AGHT+IEHu/E6NqM3wgnO0PzNJHfm7ylIJ91XqRa53EvuqqhyyBcUb7YMg890bib+mDDMVjekZVw8IQ==
X-Received: by 2002:a05:7022:4419:b0:119:e569:f25f with SMTP id a92af1059eb24-11c9d70b0d1mr568161c88.8.1763713095153;
        Fri, 21 Nov 2025 00:18:15 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:14 -0800 (PST)
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
Subject: [PATCH 3/9] gfs2: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:42 +0800
Message-Id: <20251121081748.1443507-4-zhangshida@kylinos.cn>
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
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..c8c48593449 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);	
 	return new;
 }
 
-- 
2.34.1

