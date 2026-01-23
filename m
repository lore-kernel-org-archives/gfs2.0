Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E61FFC59
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182292; cv=none; b=aMkQWKr37PoeLYPdXU4XRkmVhqup+i8jTq+YMrNeH91bVmTJ8JdAGtK6SUVnxWql6vMGtWl7yh/EvTyASWvnUTq/FMDO6BHlRRsf5h4JFgbUDJ8xCRPgKri4vWw9atdipSFY7k1a6OaDAKWm7OKTpaP6Ctgzy/uGNJZr9Li+89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182292; c=relaxed/simple;
	bh=y6FwAPr2ntcZivRpfOz4+HbNmaHiAIvVKNkIvUb9im4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Zg+FEujtAZEU/bkjmpqalvKhHHpg8OGMd2qj+lJouGVozeHb1WTg23FhkX8AU6/S/zLIkPRv6GUMefK2pPn8sh3w7AS3uxr1g0ctA3EG6ckZjbFziNSaVU/k2dNXJgsoQ1WdLKGiqJKQLiwIqaHc4fKRaQJ2lpJToA3Oi/0sHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzkD0F+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzkD0F+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPS0z4ATovvhljGz6/C00eCKv74E01O7l7uniFBrFx8=;
	b=BzkD0F+V43RgBeQRUqapUeZL67OqOza7rWYtRr6+UbmyJ8rNO+FkdVcJC/zNSog1noy7Ro
	6JjwnWfYFL/D10cUxmIGiNIFXKDoBI+WBix6VvQAXmkITIJX9Ifs6+Jg4/HFz9Dvxm3No5
	erSgx3BbHwuvlHRtaU11IccimIUiphQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-O5nUJKl9OS6I8lMXvPDQ5Q-1; Fri,
 23 Jan 2026 10:31:26 -0500
X-MC-Unique: O5nUJKl9OS6I8lMXvPDQ5Q-1
X-Mimecast-MFC-AGG-ID: O5nUJKl9OS6I8lMXvPDQ5Q_1769182285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACE611944B07
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:25 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8009D30002DC;
	Fri, 23 Jan 2026 15:31:24 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/13] gfs2: Introduce glock_{type,number,sbd} helpers
Date: Fri, 23 Jan 2026 16:31:02 +0100
Message-ID: <20260123153105.797382-13-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -BILNtzc-F6kL6FatXJEbElnJh9Wf3ZxJyRdWGovP-g_1769182285
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Introduce glock_type(), glock_number(), and glock_sbd() helpers for
accessing a glock's type, number, and super block pointer more easily.

Created with Coccinelle using the following semantic patch:

@@ struct gfs2_glock *gl; @@
- gl->gl_name.ln_type
+ glock_type(gl)

@@ struct gfs2_glock *gl; @@
- gl->gl_name.ln_number
+ glock_number(gl)

@@ struct gfs2_glock *gl; @@
- gl->gl_name.ln_sbd
+ glock_sbd(gl)

glock_sbd() is a macro because it is used with const as well as
non-const struct gfs2_glock * arguments.

