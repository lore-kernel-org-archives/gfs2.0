Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E12D7DFA
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066635; cv=none; b=uXoHdTkSRwD366P5yXwkac8XHsxRyOvH9jF36FrM5Po0iMhqH2nWsG8C6SWdDu3ZNqyafKfE/CbUuC/pswionZjn/VCrh5jRYkHoQ514X/hgD7VFCgvIFQ7GkkbGtzVgz/w3+2kjDp6ZzC/fQyqFNkiENOw3YoaPQ+zmp9C6As4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066635; c=relaxed/simple;
	bh=ZHh5Aoj2S2I/9stdudNSxl02KoF0A8sv8D1PC9opnSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/J1Y2JMApYvg4N5F5frxMxft2UnTdTeUfcKYQ5Rbi9iL3yI+jeWIa9xqNL1Tybnmfq9iYyWZnjhfvQjDzZT3Q8Q5I2dUnDdk+yvsKX5tgPoPqSQ5uVCD7qhjP+VN/iY4kxzxz5V1F2r0IqxgSi7p+uBLh1toQGofA9zJYTqfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXFwJYmO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXFwJYmO"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so4690898b3a.3
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066633; x=1758671433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL16gHrgiHX13VM701419cqvxPOFfSZ8+kJ1tFZqH7A=;
        b=KXFwJYmOdiaGjOofBmezoHUqouPeLEuSkO20Z9+2lFQPxJ0wgugiPVj8O4E7pxsf24
         mGc/iWBsW9UlYoUMClWzB0kIIYEZdGEDIUHISwjnO4TbZy1itrNugaDQ2XFUyZvEpLxP
         GKZLwTzeEaBI8yxcXkFmgvIo/TArAFX2t1XUKVRZ4J+J718rwYcUPeL4YKBrqyPAnDUl
         3zs6P8uLSFPpwFb/08aeNgQCMCwHLS2/mfAR9zgC3X+xtA4lMwuAsuKnBOkhFSr0Xpix
         Yn2ebGhxfemabOe8ZdhJH+9u2qzk5717VAc46Hs0JmzebDdMNAUWvbYC0cDu14EiSBZr
         J9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066633; x=1758671433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL16gHrgiHX13VM701419cqvxPOFfSZ8+kJ1tFZqH7A=;
        b=Gm7VmTEdhFFeCys0cuIbnwnJUKq8NoM+apDgY1C5pvC4XEH7H2otYIy2eBtRfkjhim
         fRLJamb5K2MBTaMHWU0VLYhugzsb4n9wvvpGyl1DEyrwxnFFBlrVAPFEQZuOSnV6Nvsp
         dvzZBU6p/ELRlbNnEDBLtrSwLllnGkCuqSm7NPybJIRrVpRSxhOuOxmS5D0Muny6l17M
         xlm+/7+RRKea/GOhy/UglAGUQCXsZoO0n275sat/MPZtHGrMp+9cCNj2DckqyGYPbXCM
         6iyRZrvqwbcZAdyBFrvysg2tdWWcsNZXznuXQQxvJ/K1qmwUAnd5XcuCFJrMgs1dV8VU
         H3jg==
X-Forwarded-Encrypted: i=1; AJvYcCVRrul1foKg622RmgEEvxrz9g0gV4b75oMy/I82RFYwdVgIN7GQY6mWJfScdSsaiu4CiB7W@lists.linux.dev
X-Gm-Message-State: AOJu0YygPiqtEbOzEq/BOsGDXaOAlvx9DFIDAy4E43FbS+EzAsfn45as
	b3fhtSCUO9SiIxrahnJfFz33aiZPhL+OQCWsUJdiR6Hgsj0aS53kkLO6
X-Gm-Gg: ASbGncuo0v6WF2L2WQgpAemJSDvwK7nJLkpKjt+nhiPw+q+Gbjx3Kd8ZUoffebV/q86
	7XirSpkHA/l8U+acKicxnNHgHhGojOWi1XynVS8TkfDDDzouXCUC3Xja4Ec/i6a9fhdG4cjzR/O
	IGvcad8oUhRyrv7HXeufsI0oEiZOhqheyqqXI+es/POlM+JDUUWZKNq4QHoTaQ3ZDl9l7tcWFNf
	B+j9dbg0VoKb6NKo7fYSt5dslusIbLcEexSnjsCS2pfUA1QwgMD7AWqlZDfw1VuXY3gLGErsBdD
	lzvR577/ceFMaA/GEr9DrXglv7Y9qRiGp3iCt0uZDXqbo62bIoFKEf0Naisb5FIkXIIqB5dEK1q
	RR2Ff9DR2q7GM57mD9yWbYsddczh0k2r33gKdYXVFqaPt+YWv2A==
X-Google-Smtp-Source: AGHT+IHZm7Yh1fz6JZu1L3xEnGn7JMKrOXnTZumBizZxvxbg3JjAtN8zElKhbjwsHr97+f7iaLVWWw==
X-Received: by 2002:a05:6a21:6d9f:b0:24d:9042:c856 with SMTP id adf61e73a8af0-27a97701057mr76284637.17.1758066632972;
        Tue, 16 Sep 2025 16:50:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm15282161a12.33.2025.09.16.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:32 -0700 (PDT)
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
Subject: [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_iter()
Date: Tue, 16 Sep 2025 16:44:14 -0700
Message-ID: <20250916234425.1274735-5-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges in a single call to
iomap_readpage_iter() instead of leaving the partial folio iteration to
the caller.

This will be useful for supporting caller-provided async folio read
callbacks (added in later commit) because that will require tracking
when the first and last async read request for a folio is sent, in order
to prevent premature read completion of the folio.

This additionally makes the iomap_readahead_iter() logic a bit simpler.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 69 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2a1709e0757b..0c4ba2a63490 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -420,6 +420,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -431,39 +432,33 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 
 	/* zero post-eof blocks as the page may be mapped */
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
-	return iomap_iter_advance(iter, &length);
-}
+		count = pos - iter->pos + plen;
+		if (WARN_ON_ONCE(count > length))
+			return -EIO;
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (plen == 0)
+			return iomap_iter_advance(iter, &count);
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+		}
+
+		length -= count;
+		ret = iomap_iter_advance(iter, &count);
 		if (ret)
 			return ret;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -482,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -504,16 +499,16 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->cur_folio_in_bio)
-				folio_unlock(ctx->cur_folio);
-			ctx->cur_folio = NULL;
-		}
-		if (!ctx->cur_folio) {
-			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->cur_folio_in_bio = false;
-		}
+		if (ctx->cur_folio && !ctx->cur_folio_in_bio)
+			folio_unlock(ctx->cur_folio);
+		ctx->cur_folio = readahead_folio(ctx->rac);
+		/*
+		 * We should never in practice hit this case since the iter
+		 * length matches the readahead length.
+		 */
+		if (WARN_ON_ONCE(!ctx->cur_folio))
+			return -EINVAL;
+		ctx->cur_folio_in_bio = false;
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
 			return ret;
-- 
2.47.3

