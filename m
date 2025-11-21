Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83697257848
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713098; cv=none; b=R0MSf7AJJeVPk/OD++rJsoBWfHiuZdIa2gW/+qtCSsEdm0bPZrQFPBuN80sGJXZfJN+EwhEBcGZDw0x/MrS95l8PpbuMeEBbtN5cSSfg0jzMDTa99Npkm+/4VtUi92yz24CeFE/DY+E/0z9MXoR3AadM6I48wBP1KaFHjX+LryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713098; c=relaxed/simple;
	bh=/P1RYgORKxwE9EU9V7IqZbnP/9QJ+9L8NguSmQu/jJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSbL/9j4Qfbldy+WPXUAJDaNbdSEUUa4U8uhP4yDwDtEus/LPmYPKVIUmPQ18w1183UjJXM3860t9UWtdJ7ybuUpj+QrNyq6m4HNnhEWDMpswU2Z9li6zE+YupsWXhug6Owzzf1dz5/F8+OfAGyX6yyYr5av2jLtj7C8VNA3ADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux4cdNZh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux4cdNZh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1367562b3a.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713092; x=1764317892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=Ux4cdNZhOIRxJHlRCny6td3/DzWatVslk3asCxXsD2aD6hdz59p8GjJP23zVwuMilf
         N3ga6/vIFhOb5/IW8NXv4qgP8wl694CafA+Mi4pOM6dhEp9p8SCrrukojIykaIo7ZKva
         uuFN+9KU9ithdxb7YuL1ajag6EWwRkqkexOpmridCxuP+6CIBSl7Tg6IrEkMslZj/2Hq
         19mgbnDYrCSFi3W7+U7vBkVUziM0fRiKR/TK7V2hRvOlJAZLsMIXwu8LAZThNrpawnUS
         AwR3d1PvjaTw9G6y+ljlYiv6h5BgvtRv355eaNCeL2EQSpHZMaTFKS7hNw98rfWqKVC1
         B74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713092; x=1764317892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=G/dTjBUZKWelVKKBG2lyj8SVbLakmhNMDJoTac8DBERkgvIO/pzl+k7Qwfdg/LS/wZ
         rZL1H81T2odwsL+FSnzLtmy/kH5qiMS0ehuFnmwgq3BBtrzYSebO+ubz4KBcNIzTD0V/
         XzIOrWJsJFELiNAwIPwJ6ndqlnn/wOmC6D0cvm36rBaT2do7jSgFOZJrZn2sRwzZtSjb
         8DE22nWqndFQp5HCcMJazbx4tV7FI4043XtpqJQPzkGMZrr7ZpnO2T9UjuGkAYnVVsvL
         oN3leKmVs/mJhm+cS1NyslLKAJQMDK5Hkza1ctlkd8w0TgSFWxPPENVMBCSzg0ZdElkD
         F8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYqjNHmB30l1uow0+VAjduNKg0FEHGPBjUL78/J9wATVX5cFmR0faZVj/ERdl+DXMCbcAR@lists.linux.dev
X-Gm-Message-State: AOJu0YyuQlR0YXWZROv0TdeUASVZ1p1ZhNSQ9EFnL/cx3v6Gv8CV5VTp
	QnkcVZA2ofgONE96iSn+Op8ysFaVLTN9OmTKxUQcgnk/+e/E4+X2K0ec
X-Gm-Gg: ASbGnctqMq71MHgH/PvXvRVjjgU6LHCvvmZXp84LXYcN4Y027+ZoD3s/3LEfiKOh5Vn
	LvkXTti4llygtkU45ABhhiPLIVAS4CJVMJM1mS49UeHUz/RRdGWwquuHzmo2j6opY8EXg+UWVHR
	k9uQJNEbvEnv3ezc4XUiKdNBQ3ncLVwBy5nQIhKZRr/BpHq5kFP/jNE4iKMuSwaV77sbdHxRA/i
	VkLHHG+rFFUTMgDF14uniw6OlGcBCdoJm2osTePw/iCo0Wp3T9/H0n7+yXZPDB0pWVTunOU4HTD
	fu3hLEgTKOkbr1tVDAg9IU9zXD7X0DDJ998O71fLpB81vtfw0NyfHiz1Da6iNFdFlIvnZP7ogWV
	amMDeS8W9aY+k/cEj1jbHWgpbwMbJu80Csno4PfetoIWLu3tUm9I71MScmU34usu+BfqETGkp13
	3+7x1Buj1Ge2cVrBiE85Tbz5zgDg==
X-Google-Smtp-Source: AGHT+IENbSLlagXc9NX/smNIF96UgKjh9NXUi+KBRvhy18+CUMO6BxslQvGRE/2mRUDvnGhRtmvCRg==
X-Received: by 2002:a05:7022:ba1:b0:11b:b3a1:713c with SMTP id a92af1059eb24-11c9d60d20cmr498283c88.9.1763713092239;
        Fri, 21 Nov 2025 00:18:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:11 -0800 (PST)
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
Subject: [PATCH 2/9] block: export bio_chain_and_submit
Date: Fri, 21 Nov 2025 16:17:41 +0800
Message-Id: <20251121081748.1443507-3-zhangshida@kylinos.cn>
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
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..a6912aa8d69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

