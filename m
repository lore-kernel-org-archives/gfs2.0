Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8D491584
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944491; cv=none; b=gvyun3n1hzj5Wo5SkYLVG+iPP/+zg1PWqktMpXc53txmy8nA0gVpxbyJwVMlIz4C6sMUWVazTEMZ59m4GtkSrFy1GpEKqcSas7d4ca+WO3MyMdk3jL8cUPOXtz/tI/xTBvG/FI+XOLMYO60PqjYI/Ozc0zbXc4LhKTNndCFZvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944491; c=relaxed/simple;
	bh=jhgRCcb7mvKVZxOJ1EM1RoAJ+ehrjZv/eQIaG8NPXAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/xNCtRdly9KPcq5hDlQlhsPJd5AzJT90oINLpmh2xILYRUzc2DDJD9VpSNGmSNXuY9QlyeXGKC9he5xYhkaCI2QkEObpp9ajx5R09lVYKu9IDoIW9MweaV6wsAuA0e50tpmuQhlwarCbsUa5AUuUk7OZvvBm0BMqOr6vkhuLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dKhuMEoU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dKhuMEoU"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso6740458a91.1
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944484; x=1789549284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYH8W8/cakUiUYwi0P1xd+OFPw98tjeFCA4aRl63o4I=;
        b=dKhuMEoULiK9LDXdfViP3v61qG49tCF1MlaW9TlfTxuq+ilPdo5LG+UbnDYYEEC9h8
         r1m61B6l3qse+2SfUv4W+82/jacveSTKXpF+mVqesLXF+5DBd6IArVUZVvczZLOEEyQD
         FpwPqVg696IHzgo1t84s9ax3vcCixivmgJS7qOK04pUpxqFOwjrcCAz4z/QLBqD4SPJr
         WHNEto1hbOLWxUALZ97wSDwLOQTp0gl8bkwNqWr6yj9U50SlgC7zqRacpHfBWIoAG/7U
         10J0XIhO386ZrEP3YmFVywIRIqxL8ioKc7KJGk5IY0NxmV8dxOzFM4j3FyFO0y01O879
         rfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944484; x=1789549284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYH8W8/cakUiUYwi0P1xd+OFPw98tjeFCA4aRl63o4I=;
        b=R5vnzlCyd7PpjjW7rgSPAH1y+G7Wv/yfszMTxVdN7OGSuzKyRk4+ZUroYzzNl0CXYK
         dzqWGm932sTIyyBmwQtrTK8Hyou/4aTpwEuMvNbDunpoC3KKXnTSzVykU2fd8kDObFI4
         9MVfmV8lw5AhQpJcYfwvFdbOEwokpcxhYWK5yMjnRIE0yi+ctMwJFba1H/KEomgomrva
         E34LRuV1GAjnexawa9G3wucy+RKi3e19+lyyv0vqbao8j2Id+Q2q57tnmncxnge1HFGu
         cnBf8bPdm5L6bhjQl96ZQIHIQXqV+z8pe1VxUllMqZlVTs7y9uyDW1m3YmBE16ln1GMH
         4MCg==
X-Forwarded-Encrypted: i=1; AKwUvByCxAJYAXgu3uXPQ2QIFTGI0GCLfGGZGWl73xdolkhuj47jGcoG/pJB+dcWn/lCTXoOvzfr@lists.linux.dev
X-Gm-Message-State: AFuF++nQeOp6vSNwYrR1dNzbHUCQCA7cyMkpXynFdUCKpM1083AFUJiT
	BgZRCUS3U0AZP005z1PNqAS29D9ue5RXSAKWzHi2+ttD7nolCIFW1jyeVvAhn8RoVaY=
X-Gm-Gg: AYBFou0qif3d5oTPSdUtU24hW696sVs9wO7Agid5+Xpx4DwYSUdux01HlpFSf1V5pr1
	nCyHvSevL/IuuBgM0q7t9brgSvEoiKfPKUA5W5GCiVgydkaIh6AWMe4t9ZHXGs7PjP2+LfSLeWU
	ZHqNqtOGut+3WUzXtB+INrYpessmzKSOjz0huhHrnd33il0XdLNoN/+eTaS53r22ldOABuPgI5j
	wlwvpCJYB4ABW+VQyymGfJeFqM+aj2qm9i0fD8KPlzef1auVnlzizoTPrY0xfN4hOaXuT0+UgNu
	KT+9ZjvsICXQ0N7aFASfXOGFbxwiaSXyHdhaPw6TtADmrJEHfoeByNUkymGjuSEr5HdS0V+p12o
	uBHhrrTRMrveBA/dHm9X8rxV6gGTiHhgekrpa2OwE2jNjXvZn4EA5d4GLAmtXLd1BX4QRbDByG0
	LouqC1K88VuG8rsQR6LRC9UvCx/yrSi3kZUHKVM1GPsY2pwW+wrd996rq4AlnfybrOeOBDOuCQf
	xx16kgjB3oFkA==
X-Received: by 2002:a17:90b:544b:b0:398:c8ef:3644 with SMTP id 98e67ed59e1d1-39b26203e7amr48533741a91.15.1788944483947;
        Wed, 09 Sep 2026 02:01:23 -0700 (PDT)
