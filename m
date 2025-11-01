Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7807E105
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956599; cv=none; b=cnQ4WDChkBeFxnC9WSUQES24iXmhnB0B6s7LbfBXUcsEKPetr1COYirQ34VHw3OpUhbdoKsg4DLa0B/3H7VP0uc9zNiK1R0XIY9lB+dJJY3zHoO6qLzCQ/RcowCMRNNFtK5glV8uN66Ylsm/l8tkEy6LYCbtsott4mu4r1DA1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956599; c=relaxed/simple;
	bh=gaTVt3u6BrGBEdp4EFXAKFTzDaGSL5lKb7DxYFYZTcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jmHa2Ufiax58TQYmOsbG+qGfUa44LOjLndi2Q0Tb+PDPucOdSs8LKu9KockfJUxTjERNGz/wVTlLjDcOh1bMmuAyHDVQvz0DbwVLBfGoviudUd0veOnI6T1zEbuqE0EuYSys4EdLP3iwkBjrbRJ9MBJ/94c4JNGfjLl5WA1zPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GK33+q1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK33+q1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD5B3KfGqD+mgBAHA9W9XPojAoj/eWs9wiyAquVGcU4=;
	b=GK33+q1T3HfaHbwkMkloYlqKlRQgLruF9x3C3By7sgPe7zUu4nrLt8naW40Y0VbQlTlpZ5
	PRYblhSHEx5MTVrYDRc42OUf47kJWU+EnAXBubmkZ7aT8hoKioEhGEFGiV5FWB4wIqc4+P
	LOCVEDbViyAirUusd3IFcJzpZwgQKBw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-i4q2q0BfNia4MsHAjwbJCg-1; Fri,
 31 Oct 2025 20:23:15 -0400
X-MC-Unique: i4q2q0BfNia4MsHAjwbJCg-1
X-Mimecast-MFC-AGG-ID: i4q2q0BfNia4MsHAjwbJCg_1761956595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE84418002C0
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:14 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4268180035A;
	Sat,  1 Nov 2025 00:23:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 24/24] gfs2: Clean up SDF_JOURNAL_LIVE flag handling
Date: Sat,  1 Nov 2025 00:22:33 +0000
Message-ID: <20251101002234.1286383-25-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: C71MOULPEXSiCX3_GCukVoqC6gOLdGpdX6yenbzvNiY_1761956595
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change do_withdraw() to clear the SDF_JOURNAL_LIVE flag under the log
flush lock.  In addition, change __gfs2_trans_begin() to check if the
filesystem is already known to be withdrawn using gfs2_withdrawn().
Then, once we are holding the log flush lock, check if the
SDF_JOURNAL_LIVE flag is still set.  This second check ensures that the
filesystem will remain live until the transaction is submitted.

With these changes, it is no longer useful to clear SDF_JOURNAL_LIVE in
gfs2_end_log_write() after calling gfs2_withdraw().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/lops.c  |  3 ---
 fs/gfs2/trans.c | 23 ++++++++++++++---------
 fs/gfs2/util.c  | 43 +++++++++++++++++++------------------------
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 84ee34843b77..878c99e0cab3 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -210,9 +210,6 @@ static void gfs2_end_log_write(struct bio *bio)
 			fs_err(sdp, "Error %d writing to journal, jid=%u\n",
 			       err, sdp->sd_jdesc->jd_jid);
 		gfs2_withdraw(sdp);
-		/* prevent more writes to the journal */
-		clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
-		wake_up(&sdp->sd_logd_waitq);
 	}
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 1cce8e0f85da..6df65540e13d 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -49,7 +49,7 @@ int __gfs2_trans_begin(struct gfs2_trans *tr, struct gfs2_sbd *sdp,
 	}
 	BUG_ON(blocks == 0 && revokes == 0);
 
-	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
+	if (gfs2_withdrawn(sdp))
 		return -EROFS;
 
 	tr->tr_ip = ip;
@@ -85,25 +85,30 @@ int __gfs2_trans_begin(struct gfs2_trans *tr, struct gfs2_sbd *sdp,
 	 */
 
 	down_read(&sdp->sd_log_flush_lock);
+	if (unlikely(!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)))
+		goto out_not_live;
 	if (gfs2_log_try_reserve(sdp, tr, &extra_revokes))
 		goto reserved;
+
 	up_read(&sdp->sd_log_flush_lock);
 	gfs2_log_reserve(sdp, tr, &extra_revokes);
 	down_read(&sdp->sd_log_flush_lock);
-
-reserved:
-	gfs2_log_release_revokes(sdp, extra_revokes);
 	if (unlikely(!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))) {
-		gfs2_log_release_revokes(sdp, tr->tr_revokes);
-		up_read(&sdp->sd_log_flush_lock);
+		revokes = tr->tr_revokes + extra_revokes;
+		gfs2_log_release_revokes(sdp, revokes);
 		gfs2_log_release(sdp, tr->tr_reserved);
-		sb_end_intwrite(sdp->sd_vfs);
-		return -EROFS;
+		goto out_not_live;
 	}
 
+reserved:
+	gfs2_log_release_revokes(sdp, extra_revokes);
 	current->journal_info = tr;
-
 	return 0;
+
+out_not_live:
+	up_read(&sdp->sd_log_flush_lock);
+	sb_end_intwrite(sdp->sd_vfs);
+	return -EROFS;
 }
 
 int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index b8ce04338b24..02603200846d 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -117,35 +117,30 @@ void gfs2_freeze_unlock(struct gfs2_sbd *sdp)
 
 static void do_withdraw(struct gfs2_sbd *sdp)
 {
+	down_write(&sdp->sd_log_flush_lock);
+	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		up_write(&sdp->sd_log_flush_lock);
+		return;
+	}
+	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
+	up_write(&sdp->sd_log_flush_lock);
+
 	gfs2_ail_drain(sdp); /* frees all transactions */
 
-	/*
-	 * Don't tell dlm we're bailing until we have no more buffers in the
-	 * wind. If journal had an IO error, the log code should just purge
-	 * the outstanding buffers rather than submitting new IO.
-	 *
-	 * During a normal unmount, gfs2_make_fs_ro calls gfs2_log_shutdown
-	 * which clears SDF_JOURNAL_LIVE. In a withdraw, we must not write
-	 * any UNMOUNT log header, so we can't call gfs2_log_shutdown, and
-	 * therefore we need to clear SDF_JOURNAL_LIVE manually.
-	 */
-	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
-	if (!sb_rdonly(sdp->sd_vfs)) {
-		wake_up(&sdp->sd_logd_waitq);
-		wake_up(&sdp->sd_quota_wait);
+	wake_up(&sdp->sd_logd_waitq);
+	wake_up(&sdp->sd_quota_wait);
 
-		wait_event_timeout(sdp->sd_log_waitq,
-				   gfs2_log_is_empty(sdp),
-				   HZ * 5);
+	wait_event_timeout(sdp->sd_log_waitq,
+			   gfs2_log_is_empty(sdp),
+			   HZ * 5);
 
-		sdp->sd_vfs->s_flags |= SB_RDONLY;
+	sdp->sd_vfs->s_flags |= SB_RDONLY;
 
-		/*
-		 * Dequeue any pending non-system glock holders that can no
-		 * longer be granted because the file system is withdrawn.
-		 */
-		gfs2_withdraw_glocks(sdp);
-	}
+	/*
+	 * Dequeue any pending non-system glock holders that can no
+	 * longer be granted because the file system is withdrawn.
+	 */
+	gfs2_withdraw_glocks(sdp);
 }
 
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
-- 
2.51.0

