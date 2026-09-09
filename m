Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA074968FF
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944510; cv=none; b=rgQeeLT7v85o31ngMOhbnakalPbgXNovJ7iUA6YC8+vO6qBesB+/HVqVI56HiEpoPtitplNeJUkepphA0nJSFKAF/nbI4zQ/2bw3f1af56b6R7p1BF3prkz5cWx7vnZqJbBkHpNpcYb4NZhcMQzu5DvKo7RbK+DoJRqAmLT9/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944510; c=relaxed/simple;
	bh=8FHBC5gbFeIC4E/lA238Bv5TaDRS4lUM54i1wq/3L1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5oDQuxJt7e4BfjsGZ5N2a53lVEPEFdmCQ6YHRVjFr+XehXnqOHQhGUXRSAcUEe4gBeB972RvqS8naYL9kYATb5lNsx78m/V+Chtj875T9NwnqA16I6tj3wFgmlG1BYp0P5FeV98ntqcCMXOqNwl5nlWiphDwspEnrtZyudy14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Of5Eg7gb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Of5Eg7gb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8692be1cda4so95647b3a.1
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944505; x=1789549305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=Of5Eg7gbyMb3oyudoVn8H/5VlOZskFbXVv6nAAspLAvNoJJFkcOKTSL47JtFs9cikJ
         q4MteLjbk0XHHWB4BGT/gzUFcQDYTAAL/EhEWv7Ug4VfTmMUtSvxsFBXzzA0mXsxKFf5
         nxXgHCUcWgR3ly87TXIbAGJovzsYuBoD7tcMeI7UEYXsIeepU8XihbywWjKSN2p9NFq+
         mrpyZez3Xs/Z6UnKaQNxn+d2s7rfJuFvBAtCzIoV9BdZkoNMsOE1ZKBFrPLoTZ/TWdHx
         9rYdOQmwclyInCYd3KkJEbrZ2FkeenlwuQUbs1JC6cuev1uBJu7krXoGzssEojT8kssy
         +IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944505; x=1789549305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=s5Fc++Vp4nIzFZn+Tn86nmbTBQ9avxRTU3hrDtgfNEhdhawHYsFNOF34N+/hjLZDb0
         2vafXAf3yEwKEsg3oxfPLAFVqeAQddIQXHdTAe0NRV77m9MKjoFjYf+gpouV6rtioDzl
         HxTh0gGSL7htMtiarykrorxp8p+Nuk6VY0ZFAt1AaGstaaK/7UULzVoM0DzQMkeA9J9E
         FKgAHgvUQvBpCkC6V6INAgWKJn3wCLvL2xGHFnm2C4wnYgfK9tTxWO11c66DupHwHvNz
         jd7xgbPEWmplV8PMjBvWbcRhdG7uhoHD9oWyCuLe8DkF7l8kwuH42pjl1FXgU8bNLk36
         fTsA==
X-Forwarded-Encrypted: i=1; AKwUvBwekJ0MxIElsy0hypdqe0Ej4QprtCltiU+M668dBE6kRTSr8zEnuUjoD3x4OpG1ol/In1tc@lists.linux.dev
X-Gm-Message-State: AFuF++mp4gsPBLZB+3aVUlC6hTvzTnbrdHet9zEcmARfcktdnPuxzbvg
	SDw/uSjNgN9YAW4M9x8RiL0u05bFWVC2qh8WDylvK4EyrYxAIxhVj286W8+N6K+eQIg=
X-Gm-Gg: AYBFou0/pJvIFxK4hAMQA+sUwDdDUFiyNEUcGR6AZePTkA5TmSf2AgnAKLSv5JEUD7Q
	3f3ddtPtPilWxWyu54iRWnoIjPFTrj1MYogZcil7sc4tkhFFmyJGYgBLLha9LZKmYqIzFTGQKvd
	oGh28Bp8FfaJb7Bg1M4A4jiRHwXekn7ZrTSilD+DjCvZ8wvuoRr51T1WfdTFMcA14HVAcW0bw2d
	nl37dwYpbaMaoeiy3rFLGrZTPiBTudmxXDviErxykCVykbPF1bxPeUIZne8HVgy6xV1CJrdHTjY
	UospYydyhglp0kv22f2haU4FzlvYzM31BNW/d7xWS7362gwP8BI34mwNN7yceVnHFmdgAF1npFX
	zlEbxQ/Eh7mkTRDjU69ic9WOamTK/5Wv8i8FVWFyJq9c9tT2o/Jlci260LifC9vk4D1DdC5/oz2
	UBo1o1gIkmm9rGXf1/cGdf1n7P+KQXdvGOmMrVCxx476ee7u1/lzYiEl7pm+H4CHlHy7mPnEm52
	p0=
X-Received: by 2002:a05:6a00:909a:b0:857:7317:cff1 with SMTP id d2e1a72fcca58-8616a168525mr51310976b3a.18.1788944504640;
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
Received: from localhost ([106.38.226.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-868d1e4ff97sm483493b3a.17.2026.09.09.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
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
Subject: [PATCH 7/7] landlock: use sb_for_each_inodes() when detaching a superblock
Date: Wed,  9 Sep 2026 17:01:12 +0800
Message-Id: <20260909090112.790006-8-sunjunchao@bytedance.com>
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

Convert hook_sb_delete() to sb_for_each_inodes() and release each
callback's inode reference outside s_inode_list_lock. This removes the
prev_inode reference used to preserve the walk position while retaining
the synchronization with release_inode() and the final wait for pending
inode releases.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 security/landlock/fs.c | 150 +++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..3dcde8cbfb6a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1369,110 +1369,80 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static int hook_sb_delete_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *prev_inode = NULL;
+	struct landlock_object *object;
+	struct super_block *sb = inode->i_sb;
 
-	if (!landlock_initialized)
-		return;
+	if (!atomic_read(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
+	/* Keeps a reference to this inode until the next loop walk. */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 
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
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
 
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
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 
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
+	return 0;
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
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	unsigned int flags = INODE_ITER_NORMAL;
 
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
+	if (!landlock_initialized)
+		return;
+
+	sb_for_each_inodes(sb, flags, hook_sb_delete_inode_iter_cb, NULL);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.39.5

