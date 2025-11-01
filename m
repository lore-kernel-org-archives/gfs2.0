Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA941D5174
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956576; cv=none; b=YY1HM6PCA/jKj+m0pBNquJRzoroNsOEoJPRhrKyeSqMtR4oyoYPbJxw95v0avSVkyTJOIthfDECqH4o64JcWQ8VzgJW3rZJsP09ETdBy+utSWVa4s6d/I/V/hSDP04lJSYufPXmFeecfGcSHQmURfj4qD9HMNyoHvw1Y6zQ0gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956576; c=relaxed/simple;
	bh=dVkeQTwdlW6rcrQDoVrUyvMG0ofXtXmgJ0O4zt/kG10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HoaIlMp4j00cToclpgLQynsOfecJ/m6Iny7wV9tBUL5fhTL00AJOdUh2JUc+BYObUpyEO80Ia7M+uHHov5/mN5U43NiHU2d0hufAZNVE7ogzTy/6ogea01hhRFQ8FoN8y9cWUwjACm+GvfIzA3VzqdUxWwWGZ4b82IfOMrFJrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOCXKdSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOCXKdSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXJpXSBX0CQ4H6W1JSgCMdfgHWg2TotC+khODYZKLek=;
	b=GOCXKdSGmF3rnQErrP+QD/4A5uW2vraTx6qC7dXxocQegpf1fRXdGk2dRLyjBcH6SA6fPK
	PuxDKCCHeWIIJpFNQ/Krx4X4RPLrPARz+PjZEZgegPWYcpzYeA83bMkSLXg6A9Jg3BzmvZ
	GCmanKp601IEuj4/De3Y/njJ9OwQGMo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-wbFYUahvOWuDoVRPbWI4KQ-1; Fri,
 31 Oct 2025 20:22:51 -0400
X-MC-Unique: wbFYUahvOWuDoVRPbWI4KQ-1
X-Mimecast-MFC-AGG-ID: wbFYUahvOWuDoVRPbWI4KQ_1761956571
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E02519560B7
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:51 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 116BE18004D8;
	Sat,  1 Nov 2025 00:22:49 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (1/6)
