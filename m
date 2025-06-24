Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F79217F3D
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731795; cv=none; b=Z1aFEXKXBJMk8Ezh3GfCd5QnSvwOCbiaIHcyF/LB12rUBdsnpPI+eGIr/cUrEGbAALmJtsJ52ObJDu3gWDThQYHMQxYwbI04VkvRKGwUjgcVxu8yFAdvPdojtRSZkTSk53p++2GfU8t9bMsO5EXX2q9g2hlWfmP2BxSzVKTnVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731795; c=relaxed/simple;
	bh=pRtLNn+K+f0dljnBu0Wr54Jv7D0qPpSdWn2mTd1El68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOoGDiOdqfIP+kmaO3h0wzuHjMYEA29UGOYGilMoTtQ09QqSo6YH3RAKIwhYWiUVGiNZ0K//xYfU8Mn46S8QF2lvq//sSc6OMTtcahK5p2G4CRlDnEVh9AJfEtMTnSerepi5Kq13LQZbh3Yp+pPc5aOTNOp4en2KGZQAta86OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjwE9AKn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjwE9AKn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3534021b3a.0
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731793; x=1751336593; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GtAeER6c1CahXSofSbmzClYLDOBpPxRoXtNiXwnYsM=;
        b=SjwE9AKn3RJpnKkTo+T44LtuN2T2W77RWghrIcCh5jzbmIsdmZkcHKk78NPcKlq6Tq
         FHkbKGDALwHWf2wf66wgtnq65YMGbK5FKC+X4UgFXPDTnwBcaAbCfLCPOyvQGCIekg8u
         zQ+vXBjm2rZjFXcM8vVefFcRctFg3Rz11eAcORnKW5HktRXHRO0tiQ+4+M2Wj59B24tU
         VCKgTDe+4K/7FWXShiDQPuc6Bj523H3e75wsNpYlWKgZcKxdj8tvC4Gz4ITiQlO9Rjef
         M8PeWIIdeVOTFcIktCSgbr0py0hQobu3sLBcbGBGAvoyV6vYkMNYotcTg4aULYNlJZKm
         44MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731793; x=1751336593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GtAeER6c1CahXSofSbmzClYLDOBpPxRoXtNiXwnYsM=;
        b=bO3UtHR8pfdATB+IGDyLLHHzqKzegIT7Lfv5UlWbudki8oNZGvslgRAu8jznDhcerl
         pCTmhMi6iAT5EdrooWHyq6tKyGimuyTZpO9XYCIzx9VeHbSiehua3zd8QbHu6+98/tNk
         oCCGOiWKsto3fbvoxmL5CE4DFsVdk3x9q9Mghm5tgUFJW45YBwfqsZ5YAaXlYT5yCUGo
         yxnGLcMvbetRxwX3rO9JqphlkF/pKU4XCLRQSaC1VUTu69kB2iDX8Y3PBTkaY7JDgK6x
         WOGeVBIBPSa3wh029TdCtpjnW+wq6Pxtw4+ICbYQxdmiPZiNOQqK1R9QY4bEbZVjikgE
         dACw==
X-Forwarded-Encrypted: i=1; AJvYcCVj86nJ5NP1sYr7X7xKcohafHZwaHHBq9mVxY0VawHCOcCUOgFBMtEnGl8gkMnQdE3kjdFH@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi/K2RPm1QJvKqnTm5KubG027yzmiMHZIdfw/q3kDES7Skcpni
	b+SCvQ9NHGFWlnV1pGYgJRaXTIx5qhdi5II8xs10jKCxZ0YYgx4/Mrzu
X-Gm-Gg: ASbGncsBJ2NYUQy8pbRWhpLqhvVRZUKWC0WippaNCGiE607KGPUlmD/ndJFyWu+b3ic
	TLiyTbYnpQcB+1vh/0sA0088qtCKclC6UuC5n0OAEg+9R5HCvRaZSxuM8oVpifFiYW7d77L5lh1
	jEnfUj4DB0jkm41ip/wl9mNPvvKCTwTvAzuRnuwAGbyH7SWRzrYM2zrwY3m0NhvLgDi+aFbYdPV
	sRL7fjynUHHRvm5kptMgMFf3iVjOesBbbJ17xEvy5nlQZVbmAF97nb+oh1hzMxt0tEUzGRgtmyH
	drX9Eu4QLmOduIx2dVSSCC2eh9Tez+ru8cZH6/hT5AH88f6M/VkfhVTKyA==
X-Google-Smtp-Source: AGHT+IE7bv0i6ALPDr7cw7p0PsBQNw2kOyNwlR5aRn5JcPix4coXRnKFLoiBSy2sjHoM7bpp14aqCQ==
X-Received: by 2002:a05:6a21:44ca:b0:21f:751a:dd41 with SMTP id adf61e73a8af0-22026e2a41emr27318649637.40.1750731793453;
        Mon, 23 Jun 2025 19:23:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872203sm450073b3a.157.2025.06.23.19.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 11/16] iomap: add read_folio_range() handler for buffered writes
Date: Mon, 23 Jun 2025 19:21:30 -0700
Message-ID: <20250624022135.832899-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a read_folio_range() handler for buffered writes that filesystems
may pass in if they wish to provide a custom handler for synchronously
reading in the contents of a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: renamed to read_folio_range, pass less arguments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          |  6 +++++
 fs/iomap/buffered-io.c                        | 25 +++++++++++--------
 include/linux/iomap.h                         | 10 ++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 1f5732835567..813e26dbd21e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
                        struct folio *folio);
      bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+     int (*read_folio_range)(const struct iomap_iter *iter,
+     			struct folio *folio, loff_t pos, size_t len);
  };
 
 iomap calls these functions:
@@ -123,6 +125,10 @@ iomap calls these functions:
     ``->iomap_valid``, then the iomap should considered stale and the
     validation failed.
 
+  - ``read_folio_range``: Called to synchronously read in the range that will
+    be written to. If this function is not provided, iomap will default to
+    submitting a bio read request.
+
 These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_NOWAIT``: Turns on ``IOMAP_NOWAIT``.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f6e410c9ea7b..897a3ccea2df 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -667,22 +667,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
+static int iomap_read_folio_range(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
 {
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+static int __iomap_write_begin(const struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
@@ -731,8 +732,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			if (write_ops && write_ops->read_folio_range)
+				status = write_ops->read_folio_range(iter,
+						folio, block_start, plen);
+			else
+				status = iomap_read_folio_range(iter,
+						folio, block_start, plen);
 			if (status)
 				return status;
 		}
@@ -848,7 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, len, folio);
+		status = __iomap_write_begin(iter, write_ops, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8d20a926b645..5ec651606c51 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -166,6 +166,16 @@ struct iomap_write_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Optional if the filesystem wishes to provide a custom handler for
+	 * reading in the contents of a folio, otherwise iomap will default to
+	 * submitting a bio read request.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct folio *folio, loff_t pos, size_t len);
 };
 
 /*
-- 
2.47.1

