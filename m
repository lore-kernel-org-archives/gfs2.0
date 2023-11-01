Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC315E8E
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRlHjiB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIbTI/N/pYuPdhKYKJgDATUkolBUixSAmr9FFwNJkdw=;
	b=NRlHjiB4MAQCYXDOKWEbfxuqk4RFztYJpa1VVAreyezU8E3XJQ3YW0L1swTdqZnqA/qkCs
	I/ZSy7BGY7CngOUTtbK32bX/vGjDSuTkRpXQOw1UF5HushSyh2wePoFN1qk8dOY/i8FGHY
	4yOkiTRCTTEhshGd1ORCgGHEVRmJvbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-yp9ofa0qOzGBvGbm4eqHYQ-1; Wed,
 01 Nov 2023 12:46:32 -0400
X-MC-Unique: yp9ofa0qOzGBvGbm4eqHYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AE303C1F122
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:32 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD61C40C6EBF;
	Wed,  1 Nov 2023 16:46:31 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 19/25] gfs2: Convert stuffed_readpage to folios
Date: Wed,  1 Nov 2023 17:46:09 +0100
Message-ID: <20231101164615.1138692-20-agruenba@redhat.com>
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

Change stuffed_readpage() to take a folio instead of a page.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 494484427ee3..98bc02f890d1 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -403,27 +403,27 @@ static int gfs2_jdata_writepages(struct address_space *mapping,
 }
 
 /**
- * stuffed_readpage - Fill in a Linux page with stuffed file data
+ * stuffed_readpage - Fill in a Linux folio with stuffed file data
  * @ip: the inode
- * @page: the page
+ * @folio: the folio
  *
  * Returns: errno
  */
-static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
+static int stuffed_readpage(struct gfs2_inode *ip, struct folio *folio)
 {
 	struct buffer_head *dibh;
-	u64 dsize = i_size_read(&ip->i_inode);
-	void *kaddr;
+	size_t i_size = i_size_read(&ip->i_inode);
+	void *data;
 	int error;
 
 	/*
 	 * Due to the order of unstuffing files and ->fault(), we can be
-	 * asked for a zero page in the case of a stuffed file being extended,
+	 * asked for a zero folio in the case of a stuffed file being extended,
 	 * so we need to supply one here. It doesn't happen often.
 	 */
-	if (unlikely(page->index)) {
-		zero_user(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+	if (unlikely(folio->index)) {
+		folio_zero_range(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 		return 0;
 	}
 
@@ -431,13 +431,11 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 	if (error)
 		return error;
 
-	kaddr = kmap_local_page(page);
-	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
-	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
-	kunmap_local(kaddr);
-	flush_dcache_page(page);
+	data = dibh->b_data + sizeof(struct gfs2_dinode);
+	memcpy_to_folio(folio, 0, data, i_size);
+	folio_zero_range(folio, i_size, folio_size(folio) - i_size);
 	brelse(dibh);
-	SetPageUptodate(page);
+	folio_mark_uptodate(folio);
 
 	return 0;
 }
@@ -458,7 +456,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
 		error = iomap_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
-		error = stuffed_readpage(ip, &folio->page);
+		error = stuffed_readpage(ip, folio);
 		folio_unlock(folio);
 	} else {
 		error = mpage_read_folio(folio, gfs2_block_map);
-- 
2.41.0

