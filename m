Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777E36C0D9
	for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776801; cv=none; b=NhhN8rVJbbgg7bprZj6xQB6Fz/4jF9C7JS7vn8/JvMzvQnoKpFb1ZImAC+ilhygW2WazQlSDbe6/o4gwUWAc8GPF3UQ9jSzgs6wiCejT9OopppDJADCHxhX34dXdaRFRaKhDrqEdVe9/8wGI/4TQUz5sp5eW74gDMDssqFwBPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776801; c=relaxed/simple;
	bh=3BZc3Thv5LEKtK+rwOEodZllTHTFApthvFLc2lbPNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz1WocvqZv5mTa4+BJk8GokpNJStnqU6PHE1dxtRuH04eH+sgiV6FpKdGj6Ema2S0Qb9MNkrtdXjcfHeGgSjg13Qmoi/3G64iVvAifU9a78I+5uUaPqcRIu6RNLP2UA1e8fpLxB+m/c3eIeq8lrGXWrcunmIbvqFoPI6fU2jzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyvczJja; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyvczJja"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29efd139227so13111315ad.1
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 04:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769776799; x=1770381599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKEkl8CvxvFJM2weLeokDtwNfyW3MjqMZBwUQAOABKg=;
        b=DyvczJja1tbWHbQ+tZFcp2wY9JPO+BweZLmllMx9al3lQusqHqeIiTpMXTiWAZqjNw
         G4s3DrCnrMCvCrs+YDsgbZuOMXgiPdlqF0AF7qNKYuJQW9N3+0yOeST2Ccb3wQh0tF8N
         81evRwOUT/hkMM1lS6LTnMTCHIE6fffRdT5HHop2E5ONBWhwd/j5eF45sFeznpwDQWvI
         h6mdWa6pXTeo+vSpIYsA2pF3ZNbzpv+hSvFqH0c60YyxiGHWzY66P7yw8WUg/4OTlkfm
         /u85zdLBAY/MI9bV36/0e17TuaWjeOF0PeVKyxD+V8lsf9aNWaCqUyboHV+afEDFMU4K
         zz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776799; x=1770381599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKEkl8CvxvFJM2weLeokDtwNfyW3MjqMZBwUQAOABKg=;
        b=KhGXUvl4yktOol0RZrHP/cNpr5/i3blddg2b/nEYNezo2GKRyd1qs8I2U7V62jPkmz
         eiQXFDF9FpCrnhKmVTgYkKwDbwj6tS9scaadfv6OTq8M4u5aM4q8nxvhyL0ZCPd98z16
         rkR6Opzq5lnxFXUEkkcrcwzgRLkwkEJ2wY7tHG2sRJIg82JssPKkPzF6+1tU6CqDkMm/
         1RxyavxFKX/tWgZm5gcSbZOgd56qF63FUJsIy3+bv3D7VLLzLcDtYQTwKl0FbO6scArs
         BJa5XwhnOMmMnJ9FgO19z1KKybcqipyqNGNvezqQJKE7zs/t/ytkqIJVUi1zDW4u1HEd
         LWyw==
X-Gm-Message-State: AOJu0YwybOpX0o3L+elxShZSKKS8Ygtc6iEwrdJHLv/2jSHT5z7wO51q
	97ZBHmGcjzaTrluu3N/foIOKGZxYpkkd02YXNxsWveL40BQ1rJmLXfM+
X-Gm-Gg: AZuq6aL6NtBAVY4UhK0EMTlAT/TpLT3foQIUGW1X6oO7KYuSK87NWgUn6EORj36YPDl
	j7UtdI5K8diP8ApCojY881SKjSDqxORA/Y7u5H1HdS2CN/j0VjEToMfu0ij3HamtdF49ajVGie2
	SjiMBBY/wTAcmTGPzjFkLfM2jPVbHx6vena4/46zQy4+RCy9ZflWzijytBiIykRpbRWhqdg6BkI
	MqsxF8S80IapMiF9J+8NEd18csUq2uD98NYHiCtWwD65RIXMXhLxV+febuwWual/vFNyPIG4ofZ
	2sCx+vE47MuvgSRWUXr1rpfVdtnBLFbfSTBe+6KS9XRiiVJAV60f2PV2PPAjbc7tE/gMMrdNBlQ
	u+NTKgeb1eMMNK5UPTdeaYhSnQr0xZgVhuK6BFagZNttQKCQFQL6IDgVH847YrXulfQyeZMl/1I
	mamNcET9Myhrfkem2lcyrec3O0bVbiacdJFmBgBHn4P66cIbFGtJC58a4sA4/S3F3DeyjUnRbGe
	5f82w==
