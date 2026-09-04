Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA343C051
	for <gfs2@lists.linux.dev>; Fri,  4 Sep 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521075; cv=none; b=DpSo2wWAqqNRmpPnk8KP2cXAiLXZ9efw1BAVREk4IxV/yS3ZqO28gW67UveaPhrntu2ne6RsmZX6v3+yNBT25Dd6ZF+64ut7BkzloF2dAQqXXC9iP3VA9HGRRtspJJam2/PNymnPouL3N3KQXLEb88Yg1alrY1vMK6l0ACpS0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521075; c=relaxed/simple;
	bh=mTEsa+wnW8JxspbUbddTGRiVvEnMnjzNQWfCNFCnCfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuP5skGj8yLmsQCD+gmSEed6mC52WzkvP4icA82WikbvUt89Iq4fC52QJejLhQ6/DgJlmOHvJgLleqUHHNCnOcNjTeVQILhFjaoLnJha37VZkS7IECkJfVBLoGAqbaKK5kbOpGfxNRfeprgGDMEGgigtrRIH948erZBRgzZ8Tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzOKTx2u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzOKTx2u"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc439bfb2d8so686114a12.2
        for <gfs2@lists.linux.dev>; Fri, 04 Sep 2026 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521073; x=1789125873; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wExxqxYMMDmKusQmYDv/felazU5hgbFnEoDaQ9pzTlI=;
        b=TzOKTx2uFhV4eFDSmpOu1VDr/dzaARkZ1zlTQZ3BnnlTdAT/yNBrC19tX8y2cB/PVM
         n7FtoyyF2hHNJTwiM8EmbeJ2RPxE/Oz5MxJL9Jqx5Vj9eeKkZYxkz56zrv/zakbxWapT
         O04/OKPSvk5LZPR1vVdUwIT/d9CMnlHcr/u1VFn8PXNID5N8jNFJ0sEpGC0Vq45CxsyH
         QaGpAy5/EmMPzM24yCGo9UI7quD7koS24mP5KIX7NBPiTjC4yEZSanvnRrWDaRT6tF3Z
         VHChVaf8RS5EMjyTUwOVn7TzHc3fA+svt+BXBt2hLWRaUEEsMAK0t+iSoxbSWBwJynoi
         luLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521073; x=1789125873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wExxqxYMMDmKusQmYDv/felazU5hgbFnEoDaQ9pzTlI=;
        b=GzL+/GbJxmBdv6In1VDv6HNXSPu84pY99K1+rwD+TAWOSzatvUKmYBhta3RIQDSCEA
         ZSViTJzIiFxryNvb0qead87Z42FhORSEz+Kuz04Ccz0W9baI2f1QdEGfpQs1IGrlZMRU
         9U5cFgKmuL9SqWz3BFkT4KPDNT4rxntHR00Utd6Z+u0YH9WuEnXFU/ejO2AS0cAgR9aA
         xwFqPlhUPzf2gKq8DLp64v2sPRBVW6R8ZkyDx63ZkeCXYB2VlOYGPEvxhsSmRng8N3Rz
         UIVj6Xo5mg1EnVQVVAHDda3gxZ5xHjFF+xnpQF2t3+YnMuIlEMQLSf9g48F8FupnsKWZ
         +oig==
X-Forwarded-Encrypted: i=1; AKwUvBwKkUOEwh9U24kBRqB5nlZU2WWHvSGOJqO4C9tqpr0DAdP3JGQwglH4dTJrgpZx/s3w8D+6@lists.linux.dev
X-Gm-Message-State: AFuF++kKP1UDDfEcda+3aUEWNc17mWlbXJgo0Nbl5tBqai9dN+5cYrla
	1ZvL3NbRJNMCxq3jFJ5mibiuKV6jst3/zAgdIUovBoXo+izIA96xmMU/oeMyEzFWgek=
X-Gm-Gg: AYBFou1TXaf6ymgX+cXf/LN8YismRAff98HrQSrE48dxJzGQGpn6WKlWLUAUVdjHwOM
	C3w+PAbKK7AXzJovXgJ8uu3/1baDlnKAlq+tubS3HWHLeUXdCivk57LORiN3vJyxYkMmtdYmP85
	Un09oafvWjAb3DrJFnOPRRp19Clv1mIfzC5LA0vCUij6oNJaOC4W9Vnw1KIyL9BnU1570emg75u
	GEWpXRYa04Ekltq7ZZtG+orfX7jPojyqb1JGn8LaZdtDmYGiF2NZGprRd3Ix6T3bN13nv0qq0P8
	4pmFoFUVH+5Ifa0t0Bhj5RCjURcxsv28xVTSOYuhGkIXo1GIEbcKI8Yr8lHgN02BKx7AxTmQtsg
	YP41+798pYngtGTNJS1J4M+mxcdSVIIop6w0GWHFQWelej/uIZ9IcIszzLRK/FTQco4woXbdVC/
	E4740I8LO2/kpChvf/rPgr+h5eq1DyTZT/wLXH/z8QAxLGaLixstZnj8N6hTNNb/Co2YUPLjhCU
	An586I/VRehIGRk4ebac6SF6xM2+wUHT3ei0A==
X-Received: by 2002:a17:90b:2c87:b0:398:990e:1587 with SMTP id 98e67ed59e1d1-39b26191cf2mr8362233a91.9.1788521073173;
        Fri, 04 Sep 2026 04:24:33 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm6683658eec.21.2026.09.04.04.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:24:32 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH] gfs2: fix typos in comments
Date: Fri,  4 Sep 2026 16:54:27 +0530
Message-ID: <20260904112429.39814-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/gfs2/bmap.c     | 2 +-
 fs/gfs2/lock_dlm.c | 4 ++--
 fs/gfs2/recovery.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 73c626971163..8c734450c998 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1212,7 +1212,7 @@ const struct iomap_ops gfs2_iomap_ops = {
  * @inode: The inode
  * @lblock: The logical block number
  * @bh_map: The bh to be mapped
- * @create: True if its ok to alloc blocks to satify the request
+ * @create: True if its ok to alloc blocks to satisfy the request
  *
  * The size of the requested mapping is defined in bh_map->b_size.
  *
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index cef4bdee92a8..47eec0c13025 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -431,7 +431,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
  * 10. gfs2_control sets control_lock lvb = new gen + bits for failed jids
  * 12. gfs2_recover does journal recoveries for failed jids identified above
  * 14. gfs2_control clears control_lock lvb bits for recovered jids
- * 15. gfs2_control checks if recover_block == recover_start (step 3 occured
+ * 15. gfs2_control checks if recover_block == recover_start (step 3 occurred
  *     again) then do nothing, otherwise if recover_start > recover_block
  *     then clear BLOCK_LOCKS.
  *
@@ -809,7 +809,7 @@ static void gfs2_control_func(struct work_struct *work)
 
 	/*
 	 * No more jid bits set in lvb, all recovery is done, unblock locks
-	 * (unless a new recover_prep callback has occured blocking locks
+	 * (unless a new recover_prep callback has occurred blocking locks
 	 * again while working above)
 	 */
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 616c46aa3434..27777497677f 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -155,7 +155,7 @@ int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header *lh,
  * @blk: the block to look at
  * @head: the log header to return
  *
- * Read the log header for a given segement in a given journal.  Do a few
+ * Read the log header for a given segment in a given journal.  Do a few
  * sanity checks on it.
  *
  * Returns: 0 on success,
-- 
2.48.1

