Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A911C4A24
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956569; cv=none; b=KRA7hYHqEUxij3LhNctVGlJPYZmiTVVbxMp8PZU+EcuS7YoKfQbTFxZvVAv36dltiKZbtQAPLlprEHJzz40Ld7gTC+6gjEowtlrrO4iivmBHrpSeNaxZh3IfuW7R3fkOy37fcNLycTxN3Pof9bBxl9yb+c9MQF9efghrepm1ukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956569; c=relaxed/simple;
	bh=uZjqrucLZIwMGPRrnqvATpIfHuW/qmIH2C3xpu6V1CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=I234qIJ6t1vx+FeBIEj7TGS8pJhRj8dzURxmjwUjHqQL74eREyNi1RTSsFyjBW2dJYzP57pHc5Re0BdnzRXLoJU3Om3G9A9z2N3OUgdQqnBG+ZA6kOPhEjPmT7ymdWatlSqJtD/XE0erY8C/SOWDCtAQiJvEnOf0mhuykb+DT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdZMVSN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdZMVSN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMjSfkOcJPH6ZgygFph7OAHkysxf9D/WBPZr4NxtXIM=;
	b=gdZMVSN1vsTo6BqQpBwccif2JJwquJ9dMsT2g3gdKTO+5HM5tbONANn3bXOChKqRN/XrY1
	8JEjiARpS0tjmWGa/Qrnc326NmonU8PSDvCA7rs5KeTR63ogf3hgUmb0LpT0h5oLDr02e6
	FFaQDzifpLpL2ASoHZkj4X2mngt/ERU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-11w8Fu4BM1Wdma5hx1hdWw-1; Fri,
 31 Oct 2025 20:22:44 -0400
X-MC-Unique: 11w8Fu4BM1Wdma5hx1hdWw-1
X-Mimecast-MFC-AGG-ID: 11w8Fu4BM1Wdma5hx1hdWw_1761956563
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BF251800654
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A1C218004D8;
	Sat,  1 Nov 2025 00:22:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 04/24] gfs2: Rename gfs2_{withdrawing_or_ => }withdrawn
Date: Sat,  1 Nov 2025 00:22:13 +0000
Message-ID: <20251101002234.1286383-5-agruenba@redhat.com>
In-Reply-To: <20251101002234.1286383-1-agruenba@redhat.com>
References: <20251101002234.1286383-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qahxHJr5KQ7qios2o_aFFaVkYtVlXRChCKwGALq4yfY_1761956563
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With delayed withdraws and the SDF_WITHDRAWING flag gone, we can now
rename gfs2_withdrawing_or_withdrawn() back to gfs2_withdrawn().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c       |  2 +-
 fs/gfs2/file.c       |  2 +-
 fs/gfs2/glock.c      |  8 ++++----
 fs/gfs2/glops.c      |  2 +-
 fs/gfs2/lock_dlm.c   |  8 ++++----
 fs/gfs2/log.c        | 22 +++++++++++-----------
 fs/gfs2/meta_io.c    |  6 +++---
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/quota.c      |  8 ++++----
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/super.c      | 10 +++++-----
 fs/gfs2/sys.c        |  2 +-
 fs/gfs2/trans.c      |  2 +-
 fs/gfs2/util.c       |  4 ++--
 fs/gfs2/util.h       |  5 ++---
 15 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..a2ed80f81d73 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -435,7 +435,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
 
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	return error;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index bc67fa058c84..832e3c12ea27 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1446,7 +1446,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		if (lock_is_unlock(fl))
 			locks_lock_file_wait(file, fl);
 		return -EIO;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 0084c4aeb115..691bcb96325a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -154,7 +154,7 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (!gfs2_withdrawing_or_withdrawn(sdp))
+	if (!gfs2_withdrawn(sdp))
 		return false;
 	if (gl->gl_ops->go_flags & GLOF_NONDISK)
 		return false;
@@ -270,7 +270,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
 	if (mapping) {
 		truncate_inode_pages_final(mapping);
-		if (!gfs2_withdrawing_or_withdrawn(sdp))
+		if (!gfs2_withdrawn(sdp))
 			GLOCK_BUG_ON(gl, !mapping_empty(mapping));
 	}
 	trace_gfs2_glock_put(gl);
@@ -755,7 +755,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawing_or_withdrawn(sdp))
+	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawn(sdp))
 		gfs2_withdraw(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
@@ -803,7 +803,7 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 		} else {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
+			GLOCK_BUG_ON(gl, !gfs2_withdrawn(sdp));
 			return;
 		}
 	}
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 8166c84a439b..9dfa90bfae3e 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -175,7 +175,7 @@ static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 
 	filemap_fdatawrite_range(metamapping, start, end);
 	error = filemap_fdatawait_range(metamapping, start, end);
