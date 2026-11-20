Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144413;
	b=a6B196EM2EfiLb0NIjqn3+a8n1Wjqr6B8gpoja7ktzPySVPRjSsJv/U8d3tHEG7fV3k8
	 LhfjVMxfxLPcCjOrep3zeGV6ucSfCAjtAKGW/ZSN20MvvhBVEQeD7imfkF/Xni0Clir2o
	 T3GIW2+4xo+KjWCD9a/lfiMICNn4DoLEhIxOeEXmleODUixQlsGecdAWrCIezfDtrVFdJ
	 ZToPVE4mjrunk48dDDadXh7YKNl4ExdTan9kbM45kdVXwVDLsJe5yyD9Icp1csXhpMZ6l
	 0eci8Nkg91kj7ukCTSWdpi6y8lZNLZafYh8/GgtSnGRjkuAC+7em72gWuKq3k8seNpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144413;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=t7e1N9j3FtfUfXYB6xNEtndSV5CwfLVjVvURR0QAmGs=;
	b=gP0KDAmp1GY4O40PsDqbyGfb8AQjPWwke1xP588V1e5Uk/SkDn7+kd/dIIekoa/I7JpR
	 S5eGDDMos4KK0/kqRoLh0mq1nJ8mkJNTyLJOTbcjrhIWzEeMJiL0dV6DLK9/Vsw5qO6Fe
	 CHpG3Etm453wdD7DJDj0CoqlRQw5RbDJ1shXeh7PUhf+ZPjwguuvwgNWxc/laXmlu5C63
	 fzv4PBRd4fQYrURMljaMrsUaxEGaM4adCIv9YOb2JUJpPH/p9DqKdf5tgAbNnYriy8/dl
	 Ip+znUVQaPTmkquRYh7L4dGN3EfCsAEXXIx21CXsb5cht/dOSL+oU2fzurml9g/mQTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99860A2607
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E99860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0lv3DgRzVcBB;
	Fri, 20 Nov 2026 11:13:31 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ls24TczVcBB;
	Fri, 20 Nov 2026 11:13:29 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id DFE6B30CB6D6;
	Fri, 20 Nov 2026 11:12:25 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:26 +0800
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
Subject: [PATCH v3 06/11] fs/inode: convert evict_inodes() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:00 +0800
Message-ID: <20261120031305.3561045-7-huangsj@hygon.cn>
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

Use super_iter_inodes() with INO_ITER_F_NOREF | INO_ITER_F_NOIGET,
which hands out only zero-count inodes and takes no reference on them.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c | 61 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..be21d1f10007 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,6 +865,30 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static int evict_inode_fn(struct inode *inode, void *data)
+{
+	struct list_head *list = data;
+
+	/*
+	 * Only drain what previous rounds collected: @inode is the inode the
+	 * walk is using as its cursor, and evict() would unlink it from
+	 * s_inodes underneath the walk.
+	 */
+	if (need_resched()) {
+		cond_resched();
+		dispose_list(list);
+	}
+	list_add(&inode->i_lru, list);
+	return INO_ITER_RET_NEXT;
+}
+
+static bool evict_inode_eligible(struct inode *inode, void *data)
+{
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	return true;
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -876,43 +900,10 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
 	LIST_HEAD(dispose);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read_once(inode))
-			continue;
-
-		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		inode_state_set(inode, I_FREEING);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-
-		/*
-		 * Keep this inode out of dispose so it stays on s_inodes while
-		 * the list lock is dropped. I_FREEING prevents new references
-		 * and leaves eviction to us, so we can resume the walk from it.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		list_add(&inode->i_lru, &dispose);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
+	super_iter_inodes(sb, evict_inode_fn, evict_inode_eligible, &dispose,
+			  INO_ITER_F_NOREF | INO_ITER_F_NOIGET);
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.53.0


