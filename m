Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144416;
	b=XPKrAh///F4qNO0R2w2AsAtf0C3S0hjW0+M0My3pYEbmEgDdcLHC+Si+ZrvOtTT6pCYv
	 s/6LQAR6L9PoCrzTPRmXXnreOUb+Sh9bpjUdRzPbFX57fDBek8hmqb3fmHRGFId3BTfSI
	 U/PtxChQ8mlbmCehSWAIMNJ5J7K3uwzD1wDBRNi/FFHLzZJtL0QG+YMmqF8fKWhvvjAIL
	 NE6Aj/Kx63yoiU26+pkGLtPvQNm2ijnMb0IO6YLDSVfcS2lFsCtSCHgIrpsMPv7FFrmNt
	 lp+dNoeq0zyMQdXCPft22sc74PsnsDvYgVDtA0dfmVkOzFa0DO/sKrb2/sEWAKYHGrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144416;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=FWEksGSMFDSJ1DljFY8aUrjjp0KPaagaNf13szuJ0Rw=;
	b=aKL16vF9c9QcGFPBhEJ53w4Rkg/Qx8+0pMav8lLlaMpjjz5vpz97V4ilSbnMqZPUpi+2
	 WFWRT5k2Hkk3YedCW7IEYK4/MhlPjkpE5nidHxpc4q23SStqsu8ipoIUNqbFa3/1rgRm4
	 2J0VHmgCbkj779+gZYp3CL6dRPqAt89m9im1niCE9nOwa4CMyn/KWPRZ4QDLEJsnEtUOb
	 evGGTTjriGYJOQyD3+2UDhe9zL3wQXcJZs7rlVpj5eqkbU1UBPnr0C4Q1jvQ2B8jAjy0U
	 r+VH69CPMDbsqu236MYnzH6KTP6NstC/7xKabOC9FAD1BdxDYwfdjj1SkKxylrJWTbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57960A2620
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF57960A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ly3DpFzVcB9;
	Fri, 20 Nov 2026 11:13:34 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0ly1pqHzVcB9;
	Fri, 20 Nov 2026 11:13:34 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id D69D730CB6D6;
	Fri, 20 Nov 2026 11:12:30 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:31 +0800
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
Subject: [PATCH v3 08/11] fs/drop_caches: convert drop_pagecache_sb() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:02 +0800
Message-ID: <20261120031305.3561045-9-huangsj@hygon.cn>
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

Convert drop_pagecache_sb() to super_iter_inodes().

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/drop_caches.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 28c5fb9c7357..68f1926e0c0e 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,39 +17,28 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb, void *unused)
+static bool invalidate_inode_eligible(struct inode *inode, void *priv)
+{
+	/*
+	 * We skip inodes without pages but we deliberately won't
+	 * in case we need to reschedule to avoid softlockups.
+	 */
+	return !mapping_empty(inode->i_mapping) || need_resched();
+}
+
+static int invalidate_inode_fn(struct inode *inode, void *priv)
 {
-	struct inode *inode, *toput_inode = NULL;
+	invalidate_mapping_pages(inode->i_mapping, 0, -1);
+	return INO_ITER_RET_NEXT;
+}
 
+static void drop_pagecache_sb(struct super_block *sb, void *unused)
+{
 	if (sb->s_bdi == &noop_backing_dev_info)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    (mapping_empty(inode->i_mapping) && !need_resched())) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	super_iter_inodes(sb, invalidate_inode_fn,
+			  invalidate_inode_eligible, NULL, 0);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
-- 
2.53.0


