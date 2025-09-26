Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6115ADB4
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846575; cv=none; b=EuAkRbA7gNIzRkf0/BjHcc0QNZSgJoOdjC5FUDehXUeCkfPhrV8nhd+IUoqFdtEnainZL5nE/9o/PHgE0/QgBtkylKE1E5iuk7lvf24EMWXeGu3BgK3kgBqMsxUFlc1KcvUL0X4SErrVlQyzcWE/GLAjnA7nnXpyf/sgqviymNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846575; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwV0gwzOQl3PfUGJdv645Ga+WMgNIWpyDTzhFO9UrNmWl/x1IyutmMW1/x1ODVJCMYkQ0x8+dTJ5zZXhSDboyzedFGZgSj4S9h2E+UqPF8PaIXzrpDnwuLUjdk/0Olj+BRzzN26yoik46ceXY0nEBU/fDpjHRxHwVf1n/T3g2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaOTCk1w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaOTCk1w"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-273a0aeed57so32233525ad.1
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846573; x=1759451373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=LaOTCk1wCZfzaT2PXrnibL2meS5hjxWSVXb3ch6ynKTxAjUzbyXnZOmeu4isj6OTnd
         q7Cl8Xops0nKboDhSxMjttXicc0NyhJy4pSLX8cCNdYd20Zz6KED8kwUgawuwYJGyy3N
         TE1Kwfl4ssXjbA1iFm/G49bWjeLRfOwZjSuiRmECPT2vzTOTtGikBM3OhLQM0RqFY57D
         szoSdlxcAZ7YV4gJehop54Y+rMokZ6bez+yJbibvQ8Y2XhoiKfu+mlbynZZlEjHm2o4T
         Mq59oqx+Qex1MFsCvAz9LA5TE09yHFf1YAM1Bfd2B/m4mC1iczd+VxHVgxP+tlOEHeQ4
         d4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846573; x=1759451373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=ZhGxq3ea7084vRxxbUn6aNn8ih1CSAuYvEitVfX80foZegup/c1hNl3PcJME4K9skx
         KPUpj5FxfSjZk22f5w5wGZGds7OatDC80RBZM2P3l1JyeqsbBTHYAKKKIpn10jEmpEOq
         0u9gQOb4osxJ5ZIVHn0Q0ut+ggpUNs3pv42RwreMF7q1gAZTUGgWbkYl2R+bK1QpXznX
         I/Qf+q6YWuupkj4y51SgrBtYawIrU273q4o3iICdY9DY6K/ljDhWi13QF+iVg7v/TR4m
         y5WM6QOLNcMvfVF3L9/Nt0YMBCzicivqygbtMJ+z8YMzHz2z5SIaWiLhYxMYnoKVCz0X
         sqHg==
X-Forwarded-Encrypted: i=1; AJvYcCUDqnPXk9R0npNdXGc/XaSJODjtXbBTL+4Gt0y1anrAUbPkiuThpIJmBIMTeoeL/OCSghL9@lists.linux.dev
X-Gm-Message-State: AOJu0YwGJ1tPjZg0cbsnE6cr+L15hwcRgwPTddxNapKDWFYbJ//A8gfd
	fw1PYLuCAMFcCdJsyM0CeOoSx05v+PcjO5tr1QuKT7kfiuXkGfwqbI1+
X-Gm-Gg: ASbGncvvsLhDMx74lIXrlXWVo0BeSF5vr5ZLXNVdYmLEUkiRIL7oUAAdY+pSqxmCQV3
	9eAHx1HlGtxIqDlZGVB9ywNMZgr9WWX9gQG8zI2NSQKvge97XDmYtzh9BEVhmkX1kh7KFw0b6VC
	z8bqxmaadRXXzvO27JpUe9xer018Wyhgj0qhxzaCHqtRECI8+CdQIIgOKY7TrZCnkrNAWLENiuS
	8PsEgOI5ZGNHbtt8OyZjKexkInCsajzscbQfb094lPXgxzkIcKnuXcTJjJRsTDtQCiOTwDHDzi/
	rB6me6tsfy/HHIreKWR0xdLIU9IdkYRwXH/mspUwfCZqz/FrO/4WL1cO5Nwhja58zpP/cXylEnt
	NZ/LQSzX1t/1E3lA/xtl4x46GjdVXQP0ugrRADOXJVn18kuZo
X-Google-Smtp-Source: AGHT+IEHIVx4kLA4F6aUCgGEHZ0YDmnSl35bmhbet6WjaurCHoQfC42jLR71Pq42gzogAiSpCmWQBg==
X-Received: by 2002:a17:902:db0e:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-27ed722bb32mr50893315ad.16.1758846573101;
        Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm36470675ad.141.2025.09.25.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/14] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Thu, 25 Sep 2025 17:26:00 -0700
Message-ID: <20250926002609.1302233-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

