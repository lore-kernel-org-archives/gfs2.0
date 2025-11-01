Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646D2581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956579; cv=none; b=p8PCHDbqYJXb48SLbhut3A/RWnKWNuCunuquXEtIsnw0hHcRWO9u39B14+1Ws1JfP+sWUwtVKaqcOz6O2qz32o9o7GgZSUsiU08bJrVCTgjBzSWVqZ39sGDgYlE41GceA3TTpn7hfiObTSuHgD/1GcM4YoRCzUYquI7nwHoac68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956579; c=relaxed/simple;
	bh=0jBmwDAHEWhInwRazABixUdarj2nrTmWD1eronuiBow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=f2fu8BJ7zmZNlsrA+j57QgnFQQShhzoXc+XJCfJzmfJcGkHp3pTuozVvPUZ4AHqIwqfB0xvpBRGaAHrb2HcbPIZ2nQmEjRYPlGf8uVZe/EEcWPZZ1yFW2BUM0joOtbqtRLhughJfX7Mah3Ro414c2ixreKagtBtylbcJBL0jjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCY0GgX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCY0GgX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWB90cFRRXr0EHUWmxx+vcUKhflOGtUR8Qgoe8qdCfo=;
	b=cCY0GgX6VJ282EvxqVGsULhCKaNyqQxuzsEN0n3QEPmHhTBShKkSOv0egCW8JfOzGjGgzy
	XvyIVQ0CQ4TJBQ1mM1untPC13kGzJdwHCgdM+nm9qOZlXHo+z6c5Aa9vRkJrKz5VNJ2Tgl
	N/d87h5LC1M/cJUPqRzz96Wxsx1iW3g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-AAZjMAUtMWC71n0ukhqWkQ-1; Fri,
 31 Oct 2025 20:22:55 -0400
X-MC-Unique: AAZjMAUtMWC71n0ukhqWkQ-1
X-Mimecast-MFC-AGG-ID: AAZjMAUtMWC71n0ukhqWkQ_1761956574
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 310DF1956088
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:54 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2583418004D8;
	Sat,  1 Nov 2025 00:22:52 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (3/6)
Date: Sat,  1 Nov 2025 00:22:20 +0000
Message-ID: <20251101002234.1286383-12-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 7AS5_-6Yf0kVljLpsyF-m_kYrKK3f2l5R0Bw_MjBL_I_1761956574
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts parts of commit 601ef0d52e96 ("gfs2: Force withdraw to replay
journals and wait for it to finish").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c    | 52 ----------------------------------------------
 fs/gfs2/incore.h   |  1 -
 fs/gfs2/lock_dlm.c | 31 ---------------------------
 fs/gfs2/sys.c      |  2 --
 4 files changed, 86 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 5564edd3b1b3..088c474847ee 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -30,8 +30,6 @@
 
 struct workqueue_struct *gfs2_freeze_wq;
 
-extern struct workqueue_struct *gfs2_control_wq;
-
 static void gfs2_ail_error(struct gfs2_glock *gl, const struct buffer_head *bh)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
@@ -639,55 +637,6 @@ static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 	}
 }
 
