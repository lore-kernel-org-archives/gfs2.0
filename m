Received: from out30-74.freemail.mail.aliyun.com (out30-74.freemail.mail.aliyun.com [115.124.30.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F346AE1
	for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854447; cv=none; b=LcWDl/s1pnsK0aZFOi/DsPDFYD1cGOcjI8DK8Z70oMoL3PhpWTZaHmkNP+E6rkE9ZiOdXZ2RusZYODYz/gi8/olOwK3uqZCUkUsoDwLnolAsw2owMoyDDc34VVGZYy2+kLY3UYxlHvgNqC/raNqb35PioSTUr8pGZPKfsRpVc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854447; c=relaxed/simple;
	bh=0if3ZbkPteZ/1AyhraYHD/ONE78ulLCd6pPsgf50gvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1C4eeUNBv9tba4c07mU1Mm6BC8jZmgTqqE2IZQWOyeEeocwsH+bbs00S2FrFd+wBUYe/BUgf1dph09mGg5KE6DIjI11iSQDeepHmhWLxZmPOMJtEejRl1UrsYl2NhMWZHZuUugu/4J354+IYMq3sscrVcb1eoXwFdQRi9GYdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=JvXUh8Fr; arc=none smtp.client-ip=115.124.30.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="JvXUh8Fr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776854442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vwf3SX+Yo+KS2pbmrsmxsXmWddKCuVLLCwu7JpgPAok=;
	b=JvXUh8FrQCaf3mof7RWU2qWaqo58NlFqdiSkEVjgb8cf6pxbL8FaGE+E+OtrgZVnowBNVvHx6w0BGTE85UX/Ui9fuh0ZqBu5nM/Eg5bVc5vy5g+ezkGZMBsWEFzY+jog1EdxiK/rIQ6dCHqpP+8d+fp4VK/pIE9o2MYv7CRFuRc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07358415|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0488239-0.00340513-0.947771;FP=2233420379848895703|2|2|7|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1Vu7pa_1776854440;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1Vu7pa_1776854440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 18:40:42 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y 2/2] gfs2: Validate i_depth for exhash directories
Date: Wed, 22 Apr 2026 18:40:21 +0800
Message-ID: <20260422104021.816-2-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422104021.816-1-ruohanlan@aliyun.com>
References: <20260422104021.816-1-ruohanlan@aliyun.com>
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
index e1bdc4b0608c..559cad553db6 100644
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
index fdbae357727b..8a077de9ee0a 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -459,6 +460,11 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
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

