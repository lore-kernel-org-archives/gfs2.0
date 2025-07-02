Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411452D46CD
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469947; cv=none; b=U1wOo7mrrm7agvxNKQ+kgDbXbE11Wvlf19prPS0ojiJCE68TJ2NJ23BcJJIcbU/+1+kmsxyx9/wUgcu3rWExkjotN8e5X7zjMSY/j6EMT4OmxjaBPL68PNm4nWlWDV85pAgHNM2JBVloi4N4oRHaoENxzs/OlRSCs7D32Mc8uLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469947; c=relaxed/simple;
	bh=oL8wMXvszuBhV9WJJAGSNCSdzouztwX/FpCQTPsj5F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iULKPIVG7S/YoV7q1ukFgK9ExmteF72EHm/bPwCuwiBmNmzs1n8xfRHilI8x15bDEzwNl1b/hIm/wAf2ApuH6zY3qjXAycG6oqFAR2m0t3VV419GUWjA+SuDrnNaon4JWaE1/ONFqV1c++lulZ6Wzuc4s4D2btAHd9wb57Ex2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbJWQDHt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbJWQDHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751469944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uw8bTkxWvtyQz2rA46IMr86o1LBLGfvfEdjaVtFriU=;
	b=SbJWQDHtIoBr25VkRNEJx8vwq6GmtVdeL9ND941XVT/zM0le0jHWTXS1DsaYA7phFFekCd
	amxdcARVfSgtg69SrQz1PZI8oFiiLBsjrG9qelJyhXgMedgQ2DbL/NEn6u8Ypd6YENLwY7
	OTluW3v/8Ya8KYjzRxqfyufSrADhcUI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-wMUFLDfHO6SAZR6ifZpQ6g-1; Wed,
 02 Jul 2025 11:25:42 -0400
X-MC-Unique: wMUFLDfHO6SAZR6ifZpQ6g-1
X-Mimecast-MFC-AGG-ID: wMUFLDfHO6SAZR6ifZpQ6g_1751469942
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16DD41944A82
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 15:25:42 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3DC11956087;
	Wed,  2 Jul 2025 15:25:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Price <anprice@redhat.com>
Subject: [PATCH 1/3] gfs2: sanitize the gdlm_ast -> finish_xmote interface
Date: Wed,  2 Jul 2025 17:25:34 +0200
Message-ID: <20250702152537.21742-2-agruenba@redhat.com>
In-Reply-To: <20250702152537.21742-1-agruenba@redhat.com>
References: <20250702152537.21742-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3pizw3_eomNwxhrl4LhbJo0wj0GUY8ySQDdMpuiNQ5A_1751469942
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When gdlm_ast() is called with a non-zero status code, this means that
the requested operation did not succeed and the current lock state
didn't change.  Turn that into a non-zero LM_OUT_* status code (with ret
& ~LM_OUT_ST_MASK != 0) instead of pretending that dlm returned the
now-current lock state.

Similarly, in do_xmote(), don't pretend that the current lock state
changed when ->lm_lock() fails.

That way, we can change finish_xmote() to only update gl->gl_state when
dlm has actually replied with the lock's new current state.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andrew Price <anprice@redhat.com>
---
 fs/gfs2/glock.c    | 31 +++++++++++++++++++------------
 fs/gfs2/glock.h    | 10 ++++++++++
 fs/gfs2/lock_dlm.c |  9 ++++++---
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index ba25b884169e..5dfb89475894 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -590,20 +590,25 @@ static void gfs2_demote_wake(struct gfs2_glock *gl)
 static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
-	struct gfs2_holder *gh;
-	unsigned state = ret & LM_OUT_ST_MASK;
 
-	trace_gfs2_glock_state_change(gl, state);
-	state_change(gl, state);
-	gh = find_first_waiter(gl);
+	if (!(ret & ~LM_OUT_ST_MASK)) {
+		unsigned state = ret & LM_OUT_ST_MASK;
+
+		trace_gfs2_glock_state_change(gl, state);
+		state_change(gl, state);
+	}
+
 
 	/* Demote to UN request arrived during demote to SH or DF */
 	if (test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags) &&
