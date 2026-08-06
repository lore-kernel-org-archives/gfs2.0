Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE48834
	for <gfs2@lists.linux.dev>; Thu,  6 Aug 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041391; cv=none; b=t1At57esAINT0OmNRK50MH19VLG39hsIpP/zHbvSOZKXxwWdyjG5rXC/Vn91KnFejq2iGMJYkSZ8p4yV+i1ki9TaN3/O9FnN82n4mFIZL5DNj1sFBN4YIfgO8kMXrt27L9Fos2AGGxvA92TCRHEBShg4VwPnYRhJftn+BP+bA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041391; c=relaxed/simple;
	bh=YWfvJQRuuNq+Ni9+aIG6RpWkazaoYPD9rN4uWj9XmQc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Q7+6Sfell9LAQio5REKE9AaGrZXL1MIGbAbWQqnelZAQAa/O9nOCj2hl0rqOiWX6MYpC+f7/HscU8xyHQ0ESRm0NEgHt2OIvPyAI2NpQ/pVekuKl59tpNv5jnZYlGyY2jSQD8bHvODe95Bj4jAD44dXls7MI8qwz5w+L8mNPDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmyNgPoI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmyNgPoI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso16574695e9.1
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786041386; x=1786646186; darn=lists.linux.dev;
        h=subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1IdhXA/gM5aEB7BjZ/r00E8O+kI/ce135WTaEXoqks=;
        b=XmyNgPoI1yCsY1sYVJGwec+LYi1vsKK/FnjSyu0p2dWSlmJGCYqIEVLYuhEyMpj7Nl
         7jfvgfkEUc2i+SpCju2QUtftQdnrE3wYjWlYLuM4T3rjy8futAajeNywmo5YQUknZ6kV
         VZ1S4z+L8OkNPhVnRhU79v6jqdretKQYje9A3uAL3qkRFqSQ0bHMTAF9ciIIV7uFXjC7
         AlJpu9Bx0K0PuCna5gsgo0+ePObwnZTTfUE/1q7hNaVnI4ksuHgs58wiUrtKJ5yU2pbn
         qDOFOcOIf6c5KNrr2GIOxp7ECVrr+mtvih+0oaLyTgjpqCegHefvvzcWKFRejJyGUFkR
         C3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041386; x=1786646186;
        h=subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1IdhXA/gM5aEB7BjZ/r00E8O+kI/ce135WTaEXoqks=;
        b=NHVrQeBOG3JyzN9mNYO9IjjmWrXSRqLR5TJ+t+82bEDJzYUMwXyE0FQT8QeqAszMa9
         PyRDJ5bnOACdAQXDC3qbVEC5vV+fpRdYvj5TeVPfMcVgbAQbooCBaoGu6bYmmVeQaaX6
         lh0uf4T/8Wad7u/AR9olMjkm8PPo5qa5DzoxNKoQFAV08DYwb4eGDFrBzaKy5dz31OIx
         qC1wcdGdlfiwjOUAct8Q+SgK8vy7oFP45SgUovBTVhOYggxoEyL7iXWd3MHVZMepVVb7
         22Am2y4798wBtU5OHBKYiECdTXqLIqUcF0m8AfdNB91EsEi85Fp2ZcC5PN8yn1yYBCdp
         rQXQ==
X-Gm-Message-State: AOJu0YzscBUmA6WZR8kei9ou/3tqbD7SCxLm+qiSE2ra4giLOeFhmnpd
	J7HS9xzLrH344VvEGReejEFhOSjoGKiFeoE5NNylgYovfavc8PKfDZREpkdwP8ipj0o=
X-Gm-Gg: AR+sD11k7lHnyBqOhQdHWcDtaIwTyTrire8GGwUsumQr9yovThEjLjf56j7tMCR375M
	JM3LVz80DcfEJnR5/LCkvg3foRouQ+GySxchCrYTOmtY4sNmLiVGqPXCoLSOz11JVyIgTklRwlF
	rA3E7/KMX6EnYr4iyTYs+W7/j5q3iBy3Xa2k7ob5H2c53ZfdEBSCB1FvByb8YByfyJ7f7ASufNz
	H6etZzMjuDmyjtZD/Vy6xEQLd/XB962HrqRZjXDDDz3V7dlJg9lt9znjB+6/oS9bxdcQhlOnbNq
	fjn8N6ucCgl6v1HyDsrG3EwV7NSGlXQx5XsFIZbUK4l7xNMwmpU8uUg2GsI1A126BZsMYAV8wMo
	wtm26yDsSgyT5ILeeKcpQaeGXfipH20aqvlU6WbNYZyRlTdlekgxHrJ4WQOzzeV8OhpWtWLr8yl
	yvO7K7Fbt35s+b4orCKsFJ/8NfmUkWA8AykK2r8/LrVmagjgBOLiMBIm8FOteu/Yy5LHG4H8BRk
	2I=
X-Received: by 2002:a05:600c:4688:b0:495:6bc9:62b0 with SMTP id 5b1f17b1804b1-4994e7d1487mr215979685e9.17.1786041385817;
        Thu, 06 Aug 2026 11:36:25 -0700 (PDT)
Received: from correo_v2.txt ([171.22.87.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b18368sm7086279f8f.20.2026.08.06.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:36:10 -0700 (PDT)
Message-ID: <6a74d41a.f3f7def5.e164f.560e@mx.google.com>
Date: Thu, 06 Aug 2026 11:36:10 -0700 (PDT)
From: Adrian Garcia Casado <adriangarciacasado42@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gfs2: annotate i_gl with __rcu and convert to accessor helpers
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

i_gl is assigned once at inode instantiation and only updated via
rcu_assign_pointer() at evict time, but the member lacked the __rcu
annotation, so rcu_dereference_check() and rcu_assign_pointer() made
sparse report address-space errors.

Annotate the member and convert all readers to gfs2_inode_glock(),
based on rcu_dereference_protected() since the pointer is stable for
any live inode. The two gfs2_glock_get() instantiation sites now
publish the new glock via rcu_assign_pointer() once it is private.

No functional changes intended.

Signed-off-by: Adrian Garcia Casado <adriangarciacasado42@gmail.com>

---
v1 -> v2:
 - Drop the casts; annotate i_gl with __rcu and convert all readers
   to gfs2_inode_glock() (rcu_dereference_protected), since the
   pointer is stable for any live inode.
 - The two gfs2_glock_get() instantiation sites now publish via
   rcu_assign_pointer() once the glock is private.
 - Sparse-clean: no longer trading two errors for 200 warnings.
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index a5b60778b..60d2a4f18 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -67,8 +67,8 @@ struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu)
 	if (rcu)
 		return ERR_PTR(-ECHILD);
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		int ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+	if (!gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip))) {
+		int ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED,
 					     LM_FLAG_ANY, &gh);
 		if (ret)
 			return ERR_PTR(ret);
@@ -119,8 +119,8 @@ int gfs2_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ret)
 		return ret;
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip))) {
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret)
 			goto out;
 		need_unlock = true;
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 0a7b8076a..f287488e0 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -111,7 +111,7 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 					inode->i_sb->s_blocksize,
 					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
-		gfs2_trans_add_databufs(ip->i_gl, folio, 0, folio_size(folio));
+		gfs2_trans_add_databufs(gfs2_inode_glock(ip), folio, 0, folio_size(folio));
 	}
 	return gfs2_write_jdata_folio(folio, wbc);
 }
@@ -132,7 +132,7 @@ int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control
 	int error;
 
 	BUG_ON(current->journal_info);
