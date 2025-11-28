Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D42FDC26
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318811; cv=none; b=g46irB6jO6GXXLNYpFT1YI5SqQLbttNePM9bn+sjhSUxDsAX6Q4vK+vGyhNEUw0DBWDItyJFKpFqDwv6xqfUn8wTu9MFAkfGCGwNJA884XTiaGKrFv8rpGdDeOX08vM9mUUD6elq13g6MMJ2Y/hSX14D3g1sivqyOOi3GMlHTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318811; c=relaxed/simple;
	bh=TbxNohFMmSKnHTWH+mnyMfPFRdWdcWW/LS3/VsufZdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzDSDThCc6LPGJJMyzQmJYYB1MbB6AYK22MFKZlzsYj29l05qql5T5Ctaf2m1EupW0Mo3ywmpjSxJiOLenKCecBjA6g7oXAyX3f21NAZtmPQ+EG/d+0JTBO0Y50HdDiN6+QZkeoZixhjGosV9VX9u2mYxScPUWqmnHpJslvui1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE62MRX0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE62MRX0"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bdde8f1814fso1401253a12.2
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318808; x=1764923608; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=EE62MRX0atIaRAQP7wjFlyAOKNbJKyyLvIE6107ew5CLRL4pGzUhJwgHmkMnXm95G+
         BNM5FVWwaHisy0BhjrJ+gYlTvGsgoKc2k3IjfNvGt+WFJwq4t5MUyxKjvvN6iYVNVRYi
         +6TAMomOaLm20VKIXU1dhb6XT3w62E0yvhHLv6tA7HhexPOc/wd32EfBzNhlXIdc1FzU
         dH/f204qY0hTQkLX6T/GZjHSoeiGVBLL2bZPUlzXGlyQhuH9A30Llv3dHOpEjkFK+two
         jF9p/qBz4fs/tkQenQm/tHYai6SAxdSxvzSdyCEutvIQb6kYCnXUyEuirDBJcf7YaMt4
         ehcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318808; x=1764923608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=HCHxOx8DoxMcqNL6C7ZLHAK5EQhHkO1DqTmAnivjRG2w1V34eCMj3QXe0SNXQSHagf
         rE9ZR0eFst89BC6eMN9ir9EMYS7jPLJjjPQawbOgPV3ubhXcYo0iMw91OIe5qIdtrDu6
         VxUh5W2PWtRMiOjqv9oH+mdut0O6ZN6FD28oDvJJsaCVotEvsM2XTRwkF1oWrXMtp4X0
         TmUv9sxpMMuYOjmBwfOqoKCXis90Vwyic1vQDhtn6ew4iIMufzRitZ8dEjE8EP+wvkal
         uGXPKGMNn78KDJ4GPy2e5rzyun4hKnITTtyFdYWNMEPb/DgyJx5uitPS4JGPEr/paeNh
         KUpg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+Qi3Pm2wBg18/C9GiQoc1nreUQS0pl3iPoBNWYot2fhuOXJweorHl+7tlIXDMJWTV0lM@lists.linux.dev
X-Gm-Message-State: AOJu0Yxds5LnlgM+68heg04pXbPK+thoUcpDTR07YHAxQiLRFT9cFakd
	vUUFTMfxozw6R0iOi++8Vyrdk94yMaIRsGOdnJ82wLYA+6Pj36k0vViI
X-Gm-Gg: ASbGncsoSUokYa7vprnOiqFdtPhj+UhFpA5TnOWbb3k4gY5HAr8gh5vVcs+ZWxmcqmy
	pE2cGkOQNCoLDFJCyqO/0TIds1ZkukoZFZ4JkZBPTmlgn07DLQvaPch1T8ZhfjEF4+Um0bIA4Fj
	limcs3ScUi8F49Oqw60a5tDs88n4b7oGx6JrnFTlPxgsyGua1HeYjjyvbFE1DanrJkc6cB0OhJu
	M3SpeS52+nF/0MVSh+4D0TbQOJe1m2AbmMzlmQwCMAGenKEUQqG1wzbpfhj2MgErP/NP/+kjkOm
	D58B60C7RmG4dqtaBW5hyO1zyiHiGHoSFGQljHsX2RRxpoIYFFiwKrlItxwAMBbX/xrMpCBlNDI
	4bopvti7NOpopTXXR5ZjeqU8QadZF2oV8Li0srb/Wf6mKURWwADJm8oK36V5Fuxde8nV8MYDH5E
	1JAYvXY0i0Ltz/Lafo/ZwaVES0z9BS0YjznuKj
X-Google-Smtp-Source: AGHT+IHDsMToqUoj0PcNSA32TYDuHE8zhBuDir1BrYt+w5Y/wAZYCWlUzMNg1Dgih3T9wVkLcbd8Tg==
X-Received: by 2002:a05:693c:2488:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a71929687fmr16240699eec.20.1764318807899;
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 10/12] zram: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:17 +0800
Message-Id: <20251128083219.2332407-11-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a4307465753..084de60ebaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -730,8 +730,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
+	bio_chain_and_submit(bio, parent);
 }
 
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-- 
2.34.1