Date: Sat,  1 Nov 2025 00:22:18 +0000
Message-ID: <20251101002234.1286383-10-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6rcG8ZMVB97TOURF_J4Cwppss5I55PoctLPnAl7Rq1M_1761956571
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
 fs/gfs2/glock.c      | 23 +----------------------
 fs/gfs2/incore.h     |  4 ----
 fs/gfs2/ops_fstype.c |  1 -
 fs/gfs2/sys.c        |  2 --
 fs/gfs2/util.c       |  7 -------
 5 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1b0f47e694f3..0601c55c1dc5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -757,9 +757,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (glock_blocked_by_withdraw(gl) &&
-	    (target != LM_ST_UNLOCKED ||
-	     test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags))) {
+	if (glock_blocked_by_withdraw(gl) && target != LM_ST_UNLOCKED) {
 		if (!is_system_glock(gl)) {
 			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 			/*
@@ -1639,7 +1637,6 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 void gfs2_glock_dq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
 	spin_lock(&gl->gl_lockref.lock);
 	if (!gfs2_holder_queued(gh)) {
@@ -1666,24 +1663,6 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 			goto out;
 	}
 
-	/*
-	 * If we're in the process of file system withdraw, we cannot just
-	 * dequeue any glocks until our journal is recovered, lest we introduce
-	 * file system corruption. We need two exceptions to this rule: We need
-	 * to allow unlocking of nondisk glocks and the glock for our own
-	 * journal that needs recovery.
-	 */
-	if (test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags) &&
-	    glock_blocked_by_withdraw(gl) &&
-	    gh->gh_gl != sdp->sd_jinode_gl) {
-		sdp->sd_glock_dqs_held++;
-		spin_unlock(&gl->gl_lockref.lock);
-		might_sleep();
-		wait_on_bit(&sdp->sd_flags, SDF_WITHDRAW_RECOVERY,
-			    TASK_UNINTERRUPTIBLE);
-		spin_lock(&gl->gl_lockref.lock);
-	}
-
 	__gfs2_glock_dq(gh);
 out:
 	spin_unlock(&gl->gl_lockref.lock);
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 7886a4452daf..191a5fcc5d74 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -600,8 +600,6 @@ enum {
 	SDF_FORCE_AIL_FLUSH     = 9,
 	SDF_FREEZE_INITIATOR	= 10,
 	SDF_REMOTE_WITHDRAW	= 13, /* Performing remote recovery */
-	SDF_WITHDRAW_RECOVERY	= 14, /* Wait for journal recovery when we are
-					 withdrawing */
 	SDF_KILL		= 15,
 	SDF_EVICTING		= 16,
 	SDF_FROZEN		= 17,
@@ -760,7 +758,6 @@ struct gfs2_sbd {
 	struct gfs2_jdesc *sd_jdesc;
 	struct gfs2_holder sd_journal_gh;
 	struct gfs2_holder sd_jinode_gh;
-	struct gfs2_glock *sd_jinode_gl;
 
 	struct gfs2_holder sd_sc_gh;
 	struct buffer_head *sd_sc_bh;
@@ -845,7 +842,6 @@ struct gfs2_sbd {
 
 	unsigned long sd_last_warning;
 	struct dentry *debugfs_dir;    /* debugfs directory */
-	unsigned long sd_glock_dqs_held;
 };
 
 #define GFS2_BAD_INO 1
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6be5f61d7541..e8e2ed783c7b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -754,7 +754,6 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		}
 
 		ip = GFS2_I(sdp->sd_jdesc->jd_inode);
-		sdp->sd_jinode_gl = ip->i_gl;
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
 					   LM_FLAG_RECOVER | GL_EXACT |
 					   GL_NOCACHE | GL_NOPID,
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 80389fc167a6..a829fb9023d9 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -85,7 +85,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     "FS Freeze Initiator:      %d\n"
 		     "FS Frozen:                %d\n"
 		     "Remote Withdraw:          %d\n"
-		     "Withdraw Recovery:        %d\n"
 		     "Killing:                  %d\n"
 		     "sd_log_error:             %d\n"
 		     "sd_log_flush_lock:        %d\n"
@@ -116,7 +115,6 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 		     test_bit(SDF_FREEZE_INITIATOR, &f),
 		     test_bit(SDF_FROZEN, &f),
 		     test_bit(SDF_REMOTE_WITHDRAW, &f),
-		     test_bit(SDF_WITHDRAW_RECOVERY, &f),
 		     test_bit(SDF_KILL, &f),
 		     sdp->sd_log_error,
 		     rwsem_is_locked(&sdp->sd_log_flush_lock),
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index da7e4e5037b2..3ffcba4fbbd4 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -134,8 +134,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	i_gl = ip->i_gl;
 	no_formal_ino = ip->i_no_formal_ino;
 
-	/* Prevent any glock dq until withdraw recovery is complete */
-	set_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
 	/*
 	 * Don't tell dlm we're bailing until we have no more buffers in the
 	 * wind. If journal had an IO error, the log code should just purge
@@ -173,7 +171,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	if (sdp->sd_lockstruct.ls_ops->lm_lock == NULL) { /* lock_nolock */
 		if (!ret)
 			ret = -EIO;
-		clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
 		goto skip_recovery;
 	}
 	/*
@@ -233,7 +230,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	ret = gfs2_glock_nq(&sdp->sd_live_gh);
 
 	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
-	clear_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags);
 
 	/*
 	 * If we actually got the "live" lock in EX mode, there are no other
@@ -288,9 +284,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	else
 		fs_warn(sdp, "Journal recovery skipped for jid %d until next "
 			"mount.\n", sdp->sd_lockstruct.ls_jid);
-	fs_warn(sdp, "Glock dequeues delayed: %lu\n", sdp->sd_glock_dqs_held);
-	sdp->sd_glock_dqs_held = 0;
-	wake_up_bit(&sdp->sd_flags, SDF_WITHDRAW_RECOVERY);
 }
 
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
-- 
2.51.0

