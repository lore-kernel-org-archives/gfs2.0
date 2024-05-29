Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82B1459E3
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002247; cv=none; b=Qh4/XlWO7fF0+oxMKkdi6vjPFjLD5vHp5hyEW7n3g8MlFIcrAUeFEzoApaeh3b4CZ74lwQgmdbRWwY0mbnqG79j5KoS46C87faIIBqVfPLmeDDH/SNRUj+3WwMzvTM4yBPPbTCX9gzYXlQJGK3Uokmhp+JU0b0Wf75CWuZXqAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002247; c=relaxed/simple;
	bh=q8nsL2rTxeEs8CjpKGGjvH+ILCpoomqUTAKv/pXSaC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByOUKmzbelqCGBdVUK1+piHrlI9wUJARwiOSs6xw8zuawHMPtd81Ag6WyoWjnUXMCN10fy7F5Lk1tO0y7zbXNKLLHIK12UNol23AMHFTLhgrdqb1FMk0rJB8HnbNJRK6n8MeUUgPaSrEGVIY67O0RqdBSstzWFSRfDn9vFZw5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9dCcvvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9dCcvvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV/jz+BzqWpMnAm0I8JkkeswITauy+VyBPzJx89yi48=;
	b=G9dCcvvN6iMdADQNYXMnKPuuVPEJtqhdSguSmaAxcpz03mrXOi06Q17Q43HL8S03oj+t1R
	XNF9LuUB4XwDeVhVyn0tJPXsmFek9n5BbVZukHg1dD4oigGLdOyyGlyO8zpcBKzkx67M6+
	I2Ml/Saixp+tDoj/6gTrptp1Kj/lAgQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-XNictDyOPpSOYAAywM831w-1; Wed, 29 May 2024 13:04:03 -0400
X-MC-Unique: XNictDyOPpSOYAAywM831w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AE6A800281
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:04:03 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3381492BC6;
	Wed, 29 May 2024 17:04:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/15] gfs2: Switch to a per-filesystem glock workqueue
Date: Wed, 29 May 2024 19:03:49 +0200
Message-ID: <20240529170352.571141-13-agruenba@redhat.com>
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

Switch to a per-filesystem glock workqueue.  Additional workqueues are
cheap nowadays, and keeping separate workqueues allows to flush the work
of each filesystem without affecting the others.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 20 +++++++-------------
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/ops_fstype.c | 12 ++++++++++--
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b819f8b8d98b..32991cb22023 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -65,7 +65,6 @@ static void request_demote(struct gfs2_glock *gl, unsigned int state,
 			   unsigned long delay, bool remote);
 
 static struct dentry *gfs2_root;
-static struct workqueue_struct *glock_workqueue;
 static LIST_HEAD(lru_list);
 static atomic_t lru_count = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(lru_lock);
@@ -274,7 +273,9 @@ static void gfs2_glock_remove_from_lru(struct gfs2_glock *gl)
  * work queue.
  */
 static void gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
-	if (!queue_delayed_work(glock_workqueue, &gl->gl_work, delay)) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	if (!queue_delayed_work(sdp->sd_glock_wq, &gl->gl_work, delay)) {
 		/*
 		 * We are holding the lockref spinlock, and the work was still
 		 * queued above.  The queued work (glock_work_func) takes that
@@ -2252,9 +2253,10 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	bool timed_out = false;
 
 	set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
-	flush_workqueue(glock_workqueue);
+	flush_workqueue(sdp->sd_glock_wq);
 	glock_hash_walk(clear_glock, sdp);
-	flush_workqueue(glock_workqueue);
+	flush_workqueue(sdp->sd_glock_wq);
+
 	while (!timed_out) {
 		wait_event_timeout(sdp->sd_kill_wait,
 				   !atomic_read(&sdp->sd_glock_disposal),
@@ -2270,6 +2272,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	gfs2_lm_unmount(sdp);
 	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
+	destroy_workqueue(sdp->sd_glock_wq);
 }
 
 static const char *state2str(unsigned state)
@@ -2534,16 +2537,8 @@ int __init gfs2_glock_init(void)
 	if (ret < 0)
 		return ret;
 
-	glock_workqueue = alloc_workqueue("glock_workqueue", WQ_MEM_RECLAIM |
-					  WQ_HIGHPRI | WQ_FREEZABLE, 0);
-	if (!glock_workqueue) {
-		rhashtable_destroy(&gl_hash_table);
-		return -ENOMEM;
-	}
-
 	glock_shrinker = shrinker_alloc(0, "gfs2-glock");
 	if (!glock_shrinker) {
-		destroy_workqueue(glock_workqueue);
 		rhashtable_destroy(&gl_hash_table);
 		return -ENOMEM;
 	}
@@ -2563,7 +2558,6 @@ void gfs2_glock_exit(void)
 {
 	shrinker_free(glock_shrinker);
 	rhashtable_destroy(&gl_hash_table);
-	destroy_workqueue(glock_workqueue);
 }
 
 static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 73f24b86338c..5ee46af1f4bd 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -772,6 +772,7 @@ struct gfs2_sbd {
 
 	/* Workqueue stuff */
 
+	struct workqueue_struct *sd_glock_wq;
 	struct workqueue_struct *sd_delete_wq;
 
 	/* Daemon stuff */
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 05975ec76d35..0561edd6cc86 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1188,11 +1188,17 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	snprintf(sdp->sd_fsname, sizeof(sdp->sd_fsname), "%s", sdp->sd_table_name);
 
+	error = -ENOMEM;
+	sdp->sd_glock_wq = alloc_workqueue("gfs2-glock/%s",
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_FREEZABLE, 0,
+			sdp->sd_fsname);
+	if (!sdp->sd_glock_wq)
+		goto fail_free;
+
 	sdp->sd_delete_wq = alloc_workqueue("gfs2-delete/%s",
 			WQ_MEM_RECLAIM | WQ_FREEZABLE, 0, sdp->sd_fsname);
-	error = -ENOMEM;
 	if (!sdp->sd_delete_wq)
-		goto fail_free;
+		goto fail_glock_wq;
 
 	error = gfs2_sys_fs_add(sdp);
 	if (error)
@@ -1301,6 +1307,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	gfs2_sys_fs_del(sdp);
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
+fail_glock_wq:
+	destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
-- 
2.45.1

