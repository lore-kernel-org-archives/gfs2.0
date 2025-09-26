Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46871195811
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846574; cv=none; b=t5yQHcQCjTVKYV23a9LbLFhoRA7/DlcVMzkjIN2JSDwmKrFZFa2D+FkjLsE/QCozWfr4YbzwQgxAh0oFj3Od6YZUEPsdUWS6sUH5YW7YIr5wZGeKi5l+oJ+d39izAVwMxbGL3HKahPmeIogLihvWe4RMflNlNPsVcLcAV9Wc4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846574; c=relaxed/simple;
	bh=a/zyIEvLQc/XUbs4Regz+PNxwhBjl1k4o/jZih5gfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9bFrDpjiPwM2oSSEZWOwSKtNekRWg2CMbkqk1jOTB3J239LeqaV2uRfnsQXBHNW27E4zTTH2h0+m78PFiTdAE7foN4vNbg6HqmatMwgEqMcAYRYrs7cqx9P28DcENnNPGJXcwuWsPqnGyq70sfkpCwfhRDsqUDDRJ0SHAt5RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IviUWeXs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IviUWeXs"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1466738a91.2
        for <gfs2@lists.linux.dev>; Thu, 25 Sep 2025 17:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846572; x=1759451372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=IviUWeXs25Yrbzy9Pm0ZZMadiy//17uPx5UQ0TP3fFjVSkwlLJCGtALfYXHESIkrG5
         sTQ24yNxRRVc9MwSZ7eexbH5lVfWfqHEgJC61HvtsQ5/QMDa/M8HRkCFdjjjJD3+aBu4
         M8ZCV5cvCNOHmQ0EDJdC1dyzUONh+RpUeJtJi1ItW7Cgw9RcuJVytd6tiNsdASi3ajdN
         CDo+P8S4bd/6Ey+/Tg0Wvib67cltLLqT2JwovjPciX9m3g6/il/LIvt88fWsM0d68ubJ
         NwMUwCsw9+xzjko2/XgIlfklRoQu6FXCnEMa40eqJZSWdPWpOQLAA5rs9KS85vvfvhwb
         Kzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846572; x=1759451372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=Fhy8dWBpJkTf07XS4eB9fkKoM1s+2sijzyozAXiTizngbwAUbV1W6MiVIQekp6afvw
         jSjzfTeZW8LlYAlKI/Wp3/Q40/wihL22AvVml1D7GsRVXXTlKI0vHQMAmWFKYYSeNVB+
         4T60LPQsxLFZACoyNorrVxJhaUQRK2622HWOILbW6z2PMDthIlNzf2iUKrLOCxXd4uYZ
         l8u8GrNzVz/al1LMGCTjgKVEZgrs5K50nMhFj7m6GVoI9YozNvWqHDdgL80YWwvvSDU4
         u4bppaDS7tlTkZvTN41nmJ3Jp9U8y8y5+ry7UjO/CNUzm5ilhGMJQ26xrESKhDFHmu7i
         Er4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQsAVSRnHwKxMtG0IvnKMPsaRXoLu1VJtVUW7oWhvRTZZJbOZL7URHSbChGgWm1yopvQGa@lists.linux.dev
X-Gm-Message-State: AOJu0Yyondnasrr5akLAbBd8wbd1WoGZ90Dh4eAmNP9BDan0aS9R4d4Z
	AbwNbKLZdtuofh1iAhheYiNJ/u3gRdoaqFwp43X9svr/hnCAqx+xzvLu
X-Gm-Gg: ASbGnctr4UeZKdpoOheS495x9lkJRQc7DagwGfcTV4M5GGhsocXlgPg90ndz04e8gSE
	zfMi0xdzlM/QHNJyrbZlmZOMTXm3TnSEtKbx+KCUevSQkEGOvFoRuufD51PDE8wJ5dgdOWZEj88
	D7g/brc3YyH2NFevETZhpDJ553InV4cnHcIjar39oA7NIp/cLENvR1VZH6zhrg75tRbfdXCxL1Z
	Mk4eUNkMZSFCem5VixfCdsvWAcaunQ9rhZlUcl1xR/+79JFV1BJ8goZzX4UbknklwaMQGmOjGga
	cpqjoHDUzej30Zsmn+ShWdA94yniINphUTPTyWgp9/oIGEtFh+FnPzpwKQWbN5ZD6daugD3jKog
	8OCdYlR+/mjIokjN7IJ+c4KsypEUmP2xwWLxxZ+Xv1W56GaE3
X-Google-Smtp-Source: AGHT+IETu8Xg6FKNcFj6KdxYVe833AhhKxJaGKFG0k6oD3PiYvStleW8dB/qiT8f+QPOWW4g7bx/lg==
X-Received: by 2002:a17:90b:4d82:b0:332:afb1:d050 with SMTP id 98e67ed59e1d1-3342a28c02amr5853259a91.14.1758846571573;
        Thu, 25 Sep 2025 17:29:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53babe8sm3275923a12.6.2025.09.25.17.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:31 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 04/14] iomap: iterate over folio mapping in iomap_readpage_iter()
Date: Thu, 25 Sep 2025 17:25:59 -0700
Message-ID: <20250926002609.1302233-5-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges of a folio mapping in a single call
to iomap_readpage_iter() instead of leaving the partial iteration to the
caller.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b06b532033ad..dbe5783ee68c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -439,41 +440,35 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_bio_read_folio_range(iter, ctx, pos, plen);
-	}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
+				&plen);
 
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, length);
-}
+		count = pos - iter->pos + plen;
+		if (WARN_ON_ONCE(count > length))
+			return -EIO;
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (plen == 0)
+			return iomap_iter_advance(iter, count);
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		/* zero post-eof blocks as the page may be mapped */
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+		}
+
+		ret = iomap_iter_advance(iter, count);
 		if (ret)
 			return ret;
+		length -= count;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -492,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -522,6 +517,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
+			if (WARN_ON_ONCE(!ctx->cur_folio))
+				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
-- 
2.47.3

