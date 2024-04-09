Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351401534E2
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681128; cv=none; b=DIlDRl4/BXetvsIylaJ17t78vaN4RYu7oi+ATlk2C8IK8uxS/8H5XmH9+4bXOIFbNZm8ZvpdPv7SKQjLFMF+TwQ0pmzAnpokf+fOUFDtmvA2Fe3q3g9kSmdFVHoDLRC8Hbmq80Ce9enZNf8UDsPMsFiIPrrBkSt8GyJMKTo0nUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681128; c=relaxed/simple;
	bh=6SlHA1YYdwsZrNNBgJwHxG09BO0FW06+2G3bqGbQK4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhTxKm3jAuvxpOKZuV+qUCQxS6pWW6/SB2WqbVZ1+AfLPRtRsIQXn4kscLB/O/kdIG9qoJP8+MEvpYCelOj6/5+7dfixJbh+RPv1weCGSkOCnuC0F1eFaj52PZaGc1U+X0ItqvEIgcvqV5uGvEg3yGXvNHqS4sk2IbnprKSnaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPYsXyRn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPYsXyRn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=claWbfJT9ncUPjPIdxZ+GnErIseVHm1yQ286QRREuq8=;
	b=IPYsXyRnUM47Q32qn6xgSroTbyHGcjCmaAL+Hv4jsqUGtG6m2dsGdtmGYri6jPf4Vuw9+i
	E2fYvO7JvH75zFqCEqbXZG6FLQn2cjDJhz2BeQ6nQCQlPPIoCW1/CH3oe9/2OQEoB021BH
	CQXpF3TJU+9sDcEXOIHtze8jRtDlp7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-U3M54aGgPYKCwSSOviWbKA-1; Tue, 09 Apr 2024 12:45:24 -0400
X-MC-Unique: U3M54aGgPYKCwSSOviWbKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 723558026B9
	for <gfs2@lists.linux.dev>; Tue,  9 Apr 2024 16:45:24 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5BE4C0157E;
	Tue,  9 Apr 2024 16:45:23 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/15] gfs2: Get rid of demote_ok checks
Date: Tue,  9 Apr 2024 18:45:04 +0200
Message-ID: <20240409164508.79570-15-agruenba@redhat.com>
In-Reply-To: <20240409164508.79570-1-agruenba@redhat.com>
References: <20240409164508.79570-1-agruenba@redhat.com>
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
 fs/gfs2/glock.c                           | 25 ++---------------------
 fs/gfs2/glops.c                           | 18 ----------------
 fs/gfs2/incore.h                          |  1 -
 4 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2-glocks.rst
index 8a5842929b60..fd3bf0f157fb 100644
--- a/Documentation/filesystems/gfs2-glocks.rst
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -61,8 +61,6 @@ Field              Purpose
 go_xmote_th        Called before remote state change (e.g. to sync dirty data)
 go_xmote_bh        Called after remote state change (e.g. to refill cache)
 go_inval           Called if remote state change requires invalidating the cache
-go_demote_ok       Returns boolean value of whether its ok to demote a glock
-                   (e.g. checks timeout, and that there is no cached data)
 go_lock            Called for the first local holder of a lock
 go_unlock          Called on the final local unlock of a lock
 go_dump            Called to print content of object for debugfs file, or on
@@ -96,7 +94,6 @@ Operation        GLF_LOCK bit lock held    gl_lockref.lock spinlock held
 go_xmote_th           Yes                       No
 go_xmote_bh           Yes                       No
 go_inval              Yes                       No
-go_demote_ok          Sometimes                 Yes
 go_lock               Yes                       No
 go_unlock             Yes                       No
 go_dump               Sometimes                 Yes
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 04e0a8ac61d7..5b2fd5994cfc 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -192,27 +192,6 @@ struct gfs2_glock *gfs2_glock_hold(struct gfs2_glock *gl)
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
 void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
 {
 	if (!(gl->gl_ops->go_flags & GLOF_LRU))
@@ -1674,7 +1653,7 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 			fast_path = 1;
 	}
 
-	if (!test_bit(GLF_LFLUSH, &gl->gl_flags) && demote_ok(gl))
+	if (!test_bit(GLF_LFLUSH, &gl->gl_flags))
 		gfs2_glock_add_to_lru(gl);
 
 	if (unlikely(!fast_path)) {
@@ -2033,7 +2012,7 @@ __acquires(&lru_lock)
 			goto add_back_to_lru;
 		}
 		gl->gl_lockref.count++;
-		if (demote_ok(gl))
+		if (gl->gl_state != LM_ST_UNLOCKED)
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
 		__gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 68677fb69a73..7013bccb67e8 100644
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
index 95a334d64da2..2c4c0ee2c014 100644
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
2.44.0

