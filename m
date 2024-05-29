Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6715B559
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002249; cv=none; b=ER0cAqX5COPdpA4hnPi9QEocsdDbRfEjfou2iXzipbXwUOiyjYA9A/aUuFViyokD9+nBNaX1Y/TNnocn+Kczu34fC7wIJ0u8FsQ9HC85Hez7AlFjo50a2dIF0yu7FkqW3Bi48Po0AC1+ajBYSXqgQMYM10utBGTFLJ7kVSggTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002249; c=relaxed/simple;
	bh=i+g4PmrKYUn3X+8yO2j90A8PNX94ZghmnPxZTmQl6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL8mU+uN6ENEwJk35/deUxSL1trOsTsUVXmpBRC/2GSs9YPTjDTDBfkewydslYLiY6LhCydcm+LpYr2ITIxIu7tMH0Js6XZjCwy2DdXPKMvL46ZpZan758A6iGWK3aF1DP01TD2Iz6fwxJMxEG+UURYIULTlvrKGH/+XiGR8HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaZtLEQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaZtLEQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mD1igppmZr9lYb1BsjFvbWk7AMkgK5FqIH5vfVXqvx8=;
	b=MaZtLEQcS/kVxtHKEVhh20FrBbT2tZRNygsPylQ21CTvBttr8RMFidjtttaaFV4IBOj5nh
	4otLqMLvAnfUF5RNO+o8LDHZrTyYOrR8+XIlifApeA193tBrOLG6tviXbVek+h5tfNgMw5
	K6Wbd+kNvdYeh77opOPqlhvz1fzouO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-69v7D9M_M0mcJ0gey8njVQ-1; Wed, 29 May 2024 13:04:05 -0400
X-MC-Unique: 69v7D9M_M0mcJ0gey8njVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6417581227E
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCBBB492BC6;
	Wed, 29 May 2024 17:04:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/15] gfs2: Get rid of demote_ok checks
Date: Wed, 29 May 2024 19:03:52 +0200
Message-ID: <20240529170352.571141-16-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The demote_ok glock operation is only still used to prevent the inode
glocks of the "jindex" and "rindex" directories from getting recycled
while they are still referenced by sdp->sd_jindex and sdp->sd_rindex.
However, the LRU walking code will no longer recycle glocks which are
referenced, so the demote_ok glock operation is obsolete and can be
removed.

Each of a glock's holders in the gl_holders list is holding a reference
on the glock, so when the list of holders isn't empty in demote_ok(),
the existing reference count check will already prevent the glock from
getting released.  This means that demote_ok() is obsolete as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 Documentation/filesystems/gfs2-glocks.rst |  3 ---
 fs/gfs2/glock.c                           | 23 +----------------------
 fs/gfs2/glops.c                           | 18 ------------------
 fs/gfs2/incore.h                          |  1 -
 4 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index 17ce3413608a..adc0d4c4d979 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -61,8 +61,6 @@ Field              Purpose
 go_sync            Called before remote state change (e.g. to sync dirty data)
 go_xmote_bh        Called after remote state change (e.g. to refill cache)
 go_inval           Called if remote state change requires invalidating the cache
-go_demote_ok       Returns boolean value of whether its ok to demote a glock
-                   (e.g. checks timeout, and that there is no cached data)
 go_instantiate     Called when a glock has been acquired
 go_held            Called every time a glock holder is acquired
 go_dump            Called to print content of object for debugfs file, or on
@@ -95,7 +93,6 @@ Operation        GLF_LOCK bit lock held    gl_lockref.lock spinlock held
 go_sync               Yes                       No
 go_xmote_bh           Yes                       No
 go_inval              Yes                       No
-go_demote_ok          Sometimes                 Yes
 go_instantiate        No                        No
 go_held               No                        No
 go_dump               Sometimes                 Yes
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 19f8df91b72e..7f68e3d217e6 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -216,27 +216,6 @@ struct gfs2_glock *gfs2_glock_hold(struct gfs2_glock *gl)
 	return gl;
 }
 
-/**
- * demote_ok - Check to see if it's ok to unlock a glock
- * @gl: the glock
- *
- * Returns: 1 if it's ok
- */
-
-static int demote_ok(const struct gfs2_glock *gl)
-{
-	const struct gfs2_glock_operations *glops = gl->gl_ops;
-
-	if (gl->gl_state == LM_ST_UNLOCKED)
-		return 0;
-	if (!list_empty(&gl->gl_holders))
-		return 0;
-	if (glops->go_demote_ok)
-		return glops->go_demote_ok(gl);
-	return 1;
-}
-
-
 static void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
 {
 	spin_lock(&lru_lock);
@@ -2049,7 +2028,7 @@ __acquires(&lru_lock)
 		clear_bit(GLF_LRU, &gl->gl_flags);
 		freed++;
 		gl->gl_lockref.count++;
-		if (demote_ok(gl))
+		if (gl->gl_state != LM_ST_UNLOCKED)
 			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 7bc7f6785abd..95d8081681dc 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -385,23 +385,6 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 	gfs2_clear_glop_pending(ip);
 }
 
-/**
- * inode_go_demote_ok - Check to see if it's ok to unlock an inode glock
- * @gl: the glock
- *
- * Returns: 1 if it's ok
- */
-
-static int inode_go_demote_ok(const struct gfs2_glock *gl)
-{
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
-	if (sdp->sd_jindex == gl->gl_object || sdp->sd_rindex == gl->gl_object)
-		return 0;
-
-	return 1;
-}
-
 static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
@@ -722,7 +705,6 @@ const struct gfs2_glock_operations gfs2_meta_glops = {
 const struct gfs2_glock_operations gfs2_inode_glops = {
 	.go_sync = inode_go_sync,
 	.go_inval = inode_go_inval,
-	.go_demote_ok = inode_go_demote_ok,
 	.go_instantiate = inode_go_instantiate,
 	.go_held = inode_go_held,
 	.go_dump = inode_go_dump,
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index f75982d45635..90fd2584357a 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -218,7 +218,6 @@ struct gfs2_glock_operations {
 	int (*go_sync) (struct gfs2_glock *gl);
 	int (*go_xmote_bh)(struct gfs2_glock *gl);
 	void (*go_inval) (struct gfs2_glock *gl, int flags);
-	int (*go_demote_ok) (const struct gfs2_glock *gl);
 	int (*go_instantiate) (struct gfs2_glock *gl);
 	int (*go_held)(struct gfs2_holder *gh);
 	void (*go_dump)(struct seq_file *seq, const struct gfs2_glock *gl,
-- 
2.45.1

