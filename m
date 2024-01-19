Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA45789A
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699268; cv=none; b=EA1ALrky8i9b/zxJA9JvrEqd86LTOoexqNogGpHetP9nCNBqqZw4/7jJbY8T+ffeGdIRsNHtQLRWVdIHMQzg4wNCVL+PojY1UYFvcFGJKZbvX1PPknlaTB3C8sR8HBqnaxvT3srv0cQtZcaezACsSHRx8LpztNGIdX+q3gZAfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699268; c=relaxed/simple;
	bh=DQ/c0zKIJ96BSKD9cT9AqZAxg03Sz4L5vHtWiWQyEtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFkAEdXyG0o3H2zWELqnusQF1tbrKGg/K+gbX168jdRf0ifxtEH0jQouFNYIBA9HF1PJcFNwzNs3D6dOSftAZ0ZX0yo4s+BdtSGw3A9Olj5jjrmWcLYVEwwzXQDOAq/CVZ2Q2DuP30tJkqjZhe/op2NBniMDdBKR2XZAUyugCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5RYv3YF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5RYv3YF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YetjZUMX8VrXXGdQbVt1Ucsw7jUUZITkAkI81cudyg=;
	b=B5RYv3YFCa6VOKrjxh1XuffmUJySwryMfa7l7IzVN+rtfiytv8WT8BGYtUy9yF6pIwjtv9
	hiskIH3f27x/mwkKw1uhfC49mXeWsoCIR5z0ULIW+lCBU7Vp8gN2rgXig8N42Ka0vTH72B
	1CROFemLr/TzS2N6e52ebuyWD3KvVmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-jmQGhYoFPUK3cpr-HSJjMQ-1; Fri, 19 Jan 2024 16:21:01 -0500
X-MC-Unique: jmQGhYoFPUK3cpr-HSJjMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7B8283B82B;
	Fri, 19 Jan 2024 21:21:00 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 505DF40D1B60;
	Fri, 19 Jan 2024 21:21:00 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/9] gfs2: Add FGP_NOWAIT support to gfs2_meta_read_async
Date: Fri, 19 Jan 2024 22:20:51 +0100
Message-ID: <20240119212056.805617-5-agruenba@redhat.com>
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

Add an fgp_flags argument to gfs2_meta_read_async() and gfs2_meta_read()
that is passed through to gfs2_getbuf().  When the FGP_NOWAIT flag is
set and gfs2_meta_read_async() would sleep, -EAGAIN is returned instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dir.c     |  6 +++---
 fs/gfs2/meta_io.c | 40 ++++++++++++++++++++++++++++++++++------
 fs/gfs2/meta_io.h |  4 ++--
 fs/gfs2/quota.c   |  2 +-
 fs/gfs2/rgrp.c    |  2 +-
 fs/gfs2/xattr.c   | 10 +++++-----
 6 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 446e374a8d78..a1f47696a2ec 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -105,7 +105,7 @@ static int gfs2_dir_get_existing_buffer(struct gfs2_inode *ip, u64 block,
 	struct buffer_head *bh;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, block, 0, &bh);
+	error = gfs2_meta_read(ip->i_gl, block, 0, 0, &bh);
 	if (error)
 		return error;
 	if (gfs2_metatype_check(GFS2_SB(&ip->i_inode), bh, GFS2_METATYPE_JD)) {
@@ -300,7 +300,7 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 			BUG_ON(extlen < 1);
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
 		} else {
-			error = gfs2_meta_read(ip->i_gl, dblock, 0, &bh);
+			error = gfs2_meta_read(ip->i_gl, dblock, 0, 0, &bh);
 			if (error)
 				goto fail;
 		}
@@ -757,7 +757,7 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 {
 	int error;
 
-	error = gfs2_meta_read(dip->i_gl, leaf_no, 0, bhp);
+	error = gfs2_meta_read(dip->i_gl, leaf_no, 0, 0, bhp);
 	if (!error && gfs2_metatype_check(GFS2_SB(&dip->i_inode), *bhp, GFS2_METATYPE_LF)) {
 		/* pr_info("block num=%llu\n", leaf_no); */
 		error = -EIO;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 6492d000d366..47a430206801 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -243,13 +243,16 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
  * gfs2_meta_read_async - Read a block from disk
  * @gl: The glock covering the block
  * @blkno: The block number
+ * @fgp_flags: FGP_NOWAIT if sleeping is prohibited
  * @rahead: Do read-ahead
  * @bhp: the place where the buffer is returned (NULL on failure)
  *
+ * Returns -EAGAIN if the FGP_NOWAIT flag is set and the function would sleep.
+ *
  * Returns: errno
  */
 
-int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
+int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno, fgf_t fgp_flags,
 			 int rahead, struct buffer_head **bhp)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
@@ -262,7 +265,29 @@ int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
 		return -EIO;
 	}
 
