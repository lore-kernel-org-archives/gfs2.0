Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651A4749C0
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235708; cv=none; b=e3ri/e/4oauAlnVTWrSJlLQ8DsDnRpWgZEuHQg1iC6SukeOMoXaL475tdn5quPzzQPVPnoq0iZwyPlrLkJK0adb5sQJdfmq8cK+1hrIEpUicHwbojfsDFgB5mSAODyKi1fAW0jSA23ch+rOe4JgRZvCWb1bnF2n64kYRiWOw98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235708; c=relaxed/simple;
	bh=42pxw5GnIB9mw4+tmru5IwcGBqIy86fa4fUaUl2N790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dtQjWIB8LkerhMsUAu6XSlrTfKpT7/j5pbeLrf9LXq6hmDfG8TALHJEHM4nGS86BsUZK7NvJZNiuBirNPpMN7RmgeYozBE1/2GNDkKjprk6iV5zHtO32tEaMnzCszk1n86Lh+QSiAun+A+UzKqJGpRhN8dUKvYwYpWRzMNxa7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLa2Y+L5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLa2Y+L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHVbJPMNIIO+HG0/vhIjbQUK6fzzsVFGDKrFr75AmKU=;
	b=CLa2Y+L50iB98XePo/UaiX6ZmGokg0jgi/OYsM2OXysgSvHG6MhFIXVpOXylZd6qS8+jJ8
	O8jn5ScZwNxxsLmUkw+mTmmST6WS4XpGgvWEcURX15uP0KAcJItVv5mV48STHMvPFvekX5
	loZcjxDUZ6ELCrufAHoYr1x2JzfoTGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-xv8HvtOiPqujmqjKgJAdWg-1; Thu,
 20 Aug 2026 10:21:40 -0400
X-MC-Unique: xv8HvtOiPqujmqjKgJAdWg-1
X-Mimecast-MFC-AGG-ID: xv8HvtOiPqujmqjKgJAdWg_1787235699
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EC921956058;
	Thu, 20 Aug 2026 14:21:39 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C733B3001DAF;
	Thu, 20 Aug 2026 14:21:37 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 4/6] gfs2: Introduce gfs2_inode_glock
Date: Thu, 20 Aug 2026 16:21:25 +0200
Message-ID: <20260820142129.1327413-5-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: HGHH3P-0LnWC5R_YsMN4LinvAsYNarbInvYYUSpCgKI_1787235699
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Introduce gfs2_inode_glock(inode) for getting from an inode to its inode glock.
This obsoletes the local variable 'ip' in several places.

The remaining direct accesses to ip->i_gl are for inode creation and
distruction, and will be cleaned up in the next patch.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/acl.c        | 11 +++---
 fs/gfs2/aops.c       | 17 ++++-----
 fs/gfs2/bmap.c       | 48 +++++++++++++++----------
 fs/gfs2/dentry.c     |  6 ++--
 fs/gfs2/dir.c        | 57 ++++++++++++++++++------------
 fs/gfs2/export.c     |  7 ++--
 fs/gfs2/file.c       | 69 ++++++++++++++++++++----------------
 fs/gfs2/glock.c      |  4 ++-
 fs/gfs2/glops.c      |  3 +-
 fs/gfs2/incore.h     |  5 ++-
 fs/gfs2/inode.c      | 83 ++++++++++++++++++++++++--------------------
 fs/gfs2/lops.c       | 18 +++++-----
 fs/gfs2/meta_io.c    |  7 ++--
 fs/gfs2/ops_fstype.c | 25 +++++++------
 fs/gfs2/quota.c      | 29 ++++++++--------
 fs/gfs2/recovery.c   | 12 +++----
 fs/gfs2/rgrp.c       |  4 +--
 fs/gfs2/super.c      | 70 +++++++++++++++++++------------------
 fs/gfs2/util.c       |  8 ++---
 fs/gfs2/xattr.c      | 69 +++++++++++++++++++++---------------
 20 files changed, 307 insertions(+), 245 deletions(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index a5b60778b91c..49e489fe27ef 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -59,7 +59,7 @@ static struct posix_acl *__gfs2_get_acl(struct inode *inode, int type)
 
 struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	bool need_unlock = false;
 	struct posix_acl *acl;
@@ -67,8 +67,8 @@ struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu)
 	if (rcu)
 		return ERR_PTR(-ECHILD);
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		int ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+	if (!gfs2_glock_is_locked_by_me(gl)) {
+		int ret = gfs2_glock_nq_init(gl, LM_ST_SHARED,
 					     LM_FLAG_ANY, &gh);
 		if (ret)
 			return ERR_PTR(ret);
@@ -106,6 +106,7 @@ int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
 	struct inode *inode = d_inode(dentry);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	bool need_unlock = false;
@@ -119,8 +120,8 @@ int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ret)
 		return ret;
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gl)) {
+		ret = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret)
 			goto out;
 		need_unlock = true;
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 0a7b8076af3a..ee11d494e47c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -102,7 +102,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 		struct writeback_control *wbc)
 {
 	struct inode *inode = folio->mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 
 	if (folio_test_checked(folio)) {
 		folio_clear_checked(folio);
@@ -111,7 +111,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 					inode->i_sb->s_blocksize,
 					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
-		gfs2_trans_add_databufs(ip->i_gl, folio, 0, folio_size(folio));
+		gfs2_trans_add_databufs(gl, folio, 0, folio_size(folio));
 	}
 	return gfs2_write_jdata_folio(folio, wbc);
 }
@@ -126,13 +126,13 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(mapping->host);
 	struct folio *folio = NULL;
 	int error;
 
 	BUG_ON(current->journal_info);
-	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+	if (gfs2_assert_withdraw(sdp, gl->gl_state == LM_ST_EXCLUSIVE))
 		return 0;
 
 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
