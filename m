Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236654763
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599071; cv=none; b=O0jScPpFgmGka6n3WYL+PZ1aF2hKjUdM/m3O83zK4uigZdoJQdEVoepShB2clsoA3VDbiiRDWbL0wUOB2C/GCffx+4cFAjHBR8NTQYtKvk+z4aondMMgG3EeWiaP0mYYhqEzaBOmVdKwYMtFxrsFHq4Pqf7rGeoviph+CZY53SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599071; c=relaxed/simple;
	bh=raKTnLA+4zR/hDJ6SaZEmR8Y2GKEZndyr1nRwDVCjK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Xixqw48yrv5NfkVL42EzN0Ct+08GroF4ieLrS7Md1H684xmXHViBLAQORMFMB+/z3lWW+xjNgSO2bIHmWWBtlbTyikcvLXHJ2WpmOs7k0upk5/a8o1xUCCd19pQE/WXr4RR+lgUIhxvZOURfbF+SK4OSQoCGMovGffFPbdxkahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVIMNIdZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVIMNIdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/718uZQbSKPE27Y1RoyrjlYXVYvfCykAhDsmuiGM42Y=;
	b=WVIMNIdZLe5socH/RQJfu9nkR0UhevAEI0thSn6wA8jtP9AGl+EE34G2QLOtvaz1zRLaDj
	2dTDipqkKY6qyxkP46uuOl+kaOSKWiQ/e3TaCOHblTeRAjMsHEUqn+dD9zeYiWeMzh5oFw
	90MC0VrcKBcytBD4DFqrAiRBk0fZ7Ek=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-qshYwQc4M96Hk6mXsjG-0A-1; Thu,
 11 Sep 2025 09:57:48 -0400
X-MC-Unique: qshYwQc4M96Hk6mXsjG-0A-1
X-Mimecast-MFC-AGG-ID: qshYwQc4M96Hk6mXsjG-0A_1757599067
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 544BF19774FA
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:47 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CE1A19560B1;
	Thu, 11 Sep 2025 13:57:45 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/20] gfs2: Further sanitize lock_dlm.c
Date: Thu, 11 Sep 2025 15:57:15 +0200
Message-ID: <20250911135726.657575-11-agruenba@redhat.com>
In-Reply-To: <20250911135726.657575-1-agruenba@redhat.com>
References: <20250911135726.657575-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: afcN_UZEmfXzyuH7tytvxMFQDfpkX9O3RyI6_wZFXOE_1757599067
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The gl_req field and GLF_BLOCKING flag are only relevant to gdlm_lock(),
its callback gdlm_ast(), and their helpers, so set and clear them inside
lock_dlm.c.

Also, the LM_FLAG_ANY flag is relevant to gdlm_lock(), but do_xmote()
doesn't pass that flag down to gdlm_lock() as it should.  Fix that by
passing down all the flags.

In addition, document the effect of the LM_FLAG_ANY flag on locks held
in EX mode locally.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c    |  6 ------
 fs/gfs2/glock.h    |  4 ++++
 fs/gfs2/lock_dlm.c | 26 ++++++++++++++++++--------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1ced38b9a5a2..595891015415 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -717,12 +717,6 @@ __acquires(&gl->gl_lockref.lock)
 			return;
 		do_error(gl, 0); /* Fail queued try locks */
 	}
