Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314B1D5CD4
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956588; cv=none; b=I0z8UatP0nxXsrzkahvWtXh6EGJse83q1X/w/+gBudkX99y5L+gWXnssYNdabt4R1Z+nT0bYcOs2OV5677qRgC3HK4QjFaRvsSF8t4lLITVf5lVfeOx3cAxBXX95KwpVy0eHXayyoybHo5JrxIaKJIWVfHnsCpK9X26jXDGWekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956588; c=relaxed/simple;
	bh=Uj/oxjiEmliSZoE//XY0ejDVeT9gMuVXgu3OB0Ht9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mrt9CPkKSV84D49KexgYb/0Edqe1Ulz8FGpJRHs26fBJIA9Lg+bFnY4jALH5zDQ8fAAKErpNcLuKrzjY3vGH7bNx++gH/l40WE6vtEmKUtL650SK1LoIVXPbD9mLT/qLxM1Pu1qjy595DRcEImLegbKz/oivJlzQS+GWJtyGgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSlk0Ic4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSlk0Ic4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdYK4H57WIegIfRtoZt8jQJRoRZl123Vohp1KTR1b5g=;
	b=ZSlk0Ic4YX2w/GmwsKwf4lgww0WF/zC0UP52tiPj+Q5562D4pz86SQmpm2IZa9+JWNlM2u
	EBik2Uf85/BRNiPasAkMasCrRfqNSWkK409VFgBhOz1oUTfxhz/vD0HLWt1wNlRUvvSv7Y
	ody+OKRfzJGsKNT6R6Dy3pujQO1E4xw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-ZAwPPODWMraADcGyQXKNeQ-1; Fri,
 31 Oct 2025 20:23:04 -0400
X-MC-Unique: ZAwPPODWMraADcGyQXKNeQ-1
X-Mimecast-MFC-AGG-ID: ZAwPPODWMraADcGyQXKNeQ_1761956584
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16A8D1956080
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:04 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AC471800579;
	Sat,  1 Nov 2025 00:23:02 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 17/24] Revert "gfs2: Allow some glocks to be used during withdraw"
Date: Sat,  1 Nov 2025 00:22:26 +0000
Message-ID: <20251101002234.1286383-18-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -ylXR8318QZatcawEz88Y3C0ALdMswAUtZmZ1eYR_wI_1761956584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts commit a72d2401f54b ("gfs2: Allow some glocks to be used during
withdraw").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 37 +++++--------------------------------
 fs/gfs2/glops.c      |  8 +-------
 fs/gfs2/incore.h     |  3 ---
 fs/gfs2/ops_fstype.c |  4 ----
 4 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 439ed14260ce..3637aa3df7c5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -137,33 +137,6 @@ static void gfs2_glock_dealloc(struct rcu_head *rcu)
 		kmem_cache_free(gfs2_glock_cachep, gl);
 }
 
