Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05865215162
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315661; cv=none; b=RioFdBLFRnZKj6QlsTWoR1j5gEmG6PojKFvU9EjzxLH3DRQdPRkB8CxgKkF7A+FKKKKZmHCgthyYudOhfm8SQQZXmWuz23J0XVjJPLSQAdCvWg36kRit8jJNFrSMEGSfncXcn+isgzNtYQiPjuSEJNe+KsW982mpemiR4+pzTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315661; c=relaxed/simple;
	bh=V76ajcUCLuwJR8PPdjHQNpBhwIv3cPl5J/F0aDV4Iuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RSKx0GBUTsCtosCCFIq/oVTx5s1efOMMK8DbIyblEFbf2M2SFxzo98vb3YNSY7+2745IzqMqEQRKU3C4JgHJT9CbjqsoWoP6vJxM2QAv3Rn9UY0/5/+WZ6Z6JPb11VwM5dNL5Anw0/P3KQAqy8bAxdLtGAEaEsYznQNZgCzT7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBezBy2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBezBy2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745315655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NBKTfcyQDkowIuuDDnu2kCvch5MGRCD9PtQCzncuyg=;
	b=dBezBy2cyA1r5s2fZvj1eiCzDaFRqR371DphxEcy5Bioxj+cWdbJ8fcKyrhu46d0eHzPcQ
	goA49jLQiFpL6sRS3amT2pPhUMFTqkITbT75HREqqkLLiaXFtuwF1CoVJmC8SK7J7PvJmr
	sXzvxgB0r/eigdljz4Zd7/xspiG2P3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-JibbMQIKNRysiGorOHiJdA-1; Tue,
 22 Apr 2025 05:54:13 -0400
X-MC-Unique: JibbMQIKNRysiGorOHiJdA-1
X-Mimecast-MFC-AGG-ID: JibbMQIKNRysiGorOHiJdA_1745315653
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FFAF1800570
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:13 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0947B30001A2;
	Tue, 22 Apr 2025 09:54:11 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] gfs2: deallocate inodes in gfs2_create_inode
Date: Tue, 22 Apr 2025 11:54:07 +0200
Message-ID: <20250422095407.1221362-3-agruenba@redhat.com>
In-Reply-To: <20250422095407.1221362-1-agruenba@redhat.com>
References: <20250422095407.1221362-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7E_rzfpy1yHsuZKt5mcitKsc_bxlejnk6imljJWeadE_1745315653
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When creating and destroying inodes, we are relying on the inode hash
table to make sure that for a given inode number, only a single inode
will exist.  We then link that inode to its inode and iopen glock and
let those glocks point back at the inode.  However, when iget_failed()
is called, the inode is removed from the inode hash table before
gfs_evict_inode() is called, and uniqueness is no longer guaranteed.

Commit f1046a472b70 ("gfs2: gl_object races fix") was trying to work
around that problem by detaching the inode glock from the inode before
calling iget_failed(), but that broke the inode deallocation code in
gfs_evict_inode().

To fix that, deallocate partially created inodes in gfs2_create_inode()
instead of relying on gfs_evict_inode() for doing that.

This means that gfs2_evict_inode() and its helper functions will no
longer see partially created inodes, and some simplifications are
possible there.

Fixes: f1046a472b70 ("gfs2: gl_object races fix")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 21 ++++++++++++++-------
 fs/gfs2/super.c |  6 +-----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 0b2d75106b1c..2812cce21817 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -701,6 +701,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	u32 aflags = 0;
 	unsigned blocks = 1;
 	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
+	bool xattr_initialized = false;
 
 	if (!name->len || name->len > GFS2_FNAMESIZE)
 		return -ENAMETOOLONG;
@@ -813,11 +814,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 	gfs2_cancel_delete_work(io_gl);
 	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
 
@@ -842,8 +843,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock3;
 
-	if (blocks > 1)
+	if (blocks > 1) {
 		gfs2_init_xattr(ip);
+		xattr_initialized = true;
+	}
 	init_dinode(dip, ip, symname);
 	gfs2_trans_end(sdp);
 
@@ -898,6 +901,14 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 fail_gunlock2:
 	gfs2_glock_put(io_gl);
+fail_dealloc_inode:
+	set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
+	if (ip->i_eattr)
+		gfs2_ea_dealloc(ip, xattr_initialized);
+	clear_nlink(inode);
+	mark_inode_dirty(inode);
+	gfs2_dinode_dealloc(ip);
+	ip->i_no_addr = 0;
 fail_free_inode:
 	if (ip->i_gl) {
 		gfs2_glock_put(ip->i_gl);
@@ -912,10 +923,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(&d_gh);
 	if (!IS_ERR_OR_NULL(inode)) {
-		set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
-		clear_nlink(inode);
-		if (ip->i_no_addr)
-			mark_inode_dirty(inode);
 		if (inode->i_state & I_NEW)
 			iget_failed(inode);
 		else
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e25a24ae2197..54f1efd47a3e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1258,9 +1258,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int ret;
 
-	if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
-		goto should_delete;
-
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
 		return EVICT_SHOULD_DEFER_DELETE;
@@ -1290,7 +1287,6 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 	if (inode->i_nlink)
 		return EVICT_SHOULD_SKIP_DELETE;
 
-should_delete:
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags))
 		return gfs2_upgrade_iopen_glock(inode);
@@ -1314,7 +1310,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	}
 
 	if (ip->i_eattr) {
-		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
+		ret = gfs2_ea_dealloc(ip, true);
 		if (ret)
 			goto out;
 	}
-- 
2.49.0

