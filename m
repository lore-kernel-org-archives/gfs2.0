Received: from out30-86.freemail.mail.aliyun.com (out30-86.freemail.mail.aliyun.com [115.124.30.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BB3B27E2
	for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854281; cv=none; b=e4c/b6Vjp7OoDoE+9WgLPZl2rTzNNu77fnLTu/3qscbmcrwV2a1QcKnFzT+oPoeupL6yvCE0vZ7gu5t+3e6b1n0yDIcIMkhLpAY8jYkbhFiwMTEjLgdVIjZSX8RPKR27JKZB0S9Zy+D8BkTsxurQR4JIeIl3dl8HRoy2fcYUI0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854281; c=relaxed/simple;
	bh=vd8/gCUCgi4rVzEjVgzGFjGvoliM3N5zSWIgA+GmPm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrcKuX53/3kST7s1FTy9l1f1xszOcStOftIW+VWvL9y+XyoiOp+1jcnFKHeSNnFdMs1H38bRNqgXXRYLcuk9Vd7gbzt/WWpZuOZFYb5TzPiMVtnTWTbA+StARzEUiej/15HiEA9qjc388vuXcZiM2cvjXJ5pqYxT3SqnGfZ1RBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=C+g8X6fO; arc=none smtp.client-ip=115.124.30.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="C+g8X6fO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776854278; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/ZuZS0UevaizPDdgKMu+YC+tzvXWJ6x4ZHNoj/yNQIc=;
	b=C+g8X6fO7q5sNnJ4s3xlfxTAYARp351qMd2ht2OysuI6WRZa5MTK+Xcs1m0rg2nDr0DwOm9acdVVPI6tVaKAco4R57Sz4KAa2fzkVeTCXitVVIwjdmmuUu5wd9lLqk4n4ugggpdfjPkR0cEYMQfE1UdhSdyzHwLsGOXdQzzQG/k=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07358602|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0505156-0.00404833-0.945436;FP=11456792416704195799|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1Vu77v_1776854275;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1Vu77v_1776854275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 18:37:57 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y 2/2] gfs2: Validate i_depth for exhash directories
Date: Wed, 22 Apr 2026 18:37:17 +0800
Message-ID: <20260422103717.613-2-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422103717.613-1-ruohanlan@aliyun.com>
References: <20260422103717.613-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Price <anprice@redhat.com>

[ Upstream commit 557c024ca7250bb65ae60f16c02074106c2f197b ]

A fuzzer test introduced corruption that ends up with a depth of 0 in
dir_e_read(), causing an undefined shift by 32 at:

  index = hash >> (32 - dip->i_depth);

As calculated in an open-coded way in dir_make_exhash(), the minimum
depth for an exhash directory is ilog2(sdp->sd_hash_ptrs) and 0 is
invalid as sdp->sd_hash_ptrs is fixed as sdp->bsize / 16 at mount time.

So we can avoid the undefined behaviour by checking for depth values
lower than the minimum in gfs2_dinode_in(). Values greater than the
maximum are already being checked for there.

Also switch the calculation in dir_make_exhash() to use ilog2() to
clarify how the depth is calculated.

Tested with the syzkaller repro.c and xfstests '-g quick'.

Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 fs/gfs2/dir.c   | 6 ++----
 fs/gfs2/glops.c | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 96924af95c8e..3716d89d8af6 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -60,6 +60,7 @@
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -912,7 +913,6 @@ static int dir_make_exhash(struct inode *inode)
 	struct qstr args;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_leaf *leaf;
-	int y;
 	u32 x;
 	__be64 *lp;
 	u64 bn;
@@ -979,9 +979,7 @@ static int dir_make_exhash(struct inode *inode)
 	i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
 	gfs2_add_inode_blocks(&dip->i_inode, 1);
 	dip->i_diskflags |= GFS2_DIF_EXHASH;
-
-	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
-	dip->i_depth = y;
+	dip->i_depth = ilog2(sdp->sd_hash_ptrs);
 
 	gfs2_dinode_out(dip, dibh->b_data);
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f4bd487a9b3b..e7904c1c985f 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -458,6 +459,11 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) &&
+	    depth < ilog2(sdp->sd_hash_ptrs)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-- 
2.43.0