X-Received: by 2002:a17:903:2f0b:b0:2a7:9163:8e68 with SMTP id d9443c01a7336-2a8d7eabffamr31847535ad.6.1769776799459;
        Fri, 30 Jan 2026 04:39:59 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:144b:d627:2937:e2fe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c64b4esm8247169b3a.69.2026.01.30.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 04:39:58 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
Subject: [PATCH v2] gfs2: Fix use-after-free and reference leaks in iomap inline data paths
Date: Fri, 30 Jan 2026 18:09:51 +0530
Message-ID: <20260130123951.64927-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline data buffer head (dibh) is being released prematurely in
gfs2_iomap_begin() via release_metapath(), while iomap->inline_data
still points to dibh->b_data. This causes a use-after-free when
iomap_write_end_inline() later attempts to write to the inline data
area.

Additionally, gfs2_iomap_get() and gfs2_iomap_alloc() leak buffer head
references when they call __gfs2_iomap_get() for inline data files,
as they don't release the dibh reference stored in iomap->private.

The bug sequence for the use-after-free:
1. __gfs2_iomap_get() calls gfs2_meta_inode_buffer() to read inode
   metadata into dibh
2. Sets iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode)
3. Calls release_metapath() which calls brelse(dibh), dropping refcount
   to 0
4. kswapd reclaims the page (~39ms later in the syzbot report)
5. iomap_write_end_inline() tries to memcpy() to iomap->inline_data
6. KASAN detects use-after-free write to freed memory

Fix by storing dibh in iomap->private and incrementing its refcount
with get_bh() in __gfs2_iomap_get(). The buffer is then properly
released in:
- gfs2_iomap_end() for the iomap iterator path
- gfs2_iomap_get() before returning
- gfs2_iomap_alloc() before returning

This ensures the page stays alive for the entire iomap operation and
prevents reference leaks.

Changes in v2:
- Simplified iomap->private cleanup in gfs2_iomap_end() per feedback
  from Andreas Gruenbacher (removed redundant type check and explicit
  NULL assignment)
- Added missing brelse(iomap->private) in gfs2_iomap_get() to fix
  buffer head reference leak
- Added missing brelse(iomap->private) in gfs2_iomap_alloc() to fix
  buffer head reference leak

Note: A C reproducer is not available for this issue. The fix is based
on analysis of the KASAN report and code review.

Reported-by: syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ea1cd4aa4d1e98458a55
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/gfs2/bmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 131091520de6..81a958694d1f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -887,6 +887,8 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 			      sizeof(struct gfs2_dinode);
 		iomap->type = IOMAP_INLINE;
 		iomap->inline_data = dibh->b_data + sizeof(struct gfs2_dinode);
+		iomap->private = dibh;
+		get_bh(dibh);
 		goto out;
 	}
 
@@ -1144,6 +1146,9 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
+	if (iomap->private)
+		brelse(iomap->private);
+
 	switch (flags & (IOMAP_WRITE | IOMAP_ZERO)) {
 	case IOMAP_WRITE:
 		if (flags & IOMAP_DIRECT)
@@ -1419,6 +1424,8 @@ int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 
 	ret = __gfs2_iomap_get(inode, pos, length, 0, iomap, &mp);
 	release_metapath(&mp);
+	if (iomap->private)
+		brelse(iomap->private);
 	return ret;
 }
 
@@ -1432,6 +1439,8 @@ int gfs2_iomap_alloc(struct inode *inode, loff_t pos, loff_t length,
 	if (!ret && iomap->type == IOMAP_HOLE)
 		ret = __gfs2_iomap_alloc(inode, iomap, &mp);
 	release_metapath(&mp);
+	if (iomap->private)
+		brelse(iomap->private);
 	return ret;
 }
 
-- 
2.43.0

