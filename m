Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992E145A05;
	Thu, 23 Apr 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947729; cv=none; b=aIPk30cLBx/YvXGPwrNmb/tKcBklPceAQNgLkNX0aYkOshKB5mxLdecFGLTFPgv+ZDYme0us5z5J7+vT0rkzFh3apQQ/vHGUeoy5zvLuPaKcVsbb3sTiuVFynf/GZzQX2e2AFd4fglcbZ46yKthZ9eE9X+IFZ9l3eRxoDhWVzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947729; c=relaxed/simple;
	bh=fgET4WMinVp/sWHJ7Z42x9/VB2GETJfml8E2Z2LxvOg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ncgktSmWx//99B1jWWrVkSbOhnKTD6iexTVQJyIRgnEi/VjKE1bvnOgAfZt+gFtoerFx4pMGjoeAPvfdKi/VjzcdSX1JnmEhW/GcEO8frVjqMTFxHLqZ4fzBV0/Xfv1iBTG0gGVtccEm1b3blOGGOUiEsrFeGBiDBr2qpX79nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KC7MqcQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KC7MqcQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0498FC2BCAF;
	Thu, 23 Apr 2026 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776947729;
	bh=fgET4WMinVp/sWHJ7Z42x9/VB2GETJfml8E2Z2LxvOg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=KC7MqcQwyHkw+Hxm17XvheBdjY6K2ANs6xfub8AFERzjPhvk57ZSvB6HTnoWd8W5s
	 gzgp0gSGPR7DJ4xCl02CaJu7nQPMSN5UmMZAHyiGO+GfYtAMHtCLeXPIzT7CuZFm9b
	 yhypLZTydydGv2eM/pdNKYzuBaE79MbumKy8E4o8=
Subject: Patch "gfs2: Validate i_depth for exhash directories" has been added to the 5.10-stable tree
To: agruenba@redhat.com,anprice@redhat.com,gfs2@lists.linux.dev,gregkh@linuxfoundation.org,ruohanlan@aliyun.com,sashal@kernel.org,syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Apr 2026 14:35:06 +0200
In-Reply-To: <20260423032002.2803528-1-ruohanlan@aliyun.com>
Message-ID: <2026042306-depletion-overstock-6779@gregkh>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    gfs2: Validate i_depth for exhash directories

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     gfs2-validate-i_depth-for-exhash-directories.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-240403-greg=kroah.com@vger.kernel.org Thu Apr 23 05:20:44 2026
From: Ruohan Lan <ruohanlan@aliyun.com>
Date: Thu, 23 Apr 2026 11:20:02 +0800
Subject: gfs2: Validate i_depth for exhash directories
To: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org
Cc: gfs2@lists.linux.dev, Andrew Price <anprice@redhat.com>, syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com, Andreas Gruenbacher <agruenba@redhat.com>, Ruohan Lan <ruohanlan@aliyun.com>
Message-ID: <20260423032002.2803528-1-ruohanlan@aliyun.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/dir.c   |    6 ++----
 fs/gfs2/glops.c |    4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -60,6 +60,7 @@
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -910,7 +911,6 @@ static int dir_make_exhash(struct inode
 	struct qstr args;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_leaf *leaf;
-	int y;
 	u32 x;
 	__be64 *lp;
 	u64 bn;
@@ -977,9 +977,7 @@ static int dir_make_exhash(struct inode
 	i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
 	gfs2_add_inode_blocks(&dip->i_inode, 1);
 	dip->i_diskflags |= GFS2_DIF_EXHASH;
-
-	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
-	dip->i_depth = y;
+	dip->i_depth = ilog2(sdp->sd_hash_ptrs);
 
 	gfs2_dinode_out(dip, dibh->b_data);
 
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -452,6 +453,9 @@ static int gfs2_dinode_in(struct gfs2_in
 	depth = be16_to_cpu(str->di_depth);
 	if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
 		goto corrupt;
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) &&
+	    depth < ilog2(sdp->sd_hash_ptrs))
+		goto corrupt;
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 


Patches currently in stable-queue which might be from ruohanlan@aliyun.com are

queue-5.10/gfs2-validate-i_depth-for-exhash-directories.patch
