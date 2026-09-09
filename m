Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712E49C4B9
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944499; cv=none; b=l/gRWwiZWxrTREvcP/T+Xtk1oi8oljQ88uvQhFLuuqfeyOE9ESDMhAK9Msno2mjVnobR24twBTVgiiC4Vfn3iGXcMfwUhOQ5j9nKBHyPivXGty71YLw20enaG9hMJYBcIO9rlUrtoBAZB2hjZs0n3ahmqTk8RU+R1MgdkEHoofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944499; c=relaxed/simple;
	bh=RC1BNmkCuQU1DakRzhjF5JezadS0qgQe8SFPOXejDL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9ooiIZnAPbvNZHgWKLbdTzyF8VNsBTiYelsqVvF5HzimCzQr409PVEkQcInuZBNspld2GoNsqgemS/RQQJ7VK29A8KmJFLHTGbBfkpUEcVxK691flcKNq8krwhYCHV4/yF7B1rm5SwNb44mR9eVQfuZgwBPXFhjFGEQXr60cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H8bc/ADB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H8bc/ADB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso4351518a12.1
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944493; x=1789549293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/izFqZ/muM6zoo5C7zoGnLseqg/LKzmuBhX1YVp8oU=;
        b=H8bc/ADBuensQtdSRsyM8Y3zI/iZZwPJvJhdpT9w/wMND4rn2CCooHbDjEr7tcq5k3
         lnlMUZiEHdwheClOk4PhXj1/woake7qPuW6W80XGavvZgQU9Sihb9/1q+MSiKRP3rj4j
         TIYszwdUAECjJykk8JhuqY+vd/fLVzAngnPQIJ8RKyvA7kzDV1wpR7Jz0BrORoblFihH
         g1riS7WHuJ7pWRvAvFdv20Ls8n+nMOM+fNAo2ZrjqpD05RTh/COHZ5kOWnRMjnGBHnth
         YDLL0hCYUEcdioTVUrD6lT9Rodtq8I3LncdsW3KMnQ6D0Q9Gn9RL5Zf0yzQLxG5xVam1
         CH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944493; x=1789549293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/izFqZ/muM6zoo5C7zoGnLseqg/LKzmuBhX1YVp8oU=;
        b=OShtcIzzh0oPaeuanI0K+pyckqZuL+IWXK8G7+4c145rjk0bremHRu7SZ/m3dT3ppO
         +X3NydxDF1LlW4DUC6z9cYZ0C8VwyXidEEEkWV82x20+Fp7oLFwIOEhox5N/bTOVTwWy
         jCbYy4XMH651Y3Vi2pngm4PZz6cWD2mrozTIuYKlQZFcB35QVolampjeEW61+2fwVU23
         vzVfKp/e86LmK2B47aAkl1Zo+rgCdkME55I22wVFWuaUqQ3/wo/wBfE6pb5zLcnef+CR
         Qo6nTI0z+R2OxT3yCJjoWmXDfw7f7/8BIHVnlV8ZSN1s70i+D5QaK5hlgBFqcASlfW/U
         hKjw==
X-Forwarded-Encrypted: i=1; AKwUvBxihD4xMDY2XtfaRo/Yl3RPn3pGybF1/O56HQYhCVRi8ndZMVEUFh9EQ0EwkkP4WgtYqm0u@lists.linux.dev
X-Gm-Message-State: AFuF++lXD5/hhoWjFntfmskKr/X8epjjOqnXMDznWO9uwK8CALVn/Byz
	LfARhNT2Hr5PCEuqlWPzzowBNeYgGJnaT5Dereks06X203r4cer+amHpVyu07hRn8QE=
X-Gm-Gg: AYBFou15q+qlIUUo/oshVIf8z8BxG4Lu0pbH+C0bksaSSa1ovs4aHrTnh7Sj7zXu6or
	jsvrI1/aemQNlF1z+OyfblsNVz1mn37MdgUIo5qpoI1ueDMFZf6ZTMrfsrZrRURcoFb+fI/AiJX
	jjOUd0VJEUsDUjIT5sxbyKuTyWdn3U8vleechK3/xv5ts68w+RBynOvx/AfgEcJoHSXjD8N809l
	WaUWNPwmxZ5ibxt06yhcNw9xDcEyEHh8m+M/P8l0u6Ooik/KWCpQF/YB532CeJxPNsT8ag3veAj
	gPyLmGNsBuaXcBkxCgfhUmBdRbjgxXysrRSerxvadoZD54j7YIpu3h1swaimvTkjc3qEMtCVJbN
	yO/Fj6llPs+SBVg7pl7w+RTCDtfIfp3XTgrsOOaWaQ7OwuQ+e9r74YCAp3RKUp4oGNX5nkFe8U6
	uwJSRo6D4fQ4mcUrGKvaS9VspL2fFxFyjkZhIqR9EhH9M7gKkn/TcEX/CqVLE9P5O192lgc2429
	A==
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39b26272bdcmr57133385a91.16.1788944492663;
        Wed, 09 Sep 2026 02:01:32 -0700 (PDT)
Received: from localhost ([106.38.226.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm36856959a91.4.2026.09.09.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:32 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 4/7] fs: use sb_for_each_inodes() API.
Date: Wed,  9 Sep 2026 17:01:09 +0800
Message-Id: <20260909090112.790006-5-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sb_for_each_inodes() in evict_inodes() to avoid rescanning referenced
inodes after each reschedule. Collect eligible inodes during the walk and
dispose of them after it completes.

Convert drop_pagecache_sb() as well, replacing its deferred toput_inode
reference with the iterator's position tracking.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/drop_caches.c | 44 +++++++++++++++++++------------------------
 fs/inode.c       | 49 +++++++++++++-----------------------------------
 2 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..0d475a5ff8cf 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -16,36 +16,30 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 static int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb, void *unused)
+static int drop_pagecache_inode_iter_cb(struct inode *inode, void *unused)
 {
-	struct inode *inode, *toput_inode = NULL;
+	struct super_block *sb = inode->i_sb;
 
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
+	if (mapping_empty(inode->i_mapping)) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		return 0;
 	}
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+
+	invalidate_mapping_pages(inode->i_mapping, 0, -1);
+	iput(inode);
+
+	spin_lock(&sb->s_inode_list_lock);
+
+	return 0;
+}
+
+static void drop_pagecache_sb(struct super_block *sb, void *unused)
+{
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, drop_pagecache_inode_iter_cb, NULL);
 }
 
 static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
diff --git a/fs/inode.c b/fs/inode.c
index b4279063a5dd..07a5f48641af 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -959,6 +959,17 @@ static void dispose_list(struct list_head *head)
 	}
 }
 
+static int evict_inodes_inode_iter_cb(struct inode *inode, void *data)
+{
+	struct list_head *dispose = (struct list_head *)data;
+
+	inode_state_set(inode, I_FREEING);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+	list_add(&inode->i_lru, dispose);
+	return 0;
+}
+
 /**
  * evict_inodes	- evict all evictable inodes for a superblock
  * @sb:		superblock to operate on
@@ -970,44 +981,10 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode;
 	LIST_HEAD(dispose);
+	unsigned int flags = INODE_ITER_NORMAL | INODE_ITER_UNUSED;
 
-again:
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
-		list_add(&inode->i_lru, &dispose);
-
-		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
-		 */
-		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
-			cond_resched();
-			dispose_list(&dispose);
-			goto again;
-		}
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
+	sb_for_each_inodes(sb, flags, evict_inodes_inode_iter_cb, &dispose);
 	dispose_list(&dispose);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
-- 
2.39.5

