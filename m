Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE8194AD7
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930316; cv=none; b=WSclZ8l005ZQWDFnac6SFa7YIQibAxc45aHqdR/vGnM55KdbkqNWk8LtqoE9c8AbRxVE/xVSAFDZqeBxp8op8vlM/i6qH/OZCOLvJj+fz33SoaURYc/aJN8vkZqMqWahc43WWEXBGvREEF4ME1tmwlDE5qYuehGODZnMX/jt/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930316; c=relaxed/simple;
	bh=R1MKjdiumblZFGZdDvMtW02CeKC/L/abULNWROFP7Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEO+baNIiXnYlAeGB+XUKewOcn9XMKXJo0tjnGGdi4933M5qogjRqOyhfCsK6qxRHGltsNJbVhxIcnukK5kL6RtAg6ajw7wP/DWOb5b6JPjXvnH2baNUSJj+7Uzgo7uYM5nZRSK2z7kwHvdit5TRKaSvzZToA+wtj4OuH4N4N2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XsQlm6GKwz4f3nV8
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 19:44:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 398D01A018D
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 19:45:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S6;
	Mon, 18 Nov 2024 19:45:11 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	agruenba@redhat.com,
	gfs2@lists.linux.dev,
	amir73il@gmail.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 02/11] block: use sb_for_each_inodes API
Date: Mon, 18 Nov 2024 19:44:59 +0800
Message-Id: <20241118114508.1405494-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UWw13ZryUKF1UKr1fCrg_yoWkWFg_Ja
	s3ZF4jgr1xZwnYkrsFkrnxAFZYkw1xGF13trnxtryxZr15X3Z8Aw4xtry5Xr1DCF4UG3s8
	ur1xZFyfGr4fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIID7
	DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Use sb_for_each_inodes API foreach super_block->s_inodes.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..b29e2c5c7c6e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -478,7 +478,7 @@ long nr_blockdev_pages(void)
 	long ret = 0;
 
 	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
+	sb_for_each_inodes(inode, &blockdev_superblock->s_inodes)
 		ret += inode->i_mapping->nrpages;
 	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 
@@ -1219,7 +1219,7 @@ void sync_bdevs(bool wait)
 	struct inode *inode, *old_inode = NULL;
 
 	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
+	sb_for_each_inodes(inode, &blockdev_superblock->s_inodes) {
 		struct address_space *mapping = inode->i_mapping;
 		struct block_device *bdev;
 
-- 
2.34.1

