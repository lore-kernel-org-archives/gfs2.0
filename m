Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAA366557
	for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774323610; cv=none; b=AFisIKb3gffvo7H65GzC5M41zLF0+Ld67nUqZEoxwSQwf3QMHTJdYRzwOTH9Lja5cmd5kyL4IAIz9C4IrSy8XV48Uqr1q83wRp/R+n3NogiRY+nZlqLCDjDKlYdjJRlIxacecM+iPdurhZ4/fHAXI12W8w1fdTTNNXV0wHb9bRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774323610; c=relaxed/simple;
	bh=nciGgvCiH4k7pVDp2B9QX1oYev84A93eCK1NlFz/T6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7ib+D9YlQAk8AitiLT34v8U8FPRqcIEzrDaj6Ih8JHhAC8qijoi+6nHiAth9xB38UXOqwB3O1I7aft2lYwNAzDSJWUPpWbf7addS6e9ZlR22TaWJSN/q6qGxzDLGPxxkHN/Y88EA1/ttEw3vyqTM6pQhCMcq5p6R/pKVAImqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI9FnGm8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9FnGm8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so2372157a91.1
        for <gfs2@lists.linux.dev>; Mon, 23 Mar 2026 20:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774323608; x=1774928408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4orQvplBiJqjKJ5mSB6psVkdsy/n/RygrE0Mv2DWG4=;
        b=rI9FnGm8fbefZuTiV5QGwgavD1Le/dGZBCrbvYQrCIja/KKt76atVK8zTDrbNzbiaD
         3Q8u7ULVSJqHuj8i7byszVFJB90e5d+Rah22+mGyLJIEEiwoiV2AM9sHJTVOWCibWqj/
         +8OwRtiOqppDA0YI4hphzfP/HYLz/CJxbZcuf5MJDyIPawPDxaniB4UP2XbQFBLkIHmn
         CGDDHs3P1/RglAWM35yDfWHHyfZMd9ChZuMgtc4G09jef0Qzwz4yrPpryokAyQn09Gc0
         IibYDgfr141b30NTnDJRJRl3nAfrYTGulRcd3I2gNgLKIi4O0gOkFnXNmqn023eFnbYZ
         OVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774323608; x=1774928408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4orQvplBiJqjKJ5mSB6psVkdsy/n/RygrE0Mv2DWG4=;
        b=Ifz3rNBcIQMCBJ8zHPPWJc6YwnveMbzM62wCDNtxbbJtsWb9zdvbnmtfcGmwEme7O/
         ItixYgRj7Tth4SgezB1R6qlGTRdvNcK2rgwxyLV/oq2A2QndxtHsHDGMuspG3PpcCUIn
         1rEPln7cIe5z6/NGnMpNIpRgyvRO/M14jkdiEfvJkenbFxWwfUylRuK2bffhoRv4wet/
         x23enxr5AHM7rfeYbojayJVkbSacJKthXd42zvWatLOO1w4CBv8nBTrLxFiNWkxhiQHm
         QuXe3PXq90iBquEwKDN6ojf+eImiHM/DD7rCZeHwMzGtKBL0sQ/NRxbBeMQ4WsMMu4By
         dVUQ==
X-Gm-Message-State: AOJu0YywPZ7hPC51y85mud84vHnwjwU8QAI/gkj5ZhWSFuktltIblPTC
	OXMrksbHDM8TUgK//NVVQzMF+OCymqEBUrwl94MYLoAnHC3KEUIkUVkj
X-Gm-Gg: ATEYQzwCRwuaiPr2ELFlxYoZHxNkW2GGPZU3rzU1iSnDsDWT3z5L0VGQ7aC41f65JSL
	XIuhcTEPo9myKRO7Nvysqs4Pu+tNy8k63/1AGKxuC09jjNyIu7x1YXlIv/aVBrVotUWo+gXJ/wB
	2bZeF8YIWJrGTXjZA9Ht8Ulzw8x1mey1olJ18QEx8Iahw2lb4Xx4vHQWA6lM3XfqYFsYvVGeYRR
	+vOy+JBksjH4uGQ74yBTaBl9HiHm6qR46DPfY4gsOReM+iAELTaV9R/gCiPG5b0vXR/FT2f9hG5
	JKRTHk/XnrSHMHm1FPwqErYbI/o/3eky9ksOq+digYTGb38xTLm6gt/KEGRNlScibUSoOJqRR3c
	zMuhmmNYJhtqk/rBgD2Zvm1ZiaNW9bc46IlVBhhjuD9ACKoB4XdNTRMljQTsYFo2fECnkprabvo
	Nk65CcpWpKOiJthXedvZsv0PlodmNyx+ea44TF7PKjX9Y/wbb6S1sk4ckygWg6JPUrH1oUZ/OK2
	mcmmQ==
X-Received: by 2002:a17:90b:180b:b0:359:8ca0:308d with SMTP id 98e67ed59e1d1-35c008acd78mr1480028a91.14.1774323608231;
        Mon, 23 Mar 2026 20:40:08 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:62d5:79a:7a92:c774])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03165c5esm626152a91.14.2026.03.23.20.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:40:07 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com,
	willy@infradead.org
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] gfs2: fix hung task in gfs2_jhead_process_page
Date: Tue, 24 Mar 2026 09:09:59 +0530
Message-ID: <20260324033959.1456418-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filemap_get_folio() returns an ERR_PTR if the folio is not present
in the page cache. gfs2_jhead_process_page() does not check the
return value and passes it directly to folio_wait_locked(), causing
the kernel task to get stuck in uninterruptible sleep (state D)
forever, triggering the hung task watchdog.

This can be triggered by mounting a crafted or corrupted GFS2
filesystem image.

Fix this by checking the return value of filemap_get_folio() and
returning early if the folio is not found.

Fixes: 240159077d00 ("gfs2: Convert gfs2_jhead_process_page() to use a folio")
Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/gfs2/lops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 797931eb5845..005584311eff 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -467,6 +467,9 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 
 	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
 
+	if (IS_ERR(folio))
+		return;
+
 	folio_wait_locked(folio);
 	if (!folio_test_uptodate(folio))
 		*done = true;
-- 
2.43.0

