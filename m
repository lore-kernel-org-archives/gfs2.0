Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5631E2614
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587642; cv=none; b=fJdpmLNfsj32b2ektXv+b6uR9ubB/wMtT/csQN+oFBGKKxTzrDbW9aDTSc9i5mWcMN2ZlcWN2Db5C2I6COFJuDmVDTyTAYFq8fKnUqCZGhG2XNEbRQ1rQ3fJ34REHx80wRY0bdeaCCJD++A+Lh0eYjdnCqnfM7wiZnVp5gxTLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587642; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt2Y2rKFuNNrPVRZgDcRpD125UisLCCBkYW/7qH46/8ea20IGfMyzsDwm2hRfXHC8gNKjyrAIjwybRgI7NbAjVa96hICcg7QYMSDt+TCefBFrgiOX9Xr2bTzWgqo8YF/8HlRcNJ4WV6+qorEV0DVrhbFuCxnEvAJpxjouM3hmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iELlWvXc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iELlWvXc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so95785ad.2
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587640; x=1759192440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=iELlWvXcM2GNb0it8uZqLqnak8pn9oDiMuCrXcR+RvIKchO4Fr8+xqVmHfJIcNcefu
         72FNaaej8/y+keRJXakglKzIU4uEJ13Ybd91D1AW3XBy9ceWq8kVMquCVPjivnnb2KyJ
         2l96swhBQN4dRK+0W7KuqQtchR+bxuKyDxAJ0y6DSjmAwl43P5JJ/omSAzN2Bk259q9/
         z+OnyQ6mY9RyizzrWHNtpeqjS96NFtCHLKCVUQe2uzFXcnP1vbiNt0K8GF/pSpnb8hkW
         lr0y/eVUq5+up+r0oci0r02lubU+XFbOj44VIibqKtzMrIRJ5jT4rkl0HA0tfW1RpUoV
         Bt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587640; x=1759192440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=k/N1UK61j90/dZ6wcocxND2Byn1EdWkdw2RJIHAGrM9Tu/MYPu5Ai59b8npCrukO9z
         r9RQ+IyrrVGFEwiK9pffAVDa5PmOw1o6kPWm6oY0JJqdW0gpPNWIPmAx004uXBbViIM7
         wzp9wgxtZd38QiYwCHch6MNaxjBp8gTl+GRES1Kx53xqkujTmr3CLX7MeAWJmBy0CiET
         B27GKcIw6BiJ9PlGK4ZZdZRiOJyhomv1J5VzyA0QAwn/5lKJqblODaSQRK5r4xdgKX1N
         dtPCW0JbBq+yWVID7iKTH1c9MNDvHJOt/73wv03zAC6U7Y/TOz/0/7fb8WHG/KciJKeu
         0y4w==
X-Forwarded-Encrypted: i=1; AJvYcCUkXlSsfxFHslzTAuQm+Cy5IieLB8uBfM1ICX0+dD3O1EycyIfmXSUjSkZ4atYMJY/+ve0+@lists.linux.dev
X-Gm-Message-State: AOJu0YzDtoNhoubrkGwLXJXT/2IQUgUoF8RN4oAIsMMib+Tyh9GcFi+G
	SCP/3mx7mjGgjKk4AFdvcwvGAc4YG8yub5uYPrKzRwH08558hlL5DXSE
X-Gm-Gg: ASbGncu0lkK9SF0dNzm9c7/7vjzrDW8mmKYWZjuxZLTKv3FgehQ0GWb6jkS9dFqPALy
	5qZ0gznd51qV3cW9xWOpm0SP1jDSGoDnFK56i/UNzTwToB96cbrQ0hrrLuEl+7o8E1Vjr/YEdjV
	YIf8oqr0w09nz5LPW4yI4wPedKZnF6WS8qfx9zEV5rgjDWXzV5+p9f/LCY3jZDKc/nhiG71SSb2
	Xv00ifbXlOvPfFxO/7DAVNoZvof9j+G1Hsn3cvkZp0CWa0L8Z6fHlRIpmegTEakdR9/tvz658eO
	/cQ+6epKziU5e2waRKhabvRhDMr2zZo3UOxcXxiuL9xaR6bDVBQF5lp7UJ+9qjeYIErz5B8GwaC
	1p2lJfd8OH8m1eSGzuQEkor42Qn/ugtReVdnoAWYf+U+xf35n
X-Google-Smtp-Source: AGHT+IE09TVUGqvhRnJ0j5/kebD7MODetqdlA1rNkjmRk63jDyjVyF8TO49tFsaKOOBbleAow9Cquw==
X-Received: by 2002:a17:903:1209:b0:24f:dbe7:73a2 with SMTP id d9443c01a7336-27cc580deebmr7891545ad.31.1758587639758;
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm143588125ad.56.2025.09.22.17.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:59 -0700 (PDT)
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
Subject: [PATCH v4 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Mon, 22 Sep 2025 17:23:43 -0700
Message-ID: <20250923002353.2961514-6-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3