@@ -362,14 +362,14 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 static int gfs2_jdata_writepages(struct address_space *mapping,
 				 struct writeback_control *wbc)
 {
-	struct gfs2_inode *ip = GFS2_I(mapping->host);
+	struct gfs2_glock *gl = gfs2_inode_glock(mapping->host);
 	struct gfs2_sbd *sdp = GFS2_SB(mapping->host);
 	int ret;
 
 	ret = gfs2_write_cache_jdata(mapping, wbc);
 	if (ret == 0 && wbc->sync_mode == WB_SYNC_ALL) {
-		gfs2_log_flush(sdp, ip->i_gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
-			       GFS2_LFC_JDATA_WPAGES);
+		gfs2_log_flush(sdp, gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
+					GFS2_LFC_JDATA_WPAGES);
 		ret = gfs2_write_cache_jdata(mapping, wbc);
 	}
 	return ret;
@@ -561,12 +561,13 @@ static bool gfs2_jdata_dirty_folio(struct address_space *mapping,
 
 static sector_t gfs2_bmap(struct address_space *mapping, sector_t lblock)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(mapping->host);
 	struct gfs2_inode *ip = GFS2_I(mapping->host);
 	struct gfs2_holder i_gh;
 	sector_t dblock = 0;
 	int error;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 	if (error)
 		return 0;
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 636139f463b0..b5ddd936f489 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -55,6 +55,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 			       u64 block, struct folio *folio)
 {
 	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 
 	if (!folio_test_uptodate(folio)) {
 		void *kaddr = kmap_local_folio(folio, 0);
@@ -78,7 +79,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 			map_bh(bh, inode->i_sb, block);
 
 		set_buffer_uptodate(bh);
-		gfs2_trans_add_data(ip->i_gl, bh);
+		gfs2_trans_add_data(gl, bh);
 	} else {
 		folio_mark_dirty(folio);
 		gfs2_ordered_add_inode(ip);
@@ -90,6 +91,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 {
 	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct buffer_head *bh, *dibh;
 	struct gfs2_dinode *di;
 	u64 block = 0;
@@ -125,7 +127,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 
 	/*  Set up the pointer to the new block  */
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
@@ -663,6 +665,7 @@ enum alloc_state {
 static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 			      struct metapath *mp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *dibh = metapath_dibh(mp);
@@ -679,7 +682,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 	BUG_ON(dibh == NULL);
 	BUG_ON(dblks < 1);
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 
 	down_write(&ip->i_rw_mutex);
 
@@ -723,7 +726,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 			}
 			for (; i - 1 < mp->mp_fheight - ip->i_height && n > 0;
 			     i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i, 0, bn++);
+				gfs2_indirect_init(mp, gl, i, 0, bn++);
 			if (i - 1 == mp->mp_fheight - ip->i_height) {
 				i--;
 				gfs2_buffer_copy_tail(mp->mp_bh[i],
@@ -749,9 +752,9 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 			fallthrough;	/* To branching from existing tree */
 		case ALLOC_GROW_DEPTH:
 			if (i > 1 && i < mp->mp_fheight)
-				gfs2_trans_add_meta(ip->i_gl, mp->mp_bh[i-1]);
+				gfs2_trans_add_meta(gl, mp->mp_bh[i-1]);
 			for (; i < mp->mp_fheight && n > 0; i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i,
+				gfs2_indirect_init(mp, gl, i,
 						   mp->mp_list[i-1], bn++);
 			if (i == mp->mp_fheight)
 				state = ALLOC_DATA;
@@ -761,7 +764,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 		case ALLOC_DATA:
 			BUG_ON(n > dblks);
 			BUG_ON(mp->mp_bh[end_of_metadata] == NULL);
-			gfs2_trans_add_meta(ip->i_gl, mp->mp_bh[end_of_metadata]);
+			gfs2_trans_add_meta(gl, mp->mp_bh[end_of_metadata]);
 			dblks = n;
 			ptr = metapointer(end_of_metadata, mp);
 			iomap->addr = bn << inode->i_blkbits;
@@ -990,12 +993,12 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 				 unsigned copied, struct folio *folio)
 {
 	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
 	if (gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
-		gfs2_trans_add_databufs(ip->i_gl, folio,
-					offset_in_folio(folio, pos),
+		gfs2_trans_add_databufs(gl, folio, offset_in_folio(folio, pos),
 					copied);
 
 	folio_unlock(folio);
@@ -1151,6 +1154,7 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
@@ -1197,7 +1201,7 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
 		mark_inode_dirty(inode);
-	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
+	set_bit(GLF_DIRTY, &gl->gl_flags);
 	return 0;
 }
 
@@ -1388,6 +1392,7 @@ static int gfs2_journaled_truncate(struct inode *inode, u64 oldsize, u64 newsize
 
 static int trunc_start(struct inode *inode, u64 newsize)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *dibh = NULL;
@@ -1416,7 +1421,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 	if (error)
 		goto out;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 
 	if (gfs2_is_stuffed(ip))
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + newsize);
@@ -1490,6 +1495,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			      bool meta, u32 *btotal)
 {
 	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_rgrpd *rgd;
 	struct gfs2_trans *tr;
@@ -1589,7 +1595,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			goto out_unlock;
 		}
 
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gl, bh);
 		buf_in_tr = true;
 		*p = 0;
 		if (bstart + blen == bn) {
@@ -1623,7 +1629,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			/* Every transaction boundary, we rewrite the dinode
 			   to keep its di_blocks current in case of failure. */
 			inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
 			up_write(&ip->i_rw_mutex);
@@ -1749,6 +1755,7 @@ static inline bool walk_done(struct gfs2_sbd *sdp,
 static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 {
 	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	u64 maxsize = sdp->sd_heightsize[ip->i_height];
 	struct metapath mp = {};
@@ -1836,7 +1843,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	for (mp_h = 0; mp_h < mp.mp_aheight - 1; mp_h++) {
 		metapointer_range(&mp, mp_h, start_list, start_aligned,
 				  end_list, end_aligned, &start, &end);
-		gfs2_metapath_ra(ip->i_gl, start, end);
+		gfs2_metapath_ra(gl, start, end);
 	}
 
 	if (mp.mp_aheight == ip->i_height)
@@ -1956,7 +1963,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 							  start_list, start_aligned,
 							  end_list, end_aligned,
 							  &start, &end);
-					gfs2_metapath_ra(ip->i_gl, start, end);
+					gfs2_metapath_ra(gl, start, end);
 				}
 			}
 
@@ -1990,7 +1997,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 		gfs2_statfs_change(sdp, 0, +btotal, 0);
 		gfs2_quota_change(ip, -(s64)btotal, inode->i_uid, inode->i_gid);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		gfs2_trans_add_meta(ip->i_gl, dibh);
+		gfs2_trans_add_meta(gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		up_write(&ip->i_rw_mutex);
 		gfs2_trans_end(sdp);
@@ -2013,6 +2020,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 static int trunc_end(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *dibh;
 	int error;
@@ -2036,7 +2044,7 @@ static int trunc_end(struct gfs2_inode *ip)
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ip->i_diskflags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -2097,6 +2105,7 @@ static int do_shrink(struct inode *inode, u64 newsize)
 
 static int do_grow(struct inode *inode, u64 size)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = { .target = 1, };
@@ -2141,7 +2150,7 @@ static int do_grow(struct inode *inode, u64 size)
 
 	truncate_setsize(inode, size);
 	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -2380,6 +2389,7 @@ int gfs2_write_alloc_required(struct gfs2_inode *ip, u64 offset,
 
 static int stuffed_zero_range(struct inode *inode, loff_t offset, loff_t length)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct buffer_head *dibh;
 	int error;
@@ -2392,7 +2402,7 @@ static int stuffed_zero_range(struct inode *inode, loff_t offset, loff_t length)
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (error)
 		return error;
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	memset(dibh->b_data + sizeof(struct gfs2_dinode) + offset, 0,
 	       length);
 	brelse(dibh);
diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 95050e719233..7b344461658e 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -35,8 +35,8 @@
 static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 			    struct dentry *dentry, unsigned int flags)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(dir);
 	struct gfs2_sbd *sdp = GFS2_SB(dir);
-	struct gfs2_inode *dip = GFS2_I(dir);
 	struct inode *inode;
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip = NULL;
@@ -57,9 +57,9 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
 		return 1;
 
-	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
+	had_lock = (gfs2_glock_is_locked_by_me(gl) != NULL);
 	if (!had_lock) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &d_gh);
 		if (error)
 			return 0;
 	}
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index f6111276ebb0..6cfe335fd590 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -90,10 +90,11 @@ typedef int (*gfs2_dscan_t)(const struct gfs2_dirent *dent,
 int gfs2_dir_get_new_buffer(struct gfs2_inode *ip, u64 block,
 			    struct buffer_head **bhp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct buffer_head *bh;
 
-	bh = gfs2_meta_new(ip->i_gl, block);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	bh = gfs2_meta_new(gl, block);
+	gfs2_trans_add_meta(gl, bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_JD, GFS2_FORMAT_JD);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
 	*bhp = bh;
@@ -103,10 +104,11 @@ int gfs2_dir_get_new_buffer(struct gfs2_inode *ip, u64 block,
 static int gfs2_dir_get_existing_buffer(struct gfs2_inode *ip, u64 block,
 					struct buffer_head **bhp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct buffer_head *bh;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, block, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(gl, block, DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
 	if (gfs2_metatype_check(GFS2_SB(&ip->i_inode), bh, GFS2_METATYPE_JD)) {
@@ -120,6 +122,7 @@ static int gfs2_dir_get_existing_buffer(struct gfs2_inode *ip, u64 block,
 static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 				  unsigned int offset, unsigned int size)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct buffer_head *dibh;
 	int error;
 
@@ -127,7 +130,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	memcpy(dibh->b_data + offset + sizeof(struct gfs2_dinode), buf, size);
 	if (ip->i_inode.i_size < offset + size)
 		i_size_write(&ip->i_inode, offset + size);
@@ -153,6 +156,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 			       u64 offset, unsigned int size)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *dibh;
 	u64 lblock, dblock;
@@ -208,7 +212,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 		if (error)
 			goto fail;
 
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gl, bh);
 		memcpy(bh->b_data + o, buf, amount);
 		brelse(bh);
 
@@ -230,7 +234,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 		i_size_write(&ip->i_inode, offset + copied);
 	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -268,6 +272,7 @@ static int gfs2_dir_read_stuffed(struct gfs2_inode *ip, __be64 *buf,
 static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 			      unsigned int size)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	u64 lblock, dblock;
 	u32 extlen = 0;
@@ -299,9 +304,9 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 			if (error || !dblock)
 				goto fail;
 			BUG_ON(extlen < 1);
-			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+			bh = gfs2_meta_ra(gl, dblock, extlen);
 		} else {
-			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
+			error = gfs2_meta_read(gl, dblock, DIO_WAIT, 0, &bh);
 			if (error)
 				goto fail;
 		}
@@ -672,6 +677,7 @@ static int dirent_next(struct gfs2_inode *dip, struct buffer_head *bh,
 static void dirent_del(struct gfs2_inode *dip, struct buffer_head *bh,
 		       struct gfs2_dirent *prev, struct gfs2_dirent *cur)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&dip->i_inode);
 	u16 cur_rec_len, prev_rec_len;
 
 	if (gfs2_dirent_sentinel(cur)) {
@@ -679,7 +685,7 @@ static void dirent_del(struct gfs2_inode *dip, struct buffer_head *bh,
 		return;
 	}
 
-	gfs2_trans_add_meta(dip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 
 	/* If there is no prev entry, this is the first entry in the block.
 	   The de_rec_len is already as big as it needs to be.  Just zero
@@ -712,13 +718,13 @@ static struct gfs2_dirent *do_init_dirent(struct inode *inode,
 					  struct buffer_head *bh,
 					  unsigned offset)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_dirent *ndent;
 	unsigned totlen;
 
 	totlen = be16_to_cpu(dent->de_rec_len);
 	BUG_ON(offset + name->len > totlen);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 	ndent = (struct gfs2_dirent *)((char *)dent + offset);
 	dent->de_rec_len = cpu_to_be16(offset);
 	gfs2_qstr2dirent(name, totlen - offset, ndent);
@@ -760,10 +766,11 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 		    struct buffer_head **bhp)
 {
 	struct inode *inode = &dip->i_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
 
-	error = gfs2_meta_read(dip->i_gl, leaf_no, DIO_WAIT, 0, bhp);
+	error = gfs2_meta_read(gl, leaf_no, DIO_WAIT, 0, bhp);
 	if (!error && gfs2_metatype_check(sdp, *bhp, GFS2_METATYPE_LF)) {
 		/* pr_info("block num=%llu\n", leaf_no); */
 		error = -EIO;
@@ -865,6 +872,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 
 static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh, u16 depth)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	unsigned int n = 1;
 	u64 bn;
@@ -877,12 +885,12 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 	error = gfs2_alloc_blocks(ip, &bn, &n, 0);
 	if (error)
 		return NULL;
-	bh = gfs2_meta_new(ip->i_gl, bn);
+	bh = gfs2_meta_new(gl, bn);
 	if (!bh)
 		return NULL;
 
 	gfs2_trans_remove_revoke(GFS2_SB(inode), bn, 1);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_LF, GFS2_FORMAT_LF);
 	leaf = (struct gfs2_leaf *)bh->b_data;
 	leaf->lf_depth = cpu_to_be16(depth);
@@ -909,6 +917,7 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 
 static int dir_make_exhash(struct inode *inode)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *dip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_dirent *dent;
@@ -970,7 +979,7 @@ static int dir_make_exhash(struct inode *inode)
 	/*  We're done with the new leaf block, now setup the new
 	    hash table.  */
 
-	gfs2_trans_add_meta(dip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
 	lp = (__be64 *)(dibh->b_data + sizeof(struct gfs2_dinode));
@@ -1000,6 +1009,7 @@ static int dir_make_exhash(struct inode *inode)
 
 static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *dip = GFS2_I(inode);
 	struct buffer_head *nbh, *obh, *dibh;
 	struct gfs2_leaf *nleaf, *oleaf;
@@ -1027,7 +1037,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 		return 1; /* can't split */
 	}
 
-	gfs2_trans_add_meta(dip->i_gl, obh);
+	gfs2_trans_add_meta(gl, obh);
 
 	nleaf = new_leaf(inode, &nbh, be16_to_cpu(oleaf->lf_depth) + 1);
 	if (!nleaf) {
@@ -1120,7 +1130,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 
 	error = gfs2_meta_inode_buffer(dip, &dibh);
 	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
-		gfs2_trans_add_meta(dip->i_gl, dibh);
+		gfs2_trans_add_meta(gl, dibh);
 		gfs2_add_inode_blocks(&dip->i_inode, 1);
 		gfs2_dinode_out(dip, dibh->b_data);
 		brelse(dibh);
@@ -1482,8 +1492,8 @@ static int gfs2_dir_read_leaf(struct inode *inode, struct dir_context *ctx,
 static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 			       struct file_ra_state *f_ra)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
 	struct buffer_head *bh;
 	u64 blocknr = 0, last;
 	unsigned count;
@@ -1724,6 +1734,7 @@ int gfs2_dir_check(struct inode *dir, const struct qstr *name,
 static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 {
 	struct buffer_head *bh, *obh;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_leaf *leaf, *oleaf;
 	u32 dist = 1;
@@ -1747,7 +1758,7 @@ static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 			return error;
 	} while(1);
 
-	gfs2_trans_add_meta(ip->i_gl, obh);
+	gfs2_trans_add_meta(gl, obh);
 
 	leaf = new_leaf(inode, &bh, be16_to_cpu(oleaf->lf_depth));
 	if (!leaf) {
@@ -1762,7 +1773,7 @@ static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 	error = gfs2_meta_inode_buffer(ip, &bh);
 	if (error)
 		return error;
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 	gfs2_add_inode_blocks(&ip->i_inode, 1);
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
@@ -1937,6 +1948,7 @@ int gfs2_dir_del(struct gfs2_inode *dip, const struct dentry *dentry)
 int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 		   const struct gfs2_inode *nip, unsigned int new_type)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&dip->i_inode);
 	struct buffer_head *bh;
 	struct gfs2_dirent *dent;
 
@@ -1948,7 +1960,7 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 
-	gfs2_trans_add_meta(dip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 	gfs2_inum_out(nip, dent);
 	dent->de_type = cpu_to_be16(new_type);
 	brelse(bh);
@@ -1974,6 +1986,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
 			u64 leaf_no, struct buffer_head *leaf_bh,
 			int last_dealloc)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&dip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	struct gfs2_leaf *tmp_leaf;
 	struct gfs2_rgrp_list rlist;
@@ -2068,7 +2081,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
 	if (error)
 		goto out_end_trans;
 
-	gfs2_trans_add_meta(dip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 	/* On the last dealloc, make this a regular file in case we crash.
 	   (We don't want to free these blocks a second time.)  */
 	if (last_dealloc)
diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9c..970bf2d72388 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -87,7 +87,8 @@ static int gfs2_get_name(struct dentry *parent, char *name,
 {
 	struct inode *dir = d_inode(parent);
 	struct inode *inode = d_inode(child);
-	struct gfs2_inode *dip, *ip;
+	struct gfs2_glock *gl;
+	struct gfs2_inode *ip;
 	struct get_name_filldir gnfd = {
 		.ctx.actor = get_name_filldir,
 		.name = name
@@ -102,14 +103,14 @@ static int gfs2_get_name(struct dentry *parent, char *name,
 	if (!S_ISDIR(dir->i_mode) || !inode)
 		return -EINVAL;
 
-	dip = GFS2_I(dir);
+	gl = gfs2_inode_glock(dir);
 	ip = GFS2_I(inode);
 
 	*name = 0;
 	gnfd.inum.no_addr = ip->i_no_addr;
 	gnfd.inum.no_formal_ino = ip->i_no_formal_ino;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 	if (error)
 		return error;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 164e160e9064..6fb2adeef274 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -57,13 +57,13 @@
 
 static loff_t gfs2_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
+	struct gfs2_glock *gl = gfs2_inode_glock(file->f_mapping->host);
 	struct gfs2_holder i_gh;
 	loff_t error;
 
 	switch (whence) {
 	case SEEK_END:
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (!error) {
 			error = generic_file_llseek(file, offset, whence);
@@ -105,11 +105,11 @@ static loff_t gfs2_llseek(struct file *file, loff_t offset, int whence)
 static int gfs2_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *dir = file->f_mapping->host;
-	struct gfs2_inode *dip = GFS2_I(dir);
+	struct gfs2_glock *gl = gfs2_inode_glock(dir);
 	struct gfs2_holder d_gh;
 	int error;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &d_gh);
 	if (error)
 		return error;
 
@@ -158,6 +158,7 @@ static inline u32 gfs2_gfsflags_to_fsflags(struct inode *inode, u32 gfsflags)
 int gfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int error;
@@ -166,7 +167,7 @@ int gfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(gl, LM_ST_SHARED, 0, &gh);
 	error = gfs2_glock_nq(&gh);
 	if (error)
 		goto out_uninit;
@@ -218,6 +219,7 @@ void gfs2_set_inode_flags(struct inode *inode)
  */
 static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *bh;
@@ -225,7 +227,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	int error;
 	u32 new_flags, flags;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 	if (error)
 		return error;
 
@@ -242,7 +244,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	}
 	if ((flags ^ new_flags) & GFS2_DIF_JDATA) {
 		if (new_flags & GFS2_DIF_JDATA)
-			gfs2_log_flush(sdp, ip->i_gl,
+			gfs2_log_flush(sdp, gl,
 				       GFS2_LOG_HEAD_FLUSH_NORMAL |
 				       GFS2_LFC_SET_FLAGS);
 		error = filemap_fdatawrite(inode->i_mapping);
@@ -262,7 +264,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	if (error)
 		goto out_trans_end;
 	inode_set_ctime_current(inode);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 	ip->i_diskflags = new_flags;
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
@@ -417,6 +419,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = {};
@@ -430,7 +433,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	sb_start_pagefault(inode->i_sb);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
 		ret = vmf_fs_error(err);
@@ -455,7 +458,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	gfs2_size_hint(vmf->vma->vm_file, pos, length);
 
-	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
+	set_bit(GLF_DIRTY, &gl->gl_flags);
 	set_bit(GIF_SW_PAGED, &ip->i_flags);
 
 	/*
@@ -552,12 +555,12 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	vm_fault_t ret;
 	int err;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
 		ret = vmf_fs_error(err);
@@ -590,6 +593,7 @@ static const struct vm_operations_struct gfs2_vm_ops = {
 
 static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(file->f_mapping->host);
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 
 	if (!(file->f_flags & O_NOATIME) &&
@@ -597,7 +601,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
 		struct gfs2_holder i_gh;
 		int error;
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (error)
 			return error;
@@ -674,13 +678,14 @@ int gfs2_open_common(struct inode *inode, struct file *file)
 
 static int gfs2_open(struct inode *inode, struct file *file)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder i_gh;
 	int error;
 	bool need_unlock = false;
 
 	if (S_ISREG(ip->i_inode.i_mode)) {
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (error)
 			return error;
@@ -745,6 +750,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	int sync_state = inode_state_read_once(inode) & I_DIRTY;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	int ret = 0, ret1 = 0;
 
@@ -767,7 +773,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 			ret = file_write_and_wait(file);
 		if (ret)
 			return ret;
-		gfs2_ail_flush(ip->i_gl, 1);
+		gfs2_ail_flush(gl, 1);
 	}
 
 	if (mapping->nrpages)
@@ -813,7 +819,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	size_t prev_count = 0, window_size = 0;
 	size_t read = 0;
 	ssize_t ret;
@@ -838,7 +844,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(gl, LM_ST_DEFERRED, 0, gh);
 retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
@@ -877,7 +883,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	size_t prev_count = 0, window_size = 0;
 	size_t written = 0;
 	bool enough_retries;
@@ -901,7 +907,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * unfortunately, have the option of only flushing a range like the
 	 * VFS does.
 	 */
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(gl, LM_ST_DEFERRED, 0, gh);
 retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
@@ -949,7 +955,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct gfs2_inode *ip;
+	struct gfs2_glock *gl;
 	struct gfs2_holder gh;
 	size_t prev_count = 0, window_size = 0;
 	size_t read = 0;
@@ -980,8 +986,8 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return ret;
 	}
-	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gl = gfs2_inode_glock(iocb->ki_filp->f_mapping->host);
+	gfs2_holder_init(gl, LM_ST_SHARED, 0, &gh);
 retry:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
@@ -1014,7 +1020,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *statfs_gh = NULL;
 	size_t prev_count = 0, window_size = 0;
@@ -1035,7 +1041,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, gh);
+	gfs2_holder_init(gl, LM_ST_EXCLUSIVE, 0, gh);
 	if (should_fault_in_pages(from, iocb, &prev_count, &window_size)) {
 retry:
 		window_size -= fault_in_iov_iter_readable(from, window_size);
@@ -1050,9 +1056,9 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 		goto out_uninit;
 
 	if (inode == sdp->sd_rindex) {
-		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
+		struct gfs2_glock *m_gl = gfs2_inode_glock(sdp->sd_statfs_inode);
 
-		ret = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE,
+		ret = gfs2_glock_nq_init(m_gl, LM_ST_EXCLUSIVE,
 					 GL_NOCACHE, statfs_gh);
 		if (ret)
 			goto out_unlock;
@@ -1106,14 +1112,15 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	ssize_t ret;
 
 	gfs2_size_hint(file, iocb->ki_pos, iov_iter_count(from));
 
 	if (iocb->ki_flags & IOCB_APPEND) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+		struct gfs2_glock *gl = gfs2_inode_glock(inode);
+
+		ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 		if (ret)
 			return ret;
 		gfs2_glock_dq_uninit(&gh);
@@ -1181,6 +1188,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	loff_t end = offset + len;
 	struct buffer_head *dibh;
@@ -1190,7 +1198,7 @@ static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len)
 	if (unlikely(error))
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gl, dibh);
 
 	if (gfs2_is_stuffed(ip)) {
 		error = gfs2_unstuff_dinode(ip);
@@ -1379,6 +1387,7 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 {
 	struct inode *inode = file_inode(file);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
@@ -1391,7 +1400,7 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	inode_lock(inode);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d59ea71a84db..d0612014408e 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -891,7 +891,9 @@ static void gfs2_try_to_evict(struct gfs2_glock *gl)
 		/* If the inode was evicted, gl->gl_object will now be NULL. */
 		ip = gfs2_grab_existing_inode(gl);
 		if (ip) {
-			gfs2_glock_poke(ip->i_gl);
+			struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
+
+			gfs2_glock_poke(gl);
 			iput(&ip->i_inode);
 		}
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..662d033fd2ca 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -602,8 +602,7 @@ static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = glock_sbd(gl);
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-	struct gfs2_glock *j_gl = ip->i_gl;
+	struct gfs2_glock *j_gl = gfs2_inode_glock(sdp->sd_jdesc->jd_inode);
 	struct gfs2_log_header_host head;
 	int error;
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index dadb4d3c9d3d..3ae8e2be486c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -879,5 +879,8 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 	return GFS2_SB(&ip->i_inode)->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 }
 
+static inline struct gfs2_glock *gfs2_inode_glock(struct inode *inode)
+{
+       return GFS2_I(inode)->i_gl;
+}
 #endif /* __INCORE_DOT_H__ */
-
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 438519bc06d4..5aaed0018fb3 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -324,8 +324,8 @@ struct inode *gfs2_lookup_meta(struct inode *dip, const char *name)
 struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 			   int is_root)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(dir);
 	struct super_block *sb = dir->i_sb;
-	struct gfs2_inode *dip = GFS2_I(dir);
 	struct gfs2_holder d_gh;
 	int error = 0;
 	struct inode *inode = NULL;
@@ -341,8 +341,8 @@ struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 		return dir;
 	}
 
-	if (gfs2_glock_is_locked_by_me(dip->i_gl) == NULL) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &d_gh);
 		if (error)
 			return ERR_PTR(error);
 	}
@@ -458,7 +458,7 @@ static int alloc_dinode(struct gfs2_inode *ip, u32 flags, unsigned *dblocks)
 static void gfs2_final_release_pages(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 
 	/* This can only happen during incomplete inode creation. */
 	if (unlikely(!gl))
@@ -548,12 +548,13 @@ static void gfs2_init_dir(struct buffer_head *dibh,
 
 static void gfs2_init_xattr(struct gfs2_inode *ip)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *bh;
 	struct gfs2_ea_header *ea;
 
-	bh = gfs2_meta_new(ip->i_gl, ip->i_eattr);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	bh = gfs2_meta_new(gl, ip->i_eattr);
+	gfs2_trans_add_meta(gl, bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
 
@@ -576,11 +577,12 @@ static void gfs2_init_xattr(struct gfs2_inode *ip)
 static void init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
 			const char *symname)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_dinode *di;
 	struct buffer_head *dibh;
 
-	dibh = gfs2_meta_new(ip->i_gl, ip->i_no_addr);
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	dibh = gfs2_meta_new(gl, ip->i_no_addr);
+	gfs2_trans_add_meta(gl, dibh);
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_dinode_out(ip, di);
 
@@ -728,7 +730,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(dir), LM_ST_EXCLUSIVE, 0,
+				   &d_gh);
 	if (error)
 		goto fail;
 	gfs2_holder_mark_uninitialized(&gh);
@@ -999,7 +1002,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	if (inode == NULL || IS_ERR(inode))
 		return d_splice_alias(inode, dentry);
 
-	gl = GFS2_I(inode)->i_gl;
+	gl = gfs2_inode_glock(inode);
 	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
 	if (error) {
 		iput(inode);
@@ -1059,8 +1062,8 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		return error;
 
-	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(dir), LM_ST_EXCLUSIVE, 0, &d_gh);
+	gfs2_holder_init(gfs2_inode_glock(inode), LM_ST_EXCLUSIVE, 0, &gh);
 
 	error = gfs2_glock_nq(&d_gh);
 	if (error)
@@ -1133,7 +1136,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		goto out_brelse;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(inode), dibh);
 	inc_nlink(&ip->i_inode);
 	inode_set_ctime_current(&ip->i_inode);
 	ihold(inode);
@@ -1259,8 +1262,8 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
 
 	error = -EROFS;
 
-	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
-	gfs2_holder_init(ip->i_gl,  LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(dir), LM_ST_EXCLUSIVE, 0, &d_gh);
+	gfs2_holder_init(gfs2_inode_glock(inode),  LM_ST_EXCLUSIVE, 0, &gh);
 
 	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
 	if (!rgd)
@@ -1534,18 +1537,19 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 	}
 
 	num_gh = 1;
-	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
+	gfs2_holder_init(gfs2_inode_glock(odir), LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
 	if (odip != ndip) {
-		gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE,GL_ASYNC,
+		gfs2_holder_init(gfs2_inode_glock(ndir), LM_ST_EXCLUSIVE,GL_ASYNC,
 				 ghs + num_gh);
 		num_gh++;
 	}
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(&ip->i_inode), LM_ST_EXCLUSIVE,
+			 GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
 	if (nip) {
-		gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC,
-				 ghs + num_gh);
+		gfs2_holder_init(gfs2_inode_glock(&nip->i_inode),
+				 LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
 		num_gh++;
 	}
 
@@ -1780,16 +1784,19 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 	}
 
 	num_gh = 1;
-	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
+	gfs2_holder_init(gfs2_inode_glock(odir), LM_ST_EXCLUSIVE, GL_ASYNC,
+			 ghs);
 	if (odip != ndip) {
-		gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC,
-				 ghs + num_gh);
+		gfs2_holder_init(gfs2_inode_glock(ndir), LM_ST_EXCLUSIVE,
+				 GL_ASYNC, ghs + num_gh);
 		num_gh++;
 	}
-	gfs2_holder_init(oip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(&oip->i_inode), LM_ST_EXCLUSIVE,
+			 GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
-	gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(&nip->i_inode), LM_ST_EXCLUSIVE,
+			 GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
 again:
@@ -1910,6 +1917,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 				 struct inode *inode,
 				 struct delayed_call *done)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder i_gh;
 	struct buffer_head *dibh;
@@ -1920,7 +1928,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+	gfs2_holder_init(gl, LM_ST_SHARED, 0, &i_gh);
 	error = gfs2_glock_nq(&i_gh);
 	if (error) {
 		gfs2_holder_uninit(&i_gh);
@@ -2102,6 +2110,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder i_gh;
 	int error;
@@ -2110,7 +2119,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out;
 
@@ -2164,14 +2173,15 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	u32 gfsflags;
 	int error;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
 		if (error)
 			return error;
 	}
@@ -2207,14 +2217,14 @@ static bool fault_in_fiemap(struct fiemap_extent_info *fi)
 static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	int ret;
 
 	inode_lock_shared(inode);
 
 retry:
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 	if (ret)
 		goto out;
 
@@ -2237,12 +2247,12 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 loff_t gfs2_seek_data(struct file *file, loff_t offset)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	loff_t ret;
 
 	inode_lock_shared(inode);
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 	if (!ret)
 		ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
@@ -2256,12 +2266,12 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	loff_t ret;
 
 	inode_lock_shared(inode);
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
 	if (!ret)
 		ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
@@ -2275,8 +2285,7 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 static int gfs2_update_time(struct inode *inode, enum fs_update_time type,
 		unsigned int flags)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder *gh;
 	int error;
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790..77ef22eab368 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -775,9 +775,8 @@ static int buf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 				struct gfs2_log_descriptor *ld, __be64 *ptr,
 				int pass)
 {
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct gfs2_glock *gl = ip->i_gl;
 	unsigned int blks = be32_to_cpu(ld->ld_data1);
 	struct buffer_head *bh_log, *bh_ip;
 	u64 blkno;
@@ -828,17 +827,17 @@ static int buf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 
 static void buf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 {
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
 	if (error) {
-		gfs2_inode_metasync(ip->i_gl);
+		gfs2_inode_metasync(gl);
 		return;
 	}
 	if (pass != 1)
 		return;
 
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gl);
 
 	fs_info(sdp, "jid=%u: Replayed %u of %u blocks\n",
 	        jd->jd_jid, jd->jd_replayed_blocks, jd->jd_found_blocks);
@@ -1000,8 +999,7 @@ static int databuf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 				    struct gfs2_log_descriptor *ld,
 				    __be64 *ptr, int pass)
 {
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 	unsigned int blks = be32_to_cpu(ld->ld_data1);
 	struct buffer_head *bh_log, *bh_ip;
 	u64 blkno;
@@ -1048,18 +1046,18 @@ static int databuf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 
 static void databuf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 {
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
 	if (error) {
-		gfs2_inode_metasync(ip->i_gl);
+		gfs2_inode_metasync(gl);
 		return;
 	}
 	if (pass != 1)
 		return;
 
 	/* data sync? */
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gl);
 
 	fs_info(sdp, "jid=%u: Replayed %u of %u data blocks\n",
 		jd->jd_jid, jd->jd_replayed_blocks, jd->jd_found_blocks);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index a87cfbf0df38..63591a4be10a 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -402,18 +402,19 @@ static struct buffer_head *gfs2_getjdatabuf(struct gfs2_inode *ip, u64 blkno)
 
 void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *bh;
 	int ty;
 
 	/* This can only happen during incomplete inode creation. */
-	if (!ip->i_gl)
+	if (!gl)
 		return;
 
 	gfs2_ail1_wipe(sdp, bstart, blen);
 	while (blen) {
 		ty = REMOVE_META;
-		bh = gfs2_getbuf(ip->i_gl, bstart, NO_CREATE);
+		bh = gfs2_getbuf(gl, bstart, NO_CREATE);
 		if (!bh && gfs2_is_jdata(ip)) {
 			bh = gfs2_getjdatabuf(ip, bstart);
 			ty = REMOVE_JDATA;
@@ -447,8 +448,8 @@ void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 		     struct buffer_head **bhp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct gfs2_glock *gl = ip->i_gl;
 	struct buffer_head *bh;
 	int ret = 0;
 	int rahead = 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..188b3e67f2d1 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -534,7 +534,7 @@ static void gfs2_others_may_mount(struct gfs2_sbd *sdp)
 
 static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 {
-	struct gfs2_inode *dip = GFS2_I(sdp->sd_jindex);
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_jindex);
 	struct qstr name;
 	char buf[20];
 	struct gfs2_jdesc *jd;
@@ -545,7 +545,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 	mutex_lock(&sdp->sd_jindex_mutex);
 
 	for (;;) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, ji_gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, ji_gh);
 		if (error)
 			break;
 
@@ -611,7 +611,6 @@ static int init_statfs(struct gfs2_sbd *sdp)
 	struct inode *pn = NULL;
 	char buf[30];
 	struct gfs2_jdesc *jd;
-	struct gfs2_inode *ip;
 
 	sdp->sd_statfs_inode = gfs2_lookup_meta(master, "statfs");
 	if (IS_ERR(sdp->sd_statfs_inode)) {
@@ -656,15 +655,15 @@ static int init_statfs(struct gfs2_sbd *sdp)
 
 	iput(pn);
 	pn = NULL;
-	ip = GFS2_I(sdp->sd_sc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
-				   &sdp->sd_sc_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(sdp->sd_sc_inode),
+				   LM_ST_EXCLUSIVE, GL_NOPID, &sdp->sd_sc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
 		goto free_local;
 	}
 	/* read in the local statfs buffer - other nodes don't change it. */
-	error = gfs2_meta_inode_buffer(ip, &sdp->sd_sc_bh);
+	error = gfs2_meta_inode_buffer(GFS2_I(sdp->sd_sc_inode),
+				       &sdp->sd_sc_bh);
 	if (error) {
 		fs_err(sdp, "Cannot read in local statfs: %d\n", error);
 		goto unlock_sd_gh;
@@ -697,7 +696,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 {
 	struct inode *master = d_inode(sdp->sd_master_dir);
 	struct gfs2_holder ji_gh;
-	struct gfs2_inode *ip;
+	struct gfs2_glock *gl;
 	int error = 0;
 
 	gfs2_holder_mark_uninitialized(&ji_gh);
@@ -751,8 +750,8 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 			goto fail_jindex;
 		}
 
-		ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+		gl = gfs2_inode_glock(sdp->sd_jdesc->jd_inode);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED,
 					   LM_FLAG_RECOVER | GL_EXACT |
 					   GL_NOCACHE | GL_NOPID,
 					   &sdp->sd_jinode_gh);
@@ -893,7 +892,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	struct inode *pn = NULL;
 	char buf[30];
 	int error = 0;
-	struct gfs2_inode *ip;
+	struct gfs2_glock *gl;
 	struct inode *master = d_inode(sdp->sd_master_dir);
 
 	if (sdp->sd_args.ar_spectator)
@@ -920,8 +919,8 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	iput(pn);
 	pn = NULL;
 
-	ip = GFS2_I(sdp->sd_qc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
+	gl = gfs2_inode_glock(sdp->sd_qc_inode);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, GL_NOPID,
 				   &sdp->sd_qc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"qc\" file: %d\n", error);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 0cb2bb0aec7b..b62431724eea 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -408,7 +408,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 	struct inode *inode = sdp->sd_qc_inode;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	unsigned int block, offset;
 	struct buffer_head *bh = NULL;
 	struct iomap iomap = { };
@@ -434,7 +434,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 	if (iomap.type != IOMAP_MAPPED)
 		return error;
 
-	error = gfs2_meta_read(ip->i_gl, iomap.addr >> inode->i_blkbits,
+	error = gfs2_meta_read(gl, iomap.addr >> inode->i_blkbits,
 			       DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
@@ -687,12 +687,12 @@ static int sort_qd(const void *a, const void *b)
 static void do_qc(struct gfs2_quota_data *qd, s64 change)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_qc_inode);
 	struct gfs2_quota_change *qc = qd->qd_bh_qc;
 	bool needs_put = false;
 	s64 x;
 
-	gfs2_trans_add_meta(ip->i_gl, qd->qd_bh);
+	gfs2_trans_add_meta(gl, qd->qd_bh);
 
 	/*
 	 * The QDF_CHANGE flag indicates that the slot in the quota change file
@@ -741,7 +741,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 				  unsigned off, void *buf, unsigned bytes)
 {
 	struct inode *inode = sdp->sd_quota_inode;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
@@ -780,7 +780,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 			set_buffer_uptodate(bh);
 		if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
 			goto unlock_out;
-		gfs2_trans_add_data(ip->i_gl, bh);
+		gfs2_trans_add_data(gl, bh);
 
 		/* If we need to write to the next block as well */
 		if (to_write > (bsize - boff)) {
@@ -909,6 +909,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 {
 	struct gfs2_sbd *sdp = (*qda)->qd_sbd;
 	struct inode *inode = sdp->sd_quota_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_alloc_parms ap = {};
 	unsigned int data_blocks, ind_blocks;
@@ -936,7 +937,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 			goto out_dq;
 	}
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out_dq;
 
@@ -994,8 +995,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		gfs2_glock_dq_uninit(&ghs[qx]);
 	inode_unlock(inode);
 	kfree(ghs);
-	gfs2_log_flush(sdp, ip->i_gl,
-		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
+	gfs2_log_flush(sdp, gl, GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
 		for (x = 0; x < num_qd; x++) {
 			qd = qda[x];
@@ -1039,7 +1039,7 @@ static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 		    struct gfs2_holder *q_gh)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_quota_inode);
 	struct gfs2_holder i_gh;
 	int error;
 
@@ -1063,7 +1063,7 @@ static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 		if (error)
 			return error;
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &i_gh);
 		if (error)
 			goto fail;
 
@@ -1404,7 +1404,7 @@ int gfs2_quota_refresh(struct gfs2_sbd *sdp, struct kqid qid)
 int gfs2_quota_init(struct gfs2_sbd *sdp)
 {
 	struct inode *inode = sdp->sd_qc_inode;
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	u64 size = i_size_read(sdp->sd_qc_inode);
 	unsigned int blocks = size >> sdp->sd_sb.sb_bsize_shift;
 	unsigned int x, slot = 0;
@@ -1441,7 +1441,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 				goto fail;
 		}
 		error = -EIO;
-		bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+		bh = gfs2_meta_ra(gl, dblock, extlen);
 		if (!bh)
 			goto fail;
 		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
@@ -1717,6 +1717,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct inode *inode = sdp->sd_quota_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_quota_data *qd;
 	struct gfs2_holder q_gh, i_gh;
@@ -1748,7 +1749,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 	error = gfs2_glock_nq_init(qd->qd_gl, LM_ST_EXCLUSIVE, 0, &q_gh);
 	if (error)
 		goto out_unlockput;
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out_q;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index b45aa3032ca2..5b1f494dc3c0 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -33,8 +33,8 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 			   struct buffer_head **bh)
 {
 	struct inode *inode = jd->jd_inode;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
 	u64 dblock;
 	u32 extlen;
 	int error;
@@ -307,15 +307,13 @@ static int update_statfs_inode(struct gfs2_jdesc *jd,
 			       struct inode *inode)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct gfs2_inode *ip;
 	struct buffer_head *bh;
 	struct gfs2_statfs_change_host sc;
 	int error = 0;
 
 	BUG_ON(!inode);
-	ip = GFS2_I(inode);
 
-	error = gfs2_meta_inode_buffer(ip, &bh);
+	error = gfs2_meta_inode_buffer(GFS2_I(inode), &bh);
 	if (error)
 		goto out;
 
@@ -346,7 +344,7 @@ static int update_statfs_inode(struct gfs2_jdesc *jd,
 
 	mark_buffer_dirty(bh);
 	brelse(bh);
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gfs2_inode_glock(inode));
 
 out:
 	return error;
@@ -399,7 +397,7 @@ static void recover_local_statfs(struct gfs2_jdesc *jd,
 void gfs2_recover_func(struct work_struct *work)
 {
 	struct gfs2_jdesc *jd = container_of(work, struct gfs2_jdesc, jd_work);
-	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct gfs2_log_header_host head;
 	struct gfs2_holder j_gh, ji_gh;
@@ -441,7 +439,7 @@ void gfs2_recover_func(struct work_struct *work)
 			goto fail;
 		}
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED,
 					   LM_FLAG_RECOVER | GL_NOCACHE,
 					   &ji_gh);
 		if (error)
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 5988a165a830..f6048a73e5c3 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1033,8 +1033,8 @@ static int gfs2_ri_update(struct gfs2_inode *ip)
 
 int gfs2_rindex_update(struct gfs2_sbd *sdp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_rindex);
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_rindex);
-	struct gfs2_glock *gl = ip->i_gl;
 	struct gfs2_holder ri_gh;
 	int error = 0;
 	int unlock_required = 0;
@@ -2453,7 +2453,7 @@ int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
 		if (error == 0) {
 			struct gfs2_dinode *di =
 				(struct gfs2_dinode *)dibh->b_data;
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gfs2_inode_glock(&ip->i_inode), dibh);
 			di->di_goal_meta = di->di_goal_data =
 				cpu_to_be64(ip->i_goal);
 			brelse(dibh);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 06302c29340f..af8c71576833 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -132,8 +132,7 @@ int gfs2_jdesc_check(struct gfs2_jdesc *jd)
 
 int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 {
-	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-	struct gfs2_glock *j_gl = ip->i_gl;
+	struct gfs2_glock *j_gl = gfs2_inode_glock(sdp->sd_jdesc->jd_inode);
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
@@ -176,6 +175,7 @@ void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc, void *buf)
 
 int gfs2_statfs_init(struct gfs2_sbd *sdp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_statfs_inode);
 	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
 	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
@@ -183,7 +183,7 @@ int gfs2_statfs_init(struct gfs2_sbd *sdp)
 	struct gfs2_holder gh;
 	int error;
 
-	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+	error = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
 				   &gh);
 	if (error)
 		return error;
@@ -216,13 +216,13 @@ int gfs2_statfs_init(struct gfs2_sbd *sdp)
 void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
 			s64 dinodes)
 {
-	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(sdp->sd_sc_inode);
 	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
 	s64 x, y;
 	int need_sync = 0;
 
-	gfs2_trans_add_meta(l_ip->i_gl, sdp->sd_sc_bh);
+	gfs2_trans_add_meta(gl, sdp->sd_sc_bh);
 
 	spin_lock(&sdp->sd_statfs_spin);
 	l_sc->sc_total += total;
@@ -244,13 +244,13 @@ void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
 
 void update_statfs(struct gfs2_sbd *sdp, struct buffer_head *m_bh)
 {
-	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
-	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
+	struct gfs2_glock *m_gl = gfs2_inode_glock(sdp->sd_statfs_inode);
+	struct gfs2_glock *l_gl = gfs2_inode_glock(sdp->sd_sc_inode);
 	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
 	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 
-	gfs2_trans_add_meta(l_ip->i_gl, sdp->sd_sc_bh);
-	gfs2_trans_add_meta(m_ip->i_gl, m_bh);
+	gfs2_trans_add_meta(l_gl, sdp->sd_sc_bh);
+	gfs2_trans_add_meta(m_gl, m_bh);
 
 	spin_lock(&sdp->sd_statfs_spin);
 	m_sc->sc_total += l_sc->sc_total;
@@ -273,8 +273,8 @@ int gfs2_statfs_sync(struct super_block *sb, int type)
 	struct buffer_head *m_bh;
 	int error;
 
-	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
-				   &gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(&m_ip->i_inode),
+				   LM_ST_EXCLUSIVE, GL_NOCACHE, &gh);
 	if (error)
 		goto out;
 
@@ -323,7 +323,6 @@ struct lfcc {
 
 static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 {
-	struct gfs2_inode *ip;
 	struct gfs2_jdesc *jd;
 	struct lfcc *lfcc;
 	LIST_HEAD(list);
@@ -336,13 +335,14 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	 */
 
 	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
+		struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
+
 		lfcc = kmalloc_obj(struct lfcc);
 		if (!lfcc) {
 			error = -ENOMEM;
 			goto out;
 		}
-		ip = GFS2_I(jd->jd_inode);
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &lfcc->gh);
+		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &lfcc->gh);
 		if (error) {
 			kfree(lfcc);
 			goto out;
@@ -438,15 +438,16 @@ void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 
 static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct address_space *metamapping = gfs2_glock2aspace(ip->i_gl);
+	struct address_space *metamapping = gfs2_glock2aspace(gl);
 	struct backing_dev_info *bdi = inode_to_bdi(metamapping->host);
 	int ret = 0;
 	bool flush_all = (wbc->sync_mode == WB_SYNC_ALL || gfs2_is_jdata(ip));
 
 	if (flush_all)
-		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
+		gfs2_log_flush(GFS2_SB(inode), gl,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
 	if (bdi_wb_dirty_exceeded(bdi))
@@ -481,6 +482,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 static void gfs2_dirty_inode(struct inode *inode, int flags)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct buffer_head *bh;
@@ -490,20 +492,20 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 	int ret;
 
 	/* This can only happen during incomplete inode creation. */
-	if (unlikely(!ip->i_gl))
+	if (unlikely(!gl))
 		return;
 
 	if (gfs2_withdrawn(sdp))
 		return;
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gl)) {
+		ret = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret) {
 			fs_err(sdp, "dirty_inode: glock %d\n", ret);
-			gfs2_dump_glock(NULL, ip->i_gl, true);
+			gfs2_dump_glock(NULL, gl, true);
 			return;
 		}
 		need_unlock = 1;
-	} else if (WARN_ON_ONCE(ip->i_gl->gl_state != LM_ST_EXCLUSIVE))
+	} else if (WARN_ON_ONCE(gl->gl_state != LM_ST_EXCLUSIVE))
 		return;
 
 	if (current->journal_info == NULL) {
@@ -517,7 +519,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 
 	ret = gfs2_meta_inode_buffer(ip, &bh);
 	if (ret == 0) {
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gl, bh);
 		gfs2_dinode_out(ip, bh->b_data);
 		brelse(bh);
 	}
@@ -1176,6 +1178,7 @@ static void gfs2_glock_put_eventually(struct gfs2_glock *gl)
 
 static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *gh = &ip->i_iopen_gh;
@@ -1211,11 +1214,11 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 
 	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
 		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
-		glock_needs_demote(ip->i_gl),
+		glock_needs_demote(gl),
 		5 * HZ);
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
-		if (glock_needs_demote(ip->i_gl))
+		if (glock_needs_demote(gl))
 			return EVICT_SHOULD_SKIP_DELETE;
 		return EVICT_SHOULD_DEFER_DELETE;
 	}
@@ -1238,6 +1241,7 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 static enum evict_behavior evict_should_delete(struct inode *inode,
 					       struct gfs2_holder *gh)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
@@ -1255,11 +1259,11 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Must not read inode block until block type has been verified */
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, gh);
+	ret = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, GL_SKIP, gh);
 	if (unlikely(ret))
 		return EVICT_SHOULD_SKIP_DELETE;
 
-	if (gfs2_inode_already_deleted(ip->i_gl, ip->i_no_formal_ino))
+	if (gfs2_inode_already_deleted(gl, ip->i_no_formal_ino))
 		return EVICT_SHOULD_SKIP_DELETE;
 	ret = gfs2_check_blk_type(sdp, ip->i_no_addr, GFS2_BLKST_UNLINKED);
 	if (ret)
@@ -1288,8 +1292,8 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
  */
 static int evict_unlinked_inode(struct inode *inode, struct gfs2_holder *gh)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
 	int ret;
 
 	/* The inode glock must be held exclusively and be instantiated. */
@@ -1390,8 +1394,7 @@ static int evict_linked_inode(struct inode *inode, struct gfs2_holder *gh)
 {
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct address_space *metamapping = gfs2_glock2aspace(gl);
 	int ret;
 
@@ -1446,13 +1449,14 @@ static void gfs2_evict_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	enum evict_behavior behavior;
 	int ret;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	if (sb_rdonly(sb) || !ip->i_no_addr || !ip->i_gl)
+	if (sb_rdonly(sb) || !ip->i_no_addr || !gl)
 		goto out;
 
 	/*
@@ -1505,10 +1509,10 @@ static void gfs2_evict_inode(struct inode *inode)
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 		gfs2_glock_put_eventually(gl);
 	}
-	if (ip->i_gl) {
-		glock_clear_object(ip->i_gl, ip);
+	if (gl) {
+		glock_clear_object(gl, ip);
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
-		gfs2_glock_put_eventually(ip->i_gl);
+		gfs2_glock_put_eventually(gl);
 		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 }
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 83b8bb6446e5..61b0668ecabc 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -55,10 +55,9 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	int error;
 	struct gfs2_holder j_gh;
 	struct gfs2_log_header_host head;
-	struct gfs2_inode *ip;
+	struct gfs2_glock *gl = gfs2_inode_glock(jd->jd_inode);
 
-	ip = GFS2_I(jd->jd_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_RECOVER |
+	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_RECOVER |
 				   GL_EXACT | GL_NOCACHE, &j_gh);
 	if (error) {
 		if (verbose)
@@ -333,6 +332,7 @@ void gfs2_consist_i(struct gfs2_sbd *sdp, const char *function,
 void gfs2_consist_inode_i(struct gfs2_inode *ip,
 			  const char *function, char *file, unsigned int line)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 
 	gfs2_lm(sdp,
@@ -342,7 +342,7 @@ void gfs2_consist_inode_i(struct gfs2_inode *ip,
 		(unsigned long long)ip->i_no_formal_ino,
 		(unsigned long long)ip->i_no_addr,
 		function, file, line);
-	gfs2_dump_glock(NULL, ip->i_gl, 1);
+	gfs2_dump_glock(NULL, gl, 1);
 	gfs2_withdraw(sdp);
 }
 
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index b9f48d6f10a9..db38d972debd 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -128,11 +128,12 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct buffer_head *bh,
 
 static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct buffer_head *bh, *eabh;
 	__be64 *eablk, *end;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(gl, ip->i_eattr, DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
 
@@ -156,7 +157,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 			break;
 		bn = be64_to_cpu(*eablk);
 
-		error = gfs2_meta_read(ip->i_gl, bn, DIO_WAIT, 0, &eabh);
+		error = gfs2_meta_read(gl, bn, DIO_WAIT, 0, &eabh);
 		if (error)
 			break;
 		error = ea_foreach_i(ip, eabh, ea_call, data);
@@ -279,7 +280,7 @@ static int ea_dealloc_unstuffed(struct gfs2_inode *ip, struct buffer_head *bh,
 	if (error)
 		goto out_gunlock;
 
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(&ip->i_inode), bh);
 
 	dataptrs = GFS2_EA2DATAPTRS(ea);
 	for (x = 0; x < ea->ea_num_ptrs; x++, dataptrs++) {
@@ -426,7 +427,8 @@ ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		er.er_data_len = size;
 	}
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(&ip->i_inode), LM_ST_SHARED,
+				   LM_FLAG_ANY, &i_gh);
 	if (error)
 		return error;
 
@@ -457,6 +459,7 @@ ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 			       const char *din, char *dout)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head **bh;
 	unsigned int amount = GFS2_EA_DATA_LEN(ea);
@@ -472,7 +475,7 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		return -ENOMEM;
 
 	for (x = 0; x < nptrs; x++) {
-		error = gfs2_meta_read(ip->i_gl, be64_to_cpu(*dataptrs), 0, 0,
+		error = gfs2_meta_read(gl, be64_to_cpu(*dataptrs), 0, 0,
 				       bh + x);
 		if (error) {
 			while (x--)
@@ -505,7 +508,7 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		}
 
 		if (din) {
-			gfs2_trans_add_meta(ip->i_gl, bh[x]);
+			gfs2_trans_add_meta(gl, bh[x]);
 			memcpy(pos, din, cp_size);
 			din += sdp->sd_jbsize;
 		}
@@ -608,14 +611,14 @@ static int gfs2_xattr_get(const struct xattr_handler *handler,
 			  struct dentry *unused, struct inode *inode,
 			  const char *name, void *buffer, size_t size)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_holder gh;
 	int ret;
 
 	/* During lookup, SELinux calls this function with the glock locked. */
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (!gfs2_glock_is_locked_by_me(gl)) {
+		ret = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
 		if (ret)
 			return ret;
 	} else {
@@ -637,6 +640,7 @@ static int gfs2_xattr_get(const struct xattr_handler *handler,
 
 static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_ea_header *ea;
 	unsigned int n = 1;
@@ -647,8 +651,8 @@ static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 	if (error)
 		return error;
 	gfs2_trans_remove_revoke(sdp, block, 1);
-	*bhp = gfs2_meta_new(ip->i_gl, block);
-	gfs2_trans_add_meta(ip->i_gl, *bhp);
+	*bhp = gfs2_meta_new(gl, block);
+	gfs2_trans_add_meta(gl, *bhp);
 	gfs2_metatype_set(*bhp, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(*bhp, sizeof(struct gfs2_meta_header));
 
@@ -678,6 +682,7 @@ static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 static int ea_write(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		    struct gfs2_ea_request *er)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	int error;
 
@@ -709,8 +714,8 @@ static int ea_write(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 			if (error)
 				return error;
 			gfs2_trans_remove_revoke(sdp, block, 1);
-			bh = gfs2_meta_new(ip->i_gl, block);
-			gfs2_trans_add_meta(ip->i_gl, bh);
+			bh = gfs2_meta_new(gl, block);
+			gfs2_trans_add_meta(gl, bh);
 			gfs2_metatype_set(bh, GFS2_METATYPE_ED, GFS2_FORMAT_ED);
 
 			gfs2_add_inode_blocks(&ip->i_inode, 1);
@@ -841,11 +846,12 @@ static struct gfs2_ea_header *ea_split_ea(struct gfs2_ea_header *ea)
 static void ea_set_remove_stuffed(struct gfs2_inode *ip,
 				  struct gfs2_ea_location *el)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_ea_header *ea = el->el_ea;
 	struct gfs2_ea_header *prev = el->el_prev;
 	u32 len;
 
-	gfs2_trans_add_meta(ip->i_gl, el->el_bh);
+	gfs2_trans_add_meta(gl, el->el_bh);
 
 	if (!prev || !GFS2_EA_IS_STUFFED(ea)) {
 		ea->ea_type = GFS2_EATYPE_UNUSED;
@@ -875,6 +881,7 @@ struct ea_set {
 static int ea_set_simple_noalloc(struct gfs2_inode *ip, struct buffer_head *bh,
 				 struct gfs2_ea_header *ea, struct ea_set *es)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_ea_request *er = es->es_er;
 	int error;
 
@@ -882,7 +889,7 @@ static int ea_set_simple_noalloc(struct gfs2_inode *ip, struct buffer_head *bh,
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gl, bh);
 
 	if (es->ea_split)
 		ea = ea_split_ea(ea);
@@ -902,11 +909,12 @@ static int ea_set_simple_noalloc(struct gfs2_inode *ip, struct buffer_head *bh,
 static int ea_set_simple_alloc(struct gfs2_inode *ip,
 			       struct gfs2_ea_request *er, void *private)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct ea_set *es = private;
 	struct gfs2_ea_header *ea = es->es_ea;
 	int error;
 
-	gfs2_trans_add_meta(ip->i_gl, es->es_bh);
+	gfs2_trans_add_meta(gl, es->es_bh);
 
 	if (es->ea_split)
 		ea = ea_split_ea(ea);
@@ -971,6 +979,7 @@ static int ea_set_simple(struct gfs2_inode *ip, struct buffer_head *bh,
 static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 			void *private)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *indbh, *newbh;
 	__be64 *eablk;
@@ -980,7 +989,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	if (ip->i_diskflags & GFS2_DIF_EA_INDIRECT) {
 		__be64 *end;
 
-		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0,
+		error = gfs2_meta_read(gl, ip->i_eattr, DIO_WAIT, 0,
 				       &indbh);
 		if (error)
 			return error;
@@ -1002,7 +1011,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 			goto out;
 		}
 
-		gfs2_trans_add_meta(ip->i_gl, indbh);
+		gfs2_trans_add_meta(gl, indbh);
 	} else {
 		u64 blk;
 		unsigned int n = 1;
@@ -1010,8 +1019,8 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 		if (error)
 			return error;
 		gfs2_trans_remove_revoke(sdp, blk, 1);
-		indbh = gfs2_meta_new(ip->i_gl, blk);
-		gfs2_trans_add_meta(ip->i_gl, indbh);
+		indbh = gfs2_meta_new(gl, blk);
+		gfs2_trans_add_meta(gl, indbh);
 		gfs2_metatype_set(indbh, GFS2_METATYPE_IN, GFS2_FORMAT_IN);
 		gfs2_buffer_clear_tail(indbh, mh_size);
 
@@ -1088,6 +1097,7 @@ static int ea_set_remove_unstuffed(struct gfs2_inode *ip,
 
 static int ea_remove_stuffed(struct gfs2_inode *ip, struct gfs2_ea_location *el)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_ea_header *ea = el->el_ea;
 	struct gfs2_ea_header *prev = el->el_prev;
 	int error;
@@ -1096,7 +1106,7 @@ static int ea_remove_stuffed(struct gfs2_inode *ip, struct gfs2_ea_location *el)
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, el->el_bh);
+	gfs2_trans_add_meta(gl, el->el_bh);
 
 	if (prev) {
 		u32 len;
@@ -1234,6 +1244,7 @@ static int gfs2_xattr_set(const struct xattr_handler *handler,
 			  const char *name, const void *value,
 			  size_t size, int flags)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
@@ -1244,12 +1255,12 @@ static int gfs2_xattr_set(const struct xattr_handler *handler,
 
 	/* May be called from gfs_setattr with the glock locked. */
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gl)) {
+		ret = gfs2_glock_nq_init(gl, LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret)
 			goto out;
 	} else {
-		if (WARN_ON_ONCE(ip->i_gl->gl_state != LM_ST_EXCLUSIVE)) {
+		if (WARN_ON_ONCE(gl->gl_state != LM_ST_EXCLUSIVE)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -1265,6 +1276,7 @@ static int gfs2_xattr_set(const struct xattr_handler *handler,
 
 static int ea_dealloc_indirect(struct gfs2_inode *ip)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrp_list rlist;
 	struct gfs2_rgrpd *rgd;
@@ -1283,7 +1295,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &indbh);
+	error = gfs2_meta_read(gl, ip->i_eattr, DIO_WAIT, 0, &indbh);
 	if (error)
 		return error;
 
@@ -1333,7 +1345,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 	if (error)
 		goto out_gunlock;
 
-	gfs2_trans_add_meta(ip->i_gl, indbh);
+	gfs2_trans_add_meta(gl, indbh);
 
 	eablk = (__be64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
 	bstart = 0;
@@ -1367,7 +1379,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
-		gfs2_trans_add_meta(ip->i_gl, dibh);
+		gfs2_trans_add_meta(gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
@@ -1385,6 +1397,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 {
+	struct gfs2_glock *gl = gfs2_inode_glock(&ip->i_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrpd *rgd;
 	struct buffer_head *dibh;
@@ -1419,7 +1432,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 	if (initialized) {
 		error = gfs2_meta_inode_buffer(ip, &dibh);
 		if (!error) {
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
 		}
-- 
2.55.0

