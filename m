Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF852ED848
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318776; cv=none; b=NBiR8YUwwo7x165NS7UXiT/c7tOvH4pfzwssSOXJdTUiBeGS3Mz218Qf9JHd73rWq+lXH36i0VYHxzjre7DDjcvVnajK3jtkliHFtwwE2MO8qHAU3iKqa3IGDg42RvvAUf9hbRnJaNtlKCTUknz0tQqbqjWwD/g+lOQJHyLl+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318776; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hdblm6XZNwx1+fXXiRVWeDXbtfWNjrSNWb5HckTM6edy60RaBHBGw54zuunZMfa338pXNihYzCn6aJqf881cbrnnDFAfuLOGHMM3iNh9df5giZd0tHlZsuuVn/ZM71Qpl9U7AZgV7pGx1RBEl2+OeKd/UF19PeU9yD7JBCmQdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAEv0oMo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAEv0oMo"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1933833b3a.3
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318773; x=1764923573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=XAEv0oMoJmnvz7yAy/Yz/2uSLB9ZsoFumWWf6ZscqUjoyFlhf6oe55pLKaCc+oOi2C
         XouMwdq5ijyOFM3ZanhxvJag7hwMrJwAM7RAfrgrtBN5NmLlTdlW1BBLy9K3x4wGKF58
         nByiKYJAIZ7/S1TD447VQSkDMtrU7PT189dd03P84QfJxs5irWBdSRVQx0tMLimsftt4
         7GlixMqk2PeJ3xNJCx3K9sAKFXCCvNeT8XQb+yuCwFHFQGaKp1RplXOuX6od0nzducGK
         hdQcPXpMyeGSBIxG0YLC95SZn5YYEtedJlwjD3p41i6CfmTcsPglJDbO21AWTOXHnLna
         Olng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318773; x=1764923573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=YiABvKzhTqWS2Oi4Xnqtd5ViKTJJHw1nbs6cZ4boh59BNxJB08Yk0zEiEUf5fBfG+e
         JiO8DU/wAEyGrZ98R+C8BOPGouQ8oy/q5ll9t8F+byhMb/TqaJM/1qoXK9PzHcDkJPwP
         ZH8Pxk8Ri9mDQKIvaLmXAHr6EluguszIz1S4jIuU9+piVA8kwW3QKzTv3a5uMgMjTOtc
         zAj+wObIVgz/ypxcU8QveVcqbAlyuZzDYKH541qXjWcWo7YMaG8dk2Y/tBihZb1Tl9co
         T5QBrvTxBv8+syE3xt8+l3+AZNMt6K/Pxv9lM6Op7tOlm+yJt02hBdB87DNOO4IygiDZ
         GhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDkipppkKSUoU7nfnFopTSqcEuwFvr6eono19eXVC8mVuFBIoYEoyN60FyuGurG1tEbrR@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9Rixgl+tarh5n8W0Uqd1A6ygdxzmzNPd8RCaEjA3vYM6JxfNT
	0NfEcqTDv6bbKdQt68t9mXiG5fW2Wy+B8L7gPXQk1HUg9p1XO/N+hsfq
X-Gm-Gg: ASbGncuyABrSnAxVmlvX24b/t8PbkaNHNkDxx0rdJX9Z+z4t8ykkJBDfmORaYHgyRE5
	NClUvvQsbPzf2Qkya7/aWxmgs3kdAmQ+pu2ufimbRgSGhdOU+fVWq4Hm/ZrHEUbh5cdjNmU5ljf
	Ffrf+hywQseDKq6ShfWOZOg7Gn8Dj8S/sbEZ4c6UjG2UaOvwXHn4lfr+ul7e65IMRl5JR9qe18I
	QQ6qRy/jEtjrrj4CtcANG8JFjd0Rn7fOMi4aN4niq4mRg6aJpcLug8t56vEVAm4QuWfNGWDpUHj
	K2TxMO3WWUeXSp9cyWxXO0NgKPzfA9ZFc4as9NBJDmNpGzRrhcfvR3iKZIgu9lE6+h01K2rdFFq
	B1wPhkRE1oE89PZRSMEZUfEN/eFtCqi/fOgQPh3QU8kcMyGzxr7Y4NST+DLfXR+X6V0tl/foBON
	FUscprh2FcG1Xlz66FM9kVn5z/hA==
X-Google-Smtp-Source: AGHT+IExpRIXm/rx9JSaduyyoo433z0edlCZgYRCixn+2l+uiE9AooEQRv+QW8QlPPxN5lYcC0yJLw==
X-Received: by 2002:a05:7022:2390:b0:11b:2de8:6271 with SMTP id a92af1059eb24-11c9d8635bcmr22508225c88.39.1764318773026;
        Fri, 28 Nov 2025 00:32:53 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:52 -0800 (PST)
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
Subject: [PATCH v2 03/12] md: bcache: fix improper use of bi_end_io
Date: Fri, 28 Nov 2025 16:32:10 +0800
Message-Id: <20251128083219.2332407-4-zhangshida@kylinos.cn>
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

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1

