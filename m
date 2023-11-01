Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411C15E82
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsgZuwbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJfyOx7mdEPxQvimyFyE2uRMoy4CQvd39WyBMlJcjyo=;
	b=JsgZuwbjY+yoJifsCgoWkqOgHtuE1Q9naE5Dcu+RXKOJafviV67F8FAO5WbvNzRed0H5dY
	Yf491/6SBVLSB/2CQha80f0i3H3lVT6ibm2qQKUxLeROux5dJgGsyuad1X43QAr6RQOkkP
	8HvCtJajhvnKsGUaIChQwgz4X2d4wsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-axMfjGRUO22eHIouvwpLew-1; Wed, 01 Nov 2023 12:46:30 -0400
X-MC-Unique: axMfjGRUO22eHIouvwpLew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A74C6185A787
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:30 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2806940C6EBC;
	Wed,  1 Nov 2023 16:46:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 17/25] gfs2: Get rid of gfs2_alloc_blocks generation parameter
Date: Wed,  1 Nov 2023 17:46:07 +0100
Message-ID: <20231101164615.1138692-18-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
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

Get rid of the generation parameter of gfs2_alloc_blocks(): we only ever
set the generation of the current inode while creating it, so do so
directly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c  |  4 ++--
 fs/gfs2/dir.c   |  2 +-
 fs/gfs2/inode.c |  2 +-
 fs/gfs2/rgrp.c  | 12 +++++++-----
 fs/gfs2/rgrp.h  |  2 +-
 fs/gfs2/xattr.c |  6 +++---
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ec56a07213d4..9d4020bea94f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -106,7 +106,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct page *page)
 		   and write it out to disk */
 
 		unsigned int n = 1;
-		error = gfs2_alloc_blocks(ip, &block, &n, 0, NULL);
+		error = gfs2_alloc_blocks(ip, &block, &n, 0);
 		if (error)
 			goto out_brelse;
 		if (isdir) {
@@ -727,7 +727,7 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
 	i = mp->mp_aheight;
 	do {
 		n = blks - alloced;
-		ret = gfs2_alloc_blocks(ip, &bn, &n, 0, NULL);
+		ret = gfs2_alloc_blocks(ip, &bn, &n, 0);
 		if (ret)
 			goto out;
 		alloced += n;
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 1a2afa88f8be..3a2a10d6d43d 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -868,7 +868,7 @@ static struct gfs2_leaf *new_leaf(struct inode *inode, struct buffer_head **pbh,
 	struct gfs2_dirent *dent;
 	struct timespec64 tv = current_time(inode);
 
-	error = gfs2_alloc_blocks(ip, &bn, &n, 0, NULL);
+	error = gfs2_alloc_blocks(ip, &bn, &n, 0);
 	if (error)
 		return NULL;
 	bh = gfs2_meta_new(ip->i_gl, bn);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index ee5b07d296f7..54b449cd6201 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -417,7 +417,7 @@ static int alloc_dinode(struct gfs2_inode *ip, u32 flags, unsigned *dblocks)
 	if (error)
 		goto out_ipreserv;
 
-	error = gfs2_alloc_blocks(ip, &ip->i_no_addr, dblocks, 1, &ip->i_generation);
+	error = gfs2_alloc_blocks(ip, &ip->i_no_addr, dblocks, 1);
 	if (error)
 		goto out_trans_end;
 
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 9308190895c8..c2060203b98a 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2411,13 +2411,12 @@ static void gfs2_set_alloc_start(struct gfs2_rbm *rbm,
  * @bn: Used to return the starting block number
  * @nblocks: requested number of blocks/extent length (value/result)
  * @dinode: 1 if we're allocating a dinode block, else 0
- * @generation: the generation number of the inode
  *
  * Returns: 0 or error
  */
 
 int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
-		      bool dinode, u64 *generation)
+		      bool dinode)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct buffer_head *dibh;
@@ -2477,10 +2476,13 @@ int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *nblocks,
 	rbm.rgd->rd_free -= *nblocks;
 	spin_unlock(&rbm.rgd->rd_rsspin);
 	if (dinode) {
+		u64 generation;
+
 		rbm.rgd->rd_dinodes++;
-		*generation = rbm.rgd->rd_igeneration++;
-		if (*generation == 0)
-			*generation = rbm.rgd->rd_igeneration++;
+		generation = rbm.rgd->rd_igeneration++;
+		if (generation == 0)
+			generation = rbm.rgd->rd_igeneration++;
+		ip->i_generation = generation;
 	}
 
 	gfs2_trans_add_meta(rbm.rgd->rd_gl, rbm.rgd->rd_bits[0].bi_bh);
diff --git a/fs/gfs2/rgrp.h b/fs/gfs2/rgrp.h
index 00b30cf893af..507c914f039b 100644
--- a/fs/gfs2/rgrp.h
+++ b/fs/gfs2/rgrp.h
@@ -42,7 +42,7 @@ extern int gfs2_inplace_reserve(struct gfs2_inode *ip,
 extern void gfs2_inplace_release(struct gfs2_inode *ip);
 
 extern int gfs2_alloc_blocks(struct gfs2_inode *ip, u64 *bn, unsigned int *n,
-			     bool dinode, u64 *generation);
+			     bool dinode);
 
 extern void gfs2_rs_deltree(struct gfs2_blkreserv *rs);
 extern void gfs2_rs_delete(struct gfs2_inode *ip);
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 4fea70c0fe3d..2117011c8c57 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -639,7 +639,7 @@ static int ea_alloc_blk(struct gfs2_inode *ip, struct buffer_head **bhp)
 	u64 block;
 	int error;
 
-	error = gfs2_alloc_blocks(ip, &block, &n, 0, NULL);
+	error = gfs2_alloc_blocks(ip, &block, &n, 0);
 	if (error)
 		return error;
 	gfs2_trans_remove_revoke(sdp, block, 1);
@@ -701,7 +701,7 @@ static int ea_write(struct gfs2_inode *ip, struct gfs2_ea_header *ea,
 			int mh_size = sizeof(struct gfs2_meta_header);
 			unsigned int n = 1;
 
-			error = gfs2_alloc_blocks(ip, &block, &n, 0, NULL);
+			error = gfs2_alloc_blocks(ip, &block, &n, 0);
 			if (error)
 				return error;
 			gfs2_trans_remove_revoke(sdp, block, 1);
@@ -1002,7 +1002,7 @@ static int ea_set_block(struct gfs2_inode *ip, struct gfs2_ea_request *er,
 	} else {
 		u64 blk;
 		unsigned int n = 1;
-		error = gfs2_alloc_blocks(ip, &blk, &n, 0, NULL);
+		error = gfs2_alloc_blocks(ip, &blk, &n, 0);
 		if (error)
 			return error;
 		gfs2_trans_remove_revoke(sdp, blk, 1);
-- 
2.41.0

