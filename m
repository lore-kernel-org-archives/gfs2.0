Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597948;
	b=eMRAXsYLmLV/NMbKwOw2TFAgpI8dYh7SU6EqSCSB6X7X6e3QEwabQUTQJJXor/lVah0w
	 yZLAY+fwnQ9MaJetrk6MGGvzeottAzKv3FK6OmttR8DzfToXRxw2qe+u8pNWmE3o6Av3t
	 OlZa2fadro0CFYIIn8RRjAHw4RcSw4IfIXsfcJVYD8YmP/PHSiPFHRZzjYD667AvawFNL
	 jKE0fQssHyGvkzVYzzU4XJ5nKgYl4C87sSgl0j7/aK+icS6dRjbPMFEEnpyFkp5C+FGCs
	 hpkGkARLLk8+Bwac7ZzK97hqyaCly5pZj8jj4ujUVeNUgnNrCqh5yCi10Bh1M2OwW7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597948;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=V4HbwVEuwHie2pyqStq3WwzIcpZJDTmvqIBLuBqtFGA=;
	b=F1kCF8NUSif/tj/PtVGp/bMOCogxdTNZm+djaRUgKA0ml2I6qX35gQQACC0wBTGE7CiR
	 M+ReTLof76dX/gRv74rDZ8vOITLiVR+xExb7RvuKW8/4m4IG03Yktz/wQLSnp9jtghjuz
	 N2XaI/LShjWM3U9THY0xwKqRh4XRwoKoNdlT5kS2dCQRG7mr4sbLXJ9dF2rGVVr3NgF3u
	 acmgIR6nDT+fbyjHhH+lJN0clmU9eI/0kVNB3/tnQZL+zr0Ntb2Bb5OkSxZ0ANAh6AxVj
	 WcKYRSe5kkZ93YKpAk5RJJpB9825NO8y5+IufzBJM7eJUly9tGfffExK0D0y+f35LNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058E606A682
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E058E606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTd29DHzVcB7;
	Wed, 25 Nov 2026 17:12:21 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTZ6wxDzVcB7;
	Wed, 25 Nov 2026 17:12:18 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 518F3300B6F1;
	Wed, 25 Nov 2026 17:11:06 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:16 +0800
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
Subject: [PATCH v4 05/11] fs: convert generic_shutdown_super() poison loop
Date: Wed, 25 Nov 2026 17:11:51 +0800
Message-ID: <20261125091157.1822521-6-huangsj@hygon.cn>
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

Convert generic_shutdown_super() poison loop with sb_inode_iter_locked().

No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 077e772fa19b..bf7fac5ebcbb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -780,6 +780,15 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static int inode_poison_fn(struct inode *inode, void *priv)
+{
+	inode->i_op = VFS_PTR_POISON;
+	inode->i_sb = VFS_PTR_POISON;
+	inode->i_mapping = VFS_PTR_POISON;
+
+	return 0;
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -838,15 +847,7 @@ void generic_shutdown_super(struct super_block *sb)
 			 * we can at least make it more likely that a later
 			 * iput_final() or such crashes cleanly.
 			 */
-			struct inode *inode;
-
-			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-				inode->i_op = VFS_PTR_POISON;
-				inode->i_sb = VFS_PTR_POISON;
-				inode->i_mapping = VFS_PTR_POISON;
-			}
-			spin_unlock(&sb->s_inode_list_lock);
+			sb_inode_iter_locked(sb, inode_poison_fn, NULL);
 		}
 	}
 	/*
-- 
2.53.0


