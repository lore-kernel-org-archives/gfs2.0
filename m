Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04E41C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956593; cv=none; b=a38n714r6VNoUnoTOcipOOspkFypVlyt+u5S6Wu+DWK/RgDwDpF5SzWLYB7AH4SI1jKuCj0RXikKVsZg9pZfGDpwhn4vmqjbP2r028oKZOUjW4HN7s5+HinIsxL5RdHtUSK3JizIsL4JVuFYK9kQXU5jC7JM5LsK65W5ueM3VnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956593; c=relaxed/simple;
	bh=7axmp94pJjI6GBFF/seFh99LY/plEJkGFp7s3OLi5iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=q2AvcICOuuiC5kRrRDrQLcZmGkHLg42DU3dyeMNdvR8n6uFLsxuwXkvrZ+F0lhQDxe9bEyMLtWNMlmsWvTQOfNl81eBnH9VlMK80ilD5IlTn+trwnEx7y2M+K39Lt2ezjtp8sP5coq496gkYq8aA/qsq+O4QJu1kX/HuaATF9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiQqsFrL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiQqsFrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncRdqeop+xO8VFSrQFaTYd/Y8/iGrLn92JhX36Y41NI=;
	b=CiQqsFrLGphVXvYGfjnZGk60JIufk2FKuo0HfvQIGetQHaYMCZv4qAQuSd0Ls+zk7TLjja
	eOb+v3QS6ubTopvMVdsi8ShvBaEB/fGJUoitFuRQMPh4RSe/hHOngD0wyaqvCUl7xH5HtW
	EAgz63YysSZv5zz0Jk/dghlPdFZo6qI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-tqO33dUOO12hYVD6bICqow-1; Fri,
 31 Oct 2025 20:23:09 -0400
X-MC-Unique: tqO33dUOO12hYVD6bICqow-1
X-Mimecast-MFC-AGG-ID: tqO33dUOO12hYVD6bICqow_1761956588
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA56195609F
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:08 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2B71180035A;
	Sat,  1 Nov 2025 00:23:07 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 20/24] gfs2: Clean up properly during a withdraw
Date: Sat,  1 Nov 2025 00:22:29 +0000
Message-ID: <20251101002234.1286383-21-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VBGfnDsOyOEJK3qB5XksFtHoj1UclHSAE5ur8dwgwKc_1761956588
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

During a withdraw, we don't want to write out any more data than we have
to, so in do_xmote(), skip the ->go_sync() glock operation.  We still
want to keep calling ->go_inval() to discard any cached data or
metadata, whether clean or dirty.

We do still allow glocks to transition into state LM_ST_UNLOCKED.  This
has the desired side effect of calling ->go_inval() and invalidating the
glock caches.

Function gfs2_withdraw_glocks() is already used for dequeuing any
left-over waiters.  We still want that to happen, but additionally, we
want all glocks to be unlocked.

Finally, we change function do_promote() to refuse any further
promotions.

