Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F615B55D
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002248; cv=none; b=spCaCnyjBsa46I19R7m1xQscBV4HLJHxULuIIDq9qp2+xsNIc3n1jwoEoSuyc2Spe5Mo90CPzTrc3BYz/+WwDnBTChfYf3iQkYj3O1jVxVPDCinFXaiTklSQuvQJX9HLW67uyv0XejvNpjw6sFRJLK88v0YhwuScvLJJMLD1ENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002248; c=relaxed/simple;
	bh=uqov/ax9EzXHl+cr9HvyssBZ/xbpDYqn72Wc09eCpX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfADm26WmpFFNa9OA1CkgsEiPDGvhkjDelNwxxCv6qsNGcKawS2uLjJoo35dY3hS/pKX1owLv5FBiwcFXwK7tHKo+gRJnrcf8i1ahkw0Iv5+kUznddyZ+LM6IZ73G6786fzUWkNxrXqnVDs4f1X5rYo3EnKFlO1Wy9Sdbu21mGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiJq+FfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiJq+FfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xq6+NzjeIH+qEIMD6k2EIvcMcTMx9fZkkEnWG/aDsTY=;
	b=NiJq+FfNZEvFB3PRany+Ej3pkuzkxqV8ECep87p/P+6Tgwvj2kzg7lpPsBw0jKfP1wqx44
	yXN5RXFPJJy1/M8+3rUJgqeFhqjdOUO1Qgx5rDI0ciLJkCosTzadK792UN3YqCmdnhxKFU
	o9XKC4pjy3uSJofYQW2T05f+pC01sNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-IUykYAh7OGSPCdPAeK_u_w-1; Wed,
 29 May 2024 13:04:04 -0400
X-MC-Unique: IUykYAh7OGSPCdPAeK_u_w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFBD43806701
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:03 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64A9A492BC6;
	Wed, 29 May 2024 17:04:03 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/15] gfs2: Revise glock reference counting model
Date: Wed, 29 May 2024 19:03:50 +0200
Message-ID: <20240529170352.571141-14-agruenba@redhat.com>
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

In the current glock reference counting model, a bias of one is added to
a glock's refcount when it is locked (gl->gl_state != LM_ST_UNLOCKED).
A glock is removed from the lru_list when it is enqueued, and added back
when it is dequeued.  This isn't a very appropriate model because most
glocks are held for long periods of time (for example, the inode "owns"
references to its inode and iopen glocks as long as the inode is cached
even when the glock state changes to LM_ST_UNLOCKED), and they can only
be freed when they are no longer referenced, anyway.

Fix this by getting rid of the refcount bias for locked glocks.  That
way, we can use lockref_put_or_lock() to efficiently drop all but the
last glock reference, and put the glock onto the lru_list when the last
reference is dropped.  When find_insert_glock() returns a reference to a
cached glock, it removes the glock from the lru_list.

Dumping the "glocks" and "glstats" debugfs files also takes glock
references, but instead of removing the glocks from the lru_list in that
case as well, we leave them on the list.  This ensures that dumping
those files won't perturb the order of the glocks on the lru_list.

In addition, when the last reference to an *unlocked* glock is dropped,
we immediately free it; this preserves the preexisting behavior.  If it
later turns out that caching unlocked glocks is useful in some
situations, we can change the caching strategy.

It is currently unclear if a glock that has no active references can
have the GLF_LFLUSH flag set.  To make sure that such a glock won't
accidentally be evicted due to memory pressure, we add a GLF_LFLUSH
check to gfs2_dispose_glock_lru().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 56 ++++++++++++++++++++++++++-----------------------
 fs/gfs2/glock.h |  1 -
 fs/gfs2/super.c |  1 -
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 32991cb22023..e2a72c21194a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -237,7 +237,7 @@ static int demote_ok(const struct gfs2_glock *gl)
 }
 
 
-void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
+static void gfs2_glock_add_to_lru(struct gfs2_glock *gl)
 {
 	if (!(gl->gl_ops->go_flags & GLOF_LRU))
 		return;
@@ -305,6 +305,20 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	sdp->sd_lockstruct.ls_ops->lm_put_lock(gl);
 }
 
