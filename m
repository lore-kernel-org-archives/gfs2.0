Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C323191BD
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181753; cv=none; b=dHGWylLQVDnZDwCE9l7A2ywHTDoRtmuyLsA9Di5W/g/j30k/7ZaS7gnPLFeifpFym4g9m3k4+Z/P9T1CKKA6sI84hnngiO4a/uFwPQa7BNw85nn5WqMXH7Smxw+8bX1lJA7BzGQU1QFIiNE3mK47Cp6xiqeKP2LXBqzDwmrtP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181753; c=relaxed/simple;
	bh=N99WCd8KPn8fIwtVdCIU4CldlctrYy5zD12UUboG3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=TflB+RwbO+JtXEaNLbSp7xuOpWYf4olTK3/gQfeV2yzKnzkXkvNT84wt+nUwU1FiXDDVNB1IFYEt0Y6bG0k4Y1dKRtbGJTs1Oe0LtEhiHcmW3MiY1rqGvxMUAIzGQlM/QtwtJDc1CLZt27bbmoMPkvQlLTOTguuROq+Wpq87siM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XurtX4mg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XurtX4mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788181750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/IlmXUiF1SFHS+RQU/SK+e2FPSW8VzzbUE+zJdRGQRU=;
	b=XurtX4mge9fZx4AEhHlKI8d3OLjtJwuJOximR2VGS1ki+mrKQMUKGkCK4s9daB+AUAuyBQ
	osZvcKH5KDV2+rvUtImMm/L+PNJ6aE4CUM22FOyti/PB8Ato5l/VCvEaUhLN8Njsdm3yMe
	mFT2hMeBGuJyY3k2gscjCzeIflntJQE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-ftvgYeIEOwCDp5f1Z2GfWA-1; Mon,
 31 Aug 2026 09:09:06 -0400
X-MC-Unique: ftvgYeIEOwCDp5f1Z2GfWA-1
X-Mimecast-MFC-AGG-ID: ftvgYeIEOwCDp5f1Z2GfWA_1788181745
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 602FA18052CE
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 13:09:05 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.6])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F2AE40E;
	Mon, 31 Aug 2026 13:09:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Get rid of sd_async_glock_wait
Date: Mon, 31 Aug 2026 15:09:03 +0200
Message-ID: <20260831130903.572605-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VTTEl7_YCUMTU6kfjXvf_ONg-UgbjwO998pPDSOL8ps_1788181745
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Get rid of the per-superblock wait queue for asynchronous locking requests.
Instead, wait for the specific events we are interested in.  Use multiple wait
queue entries when waiting for multiple events at once.

Without this patch, the per-superblock wait queue for asynchronous locking
requests can become a bottleneck when many inodes are deleted remotely: in that
case, we schedule delayed work with gfs2_queue_verify_delete().  When that work
later runs, we end up in delete_work_func() -> iput() -> gfs2_evict_inode() ->
gfs2_upgrade_iopen_glock(), which uses asynchronous locking.  Each completing
locking asynchronous request will wake up sdp->sd_async_glock_wait, and all the
waiters will compete with each other and waste resources.  Avoid that by
eliminating the per-superblock wait queue.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 56 ++++++++++++++++++++++++++++++--------------
 fs/gfs2/incore.h     |  1 -
 fs/gfs2/ops_fstype.c |  1 -
 fs/gfs2/super.c      | 30 ++++++++++++++++++++----
 4 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d0612014408e..d22a088c66cd 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -329,11 +329,6 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
 	clear_bit(HIF_WAIT, &gh->gh_iflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&gh->gh_iflags, HIF_WAIT);
