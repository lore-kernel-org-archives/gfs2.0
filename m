Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E931C598
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357552; cv=none; b=Nt0OOhz3fVLwNzAllZcHhJ2PuivDbnOQNFdR2hTS05naGHa8OoWoSlMR/Jb71IVkPB/RIbBxbTaqz74Y3qzk/nry7bFF6mFyUKRLdcySl1tpNhE4vUNFbTnFBCmDVeVClZYs9g/T7eo+YNufKkecRvhFTu8Sgis0bMQUaDFfsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357552; c=relaxed/simple;
	bh=8bVzq7rcd6+/oHguqVASvBdfwSnObq0kOuEOnIfHh0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhN5qC7+tGOtpGmrIOPQlwZpAyEMNLNSZskoNZXkD/BvBIvLyt3BsZs08InyX+U75FGiF7lEs9nATljuy4587paAba7F907csom0EtR66Ylm/fLJpwzy1+Nq+PMVIuvB/slIeYXh8H5vfeuoPY7xpdqHYg6MMXbmQx5YoCqiNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXApr30s; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXApr30s"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3748112b3a.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357550; x=1757962350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7rjD1iv39Js7KLe7xETVP5pGV3Dh0KHSA9Vqd5TnBE=;
        b=YXApr30sLTJLKEezmSt8M1pPhRnr2dmqxRwBefDOAZM5N+NlXt1ru6fH4ecFTQxBcY
         U5AH6l4Qxi9bxYfPyFSzjZK1hiD8ro3sninnIie3RP6aXUxdlFwXInpgr3cQxaNklu9z
         yBtf+ZEXinZJh4FVmF9jRrb2MxX8mtZe4Zd8d1Cz99o7KxGWMYVkjEeOsGxuLR0jRHgI
         LiIm2pIfIXT77de78KWtcfoL0lQPBM92uXS0RVfBCgqO6XWWlHLSndm2jJO6fXnynpyX
         RkP36tgq3UDA1MHXp9evNrjRGGSQHYdWxy3DFZWpBO1jQTYxYLG/vA+udSzwWuAuR6P2
         ujfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357550; x=1757962350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7rjD1iv39Js7KLe7xETVP5pGV3Dh0KHSA9Vqd5TnBE=;
        b=SFwX3oEG5u6acdK5tMH+DzowjQ0po7XaW/DkRWr2XsFSbCrnR15ncZLN7Pxm+zbd93
         UjxEm4mwq/gS6zUOJTueQL0w7IJ4cW8Izj9rpoRARj5LSlVpoXYwJmd3oUSyDebXZ8e1
         6tLZukCMJi60PeKsIniIgkcduhwJ5PKJsUl3q8fMtdwLeFh1cKh/Rl0KVHYN8vQEcqpE
         UsKkrILhaf2si5CLoRuviOaDWkhVNoJ1mfmabJRO+9NoIrxwVwETDK3UwR9bQdTYctkT
         HaPWVITSy2AjHc2a/K0XDRHFr+LVFPzAzPVQ7Wqqn5J9xs9cdflsAeUl+YdnkyrbXKxX
         mhbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8ek+s3xnFQ5z6E1N6eB1xzXiHM3Fjc4IVqY41Ajfyo6thBroAwR5COA9hP/WyRjpJ+Le@lists.linux.dev
X-Gm-Message-State: AOJu0YwQvUZUGfUCGkt/lmmLAAjdplvG7IqyOD9/k9OFoy9yvlDg6dnz
	PGE3wT54yj7aWPP6S2EVjTSdMWbCXHrUNqYyLQ83G8BSj6wrRGHNt4DA
X-Gm-Gg: ASbGncsHV4T3VgpJW1jdGzFADsbbOGlq9lg10pHKm2lRbMoLiGUPWlen8yk7T9FLCYa
	comDXbXPp3aNW1e5DfLCZaQk2QptdUHTjBIQekz+SRQ6RXcq9sKUzsZ9IJIw+eN7R/Rj7cenZVm
	hvTyFiY7Q7jAu9zfjhs2xB8uORRlbqs4LKl3m8O1oWC1EevVSHEV13mawvJh6VZbUffgCa9zywd
	7kHMf3+q566dpf/vlgVKfXCE4zi5AFrh3zT4iNUG+KnRLovKlNV72laZaizFxT8c9kYSKhrjGbT
	sy9XCfvrkbvzjP86TPH21AR3vQZVC2iOpxpqEsjy6aQYDSX3yLinr6hZhMXa6/HJ2uWCOt6WvSV
	tHocN6RhHRObnVfo4JA==
X-Google-Smtp-Source: AGHT+IGHbUW9FBEb8tIDxVtvLWASURviWnoIYFqblnFqkXVQubVBT8P2+9shF/FbVaCvTpCNN+baqA==
X-Received: by 2002:a05:6a00:4b0c:b0:772:63ba:124 with SMTP id d2e1a72fcca58-7742ddf2532mr10301902b3a.19.1757357550309;
        Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4beb67sm30326993b3a.65.2025.09.08.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:30 -0700 (PDT)
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
Subject: [PATCH v2 09/16] iomap: add public start/finish folio read helpers
Date: Mon,  8 Sep 2025 11:51:15 -0700
Message-ID: <20250908185122.3199171-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
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
---
 fs/iomap/buffered-io.c | 26 +++++++++++++++++---------
 include/linux/iomap.h  |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 008042108c68..50de09426c96 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -317,9 +317,20 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
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
@@ -339,7 +350,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
+#ifdef CONFIG_BLOCK
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
@@ -381,18 +394,13 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 	struct bio *bio = ctx->private;
 
 	ctx->folio_owned = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
+	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..0938c4a57f4c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -467,6 +467,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
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

