Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DB2E8E1F
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318791; cv=none; b=of8Ty+sGxiMpQ3+eCm3a4fbiGlAcUOFN1JzLiH1XW2wVVyOAwtit6PEBxkjNgirQR2j4hvBv77knpFqru7jRrzLhJj8mVB+4l4Nf3mOqzo9X8+IjAJSi2bRqStQXEAAHpxrOeg7nKN45WamdMr7VXTBVoiMiNOSvIh4h8lZ0xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318791; c=relaxed/simple;
	bh=eIesZROL2LjNY0DrQ6P8R8b1cwhdKxEhWtmo1wbXnYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lk4SzM2AssnHlEWGciG+qyvsCDvhCU6dC/9GVcRadH+RsGdEHP0K7OgsaZg36ycGzy2+P51WVAGMcqh5J+BZtflbpnpTFEs9LLacwjn7J3en4pr88PTkgj1TV8WK2ScDHk5N0/C/fy3vy4tq4+jvnnyHedXmEyIto2Nuat9+WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Tctji+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Tctji+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1543207b3a.1
        for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318788; x=1764923588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=M/Tctji+zir8RrMJa02kHnbrPuoppwKNRP11A/OWIxzOrDNDFfeYfPrJqH8NOFr3Lg
         U51Lkt9+FdI5+MGSKkwWfVBD15CQfETA++ib5U3O1lwSsBsVVL0cFEbU4bdP4JhGtgNN
         fjA83q1t8qymBzzqEhqfHWVLzfPkaQrbj66xnfpTfj3qhP8YOs6sFe+ztMQWGgiJX+CJ
         oTeL3k19OeEYtlWOMcFqsb51c3ThLwd8sdwyPwaJSmEAgOwD2rfkqtbQ9m+qWhxqhGpe
         XWCcvSJn2o9qL7D2Bm5O4tfXWwEN0oAVkq5V05AQfn6449WZgMHygL77ft0IAnedO2K6
         1/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318788; x=1764923588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAlkzqFb5MzFCJaoNDunPaLLzQJH14gDGKiKCNGaT3E=;
        b=JLKZeNiZA4+6go7yM6O3TZTnXeSWvABwqPIRd2tfT73WOy1WV5PInT2YzjDwDpszeh
         Lr0CUTu4va6otJytxyV9z66Ukaq18tmQkNCSwepjF7QS3orhlFJATQYcAP+D0h3xTk+N
         zTibzvgMZn1V1AEjAxvvGSPTn803FrR+3uByQ9SkO3500fVY28HGnoqvgn0qgE+TUMNz
         9RXIjKbiP7G+GUMfpWOMPWc1xUDdTBv8pYg14oYsAts+4eoQQ5Scdg4NZyqttYyGL4i5
         TMEDVQwTavDJB7wvJM/hUuQUANdaGNEMr5dJOONWoKDFYL5yg0HCFrDPXYQqfmtNI86x
         wFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySnRZtfJheVR5WfTodDMvWgGZx799vhHyZ/lfVvKVWlPUPlBpoXR+ie2rEHXPhPw4/oAy@lists.linux.dev
X-Gm-Message-State: AOJu0YzYB3+RaLCTILdd1CnStEodCpvf440s4LQjWzzFb+ifU0yNol4s
	XljmZGF20NRmJm8emmwJrwhL7h1LHO0gCgzAM+PEV9nbGjcJxWsWC6m3
X-Gm-Gg: ASbGncugatd+CCbLPt/S4Qq3gvsGbPah5WpQwYO06GrWfEhEwDcotGNLEc0B+5djEbo
	ffENI5qaqOZy0DopXC3kxHNBCu6o1+MIJzHK6U83IaG9XB88uheBhP79dudj6p1KTVjLeCw1wTB
	VqtvzbPoecbOYu0v+8TzBs/EebMDF+iIV4CKjKQgTT8ibejMpHgGBSquUKWV1qG4lqAo1UFlOYl
	eQCDEL8P47Oj7TnenkZxx/E9jQATGHbU7GFDym1W8pLkOgb24cJA3hZQKZTaxKgpyv0YODueehS
	6VCWpJu2Xqn5h/iJUji6f/Dmt0M2GC+boXJMPQujf127yxiy+qVO7EB2jAhMA+dpKDOCPOUZ73J
	bo3K+JTmCBIeGcAtR9YU2wAMeuSJJSc2ph/Btnhf5m0B/xdk5ApXdJnyd+S83khix1vxHYG7dqW
	fV6DfNPB6pCeZ/wEav0sPP0BfW3g==
X-Google-Smtp-Source: AGHT+IFIaFCQuKpxcLcZ63tEcOt0hGjrfoUQN9LWUQ2kBfICDUhGuL68J3zsB+mI5c6KDSWUdB+sFw==
X-Received: by 2002:a05:7022:670f:b0:11a:4016:4491 with SMTP id a92af1059eb24-11c9d84c6f8mr17988575c88.24.1764318788462;
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:08 -0800 (PST)
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
Subject: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:13 +0800
Message-Id: <20251128083219.2332407-7-zhangshida@kylinos.cn>
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

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..0073fd7c454 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);
 	return new;
 }
 
-- 
2.34.1

