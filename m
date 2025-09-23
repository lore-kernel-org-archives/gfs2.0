Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35754202961
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587649; cv=none; b=ULDw0TbZmQZEFtORfQ2WBGtRAcm9ZlFv3OfXnVpZnS/9iUt1fL1CKauoFQ4Pz/LNoq0e7+NvMUiGgHvfmIzsTPYy+JXDSg2vTr80T6iOQfPdWpRaum5e8ppXVYJTtGfLZumpbnypySPcNoLwAb8NHMtHWHOrdDDZVvSvznveC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587649; c=relaxed/simple;
	bh=yLj6g5WJ4PjAjFCvmn5JiB1GDCM8kZxAtJld1CzxfWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE5HfURgtLje843OZFSzy+tVsC1TY2Jd4u2SiWkKJKEAEM9U84MqCCrScqVf5y3d28Lk8etL92r3T5dO+YHdvOmtu6ZLHv573U9FFTBKy1fJneUG/cj349zcfAt8o0oYxHcoKAZd/aKwVAbtjlztw/PASHE8+AuQm30TJMPWLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHfCpiyC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHfCpiyC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267dff524d1so37089905ad.3
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587646; x=1759192446; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntuDtvvcxXIwL9deTSqYzeD3zNqVLETNsiY99SSIRBw=;
        b=mHfCpiyCCu9RHRsSnLshytLGfyFVf821d1zjgXuGO4CW5J1H9o25P6K4895tvw7RNN
         inQ2M4Zx7sHvwn6TH74wZBIRAHWJa103ZNMCOTkwhpBQUJYBPETaitiidbIEOxYx/C1q
         DUe7e6jYW5VV8SQ8JrZUdK8MV9kIs8cnfrHWPMuJYIh0U6y2h5zVcG97l3TzeGyeYMm/
         7O313iqIluZ/Ph7kcurB4tlfjOgwX3MeDKc3/VptTDPTEV9/g0nNbkjx89eHVxQyqte7
         BKlbl2kyJ5hTm9arCwlbgFtwR9Gn2Wvqy/lMQCxNPvy0axpjFH0dRXjvhY6zaRxQw4aL
         mhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587646; x=1759192446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntuDtvvcxXIwL9deTSqYzeD3zNqVLETNsiY99SSIRBw=;
        b=XBsnKqN/DgAPjqNuQe6M6jJMfy8kaiVqBEYG2w3zOt+HImnjSvzBekS5Qw1qSZFyT7
         WXFh5uqSFfAWMDrYkCvDIt82ZdrfXD8sutldpAXV/T2ERV48iwsmUfZS8Aq4u5HEmYfr
         A9PCpYrOEAi0aVWcnl4nK47gpM5ockvVD1pSLZUZCuQAX7rwOhG4oAGU5fot/tMS8LIj
         uI9gPK02/FQn3BLS+A++UzWECgg/Q0JlZLQVmaQGW7kFJDGkfM1XMF1b5bsUIQIoT1n7
         vE6/3zUYCW46OMfIy1aRycf4CnUEdkHe139Zq8fwEGHn42KaGNsqD/Hrfub//04SQyXb
         nqMw==
X-Forwarded-Encrypted: i=1; AJvYcCVVj9TQZuEWL0if0ulqLk+qcFHNabMIKtvEW5YonguTzO45BsGxbjdDwVPM81G/+85267rY@lists.linux.dev
X-Gm-Message-State: AOJu0YxZd0opsKLtmopun+LqtTwzEPovRxesPJreQK5JK4K6TnLFhLYh
	crnoU+e5SDVl71jLp0DL0thaXIsAIEbbp1/fmcHRSoV2VwJ5RCZOYoOS