-	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+	if (gfs2_assert_withdraw(sdp, gfs2_inode_glock(ip)->gl_state == LM_ST_EXCLUSIVE))
 		return 0;
 
 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
@@ -368,7 +368,7 @@ static int gfs2_jdata_writepages(struct address_space *mapping,
 
 	ret = gfs2_write_cache_jdata(mapping, wbc);
 	if (ret == 0 && wbc->sync_mode == WB_SYNC_ALL) {
-		gfs2_log_flush(sdp, ip->i_gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
+		gfs2_log_flush(sdp, gfs2_inode_glock(ip), GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_JDATA_WPAGES);
 		ret = gfs2_write_cache_jdata(mapping, wbc);
 	}
@@ -566,7 +566,7 @@ static sector_t gfs2_bmap(struct address_space *mapping, sector_t lblock)
 	sector_t dblock = 0;
 	int error;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 	if (error)
 		return 0;
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44..039569af2 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -78,7 +78,7 @@ static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_head *dibh,
 			map_bh(bh, inode->i_sb, block);
 
 		set_buffer_uptodate(bh);
-		gfs2_trans_add_data(ip->i_gl, bh);
+		gfs2_trans_add_data(gfs2_inode_glock(ip), bh);
 	} else {
 		folio_mark_dirty(folio);
 		gfs2_ordered_add_inode(ip);
@@ -124,7 +124,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *folio)
 
 	/*  Set up the pointer to the new block  */
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
@@ -678,7 +678,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 	BUG_ON(dibh == NULL);
 	BUG_ON(dblks < 1);
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 
 	down_write(&ip->i_rw_mutex);
 
@@ -722,7 +722,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 			}
 			for (; i - 1 < mp->mp_fheight - ip->i_height && n > 0;
 			     i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i, 0, bn++);
+				gfs2_indirect_init(mp, gfs2_inode_glock(ip), i, 0, bn++);
 			if (i - 1 == mp->mp_fheight - ip->i_height) {
 				i--;
 				gfs2_buffer_copy_tail(mp->mp_bh[i],
@@ -748,9 +748,9 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 			fallthrough;	/* To branching from existing tree */
 		case ALLOC_GROW_DEPTH:
 			if (i > 1 && i < mp->mp_fheight)
-				gfs2_trans_add_meta(ip->i_gl, mp->mp_bh[i-1]);
+				gfs2_trans_add_meta(gfs2_inode_glock(ip), mp->mp_bh[i-1]);
 			for (; i < mp->mp_fheight && n > 0; i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i,
+				gfs2_indirect_init(mp, gfs2_inode_glock(ip), i,
 						   mp->mp_list[i-1], bn++);
 			if (i == mp->mp_fheight)
 				state = ALLOC_DATA;
@@ -760,7 +760,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 		case ALLOC_DATA:
 			BUG_ON(n > dblks);
 			BUG_ON(mp->mp_bh[end_of_metadata] == NULL);
-			gfs2_trans_add_meta(ip->i_gl, mp->mp_bh[end_of_metadata]);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), mp->mp_bh[end_of_metadata]);
 			dblks = n;
 			ptr = metapointer(end_of_metadata, mp);
 			iomap->addr = bn << inode->i_blkbits;
@@ -993,7 +993,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
 	if (gfs2_is_jdata(ip) && !gfs2_is_stuffed(ip))
-		gfs2_trans_add_databufs(ip->i_gl, folio,
+		gfs2_trans_add_databufs(gfs2_inode_glock(ip), folio,
 					offset_in_folio(folio, pos),
 					copied);
 
@@ -1196,7 +1196,7 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
 		mark_inode_dirty(inode);
-	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
+	set_bit(GLF_DIRTY, &gfs2_inode_glock(ip)->gl_flags);
 	return 0;
 }
 
@@ -1413,7 +1413,7 @@ static int trunc_start(struct inode *inode, u64 newsize)
 	if (error)
 		goto out;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 
 	if (gfs2_is_stuffed(ip))
 		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + newsize);
@@ -1585,7 +1585,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			goto out_unlock;
 		}
 
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 		buf_in_tr = true;
 		*p = 0;
 		if (bstart + blen == bn) {
@@ -1619,7 +1619,7 @@ static int sweep_bh_for_rgrps(struct gfs2_inode *ip, struct gfs2_holder *rd_gh,
 			/* Every transaction boundary, we rewrite the dinode
 			   to keep its di_blocks current in case of failure. */
 			inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
 			up_write(&ip->i_rw_mutex);
@@ -1831,7 +1831,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	for (mp_h = 0; mp_h < mp.mp_aheight - 1; mp_h++) {
 		metapointer_range(&mp, mp_h, start_list, start_aligned,
 				  end_list, end_aligned, &start, &end);
-		gfs2_metapath_ra(ip->i_gl, start, end);
+		gfs2_metapath_ra(gfs2_inode_glock(ip), start, end);
 	}
 
 	if (mp.mp_aheight == ip->i_height)
@@ -1951,7 +1951,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 							  start_list, start_aligned,
 							  end_list, end_aligned,
 							  &start, &end);
-					gfs2_metapath_ra(ip->i_gl, start, end);
+					gfs2_metapath_ra(gfs2_inode_glock(ip), start, end);
 				}
 			}
 
@@ -1986,7 +1986,7 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 		gfs2_quota_change(ip, -(s64)btotal, ip->i_inode.i_uid,
 				  ip->i_inode.i_gid);
 		inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
