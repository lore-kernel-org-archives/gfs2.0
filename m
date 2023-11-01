Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7315E88
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL7vNDVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qIrr6ybf7s7OAQIN6Ok615avvm4AjA5c/mnH8oVbjA=;
	b=KL7vNDVhVe+JqD62epgISpRjmSr6TwHKWMeRnu8Nt4OmJESatLuBKESDJzP++142en1Xeq
	5zlLM56p53qTINQvAgL859iVInBfRokVo/nIFaF8eRCIImsOY7p0Tq/7UqkYiZ5HAmu7DE
	5HrKQIXlkJUm4t/qEXTvryVf4FaJx2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-W-6PfGInN3acLtrGMPKVsg-1; Wed, 01 Nov 2023 12:46:29 -0400
X-MC-Unique: W-6PfGInN3acLtrGMPKVsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 243A485A58C
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:29 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94F7340C6EBC;
	Wed,  1 Nov 2023 16:46:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/25] gfs2: Get rid of repeated call to __gfs2_iomap_get
Date: Wed,  1 Nov 2023 17:46:05 +0100
Message-ID: <20231101164615.1138692-16-agruenba@redhat.com>
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

Right now, gfs2_iomap_begin() calls __gfs2_iomap_get(), and for writes,
it calls gfs2_iomap_begin_write().  When the inode needs to be
unstuffed, gfs2_iomap_begin_write() does that and then it calls
__gfs2_iomap_get() again to look up the mapping the unstuffing has
resulted in.

That works, but it isn't hard to figure out the mapping after unstuffing
without calling __gfs2_iomap_get() a second time, so do that instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index f00223919b0b..1807747e44a3 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -808,29 +808,28 @@ static int __gfs2_iomap_alloc(struct inode *inode, struct iomap *iomap,
  * gfs2_alloc_size - Compute the maximum allocation size
  * @inode: The inode
  * @mp: The metapath
+ * @lblock: The logical starting block number
  * @size: Requested size in blocks
  *
  * Compute the maximum size of the next allocation at @mp.
  *
  * Returns: size in blocks
  */
-static u64 gfs2_alloc_size(struct inode *inode, struct metapath *mp, u64 size)
+static u64 gfs2_alloc_size(struct inode *inode, struct metapath *mp,
+			   sector_t lblock, u64 size)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	const __be64 *first, *ptr, *end;
 
-	/*
-	 * For writes to stuffed files, this function is called twice via
-	 * __gfs2_iomap_get, before and after unstuffing. The size we return the
-	 * first time needs to be large enough to get the reservation and
-	 * allocation sizes right.  The size we return the second time must
-	 * be exact or else __gfs2_iomap_alloc won't do the right thing.
-	 */
-
 	if (gfs2_is_stuffed(ip) || mp->mp_fheight != mp->mp_aheight) {
-		unsigned int maxsize = mp->mp_fheight > 1 ?
-			sdp->sd_inptrs : sdp->sd_diptrs;
+		unsigned int maxsize;
+
+		/* Are we writing to the block resulting from unstuffing? */
+		if (gfs2_is_stuffed(ip) && lblock == 0 && inode->i_size != 0)
+			return 1;
+
+		maxsize = mp->mp_fheight > 1 ? sdp->sd_inptrs : sdp->sd_diptrs;
 		maxsize -= mp->mp_list[mp->mp_fheight - 1];
 		if (size > maxsize)
 			size = maxsize;
@@ -964,7 +963,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		if (flags & IOMAP_DIRECT)
 			goto out;  /* (see gfs2_file_direct_write) */
 
-		len = gfs2_alloc_size(inode, mp, len);
+		len = gfs2_alloc_size(inode, mp, lblock, len);
 		alloc_size = len << inode->i_blkbits;
 		if (alloc_size < iomap->length)
 			iomap->length = alloc_size;
@@ -1073,10 +1072,14 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 			if (ret)
 				goto out_trans_end;
 			mp->mp_aheight = 1;
-			ret = __gfs2_iomap_get(inode, iomap->offset,
-					       iomap->length, flags, iomap, mp);
-			if (ret)
-				goto out_trans_end;
+			if (iomap->offset == 0 && inode->i_size != 0) {
+				__be64 *ptr = metapointer(0, mp);
+				u64 dblock = be64_to_cpu(*ptr);
+
+				iomap->type = IOMAP_MAPPED;
+				iomap->addr = dblock << inode->i_blkbits;
+				iomap->flags |= IOMAP_F_MERGED;
+			}
 		}
 
 		if (iomap->type == IOMAP_HOLE) {
-- 
2.41.0

