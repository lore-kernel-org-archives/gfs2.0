Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144422;
	b=dWmBOQ2u+lZGpqpToPpZoLpZzPaIXU7lroF/e/fbsQTY929y5iS30+T7gSS/cK23YQoz
	 zowxAmcX5tmXyQqOi3yiK0ZQp4QT0YZwS7U9qDvhplUwBKq63ZxvWGbJ6Qnmrq+shyvJV
	 49THFgLWw4/u4+3x87i5hMMeaetGObzN278brJWBcOCfdwEn5L2xHYOgiI3eH0MPehSu+
	 j5aLZjIKYLzPUGi4JlvJVTvzbUoZwx0tRe4folKIFaxX/swNY9vzj0C4CL9TiM6kZPznj
	 pF5zcao3lcvlBH9YuzDFWUT9Z5RTbeBxOkHf/erMyVsNLmxQ2fjxxoW0yhrkPntYtZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144422;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=XfUQYqhSBDtnNz/92eiuuQq9fnpmWexW1FrDv5wdiVA=;
	b=z7hgPif8BZ148eDjrmAQXDe5a+dRaIjDL/uplAafOksjjeMYe2CkAL/IIiZaqadpNuan
	 Qea+7OuOmikw3M1mALznty4wtHYE4GOWMFam/5wIGQ2RkUESP8SJli1y5KmabaBP9OwB+
	 aD54mKza1wHXA8RMgf1oRDYFP2VhHA9tGqg00vvRw0IjiEmTPWwKM8bCqMwIzQk1WkVd4
	 Yg4ZWVpyICCLVez02Z1GuSy4n+Xd6SY3CW1Qn9dRX4/vG/H6r4ay+JAYoeYabGMmhnwqj
	 Essdsdw2RJKzVEPR4z1UUGW5cuFjXlVJK4KqMTffwepDzu2Fl0ZcQb6gSGZDA8zusww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5560A3812
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 03:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D5560A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m43Dx1zVcBH;
	Fri, 20 Nov 2026 11:13:40 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jW0m32q2vzVcBH;
	Fri, 20 Nov 2026 11:13:39 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 046C930CB6D6;
	Fri, 20 Nov 2026 11:12:36 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Nov 2026 11:13:36 +0800
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
Subject: [PATCH v3 10/11] landlock: convert hook_sb_delete() to super_iter_inodes()
Date: Fri, 20 Nov 2026 11:13:04 +0800
Message-ID: <20261120031305.3561045-11-huangsj@hygon.cn>
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

Convert hook_sb_delete() to super_iter_inodes().
No functional change.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 security/landlock/fs.c | 138 ++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 86 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 2ab67bcad198..dae606892d96 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1380,105 +1380,71 @@ static void hook_inode_free_security_rcu(void *inode_security)
  *
  * Cf. fsnotify_unmount_inodes() and evict_inodes()
  */
-static void hook_sb_delete(struct super_block *const sb)
+static bool release_inode_eligible(struct inode *inode, void *priv)
 {
-	struct inode *inode, *prev_inode = NULL;
+	bool ret;
 
-	if (!landlock_initialized)
-		return;
+	rcu_read_lock();
+	ret = !!rcu_dereference(landlock_inode(inode)->object);
+	rcu_read_unlock();
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	return ret;
+}
+
+static int release_inode_fn(struct inode *inode, void *priv)
+{
+	struct landlock_object *object;
+
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		return INO_ITER_RET_NEXT;
+	}
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj == inode) {
+		object->underobj = NULL;
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
 
 		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * Because object->underobj was not NULL,
+		 * release_inode() and get_inode_object() guarantee
+		 * that it is safe to reset
+		 * landlock_inode(inode)->object while it is not NULL.
+		 * It is therefore not necessary to lock inode->i_lock.
 		 */
-		spin_lock(&inode->i_lock);
+		rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object() and the
+		 * __iget() reference that we just set in this loop
+		 * walk.  Therefore there are at least two references
+		 * on the inode.
 		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+	return INO_ITER_RET_NEXT;
+}
 
-			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
-			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
-			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+static void hook_sb_delete(struct super_block *const sb)
+{
+	if (!landlock_initialized)
+		return;
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+	super_iter_inodes(sb, release_inode_fn, release_inode_eligible,
+			  NULL, INO_ITER_F_REFERENCED);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.53.0


