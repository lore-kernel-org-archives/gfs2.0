Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7D33C53C
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713101; cv=none; b=A9FiCJinWyWJwr8KMMbvjv7yqWjo0TY7T94haq88S2t8i3Y/cs+xlfIu4+H/30o5QyP4haPHx6yk2sDefr8XnIjLhW4astAp/F9Oy7Z5sXuKVE8Zxkw5sZ2GU6yPVI4UHToHquwXZr8ebOo2kvzvY0sdeTl4CkL73rJ9cFEuePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713101; c=relaxed/simple;
	bh=tcwWQ/Mm+gFAO+0q/5/zfPas5QNJ1LyCpxuvQ1Cp8pM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpQhnOJoBPxVoScONernOtonA1PfrEPB4SU4ueZbvvc0eOm5E8H2abrCVlOv+bVGl0NUgn5qaL6TlgmI6hU38d4DinbJeISWR6eB2JpQd/AGJClplLqQyby3EVOwfHPcb87BsH7sxXbkn6mfHrZcCRXW0abm3y18XeeFfc/UTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNI1+Y/w; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNI1+Y/w"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11b6bc976d6so2581271c88.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713098; x=1764317898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=eNI1+Y/wPjmnjeU9vEFxd3nWV6NqcqXaxUaU35gah+kfTRYZZTTsx3jCSs7f+lX+pM
         zEtHKWJ3iWi8cSyoim7uKM3dIgNCUFo+lMgTXJ5+Ch5P/jhrplCdUYaSLQTgY4UvzrKH
         3v101FcTZDdsLXuBPqJv0eCI3NXw0NUjmOfE6FN870zfw/TvKcHNPsPLibS0PsF61Nx2
         mICHaYXaG9Kgg/lIickWb+HsvirWnO5JV2j6EnRtjagHmI5ih1CGoH4D6nR9I89uMy0e
         26XS8R/pT1BYfz8eqsOyXkhrbZQFo0Mqv7A+rgQV0ANJuXyRBj/xojtlM99UvNvjst1r
         lIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713098; x=1764317898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=YEHgjFwRAjkCTKgIlBk5BojY0KwZeQs1OxSZ1u/9tho8cbcVhmGOiLIQgeXZ/D7ZXN
         oy/2HWfXUHfIs8PbatzvIRQrwveyVfqYmY0melYVu6ZY8fDvOE0kDCvMIDQtzD9ORj3z
         4/EaALe5aSx/ySW+Lye21t30cXX1KqqMWE5kf6Hp6Yv7vAMoOarbKLyEPiu6RQoemY5a
         LC0azlJwX9cWP4/Vh64ZqG2jQZ11ovnPK7V2d0OQ7pyOc++jd69v9Cy/s1h8YFfZwsaq
         SN1OIcpSUYYFGUvZizyr8gkMzZs1rmqyhLZ1LKxQMLqVD6XP+QoIp77DwdQ0iwvWDy3b
         CcPg==
X-Forwarded-Encrypted: i=1; AJvYcCVmiy7EoqnelGhgTICO3Ofc2KA2oHa1K04LHVZEYV60X9D57N5JTt82w+8IKjNKuO2630eg@lists.linux.dev
X-Gm-Message-State: AOJu0YwIgbfDQvzRWiVDzFphz/eLk+43zMBTui7iLgXBfoU0neLhCw26
	j1Vrvd0sNxOHE0Ry4wOd0Dr7fSgjcVNVrtzmavmj4V7m74z+PllmEviz
X-Gm-Gg: ASbGncvZEs6kUAQIHbX8jVf/hJYGTNJUqxJbrLEIa0HyS3B3ZdV2gJ+K++B9TmYqUMe
	Lo3IHZjTym+3Iurv3wPNdCJdWu5ERKX6Hs8pTY2IqNOHT/H238fpZaj1kPHjh8mRGcnZs7nTSyv
	dZdLZGm0ItQKedLAln9fssC05drGhnzQbPsbeXzXCE7+sJDP9u0eDXJWPw5E2Z8d5fIYfnGC7WB
	GwQKorhunyoDuYHIRXyEzdJX+t9lzivm02bue9+2uToeyM4zs786OmsJsH2IR/udkn7LocmGuil
	vTvpf+xOBQQvNqvXMjDFMtv4ECss5ZGEwmfnkuF1TrjyA2rloiTcLx3kObg2IsdMHLqI5VurWJ2
	civs9+OFRMgdrdwutEF/xV0rU+V1j+JaU28S5xKznpUZrF+K0OAKY4NVDtUz23cYHSW4cW6Ui06
	PyvxQhKMaItVUp8WKrs8WTiAFGVQ==
X-Google-Smtp-Source: AGHT+IHOO8G/RNP4+N7h+q+3n5RC1e80lk0gJCjZ+Jmb8LlUPm7c2u0245iVMv+KJKdve3qFM22yaw==
X-Received: by 2002:a05:7022:ec8a:b0:11c:2632:b7c1 with SMTP id a92af1059eb24-11c9c8a63a8mr515277c88.0.1763713098073;
        Fri, 21 Nov 2025 00:18:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:17 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 4/9] xfs: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:43 +0800
Message-Id: <20251121081748.1443507-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/xfs/xfs_bio_io.c | 3 +--
 fs/xfs/xfs_buf.c    | 3 +--
 fs/xfs/xfs_log.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 2a736d10eaf..4a6577b0789 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -38,8 +38,7 @@ xfs_rw_bdev(
 					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_chain(prev, bio);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 		done += added;
 	} while (done < count);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 773d959965d..c26bd28edb4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1357,8 +1357,7 @@ xfs_buf_submit_bio(
 		split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
 				&fs_bio_set);
 		split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
-		bio_chain(split, bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, bio);
 	}
 	bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
 	submit_bio(bio);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 603e85c1ab4..f4c9ad1d148 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1687,8 +1687,7 @@ xlog_write_iclog(
 
 		split = bio_split(&iclog->ic_bio, log->l_logBBsize - bno,
 				  GFP_NOIO, &fs_bio_set);
-		bio_chain(split, &iclog->ic_bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, &iclog->ic_bio);
 
 		/* restart at logical offset zero for the remainder */
 		iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart;
-- 
2.34.1