-		gfs2_trans_add_meta(ip->i_gl, dibh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		up_write(&ip->i_rw_mutex);
 		gfs2_trans_end(sdp);
@@ -2031,7 +2031,7 @@ static int trunc_end(struct gfs2_inode *ip)
 	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 	ip->i_diskflags &= ~GFS2_DIF_TRUNC_IN_PROG;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -2136,7 +2136,7 @@ static int do_grow(struct inode *inode, u64 size)
 
 	truncate_setsize(inode, size);
 	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -2387,7 +2387,7 @@ static int stuffed_zero_range(struct inode *inode, loff_t offset, loff_t length)
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (error)
 		return error;
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	memset(dibh->b_data + sizeof(struct gfs2_dinode) + offset, 0,
 	       length);
 	brelse(dibh);
diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 95050e719..63a520ea4 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -57,9 +57,9 @@ static int gfs2_drevalidate(struct inode *dir, const struct qstr *name,
 	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL)
 		return 1;
 
-	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
+	had_lock = (gfs2_glock_is_locked_by_me(gfs2_inode_glock(dip)) != NULL);
 	if (!had_lock) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+		error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_SHARED, 0, &d_gh);
 		if (error)
 			return 0;
 	}
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0237b36b9..6c9f0141d 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -92,8 +92,8 @@ int gfs2_dir_get_new_buffer(struct gfs2_inode *ip, u64 block,
 {
 	struct buffer_head *bh;
 
-	bh = gfs2_meta_new(ip->i_gl, block);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	bh = gfs2_meta_new(gfs2_inode_glock(ip), block);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_JD, GFS2_FORMAT_JD);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
 	*bhp = bh;
@@ -106,7 +106,7 @@ static int gfs2_dir_get_existing_buffer(struct gfs2_inode *ip, u64 block,
 	struct buffer_head *bh;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, block, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(gfs2_inode_glock(ip), block, DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
 	if (gfs2_metatype_check(GFS2_SB(&ip->i_inode), bh, GFS2_METATYPE_JD)) {
@@ -127,7 +127,7 @@ static int gfs2_dir_write_stuffed(struct gfs2_inode *ip, const char *buf,
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	memcpy(dibh->b_data + offset + sizeof(struct gfs2_dinode), buf, size);
 	if (ip->i_inode.i_size < offset + size)
 		i_size_write(&ip->i_inode, offset + size);
@@ -208,7 +208,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 		if (error)
 			goto fail;
 
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 		memcpy(bh->b_data + o, buf, amount);
 		brelse(bh);
 
@@ -230,7 +230,7 @@ static int gfs2_dir_write_data(struct gfs2_inode *ip, const char *buf,
 		i_size_write(&ip->i_inode, offset + copied);
 	inode_set_mtime_to_ts(&ip->i_inode, inode_set_ctime_current(&ip->i_inode));
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	gfs2_dinode_out(ip, dibh->b_data);
 	brelse(dibh);
 
@@ -299,9 +299,9 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 			if (error || !dblock)
 				goto fail;
 			BUG_ON(extlen < 1);
-			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+			bh = gfs2_meta_ra(gfs2_inode_glock(ip), dblock, extlen);
 		} else {
-			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
+			error = gfs2_meta_read(gfs2_inode_glock(ip), dblock, DIO_WAIT, 0, &bh);
 			if (error)
 				goto fail;
 		}
@@ -679,7 +679,7 @@ static void dirent_del(struct gfs2_inode *dip, struct buffer_head *bh,
 		return;
 	}
 
-	gfs2_trans_add_meta(dip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(dip), bh);
 
 	/* If there is no prev entry, this is the first entry in the block.
 	   The de_rec_len is already as big as it needs to be.  Just zero
@@ -718,7 +718,7 @@ static struct gfs2_dirent *do_init_dirent(struct inode *inode,
 
 	totlen = be16_to_cpu(dent->de_rec_len);
 	BUG_ON(offset + name->len > totlen);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	ndent = (struct gfs2_dirent *)((char *)dent + offset);
 	dent->de_rec_len = cpu_to_be16(offset);
 	gfs2_qstr2dirent(name, totlen - offset, ndent);
@@ -761,7 +761,7 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 {
 	int error;
 
-	error = gfs2_meta_read(dip->i_gl, leaf_no, DIO_WAIT, 0, bhp);
+	error = gfs2_meta_read(gfs2_inode_glock(dip), leaf_no, DIO_WAIT, 0, bhp);
 	if (!error && gfs2_metatype_check(GFS2_SB(&dip->i_inode), *bhp, GFS2_METATYPE_LF)) {
 		/* pr_info("block num=%llu\n", leaf_no); */
 		error = -EIO;
@@ -875,12 +875,12 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 	error = gfs2_alloc_blocks(ip, &bn, &n, 0);
 	if (error)
 		return NULL;
-	bh = gfs2_meta_new(ip->i_gl, bn);
+	bh = gfs2_meta_new(gfs2_inode_glock(ip), bn);
 	if (!bh)
 		return NULL;
 
 	gfs2_trans_remove_revoke(GFS2_SB(inode), bn, 1);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_LF, GFS2_FORMAT_LF);
 	leaf = (struct gfs2_leaf *)bh->b_data;
 	leaf->lf_depth = cpu_to_be16(depth);
@@ -968,7 +968,7 @@ static int dir_make_exhash(struct inode *inode)
 	/*  We're done with the new leaf block, now setup the new
 	    hash table.  */
 
-	gfs2_trans_add_meta(dip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(dip), dibh);
 	gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
 
 	lp = (__be64 *)(dibh->b_data + sizeof(struct gfs2_dinode));
@@ -1025,7 +1025,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 		return 1; /* can't split */
 	}
 
-	gfs2_trans_add_meta(dip->i_gl, obh);
+	gfs2_trans_add_meta(gfs2_inode_glock(dip), obh);
 
 	nleaf = new_leaf(inode, &nbh, be16_to_cpu(oleaf->lf_depth) + 1);
 	if (!nleaf) {
@@ -1118,7 +1118,7 @@ static int dir_split_leaf(struct inode *inode, const struct qstr *name)
 
 	error = gfs2_meta_inode_buffer(dip, &dibh);
 	if (!gfs2_assert_withdraw(GFS2_SB(&dip->i_inode), !error)) {
-		gfs2_trans_add_meta(dip->i_gl, dibh);
+		gfs2_trans_add_meta(gfs2_inode_glock(dip), dibh);
 		gfs2_add_inode_blocks(&dip->i_inode, 1);
 		gfs2_dinode_out(dip, dibh->b_data);
 		brelse(dibh);
@@ -1481,7 +1481,7 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 			       struct file_ra_state *f_ra)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	struct buffer_head *bh;
 	u64 blocknr = 0, last;
 	unsigned count;
@@ -1745,7 +1745,7 @@ static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 			return error;
 	} while(1);
 
-	gfs2_trans_add_meta(ip->i_gl, obh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), obh);
 
 	leaf = new_leaf(inode, &bh, be16_to_cpu(oleaf->lf_depth));
 	if (!leaf) {
@@ -1760,7 +1760,7 @@ static int dir_new_leaf(struct inode *inode, const struct qstr *name)
 	error = gfs2_meta_inode_buffer(ip, &bh);
 	if (error)
 		return error;
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	gfs2_add_inode_blocks(&ip->i_inode, 1);
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
@@ -1946,7 +1946,7 @@ int gfs2_dir_mvino(struct gfs2_inode *dip, const struct qstr *filename,
 	if (IS_ERR(dent))
 		return PTR_ERR(dent);
 
-	gfs2_trans_add_meta(dip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(dip), bh);
 	gfs2_inum_out(nip, dent);
 	dent->de_type = cpu_to_be16(new_type);
 	brelse(bh);
@@ -2066,7 +2066,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
 	if (error)
 		goto out_end_trans;
 
-	gfs2_trans_add_meta(dip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(dip), dibh);
 	/* On the last dealloc, make this a regular file in case we crash.
 	   (We don't want to free these blocks a second time.)  */
 	if (last_dealloc)
diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394c..e78c8e62a 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -109,7 +109,7 @@ static int gfs2_get_name(struct dentry *parent, char *name,
 	gnfd.inum.no_addr = ip->i_no_addr;
 	gnfd.inum.no_formal_ino = ip->i_no_formal_ino;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_SHARED, 0, &gh);
 	if (error)
 		return error;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b8c10de11..c079ef5e3 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -63,7 +63,7 @@ static loff_t gfs2_llseek(struct file *file, loff_t offset, int whence)
 
 	switch (whence) {
 	case SEEK_END:
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (!error) {
 			error = generic_file_llseek(file, offset, whence);
@@ -109,7 +109,7 @@ static int gfs2_readdir(struct file *file, struct dir_context *ctx)
 	struct gfs2_holder d_gh;
 	int error;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_SHARED, 0, &d_gh);
 	if (error)
 		return error;
 
@@ -166,7 +166,7 @@ int gfs2_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (d_is_special(dentry))
 		return -ENOTTY;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 	error = gfs2_glock_nq(&gh);
 	if (error)
 		goto out_uninit;
@@ -225,7 +225,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	int error;
 	u32 new_flags, flags;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 	if (error)
 		return error;
 
@@ -242,7 +242,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	}
 	if ((flags ^ new_flags) & GFS2_DIF_JDATA) {
 		if (new_flags & GFS2_DIF_JDATA)
-			gfs2_log_flush(sdp, ip->i_gl,
+			gfs2_log_flush(sdp, gfs2_inode_glock(ip),
 				       GFS2_LOG_HEAD_FLUSH_NORMAL |
 				       GFS2_LFC_SET_FLAGS);
 		error = filemap_fdatawrite(inode->i_mapping);
@@ -262,7 +262,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 	if (error)
 		goto out_trans_end;
 	inode_set_ctime_current(inode);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	ip->i_diskflags = new_flags;
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
@@ -430,7 +430,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	sb_start_pagefault(inode->i_sb);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
 		ret = vmf_fs_error(err);
@@ -455,7 +455,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	gfs2_size_hint(vmf->vma->vm_file, pos, length);
 
-	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
+	set_bit(GLF_DIRTY, &gfs2_inode_glock(ip)->gl_flags);
 	set_bit(GIF_SW_PAGED, &ip->i_flags);
 
 	/*
@@ -557,7 +557,7 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err;
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
 		ret = vmf_fs_error(err);
@@ -597,7 +597,7 @@ static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
 		struct gfs2_holder i_gh;
 		int error;
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (error)
 			return error;
@@ -680,7 +680,7 @@ static int gfs2_open(struct inode *inode, struct file *file)
 	bool need_unlock = false;
 
 	if (S_ISREG(ip->i_inode.i_mode)) {
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY,
 					   &i_gh);
 		if (error)
 			return error;
@@ -767,7 +767,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 			ret = file_write_and_wait(file);
 		if (ret)
 			return ret;
-		gfs2_ail_flush(ip->i_gl, 1);
+		gfs2_ail_flush(gfs2_inode_glock(ip), 1);
 	}
 
 	if (mapping->nrpages)
@@ -837,7 +837,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_DEFERRED, 0, gh);
 retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
@@ -900,7 +900,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	 * unfortunately, have the option of only flushing a range like the
 	 * VFS does.
 	 */
-	gfs2_holder_init(ip->i_gl, LM_ST_DEFERRED, 0, gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_DEFERRED, 0, gh);
 retry:
 	ret = gfs2_glock_nq(gh);
 	if (ret)
@@ -980,7 +980,7 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			return ret;
 	}
 	ip = GFS2_I(iocb->ki_filp->f_mapping->host);
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 retry:
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
@@ -1034,7 +1034,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 			return -ENOMEM;
 	}
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, gh);
 	if (should_fault_in_pages(from, iocb, &prev_count, &window_size)) {
 retry:
 		window_size -= fault_in_iov_iter_readable(from, window_size);
@@ -1051,7 +1051,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	if (inode == sdp->sd_rindex) {
 		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 
-		ret = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE,
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(m_ip), LM_ST_EXCLUSIVE,
 					 GL_NOCACHE, statfs_gh);
 		if (ret)
 			goto out_unlock;
@@ -1112,7 +1112,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	gfs2_size_hint(file, iocb->ki_pos, iov_iter_count(from));
 
 	if (iocb->ki_flags & IOCB_APPEND) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 		if (ret)
 			return ret;
 		gfs2_glock_dq_uninit(&gh);
@@ -1189,7 +1189,7 @@ static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len)
 	if (unlikely(error))
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 
 	if (gfs2_is_stuffed(ip)) {
 		error = gfs2_unstuff_dinode(ip);
@@ -1390,7 +1390,7 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	inode_lock(inode);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 	ret = gfs2_glock_nq(&gh);
 	if (ret)
 		goto out_uninit;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b8a144d3a..7e1ca46ce 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -918,7 +918,7 @@ static void gfs2_try_to_evict(struct gfs2_glock *gl)
 		/* If the inode was evicted, gl->gl_object will now be NULL. */
 		ip = gfs2_grab_existing_inode(gl);
 		if (ip) {
-			gfs2_glock_poke(ip->i_gl);
+			gfs2_glock_poke(gfs2_inode_glock(ip));
 			iput(&ip->i_inode);
 		}
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424e..1a0f74852 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -603,7 +603,7 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-	struct gfs2_glock *j_gl = ip->i_gl;
+	struct gfs2_glock *j_gl = gfs2_inode_glock(ip);
 	struct gfs2_log_header_host head;
 	int error;
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 614657778..615920463 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -392,7 +392,7 @@ struct gfs2_inode {
 	u64 i_generation;
 	u64 i_eattr;
 	unsigned long i_flags;		/* GIF_... */
-	struct gfs2_glock *i_gl;
+	struct gfs2_glock __rcu *i_gl;
 	struct gfs2_holder i_iopen_gh;
 	struct gfs2_qadata *i_qadata; /* quota allocation data */
 	struct gfs2_holder i_rgd_gh;
@@ -878,5 +878,13 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 	return GFS2_SB(&ip->i_inode)->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 }
 
-#endif /* __INCORE_DOT_H__ */
 
+static inline struct gfs2_glock *gfs2_inode_glock(const struct gfs2_inode *ip)
+{
+	/*
+	 * i_gl is set once at instantiation and only NULLed at evict,
+	 * so it is stable for any live inode.
+	 */
+	return rcu_dereference_protected(ip->i_gl, 1);
+}
+#endif /* __INCORE_DOT_H__ */
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a77794bb..2a849f847 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -146,8 +146,10 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		int extra_flags = 0;
 
 		gfs2_setup_inode(inode);
-		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE,
-				       &ip->i_gl);
+		{ struct gfs2_glock *gl;
+		error = gfs2_glock_get(sdp, no_addr, &gfs2_inode_glops, CREATE, &gl);
+		if (!error)
+			rcu_assign_pointer(ip->i_gl, gl); }
 		if (unlikely(error))
 			goto fail;
 
@@ -178,14 +180,14 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 			 * block.  We read the inode when instantiating it
 			 * after possibly checking the block type.
 			 */
-			error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE,
+			error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE,
 						   GL_SKIP, &i_gh);
 			if (error)
 				goto fail;
 
 			error = -ESTALE;
 			if (no_formal_ino &&
-			    gfs2_inode_already_deleted(ip->i_gl, no_formal_ino))
+			    gfs2_inode_already_deleted(gfs2_inode_glock(ip), no_formal_ino))
 				goto fail;
 
 			if (blktype != GFS2_BLKST_FREE) {
@@ -196,20 +198,20 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 			}
 		}
 
