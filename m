Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B23C1F57
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173675; cv=none; b=uZDNAvRpUGDjWSSOqT7qJlq7YaXhdQZbud3X0Dtk0ieAk+W1Md+zWoO8hozxcZaGDXlbw5wQKtBH9k7it+9BsAfYBsfOdSIKdF3kwvICIL0SvYQE3xIGfB0WxglxLc2Kfdoi/ljvZ9eJQ9lPRb268SwCls0DxWhQGKer2bkpxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173675; c=relaxed/simple;
	bh=TFNu8EnMdDhDnRdTdI6WOtz4htgP2HuJyYVuuH2HnXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4ZkavpXWsXwQ7MJ/BOaN1hHAjDe4/wOIqBUfSbo2GRyksQ6owKWFVw8O7ak2FI00qtAyv8zdcojL5zGjPJBFZFVW4HQ0SOYqHIK5SGijXwQeCXx0dlVjRrWFWqCAU5bYi0zmTzgJ2/Zwmn2Wqfm3nUP4cgoi/e4B8AZkEpasj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O23YbQv+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O23YbQv+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce98cb8165so32313865ad.1
        for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173674; x=1788778474; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zQNiu9TZQ10x49ZJ9yma2tHLImqVrjgDfm3we0pmhDw=;
        b=O23YbQv+NeO5i7PpFj9xEZm++banVMeGbMXXU+NLHw9d5SdnHFaktBhxlRQtYA5W2n
         3q7CYQmguAoOkc3eyQC7bmotdM/6X9+4tHQ0rJrwhSRUGE56GyvWl2hykAG6H7l5ZcmD
         ONQikZ40BjS3xmtq4bjINl+tsfzjYbbSWxuEjuaJIsUfUTAyMmEw4gBzeCclFD/R+j4M
         F9d/oDV8mU8p0kUznVi9rOGLahDcQk5uLgkWfi/4vnoqxjaODJtonGAiuoU+J5Xch3DB
         3vNwhQ1/W/91uxlwU2hU4cInUvP9h4UuvXmjZXFQrzdeazT1Kwl2EJ6tAFFo112vdNHk
         btKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173674; x=1788778474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQNiu9TZQ10x49ZJ9yma2tHLImqVrjgDfm3we0pmhDw=;
        b=hRtfVH4LGJFK2XzAQFHvRiTh7X4r71cyqoI8ALM+l2gQ0Q4UJj1ZRXPoCE6/atsqdT
         xVqah6tGHk/5IM9uNHwj3R1Snt/sfziU4moXnm93zaCZQ3axFME09D+DInSu09nSFTiI
         9ALTAJxZ70kXwhY2wP/jGL47gGh2RleBYt8uETd2NVzBXY2+S9GHuYG1C4NQOshWzcBZ
         Ig7MrsgK7j3rF6f4PCGgoO8kMorlA5bKBoKXYkCgmJ0bAM8+sG7KtBA8/m1rcH1mcPhM
         n1Mc1rf/KDeklfEerx2a6VdXyMGWfxAYgaY0jlr0vfUJBIE6GzruSvlQxOA4e1LwTs6e
         7ddw==
X-Forwarded-Encrypted: i=1; AKwUvBx6W8hukYE9MxoNBUWGvXXBtVLjVLNQO3xUvXWvmWLFEu66MLL3tGywsvPNYGTYphzu3mCA@lists.linux.dev
X-Gm-Message-State: AFuF++l5pDuwzJhxtmOunztiHfA/JS75EF4I8wfJ9ATuUkc+Lg2onK2Z
	rqW5mIjtYo7Q6Xrd3a56glBS85HUyAm+8EGyEU9X905NUyd+Y3BTq3WY
X-Gm-Gg: AYBFou2S4kGm414GlmMB7xy++68igKLspG4gZSdLf8VZ8xfB2X0UMF1SI2yChiAufuD
	HQbHt2r0nRw6px4y3gLgVYq7eUZ2PCUo70m3R23u3nEiKrwl27XtntTwUveq+jr2M/5D5n1iWUG
	X8PJzM100MG308fJV8flmu6xM99WAz+KT5hr20iRIU+YMSaCCgNkl7vB3xU7SPUtRri6GloTBJX
	lKgxcTCec8EkUc6P8egG1aTiLevlWr8BWiTrk9Fz40VOwWTQltDpDF0H54ocBgihx9MId7nDeQh
	5ntv5jzIDde+P4TqG5jSDHmvUQ5iYRdGa4ShOMWDkH5xscMMEe8+/C+3RTpr5Z9RUZ696DxbW7n
	j6vU0ayngfoVrLJMh72AVtxJMpnC8WN6LsIjgfrYhB5nZwBxtGoNOxZsq3rF3uyUcv+lBtspl3r
	puVkNVj8fEuz1oJHhTnXkjgIoeAh4WsRxzzVWPmIy8iqnv91rt2iCReiTQbD0+1yrXRpygfSQ=
X-Received: by 2002:a17:902:e949:b0:2d6:dcf3:b754 with SMTP id d9443c01a7336-2d91afa062bmr62301885ad.7.1788173673289;
        Mon, 31 Aug 2026 03:54:33 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d8f6a92239sm23720745ad.70.2026.08.31.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:54:32 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: anprice@redhat.com,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	Jiaming Zhang <r772577952@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] gfs2: reject oversized dinode sizes before i_size_write
Date: Mon, 31 Aug 2026 18:54:25 +0800
Message-ID: <20260831105425.622254-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corrupted GFS2 image can store a dinode size that is larger than what VFS
i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64 and
writes it directly into inode->i_size. If the value is larger than S64_MAX, the
incore i_size becomes negative. That negative value can bypass the existing
stuffed inode size check:

inode->i_size > gfs2_max_stuffed_size(ip)

Later, gfs2_quotad may try to sync the quota file and unstuff the quota inode.
gfs2_unstuffer_folio() reads the negative i_size into an unsigned length and
passes it to memcpy(), turning it into a huge copy size and triggering a
out-of-bound issue.

Reject dinodes whose size exceeds sb->s_maxbytes before storing the value in
inode->i_size. Also make the stuffed inode check use the raw on-disk size while
it is still unsigned.

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/gfs2/glops.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..8c5d257451d5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	umode_t mode = be32_to_cpu(str->di_mode);
 	struct inode *inode = &ip->i_inode;
 	bool is_new = inode_state_read_once(inode) & I_NEW;
+	u64 size = be64_to_cpu(str->di_size);
 
 	if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
 		gfs2_consist_inode(ip);
 		return -EIO;
@@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	i_uid_write(inode, be32_to_cpu(str->di_uid));
 	i_gid_write(inode, be32_to_cpu(str->di_gid));
 	set_nlink(inode, be32_to_cpu(str->di_nlink));
-	i_size_write(inode, be64_to_cpu(str->di_size));
+	i_size_write(inode, size);
 	gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
 	atime.tv_sec = be64_to_cpu(str->di_atime);
 	atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		return -EIO;
 	}
 
-	if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+	if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
-- 
2.43.0

