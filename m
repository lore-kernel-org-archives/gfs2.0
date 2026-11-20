Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144420;
	b=XpKO+cR1ixzAtfZKFdYpttjRELBbdlzklGxQkFRj9SqBpKunr4i8t8kkCS/+onknxx/c
	 BF9QxXgXQV9z3gYXcRfY0qH4ydopBhUbjhvLSH4/s9i5q6LbjJIfa+jn8eV7SfbfNwxzH
	 BHhFeLmgAV/PNpYQgmRPbCznITwpPfEJSl5fBrwR+UT2sB3s0WWi0rBno+uaSruULkJ5+
	 iTeeqsPqCtCxoWMgiD9L1YRm4VPV1xB0wViCWnbbZ2bdrfni1tluBmZos3US/FvncqSUa
	 eXOEXr8Sn23Nw8dfsT+Z8WEsgUFLlmzUgfeMocSDxMPlpCv5rYG9DaDDhMM3Y+O4stw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144420;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=MXn/vipY2N1l4qLdGnwApO+16GsInZpYm0yxQZl82ao=;
	b=1rtLXAsTtDk4k37rbcjqe86xZgDv0zdIWcvf2qy287+fWRBXe5XBEWyf1kbCDuVV6T49
	 xiGRSTu7XXzo0VYl3nf0cmcFC9Y0SfUUy3Qga4VLucTdSFIoil+xgvUvrAwhgLyuoVvIA
	 CSu7TT5sPd744ZYIBQOfFNU/0WTHsKk52RfKruiwj1BH3gZHvS5cLeHRkG1jDv1t5u9WO
	 LM8L4bdM3WI3kogOUiyiHXCM31St3Ne8NMFvu/mHIbzUq8w2/OG9n6mbvprt/GylzRBhH
	 J643Ce+Ugh3S1v+3FOydCu5Y+6vIFfzKz30TRd9vU8cmxQ9FpF036vXdRWQUuD2ACqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F360A2620
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887F360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m13Dy9zVcBC;
	Fri, 20 Nov 2026 11:13:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m05NyKzVcBC;
	Fri, 20 Nov 2026 11:13:36 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 73A1FC087;
	Fri, 20 Nov 2026 11:13:27 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:34 +0800
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
Subject: [PATCH v3 09/11] fs/quota: convert add_dquot_ref() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:03 +0800
Message-ID: <20261120031305.3561045-10-huangsj@hygon.cn>
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

Convert add_dquot_ref() to super_iter_inodes()

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 71 +++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9aaf2cfa9e1b..6453949c8af6 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1066,56 +1066,41 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static bool add_dquot_ref_eligible(struct inode *inode, void *priv)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
-	int err = 0;
+	struct dquot_ref_data *ref = priv;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
-		    !atomic_read(&inode->i_writecount) ||
-		    !dqinit_needed(inode, type)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+	return atomic_read(&inode->i_writecount) &&
+	       dqinit_needed(inode, ref->type);
+}
+
+static int add_dquot_ref_fn(struct inode *inode, void *priv)
+{
+	struct dquot_ref_data *ref = priv;
+	int ret;
 
 #ifdef CONFIG_QUOTA_DEBUG
-		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+	if (unlikely(inode_get_rsv_space(inode) > 0))
+		ref->reserved++;
 #endif
-		iput(old_inode);
-		err = __dquot_initialize(inode, type);
-		if (err) {
-			iput(inode);
-			goto out;
-		}
+	ret = __dquot_initialize(inode, ref->type);
+	if (ret)
+		return ret;
+	return INO_ITER_RET_NEXT;
+}
 
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
+/* This routine is guarded by s_umount semaphore */
+static int add_dquot_ref(struct super_block *sb, int type)
+{
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	int err;
+
+	err = super_iter_inodes(sb, add_dquot_ref_fn,
+				add_dquot_ref_eligible, &ref, 0);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
-- 
2.53.0


