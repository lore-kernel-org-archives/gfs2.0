Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97647143B
	for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235706; cv=none; b=fvZJAN1+oY6hzjoIYtFsfgto8XWS/L5f2KjvHLA6uGPoFuGr9aNQSpjx08UFgW9POIJ+mpBXxcs4Ur1IsHqhJX3N4Fb931JTMRVjKVMfs3ErCROktjWfIVAJblPYo0xKjuwAlulpeDaAzg3F8UzRuebWmFFPDpN/pqG0uyHjHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235706; c=relaxed/simple;
	bh=zOD2rtv9eSfPTth+eVrBz6wKtoSzk6iWXae48NqVeTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gC2FQ7lVe/HTriaQNHoKb9QCyJdLDIdWrgxmB77Rzc8pEMTRT+wuw9fWWEyq082WTetjwcDBqy1CPkblLs9kZ0y0uA+++LfFEO9LTt3z3OO7ZfLcKrvJf9xN8OJ5rmy61/do8MDWEK3nKSYUGqtJUDK49QnZKVi88ju+k8B7stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kdo0ui67; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdo0ui67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787235703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGfi6bNSDeoVb2Q23+h76WHl4/52bjsWT7V57R85NKk=;
	b=Kdo0ui67/xgZSldiiBrvRHBv8As72AS6zasrXDUnF0lg3g7BMvIUGNnAu8FTyrmQXlrqcd
	hJViO5VioEUs+iroSic+VCnqAT9+IzN6hGj9MvftEYqjnolHDrRbu3q9m7nLTsLUcKaD+k
	ITispRsvcB8Vx6u5UOt0LdIh0+QoPGY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-21dmnPcwMZm1wnXOmbRwcA-1; Thu,
 20 Aug 2026 10:21:41 -0400
X-MC-Unique: 21dmnPcwMZm1wnXOmbRwcA-1
X-Mimecast-MFC-AGG-ID: 21dmnPcwMZm1wnXOmbRwcA_1787235701
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F117195609D;
	Thu, 20 Aug 2026 14:21:41 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D97C23001DAF;
	Thu, 20 Aug 2026 14:21:39 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Adrian Garcia Casado <adriangarciacasado42@gmail.com>
Subject: [PATCH 5/6] gfs2: annotate i_gl with __rcu
Date: Thu, 20 Aug 2026 16:21:26 +0200
Message-ID: <20260820142129.1327413-6-agruenba@redhat.com>
In-Reply-To: <20260820142129.1327413-1-agruenba@redhat.com>
References: <20260820142129.1327413-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2A3k-jSUoZJz6XpZS9SPZPq1QZEcmNXfiXmepAvBdBQ_1787235701
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

ip->i_gl is always set over the lifetime of a gfs2 inode; it is initialized at
inode create time and torn down during evict.

However, gfs2_permission() can be called on an inode in non-blocking mode, when
the inode may already be undergoing evict.  So far, to make that work, we have
been using rcu_dereference_check() in gfs2_permission() and
rcu_assign_pointer() in gfs2_evict_inode().

However, ip->i_gl wasn't marked as __rcu so far.  rcu_dereference_check() and
rcu_assign_pointer() expect __rcu pointer arguments, and sparse complains when
regular pointers are passed to those functions:

fs/gfs2/super.c:1516:17: error: incompatible types in comparison expression (different address spaces):
fs/gfs2/super.c:1516:17:    struct gfs2_glock [noderef] __rcu *
fs/gfs2/super.c:1516:17:    struct gfs2_glock *
fs/gfs2/inode.c:1988:14: error: incompatible types in comparison expression (different address spaces):
fs/gfs2/inode.c:1988:14:    struct gfs2_glock [noderef] __rcu *
fs/gfs2/inode.c:1988:14:    struct gfs2_glock *

To fix those errors, turn ip->i_gl into a __rcu variable.  Use
rcu_assign_pointer() to assign to it, and rcu_dereference_protected() to access
it when the pointer is known to be valid.

Make sure not to use gfs2_inode_glock() in gfs2_permission().

Based on a patch from Adrian Garcia Casado <adriangarciacasado42@gmail.com>.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h | 4 ++--
 fs/gfs2/inode.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 3ae8e2be486c..0a48f8e8ed6c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -391,7 +391,7 @@ struct gfs2_inode {
 	u64 i_generation;
 	u64 i_eattr;
 	unsigned long i_flags;		/* GIF_... */
-	struct gfs2_glock *i_gl;
+	struct gfs2_glock __rcu *i_gl;
 	struct gfs2_holder i_iopen_gh;
 	struct gfs2_qadata *i_qadata; /* quota allocation data */
 	struct gfs2_holder i_rgd_gh;
@@ -881,6 +881,6 @@ static inline unsigned gfs2_max_stuffed_size(const struct gfs2_inode *ip)
 
 static inline struct gfs2_glock *gfs2_inode_glock(struct inode *inode)
 {
-       return GFS2_I(inode)->i_gl;
+       return rcu_dereference_protected(GFS2_I(inode)->i_gl, 1);
 }
 #endif /* __INCORE_DOT_H__ */
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 5aaed0018fb3..d4e1e443391e 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -151,7 +151,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 				       &gl);
 		if (unlikely(error))
 			goto fail;
-		ip->i_gl = gl;
+		rcu_assign_pointer(ip->i_gl, gl);
 
 		error = gfs2_glock_get(sdp, no_addr, &gfs2_iopen_glops, CREATE,
 				       &io_gl);
@@ -244,7 +244,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 		gfs2_glock_dq_uninit(&i_gh);
 	if (gl) {
 		gfs2_glock_put(gl);
-		ip->i_gl = NULL;
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 	iget_failed(inode);
 	return ERR_PTR(error);
@@ -840,7 +840,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &gl);
 	if (error)
 		goto fail_dealloc_inode;
-	ip->i_gl = gl;
+	rcu_assign_pointer(ip->i_gl, gl);
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
@@ -940,7 +940,7 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 fail_free_inode:
 	if (gl) {
 		gfs2_glock_put(gl);
-		ip->i_gl = NULL;
+		rcu_assign_pointer(ip->i_gl, NULL);
 	}
 	gfs2_rs_deltree(&ip->i_res);
 	gfs2_qa_put(ip);
-- 
2.55.0

