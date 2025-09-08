Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9031C59A
	for <gfs2@lists.linux.dev>; Mon,  8 Sep 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357549; cv=none; b=Q8+Td4RNaZ7vjfzJQgohbtS6ae5s2uhjnQilpLAc82onU0k7IKiCS9KaaCiqsqSfALniHQd92dKMK+geMfQ0LZnlG1bxePOzoeRMPIMwAcnHkOAvrJIwy+Xxqr6UNvcAMXI9TWaJBA9LYHEPop5RajkUF+ASOMRFh375SYS15A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357549; c=relaxed/simple;
	bh=Vf0sfQGa9NYJS5wi+GNi6XmHISQSVuhQBlSiZgVnGAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgTfEAJ1AWewgege7K47u5jCdF9OB/732Xl/4bj20kISPUKqI7Rx0kfpajf17YNqCNPN5NCuHCxcJJaCDoIjeiMZBIH8SDuCoGxctlKPOLPYn33bxbp+sRZEcvIelo3Bb1Lcx4vhg0xsJ9Yf4rqIZYnU5BxNKK82JhRaoIN4Oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McyuA/lQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McyuA/lQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24eb713b2dfso27980525ad.0
        for <gfs2@lists.linux.dev>; Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357547; x=1757962347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz0e46H0Amt2P31x/YJ/3yAHE3DoTD0Pj8b5/EZ9tLo=;
        b=McyuA/lQ3+BWUbRnG+Lni/+sD26xHXOGLZpjkWFIMdw3NXFKIkUGjKU0L83kJkWxNP
         ENY/TqrXG6bVQnuZlhcFWuQVyTebzu3/4TiJtOYmPpGCHl63AAiVUcaAfEAbNGYsodlU
         6kj1Vv2arEgv48heC9EXkNxHNs0lsI+AtZWFuIQMQ08wcYhE91ud0FJt9uWYkJmmSDIi
         nj6VbrEXZO+Y8q+mPFZx5FXyqewyQntI/5HftgqWbJYU+3InvCVNO96bl5bXocL+SjA2
         re/NETrtuc88DYfie4MfpIn6JVRDdIcShrAJWgkMhRGhGHqhus36+n7Pt4sSRUu1JQLF
         G8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357547; x=1757962347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz0e46H0Amt2P31x/YJ/3yAHE3DoTD0Pj8b5/EZ9tLo=;
        b=LhswbLtMddRrt38wJdfB8URYuUe5L9fk6RDdVPjVgdJxZso6DpbF7zCC2BekFi3/K8
         Bi+DuEFAgSFW1Dn2n54QMfeealyV7IG9EHyFxQFcRDOi9BJv4UXIJoc/hvN30QU39gPz
         dy4Olp6a8RyvtP61sSxgSM42KW6/gqqAJDJSLj8kpmyPTUFfXHkOIJyLMCQIuRNl+rYZ
         MOGsOty+6PHQEdVfTGriO+Fyya1MKZNNHZCVoNQLvjWdKF/1OLz4+y/HMF3agBAFFBwd
         EimohvdJQhV5/TYaP4qDDE4nedDpQHmyFh71N6QaGDy+KOpJfMsx8yWpmVVuehpcBCaD
         3ktg==
X-Forwarded-Encrypted: i=1; AJvYcCWSlcrUXbM5j9l8VhTFYl7lh7SLbFFVftEneF8m0WehCuwvWAJC5QD23KBChzI09tgtziOM@lists.linux.dev
X-Gm-Message-State: AOJu0YzsLwfmIR2SbnVhZsJS/MKvDomKOhx4nBv+nngwA/5q3pXjTOpV
	LEnd4aCeXYoEVn74tYayMFbcGvj4ub3hWi8F5V1yE0DvpQKKCrUTIUl+
X-Gm-Gg: ASbGncsl6UN6or5DJulxDf8oAstRYbrVuV6J1sBo0Owzk1vaXh7Qh+QQ7XQHzWiWL13
	53Bm+/Id6gEkpbzCPPHN3kLCRXMrJFwgt2xVC/oBRYqmnjSTuPP0cpQzttIp6L0/N6Kb4L2PpM3
	FSg5Rqp8SxHhJLZ+9eJQdd+Ra1WHYG2Ze93GQzb8C0ojDSL5lFpr3UBm8F1++rkx/PqiQg6khAy
	zJnqouc5x0ZBMgf3QWmMLg7ThawwDt/cyAO+M5jcQr2RNKY+jzTVNwEJv2PUtCEgsnCzWuhIg/U
	4/qGoJOsi5shH4hhJp7bHk+7Bty+9e44ZQj2O1Cu+bLBxqwI7HbSV/WRIuzRFr+BPFLfrgl+owP
	9Icf0ulAVr+5KLc8Z
X-Google-Smtp-Source: AGHT+IE+l+BXURNmfdy0m2VV1VNkMDGB2osHHSSbmfc0bl8WNEUpwSDjnUBgNzIdhJAO7Jj04uFyrQ==
X-Received: by 2002:a17:902:d584:b0:24c:cfcc:1743 with SMTP id d9443c01a7336-251737d44efmr105556145ad.58.1757357547244;
        Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm190930565ad.138.2025.09.08.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
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
Subject: [PATCH v2 07/16] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Mon,  8 Sep 2025 11:51:13 -0700
Message-ID: <20250908185122.3199171-8-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fc8fa24ae7db..c376a793e4c5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -423,7 +423,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -484,7 +484,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_submit_read_bio(&ctx);
 
@@ -511,7 +511,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
 		ctx->folio_owned = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

