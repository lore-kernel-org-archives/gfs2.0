Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BD33B6FA
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713094; cv=none; b=jcwrwfbc2qawdI5BawbJT4Snw5piPe+cVZwRA/6vGw6kU/q1UcsQMXCsvrAJOXinpvdJp4j2Hq4SRv4XR/vSiHlRxiQBa/XdWEw0UD+6vO+pYg5l6/VqeJhUxunHuKHMOJsNax5uzdcJ/8/yrKl41nAwMXvKl1kCeHHxYRM7tRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713094; c=relaxed/simple;
	bh=+7tflVaH8x7L3VJvig23+lCVNVSwvcR4NvQ6QZjXrp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4HU4DQOOipBg4Gt9wyX4Wl7TEoJ+czUegfifJ1Vu1x99rxsKhGsPtm4LlquR4yWXfEKdNNDAr8X1fbVeXn3H1zcU6jl4GuK4hUnOPtb+s3XyhbrS3ju+kr38QEDHdWH5gdM4SApArawcHXO1GF8wQyh6hIaxqdXe9S1CTv6NgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVRCLXZk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVRCLXZk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1962570b3a.3
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713089; x=1764317889; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=eVRCLXZkSwgPPjKI3iy1yR8NQJeSEzSkjRJjLCFG1By7Y6Q0vU6tDNA+jeGvLAlq/I
         rhExDE4kCa/F8dg1GWw3CmDvenmMqk1Sh9FjYHQA93G1n8p7Qo+iZCLtV/9Gkpn9XISF
         oncMH2984k75cw+pBqW7oTObmZ7ijjIfFJbqMXSteNuT0YZ7QWKGbFh3WjUzxI3Aigw2
         yTDatYN2WPeZuKpJFEwFAS2wWy6RZHRaieN5AOYOKtRekg+Vdu9LIipErNooq/gGsr4t
         gLUhvRdYkzo5/c+5gbKB2pIcgAj7dxvdVRYnbYDBncB7qGENS4NHGGjJX4N1f/RI8850
         OBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713089; x=1764317889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsO4Hd5ROz+D0bqFKvcezOn2Jkcskeai3TxWpcHV0vk=;
        b=Ucyl8Gjlp9lGw/nrouRALs52CLyZlB95bk8lWru52gOZGv8C54zPXkVWANw+EjdTeM
         cAOslTLAm1tdUj2lr/1ElRVdWUEoqA6uSTns6zfFxIVlVaaJvXk/tHQ+4GMg8mPziCIy
         J8PrS1ihX8iQ3imfnphBB8gpbVBIY87xGL/TtScqyG1o7C9FO8cq2V+2ZSzqdnL4Irce
         OBLEkasBd9FJUKG0ITNg5GOmE5r95LYJgmho1LMOkXfK3NSjDQEV+2rloD9RvA4+XhOS
         fH9mM9Gi733Coudir6VN4sNjqXbH6v2WsADmcw0O7HTacJufR+S6FwrnrfDe8fsiYu1n
         uIAw==
X-Forwarded-Encrypted: i=1; AJvYcCWANniP1D9IXZXHf3fYLnLy/aAdccNbLaVVPzYyXBxnLS3/1kXD29tXNtfBxFibWPWjBNmV@lists.linux.dev
X-Gm-Message-State: AOJu0YxQYLKo06Cvs687UYALrgq3JkkGE+yuNQ4Cu2/fPvqbeewllw+r
	kSsuOQzVuLIL/1pUb205UL3h4dXEQKlw0j7jrs+CFNiFCE6gufWPzz34EH4YYnAvWbs=
X-Gm-Gg: ASbGncugARNCAnf7PGyNMMXHj4vIYumgCFgTs/ZOh6tDuzvDf50+YEOPyVRP3YVCGMH
	Uxri+PO/pcthQHt4/6SIWUIByV1maKIU1nQGPTrGQB6kWyx/u6RYymFCJP4+P3fA0uoHpFoU4nC
	XlghIuITQaWS41aInQ8nH6ii6EegrQaVz2qntGoQehYvoIVmHiDCfBXwBI+ZTfFF1FqTWyI/EKB
	rySKfJ0nwLLzmmz+HASVKAmNMofRuwXFQ/CzYCSIWZlwM5W2yYcZETgoZtCOqSyNhTJDc4mRHPe
	IzDvBYssWalzyk7MAWmvQWIRihuBIGr/pnV71TMFZH5YKanyyE6desMxjnoX4mPtgq0GdPQBmBD
	SLCch/jvlfkTj3RwsENfjIbwiAK67zkJAf0uLxaqx+1987cQgbSYdFX8MbkQX5s61xh6Khi0/Vf
	64mZvs8wwl5WwE1hGb6xun1OaD4Q==
X-Google-Smtp-Source: AGHT+IFqeRBYEjCaG+tIpPdWA+qVKSXVzOiqtjGknDBSdNDUFTnY7ogPNjlccPCj95LHEh6lRlusYg==
X-Received: by 2002:a05:7022:6b97:b0:119:e569:fb9b with SMTP id a92af1059eb24-11c9d708d34mr570234c88.10.1763713089300;
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:09 -0800 (PST)
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
Subject: [PATCH 1/9] block: fix data loss and stale date exposure problems during append write
Date: Fri, 21 Nov 2025 16:17:40 +0800
Message-Id: <20251121081748.1443507-2-zhangshida@kylinos.cn>
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
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1

