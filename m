Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42C41C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956586; cv=none; b=EuRDjfBn20Ck2XbRPXKhOQwoHCbnoSMuxL+b8AaTcUKuZ4O/+rVmldqPpKl+58Q10mKJ8qhyDw7tQLEDom9Mw/WDm6NIBaakfiQoCSg8j1jiHDZaPXJ2mLJatcmwA1XA0chOSCkNGJElhT1a9eq/sJqH3ahAX7Gmm/BbSGXDv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956586; c=relaxed/simple;
	bh=Kfl2x5TTNrfiGoik9d1Do/T/fqkVDcwF8RKVhD45y2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=N4crOxs8DTG3lAR2r6D8gM3Lh0jw1TATlL2oUCbkLv57036r3Bt1p/juHiRuySihB6OiHfTNQAzAt8AOU+BYwptsiODPrxjRA6CG3S3QMwFCIN/laN8Zl2RCh8naRHCoAwg36AMa+AhSbKFKt7sMv9Vr8tJVcMcXvN84yALiuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTdve+WA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTdve+WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5q3OZS9u7zjuFtmUOd+mho61hpQO/7lyCLrqIS8vHRM=;
	b=TTdve+WA2pD4CRDqzlZtQ+8qEYZH+9vlpWtI7pAEdKtWFQbO4F2zwLSxwjW+8meZSHZUE5
	lBr0tiEvQPWVniiDyFHb42VPMBuoiL479FDujdwd+7H4zHR+OGOGooa0rOa9HUZO/khl/J
	TrhsgKU66/ZHKm7lvy++aErjKASY3/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-pRSHqdHQOvanRqIK7L-dTA-1; Fri,
 31 Oct 2025 20:23:01 -0400
X-MC-Unique: pRSHqdHQOvanRqIK7L-dTA-1
X-Mimecast-MFC-AGG-ID: pRSHqdHQOvanRqIK7L-dTA_1761956581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D0719560B2
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:01 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAEC8180035A;
	Sat,  1 Nov 2025 00:22:59 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/24] Revert "gfs2: fix a deadlock on withdraw-during-mount"
Date: Sat,  1 Nov 2025 00:22:24 +0000
Message-ID: <20251101002234.1286383-16-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _zMkBNJ_Mkr0hBruB6Zu5YRn6PZuIRNCuf-vxtu5h3c_1761956581
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts commit 865cc3e9cc0b ("gfs2: fix a deadlock on
withdraw-during-mount").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 53 +++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index c8ab86e22942..26438cb08a97 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -663,16 +663,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 		clear_bit(GLF_LOCK, &gl->gl_flags);
 }
 
-static bool is_system_glock(struct gfs2_glock *gl)
-{
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
-
-	if (gl == m_ip->i_gl)
-		return true;
-	return false;
-}
-
 /**
  * do_xmote - Calls the DLM to change the state of a lock
  * @gl: The lock state
@@ -747,36 +737,29 @@ __acquires(&gl->gl_lockref.lock)
 	 * to see sd_log_error and withdraw, and in the meantime, requeue the
 	 * work for later.
 	 *
-	 * We make a special exception for some system glocks, such as the
-	 * system statfs inode glock, which needs to be granted before the
-	 * gfs2_quotad daemon can exit, and that exit needs to finish before
-	 * we can unmount the withdrawn file system.
-	 *
 	 * However, if we're just unlocking the lock (say, for unmount, when
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
 	if (glock_blocked_by_withdraw(gl) && target != LM_ST_UNLOCKED) {
-		if (!is_system_glock(gl)) {
-			request_demote(gl, LM_ST_UNLOCKED, 0, false);
-			/*
-			 * Ordinarily, we would call dlm and its callback would call
-			 * finish_xmote, which would call state_change() to the new state.
-			 * Since we withdrew, we won't call dlm, so call state_change
-			 * manually, but to the UNLOCKED state we desire.
-			 */
-			state_change(gl, LM_ST_UNLOCKED);
-			/*
-			 * We skip telling dlm to do the locking, so we won't get a
-			 * reply that would otherwise clear GLF_LOCK. So we clear it here.
-			 */
-			if (!test_bit(GLF_CANCELING, &gl->gl_flags))
-				clear_bit(GLF_LOCK, &gl->gl_flags);
-			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-			gl->gl_lockref.count++;
-			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
-			return;
-		}
+		request_demote(gl, LM_ST_UNLOCKED, 0, false);
+		/*
+		 * Ordinarily, we would call dlm and its callback would call
+		 * finish_xmote, which would call state_change() to the new state.
+		 * Since we withdrew, we won't call dlm, so call state_change
+		 * manually, but to the UNLOCKED state we desire.
+		 */
+		state_change(gl, LM_ST_UNLOCKED);
+		/*
+		 * We skip telling dlm to do the locking, so we won't get a
+		 * reply that would otherwise clear GLF_LOCK. So we clear it here.
+		 */
+		if (!test_bit(GLF_CANCELING, &gl->gl_flags))
+			clear_bit(GLF_LOCK, &gl->gl_flags);
+		clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
+		gl->gl_lockref.count++;
+		gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
+		return;
 	}
 
 	if (ls->ls_ops->lm_lock) {
-- 
2.51.0

