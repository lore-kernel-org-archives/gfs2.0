Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC61D5AD5
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301827; cv=none; b=B/Ku7naTN09+HdkIcZ+dOKcX4NoGlQiJYOWnabDmRoIznyEkwrfXsyIzovX1LbhCNNDi/I50vlKa/c859Pxs2z+PlLXwSN+RE+KO5XDm1/R1GSBW8OCqfZajnj8sMk4ci7oPkF2kVDf8zu0vXWSjz/ZjqEdN3z/3xWbhH5LUdug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301827; c=relaxed/simple;
	bh=dwBUUWFpHOw5mzn8pm5ErMw1dMXIoP6U8kmvcVX3Yoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLjTw8vnC+SKT7XO7ulSoRDSuLbscLwVuIu4pu/jfe7NcKl48bZ6tf3kN28rlVPzV4mcE57QjCN+5TNWhORxgxpU3UZG/qv+awOuusCv9nrqwTc0tHIHqDvhsJd4nCu2yILKJ0mHHN3807cXAvXIh7fOlWnzFcl8vKbmJzC/iOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNhRJavG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNhRJavG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QmaPdPvgRL6BAuK9+X6CJV0QfftP4xuYhrE+yoyg4g=;
	b=YNhRJavGPO7qBOnM6VmWYZHtbchrNGi5XtRApwYDDxFmCMjPDBBQ7GQ0OmQvRc+v0BYqq/
	nB70ToFjt0s5A8DfJYdHR8QyAM/1v1f/j+o2zmPBgZ6VabQYZ3RBiKME32vz31d3+vA8Cm
	72Atjn3wEr36aQd/8c7qJjAcU0/3FOE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-MVe6uNVpNPm1xTZkUDJ3fw-1; Wed,
 25 Sep 2024 18:03:44 -0400
X-MC-Unique: MVe6uNVpNPm1xTZkUDJ3fw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47FAA19E577C
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D3B619560AA;
	Wed, 25 Sep 2024 22:03:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/16] gfs2: Faster gfs2_upgrade_iopen_glock wakeups
Date: Thu, 26 Sep 2024 00:03:15 +0200
Message-ID: <20240925220331.417856-6-agruenba@redhat.com>
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

Move function needs_demote() to glock.h and rename it to
glock_needs_demote().  In handle_callback(), wake up the glock when
setting the GLF_PENDING_DEMOTE flag as well.  (Setting the GLF_DEMOTE
flag already triggered a wake-up.)

With that, check for glock_needs_demote() in gfs2_upgrade_iopen_glock()
to wake up when either of those flags is set for the inode glock: the
faster we can react to contention, the better.

The GLF_PENDING_DEMOTE flag is only used for inode glocks (see
gfs2_glock_cb()) so it's okay to only check for the GLF_DEMOTE flag in
gfs2_drop_inode().  Still, using glock_needs_demote() there as well
makes the code a little easier to read.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 23 +++++++----------------
 fs/gfs2/glock.h |  6 ++++++
 fs/gfs2/super.c |  4 ++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9273ec5345ed..4567c8c60a03 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -563,11 +563,11 @@ static void state_change(struct gfs2_glock *gl, unsigned int new_state)
 	gl->gl_tchange = jiffies;
 }
 
-static void gfs2_set_demote(struct gfs2_glock *gl)
+static void gfs2_set_demote(int nr, struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	set_bit(GLF_DEMOTE, &gl->gl_flags);
+	set_bit(nr, &gl->gl_flags);
 	smp_mb();
 	wake_up(&sdp->sd_async_glock_wait);
 }
@@ -1101,7 +1101,7 @@ static void glock_work_func(struct work_struct *work)
 
 		if (!delay) {
 			clear_bit(GLF_PENDING_DEMOTE, &gl->gl_flags);
-			gfs2_set_demote(gl);
+			gfs2_set_demote(GLF_DEMOTE, gl);
 		}
 	}
 	run_queue(gl, 0);
@@ -1443,10 +1443,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
 static void request_demote(struct gfs2_glock *gl, unsigned int state,
 			   unsigned long delay, bool remote)
 {
-	if (delay)
-		set_bit(GLF_PENDING_DEMOTE, &gl->gl_flags);
-	else
-		gfs2_set_demote(gl);
+	gfs2_set_demote(delay ? GLF_PENDING_DEMOTE : GLF_DEMOTE, gl);
 	if (gl->gl_demote_state == LM_ST_EXCLUSIVE) {
 		gl->gl_demote_state = state;
 		gl->gl_demote_time = jiffies;
@@ -1636,12 +1633,6 @@ int gfs2_glock_poll(struct gfs2_holder *gh)
 	return test_bit(HIF_WAIT, &gh->gh_iflags) ? 0 : 1;
 }
 
-static inline bool needs_demote(struct gfs2_glock *gl)
-{
-	return (test_bit(GLF_DEMOTE, &gl->gl_flags) ||
-		test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
-}
-
 static void __gfs2_glock_dq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
@@ -1650,8 +1641,8 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 
 	/*
 	 * This holder should not be cached, so mark it for demote.
-	 * Note: this should be done before the check for needs_demote
-	 * below.
+	 * Note: this should be done before the glock_needs_demote
+	 * check below.
 	 */
 	if (gh->gh_flags & GL_NOCACHE)
 		request_demote(gl, LM_ST_UNLOCKED, 0, false);
@@ -1664,7 +1655,7 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 	 * If there hasn't been a demote request we are done.
 	 * (Let the remaining holders, if any, keep holding it.)
 	 */
-	if (!needs_demote(gl)) {
+	if (!glock_needs_demote(gl)) {
 		if (list_empty(&gl->gl_holders))
 			fast_path = 1;
 	}
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 63e101d448e9..c171f745650f 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -285,4 +285,10 @@ static inline bool gfs2_holder_queued(struct gfs2_holder *gh)
 void gfs2_inode_remember_delete(struct gfs2_glock *gl, u64 generation);
 bool gfs2_inode_already_deleted(struct gfs2_glock *gl, u64 generation);
 
+static inline bool glock_needs_demote(struct gfs2_glock *gl)
+{
+	return (test_bit(GLF_DEMOTE, &gl->gl_flags) ||
+		test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
+}
+
 #endif /* __GLOCK_DOT_H__ */
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e22c1edc32b3..7f59c7f891fd 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1030,7 +1030,7 @@ static int gfs2_drop_inode(struct inode *inode)
 	if (inode->i_nlink &&
 	    gfs2_holder_initialized(&ip->i_iopen_gh)) {
 		struct gfs2_glock *gl = ip->i_iopen_gh.gh_gl;
-		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
+		if (glock_needs_demote(gl))
 			clear_nlink(inode);
 	}
 
@@ -1294,7 +1294,7 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 
 	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
 		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
-		test_bit(GLF_DEMOTE, &ip->i_gl->gl_flags),
+		glock_needs_demote(ip->i_gl),
 		5 * HZ);
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
-- 
2.46.0

