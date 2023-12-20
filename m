Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856F487A9
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxxHY/ZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703103146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+spg/Gh7LpsD0V3ySSkyOmstSYExf6oayje7VYXgZc=;
	b=JxxHY/ZWtQmKdLbuLsGagUup/2ZFvVBsh5yz/i1wooo9o3jExKEdk/TQAhCQT9KwmYqoCf
	UbJOxP8U8hnhger2ZI5FENDMXZnk1//myrugkgH40EuPD5DL4oNdH+URgZ+poB3pWD4d3M
	QNwaUtVN/tGcN9jEyOEfiLH39TBoYJc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-C-Dzc9YEPqiFpNsbj7o-GQ-1; Wed,
 20 Dec 2023 15:12:25 -0500
X-MC-Unique: C-Dzc9YEPqiFpNsbj7o-GQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8F61C0BB42
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 20:12:24 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A02F492BE6;
	Wed, 20 Dec 2023 20:12:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/4] gfs2: Rename gfs2_withdrawn to gfs2_withdrawing_or_withdrawn
Date: Wed, 20 Dec 2023 21:12:21 +0100
Message-ID: <20231220201222.1581061-3-agruenba@redhat.com>
In-Reply-To: <20231220201222.1581061-1-agruenba@redhat.com>
References: <20231220201222.1581061-1-agruenba@redhat.com>
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

This function checks whether the filesystem has been been marked to be
withdrawn eventually or has been withdrawn already.  Rename this
function to avoid confusing code like checking for gfs2_withdrawing()
when gfs2_withdrawn() has already returned true.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c       |  2 +-
 fs/gfs2/file.c       |  2 +-
 fs/gfs2/glock.c      |  8 ++++----
 fs/gfs2/glops.c      |  2 +-
 fs/gfs2/lock_dlm.c   |  8 ++++----
 fs/gfs2/log.c        | 21 +++++++++++----------
 fs/gfs2/meta_io.c    |  9 ++++++---
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/quota.c      |  8 ++++----
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/super.c      | 10 +++++-----
 fs/gfs2/sys.c        |  2 +-
 fs/gfs2/trans.c      |  2 +-
 fs/gfs2/util.c       |  4 ++--
 fs/gfs2/util.h       |  5 +++--
 15 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 4482a5a9bdc9..d551b9c94935 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -462,7 +462,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return -EIO;
 
 	return error;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 03902e780935..992ca4effb50 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1442,7 +1442,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		if (fl->fl_type == F_UNLCK)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b71dd7c8f65e..45f5c88d2622 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -156,7 +156,7 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (!gfs2_withdrawn(sdp))
+	if (!gfs2_withdrawing_or_withdrawn(sdp))
 		return false;
 	if (gl->gl_ops->go_flags & GLOF_NONDISK)
 		return false;
@@ -278,7 +278,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
 	if (mapping) {
 		truncate_inode_pages_final(mapping);
-		if (!gfs2_withdrawn(sdp))
+		if (!gfs2_withdrawing_or_withdrawn(sdp))
 			GLOCK_BUG_ON(gl, !mapping_empty(mapping));
 	}
 	trace_gfs2_glock_put(gl);
@@ -774,7 +774,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawn(sdp))
+	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawing_or_withdrawn(sdp))
 		gfs2_withdraw_delayed(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
@@ -811,7 +811,7 @@ __acquires(&gl->gl_lockref.lock)
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawn(sdp));
+			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
 		}
 	} else { /* lock_nolock */
 		finish_xmote(gl, target);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 15d0e653fd2b..45653cbc8a87 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -174,7 +174,7 @@ static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 
 	filemap_fdatawrite_range(metamapping, start, end);
 	error = filemap_fdatawait_range(metamapping, start, end);
-	WARN_ON_ONCE(error && !gfs2_withdrawn(sdp));
+	WARN_ON_ONCE(error && !gfs2_withdrawing_or_withdrawn(sdp));
 	mapping_set_error(metamapping, error);
 	if (error)
 		gfs2_io_error(sdp);
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 59ab18c79889..d1ac5d0679ea 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1122,7 +1122,7 @@ static void gdlm_recover_prep(void *arg)
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_prep ignored due to withdraw.\n");
 		return;
 	}
