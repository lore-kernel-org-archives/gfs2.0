Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29A2FE576
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318822; cv=none; b=b8Pa+5gU+dNHprN/t4oQvBKugAURBJUT36Oo5kzlyoCwYDpwmQaK1KbcZJQzxJmItVrTZ4RQpgk5pDA7A4vnL0dsV72Kn5i6jU+WFmCHge4lA26RgaKEkAzoUixYa24VYg87S8zJKdRVlV/q2pRye/2UDOv0Y0N5omhwlbs1YGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318822; c=relaxed/simple;
	bh=HTuaf3JKiz2KHLk/jbQPL7NkOb05byK6j+tq4J3zrGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBiihAcfhLmzgWe0CagzjiUuccsjqQPGrWqYShrz9BeTjDsHwyDwHenyHO72Udnc0EByjLcdDGOA8PSLuL6gyGdQi35HVRRKjMj+x1ZT0bRhoYZdDE2M424LCTcWjEWHhAh46bBOdu4g9+dWk1duP2l8DuBDJ7C+0mThB1WduzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYJ7GAme; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYJ7GAme"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b98983baeacso824648a12.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318818; x=1764923618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=SYJ7GAmeEdS8ECds/Mx2umdfnzhizauVV/jrQ3jwPmuX1L+WvRK6172NUEKe01eVcS
         dT/D1EXbpemUIblLAUGfHxPCWaT/vOEPR4VDs+FV6//OVcBXcBzjN2htjX5t0UY7j7un
         6HYJaMexBEAjekQWHBx8As78AdDacsNhFoEncV/WltITY7speVDSb7CwWw6I51ER0cwg
         BKblSgGoMVb6APfwiBiiAvheyD+CPe0qURr0THAo/39yRNgoJdVbYp1COmPso+NUK9IF
         GCM06OWuUpjtsl9IaYZ9SF4TmWsI7rdKZA8s6RWUjJ83WEe8gA6GVKcmWVUHTXQcXAZg
         y4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318818; x=1764923618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JuZTiXTtCfnBMrxTr4djU8x13PVqvGl4QPuQVkzEeA=;
        b=sUGbYzxOBK0ggU779Vu3XJwJmi91I8tTuw60Y1UX/RPvyGpk9ilcLYF06MBWnuTlnI
         T6ypr0+nmnFjY1j343o8vzrOjRnm2Azy1aeoFYIK7ku3SVID1XYwRObgSTscYOOvo+J2
         R63+AAufK6UTZ+gizc0CdwMouoNirU68jPsbtlBGpTYHaEE3HadiYZYh+iqSDgsK042i
         KZFuEkir/T7O8DS5I9SBntuNvPg0GPIkvOjTyres+Vg2mYeiO+VJ4p0m4O1I8zPxEDw8
         P2CSsEFGMa9cwufs6Jvh3wRj4I7VQOBGgBDbHWKp2JH5djNE71iZYcCiU1jqsacLPkRp
         QbiA==
X-Forwarded-Encrypted: i=1; AJvYcCUDk5B6+z4YToJKmX3ih7s5C/vjwE5W3fcRVlU97yHhHIE84WKw/OTNF2JqZqMw+3YlrKJL@lists.linux.dev
X-Gm-Message-State: AOJu0YwixsVLvAZD81CZwlGPQtGN2xRevsS0PqEoQp7rRgO2j4q4YNey
	4fblX1xxcxSXigl7lEvWySSlkvXIIrKUgRqDvhJLr5ibyPZ89PAFNA+p
X-Gm-Gg: ASbGncuJlKMr3K/XpL4cpWSOmR9vtaxXrftatfo6FeSyhh2l5K5hSqmuQ5KGGnry+/7
	/5F5QZwreOCkOTpm3fB4Jd4Vs0uzvkj5mXMavzW1WJGnCnXO7TTCOIEbEuieuchNLqxpx4SM+Vr
	1uByzXnL1+iBl0gWiZv0tH+b67m8WDg8kIYjJx/M6ENarCB1Opumy145ch5L+9jLMXuIg1VnFmG
	6+Nge23jRR/wuyBJylpMUMqqxvwZRR4GSMbmUKR/BvOGQEZHZPR2MtR1mApOJJRlqPrPVGBoL2f
	wIZmWD02zJnhwEmfsHXD70S5RMpRDNc7LZJNr5G2aXdwBkfFSNIqDOPYSXKZPrMKfxpG64Xp3pa
	mgggqFn2YCrNXjsEpN1arYJvsy+wtNiGaC502SQfYlnTnphgEE0qisgdBxjut729z5CaPAlxwWc
	sM5Ui+abRAEiEsSNBp3PO1QI4Yaw==
X-Google-Smtp-Source: AGHT+IEiYKFOm1UmbHzu9Io+L0ipF/pftCo6ih2XEqCkxPLrZNrFMt6HrxgMvpe9BJ/P01XRe5CPUg==
X-Received: by 2002:a05:7301:162a:b0:2a4:3593:ddd7 with SMTP id 5a478bee46e88-2a71953bfaamr12018765eec.4.1764318818087;
        Fri, 28 Nov 2025 00:33:38 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:37 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
Date: Fri, 28 Nov 2025 16:32:19 +0800
Message-Id: <20251128083219.2332407-13-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Replace repetitive bio chaining patterns with bio_chain_and_submit.
Note that while the parameter order (prev vs new) differs from the
original code, the chaining order does not affect bio chain
functionality.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca60..4af45659bd2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
-			bio_chain(bio, prev);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 
 		sector += sg->length >> 9;
-- 
2.34.1