-	    state != LM_ST_UNLOCKED && gl->gl_demote_state == LM_ST_UNLOCKED)
+	    gl->gl_state != LM_ST_UNLOCKED &&
+	    gl->gl_demote_state == LM_ST_UNLOCKED)
 		gl->gl_target = LM_ST_UNLOCKED;
 
 	/* Check for state != intended state */
-	if (unlikely(state != gl->gl_target)) {
+	if (unlikely(gl->gl_state != gl->gl_target)) {
+		struct gfs2_holder *gh = find_first_waiter(gl);
+
 		if (gh && (ret & LM_OUT_CANCELED))
 			gfs2_holder_wake(gh);
 		if (gh && !test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags)) {
@@ -629,7 +634,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 				goto out;
 			}
 		}
-		switch(state) {
+		switch(gl->gl_state) {
 		/* Unlocked due to conversion deadlock, try again */
 		case LM_ST_UNLOCKED:
 			do_xmote(gl, gh, gl->gl_target);
@@ -640,8 +645,10 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			do_xmote(gl, gh, LM_ST_UNLOCKED);
 			break;
 		default: /* Everything else */
-			fs_err(gl->gl_name.ln_sbd, "wanted %u got %u\n",
-			       gl->gl_target, state);
+			fs_err(gl->gl_name.ln_sbd,
+			       "glock %u:%llu wanted=%u ret=%u\n",
+			       gl->gl_name.ln_type, gl->gl_name.ln_number,
+			       gl->gl_target, ret);
 			GLOCK_BUG_ON(gl, 1);
 		}
 		return;
@@ -650,7 +657,7 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	/* Fast path - we got what we asked for */
 	if (test_and_clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags))
 		gfs2_demote_wake(gl);
-	if (state != LM_ST_UNLOCKED) {
+	if (gl->gl_state != LM_ST_UNLOCKED) {
 		if (glops->go_xmote_bh) {
 			int rv;
 
@@ -826,7 +833,7 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			target = gl->gl_state | LM_OUT_ERROR;
+			target = LM_OUT_ERROR;
 		} else {
 			/* The operation will be completed asynchronously. */
 			return;
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index c171f745650f..9339a3bff6ee 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -92,12 +92,22 @@ enum {
  * LM_OUT_ST_MASK
  * Masks the lower two bits of lock state in the returned value.
  *
+ * LM_OUT_TRY_AGAIN
+ * The trylock request failed.
+ *
+ * LM_OUT_DEADLOCK
+ * The lock request failed because it would deadlock.
+ *
  * LM_OUT_CANCELED
  * The lock request was canceled.
  *
+ * LM_OUT_ERROR
+ * The lock request timed out or failed.
  */
 
 #define LM_OUT_ST_MASK		0x00000003
+#define LM_OUT_TRY_AGAIN	0x00000020
+#define LM_OUT_DEADLOCK		0x00000010
 #define LM_OUT_CANCELED		0x00000008
 #define LM_OUT_ERROR		0x00000004
 
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 7cb9d216d8bb..cee5d199d2d8 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -119,7 +119,7 @@ static inline void gfs2_update_request_times(struct gfs2_glock *gl)
 static void gdlm_ast(void *arg)
 {
 	struct gfs2_glock *gl = arg;
-	unsigned ret = gl->gl_state;
+	unsigned ret;
 
 	/* If the glock is dead, we only react to a dlm_unlock() reply. */
 	if (__lockref_is_dead(&gl->gl_lockref) &&
@@ -139,13 +139,16 @@ static void gdlm_ast(void *arg)
 		gfs2_glock_free(gl);
 		return;
 	case -DLM_ECANCEL: /* Cancel while getting lock */
-		ret |= LM_OUT_CANCELED;
+		ret = LM_OUT_CANCELED;
 		goto out;
 	case -EAGAIN: /* Try lock fails */
+		ret = LM_OUT_TRY_AGAIN;
+		goto out;
 	case -EDEADLK: /* Deadlock detected */
+		ret = LM_OUT_DEADLOCK;
 		goto out;
 	case -ETIMEDOUT: /* Canceled due to timeout */
-		ret |= LM_OUT_ERROR;
+		ret = LM_OUT_ERROR;
 		goto out;
 	case 0: /* Success */
 		break;
-- 
2.50.0

