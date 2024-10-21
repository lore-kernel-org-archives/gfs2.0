Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D51CF5E1
	for <gfs2@lists.linux.dev>; Mon, 21 Oct 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541245; cv=none; b=JP0xtXY4d0P85rnB13zYbcSAUjeJBSyXFQ2qZb/7t5v8ObuZMT7af7Cu3JCQSl8Kg6JWNhzDT2/64Ly1zbCgvxg5GqMNpVeuJnSqnHPDWRo4zrOUwiL2rwkPQbCve+IFrpQg87Dq26cMADKwrhUcROw/ThtbO3WT131x/cR+sy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541245; c=relaxed/simple;
	bh=dnBbHtYo/9cXdk688cre3OBh0deTTBI0h00WTTPou74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0q+jHvm3p1hIewqpPoG37zAjPDNDSXlFChT0Ev00Csuj5KaQ8tBnLok+dBqrL7lfPJTPiK8pZmL/C9j+eT7eSqzzdlWes2itT8SF4kpuvoQ5m8aTQOddTFkLlHpXsSe45r3edgPQ0tMSe30XGb2sS/jUdj3C0QT8e9d8SEtlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1xBxefu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1xBxefu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729541242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VibIZXzbFb56BBtrIzYZfviJzsIbQt5aT7YbVUZhnNA=;
	b=d1xBxefuhF41XDy2uSpQbUCaY9t1hZtdi8saqb2DmM62QMQs2r4wSuU5aZFaXZZYMGafc3
	2AdaIGWKlCHVSfMvPNWGWD7oJ/WwAvwoddrG+8xt55w9OXWwuEDQHnFRkz9vH+O7f0ybpf
	eA4YmyAgiryIMYi1zMPj1XOZc93zkbc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-y_tZkk57OouJ2OOz7uTkcw-1; Mon,
 21 Oct 2024 16:07:21 -0400
X-MC-Unique: y_tZkk57OouJ2OOz7uTkcw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AE2C1955D94
	for <gfs2@lists.linux.dev>; Mon, 21 Oct 2024 20:07:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.39.192.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BFE51956056;
	Mon, 21 Oct 2024 20:07:19 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Flush glock work queue on inode lookup / create
Date: Mon, 21 Oct 2024 22:07:18 +0200
Message-ID: <20241021200718.73074-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When an inode is looked up or created, the corresponding inode glock may
be in the glock cache already.  In that case, the inode glock is either
unlocked already, or a delayed demote request to state LM_ST_UNLOCKED
from the last user of that glock must still be queued.

gfs2_inode_lookup() and gfs2_create_inode() can only deal with unlocked
inode glocks, so the latter case is a problem for them.  To ensure that
we don't end up in that case, flush the glock work before reusing a
glock.  (This will have no effect in the case of new glocks.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6fbbaaad1cd0..3396ef72413e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -136,6 +136,8 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 				       &ip->i_gl);
 		if (unlikely(error))
 			goto fail;
+		/* Ensure that the glock is unlocked. */
+		flush_delayed_work(&ip->i_gl->gl_work);
 
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CREATE,
 				       &io_gl);
@@ -745,6 +747,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
 	if (error)
 		goto fail_free_inode;
+	/* Ensure that the glock is unlocked. */
+	flush_delayed_work(&ip->i_gl->gl_work);
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
-- 
2.46.2

