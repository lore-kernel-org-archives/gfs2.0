Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A093DB305
	for <gfs2@lists.linux.dev>; Tue, 30 Jun 2026 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792882; cv=none; b=eTyQt4MXrL2YxmQGgBHCImRvOt9XCctHBFtA42O+aJs+NqJY6J2jfrCgke2YthwKydLSHsgxfJ6IjTTIc2nf2XIxRxDUsa5eZQMdEcCSYKJjuoxElrdMqAIsBZ10ti6xjMB1IhXy2iKSCxgr/EZ2nJow9XtpdwddQF1xZRWOgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792882; c=relaxed/simple;
	bh=vECd1ZXFSHAcewzz+FC6PcGYAX+aotiyKCutNRMQZqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXvqYehAV758XR974Z+/aFLGXXhN4HudtmVDAG9OyFFJn+WrbeRzGRtvYCdP8KAfz+rK+ryawGl4WA0xKDiKVQPj9a8Dky6ITxbCQwDwps5JWAuAyuyOZ58TrnM7grMPt5Z5RB28iQKTCiFcFzLEtkVDJTWk3YcP4+vwD61NW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmTTV3No; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmTTV3No"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37de961d1bfso3141687a91.0
        for <gfs2@lists.linux.dev>; Mon, 29 Jun 2026 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782792880; x=1783397680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2HZ8Ei9rFQuPTuXmwiDS3Is/BT0HBG7kO3fUbqkF6M=;
        b=kmTTV3NorjoAE8S/Jm9Dvqjt28O+XgVPZ9UjcUtSe3jCjUtnyiGGYg7NJiBg9If/g9
         CtKGj7uP7dktl67kRRZOXaNJ4za/0bdZuYVYcRoc6Yq4TKXO1fmIjhx14SYw05gQtlQ+
         jUit0lh1uOQTubCrD580N7d0yAwJ8+RPvXjzTEEY/0L9MnQrD0xFPcqIfLH5WpmnHY54
         rKhGCokpkqa7JARgfkaWGXlU+kEdHj+jA6ME8H/jxCKmBa9l6qDpWQe9DYY+oEl4t2G7
         Glhx+SWFC0vw1/ImI72SEUORsdDRvgt5sGqKtFMRZg2QMNDYwwkyW2+G7iZLvkMxIFqP
         yqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782792880; x=1783397680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2HZ8Ei9rFQuPTuXmwiDS3Is/BT0HBG7kO3fUbqkF6M=;
        b=MA6hnFgTLNr9JG9Ve5OpzCQwxExLIdQXYoe4v5e7y0ii11jm1jC1tfSmeEoSnOgLB/
         338Lstuy9moPdCB//IEVVlJL1JBj6eVtORTOogl4Zi5saU0GMIBGmTGtC+1LbhcIbS/v
         MwMjBxFONqe5/Zbl1tlm1MVf5mBBLmuDeMUkIKvk5w6bJfo9Q+2EM0pEyWNHyNTyjVfg
         cwaGUtfNapbasahnDN1Pki11tvQMDc8SLFFR1HRuO5lYVIAMCMrlJdbvOs/S5P+tkr1C
         oNAGfAMR7lhikclamH/tm6x7Ks85s5mhjcJRu2P1127aHKkeKj5p8PlwxX7QpM5lgp2A
         3g1g==
X-Gm-Message-State: AOJu0YwbX575hp1bc/vDH0VPk2aY6f2NXhcRUez3FzqlbNS3LKR6mRS3
	wVodyoJHg32CklHoMuNbYlzpCGqOpLuPIu5cVTFGKRl+5jzW6VPLyt6/
X-Gm-Gg: AfdE7clv6xq8o3X5I6ZP9EBB2+sp4n3r3ZGPTv7aU1z0aTj2h/ood4iBC8ch0fNaNHC
	vdttSMDnqZn7KGzzzGWQ4eTW7ruoe8sPc+Axi74HbSnyoQyjA8zdoqdA5uUjU9hgTIbzlvLeGYi
	Cjt2i/0Q+GH7LYARSxEqXNQnE5zJmGVGOPESbM0breo8ipJfSXRCJ7c3pg9ahxmBcuJc3zycQvt
	4zV8yKYf0CUfpAuPff30NzgQbWktPiO9yH1PMCFOCIFalI9PgnoQaNaT3DjR4vTIige0YPZcqCc
	6b60909Kmz1mP+cn6EwMKU5t5lTIRbsMCrifpUff9I+8UJqOhWDUOhX3s4CskG/FyMI1sg9oE0y
	mQYRoR0lerPQNSJ8ZW3x3ElyPCRmoKPyPfgxwb9z2YNsBb24hJ36FumbjEYKPx0fc+PudfhXZvr
	EHX5RMalCCjQDU9LUlauJF7jLW7hg8/t7NHnv7SE6yiTlo6h7X6UgX91Se7rna2qNMgu1q
