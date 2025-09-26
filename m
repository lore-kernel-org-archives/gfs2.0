Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE81494A8
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846584; cv=none; b=S6EyQG00OjRP88NMkUhyJDqpBsebQBNIcEwxD8KyCS+SZXZrzxNL8dz35YUrTIpGEZycahNs2O+tI8MYnoKBFVZzZIi9+1Z/z21GyoVEQcYs6EAiB5DRA/hPM+Cr5X7fr5fbKCWcW4ohRs2EpSAEbafkh3YhFE0zLoU85qaip3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846584; c=relaxed/simple;
	bh=ZJKn2aUxwVXrXo21+pZx6cBCh+fmZr2QcyaMhglPP5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndcu3igdskVDu2MMQnHMfCzsLqa3OGxIHm4bUmIkLT3sxX4x0zi0B+rbNUfU+GGGzY5gjsmHmAKD3k1AwvpDMlcmg5z7QdaiWzHdTqiJzRSKCc1NlAZlOz9rBWQnxp+FUnogAqjoHDF2O6jGe/mRQAVXphU8iG7V6Qn0a3J31Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG86yLsG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG86yLsG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d69771e3eso13616345ad.3
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846582; x=1759451382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfpa58E21gi9e/RAKTk39wwAnWAES7lJ4fXxRAP7/fA=;
        b=IG86yLsGYKK52W8mYl0SEKiPg8i5aAfvv85TLd5QiPD7earF8pfeAp7uj+q3JiMQpK
         apKT5PLys0Spk0kjA7gRORWWSkk8bMrBGDA1/c1Kzfvkfe/dV+CYk+HhrFhp2Ueim0x+
         fuk+e5XYOOqJ+3cHN6lcLdEtJnlxwDZRmDJiCbkJKv7bjYPCMKy6LvNfr9kyglPBlLoz
         7XuiJ/AMG2DTGGCNSnRFcVOFGbpT2BBBjzp5KwrudfpWCn760SSM6Czq4P0F9W3NKvaK
         LKLA4xgBxR1ul1R6xQ+pgXBBlmyDkeZm5YpB0MHdt9D70c4a4HoYGZWP9C/EIOKYyqpU
         8TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846582; x=1759451382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfpa58E21gi9e/RAKTk39wwAnWAES7lJ4fXxRAP7/fA=;
        b=V1OUfcpbKgPHAheu12xGv/BxnEyjul+MHEesstWT+ploNLKyHDq027ckgzMNAQSVJZ
         wTKrVT6iUS95udSidPmFs0hbJe2l2BNla8P3xtip8295IMB5u8IGew179JrRYr3s1wQC
         q9orT4wLKLTKc+XAp7wWCwh26RQkuaq3lH+yYCl2qcXGCGgjy1SSgKWAi4Vd2AAN9ZRR
         DsLEfBSMxggcXcuQgqGHKp+2+xzPxS+04uIjyDMR5tv9kW4gfja+mcQuPhHLPY4GFbXY
         o1eCdIMqBtQp3YN21qml7866ec7+JhbnUwKDkiF4se2naC7ZgSAzdfdM1hYyRB3rHpwh
         sSew==
X-Forwarded-Encrypted: i=1; AJvYcCXNtrjDamPPz1Uq8r+bZT3pYSskrQUvlA/YxlQeGcHs+CwTvnzT2RAGMoYKbJORnoPJvX/t@lists.linux.dev
X-Gm-Message-State: AOJu0YwFM597gL+QR/Yu51vUhHi5x8AoNsvDmFNuieh3bWuXi181p8V8
	L8/fKDSc5PAmLR9a2v0WlMIuyusMjAK3gXBcn43h+a3+mYcu0lPhHnCW
X-Gm-Gg: ASbGnctPzq/uDJtSU1yDuHxhV9cBL5tdTw3inbyEmUdNbqjHXEafs3tjZtxPAzJJYWS
	L1gMT1x0aQAHkjRsvWR2hLvggHhE3v3PH9wMlwzR8lSlZFgFfcpnQD45EEHtvCiCkksE8jXuVJ5
	qnERB+9SCIoSbqe8M/5CmN50CS6XY+Gy/g5+S/m/QGkklXRhW9aJPIZW5veE34BIsb5PDQcjTzr
	pVuW4x4RjD06zXQ8SJo+Mv3ZrBJ6Q30yYUK8Ns1xNxZ6dKEYXvDwcf/pS1JmsEkbuCqs8YUPcPV
	eEwaqZ2TETRXST3Xez/4gm1l3cpW2btk9JezMfwIDXOWgPeY3YqAeM3VqL+4OkB/xvkRUJ42aOG
	D8nn2xOjr2rTHZjFLugDI9hJ4qsAUX7m7jJkvk7ExgX2jSLEqcmnelyZeyK8=
X-Google-Smtp-Source: AGHT+IEkvHARpHr6lASCpYYJKhWtkl83Q5YPMtQqvQsOsQI6v9aOaa5WPfigq1o+4kPYb7qTz8Gvvw==
X-Received: by 2002:a17:903:b06:b0:276:d3e:6844 with SMTP id d9443c01a7336-27ed4a7e7d9mr49611825ad.33.1758846581629;
        Thu, 25 Sep 2025 17:29:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716240sm36366015ad.54.2025.09.25.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:41 -0700 (PDT)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v5 11/14] iomap: make iomap_read_folio() a void return
Date: Thu, 25 Sep 2025 17:26:06 -0700
Message-ID: <20250926002609.1302233-12-joannelkoong@gmail.com>
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

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 86c8094e5cc8..f9ae72713f74 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -459,7 +459,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return 0;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -480,13 +480,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 		ctx->ops->submit_read(ctx);
 
 	iomap_read_end(folio, bytes_pending);
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
index 37435b912755..6d864b446b6e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -338,7 +338,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
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

