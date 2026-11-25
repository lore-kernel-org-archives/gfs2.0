Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597953;
	b=fLj59KzBYrq4qH4BNgpwR8BTYmstjMhYTECEMu20RthUJ9XJqGc/9fDSEc9u0iNBaNGm
	 yQqM/NV3K8hkyeBumFu4c9NCCpTNRCWoolU2bj07+ZutU2bxkU+o046qC0wunnDRQRNYL
	 /UpkucSsAPr36o51///ff59yDdps+cLRXBVFnGpKCXNkukqY+GZtcNX5U2Imw+7FNlgYs
	 guRRUW/0b5kP8Du8SXI9G6LdlxcgCLt93lfR7xxVqMMO/aP0I8sVAa1DnO3zuHTL7F/jj
	 DHpFG4sO6FPnTCbm+k9AmIBmEZpL9oiCn1CO1DzqQtJAkRn6+LBCZexeIUKgr+ZK/1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597953;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=PZApHeOyVFfHJcYU8jllKoaZGZcNH5itsU2DEbproM8=;
	b=Mce3UWBB8/Aos3BOHmTRNqpNgLCzD6y3kroFoUF5b0RdW4yHMqYklEIoOWBqTvRnui1K
	 7vMUyj3qxcEbzzmJOy6zpP5t69bZWwlmh2HpBlYKxuh6wuD9sdFvkf2U8fd5hHNxivJDR
	 erv1Q9yQ47oaLpalK5ZWpXgnqlBfNbaPliMl7Z8e09zp6t8Jn1cY4ffKK/zj2crTu60N5
	 SrTHMvpTCQKnsWc9l9ddLdaKNEhR26hvHvNwFkmxdPcr0fc4oFkxfp53VLqT/v1KNU/+8
	 K4iFJqqwTrPDwZfKSShQ5HI4AZybsprwb9yepzQdB7/a+N6X2fRfEzM1vPN+dFUeZpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AA6606A690
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2AA6606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTp29NpzVcBF;
	Wed, 25 Nov 2026 17:12:30 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTm28LNzVcBC;
	Wed, 25 Nov 2026 17:12:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id A4193300B6F1;
	Wed, 25 Nov 2026 17:11:15 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:26 +0800
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
Subject: [PATCH v4 09/11] fs/quota: convert add_dquot_ref() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:55 +0800
Message-ID: <20261125091157.1822521-10-huangsj@hygon.cn>
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

Convert add_dquot_ref() to sb_inode_iter.

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/quota/dquot.c | 54 ++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 538578c79b5c..d047a3353b79 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1066,56 +1066,38 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
+static bool add_dquot_ref_eligible(struct inode *inode, void *priv)
+{
+	struct dquot_ref_data *ref = priv;
+
+	return atomic_read(&inode->i_writecount) &&
+	       dqinit_needed(inode, ref->type);
+}
+
 /* This routine is guarded by s_umount semaphore */
 static int add_dquot_ref(struct super_block *sb, int type)
 {
-	struct inode *inode, *old_inode = NULL;
-#ifdef CONFIG_QUOTA_DEBUG
-	int reserved = 0;
-#endif
+	struct dquot_ref_data ref = {
+		.type = type,
+	};
+	struct inode *inode;
 	int err = 0;
 
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
-
+	CLASS(sb_inode_iter, iter)(sb, add_dquot_ref_eligible, &ref, 0);
+	while ((inode = sb_inode_iter_next(&iter))) {
 #ifdef CONFIG_QUOTA_DEBUG
 		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+			ref.reserved++;
 #endif
-		iput(old_inode);
 		err = __dquot_initialize(inode, type);
 		if (err) {
-			iput(inode);
-			goto out;
+			iter.status = err;
+			break;
 		}
-
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
-		old_inode = inode;
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
+	if (ref.reserved) {
 		quota_error(sb, "Writes happened before quota was turned on "
 			"thus quota information is probably inconsistent. "
 			"Please run quotacheck(8)");
-- 
2.53.0


