Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8C3C0621
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091944; cv=none; b=owLZ97KE0lg34XeEew05C2xKd180vqNBbUS0mSWBmwtsIMMf0MYu0dw3hY1kfLZt0l3Tw4ASNu0jIxFO5Rn1BUxZNSUSz8S/4KvGP28gBUooh5r41pZiOEloAIDR/OfdwW0+Z7NKrgLJ9P4Iw13b0uMxVBSAHOGy14ZZqGfbBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091944; c=relaxed/simple;
	bh=BL9XG+FbnhbmgVrYtmNsHIF82qgRUbac6aXtPR5XBvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=R9oEIv9xkLdLia/KDhopJRaRbSwm/AeU8ivbNvnUuyTkRVCwlXAEBPaAIXraW/XQgg0sfajrA1N77b3kgoxsEP4jFfcNs1/7UyzzuPl55qbwJuKjlDsmTBNO0I8KUdITon6FQMYRrD4YTH7FwnWGihuWZbq3+qezy1JE0VrdaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxgMCTLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxgMCTLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776091941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psMi1PRTkO2Ht8mjpBzBt0WEBvRKtVyu0bkH3OUMfOM=;
	b=IxgMCTLXjdrOw9Kao8978xk8hNhmA4ldC50zdjwImCKC57PiqfCDUBmZIjk/SgBT+f01/U
	d4pnYNkkFu3Xm6eEzZANDgIptdmFajWZmDco0S726wD5VOYEhkQP8tOiORMwDXMTuf7F5q
	P3ostZbNDV9svIEjLrqmW9SVuQGve1I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-dWagoob8MPO8NPoSoG-qEQ-1; Mon,
 13 Apr 2026 10:52:17 -0400
X-MC-Unique: dWagoob8MPO8NPoSoG-qEQ-1
X-Mimecast-MFC-AGG-ID: dWagoob8MPO8NPoSoG-qEQ_1776091936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52F5F180120E;
	Mon, 13 Apr 2026 14:52:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEA8C19560AB;
	Mon, 13 Apr 2026 14:52:14 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
Subject: [PATCH 01/18] gfs2: Call unlock_new_inode before d_instantiate
Date: Mon, 13 Apr 2026 16:51:54 +0200
Message-ID: <20260413145211.881752-2-agruenba@redhat.com>
In-Reply-To: <20260413145211.881752-1-agruenba@redhat.com>
References: <20260413145211.881752-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ntW5Gq4uXkF1x78jBkIHjLAGuf7kiAR73X5nwpOOwxA_1776091936
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As Neil Brown describes in detail in the link referenced below, new
inodes must be unlocked before they can be instantiated.

An even better fix is to use d_instantiate_new(), which combines
d_instantiate() and unlock_new_inode().

Fixes: 3d36e57ff768 ("gfs2: gfs2_create_inode rework")
Reported-by: syzbot+0ea5108a1f5fb4fcc2d8@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-fsdevel/177153754005.8396.8777398743501764194@noble.neil.brown.name/
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8344040ecaf7..e9bf4879c07f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -892,7 +892,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 		goto fail_gunlock4;
 
 	mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	/* After instantiate, errors should result in evict which will destroy
 	 * both inode and iopen glocks properly. */
 	if (file) {
@@ -904,7 +904,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&gh);
 	gfs2_glock_put(io_gl);
 	gfs2_qa_put(dip);
-	unlock_new_inode(inode);
 	return error;
 
 fail_gunlock4:
-- 
2.53.0

