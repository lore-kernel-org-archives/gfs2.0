Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E117EF
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699265; cv=none; b=pBary4MI86tMTEv/9BRGOp3JiiSGN9koDPyqEmUzyiMdEZqUfgd2PVc05jKOU3yS4cnGDISCoWE6bq6zVGYyM54wb5kp2LRYhM4BSHleD0D3RCquxsl7uIbxcD82xe34w2010g6yEeWahBeRb12QvW6gYs1WZlukyc3zhQj9I4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699265; c=relaxed/simple;
	bh=beiySI6G+qqkWOcFXOn96Ot42S2LhM96ucVTugSClbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmdEDCR3aw4oxWftgXAFSvFEREf1SSWUu8RF7moFHdjKYyyOvKj6zj5T7aFcwz5hD7HgUht7Mkw0fDpnQsiz1h42H8495fpi/v4wSPxf88r7BONA9cMhxIepQe3C5FOP1Kzegtjee2yzoS/bZ/rWn9wYsdx7JiaE7t0+7N1PLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrRuiTCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrRuiTCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/n5UXrD2DwmYBGAyBR+rjpWCmpb5LndJ5KoD7WiY0g=;
	b=DrRuiTCIqLvxHP8VTge4vPc/LEi1jttpH6pkv3I50eLccv/ef52JNODeVlq80tYifLTWuA
	3+z+/TLGz5+Nt4NXHyaFw3B65z71o/RvSi3RAxccNOb4wp47eS4USdb71lptkayyn+AJ19
	xBQrtqYcIDjiJvX2uuDK19dFHmVyP+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-G39-ftl1MOSCmK9LuJfIAw-1; Fri,
 19 Jan 2024 16:20:59 -0500
X-MC-Unique: G39-ftl1MOSCmK9LuJfIAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BE45280640F;
	Fri, 19 Jan 2024 21:20:59 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A70D40C1430;
	Fri, 19 Jan 2024 21:20:58 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/9] gfs2: Pass FGP flags to gfs2_getbuf
Date: Fri, 19 Jan 2024 22:20:49 +0100
Message-ID: <20240119212056.805617-3-agruenba@redhat.com>
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

Replace gfs2_getbuf()'s create argument with a fgp_flags argument.  Use
the FGP_CREAT flag instead of the CREATE flag to indicate that new
buffers should be created.

In addition, when the FGP_NOWAIT flag is set and gfs2_getbuf() would
sleep, -EAGAIN is returned instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c    |  2 +-
 fs/gfs2/dir.c     |  2 +-
 fs/gfs2/meta_io.c | 33 +++++++++++++++++++--------------
 fs/gfs2/meta_io.h |  2 +-
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index d9ccfd27e4f1..92945e5b7643 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -301,7 +301,7 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 		if (!*t)
 			continue;
 
-		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
+		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), FGP_CREAT);
 		if (trylock_buffer(rabh)) {
 			if (!buffer_uptodate(rabh)) {
 				rabh->b_end_io = end_buffer_read_sync;
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 560e4624c09f..518a7fb42df0 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1500,7 +1500,7 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 		if (blocknr == last)
 			continue;
 
-		bh = gfs2_getbuf(gl, blocknr, 1);
+		bh = gfs2_getbuf(gl, blocknr, FGP_CREAT);
 		if (trylock_buffer(bh)) {
 			if (buffer_uptodate(bh)) {
 				unlock_buffer(bh);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f814054c8cd0..d0f3727f24db 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -106,12 +106,15 @@ const struct address_space_operations gfs2_rgrp_aops = {
  * gfs2_getbuf - Get a buffer with a given address space
  * @gl: the glock
  * @blkno: the block number (filesystem scope)
- * @create: 1 if the buffer should be created
+ * @fgp_flags: Flags like FGP_CREAT and FGP_NOWAIT
+ *
+ * Returns ERR_PTR(-EAGAIN) if the FGP_NOWAIT flag is set and the function
+ * would sleep.
  *
  * Returns: the buffer
  */
-
-struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
+struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno,
+				fgf_t fgp_flags)
 {
 	struct address_space *mapping = gfs2_glock2aspace(gl);
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
@@ -128,17 +131,19 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	index = blkno >> shift;             /* convert block to page */
 	bufnum = blkno - (index << shift);  /* block buf index within page */
 
-	if (create) {
+	fgp_flags |= FGP_LOCK | FGP_ACCESSED;
+	if (fgp_flags & FGP_CREAT) {
 		folio = __filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				fgp_flags,
 				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
 		bh = folio_buffers(folio);
-		if (!bh)
+		if (!bh && !(fgp_flags & FGP_NOWAIT))
 			bh = create_empty_buffers(folio,
 				sdp->sd_sb.sb_bsize, 0);
 	} else {
-		folio = __filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_ACCESSED, 0);
+		folio = __filemap_get_folio(mapping, index, fgp_flags, 0);
 		if (IS_ERR(folio))
 			return NULL;
 		bh = folio_buffers(folio);
@@ -181,7 +186,7 @@ static void meta_prep_new(struct buffer_head *bh)
 struct buffer_head *gfs2_meta_new(struct gfs2_glock *gl, u64 blkno)
 {
 	struct buffer_head *bh;
-	bh = gfs2_getbuf(gl, blkno, CREATE);
+	bh = gfs2_getbuf(gl, blkno, FGP_CREAT);
 	meta_prep_new(bh);
 	return bh;
 }
@@ -258,7 +263,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		return -EIO;
 	}
 
-	*bhp = bh = gfs2_getbuf(gl, blkno, CREATE);
+	*bhp = bh = gfs2_getbuf(gl, blkno, FGP_CREAT);
 
 	lock_buffer(bh);
 	if (buffer_uptodate(bh)) {
@@ -271,7 +276,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	}
 
 	if (rahead) {
-		bh = gfs2_getbuf(gl, blkno + 1, CREATE);
+		bh = gfs2_getbuf(gl, blkno + 1, FGP_CREAT);
 
 		lock_buffer(bh);
 		if (buffer_uptodate(bh)) {
@@ -443,7 +448,7 @@ void gfs2_journal_wipe(struct gfs2_inode *ip, u64 bstart, u32 blen)
 	gfs2_ail1_wipe(sdp, bstart, blen);
 	while (blen) {
 		ty = REMOVE_META;
-		bh = gfs2_getbuf(ip->i_gl, bstart, NO_CREATE);
+		bh = gfs2_getbuf(ip->i_gl, bstart, 0);
 		if (!bh && gfs2_is_jdata(ip)) {
 			bh = gfs2_getjdatabuf(ip, bstart);
 			ty = REMOVE_JDATA;
@@ -519,7 +524,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	if (extlen > max_ra)
 		extlen = max_ra;
 
-	first_bh = gfs2_getbuf(gl, dblock, CREATE);
+	first_bh = gfs2_getbuf(gl, dblock, FGP_CREAT);
 
 	if (buffer_uptodate(first_bh))
 		goto out;
@@ -529,7 +534,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	extlen--;
 
 	while (extlen) {
-		bh = gfs2_getbuf(gl, dblock, CREATE);
+		bh = gfs2_getbuf(gl, dblock, FGP_CREAT);
 
 		bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
 		brelse(bh);
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index 831d988c2ceb..e239e410881c 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -55,7 +55,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		   int rahead, struct buffer_head **bhp);
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh);
 struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno,
-			        int create);
+				fgf_t fgp_flags);
 enum {
 	REMOVE_JDATA = 0,
 	REMOVE_META = 1,
-- 
2.43.0