@@ -1148,7 +1148,7 @@ static void gdlm_recover_slot(void *arg, struct dlm_slot *slot)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int jid = slot->slot - 1;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_slot jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
@@ -1177,7 +1177,7 @@ static void gdlm_recover_done(void *arg, struct dlm_slot *slots, int num_slots,
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_done ignored due to withdraw.\n");
 		return;
 	}
@@ -1208,7 +1208,7 @@ static void gdlm_recovery_result(struct gfs2_sbd *sdp, unsigned int jid,
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recovery_result jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 61cd52a579d9..8691839104b7 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -126,7 +126,7 @@ __acquires(&sdp->sd_ail_lock)
 			}
 		}
 
-		if (gfs2_withdrawn(sdp)) {
+		if (gfs2_withdrawing_or_withdrawn(sdp)) {
 			gfs2_remove_from_ail(bd);
 			continue;
 		}
@@ -842,7 +842,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	struct super_block *sb = sdp->sd_vfs;
 	u64 dblock;
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
@@ -1048,7 +1048,8 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	 * Do this check while holding the log_flush_lock to prevent new
 	 * buffers from being added to the ail via gfs2_pin()
 	 */
-	if (gfs2_withdrawn(sdp) || !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
+	if (gfs2_withdrawing_or_withdrawn(sdp) ||
+	    !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
 		goto out;
 
 	/* Log might have been flushed while we waited for the flush lock */
@@ -1097,13 +1098,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 			goto out_withdraw;
 
 	gfs2_ordered_write(sdp);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	lops_before_commit(sdp, tr);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 
 	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
@@ -1111,7 +1112,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	} else if (sdp->sd_log_tail != sdp->sd_log_flush_tail && !sdp->sd_log_idle) {
 		log_write_header(sdp, flags);
 	}
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	lops_after_commit(sdp, tr);
 
@@ -1129,7 +1130,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
 		if (!sdp->sd_log_idle) {
 			empty_ail1_list(sdp);
-			if (gfs2_withdrawn(sdp))
+			if (gfs2_withdrawing_or_withdrawn(sdp))
 				goto out_withdraw;
 			log_write_header(sdp, flags);
 		}
@@ -1299,7 +1300,7 @@ int gfs2_logd(void *data)
 	unsigned long t = 1;
 
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			break;
 
 		/* Check for errors writing to the journal */
@@ -1338,7 +1339,7 @@ int gfs2_logd(void *data)
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
 				sdp->sd_log_error ||
-				gfs2_withdrawn(sdp) ||
+				gfs2_withdrawing_or_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 	}
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 299ae67ae85e..f814054c8cd0 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -252,7 +252,8 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp)) {
 		*bhp = NULL;
 		return -EIO;
 	}
