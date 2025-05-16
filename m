Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38A22DFF3
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432114; cv=none; b=O5/eQEAn9Pb+TL9tXSvydBDnOv9OF2Fbq4mYxSf97QeOz6aOboTCXjYgZ6gZXZheqmAefxDOkIqixGTtk9A5HByOGzrrvfFsGodCGNwECA5GO0wX1m6DZM5tv1m+2z4KFsIeYyyH1+3mb2g+Htzo3JXOJMaKmDpQludPbfILVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432114; c=relaxed/simple;
	bh=LLcion4Q9CBO8UaT9aNDbRogU3dKeLpIsNgOhWrn/kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PnLXrWvJzuWracgvmHTckfW3wSBd0iTMTmSA/+aoNvRFRsxriXFlWSefgMoCdNtkA1VftnUutcrs9lenKIHL5azIBbb/7cnU1LUigA8QRyRLYimF0qyF5HyYRtZnZjCgB5uvmAcqfKU/AVh9nJFr/AfWdedf+XjKTxtRsXskaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiW7aUed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiW7aUed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BR0pkOL8qxNxAL0qO1nIxt34qeHv+s+IqWZiMW7+fzs=;
	b=eiW7aUedO2qOcqebpWRpJEqb3dTShg9/o2NKgWeHbjTFrfkpWwH3Vh0PQ6bn4wpdO/T2hK
	NyAh/SKUqebyrDw9V5A4JzIhugXAyR8x/UdGr0+JQIClbmo/8h5A/3mwZa7EKH3bQ3YxlS
	HUq6zSj8Vf6UYM7lMNknYt+9XKqwE/A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-qgV_1GsMPs60B9QGZ5V0ww-1; Fri,
 16 May 2025 17:48:29 -0400
X-MC-Unique: qgV_1GsMPs60B9QGZ5V0ww-1
X-Mimecast-MFC-AGG-ID: qgV_1GsMPs60B9QGZ5V0ww_1747432108
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458E6195608C;
	Fri, 16 May 2025 21:48:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8956195608D;
	Fri, 16 May 2025 21:48:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/3] gfs2: Rename jdata_dirty_folio to gfs2_jdata_dirty_folio
Date: Fri, 16 May 2025 23:48:18 +0200
Message-ID: <20250516214822.905056-2-agruenba@redhat.com>
In-Reply-To: <20250516214822.905056-1-agruenba@redhat.com>
References: <20250516214822.905056-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hydXIW4JllTlvAw2mg7cNmk9vDiHNtwW915PgxIhLk0_1747432108
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 5be99d87bcdc..66b0ad9f1f92 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -532,7 +532,7 @@ void adjust_fs_space(struct inode *inode)
 	gfs2_trans_end(sdp);
 }
 
-static bool jdata_dirty_folio(struct address_space *mapping,
+static bool gfs2_jdata_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	if (current->journal_info)
@@ -714,7 +714,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.writepages = gfs2_jdata_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-	.dirty_folio = jdata_dirty_folio,
+	.dirty_folio = gfs2_jdata_dirty_folio,
 	.bmap = gfs2_bmap,
 	.migrate_folio = buffer_migrate_folio,
 	.invalidate_folio = gfs2_invalidate_folio,
-- 
2.49.0

