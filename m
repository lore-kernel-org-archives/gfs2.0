Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55515E82
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCIgDG5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZgiBZQbsv+p1NBwJtSqcDiNiKU50ABEwPymd9P/Xms=;
	b=RCIgDG5tAfvIX41r/vZpOIqgxLpPdST7bgIhOlH7c0P3I1eB4plPHei/BGWSQh/Oy3aKV9
	yNFJ5ZsxIwxPj6MV3omPyR1JWMHuA+h8Noe2FWYW0Q53tEwR8KWZ7NlJi00TTo8aa1movZ
	ppcrl2GDF4/3D7jVYCAnv3JJaYLNm6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ZreBIkiXNQSV5het6wuj0w-1; Wed, 01 Nov 2023 12:46:33 -0400
X-MC-Unique: ZreBIkiXNQSV5het6wuj0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 056AD85A5B5
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77CBC40C6EBC;
	Wed,  1 Nov 2023 16:46:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 20/25] gfs2: Convert gfs2_internal_read to folios
Date: Wed,  1 Nov 2023 17:46:10 +0100
Message-ID: <20231101164615.1138692-21-agruenba@redhat.com>
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

Change gfs2_internal_read() to use folios.  Convert sizes to size_t.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c  | 34 ++++++++++++++++------------------
 fs/gfs2/inode.h |  4 ++--
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 98bc02f890d1..23fc474046fb 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -477,31 +477,29 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
  *
  */
 
-int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
-                       unsigned size)
+ssize_t gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
+			   size_t size)
 {
 	struct address_space *mapping = ip->i_inode.i_mapping;
 	unsigned long index = *pos >> PAGE_SHIFT;
-	unsigned offset = *pos & (PAGE_SIZE - 1);
-	unsigned copied = 0;
-	unsigned amt;
-	struct page *page;
+	size_t copied = 0;
 
 	do {
-		page = read_cache_page(mapping, index, gfs2_read_folio, NULL);
-		if (IS_ERR(page)) {
-			if (PTR_ERR(page) == -EINTR)
+		size_t offset, chunk;
+		struct folio *folio;
+
+		folio = read_cache_folio(mapping, index, gfs2_read_folio, NULL);
+		if (IS_ERR(folio)) {
+			if (PTR_ERR(folio) == -EINTR)
 				continue;
-			return PTR_ERR(page);
+			return PTR_ERR(folio);
 		}
-		amt = size - copied;
-		if (offset + size > PAGE_SIZE)
-			amt = PAGE_SIZE - offset;
-		memcpy_from_page(buf + copied, page, offset, amt);
-		put_page(page);
-		copied += amt;
-		index++;
-		offset = 0;
+		offset = *pos + copied - folio_pos(folio);
+		chunk = min(size - copied, folio_size(folio) - offset);
+		memcpy_from_folio(buf + copied, folio, offset, chunk);
+		index = folio_next_index(folio);
+		folio_put(folio);
+		copied += chunk;
 	} while(copied < size);
 	(*pos) += size;
 	return size;
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 908c739220b8..041b93367002 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -13,8 +13,8 @@
 #include "util.h"
 
 bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask);
-extern int gfs2_internal_read(struct gfs2_inode *ip,
-			      char *buf, loff_t *pos, unsigned size);
+extern ssize_t gfs2_internal_read(struct gfs2_inode *ip,
+				  char *buf, loff_t *pos, size_t size);
 extern void gfs2_set_aops(struct inode *inode);
 
 static inline int gfs2_is_stuffed(const struct gfs2_inode *ip)
-- 
2.41.0

