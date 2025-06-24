Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B8235360
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731791; cv=none; b=XkxM40F6SwYEYpMZcwsCJn9fSkF9AoBBLSZBYXiCA1VCDKeHlWfUB9HsnYMRBg6Q+9pFk70546KoojywOfexza9vAcTh4gfQOZ8X4kH+53zvrvtjFmwA8QL9IUh4heTMplWAcWnW4k/fdgWt45sSMBl5ALqtc+V38dmJgZIuvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731791; c=relaxed/simple;
	bh=j5vgOtyIh/0mL3/1IM1EQg3ivNapUnNYD1rSJUxJUTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enDsxPC1nYUpUh/fGJFhqo4AxS9c0KY5KBsToG/u/PEhiqRpgefiNKs+UF/Dhv3ZipFdBULAOpfsZeMTCp1pRDsU5g+JCovI93qx6cSLuZG+lXE/8kaESe3fT3ap/vmAqeLE8zji1kkFnHWzKp675hkDpsgKrvXYC1tbFHds/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7Xpp0X8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7Xpp0X8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso62383205ad.0
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731789; x=1751336589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC1UYON7hcM+s5zpfKbC1ZPj9/+qK5UO2VBeIZXIz0E=;
        b=U7Xpp0X8kH8Jat76Pz1F2EwP58AiJmhOdDQo/nwoT5oiNSXkMKrrt1RX4olYqJldd8
         yBaSSrWbrxRw1lhYdh5kVv+vNU0tpFXgalwI0o+Uhv8VselkTogBUW828JVs9ll0mngP
         3ssiP6EcE13Ix84IRb438FXiFIix6m8ADKSWr25p1/cCvO7P8nCWHbqbRVO0HK5TOrOF
         g139SpTaI/Ufc4zzxRBZ+rPq9DGeM3UuH2y2ksU74EGXGhL+Z3FKKqqCBtntl9P9t4qd
         FGh2krqtHT105obaoyo4NL8isFq2AbXqLSSWNcABBIDrKWrtF05SQmx2zUKBKucnyWc9
         2KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731789; x=1751336589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC1UYON7hcM+s5zpfKbC1ZPj9/+qK5UO2VBeIZXIz0E=;
        b=DWGKfYm8dP7d86tMvi6EqloinZ7IIerGHSIfE6XnOXOvZoySlQkUkaBluWAuYQBP6J
         24OxQEuLoIj6uXBj6a+7v4vvVK0b3A83a2f/dvU9BFPEVJMTO2UQ2c20vcJTXI7QTIO6
         Y9zajhppvFBMJALX/5HUmdhMGavae2IpZnmD6faVinbPsTxydQcsq+wOcBxdXFbc9+by
         UwC6Cg3ozPeiiU/Iguch6KasChEUawrGbNI2L5nsSh6q9LODG3CT/573u6XS4DBVo5xA
         AziAPfNonwsYUmNXAZUDPhBFYNSFRBoYPuDB8mc3U2qr4+tGGP4yxIz9QJ8S64++rucU
         A9ww==
X-Forwarded-Encrypted: i=1; AJvYcCU2m+MTaKyzi3E4znxPpD2lSboKl4n6NWwuj90BXYTOWqEFaVIhqehVJHVvoBQ8p92ZHky2@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr2cWsnx+LZf9BHfKowCE79E6Agn15Qd+oWFnKgSjoo6hYSJda
	LrKJJq4Es2sAnFSSrIqz106RBZKokzuF9BoRuiKY1dTh+tSz4cIVqX1sqdQtJg==
X-Gm-Gg: ASbGncuPCFrH7B6XhslZ3GiFeTZMPbQ2s8JJHohoDvvJqluxnHYpCqTeWsoH28a4rgT
	UlusOuwYmJuWQu2noRpqN90ELScB6rzkGOgpgQLdjY8pe90Nb27quGwUqlizeUz7mtI+7F55bPP
	Zao0K24Z7pDdZKg3JLUQp47sZxG/EIsh2RF+ghZZkPHgmwZyt2qFWScIfMSGLrcDQO0rs9rngq/
	j6fuydWw2bgoiGazMTn+kTxDbh35AJOJ18hBfPCcb5uin/sb3A+pMOXhN1a2PILDfjFxLfJIyOy
	k/22uE6QtIIgD1A6zoa1ispo1JW0Zi8BEiCAIaVwDNXs6OZGaFBIip5f
X-Google-Smtp-Source: AGHT+IE9dVRe9OSggKmdFWeyGF5nhQkVROL7+L8HQgoSpB0UZLST5XDNEs2KEP5cexzKVClOYWSy/g==
X-Received: by 2002:a17:903:1b50:b0:235:ef79:2997 with SMTP id d9443c01a7336-237d9ab5f95mr192725555ad.47.1750731789069;
        Mon, 23 Jun 2025 19:23:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86635e0sm94530875ad.157.2025.06.23.19.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:08 -0700 (PDT)
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
Subject: [PATCH v3 08/16] iomap: move folio_unlock out of iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:27 -0700
Message-ID: <20250624022135.832899-9-joannelkoong@gmail.com>
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

Move unlocking the folio out of iomap_writeback_folio into the caller.
This means the end writeback machinery is now run with the folio locked
when no writeback happend, or writeback completed extremely fast.

This prepares for exporting iomap_writeback_folio for use in folio
laundering.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c6bbee68812e..2973fced2a52 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1656,10 +1656,8 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1713,7 +1711,6 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1740,8 +1737,10 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
-	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
+		folio_unlock(folio);
+	}
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.1