+static bool __gfs2_glock_put_or_lock(struct gfs2_glock *gl)
+{
+	if (lockref_put_or_lock(&gl->gl_lockref))
+		return true;
+	GLOCK_BUG_ON(gl, gl->gl_lockref.count != 1);
+	if (gl->gl_state != LM_ST_UNLOCKED) {
+		gl->gl_lockref.count--;
+		gfs2_glock_add_to_lru(gl);
+		spin_unlock(&gl->gl_lockref.lock);
+		return true;
+	}
+	return false;
+}
+
 /**
  * gfs2_glock_put() - Decrement reference count on glock
  * @gl: The glock to put
@@ -313,7 +327,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 
 void gfs2_glock_put(struct gfs2_glock *gl)
 {
-	if (lockref_put_or_lock(&gl->gl_lockref))
+	if (__gfs2_glock_put_or_lock(gl))
 		return;
 
 	__gfs2_glock_put(gl);
@@ -328,10 +342,9 @@ void gfs2_glock_put(struct gfs2_glock *gl)
  */
 void gfs2_glock_put_async(struct gfs2_glock *gl)
 {
-	if (lockref_put_or_lock(&gl->gl_lockref))
+	if (__gfs2_glock_put_or_lock(gl))
 		return;
 
-	GLOCK_BUG_ON(gl, gl->gl_lockref.count != 1);
 	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
@@ -570,18 +583,6 @@ static inline struct gfs2_holder *find_last_waiter(const struct gfs2_glock *gl)
 
 static void state_change(struct gfs2_glock *gl, unsigned int new_state)
 {
-	int held1, held2;
-
-	held1 = (gl->gl_state != LM_ST_UNLOCKED);
-	held2 = (new_state != LM_ST_UNLOCKED);
-
-	if (held1 != held2) {
-		GLOCK_BUG_ON(gl, __lockref_is_dead(&gl->gl_lockref));
-		if (held2)
-			gl->gl_lockref.count++;
-		else
-			gl->gl_lockref.count--;
-	}
 	if (new_state != gl->gl_target)
 		/* shorten our minimum hold time */
 		gl->gl_hold_time = max(gl->gl_hold_time - GL_GLOCK_HOLD_DECR,
@@ -1139,10 +1140,14 @@ static void glock_work_func(struct work_struct *work)
 	}
 
 	/* Drop the remaining glock references manually. */
+	GLOCK_BUG_ON(gl, gl->gl_lockref.count < drop_refs);
 	gl->gl_lockref.count -= drop_refs;
 	if (!gl->gl_lockref.count) {
-		__gfs2_glock_put(gl);
-		return;
+		if (gl->gl_state == LM_ST_UNLOCKED) {
+			__gfs2_glock_put(gl);
+			return;
+		}
+		gfs2_glock_add_to_lru(gl);
 	}
 	spin_unlock(&gl->gl_lockref.lock);
 }
@@ -1178,6 +1183,8 @@ static struct gfs2_glock *find_insert_glock(struct lm_lockname *name,
 out:
 	rcu_read_unlock();
 	finish_wait(wq, &wait.wait);
+	if (gl)
+		gfs2_glock_remove_from_lru(gl);
 	return gl;
 }
 
@@ -1626,9 +1633,6 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 		return error;
 	}
 
-	if (test_bit(GLF_LRU, &gl->gl_flags))
-		gfs2_glock_remove_from_lru(gl);
-
 	gh->gh_error = 0;
 	spin_lock(&gl->gl_lockref.lock);
 	add_to_queue(gh);
@@ -1693,9 +1697,6 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 			fast_path = 1;
 	}
 
-	if (!test_bit(GLF_LFLUSH, &gl->gl_flags) && demote_ok(gl))
-		gfs2_glock_add_to_lru(gl);
-
 	if (unlikely(!fast_path)) {
 		gl->gl_lockref.count++;
 		if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
@@ -2008,10 +2009,12 @@ static int glock_cmp(void *priv, const struct list_head *a,
 
 static bool can_free_glock(struct gfs2_glock *gl)
 {
-	bool held = gl->gl_state != LM_ST_UNLOCKED;
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
 	return !test_bit(GLF_LOCK, &gl->gl_flags) &&
-	       gl->gl_lockref.count == held;
+	       !gl->gl_lockref.count &&
+	       (!test_bit(GLF_LFLUSH, &gl->gl_flags) ||
+		test_bit(SDF_KILL, &sdp->sd_flags));
 }
 
 /**
@@ -2177,6 +2180,7 @@ static void thaw_glock(struct gfs2_glock *gl)
 	if (!lockref_get_not_dead(&gl->gl_lockref))
 		return;
 
+	gfs2_glock_remove_from_lru(gl);
 	spin_lock(&gl->gl_lockref.lock);
 	set_bit(GLF_HAVE_REPLY, &gl->gl_flags);
 	gfs2_glock_queue_work(gl, 0);
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 19aef6d53267..adf0091cc98f 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -250,7 +250,6 @@ void gfs2_flush_delete_work(struct gfs2_sbd *sdp);
 void gfs2_gl_hash_clear(struct gfs2_sbd *sdp);
 void gfs2_gl_dq_holders(struct gfs2_sbd *sdp);
 void gfs2_glock_thaw(struct gfs2_sbd *sdp);
-void gfs2_glock_add_to_lru(struct gfs2_glock *gl);
 void gfs2_glock_free(struct gfs2_glock *gl);
 void gfs2_glock_free_later(struct gfs2_glock *gl);
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 7a5aedfcd52a..6678060ed4d2 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1524,7 +1524,6 @@ static void gfs2_evict_inode(struct inode *inode)
 	if (ip->i_gl) {
 		glock_clear_object(ip->i_gl, ip);
 		wait_on_bit_io(&ip->i_flags, GIF_GLOP_PENDING, TASK_UNINTERRUPTIBLE);
-		gfs2_glock_add_to_lru(ip->i_gl);
 		gfs2_glock_put_eventually(ip->i_gl);
 		rcu_assign_pointer(ip->i_gl, NULL);
 	}
-- 
2.45.1

