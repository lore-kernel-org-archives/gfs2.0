Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D47EF
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699269; cv=none; b=Lqi/m36YrGfJXon/shC28AEuXsZKtrMMhjUqDLXsql7d6g+mlisDPWgebEBf8oplXpPYNk9P9w9Uv6Yo5YPgOnb+kEYS92zWDp/6aAUJr1YM55e6D1aHrtE9VGjrizp6JSkrsgED6ltBupVfCk+aYj+oYrte6+EDsNFv4HgqALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699269; c=relaxed/simple;
	bh=Qe4gy/CXoRlBJh7tbCgTr1ftW4SDQa3mhFmiVtoquBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyu+pPqqLghGjwFS6Ea3g93UHVqe99jUtQOtvzyAjvnRxPgT07HIjEVijABiDTe2l14nS3Di3zTbpq8139nWe+C0B8FHOluwzZ/+rTDN5JmToB/1DNNYQ7ef5nZTrkONo+Qwqh7t5EL7q0Nmw/NBvEowCe1d0yaeEt73ioSSmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5wTdh+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5wTdh+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57II/m6DQZMjAZXiMAMCrgfWNMvdNeJF63EUp7To+n8=;
	b=f5wTdh+4Vipbn5rVmp5+WFIkvSxVUKP/8UPrBa7Tmie939xlzW9cNWjagWz1nwvpG9bHFx
	t8HjQgkndA5Ei2Z8AyXpl/GZSLY10uLrkP/pOe3IvO2iC0Gzz10U5YTHFDKdv/asOcLIXK
	LErmUjXCodYIXcILf2YGSR+JwDhJKME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-EbyLegA1NIKYSZKXer9jiA-1; Fri, 19 Jan 2024 16:21:04 -0500
X-MC-Unique: EbyLegA1NIKYSZKXer9jiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53669185A780;
	Fri, 19 Jan 2024 21:21:04 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B276A40C95AD;
	Fri, 19 Jan 2024 21:21:03 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 8/9] gfs2: Minor gfs2_drevalidate cleanup
Date: Fri, 19 Jan 2024 22:20:55 +0100
Message-ID: <20240119212056.805617-9-agruenba@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Get rid of the had_lock and valid variables in gfs2_drevalidate().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index f179a6d94cbe..99239d80982b 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -38,8 +38,9 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dinode, *inode;
 	struct gfs2_holder d_gh;
 	struct gfs2_inode *ip = NULL;
-	int error, valid = 0;
-	int had_lock = 0;
+	int error;
+
+	gfs2_holder_mark_uninitialized(&d_gh);
 
 	if (flags & LOOKUP_RCU) {
 		dinode = d_inode_rcu(READ_ONCE(dentry->d_parent));
@@ -54,18 +55,19 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 	inode = d_inode(dentry);
 
 	if (inode) {
-		if (is_bad_inode(inode))
+		if (is_bad_inode(inode)) {
+			error = 0;
 			goto out;
+		}
 		ip = GFS2_I(inode);
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_mount == NULL) {
-		valid = 1;
+		error = 1;
 		goto out;
 	}
 
-	had_lock = (gfs2_glock_is_locked_by_me(dip->i_gl) != NULL);
-	if (!had_lock) {
+	if (!gfs2_glock_is_locked_by_me(dip->i_gl)) {
 		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED,
 					   flags & LOOKUP_RCU ? GL_NOBLOCK : 0, &d_gh);
 		if (error)
@@ -73,13 +75,13 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	error = gfs2_dir_check(dinode, &dentry->d_name, ip, 0);
-	valid = inode ? !error : (error == -ENOENT);
+	error = inode ? !error : (error == -ENOENT);
 
-	if (!had_lock)
+	if (gfs2_holder_initialized(&d_gh))
 		gfs2_glock_dq_uninit(&d_gh);
 out:
 	dput(parent);
-	return valid;
+	return error;
 }
 
 static int gfs2_dhash(const struct dentry *dentry, struct qstr *str)
-- 
2.43.0

