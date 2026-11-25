Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597948;
	b=TbXlMZubgtydXP1r5LjXVEPJPf6swkZT6bqQUK8BBWrLxaJIP6R0ueFyQD0yMQxid4xX
	 eOa7ZRs+RMrz9yE1Hz2ledgO+0P62C9wyR5Us6tJJWLj7PWZL/zm9HjOlBGQh0J0bR4rB
	 4aAEgaofKkmMK7QuybFy48wPCgr/XwptlzvortKVxmaqwX4X0UvBCRPgqCbCfmaqBYYHo
	 3H16R4Hwxav0Yi8khyNEuOnfcGzr3EuibMTHpZitkcR52vE4O0C8CEH3YgOfr5Fp87af6
	 5Wl3zQFCsOWFaSG6lonkuZlCTCi6VcHmv9cyJ6rqtOfIqrPhnYzH0f9VJA/qf9lTfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597948;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=/6O+blZWFeGtJIpYuxgB4qiZ+0l3PmKkDlPDd+QWUBU=;
	b=CdS50NweJ3IGG4+L6bG+IRZpn4JIsfPWoDUvOJJigMo3UIBYteNw+GIDirSaBY97haof
	 9lZva5Mx/VeOWwIwUX5T6mQnAbbsFoPScn//gGY/xOV1VpuBrqUOq8SuVFpQL4OUKUnUK
	 kwG05z7mt48skiCsy50woimwpNhCfCiLNDxKT/Pf45MdFLJeR+1EOhGhOPAMF0DlnSPxQ
	 4AZY5QEsgUIzkRz7pLI2Ov7/2J4duBBMvFOoSmB64haUp9ebHOY4p1kBNJmY3vMLTvQOW
	 2YELvytt4XE9bA7Hx15UBlIZJdnaVMPAJ4HAJt2ToDfVa7BQieZ3sgiV4wxVFE3Ugtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C2606A321
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 736C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTh29FjzVcBJ;
	Wed, 25 Nov 2026 17:12:24 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTd2x4vzVcBC;
	Wed, 25 Nov 2026 17:12:21 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B62751548;
	Wed, 25 Nov 2026 17:12:14 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:19 +0800
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
Subject: [PATCH v4 06/11] fs/inode: convert evict_inodes() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:52 +0800
Message-ID: <20261125091157.1822521-7-huangsj@hygon.cn>
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

Use sb_inode_iter with %INO_ITER_F_NOREF | %INO_ITER_F_NOIGET, which
hands out only zero-count inodes and takes no reference on them.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/inode.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..0830a11a37e9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,6 +865,13 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
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
@@ -879,40 +886,20 @@ void evict_inodes(struct super_block *sb)
 	struct inode *inode;
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
+	CLASS(sb_inode_iter, iter)(sb, evict_inode_eligible, &dispose,
+				   INO_ITER_F_NOREF | INO_ITER_F_NOIGET);
+	while ((inode = sb_inode_iter_next(&iter))) {
 		/*
 		 * Keep this inode out of dispose so it stays on s_inodes while
 		 * the list lock is dropped. I_FREEING prevents new references
 		 * and leaves eviction to us, so we can resume the walk from it.
 		 */
 		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
-			spin_lock(&sb->s_inode_list_lock);
 		}
 		list_add(&inode->i_lru, &dispose);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.53.0


