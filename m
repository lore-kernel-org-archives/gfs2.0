Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F811C75E2
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956571; cv=none; b=lBRyDf5qpm8BQ2dWdJtuq0bcOAOqSXU2wcEhkKMrRte0n7uJujqk4ar9GLMX7pjDcuLStv/r0BXne31XbNdlhNnLmF+p7OZom7J6cDcDtk38FmhHYOYxdR1OyGqHc/6qz4ckw2WOLS41R3cc5LkHaDCoBaaZrFLTRWeAe3rp398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956571; c=relaxed/simple;
	bh=wuyUJwIZfr1npEOZCl+9ArmAFzPr4n4Zyq98TD0iKJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gcSc7G3n0EZ9ZOdzYnPM+reJ1K0ti9L9RQ3X7APji550gYyX10BIlaS9/dPep6ivm7hJ95zpmXMYUtJFVvhRSf56uXWJ9jvnzzIc4dqrH8uza65ndSAmxIImMAzw5c2jUDKy+U+iLWF6RWHrQDJi4r25xEsWmwyvZD43m+XINto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkl2l0gF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkl2l0gF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1PxMuz8fdkzZTuefHfrlDjAPK8TD4MYpSnniE6m9yY=;
	b=Jkl2l0gF8iKqhS29a6i9/aSfCaD/KraUL+6y0gEqULOMS/+5mYlXL/K5ZA/4Ou8H7y5IBV
	kWm8Xl+/Y5qlJ9Ul4thWPcTMGdOEdIhv7gWNX8ti8dbu4phpKtLKGVXDCGjKLnTf0UXhir
	xs6zu9Lm6I7jeG7PsdMkWwo5/j73Er4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-g4Tp-6YPN6C_0tsAbhtCuQ-1; Fri,
 31 Oct 2025 20:22:45 -0400
X-MC-Unique: g4Tp-6YPN6C_0tsAbhtCuQ-1
X-Mimecast-MFC-AGG-ID: g4Tp-6YPN6C_0tsAbhtCuQ_1761956565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC6921956096
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:44 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D134218004D8;
	Sat,  1 Nov 2025 00:22:43 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 05/24] gfs2: Withdraw immediately on log write errors
Date: Sat,  1 Nov 2025 00:22:14 +0000
Message-ID: <20251101002234.1286383-6-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jNJ2TkefXuInGVyjQUFJNeHfcj4C37lPFcMfoVMfd-8_1761956565
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that gfs2_withdraw() is asynchronous, immediately withdraw when
a log write error is detected.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c |  4 ++--
 fs/gfs2/log.c   | 12 ------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 691bcb96325a..3be366bd6e01 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -710,6 +710,7 @@ __acquires(&gl->gl_lockref.lock)
 		if (cmpxchg(&sdp->sd_log_error, 0, ret)) {
 			fs_err(sdp, "Error %d syncing glock\n", ret);
 			gfs2_dump_glock(NULL, gl, true);
+			gfs2_withdraw(sdp);
 		}
 		spin_lock(&gl->gl_lockref.lock);
 		goto skip_inval;
@@ -728,6 +729,7 @@ __acquires(&gl->gl_lockref.lock)
 			gfs2_glock_assert_warn(gl,
 					       !atomic_read(&gl->gl_ail_count));
 			gfs2_dump_glock(NULL, gl, true);
+			gfs2_withdraw(sdp);
 		}
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
 	}
@@ -755,8 +757,6 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawn(sdp))
-		gfs2_withdraw(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
 	     test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags))) {
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index b97da7f4d3f8..69734e18b23d 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1299,17 +1299,6 @@ int gfs2_logd(void *data)
 		if (gfs2_withdrawn(sdp))
 			break;
 
-		/* Check for errors writing to the journal */
-		if (sdp->sd_log_error) {
-			gfs2_lm(sdp,
-				"GFS2: fsid=%s: error %d: "
-				"withdrawing the file system to "
-				"prevent further damage.\n",
-				sdp->sd_fsname, sdp->sd_log_error);
-			gfs2_withdraw(sdp);
-			break;
-		}
-
 		if (gfs2_jrnl_flush_reqd(sdp) || t == 0) {
 			gfs2_ail1_empty(sdp, 0);
 			gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_NORMAL |
@@ -1332,7 +1321,6 @@ int gfs2_logd(void *data)
 				test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
-				sdp->sd_log_error ||
 				gfs2_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
-- 
2.51.0

