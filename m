Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597955;
	b=ghil3zEdIFhjAemzXTOO584rtPY86OFEWW7byw1Sv/P0bmPdsuNfZSDI/ocsgqhWGav6
	 w73OpN5uh0jtGljTgu7VnK1kd5/27FPmOPjo4/IVRMz+y13dlR3IZqF4WapdL6m6D+2Hs
	 931JMnm3bKwlrzdYicWIEyaTeX1iI4JHRsv6BIJeLOF7VK4hKQ2JuvHX0UlYXcW9xkVqR
	 igPm7X8FXwBz3eXT/pOQELpCr0RTSLaFPmQcqiYjGS0mH3q4ahO+MXt50pn/Bo0WxmhnX
	 En0IahZAKwJq0pZt4hb5/KZPiALpkrh7m+Hpp4R7VPbSs32OMNYImbx3w5ab1PArQeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597955;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=W5xTPhBqbOYvt1pbc0+N0zz1+MkA79aoENSFmoHeo0U=;
	b=BfU5JBvMJGX/o7EYul4tlbXDOkWrdMxJQBtY2giGgiOKVbqhhqjUQzcT7ekf+udnYOUZ
	 Ehj7zyFNdXyb1BS+wjjn0LTlb7aFkTDN4VJw+NKaIitF5/z4wgLIIx7+PqSUu7/KPk1sc
	 Db0TH0NkvipFnEDg9t8Pna4IY/XQ/H8Q6NHKM2eQvl3hjfPRlbyRm+htZ9qeEM5KpD4jy
	 eMPnfLovgKLNRlzBO2nXnllE9t8JmNGeF1KqJpE9mhcECg95enZi2yV2sF7249hNlmzrg
	 ICe8n+AvzqLzdWoMJSsRMUm1GAgCtgyblWHCPgeWJkHdXFis5SnDpUMvwgnAA5g9VJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4B60A260B
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA4B60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTs29cZzVcBQ;
	Wed, 25 Nov 2026 17:12:33 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTr6kFyzVcBM;
	Wed, 25 Nov 2026 17:12:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 4D687300B6F1;
	Wed, 25 Nov 2026 17:11:20 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:30 +0800
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
Subject: [PATCH v4 11/11] gfs2: convert gfs2_evict_inodes() to sb_inode_iter
Date: Wed, 25 Nov 2026 17:11:57 +0800
Message-ID: <20261125091157.1822521-12-huangsj@hygon.cn>
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

Convert gfs2_evict_inodes to sb_inode_iter.

The original code also handed out an inode which was already being
torn down when need_resched() was set. That is not preserved: taking a
reference on an I_FREEING inode whose count has already reached zero
lets a second iput() run on it once the reference is dropped again.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/gfs2/ops_fstype.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6ec47376aecf..130b116627a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1739,31 +1739,17 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
+	/*
+	 * Nothing to do with each inode: we only want to bounce it through
+	 * iput() so that it is evicted while the list lock is dropped.
+	 */
+	CLASS(sb_inode_iter, iter)(sb, NULL, NULL, 0);
+	while (sb_inode_iter_next(&iter))
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.53.0