X-Received: by 2002:a17:90b:1d02:b0:37f:9ce1:cda9 with SMTP id 98e67ed59e1d1-380527daa2dmr1512409a91.31.1782792880353;
        Mon, 29 Jun 2026 21:14:40 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:bf30:8dca:9d63:c0de])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380529bba6esm843165a91.8.2026.06.29.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:14:39 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix null-ptr-deref in gfs2_quota_hold during unmount
Date: Tue, 30 Jun 2026 09:44:32 +0530
Message-ID: <20260630041432.96776-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_quota_cleanup() frees sd_quota_bitmap early in gfs2_put_super()
before the iput() calls that can trigger inode eviction. When an unlinked
inode is evicted during unmount, it goes through:

  gfs2_evict_inode() -> gfs2_dinode_dealloc() -> gfs2_quota_hold()
    -> qdsb_get() -> slot_get() -> find_first_zero_bit(sd_quota_bitmap)

If sd_quota_bitmap has already been freed by gfs2_quota_cleanup(), this
results in a null pointer dereference:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  _find_first_zero_bit+0x29/0xb0 lib/find_bit.c:149
  slot_get fs/gfs2/quota.c:355
  qdsb_get+0x133/0x340 fs/gfs2/quota.c:522
  gfs2_quota_hold+0x191/0x5c0 fs/gfs2/quota.c:606
  gfs2_dinode_dealloc+0x176/0x3f0 fs/gfs2/inode.c:488
  gfs2_evict_inode+0x11cd/0x1400 fs/gfs2/super.c:1479
  gfs2_put_super+0x300/0x860 fs/gfs2/super.c:618

The same problem exists in both paths through gfs2_put_super(): the
direct gfs2_quota_cleanup() call in the read-only branch, and indirectly
via gfs2_make_fs_ro() in the read-write branch.

Fix this by removing gfs2_quota_cleanup() from gfs2_make_fs_ro() and
moving it to after all the iput() calls in gfs2_put_super(), ensuring
sd_quota_bitmap remains valid for the entire duration of inode eviction.
Restore an explicit gfs2_quota_cleanup() call in gfs2_reconfigure() after
gfs2_make_fs_ro() to preserve the remount-ro cleanup behaviour.

Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb79de2cc8b76fbf474f
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/gfs2/ops_fstype.c | 1 +
 fs/gfs2/super.c      | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9b9e70f14d25..56bc966531f2 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1592,6 +1592,7 @@ static int gfs2_reconfigure(struct fs_context *fc)
 	if ((sb->s_flags ^ fc->sb_flags) & SB_RDONLY) {
 		if (fc->sb_flags & SB_RDONLY) {
 			gfs2_make_fs_ro(sdp);
+			gfs2_quota_cleanup(sdp);
 		} else {
 			error = gfs2_make_fs_rw(sdp);
 			if (error)
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4d854556b529..e13c9f9efe6c 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -565,7 +565,6 @@ void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 				   HZ * 5);
 		gfs2_assert_warn(sdp, gfs2_log_is_empty(sdp));
 	}
-	gfs2_quota_cleanup(sdp);
 }
 
 /**
@@ -604,8 +603,6 @@ static void gfs2_put_super(struct super_block *sb)
 	else {
 		if (gfs2_withdrawn(sdp))
 			gfs2_destroy_threads(sdp);
-
-		gfs2_quota_cleanup(sdp);
 	}
 
 	/*  At this point, we're through modifying the disk  */
@@ -637,6 +634,8 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_glock_dq_uninit(&sdp->sd_live_gh);
 	gfs2_clear_rgrpd(sdp);
 	gfs2_jindex_free(sdp);
+
+	gfs2_quota_cleanup(sdp);
 	/*  Take apart glock structures and buffer lists  */
 	gfs2_gl_hash_clear(sdp);
 	iput(sdp->sd_inode);
-- 
2.43.0

