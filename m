Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C811EB1A8
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315654; cv=none; b=TTZ+Ck746AnDvP01ZrU1gIOEs/OpeHrme9fuU73nxYweiPG4poNEbVFGgSHQBQDqn2nE7u71+6f4FDsbft8SNzbmOuQmfrpwno4oN28/R3Zbh6uEnxBVU/yrvRqzbEq5y+blusFDVs4tdG7WKVEAfmB2OSEvU5HlFWNoWU8Anew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315654; c=relaxed/simple;
	bh=281zJ6qJBITJjQn4vPKaWD0Lj5mv3qXcgXipoFSkAws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CJI/XV2qXSe410ZQPwVVep/WcCKspkuMmjatFNQ2/tKzyz+B8PEoH7t2u8pYsUIs392rHS8A785pyyJwNh67zVGUfuezORlawl34HmqWh9X8JF593oObpwn43EVwIgbJkjOpJAcpHT17+PBg+lYffgWwdMcZm79D5INZgoYB69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN6alvZR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN6alvZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745315652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8wEeld1t54VbmSzTYlABgpgwFtde3nsVh1OLv0lorc=;
	b=aN6alvZRwzRtTr6DyciQn3t7YpRaT75ZtIFbarhM+My0sW5IiZ8fKxubQfQ+fpnaIyS3th
	TjDStt5KWEYU2ugMcf8QxLRKZn4fP4AmrSDiGIxn+jojY56a/DCQpq7sjZJFeb+a5xbHFr
	ia/ZuklzljxIhRD4zT28BOJ2rL2cC4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-2nMvvqn6NJOrgsYsIBtpvA-1; Tue,
 22 Apr 2025 05:54:10 -0400
X-MC-Unique: 2nMvvqn6NJOrgsYsIBtpvA-1
X-Mimecast-MFC-AGG-ID: 2nMvvqn6NJOrgsYsIBtpvA_1745315650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00441800263
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:09 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D79EC30001A2;
	Tue, 22 Apr 2025 09:54:08 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] gfs2: Move gfs2_dinode_dealloc
Date: Tue, 22 Apr 2025 11:54:05 +0200
Message-ID: <20250422095407.1221362-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7NR1_OS_flIE_rdXw6NyCFk0_7P16hPHjLvXsHMKZlQ_1745315650
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move gfs2_dinode_dealloc() and its helper gfs2_final_release_pages()
from super.c to inode.c.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/inode.h |  1 +
 fs/gfs2/super.c | 68 -------------------------------------------------
 3 files changed, 69 insertions(+), 68 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 62ff09264f0f..0b2d75106b1c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -439,6 +439,74 @@ static int alloc_dinode(struct gfs2_inode *ip, u32 flags, unsigned *dblocks)
 	return error;
 }
 
+static void gfs2_final_release_pages(struct gfs2_inode *ip)
+{
+	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = ip->i_gl;
+
+	if (unlikely(!gl)) {
+		/* This can only happen during incomplete inode creation. */
+		BUG_ON(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
+		return;
+	}
+
+	truncate_inode_pages(gfs2_glock2aspace(gl), 0);
+	truncate_inode_pages(&inode->i_data, 0);
+
+	if (atomic_read(&gl->gl_revokes) == 0) {
+		clear_bit(GLF_LFLUSH, &gl->gl_flags);
+		clear_bit(GLF_DIRTY, &gl->gl_flags);
+	}
+}
+
+int gfs2_dinode_dealloc(struct gfs2_inode *ip)
+{
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	struct gfs2_rgrpd *rgd;
+	struct gfs2_holder gh;
+	int error;
+
+	if (gfs2_get_inode_blocks(&ip->i_inode) != 1) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+
+	gfs2_rindex_update(sdp);
+
+	error = gfs2_quota_hold(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
+	if (error)
+		return error;
+
+	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
+	if (!rgd) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out_qs;
+	}
+
+	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE,
+				   LM_FLAG_NODE_SCOPE, &gh);
+	if (error)
+		goto out_qs;
+
+	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_STATFS + RES_QUOTA,
+				 sdp->sd_jdesc->jd_blocks);
+	if (error)
+		goto out_rg_gunlock;
+
+	gfs2_free_di(rgd, ip);
+
+	gfs2_final_release_pages(ip);
+
+	gfs2_trans_end(sdp);
+
+out_rg_gunlock:
+	gfs2_glock_dq_uninit(&gh);
+out_qs:
+	gfs2_quota_unhold(ip);
+	return error;
+}
+
 static void gfs2_init_dir(struct buffer_head *dibh,
 			  const struct gfs2_inode *parent)
 {
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 9e5e1622d50a..eafe123617e6 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -92,6 +92,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned type,
 struct inode *gfs2_lookup_by_inum(struct gfs2_sbd *sdp, u64 no_addr,
 				  u64 no_formal_ino,
 				  unsigned int blktype);
+int gfs2_dinode_dealloc(struct gfs2_inode *ip);
 
 struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 			   int is_root);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4529b7dda8ca..3f49f848c6b4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1173,74 +1173,6 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static void gfs2_final_release_pages(struct gfs2_inode *ip)
-{
-	struct inode *inode = &ip->i_inode;
-	struct gfs2_glock *gl = ip->i_gl;
-
-	if (unlikely(!gl)) {
-		/* This can only happen during incomplete inode creation. */
-		BUG_ON(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
-		return;
-	}
-
-	truncate_inode_pages(gfs2_glock2aspace(gl), 0);
-	truncate_inode_pages(&inode->i_data, 0);
-
-	if (atomic_read(&gl->gl_revokes) == 0) {
-		clear_bit(GLF_LFLUSH, &gl->gl_flags);
-		clear_bit(GLF_DIRTY, &gl->gl_flags);
-	}
-}
-
-static int gfs2_dinode_dealloc(struct gfs2_inode *ip)
-{
-	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct gfs2_rgrpd *rgd;
-	struct gfs2_holder gh;
-	int error;
-
-	if (gfs2_get_inode_blocks(&ip->i_inode) != 1) {
-		gfs2_consist_inode(ip);
-		return -EIO;
-	}
-
-	gfs2_rindex_update(sdp);
-
-	error = gfs2_quota_hold(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
-	if (error)
-		return error;
-
-	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
-	if (!rgd) {
-		gfs2_consist_inode(ip);
-		error = -EIO;
-		goto out_qs;
-	}
-
-	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE,
-				   LM_FLAG_NODE_SCOPE, &gh);
-	if (error)
-		goto out_qs;
-
-	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_STATFS + RES_QUOTA,
-				 sdp->sd_jdesc->jd_blocks);
-	if (error)
-		goto out_rg_gunlock;
-
-	gfs2_free_di(rgd, ip);
-
-	gfs2_final_release_pages(ip);
-
-	gfs2_trans_end(sdp);
-
-out_rg_gunlock:
-	gfs2_glock_dq_uninit(&gh);
-out_qs:
-	gfs2_quota_unhold(ip);
-	return error;
-}
-
 /**
  * gfs2_glock_put_eventually
  * @gl:	The glock to put
-- 
2.49.0

