Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=E6qLybCH/fmmDeB8L8Cq5Zn9hkV6pjk1RMgQsPRD5Efg7Hl1cypFsjVK8IiMWCpXhFEd
	 umP3uCByf8RlzGuR/7kCnoV6HrJNQiFouXRWFtDywpvPNqnUhs3Iv/34+JIprk9aMbFC9
	 Tm+Uklq3z/eyVVCRuzbhFFqE82peedxrePtGfL+dbNcW8k3gwCGLo8Rr5DSlxbwaBgEe7
	 w/5b3OjuSIpgZ1oFBmEsza00xhV3EC5r8VQLBkFjmRQrL4uuVOu9rMk2mmrxAPlCSr0YE
	 vixtf/MF7/KfmoYSBLyX4johDK7d9H71AXSyd7gmQGBzWGK11G3i0/5/7Emel2zi4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=rY5KIVlAKbKab/tzgXdLnTdiBHJ81jLW95dmUPBtS/E=;
	b=ZLfVkDc+LPXrRAWIuFvkU5cv6wHB1gQvOJRc4pi0v1Y/86duco31v+8dcq2riq1Dkawf
	 JLFFZYI67S7HEm6xlwSkPqulKW+TEVWkU4TY7Vo6ye3YHSCrrN7uWA00rEjn/D0z+M6yd
	 231iP/l/grsCqyq7H3sKVmptdk+SwLVppP+KkcN/RmIE0jfkRqzpiQLEtYzxTZD/oHAw5
	 cwCMic8UvHJVvC20zATeuz9Osx6w4d758SMW53JlHEeFffPE9WbRdbmsj2FaKPLhJDKEi
	 lXsWglnqFCbULjt4KIKWLQjoknHs06rv+kr2LKAEgd/3cWJwIWe+bg22WG6VuHdjBLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3B606A330
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C3B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTZ2984zVcB6;
	Wed, 25 Nov 2026 17:12:18 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTX3hm4zVcB6;
	Wed, 25 Nov 2026 17:12:16 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id D43771548;
	Wed, 25 Nov 2026 17:12:09 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:14 +0800
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
Subject: [PATCH v4 04/11] fs/quota: convert remove_dquot_ref() to sb_inode_iter_locked()
Date: Wed, 25 Nov 2026 17:11:50 +0800
Message-ID: <20261125091157.1822521-5-huangsj@hygon.cn>
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

Convert remove_dquot_ref() to sb_inode_iter_locked().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a3d503591871..538578c79b5c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -83,6 +83,8 @@
 
 #include <linux/uaccess.h>
 
+#include "../internal.h"
+
 /*
  * There are five quota SMP locks:
  * * dq_list_lock protects all lists with quotas and quota formats.
@@ -165,6 +167,11 @@ static struct kmem_cache *dquot_cachep;
 /* workqueue for work quota_release_work*/
 static struct workqueue_struct *quota_unbound_wq;
 
+struct dquot_ref_data {
+	int type;
+	int reserved;
+};
+
 void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -1117,41 +1124,44 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	return err;
 }
 
-static void remove_dquot_ref(struct super_block *sb, int type)
+static int remove_dquot_ref_fn(struct inode *inode, void *priv)
 {
-	struct inode *inode;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data *ref = priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 *  We have to scan also I_NEW inodes because they can already
-		 *  have quota pointer initialized. Luckily, we need to touch
-		 *  only quota pointers and these have separate locking
-		 *  (dq_data_lock).
-		 */
-		spin_lock(&dq_data_lock);
-		if (!IS_NOQUOTA(inode)) {
-			struct dquot __rcu **dquots = i_dquot(inode);
-			struct dquot *dquot = srcu_dereference_check(
-				dquots[type], &dquot_srcu,
-				lockdep_is_held(&dq_data_lock));
+	spin_lock(&dq_data_lock);
+	if (!IS_NOQUOTA(inode)) {
+		struct dquot __rcu **dquots = i_dquot(inode);
+		struct dquot *dquot = srcu_dereference_check(
+			dquots[ref->type], &dquot_srcu,
+			lockdep_is_held(&dq_data_lock));
 
 #ifdef CONFIG_QUOTA_DEBUG
-			if (unlikely(inode_get_rsv_space(inode) > 0))
-				reserved = 1;
+		if (unlikely(inode_get_rsv_space(inode) > 0))
+			ref->reserved++;
 #endif
-			rcu_assign_pointer(dquots[type], NULL);
-			if (dquot)
-				dqput(dquot);
-		}
-		spin_unlock(&dq_data_lock);
+		rcu_assign_pointer(dquots[ref->type], NULL);
+		if (dquot)
+			dqput(dquot);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
+	spin_unlock(&dq_data_lock);
+	return 0;
+}
+
+static void remove_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+
+	/*
+	 *  We have to scan also I_NEW inodes because they can already
+	 *  have quota pointer initialized. Luckily, we need to touch
+	 *  only quota pointers and these have separate locking
+	 *  (dq_data_lock).
+	 */
+	sb_inode_iter_locked(sb, remove_dquot_ref_fn, &ref);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
 			" was disabled thus quota information is probably "
 			"inconsistent. Please run quotacheck(8).\n", sb->s_id);
-- 
2.53.0


