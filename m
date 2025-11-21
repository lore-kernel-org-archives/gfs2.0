Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE833F8A4
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713113; cv=none; b=R5O3mv3CpxqRCtS/4btGOWBedRWa6Fm09qzIvAw9X4NT3QohB7UgTD+SMZYCui9bVxHg/y4h2s1/TekawDehBT9nkOKP/T60TRzKzWlYBavBwKWMYVTXjTpPfEEaBIvMneW+Dk7b+ehqRjZmxU4d+w3eCBxpo9Ogm63qvjVwBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713113; c=relaxed/simple;
	bh=a7LSL2iwilO1NB088738btanTUaCE2U990irg/c2KQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTEK8MoIsD3Hm2ITOlICIWZ27XMWCfMeadWhRYEykslN9G5y1YIKHxvt9c08+7COOcE2fjAUGwM8SIxkUuQVMD3jH0VExM5uMAcfoloe01V7xb5zBdHK+UW8eUDUnp3xlNStX3KHsLy1KSqaHntpExWvOGcVL9dMoWSWQbD/PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG1khWBk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG1khWBk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso1073057a12.3
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713111; x=1764317911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=HG1khWBk5LXl53K5NDYrTW8VCTVBPEir7KvA5lKQ7Ee7yU4g1MAsQYyXZ9OcjuxEIa
         73z08097waazSMlgyDUpPNvt3u+aCJAOhutIDFm1Ltv82Dt7DH8Gf6YIS1KyojmqTiag
         Nw7uRMOgZXXg759DKRL1izLmL64IIAO8Q3cVFHStJn18Jbe1hAYE7QHTix8BcKlr8UP3
         zyII4M+5GmKkEwqrbdu0aUF2YfTzaNlVuXXNF5zBMj/TPavDaHU41gaQJsu4YT6ekXp2
         H542hg/KeRt1OWU9ACiGazw9/sbhnJ3wcqJxYWiYJhnfELIyKZ8tIV4SPQKUvMlmYLIq
         k01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713111; x=1764317911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqJVIkHeBy2QrJ/910C594A/mOhcsYvy9xKzTt/nypY=;
        b=xMIEH8qBPedkNumq+9+GiK8s14qLDG81hlGuyv+K8IP4eP1uB0jrJIPEcrHT1h4FTk
         oy7P3EDCi+Hv2YRJQ0pQ1e6XEGLQ8B3qYzeOUA/uesXci5hdEqpxFVZXCsq4mRgqLe6F
         I+jBgmvSEA59x9mTnG2aMo9pDvaSFPPlhFapB/ZS/gcztRwrSDUpC0C2eKt+Mh/GwpCs
         FGs5khs54LmBhvV1FzbF0a/2nU13buGtF1oa9YhSPfteBU3K0ofBde+shRIcy85j1kGn
         qAxoPjWw4Fp4CWy6z2vBfz/USr0p+l5MALnwBTBogj/zwS5Y7tX8ZCdK7+McBnek3Wz8
         YT7A==
X-Forwarded-Encrypted: i=1; AJvYcCVTcHJF/kP2YjuQYMdiIPGsKJbkxd5oG+b8ko1BBUQVTO9s0I+lBfuiDyWg0+gkFI8Ns4do@lists.linux.dev
X-Gm-Message-State: AOJu0YzLjueI7wzfGkOlnNuaBWxJJ5oFqAMnateTwqgENKD3TjT6elND
	JK83tL2+iBM6z7J7LfTUY8zk0Fi1GZpspSAxmCy2LXWRyY9VJvqTxUl4
X-Gm-Gg: ASbGncuXFAXMfyXrIFZLVQaH5xtX0Vu3SVbT6GXXE4INi14xlQNN7EW/3YSxK8BOE2m
	HS4ZYiP64HogxuqfDeZrLNpBJspWlSN/bm4pB4lJ8MAuDIg7GtRLMtTnNJhCuFxPpzAeBmAUnNa
	gBVaYKmLo/xvTIRQVMaYtaOuPqdlwlizupAgkx1vk9qYMUHHE+OIvE7LBZj6ZaCrNBiTUW9L8FK
	yos4CAXBGj8IA0oUfQuXfXEk7/CwX+nMBT6veQXjZQM6NzmAxIln3tzsfP6ccz2BP5J5pV8/Mkw
	Xps/TaJp1nB5yY0H4wjYq++adheUHeydDqS+frDel4CDXwjbfkqoQSqWAEQvJX0iIOKjr71mD9v
	7IEUlmmOVejLAzc+9LGsA6q8puf/nt7bFuSnRb0IGVRR4M2iVgPQqPC2i7/4P5xPHGgSGB9WYVz
	M7JNK6FyqJHkTriRAtUgM8DiamYw==
X-Google-Smtp-Source: AGHT+IFWgtWuJbeRkMQREJ+GB1+CIl1owO0q1AKLfdba/kSV5Dme/s+uE/AHBWMGMV79yRIBfle0AA==
X-Received: by 2002:a05:7022:628d:b0:11b:9386:8257 with SMTP id a92af1059eb24-11c9d87a334mr448835c88.44.1763713110905;
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:30 -0800 (PST)
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
Subject: [PATCH 8/9] nvmet: fix the potential bug and use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:47 +0800
Message-Id: <20251121081748.1443507-9-zhangshida@kylinos.cn>
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

the prev and new may be in the wrong position...

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1

