Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED9449B02
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235703; cv=none; b=o21Emul7M6VpzXiKCTdbj7+1MNa78g86pk2ye6sj/maL4qYxnqgBVYTgLLTpezrM6HL60ZqNMw7mGzZahyObhsjq7JOHB37A76B4slNPEiW4frrizSj+k7+ppKWI4xU9dkQ/RAfqvxzX19DfZQpuqt+AUwf2fM2Lx1FcSNXcR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235703; c=relaxed/simple;
	bh=uXZcbwPZFNfmPlPE45iXbCq7VwKzVQT4kMd9y0JnJp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NBEkQT0zdTCM46OXLVoKclt37RVCBwWRFqpJEXsPtL53sZe1+5UuphryRbtNq3eRKtBPIFgzcEyJVAio9s43jjhhNanVhYeMCuF22jejqcClblXqf7O8fQUJb1yJODsMAYIALqTx+fHED2jX2LMEx+YA4nL6fFnzIn01WY3+mPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxzpxOyF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxzpxOyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIeBcKGn3nmkA1Kmey+b9cVEw8wdpg93C+ThE4sMT5Q=;
	b=BxzpxOyFWaMB8Fd53icFAFwAGYRSwh7HCMqxc4avPvtxKMw9RbtXkMRvHJASTbY04s0iKa
	ffkzr1g4DNQKo24U/VM5taA1e/qbHR0jqHzj6ZiIXU84+4fDRs93Kh73EvUaPLy62HkJlO
	utgylmDJA3W4hDaF+K51u/aNBPlM1yA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Z1y2q0XhPaSF_9C-h91iqQ-1; Thu,
 20 Aug 2026 10:21:35 -0400
X-MC-Unique: Z1y2q0XhPaSF_9C-h91iqQ-1
X-Mimecast-MFC-AGG-ID: Z1y2q0XhPaSF_9C-h91iqQ_1787235694
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D03EC1956044;
	Thu, 20 Aug 2026 14:21:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A77703001DAF;
	Thu, 20 Aug 2026 14:21:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 1/6] gfs2: Avoid ip->i_gl dereferences in gfs2_inode_lookup and gfs2_create_inode
Date: Thu, 20 Aug 2026 16:21:22 +0200
Message-ID: <20260820142129.1327413-2-agruenba@redhat.com>
In-Reply-To: <20260820142129.1327413-1-agruenba@redhat.com>
References: <20260820142129.1327413-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y-PftaY5Gdw40tJYnBzTp9pLr8_ZRurfDY5a4u7y0IM_1787235694
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Store the inode glock in a separate variable instead of repeatedly retrieving
it as ip->i_gl.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f361876c5583..438519bc06d4 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -130,6 +130,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 {
 	struct inode *inode;
 	struct gfs2_inode *ip;
+	struct gfs2_glock *gl = NULL;
 	struct gfs2_holder i_gh;
 	int error;
 
@@ -147,9 +148,10 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 
 		gfs2_setup_inode(inode);
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE,
-				       &ip->i_gl);
+				       &gl);
 		if (unlikely(error))
 			goto fail;
+		ip->i_gl = gl;
 
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CREATE,
 				       &io_gl);
@@ -178,14 +180,14 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 			 * block.  We read the inode when instantiating it
 			 * after possibly checking the block type.
 			 */
-			error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE,
+			error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE,
 						   GL_SKIP, &i_gh);
 			if (error)
 				goto fail;
 
 			error = -ESTALE;
 			if (no_formal_ino &&
-			    gfs2_inode_already_deleted(ip->i_gl, no_formal_ino))
+			    gfs2_inode_already_deleted(gl, no_formal_ino))
 				goto fail;
 
 			if (blktype != GFS2_BLKST_FREE) {
@@ -196,20 +198,20 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 			}
 		}
 
-		set_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
+		set_bit(GLF_INSTANTIATE_NEEDED, &gl->gl_flags);
 
 		/* Lowest possible timestamp; will be overwritten in gfs2_dinode_in. */
 		inode_set_atime(inode,
 				1LL << (8 * sizeof(inode_get_atime_sec(inode)) - 1),
 				0);
 
-		glock_set_object(ip->i_gl, ip);
+		glock_set_object(gl, ip);
 
 		if (type == DT_UNKNOWN) {
 			/* Inode glock must be locked already */
 			error = gfs2_instantiate(&i_gh);
 			if (error) {
-				glock_clear_object(ip->i_gl, ip);
+				glock_clear_object(gl, ip);
 				goto fail;
 			}
 		} else {
@@ -240,8 +242,8 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 	if (gfs2_holder_initialized(&i_gh))
 		gfs2_glock_dq_uninit(&i_gh);
-	if (ip->i_gl) {
-		gfs2_glock_put(ip->i_gl);
+	if (gl) {
+		gfs2_glock_put(gl);
 		ip->i_gl = NULL;
 	}
 	iget_failed(inode);
@@ -708,7 +710,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct gfs2_inode *dip = GFS2_I(dir), *ip;
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
-	struct gfs2_glock *io_gl;
+	struct gfs2_glock *gl = NULL, *io_gl;
 	int error, dealloc_error;
 	u32 aflags = 0;
 	unsigned blocks = 1;
@@ -832,9 +834,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	gfs2_set_inode_blocks(inode, blocks);
 
-	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
+	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &gl);
 	if (error)
 		goto fail_dealloc_inode;
+	ip->i_gl = gl;
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
@@ -854,10 +857,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock2;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, &gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, GL_SKIP, &gh);
 	if (error)
 		goto fail_gunlock3;
-	clear_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
+	clear_bit(GLF_INSTANTIATE_NEEDED, &gl->gl_flags);
 
 	error = gfs2_trans_begin(sdp, blocks, 0);
 	if (error)
@@ -870,7 +873,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	init_dinode(dip, ip, symname);
 	gfs2_trans_end(sdp);
 
-	glock_set_object(ip->i_gl, ip);
+	glock_set_object(gl, ip);
 	glock_set_object(io_gl, ip);
 	gfs2_set_iop(inode);
 
@@ -914,7 +917,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	return error;
 
 fail_gunlock4:
-	glock_clear_object(ip->i_gl, ip);
+	glock_clear_object(gl, ip);
 	glock_clear_object(io_gl, ip);
 fail_gunlock3:
 	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
@@ -932,8 +935,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		fs_warn(sdp, "%s: %d\n", __func__, dealloc_error);
 	ip->i_no_addr = 0;
 fail_free_inode:
-	if (ip->i_gl) {
-		gfs2_glock_put(ip->i_gl);
+	if (gl) {
+		gfs2_glock_put(gl);
 		ip->i_gl = NULL;
 	}
 	gfs2_rs_deltree(&ip->i_res);
-- 
2.55.0

