Received: from synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B154B0
	for <gfs2@lists.linux.dev>; Wed, 22 Nov 2023 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="r1vV4cp9"
From: Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1700632662; bh=SC9dnxHqfvQKEaJuD+znaUhn7y/jfcUHLwEfFKu8P2E=;
	h=From:To:Cc:Subject:Date;
	b=r1vV4cp9rAA2YvIc5MzJRn4Xye123pFNposLFmJQlFfriLjqC8PKR5ss27eBZqjn9
	 GKZaKVs8fkpTyFWvg3p6UIC/Bhp1wHiFdkJVX+gCwjpJlhqfGq56OUkoUuqq4fFfmq
	 yvCNrxgS6ojR1wIDhwmneTEKj464oubsWJJW1suU=
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	shepjeng@gmail.com,
	kernel@cccheng.net,
	Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] gfs2: drop filesystem-specific hash function
Date: Wed, 22 Nov 2023 13:57:39 +0800
Message-Id: <20231122055739.4140979-1-cccheng@synology.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no

Prior to commit 8387ff2577eb ("vfs: make the string hashes salt the
hash"), the dentry hash lookup function, d_hash(), incorporated
hash"), the dentry hash lookup function, d_hash(), incorporated
additional salt from parent directories into the hash value before
returning the result.  However, after this commit, the dentry hash
generator should internally add its own salt to prevent identical
filenames from being placed in the same hash bucket within the
dentry_hashtable. This ensures that the hash distribution remains
uniform and efficient. Since GFS2 doesn't modify the filename and
the dentry hash doesn't need to match the on-disk hash function,
the filesystem-specific hash function can be eliminated.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/gfs2/dentry.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 2e215e8c3c88..87b53c53d0f1 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -77,12 +77,6 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 	return valid;
 }
 
-static int gfs2_dhash(const struct dentry *dentry, struct qstr *str)
-{
-	str->hash = gfs2_disk_hash(str->name, str->len);
-	return 0;
-}
-
 static int gfs2_dentry_delete(const struct dentry *dentry)
 {
 	struct gfs2_inode *ginode;
@@ -102,7 +96,6 @@ static int gfs2_dentry_delete(const struct dentry *dentry)
 
 const struct dentry_operations gfs2_dops = {
 	.d_revalidate = gfs2_drevalidate,
-	.d_hash = gfs2_dhash,
 	.d_delete = gfs2_dentry_delete,
 };
 
-- 
2.34.1

