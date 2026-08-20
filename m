Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23F476056
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235705; cv=none; b=KD+h/8CaTbOiA2Nvj63MTT87OiYmshUqE7dkVnV2imzyHYbHVaJYOlxQ+KP4jJpmWEQFxvTehPjGuqHNYUMLj0SI2y83O3KEwLHSULCQH5UzZMB5kvC1E/Pc1azqkD4ea3nIEFGV4BYFpFbo+LdYGukqcvXI3U/SVL2nlWFPb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235705; c=relaxed/simple;
	bh=bXvOtx4Lb4KYStfuQvEbcZXFmqRCMuiK+vJr6lTGrUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n+DO9KQIE/++EzOb7BRIWqjKVlIhdF+4IvS4H/jf1MeMh+i/hKUqnau8Z80MmKa8VSb0zh3sKzddnhlEdUs6Ux++xnU1njYm0tWakWEFvHnOVCoJC4pufbrLHVvjE2HNfC94cfIiS8fD2pz+DS1Wn8eVLmqALaiC6UJdCdHDDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpK30cFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpK30cFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySKfyUzApowtQtF2hGdic5hyV4Gu2NQTrLgP7fV9S6c=;
	b=hpK30cFvNCDH7PkO6iyMVBIEBvUBXK6BUkVvb64N/vBdEJ6b5dmrDiNqI6espuKQp83lDV
	t4622KZDtpzzFVTInjTyFtz7sw6YDb/U1rBWAxegcMwu/7AJ9XI0YO1JyOoTFRTZK7kz3Z
	XQIu2WVyv2szfEmEEPMDMxGDszgGhco=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-8cuD12aLNG22O0KaWrb45Q-1; Thu,
 20 Aug 2026 10:21:38 -0400
X-MC-Unique: 8cuD12aLNG22O0KaWrb45Q-1
X-Mimecast-MFC-AGG-ID: 8cuD12aLNG22O0KaWrb45Q_1787235697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57CEF1800471;
	Thu, 20 Aug 2026 14:21:37 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F6553001DAF;
	Thu, 20 Aug 2026 14:21:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 3/6] gfs2: Add inode variables