-	WARN_ON_ONCE(error && !gfs2_withdrawing_or_withdrawn(sdp));
+	WARN_ON_ONCE(error && !gfs2_withdrawn(sdp));
 	mapping_set_error(metamapping, error);
 	if (error)
 		gfs2_io_error(sdp);
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index c18e732a04bd..301e17345f52 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1195,7 +1195,7 @@ static void gdlm_recover_prep(void *arg)
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_err(sdp, "recover_prep ignored due to withdraw.\n");
 		return;
 	}
@@ -1221,7 +1221,7 @@ static void gdlm_recover_slot(void *arg, struct dlm_slot *slot)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int jid = slot->slot - 1;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_err(sdp, "recover_slot jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
@@ -1250,7 +1250,7 @@ static void gdlm_recover_done(void *arg, struct dlm_slot *slots, int num_slots,
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_err(sdp, "recover_done ignored due to withdraw.\n");
 		return;
 	}
@@ -1281,7 +1281,7 @@ static void gdlm_recovery_result(struct gfs2_sbd *sdp, unsigned int jid,
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_err(sdp, "recovery_result jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 26a1baa21535..b97da7f4d3f8 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -118,7 +118,7 @@ __acquires(&sdp->sd_ail_lock)
 			}
 		}
 
-		if (gfs2_withdrawing_or_withdrawn(sdp)) {
+		if (gfs2_withdrawn(sdp)) {
 			gfs2_remove_from_ail(bd);
 			continue;
 		}
@@ -834,7 +834,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	struct super_block *sb = sdp->sd_vfs;
 	u64 dblock;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return;
 
 	page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
@@ -981,7 +981,7 @@ static void empty_ail1_list(struct gfs2_sbd *sdp)
 		gfs2_ail1_wait(sdp);
 		empty = gfs2_ail1_empty(sdp, 0);
 
-		if (gfs2_withdrawing_or_withdrawn(sdp))
+		if (gfs2_withdrawn(sdp))
 			break;
 	}
 }
@@ -1044,7 +1044,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	 * Do this check while holding the log_flush_lock to prevent new
 	 * buffers from being added to the ail via gfs2_pin()
 	 */
-	if (gfs2_withdrawing_or_withdrawn(sdp) ||
+	if (gfs2_withdrawn(sdp) ||
 	    !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
 		goto out;
 
@@ -1094,14 +1094,14 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 			goto out_withdraw;
 
 	gfs2_ordered_write(sdp);
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 	lops_before_commit(sdp, tr);
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 	if (sdp->sd_jdesc)
 		gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 
 	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
@@ -1109,7 +1109,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	} else if (sdp->sd_log_tail != sdp->sd_log_flush_tail && !sdp->sd_log_idle) {
 		log_write_header(sdp, flags);
 	}
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		goto out_withdraw;
 	lops_after_commit(sdp, tr);
 
@@ -1127,7 +1127,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
 		if (!sdp->sd_log_idle) {
 			empty_ail1_list(sdp);
-			if (gfs2_withdrawing_or_withdrawn(sdp))
+			if (gfs2_withdrawn(sdp))
 				goto out_withdraw;
 			log_write_header(sdp, flags);
 		}
@@ -1296,7 +1296,7 @@ int gfs2_logd(void *data)
 
 	set_freezable();
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawing_or_withdrawn(sdp))
+		if (gfs2_withdrawn(sdp))
 			break;
 
 		/* Check for errors writing to the journal */
@@ -1333,7 +1333,7 @@ int gfs2_logd(void *data)
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
 				sdp->sd_log_error ||
