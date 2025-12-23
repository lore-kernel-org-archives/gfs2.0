Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1F29B204
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498715; cv=none; b=Zb87fVJzDgoTM1iL29B57Yz6mx+MJmo54pGhQMaheswIUm7g3nlg4z6Y0v9oap/3Mbb/my6rAR0PYnxIw6tIWlCovtELUSGlrUAK4iRaVc1lvwkpG5YpRCqRQ/hDR6mt5E5xwVbe4jBBBU4bF3eYdug6t+0mgJ0ycIsNBD9842A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498715; c=relaxed/simple;
	bh=vPU2V50o5jpPnvrbKJzOO+bcSFJqLPqe32WzSG2rqCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9nsJumBkpAzz96Vr8iUzOEGur/onSKz0up3IVCxVUCmP0n01cnQMpvnXtSOy2VuQ3b3fpHrJ624MJ4Ai8zNrpMgHfQGnZ+NbR8Rve098G/zE3IZTIAUSl325N6kdY1nEljpe44817812ZTs0ScLn8X3HJExd2XvzSb5ps5obIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcVclo5u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcVclo5u"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a110548cdeso70303125ad.0
        for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766498713; x=1767103513; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=FcVclo5uC8I8tzEMX60ydw+u1LqIlvWvAq7IGFv8JENTPcFjUqSYn63eTwrVrJLGys
         OhmEQwlm3oVch3YHgtwTML9GytQR/ypWsHAp1n40hGsXHDiHtgq72B+mVLWPPiMASoE7
         iHWhuKwPMRDRGrNkm7crrzqJ8LuvE0vlovrpMCFsYloFSdZu9UcqJHwjhpVqCgzXe5aV
         3ace2LP4o0xM0ncercXlVyaSrbEMjhXcr2ShEY3yTXNJge/5pY9VpAAikKmQEqaC7I2Z
         mxPCAOb3Rwjgp/MD2Wt9XczhH5xmV+Kna8FaKCKM7yoIxYysthkKG3mOrVv56JmCQa3B
         ifbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766498713; x=1767103513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG6EI6RBrBqfcG1Qj/7XoK7r3FMDle9OXgLojBRhNAU=;
        b=IXwGjLhTFTHnqeStp8TMDu+RHuLatChl44nSLbBtETE9eePgqxVf4tUQLrAlkJJMun
         3mHsh1/118NyMfkrg7w9qwBuc9gzOHfPIdx1tXd8LaEtIr0MG/a9kSMXjpD+AZSiWZyP
         P++UoTMfnVL2TQxGyr/ObMrHvaB38HONQNpCdVxaDEuT+D/jbzPWCwl6ORnZtQg6ThNF
         sldquD+0zhkbFCTMbTd2XW5CXfQoeZ3WW4tFz2aioudq5EBTZeBImClMFASzFSmZZtN9
         Dbys6HDpPcCjEWFrm81OVMzn6k8Kz2OIqGL67KY1KiTrC8fermWCWHiciGDH8E94sD5o
         /4rA==
X-Gm-Message-State: AOJu0YxOUjV53tL1/eRjs/AliPrm96qI1wKuSQ0Xm99F+0vYiWGNwVJo
	avAYGbgQfGIYlQxKhjq4oXinXKwbVwACxxAvs5q/mFSIZTLj0ubS11ml
X-Gm-Gg: AY/fxX4E7P5UqHbnDDMOCPlDiVTpmzdYU1FME5W85gOr1BlNHBv6vvqjVAKmEjHUUOr
	7w1/RT7OcMaZSaAgr54a7nLUzG2FtUBnrnlbs/u7fHEFscP1es409+WoZB6ByM15LnTJIF5mi/G
	tnIQgjdjofKWBd3vIInNxAAkmAFzerYjod+sQFXjASulIQc5YvNNGFMJS9O5P2vDPidl7mGkNpj
	XAieKps4M+ZjMwPEq2L3ncuFzfOg3ZZa7Q+XkuaY4kRjTPUp2By1j+ha/S0uPDhLsodg5FUBRZj
	hNOkNyqY0SSPRHJ93DEthTj0OCafsYzOEYiwC6SlBkOM76o/kFVHxTrQ5DvKex+E9lKP76VXa+I
	Y1DR+tRvNhVoSHsNn3ZTyGKMfGjaCKv+XD45+11JDkNiJ5K6tSqXcZFCTEmJ7M2DN5PJGbF6NvP
	WMD+SroevyFMFm
X-Google-Smtp-Source: AGHT+IHbyFgKmCkKVy+fWCluUAqW7A5+LdBDsZ00crpOJb71qQWKWZcujxPGz1eDLdPumnLW6UqawQ==
X-Received: by 2002:a05:7022:f68e:b0:11a:641f:ba11 with SMTP id a92af1059eb24-121722eaec0mr13661214c88.29.1766498712830;
        Tue, 23 Dec 2025 06:05:12 -0800 (PST)
Received: from pop-os.. ([177.21.140.228])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724ddc30sm60661035c88.6.2025.12.23.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 06:05:12 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [PATCH] gfs2: do not evict glocks with populated address spaces
Date: Tue, 23 Dec 2025 11:05:06 -0300
Message-Id: <20251223140506.568643-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata glocks may have associated address spaces used as caches. Avoid
reclaiming such glocks under memory pressure while their mappings are
still populated or their state is not unlocked, as this can lead to
invalid page cache state and GLOCK_BUG_ON().

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 fs/gfs2/glock.h | 30 ++++++++++++++++++++++++++++++
 fs/gfs2/super.c |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 55d5985f32a0..12f57461f687 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -305,4 +305,34 @@ static inline bool glock_needs_demote(struct gfs2_glock *gl)
 		test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
 }
 
+/*
+ * gfs2_glock_not_evictable - check if a glock is not evictable
+ * @gl:	The glock to check
+ *
+ * Glocks which do not represent normal filesystem inodes (e.g. statfs, quota, rindex)
+ * may have associated address spaces used as metadata caches. These glocks must not
+ * be reclaimed under memory pressure while their mappings are still populated or their
+ * state is not unlocked.
+ */
+
+static inline bool gfs2_glock_not_evictable(struct gfs2_glock *gl)
+{
+	if (gl->gl_name.ln_type == LM_TYPE_INODE)
+		return false;
+
+	if (gl->gl_ops->go_flags & GLOF_ASPACE) {
+		struct gfs2_glock_aspace *gla;
+
+		gla = container_of(gl, struct gfs2_glock_aspace, glock);
+
+		if (!mapping_empty(&gla->mapping))
+			return true;
+	}
+
+	if (gl->gl_state != LM_ST_UNLOCKED)
+		return true;
+
+	return false;
+}
+
 #endif /* __GLOCK_DOT_H__ */
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f6cd907b3ec6..86544cdafe53 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1164,6 +1164,9 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 
 static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 {
+	if (gfs2_glock_not_evictable(gl))
+		return;
+
 	if (current->flags & PF_MEMALLOC)
 		gfs2_glock_put_async(gl);
 	else
-- 
2.34.1