-		set_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
+		set_bit(GLF_INSTANTIATE_NEEDED, &gfs2_inode_glock(ip)->gl_flags);
 
 		/* Lowest possible timestamp; will be overwritten in gfs2_dinode_in. */
 		inode_set_atime(inode,
 				1LL << (8 * sizeof(inode_get_atime_sec(inode)) - 1),
 				0);
 
-		glock_set_object(ip->i_gl, ip);
+		glock_set_object(gfs2_inode_glock(ip), ip);
 
 		if (type == DT_UNKNOWN) {
 			/* Inode glock must be locked already */
 			error = gfs2_instantiate(&i_gh);
 			if (error) {
-				glock_clear_object(ip->i_gl, ip);
+				glock_clear_object(gfs2_inode_glock(ip), ip);
 				goto fail;
 			}
 		} else {
@@ -240,9 +242,9 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 	if (gfs2_holder_initialized(&i_gh))
 		gfs2_glock_dq_uninit(&i_gh);
-	if (ip->i_gl) {
-		gfs2_glock_put(ip->i_gl);
-		ip->i_gl = NULL;
+	if (gfs2_inode_glock(ip)) {
+		gfs2_glock_put(gfs2_inode_glock(ip));
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 	iget_failed(inode);
 	return ERR_PTR(error);
@@ -339,8 +341,8 @@ struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 		return dir;
 	}
 
-	if (gfs2_glock_is_locked_by_me(dip->i_gl) == NULL) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	if (gfs2_glock_is_locked_by_me(gfs2_inode_glock(dip)) == NULL) {
+		error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_SHARED, 0, &d_gh);
 		if (error)
 			return ERR_PTR(error);
 	}
@@ -456,7 +458,7 @@ static int alloc_dinode(struct gfs2_inode *ip, u32 flags, unsigned *dblocks)
 static void gfs2_final_release_pages(struct gfs2_inode *ip)
 {
 	struct inode *inode = &ip->i_inode;
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 
 	/* This can only happen during incomplete inode creation. */
 	if (unlikely(!gl))
@@ -550,8 +552,8 @@ static void gfs2_init_xattr(struct gfs2_inode *ip)
 	struct buffer_head *bh;
 	struct gfs2_ea_header *ea;
 
-	bh = gfs2_meta_new(ip->i_gl, ip->i_eattr);
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	bh = gfs2_meta_new(gfs2_inode_glock(ip), ip->i_eattr);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
 
@@ -577,8 +579,8 @@ static void init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
 	struct gfs2_dinode *di;
 	struct buffer_head *dibh;
 
-	dibh = gfs2_meta_new(ip->i_gl, ip->i_no_addr);
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	dibh = gfs2_meta_new(gfs2_inode_glock(ip), ip->i_no_addr);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_dinode_out(ip, di);
 
@@ -726,7 +728,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail;
 
-	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_EXCLUSIVE, 0, &d_gh);
 	if (error)
 		goto fail;
 	gfs2_holder_mark_uninitialized(&gh);
@@ -832,7 +834,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	gfs2_set_inode_blocks(inode, blocks);
 
-	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
+	{ struct gfs2_glock *gl; error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &gl); if (!error) rcu_assign_pointer(ip->i_gl, gl); }
 	if (error)
 		goto fail_dealloc_inode;
 
