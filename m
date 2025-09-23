Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888981AA1D2
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587646; cv=none; b=ebeqUbCl2ecFSE3e5NlNsZ8rAjjInZyt+75zrrFL1xg7UWimf1PDBdeq4bSxraxVE+s2vspmcgU7E/nUqtuc3w3RINXFLD4UIcdhk1hyF5MvpaC7rMV7R+ZmOpac7DOjP+oRyhHN6FtiDP6mSuwT2fJEs2yDoIACywAqbxRIsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587646; c=relaxed/simple;
	bh=wL9lZimimYPepUkw6uokO76yAdo/rrFpXRGxdT20nX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOYUTn39e3Wl1OKOsZcjiaiJQUJ9iznA/ZyAhrkfs1uKojAu4oL+fmQ4ySNrf+yYKxAVa0KNNpcHCR1owLpqsYMoSs9ZBWWk+/gSf0m3Tvaw4aScwCImnl24k2UPswIYkf2VceNvq5LhMPj8rK92qka9rWLGLPRxrtZfBKZTw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0Hd5jOd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0Hd5jOd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2681660d604so47577475ad.0
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587644; x=1759192444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5LoytNdOZjWYJW/+eSct1yfmQv94J0ZLKj78CJDynY=;
        b=f0Hd5jOdVFJVTkcsGYWXpwO5tq0WDlocVv6hghJH0B6b91QS+kviS13/3FSm9jc9IN
         VZknwrLXkoN1SaSfJ7UvFogbt5Fq5nsu/ft4Xq9eXd13kGXwOEdCR3xzkcVMB3qP4Pb5
         llaCku4C4Ea8R0VcA+S3+lzMbFmR5p8qLFpCUjsqKNgGbAhp088QQDrUObHs4nRH4z/O
         lgR9YRGuwdVm0g5jG6VRGtdC/WmKX99zy0M0zx3RrNGcsfSB7g1JQbgQx2KgNiREvrBC
         qXJWPYIv70B4+hBmnaKHN7xi6RF3B7VWbigPkFSxoGeahBcl2uA65un4DD9W0KMVz14l
         08tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587644; x=1759192444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5LoytNdOZjWYJW/+eSct1yfmQv94J0ZLKj78CJDynY=;
        b=AodwtVyVgfyxRF+UqmGkeagICC+DL1S0cS18MNfT4EiB1YYu90yok6now2EtvyCKQ3
         nTZUgW/OxBiRgpjh6uqJtbGdmHeG4jDKSkRYxIOoRwCMF/KVOsQqgN1nPx3UMZTjFf1O
         FdWL8FIW8wWytWCGIc/kveL5bHzrirzeBGzNOcJvZTGKSHXkeR0fv8VXvIJgTz1MlDGR
         IfxqPrSjQL9T+z10RrA0cFo5BC+vKY3YEol2Kzo+KFX8Fo6v5yg3BeAag7f/DGy9N5ju
         1CeiFZzgqOD/p9ErXNmjxQMN0fBPrGZXw0yDExvaizm6Q6tx6SsWVINZvslFcWOlE06B
         Se9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVm8Z5Afx7HrnIjW8rFr+IRF75kO4oL42LZL3O8P0kqDG2tpevgkRYgKTjvzEuuggXotlt@lists.linux.dev
X-Gm-Message-State: AOJu0YyW+440k/TGMn2NtrgqztZaQxF8rbRLwbBdbjnQ6nT1DiHcpnMm
	Iw0gtaNui5kEMEMB9+y5YO+EJp+lS3NdMbCv8BaGMsFpBPNT36hUIViC
X-Gm-Gg: ASbGncsxS4b4u+wwxH8JnPKUenuIjrDST95rXyROUQnY6f3To6t8xle6OaMa80CPS37
	kbIU1Sk0889mTebPllsl4RCC0cXMKmloopjIWZLVsBdueGiTExR1p9FGMZX8iHVbAE79Ml4cUAj
	/5RbE9bNojJqkQ3cJ/qST1RZbvsPLuvjQFwtGRzghfSS3SXwBTrQlkDzweaf7h68kvqDqTtL99E
	gTCPtVLrQsI6ihlPApSKcL+usn/RYBmQvHKHa3QKskOXswCrGNd3OgD6TQLhdKgYhzV4h6Mnruu
	c8Hai2F8R+XV8wZf44O52rs5fyqC0i8gsOEbK0xeyOCBAYJY5EHVw6pklLqCUzhAM2RgKS3Etnz
	AunixW7hwaE1gygiR6cY9Dll5U7GsxYKMrdPDErViMI0qQYIPpA==
X-Google-Smtp-Source: AGHT+IE2rDd9Yyv5lah4zvV6w6qJu6a1A3PLSQl9h6wVx4RGpLkLw8rukfKuDkaefPlT+C3jXqTA3w==
X-Received: by 2002:a17:903:2ac5:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-27cc22efd33mr7650465ad.19.1758587643804;
        Mon, 22 Sep 2025 17:34:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm145121615ad.109.2025.09.22.17.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 08/15] iomap: add public start/finish folio read helpers
Date: Mon, 22 Sep 2025 17:23:46 -0700
Message-ID: <20250923002353.2961514-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ifs read_bytes_pending increment logic into a separate helper,
iomap_start_folio_read(), which will be needed later on by
caller-provided read callbacks (added in a later commit) for
read/readahead. This is the counterpart to the currently existing
iomap_finish_folio_read().

Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
accessible. These need to be accessible in order for caller-provided
read callbacks to use.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 26 +++++++++++++++++---------
 include/linux/iomap.h  |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 34df1cddf65c..469079524208 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -327,9 +327,20 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
-#ifdef CONFIG_BLOCK
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
+void iomap_start_folio_read(struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += len;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_read);
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -349,7 +360,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
+#ifdef CONFIG_BLOCK
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
@@ -379,17 +392,12 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
+	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4469b2318b08..edc7b3682903 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -465,6 +465,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_start_folio_read(struct folio *folio, size_t len);
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error);
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-- 
2.47.3

