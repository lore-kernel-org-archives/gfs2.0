Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9D2581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956585; cv=none; b=mHaZt3pA/Zp59jM5PvQu/WLLyZHgElV1/PrCwfFmPyjoOpWIf3YzL3yVhbZGmkqB09T2gue/KyQ7nmHivlcONUIBlyC3exqfpTINktDucr0apXUY0DL/vCJI5/rwdTWhqnYBMP1Fb38kqtWv9P2s+Ap3bT/xpa26XQATBLjBfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956585; c=relaxed/simple;
	bh=QpvSw5vDl1ft4+blXxTFf7FLV0tctKbBAOqiPCqOX30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KL2puXZqqfMXWJ4TwCJc1nTBowI8aSLd/ygOVsQ2buVKXWdCw5aEhc3kYfgT8bvs7g380FwXZvyjC7SQwJR0k6z88dcNuytJUZoUF1yXLFGLN1HwmoEY//wlrVI4jBMbjYZIwqDxrlsvlvpTZkOUD/qDritO6zUlEfhysNKgEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkUTyW2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkUTyW2F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0KwHpZFK/LZvbUc/Rm8+9J0CzI4hbTeMpBAHw2Rbko=;
	b=hkUTyW2FyqIzu/bgTvbabEYIM116okreI/57pvKzV8+Uth+Nhwd3W/bJ3hTiZm5oTSiHmW
	zTEFSY1bMC5h1HeCpwAn1NSMb9gRv/q6ZCkAT0XWdQ1Nm5yZkTPppYQprUlojgwX3UoByN
	zyQcojfL61lbC3d6DnQ0WTj/hND3KWY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-eP0XE5ChM7O1Nkb_pDsx5g-1; Fri,
 31 Oct 2025 20:23:00 -0400
X-MC-Unique: eP0XE5ChM7O1Nkb_pDsx5g-1
X-Mimecast-MFC-AGG-ID: eP0XE5ChM7O1Nkb_pDsx5g_1761956579
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8025B180066C
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:59 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0AB7180035A;
	Sat,  1 Nov 2025 00:22:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 14/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (6/6)
Date: Sat,  1 Nov 2025 00:22:23 +0000
Message-ID: <20251101002234.1286383-15-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LZnpf0b-kmNKBTtGZ7emzd9zKlcAvq0BkA84p1SVafo_1761956579
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
 fs/gfs2/util.c | 127 ++-----------------------------------------------
 1 file changed, 3 insertions(+), 124 deletions(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 797613503858..4f1db097212a 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -115,30 +115,14 @@ void gfs2_freeze_unlock(struct gfs2_sbd *sdp)
 		gfs2_glock_dq_uninit(&sdp->sd_freeze_gh);
 }
 
-static void signal_our_withdraw(struct gfs2_sbd *sdp)
+static void do_withdraw(struct gfs2_sbd *sdp)
 {
-	struct gfs2_glock *live_gl = sdp->sd_live_gh.gh_gl;
-	struct inode *inode;
-	struct gfs2_inode *ip;
-	struct gfs2_glock *i_gl;
-	u64 no_formal_ino;
-	int ret = 0;
-	int tries;
-
-	if (test_bit(SDF_NORECOVERY, &sdp->sd_flags) || !sdp->sd_jdesc)
-		return;
-
 	gfs2_ail_drain(sdp); /* frees all transactions */
-	inode = sdp->sd_jdesc->jd_inode;
-	ip = GFS2_I(inode);
-	i_gl = ip->i_gl;
-	no_formal_ino = ip->i_no_formal_ino;
 
 	/*
 	 * Don't tell dlm we're bailing until we have no more buffers in the
 	 * wind. If journal had an IO error, the log code should just purge
-	 * the outstanding buffers rather than submitting new IO. Making the
-	 * file system read-only will flush the journal, etc.
+	 * the outstanding buffers rather than submitting new IO.
 	 *
 	 * During a normal unmount, gfs2_make_fs_ro calls gfs2_log_shutdown
 	 * which clears SDF_JOURNAL_LIVE. In a withdraw, we must not write
@@ -168,112 +152,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 		gfs2_gl_dq_holders(sdp);
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_lock == NULL) { /* lock_nolock */
-		if (!ret)
-			ret = -EIO;
-		goto skip_recovery;
-	}
-	/*
-	 * Drop the glock for our journal so another node can recover it.
-	 */
-	if (gfs2_holder_initialized(&sdp->sd_journal_gh)) {
-		gfs2_glock_dq_wait(&sdp->sd_journal_gh);
-		gfs2_holder_uninit(&sdp->sd_journal_gh);
-	}
-	sdp->sd_jinode_gh.gh_flags |= GL_NOCACHE;
-	gfs2_glock_dq(&sdp->sd_jinode_gh);
 	gfs2_thaw_freeze_initiator(sdp->sd_vfs);