@@ -854,10 +856,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock2;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, &gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, GL_SKIP, &gh);
 	if (error)
 		goto fail_gunlock3;
-	clear_bit(GLF_INSTANTIATE_NEEDED, &ip->i_gl->gl_flags);
+	clear_bit(GLF_INSTANTIATE_NEEDED, &gfs2_inode_glock(ip)->gl_flags);
 
 	error = gfs2_trans_begin(sdp, blocks, 0);
 	if (error)
@@ -870,7 +872,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	init_dinode(dip, ip, symname);
 	gfs2_trans_end(sdp);
 
-	glock_set_object(ip->i_gl, ip);
+	glock_set_object(gfs2_inode_glock(ip), ip);
 	glock_set_object(io_gl, ip);
 	gfs2_set_iop(inode);
 
@@ -914,7 +916,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	return error;
 
 fail_gunlock4:
-	glock_clear_object(ip->i_gl, ip);
+	glock_clear_object(gfs2_inode_glock(ip), ip);
 	glock_clear_object(io_gl, ip);
 fail_gunlock3:
 	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
@@ -932,9 +934,9 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		fs_warn(sdp, "%s: %d\n", __func__, dealloc_error);
 	ip->i_no_addr = 0;
 fail_free_inode:
-	if (ip->i_gl) {
-		gfs2_glock_put(ip->i_gl);
-		ip->i_gl = NULL;
+	if (gfs2_inode_glock(ip)) {
+		gfs2_glock_put(gfs2_inode_glock(ip));
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 	gfs2_rs_deltree(&ip->i_res);
 	gfs2_qa_put(ip);
@@ -997,7 +999,7 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	if (inode == NULL || IS_ERR(inode))
 		return d_splice_alias(inode, dentry);
 
-	gl = GFS2_I(inode)->i_gl;
+	gl = gfs2_inode_glock(GFS2_I(inode));
 	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
 	if (error) {
 		iput(inode);
@@ -1057,8 +1059,8 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		return error;
 
-	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(dip), LM_ST_EXCLUSIVE, 0, &d_gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 
 	error = gfs2_glock_nq(&d_gh);
 	if (error)
@@ -1131,7 +1133,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		goto out_brelse;
 
-	gfs2_trans_add_meta(ip->i_gl, dibh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 	inc_nlink(&ip->i_inode);
 	inode_set_ctime_current(&ip->i_inode);
 	ihold(inode);
@@ -1257,8 +1259,8 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
 
 	error = -EROFS;
 
-	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, &d_gh);
-	gfs2_holder_init(ip->i_gl,  LM_ST_EXCLUSIVE, 0, &gh);
+	gfs2_holder_init(gfs2_inode_glock(dip), LM_ST_EXCLUSIVE, 0, &d_gh);
+	gfs2_holder_init(gfs2_inode_glock(ip),  LM_ST_EXCLUSIVE, 0, &gh);
 
 	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
 	if (!rgd)
@@ -1532,17 +1534,17 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 	}
 
 	num_gh = 1;
-	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
+	gfs2_holder_init(gfs2_inode_glock(odip), LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
 	if (odip != ndip) {
-		gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE,GL_ASYNC,
+		gfs2_holder_init(gfs2_inode_glock(ndip), LM_ST_EXCLUSIVE,GL_ASYNC,
 				 ghs + num_gh);
 		num_gh++;
 	}
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
 	if (nip) {
-		gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC,
+		gfs2_holder_init(gfs2_inode_glock(nip), LM_ST_EXCLUSIVE, GL_ASYNC,
 				 ghs + num_gh);
 		num_gh++;
 	}
@@ -1778,16 +1780,16 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 	}
 
 	num_gh = 1;
-	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
+	gfs2_holder_init(gfs2_inode_glock(odip), LM_ST_EXCLUSIVE, GL_ASYNC, ghs);
 	if (odip != ndip) {
-		gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC,
+		gfs2_holder_init(gfs2_inode_glock(ndip), LM_ST_EXCLUSIVE, GL_ASYNC,
 				 ghs + num_gh);
 		num_gh++;
 	}
-	gfs2_holder_init(oip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(oip), LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
-	gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
+	gfs2_holder_init(gfs2_inode_glock(nip), LM_ST_EXCLUSIVE, GL_ASYNC, ghs + num_gh);
 	num_gh++;
 
 again:
@@ -1918,7 +1920,7 @@ static const char *gfs2_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+	gfs2_holder_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &i_gh);
 	error = gfs2_glock_nq(&i_gh);
 	if (error) {
 		gfs2_holder_uninit(&i_gh);
@@ -2108,7 +2110,7 @@ static int gfs2_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out;
 
@@ -2168,8 +2170,8 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
 	int error;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip)) == NULL) {
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY, &gh);
 		if (error)
 			return error;
 	}
@@ -2212,7 +2214,7 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	inode_lock_shared(inode);
 
 retry:
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 	if (ret)
 		goto out;
 
@@ -2240,7 +2242,7 @@ loff_t gfs2_seek_data(struct file *file, loff_t offset)
 	loff_t ret;
 
 	inode_lock_shared(inode);
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 	if (!ret)
 		ret = iomap_seek_data(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
@@ -2259,7 +2261,7 @@ loff_t gfs2_seek_hole(struct file *file, loff_t offset)
 	loff_t ret;
 
 	inode_lock_shared(inode);
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &gh);
 	if (!ret)
 		ret = iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
 	gfs2_glock_dq_uninit(&gh);
@@ -2274,7 +2276,7 @@ static int gfs2_update_time(struct inode *inode, enum fs_update_time type,
 		unsigned int flags)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	struct gfs2_holder *gh;
 	int error;
 
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad..c4d9646fb 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -777,7 +777,7 @@ static int buf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 {
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	unsigned int blks = be32_to_cpu(ld->ld_data1);
 	struct buffer_head *bh_log, *bh_ip;
 	u64 blkno;
@@ -832,13 +832,13 @@ static void buf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
 	if (error) {
-		gfs2_inode_metasync(ip->i_gl);
+		gfs2_inode_metasync(gfs2_inode_glock(ip));
 		return;
 	}
 	if (pass != 1)
 		return;
 
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gfs2_inode_glock(ip));
 
 	fs_info(sdp, "jid=%u: Replayed %u of %u blocks\n",
 	        jd->jd_jid, jd->jd_replayed_blocks, jd->jd_found_blocks);