-	if (gh->gh_flags & GL_ASYNC) {
-		struct gfs2_sbd *sdp = glock_sbd(gh->gh_gl);
-
-		wake_up(&sdp->sd_async_glock_wait);
-	}
 }
 
 /**
@@ -512,11 +507,9 @@ static void state_change(struct gfs2_glock *gl, unsigned int new_state)
 
 static void gfs2_set_demote(int nr, struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = glock_sbd(gl);
-
 	set_bit(nr, &gl->gl_flags);
-	smp_mb();
-	wake_up(&sdp->sd_async_glock_wait);
+	smp_mb__after_atomic();
+	wake_up_bit(&gl->gl_flags, GLF_DEMOTE);
 }
 
 static void gfs2_demote_wake(struct gfs2_glock *gl)
@@ -1272,11 +1265,14 @@ static int glocks_pending(unsigned int num_gh, struct gfs2_holder *ghs)
 int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			  unsigned int retries)
 {
-	struct gfs2_sbd *sdp = glock_sbd(ghs[0].gh_gl);
 	unsigned long start_time = jiffies;
-	int i, ret = 0;
-	long timeout;
+	struct wait_queue_head *waitq[4];
+	struct wait_queue_entry wait[4];
+	long ret, timeout;
+	int i;
 
+	BUILD_BUG_ON(ARRAY_SIZE(waitq) != ARRAY_SIZE(wait));
+	BUG_ON(num_gh > ARRAY_SIZE(wait));
 	might_sleep();
 
 	timeout = GL_GLOCK_MIN_HOLD;
@@ -1294,14 +1290,38 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		timeout += (incr / 3) + get_random_long() % (incr / 3);
 	}
 
-	if (!wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
-				!glocks_pending(num_gh, ghs), timeout)) {
-		ret = -ESTALE; /* request timed out. */
-		goto out;
+	ret = timeout;
+	for (i = 0; i < num_gh; i++) {
+		waitq[i] = bit_waitqueue(&ghs[i].gh_iflags, HIF_WAIT);
+		init_wait(wait + i);
+	}
+	for (;;) {
+		for (i = 0; i < num_gh; i++)
+			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
+		if (!glocks_pending(num_gh, ghs))
+			break;
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+		ret = schedule_timeout(ret);
+		if (!glocks_pending(num_gh, ghs))
+			break;
+		if (!ret) {
+			ret = -ESTALE; /* request timed out. */
+			break;
+		}
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
-	if (signal_pending(current))
-		goto interrupted;
+	for (i = 0; i < num_gh; i++)
+		finish_wait(waitq[i], wait + i);
+	if (ret < 0)
+		goto out;
 
+	ret = 0;
 	for (i = 0; i < num_gh; i++) {
 		struct gfs2_holder *gh = &ghs[i];
 		int ret2;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 0a48f8e8ed6c..49cc232942a2 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -716,7 +716,6 @@ struct gfs2_sbd {
 	struct work_struct sd_freeze_work;
 	struct work_struct sd_withdraw_work;
 	wait_queue_head_t sd_kill_wait;
-	wait_queue_head_t sd_async_glock_wait;
 	atomic_t sd_glock_disposal;
 	struct completion sd_locking_init;
 	struct completion sd_withdraw_helper;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 188b3e67f2d1..6ec47376aecf 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -90,7 +90,6 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	gfs2_tune_init(&sdp->sd_tune);
 
 	init_waitqueue_head(&sdp->sd_kill_wait);
-	init_waitqueue_head(&sdp->sd_async_glock_wait);
 	atomic_set(&sdp->sd_glock_disposal, 0);
 	init_completion(&sdp->sd_locking_init);
 	init_completion(&sdp->sd_withdraw_helper);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index af8c71576833..f8297c58e491 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1180,8 +1180,10 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 {
 	struct gfs2_glock *gl = gfs2_inode_glock(inode);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *gh = &ip->i_iopen_gh;
+	struct wait_queue_head *holder_waitq, *glock_waitq;
+	struct wait_queue_entry holder_wait, glock_wait;
+	long ret = 5 * HZ;
 	int error;
 
 	gh->gh_flags |= GL_NOCACHE;
@@ -1212,10 +1214,28 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 	if (error)
 		return EVICT_SHOULD_SKIP_DELETE;
 
-	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
-		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
-		glock_needs_demote(gl),
-		5 * HZ);
+	holder_waitq = bit_waitqueue(&gh->gh_iflags, HIF_WAIT);
+	glock_waitq = bit_waitqueue(&gl->gl_flags, GLF_DEMOTE);
+	init_wait(&holder_wait);
+	init_wait(&glock_wait);
+	for (;;) {
+		prepare_to_wait(holder_waitq, &holder_wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(glock_waitq, &glock_wait, TASK_INTERRUPTIBLE);
+		if (!test_bit(HIF_WAIT, &gh->gh_iflags) ||
+		    glock_needs_demote(gl))
+			break;
+		if (signal_pending(current))
+			break;
+		ret = schedule_timeout(ret);
+		if (!test_bit(HIF_WAIT, &gh->gh_iflags) ||
+		    glock_needs_demote(gl))
+			break;
+		if (signal_pending(current))
+			break;
+	}
+	finish_wait(holder_waitq, &holder_wait);
+	finish_wait(glock_waitq, &glock_wait);
+
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
 		if (glock_needs_demote(gl))
-- 
2.55.0

