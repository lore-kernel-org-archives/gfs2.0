Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053612F59C
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640928; cv=none; b=hbGBCcYacENH21mdCkqe8AIgi0y76yzEDj8Y+j5HGJiHPPaIpU8+B5InsC7kJe2Cn/qZw64TaxSUFCHQVSNc7x0tNo45SL1ThVNBngfyPTwxVS800ymazVLtzIXsoX0ImJfhWbt76Ht7kalnnrNzL8RemdAGMi2THuvxG2nadiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640928; c=relaxed/simple;
	bh=46WpczucCyTh6Cv7gOTVvLofifa/zlW1irs5OZpdzZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz3KxC6sTMmJcRxT0Un2hKhaVLXhJNIt6r6htAaqUW85xIwAURaCOcz8GkDvSjpyuPEDZH1HAY05nSxrEP3kVlpvNHZJqCjagwsaUMFfajDv8cZBieg4P6Mh2truH2uYJL7RrgCkV8EZRlr1ZHmhaeZMFMJJit3X7QzoIDkP5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQLr37L2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQLr37L2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711640925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBo/bd1gq0fWi2h4WTrwZco5Gw5V48aLvXeNl1yOcyc=;
	b=MQLr37L2G8FHFAr6VUpuWdpblFczoVlzPYfWw5TXdrKgqMg19Gj1Jb8Xv/zrdhQ1ebXHap
	/GuNgIyFnmspYk3lv015qpY6JXyODI06tEYfkHXGgiRGm2C8hEOqCqpjgCigieXxEduRYo
	8jv5y7mly7lxJEbwVnlsawy+3qXOOV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-WbHJKXfMMJOMe5JZXR07pg-1; Thu, 28 Mar 2024 11:48:44 -0400
X-MC-Unique: WbHJKXfMMJOMe5JZXR07pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBE25800269
	for <gfs2@lists.linux.dev>; Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B3E91C04122;
	Thu, 28 Mar 2024 15:48:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [PATCH v6.9-rc1 06/10] dlm: remove callback queue debugfs functionality
Date: Thu, 28 Mar 2024 11:48:38 -0400
Message-ID: <20240328154842.1099288-6-aahringo@redhat.com>
In-Reply-To: <20240328154842.1099288-1-aahringo@redhat.com>
References: <20240328154842.1099288-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes the whole functionality to dump the pending lkb
callbacks. We are preparing to remove any relation from the lkb and its
callback because we cannot held any lkb reference when the callback
occurs. As result we will drop the per lkb callback queue.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 96 -----------------------------------------------
 1 file changed, 96 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 4fa11d9ddbb6..289d959c7700 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -366,52 +366,6 @@ static void print_format4(struct dlm_rsb *r, struct seq_file *s)
 	unlock_rsb(r);
 }
 
-static void print_format5_lock(struct seq_file *s, struct dlm_lkb *lkb)
-{
-	struct dlm_callback *cb;
-
-	/* lkb_id lkb_flags mode flags sb_status sb_flags */
-
-	spin_lock(&lkb->lkb_cb_lock);
-	list_for_each_entry(cb, &lkb->lkb_callbacks, list) {
-		seq_printf(s, "%x %x %d %x %d %x\n",
-			   lkb->lkb_id,
-			   dlm_iflags_val(lkb),
-			   cb->mode,
-			   cb->flags,
-			   cb->sb_status,
-			   cb->sb_flags);
-	}
-	spin_unlock(&lkb->lkb_cb_lock);
-}
-
-static void print_format5(struct dlm_rsb *r, struct seq_file *s)
-{
-	struct dlm_lkb *lkb;
-
-	lock_rsb(r);
-
-	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
-		print_format5_lock(s, lkb);
-		if (seq_has_overflowed(s))
-			goto out;
-	}
-
-	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		print_format5_lock(s, lkb);
-		if (seq_has_overflowed(s))
-			goto out;
-	}
-
-	list_for_each_entry(lkb, &r->res_waitqueue, lkb_statequeue) {
-		print_format5_lock(s, lkb);
-		if (seq_has_overflowed(s))
-			goto out;
-	}
- out:
-	unlock_rsb(r);
-}
-
 struct rsbtbl_iter {
 	struct dlm_rsb *rsb;
 	unsigned bucket;
@@ -455,13 +409,6 @@ static int table_seq_show(struct seq_file *seq, void *iter_ptr)
 		}
 		print_format4(ri->rsb, seq);
 		break;
-	case 5:
-		if (ri->header) {
-			seq_puts(seq, "lkb_id lkb_flags mode flags sb_status sb_flags\n");
-			ri->header = 0;
-		}
-		print_format5(ri->rsb, seq);
-		break;
 	}
 
 	return 0;
@@ -471,7 +418,6 @@ static const struct seq_operations format1_seq_ops;
 static const struct seq_operations format2_seq_ops;
 static const struct seq_operations format3_seq_ops;
 static const struct seq_operations format4_seq_ops;
-static const struct seq_operations format5_seq_ops;
 
 static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 {
@@ -503,8 +449,6 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 		ri->format = 3;
 	if (seq->op == &format4_seq_ops)
 		ri->format = 4;
-	if (seq->op == &format5_seq_ops)
-		ri->format = 5;
 
 	tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
@@ -659,18 +603,10 @@ static const struct seq_operations format4_seq_ops = {
 	.show  = table_seq_show,
 };
 
-static const struct seq_operations format5_seq_ops = {
-	.start = table_seq_start,
-	.next  = table_seq_next,
-	.stop  = table_seq_stop,
-	.show  = table_seq_show,
-};
-
 static const struct file_operations format1_fops;
 static const struct file_operations format2_fops;
 static const struct file_operations format3_fops;
 static const struct file_operations format4_fops;
-static const struct file_operations format5_fops;
 
 static int table_open1(struct inode *inode, struct file *file)
 {
@@ -757,20 +693,6 @@ static int table_open4(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int table_open5(struct inode *inode, struct file *file)
-{
-	struct seq_file *seq;
-	int ret;
-
-	ret = seq_open(file, &format5_seq_ops);
-	if (ret)
-		return ret;
-
-	seq = file->private_data;
-	seq->private = inode->i_private; /* the dlm_ls */
-	return 0;
-}
-
 static const struct file_operations format1_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open1,
@@ -804,14 +726,6 @@ static const struct file_operations format4_fops = {
 	.release = seq_release
 };
 
-static const struct file_operations format5_fops = {
-	.owner   = THIS_MODULE,
-	.open    = table_open5,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release
-};
-
 /*
  * dump lkb's on the ls_waiters list
  */
@@ -1021,16 +935,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 							  dlm_root,
 							  ls,
 							  &waiters_fops);
-
-	/* format 5 */
-
-	snprintf(name, sizeof(name), "%s_queued_asts", ls->ls_name);
-
-	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
-							      0644,
-							      dlm_root,
-							      ls,
-							      &format5_fops);
 }
 
 void __init dlm_register_debugfs(void)
-- 
2.43.0