@@ -1001,7 +1001,7 @@ static int databuf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 				    __be64 *ptr, int pass)
 {
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	unsigned int blks = be32_to_cpu(ld->ld_data1);
 	struct buffer_head *bh_log, *bh_ip;
 	u64 blkno;
@@ -1052,14 +1052,14 @@ static void databuf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 
 	if (error) {
-		gfs2_inode_metasync(ip->i_gl);
+		gfs2_inode_metasync(gfs2_inode_glock(ip));
 		return;
 	}
 	if (pass != 1)
 		return;
 
 	/* data sync? */
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gfs2_inode_glock(ip));
 
 	fs_info(sdp, "jid=%u: Replayed %u of %u data blocks\n",
 		jd->jd_jid, jd->jd_replayed_blocks, jd->jd_found_blocks);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index a87cfbf0d..bdb7c589a 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -407,13 +407,13 @@ void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 	int ty;
 
 	/* This can only happen during incomplete inode creation. */
-	if (!ip->i_gl)
+	if (!gfs2_inode_glock(ip))
 		return;
 
 	gfs2_ail1_wipe(sdp, bstart, blen);
 	while (blen) {
 		ty = REMOVE_META;
-		bh = gfs2_getbuf(ip->i_gl, bstart, NO_CREATE);
+		bh = gfs2_getbuf(gfs2_inode_glock(ip), bstart, NO_CREATE);
 		if (!bh && gfs2_is_jdata(ip)) {
 			bh = gfs2_getjdatabuf(ip, bstart);
 			ty = REMOVE_JDATA;
@@ -448,7 +448,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 		     struct buffer_head **bhp)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	struct buffer_head *bh;
 	int ret = 0;
 	int rahead = 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9b9e70f14..4c738b4de 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -543,7 +543,7 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 	mutex_lock(&sdp->sd_jindex_mutex);
 
 	for (;;) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, ji_gh);
+		error = gfs2_glock_nq_init(gfs2_inode_glock(dip), LM_ST_SHARED, 0, ji_gh);
 		if (error)
 			break;
 
@@ -655,7 +655,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 	iput(pn);
 	pn = NULL;
 	ip = GFS2_I(sdp->sd_sc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, GL_NOPID,
 				   &sdp->sd_sc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
@@ -750,7 +750,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		}
 
 		ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED,
 					   LM_FLAG_RECOVER | GL_EXACT |
 					   GL_NOCACHE | GL_NOPID,
 					   &sdp->sd_jinode_gh);
@@ -919,7 +919,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	pn = NULL;
 
 	ip = GFS2_I(sdp->sd_qc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, GL_NOPID,
 				   &sdp->sd_qc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"qc\" file: %d\n", error);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 91e9975d2..4c9917bf4 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -434,7 +434,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 	if (iomap.type != IOMAP_MAPPED)
 		return error;
 
-	error = gfs2_meta_read(ip->i_gl, iomap.addr >> inode->i_blkbits,
+	error = gfs2_meta_read(gfs2_inode_glock(ip), iomap.addr >> inode->i_blkbits,
 			       DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
@@ -692,7 +692,7 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change)
 	bool needs_put = false;
 	s64 x;
 
-	gfs2_trans_add_meta(ip->i_gl, qd->qd_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), qd->qd_bh);
 
 	/*
 	 * The QDF_CHANGE flag indicates that the slot in the quota change file
@@ -780,7 +780,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 			set_buffer_uptodate(bh);
 		if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
 			goto unlock_out;
-		gfs2_trans_add_data(ip->i_gl, bh);
+		gfs2_trans_add_data(gfs2_inode_glock(ip), bh);
 
 		/* If we need to write to the next block as well */
 		if (to_write > (bsize - boff)) {
@@ -935,7 +935,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 			goto out_dq;
 	}
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out_dq;
 
@@ -993,7 +993,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		gfs2_glock_dq_uninit(&ghs[qx]);
 	inode_unlock(&ip->i_inode);
 	kfree(ghs);
-	gfs2_log_flush(glock_sbd(ip->i_gl), ip->i_gl,
+	gfs2_log_flush(glock_sbd(gfs2_inode_glock(ip)), gfs2_inode_glock(ip),
 		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
 		for (x = 0; x < num_qd; x++) {
@@ -1062,7 +1062,7 @@ static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 		if (error)
 			return error;
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &i_gh);
 		if (error)
 			goto fail;
 
@@ -1439,7 +1439,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 				goto fail;
 		}
 		error = -EIO;
-		bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+		bh = gfs2_meta_ra(gfs2_inode_glock(ip), dblock, extlen);
 		if (!bh)
 			goto fail;
 		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
@@ -1745,7 +1745,7 @@ static int gfs2_set_dqblk(struct super_block *sb, struct kqid qid,
 	error = gfs2_glock_nq_init(qd->qd_gl, LM_ST_EXCLUSIVE, 0, &q_gh);
 	if (error)
 		goto out_unlockput;
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &i_gh);
 	if (error)
 		goto out_q;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 616c46aa3..9ee0250da 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -33,7 +33,7 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 			   struct buffer_head **bh)
 {
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	u64 dblock;
 	u32 extlen;
 	int error;
@@ -345,7 +345,7 @@ static int update_statfs_inode(struct gfs2_jdesc *jd,
 
 	mark_buffer_dirty(bh);
 	brelse(bh);
-	gfs2_inode_metasync(ip->i_gl);
+	gfs2_inode_metasync(gfs2_inode_glock(ip));
 
 out:
 	return error;
@@ -440,7 +440,7 @@ void gfs2_recover_func(struct work_struct *work)
 			goto fail;
 		}
 
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED,
 					   LM_FLAG_RECOVER | GL_NOCACHE,
 					   &ji_gh);
 		if (error)
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 5988a165a..643c0c209 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1034,7 +1034,7 @@ static int gfs2_ri_update(struct gfs2_inode *ip)
 int gfs2_rindex_update(struct gfs2_sbd *sdp)
 {
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_rindex);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	struct gfs2_holder ri_gh;
 	int error = 0;
 	int unlock_required = 0;
