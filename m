Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3346D087;
	Tue,  8 Sep 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902146; cv=none; b=A86nPKB9LePfla7Z7Hn3trn2d8KRUyLzaiog/1jyvMPBfgBzVToEHVsEUUxu06y2HHr9WUtX72QtU9JUWyUvAh/naVhq2iKwcAmUcXV3fwuPu0aLwXGDUEQETDeZhT1ylI7J/Rfs3KEIwPlfd9p8k4Ftde6euzRlf3zF3P/xJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902146; c=relaxed/simple;
	bh=BaX/gApUF1YpvZFVaqxs+u1B+t9ffCtHL/0k1sb4UFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjLAMunpvjhg2cp6Mw51WsRSjqYpS1KMcj2GUCE4fidwsn133mWr6wEL5GndfqWN4ohEgQeUsYLsE/yb1v1G78iwmD8exx2+eAHVqJwOgvuS0wz+8DVVdl75q7hx69z35JAU5nhw5VPDj8dIsl3mfPug/zKCuLQLnRTXg97A4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WCKZ0Cdz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WCKZ0Cdz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=8dfw+0EPuKtNINADQKW9iW9tjuvtrD/D7F9t6H2GO50=; b=WCKZ0Cdz4ueznBB1Gq6eVNZ/bi
	S6WpyFLQ0/L8jlojE3QhOInMDlZqg1C9fvxxAPrs5QCPsN4zL243s0suC91IKS5ZqeOizYkNQ2J1a
	/Zvt/74C+bXP5rcmY23A5sS7KOIe7gv5fsDXsFYJJZqnKx3tmJMZdtM99xKHJYG8OK7LGGLy/2X1u
	ND0+rNnNJOd2L2TxYkqVUzWaT+jD9OKh07vqshngu7Yq5YAmBDJBWKG4R8J6PmQiWwB//J6ISpZ3p
	Hp8ExIQg+HzmaomJe5GdXqWvN1/ZeJBXJN54rxi5Ez45IWl2G1jDaM+oJvFKx8vn5xn/r7U1S78+Y
	lthJnDdw==;
