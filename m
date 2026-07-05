Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01B377EA1
	for <gfs2@lists.linux.dev>; Sun,  5 Jul 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260459; cv=none; b=hN1smAhnW6wpAg9HcvGlj7QiL70k8BJlSbx4ZWGaCMBbM47yDXa4HziPfeIhUMsn9QqOdZNlruKq//lmidEr9wj3cJ13F5VruZX28FiU0f7+Q5KjlFg7Eqi5AthRRNBksYrBaUgYJS93QxEDTCwIi4nW4mWKoQ6LLqDudYCGq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260459; c=relaxed/simple;
	bh=E5aD1rjr/Ny3UIfv/rIdB/B/rT2PNtU/rM+Il693iww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEh8Vc4EtBp13Q+Rv+aYHTrKlhXDNBWy6nHqzXjkB2kSrTxkY04kqHApSfmVuJrJ53XV+HH2GOd3v/iSfLnZ8tPGxsmCa03Ech2U4ZCug0jlmZjX2o683wOBkWuOs31Br4V13f0tFX6P/fbKOh9iZhlh4Qp7MpcqNcR16J0BTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUcD3Y4b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUcD3Y4b"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caf4496889so9005385ad.1
        for <gfs2@lists.linux.dev>; Sun, 05 Jul 2026 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783260457; x=1783865257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qItYY1MC23y2gpUN/PlpNHVEWcc/m0+Eso8v+dJUDBI=;
        b=JUcD3Y4b5MmZa+Y0Epcs6FGfm9SSoi/UwTsaIwhc3eS7TFWd4iS44g7JWpa+QF/7JL
         ZPddBwETLNEbhWhUieWkQKursD1B6wn6lmsGYfLXIdsa9Ls8e6s10oW1Mrh6jlXnPYAe
         KiODlZOIzZ9T4ntN6O9/Rs4llM11KXeJb+apSIOa82/z+sl4s8iV23LUxVDRrPSJoqlI
         /Sg6DSrD1b+3k43gzn2kexChoYJED+xwqQ/pFdMmHAi4bVXbK+n3+LO38tmmcBZ7D4Li
         xR8Iodzx6f3MtdVImSIbabufkWTN4lB9LwLcinv0+gH8ooXCAS1fsmbtMw+zRYk/jrRB
         cLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260457; x=1783865257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qItYY1MC23y2gpUN/PlpNHVEWcc/m0+Eso8v+dJUDBI=;
        b=hvRT/uvgVHvlkBqk2CKsil4KtrMS3+7+0n030zvXHm3LgiayX8+y7hNt/pnvNYan6E
         Tey0jjDbAs7NZp8Mf/VYgYnFZlUcaArN04pVuPsR/F4PbyS4aRBlfEX/OFuiWSMKejfS
         t5rOjA+3juW3EFxFA0Ic7fev8dJIdVQKrPQkP0FVJynVg6V+nzUpHLKEwR1hsPlwoSYo
         MzOowB73+NP7LbrSzKWp9o2VjS7PR2Nl5CQaXncIf14yqT3Lm7LUhp4j5ocJYIItLvDC
         UJj9IiCLlQdUwfQWKaTd+wlQEWCMOCtLWihfeMco7omTgUxHsFLIQL/E2+4ND4/3t9i6
         tq3w==
X-Forwarded-Encrypted: i=1; AHgh+RrsaBuFIb8esF2tJ2dJG/eoXXbGgpjkydjoLcq1WjAswCOGtwdbqh8yYoNLFYs3C1hsVMKE@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk94rdgvTXwL+GXWQ09OfoSsl5J64O3WCLDAsCMA5jtx8YWCjH
	e/Pd7nMkv1CS5x0/aW7KpEorq9qv28i5tooVggKI8S1gEyLy6lro485o
X-Gm-Gg: AfdE7clbZh7Tlo95UR1d/lLwH1ZljF7t8mAP8UTNa6fhYIk0GdtNB+QGnX4zq8mqcjy
	xd8Qd0f6pE3H7HWn1uadBsYbbfVqfqQfqHXN83FVAMVo7BQ7YuilOcfUo1obuHgDvy2XgGH+yFB
	dCaLOaLK5FYHZwvGHzb/KZ4Du1ULr5h195vEwgOzFZEdkBI3AwfeJ+Tw6VI49TuoI3BsDCo+2gE
	8GzdbS3Wc/8/3GDqZ1Eh50nTzojyrc6IdA3gIpgwwG5LAGF+ly4urdgr6Q/URvaApw2UAE8v9dk
	mjg5wblDfqNjMLqg9wp1YvuZLab/STx7RPb4mwy6NH/iEmFF2ZniTsI3yMWnER/rvFdbcRIpwB1
	kuda5xNph+uEwJud8dr8xo1osRA0RRPa/KjLUKiI6E5HuQT+o5ZjtVdm7bzzAygo6aL/+aXjj2B
	uRMTUDd8+dTn8I5upqhg160/fny/ADSQ0S+A==
X-Received: by 2002:a17:902:d551:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cc0b23ef33mr52337205ad.22.1783260456801;
        Sun, 05 Jul 2026 07:07:36 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad78aa06bsm34446105ad.84.2026.07.05.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 07:07:36 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: r772577952@gmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	stable@vger.kernel.org
Subject: [PATCH] gfs2: validate stuffed inode size before unstuffing
Date: Sun,  5 Jul 2026 22:06:20 +0800
Message-ID: <20260705140620.1732914-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com>
References: <CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com>
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
it is still unsigned. As a defensive measure, validate the incore i_size again
before unstuffing and pass the checked size down to gfs2_unstuffer_folio().

Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Cc: stable@vger.kernel.org
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/gfs2/bmap.c  | 18 ++++++++++++------
 fs/gfs2/glops.c | 10 +++++++---
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..89c46c1d622c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -52,16 +52,15 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length);
  * Returns: errno
  */
 static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
-			       u64 block, struct folio *folio)
+			       u64 block, struct folio *folio, size_t size)
 {
 	struct inode *inode = &ip->i_inode;
 
 	if (!folio_test_uptodate(folio)) {
 		void *kaddr = kmap_local_folio(folio, 0);
-		u64 dsize = i_size_read(inode);
- 
-		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
-		memset(kaddr + dsize, 0, folio_size(folio) - dsize);
+
+		memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), size);
+		memset(kaddr + size, 0, folio_size(folio) - size);
 		kunmap_local(kaddr);
 
 		folio_mark_uptodate(folio);
@@ -92,9 +91,15 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 	struct buffer_head *bh, *dibh;
 	struct gfs2_dinode *di;
 	u64 block = 0;
+	loff_t size = i_size_read(&ip->i_inode);
 	int isdir = gfs2_is_dir(ip);
 	int error;
 
+	if (unlikely(size < 0 || size > gfs2_max_stuffed_size(ip))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (error)
 		return error;
@@ -116,7 +121,8 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 					      dibh, sizeof(struct gfs2_dinode));
 			brelse(bh);
 		} else {
-			error = gfs2_unstuffer_folio(ip, dibh, block, folio);
+			error = gfs2_unstuffer_folio(ip, dibh, block, folio,
+						     size);
 			if (error)
 				goto out_brelse;
 		}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..33575fa681f5 100644
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
@@ -707,4 +712,3 @@ const struct gfs2_glock_operations *gfs2_glops_list[] = {
 	[LM_TYPE_QUOTA] = &gfs2_quota_glops,
 	[LM_TYPE_JOURNAL] = &gfs2_journal_glops,
 };
-
-- 
2.43.0

