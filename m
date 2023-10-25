Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718911732
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieU3pOwl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d9effe314so3793566f8f.3
        for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235034; x=1698839834; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svgsq/AnbjJxNk7jNBD8VRF+Bt+Kn7+Y3XI8iU9eztQ=;
        b=ieU3pOwlPk1TZ7Kvw/1R2PGE4GLmmCIKTNefeCigGj0g5we6KfVsAC/Vs3tRs4Thuz
         TgP0jRJKKEN6xt7AQ1UkGAqmZcUqXIRlsysQ/h2EU4WqG8OPVUozCNFeQ4WuNg8kKHkT
         x0gPdlJLjbDTdBNFC6UL9NQL7990JR3Y+G5Z3fm3cM0ljolJT8+NZ4qZ/oaYwXU8x4/g
         gScjAqBRWjLYIwl5HKYkOwm4ZHwUpPf1L8sSWF7unlv8C5UxqGCLLUPl7O4bXyXuGLsm
         GdavEYiY0TucnN6j54kXTHVQcdRQk29rXLBcDOkS5A4atDFWhsp18zxITIMl96Zfr1sc
         xzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235034; x=1698839834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Svgsq/AnbjJxNk7jNBD8VRF+Bt+Kn7+Y3XI8iU9eztQ=;
        b=LS+ZVqFMV5M61JtVdPg3nzoWc7J2PVjrF0cA/SeijFgx84TL2Vu8qIOC3bNx5VQuVr
         hCvWvmme/o0lkV238eXwiXH0Bwgt2Hg8z+DUSQR9nHfic3XBxg8M4zm1eYPimbVB+bbH
         e6yMfC6/XOTJFgxO4for1YGcpDFee2Fd8ZbamCGZy2oNiwWUcxLu9offOW6zdPCNJitc
         SzC9v2lYfe2dR4myAhqN0ccXlZZyDB53YY5PD8Gkll/hkkVi0Nyk0/uftQ2P8KeZRkUe
         ZbqX8EfpnwN6xUsf3UYWvsUOL87euOJgCJUzIeoH7oNQ6n+XMLWPlI4Seb7TJJ8Y7tA+
         QoMA==
X-Gm-Message-State: AOJu0Yy6/bjKPDpoBWZKMkv7jDyWKE0j4k5I+X609FkQWfX6xigfUfKS
	iBgkkPX84t7kfA8CBi1UyNOK7Q==
X-Google-Smtp-Source: AGHT+IG7r3dLAwdLNcAlseIa0fKBtN898ETmhV+sCzsSFjW27iIRaLWoI4YCTr60PRsoelQHtsEmkA==
X-Received: by 2002:a5d:6310:0:b0:32d:84c7:2f56 with SMTP id i16-20020a5d6310000000b0032d84c72f56mr11957241wru.21.1698235034491;
        Wed, 25 Oct 2023 04:57:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b003140f47224csm11843971wrx.15.2023.10.25.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:57:14 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:57:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] gfs2: uninitialized variable in __gfs2_iomap_get()
Message-ID: <0b9cb1ea-4656-4802-b7a7-811c1e9e118a@moroto.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable is uninitialized when we goto out because
gfs2_is_stuffed(ip).

Fixes: 2cd225820b91 ("gfs2: Initialize metapaths outside of __gfs2_iomap_get")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/gfs2/bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index cef57d87c24d..12d7651e15e9 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -866,7 +866,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	__be64 *ptr;
 	sector_t lblock;
 	sector_t lblock_stop;
-	int ret;
+	int ret = 0;
 	int eob;
 	u64 len;
 	struct buffer_head *bh;
-- 
2.42.0