Received: from 186-249-150-254.shared.desktop.com.br ([186.249.150.254] helo=[127.0.1.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x43AM-00GhZP-1c; Tue, 08 Sep 2026 23:15:42 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Tue, 08 Sep 2026 18:16:14 -0300
Subject: [PATCH 3/5] gfs2: handle NULL return value in callers of
 gfs2_meta_new()
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gfs2_getbuf-error-checks-v1-3-7c59698f178f@igalia.com>
References: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
In-Reply-To: <20260908-gfs2_getbuf-error-checks-v1-0-7c59698f178f@igalia.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: kernel-dev@igalia.com, gfs2@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

Now that gfs2_meta_new() can return NULL (instead of hit a kernel oops),
update its callers to handle it (and not hit another kernel oops).

If gfs2_meta_new() returns NULL:

- new_leaf()

  It currently checks for NULL and returns -EIO.

- gfs2_indirect_init()

  Return -EIO. The only caller is __gfs2_iomap_alloc() (same file), twice.
  Fail as currently done in other cases.

- gfs2_dir_get_new_buffer()

  Return -EIO. The only two callers already check for errors.

- gfs2_init_xattr()
- init_dinode()

  Return -EIO. The only caller is gfs2_create_inode() (same file).
  Fail as currently done in the preceding error case.

- buf_lo_scan_elements()
- data_buf_lo_scan_elements()

  Return -EIO after releasing the just acquired bh_log buffer.

- ea_alloc_blk()
- ea_write()
- ea_set_block()

  Return -EIO. The function can currently return errors.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 fs/gfs2/bmap.c  | 25 +++++++++++++++++--------
 fs/gfs2/dir.c   |  2 ++
 fs/gfs2/inode.c | 20 +++++++++++++++-----
 fs/gfs2/lops.c  |  8 ++++++++
 fs/gfs2/xattr.c |  6 ++++++
 5 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index a766b5816634d360a4bbae89f8bcdd284071864a..1c14313acea084584ae5de69a1107b45e470606a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -608,9 +608,9 @@ static int gfs2_hole_size(struct inode *inode, sector_t lblock, u64 len,
 	return ret;
 }
 
-static inline void gfs2_indirect_init(struct metapath *mp,
-				      struct gfs2_glock *gl, unsigned int i,
-				      unsigned offset, u64 bn)
+static inline int gfs2_indirect_init(struct metapath *mp,
+				     struct gfs2_glock *gl, unsigned int i,
+				     unsigned int offset, u64 bn)
 {
 	__be64 *ptr = (__be64 *)(mp->mp_bh[i - 1]->b_data +
 		       ((i > 1) ? sizeof(struct gfs2_meta_header) :
@@ -618,11 +618,14 @@ static inline void gfs2_indirect_init(struct metapath *mp,
 	BUG_ON(i < 1);
 	BUG_ON(mp->mp_bh[i] != NULL);
 	mp->mp_bh[i] = gfs2_meta_new(gl, bn);
+	if (!mp->mp_bh[i])
+		return -EIO;
 	gfs2_trans_add_meta(gl, mp->mp_bh[i]);
 	gfs2_metatype_set(mp->mp_bh[i], GFS2_METATYPE_IN, GFS2_FORMAT_IN);
 	gfs2_buffer_clear_tail(mp->mp_bh[i], sizeof(struct gfs2_meta_header));
 	ptr += offset;
 	*ptr = cpu_to_be64(bn);
+	return 0;
 }
 
 enum alloc_state {
@@ -723,8 +726,11 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 				zero_bn = *ptr;
 			}
 			for (; i - 1 < mp->mp_fheight - ip->i_height && n > 0;
-			     i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i, 0, bn++);
+			     i++, n--) {
+				ret = gfs2_indirect_init(mp, ip->i_gl, i, 0, bn++);
+				if (ret)
+					goto out;
+			}
 			if (i - 1 == mp->mp_fheight - ip->i_height) {
 				i--;
 				gfs2_buffer_copy_tail(mp->mp_bh[i],
@@ -751,9 +757,12 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 		case ALLOC_GROW_DEPTH:
 			if (i > 1 && i < mp->mp_fheight)
 				gfs2_trans_add_meta(ip->i_gl, mp->mp_bh[i-1]);
-			for (; i < mp->mp_fheight && n > 0; i++, n--)
-				gfs2_indirect_init(mp, ip->i_gl, i,
-						   mp->mp_list[i-1], bn++);
+			for (; i < mp->mp_fheight && n > 0; i++, n--) {
+				ret = gfs2_indirect_init(mp, ip->i_gl, i,
+							 mp->mp_list[i-1], bn++);
+				if (ret)
+					goto out;
+			}
 			if (i == mp->mp_fheight)
 				state = ALLOC_DATA;
 			if (n == 0)
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0d92f6c33dcb85dfa2a4b07f9f09575834e75e01..d1dc1e94b6c432d2ede504b04cb71959285a945d 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -93,6 +93,8 @@ int gfs2_dir_get_new_buffer(struct gfs2_inode *ip, u64 block,
 	struct buffer_head *bh;
 
 	bh = gfs2_meta_new(ip->i_gl, block);
+	if (!bh)
+		return -EIO;
 	gfs2_trans_add_meta(ip->i_gl, bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_JD, GFS2_FORMAT_JD);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f361876c5583353a1196ed35be1c95af33a90c02..dda51390fee49b56279161fdd755b3c2b6e7eac6 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -544,13 +544,15 @@ static void gfs2_init_dir(struct buffer_head *dibh,
  * take any ACLs, LSM xattrs, etc.
  */
 
-static void gfs2_init_xattr(struct gfs2_inode *ip)
+static int gfs2_init_xattr(struct gfs2_inode *ip)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *bh;
 	struct gfs2_ea_header *ea;
 
 	bh = gfs2_meta_new(ip->i_gl, ip->i_eattr);
+	if (!bh)
+		return -EIO;
 	gfs2_trans_add_meta(ip->i_gl, bh);
 	gfs2_metatype_set(bh, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(bh, sizeof(struct gfs2_meta_header));
@@ -561,6 +563,7 @@ static void gfs2_init_xattr(struct gfs2_inode *ip)
 	ea->ea_flags = GFS2_EAFLAG_LAST;
 
 	brelse(bh);
+	return 0;
 }
 
 /**
@@ -571,13 +574,15 @@ static void gfs2_init_xattr(struct gfs2_inode *ip)
  *
  */
 
-static void init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
-			const char *symname)
+static int init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
+		       const char *symname)
 {
 	struct gfs2_dinode *di;
 	struct buffer_head *dibh;
 
 	dibh = gfs2_meta_new(ip->i_gl, ip->i_no_addr);
+	if (!dibh)
+		return -EIO;
 	gfs2_trans_add_meta(ip->i_gl, dibh);
 	di = (struct gfs2_dinode *)dibh->b_data;
 	gfs2_dinode_out(ip, di);
@@ -602,6 +607,7 @@ static void init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
 
 	set_buffer_uptodate(dibh);
 	brelse(dibh);
+	return 0;
 }
 
 /**
@@ -864,10 +870,14 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		goto fail_gunlock3;
 
 	if (blocks > 1) {
-		gfs2_init_xattr(ip);
+		error = gfs2_init_xattr(ip);
+		if (error)
+			goto fail_gunlock3;
 		xattr_initialized = true;
 	}
-	init_dinode(dip, ip, symname);
+	error = init_dinode(dip, ip, symname);
+	if (error)
+		goto fail_gunlock3;
 	gfs2_trans_end(sdp);
 
 	glock_set_object(ip->i_gl, ip);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6dabe73ad790d9cbf6f2725dd3e5e1c40c3781b8..192e71e630dce062361cc754f2ba878fa23c0a7f 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -801,6 +801,10 @@ static int buf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 			return error;
 
 		bh_ip = gfs2_meta_new(gl, blkno);
+		if (!bh_ip) {
+			brelse(bh_log);
+			return -EIO;
+		}
 		memcpy(bh_ip->b_data, bh_log->b_data, bh_log->b_size);
 
 		if (gfs2_meta_check(sdp, bh_ip))
@@ -1026,6 +1030,10 @@ static int databuf_lo_scan_elements(struct gfs2_jdesc *jd, u32 start,
 			return error;
 
 		bh_ip = gfs2_meta_new(gl, blkno);
+		if (!bh_ip) {
+			brelse(bh_log);
+			return -EIO;
+		}
 		memcpy(bh_ip->b_data, bh_log->b_data, bh_log->b_size);
 
 		/* Unescape */
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index b9f48d6f10a97a36365a2fe636ceb1cd476e4318..5aec4d0f240dc5beef18bc5619faf6b375152c03 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -648,6 +648,8 @@ static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 		return error;
 	gfs2_trans_remove_revoke(sdp, block, 1);
 	*bhp = gfs2_meta_new(ip->i_gl, block);
+	if (!*bhp)
+		return -EIO;
 	gfs2_trans_add_meta(ip->i_gl, *bhp);
 	gfs2_metatype_set(*bhp, GFS2_METATYPE_EA, GFS2_FORMAT_EA);
 	gfs2_buffer_clear_tail(*bhp, sizeof(struct gfs2_meta_header));
@@ -710,6 +712,8 @@ static int ea_write(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 				return error;
 			gfs2_trans_remove_revoke(sdp, block, 1);
 			bh = gfs2_meta_new(ip->i_gl, block);
+			if (!bh)
+				return -EIO;
 			gfs2_trans_add_meta(ip->i_gl, bh);
 			gfs2_metatype_set(bh, GFS2_METATYPE_ED, GFS2_FORMAT_ED);
 
@@ -1011,6 +1015,8 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 			return error;
 		gfs2_trans_remove_revoke(sdp, blk, 1);
 		indbh = gfs2_meta_new(ip->i_gl, blk);
+		if (!indbh)
+			return -EIO;
 		gfs2_trans_add_meta(ip->i_gl, indbh);
 		gfs2_metatype_set(indbh, GFS2_METATYPE_IN, GFS2_FORMAT_IN);
 		gfs2_buffer_clear_tail(indbh, mh_size);

-- 
2.47.3

