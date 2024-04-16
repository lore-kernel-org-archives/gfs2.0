Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C086659
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262277; cv=none; b=pEEoFGSztHqtNcze/uTMu/74+fmaE7ASDLLKK4Lh8VrRQjym2/lFnIQuBjiMwRdGwFNwLQJAW+wj+a5VmooXAMjczka01s66WoVSkg9LgCltM+aL/x2rDcuuk2mlxbdKasvnrQyE7IuFNdZ9+pIDR7mqvnMOqFZqAiJ0H6Z2rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262277; c=relaxed/simple;
	bh=S/BeUaBAfn38GbjXYiPoBXyVkJnDfQyibj0QU4HABQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8hA8d0mOTb0+mlW9cOhTI9WBCCpCEhx9Huu9aygDZlGR6wARLRmUkGJKEqFXRTmbo3YKRwUdvs5wPVZLtxFpr0b+zSRHI27AUSEkPASSXsI2t2CBEjNEkhJU9DrLscZYRK1UvCmkLbRdt9+0LGgcdlMimpkN6UCopbZmnZrGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqoP2y3X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqoP2y3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713262274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhMSNp0HoUMDewmeBhIUJcQK//OsqeCOn8ryeX0FeuE=;
	b=GqoP2y3X/EOxDF2ZyB7ZDYiC77rkReXSv6TvCxa0gE0Ez0t1n7EZY6mS28qiAtpTVDMdfE
	tXobVqGr/d/nvZss4NIN8Fg8hsTSbT3F0KFzac073DHiGm4DV1SoF5qmPkTHA+UW+hXTUG
	nWGI8AoMuKe4Cv2NTHxSaHmIYYz9uTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422--phQtJ2iMoGKoJCn2hAOog-1; Tue, 16 Apr 2024 06:11:13 -0400
X-MC-Unique: -phQtJ2iMoGKoJCn2hAOog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8B980021A
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7608340B497E;
	Tue, 16 Apr 2024 10:11:12 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] gfs2: do_xmote fixes
Date: Tue, 16 Apr 2024 12:10:49 +0200
Message-ID: <20240416101050.636697-3-agruenba@redhat.com>
In-Reply-To: <20240416101050.636697-1-agruenba@redhat.com>
References: <20240411135243.260020-1-agruenba@redhat.com>
 <20240416101050.636697-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Function do_xmote() is called with the glock spinlock held.  Commit
86934198eefa added a 'goto skip_inval' statement at the beginning of the
function to further below where the glock spinlock is expected not to be
held anymore.  Then it added code there that requires the glock spinlock
to be held.  This doesn't make sense; fix this up by dropping and
retaking the spinlock where needed.

In addition, when ->lm_lock() returned an error, do_xmote() didn't fail
the locking operation, and simply left the glock hanging; fix that as
well.  (This is a much older error.)

Fixes: 86934198eefa ("gfs2: Clear flags when withdraw prevents xmote")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 52d1ba7245d4..db0e960d1b33 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -719,6 +719,7 @@ __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	unsigned int lck_flags = (unsigned int)(gh ? gh->gh_flags : 0);
 	int ret;
 
@@ -747,6 +748,9 @@ __acquires(&gl->gl_lockref.lock)
 	    (gl->gl_state == LM_ST_EXCLUSIVE) ||
 	    (lck_flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB)))
 		clear_bit(GLF_BLOCKING, &gl->gl_flags);
+	if (!glops->go_inval && !glops->go_sync)
+		goto skip_inval;
+
 	spin_unlock(&gl->gl_lockref.lock);
 	if (glops->go_sync) {
 		ret = glops->go_sync(gl);
@@ -759,6 +763,7 @@ __acquires(&gl->gl_lockref.lock)
 				fs_err(sdp, "Error %d syncing glock \n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
+			spin_lock(&gl->gl_lockref.lock);
 			goto skip_inval;
 		}
 	}
@@ -779,9 +784,10 @@ __acquires(&gl->gl_lockref.lock)
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
 		clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 	}
+	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	gfs2_glock_hold(gl);
+	gl->gl_lockref.count++;
 	/*
 	 * Check for an error encountered since we called go_sync and go_inval.
 	 * If so, we can't withdraw from the glock code because the withdraw
@@ -823,37 +829,37 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 			clear_bit(GLF_LOCK, &gl->gl_flags);
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
-			goto out;
+			__gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
+			return;
 		} else {
 			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 		}
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
-		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+	if (ls->ls_ops->lm_lock) {
+		spin_unlock(&gl->gl_lockref.lock);
+		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
+		spin_lock(&gl->gl_lockref.lock);
 
-		/* lock_dlm */
-		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
 		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-			spin_lock(&gl->gl_lockref.lock);
-			finish_xmote(gl, target);
-			__gfs2_glock_queue_work(gl, 0);
-			spin_unlock(&gl->gl_lockref.lock);
+			/*
+			 * The lockspace has been released and the lock has
+			 * been unlocked implicitly.
+			 */
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
+			target = gl->gl_state | LM_OUT_ERROR;
+		} else {
+			/* The operation will be completed asynchronously. */
+			return;
 		}
-	} else { /* lock_nolock */
-		spin_lock(&gl->gl_lockref.lock);
-		finish_xmote(gl, target);
-		__gfs2_glock_queue_work(gl, 0);
-		spin_unlock(&gl->gl_lockref.lock);
 	}
-out:
-	spin_lock(&gl->gl_lockref.lock);
+
+	/* Complete the operation now. */
+	finish_xmote(gl, target);
+	__gfs2_glock_queue_work(gl, 0);
 }
 
 /**
-- 
2.44.0