-	gl->gl_req = target;
-	set_bit(GLF_BLOCKING, &gl->gl_flags);
-	if ((gl->gl_req == LM_ST_UNLOCKED) ||
-	    (gl->gl_state == LM_ST_EXCLUSIVE) ||
-	    (lck_flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB)))
-		clear_bit(GLF_BLOCKING, &gl->gl_flags);
 	if (!glops->go_inval && !glops->go_sync)
 		goto skip_inval;
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 9339a3bff6ee..d041b922b45e 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -68,6 +68,10 @@ enum {
  * also be granted in SHARED.  The preferred state is whichever is compatible
  * with other granted locks, or the specified state if no other locks exist.
  *
+ * In addition, when a lock is already held in EX mode locally, a SHARED or
+ * DEFERRED mode request with the LM_FLAG_ANY flag set will be granted.
+ * (The LM_FLAG_ANY flag is only use for SHARED mode requests currently.)
+ *
  * LM_FLAG_NODE_SCOPE
  * This holder agrees to share the lock within this node. In other words,
  * the glock is held in EX mode according to DLM, but local holders on the
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index cee5d199d2d8..5daaeaaaf18d 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -58,6 +58,7 @@ static inline void gfs2_update_stats(struct gfs2_lkstats *s, unsigned index,
 /**
  * gfs2_update_reply_times - Update locking statistics
  * @gl: The glock to update
+ * @blocking: The operation may have been blocking
  *
  * This assumes that gl->gl_dstamp has been set earlier.
  *
@@ -72,12 +73,12 @@ static inline void gfs2_update_stats(struct gfs2_lkstats *s, unsigned index,
  * TRY_1CB flags are set are classified as non-blocking. All
  * other DLM requests are counted as (potentially) blocking.
  */
-static inline void gfs2_update_reply_times(struct gfs2_glock *gl)
+static inline void gfs2_update_reply_times(struct gfs2_glock *gl,
+					   bool blocking)
 {
 	struct gfs2_pcpu_lkstats *lks;
 	const unsigned gltype = gl->gl_name.ln_type;
-	unsigned index = test_bit(GLF_BLOCKING, &gl->gl_flags) ?
-			 GFS2_LKS_SRTTB : GFS2_LKS_SRTT;
+	unsigned index = blocking ? GFS2_LKS_SRTTB : GFS2_LKS_SRTT;
 	s64 rtt;
 
 	preempt_disable();
@@ -119,14 +120,18 @@ static inline void gfs2_update_request_times(struct gfs2_glock *gl)
 static void gdlm_ast(void *arg)
 {
 	struct gfs2_glock *gl = arg;
+	bool blocking;
 	unsigned ret;
 
+	blocking = test_bit(GLF_BLOCKING, &gl->gl_flags);
+	gfs2_update_reply_times(gl, blocking);
+	clear_bit(GLF_BLOCKING, &gl->gl_flags);
+
 	/* If the glock is dead, we only react to a dlm_unlock() reply. */
 	if (__lockref_is_dead(&gl->gl_lockref) &&
 	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
 		return;
 
-	gfs2_update_reply_times(gl);
 	BUG_ON(gl->gl_lksb.sb_flags & DLM_SBF_DEMOTED);
 
 	if ((gl->gl_lksb.sb_flags & DLM_SBF_VALNOTVALID) && gl->gl_lksb.sb_lvbptr)
@@ -241,7 +246,7 @@ static bool down_conversion(int cur, int req)
 }
 
 static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
-		      const int cur, const int req)
+		      const int req, bool blocking)
 {
 	u32 lkf = 0;
 
@@ -274,7 +279,7 @@ static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
 		 * "upward" lock conversions or else DLM will reject the
 		 * request as invalid.
 		 */
-		if (!down_conversion(cur, req))
+		if (blocking)
 			lkf |= DLM_LKF_QUECVT;
 	}
 
@@ -294,14 +299,20 @@ static int gdlm_lock(struct gfs2_glock *gl, unsigned int req_state,
 		     unsigned int flags)
 {
 	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
+	bool blocking;
 	int cur, req;
 	u32 lkf;
 	char strname[GDLM_STRNAME_BYTES] = "";
 	int error;
 
+	gl->gl_req = req_state;
 	cur = make_mode(gl->gl_name.ln_sbd, gl->gl_state);
 	req = make_mode(gl->gl_name.ln_sbd, req_state);
-	lkf = make_flags(gl, flags, cur, req);
+	blocking = !down_conversion(cur, req) &&
+		   !(flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB));
+	lkf = make_flags(gl, flags, req, blocking);
+	if (blocking)
+		set_bit(GLF_BLOCKING, &gl->gl_flags);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	if (test_bit(GLF_INITIAL, &gl->gl_flags)) {
@@ -341,7 +352,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		return;
 	}
 
-	clear_bit(GLF_BLOCKING, &gl->gl_flags);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
-- 
2.51.0

