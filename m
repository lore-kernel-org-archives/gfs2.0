Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BD202C46
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731782; cv=none; b=O2HPsqWybbwvo30cb7o7R097T8cPb0CoIP1g38COHe8+rowf8x+YHc2dXWN7lgmoZpZ6c07zK3S9OtLoWnUm4n1HzaWXkeNBdQHi/ZtTQyc1PkD7M5cqP0fkVRQN9Z3YqHgAjHu/15FeivmzmcDMti234n42JohhgvkiI8YkfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731782; c=relaxed/simple;
	bh=bgI5aM7q9s1dDFn8N9JMw8Zt74AcFrVNaXjWC9Ilv6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAkMxLTwtCTiHHProfZpdNz/87zzl/WjYEsczLfbVvYf5DjIaMO+SrYmgf5uTAss2PSYqX986SrEzhxwNe1MSZre+pgUKzC0duqxmApanWJFFX1S/VxOwK41jE5BSaT5uY+6wCAma7taw6zoJroczrnB1Gmvh472Ryrn2qwIshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBA6/Rzp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBA6/Rzp"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so44660345ad.1
        for <gfs2@lists.linux.dev>; Mon, 23 Jun 2025 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731780; x=1751336580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IETc+Vke7pqtXY+tQ/orHCelym8kNJNTtoeGrsW0BVA=;
        b=XBA6/RzpGi5msRs1yW5tdSAQv+Nr1QNt+m2NrscuvjW+K0ag5IN8iCJKlZQ7i6jD7P
         L2BpbkvDG+rjNH4HqeyM5boZVuakuAK09GpA4zB4Fie3R1GSmBUU0rnRIc49WO3HytMy
         vTMlqZdotLURtqZZquBve/tMZUEyyrcq6HD9VKIXzbKEi9tvf5U4Xk20HcnnjvUSU64k
         q/YGMyev3Vx0zWeUZXTmCMQCg0m4cm0Y/ZPODLK7bi1OwjHsqQVL4Y1n/0GzcG5crgDX
         Gh9WyG7aRVnnYV6scTxZ2ag3Uf1uKyLeWSjpaGLbLp7wj5O7lJrA6eYnw1XbpKPLvHj0
         038g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731780; x=1751336580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IETc+Vke7pqtXY+tQ/orHCelym8kNJNTtoeGrsW0BVA=;
        b=MBEFbEaDugoMaEopUUdZmJYOq8ey9Kh2bVJxkLcVL270pq2IBpVDORAziYHg59ICBQ
         goR5Sa4+0wFZYWalSVHEujkpui2yhp37C8tfPGbHQElAl1GVATHuYTCZlJKGLakV5Bv0
         MWBxFr19hvRamkm2n8eSsPYGoV3kuoMpnxEqJvvzsPZAnTjX+s4hyW8BXxX3ToXOOoM6
         bJ8bBgQkNkjtvCh93T2xoWELlzPvs9nH2ITvIGEb33sAh69umkBCXpOs6uKeRzoRekLo
         8782PlpiwZeRUdgg+Jijl3c7PW9fuQr9GCKC20GOBxGKCzMkzBoypBgPygsxCfHIiok+
         rUxg==
X-Forwarded-Encrypted: i=1; AJvYcCWrcRsZjxb49hGjVWJxrPY1F1wIqESxjyUjv1ad4+8F3B5EwJW6nUa6YD4Ara9rIpz18dAv@lists.linux.dev
X-Gm-Message-State: AOJu0YzubR9CWRLmjwCdw7uf2oZIsLgjJe83wtKAeCy0OtbHiMDJHM/6
	GH9FKCLGT4NHz24vsdrVuTCbzqDJD0jMwo8xwh26dis6YhOPuoAR2y0e
X-Gm-Gg: ASbGncuNmxHJYuZ/7bdI/GOBJ/eBPV0JHKFRDrZvf/zuPzxMbW2CFHGfUh90D1ZvwBa
	avLK1oJMEDP5lcy/HVAxi0IotgzgVFYxzwg9K1U1hGB4JPXL82e9t1M/SWiB82E9IM9Uy/6gq3n
	oxP3CjjlGZWzBvRZmlKPf1bfCK5xm0f2pLpeKJDvRjVvwgJF4dk1pYcCvrquSXgwx9kHawzSfyg
	AcVBUimY0vbsPVIfEuYmf3Q6SSBbDZioQgbyuJIA/yeCdkmIexMO7ovF0S+mSCUUHclHL4RHZny
	tcDA9O4XKahuF/VHUIsmzX+6Hv+TEwlyEMZHmTKZYLbClZfq+hm4Xinl
X-Google-Smtp-Source: AGHT+IHCkHeapeuEFLZu6oqm8JyA0jqOksNmIyW1sEaDYbkw3ivQkjlPo7L+ZEOJ4SyNnTu71NSVSg==
X-Received: by 2002:a17:90b:2c85:b0:312:639:a062 with SMTP id 98e67ed59e1d1-3159d8c8ec2mr27173741a91.16.1750731780525;
        Mon, 23 Jun 2025 19:23:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71d49sm9368112a91.5.2025.06.23.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:00 -0700 (PDT)
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
Subject: [PATCH v3 02/16] iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
Date: Mon, 23 Jun 2025 19:21:21 -0700
Message-ID: <20250624022135.832899-3-joannelkoong@gmail.com>
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

We don't care about the count of outstanding ioends, just if there is one.
Replace the count variable passed to iomap_writepage_map_blocks with a
boolean to make that more clear.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: rename the variable, update the commit message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71ad17bf827f..11a55da26a6f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1758,7 +1758,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
-		unsigned *count)
+		bool *wb_pending)
 {
 	int error;
 
@@ -1786,7 +1786,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
 					map_len);
 			if (!error)
-				(*count)++;
+				*wb_pending = true;
 			break;
 		}
 		dirty_len -= map_len;
@@ -1873,7 +1873,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	unsigned count = 0;
+	bool wb_pending = false;
 	int error = 0;
 	u32 rlen;
 
@@ -1917,13 +1917,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
-				rlen, &count);
+				rlen, &wb_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (count)
+	if (wb_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1945,7 +1945,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		if (!wb_pending)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
-- 
2.47.1

