Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857590;
	b=tfYI1nMfauwaBu/hyXD6iT/ckWESdJ6dmdSveff2/Mc2jgUV5M1oC++/DpCzJMpuUhGC
	 ppC/lpddfaLrr4XRi9o7B0gfjjdr6qiSrx3L8kzrbh1T8+q8oH84wvscQk4Stcn+Cr2ck
	 0achMCa7FX4x2XxXNCXf1jzIJ1txKpRFX2bwfyxyAt5XB0wC4XAXfLTWLJnFZc1qmTuhf
	 amWEMewXybSvTylcQIHeAYxWi8pBhyPT8PLte4jI7uI9Vbi7xBJeFNzOsJNWdGYrbcjjJ
	 ianoOo34cuCHfQAAaccne82Dt0ph/7Ha+l05L8F3R88wio8PSWN43aziTgKHfAM9HDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857590;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KJYBuO098geltKEM54mCnRU5Y8/TDCaYnTsPMsckVXc=;
	b=H8quVrfwprkqO+KO6Gh1RTtJSIdywzlkRpq6JVjJbPU9n9lbOmQb+GRYy4XjWBBco50g
	 fMbIpqoGchRaQAYV2zkK6S4CzMajTWuO4C7TtT5fk3zfAf0qh0f7CrW/E0+lOhj2uZ60/
	 ug5rkdug/H7DWJQfFkdcEfxEwN1ZI22OZYz64IXQS3oFdiG5g4jAPAM9kN6QLUN3OKnON
	 qdSXIuEyaPKleq7HNRJ/xlyvB4vjROnElMphHAPMA5iM0xzbVrqQytmIhl/TmeRxuweNx
	 ekZg9eyKt7q0M3iCKlGPGr599wKUlZeMYaVNhRCz3wsYaOIpEzs7bOlgRIt5ywdNUcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RmoRF0TP;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17252606A330
	for <gfs2@lists.linux.dev>; Thu,  5 Nov 2026 05:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17252606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RmoRF0TP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793857586; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KJYBuO098geltKEM54mCnRU5Y8/TDCaYnTsPMsckVXc=;
	b=RmoRF0TP4UNAu/m/f7FVOFOIopCsBcQj8pySMYAu4MgyhzH+e7OWopE/2kjnpIopbR2QH0+ITPZmcwJ0FBo7OGWm5lv+jX3X/VaKSloLTcOXtGdjmngqSSBd1FVWz1lkejsxxartwdiYSTbbaVksxO8S4ZfFNFVfdODZuayv39M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0XE7iOLF_1793857584;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE7iOLF_1793857584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 13:46:24 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] gfs2: hold the master statfs glock while operating on the rindex
Date: Thu,  5 Nov 2026 13:46:09 +0800
Message-Id: <20261105054609.2759418-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
References: <20261105054609.2759418-1-joseph.qi@linux.alibaba.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writes to the rindex reach adjust_fs_space() through gfs2_iomap_end(),
which reads the master statfs block, merges the local statfs deltas into
it and dirties it again through update_statfs().
gfs2_file_buffered_write() therefore takes that glock exclusively before
writing to the rindex.

gfs2_fallocate() and gfs2_setattr() do not, so fallocate(2) and
truncate(2) on the rindex reach adjust_fs_space() with nothing held on
sd_statfs_inode.  gfs2_fallocate() admits the rindex on purpose, since
gfs2_grow reserves rindex space with it, and the rindex size is only
page aligned when the resource group count is a multiple of 64, so
gfs2_clear_beyond_eof() usually zeroes the tail of the last page there
and gfs2_iomap_end() sees IOMAP_ZERO on the rindex.  Punching a hole in
the rindex goes the same way through __gfs2_punch_hole(), and growing or
truncating it goes through gfs2_setattr_size(), which reaches
gfs2_clear_beyond_eof() in do_grow() and gfs2_block_zero_range() in
trunc_start().

Another node holding the master statfs glock can update the block while
this one works from the copy it read, and that update is lost.

Take the glock in gfs2_fallocate() and gfs2_setattr() for the rindex,
mirroring gfs2_file_buffered_write().  Both already hold the inode glock
at that point, so the acquisition order matches.

Fixes: 2257e468a63b ("gfs2: implement gfs2_block_zero_range using iomap_zero_range")
Fixes: 4982e58669b1 ("gfs2: page poisoning fix")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/gfs2/file.c  | 20 +++++++++++++++++++-
 fs/gfs2/inode.c | 24 +++++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2452d3ecf09c7..e37b9cd78d972 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1391,9 +1391,11 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_holder gh;
+	struct gfs2_holder gh, statfs_gh;
 	int ret;
 
+	gfs2_holder_mark_uninitialized(&statfs_gh);
+
 	if (mode & ~(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE))
 		return -EOPNOTSUPP;
 	/* fallocate is needed by gfs2_grow to reserve space in the rindex */
@@ -1407,6 +1409,20 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 	if (ret)
 		goto out_uninit;
 
+	/*
+	 * Growing the rindex or punching a hole in it ends up in
+	 * adjust_fs_space(), which updates the master statfs block, so hold
+	 * that glock like gfs2_file_buffered_write() does.
+	 */
+	if (inode == sdp->sd_rindex) {
+		struct gfs2_glock *m_gl = gfs2_inode_glock(sdp->sd_statfs_inode);
+
+		ret = gfs2_glock_nq_init(m_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+					 &statfs_gh);
+		if (ret)
+			goto out_unlock;
+	}
+
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    (offset + len) > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -1428,6 +1444,8 @@ static long gfs2_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	put_write_access(inode);
 out_unlock:
+	if (gfs2_holder_initialized(&statfs_gh))
+		gfs2_glock_dq_uninit(&statfs_gh);
 	gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 2c2dc459c0375..51d406d913793 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2112,9 +2112,11 @@ static int gfs2_setattr(const struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(dentry);
 	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_holder i_gh;
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
+	struct gfs2_holder i_gh, statfs_gh;
 	int error;
 
+	gfs2_holder_mark_uninitialized(&statfs_gh);
 	error = gfs2_qa_get(ip);
 	if (error)
 		return error;
@@ -2131,9 +2133,25 @@ static int gfs2_setattr(const struct mnt_idmap *idmap,
 	if (error)
 		goto error;
 
-	if (attr->ia_valid & ATTR_SIZE)
+	if (attr->ia_valid & ATTR_SIZE) {
+		/*
+		 * Growing or truncating the rindex ends up in
+		 * adjust_fs_space(), which updates the master statfs block, so
+		 * hold that glock like gfs2_file_buffered_write() does.
+		 */
+		if (inode == sdp->sd_rindex) {
+			struct gfs2_glock *m_gl;
+
+			m_gl = gfs2_inode_glock(sdp->sd_statfs_inode);
+			error = gfs2_glock_nq_init(m_gl, LM_ST_EXCLUSIVE,
+						   GL_NOCACHE, &statfs_gh);
+			if (error)
+				goto error;
+		}
 		error = gfs2_setattr_size(inode, attr->ia_size);
-	else if (attr->ia_valid & (ATTR_UID | ATTR_GID))
+		if (gfs2_holder_initialized(&statfs_gh))
+			gfs2_glock_dq_uninit(&statfs_gh);
+	} else if (attr->ia_valid & (ATTR_UID | ATTR_GID))
 		error = setattr_chown(inode, attr);
 	else {
 		error = gfs2_setattr_simple(inode, attr);
-- 
2.39.3

