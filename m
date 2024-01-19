Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7885789A
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699264; cv=none; b=FAeDe6IXC9ct6SoErYUoiqoYGxdxkbN6tHwVZV+wPBY+f5vCERvrzoy9zR5CR/W+jjFTa1NmLeRRu4085Iol/gLY1kC2KOSO9SHufZNnS1ZiDOWdloSG3y7WmBlFT2RBPzO0Ne8ubx2E542ciURh+vdfHZYqPdEt6hGzD1AvcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699264; c=relaxed/simple;
	bh=6MpkVEuy9fgxYqNp4BCvRIiuu3Tf3P5Fh3yjBgWhwUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq7EgfzG7ZuT3lFkZUl6Z+Uud38sWeVop4wY5AybMscQQS1kYnaJjy9O2PchmXNkm8EuoY1g/QhwffuFwn6URZ7wgQCxP4qLnUf0baSbBw7xjB8I2kv14hQpE0wtqbWA/lGhdRV4XrtlFZO8TeKug1AtuXm+JYyOQGkZxQhMUWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9IJkFC8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9IJkFC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37TYOJG7oiVNT1y//nbn1EV8JPNAwKg0n0yFXLoZhIA=;
	b=H9IJkFC8d/vsR+M6VUy6cRzVdpjKrcqNMsAKw5105PKjQ5KDh6AXMfYIwchv38yQOel4bc
	RV6Wm6w2ixgtz8czRXw8G8AlEpVJFjVbqeWUJKO0amIcRpRSULvPNazW0bOnNj3h9xWq4A
	F0gxsGBp11jsmqjphERofWMULbJAAYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-7eza5FbtPbOmNg4gVBfDdA-1; Fri, 19 Jan 2024 16:21:00 -0500
X-MC-Unique: 7eza5FbtPbOmNg4gVBfDdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17566185A785;
	Fri, 19 Jan 2024 21:21:00 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7538440C95AD;
	Fri, 19 Jan 2024 21:20:59 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/9] gfs2: Split gfs2_meta_read_async off from gfs2_meta_read
Date: Fri, 19 Jan 2024 22:20:50 +0100
Message-ID: <20240119212056.805617-4-agruenba@redhat.com>
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

Split gfs2_meta_read_async() off from gfs2_meta_read() and implement
gfs2_meta_read() in terms of gfs2_meta_read_async() and
gfs2_meta_wait().

The initial check for filesystem withdrawal in gfs2_meta_wait() is
unnecessary and can be removed because gfs2_meta_wait() always follows
gfs2_meta_read_async() in the code and gfs2_meta_read_async() already
performs that check.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dir.c     |  6 +++---
 fs/gfs2/incore.h  |  1 -
 fs/gfs2/meta_io.c | 46 ++++++++++++++++++++++------------------------
 fs/gfs2/meta_io.h |  6 ++++--
 fs/gfs2/quota.c   |  2 +-
 fs/gfs2/rgrp.c    |  3 ++-
 fs/gfs2/xattr.c   | 13 ++++++-------
 7 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 518a7fb42df0..446e374a8d78 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -105,7 +105,7 @@ static int gfs2_dir_get_existing_buffer(struct gfs2_inode *ip, u64 block,
 	struct buffer_head *bh;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, block, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(ip->i_gl, block, 0, &bh);
 	if (error)
 		return error;
 	if (gfs2_metatype_check(GFS2_SB(&ip->i_inode), bh, GFS2_METATYPE_JD)) {
@@ -300,7 +300,7 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 			BUG_ON(extlen < 1);
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
 		} else {
-			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
+			error = gfs2_meta_read(ip->i_gl, dblock, 0, &bh);
 			if (error)
 				goto fail;
 		}
@@ -757,7 +757,7 @@ static int get_leaf(struct gfs2_inode *dip, u64 leaf_no,
 {
 	int error;
 
-	error = gfs2_meta_read(dip->i_gl, leaf_no, DIO_WAIT, 0, bhp);
+	error = gfs2_meta_read(dip->i_gl, leaf_no, 0, bhp);
 	if (!error && gfs2_metatype_check(GFS2_SB(&dip->i_inode), *bhp, GFS2_METATYPE_LF)) {
 		/* pr_info("block num=%llu\n", leaf_no); */
 		error = -EIO;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 95a334d64da2..e1343fd0a5b1 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -22,7 +22,6 @@
 #include <linux/rhashtable.h>
 #include <linux/mutex.h>
 
-#define DIO_WAIT	0x00000010
 #define DIO_METADATA	0x00000020
 
 struct gfs2_log_operations;
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index d0f3727f24db..6492d000d366 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -240,18 +240,17 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 }
 
 /**
- * gfs2_meta_read - Read a block from disk
+ * gfs2_meta_read_async - Read a block from disk
  * @gl: The glock covering the block
  * @blkno: The block number
- * @flags: flags
  * @rahead: Do read-ahead
  * @bhp: the place where the buffer is returned (NULL on failure)
  *
  * Returns: errno
  */
 
-int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
-		   int rahead, struct buffer_head **bhp)
+int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
+			 int rahead, struct buffer_head **bhp)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct buffer_head *bh, *bhs[2];
@@ -268,7 +267,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	lock_buffer(bh);
 	if (buffer_uptodate(bh)) {
 		unlock_buffer(bh);
-		flags &= ~DIO_WAIT;
 	} else {
 		bh->b_end_io = end_buffer_read_sync;
 		get_bh(bh);
@@ -289,20 +287,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	}
 
 	gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
-	if (!(flags & DIO_WAIT))
-		return 0;
-
-	bh = *bhp;
-	wait_on_buffer(bh);
-	if (unlikely(!buffer_uptodate(bh))) {
-		struct gfs2_trans *tr = current->journal_info;
-		if (tr && test_bit(TR_TOUCHED, &tr->tr_flags))
-			gfs2_io_error_bh_wd(sdp, bh);
-		brelse(bh);
-		*bhp = NULL;
-		return -EIO;
-	}
-
 	return 0;
 }
 
