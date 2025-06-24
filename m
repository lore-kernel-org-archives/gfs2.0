Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89696225413
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731787; cv=none; b=WyVnQNi86veGNwyZJSvga+mO5bBEqMgpLZAL8nqLZvrtQZsszVVCW28qMAM/zFVHxLHXSnqeuWbfBriKP0MZ0BCZKDKX1pV6RruY7RJx/mqxtn8UTNzYi9d8dw1kFPfSCI9S6Hfd98ZM0dwyvgGbrivpT4Z2Fqyqo/vltARl4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731787; c=relaxed/simple;
	bh=w6oI4XdBkqLpqx8UEy0BO/l6PNovW+ILKa/y0YsvhEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWlU3j5YcXhKbh+HMq9TJfg1WsCuXa4GviMQvglxAOE8BL6Oos0Y2+2SYDwBXgUJRQWxoK0AxlmSw9D7gy1c2I/qKJe16MZgV2+g6FhicXPGUVQkyMtpBvCWVv8LhN5a+q+uc7AD9e9gJOOiZk1wd9O4vzep/wfq1lUUOlzwovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ7Ri+nG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ7Ri+nG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso3444910b3a.2
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731785; x=1751336585; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7qRwxTAh1XYIZNu1ybbTn2mD5r36mtDEb/ZOVNmqbg=;
        b=AJ7Ri+nGgvTZ2lSXJhO79cY6O6Pas1ScSk6zySXVhpRLPriDaQwAq853Tj4fJd9zIC
         VXNmRSnBe/NLvVQcbY8tUazsGJ5FBQggvMdri5hDB3+OpSumpu9u9TpBCcIrdxaR+a6t
         XcvtvrjEBr0dc+5FUoYrNtZdnGO45PcPbj1nNPfcWT9+4FpU5HRFwdcF89OirsLQHMqA
         vXiVSwMN/RQNRP1QY3WPCijFeKNjl1ZKWBXn0bhf/fadI9rmfDVvG3+NMkpiC3XjYAcC
         jxfQ6kmrp+ziT0VZ3Iy7g/X7BAZDKN4zA2NN1Pg0lz2ynthhn1a61iFRjwSwIx0njgDT
         3zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731785; x=1751336585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7qRwxTAh1XYIZNu1ybbTn2mD5r36mtDEb/ZOVNmqbg=;
        b=ca9Efdruq82wWu+agIrZm8Di01U8/HWWjWgqK/bdYvKrvyH3XorTxn1oCBwAyJWuzU
         /l5UQkkHWJAE7cncS9tN53GcK0Nep8lY4IdXf3WrvVOXpodDK2apt1XWZ3fmYJtA2Iqx
         oNmXgXc6aRURbriG0FtE3Nu5goxH7uqXH8x1OF3+ZUtfBLwYrMUUOHMsXmwdbJBzbneA
         3IfRv3f0aaIuSca4I3HJGOkABArAKhfgK0o7suVQq7AHGY5a7BdljYcauSk8LZZcG2V6
         V2ZflyG5vqjU8klEIGxSxICuxb/G1tZksXTXpJJAOD+BSlDeDinRyquKjm7MpcTWE7fX
         Kmvg==
X-Forwarded-Encrypted: i=1; AJvYcCW7fu5jhRPTBbRKeHRuo6HmC0JyeTB6a9aBWk/gqNDhRmRL0tz/4ccJsOh1ie5VtxzenqgQ@lists.linux.dev
X-Gm-Message-State: AOJu0YzPk/rGh26ePBpMtT+Me5EVFTszJ+QW8WWI5VBm9M5320ym/Gsv
	hz2ixYIExXzjhX7GuQpALn/K9Et+purZo5VB3k/PnSE/sy56mwmvUszh
X-Gm-Gg: ASbGncvaqTvXSV/v15EHPrB8pztZ8Q/QWPAs/PCY9DWMSWJTGYj3ZmtSsUKJaCn776c
	DriXmEvteVV9sxJAKNRXXQIrozQ05YT8keLJgdp2wc+chfGS2xyr5MzNlYIUykRkiBJdEcqDUkk
	uvIPnrn1uiO56dsqXLkvI0kDdTPEFbP0WQSJrc0vFn0mc0MnCj28sVMu/NrQMpZRd0sSQMXqcBB
	0T8xa+RXcAdwuuAk4hUVSawZfs4N7PKZIwKa4E+J0xct/LUW8J0skOGAwvqrDxvaKEgUx8X30m1
	P/a/JoHxiD7Mtn6oIQUwAdvOtaUfbGrvz31yc3i8A5Z6JvC2sFEKbevIaw==
X-Google-Smtp-Source: AGHT+IGel6o48zBxpcJuXVrZ4h8rIweeNj3Mra0caghqGYv6uPbzbvrWu2IBvYn2pP9m+sUAn+EBZg==
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr20118385b3a.18.1750731784748;
        Mon, 23 Jun 2025 19:23:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241efbsm9057789a12.36.2025.06.23.19.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:04 -0700 (PDT)
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
Subject: [PATCH v3 05/16] iomap: add public helpers for uptodate state manipulation
Date: Mon, 23 Jun 2025 19:21:24 -0700
Message-ID: <20250624022135.832899-6-joannelkoong@gmail.com>
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

Add a new iomap_start_folio_write helper to abstract away the
write_bytes_pending handling, and export it and the existing
iomap_finish_folio_write for non-iomap writeback in fuse.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++++-----
 include/linux/iomap.h  |  5 +++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 50cfddff1393..b4a8d2241d70 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1535,7 +1535,18 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_write);
+
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1546,6 +1557,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
 		folio_end_writeback(folio);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
 /*
  * We're now finished for good with this ioend structure.  Update the page
@@ -1668,7 +1680,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len)
 {
 	struct iomap_ioend *ioend = wpc->wb_ctx;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
 	unsigned int map_len = min_t(u64, dirty_len,
@@ -1711,8 +1722,7 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
-	if (ifs)
-		atomic_add(map_len, &ifs->write_bytes_pending);
+	iomap_start_folio_write(wpc->inode, folio, map_len);
 
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
@@ -1880,7 +1890,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * all blocks.
 		 */
 		WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending) != 0);
-		atomic_inc(&ifs->write_bytes_pending);
+		iomap_start_folio_write(inode, folio, 1);
 	}
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 047100f94092..bfd178fb7cfc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -460,6 +460,11 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
+
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1

