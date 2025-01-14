Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C741FA8C2
	for <gfs2@lists.linux.dev>; Tue, 14 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877597; cv=none; b=Oi5Xfhl0nPf5j69HFdFV4NnLMcoJCz8HezI0NOY8nezBKl+Q+45qiNVbIWtQ8PWZCd5UTKh6YHDomjvs+4ectjusfD1U9woyRfwHQ+1+gSkWKWwEHislZMh7viCp2XmHVR0W7BXwZqot2CPLUJ1pEfGEynRy4muYMwZAubvMT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877597; c=relaxed/simple;
	bh=lfSLiHatBpPLoBPTrlv4lIadDzkUPAH0ISNNvQoN2TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CPjfjM22dViGCyZiwUSWgpNAq7tDTsHat3MHtqqJKNthMiATUzvqxgBtYFXLC51CJu9b6Znxm8otIfCcF8YtiNEm9BGFbHIT+zfggUXeUXMUNledSjQeB1oLuk7OC0wY8fpBzXLGQ4JhphU8KzfSEBHNlQDsSZWuG+lk2qq0v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3+2J3pl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3+2J3pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QshYZNEnKiLCTguz6Io+tV7Z4F1SXSh75UZLUI1/QPc=;
	b=V3+2J3pluhAyR6zYWjhEJYJMFm4SGdWlB4flaYvh03vaQtPG+znDCvTmqr5oU8ZRkvXmfD
	NVRqFX3jBMlbfN+qF4Td+dvCUmUIMuGuLQrtuDqh4TmuhQ3qYKWDuhzobv2NcYr6szGexv
	BQdDsx9Xw0ND2OS5DqDGdwGao8y3HYM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-PFAAYLjnNQ-3dNRb87HqFg-1; Tue,
 14 Jan 2025 12:59:53 -0500
X-MC-Unique: PFAAYLjnNQ-3dNRb87HqFg-1
X-Mimecast-MFC-AGG-ID: PFAAYLjnNQ-3dNRb87HqFg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E6111955DC8;
	Tue, 14 Jan 2025 17:59:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.79])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD876195608A;
	Tue, 14 Jan 2025 17:59:50 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Kun Hu <huk23@m.fudan.edu.cn>
Subject: [PATCH] gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag
Date: Tue, 14 Jan 2025 18:59:49 +0100
Message-ID: <20250114175949.1196275-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BctCDnZtugShpxJUPSk_42M2m8XS2g7_XfL1RUS-ChQ_1736877592
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Truncate an inode's address space when flipping the GFS2_DIF_JDATA flag:
depending on that flag, the pages in the address space will either use
buffer heads or iomap_folio_state structs, and we cannot mix the two.

Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1e73cf87ff88..c9bb3be21d2b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -251,6 +251,7 @@ static int do_gfs2_set_flags(struct inode *inode, u32 reqflags, u32 mask)
 		error = filemap_fdatawait(inode->i_mapping);
 		if (error)
 			goto out;
+		truncate_inode_pages(inode->i_mapping, 0);
 		if (new_flags & GFS2_DIF_JDATA)
 			gfs2_ordered_del_inode(ip);
 	}
-- 
2.47.1

