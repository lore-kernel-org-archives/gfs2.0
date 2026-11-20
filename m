Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144416;
	b=ebUXTMoSmF7palT0St86QjWYyFwG8G1wK/9VErdN4315iZNQTLIoj2UY+6+oZHY9J2Yq
	 Pn1Tq4U6x7KQCUlDEPfpWg5/n/D5DHXAOTQMGx4kobovsywUtKDXzurOmhJygrcL2XI2K
	 SolC1ScgXHXdx/Nu5q/5T0fQPPZ5e30XQZsKADZoM1nAW9q408UxLSKyEod7FYRxOIbXP
	 t3HW1S7d69F5U/wLVJtmzgJYSDLdnDjOynQ+G1+qxSVb4gtE6UYu5Oon/jmW6Nq/cjUui
	 8reIPTK3kZzkX2B1CGXBdyBI5gxKKF0hqa6KWg5AY59C4seaLhUoQOuiMiGwPewBM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144416;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=++vwF3/aYnq3i5kVxaq8VS+fg3m4S+G64LZ6YaI01gY=;
	b=e1cgRlE5w1NKVmKNKg1QCfW2x6uBh1jOzoRxdPqTMIsOvNio/TT9RPw50DthGqqYsbY8
	 2uOHUpRueczPnCn9PHir7Y5QDhfCAYjiPuZ+O54fdJLDNI7CYg1BCBujc16SyeCc/hlQ/
	 VmVZEcUsq+mnNOHlu2sa/nnzj/BaMIXsLKLR2NJ9PXW2e21F6KAoq5tjK8+36Pxl9GXa+
	 eekf8MdFSQSHtQ4OBQ9F/GiG0ZbbCO8vyFgEhiZDComxS2r0/sxi2ug470FkQ3Vum/ZcK
	 HCdU3MWhkhYNdMh7lqW3w0xqtUzJAqlkC1DUkhMPumCdHt5CFzGAL3TBN93KSY0WlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59060A2621
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF59060A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ly3DvgzVcBF;
	Fri, 20 Nov 2026 11:13:34 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lv5RMvzVcBJ;
	Fri, 20 Nov 2026 11:13:31 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 75322C087;
	Fri, 20 Nov 2026 11:13:22 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:29 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<hch@infradead.org>, <agruenba@redhat.com>, <mic@digikod.net>,
	<axboe@kernel.dk>
CC: <gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <legion@kernel.org>, <aleksa@amutable.com>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <djwong@kernel.org>,
	<sandeen@redhat.com>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <wujianyong@hygon.cn>, <shijie8@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, Huang Shijie <huangsj@hygon.cn>
Subject: [PATCH v3 07/11] block: convert sync_bdevs() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:01 +0800
Message-ID: <20261120031305.3561045-8-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120031305.3561045-1-huangsj@hygon.cn>
References: <20261120031305.3561045-1-huangsj@hygon.cn>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Convert sync_bdevs() to super_iter_inodes().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 86 +++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3c1d38475607..37fa47fb15ac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1339,66 +1339,48 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static bool sync_bdev_eligible(struct inode *inode, void *priv)
 {
-	struct inode *inode, *old_inode = NULL;
+	return inode->i_mapping->nrpages != 0;
+}
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+static int sync_bdev_fn(struct inode *inode, void *priv)
+{
+	bool wait = *(bool *)priv;
+	struct block_device *bdev;
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
+	bdev = I_BDEV(inode);
+	/*
+	 * The inode does not keep the gendisk of a partition alive, the
+	 * device does.
+	 */
+	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+		return INO_ITER_RET_NEXT;
 
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * The inode does not keep the gendisk of a partition alive, the
-		 * device does.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		if (!kobject_get_unless_zero(&bdev->bd_device.kobj)) {
-			spin_lock(&blockdev_superblock->s_inode_list_lock);
-			continue;
-		}
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
+	}
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	put_device(&bdev->bd_device);
 
-		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!atomic_read(&bdev->bd_openers)) {
-			; /* skip */
-		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
-		} else {
-			filemap_fdatawrite(inode->i_mapping);
-		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-		put_device(&bdev->bd_device);
+	return INO_ITER_RET_NEXT;
+}
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
-	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+void sync_bdevs(bool wait)
+{
+	super_iter_inodes(blockdev_superblock, sync_bdev_fn,
+			  sync_bdev_eligible, &wait, 0);
 }
 
 /*
-- 
2.53.0


