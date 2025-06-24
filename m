Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C06253935
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731803; cv=none; b=br5uXlOuQo2B80btrFglcIgHXmUB5L2FOeycn3PFwFQaEF0b7lMtLMVddJuPnfna8tEItKQIRrBYicOnBKxTjwecL8GM8Ez5SGYoNVFMKDr6dVs68J4ZgHr51E2UoeqST2kXk5jvJixWLQ944z++qCJjD3LshH0XKqeE69O8g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731803; c=relaxed/simple;
	bh=PoerR/K4ms0GxJO2Pm9kIrVTcdNfydFhWRhcSG1UbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl9wic+klN8rUtH6v6ujnI7BUgtWRAd7ejZWtF3mRJ/qveWoN6LZv5mbRIb/8f3LW1BWXcOyV8InjHxAfpeQEbXsvr/HSi7Oqp6dBIcH+EBS75djw7QVnN062BhNYY7rT5EOF4M2nofjzTNU60U0NsmXgdyXWjKi+mcWTRNNmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB/xDhOw; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB/xDhOw"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3209ce08acso1846256a12.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731800; x=1751336600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjrDdY1Jsc+m41Z52NB47+T+tcVMCALvPxP8ZmViS1E=;
        b=eB/xDhOwQLKM5uATWC5I41k02l/T/eLoeCZenXhDmzQNMIFOeebXLP9hNK8SiuayRI
         Fo63VrbRvA5e1wyufavixMxVniLWcUUVMwUjN55Cd115eioC8NclTLAaX/AZsEgBZSVn
         KvIlRTRsFrMX8O8NHx/dYvKujOtJmJjuXhnH1NjOJ/UhgeMcNtyw6iOr3hYx21HO14TO
         SfVVHLhOsLOunZrTfBJu1x49tLodWcNDBnWsdi4a2n4YccK9BwnOrVJxM4fgVSlqBZVp
         be/bXkSOqaNSEpsuJRKau+RImS4QZ/kETQXsBNmoLncgfR+MSGtYRSD0iCE+FJX1AkJE
         SVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731800; x=1751336600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjrDdY1Jsc+m41Z52NB47+T+tcVMCALvPxP8ZmViS1E=;
        b=q5hTysgCnVBXO4N7ibs0l1yLiQqpJrEX9Of/PUngmTfujOLUvsJ5JmsPFWRqTTXrGh
         JXWsvHD6kEgrlFiVrTTOwGZDSFjym6l8W2j31XMKbXTIBfzLzpPumH44Aj/RJ++vxaVY
         WzZyVOGFXseSRYYtcfmtVqkjZPtcRKE0TllH1VQELuy5u+7gBmcUBQb9U7CKUSC4N+Qb
         nsPU6tzVYuYFLLBtfa6CbKQ0sKHmDOl0zRmcrevyrh4hLGpPdOIVu34vYjdMwhHJDe8l
         /jtW6SG3C24qXda6GsqXQwi+zxL0tfwnnIa7JpkkJ2Gm2L7alTFsIPWrfOA/pHkXsBT0
         aljA==
X-Forwarded-Encrypted: i=1; AJvYcCXqkoNOQaYm3e57HfQk8Aq2tlXpBGp5LzTAtqmRfBAM2c6N2/P00KnQntWTT10lybLKJjYs@lists.linux.dev
X-Gm-Message-State: AOJu0YwFCt83jQn+w25/u68MFxrMiR03GE30uOLQrsexjZlUKP/76E2N
	iSXU2OEzs/gqAQ08boUJh97KGN632pLVLxsYNHM5HYqocnRLotSQEy7T
X-Gm-Gg: ASbGncsfQWF84/4HFFrPmdIZmEe4JyZO7EWlVouvDqHU6i7r6IvBRfK5I4xw8bTOIT3
	g+CRYbmOXhUJgfXDALp3hoNfj7snt0cmLLsvAgq2DsuFOzy+MRBID/FJi5pFw/VlauAnTuaTwlD
	1ZqYshewjlrqqKFpZUHIb5QUfVGycKyEJ35E9jyfaWwPU5H+aCM9H2QNE+mrhwDCtTU9xeouoH8
	wQJPljhUV0B0VuRyXqEmuig6qaSHYDkCbzV4PCqARNMJQi6JxmuVYNeGHVlpL0p4try6s7vJDbL
	ACJkMdKICNygmRUzkbV/Ci1BrXgrDaaEOfjpLvf6uS8K9uuvdRuaksFD
