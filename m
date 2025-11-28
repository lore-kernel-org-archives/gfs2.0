Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24C2E7BC9
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318801; cv=none; b=TRCQIewVac3rghhWfT7Ar/2xSUR+P9+7somdAOdoEhUgQvmSAnSfeimrBzhuRz4BIGAF3y8P+oY07VLF+4GagR3qgY8s7Bdn+4Es0YTJoTeeFI48FQX+8IHDeCp+qXJsRshfToD7ps64hWHCtLWSMZG4gtATSQxzsT/zKn6j8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318801; c=relaxed/simple;
	bh=Hfn+I4xKib6YHUNH+g6fjmCyECLvbavw8yPYoNL/5CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dijvbtkWhee/iLK7CZ2nLB+tT+qSoh1/i6vAOfqvRTZFV+LEsBBjxccurF9tV9qWKrlGM6dAC9F07wec1mc++FKg2CVp+J2QevV/vzLUtORUfGr5ImexN83e//nq681A9iqd1ex+D8BjujspUCdd48PJpwHF5S8tpsnsghq3O0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0aOLTiO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0aOLTiO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aad4823079so1395917b3a.0
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318799; x=1764923599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=E0aOLTiOgeQw15qD+0lcu4SBgBMtSbwysfU6q8Elgic2p5citmMT9WtnTZU+exM/zf
         P1qxw9Hcsx4VPSUXKUAlJCd6rENwT+126hey4N9kTiGiM4rVxi2W4G5jzKuJgaybWweO
         BgKPYGZCxMno2xm+7DLIjhKtttyZZjpP439fUXOdNyQfOo/sTffV5ecd/mfQcsexYuXo
         fhIwOmGX4kxVJIqeqmh+K82VpTm4UrfkWuCL03irGEbeMfoK4vw9at5yDziodT4EG1LG
         fCmyYvMUjUoFO1XfPd+qGYSYowoDjij+HN7BxGTh2VMTfydt2qrTFpq/AxGdhPJDnRCW
         qs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318799; x=1764923599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdyx9mvaY+8x+eK9XImqi9TsYLR1v6CaCbGe/GD/N5s=;
        b=U/oM8ZC1rTN20qJf8PAx2c00Um0r/QTVFSDBV4/rLKZLj4s/i48LR/HVgxWeSbqQoL
         hOSUoKcFtapEPv6S1tve3HmIbsoFa8Bee3+8ppQjnl3zuEF1clxOT2TizGs1om2zMqJ3
         ah08J/wnBw2QKtxb+r/kC8TtPB3fA9OTlY2+YJZkC04gvUAfQDFi3KyJbwE3TIOMLjYD
         KjYGAXVP1A50s4v7WB4HCPrddJHoIhzvuZ+CFujz5Vs3wsYjznf2PpEfPqwB5EIBnc2a
         sVMwQUexgaUZ5D9drM1PSFzfLjT1ecBxh3wT+BHWooOCim3oEMkBUcQrfkp5CZ4W2GX7
         lkGg==
X-Forwarded-Encrypted: i=1; AJvYcCWWPcI3prGEI2Mu4bRYwkL5XeFE71TnQNibFyuXtwQgT+phQshnr5MNN3z3Yv4tdVfOUtxf@lists.linux.dev
X-Gm-Message-State: AOJu0YwdpWnAZTaxkw1icr4RtcBESdaR2BNKPqVoloU3MXkrfcr1LO5W
	Nij8KLgStuBH5WxDAitDy7lqZA9yjKilM+YXM3vY0l21MHMilHfks4Dj
X-Gm-Gg: ASbGnct4C1VmU+mydv1FN+yxvVa6T5w7Vppk1FXOXrSoz7vWiPfAjT+BaJW2EzRb6sc
	1VVLyNHpOZw/2d4AsCiS2SKMthIbr+5F+B3sNzTlF1bukwjAkf4fFj5pVn7nim4Rj+Vo06uTnc7
	vJ/NMOHm9C8yS+OPSvyDLMKJqM5lc2IfpXZIkRYv+sUkdQ+i3Ac1zujfREakiX0ripGmtXMnxF4
	cuVw+fOje5dsinjHgHlVyXyYzs1LMmlC8ZURHfbus7YEkMsefJmUAqjeuonLG0qYcNckxZ9CLQq
	ahiVaaV7JllCJOznDaIUivG2lHkuvyLX5PXZ6bpqDXLjUXGYkAa1LSG/axCKqxSxEAQr8NC5xgQ
	iuzKjoIau162PZlJA5Ac3BDkvgC4ddyDUnj5HxQB08yXzZDhmC0cFPFN+RhwVlXqi3j3CEpXYD8
	GrIkGQp1GGnFc7U76EERUxw5ncPQ==
X-Google-Smtp-Source: AGHT+IHKXq8x9elSCjEHks4N7hQUevj8WxDVP5HKi9llAEtlIQFfHNb05BLq+B1Nz6uA8fi9DHZiww==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17436186c88.35.1764318798796;
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:18 -0800 (PST)
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
Subject: [PATCH v2 08/12] block: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:15 +0800
Message-Id: <20251128083219.2332407-9-zhangshida@kylinos.cn>
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
 fs/squashfs/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index a05e3793f93..5818e473255 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -126,8 +126,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 			if (bio) {
 				bio_trim(bio, start_idx * PAGE_SECTORS,
 					 (end_idx - start_idx) * PAGE_SECTORS);
-				bio_chain(bio, new);
-				submit_bio(bio);
+				bio_chain_and_submit(bio, new);
 			}
 
 			bio = new;
-- 
2.34.1