X-Gm-Gg: ASbGnctW2kBOMWsGQIxYrB4+cQd3GSpbLJ28Pzt0oKyzJbN3ipeiqjfxQZCa+/Cb93P
	tXc6VSd6tgGY12AoaJ6oWDo7FvPSLH151mu4BWcZKFu9OMO9n4bqnjPR3leruR102SiGjDUCFG/
	uTD3VEwHRfryEgJs3SQJ/GiqAVW0VPKr3qBpNcsi545lOeyE4eMm2zgGk48mH/GyA2bJdjxmKzR
	iaL7MD1C8JGsY1v6ElBdsYiFQYl+gFbZiTzh61EKEpZbYdv8nO9iOd1lu9v/dZeWODWiJpqOvzM
	5e1kY/TNEKfBzmTrg3OI+HM++D4wJEE/4GAn7rMkazT38m9oQl1zIszwng/lyphbHJQ6r1QEEug
	VcpRH6LXWiMPC4Cj2kIvcEj/aTX/89CutseHV5uRcYoYLCM8GQZHy3nSi0tcr
X-Google-Smtp-Source: AGHT+IEhTnBUYl+j3KLiqlpxHUCI/vnvNAMZQ6XSvAN+3hktfXKpSSHFQfOmtaK7JIZM3c79iCAhNw==
X-Received: by 2002:a17:902:ccd1:b0:269:74b6:8735 with SMTP id d9443c01a7336-27cc24e4231mr8951755ad.24.1758587646479;
        Mon, 22 Sep 2025 17:34:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053c88sm145125515ad.19.2025.09.22.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:06 -0700 (PDT)
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
	kernel-team@meta.com
Subject: [PATCH v4 10/15] iomap: add bias for async read requests
Date: Mon, 22 Sep 2025 17:23:48 -0700
Message-ID: <20250923002353.2961514-11-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c | 48 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 81ba0cc7705a..354819facfac 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,38 @@ const struct iomap_read_ops iomap_bio_read_ops = {
 };
 EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
 
+/*
+ * Add a bias to ifs->read_bytes_pending to prevent the read on the folio from
+ * being ended prematurely.
+ *
+ * Otherwise, if the ranges are read asynchronously and read requests are
+ * fulfilled on an ongoing basis, there is the possibility that the read on the
+ * folio may be prematurely ended if earlier async requests complete before the
+ * later ones have been issued.
+ */
+static void iomap_read_add_bias(struct iomap_iter *iter, struct folio *folio)
+{
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_start_folio_read(folio, 1);
+}
+
+static void iomap_read_remove_bias(struct folio *folio, bool folio_owned)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	bool end_read, uptodate;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending--;
+		end_read = !ifs->read_bytes_pending && folio_owned;
+		if (end_read)
+			uptodate = ifs_is_fully_uptodate(folio, ifs);
+		spin_unlock_irq(&ifs->state_lock);
+		if (end_read)
+			folio_end_read(folio, uptodate);
+	}
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
 {
@@ -448,8 +480,6 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	ifs_alloc(iter->inode, folio, iter->flags);
-
 	length = min_t(loff_t, length,
 			folio_size(folio) - offset_in_folio(folio, pos));
 	while (length) {
@@ -505,6 +535,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
+	iomap_read_add_bias(&iter, folio);
+
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&folio_owned);
@@ -512,6 +544,8 @@ int iomap_read_folio(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
+	iomap_read_remove_bias(folio, folio_owned);
+
 	if (!folio_owned)
 		folio_unlock(folio);
 
@@ -533,6 +567,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
+			iomap_read_remove_bias(ctx->cur_folio,
+					*cur_folio_owned);
 			if (!*cur_folio_owned)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
@@ -541,6 +577,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
+			iomap_read_add_bias(iter, ctx->cur_folio);
 			*cur_folio_owned = false;
 		}
 		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
@@ -590,8 +627,11 @@ void iomap_readahead(const struct iomap_ops *ops,
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	if (ctx->cur_folio && !cur_folio_owned)
-		folio_unlock(ctx->cur_folio);
+	if (ctx->cur_folio) {
+		iomap_read_remove_bias(ctx->cur_folio, cur_folio_owned);
+		if (!cur_folio_owned)
+			folio_unlock(ctx->cur_folio);
+	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3