@@ -2453,7 +2453,7 @@ int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
 		if (error == 0) {
 			struct gfs2_dinode *di =
 				(struct gfs2_dinode *)dibh->b_data;
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 			di->di_goal_meta = di->di_goal_data =
 				cpu_to_be64(ip->i_goal);
 			brelse(dibh);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 4d854556b..7c2adb97d 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -133,7 +133,7 @@ int gfs2_jdesc_check(struct gfs2_jdesc *jd)
 int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 {
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-	struct gfs2_glock *j_gl = ip->i_gl;
+	struct gfs2_glock *j_gl = gfs2_inode_glock(ip);
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
@@ -183,7 +183,7 @@ int gfs2_statfs_init(struct gfs2_sbd *sdp)
 	struct gfs2_holder gh;
 	int error;
 
-	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+	error = gfs2_glock_nq_init(gfs2_inode_glock(m_ip), LM_ST_EXCLUSIVE, GL_NOCACHE,
 				   &gh);
 	if (error)
 		return error;
@@ -222,7 +222,7 @@ void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
 	s64 x, y;
 	int need_sync = 0;
 
-	gfs2_trans_add_meta(l_ip->i_gl, sdp->sd_sc_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(l_ip), sdp->sd_sc_bh);
 
 	spin_lock(&sdp->sd_statfs_spin);
 	l_sc->sc_total += total;
@@ -249,8 +249,8 @@ void update_statfs(struct gfs2_sbd *sdp, struct buffer_head *m_bh)
 	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
 	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 
-	gfs2_trans_add_meta(l_ip->i_gl, sdp->sd_sc_bh);
-	gfs2_trans_add_meta(m_ip->i_gl, m_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(l_ip), sdp->sd_sc_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(m_ip), m_bh);
 
 	spin_lock(&sdp->sd_statfs_spin);
 	m_sc->sc_total += l_sc->sc_total;
@@ -273,7 +273,7 @@ int gfs2_statfs_sync(struct super_block *sb, int type)
 	struct buffer_head *m_bh;
 	int error;
 
-	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+	error = gfs2_glock_nq_init(gfs2_inode_glock(m_ip), LM_ST_EXCLUSIVE, GL_NOCACHE,
 				   &gh);
 	if (error)
 		goto out;
@@ -342,7 +342,7 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 			goto out;
 		}
 		ip = GFS2_I(jd->jd_inode);
-		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &lfcc->gh);
+		error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, 0, &lfcc->gh);
 		if (error) {
 			kfree(lfcc);
 			goto out;
@@ -440,13 +440,13 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	struct address_space *metamapping = gfs2_glock2aspace(ip->i_gl);
+	struct address_space *metamapping = gfs2_glock2aspace(gfs2_inode_glock(ip));
 	struct backing_dev_info *bdi = inode_to_bdi(metamapping->host);
 	int ret = 0;
 	bool flush_all = (wbc->sync_mode == WB_SYNC_ALL || gfs2_is_jdata(ip));
 
 	if (flush_all)
-		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
+		gfs2_log_flush(GFS2_SB(inode), gfs2_inode_glock(ip),
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
 	if (bdi_wb_dirty_exceeded(bdi))
@@ -490,20 +490,20 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 	int ret;
 
 	/* This can only happen during incomplete inode creation. */
-	if (unlikely(!ip->i_gl))
+	if (unlikely(!gfs2_inode_glock(ip)))
 		return;
 
 	if (gfs2_withdrawn(sdp))
 		return;
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip))) {
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret) {
 			fs_err(sdp, "dirty_inode: glock %d\n", ret);
-			gfs2_dump_glock(NULL, ip->i_gl, true);
+			gfs2_dump_glock(NULL, gfs2_inode_glock(ip), true);
 			return;
 		}
 		need_unlock = 1;
-	} else if (WARN_ON_ONCE(ip->i_gl->gl_state != LM_ST_EXCLUSIVE))
+	} else if (WARN_ON_ONCE(gfs2_inode_glock(ip)->gl_state != LM_ST_EXCLUSIVE))
 		return;
 
 	if (current->journal_info == NULL) {
@@ -517,7 +517,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 
 	ret = gfs2_meta_inode_buffer(ip, &bh);
 	if (ret == 0) {
-		gfs2_trans_add_meta(ip->i_gl, bh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 		gfs2_dinode_out(ip, bh->b_data);
 		brelse(bh);
 	}
@@ -1211,11 +1211,11 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 
 	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
 		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
-		glock_needs_demote(ip->i_gl),
+		glock_needs_demote(gfs2_inode_glock(ip)),
 		5 * HZ);
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
-		if (glock_needs_demote(ip->i_gl))
+		if (glock_needs_demote(gfs2_inode_glock(ip)))
 			return EVICT_SHOULD_SKIP_DELETE;
 		return EVICT_SHOULD_DEFER_DELETE;
 	}
@@ -1255,11 +1255,11 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Must not read inode block until block type has been verified */
-	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, gh);
+	ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, GL_SKIP, gh);
 	if (unlikely(ret))
 		return EVICT_SHOULD_SKIP_DELETE;
 
-	if (gfs2_inode_already_deleted(ip->i_gl, ip->i_no_formal_ino))
+	if (gfs2_inode_already_deleted(gfs2_inode_glock(ip), ip->i_no_formal_ino))
 		return EVICT_SHOULD_SKIP_DELETE;
 	ret = gfs2_check_blk_type(sdp, ip->i_no_addr, GFS2_BLKST_UNLINKED);
 	if (ret)
@@ -1289,7 +1289,7 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 static int evict_unlinked_inode(struct inode *inode, struct gfs2_holder *gh)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	int ret;
 
 	/* The inode glock must be held exclusively and be instantiated. */
@@ -1391,7 +1391,7 @@ static int evict_linked_inode(struct inode *inode, struct gfs2_holder *gh)
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_glock *gl = ip->i_gl;
+	struct gfs2_glock *gl = gfs2_inode_glock(ip);
 	struct address_space *metamapping = gfs2_glock2aspace(gl);
 	int ret;
 
