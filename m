Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847033C9EF1
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091949; cv=none; b=FQYLmKilDgBoB8LTdE1YgbQ9OTQ4Cw0ZzzJFU192nkAg473hO6dRBLlEQ2d7JyTPdOvHc1IMbob1ozQ/nyNVsslhe+OiNw/KWfEnS8jzFe8h9mxJ+NOvnXKNCZp/zYPLFIcO529ms76fVb2NTvtMq6OQvTE301tw0vktUCAgQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091949; c=relaxed/simple;
	bh=aAVe8Gsv/HSSFGOYlQ/EtaBnfSp3Yq7eBzZeh9gP9Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ev3FD4g8lOdzboXC4aAlL90I+VqlxbCbaQOPJBuT95LaWvbEHzgFqNBDHl4tHGBGJQddB6KuBNc02P1HH8Qt/aCIv0v0MKVL+fq5fUFw+XThsr/rhOjdnIuHe1cx1mSBn/HVvn8qPbuSPaTaNsu1GGMADXXgHS7C36uYGsPt6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTFalOrn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTFalOrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ago6qXASGrLjlCi1tRm+/ov0no42fWgqdhviffY38QA=;
	b=hTFalOrnGtEXjZ5+nt+DVeK9ZRFFWrCj+GOZzy+G2ToGezvwppWHskRbCm660nVpZxjtRS
	LLrQ6BUFwtwxrr38NBNK9O/zxfmPri8JdHemXeScAkTJ437NepHu6gHhu+GdGPwdnXlbQz
	dPsIOhQmIBZPOUam+Gzg3xjzFbt1xsg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-Ij72E34jOQm7jvVSiCsY0w-1; Mon,
 13 Apr 2026 10:52:22 -0400
X-MC-Unique: Ij72E34jOQm7jvVSiCsY0w-1
X-Mimecast-MFC-AGG-ID: Ij72E34jOQm7jvVSiCsY0w_1776091942
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D03718002E5
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1945219560B1;
	Mon, 13 Apr 2026 14:52:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/18] gfs2: Fix data loss during inode evict
Date: Mon, 13 Apr 2026 16:51:58 +0200
Message-ID: <20260413145211.881752-6-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pCN9AhBZpRVwswNbi3Xv3I2GJ97k8WEMS1KEnOdI3qs_1776091942
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When gfs2_evict_inode() is called on an inode with unwritten data in the
page cache, the page cache needs to be written before it can be
truncated.  This doesn't always happen.  Fix that by changing
gfs2_evict_inode() to always either call evict_linked_inode() or
evict_unlinked_inode().

Inside evict_unlinked_inode(), first check if the inode is dirty.  If it
is, make sure the inode glock is held and write back the data and
metadata.  If it isn't, skip those steps.

Also, make sure that gfs2_evict_inode() calls gfs2_evict_inode() and
evict_unlinked_inode() only if ip->i_gl is not NULL; this avoids
unnecessary complications there.

Fixes xfstest generic/211.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b20494d6730a..e4219a04d16e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1241,6 +1241,9 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int ret;
 
+	if (inode->i_nlink)
+		return EVICT_SHOULD_SKIP_DELETE;
+
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
 		return EVICT_SHOULD_DEFER_DELETE;
@@ -1279,13 +1282,18 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 /**
  * evict_unlinked_inode - delete the pieces of an unlinked evicted inode
  * @inode: The inode to evict
+ * @gh: The glock holder structure
  */
-static int evict_unlinked_inode(struct inode *inode)
+static int evict_unlinked_inode(struct inode *inode, struct gfs2_holder *gh)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_glock *gl = ip->i_gl;
 	int ret;
 
+	/* The inode glock must be held exclusively and be instantiated. */
+	BUG_ON(!gfs2_holder_initialized(gh) ||
+	       test_bit(GLF_INSTANTIATE_NEEDED, &gl->gl_flags));
+
 	if (S_ISDIR(inode->i_mode) &&
 	    (ip->i_diskflags & GFS2_DIF_EXHASH)) {
 		ret = gfs2_dir_exhash_dealloc(ip);
@@ -1318,7 +1326,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	 */
 
 	ret = gfs2_dinode_dealloc(ip);
-	if (!ret && gl)
+	if (!ret)
 		gfs2_inode_remember_delete(gl, ip->i_no_formal_ino);
 
 out:
@@ -1357,19 +1365,30 @@ static int gfs2_truncate_inode_pages(struct inode *inode)
 /*
  * evict_linked_inode - evict an inode whose dinode has not been unlinked
  * @inode: The inode to evict
+ * @gh: The glock holder structure
  */
-static int evict_linked_inode(struct inode *inode)
+static int evict_linked_inode(struct inode *inode, struct gfs2_holder *gh)
 {
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_glock *gl = ip->i_gl;
-	struct address_space *metamapping;
+	struct address_space *metamapping = gfs2_glock2aspace(gl);
 	int ret;
 
+	if (!(test_bit(GLF_DIRTY, &gl->gl_flags) || inode->i_flags & I_DIRTY))
+		goto clean;
+
+	/* The inode glock must be held exclusively and be instantiated. */
+	if (!gfs2_holder_initialized(gh))
+		ret = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, gh);
+	else
+		ret = gfs2_instantiate(gh);
+	if (ret)
+		return ret;
+
 	gfs2_log_flush(sdp, gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
 		       GFS2_LFC_EVICT_INODE);
-	metamapping = gfs2_glock2aspace(gl);
 	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
 		filemap_fdatawrite(metamapping);
 		filemap_fdatawait(metamapping);
@@ -1377,6 +1396,7 @@ static int evict_linked_inode(struct inode *inode)
 	write_inode_now(inode, 1);
 	gfs2_ail_flush(gl, 0);
 
+clean:
 	ret = gfs2_truncate_inode_pages(inode);
 	if (ret)
 		return ret;
@@ -1415,7 +1435,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	int ret;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	if (inode->i_nlink || sb_rdonly(sb) || !ip->i_no_addr)
+	if (sb_rdonly(sb) || !ip->i_no_addr || !ip->i_gl)
 		goto out;
 
 	/*
@@ -1440,9 +1460,9 @@ static void gfs2_evict_inode(struct inode *inode)
 		behavior = EVICT_SHOULD_SKIP_DELETE;
 	}
 	if (behavior == EVICT_SHOULD_DELETE)
-		ret = evict_unlinked_inode(inode);
+		ret = evict_unlinked_inode(inode, &gh);
 	else
-		ret = evict_linked_inode(inode);
+		ret = evict_linked_inode(inode, &gh);
 
 	if (gfs2_rs_active(&ip->i_res))
 		gfs2_rs_deltree(&ip->i_res);
-- 
2.53.0

