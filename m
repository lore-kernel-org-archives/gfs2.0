Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30673976A4
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944507; cv=none; b=ol8Hk/YmJfn7gpV9FjF0yRy1jKtC4S6GwSX8JNT7ztEgMhyIrqAEgjPoew5j3jxtbnPPI4zErCgSQ4ysXy2nf9KHwGLylBDTLZwGiVvLuWUhle7bR1FbrQkESIGur8H1e14T+rEphaqI3w6aM8RCwFlPXnh178Yt1yNs33Fd+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944507; c=relaxed/simple;
	bh=SAkZAInoNDJlwE4Vz0Q6DNK1AolKSJ1RECb+CGpp1bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeDAD83XXfEoRTS+ooNsBtJO/VhTNby8Ld3y/ms5pethtH3nBxe8MUW7mFjWKRcYBKXtNb6nQnarVqlf961AmzNen9cvxAbVyLkT6YQq0i/VpFUHdwBBFAji4fSDZwhFyTGH5QEBmtcmR2KmixsUiRZAl64RVW8OVZn8FQlRoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CJ2U7Rto; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CJ2U7Rto"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-852c481415fso6875786b3a.3
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944500; x=1789549300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16fpww6sBpVAinXNCcY2u0zfGvd2bv+kcIua+w/wNXg=;
        b=CJ2U7RtorDKfdEoQ+Jx4OgvNNBBfPus64M9CgR2J20iOQc3rLPVUa30A74tbGZc/v8
         PXb+K9vDcOc2q3RcEEWtQWpdqjVy25mnSGfje3sONHKbCrHBeJmqCWTkrsF9GRdk+Q9b
         xi9R89aMie+IXiktYn4AuKdHeIxAKLRJ04odmAHB89Sbwo6j42CWzrFcQ6ZlXlnKrFQQ
         Qqo+4SW9dK+Shjvo4m9wKu8jUUxasea9ft1lIHyVfN0/zVQRv4K3awOrKKOs7Sj5E6bU
         X2hdEzoh5Wird/8jPgFtAZ0Oy6iSyvpcpFEKPHSKnbYGOi+B6Jmkoqzo229e4RM4DqsF
         dQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944500; x=1789549300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=16fpww6sBpVAinXNCcY2u0zfGvd2bv+kcIua+w/wNXg=;
        b=SdP5Uid8LeebX8o/h7U4vQ76cdtmHsXeXIgKAmblIDeNvBm3L+0Yb6iEhIsSvu+5Rv
         fXaY2L2qR+T/McjG56GtoBnbujNoSsKtGIemKqt8Bmtbd5cyGAlnpZPYJaTGIVVgDLus
         BeA6crUUBvNOIhVV9pSsOOuU6Zw6xl29PKzdWrMF6k870qjIyo8K+7lgIHRpi7NEfDmC
         y2tlcomprCFK0heSLZr7dQahzA6PcIlthnlNHQbyRB8PcJbEuC/XgSeRJBa6y8FBhKCo
         mGxSYypz2xiktEE90vAVW0G+dKGCzfBQf5UHDBrj1be/2bT08IPOSI8w4u/c8uovXoPn
         0EBg==
X-Forwarded-Encrypted: i=1; AKwUvByavbNvm3BHLUVFFePYxszKSE+zQThVM0s3MhBr3WVtnaMY5NPzpkJgFfe5J6P7KxDCs5hV@lists.linux.dev
X-Gm-Message-State: AFuF++nP8XdH+cipLrCPlSmpiqHjZvtjqelJfKoNENyXykmjwgrARa5s
	62NA2NZiQimCIOlLn73inI3vHsRBm8bvqkzz6DabgFa+6swJHz2JURiyhQ1OYgrIFso=