X-Google-Smtp-Source: AGHT+IG87S4yoqcIWNxElC6u13fXrMt/nV7cjqhpB1zvdKJmHCLYWfio3y1z0ctV9KIAPZysoVRI3g==
X-Received: by 2002:a05:6a20:a108:b0:216:1476:f71 with SMTP id adf61e73a8af0-22026f13166mr22674077637.39.1750731800489;
        Mon, 23 Jun 2025 19:23:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118f205sm7770446a12.13.2025.06.23.19.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:20 -0700 (PDT)
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
Subject: [PATCH v3 16/16] fuse: refactor writeback to use iomap_writepage_ctx inode
Date: Mon, 23 Jun 2025 19:21:35 -0700
Message-ID: <20250624022135.832899-17-joannelkoong@gmail.com>
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

struct iomap_writepage_ctx includes a pointer to the file inode. In
writeback, use that instead of also passing the inode into
fuse_fill_wb_data.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 865d04b8ef31..4f17ba69ddfc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2070,16 +2070,16 @@ struct fuse_fill_wb_data {
 	unsigned int nr_bytes;
 };
 
-static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
+static bool fuse_pages_realloc(struct fuse_fill_wb_data *data,
+			       unsigned int max_pages)
 {
 	struct fuse_args_pages *ap = &data->wpa->ia.ap;
-	struct fuse_conn *fc = get_fuse_conn(data->inode);
 	struct folio **folios;
 	struct fuse_folio_desc *descs;
 	unsigned int nfolios = min_t(unsigned int,
 				     max_t(unsigned int, data->max_folios * 2,
 					   FUSE_DEFAULT_MAX_PAGES_PER_REQ),
-				    fc->max_pages);
+				    max_pages);
 	WARN_ON(nfolios <= data->max_folios);
 
 	folios = fuse_folios_alloc(nfolios, GFP_NOFS, &descs);
@@ -2096,10 +2096,10 @@ static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
 	return true;
 }
 
-static void fuse_writepages_send(struct fuse_fill_wb_data *data)
+static void fuse_writepages_send(struct inode *inode,
+				 struct fuse_fill_wb_data *data)
 {
 	struct fuse_writepage_args *wpa = data->wpa;
-	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	spin_lock(&fi->lock);
@@ -2134,7 +2134,8 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-	if (ap->num_folios == data->max_folios && !fuse_pages_realloc(data))
+	if (ap->num_folios == data->max_folios &&
+	    !fuse_pages_realloc(data, fc->max_pages))
 		return true;
 
 	return false;
@@ -2147,7 +2148,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 	struct fuse_writepage_args *wpa = data->wpa;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
-	struct inode *inode = data->inode;
+	struct inode *inode = wpc->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
@@ -2165,7 +2166,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	iomap_start_folio_write(inode, folio, 1);
 
 	if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, data)) {
-		fuse_writepages_send(data);
+		fuse_writepages_send(inode, data);
 		data->wpa = NULL;
 		data->nr_bytes = 0;
 	}
@@ -2199,7 +2200,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);
-		fuse_writepages_send(data);
+		fuse_writepages_send(wpc->inode, data);
 	}
 
 	if (data->ff)
@@ -2218,9 +2219,7 @@ static int fuse_writepages(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_wb_data data = {
-		.inode = inode,
-	};
+	struct fuse_fill_wb_data data = {};
 	struct iomap_writepage_ctx wpc = {
 		.inode = inode,
 		.iomap.type = IOMAP_MAPPED,
@@ -2242,9 +2241,7 @@ static int fuse_writepages(struct address_space *mapping,
 static int fuse_launder_folio(struct folio *folio)
 {
 	int err = 0;
-	struct fuse_fill_wb_data data = {
-		.inode = folio->mapping->host,
-	};
+	struct fuse_fill_wb_data data = {};
 	struct iomap_writepage_ctx wpc = {
 		.inode = folio->mapping->host,
 		.iomap.type = IOMAP_MAPPED,
-- 
2.47.1

