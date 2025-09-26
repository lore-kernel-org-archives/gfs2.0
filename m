Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D368287E
	for <gfs2@lists.linux.dev>; Fri, 26 Sep 2025 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855464; cv=none; b=a0445/iB8nXLwhOjSuJwbinY/3INFkRX5MmSO0BcNwqd6ZM9B3Umk4rXnbsMrYjNcqv+HfC8LTnvPkjGYkJtDsrZyYDelAHs0wFv5FCvtU1ZLxaVzklYbLxQLaeZNwAviyaklaKW7GPS+yVed0q730GXr1ZXSgGhbdB1Rf5KgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855464; c=relaxed/simple;
	bh=0seR/PPCeNmqCqEO+CWxl4vQFh/Swbrz7dNPOFg2U8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAiNxAHT7C/VLIkJDKcxoI+zC53N04Cvd+v0MR2bX9miIZnHZ4oC5wYJNsxAir97T3w5vkATj91ipUTEM+W0j0wxN5rb15qh7zvy0DgJQOjIddoYfDljEMcxlluvXvl34P3ZSsQMdPajCPBLqdCZIIb4nBksr7MRG2D3kUxXqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ErkBwIxn; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ErkBwIxn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758855449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMI3PZUF0sh3zSd/02iYpfvXrjt5XLvTI4LxgYH0VXg=;
	b=ErkBwIxniq2ZxzhmdPHgOou7mR8kgIHkwtskgQaDy9V/FGhbFnOyVVnrBzuT+F4NiFAiI7
	+jSJd3wxQJbdNeefgRygLePWLrxMkSj/OvrNAH2WsWKnwT3Bs2jLOo0ZO1RgXlMZfgQZ2y
	LJEPJyPfI0IOwlSrcJ6X9WNFd5M6gao=
From: Youling Tang <youling.tang@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] gfs2: Move i_nlink checks from gfs2_{link,rename,mkdir} to VFS layer
Date: Fri, 26 Sep 2025 10:56:04 +0800
Message-ID: <20250926025604.500713-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

vfs_{link, rename, mkdir} will check i_nlink. When sb->s_max_links is set,
set sb->s_max_links in gfs2 to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/gfs2/gfs2.h       |  1 +
 fs/gfs2/inode.c      | 10 ----------
 fs/gfs2/ops_fstype.c |  1 +
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/gfs2.h b/fs/gfs2/gfs2.h
index ed78e5f20f41..06a7f731d34c 100644
--- a/fs/gfs2/gfs2.h
+++ b/fs/gfs2/gfs2.h
@@ -18,6 +18,7 @@ enum {
 };
 
 #define GFS2_FAST_NAME_SIZE 8
+#define GFS2_LINK_MAX	0xffffffff
 
 #endif /* __GFS2_DOT_H__ */
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..f2a6420e1fa8 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -373,8 +373,6 @@ static int create_ok(struct gfs2_inode *dip, const struct qstr *name,
 
 	if (dip->i_entries == (u32)-1)
 		return -EFBIG;
-	if (S_ISDIR(mode) && dip->i_inode.i_nlink == (u32)-1)
-		return -EMLINK;
 
 	return 0;
 }
@@ -1079,9 +1077,6 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out_gunlock;
-	error = -EMLINK;
-	if (ip->i_inode.i_nlink == (u32)-1)
-		goto out_gunlock;
 
 	error = gfs2_diradd_alloc_required(dir, &dentry->d_name, &da);
 	if (error < 0)
@@ -1623,11 +1618,6 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 				error = -EFBIG;
 				goto out_gunlock;
 			}
-			if (S_ISDIR(ip->i_inode.i_mode) &&
-			    ndip->i_inode.i_nlink == (u32)-1) {
-				error = -EMLINK;
-				goto out_gunlock;
-			}
 		}
 	}
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..823f3d987d6c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1152,6 +1152,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE;
 	sb->s_time_gran = 1;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_max_links = GFS2_LINK_MAX;
 
 	/* Set up the buffer cache and fill in some fake block size values
 	   to allow us to read-in the on-disk superblock. */
-- 
2.43.0

