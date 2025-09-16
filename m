Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C542F0C5B
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066640; cv=none; b=Hwqon2aSvM3pSvYcyFLOp8oOQBcuY5/R2mt7dJ/G1mhtKVhuPyHEfuYvqGgJxlhrlE2FwCHX4128vxHBQYmcKivav8EAwNxQcQmKFqfOIacjzGYV5znjz7AWfye3EwZmSJqAXm1MGeIKR9U3vb3uJcp+O/R75A2PlIYAizl5QyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066640; c=relaxed/simple;
	bh=Yyt3s3tbXY7QwAI4TPD26F/A94LWO5nXEEs4FjwMAGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyNpjszl37KffAlhdq0BhdQJlAq1rWdssvm2JxsEQ+OFIy9jLwMEmoX2fbEhJS1spir1whJiNTCqyS0tgCHuvMoCpqPAJQuBIhmLbaKxgltCpCEHeER/6LMIehKDoOncEeS1g4sLITlt3RZeU17MrhyWs91k4rZMePGMNamPIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPtGWM7B; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPtGWM7B"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54a588ad96so289840a12.1
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066636; x=1758671436; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIk1L4IFEloGQNbnkxMN6KLWRcTMndGu9WccIzvQI/M=;
        b=KPtGWM7BQxom1shCBwbjwIdggCSRtF/Fhgdd/qZ2qGnB/akIAJy9+Dt0g51VZaB+oQ
         fvKPmuJ9PA0u4WwhOv9aOJptEGk1/GNBUeAMCEkUOenMMwtMWKMitR23B3N8XcfqpLmp
         Qy3IDJQaVPz0nMMejjFaCyAblTKly+DqgCgIShzH8oI4WGXsXzgbsWsq0QWNz+yyjBcJ
         ffZS5qyx3ZJwCmcQH+OI30Q0L7p7hDRb4IlivEG21ZFk00+vpnhbAyZrQmPmEnDzJ0l6
         M7K39lvm6qzFP8Bz1HfLA+KQfiQgjcbXuTVtVPbXCXdO5Kji0RgYizYwZoX1ZGRgxFz6
         EWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066636; x=1758671436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIk1L4IFEloGQNbnkxMN6KLWRcTMndGu9WccIzvQI/M=;
        b=HvPhTJDQmaTuovYfImsh0efMFpIulP20UA9fua3Oq9d/3xjJQMiESisyqnsb5P42YW
         EgWRy3CCqaVYzhyDZ7KpNkYOCKo3pIMG2vRAKSmrKQJSxvFAndeIiNB3ZFMetl3sRslI
         IkTYNfVNovGpeHYjgHfDvcfItQ8CzuBRSE0F6ARYrUMdo7DkcztO0JZdhte8MSrucmmG
         sUETtji0CzM9yrqakVV5YfXuxEBH625VuG+GkXP5Yhxklai0THJOAU0CJwxdPu1xmJE8
         MNg7qs+rvkLthakT0ehuFQjBZo3SyVMDhTFzk4KlxSzzDwijUUi3OMh460gUjYThopNG
         Jojg==
X-Forwarded-Encrypted: i=1; AJvYcCWGD4iGWExwx5o/OEN8JIT+nVkEpoi6GxH4CZNlMjokDuhhgcTsD0qJOE8Zjr8jBi9/ndpm@lists.linux.dev
X-Gm-Message-State: AOJu0YyBaptXNs0OpeCXFr2XpSohQeu7IH5r/m20hZzp7QuwyTH/XWbx
	k4BkKWBgB59qvxANS5KYfYuEsEXAcjdK8WzD1Gf7eznf2XTrcA2DIdWL
X-Gm-Gg: ASbGnct9Iua1awxTHyTTl5d7Txm9VTxN3+Ycv75KnZpqdMgiPAsJw+vH5MEdawNQBdl
	VgR4T+4PkeRZ8QC31VTkmhkWwPLbUlngivEWEWLQPmrHe/8yA6bybBKpXg301mssFHvtbXX6kVS
	cMPxCfArKSceE4hR4cSvYoYgHayN0ZTRycCJoGue7Kap9hitHld1oZ1/AD3uFJRct49O3QS3AIu
	ktKxnLBITODZM7aGxIT+rb0d9cmUhYIX1SzQGetDYdKwPGOr31qDRURhluGvhscAch8Va4fKHWr
	pCYNHTXY4rzLn5d8ikVnLCIQ6R4RmoOXQUNaFXN0I8Srz9R5CULX2+H2s4pAjppOTQtL8LgIJqF
	oevKB8tFs8YM2mm8JENEAH+NGlgVDnC0MQVdWS0cSnOsXUv/XSV8JjGIMdOXq
X-Google-Smtp-Source: AGHT+IHNyQDV8MtJvN6c+ZIdOgaZI0j/AlCjhhT7u/T86oO3i7+BLfkpWtoSR/NM9VEtGl/sAno5YA==
X-Received: by 2002:a17:902:fc4e:b0:267:7a5d:42b1 with SMTP id d9443c01a7336-26810c50bb2mr1969135ad.30.1758066636134;
        Tue, 16 Sep 2025 16:50:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267bd70598csm39576735ad.145.2025.09.16.16.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:35 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Tue, 16 Sep 2025 16:44:16 -0700
Message-ID: <20250916234425.1274735-7-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d6266cb702e3..6c5a631848b7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -350,14 +350,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
-static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
@@ -366,7 +366,7 @@ static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -413,7 +413,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -469,7 +469,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -494,7 +494,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -539,7 +539,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3