Received: from localhost ([106.38.226.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4640bc66bsm5418841a12.10.2026.09.09.02.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:23 -0700 (PDT)
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
Subject: [PATCH 2/7] fs: introduce sb_for_each_inodes().
Date: Wed,  9 Sep 2026 17:01:07 +0800
Message-Id: <20260909090112.790006-3-sunjunchao@bytedance.com>
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

Add sb_for_each_inodes() to share s_inodes traversal and preserve its
position while s_inode_list_lock is dropped.

Track active iterators on sb->s_inodes_iters and advance their saved
positions before unlinking an inode. Callbacks manage inode references
and per-inode work, allowing both normal walks and eviction to use the
same interface.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/inode.c                     | 93 ++++++++++++++++++++++++++++++++++
 fs/super.c                     |  1 +
 include/linux/fs.h             | 15 ++++++
 include/linux/fs/super_types.h |  3 +-
 4 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..b4279063a5dd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -69,6 +69,15 @@ const struct address_space_operations empty_aops = {
 };
 EXPORT_SYMBOL(empty_aops);
 
+struct inode_iter {
+	struct list_head	iters_node;	/* sb->s_inodes_iters */
+	struct list_head	*next;		/* next node going to iterate */
+	unsigned int flags;
+	inode_iter_cb func;
+	void *data;
+	int ret;
+};
+
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
 
@@ -641,12 +650,96 @@ void inode_sb_list_add(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
+static void inode_sb_iter_start(struct super_block *sb, struct inode_iter *it,
+				unsigned int flags, inode_iter_cb fn, void *data)
+{
+	it->flags = flags;
+	it->func = fn;
+	it->data = data;
+	it->ret = 0;
+	spin_lock(&sb->s_inode_list_lock);
+	it->next = sb->s_inodes.next;
+	list_add(&it->iters_node, &sb->s_inodes_iters);
+}
+
+static void inode_sb_iter_end(struct inode_iter *it, struct super_block *sb)
+{
+	list_del(&it->iters_node);
+	spin_unlock(&sb->s_inode_list_lock);
+}
+
+static bool inode_sb_iter_next(struct inode_iter *it, struct super_block *sb)
+{
+	struct inode *inode = NULL;
+	int ret;
+
+	while (!inode && it->next != &sb->s_inodes) {
+		inode = list_entry(it->next, struct inode, i_sb_list);
+		if (it->flags & INODE_ITER_UNUSED) {
+			if (icount_read_once(inode)) {
+				it->next = it->next->next;
+				continue;
+			}
+
+			spin_lock(&inode->i_lock);
+			if (icount_read(inode)) {
+				spin_unlock(&inode->i_lock);
+				it->next = it->next->next;
+				continue;
+			}
+		} else {
+			spin_lock(&inode->i_lock);
+		}
+
+		if ((it->flags & INODE_ITER_NORMAL) &&
+		    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
+			spin_unlock(&inode->i_lock);
+			it->next = it->next->next;
+			continue;
+		}
+
+		it->next = it->next->next;
+		ret = it->func(inode, it->data);
+		if (ret) {
+			it->ret = ret;
+			return false;
+		}
+
+		if (need_resched()) {
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			spin_lock(&sb->s_inode_list_lock);
+		}
+	}
+
+	return it->next == &sb->s_inodes ? false : true;
+}
+
+int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
+		       inode_iter_cb fn, void *data)
+{
+	struct inode_iter it;
+
+	inode_sb_iter_start(sb, &it, flags, fn, data);
+	while (inode_sb_iter_next(&it, sb))
+		;
+	inode_sb_iter_end(&it, sb);
+
+	return it.ret;
+}
+EXPORT_SYMBOL(sb_for_each_inodes);
+
 static inline void inode_sb_list_del(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	struct inode_iter *it;
 
 	if (!list_empty(&inode->i_sb_list)) {
 		spin_lock(&sb->s_inode_list_lock);
+		list_for_each_entry(it, &sb->s_inodes_iters, iters_node) {
+			if (it->next == &inode->i_sb_list)
+				it->next = inode->i_sb_list.next;
+		}
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
 	}
diff --git a/fs/super.c b/fs/super.c
index 05e443173038..3e069150c544 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -382,6 +382,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	spin_lock_init(&s->s_roots_lock);
 	mutex_init(&s->s_sync_lock);
 	INIT_LIST_HEAD(&s->s_inodes);
+	INIT_LIST_HEAD(&s->s_inodes_iters);
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09c4db5e9ae0..f3176ab10e65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -870,6 +870,21 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+enum inode_iter_flags_enum {
+	INODE_ITER_NORMAL = (1U << 1),  /* Exclude inodes with (I_NEW | I_FREEING | I_WILL_FREE). */
+	INODE_ITER_UNUSED = (1U << 2),  /* Only return inodes with (i_count == 0). */
+};
+
+/*
+ *                             start          end
+ *  inode->i_lock              locked         unlocked
+ *  sb->s_inode_list_lock      locked         locked
+ */
+typedef int (*inode_iter_cb) (struct inode *, void *);
+
+int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
+		       inode_iter_cb fn, void *data);
+
 /*
  * i_state handling
  *
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..1f81cc219b8e 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -269,9 +269,10 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
-	/* s_inode_list_lock protects s_inodes */
+	/* s_inode_list_lock protects s_inodes and s_inodes_iters */
 	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
 	struct list_head			s_inodes;	/* all inodes */
+	struct list_head			s_inodes_iters; /* all iterators */
 
 	spinlock_t				s_inode_wblist_lock;
 	struct list_head			s_inodes_wb;	/* writeback inodes */
-- 
2.39.5

