Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB0376A12
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199786; cv=none; b=kN26AiptzAbgDfT82Q+fjhWlf3Ao60OvArX221gPlUZtZGWBTPkSwhxZqRh4XCI1aR+C8i08n+zd8PlanPkseyRbsCzvJYzhRGBVfm9ROeHLH6uQIGWVRiHjTQKHyQV/M1LTQU1g+NmCueQGhF0nillCK9B6yLqqWaQ5F7DeIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199786; c=relaxed/simple;
	bh=6BlpT8JN5aJlHP7+FCNsHkF2VI/kIKNpCjTjsd3gH+8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a3yOysPz61KARrt7cn0r+ACENKVP/rJg6iY/uwoz6pFRiLzOY1SeViZ9reWZ8amADxWIbS8y5ewXiNUUSEMLCYAS5EG2V9dNAtTundTigBrcz03TX0FWJUCK7o+jeHDnpQiH+/WJPAaQ3AU62+wkMN5dppm7qOjHD83mo58Qy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AYbTuFhY; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AYbTuFhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787199774; bh=OXRmnuz5ZMfJwMTMAGg3K+NGWRx+85asi7BTWGREPBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYbTuFhYPUIHpatitmCPSCKe0rzgAFVMou3ILS88I/mGMR+luvIz1SrgaOvj3TUzF
	 zE6QVnWOtoe7tULFyKVZHyQdv+Jx8QWruNCjldgisLTfXPTS9Biv01ipU648rUFEz3
	 817PZAIrjry0rp8QivnqLj/MbRpj9eQ1AuVdb0Yw=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 56603215; Thu, 20 Aug 2026 12:21:38 +0800
X-QQ-mid: xmsmtpt1787199698t5wm9axdy
Message-ID: <tencent_D69518E8F6ED56CE0479766DD82CC56EF00A@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ+U3yi7+TQIx+TTklNSKs7GKtNTXxTWC3i/vcI1IjR3MIm6ywSJ
	 Tb6dXO9jMLfX2bpQAU4jnavDKAq7oZ4qQDxSjDD7xpR10SkHJbOUsuNmA151uD/FEj3L5L22+tdP
	 AtqVasGWVmJUol+/ySSLTdx+qI1AoPijMEPVbWeNSqh2j5RD/ZiESgF1EAbNjZFQFQF2Ujr9afFj
	 nAYBK1sdmWxFGzUznAoR8W4skNqh72ElKhbK1cUw80N4JeJDleq3avnpB2wwKpJT62/ZP2H1n+c2
	 JyeqV4FfdN1trgxhIcqeiRWuhr0VSrxU6gm0QeFSRY2+D/ENhPQChCNcrX5svWy/tEHU1hfeL/ZQ
	 8MA9zHWql28CXiqlBwwyl37yVc/JbyjoSr3rVjgKxjFIj4zbBj08C8QDov1wmOY0csLgXds3NBcx
	 DcWbs0u1qP9F0KTLwQBcAW2Cxfi3hOLOXI0kzecBA7POI05azWXm7qq7fzXclUqr3gXlFrQBEQrG
	 nLcwFpvNkm59nIObbjkuFDhEgHiqSP4YZP1BlLli6dd/QblUdGjcQqfNDwFXiNWmTiOdqolnCzdV
	 gW7y2GLN+ofuQ93Uf60lTfF1e6xxR+/HdGuYtMcI9tWaS2nUDfYDm5hb1X6KIUA9rK9KOyX3DL/+
	 ueNkfZSG7k25rRYA/zoHAWhEMCpI/6KAlpBVrU5dTDmYOHwf6FuRkOuonejXfB09UV4+oeSnn9kf
	 H5f/CnlZgOIsNA1SYoXMRBCmrw0ub4qZQsffB64J4aV1NiUPE83Ox0SOo79oAan0yhHGUWkQeG4f
	 +ObXrDqKeFubqUDTo/ZwxMA6iu17kbZkXiKHEo7lu4vCIDDx4sMyC4pDo5GGU7gZLTb5qOn0Zk6R
	 BYhPmM7h4soiD6YOzB2aCBP2toVFGyMrx9Dy/jTjF/3RR3W6y3bHIPV1oEAHC4Bz5wOKulUvRU5R
	 FR4zcqHQDRYruMFl3honc/q3QaCqNjQZpxc+FEeUyasrWzOw1cBDw54/6fSvU+cBNmK4qUbhbAxl
	 tJEZ56/T7HyQsM2mQ7F9aDS8kbiOwXXlgMrbE+cWxxbP2hNdF+iNBawZHKhFNUWeyv3esfgvlmYO
	 rWk8l4
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	swhiteho@redhat.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gfs2@lists.linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matthew.brost@intel.com,
	rakie.kim@sk.com,
	syzkaller-bugs@googlegroups.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com
Subject: [PATCH] gfs2: valid the length of rgrp header
Date: Thu, 20 Aug 2026 12:21:38 +0800
X-OQ-MSGID: <20260820042137.518834-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
References: <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting a deliberately corrupted filesystem image, an excessively
large rgrp header length is used in a call to kzalloc_objs() within
compute_bitstructs(), and the memory allocator cannot handle such a large
allocation request. This triggers [1].

Add a check for the rgrp header length to avoid [1].

[1]
WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x2427/0x2dc0 mm/page_alloc.c:5280, CPU#1: syz-executor256/5629
Call Trace:
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 ___kmalloc_large_node+0xe5/0x120 mm/slub.c:5274
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5305
 __do_kmalloc_node mm/slub.c:5322 [inline]
 __kmalloc_noprof+0x5a1/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
 read_rindex_entry+0x4a1/0x1250 fs/gfs2/rgrp.c:931
 gfs2_ri_update+0x6f/0x3b0 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x40b/0x480 fs/gfs2/rgrp.c:1051
 init_inodes+0x1f78/0x2790 fs/gfs2/ops_fstype.c:872
 gfs2_fill_super+0x1d3d/0x2cf0 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1640
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x320 fs/super.c:1700
 fc_mount fs/namespace.c:1198 [inline]

Fixes: bb8d8a6f54c1 ("[GFS2] Fix sign problem in quota/statfs and cleanup _host structures")
Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d20c3ad7d29227de28d
Tested-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/rgrp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 5988a165a830..53d097ce668e 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -899,6 +899,7 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 	struct gfs2_rindex buf;
 	int error;
 	struct gfs2_rgrpd *rgd;
+	size_t size;
 
 	if (pos >= i_size_read(&ip->i_inode))
 		return 1;
@@ -917,6 +918,13 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 	rgd->rd_sbd = sdp;
 	rgd->rd_addr = be64_to_cpu(buf.ri_addr);
 	rgd->rd_length = be32_to_cpu(buf.ri_length);
+
+	size = rgd->rd_length * sizeof(struct gfs2_bitmap);
+	if (get_order(size) > MAX_PAGE_ORDER) {
+		error = -EINVAL;
+		goto fail;
+	}
+
 	rgd->rd_data0 = be64_to_cpu(buf.ri_data0);
 	rgd->rd_data = be32_to_cpu(buf.ri_data);
 	rgd->rd_bitbytes = be32_to_cpu(buf.ri_bitbytes);
-- 
2.43.0

