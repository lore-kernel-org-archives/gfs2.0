Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2A215067
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315657; cv=none; b=iHWn+KdaDRjGKcUReDvVWszCALiXDU0OzfSXT0D2sjXFJTvjlSwE/dzuuqsl5tqbE1Ewu796BhhvLbUJO8eGleMSfUqAwSnHW+nSHOkRaUjlqL86K3qwGfB3Uwv8LoMHF/zUhn2vbBtMLkMtRDIZqIGi05V7pJ9TTpDzKo+Y3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315657; c=relaxed/simple;
	bh=8FtWmGV6DmLmf77G2mWLcRK+RNYhNfT/O/HfmI68RVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VFsbfu4FnooLH5OE/Uz4rmWBuiIfAfFXwYFl5LQSTPcGQ/oMxTyJveUPVAJ0hDTaalSpw7et12mlnNXFfZzvuxek1TjmIchujcB4Jx35KpzeOHmNEwGNvPNWMn5vR1IV8kRBiEg7CkQkw96FcOPd9nxIC5NybYs12fnS5Kt8hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heK/B7MI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heK/B7MI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745315654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgnHdx7/OzTeCfwoZXQbm4Em81cYluvzP7i3AplB8pA=;
	b=heK/B7MIx92+I+2HC9zDkdQcTJBfEm1n0opJG7z6BcGIE4kJq0i2i9hcZcpEWQlqppuWc+
	g5x22XedPjHcUJEcObgswdFk8mnPggXcikBbF3gaycXm/LX10KdGc1eVG/roJNl94n0qIZ
	T0PsVODNJ3Kvi2p7cIQjS8zfqS9Nb6Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-G7GH3tSNPo-lRUoz_LOqWQ-1; Tue,
 22 Apr 2025 05:54:12 -0400
X-MC-Unique: G7GH3tSNPo-lRUoz_LOqWQ-1
X-Mimecast-MFC-AGG-ID: G7GH3tSNPo-lRUoz_LOqWQ_1745315651
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B897180036E
	for <gfs2@lists.linux.dev>; Tue, 22 Apr 2025 09:54:11 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6175730001A2;
	Tue, 22 Apr 2025 09:54:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] gfs2: Move GIF_ALLOC_FAILED check out of gfs2_ea_dealloc
Date: Tue, 22 Apr 2025 11:54:06 +0200
Message-ID: <20250422095407.1221362-2-agruenba@redhat.com>
In-Reply-To: <20250422095407.1221362-1-agruenba@redhat.com>
References: <20250422095407.1221362-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wuBw5kdW8HhyIT2tfBMwLYaFV1qwabPo8dG_UmX8YsI_1745315651
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Don't check for the GIF_ALLOC_FAILED flag in gfs2_ea_dealloc() and pass
that information explicitly instead.  This allows for a cleaner
follow-up patch.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c |  2 +-
 fs/gfs2/xattr.c | 11 ++++++-----
 fs/gfs2/xattr.h |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 3f49f848c6b4..e25a24ae2197 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1314,7 +1314,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	}
 
 	if (ip->i_eattr) {
-		ret = gfs2_ea_dealloc(ip);
+		ret = gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
 		if (ret)
 			goto out;
 	}
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 17ae5070a90e..df9c93de94c7 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1383,7 +1383,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 	return error;
 }
 
-static int ea_dealloc_block(struct gfs2_inode *ip)
+static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrpd *rgd;
@@ -1416,7 +1416,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 	ip->i_eattr = 0;
 	gfs2_add_inode_blocks(&ip->i_inode, -1);
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = gfs2_meta_inode_buffer(ip, &dibh);
 		if (!error) {
 			gfs2_trans_add_meta(ip->i_gl, dibh);
@@ -1435,11 +1435,12 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 /**
  * gfs2_ea_dealloc - deallocate the extended attribute fork
  * @ip: the inode
+ * @initialized: xattrs have been initialized
  *
  * Returns: errno
  */
 
-int gfs2_ea_dealloc(struct gfs2_inode *ip)
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized)
 {
 	int error;
 
@@ -1451,7 +1452,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 	if (error)
 		return error;
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = ea_foreach(ip, ea_dealloc_unstuffed, NULL);
 		if (error)
 			goto out_quota;
@@ -1463,7 +1464,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 		}
 	}
 
-	error = ea_dealloc_block(ip);
+	error = ea_dealloc_block(ip, initialized);
 
 out_quota:
 	gfs2_quota_unhold(ip);
diff --git a/fs/gfs2/xattr.h b/fs/gfs2/xattr.h
index eb12eb7e37c1..3c9788e0e137 100644
--- a/fs/gfs2/xattr.h
+++ b/fs/gfs2/xattr.h
@@ -54,7 +54,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 		     const void *value, size_t size,
 		     int flags, int type);
 ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size);
-int gfs2_ea_dealloc(struct gfs2_inode *ip);
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized);
 
 /* Exported to acl.c */
 
-- 
2.49.0

