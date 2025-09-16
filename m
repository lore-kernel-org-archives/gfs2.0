Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0892F39DA
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066648; cv=none; b=hT3qlQiBctXD5p+gr45imn3+3Cy3xIqzuBfPgIrn1+2YH4hb0ZIUtVjG+2l78Mj2isXMdIggtgSU6VqKqT7WYF7Orfs+HptXRR6AQBxXLJ/vNjxMWBWH7jKxK43fMse2yP//lgYgv5IDYjNJp8aenFD0dDRb1Zd9XzhYxXSrsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066648; c=relaxed/simple;
	bh=WvDk48cCQDjmhEgUA3H/dzeLiBWsntQn2o/liLF6Xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAjEwNehcSCA5002syJs87zq4+/F/gF7l/azwWypd2yc2cts75aSbMuwmkxKXu20diTiURxe6tGzG4ZHUjxwPaW5V1RwPScUvMmpvWnXyWKu4BpLORcES7GXcg/wZ7Vxrit79r0Hz3ntreTTsVm5Iqh3E4zpU9xoVWDxI3hVqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4zmu+cf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4zmu+cf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77287fb79d3so4628454b3a.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066645; x=1758671445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=F4zmu+cfupDDqQB8Y7c13ieXIrTkYFZPnBG4tMm5raEu1mPXJ18uMqRI3OYcaMUrUY
         KKcw7RU4DwiscyXbVSgl5Fy51ZJTdjhJHkg+Y/qC2p2ckWNaP1Xt0V8f3L6tTKxh2e2S
         wH0dmA4lNRThnMUxCJaxdzBn8Z7oXG1/ARZz1F9nmC6pHYqkJr4umgmMH5rEngk/eKzZ
         m5pxuGoRnicj8e3DewUN3kVkGd3w7kfvZb5iDYGRrDz+n5stt1ei0Y5EdfTnpt+K+rl/
         kUG7jpmlxrqprhZhf+YmN3IjXEYJXiZrN3WeM1O4AtrRNqnmM67NmIoXryUrIZqlTt7L
         /boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066645; x=1758671445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=RYU3okIroEpGwMU+h2u+k+LaJ0pN3rVcLdbAGOgORyP14d5CQJ+9t2i4oJ64HnwQd5
         e2108Yso6eGnWmNB4I98isMsEsYUfwkwcaTaZacRt/EbvFaIOq0WHwNRzJiyuHVwOT35
         a16fjSJjVWZ6FBwjgxze2h/P3LrxRrGmHTRuhFg8w+3aBMV0L0OK5CsBKSVyI6BfayyQ
         PZoCEG4G5uaNwlcPupLJ6PE4YSAIYNeuhQyhG+sYaOv6P2DH4ULfmnsnMadLg4wMuGVc
         Z/CsjvENX8bjhMb8iZJbZSqHgfbz85EoDUUPn+wHD7i40qV4nrDTNGZf6qHcZvv1qmwi
         2sZw==
X-Forwarded-Encrypted: i=1; AJvYcCU6x+PRq8ZWamXc0jJKhxYMCygal6g2g3Dhuot7u4dlUunvHVcnmYYu1IL29koV44tX/8if@lists.linux.dev
X-Gm-Message-State: AOJu0Ywec1aZsqo1dbwd2JimiehUr75YAX6ZvpvJyUBkx+tm4zyl2+Xf
	zn+TNz4JeDScdPxmN8KxAb8m9YzgHnh46l8F5h7DnSLXi0IWnjqPI762
X-Gm-Gg: ASbGnctzJP4bMENx+4pwt3u5zAjof6oYGdlsDed86ta0VZ1goNv+2pGbzwTUJUQb9uO
	lQJEnZvJ/nLRH/4MOYR+hFXQcqRrZ9tIDHxmLferNs4oitnzXuGac/qAZXCZIcOoAI0T9ZFSV1I
	lsHlziq4vX6JaNUDavY9+XiQxEZCSyBTvmHCFptZGdILQQtyszPEQzdzHk/Yy4JUgT22GsvuX2S
	2PvNP+7GeSU28QWbzJ9QlmtSlsYTxJHd//blgjtDk0PlI4wEIKIldHfVQzzZ72T5D5H6i2wv+WA
	CiqE8hHoEM/BVXVoSLnlmDFQ2fw13KwFhN12f9QD27nVjhSFKHXQPNWHok0jN+ZFFGrTLN/Rx93
	4o3a5ZLk86pKkyYUIIBoci539eydtIpYSmX5nrEfuL3rgKfiFig==
X-Google-Smtp-Source: AGHT+IHkRlLnCp0WU1FUde2gi6s/vcnbEIKk0ErpbS8ixCYe3+7N5XMnBohfRkdqaL85QNvZmgrsuQ==
X-Received: by 2002:a05:6a20:7d9c:b0:262:5689:b2b1 with SMTP id adf61e73a8af0-27a938d847dmr96465637.14.1758066645351;
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b331e4sm17001334b3a.70.2025.09.16.16.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
Date: Tue, 16 Sep 2025 16:44:22 -0700
Message-ID: <20250916234425.1274735-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72258b0109ec..be535bd3aeca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return ret;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -477,13 +477,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	if (!cur_folio_owned)
 		folio_unlock(folio);
-
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4a168ebb40f5..fa55ec611fff 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -340,7 +340,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
-- 
2.47.3

