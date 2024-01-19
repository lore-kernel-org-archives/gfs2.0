Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029C58100
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699268; cv=none; b=EqskAdwQdxCs5oBLgOoyQY0DXJFFDhzzy24CD4wibXBX8MyqLmzKe+3mhHfOwSG46XjOOwD0P0/nx58ul12tMOYlWgwev7lu/yHtP8wDLkenCrG7yqWKis4CfpOSIiYptcfwmrxDwd8CyZ9YdgPz6jMXaycv7VURM4uMXzi45Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699268; c=relaxed/simple;
	bh=NHzjQffbx2on3CFrjpWJqcP4teagw38t67oRTe4bpyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=titIo+vAdEjMj9IDegv0ZXXSxkG7KbLhzSHBVtHi8dExWa1y1IsAbGj3lLAm+2L5v/DNd3K+flf5jhM+wDyhhmH6K7H4ltNG9wqVjXogQJscrcO8yUjvf8C0Hi8j17yvAgie6nt0hO4gNZyITN2uRzoT9Vy94YPtEkv1L5cK9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYoer2FR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYoer2FR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj07bn0nWbqbHFd4s5mEky1TEmrI3pkqI6vlnlSKXNo=;
	b=KYoer2FRSTGeXpGt7jcvJgmYZV9HvkT1pPYpCGB/AyYboD33td1eFqvelM0UsqMuFQ4xBt
	f4gm55Dq8+ve4GdbXykx/fLacLw4Rn7tgq9IY7S0MkRaH2P0os+CcAPvXo1Vz1nq2TmHeU
	nJIbjpvEjsObS+LVC1ELYPeyeDYlgK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-A0iCQyEeOA2Gs5IQNn0flQ-1; Fri, 19 Jan 2024 16:21:02 -0500
X-MC-Unique: A0iCQyEeOA2Gs5IQNn0flQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2B86869EC3;
	Fri, 19 Jan 2024 21:21:01 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CF1640C1430;
	Fri, 19 Jan 2024 21:21:01 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5/9] gfs2: Pass FGP flags to gfs2_meta_{,inode_}buffer
Date: Fri, 19 Jan 2024 22:20:52 +0100
Message-ID: <20240119212056.805617-6-agruenba@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Pass a fgp_flags argument to gfs2_meta_buffer() and
gfs2_meta_inode_buffer().  If the FGP_NOWAIT flag is set and one of
these functions would sleep, -EAGAIN is returned instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c       |  4 ++--
 fs/gfs2/bmap.c       | 19 ++++++++++---------
 fs/gfs2/dir.c        | 20 ++++++++++----------
 fs/gfs2/file.c       |  4 ++--
 fs/gfs2/glops.c      |  2 +-
 fs/gfs2/inode.c      |  4 ++--
 fs/gfs2/meta_io.c    |  7 +++++--
 fs/gfs2/meta_io.h    |  7 ++++---
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/rgrp.c       |  2 +-
 fs/gfs2/super.c      |  6 +++---
 fs/gfs2/xattr.c      |  4 ++--
 13 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..31da7f6926c9 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -424,7 +424,7 @@ static int stuffed_read_folio(struct gfs2_inode *ip, struct folio *folio)
 	if (unlikely(folio->index)) {
 		dsize = 0;
 	} else {
-		error = gfs2_meta_inode_buffer(ip, &dibh);
+		error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 		if (error)
 			goto out;
 		from = dibh->b_data + sizeof(struct gfs2_dinode);
@@ -548,7 +548,7 @@ void adjust_fs_space(struct inode *inode)
 
 	/* Total up the file system space, according to the latest rindex. */
 	fs_total = gfs2_ri_total(sdp);
-	if (gfs2_meta_inode_buffer(m_ip, &m_bh) != 0)
+	if (gfs2_meta_inode_buffer(m_ip, 0, &m_bh) != 0)
 		goto out;
 
 	spin_lock(&sdp->sd_statfs_spin);
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 92945e5b7643..ffe19d3012f5 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -95,7 +95,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 	int isdir = gfs2_is_dir(ip);
 	int error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		return error;
 
@@ -331,7 +331,8 @@ static int __fillup_metapath(struct gfs2_inode *ip, struct metapath *mp,
 
 		if (!dblock)
 			break;
-		ret = gfs2_meta_buffer(ip, GFS2_METATYPE_IN, dblock, &mp->mp_bh[x + 1]);
+		ret = gfs2_meta_buffer(ip, GFS2_METATYPE_IN, dblock, 0,
+				       &mp->mp_bh[x + 1]);
 		if (ret)
 			return ret;
 	}
@@ -858,7 +859,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 
 	down_read(&ip->i_rw_mutex);
 
-	ret = gfs2_meta_inode_buffer(ip, &dibh);
+	ret = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (ret)
 		goto unlock;
 	mp->mp_bh[0] = dibh;
@@ -1377,7 +1378,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 	if (error)
 		return error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		goto out;
 
@@ -1580,7 +1581,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 		if (current->journal_info) {
 			struct buffer_head *dibh;
 
-			ret = gfs2_meta_inode_buffer(ip, &dibh);
+			ret = gfs2_meta_inode_buffer(ip, 0, &dibh);
 			if (ret)
 				goto out;
 
@@ -1785,7 +1786,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	}
 	start_aligned = mp_h;
 
-	ret = gfs2_meta_inode_buffer(ip, &dibh);
+	ret = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (ret)
 		return ret;
 
@@ -1985,7 +1986,7 @@ static int trunc_end(struct gfs2_inode *ip)
 
 	down_write(&ip->i_rw_mutex);
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		goto out;
 
@@ -2091,7 +2092,7 @@ static int do_grow(struct inode *inode, u64 size)
 			goto do_end_trans;
 	}
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		goto do_end_trans;
 
