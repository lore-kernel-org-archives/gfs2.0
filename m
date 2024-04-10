Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D661836D6
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784505; cv=none; b=sbhTUTLIyTln9Tmw538j7r2CUrw08EfQIhQqpzPjKZ03d/4Ceq5n7F8dg8a7pULVJsLDHoyXxNv/Gebd9doqAkuZh1EqU4GpKfge45sV+XYyqVn74+506U3I9UZLSXieJ9zSmmEZZYc/4v7plTizVgEyQAPzAJeu0ZMJDPZET3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784505; c=relaxed/simple;
	bh=2xkpgVY1/P5QMOYJSbgfHUlaL5zlsVsTByrHoaaxgwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpGAcSjQ9tBcdi+21Z1ITPgpcuOBcrqulWNOiCc4dNhPoAEdTYomNqCpFdgbSHTxDEoWne9sbyaaz9qv208VCZeYX5Gp6Y7TKc+7bHx75JfRXozfEHWryZiOQpwmaVA53ZMAPVyItTsKnUGEykYpJH8Qc8DsT9VXtjylaStCsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTZZqjtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTZZqjtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712784502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KCRkndoqgCZ1T2DnBntMz/yU4Y/dWvFMlYElaDukCU=;
	b=dTZZqjtnPDZG43dt5aOXzS+17m7kfKV6IXK5F24FLo1hzgWyQE8LBTR7yK3ReBQJbZWIEy
	vZshDUUUm237+gHNJxQg+iWKuwj5zd98rso9q+O/mccV2KJWESZWU9WsES/N+WargVZBdT
	lB0IlAz6bS9eAOi9pcKNqcluaUiOQWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-WPh5K-9kPay2ohstN0Qtnw-1; Wed, 10 Apr 2024 17:28:21 -0400
X-MC-Unique: WPh5K-9kPay2ohstN0Qtnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AE22801701
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67306444FE2;
	Wed, 10 Apr 2024 21:28:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	David Teigland <teigland@redhat.com>
Subject: [PATCH 2/3] gfs2: Fix potential glock use-after-free on unmount
Date: Wed, 10 Apr 2024 23:28:12 +0200
Message-ID: <20240410212814.204819-3-agruenba@redhat.com>
In-Reply-To: <20240410212814.204819-1-agruenba@redhat.com>
References: <20240410212814.204819-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When a DLM lockspace is released and there ares still locks in that
lockspace, DLM will unlock those locks automatically.  Commit
fb6791d100d1b started exploiting this behavior to speed up filesystem
unmount: gfs2 would simply free glocks it didn't want to unlock and then
release the lockspace.  This didn't take the bast callbacks for
asynchronous lock contention notifications into account, which remain
active until until a lock is unlocked or its lockspace is released.

To prevent those callbacks from accessing deallocated objects, put the
glocks that should not be unlocked on the sd_dead_glocks list, release
the lockspace, and only then free those glocks.

As an additional measure, ignore unexpected ast and bast callbacks if
the receiving glock is dead.

Fixes: fb6791d100d1b ("GFS2: skip dlm_unlock calls in unmount")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Teigland <teigland@redhat.com>
---
 fs/gfs2/glock.c      | 31 ++++++++++++++++++++++++++++---
 fs/gfs2/glock.h      |  2 ++
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/lock_dlm.c   | 32 ++++++++++++++++++++++----------
 fs/gfs2/ops_fstype.c |  1 +
 fs/gfs2/super.c      |  1 +
 6 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 60503e378740..ce62937d85b5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -166,18 +166,43 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 	return true;
 }
 
-void gfs2_glock_free(struct gfs2_glock *gl)
+static void __gfs2_glock_free(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
 	smp_mb();
 	wake_up_glock(gl);
 	call_rcu(&gl->gl_rcu, gfs2_glock_dealloc);
+}
+
+void gfs2_glock_free(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	__gfs2_glock_free(gl);
 	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
 		wake_up(&sdp->sd_kill_wait);
 }
 