Instances in macro definitions, particularly in tracepoint definitions,
replaced by hand.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 82 ++++++++++++++++++++++----------------------
 fs/gfs2/glock.h      |  4 +--
 fs/gfs2/glops.c      | 34 +++++++++---------
 fs/gfs2/incore.h     | 16 +++++++--
 fs/gfs2/lock_dlm.c   | 28 +++++++--------
 fs/gfs2/lops.c       |  6 ++--
 fs/gfs2/meta_io.c    |  6 ++--
 fs/gfs2/meta_io.h    |  2 +-
 fs/gfs2/quota.c      |  4 +--
 fs/gfs2/rgrp.c       |  2 +-
 fs/gfs2/trace_gfs2.h | 48 +++++++++++++-------------
 fs/gfs2/trans.c      |  4 +--
 12 files changed, 124 insertions(+), 112 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index bba415511920..6fb2731e8be1 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -147,7 +147,7 @@ static void __gfs2_glock_free(struct gfs2_glock *gl)
 }
 
 void gfs2_glock_free(struct gfs2_glock *gl) {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	__gfs2_glock_free(gl);
 	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
@@ -155,7 +155,7 @@ void gfs2_glock_free(struct gfs2_glock *gl) {
 }
 
 void gfs2_glock_free_later(struct gfs2_glock *gl) {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	spin_lock(&lru_lock);
 	list_add(&gl->gl_lru, &sdp->sd_dead_glocks);
@@ -219,7 +219,7 @@ static void gfs2_glock_remove_from_lru(struct gfs2_glock *gl)
  * work queue.
  */
 static void gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	if (!queue_delayed_work(sdp->sd_glock_wq, &gl->gl_work, delay)) {
 		/*
@@ -235,7 +235,7 @@ static void gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
 
 static void __gfs2_glock_put(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct address_space *mapping = gfs2_glock2aspace(gl);
 
 	lockref_mark_dead(&gl->gl_lockref);
@@ -357,7 +357,7 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
 	smp_mb__after_atomic();
 	wake_up_bit(&gh->gh_iflags, HIF_WAIT);
 	if (gh->gh_flags & GL_ASYNC) {
-		struct gfs2_sbd *sdp = gh->gh_gl->gl_name.ln_sbd;
+		struct gfs2_sbd *sdp = glock_sbd(gh->gh_gl);
 
 		wake_up(&sdp->sd_async_glock_wait);
 	}
@@ -459,7 +459,7 @@ int gfs2_instantiate(struct gfs2_holder *gh)
 
 static void do_promote(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_holder *gh, *current_gh;
 
 	if (gfs2_withdrawn(sdp)) {
@@ -539,7 +539,7 @@ static void state_change(struct gfs2_glock *gl, unsigned int new_state)
 
 static void gfs2_set_demote(int nr, struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	set_bit(nr, &gl->gl_flags);
 	smp_mb();
@@ -611,9 +611,9 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			do_xmote(gl, gh, LM_ST_UNLOCKED, false);
 			break;
 		default: /* Everything else */
-			fs_err(gl->gl_name.ln_sbd,
+			fs_err(glock_sbd(gl),
 			       "glock %u:%llu requested=%u ret=%u\n",
-			       gl->gl_name.ln_type, gl->gl_name.ln_number,
+			       glock_type(gl), glock_number(gl),
 			       gl->gl_req, ret);
 			GLOCK_BUG_ON(gl, 1);
 		}
@@ -659,7 +659,7 @@ __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int ret;
 
@@ -819,7 +819,7 @@ void glock_set_object(struct gfs2_glock *gl, void *object)
 	prev_object = gl->gl_object;
 	gl->gl_object = object;
 	spin_unlock(&gl->gl_lockref.lock);
-	if (gfs2_assert_warn(gl->gl_name.ln_sbd, prev_object == NULL))
+	if (gfs2_assert_warn(glock_sbd(gl), prev_object == NULL))
 		gfs2_dump_glock(NULL, gl, true);
 }
 
@@ -836,7 +836,7 @@ void glock_clear_object(struct gfs2_glock *gl, void *object)
 	prev_object = gl->gl_object;
 	gl->gl_object = NULL;
 	spin_unlock(&gl->gl_lockref.lock);
-	if (gfs2_assert_warn(gl->gl_name.ln_sbd, prev_object == object))
+	if (gfs2_assert_warn(glock_sbd(gl), prev_object == object))
 		gfs2_dump_glock(NULL, gl, true);
 }
 
@@ -926,7 +926,7 @@ static void gfs2_try_to_evict(struct gfs2_glock *gl)
 
 bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	if (test_and_set_bit(GLF_TRY_TO_EVICT, &gl->gl_flags))
 		return false;
@@ -935,7 +935,7 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 
 bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	unsigned long delay;
 
 	if (test_and_set_bit(GLF_VERIFY_DELETE, &gl->gl_flags))
@@ -948,7 +948,7 @@ static void delete_work_func(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct gfs2_glock *gl = container_of(dwork, struct gfs2_glock, gl_delete);
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	bool verify_delete = test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags);
 
 	/*
@@ -961,7 +961,7 @@ static void delete_work_func(struct work_struct *work)
 		gfs2_try_to_evict(gl);
 
 	if (verify_delete) {
-		u64 no_addr = gl->gl_name.ln_number;
+		u64 no_addr = glock_number(gl);
 		struct inode *inode;
 
 		inode = gfs2_lookup_by_inum(sdp, no_addr, gl->gl_no_formal_ino,
@@ -995,7 +995,7 @@ static void glock_work_func(struct work_struct *work)
 	if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
 	    gl->gl_demote_state != LM_ST_EXCLUSIVE) {
-		if (gl->gl_name.ln_type == LM_TYPE_INODE) {
+		if (glock_type(gl) == LM_TYPE_INODE) {
 			unsigned long holdtime, now = jiffies;
 
 			holdtime = gl->gl_tchange + gl->gl_hold_time;
@@ -1137,7 +1137,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	gl->gl_object = NULL;
 	gl->gl_hold_time = GL_GLOCK_DFT_HOLD;
 	INIT_DELAYED_WORK(&gl->gl_work, glock_work_func);
-	if (gl->gl_name.ln_type == LM_TYPE_IOPEN)
+	if (glock_type(gl) == LM_TYPE_IOPEN)
 		INIT_DELAYED_WORK(&gl->gl_delete, delete_work_func);
 
 	mapping = gfs2_glock2aspace(gl);
@@ -1295,7 +1295,7 @@ static int glocks_pending(unsigned int num_gh, struct gfs2_holder *ghs)
 int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			  unsigned int retries)
 {
-	struct gfs2_sbd *sdp = ghs[0].gh_gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(ghs[0].gh_gl);
 	unsigned long start_time = jiffies;
 	int i, ret = 0;
 	long timeout;
@@ -1437,7 +1437,7 @@ static inline bool pid_is_meaningful(const struct gfs2_holder *gh)
 static inline void add_to_queue(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_holder *gh2;
 
 	GLOCK_BUG_ON(gl, gh->gh_owner_pid == NULL);
@@ -1470,11 +1470,11 @@ static inline void add_to_queue(struct gfs2_holder *gh)
 	fs_err(sdp, "original: %pSR\n", (void *)gh2->gh_ip);
 	fs_err(sdp, "pid: %d\n", pid_nr(gh2->gh_owner_pid));
 	fs_err(sdp, "lock type: %d req lock state : %d\n",
-	       gh2->gh_gl->gl_name.ln_type, gh2->gh_state);
+	       glock_type(gh2->gh_gl), gh2->gh_state);
 	fs_err(sdp, "new: %pSR\n", (void *)gh->gh_ip);
 	fs_err(sdp, "pid: %d\n", pid_nr(gh->gh_owner_pid));
 	fs_err(sdp, "lock type: %d req lock state : %d\n",
-	       gh->gh_gl->gl_name.ln_type, gh->gh_state);
+	       glock_type(gh->gh_gl), gh->gh_state);
 	gfs2_dump_glock(NULL, gl, true);
 	BUG();
 }
@@ -1491,7 +1491,7 @@ static inline void add_to_queue(struct gfs2_holder *gh)
 int gfs2_glock_nq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	int error;
 
 	if (gfs2_withdrawn(sdp))
@@ -1580,7 +1580,7 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 		gl->gl_lockref.count++;
 		if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 		    !test_bit(GLF_DEMOTE, &gl->gl_flags) &&
-		    gl->gl_name.ln_type == LM_TYPE_INODE)
+		    glock_type(gl) == LM_TYPE_INODE)
 			delay = gl->gl_hold_time;
 		gfs2_glock_queue_work(gl, delay);
 	}
@@ -1624,7 +1624,7 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 
 		set_bit(GLF_CANCELING, &gl->gl_flags);
 		spin_unlock(&gl->gl_lockref.lock);
-		gl->gl_name.ln_sbd->sd_lockstruct.ls_ops->lm_cancel(gl);
+		glock_sbd(gl)->sd_lockstruct.ls_ops->lm_cancel(gl);
 		wait_on_bit(&gh->gh_iflags, HIF_WAIT, TASK_UNINTERRUPTIBLE);
 		spin_lock(&gl->gl_lockref.lock);
 		clear_bit(GLF_CANCELING, &gl->gl_flags);
@@ -1798,7 +1798,7 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 	gfs2_glock_hold(gl);
 	spin_lock(&gl->gl_lockref.lock);
 	if (!list_empty(&gl->gl_holders) &&
-	    gl->gl_name.ln_type == LM_TYPE_INODE) {
+	    glock_type(gl) == LM_TYPE_INODE) {
 		unsigned long now = jiffies;
 		unsigned long holdtime;
 
@@ -1855,7 +1855,7 @@ static int gfs2_should_freeze(const struct gfs2_glock *gl)
 
 void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 {
-	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
+	struct lm_lockstruct *ls = &glock_sbd(gl)->sd_lockstruct;
 
 	spin_lock(&gl->gl_lockref.lock);
 	clear_bit(GLF_MAY_CANCEL, &gl->gl_flags);
@@ -1883,9 +1883,9 @@ static int glock_cmp(void *priv, const struct list_head *a,
 	gla = list_entry(a, struct gfs2_glock, gl_lru);
 	glb = list_entry(b, struct gfs2_glock, gl_lru);
 
-	if (gla->gl_name.ln_number > glb->gl_name.ln_number)
+	if (glock_number(gla) > glock_number(glb))
 		return 1;
-	if (gla->gl_name.ln_number < glb->gl_name.ln_number)
+	if (glock_number(gla) < glock_number(glb))
 		return -1;
 
 	return 0;
@@ -1893,7 +1893,7 @@ static int glock_cmp(void *priv, const struct list_head *a,
 
 static bool can_free_glock(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	return !test_bit(GLF_LOCK, &gl->gl_flags) &&
 	       !gl->gl_lockref.count &&
@@ -2015,7 +2015,7 @@ static void glock_hash_walk(glock_examiner examiner, const struct gfs2_sbd *sdp)
 		rhashtable_walk_start(&iter);
 
 		while ((gl = rhashtable_walk_next(&iter)) && !IS_ERR(gl)) {
-			if (gl->gl_name.ln_sbd == sdp)
+			if (glock_sbd(gl) == sdp)
 				examiner(gl);
 		}
 
@@ -2035,8 +2035,8 @@ void gfs2_cancel_delete_work(struct gfs2_glock *gl)
 
 static void flush_delete_work(struct gfs2_glock *gl)
 {
-	if (gl->gl_name.ln_type == LM_TYPE_IOPEN) {
-		struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	if (glock_type(gl) == LM_TYPE_IOPEN) {
+		struct gfs2_sbd *sdp = glock_sbd(gl);
 
 		if (cancel_delayed_work(&gl->gl_delete)) {
 			queue_delayed_work(sdp->sd_delete_wq,
@@ -2321,7 +2321,7 @@ void gfs2_dump_glock(struct seq_file *seq, struct gfs2_glock *gl, bool fsid)
 	unsigned long long dtime;
 	const struct gfs2_holder *gh;
 	char gflags_buf[32];
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	char fs_id_buf[sizeof(sdp->sd_fsname) + 7];
 	unsigned long nrpages = 0;
 
@@ -2340,8 +2340,8 @@ void gfs2_dump_glock(struct seq_file *seq, struct gfs2_glock *gl, bool fsid)
 	gfs2_print_dbg(seq, "%sG:  s:%s n:%u/%llx f:%s t:%s d:%s/%llu a:%d "
 		       "v:%d r:%d m:%ld p:%lu\n",
 		       fs_id_buf, state2str(gl->gl_state),
-		       gl->gl_name.ln_type,
-		       (unsigned long long)gl->gl_name.ln_number,
+		       glock_type(gl),
+		       (unsigned long long) glock_number(gl),
 		       gflags2str(gflags_buf, gl),
 		       state2str(gl->gl_target),
 		       state2str(gl->gl_demote_state), dtime,
@@ -2361,8 +2361,8 @@ static int gfs2_glstats_seq_show(struct seq_file *seq, void *iter_ptr)
 	struct gfs2_glock *gl = iter_ptr;
 
 	seq_printf(seq, "G: n:%u/%llx rtt:%llu/%llu rttb:%llu/%llu irt:%llu/%llu dcnt: %llu qcnt: %llu\n",
-		   gl->gl_name.ln_type,
-		   (unsigned long long)gl->gl_name.ln_number,
+		   glock_type(gl),
+		   (unsigned long long) glock_number(gl),
 		   (unsigned long long)gl->gl_stats.stats[GFS2_LKS_SRTT],
 		   (unsigned long long)gl->gl_stats.stats[GFS2_LKS_SRTTVAR],
 		   (unsigned long long)gl->gl_stats.stats[GFS2_LKS_SRTTB],
@@ -2478,7 +2478,7 @@ static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
 			gl = NULL;
 			break;
 		}
-		if (gl->gl_name.ln_sbd != gi->sdp)
+		if (glock_sbd(gl) != gi->sdp)
 			continue;
 		if (n <= 1) {
 			if (!lockref_get_not_dead(&gl->gl_lockref))
@@ -2774,8 +2774,8 @@ static int gfs2_glockfd_seq_show(struct seq_file *seq, void *iter_ptr)
 	gl = GFS2_I(inode)->i_iopen_gh.gh_gl;
 	if (gl) {
 		seq_printf(seq, "%d %u %u/%llx\n",
-			   i->tgid, i->fd, gl->gl_name.ln_type,
-			   (unsigned long long)gl->gl_name.ln_number);
+			   i->tgid, i->fd, glock_type(gl),
+			   (unsigned long long) glock_number(gl));
 	}
 	gfs2_glockfd_seq_show_flock(seq, i);
 	inode_unlock_shared(inode);
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 26f967aa0e99..6341ac9b863f 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -222,11 +222,11 @@ void gfs2_dump_glock(struct seq_file *seq, struct gfs2_glock *gl,
 			BUG(); } } while(0)
 #define gfs2_glock_assert_warn(gl, x) do { if (unlikely(!(x))) {	\
 			gfs2_dump_glock(NULL, gl, true);		\
-			gfs2_assert_warn((gl)->gl_name.ln_sbd, (x)); } } \
+			gfs2_assert_warn(glock_sbd(gl), (x)); } } \
 	while (0)
 #define gfs2_glock_assert_withdraw(gl, x) do { if (unlikely(!(x))) {	\
 			gfs2_dump_glock(NULL, gl, true);		\
-			gfs2_assert_withdraw((gl)->gl_name.ln_sbd, (x)); } } \
+			gfs2_assert_withdraw(glock_sbd(gl), (x)); } } \
 	while (0)
 
 __printf(2, 3)
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 2173ccf5034b..ba61649368bf 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -32,7 +32,7 @@ struct workqueue_struct *gfs2_freeze_wq;
 
 static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	fs_err(sdp,
 	       "AIL buffer %p: blocknr %llu state 0x%08lx mapping %p page "
@@ -40,7 +40,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 	       bh, (unsigned long long)bh->b_blocknr, bh->b_state,
 	       bh->b_folio->mapping, bh->b_folio->flags.f);
 	fs_err(sdp, "AIL glock %u:%llu mapping %p\n",
-	       gl->gl_name.ln_type, gl->gl_name.ln_number,
+	       glock_type(gl), glock_number(gl),
 	       gfs2_glock2aspace(gl));
 	gfs2_lm(sdp, "AIL error\n");
 	gfs2_withdraw(sdp);
@@ -58,7 +58,7 @@ static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 			     unsigned int nr_revokes)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct list_head *head = &gl->gl_ail_list;
 	struct gfs2_bufdata *bd, *tmp;
 	struct buffer_head *bh;
@@ -86,7 +86,7 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 
 static int gfs2_ail_empty_gl(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_trans tr;
 	unsigned int revokes;
 	int ret = 0;
@@ -139,7 +139,7 @@ static int gfs2_ail_empty_gl(struct gfs2_glock *gl)
 
 void gfs2_ail_flush(struct gfs2_glock *gl, bool fsync)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	unsigned int revokes = atomic_read(&gl->gl_ail_count);
 	int ret;
 
@@ -163,7 +163,7 @@ void gfs2_ail_flush(struct gfs2_glock *gl, bool fsync)
 
 static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct address_space *metamapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
@@ -191,7 +191,7 @@ static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 
 static int rgrp_go_sync(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	int error;
 
@@ -220,7 +220,7 @@ static int rgrp_go_sync(struct gfs2_glock *gl)
 
 static void rgrp_go_inval(struct gfs2_glock *gl, int flags)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct address_space *mapping = gfs2_aspace(sdp);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
 	const unsigned bsize = sdp->sd_sb.sb_bsize;
@@ -290,7 +290,7 @@ int gfs2_inode_metasync(struct gfs2_glock *gl)
 	filemap_fdatawrite(metamapping);
 	error = filemap_fdatawait(metamapping);
 	if (error)
-		gfs2_io_error(gl->gl_name.ln_sbd);
+		gfs2_io_error(glock_sbd(gl));
 	return error;
 }
 
@@ -317,7 +317,7 @@ static int inode_go_sync(struct gfs2_glock *gl)
 
 	GLOCK_BUG_ON(gl, gl->gl_state != LM_ST_EXCLUSIVE);
 
-	gfs2_log_flush(gl->gl_name.ln_sbd, gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
+	gfs2_log_flush(glock_sbd(gl), gl, GFS2_LOG_HEAD_FLUSH_NORMAL |
 		       GFS2_LFC_INODE_GO_SYNC);
 	filemap_fdatawrite(metamapping);
 	if (isreg) {
@@ -359,7 +359,7 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_inode *ip = gfs2_glock2inode(gl);
 
-	gfs2_assert_withdraw(gl->gl_name.ln_sbd, !atomic_read(&gl->gl_ail_count));
+	gfs2_assert_withdraw(glock_sbd(gl), !atomic_read(&gl->gl_ail_count));
 
 	if (flags & DIO_METADATA) {
 		struct address_space *mapping = gfs2_glock2aspace(gl);
@@ -372,11 +372,11 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 		}
 	}
 
-	if (ip == GFS2_I(gl->gl_name.ln_sbd->sd_rindex)) {
-		gfs2_log_flush(gl->gl_name.ln_sbd, NULL,
+	if (ip == GFS2_I(glock_sbd(gl)->sd_rindex)) {
+		gfs2_log_flush(glock_sbd(gl), NULL,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_INODE_GO_INVAL);
-		gl->gl_name.ln_sbd->sd_rindex_uptodate = 0;
+		glock_sbd(gl)->sd_rindex_uptodate = 0;
 	}
 	if (ip && S_ISREG(ip->i_inode.i_mode))
 		truncate_inode_pages(ip->i_inode.i_mapping, 0);
@@ -567,7 +567,7 @@ static void inode_go_dump(struct seq_file *seq, const struct gfs2_glock *gl,
 
 static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct super_block *sb = sdp->sd_vfs;
 
 	if (!remote ||
@@ -596,7 +596,7 @@ static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
  */
 static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 	struct gfs2_glock *j_gl = ip->i_gl;
 	struct gfs2_log_header_host head;
@@ -626,7 +626,7 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 {
 	struct gfs2_inode *ip = gl->gl_object;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 
 	if (!remote || test_bit(SDF_KILL, &sdp->sd_flags))
 		return;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index f7909607936a..61465777826a 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -369,6 +369,16 @@ struct gfs2_glock {
 	struct rhash_head gl_node;
 };
 
+static inline unsigned int glock_type(const struct gfs2_glock *gl)
+{
+	return gl->gl_name.ln_type;
+}
+
+static inline u64 glock_number(const struct gfs2_glock *gl)
+{
+	return gl->gl_name.ln_number;
+}
+
 enum {
 	GIF_QD_LOCKED		= 1,
 	GIF_SW_PAGED		= 3,
@@ -839,6 +849,8 @@ struct gfs2_sbd {
 	struct dentry *debugfs_dir;    /* debugfs directory */
 };
 
+#define glock_sbd(gl) ((gl)->gl_name.ln_sbd)
+
 #define GFS2_BAD_INO 1
 
 static inline struct address_space *gfs2_aspace(struct gfs2_sbd *sdp)
@@ -853,9 +865,9 @@ static inline void gfs2_glstats_inc(struct gfs2_glock *gl, int which)
 
 static inline void gfs2_sbstats_inc(const struct gfs2_glock *gl, int which)
 {
-	const struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	const struct gfs2_sbd *sdp = glock_sbd(gl);
 	preempt_disable();
-	this_cpu_ptr(sdp->sd_lkstats)->lkstats[gl->gl_name.ln_type].stats[which]++;
+	this_cpu_ptr(sdp->sd_lkstats)->lkstats[glock_type(gl)].stats[which]++;
 	preempt_enable();
 }
 
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index b8d249925395..53b8419ee15f 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -74,13 +74,13 @@ static inline void gfs2_update_reply_times(struct gfs2_glock *gl,
 					   bool blocking)
 {
 	struct gfs2_pcpu_lkstats *lks;
-	const unsigned gltype = gl->gl_name.ln_type;
+	const unsigned gltype = glock_type(gl);
 	unsigned index = blocking ? GFS2_LKS_SRTTB : GFS2_LKS_SRTT;
 	s64 rtt;
 
 	preempt_disable();
 	rtt = ktime_to_ns(ktime_sub(ktime_get_real(), gl->gl_dstamp));
-	lks = this_cpu_ptr(gl->gl_name.ln_sbd->sd_lkstats);
+	lks = this_cpu_ptr(glock_sbd(gl)->sd_lkstats);
 	gfs2_update_stats(&gl->gl_stats, index, rtt);		/* Local */
 	gfs2_update_stats(&lks->lkstats[gltype], index, rtt);	/* Global */
 	preempt_enable();
@@ -100,7 +100,7 @@ static inline void gfs2_update_reply_times(struct gfs2_glock *gl,
 static inline void gfs2_update_request_times(struct gfs2_glock *gl)
 {
 	struct gfs2_pcpu_lkstats *lks;
-	const unsigned gltype = gl->gl_name.ln_type;
+	const unsigned gltype = glock_type(gl);
 	ktime_t dstamp;
 	s64 irt;
 
@@ -108,7 +108,7 @@ static inline void gfs2_update_request_times(struct gfs2_glock *gl)
 	dstamp = gl->gl_dstamp;
 	gl->gl_dstamp = ktime_get_real();
 	irt = ktime_to_ns(ktime_sub(gl->gl_dstamp, dstamp));
-	lks = this_cpu_ptr(gl->gl_name.ln_sbd->sd_lkstats);
+	lks = this_cpu_ptr(glock_sbd(gl)->sd_lkstats);
 	gfs2_update_stats(&gl->gl_stats, GFS2_LKS_SIRT, irt);		/* Local */
 	gfs2_update_stats(&lks->lkstats[gltype], GFS2_LKS_SIRT, irt);	/* Global */
 	preempt_enable();
@@ -195,7 +195,7 @@ static void gdlm_bast(void *arg, int mode)
 		gfs2_glock_cb(gl, LM_ST_SHARED);
 		break;
 	default:
-		fs_err(gl->gl_name.ln_sbd, "unknown bast mode %d\n", mode);
+		fs_err(glock_sbd(gl), "unknown bast mode %d\n", mode);
 		BUG();
 	}
 }
@@ -276,7 +276,7 @@ static void gfs2_reverse_hex(char *c, u64 value)
 static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 		     unsigned int flags)
 {
-	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
+	struct lm_lockstruct *ls = &glock_sbd(gl)->sd_lockstruct;
 	bool blocking;
 	int cur, req;
 	u32 lkf;
@@ -284,8 +284,8 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 	int error;
 
 	gl->gl_req = req_state;
-	cur = make_mode(gl->gl_name.ln_sbd, gl->gl_state);
-	req = make_mode(gl->gl_name.ln_sbd, req_state);
+	cur = make_mode(glock_sbd(gl), gl->gl_state);
+	req = make_mode(glock_sbd(gl), req_state);
 	blocking = !down_conversion(cur, req) &&
 		   !(flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB));
 	lkf = make_flags(gl, flags, req, blocking);
@@ -296,8 +296,8 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		memset(strname, ' ', GDLM_STRNAME_BYTES - 1);
 		strname[GDLM_STRNAME_BYTES - 1] = '\0';
-		gfs2_reverse_hex(strname + 7, gl->gl_name.ln_type);
-		gfs2_reverse_hex(strname + 23, gl->gl_name.ln_number);
+		gfs2_reverse_hex(strname + 7, glock_type(gl));
+		gfs2_reverse_hex(strname + 23, glock_number(gl));
 		gl->gl_dstamp = ktime_get_real();
 	} else {
 		gfs2_update_request_times(gl);
@@ -323,7 +323,7 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 
 static void gdlm_put_lock(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	uint32_t flags = 0;
 	int error;
@@ -375,14 +375,14 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 
 	if (error) {
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
-		       gl->gl_name.ln_type,
-		       (unsigned long long)gl->gl_name.ln_number, error);
+		       glock_type(gl),
+		       (unsigned long long) glock_number(gl), error);
 	}
 }
 
 static void gdlm_cancel(struct gfs2_glock *gl)
 {
-	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
+	struct lm_lockstruct *ls = &glock_sbd(gl)->sd_lockstruct;
 
 	down_read(&ls->ls_sem);
 	if (likely(ls->ls_dlm != NULL)) {
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index df7916bf49c1..e03928def87e 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -65,15 +65,15 @@ void gfs2_pin(struct gfs2_sbd *sdp, struct buffer_head *bh)
 
 static bool buffer_is_rgrp(const struct gfs2_bufdata *bd)
 {
-	return bd->bd_gl->gl_name.ln_type == LM_TYPE_RGRP;
+	return glock_type(bd->bd_gl) == LM_TYPE_RGRP;
 }
 
 static void maybe_release_space(struct gfs2_bufdata *bd)
 {
 	struct gfs2_glock *gl = bd->bd_gl;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_rgrpd *rgd = gfs2_glock2rgrp(gl);
-	unsigned int index = bd->bd_bh->b_blocknr - gl->gl_name.ln_number;
+	unsigned int index = bd->bd_bh->b_blocknr - glock_number(gl);
 	struct gfs2_bitmap *bi = rgd->rd_bits + index;
 
 	rgrp_lock_local(rgd);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index e4356198d8d8..3c8e4553102d 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -126,7 +126,7 @@ const struct address_space_operations gfs2_rgrp_aops = {
 struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 {
 	struct address_space *mapping = gfs2_glock2aspace(gl);
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct folio *folio;
 	struct buffer_head *bh;
 	unsigned int shift;
@@ -259,7 +259,7 @@ static void gfs2_submit_bhs(blk_opf_t opf, struct buffer_head *bhs[], int num)
 int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		   int rahead, struct buffer_head **bhp)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
@@ -513,7 +513,7 @@ int gfs2_meta_buffer(struct gfs2_inode *ip, u32 mtype, u64 num,
 
 struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct buffer_head *first_bh, *bh;
 	u32 max_ra = gfs2_tune_get(sdp, gt_max_readahead) >>
 			  sdp->sd_sb.sb_bsize_shift;
diff --git a/fs/gfs2/meta_io.h b/fs/gfs2/meta_io.h
index b7c8a6684d02..2fe5dec193ed 100644
--- a/fs/gfs2/meta_io.h
+++ b/fs/gfs2/meta_io.h
@@ -43,7 +43,7 @@ static inline struct gfs2_sbd *gfs2_mapping2sbd(struct address_space *mapping)
 	if (mapping->a_ops == &gfs2_meta_aops) {
 		struct gfs2_glock_aspace *gla =
 			container_of(mapping, struct gfs2_glock_aspace, mapping);
-		return gla->glock.gl_name.ln_sbd;
+		return glock_sbd(&gla->glock);
 	} else
 		return inode->i_sb->s_fs_info;
 }
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index b1692f12a602..21dfe1e48da6 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -978,7 +978,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda,
 		gfs2_glock_dq_uninit(&ghs[qx]);
 	inode_unlock(&ip->i_inode);
 	kfree(ghs);
-	gfs2_log_flush(ip->i_gl->gl_name.ln_sbd, ip->i_gl,
+	gfs2_log_flush(glock_sbd(ip->i_gl), ip->i_gl,
 		       GFS2_LOG_HEAD_FLUSH_NORMAL | GFS2_LFC_DO_SYNC);
 	if (!error) {
 		for (x = 0; x < num_qd; x++) {
@@ -1027,7 +1027,7 @@ static int do_glock(struct gfs2_quota_data *qd, int force_refresh,
 	struct gfs2_holder i_gh;
 	int error;
 
-	gfs2_assert_warn(sdp, sdp == qd->qd_gl->gl_name.ln_sbd);
+	gfs2_assert_warn(sdp, sdp == glock_sbd(qd->qd_gl));
 restart:
 	error = gfs2_glock_nq_init(qd->qd_gl, LM_ST_SHARED, 0, q_gh);
 	if (error)
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index b14e54b38ee8..8a97ca734afc 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1923,7 +1923,7 @@ static void try_rgrp_unlink(struct gfs2_rgrpd *rgd, u64 *last_unlinked, u64 skip
 static bool gfs2_rgrp_congested(const struct gfs2_rgrpd *rgd, int loops)
 {
 	const struct gfs2_glock *gl = rgd->rd_gl;
-	const struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	const struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_lkstats *st;
 	u64 r_dcount, l_dcount;
 	u64 l_srttb, a_srttb = 0;
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index a308228d5c2d..6fd39fcdd00e 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -111,9 +111,9 @@ TRACE_EVENT(gfs2_glock_state_change,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->glnum		= gl->gl_name.ln_number;
-		__entry->gltype		= gl->gl_name.ln_type;
+		__entry->dev		= glock_sbd(gl)->sd_vfs->s_dev;
+		__entry->glnum		= glock_number(gl);
+		__entry->gltype		= glock_type(gl);
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
 		__entry->new_state	= glock_trace_state(new_state);
 		__entry->tgt_state	= glock_trace_state(gl->gl_target);
@@ -147,9 +147,9 @@ TRACE_EVENT(gfs2_glock_put,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->gltype		= gl->gl_name.ln_type;
-		__entry->glnum		= gl->gl_name.ln_number;
+		__entry->dev		= glock_sbd(gl)->sd_vfs->s_dev;
+		__entry->gltype		= glock_type(gl);
+		__entry->glnum		= glock_number(gl);
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
 		__entry->flags		= gl->gl_flags  | (gl->gl_object ? (1UL<<GLF_OBJECT) : 0);
 	),
@@ -181,9 +181,9 @@ TRACE_EVENT(gfs2_demote_rq,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->gltype		= gl->gl_name.ln_type;
-		__entry->glnum		= gl->gl_name.ln_number;
+		__entry->dev		= glock_sbd(gl)->sd_vfs->s_dev;
+		__entry->gltype		= glock_type(gl);
+		__entry->glnum		= glock_number(gl);
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
 		__entry->dmt_state	= glock_trace_state(gl->gl_demote_state);
 		__entry->flags		= gl->gl_flags  | (gl->gl_object ? (1UL<<GLF_OBJECT) : 0);
@@ -215,9 +215,9 @@ TRACE_EVENT(gfs2_promote,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->glnum	= gh->gh_gl->gl_name.ln_number;
-		__entry->gltype	= gh->gh_gl->gl_name.ln_type;
+		__entry->dev	= glock_sbd(gh->gh_gl)->sd_vfs->s_dev;
+		__entry->glnum	= glock_number(gh->gh_gl);
+		__entry->gltype	= glock_type(gh->gh_gl);
 		__entry->state	= glock_trace_state(gh->gh_state);
 	),
 
@@ -243,9 +243,9 @@ TRACE_EVENT(gfs2_glock_queue,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->glnum	= gh->gh_gl->gl_name.ln_number;
-		__entry->gltype	= gh->gh_gl->gl_name.ln_type;
+		__entry->dev	= glock_sbd(gh->gh_gl)->sd_vfs->s_dev;
+		__entry->glnum	= glock_number(gh->gh_gl);
+		__entry->gltype	= glock_type(gh->gh_gl);
 		__entry->queue	= queue;
 		__entry->state	= glock_trace_state(gh->gh_state);
 	),
@@ -282,9 +282,9 @@ TRACE_EVENT(gfs2_glock_lock_time,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = gl->gl_name.ln_sbd->sd_vfs->s_dev;
-		__entry->glnum          = gl->gl_name.ln_number;
-		__entry->gltype         = gl->gl_name.ln_type;
+		__entry->dev            = glock_sbd(gl)->sd_vfs->s_dev;
+		__entry->glnum          = glock_number(gl);
+		__entry->gltype         = glock_type(gl);
 		__entry->status		= gl->gl_lksb.sb_status;
 		__entry->flags		= gl->gl_lksb.sb_flags;
 		__entry->tdiff		= tdiff;
@@ -337,11 +337,11 @@ TRACE_EVENT(gfs2_pin,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= bd->bd_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= glock_sbd(bd->bd_gl)->sd_vfs->s_dev;
 		__entry->pin		= pin;
 		__entry->len		= bd->bd_bh->b_size;
 		__entry->block		= bd->bd_bh->b_blocknr;
-		__entry->ino		= bd->bd_gl->gl_name.ln_number;
+		__entry->ino		= glock_number(bd->bd_gl);
 	),
 
 	TP_printk("%u,%u log %s %llu/%lu inode %llu",
@@ -458,7 +458,7 @@ TRACE_EVENT(gfs2_bmap,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
 		__entry->lblock		= lblock;
 		__entry->pblock		= buffer_mapped(bh) ?  bh->b_blocknr : 0;
 		__entry->inum		= ip->i_no_addr;
@@ -494,7 +494,7 @@ TRACE_EVENT(gfs2_iomap_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->pos		= pos;
 		__entry->length		= length;
@@ -526,7 +526,7 @@ TRACE_EVENT(gfs2_iomap_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = glock_sbd(ip->i_gl)->sd_vfs->s_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->offset		= iomap->offset;
 		__entry->length		= iomap->length;
@@ -568,7 +568,7 @@ TRACE_EVENT(gfs2_block_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= rgd->rd_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= glock_sbd(rgd->rd_gl)->sd_vfs->s_dev;
 		__entry->start		= block;
 		__entry->inum		= ip->i_no_addr;
 		__entry->len		= len;
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 6df65540e13d..95f2632cdb01 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -197,7 +197,7 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
 void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 {
 	struct gfs2_trans *tr = current->journal_info;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct gfs2_bufdata *bd;
 
 	lock_buffer(bh);
@@ -255,7 +255,7 @@ void gfs2_trans_add_databufs(struct gfs2_glock *gl, struct folio *folio,
 void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 {
 
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct gfs2_sbd *sdp = glock_sbd(gl);
 	struct super_block *sb = sdp->sd_vfs;
 	struct gfs2_bufdata *bd;
 	struct gfs2_meta_header *mh;
-- 
2.52.0

