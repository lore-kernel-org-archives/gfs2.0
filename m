Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA03146A7A
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301830; cv=none; b=dkRAbx7Og7bX1imOLg68n8mFpnMw/r5wpYEljY3UJS6DtCtJD8dCNoyQodk7GPSVn8pvshs0CZ3bxugHMnxV4jNXjBbyeU7OmVc+FxmqIdfah0MTyIuA4MN5DuUhmsdw9+caLKUA9kuvk6B61O/MtXFeMtdma98Dt7XQcbpUQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301830; c=relaxed/simple;
	bh=BlUrtJ4w1L391QNEuA1u4In+eTx9UzAY9VbVwj6KqkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrD/D77Is8qy+56wZ0LdF51NCkcM4W0Fqza19Hm4n9NqJETiCOpAExNsHzFMW6noNXmU3QCXuwl31Fi5AsusYEbJqcGRSuhMdtRVQ8rU5U62Jhvi9SReNpxVqLUnxGRiTgFZkLAcf1uB3g/jnm3TcuQVZQTq6AmGAhaemN7ERTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9EDN06I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9EDN06I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd+p4TOLfSGTlUO6zaIqdSbscTGZb7P4z4wk/NzIi4s=;
	b=f9EDN06ILOjD73bzxBOJbQ2mhmFcNmeuf7Xj7ewQsegxWQctPHrSQ+F7bysR+yNEicdmC4
	CGNheh8dj0klLGFwGTemsZIBFvkBz90RkamHYEThiYqlUvFxQQK419tpoivJtXl3kGiYyE
	S9zSnNuuc7o/5RFZ6UomSCbPQ4xIcjU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-rV-Wpu07PVW8IZuRDh7y9A-1; Wed,
 25 Sep 2024 18:03:47 -0400
X-MC-Unique: rV-Wpu07PVW8IZuRDh7y9A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DD2C1936115
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A30AF19560AA;
	Wed, 25 Sep 2024 22:03:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 07/16] gfs2: Rename dinode_demise to evict_behavior
Date: Thu, 26 Sep 2024 00:03:17 +0200
Message-ID: <20240925220331.417856-8-agruenba@redhat.com>
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

Rename enum dinode_demise to evict_behavior and its items
SHOULD_DELETE_DINODE to EVICT_SHOULD_DELETE,
SHOULD_NOT_DELETE_DINODE to EVICT_SHOULD_SKIP_DELETE, and
SHOULD_DEFER_EVICTION to EVICT_SHOULD_DEFER_DELETE.

In gfs2_evict_inode(), add a separate variable of type enum
evict_behavior instead of implicitly casting to int.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 65aef2153b19..bfe822827bbd 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -44,10 +44,10 @@
 #include "xattr.h"
 #include "lops.h"
 
-enum dinode_demise {
-	SHOULD_DELETE_DINODE,
-	SHOULD_NOT_DELETE_DINODE,
-	SHOULD_DEFER_EVICTION,
+enum evict_behavior {
+	EVICT_SHOULD_DELETE,
+	EVICT_SHOULD_SKIP_DELETE,
+	EVICT_SHOULD_DEFER_DELETE,
 };
 
 /**
@@ -1313,8 +1313,8 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
  *
  * Returns: the fate of the dinode
  */
-static enum dinode_demise evict_should_delete(struct inode *inode,
-					      struct gfs2_holder *gh)
+static enum evict_behavior evict_should_delete(struct inode *inode,
+					       struct gfs2_holder *gh)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -1325,11 +1325,11 @@ static enum dinode_demise evict_should_delete(struct inode *inode,
 		goto should_delete;
 
 	if (test_bit(GIF_DEFER_DELETE, &ip->i_flags))
-		return SHOULD_DEFER_EVICTION;
+		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Deletes should never happen under memory pressure anymore.  */
 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
-		return SHOULD_DEFER_EVICTION;
+		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Must not read inode block until block type has been verified */
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, gh);
@@ -1337,34 +1337,34 @@ static enum dinode_demise evict_should_delete(struct inode *inode,
 		glock_clear_object(ip->i_iopen_gh.gh_gl, ip);
 		ip->i_iopen_gh.gh_flags |= GL_NOCACHE;
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
-		return SHOULD_DEFER_EVICTION;
+		return EVICT_SHOULD_DEFER_DELETE;
 	}
 
 	if (gfs2_inode_already_deleted(ip->i_gl, ip->i_no_formal_ino))
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 	ret = gfs2_check_blk_type(sdp, ip->i_no_addr, GFS2_BLKST_UNLINKED);
 	if (ret)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 	ret = gfs2_instantiate(gh);
 	if (ret)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 	/*
 	 * The inode may have been recreated in the meantime.
 	 */
 	if (inode->i_nlink)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 should_delete:
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags)) {
 		if (!gfs2_upgrade_iopen_glock(inode)) {
 			gfs2_holder_uninit(&ip->i_iopen_gh);
-			return SHOULD_NOT_DELETE_DINODE;
+			return EVICT_SHOULD_SKIP_DELETE;
 		}
 	}
-	return SHOULD_DELETE_DINODE;
+	return EVICT_SHOULD_DELETE;
 }
 
 /**
@@ -1475,6 +1475,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
+	enum evict_behavior behavior;
 	int ret;
 
 	if (inode->i_nlink || sb_rdonly(sb) || !ip->i_no_addr)
@@ -1489,10 +1490,10 @@ static void gfs2_evict_inode(struct inode *inode)
 		goto out;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	ret = evict_should_delete(inode, &gh);
-	if (ret == SHOULD_DEFER_EVICTION)
+	behavior = evict_should_delete(inode, &gh);
+	if (behavior == EVICT_SHOULD_DEFER_DELETE)
 		goto out;
-	if (ret == SHOULD_DELETE_DINODE)
+	if (behavior == EVICT_SHOULD_DELETE)
 		ret = evict_unlinked_inode(inode);
 	else
 		ret = evict_linked_inode(inode);
-- 
2.46.0

