Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6E1A0718
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930321; cv=none; b=ECi5stkIE3TGhX6GhWoGlX9OyAqcDNz/NVY5nWg7j21kPxTF/SnxFymAcYASCI0HrkYK/nEiGo/GqupzzJ70O+JdngdpnCZpdGM+LziTNkmxXudJa4hJsmhTbpBt3nsBtrACcm9GGshlDKmzG34clZGrJ/Vab6vE4uCNCEJjc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930321; c=relaxed/simple;
	bh=Ie7+Y2P96jQDsIJ9iZsKmlswzDmS/OznA23gsg+kWe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeQZWbghfGusbAA4Dm9NHGId1AxxnWFTsFRtGoufQbdH3DbCbrULc5DrB/1ji9dRe2Ax9I8dAtpEW0JgpcGDDX5xD7KRxXdygcJJhG2wge79QbLPxJsGWh8g98b6a46joUnvowIb9cwVBavg7iFsebDjuucpnBeSrlagAWjNzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsQls5LP9z4f3jXy
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 19:44:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 321BE1A0568
	for <gfs2@lists.linux.dev>; Mon, 18 Nov 2024 19:45:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S12;
	Mon, 18 Nov 2024 19:45:15 +0800 (CST)
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
Subject: [PATCH 08/11] fs/super.c: use sb_for_each_inodes API
Date: Mon, 18 Nov 2024 19:45:05 +0800
Message-Id: <20241118114508.1405494-9-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S12
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UWw13Zr4kGrykJw15twb_yoWxtrc_ZF
	4xAFWjgw43XryS9r4DKws3ZFsakwnakF17Gr43JF15Aw4jqFn8J3yktryF9rn8CF45tr98
	Ar1xtFW5ArWUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Use sb_for_each_inodes API foreach super_block->s_inodes.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index c9c7223bc2a2..71bd0b41468e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -658,7 +658,7 @@ void generic_shutdown_super(struct super_block *sb)
 			struct inode *inode;
 
 			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+			sb_for_each_inodes(inode, &sb->s_inodes) {
 				inode->i_op = VFS_PTR_POISON;
 				inode->i_sb = VFS_PTR_POISON;
 				inode->i_mapping = VFS_PTR_POISON;
-- 
2.34.1