@@ -2345,7 +2346,7 @@ static int stuffed_zero_range(struct inode *inode, loff_t offset, loff_t length)
 	if (offset + length > inode->i_size)
 		length = inode->i_size - offset;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		return error;
 	gfs2_trans_add_meta(ip->i_gl, dibh);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index a1f47696a2ec..8719c8316e28 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -122,7 +122,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 	struct buffer_head *dibh;
 	int error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		return error;
 
@@ -221,7 +221,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 	}
 
 out:
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		return error;
 
@@ -246,7 +246,7 @@ static int gfs2_dir_read_stuffed(struct gfs2_inode *ip, __be64 *buf,
 	struct buffer_head *dibh;
 	int error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (!error) {
 		memcpy(buf, dibh->b_data + sizeof(struct gfs2_dinode), size);
 		brelse(dibh);
@@ -844,7 +844,7 @@ static struct gfs2_dirent *gfs2_dirent_search(struct inode *inode,
 	}
 
 
-	error = gfs2_meta_inode_buffer(ip, &bh);
+	error = gfs2_meta_inode_buffer(ip, 0, &bh);
 	if (error)
 		return ERR_PTR(error);
 	dent = gfs2_dirent_scan(inode, bh->b_data, bh->b_size, scan, name, NULL);
@@ -915,7 +915,7 @@ static int dir_make_exhash(struct inode *inode)
 	u64 bn;
 	int error;
 
-	error = gfs2_meta_inode_buffer(dip, &dibh);
+	error = gfs2_meta_inode_buffer(dip, 0, &dibh);
 	if (error)
 		return error;
 
@@ -1115,7 +1115,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 
 	oleaf->lf_depth = nleaf->lf_depth;
 
-	error = gfs2_meta_inode_buffer(dip, &dibh);
+	error = gfs2_meta_inode_buffer(dip, 0, &dibh);
 	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
 		gfs2_trans_add_meta(dip->i_gl, dibh);
 		gfs2_add_inode_blocks(&dip->i_inode, 1);
@@ -1169,7 +1169,7 @@ static int dir_double_exhash(struct gfs2_inode *dip)
 		return -ENOMEM;
 
 	h = hc2;
-	error = gfs2_meta_inode_buffer(dip, &dibh);
+	error = gfs2_meta_inode_buffer(dip, 0, &dibh);
 	if (error)
 		goto out_kfree;
 
@@ -1586,7 +1586,7 @@ int gfs2_dir_read(struct inode *inode, struct dir_context *ctx,
 		return -EIO;
 	}
 
-	error = gfs2_meta_inode_buffer(dip, &dibh);
+	error = gfs2_meta_inode_buffer(dip, 0, &dibh);
 	if (error)
 		return error;
 
@@ -1758,7 +1758,7 @@ static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 	brelse(bh);
 	brelse(obh);
 
-	error = gfs2_meta_inode_buffer(ip, &bh);
+	error = gfs2_meta_inode_buffer(ip, 0, &bh);
 	if (error)
 		return error;
 	gfs2_trans_add_meta(ip->i_gl, bh);
@@ -2063,7 +2063,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
 		goto out_end_trans;
 	}
 
-	error = gfs2_meta_inode_buffer(dip, &dibh);
+	error = gfs2_meta_inode_buffer(dip, 0, &dibh);
 	if (error)
 		goto out_end_trans;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 992ca4effb50..ac4ed6abfc6c 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -257,7 +257,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	error = gfs2_trans_begin(sdp, RES_DINODE, 0);
 	if (error)
 		goto out;
-	error = gfs2_meta_inode_buffer(ip, &bh);
+	error = gfs2_meta_inode_buffer(ip, 0, &bh);
 	if (error)
 		goto out_trans_end;
 	inode_set_ctime_current(inode);
@@ -1179,7 +1179,7 @@ static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len,
 	struct buffer_head *dibh;
 	int error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (unlikely(error))
 		return error;
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 45653cbc8a87..cc38aa81d246 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -483,7 +483,7 @@ int gfs2_inode_refresh(struct gfs2_inode *ip)
 	struct buffer_head *dibh;
 	int error;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		return error;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6bfc9383b7b8..a417650e378f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1027,7 +1027,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 			goto out_ipres;
 	}
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error)
 		goto out_end_trans;
 
