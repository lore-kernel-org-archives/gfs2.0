Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047D3446BC
	for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445226; cv=none; b=G7uGJB7HmTgdp+AVCrM1LJjlqhxH1MMw8iDRqAxsZs6XuqDioG5ufK0gZ9CcGUki1HnNDf2179pDzfbCZRt2rkEivJ/tjmp1OxsHPyPDATsj/IhoSOeLWdQe9Z3ApfAfYPaRBjPdjvhEkLkcISdrkNh/vfrhlxRz6zMv1qCwsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445226; c=relaxed/simple;
	bh=aBhzfqfbVT4tlgc9EYum7W0bOLioD/FY2EzkMr3vbfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utu+PFmALHJSVePLdALpdgiQTS9CqF+b8Y5pH6dnDrNxhfOStK3V9mjGKSvgnQUnHbDdRv+QG17rOepO+CnUc39B3UzyyKewMzwjGwLBN85O8Gdok6N2D5R3PoKtoZ+TvmCRo1ktNEjc0COYpwqzuRCdybiqU53R2EgK+QE95bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIASc4tU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIASc4tU"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794f701a3e6so2126897b3.2
        for <gfs2@lists.linux.dev>; Wed, 18 Feb 2026 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445224; x=1772050024; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzFBOFx15rx8Wpt9w9ms8Y2WzKThMM4oOB+R1c01Qi8=;
        b=VIASc4tUC5oyi77jMStU2QOCtRhioKgRqXuH+zW4P843S3AGhU8a3mp6bqjvt6aGMr
         CaczjpfK3zyxOjHUdgQoaNnUSG8HoyUKifZSJc7GKG+S8ggNpnnaQ1hYTPMQCSq17d2Y
         RvZBvE7lWzzD6M80Og7iPyaIT3pAt6CK3vHHBESgszhMlRIImagcUwt+KkdBwM4QnQx1
         j0ogamnD0CJq+vfeSrWq5uowyQyvWAn5sx088COkmn0rUc7MwZbh8KeSQlz2ulnSNZpo
         /le3nnE5eZ1gzBToCIykXUamajxsaX5t4ySgmF7PZAjSdLbDppUXBkNPnoa2VtLrHje8
         9NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445224; x=1772050024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzFBOFx15rx8Wpt9w9ms8Y2WzKThMM4oOB+R1c01Qi8=;
        b=W/+kCSIP6fX6gsrRCbfC0V1zt6RheLB4AefzyaU8XzCxyDR5ETBqKMHbLmGR1gjujN
         8XYpc/eNyrkU82qjhA3tG4i9PnY7laoAnTqyJztIdwuTdq2cepIzJ4SnqstfIh/hd6CI
         UnuFW+5CFc/G4RrdVCpv8ctdlzX9HcGuRGhmVOqUZLRDCRTFTrG25fG7OfZ7gg9dSSQA
         tlaFiT7x0ZIj+kgkNCt24Vh1H44kVOaKhAQ+Byy4o7S3DRP0HkSnBnkUM+FmJ/GieXGT
         amh/C8OovJvqUtlAEkj57ksYo+ZzZoIaogzwSUltJxBwsbMn41zbDVknTL3sjVlUFKST
         1ebg==
X-Forwarded-Encrypted: i=1; AJvYcCWt0riH4qVPdadVK+aqS7D4NbduaCy0cG9f1Uy4k764IL0Zpqh6QPa8qmwxNETUNgEleDOw@lists.linux.dev
X-Gm-Message-State: AOJu0YwhUaFYrXXw4jq2d34VY+Dgh6Slm+pjJo44ATIG3i7NUxj5Hm8r
	Ne8mv5WgZfUWB2x5UqROxkidCIa3uLPAt1X6AftQHISyDFmDdSU4SE8G
X-Gm-Gg: AZuq6aIMBKinA7h5jrQXBdJHgj/HcTnOxFsfLRBnPKwp0lZi0Nv6uiQonE6hR09MFg9
	QB/TcK/hqGI41Py6qWdPRT2fjNSaEdSjPep2QXc17aWjOyDW5Efaq0D8ci2GS3F3hJ7Vu2ZCr0l
	pfthhTZ7zQvT78DKH20U7sl1lIsop8kpCk8Jn4JBqyTLMJe+B/vgAKNPEUkBiBBo5LDqa6GlEB/
	xdICqldqC0i0Bj2sqh1nBsYK3msxlCEghHOlaPvULK5z8FYRYEOSywU4562Kdwll59WYDqyVDCd
	KLjbC3pxh8zvW1b39hKJewUGok3o4bBDRdTlA5F2SHYFO/tBledknyZfcy1OIcqWibf1/T670tm
	jaPuZYvdCcBpvdF9DPFMjUHzoSOZFpZ7hBV8tLLC/01uqlJjQuSfnb5dyZOQuzRBrsGS4AIyI0a
	fJdsoUHNeQ0gOnaGTAD4tsCI6p1XPevbshuJxAlX7ZjUDDieITb1TVS4C29Jhte1PtGidn2nXd3
	vFEqYaWEowPdHFWjIzf5oq+CaGP3nwNrPn94IfHcPk=
X-Received: by 2002:a05:690c:9a90:b0:794:d44c:866c with SMTP id 00721157ae682-79803d19d87mr4675757b3.60.1771445223871;
        Wed, 18 Feb 2026 12:07:03 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c023be7sm125920237b3.0.2026.02.18.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:07:03 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] gfs2: Fix error pointer dereference
Date: Wed, 18 Feb 2026 14:06:45 -0600
Message-ID: <20260218200645.15713-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function __filemap_get_folio() can return an error pointer and is
not checked for one. Add check for error pointer.

Detected by Smatch:
fs/gfs2/meta_io.c:147 gfs2_getbuf() error:
'folio' dereferencing possible ERR_PTR()

Fixes: 0eb751791df86 ("gfs2: convert gfs2_getbuf() to folios")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/gfs2/meta_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 3c8e4553102d..9c0ba4c3cb29 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -144,6 +144,8 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 		folio = __filemap_get_folio(mapping, index,
 				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
+		if (IS_ERR(folio))
+			return NULL;
 		bh = folio_buffers(folio);
 		if (!bh)
 			bh = create_empty_buffers(folio,
-- 
2.53.0