This commit cleans up the leftovers of commit 86934198eefa ("gfs2: Clear
flags when withdraw prevents xmote").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 83 +++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 7c20750e482d..bc6f236b899c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -458,8 +458,12 @@ int gfs2_instantiate(struct gfs2_holder *gh)
 
 static void do_promote(struct gfs2_glock *gl)
 {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct gfs2_holder *gh, *current_gh;
 
+	if (gfs2_withdrawn(sdp))
+		return;
+
 	current_gh = find_first_holder(gl);
 	list_for_each_entry(gh, &gl->gl_holders, gh_list) {
 		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
@@ -565,7 +569,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 		state_change(gl, state);
 	}
 
-
 	/* Demote to UN request arrived during demote to SH or DF */
 	if (test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
@@ -654,28 +657,36 @@ __acquires(&gl->gl_lockref.lock)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int ret;
 
-	if (target != LM_ST_UNLOCKED && gfs2_withdrawn(sdp))
-		goto skip_inval;
+	/*
+	 * When a filesystem is withdrawing, the remaining cluster nodes will
+	 * take care of recovering the withdrawing node's journal.  We only
+	 * need to make sure that once we trigger remote recovery, we won't
+	 * write to the shared block device anymore.  This means that here,
+	 *
+	 * - no new writes to the filesystem must be triggered (->go_sync()).
+	 *
+	 * - any cached data should be discarded by calling ->go_inval(), dirty
+	 *   or not and journaled or unjournaled.
+	 *
+	 * - no more dlm locking operations should be issued (->lm_lock()).
+	 */
 
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
 	GLOCK_BUG_ON(gl, gl->gl_state == gl->gl_target);
+
 	if (!glops->go_inval || !glops->go_sync)
 		goto skip_inval;
 
 	spin_unlock(&gl->gl_lockref.lock);
-	ret = glops->go_sync(gl);
-	/* If we had a problem syncing (due to io errors or whatever,
-	 * we should not invalidate the metadata or tell dlm to
-	 * release the glock to other nodes.
-	 */
-	if (ret) {
-		if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
-			fs_err(sdp, "Error %d syncing glock\n", ret);
-			gfs2_dump_glock(NULL, gl, true);
-			gfs2_withdraw(sdp);
+	if (!gfs2_withdrawn(sdp)) {
+		ret = glops->go_sync(gl);
+		if (ret) {
+			if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
+				fs_err(sdp, "Error %d syncing glock\n", ret);
+				gfs2_dump_glock(NULL, gl, true);
+				gfs2_withdraw(sdp);
+			}
 		}
-		spin_lock(&gl->gl_lockref.lock);
-		goto skip_inval;
 	}
 
 	if (target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED)
@@ -683,25 +694,10 @@ __acquires(&gl->gl_lockref.lock)
 	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	if (gfs2_withdrawn(sdp) && target != LM_ST_UNLOCKED) {
-		request_demote(gl, LM_ST_UNLOCKED, 0, false);
-		/*
-		 * Ordinarily, we would call dlm and its callback would call
-		 * finish_xmote, which would call state_change() to the new state.
-		 * Since we withdrew, we won't call dlm, so call state_change
-		 * manually, but to the UNLOCKED state we desire.
-		 */
-		state_change(gl, LM_ST_UNLOCKED);
-		/*
-		 * We skip telling dlm to do the locking, so we won't get a
-		 * reply that would otherwise clear GLF_LOCK. So we clear it here.
-		 */
-		if (!test_bit(GLF_CANCELING, &gl->gl_flags))
-			clear_bit(GLF_LOCK, &gl->gl_flags);
-		clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-		gl->gl_lockref.count++;
-		gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
-		return;
+	if (gfs2_withdrawn(sdp)) {
+		if (target != LM_ST_UNLOCKED)
+			target = LM_OUT_ERROR;
+		goto out;
 	}
 
 	if (ls->ls_ops->lm_lock) {
@@ -717,12 +713,15 @@ __acquires(&gl->gl_lockref.lock)
 		}
 		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 
-		if (ret == -ENODEV && gl->gl_target == LM_ST_UNLOCKED &&
-		    target == LM_ST_UNLOCKED) {
+		if (ret == -ENODEV) {
 			/*
 			 * The lockspace has been released and the lock has
 			 * been unlocked implicitly.
 			 */
+			if (target != LM_ST_UNLOCKED) {
+				target = LM_OUT_ERROR;
+				goto out;
+			}
 		} else {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
 			GLOCK_BUG_ON(gl, !gfs2_withdrawn(sdp));
@@ -730,6 +729,7 @@ __acquires(&gl->gl_lockref.lock)
 		}
 	}
 
+out:
 	/* Complete the operation now. */
 	finish_xmote(gl, target);
 	gl->gl_lockref.count++;
@@ -2072,8 +2072,17 @@ static void dump_glock_func(struct gfs2_glock *gl)
 static void withdraw_glock(struct gfs2_glock *gl)
 {
 	spin_lock(&gl->gl_lockref.lock);
-	if (!__lockref_is_dead(&gl->gl_lockref))
+	if (!__lockref_is_dead(&gl->gl_lockref)) {
+		/*
+		 * We don't want to write back any more dirty data.  Unlock the
+		 * remaining inode and resource group glocks; this will cause
+		 * their ->go_inval() hooks to toss out all the remaining
+		 * cached data, dirty or not.
+		 */
+		if (gl->gl_ops->go_inval && gl->gl_state != LM_ST_UNLOCKED)
+			request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		do_error(gl, LM_OUT_ERROR); /* remove pending waiters */
+	}
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
-- 
2.51.0

