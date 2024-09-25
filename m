Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A91D5AD5
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301821; cv=none; b=KqAkLuFrUp2WOmxYMrDowSgXM3qko8gM/VhLTZKj0ZcwtQOq9yiO1pnFsb+PVghrp3uKU++owz+ylNgut2whFCZvor68j8FjjUiUf30eOJesdy2VjUiWsq6osFhORDHf2tHHl4wX2QcYpOZonHYFOpDTcUTIG62xK4aJDEOPlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301821; c=relaxed/simple;
	bh=y5rlyj+1HsYCd9ELlBtVvfkYa9nNNJ2AakypkfbY02k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNBGyNF7rvLqCpNaoDekKilamyCJ31yD+W+3yfFMEU20ex90/1mrUw4pAAasPFiHpVzZrnHnyatIGr6hYNL/jKlM1yguRtidNRQUXFq+aCXVSBAcGolHxWVGLBiQsXltyniIglUZMUhRjzBKrWm7dYFXwfUt7V/4m3ZtJAARGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9Th4eum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9Th4eum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhet1T1jeSU1tjxmpCEEWZduNctJPqx9C2K1VhofyIo=;
	b=c9Th4eumFjKP7tupDvWvSwRqTp1yz0+qPlJJDjAV+vAtAeUvh7UH6QpH8FJFrKsa5gLR0f
	51v3Jy0de27JnX2Oz/23S8vFF0eIaMGjV+8mHb0It4pf62Y47I4SjxhA2xaRyNtfhVy3TG
	jQ/Lv4byUe+AXCosonEOv1oY32lQkT8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-1ZF20y-ZN2ikfFItQXZSvA-1; Wed,
 25 Sep 2024 18:03:37 -0400
X-MC-Unique: 1ZF20y-ZN2ikfFItQXZSvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 219AD197904A
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:37 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 273E219560AA;
	Wed, 25 Sep 2024 22:03:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/16] gfs2: Initialize gl_no_formal_ino earlier
Date: Thu, 26 Sep 2024 00:03:12 +0200
Message-ID: <20240925220331.417856-3-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Set gl_no_formal_ino of the iopen glock to the generation of the
associated inode (ip->i_no_formal_ino) as soon as that value is known.
This saves us from setting it later, possibly repeatedly, when queuing
GLF_VERIFY_DELETE work.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 1 -
 fs/gfs2/glops.c | 9 ++++++++-
 fs/gfs2/inode.c | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5addf4ebf33b..96894243d03b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -980,7 +980,6 @@ static bool gfs2_try_evict(struct gfs2_glock *gl)
 		ip = NULL;
 	spin_unlock(&gl->gl_lockref.lock);
 	if (ip) {
-		gl->gl_no_formal_ino = ip->i_no_formal_ino;
 		set_bit(GIF_DEFERRED_DELETE, &ip->i_flags);
 		d_prune_aliases(&ip->i_inode);
 		iput(&ip->i_inode);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 95d8081681dc..dbc444bfc630 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -494,11 +494,18 @@ int gfs2_inode_refresh(struct gfs2_inode *ip)
 static int inode_go_instantiate(struct gfs2_glock *gl)
 {
 	struct gfs2_inode *ip = gl->gl_object;
+	struct gfs2_glock *io_gl;
+	int error;
 
 	if (!ip) /* no inode to populate - read it in later */
 		return 0;
 
-	return gfs2_inode_refresh(ip);
+	error = gfs2_inode_refresh(ip);
+	if (error)
+		return error;
+	io_gl = ip->i_iopen_gh.gh_gl;
+	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
+	return 0;
 }
 
 static int inode_go_held(struct gfs2_holder *gh)
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 1b95db2c3aac..6fbbaaad1cd0 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -750,6 +750,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_free_inode;
 	gfs2_cancel_delete_work(io_gl);
+	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
 
 retry:
 	error = insert_inode_locked4(inode, ip->i_no_addr, iget_test, &ip->i_no_addr);
-- 
2.46.0