@@ -1452,7 +1452,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	int ret;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	if (sb_rdonly(sb) || !ip->i_no_addr || !ip->i_gl)
+	if (sb_rdonly(sb) || !ip->i_no_addr || !gfs2_inode_glock(ip))
 		goto out;
 
 	/*
@@ -1505,10 +1505,10 @@ static void gfs2_evict_inode(struct inode *inode)
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 		gfs2_glock_put_eventually(gl);
 	}
-	if (ip->i_gl) {
-		glock_clear_object(ip->i_gl, ip);
+	if (gfs2_inode_glock(ip)) {
+		glock_clear_object(gfs2_inode_glock(ip), ip);
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
-		gfs2_glock_put_eventually(ip->i_gl);
+		gfs2_glock_put_eventually(gfs2_inode_glock(ip));
 		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 }
@@ -1523,7 +1523,7 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	ip->i_no_addr = 0;
 	ip->i_no_formal_ino = 0;
 	ip->i_flags = 0;
-	ip->i_gl = NULL;
+	rcu_assign_pointer(ip->i_gl, NULL);
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
 	memset(&ip->i_res, 0, sizeof(ip->i_res));
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 6fd39fcdd..bbd8c527f 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -458,7 +458,7 @@ TRACE_EVENT(gfs2_bmap,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(gfs2_inode_glock(ip))->sd_vfs->s_dev;
 		__entry->lblock		= lblock;
 		__entry->pblock		= buffer_mapped(bh) ?  bh->b_blocknr : 0;
 		__entry->inum		= ip->i_no_addr;
@@ -494,7 +494,7 @@ TRACE_EVENT(gfs2_iomap_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(gfs2_inode_glock(ip))->sd_vfs->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->pos		= pos;
 		__entry->length		= length;
@@ -526,7 +526,7 @@ TRACE_EVENT(gfs2_iomap_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(gfs2_inode_glock(ip))->sd_vfs->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->offset		= iomap->offset;
 		__entry->length		= iomap->length;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 83b8bb644..807df4cdd 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -58,7 +58,7 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	struct gfs2_inode *ip;
 
 	ip = GFS2_I(jd->jd_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_RECOVER |
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_RECOVER |
 				   GL_EXACT | GL_NOCACHE, &j_gh);
 	if (error) {
 		if (verbose)
@@ -342,7 +342,7 @@ void gfs2_consist_inode_i(struct gfs2_inode *ip,
 		(unsigned long long)ip->i_no_formal_ino,
 		(unsigned long long)ip->i_no_addr,
 		function, file, line);
-	gfs2_dump_glock(NULL, ip->i_gl, 1);
+	gfs2_dump_glock(NULL, gfs2_inode_glock(ip), 1);
 	gfs2_withdraw(sdp);
 }
 
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index b9f48d6f1..00da7f7f0 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -132,7 +132,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 	__be64 *eablk, *end;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(gfs2_inode_glock(ip), ip->i_eattr, DIO_WAIT, 0, &bh);
 	if (error)
 		return error;
 
@@ -156,7 +156,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 			break;
 		bn = be64_to_cpu(*eablk);
 
-		error = gfs2_meta_read(ip->i_gl, bn, DIO_WAIT, 0, &eabh);
+		error = gfs2_meta_read(gfs2_inode_glock(ip), bn, DIO_WAIT, 0, &eabh);
 		if (error)
 			break;
 		error = ea_foreach_i(ip, eabh, ea_call, data);
@@ -279,7 +279,7 @@ static int ea_dealloc_unstuffed(struct gfs2_inode *ip, struct buffer_head *bh,
 	if (error)
 		goto out_gunlock;
 
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 
 	dataptrs = GFS2_EA2DATAPTRS(ea);
 	for (x = 0; x < ea->ea_num_ptrs; x++, dataptrs++) {
@@ -426,7 +426,7 @@ ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		er.er_data_len = size;
 	}
 
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	error = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
 	if (error)
 		return error;
 
@@ -472,7 +472,7 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		return -ENOMEM;
 
 	for (x = 0; x < nptrs; x++) {
-		error = gfs2_meta_read(ip->i_gl, be64_to_cpu(*dataptrs), 0, 0,
+		error = gfs2_meta_read(gfs2_inode_glock(ip), be64_to_cpu(*dataptrs), 0, 0,
 				       bh + x);
 		if (error) {
 			while (x--)
@@ -505,7 +505,7 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		}
 
 		if (din) {
-			gfs2_trans_add_meta(ip->i_gl, bh[x]);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), bh[x]);
 			memcpy(pos, din, cp_size);
 			din += sdp->sd_jbsize;
 		}
@@ -614,8 +614,8 @@ static int gfs2_xattr_get(const struct xattr_handler *handler,
 
 	/* During lookup, SELinux calls this function with the glock locked. */
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (!gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip))) {
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_SHARED, LM_FLAG_ANY, &gh);
 		if (ret)
 			return ret;
 	} else {
@@ -647,8 +647,8 @@ static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 	if (error)
 		return error;
 	gfs2_trans_remove_revoke(sdp, block, 1);
-	*bhp = gfs2_meta_new(ip->i_gl, block);
-	gfs2_trans_add_meta(ip->i_gl, *bhp);
+	*bhp = gfs2_meta_new(gfs2_inode_glock(ip), block);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), *bhp);
 	gfs2_metatype_set(*bhp, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(*bhp, sizeof(struct gfs2_meta_header));
 
@@ -709,8 +709,8 @@ static int ea_write(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 			if (error)
 				return error;
 			gfs2_trans_remove_revoke(sdp, block, 1);
-			bh = gfs2_meta_new(ip->i_gl, block);
-			gfs2_trans_add_meta(ip->i_gl, bh);
+			bh = gfs2_meta_new(gfs2_inode_glock(ip), block);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 			gfs2_metatype_set(bh, GFS2_METATYPE_ED, GFS2_FORMAT_ED);
 
 			gfs2_add_inode_blocks(&ip->i_inode, 1);
@@ -845,7 +845,7 @@ static void ea_set_remove_stuffed(struct gfs2_inode *ip,
 	struct gfs2_ea_header *prev = el->el_prev;
 	u32 len;
 
-	gfs2_trans_add_meta(ip->i_gl, el->el_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), el->el_bh);
 
 	if (!prev || !GFS2_EA_IS_STUFFED(ea)) {
 		ea->ea_type = GFS2_EATYPE_UNUSED;
@@ -882,7 +882,7 @@ static int ea_set_simple_noalloc(struct gfs2_inode *ip, struct buffer_head *bh,
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), bh);
 
 	if (es->ea_split)
 		ea = ea_split_ea(ea);
@@ -906,7 +906,7 @@ static int ea_set_simple_alloc(struct gfs2_inode *ip,
 	struct gfs2_ea_header *ea = es->es_ea;
 	int error;
 
-	gfs2_trans_add_meta(ip->i_gl, es->es_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), es->es_bh);
 
 	if (es->ea_split)
 		ea = ea_split_ea(ea);
@@ -980,7 +980,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	if (ip->i_diskflags & GFS2_DIF_EA_INDIRECT) {
 		__be64 *end;
 
-		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0,
+		error = gfs2_meta_read(gfs2_inode_glock(ip), ip->i_eattr, DIO_WAIT, 0,
 				       &indbh);
 		if (error)
 			return error;
@@ -1002,7 +1002,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 			goto out;
 		}
 
-		gfs2_trans_add_meta(ip->i_gl, indbh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), indbh);
 	} else {
 		u64 blk;
 		unsigned int n = 1;
@@ -1010,8 +1010,8 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 		if (error)
 			return error;
 		gfs2_trans_remove_revoke(sdp, blk, 1);
-		indbh = gfs2_meta_new(ip->i_gl, blk);
-		gfs2_trans_add_meta(ip->i_gl, indbh);
+		indbh = gfs2_meta_new(gfs2_inode_glock(ip), blk);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), indbh);
 		gfs2_metatype_set(indbh, GFS2_METATYPE_IN, GFS2_FORMAT_IN);
 		gfs2_buffer_clear_tail(indbh, mh_size);
 
@@ -1096,7 +1096,7 @@ static int ea_remove_stuffed(struct gfs2_inode *ip, struct gfs2_ea_location *el)
 	if (error)
 		return error;
 
-	gfs2_trans_add_meta(ip->i_gl, el->el_bh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), el->el_bh);
 
 	if (prev) {
 		u32 len;
@@ -1244,12 +1244,12 @@ static int gfs2_xattr_set(const struct xattr_handler *handler,
 
 	/* May be called from gfs_setattr with the glock locked. */
 
-	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
-		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (!gfs2_glock_is_locked_by_me(gfs2_inode_glock(ip))) {
+		ret = gfs2_glock_nq_init(gfs2_inode_glock(ip), LM_ST_EXCLUSIVE, 0, &gh);
 		if (ret)
 			goto out;
 	} else {
-		if (WARN_ON_ONCE(ip->i_gl->gl_state != LM_ST_EXCLUSIVE)) {
+		if (WARN_ON_ONCE(gfs2_inode_glock(ip)->gl_state != LM_ST_EXCLUSIVE)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -1283,7 +1283,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &indbh);
+	error = gfs2_meta_read(gfs2_inode_glock(ip), ip->i_eattr, DIO_WAIT, 0, &indbh);
 	if (error)
 		return error;
 
@@ -1333,7 +1333,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 	if (error)
 		goto out_gunlock;
 
-	gfs2_trans_add_meta(ip->i_gl, indbh);
+	gfs2_trans_add_meta(gfs2_inode_glock(ip), indbh);
 
 	eablk = (__be64 *)(indbh->b_data + sizeof(struct gfs2_meta_header));
 	bstart = 0;
@@ -1367,7 +1367,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
 	if (!error) {
-		gfs2_trans_add_meta(ip->i_gl, dibh);
+		gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 		gfs2_dinode_out(ip, dibh->b_data);
 		brelse(dibh);
 	}
@@ -1419,7 +1419,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 	if (initialized) {
 		error = gfs2_meta_inode_buffer(ip, &dibh);
 		if (!error) {
-			gfs2_trans_add_meta(ip->i_gl, dibh);
+			gfs2_trans_add_meta(gfs2_inode_glock(ip), dibh);
 			gfs2_dinode_out(ip, dibh->b_data);
 			brelse(dibh);
 		}

