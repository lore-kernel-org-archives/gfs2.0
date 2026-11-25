Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=HWNn9ybpLITBViXbo8mApWIMRSpXjBPEafrPWM72MHkn4sNjqZ0RIKbXcMiKvEerjCc8
	 wMsJP2hLyJ9QskpPdjNOIRSEdKHgl+w39n+B4I1XqWplWwxVJ7fyo/+9oxJif6vwaDxJ3
	 SWkAp0YGtw94k85cuXIyO0sDt45IPRt5h4ScjVBOrlg1CoDeHHxb6BiWjb5e4D1QAQQtS
	 vnvFLVJwLe4uaPN6uFhMMYGQHgs93cuaYTn8rRYNernrI164eaWXejeiZEmXOOXXkNykI
	 1QaWujKM5O4/IaYQ+fPjRsBsVgN6bw0WUKPTSBUt1sgE6BVJWTxMfZTXFmuNOuDDI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=C3CkL86lGVjEHDU0Yms3OxY9SiwvX79Vo9oMUChjX3o=;
	b=bb5ITbyUryub20UNLTNSEu/K25DtnMGk9DReEH1fWsXDg2gSbTAQ4WgLLH0Lq0F7nBo9
	 2/Ssu8CNBOBJwTUJmkzJ9gpeTCMYuSRH78MDjyGv+Gz+KBW0TU+doe17VWW6FJbC2fokg
	 9a6BLlVemQnG6SDf9wa5JV93gPaomsJqUNAGWadSK0eA1LuDNcD87/57RBLizF8QzHxoY
	 Cdd50W52LZIWKFbmSbIhg12FcKR5f53v0h7+OaBv3x91hbnq2R0kkkh2/NfH4QuECPINf
	 w2pTkeIygBy7n0cFqXbCfiBQWFeiyJfGN+6xPSyaKwW8lnUq7SoePZ8Ez3JaoIjuR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE9606A32C
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BE9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTW29BwzVcB5;
	Wed, 25 Nov 2026 17:12:15 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTV0QbPzVcB5;
	Wed, 25 Nov 2026 17:12:14 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 68886300B6F1;
	Wed, 25 Nov 2026 17:11:01 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:11 +0800
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
Subject: [PATCH v4 03/11] block: convert nr_blockdev_pages() to sb_inode_iter_locked()
Date: Wed, 25 Nov 2026 17:11:49 +0800
Message-ID: <20261125091157.1822521-4-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125091157.1822521-1-huangsj@hygon.cn>
References: <20261125091157.1822521-1-huangsj@hygon.cn>
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

Convert nr_blockdev_pages() to sb_inode_iter_locked().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 block/bdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..938396c6559d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -558,16 +558,19 @@ void bdev_drop(struct block_device *bdev)
 	iput(BD_INODE(bdev));
 }
 
+static int bdev_pages_count(struct inode *inode, void *priv)
+{
+	long *pages = priv;
+
+	*pages += inode->i_mapping->nrpages;
+	return 0;
+}
+
 long nr_blockdev_pages(void)
 {
-	struct inode *inode;
 	long ret = 0;
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-
+	sb_inode_iter_locked(blockdev_superblock, bdev_pages_count, &ret);
 	return ret;
 }
 
-- 
2.53.0


