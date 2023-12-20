Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE9487B3
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl7tB9CK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBGpGgq2pPG4+qLFNDop04hL5WFwt92YTn0ztesDdkI=;
	b=hl7tB9CKwrZr23A9DH6uD2sYRcQ1Y+ys7BLjInjvtsBzALy4ogtUh5KL1uF5aobkJIT99l
	GWo+AbqbEXjdAI2OgwgQYuXQW99CzYMzIwgMwUwccujSnJIEank8IXcyJ43e8Ohgr0ykmm
	WqK2pb6tWKmOXdEWFRXpl6i5DRs9/Gs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-cEFhzuCmODOtfJgOAv2NpA-1; Wed,
 20 Dec 2023 15:25:00 -0500
X-MC-Unique: cEFhzuCmODOtfJgOAv2NpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E183F299E74B
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:24:59 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44F92C15A0C;
	Wed, 20 Dec 2023 20:24:59 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Abhi Das <adas@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/2] gfs2: Use GL_NOBLOCK flag for non-blocking lookups
Date: Wed, 20 Dec 2023 21:24:57 +0100
Message-ID: <20231220202457.1581334-2-agruenba@redhat.com>
In-Reply-To: <20231220202457.1581334-1-agruenba@redhat.com>
References: <20231220202457.1581334-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Abhi Das <adas@redhat.com>

Add the GL_NOBLOCK flag to the locking requests in gfs2_permission() and
gfs2_drevalidate() when called with the MAY_NOT_BLOCK flag and
LOOKUP_RCU flag, respectively.  This will cause the locking requests to
be handled without sleeping if possible.  We bail out with -ECHILD if we
can't grant the glock immediately.

Make sure not to dget() + dput() the parent dentry in gfs2_drevalidate()
in LOOKUP_RCU mode; dput() is a sleeping operation.

Signed-off-by: Abhi Das <adas@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 23 ++++++++++++++---------
 fs/gfs2/inode.c  |  8 ++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 2e215e8c3c88..177f1f41f225 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -32,21 +32,25 @@
 
 static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 {
-	struct dentry *parent;
+	struct dentry *parent = NULL;
 	struct gfs2_sbd *sdp;
 	struct gfs2_inode *dip;
-	struct inode *inode;
+	struct inode *dinode, *inode;
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip = NULL;
 	int error, valid = 0;
 	int had_lock = 0;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	parent = dget_parent(dentry);
-	sdp = GFS2_SB(d_inode(parent));
-	dip = GFS2_I(d_inode(parent));
+	if (flags & LOOKUP_RCU) {
+		dinode = d_inode_rcu(READ_ONCE(dentry->d_parent));
+		if (!dinode)
+			return -ECHILD;
+	} else {
+		parent = dget_parent(dentry);
+		dinode = d_inode(parent);
+	}
+	sdp = GFS2_SB(dinode);
+	dip = GFS2_I(dinode);
 	inode = d_inode(dentry);
 
 	if (inode) {
@@ -62,7 +66,8 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 
 	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
 	if (!had_lock) {
-		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED,
+					   flags & LOOKUP_RCU ? GL_NOBLOCK : 0, &d_gh);
 		if (error)
 			goto out;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 1b95db2c3aac..6bfc9383b7b8 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1882,10 +1882,10 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
 		WARN_ON_ONCE(!may_not_block);
 		return -ECHILD;
         }
-	if (gfs2_glock_is_locked_by_me(gl) == NULL) {
-		if (may_not_block)
-			return -ECHILD;
-		error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &i_gh);
+	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
+		int noblock = may_not_block ? GL_NOBLOCK : 0;
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
+					   LM_FLAG_ANY | noblock, &i_gh);
 		if (error)
 			return error;
 	}
-- 
2.43.0

