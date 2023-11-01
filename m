Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4D15E85
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSz/8K4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd8A6TfGcqtbHJyxQUrE66BhJSo57fJMeNPdt0WVzAg=;
	b=OSz/8K4SxAYMPBj5XwHrWZO3cre5WU2bTrcDqd6VB8NZrSzXfPoFsU0VQh1QEI5sAAH5A1
	mLQW0fY65FE9Tx6rO6TXAUygdAklJh8XcyW/QSPtuN5VH686dOUjt1ILU6wD6JokiOLFNt
	tyUpk9e6dVaJ/iT70aBCJZo6HiJpINM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-xl9Zr2_qO2ygapu6bg5khA-1; Wed, 01 Nov 2023 12:46:30 -0400
X-MC-Unique: xl9Zr2_qO2ygapu6bg5khA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0013185A785
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:29 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6011540C6EBF;
	Wed,  1 Nov 2023 16:46:29 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 16/25] gfs2: Remove unnecessary gfs2_iomap_begin_write parameters
Date: Wed,  1 Nov 2023 17:46:06 +0100
Message-ID: <20231101164615.1138692-17-agruenba@redhat.com>
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

Remove some unnecessary parameters of gfs2_iomap_begin_write().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1807747e44a3..ec56a07213d4 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1023,20 +1023,14 @@ static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
 	.put_folio = gfs2_iomap_put_folio,
 };
 
-static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
-				  loff_t length, unsigned flags,
-				  struct iomap *iomap,
-				  struct metapath *mp)
+static int gfs2_iomap_begin_write(struct inode *inode,
+				  struct iomap *iomap, struct metapath *mp)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	bool unstuff;
 	int ret;
 
-	unstuff = gfs2_is_stuffed(ip) &&
-		  pos + length > gfs2_max_stuffed_size(ip);
-
-	if (unstuff || iomap->type == IOMAP_HOLE) {
+	if (iomap->type == IOMAP_HOLE) {
 		unsigned int data_blocks, ind_blocks;
 		struct gfs2_alloc_parms ap = {};
 		unsigned int rblocks;
@@ -1067,7 +1061,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 		if (ret)
 			goto out_trans_fail;
 
-		if (unstuff) {
+		if (gfs2_is_stuffed(ip)) {
 			ret = gfs2_unstuff_dinode(ip);
 			if (ret)
 				goto out_trans_end;
@@ -1151,7 +1145,7 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 		goto out_unlock;
 	}
 
-	ret = gfs2_iomap_begin_write(inode, pos, length, flags, iomap, &mp);
+	ret = gfs2_iomap_begin_write(inode, iomap, &mp);
 
 out_unlock:
 	release_metapath(&mp);
-- 
2.41.0