@@ -310,7 +311,8 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	wait_on_buffer(bh);
@@ -321,7 +323,8 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			gfs2_io_error_bh_wd(sdp, bh);
 		return -EIO;
 	}
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c6ec08909c69..9c6f1a8fb5fb 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1073,7 +1073,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 void gfs2_lm_unmount(struct gfs2_sbd *sdp)
 {
 	const struct lm_lockops *lm = sdp->sd_lockstruct.ls_ops;
-	if (!gfs2_withdrawn(sdp) && lm->lm_unmount)
+	if (!gfs2_withdrawing_or_withdrawn(sdp) && lm->lm_unmount)
 		lm->lm_unmount(sdp);
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index f139ce8cf5ce..9ade69f8d338 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -128,7 +128,7 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 	hlist_bl_del_rcu(&qd->qd_hlist);
 	spin_unlock_bucket(qd->qd_hash);
 
-	if (!gfs2_withdrawn(sdp)) {
+	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
 		gfs2_assert_warn(sdp, !qd->qd_change);
 		gfs2_assert_warn(sdp, !qd->qd_slot_ref);
 		gfs2_assert_warn(sdp, !qd->qd_bh_count);
@@ -1540,7 +1540,7 @@ static void quotad_error(struct gfs2_sbd *sdp, const char *msg, int error)
 {
 	if (error == 0 || error == -EROFS)
 		return;
-	if (!gfs2_withdrawn(sdp)) {
+	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
 		if (!cmpxchg(&sdp->sd_log_error, 0, error))
 			fs_err(sdp, "gfs2_quotad: %s error %d\n", msg, error);
 		wake_up(&sdp->sd_logd_waitq);
@@ -1584,7 +1584,7 @@ int gfs2_quotad(void *data)
 	unsigned long t = 0;
 
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			break;
 
 		/* Update the master statfs file */
@@ -1608,7 +1608,7 @@ int gfs2_quotad(void *data)
 
 		t = wait_event_interruptible_timeout(sdp->sd_quota_wait,
 				sdp->sd_statfs_force_sync ||
-				gfs2_withdrawn(sdp) ||
+				gfs2_withdrawing_or_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 5aae02669a40..f4fe7039f725 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -411,7 +411,7 @@ void gfs2_recover_func(struct work_struct *work)
 	int error = 0;
 	int jlocked = 0;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
 		       jd->jd_jid);
 		goto fail;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 85c77dd327ec..cf3431486fd4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -134,7 +134,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return -EIO;
 
 	error = gfs2_find_jhead(sdp->sd_jdesc, &head, false);
@@ -153,7 +153,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	gfs2_log_pointers_init(sdp, head.lh_blkno);
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawn(sdp))
+	if (!error && gfs2_withdrawing_or_withdrawn(sdp))
 		error = -EIO;
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
@@ -499,7 +499,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 		return;
 	}
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
 		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
@@ -605,7 +605,7 @@ static void gfs2_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
 	else {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			gfs2_destroy_threads(sdp);
 
 		gfs2_quota_cleanup(sdp);
@@ -685,7 +685,7 @@ static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
 	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
 		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
 			       GFS2_LFC_FREEZE_GO_SYNC);
-		if (gfs2_withdrawn(sdp)) {
+		if (gfs2_withdrawing_or_withdrawn(sdp)) {
 			error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 			if (error)
 				return error;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 60a0206890c5..250f340cb44d 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -193,7 +193,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
-	unsigned int b = gfs2_withdrawn(sdp);
+	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
 	return snprintf(buf, PAGE_SIZE, "%u\n", b);
 }
 
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 1487fbb62d84..192213c7359a 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -268,7 +268,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		       (unsigned long long)bd->bd_bh->b_blocknr);
 		BUG();
 	}
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_info(sdp, "GFS2:adding buf while withdrawn! 0x%llx\n",
 			(unsigned long long)bd->bd_bh->b_blocknr);
 		goto out_unlock;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index da29fafb6272..f52141ce9485 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -372,7 +372,7 @@ void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 			    const char *function, char *file, unsigned int line,
 			    bool delayed)
 {
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	fs_err(sdp,
@@ -548,7 +548,7 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			const char *function, char *file, unsigned int line,
 			bool withdraw)
 {
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	fs_err(sdp, "fatal: I/O error\n"
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 76acf0b39814..ba071998461f 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -198,10 +198,11 @@ static inline void gfs2_withdraw_delayed(struct gfs2_sbd *sdp)
 }
 
 /**
- * gfs2_withdrawn - test whether the file system is withdrawing or withdrawn
+ * gfs2_withdrawing_or_withdrawn - test whether the file system is withdrawing
+ *                                 or withdrawn
  * @sdp: the superblock
  */
-static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
+static inline bool gfs2_withdrawing_or_withdrawn(struct gfs2_sbd *sdp)
 {
 	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
 			test_bit(SDF_WITHDRAWING, &sdp->sd_flags));
-- 
2.43.0

