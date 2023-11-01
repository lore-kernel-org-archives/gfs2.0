Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDD15E83
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfQsUB52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJktxJItJfOm9mdfrV2yrIvR2cps9LUHekSaKXFCxSU=;
	b=dfQsUB52aR1WJzeiAlKLVb1AjgKO5wxoExKPyAUlaznGGONUfM3o1uLSqWubgcsfCuGEvU
	KZkW2egP2PU91GQqyuBM0OD/7m3Wp0pbFFxPCtEQ2a9zGVluctCHePFczrLjpm5+2K2jjQ
	nGP6+3Jjk7r4ScD9M/H9c/OrFEj6XxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-wa7HP93nOpmC-sMInh5dEw-1; Wed, 01 Nov 2023 12:46:28 -0400
X-MC-Unique: wa7HP93nOpmC-sMInh5dEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58EAB811E8E
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:28 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCCF240C6EBF;
	Wed,  1 Nov 2023 16:46:27 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/25] gfs2: Initialize metapaths outside of __gfs2_iomap_get
Date: Wed,  1 Nov 2023 17:46:04 +0100
Message-ID: <20231101164615.1138692-15-agruenba@redhat.com>
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

Initialize metapaths outside of __gfs2_iomap_get().  This saves us from
having to release the metapath in gfs2_iomap_begin_write() before
calling __gfs2_iomap_get() a second time.

Also gets rid of instances where mp_aheight is set to 1 for stuffed
inodes.  (In those cases, mp_aheight isn't used, though.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 57 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 240f73e402d0..f00223919b0b 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -317,6 +317,26 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 	}
 }
 
+/*
+ * init_metapath - initialize a metapath
+ * @mp: The metapath
+ * @inode: The inode
+ */
+static int
+init_metapath(struct metapath *mp, struct inode *inode)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct buffer_head *dibh;
+	int ret;
+
+	memset(mp, 0, sizeof(*mp));
+	ret = gfs2_meta_inode_buffer(ip, &dibh);
+	if (!ret)
+		mp->mp_bh[0] = dibh;
+	mp->mp_aheight = gfs2_is_stuffed(ip) ? 0 : 1;
+	return ret;
+}
+
 static inline struct buffer_head *
 metapath_dibh(struct metapath *mp)
 {
@@ -849,10 +869,10 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	__be64 *ptr;
 	sector_t lblock;
 	sector_t lblock_stop;
-	int ret;
+	int ret = 0;
 	int eob;
 	u64 len;
-	struct buffer_head *dibh = NULL, *bh;
+	struct buffer_head *bh;
 	u8 height;
 
 	if (!length)
@@ -860,12 +880,9 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 
 	down_read(&ip->i_rw_mutex);
 
-	ret = gfs2_meta_inode_buffer(ip, &dibh);
-	if (ret)
-		goto unlock;
-	mp->mp_bh[0] = dibh;
-
 	if (gfs2_is_stuffed(ip)) {
+		struct buffer_head *dibh = metapath_dibh(mp);
+
 		if (flags & IOMAP_WRITE) {
 			loff_t max_size = gfs2_max_stuffed_size(ip);
 
@@ -1055,7 +1072,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 			ret = gfs2_unstuff_dinode(ip);
 			if (ret)
 				goto out_trans_end;
-			release_metapath(mp);
+			mp->mp_aheight = 1;
 			ret = __gfs2_iomap_get(inode, iomap->offset,
 					       iomap->length, flags, iomap, mp);
 			if (ret)
@@ -1097,13 +1114,16 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 			    struct iomap *srcmap)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct metapath mp = { .mp_aheight = 1, };
+	struct metapath mp;
 	int ret;
 
 	if (gfs2_is_jdata(ip))
 		iomap->flags |= IOMAP_F_BUFFER_HEAD;
 
 	trace_gfs2_iomap_start(ip, pos, length, flags);
+	ret = init_metapath(&mp, inode);
+	if (ret)
+		goto out_unlock;
 	ret = __gfs2_iomap_get(inode, pos, length, flags, iomap, &mp);
 	if (ret)
 		goto out_unlock;
@@ -1409,9 +1429,12 @@ static int trunc_start(struct inode *inode, u64 newsize)
 int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		   struct iomap *iomap)
 {
-	struct metapath mp = { .mp_aheight = 1, };
+	struct metapath mp;
 	int ret;
 
+	ret = init_metapath(&mp, inode);
+	if (ret)
+		return ret;
 	ret = __gfs2_iomap_get(inode, pos, length, 0, iomap, &mp);
 	release_metapath(&mp);
 	return ret;
@@ -1420,9 +1443,12 @@ int gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 int gfs2_iomap_alloc(struct inode *inode, loff_t pos, loff_t length,
 		     struct iomap *iomap)
 {
-	struct metapath mp = { .mp_aheight = 1, };
+	struct metapath mp;
 	int ret;
 
+	ret = init_metapath(&mp, inode);
+	if (ret)
+		return ret;
 	ret = __gfs2_iomap_get(inode, pos, length, IOMAP_WRITE, iomap, &mp);
 	if (!ret && iomap->type == IOMAP_HOLE)
 		ret = __gfs2_iomap_alloc(inode, iomap, &mp);
@@ -1716,8 +1742,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	u64 maxsize = sdp->sd_heightsize[ip->i_height];
-	struct metapath mp = {};
-	struct buffer_head *dibh, *bh;
+	struct metapath mp;
+	struct buffer_head *bh;
 	struct gfs2_holder rd_gh;
 	unsigned int bsize_shift = sdp->sd_sb.sb_bsize_shift;
 	u64 lblock = (offset + (1 << bsize_shift) - 1) >> bsize_shift;
@@ -1787,11 +1813,10 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	}
 	start_aligned = mp_h;
 
-	ret = gfs2_meta_inode_buffer(ip, &dibh);
+	ret = init_metapath(&mp, &ip->i_inode);
 	if (ret)
 		return ret;
 
-	mp.mp_bh[0] = dibh;
 	ret = lookup_metapath(ip, &mp);
 	if (ret)
 		goto out_metapath;
@@ -1944,6 +1969,8 @@ static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length)
 	}
 
 	if (btotal) {
+		struct buffer_head *dibh = metapath_dibh(&mp);
+
 		if (current->journal_info == NULL) {
 			ret = gfs2_trans_begin(sdp, RES_DINODE + RES_STATFS +
 					       RES_QUOTA, 0);
-- 
2.41.0

