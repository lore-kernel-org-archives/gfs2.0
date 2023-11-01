Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0015E84
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPSxh/pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ5ZY/46fLp/XH9R6zBNAbnNMWw6F8iHEyX9b1E75oc=;
	b=BPSxh/pc82yeVVTz1JsUOoIV1nnX7ho1wperb/8ym8seNe2NFQOHOIhOE1eaRCLTG/flJQ
	ritxxQOyREAO5GdlXK5lHDKudIqN62Z0VUzHofOGOmH/VfIoaIipxAUY2ROwvmLSNVySgr
	FtBUW+EO7oI4SUGFRprAAX9dpqNva8w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-pLlLdveHM0Og36HqscEH2A-1; Wed,
 01 Nov 2023 12:46:19 -0400
X-MC-Unique: pLlLdveHM0Og36HqscEH2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EE841C068D4
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:19 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3D8340C6EC9;
	Wed,  1 Nov 2023 16:46:18 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/25] gfs2: Remove unused gfs2_extent_length argument
Date: Wed,  1 Nov 2023 17:45:53 +0100
Message-ID: <20231101164615.1138692-4-agruenba@redhat.com>
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

The limit argument of gfs2_extent_length() is unused.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..47d0f39feeb1 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -415,13 +415,12 @@ static void release_metapath(struct metapath *mp)
  * gfs2_extent_length - Returns length of an extent of blocks
  * @bh: The metadata block
  * @ptr: Current position in @bh
- * @limit: Max extent length to return
  * @eob: Set to 1 if we hit "end of block"
  *
  * Returns: The length of the extent (minimum of one block)
  */
 
-static inline unsigned int gfs2_extent_length(struct buffer_head *bh, __be64 *ptr, size_t limit, int *eob)
+static inline unsigned int gfs2_extent_length(struct buffer_head *bh, __be64 *ptr, int *eob)
 {
 	const __be64 *end = (__be64 *)(bh->b_data + bh->b_size);
 	const __be64 *first = ptr;
@@ -913,7 +912,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		goto do_alloc;
 
 	bh = mp->mp_bh[ip->i_height - 1];
-	len = gfs2_extent_length(bh, ptr, len, &eob);
+	len = gfs2_extent_length(bh, ptr, &eob);
 
 	iomap->addr = be64_to_cpu(*ptr) << inode->i_blkbits;
 	iomap->length = len << inode->i_blkbits;
-- 
2.41.0