-	*bhp = bh = gfs2_getbuf(gl, blkno, FGP_CREAT);
+	fgp_flags |= FGP_CREAT;
+	*bhp = bh = gfs2_getbuf(gl, blkno, fgp_flags);
+	if (IS_ERR(bh)) {
+		*bhp = NULL;
+		return PTR_ERR(bh);
+	}
+
+	if (fgp_flags & FGP_NOWAIT) {
+		bool uptodate = false;
+
+		/* skips readahead entirely. */
+
+		if (trylock_buffer(bh)) {
+			uptodate = buffer_uptodate(bh);
+			unlock_buffer(bh);
+		}
+		if (!uptodate) {
+			brelse(bh);
+			*bhp = NULL;
+			return -EAGAIN;
+		}
+		return 0;
+	}
 
 	lock_buffer(bh);
 	if (buffer_uptodate(bh)) {
@@ -274,7 +299,9 @@ int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
 	}
 
 	if (rahead) {
-		bh = gfs2_getbuf(gl, blkno + 1, FGP_CREAT);
+		bh = gfs2_getbuf(gl, blkno + 1, fgp_flags);
+		if (IS_ERR(bh))
+			goto out;
 
 		lock_buffer(bh);
 		if (buffer_uptodate(bh)) {
@@ -286,6 +313,7 @@ int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
 		}
 	}
 
+out:
 	gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
 	return 0;
 }
@@ -315,13 +343,13 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	return 0;
 }
 
-int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno,
+int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, fgf_t fgp_flags,
 		   int rahead, struct buffer_head **bhp)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	int ret;
 
-	ret = gfs2_meta_read_async(gl, blkno, rahead, bhp);
+	ret = gfs2_meta_read_async(gl, blkno, fgp_flags, rahead, bhp);
 	if (ret)
 		return ret;
 
@@ -489,7 +517,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 	if (num == ip->i_no_addr)
 		rahead = ip->i_rahead;
 
-	ret = gfs2_meta_read(gl, num, rahead, &bh);
+	ret = gfs2_meta_read(gl, num, 0, rahead, &bh);
 	if (ret == 0 && gfs2_metatype_check(sdp, bh, mtype)) {
 		brelse(bh);
 		ret = -EIO;
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index f04c91eadfb4..6ca37e9f1c95 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -51,10 +51,10 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 }
 
 struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno);
-int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
+int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno, fgf_t fgp_flags,
 			 int rahead, struct buffer_head **bhp);
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh);
-int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno,
+int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, fgf_t fgp_flags,
 		   int rahead, struct buffer_head **bhp);
 struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno,
 				fgf_t fgp_flags);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index a68af8bdf7de..8b47306816ab 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -424,7 +424,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 		goto fail;
 
 	error = gfs2_meta_read(ip->i_gl, iomap.addr >> inode->i_blkbits,
-			       0, &bh);
+			       0, 0, &bh);
 	if (error)
 		goto fail;
 	error = -EIO;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index fcef82c767e3..9fa4fc7f4bcf 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1210,7 +1210,7 @@ int gfs2_rgrp_go_instantiate(struct gfs2_glock *gl)
 
 	for (x = 0; x < length; x++) {
 		bi = rgd->rd_bits + x;
-		error = gfs2_meta_read_async(gl, rgd->rd_addr + x, 0,
+		error = gfs2_meta_read_async(gl, rgd->rd_addr + x, 0, 0,
 					     &bi->bi_bh);
 		if (error)
 			goto fail;
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 759347ec67af..745c7cf78519 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -128,7 +128,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 	__be64 *eablk, *end;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &bh);
+	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, 0, &bh);
 	if (error)
 		return error;
 
@@ -152,7 +152,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 			break;
 		bn = be64_to_cpu(*eablk);
 
-		error = gfs2_meta_read(ip->i_gl, bn, 0, &eabh);
+		error = gfs2_meta_read(ip->i_gl, bn, 0, 0, &eabh);
 		if (error)
 			break;
 		error = ea_foreach_i(ip, eabh, ea_call, data);
@@ -469,7 +469,7 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 
 	for (x = 0; x < nptrs; x++) {
 		error = gfs2_meta_read_async(ip->i_gl, be64_to_cpu(*dataptrs),
-					     0, bh + x);
+					     0, 0, bh + x);
 		if (error) {
 			while (x--)
 				brelse(bh[x]);
@@ -976,7 +976,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	if (ip->i_diskflags & GFS2_DIF_EA_INDIRECT) {
 		__be64 *end;
 
-		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &indbh);
+		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, 0, &indbh);
 		if (error)
 			return error;
 
@@ -1278,7 +1278,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &indbh);
+	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, 0, &indbh);
 	if (error)
 		return error;
 
-- 
2.43.0