-/**
- * glock_blocked_by_withdraw - determine if we can still use a glock
- * @gl: the glock
- *
- * We need to allow some glocks to be enqueued, dequeued, promoted, and demoted
- * when we're withdrawn. For example, to maintain metadata integrity, we should
- * disallow the use of inode and rgrp glocks when withdrawn. Other glocks like
- * the iopen or freeze glock may be safely used because none of their
- * metadata goes through the journal. So in general, we should disallow all
- * glocks that are journaled, and allow all the others. One exception is:
- * we need to allow our active journal to be promoted and demoted so others
- * may recover it and we can reacquire it when they're done.
- */
-static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
-{
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
-	if (!gfs2_withdrawn(sdp))
-		return false;
-	if (gl->gl_ops->go_flags & GLOF_NONDISK)
-		return false;
-	if (!sdp->sd_jdesc ||
-	    gl->gl_name.ln_number == sdp->sd_jdesc->jd_no_addr)
-		return false;
-	return true;
-}
-
 static void __gfs2_glock_free(struct gfs2_glock *gl)
 {
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
@@ -681,7 +654,7 @@ __acquires(&gl->gl_lockref.lock)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int ret;
 
-	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl))
+	if (target != LM_ST_UNLOCKED && gfs2_withdrawn(sdp))
 		goto skip_inval;
 
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
@@ -725,7 +698,7 @@ __acquires(&gl->gl_lockref.lock)
 	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	if (glock_blocked_by_withdraw(gl) && target != LM_ST_UNLOCKED) {
+	if (gfs2_withdrawn(sdp) && target != LM_ST_UNLOCKED) {
 		request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		/*
 		 * Ordinarily, we would call dlm and its callback would call
@@ -1503,9 +1476,10 @@ static inline void add_to_queue(struct gfs2_holder *gh)
 int gfs2_glock_nq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	int error;
 
-	if (glock_blocked_by_withdraw(gl))
+	if (gfs2_withdrawn(sdp))
 		return -EIO;
 
 	if (gh->gh_flags & GL_NOBLOCK) {
@@ -2113,8 +2087,7 @@ static void dump_glock_func(struct gfs2_glock *gl)
 static void withdraw_dq(struct gfs2_glock *gl)
 {
 	spin_lock(&gl->gl_lockref.lock);
-	if (!__lockref_is_dead(&gl->gl_lockref) &&
-	    glock_blocked_by_withdraw(gl))
+	if (!__lockref_is_dead(&gl->gl_lockref))
 		do_error(gl, LM_OUT_ERROR); /* remove pending waiters */
 	spin_unlock(&gl->gl_lockref.lock);
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 088c474847ee..232bd4310ebc 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -639,7 +639,6 @@ static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 
 const struct gfs2_glock_operations gfs2_meta_glops = {
 	.go_type = LM_TYPE_META,
-	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_inode_glops = {
@@ -665,35 +664,30 @@ const struct gfs2_glock_operations gfs2_freeze_glops = {
 	.go_xmote_bh = freeze_go_xmote_bh,
 	.go_callback = freeze_go_callback,
 	.go_type = LM_TYPE_NONDISK,
-	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_iopen_glops = {
 	.go_type = LM_TYPE_IOPEN,
 	.go_callback = iopen_go_callback,
 	.go_dump = inode_go_dump,
-	.go_flags = GLOF_NONDISK,
 	.go_subclass = 1,
 };
 
 const struct gfs2_glock_operations gfs2_flock_glops = {
 	.go_type = LM_TYPE_FLOCK,
-	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_nondisk_glops = {
 	.go_type = LM_TYPE_NONDISK,
-	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations gfs2_quota_glops = {
 	.go_type = LM_TYPE_QUOTA,
-	.go_flags = GLOF_LVB | GLOF_NONDISK,
+	.go_flags = GLOF_LVB,
 };
 
 const struct gfs2_glock_operations gfs2_journal_glops = {
 	.go_type = LM_TYPE_JOURNAL,
-	.go_flags = GLOF_NONDISK,
 };
 
 const struct gfs2_glock_operations *gfs2_glops_list[] = {
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index bcc39969094b..7a6ad36413d1 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -228,7 +228,6 @@ struct gfs2_glock_operations {
 	const unsigned long go_flags;
 #define GLOF_ASPACE 1 /* address space attached */
 #define GLOF_LVB    2 /* Lock Value Block attached */
-#define GLOF_NONDISK   8 /* not I/O related */
 };
 
 enum {
@@ -518,8 +517,6 @@ struct gfs2_jdesc {
 
 	struct list_head jd_revoke_list;
 	unsigned int jd_replay_tail;
-
-	u64 jd_no_addr;
 };
 
 struct gfs2_statfs_change_host {
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 19ef5bc93723..71c327f6fadc 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -542,8 +542,6 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 	mutex_lock(&sdp->sd_jindex_mutex);
 
 	for (;;) {
-		struct gfs2_inode *jip;
-
 		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, ji_gh);
 		if (error)
 			break;
@@ -584,8 +582,6 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 		d_mark_dontcache(jd->jd_inode);
 		spin_lock(&sdp->sd_jindex_spin);
 		jd->jd_jid = sdp->sd_journals++;
-		jip = GFS2_I(jd->jd_inode);
-		jd->jd_no_addr = jip->i_no_addr;
 		list_add_tail(&jd->jd_list, &sdp->sd_jindex_list);
 		spin_unlock(&sdp->sd_jindex_spin);
 	}
-- 
2.51.0

