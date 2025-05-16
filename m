Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B218E025
	for <gfs2@lists.linux.dev>; Fri, 16 May 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432116; cv=none; b=SpWz0d9Uxga4UqxUqBPY1Dw5Zh4aShfbuHmrweuOBjUY4i11gQHhaUmrC4LmIziqwZ6mQexcFsL1KOIQB+wvYdI1QxmCxX4WWmWS2ZE1EZKY7AfLocGDPXhJ5ecgB6V0lNUILUFBWN1lWDbdswIBRfSkhox+I8zZHwddQ8e66No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432116; c=relaxed/simple;
	bh=LLcion4Q9CBO8UaT9aNDbRogU3dKeLpIsNgOhWrn/kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=c4PKwjtETt5P4l26fF8wSo8O4C9qKWIzJztNGza8+Tf3P+B2Dv/NM5xOvBBh0P39aIVHHH3BE/PD96MX2yGqi0zV8pzlv2KxglHvlrP6xJyNvYPbIWOLdDwrwVuciuPb/4W4JotN+syB01knnD6iw4cvtVFI3hIpuqnAsFTxkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpR2vOGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpR2vOGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747432113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BR0pkOL8qxNxAL0qO1nIxt34qeHv+s+IqWZiMW7+fzs=;
	b=MpR2vOGNI3XvDI+Smvmc9y7opur1Z29Zk9Rb3bjbb9AXN40geoiLJOJm1SiraSpFnft6hd
	298SR20yDRPv2FamUSZy5W+AFi1PkYfMSxZ4uJRvGbXJHnqIhAdTfd3p+9lvOdjT0i9XtV
	QP05SFBQ9SIuWkrGCNY47EnUcO1pviQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-t6tOUBmXPLKjvUuOJ_39-w-1; Fri,
 16 May 2025 17:48:32 -0400
X-MC-Unique: t6tOUBmXPLKjvUuOJ_39-w-1
X-Mimecast-MFC-AGG-ID: t6tOUBmXPLKjvUuOJ_39-w_1747432111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00D34195608C;
	Fri, 16 May 2025 21:48:31 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0F72195608D;
	Fri, 16 May 2025 21:48:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] Rename jdata_dirty_folio to gfs2_jdata_dirty_folio
Date: Fri, 16 May 2025 23:48:19 +0200
Message-ID: <20250516214822.905056-3-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lFSVzkEmAEjtNxL4vHr4dkYPLXhGI_mWmYvOBFw9Bu8_1747432111
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