-	wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE, TASK_UNINTERRUPTIBLE);
-
-	/*
-	 * holder_uninit to force glock_put, to force dlm to let go
-	 */
-	gfs2_holder_uninit(&sdp->sd_jinode_gh);
-
-	/*
-	 * Note: We need to be careful here:
-	 * Our iput of jd_inode will evict it. The evict will dequeue its
-	 * glock, but the glock dq will wait for the withdraw unless we have
-	 * exception code in glock_dq.
-	 */
-	iput(inode);
-	sdp->sd_jdesc->jd_inode = NULL;
-	/*
-	 * Dequeue the "live" glock, but keep a reference so it's never freed.
-	 */
-	gfs2_glock_hold(live_gl);
-	gfs2_glock_dq_wait(&sdp->sd_live_gh);
-	/*
-	 * We enqueue the "live" glock in EX so that all other nodes
-	 * get a demote request and act on it. We don't really want the
-	 * lock in EX, so we send a "try" lock with 1CB to produce a callback.
-	 */
-	fs_warn(sdp, "Requesting recovery of jid %d.\n",
-		sdp->sd_lockstruct.ls_jid);
-	gfs2_holder_reinit(LM_ST_EXCLUSIVE,
-			   LM_FLAG_TRY_1CB | LM_FLAG_RECOVER | GL_NOPID,
-			   &sdp->sd_live_gh);
-	msleep(GL_GLOCK_MAX_HOLD);
-	/*
-	 * This will likely fail in a cluster, but succeed standalone:
-	 */
-	ret = gfs2_glock_nq(&sdp->sd_live_gh);
-
-	gfs2_glock_put(live_gl); /* drop extra reference we acquired */
-
-	/*
-	 * If we actually got the "live" lock in EX mode, there are no other
-	 * nodes available to replay our journal.
-	 */
-	if (ret == 0) {
-		fs_warn(sdp, "No other mounters found.\n");
-		/*
-		 * We are about to release the lockspace.  By keeping live_gl
-		 * locked here, we ensure that the next mounter coming along
-		 * will be a "first" mounter which will perform recovery.
-		 */
-		goto skip_recovery;
-	}
-
-	/*
-	 * At this point our journal is evicted, so we need to get a new inode
-	 * for it. Once done, we need to call gfs2_find_jhead which
-	 * calls gfs2_map_journal_extents to map it for us again.
-	 *
-	 * Note that we don't really want it to look up a FREE block. The
-	 * GFS2_BLKST_FREE simply overrides a block check in gfs2_inode_lookup
-	 * which would otherwise fail because it requires grabbing an rgrp
-	 * glock, which would fail with -EIO because we're withdrawing.
-	 */
-	inode = gfs2_inode_lookup(sdp->sd_vfs, DT_UNKNOWN,
-				  sdp->sd_jdesc->jd_no_addr, no_formal_ino,
-				  GFS2_BLKST_FREE);
-	if (IS_ERR(inode)) {
-		fs_warn(sdp, "Reprocessing of jid %d failed with %ld.\n",
-			sdp->sd_lockstruct.ls_jid, PTR_ERR(inode));
-		goto skip_recovery;
-	}
-	sdp->sd_jdesc->jd_inode = inode;
-	d_mark_dontcache(inode);
-
-	/*
-	 * Now wait until recovery is complete.
-	 */
-	for (tries = 0; tries < 10; tries++) {
-		ret = check_journal_clean(sdp, sdp->sd_jdesc, false);
-		if (!ret)
-			break;
-		msleep(HZ);
-		fs_warn(sdp, "Waiting for journal recovery jid %d.\n",
-			sdp->sd_lockstruct.ls_jid);
-	}
-skip_recovery:
-	if (!ret)
-		fs_warn(sdp, "Journal recovery complete for jid %d.\n",
-			sdp->sd_lockstruct.ls_jid);
-	else
-		fs_warn(sdp, "Journal recovery skipped for jid %d until next "
-			"mount.\n", sdp->sd_lockstruct.ls_jid);
 }
 
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
@@ -303,7 +182,7 @@ void gfs2_withdraw_func(struct work_struct *work)
 
 	BUG_ON(sdp->sd_args.ar_debug);
 
-	signal_our_withdraw(sdp);
+	do_withdraw(sdp);
 
 	kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
 
-- 
2.51.0