@@ -316,10 +300,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (gfs2_withdrawing_or_withdrawn(sdp) &&
-	    !gfs2_withdraw_in_prog(sdp))
-		return -EIO;
-
 	wait_on_buffer(bh);
 
 	if (!buffer_uptodate(bh)) {
@@ -335,6 +315,24 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	return 0;
 }
 
+int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno,
+		   int rahead, struct buffer_head **bhp)
+{
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	int ret;
+
+	ret = gfs2_meta_read_async(gl, blkno, rahead, bhp);
+	if (ret)
+		return ret;
+
+	ret = gfs2_meta_wait(sdp, *bhp);
+	if (ret) {
+		brelse(*bhp);
+		*bhp = NULL;
+	}
+	return ret;
+}
+
 void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
 {
 	struct address_space *mapping = bh->b_folio->mapping;
@@ -491,7 +489,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 	if (num == ip->i_no_addr)
 		rahead = ip->i_rahead;
 
-	ret = gfs2_meta_read(gl, num, DIO_WAIT, rahead, &bh);
+	ret = gfs2_meta_read(gl, num, rahead, &bh);
 	if (ret == 0 && gfs2_metatype_check(sdp, bh, mtype)) {
 		brelse(bh);
 		ret = -EIO;
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index e239e410881c..f04c91eadfb4 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -51,9 +51,11 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 }
 
 struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno);
-int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
-		   int rahead, struct buffer_head **bhp);
+int gfs2_meta_read_async(struct gfs2_glock *gl, u64 blkno,
+			 int rahead, struct buffer_head **bhp);
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh);
+int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno,
+		   int rahead, struct buffer_head **bhp);
 struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno,
 				fgf_t fgp_flags);
 enum {
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index aa9cf0102848..a68af8bdf7de 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -424,7 +424,7 @@ static int bh_get(struct gfs2_quota_data *qd)
 		goto fail;
 
 	error = gfs2_meta_read(ip->i_gl, iomap.addr >> inode->i_blkbits,
-			       DIO_WAIT, 0, &bh);
+			       0, &bh);
 	if (error)
 		goto fail;
 	error = -EIO;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..fcef82c767e3 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1210,7 +1210,8 @@ int gfs2_rgrp_go_instantiate(struct gfs2_glock *gl)
 
 	for (x = 0; x < length; x++) {
 		bi = rgd->rd_bits + x;
-		error = gfs2_meta_read(gl, rgd->rd_addr + x, 0, 0, &bi->bi_bh);
+		error = gfs2_meta_read_async(gl, rgd->rd_addr + x, 0,
+					     &bi->bi_bh);
 		if (error)
 			goto fail;
 	}
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 8c96ba6230d1..759347ec67af 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -128,7 +128,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 	__be64 *eablk, *end;
 	int error;
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &bh);
+	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &bh);
 	if (error)
 		return error;
 
@@ -152,7 +152,7 @@ static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
 			break;
 		bn = be64_to_cpu(*eablk);
 
-		error = gfs2_meta_read(ip->i_gl, bn, DIO_WAIT, 0, &eabh);
+		error = gfs2_meta_read(ip->i_gl, bn, 0, &eabh);
 		if (error)
 			break;
 		error = ea_foreach_i(ip, eabh, ea_call, data);
@@ -468,8 +468,8 @@ static int gfs2_iter_unstuffed(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 		return -ENOMEM;
 
 	for (x = 0; x < nptrs; x++) {
-		error = gfs2_meta_read(ip->i_gl, be64_to_cpu(*dataptrs), 0, 0,
-				       bh + x);
+		error = gfs2_meta_read_async(ip->i_gl, be64_to_cpu(*dataptrs),
+					     0, bh + x);
 		if (error) {
 			while (x--)
 				brelse(bh[x]);
@@ -976,8 +976,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	if (ip->i_diskflags & GFS2_DIF_EA_INDIRECT) {
 		__be64 *end;
 
-		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0,
-				       &indbh);
+		error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &indbh);
 		if (error)
 			return error;
 
@@ -1279,7 +1278,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 
 	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
 
-	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, DIO_WAIT, 0, &indbh);
+	error = gfs2_meta_read(ip->i_gl, ip->i_eattr, 0, &indbh);
 	if (error)
 		return error;
 
-- 
2.43.0

