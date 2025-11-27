Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE312D94B4
	for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271979; cv=none; b=pxYqOCRIHfE2KGvTAzGpVYUdvyfoqGMutaTZWEC1TF1v2kT5nPf8g/yXHbMyfcSFou2GCQaqaittmTllE1BzHeif9B8NuUDqXNq019VGNxnYGgFGqOUms0npLR4MLsE0N5dSGu/+Y7rzBRkJy3IRqkLo5su84xNe+rJYbXI8CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271979; c=relaxed/simple;
	bh=Tn9kt3Rd60qF6RLPM2DBnhkLPhIU66GGiGA+z7bAqHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVtokdhQj17vL0RyK5hx/CBoMzW8H5V+tX1gvdWV7WVty/R50dgdiuzxYotk/NLrWBqvSbj/PPPJD5haNvfGTH5PIl/ivAJgkmkBor2yExeNpwe1ZKuDRexjVibGfYpHz0oH4n0ENLKibvSF55xH5nCTnRyOi4wSrmwWJy8eXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=YD+xD6Xu; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="YD+xD6Xu"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so1064072a12.0
        for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764271977; x=1764876777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lM1r++3RTNjRzY120+T4NuENeTC6ZBYSsw5Jwl/MuQU=;
        b=YD+xD6XuLy+YaGjcMDipzO/Sy00GzpRRJVCSzV1jxS7Ag2H//H9ql77OgQqK8HjL+v
         ok3RHrwqJVbXRFEbGTu855qjlLLg0Bsl2o1anV0mJocAS+6fZlx5AugQeHqw722ndYit
         jLZgJUApy4GHBL5Rwj38V9yeTbQC0xBFAD/1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271977; x=1764876777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM1r++3RTNjRzY120+T4NuENeTC6ZBYSsw5Jwl/MuQU=;
        b=AuhFUJENXI2jLOVAay5ObZtnL/ycgT53+uVVEosYAnDShjeMbcEaHV52aLIJeBiZdU
         ylOJ1V/rivH5WsalyttlJZhaosRy6Op7MaqodEpTkRVK3dXF6rBLxBkSgeAR6j9ts4R0
         I3reWUYCEi+Rf3ycdBIB9vpYQxdRmliAoCnCRSkS6th/OblFHQEr/2GMcdn2UMNin1YU
         4OYrsmvmgoeIzl2M03GZHij6XeqPOx8evETf6ggOTB3V9Hs4ihmvP63DRr0Iocb87m1p
         i2eQH1HENh0/dCTeZIPZ3w7t5AzzspYeDoA2QjD3b8O6ZBiyvivmB0yT/N89/0Nxn30v
         4JAg==
X-Gm-Message-State: AOJu0Yz5Ub85YItkMQoxMbSBPtfqkwKrYNZIbSRWtd8WRDY5QzHJEmP4
	BqTPYqL0XURW2VXHVKqlvJG6Zk45NTdiRgLuz7ONCl0LlInOrjr2Lcqb/XObP7JRARM=
X-Gm-Gg: ASbGncsjRvFP4TRRDtegvxgHSyP+plwK6o4Z2lT+UvuC6tDbLDf+ZZtttPDbualPWLC
	efVRTy5vXFuqvBdSRxfwPLMFq81TQEfsHhuQ8Cxmx5cHPAp+NEp1HRGWR0HsFUN8W47Ou4ZJjxA
	qyTxHywcWuq/JKcNTu4bTVJFnpDkqBOwWwaZpuZF3r2e0TM+J2WKVBOrgDVc7YpdTUy8Nr4N2Af
	T5kBoOCHQc07yGMYwrzUyS/htqWH0WoB5z4M1oyBTTit8NNgvywtZMZGTuV89wEeE0r8aiNrmtj
	KVsiD5Wv0a+fvY9M2xsOUMkijrwaEGoYUZHBHsq4fMtCLthn50Ip3mUNIkJPkML9PrmZJOtG8q8
	qt5eliwFIGGlcZihNdKf+j3Cm6KMuR/EuTKbLMNYWCwiYDFkGjmxH5+JojdQK1SBLsXlTloVtAT
	g6HNrGlXUDirDc1E1epqnQEzkXadmakvZQXMW+SfSXrzo3HHZ5yKbBq+eMZWjQxQ==
X-Google-Smtp-Source: AGHT+IHKyKUSA2ibNsoBlTuZ1j6vGRVIEJN6h3w9mksWgr8c890wFiPTq7xmArcLJBhP8a/ET+BxEA==
X-Received: by 2002:a17:902:cf41:b0:296:547a:4bf2 with SMTP id d9443c01a7336-29b6c004ae1mr257927005ad.27.1764271976944;
        Thu, 27 Nov 2025 11:32:56 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:1009:d133:e67f:bfbd:c82:9cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb55192sm24595595ad.91.2025.11.27.11.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 11:32:56 -0800 (PST)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: replace BUG_ON with WARN_ON_ONCE in gfs2_quota_cleanup
Date: Fri, 28 Nov 2025 01:02:47 +0530
Message-Id: <20251127193247.17030-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_cleanup() triggers a kernel BUG when called while the
journal is still marked live and SDF_NORECOVERY is not set. This
can occur during filesystem withdraw or error recovery paths,
particularly via gfs2_make_fs_ro() during a reconfigure operation.

The BUG_ON was intended to catch unexpected state where quota
cleanup runs while the journal is active. However, the cleanup
code is safe in this scenario because it skips quota entries with
active references and waits for all references to drain via
wait_event_timeout().

Crashing the kernel is unnecessarily harsh for what is a
recoverable situation. Replace the BUG_ON with WARN_ON_ONCE to
flag the unexpected state for debugging while allowing the
cleanup to proceed safely.

Reported-by: syzbot+af4d53576692f8956fd6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
Fixes: 71733b492200 ("gfs2: fix kernel BUG in gfs2_quota_cleanup")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/gfs2/quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 2298e06797ac..13f113d8aaef 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1516,8 +1516,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
 	LIST_HEAD(dispose);
 	int count;
 
-	BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
-		test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
+	WARN_ON_ONCE(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
+		     test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
 
 	spin_lock(&qd_lock);
 	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
-- 
2.34.1

