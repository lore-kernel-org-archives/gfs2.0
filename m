Received: from out30-82.freemail.mail.aliyun.com (out30-82.freemail.mail.aliyun.com [115.124.30.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6522D4C3
	for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914441; cv=none; b=LoPeNzAvtX3Oglh2AhIRNrDR/CScy7SAxq2vxXw//kSs/h9b++M+LsqvKFd9qXsbk6tTl5keOgd5tbhQ4t/tQsHH2ck12N9T3sxTV/xZuyXsmZpNxXgAEveEFcp3RYe3isRe/eJajL/7eDFBAN89lKdgeIAwmUC4Ww1mKG4xacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914441; c=relaxed/simple;
	bh=I8hELIny7FNKUVBOWrMq/lhxyBAmeuZhX2S/0Uv9MEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bcxci17TrO1XxZKG9ZhnO2X412xYfAUmCohojrF78DoUlSmvYJ690V2PzQilOjTwyLF4n10ACTlJDrIudRxdm+t6l/XaoLj6Qutbx0BVeAq8pdiQIQ5Twqv56c0nlGK5WtZBjJwAXr98AvYWKH1TrMhIr8B0KoaUCKCYrcP/jjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=F6ZWyAM2; arc=none smtp.client-ip=115.124.30.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="F6ZWyAM2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776914437; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1TVO0IAj8sUuaMrJ+zElAkcm6qSIuAxDoIvGoa6chdA=;
	b=F6ZWyAM22BlptiSsQiLk0viVlpzs1kbDp+rnj3JlFE6C+fNZ8FFWNTEASjKYN9bw4/0h6IBWaSxQj2Cyc2N5jTqy/c7FRRtG7nxmDW6aVwdmtTRwxkDPt5HTFeN0klPzWQY8uW8MQNbfIWfD2+XKE6uRRIg0DKdEceZkt8plLZo=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07358088|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0586597-0.00734281-0.933998;FP=6914912296662133975|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1YFzfZ_1776914426;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1YFzfZ_1776914426 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 11:20:36 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.10.y] gfs2: Validate i_depth for exhash directories
Date: Thu, 23 Apr 2026 11:20:02 +0800
Message-Id: <20260423032002.2803528-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
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
[ To maintain consistency in error handling in gfs2_dinode_in(),
use "goto corrupt" in v5.10. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 fs/gfs2/dir.c   | 6 ++----
 fs/gfs2/glops.c | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 4517ffb7c13d..7b11f7b7151a 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -60,6 +60,7 @@
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -910,7 +911,6 @@ static int dir_make_exhash(struct inode *inode)
 	struct qstr args;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_leaf *leaf;
-	int y;
 	u32 x;
 	__be64 *lp;
 	u64 bn;
@@ -977,9 +977,7 @@ static int dir_make_exhash(struct inode *inode)
 	i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
 	gfs2_add_inode_blocks(&dip->i_inode, 1);
 	dip->i_diskflags |= GFS2_DIF_EXHASH;
-
-	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
-	dip->i_depth = y;
+	dip->i_depth = ilog2(sdp->sd_hash_ptrs);
 
 	gfs2_dinode_out(dip, dibh->b_data);
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 87f811088466..a4050468fecc 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -452,6 +453,9 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	depth = be16_to_cpu(str->di_depth);
 	if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
 		goto corrupt;
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) &&
+	    depth < ilog2(sdp->sd_hash_ptrs))
+		goto corrupt;
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-- 
2.43.0