@@ -1833,7 +1833,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 		goto out;
 	}
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (error) {
 		buf = ERR_PTR(error);
 		goto out;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 47a430206801..c8750b337496 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -500,13 +500,16 @@ void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
  * @ip: The GFS2 inode
  * @mtype: The block type (GFS2_METATYPE_*)
  * @num: The block number (device relative) of the buffer
+ * @fgp_flags: FGP_NOWAIT if sleeping is prohibited
  * @bhp: the buffer is returned here
  *
+ * Returns -EAGAIN if the FGP_NOWAIT flag is set and the function would sleep.
+ *
  * Returns: errno
  */
 
 int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
-		     struct buffer_head **bhp)
+		     fgf_t fgp_flags, struct buffer_head **bhp)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_glock *gl = ip->i_gl;
@@ -517,7 +520,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 	if (num == ip->i_no_addr)
 		rahead = ip->i_rahead;
 
-	ret = gfs2_meta_read(gl, num, 0, rahead, &bh);
+	ret = gfs2_meta_read(gl, num, fgp_flags, rahead, &bh);
 	if (ret == 0 && gfs2_metatype_check(sdp, bh, mtype)) {
 		brelse(bh);
 		ret = -EIO;
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 6ca37e9f1c95..7b5122078113 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -66,12 +66,13 @@ enum {
 void gfs2_remove_from_journal(struct buffer_head *bh, int meta);
 void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen);
 int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
-		     struct buffer_head **bhp);
+		     fgf_t fgp_flags, struct buffer_head **bhp);
 
-static inline int gfs2_meta_inode_buffer(struct gfs2_inode *ip,
+static inline int gfs2_meta_inode_buffer(struct gfs2_inode *ip, fgf_t fgp_flags,
 					 struct buffer_head **bhp)
 {
-	return gfs2_meta_buffer(ip, GFS2_METATYPE_DI, ip->i_no_addr, bhp);
+	return gfs2_meta_buffer(ip, GFS2_METATYPE_DI, ip->i_no_addr, fgp_flags,
+				bhp);
 }
 
 struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1281e60be639..1a01adb48f5b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -698,7 +698,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 		goto free_local;
 	}
 	/* read in the local statfs buffer - other nodes don't change it. */
-	error = gfs2_meta_inode_buffer(ip, &sdp->sd_sc_bh);
+	error = gfs2_meta_inode_buffer(ip, 0, &sdp->sd_sc_bh);
 	if (error) {
 		fs_err(sdp, "Cannot read in local statfs: %d\n", error);
 		goto unlock_sd_gh;
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index f4fe7039f725..4db3ca9c3b02 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -317,7 +317,7 @@ static int update_statfs_inode(struct gfs2_jdesc *jd,
 	BUG_ON(!inode);
 	ip = GFS2_I(inode);
 
-	error = gfs2_meta_inode_buffer(ip, &bh);
+	error = gfs2_meta_inode_buffer(ip, 0, &bh);
 	if (error)
 		goto out;
 
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 9fa4fc7f4bcf..c9aec3dba80c 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2452,7 +2452,7 @@ int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
 	rbm.rgd->rd_last_alloc = block - rbm.rgd->rd_data0;
 	if (!dinode) {
 		ip->i_goal = block + *nblocks - 1;
-		error = gfs2_meta_inode_buffer(ip, &dibh);
+		error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 		if (error == 0) {
 			struct gfs2_dinode *di =
 				(struct gfs2_dinode *)dibh->b_data;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e5f79466340d..7bfdd5924a54 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -192,7 +192,7 @@ int gfs2_statfs_init(struct gfs2_sbd *sdp)
 	if (error)
 		return error;
 
-	error = gfs2_meta_inode_buffer(m_ip, &m_bh);
+	error = gfs2_meta_inode_buffer(m_ip, 0, &m_bh);
 	if (error)
 		goto out;
 
@@ -282,7 +282,7 @@ int gfs2_statfs_sync(struct super_block *sb, int type)
 	if (error)
 		goto out;
 
-	error = gfs2_meta_inode_buffer(m_ip, &m_bh);
+	error = gfs2_meta_inode_buffer(m_ip, 0, &m_bh);
 	if (error)
 		goto out_unlock;
 
@@ -521,7 +521,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 		need_endtrans = 1;
 	}
 
-	ret = gfs2_meta_inode_buffer(ip, &bh);
+	ret = gfs2_meta_inode_buffer(ip, 0, &bh);
 	if (ret == 0) {
 		gfs2_trans_add_meta(ip->i_gl, bh);
 		gfs2_dinode_out(ip, bh->b_data);
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 745c7cf78519..e2ff0fc8e445 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1360,7 +1360,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	ip->i_diskflags &= ~GFS2_DIF_EA_INDIRECT;
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
+	error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 	if (!error) {
 		gfs2_trans_add_meta(ip->i_gl, dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
@@ -1412,7 +1412,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 	gfs2_add_inode_blocks(&ip->i_inode, -1);
 
 	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
-		error = gfs2_meta_inode_buffer(ip, &dibh);
+		error = gfs2_meta_inode_buffer(ip, 0, &dibh);
 		if (!error) {
 			gfs2_trans_add_meta(ip->i_gl, dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
-- 
2.43.0

