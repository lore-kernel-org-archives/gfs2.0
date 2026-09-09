Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90648E0E1
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944495; cv=none; b=Q/lI6LfAp4e+dsWQl0mLKmrYb4xz4kUvwzBXqpa246ljHGHKnhFOpp5l63j45+20pk7R+jHTsxi6MOZ5gtp3nvBxCwykWz7bS5Qseo/lZlOTHT0+Oi4dJ2nvU5m5kyYJSanJqSFlp4AlGybmOC8+7fc3x9HqtSV1IjrzNYGigzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944495; c=relaxed/simple;
	bh=+N65DOQCnJgQqGpfVkRNDf8fPq5SSO1tZXUIQK8AhmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGp+gqg3LTw6AgFE/SIGyV/L4r7DHyN8pB8M9tqK8/dGXKw3HE7PKgy0DeLYL0r5frFbbrGxgYQRvfVUEfOPU81rAPAl8BtgUNSvNnK75x9ML0yXJwzuTfyCVcTPE3W46fTNkSXZzbk4Ubu3agtI0Vsnkho2I7wegQkzWBu7YwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ksj5rEJn; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ksj5rEJn"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so777642a91.2
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944488; x=1789549288; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uD00HHK4q2p2m+RWf7dPjIKnA4HG/zGsgecKKk0GRwI=;
        b=ksj5rEJnMrRxpWNKSoDqdp1+DtdC8Lxp9kJ284gyLIHmTHBLtvMj8TncIql/jX7Lam
         JbJWkW5HvpE+bcJFAOabuBN3nmZvHB8kln296zoOpH16fCPgHx473TQGLbqAkrHNnWV1
         oBXDMLfpvNMPFqkGuFWGYObTrvUTmVoBpYO/cSwnPG08clZgCDTixPgNBoaFxXmMlxQD
         5Qwdyd4OEiJ73QEIdUV6tYVit/j7ndw1SP2dCWO/UhzbKO/hZpK6VjL9FqmM1j1knkBC
         Tsv4MbtKoc3Jawe+TBhW1KaRh2S7zKvUWtoL7RMZkCMKOMb/s8L74MV6gaRa00MAfTK1
         qSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944488; x=1789549288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uD00HHK4q2p2m+RWf7dPjIKnA4HG/zGsgecKKk0GRwI=;
        b=Zz0mvsPJOSxAWNIM6RtYuZgFuLvNyFYwOcpte1xnp9/GnobIJJ72ie7WfmwOjhnu7J
         paHy1+kWLZYNa+3BB7IUpMIY/KongSLKSEFK5TWgAGc9WfETpxX1q19Zg7HJEnOp3hy7
         cyRhtScXAPLgC0zFZRmDQFlR5gLNdbPWT6IglB/Z8eZyrOQll1XFqq7R4ViNpKoBC6k3
         wNsePQ7EbqlTz1gGtnMGoo2XB3yS+hB4nYcBiYB8fOJHGKnFGnp517vejKs8i4V3jOIx
         fhKrwuY0PO0uRxeTmcYCxXkDcaytnnNHREE7hKeE4NpCDDLVS6ILMuTetBAK2HKeJ837
         Bhng==
X-Forwarded-Encrypted: i=1; AKwUvBzrnPi0sOlDmtTEkrxKbuobTqW0gPNlruhO446Nq89EuZq5cDszGytvOl3/b3c4+aNRtkGQ@lists.linux.dev
X-Gm-Message-State: AFuF++klBgwNNvdhxyTC/zUv99L9JbFIsdp0w96kCgb2BBDjpTmps0KV
	QgWxhrT4eZ1HSEZCq/sr/XU9sFUpDBBC3X0eGIlLXc4jrHTrQ0fWSWwbf8gEQs4V7xM=
