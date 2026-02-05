Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A222339
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311162; cv=none; b=kbs9IgxdEW6vqxciS6loegkx0mZqsNi6JHSOzey3vXSAk0xAurCBHQAQIBNQg98fS2qMxfWi49XOJZ5Rc7xRbVo9on4S4j2fy/nAjmZrEHNYBU6J59FfjxhCtuq7MyNtZD2ZP0bKy+T4VoH7FXUQyLolig6+kp0QpitzGWwd104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311162; c=relaxed/simple;
	bh=mxdsqLQzKwujBVpb80GBqNJLBqaCY5lOGVkBV8ZZGAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ekDQhqwddZW90b7I7ffo0UpnM4moOW0rUhLRbnJCh1JrYZ/JJ/LpDUJvl+f3qw1SooFXBH53kLE+dgTk2KHx40XwEhWTU5tKRypSz+oX7TyRTC++l4zgxDw3vN4+lIrPFC2AoLxeg+q2USMnDnja6AbYPqcdaa1Ca4sYpJw9rq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCb99iKg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCb99iKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770311161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8jyPMf0RawOV4Uk46BJulibP8G6RSkLSbbL/Gox//uA=;
	b=DCb99iKgLAbdtNrah+YziM4YO+p7HO4sEplRUBBBRxqRFhEtPndVBYLIHF/uLWLvnCZGx9
	vmhNClCIlacldcOT2EbaQWXlqtjboohAk00Ctm4FZtN5NCx9eKc3ZJcSvapPhuOPXhRtaX
	YXYa3T4zFJWZE6nLmdR0LJQP62zDBZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-15j5gRF3O2ioATSvcWQ1UA-1; Thu,
 05 Feb 2026 12:05:59 -0500
X-MC-Unique: 15j5gRF3O2ioATSvcWQ1UA-1
X-Mimecast-MFC-AGG-ID: 15j5gRF3O2ioATSvcWQ1UA_1770311158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84BEB1964CE4
	for <gfs2@lists.linux.dev>; Thu,  5 Feb 2026 17:05:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.226.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87FB2192C7CD;
	Thu,  5 Feb 2026 17:05:51 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: fiemap page fault fix
Date: Thu,  5 Feb 2026 18:05:50 +0100
Message-ID: <20260205170550.1167774-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lVoWrFQFtWeAuvUzqyozy85E4f1L2XE9Y8q3QCoDGC8_1770311158
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In gfs2_fiemap(), we are calling iomap_fiemap() while holding the inode
glock.  This can lead to recursive glock taking if the fiemap buffer is
memory mapped to the same inode and accessing it triggers a page fault.

Fix by disabling page faults for iomap_fiemap() and faulting in the
buffer by hand if necessary.

Fixes xfstest generic/742.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b6ed069b3487..4d65e4a75262 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2192,6 +2192,14 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static bool fault_in_fiemap(struct fiemap_extent_info *fi)
+{
+	struct fiemap_extent __user *dest = fi->fi_extents_start;
+	size_t size = sizeof(*dest) * fi->fi_extents_max;
+
+	return fault_in_safe_writeable((char __user *)dest, size) == 0;
+}
+
 static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len)
 {
@@ -2201,14 +2209,22 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	inode_lock_shared(inode);
 
+retry:
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	if (ret)
 		goto out;
 
+	pagefault_disable();
 	ret = iomap_fiemap(inode, fieinfo, start, len, &gfs2_iomap_ops);
+	pagefault_enable();
 
 	gfs2_glock_dq_uninit(&gh);
 
+	if (ret == -EFAULT && fault_in_fiemap(fieinfo)) {
+		fieinfo->fi_extents_mapped = 0;
+		goto retry;
+	}
+
 out:
 	inode_unlock_shared(inode);
 	return ret;
-- 
2.52.0

