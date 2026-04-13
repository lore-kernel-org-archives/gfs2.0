Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6835838B
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092159; cv=none; b=KFuu9ETzd8TdHbZwCsjl3ewSN2b660n27BuR0uSXCEr/I2+ZqjBVVXlO2IKg+1CJu7uuOr/WvAQje8aiuKN7LrOimrRPmlbnr9Bz9b4c7rrnDcKJnOe0Ad354g/g3fWNSd71sQ9YCu3gqWZofiU+fCyRZJ2MJxSDZK/t4l5jdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092159; c=relaxed/simple;
	bh=gJ57onl3f47dAS4Vp9tsItPdddRPQ7b6ZFtENu2w9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lyI3pSP8yiDm8+LcFQqisesQcsrOV9dWo5v2jEYtrkG99yLg4GQjqobVutFXIfl5xWhqrQ+onpF5VQoyUV7jLVHktKaCKprg7vWV5u1TAnQbpHvIIV6EpbrP7L/sotlKam3eXqufz73AmNfbaxNLkFzR98BBjZLUKVQrmg1g0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiuiA8sl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiuiA8sl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776092157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlv6FY/CulFEfkauFf8HwOt1DKmdLN5GX6ZrVzWqd84=;
	b=BiuiA8slVGbfCZe5HdJ5w20tBis3//l0zEw/Na9agvUZmr4zO9X4jvbttY1AHk6LHa1Nqx
	+UK//4LoLQxz4ioofBAlomCPFW0FF2N21sXQ2gzu97zEOUR1LYrzOqErbjs76xjV+LNJh4
	PBj9o3Dglyxh7afXR5Lb+zDbtRi7T8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-OrZV6DxsOcWFKmr0FbD-Yg-1; Mon,
 13 Apr 2026 10:52:21 -0400
X-MC-Unique: OrZV6DxsOcWFKmr0FbD-Yg-1
X-Mimecast-MFC-AGG-ID: OrZV6DxsOcWFKmr0FbD-Yg_1776091940
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1AE61956095
	for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 14:52:20 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACC3119560AB;
	Mon, 13 Apr 2026 14:52:19 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/18] gfs2: minor evict_[un]linked_inode cleanup
Date: Mon, 13 Apr 2026 16:51:57 +0200
Message-ID: <20260413145211.881752-5-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vF8SMhjvjmNZOv-K-ApwqGnABlWFCsxPElTMOWkZBHk_1776091940
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add gl helper variables in evict_unlinked_inode() and
evict_linked_inode().  This patch isn't very interesting by itself, but
it makes the next patch more readable.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9149fa375ef3..b20494d6730a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1283,6 +1283,7 @@ static enum evict_behavior evict_should_delete(struct inode *inode,
 static int evict_unlinked_inode(struct inode *inode)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = ip->i_gl;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode) &&
@@ -1317,8 +1318,8 @@ static int evict_unlinked_inode(struct inode *inode)
 	 */
 
 	ret = gfs2_dinode_dealloc(ip);
-	if (!ret && ip->i_gl)
-		gfs2_inode_remember_delete(ip->i_gl, ip->i_no_formal_ino);
+	if (!ret && gl)
+		gfs2_inode_remember_delete(gl, ip->i_no_formal_ino);
 
 out:
 	return ret;
@@ -1362,18 +1363,19 @@ static int evict_linked_inode(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_glock *gl = ip->i_gl;
 	struct address_space *metamapping;
 	int ret;
 
-	gfs2_log_flush(sdp, ip->i_gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
+	gfs2_log_flush(sdp, gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
 		       GFS2_LFC_EVICT_INODE);
-	metamapping = gfs2_glock2aspace(ip->i_gl);
-	if (test_bit(GLF_DIRTY, &ip->i_gl->gl_flags)) {
+	metamapping = gfs2_glock2aspace(gl);
+	if (test_bit(GLF_DIRTY, &gl->gl_flags)) {
 		filemap_fdatawrite(metamapping);
 		filemap_fdatawait(metamapping);
 	}
 	write_inode_now(inode, 1);
-	gfs2_ail_flush(ip->i_gl, 0);
+	gfs2_ail_flush(gl, 0);
 
 	ret = gfs2_truncate_inode_pages(inode);
 	if (ret)
-- 
2.53.0