-				gfs2_withdrawing_or_withdrawn(sdp) ||
+				gfs2_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 	}
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 7fb11ff71b5a..3ee90a4452b9 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -263,7 +263,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	if (gfs2_withdrawn(sdp) &&
 	    !gfs2_withdraw_in_prog(sdp)) {
 		*bhp = NULL;
 		return -EIO;
@@ -322,7 +322,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	if (gfs2_withdrawn(sdp) &&
 	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
@@ -334,7 +334,7 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			gfs2_io_error_bh_wd(sdp, bh);
 		return -EIO;
 	}
-	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	if (gfs2_withdrawn(sdp) &&
 	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 553cf6d922c0..8dab5e87b5a6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1040,7 +1040,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 void gfs2_lm_unmount(struct gfs2_sbd *sdp)
 {
 	const struct lm_lockops *lm = sdp->sd_lockstruct.ls_ops;
-	if (!gfs2_withdrawing_or_withdrawn(sdp) && lm->lm_unmount)
+	if (!gfs2_withdrawn(sdp) && lm->lm_unmount)
 		lm->lm_unmount(sdp, true);
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 2298e06797ac..686b90ede870 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -125,7 +125,7 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 	hlist_bl_del_rcu(&qd->qd_hlist);
 	spin_unlock_bucket(qd->qd_hash);
 
-	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (!gfs2_withdrawn(sdp)) {
 		gfs2_assert_warn(sdp, !qd->qd_change);
 		gfs2_assert_warn(sdp, !qd->qd_slot_ref);
 		gfs2_assert_warn(sdp, !qd->qd_bh_count);
@@ -1551,7 +1551,7 @@ static void quotad_error(struct gfs2_sbd *sdp, const char *msg, int error)
 {
 	if (error == 0 || error == -EROFS)
 		return;
-	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (!gfs2_withdrawn(sdp)) {
 		if (!cmpxchg(&sdp->sd_log_error, 0, error))
 			fs_err(sdp, "gfs2_quotad: %s error %d\n", msg, error);
 		wake_up(&sdp->sd_logd_waitq);
@@ -1596,7 +1596,7 @@ int gfs2_quotad(void *data)
 
 	set_freezable();
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawing_or_withdrawn(sdp))
+		if (gfs2_withdrawn(sdp))
 			break;
 
 		/* Update the master statfs file */
@@ -1618,7 +1618,7 @@ int gfs2_quotad(void *data)
 
 		t = wait_event_freezable_timeout(sdp->sd_quota_wait,
 				sdp->sd_statfs_force_sync ||
-				gfs2_withdrawing_or_withdrawn(sdp) ||
+				gfs2_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 24250478b085..4873b1c0e1bd 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -408,7 +408,7 @@ void gfs2_recover_func(struct work_struct *work)
 	int error = 0;
 	int jlocked = 0;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
 		       jd->jd_jid);
 		goto fail;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a6e898861412..2e4f75f17d46 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -137,7 +137,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	if (sdp->sd_log_sequence == 0) {
@@ -147,7 +147,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	}
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawing_or_withdrawn(sdp))
+	if (!error && gfs2_withdrawn(sdp))
 		error = -EIO;
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
@@ -491,7 +491,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 	if (unlikely(!ip->i_gl))
 		return;
 
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return;
 	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
 		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
@@ -597,7 +597,7 @@ static void gfs2_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
 	else {
-		if (gfs2_withdrawing_or_withdrawn(sdp))
+		if (gfs2_withdrawn(sdp))
 			gfs2_destroy_threads(sdp);
 
 		gfs2_quota_cleanup(sdp);
@@ -778,7 +778,7 @@ static int gfs2_freeze_fs(struct super_block *sb)
 	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
 		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
 			       GFS2_LFC_FREEZE_GO_SYNC);
-		if (gfs2_withdrawing_or_withdrawn(sdp))
+		if (gfs2_withdrawn(sdp))
 			return -EIO;
 	}
 	return 0;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 8093a596661e..5439a65549af 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -191,7 +191,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
-	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
+	unsigned int b = gfs2_withdrawn(sdp);
 	return sysfs_emit(buf, "%u\n", b);
 }
 
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 075f7e9abe47..f0cfdb5c5f2d 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -289,7 +289,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		       (unsigned long long)bd->bd_bh->b_blocknr);
 		BUG();
 	}
-	if (gfs2_withdrawing_or_withdrawn(sdp)) {
+	if (gfs2_withdrawn(sdp)) {
 		fs_info(sdp, "GFS2:adding buf while withdrawn! 0x%llx\n",
 			(unsigned long long)bd->bd_bh->b_blocknr);
 		goto out_unlock;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index e15e11f6f161..4c3b44eafc9f 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -366,7 +366,7 @@ void gfs2_withdraw(struct gfs2_sbd *sdp)
 void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 			    const char *function, char *file, unsigned int line)
 {
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return;
 
 	fs_err(sdp,
@@ -524,7 +524,7 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			const char *function, char *file, unsigned int line,
 			bool withdraw)
 {
-	if (gfs2_withdrawing_or_withdrawn(sdp))
+	if (gfs2_withdrawn(sdp))
 		return;
 
 	fs_err(sdp, "fatal: I/O error - "
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 51347a467b89..832c6c6eef41 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -183,11 +183,10 @@ static inline unsigned int gfs2_tune_get_i(struct gfs2_tune *gt,
 }
 
 /**
- * gfs2_withdrawing_or_withdrawn - test whether the file system is withdrawing
- *                                 or withdrawn
+ * gfs2_withdrawn - test whether the file system is withdrawn
  * @sdp: the superblock
  */
-static inline bool gfs2_withdrawing_or_withdrawn(struct gfs2_sbd *sdp)
+static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
 {
 	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags));
 }
-- 
2.51.0

