Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109622F747B
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318785; cv=none; b=Bb86G6zCYZ6PbCnnrBSLNsS41jT4HoXrvSft8GwtwYvn6x3ebUFkA8CQwgOE/TJY3MzaWA1oj0Iqj7fTVeK+Rm5dzoYlxg1JF5ZIBa7SKLSVk5IJ9BIEexZSLTE52gxO56kb4wGnX0SzbKirebQXOFeMCFauiuq1LyoAyovRyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318785; c=relaxed/simple;
	bh=+kdxszjTpaHcpdO+OsTg3+9Bb8a87RQlO+SGH8oGptU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0/nWypD9PwrMbQFqfcE5QGZ5+EHQzc9khlczyxGQpdjRXZmURjzQnM0z24+e/TdoGK82BvF6S8JLc9EEP5hD7mbIFfYRQEtAfeZoW+Jz7SAdtOuBY6/Z/k2qOFIUE4REpudtrwLFQxqKizvNc2nY2h3Tl6K0X1ImvZZus6ys0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqG4gacU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqG4gacU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ade456b6abso1303549b3a.3
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318783; x=1764923583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=XqG4gacU9SZIdL3nRR+pIDFwdfQAQYW26WeggPlmgHk91pUMHvWR1y5CsH+rPw8UeB
         cL1Nsf9IDY/mUKAvyJmVzT/UcMj4Faxcv/YQRAr4lGt3cmy5QNFF/CAtURb4WZ/Jav21
         rxnEtlNu3UXu89Kr02dKhykQp6/02H3LV9XOsDV+eFMR1lalfO5gimckJ7/NAzfCVcQS
         PpdTS73u/VC/tNzY0Irygas+BUZt/fBRuGod0AEkE8ZKifZMBTCIcg/PbHyRiCz4r1iH
         ezC+0zlovmt1GYTFv4oQkTTHIazidHbKomV8yeFh4geRr75kKqmKOuzom4A2r+i9KyZM
         PImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318783; x=1764923583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=viGvjEMGyzfeS39Ed9ENc3zDyWUaHfkRk88RMQ/Bj/NQ2g/z87Uz3435DS78HWT393
         J+C6W861G3Vw+hXIby0HGG/ioEZg8RO/FlyVgIXu67CVV4HzJiCpcw+Vm9gkTjWazFId
         MzZX8pCX1UViTzZyhufcUZ0vQ9dsflfTdzPNbwSjzB+u98KxirMWSGhxqWN69+Fk37i2
         JNQS7HElUYVMAf5zSJZWP0C/aWh5Mm+wU0J846TnMoRMyR4kMHfOdn7wVWwWNqHFErVl
         iDFJyrhMgxQOTVrFFwzz/iHYvqv1gSCMBf5ISkQPe3J74U6lXfQS5Av799rJV6PyCR1n
         X7pg==
X-Forwarded-Encrypted: i=1; AJvYcCXs2HLkbwXJbLkJpMVeG3tAkcO61+/AZJO8/2bhCgk58hbS5vryn/20jGcu1wMq/EAhXj9/@lists.linux.dev
X-Gm-Message-State: AOJu0YxDKTLtzgfKroBlUv2SbOuWatp7sXzTe2KDKxDWRTo2Ik4s/DmU
	x/wOyhmczPkWtRGcgC9u/BX60/PEQcQfJeh/rggPaZlxhGkPe3IXWUSu
X-Gm-Gg: ASbGncuZYguZH0MxXdn4avv9vAqkD9vcWuSiQ8Emials2H0kPt+AUhiiIRtfS6rOWiH
	USIKPS94uHdxgyOfrjjTr3xagNqRgu9lh8E3WF3zHtki1Sd7Aj621Z4rF9JL2GlrHheovVTZ8Jw
	FJuNT+sWoft4jQXqd7lr6HsElShBVYDBo9y8I2HX6GFZRe7Nfo8gUQdVHYp1GT5oTeufMxFr9Fh
	fav2HR3+TrqIzsephl+O1EoLC4p+GiJCEJtKrxZy/YEoeSCi8eauvmuyeFHis22ylqnPKLpHT+f
	IEbjKAztIdKkJXwb3dgMfLKZ4dcFCec65a1fN4MlMCOv7zPv65eJapgaQjyVsoKT9tlGtDtHlYc
	BEEKLQ5Y1SeFRVhptf8A9qFb6VtdGGAQSIWW1fe9BgqN38yRu8tqH5c69nd2HxDXyI5GabzOLhx
	senXpbrlcy9Xj/99IEeMyvFlqx+A==
X-Google-Smtp-Source: AGHT+IG9KZ7rWCO0ABhUceCtzlD+O/EyLZjlRlvHPaAHNjz6G3IYpmLI91Aw7ItyMwREv8ZXa06T1A==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17435747c88.35.1764318783005;
        Fri, 28 Nov 2025 00:33:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:02 -0800 (PST)
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
Subject: [PATCH v2 05/12] block: export bio_chain_and_submit
Date: Fri, 28 Nov 2025 16:32:12 +0800
Message-Id: <20251128083219.2332407-6-zhangshida@kylinos.cn>
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

Export the bio_chain_and_submit function to make it available as a
common utility. This will allow replacing repetitive bio chaining
patterns found in multiple locations throughout the codebase.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 2473a2c0d2f..6102e2577cb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -371,6 +371,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