Date: Thu, 20 Aug 2026 16:21:24 +0200
Message-ID: <20260820142129.1327413-4-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fxFxZEX_UhR5CCz5Wqj4xZJViUmU0hx7b26x65LRneY_1787235697
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add inode variables in a few places to get rid of '&ip->i_inode'.  This cleans
up the code a little and prepares for the next step of adding an accessor
function for ip->i_gl.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c     | 37 ++++++++++++++++++++-----------------
 fs/gfs2/dir.c      |  4 +++-
 fs/gfs2/file.c     |  5 +++--
 fs/gfs2/quota.c    | 25 ++++++++++++++-----------
 fs/gfs2/recovery.c |  5 +++--
 5 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 73c626971163..636139f463b0 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -89,6 +89,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 
 static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 {
+	struct inode *inode = &ip->i_inode;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_dinode *di;
 	u64 block = 0;
@@ -99,7 +100,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 	if (error)
 		return error;
 
-	if (i_size_read(&ip->i_inode)) {
+	if (i_size_read(inode)) {
 		/* Get a free block, fill it with the stuffed data,
 		   and write it out to disk */
 
@@ -108,7 +109,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 		if (error)
 			goto out_brelse;
 		if (isdir) {
-			gfs2_trans_remove_revoke(GFS2_SB(&ip->i_inode), block, 1);
+			gfs2_trans_remove_revoke(GFS2_SB(inode), block, 1);
 			error = gfs2_dir_get_new_buffer(ip, block, &bh);
 			if (error)
 				goto out_brelse;
@@ -128,10 +129,10 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
-	if (i_size_read(&ip->i_inode)) {
+	if (i_size_read(inode)) {
 		*(__be64 *)(di + 1) = cpu_to_be64(block);
-		gfs2_add_inode_blocks(&ip->i_inode, 1);
-		di->di_blocks = cpu_to_be64(gfs2_get_inode_blocks(&ip->i_inode));
+		gfs2_add_inode_blocks(inode, 1);
+		di->di_blocks = cpu_to_be64(gfs2_get_inode_blocks(inode));
 	}
 
 	ip->i_height = 1;
@@ -1488,7 +1489,8 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			      struct buffer_head *bh, __be64 *start, __be64 *end,
 			      bool meta, u32 *btotal)
 {
-	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	struct inode *inode = &ip->i_inode;
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_rgrpd *rgd;
 	struct gfs2_trans *tr;
 	__be64 *p;
@@ -1546,7 +1548,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 
 			jblocks_rqsted = rgd->rd_length + RES_DINODE +
 				RES_INDIRECT;
-			isize_blks = gfs2_get_inode_blocks(&ip->i_inode);
+			isize_blks = gfs2_get_inode_blocks(inode);
 			if (isize_blks > atomic_read(&sdp->sd_log_thresh2))
 				jblocks_rqsted +=
 					atomic_read(&sdp->sd_log_thresh2);
@@ -1597,7 +1599,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 		if (bstart) {
 			__gfs2_free_blocks(ip, rgd, bstart, (u32)blen, meta);
 			(*btotal) += blen;
-			gfs2_add_inode_blocks(&ip->i_inode, -blen);
+			gfs2_add_inode_blocks(inode, -blen);
 		}
 		bstart = bn;
 		blen = 1;
@@ -1605,7 +1607,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 	if (bstart) {
 		__gfs2_free_blocks(ip, rgd, bstart, (u32)blen, meta);
 		(*btotal) += blen;
-		gfs2_add_inode_blocks(&ip->i_inode, -blen);
+		gfs2_add_inode_blocks(inode, -blen);
 	}
 out_unlock:
 	if (!ret && blks_outside_rgrp) { /* If buffer still has non-zero blocks
@@ -1620,7 +1622,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 
 			/* Every transaction boundary, we rewrite the dinode
 			   to keep its di_blocks current in case of failure. */
-			inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
+			inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 			gfs2_trans_add_meta(ip->i_gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
@@ -1746,7 +1748,8 @@ static inline bool walk_done(struct gfs2_sbd *sdp,
  */
 static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 {
-	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	struct inode *inode = &ip->i_inode;
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	u64 maxsize = sdp->sd_heightsize[ip->i_height];
 	struct metapath mp = {};
 	struct buffer_head *dibh, *bh;
@@ -1985,9 +1988,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 			down_write(&ip->i_rw_mutex);
 		}
 		gfs2_statfs_change(sdp, 0, +btotal, 0);
-		gfs2_quota_change(ip, -(s64)btotal, ip->i_inode.i_uid,
-				  ip->i_inode.i_gid);
-		inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
+		gfs2_quota_change(ip, -(s64)btotal, inode->i_uid, inode->i_gid);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		gfs2_trans_add_meta(ip->i_gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		up_write(&ip->i_rw_mutex);
@@ -2010,7 +2012,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 
 static int trunc_end(struct gfs2_inode *ip)
 {
-	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	struct inode *inode = &ip->i_inode;
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *dibh;
 	int error;
 
@@ -2024,13 +2027,13 @@ static int trunc_end(struct gfs2_inode *ip)
 	if (error)
 		goto out;
 
-	if (!i_size_read(&ip->i_inode)) {
+	if (!i_size_read(inode)) {
 		ip->i_height = 0;
 		ip->i_goal = ip->i_no_addr;
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 		gfs2_ordered_del_inode(ip);
 	}
-	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ip->i_diskflags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
 	gfs2_trans_add_meta(ip->i_gl, dibh);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0237b36b9eb1..f6111276ebb0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -759,10 +759,12 @@ static struct gfs2_dirent *gfs2_dirent_split_alloc(struct inode *inode,
 static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 		    struct buffer_head **bhp)
 {
+	struct inode *inode = &dip->i_inode;
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
 
 	error = gfs2_meta_read(dip->i_gl, leaf_no, DIO_WAIT, 0, bhp);
-	if (!error && gfs2_metatype_check(GFS2_SB(&dip->i_inode), *bhp, GFS2_METATYPE_LF)) {
+	if (!error && gfs2_metatype_check(sdp, *bhp, GFS2_METATYPE_LF)) {
 		/* pr_info("block num=%llu\n", leaf_no); */
 		error = -EIO;
 	}
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b8c10de113ba..164e160e9064 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -812,7 +812,8 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 				     struct gfs2_holder *gh)
 {
 	struct file *file = iocb->ki_filp;
-	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	size_t prev_count = 0, window_size = 0;
 	size_t read = 0;
 	ssize_t ret;
@@ -906,7 +907,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret)
 		goto out_uninit;
 	/* Silently fall back to buffered I/O when writing beyond EOF */
-	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(&ip->i_inode))
+	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode))
 		goto out_unlock;
 
 	from->nofault = true;
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 001c8b39ca55..0cb2bb0aec7b 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -740,8 +740,8 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 				  unsigned off, void *buf, unsigned bytes)
 {
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
-	struct inode *inode = &ip->i_inode;
+	struct inode *inode = sdp->sd_quota_inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
@@ -908,7 +908,8 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		   u64 sync_gen)
 {
 	struct gfs2_sbd *sdp = (*qda)->qd_sbd;
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
+	struct inode *inode = sdp->sd_quota_inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_alloc_parms ap = {};
 	unsigned int data_blocks, ind_blocks;
 	struct gfs2_holder *ghs, i_gh;
@@ -927,7 +928,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		return -ENOMEM;
 
 	sort(qda, num_qd, sizeof(struct gfs2_quota_data *), sort_qd, NULL);
-	inode_lock(&ip->i_inode);
+	inode_lock(inode);
 	for (qx = 0; qx < num_qd; qx++) {
 		error = gfs2_glock_nq_init(qda[qx]->qd_gl, LM_ST_EXCLUSIVE,
 					   GL_NOCACHE, &ghs[qx]);
@@ -991,9 +992,9 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 out_dq:
 	while (qx--)
 		gfs2_glock_dq_uninit(&ghs[qx]);
-	inode_unlock(&ip->i_inode);
+	inode_unlock(inode);
 	kfree(ghs);
-	gfs2_log_flush(glock_sbd(ip->i_gl), ip->i_gl,
+	gfs2_log_flush(sdp, ip->i_gl,
 		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
 		for (x = 0; x < num_qd; x++) {
@@ -1402,7 +1403,8 @@ int gfs2_quota_refresh(struct gfs2_sbd *sdp, struct kqid qid)
 
 int gfs2_quota_init(struct gfs2_sbd *sdp)
 {
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
+	struct inode *inode = sdp->sd_qc_inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	u64 size = i_size_read(sdp->sd_qc_inode);
 	unsigned int blocks = size >> sdp->sd_sb.sb_bsize_shift;
 	unsigned int x, slot = 0;
@@ -1434,7 +1436,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 
 		if (!extlen) {
 			extlen = 32;
-			error = gfs2_get_extent(&ip->i_inode, x, &dblock, &extlen);
+			error = gfs2_get_extent(inode, x, &dblock, &extlen);
 			if (error)
 				goto fail;
 		}
@@ -1714,7 +1716,8 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 			  struct qc_dqblk *fdq)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
+	struct inode *inode = sdp->sd_quota_inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_quota_data *qd;
 	struct gfs2_holder q_gh, i_gh;
 	unsigned int data_blocks, ind_blocks;
@@ -1741,7 +1744,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 	if (error)
 		goto out_put;
 
-	inode_lock(&ip->i_inode);
+	inode_lock(inode);
 	error = gfs2_glock_nq_init(qd->qd_gl, LM_ST_EXCLUSIVE, 0, &q_gh);
 	if (error)
 		goto out_unlockput;
@@ -1807,7 +1810,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 	gfs2_glock_dq_uninit(&q_gh);
 out_unlockput:
 	gfs2_qa_put(ip);
-	inode_unlock(&ip->i_inode);
+	inode_unlock(inode);
 out_put:
 	qd_put(qd);
 	return error;
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 616c46aa3434..b45aa3032ca2 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -32,14 +32,15 @@ struct workqueue_struct *gfs2_recovery_wq;
 int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 			   struct buffer_head **bh)
 {
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct inode *inode = jd->jd_inode;
+	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_glock *gl = ip->i_gl;
 	u64 dblock;
 	u32 extlen;
 	int error;
 
 	extlen = 32;
-	error = gfs2_get_extent(&ip->i_inode, blk, &dblock, &extlen);
+	error = gfs2_get_extent(inode, blk, &dblock, &extlen);
 	if (error)
 		return error;
 	if (!dblock) {
-- 
2.55.0