X-Gm-Gg: AYBFou0/CasLc/r0PnvlYUx/kn8qOOdswNqEltGW+LRxRxjiYdKN94TjDkAG9g/yegL
	mN2avEIPTxA7zM+D70Y10T6J5HRx+yT2+SQWe3Y4PCq1Ht4pvQiMonJruOpSdd2i0tIwNhdzoUu
	zzjrPfA+WChoycw5yYDRObmo5ZnT2PLVPyDaMm1N7vI3AUWWARMErEt5ZzB5w/iMYruyvXPk9u8
	G5X1VedOYIpkNpf2Owkge+nj2ae8676/axD3ObABtYy+P79iqCBw6r6Bfu3Hl1gpATCS0WAnPbA
	PYNs4aH0DJQBpRpqMZw4JLpvluwBdJUwgqmz646qE81suUrxvzrJO1eomcmhmR6lU40wGRPzoYZ
	4S9M+KDm833hFGJc8yxj76nX4sL/ShHZk1+Vkby5C/XL+hQPj/A/Uido7LrqyMvnLI87o16YIeT
	FLpN4jnvVz8PiHZHbSlwwF+hmxgmM2J8v+UAaaPq5JWG+c0PYynjH+gyUNaZbgfYm5rGj7ToAaJ
	Q==
X-Received: by 2002:a17:90b:4986:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39bac34a641mr7338347a91.13.1788944487761;
        Wed, 09 Sep 2026 02:01:27 -0700 (PDT)
Received: from localhost ([106.38.226.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cd20641e2sm951155a91.3.2026.09.09.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:27 -0700 (PDT)
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
Subject: [PATCH 3/7] block: use sb_for_each_inodes() in sync_bdevs()
Date: Wed,  9 Sep 2026 17:01:08 +0800
Message-Id: <20260909090112.790006-4-sunjunchao@bytedance.com>
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

Convert sync_bdevs() to sb_for_each_inodes() and move device writeback
into a callback. The iterator preserves the walk position, allowing the
callback to iput() its inode before reacquiring the list lock and removing
the old_inode reference carried across iterations.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/bdev.c | 85 +++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..ae472a062e51 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1336,56 +1336,53 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
  */
 EXPORT_SYMBOL_GPL(bdev_mark_dead);
 
-void sync_bdevs(bool wait)
+static int sync_bdevs_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *old_inode = NULL;
-
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
-		struct address_space *mapping = inode->i_mapping;
-		struct block_device *bdev;
+	bool wait = (bool)data;
+	struct block_device *bdev;
+	struct address_space *mapping = inode->i_mapping;
 
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW) ||
-		    mapping->nrpages == 0) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
+	if (mapping->nrpages == 0) {
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
+		return 0;
+	}
+
+	/*
+	 * We hold a reference to 'inode' so it couldn't have been
+	 * removed from s_inodes list while we dropped the
+	 * s_inode_list_lock.
+	 */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	bdev = I_BDEV(inode);
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!atomic_read(&bdev->bd_openers)) {
+		; /* skip */
+	} else if (wait) {
 		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
+		 * We keep the error status of individual mapping so
+		 * that applications can catch the writeback error using
+		 * fsync(2). See filemap_fdatawait_keep_errors() for
+		 * details.
 		 */
-		iput(old_inode);
-		old_inode = inode;
-		bdev = I_BDEV(inode);
-
-		mutex_lock(&bdev->bd_disk->open_mutex);
-		if (!atomic_read(&bdev->bd_openers)) {
-			; /* skip */
-		} else if (wait) {
-			/*
-			 * We keep the error status of individual mapping so
-			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
-			 * details.
-			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
-		} else {
-			filemap_fdatawrite(inode->i_mapping);
-		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
-
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		filemap_fdatawait_keep_errors(inode->i_mapping);
+	} else {
+		filemap_fdatawrite(inode->i_mapping);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
-	iput(old_inode);
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	iput(inode);
+
+	spin_lock(&blockdev_superblock->s_inode_list_lock);
+
+	return 0;
+}
+
+void sync_bdevs(bool wait)
+{
+	sb_for_each_inodes(blockdev_superblock, INODE_ITER_NORMAL,
+			   sync_bdevs_inode_iter_cb, (void *)wait);
 }
 
 /*
-- 
2.39.5

