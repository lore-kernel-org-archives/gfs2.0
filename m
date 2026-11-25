Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597941;
	b=LenKmSK5pZxZFSCNeHwvrI8eacf7CP7gmN8jCildLeFdz5UsuOU6TDHIMfYKc2KfCaTG
	 LrdcGHj/cD8SE9nQ9fts5P/EQP1bLknSKxrGcdU4Bt5Cee+V8OjMvWX0ncrknXzAjtU4g
	 RiKwvFp8nuoyy0TqB/iNCn8h4D8SuzP+tpyQIfBJic7H2N4JkIul40gqrYw09uIK9I2Mw
	 NUxgmLorKiyziA6/GHir1I+IaNHdIYSAEv/RY85hYVl1/bcoypc+IaQ/tAhDzxprITTUG
	 T2S3V2nQ2XCAjD9ASp0DnkHv4D4ej2qtkZl5hWS/FGv/d9QzkUHGsdPywMmoGg5dIOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597941;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=mvTE/jYYGVeN6Jqeco/QZgTO0HeF19oQmNCmoulMWNo=;
	b=BD/7POHB84FueV4ZCwjCLV/QwMSgtn+IXPGtD4oqb7qKwGP/q9+Qia89/DXWQ9GIUlzF
	 VSDsSEnLMZVbnBRaq4ptaFiqtv51Hk9NLds3J1OHjvjAo9iW8cHNLZeh9pwpeGuXs3voE
	 jLz30Tbjo8gAxEI4+/+boYB/5Yz8gW9j4E7yFLh23AEuKUIQAtOrk2RuVQjwcOG4nHPY/
	 UL9khBkEQVr6XUVwpICXOEJ+xfHUfzn690WSPpggcLztKqrG4vmikupRwN19GLP1morDu
	 Nya9oteC4oo0e3ezCs/OTf0FgK2LT+KfeVPrYsLCTwKAjMlomX7nd6r6A+a+bGLq9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED8E606A321
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 09:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTS292kzVhfS;
	Wed, 25 Nov 2026 17:12:12 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jZDTR4QkXzVhfS;
	Wed, 25 Nov 2026 17:12:11 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id EA7BF1662;
	Wed, 25 Nov 2026 17:12:04 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Nov 2026 17:12:09 +0800
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
Subject: [PATCH v4 02/11] vfs: add sb_inode_iter_locked()
Date: Wed, 25 Nov 2026 17:11:48 +0800
Message-ID: <20261125091157.1822521-3-huangsj@hygon.cn>
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

Add sb_inode_iter_locked(), which keeps sb->s_inode_list_lock held
across the whole walk and takes no reference, so each callback only gets
an existence guarantee.  It must do its own inode state checks and must
not block.

It lives in fs/internal.h as a static inline rather than being exported,
so that it stays a VFS internal facility and the small callbacks inline
into their callers.  A callback returns a negative value to stop the walk
with that error, and 0 to continue.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/internal.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 967c8556c17f..0479094e1330 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,6 +139,31 @@ struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 
+/*
+ * Iteration for internal VFS use only, with sb->s_inode_list_lock held
+ * across the whole walk and no inode reference taken.  @iter_fn runs in
+ * atomic context with only an inode existence guarantee, so it must not
+ * block and must perform its own inode state checks.
+ *
+ * Return a negative value to stop the walk with that error, 0 to continue.
+ */
+static inline int sb_inode_iter_locked(struct super_block *sb,
+		int (*iter_fn)(struct inode *inode, void *priv), void *priv)
+{
+	struct inode *inode;
+	int ret = 0;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		ret = iter_fn(inode, priv);
+		if (ret)
+			break;
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+
+	return ret;
+}
+
 /*
  * Prepare superblock for changing its read-only state (i.e., either remount
  * read-write superblock read-only or vice versa). After this function returns
-- 
2.53.0


