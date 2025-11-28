Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59F2F12D4
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318780; cv=none; b=TgBRGX69fcjJCNl0UjAoNiMLDepbqyKP8+WFtoqZnIsWrn0S0xvark68gOcmxlItkVSSI1y4DB91X1AAKhygycM+0T/Ak79q6WbY5puo4t43VptNIEcIxOwLinKyoGzfNa4zLpZzs3kZ+AUotjY7B+pL2j+TNt/tL5qIUi90Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318780; c=relaxed/simple;
	bh=XfGf+/4TH9UT7Q+DEbtJ2829MlGgMcgOkxUS/OB2JNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpyR6jPqsVvRxIG9qeVNKO35anLhhnSR3lNca7V8B0tlBjYyr/hTFvABwzs6t+hSvXCGxA/Yxg2Vg26ntS74Vmp8xvRkr5RQkXXB0OuX9OeY/QQMo2Mseod6/B6f8LYVsblvm3HnOdq7dy3r1HYu7Njqe1gdhdwpdTNM+SZH9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYLy3d6l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYLy3d6l"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so1097799b3a.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318778; x=1764923578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=AYLy3d6l8pqS9y3rV+T50YmF3ZamtXqnYS68ZgS3dl0vYkV/CGZa4/lLxEI03UkEI4
         1vfV8VEkShbVDBjLcc/zqPqzZchkVqVJF0AfPlosBWpYxvA183NsvMV/aMc8Tojv0bGE
         LvAP2qTNnqkCXP3LreqEty63ALemME0sNFZzUW1rdb6S5ukvjxPf6qIDB155lxsozTDR
         BxmLo05a74H4OtJ1gz7k0IFvKOXuJVIo+flLwWMxIBvckk6AB7X1bmkPYwPBwviZgfTH
         yzBCtuHbBiadaNzPk/FyZXXSHlznsoa6hyTAhoUnkq/ZEmaY3gymtfSq6aWW6ZJeNRiC
         HD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318778; x=1764923578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=eC/HGDaHGcGcpJTrCnt9ha+rWzNnHtK+uFr9wym2uZfwmus8Z+YlZ57LFyn9IpMARF
         ZlcIMFjCP/eXNJ9a7NeVn/yoNdzYILTIsJ5QTrzBh+MwtXvit+smkR/kB47dZOEopULd
         0+0ASgkuNe/WQIHyrElOcbyJ6pEd54y+j86KmDqiIFwxTTpzjfSaGKaggjJE2dEZuObu
         nqB4PVj9nQ45y7fqe9G+xcr+EfEl32k9n8mpAAHsupRPJ4/3c0QbBD/9duKUYKQhAUi3
         Knu8z2iYfbDNMbXtc556UqVe1jjzUW6EjJrFHSnnTgI9bk74afSp09FWS22d6Abs7Tew
         uTUw==
X-Forwarded-Encrypted: i=1; AJvYcCUumEGliWHRZQqEFK62WmKfzM+fPllqrOcewEeCNGR6T8MXWUu8ebtLRcRsuGlQ+wRCSpcb@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/kMeTGl8Zjow6mi1pQfKzmm9PGgkRnnDvWgTxp/IMN6Nv8CHt
	BiR2ckQyd6sRqhinfVcC+jp0i1AvWCO5sTFsHX5XnttqIfWJd9972NFR
X-Gm-Gg: ASbGncvA9wXfYHHKJ3hETAuhoBwJlZXFmnfsRRM7+PPKAd+Zkm8z6czf77P1V1mAHrG
	utHXMlytvvksGwPInXpVto3POKRhB8vyO0L5kOyfL1asFr+ls/bjmqfbIkABiKyVs7p/khENWAM
	f0nmUserIWpYb8KLnB2Esq5JrFfLa7wF6bwbwfRo2gH0A1tW6fbRuh+5/AnQRgs3pjuM6AyXHZ+
	kExCIj+TDxUvii557VvxvGPEyS8IiBBnjBfJWC53uN/oIX0cSonnJayRgJjpOc3nRCrnzkrWEgf
	KhiHI1oEENUXYU1id8pbnyQieMvjmtOI7rvIlad4hxnAhjBuw43ZwSNHjRVznFLfcbZxkqVcuK9
	GNeSAvMhvm+TAHc6vJv9WMVaCBbh24l3qIHyPsrcpWhxJdMMeRSjgNdvX6c7CNE9RJ4omImXbvS
	9mNxUgFdA3qsE2HkhGTe1dZ18U8g==
X-Google-Smtp-Source: AGHT+IHuO0sAEeNowy1+oe3IeEgaIYQcRN0FMbygDOiWMPQmdT1sBtyBJY7y0vyzVSrhuxE7eNWdhQ==
X-Received: by 2002:a05:7022:5f0c:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-11c9d8539f7mr12036129c88.26.1764318777892;
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
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
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:11 +0800
Message-Id: <20251128083219.2332407-5-zhangshida@kylinos.cn>
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

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index aa43435c15f..2473a2c0d2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
+	BUG_ON(1);
 	bio_endio(bio);
 }
 
-- 
2.34.1