X-Gm-Gg: AYBFou3YK0KLY2NT73PM4Z9ft8wbO1c4+4zRgg61xR6ZXNp0TB5Lr9zNKJJKu2OElnB
	XQQsJ2OnZoDLtbhGuhUXdC1MXcP8me2wyMgMxgXLjLD+GtEBZaRtnMIZtpKeDp7KXCgtzMb32OP
	NjT+0/b2SZLG9VSt/fmIvvDKR3rF10AiIsJQ2v0nv5YyDgc1j2HpPaeN3IU7kT53u9XNnHsY5Ed
	O+StDKe5+pqanxK+iu7HqwI/6EvTvj5Ngoj+RK51jETrcAHo978i3Gnkry6A3cVjT1HCvmRLxVm
	JfKSp6Bobs9Xz+ghhnFC2ZcWVmYXqswSkdn9mkSqhXs9kjqFERnsyyOqlIQBh8htd9uus1ThKKc
	AkWlvi6F5sqBZvSaDimbNLr6BZfyyYqOoQ/EmU65AONPGgVYiuI/gV5gbg/3fCAi1WaDKibf7yl
	VGhsMKMbymOL1M0W31qZyC76hvPtns8PuNQQxIMQD/ZhfqCUOcG0GnA7avC7Yd6TTUS7OftdnFu
	g==
X-Received: by 2002:a05:6a00:f94:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8616ac58363mr49645804b3a.21.1788944500308;
        Wed, 09 Sep 2026 02:01:40 -0700 (PDT)
Received: from localhost ([106.38.226.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f8bsm6902214b3a.15.2026.09.09.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:39 -0700 (PDT)
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
Subject: [PATCH 6/7] quota: use sb_for_each_inodes() in add_dquot_ref()
Date: Wed,  9 Sep 2026 17:01:11 +0800
Message-Id: <20260909090112.790006-7-sunjunchao@bytedance.com>
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

Convert add_dquot_ref() to sb_for_each_inodes(), passing the quota type
to the callback and propagating initialization errors. This removes the
old_inode reference used to preserve the walk position.

Leave remove_dquot_ref() unchanged to avoid adding per-inode locking to a
walk that never drops s_inode_list_lock.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/quota/dquot.c | 72 +++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 204afc5e984b..77c68149d4ae 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1043,64 +1043,48 @@ static int dqinit_needed(struct inode *inode, int type)
 	return 0;
 }
 
-/* This routine is guarded by s_umount semaphore */
-static int add_dquot_ref(struct super_block *sb, int type)
+static int add_dquot_ref_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
+	int type = *(int *)data;
+	int err = 0;
+	struct super_block *sb = inode->i_sb;
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
-	int err = 0;
 
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
+	if (!atomic_read(&inode->i_writecount) ||
+	    !dqinit_needed(inode, type)) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		return 0;
+	}
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-		if (unlikely(inode_get_rsv_space(inode) > 0))
-			reserved = 1;
+	if (unlikely(inode_get_rsv_space(inode) > 0))
+		reserved = 1;
 #endif
-		iput(old_inode);
-		err = __dquot_initialize(inode, type);
-		if (err) {
-			iput(inode);
-			goto out;
-		}
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
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(old_inode);
-out:
+	err = __dquot_initialize(inode, type);
 #ifdef CONFIG_QUOTA_DEBUG
-	if (reserved) {
-		quota_error(sb, "Writes happened before quota was turned on "
-			"thus quota information is probably inconsistent. "
-			"Please run quotacheck(8)");
-	}
+	if (reserved)
+		quota_error(sb, "Writes happened before quota was turned "
+			    "on thus quota information is probably "
+			    "inconsistent. Please run quotacheck(8)");
 #endif
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 	return err;
 }
 
+/* This routine is guarded by s_umount semaphore */
+static int add_dquot_ref(struct super_block *sb, int type)
+{
+	return sb_for_each_inodes(sb, INODE_ITER_NORMAL,
+				  add_dquot_ref_inode_iter_cb, &type);
+}
+
 static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
-- 
2.39.5

