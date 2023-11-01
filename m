Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7C15E86
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/hRSXlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VU+ZT0DhIggCNbJwZC/lI0da+fcsMYNWoE9JFnQuYc=;
	b=b/hRSXlmRjnORHqTmLeAknLf5NEwPbuvwO0DY9UTMCUhLJ3QMr0XwNZ+5OgXxuDpWjuZQ6
	B6JntCtQZ921LfQO4AEjDjQL6LdFWyLRWPxfI3J7EiLrfVWfy50L9/F3DXEs9o/X1TCsaG
	c7liWk7m0FKr53iFtzdR9chqmGFPpj8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-HiLOKIE7OjaTsb-cklZPww-1; Wed,
 01 Nov 2023 12:46:31 -0400
X-MC-Unique: HiLOKIE7OjaTsb-cklZPww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7217F28B72FD
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:31 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E404740C6EBF;
	Wed,  1 Nov 2023 16:46:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 18/25] gfs2: Minor gfs2_write_jdata_batch PAGE_SIZE cleanup
Date: Wed,  1 Nov 2023 17:46:08 +0100
Message-ID: <20231101164615.1138692-19-agruenba@redhat.com>
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

In gfs2_write_jdata_batch(), to compute the number of blocks, compute
the total size of the folio batch instead of the number of pages it
contains.  Not a functional change.

Note that we don't currently allow mounting filesystems with a block
size bigger than the page size.  We could change that after converting
the page cache to folios.  The page cache would then only contain
block-size or bigger folios, so rounding wouldn't become an issue here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 52fad5bcb047..494484427ee3 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -214,12 +214,12 @@ static int gfs2_write_jdata_batch(struct address_space *mapping,
 	unsigned nrblocks;
 	int i;
 	int ret;
-	int nr_pages = 0;
+	size_t size = 0;
 	int nr_folios = folio_batch_count(fbatch);
 
 	for (i = 0; i < nr_folios; i++)
-		nr_pages += folio_nr_pages(fbatch->folios[i]);
-	nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
+		size += folio_size(fbatch->folios[i]);
+	nrblocks = size >> inode->i_blkbits;
 
 	ret = gfs2_trans_begin(sdp, nrblocks, nrblocks);
 	if (ret < 0)
-- 
2.41.0