+void gfs2_glock_free_later(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	list_add(&gl->gl_lru, &sdp->sd_dead_glocks);
+	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
+		wake_up(&sdp->sd_kill_wait);
+}
+
+void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
+{
+	struct list_head *list = &sdp->sd_dead_glocks;
+
+	while(!list_empty(list)) {
+		struct gfs2_glock *gl;
+
+		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
+		list_del_init(&gl->gl_lru);
+		__gfs2_glock_free(gl);
+	}
+}
+
 /**
  * gfs2_glock_hold() - increment reference count on glock
  * @gl: The glock to hold
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 2c697674a86f..3aa6ab6ab73f 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -252,6 +252,8 @@ void gfs2_gl_dq_holders(struct gfs2_sbd *sdp);
 void gfs2_glock_thaw(struct gfs2_sbd *sdp);
 void gfs2_glock_add_to_lru(struct gfs2_glock *gl);
 void gfs2_glock_free(struct gfs2_glock *gl);
+void gfs2_glock_free_later(struct gfs2_glock *gl);
+void gfs2_free_dead_glocks(struct gfs2_sbd *sdp);
 
 int __init gfs2_glock_init(void);
 void gfs2_glock_exit(void);
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 2c4c0ee2c014..fbb1c358b7e3 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -837,6 +837,7 @@ struct gfs2_sbd {
 	/* For quiescing the filesystem */
 	struct gfs2_holder sd_freeze_gh;
 	struct mutex sd_freeze_mutex;
+	struct list_head sd_dead_glocks;
 
 	char sd_fsname[GFS2_FSNAME_LEN + 3 * sizeof(int) + 2];
 	char sd_table_name[GFS2_FSNAME_LEN];
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index d1ac5d0679ea..e028e55e67d9 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -121,6 +121,11 @@ static void gdlm_ast(void *arg)
 	struct gfs2_glock *gl = arg;
 	unsigned ret = gl->gl_state;
 
+	/* If the glock is dead, we only react to a dlm_unlock() reply. */
+	if (__lockref_is_dead(&gl->gl_lockref) &&
+	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
+		return;
+
 	gfs2_update_reply_times(gl);
 	BUG_ON(gl->gl_lksb.sb_flags & DLM_SBF_DEMOTED);
 
@@ -171,6 +176,9 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
+	if (__lockref_is_dead(&gl->gl_lockref))
+		return;
+
 	switch (mode) {
 	case DLM_LOCK_EX:
 		gfs2_glock_cb(gl, LM_ST_UNLOCKED);
@@ -291,8 +299,12 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int error;
 
-	if (gl->gl_lksb.sb_lkid == 0)
-		goto out_free;
+	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
+
+	if (gl->gl_lksb.sb_lkid == 0) {
+		gfs2_glock_free(gl);
+		return;
+	}
 
 	clear_bit(GLF_BLOCKING, &gl->gl_flags);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
@@ -300,13 +312,17 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_update_request_times(gl);
 
 	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags))
-		goto out_free;
+	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+		gfs2_glock_free(gl);
+		return;
+	}
 	/* don't want to skip dlm_unlock writing the lvb when lock has one */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
-	    !gl->gl_lksb.sb_lvbptr)
-		goto out_free;
+	    !gl->gl_lksb.sb_lvbptr) {
+		gfs2_glock_free_later(gl);
+		return;
+	}
 
 again:
 	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_VALBLK,
@@ -321,10 +337,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		       gl->gl_name.ln_type,
 		       (unsigned long long)gl->gl_name.ln_number, error);
 	}
-	return;
-
-out_free:
-	gfs2_glock_free(gl);
 }
 
 static void gdlm_cancel(struct gfs2_glock *gl)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 1281e60be639..db0df091a6a7 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -136,6 +136,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	atomic_set(&sdp->sd_log_in_flight, 0);
 	init_waitqueue_head(&sdp->sd_log_flush_wait);
 	mutex_init(&sdp->sd_freeze_mutex);
+	INIT_LIST_HEAD(&sdp->sd_dead_glocks);
 
 	return sdp;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index d481db9510ac..4c3cec1a2cbd 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -652,6 +652,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_delete_debugfs_file(sdp);
 	/*  Unmount the locking protocol  */
 	gfs2_lm_unmount(sdp);
+	gfs2_free_dead_glocks(sdp);
 
 	/*  At this point, we're through participating in the lockspace  */
 	gfs2_sys_fs_del(sdp);
-- 
2.44.0

