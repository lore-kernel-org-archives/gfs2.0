Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE931D757
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357557; cv=none; b=D4hs6hvmVDQdyVTRxoSdaTR/eSZKrlL5JHH8Z92Q3mjsTV99miyHVuqA8ZYqeXVxlg/2rK5VhtrIHwOyh7y+7mUfbxOWFSxlYOey6pAfLVGH/njdmmDR7kHk5BDpz2YC66oDbYhnF5unZgYZtUmFn/nH78Z3f5ZzWj0qKVAieMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357557; c=relaxed/simple;
	bh=XYDdbiCheJNYqFN+xdj3twDywVgXtenvowlZMieDVfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czn5rpt/4GYgfNTuwfFlm9jgU9RfWPR0bMEqpSwXQmXl9dChnLWShRfvp9uh0hM6UslR/wQE+hcTOGo9ITTI19vPHuyqQpdm5xF7740SIW+xo3+AR4gDJL/BytpIXOSlAq2wOvBwnLrJvET8d+/zaciZ868nQeFw8u7v8bRSIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfa00vYf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfa00vYf"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso4221630b3a.2
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357555; x=1757962355; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rKTaVko7JdJw65BUlzUAONrdRe7GE3jKL24dVmvC2I=;
        b=Kfa00vYfpIOpaJ47rZNb1SvucO5cMGJwlZz+KBAYIN3zyY+cRTC/mhg9BZBUIzpaCx
         u2QlDgXEM11MGIveHhJzQyuWMIRybLDPoUaLk5eY2Ve3DKxfLlzM5yLeFN1vbsPWrv2a
         Bda8hqg6IbepLCVqHc+S7HaYFgBFV4QW03hfIw2i2kk3onYTZ5nOAxIp/di8W92y+1ir
         rR8frbDbZGndmZOA1iMy68scnZPvbd/B4Wzqwj47xhjpSFT80ur2ZmeqAQULewDCEiT3
         nS/lahmbLJyxDMB4b4izwgJQWDaoQTUpeNCFpfuXbNXO0LUgFCM9MzBGz1fGlN4y5txI
         7OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357555; x=1757962355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rKTaVko7JdJw65BUlzUAONrdRe7GE3jKL24dVmvC2I=;
        b=klyC2C4/sSAbA6/3XfBpyNbOWt04BXs21vQ5RZzmi5JpanvRfrVq30UTAQxENy7o8N
         1uduIuxVSv93SvChbhjJ1wQf0ykEZLq1I0K27lhYOFCmWs4/z5bGSzR4h2jwR97gFNsM
         WDH908f1a4TGm+cGAWll7P9WwDE4hb3J4xoWNa5tBHCkjGhZ3ZEfmwsaCNlF0w14tNhM
         Mo5Q3eKENdYda5ISKTnV7B0pVSia1GwEEGRxqvZ2TfpztxVFDwheRlDSU1veU/5mkueK
         uYQbV23z84ZFJEa4wuIOVbhBsM5BWVERkGSBgh8oj4J1LBYc6x2c+pJxiCbGiCwCbmHL
         DOBg==
X-Forwarded-Encrypted: i=1; AJvYcCU6vRWUHrPYNmtN6cr+Cjy8vD2zhpRHVTkQAYmM8WgPuPmfBe/rFmbLqKvrkvVNV8xpXjbU@lists.linux.dev
X-Gm-Message-State: AOJu0YyKaz1oP/O5TnohFSTzAwuZgmv9N3fvP6rAt4IZI/QVzhJZASU4
	FfDMiAXFbS7JlEuF9d+mRXTq0y3ejk5yxuhcgnWLDgJoGTA51rIYr13/
X-Gm-Gg: ASbGnctkGhH0pjSJsFWwbsWWULLzMQTTFwZVTNhTWdLnD0VPicBgSBL4FcqHGYnaHYM
	9kalX9wtOqZNs8/DnmJgOAI/gDE6wjP+7naLc6w9cmgqa9SeYVi1hgXYw1oxX44iaBzUQ6SeXvV
	TdpGbVgw2/oPxSdOCzKK3JdwxGq01LA6RdpF5xYmVR9j1/8mcoqYiEjBusPEQ1AP2uDGbGsKEaz
	+SlNON3OCQEW4y44igos7MEFWwwXAW1fnB4teouqCTPRZ5eCnrmnIvm9PdOWdqGIH8c6IDeouCB
	vDRX+AY2/j608n3f+yC1ZNzZQY5BXPw6qWrv5ULLPFCJ52LD2k4bNbCBTEQWb4OF2cKZTEqvqhT
	v4K0cZ8+uf/9HCHOyiwnPQWIS6uA=
