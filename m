Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C49225761
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731789; cv=none; b=ItrSHfmTiT93EbrJI5GDTv8b+N2e6gwI9Ka8LAUnixZP0EtRnfai55gkNtfNPQzmsP3eMUGch/okSPHSVnYJbDbGaH33jk1aRx/w3TyzFCD2C0vKdYeWJDlnkqSv25wFNO1th2arP1dhozwa2KFdaut0/J79/x3yzIe1F/3t7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731789; c=relaxed/simple;
	bh=DuFDYi6x2GDu8XCgCXdktULX1gXUCzSc3Jt7r8VI/KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+StHS/Oay/zVN8oNNIFGDUH0IiRL9SKqFjHHq0pdf79WCzlVQJ3xRF4IAJXWKd8hSyO8AFZ3pdVg1F9iAbyO0XivfRJs5I1dJOtcEPRBPMs9P4YtFOzQN4dc9E+Ym3OLK/5auCrEjm8I3qazSV+YLC35TGAN1zkVPIgJxwt32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeGRCcMk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeGRCcMk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so4251626b3a.3
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731788; x=1751336588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbcCkgg55M0bdQitvnUlRX8wbIsKazYAcM3SmCzuIfk=;
        b=TeGRCcMkp6fwTM5//7SAgZJXoPDrmQQBnNNzex9dCHk6iC5yXqYB3au759JkJW5+Qj
         o/5wMB9hTpGoTiR9zGBbIje29cNPYWQgduGKO2DpO0Vm9MW4kkKEHZPy8sYShMuX3AZC
         Fiuki1nSagyUS5dkc3IooeEQyEW8/NZtramApqy4w7FHvAvLebe6HZZhX+KcpGMCO9jc
         BKoQrW5Nn2u4IXvI+K18qgZS3cmG4gnivPln2UHzsLpNCHTurkHC8cndmkMZczHid4V5
         ikGCY8Iki2uMHJS0yeCQ1e11NVHyXgqcHrla0ITCcctY60kL05hXLh0nL0NaHKMG7ClK
         jHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731788; x=1751336588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbcCkgg55M0bdQitvnUlRX8wbIsKazYAcM3SmCzuIfk=;
        b=VnosUCT6YWfhXL8TLnECewFsnVaRN1nlJN/PFQ/g5bI84Ck33QmvXMW4rY2bjyYBVA
         SCtduPT2WfB4rjmUnwBtYUUpUwxC5C7YQCVUEaSpidTDEFg1I8YKNrj3Ej/xQd6ZQ+YC
         R6WkXhJcKQRll6wxgxLzJw0kWxToBtD3lCsBjT2Zbo3gOdP+gMalJHdjNWG7ReZ88Qte
         bBbwO8IQhvIRA8gbtpnOMXhhxJFOv7a3bcZCepbGw7ohSp5URLNvO1rXNRma1sA5gXHD
         O1iSCP3Dt7lyRwxXVzM7fB72lb0iQBX14/T2DZuhtGUHD6EGGsaMHVmAQK2VROHbQUHY
         6N8g==
X-Forwarded-Encrypted: i=1; AJvYcCXHD1e8VEZRttuwZ1gGC5qylhMaIzIZR1zXVmnJpV0kw0A4saq5VZ2VqGN6bb/vPKuEvhXo@lists.linux.dev
X-Gm-Message-State: AOJu0YwRPfV8BJF9bKOlh089yVuQ20U2CAFwwp+Z1tEnMVN5w4FtXwhO
	DFLwCOX3qSEOw9f7yd7c6JNYJcsrZhJYh8RzGQJUO/J4Qif5GEouCQHA
X-Gm-Gg: ASbGnctPM2iMjnMEz2sJHmJIeC8htic302Sl+S85NkNAYwz0wjBn0P/E71xla7cOn1b
	wnEnZMUKkNhkSOOPdUhtDChSydhlqTdPA5XZPzazLukVFEkHQUHj81vm6QlstHjK24dOrpFTSi9
	CVRMypxRShi/Xuv3qXzJYx7oo/qImbrbcw1Xg2Lo2DUnfAEQREPOKn629gntH6y6Ki41WWgpF8s
	/vTcg9qEf4WHfK6tuQSBgr/D+b1G7So/ZKtUStym/J6/7/U7OmLG6XUht8Sbs3oekgv7vTIGFXP
	VIdZiQieoDwrJoc8j1enXu5vYNLlZWgqepbSRZ7w/aGkFO0gGwT2/tGm
X-Google-Smtp-Source: AGHT+IEENwAkXzGydPxLzf6WX938YJuS6B9WM8WOwIG5D04Hw1fzs6d1BLLn8TmD3v/7taw6P6gwag==
X-Received: by 2002:a05:6a20:7f8d:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-22026e6bde2mr26230930637.34.1750731787652;
        Mon, 23 Jun 2025 19:23:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8850c86sm487581b3a.112.2025.06.23.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:07 -0700 (PDT)
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
Subject: [PATCH v3 07/16] iomap: rename iomap_writepage_map to iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:26 -0700
Message-ID: <20250624022135.832899-8-joannelkoong@gmail.com>
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

From: Christoph Hellwig <hch@lst.de>

->writepage is gone, and our naming wasn't always that great to start
with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c262f883f9f9..c6bbee68812e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1586,7 +1586,7 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
  * If the folio is entirely beyond i_size, return false.  If it straddles
  * i_size, adjust end_pos and zero all data beyond i_size.
  */
-static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
+static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 		u64 *end_pos)
 {
 	u64 isize = i_size_read(inode);
@@ -1638,7 +1638,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 		struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1656,7 +1656,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
 		folio_unlock(folio);
 		return 0;
 	}
@@ -1741,7 +1741,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 		return -EIO;
 
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, folio);
+		error = iomap_writeback_folio(wpc, folio);
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.1