-/**
- * nondisk_go_callback - used to signal when a node did a withdraw
- * @gl: the nondisk glock
- * @remote: true if this came from a different cluster node
- *
- */
-static void nondisk_go_callback(struct gfs2_glock *gl, bool remote)
-{
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
-	/* Ignore the callback unless it's from another node, and it's the
-	   live lock. */
-	if (!remote || gl->gl_name.ln_number != GFS2_LIVE_LOCK)
-		return;
-
-	/* First order of business is to cancel the demote request. We don't
-	 * really want to demote a nondisk glock. At best it's just to inform
-	 * us of another node's withdraw. We'll keep it in SH mode. */
-	clear_bit(GLF_DEMOTE, &gl->gl_flags);
-	clear_bit(GLF_PENDING_DEMOTE, &gl->gl_flags);
-
-	/* Ignore the unlock if we're withdrawn, unmounting, or in recovery. */
-	if (test_bit(SDF_NORECOVERY, &sdp->sd_flags) ||
-	    test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
-	    test_bit(SDF_REMOTE_WITHDRAW, &sdp->sd_flags))
-		return;
-
-	/* We only care when a node wants us to unlock, because that means
-	 * they want a journal recovered. */
-	if (gl->gl_demote_state != LM_ST_UNLOCKED)
-		return;
-
-	if (sdp->sd_args.ar_spectator) {
-		fs_warn(sdp, "Spectator node cannot recover journals.\n");
-		return;
-	}
-
-	fs_warn(sdp, "Some node has withdrawn; checking for recovery.\n");
-	set_bit(SDF_REMOTE_WITHDRAW, &sdp->sd_flags);
-	/*
-	 * We can't call remote_withdraw directly here or gfs2_recover_journal
-	 * because this is called from the glock unlock function and the
-	 * remote_withdraw needs to enqueue and dequeue the same "live" glock
-	 * we were called from. So we queue it to the control work queue in
-	 * lock_dlm.
-	 */
-	queue_delayed_work(gfs2_control_wq, &sdp->sd_control_work, 0);
-}
-
 const struct gfs2_glock_operations gfs2_meta_glops = {
 	.go_type = LM_TYPE_META,
 	.go_flags = GLOF_NONDISK,
@@ -735,7 +684,6 @@ const struct gfs2_glock_operations gfs2_flock_glops = {
 const struct gfs2_glock_operations gfs2_nondisk_glops = {
 	.go_type = LM_TYPE_NONDISK,
 	.go_flags = GLOF_NONDISK,
-	.go_callback = nondisk_go_callback,
 };
 
 const struct gfs2_glock_operations gfs2_quota_glops = {
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index c72c06d9e77c..bcc39969094b 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -597,7 +597,6 @@ enum {
 	SDF_SKIP_DLM_UNLOCK	= 8,
 	SDF_FORCE_AIL_FLUSH     = 9,
 	SDF_FREEZE_INITIATOR	= 10,
-	SDF_REMOTE_WITHDRAW	= 13, /* Performing remote recovery */
 	SDF_KILL		= 15,
 	SDF_EVICTING		= 16,
 	SDF_FROZEN		= 17,
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index a118f71adb00..b8d249925395 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -15,7 +15,6 @@
 #include <linux/sched/signal.h>
 
 #include "incore.h"
-#include "recovery.h"
 #include "util.h"
 #include "sys.h"
 #include "trace_gfs2.h"
@@ -395,7 +394,6 @@ static void gdlm_cancel(struct gfs2_glock *gl)
 /*
  * dlm/gfs2 recovery coordination using dlm_recover callbacks
  *
- *  0. gfs2 checks for another cluster node withdraw, needing journal replay
  *  1. dlm_controld sees lockspace members change
  *  2. dlm_controld blocks dlm-kernel locking activity
  *  3. dlm_controld within dlm-kernel notifies gfs2 (recover_prep)
@@ -653,28 +651,6 @@ static int control_lock(struct gfs2_sbd *sdp, int mode, uint32_t flags)
 			 &ls->ls_control_lksb, "control_lock");
 }
 
-/**
- * remote_withdraw - react to a node withdrawing from the file system
- * @sdp: The superblock
- */
-static void remote_withdraw(struct gfs2_sbd *sdp)
-{
-	struct gfs2_jdesc *jd;
-	int ret = 0, count = 0;
-
-	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
-		if (jd->jd_jid == sdp->sd_lockstruct.ls_jid)
-			continue;
-		ret = gfs2_recover_journal(jd, true);
-		if (ret)
-			break;
-		count++;
-	}
-
-	/* Now drop the additional reference we acquired */
-	fs_err(sdp, "Journals checked: %d, ret = %d.\n", count, ret);
-}
-
 static void gfs2_control_func(struct work_struct *work)
 {
 	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_control_work.work);
@@ -685,13 +661,6 @@ static void gfs2_control_func(struct work_struct *work)
 	int recover_size;
 	int i, error;
 
-	/* First check for other nodes that may have done a withdraw. */
-	if (test_bit(SDF_REMOTE_WITHDRAW, &sdp->sd_flags)) {
-		remote_withdraw(sdp);
-		clear_bit(SDF_REMOTE_WITHDRAW, &sdp->sd_flags);
-		return;
-	}
-
 	spin_lock(&ls->ls_recover_spin);
 	/*
 	 * No MOUNT_DONE means we're still mounting; control_mount()
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index a829fb9023d9..db3bc4aee875 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -84,7 +84,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "Force AIL Flush:          %d\n"
 		     "FS Freeze Initiator:      %d\n"
 		     "FS Frozen:                %d\n"
-		     "Remote Withdraw:          %d\n"
 		     "Killing:                  %d\n"
 		     "sd_log_error:             %d\n"
 		     "sd_log_flush_lock:        %d\n"
@@ -114,7 +113,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_FORCE_AIL_FLUSH, &f),
 		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_FROZEN, &f),
-		     test_bit(SDF_REMOTE_WITHDRAW, &f),
 		     test_bit(SDF_KILL, &f),
 		     sdp->sd_log_error,
 		     rwsem_is_locked(&sdp->sd_log_flush_lock),
-- 
2.51.0