X-Google-Smtp-Source: AGHT+IEBOsJF9kmNPbxpjlNuPGBRNS2ZtwaXOFm/FJY0Ln5Ayeda8Xt4/B7oIVcSXTC3tK2bRuDPDw==
X-Received: by 2002:a05:6a20:394a:b0:24e:ced1:d91 with SMTP id adf61e73a8af0-2534519d1a8mr12004589637.41.1757357555318;
        Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b362dsm30535084b3a.32.2025.09.08.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:35 -0700 (PDT)
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
Subject: [PATCH v2 12/16] iomap: add bias for async read requests
Date: Mon,  8 Sep 2025 11:51:18 -0700
Message-ID: <20250908185122.3199171-13-joannelkoong@gmail.com>
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

Non-block-based filesystems will be using iomap read/readahead. If they
handle reading in ranges asynchronously and fulfill those read requests
on an ongoing basis (instead of all together at the end), then there is
the possibility that the read on the folio may be prematurely ended if
earlier async requests complete before the later ones have been issued.

For example if there is a large folio and a readahead request for 16
pages in that folio, if doing readahead on those 16 pages is split into
4 async requests and the first request is sent off and then completed
before we have sent off the second request, then when the first request
calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
which would end the read and unlock the folio prematurely.

To mitigate this, a "bias" is added to ifs->read_bytes_pending before
the first range is forwarded to the caller and removed after the last
range has been forwarded.

iomap writeback does this with their async requests as well to prevent
prematurely ending writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 43 ++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6fafe3b30563..f673e03f4ffb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -329,8 +329,8 @@ void iomap_start_folio_read(struct folio *folio, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_start_folio_read);
 
-void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
-		int error)
+static void __iomap_finish_folio_read(struct folio *folio, size_t off,
+		size_t len, int error, bool update_bitmap)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -340,7 +340,7 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		unsigned long flags;
 
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		if (!error)
+		if (!error && update_bitmap)
 			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
 		ifs->read_bytes_pending -= len;
 		finished = !ifs->read_bytes_pending;
@@ -350,6 +350,12 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
+{
+	return __iomap_finish_folio_read(folio, off, len, error, true);
+}
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
 #ifdef CONFIG_BLOCK
@@ -434,9 +440,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
+	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	loff_t count;
-	int ret;
+	int ret = 0;
 
 	if (iomap->type == IOMAP_INLINE) {
 		ret = iomap_read_inline_data(iter, folio);
@@ -446,7 +453,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	ifs_alloc(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
+
+	/*
+	 * Add a bias to ifs->read_bytes_pending so that a read is ended only
+	 * after all the ranges have been read in.
+	 */
+	if (ifs)
+		iomap_start_folio_read(folio, 1);
 
 	length = min_t(loff_t, length,
 			folio_size(folio) - offset_in_folio(folio, pos));
@@ -454,8 +468,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos,
 				length, &poff, &plen);
 		count = pos - iter->pos + plen;
-		if (plen == 0)
-			return iomap_iter_advance(iter, &count);
+		if (plen == 0) {
+			ret = iomap_iter_advance(iter, &count);
+			break;
+		}
 
 		if (iomap_block_needs_zeroing(iter, pos)) {
 			folio_zero_range(folio, poff, plen);
@@ -465,16 +481,23 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			ret = ctx->ops->read_folio_range(iter, ctx, pos,
 						plen);
 			if (ret)
-				return ret;
+				break;
 		}
 
 		length -= count;
 		ret = iomap_iter_advance(iter, &count);
 		if (ret)
-			return ret;
+			break;
 		pos = iter->pos;
 	}
-	return 0;
+
+	if (ifs) {
+		__iomap_finish_folio_read(folio, 0, 1, ret, false);
+		/* __iomap_finish_folio_read takes care of any unlocking */
+		*cur_folio_owned = true;
+	}
+
+	return ret;
 }
 
 int iomap_read_folio(const struct iomap_ops *ops,
-- 
2.47.3

