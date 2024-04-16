Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AB8664D
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262277; cv=none; b=niiUwLAqwN9o7/bM5s9cBearcCgdIGzz116M9A6nAfcUlk0KPh7lpdb98FQVBKgCA8PccDVLKIZu1dzq8Cj+DX6/kOBhwbMlKo9M7axfXUGJW5WK6ErUT9MwxjBPp42hzcHpQMWitPmIULXseyTWTnigv7+Nwt8vg7MrAShjVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262277; c=relaxed/simple;
	bh=GaCsgXhOM/fD2KQzN9Xza4AMOzuPdoYdG3YThAU5M4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMOJoKG4Tj67dfn2OSx0pBOtPvAzl93CAh3xuRrRWfDvuTd3Mvr+9PBFu02a5BoqrhTaowZjmAuq0bqCM5LzntdyRBRsyRmFZCH/pfxF7De+7i/vtkDZmqge5p2Tqhy6AfWJ7mRC9DsXOMKjbp0IwjKE4XXY3FtIf+e9DT6KKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dA6LsfXY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA6LsfXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713262275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33n2F5XmJvFvLvnpC4xNm4/0EQg5npR9skXP8AEYZ7w=;
	b=dA6LsfXYHl7uQsNqNiI/eHGGb9p/0NdBpek/QKOUfMa9TApmSOCfboyS4CwaxMRt6P+PPU
	2Z8Z3nDwecfVX8DLli/92ivGz9uJYLgxdu9PAkcdV07tAbREDR3NxtYLnPMzkvjZtzM+MK
	wNE4GxHG8P7mDZ0WvHgulZp9mY4HNw0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-HsR9ROelM4C1YppT2JknKg-1; Tue,
 16 Apr 2024 06:11:13 -0400
X-MC-Unique: HsR9ROelM4C1YppT2JknKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE10A3C000A8
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:13 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33FB140B497B;
	Tue, 16 Apr 2024 10:11:13 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] gfs2: Remove and replace gfs2_glock_queue_work
Date: Tue, 16 Apr 2024 12:10:50 +0200
Message-ID: <20240416101050.636697-4-agruenba@redhat.com>
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

There are no more callers of gfs2_glock_queue_work() left, so remove
that helper.  With that, we can now rename __gfs2_glock_queue_work()
back to gfs2_glock_queue_work() to get rid of some unnecessary clutter.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index db0e960d1b33..66b084cd08e9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -272,7 +272,7 @@ static void gfs2_glock_remove_from_lru(struct gfs2_glock *gl)
  * Enqueue the glock on the work queue.  Passes one glock reference on to the
  * work queue.
  */
-static void __gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
+static void gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
 	if (!queue_delayed_work(glock_workqueue, &gl->gl_work, delay)) {
 		/*
 		 * We are holding the lockref spinlock, and the work was still
@@ -285,12 +285,6 @@ static void __gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay)
 	}
 }
 
-static void gfs2_glock_queue_work(struct gfs2_glock *gl, unsigned long delay) {
-	spin_lock(&gl->gl_lockref.lock);
-	__gfs2_glock_queue_work(gl, delay);
-	spin_unlock(&gl->gl_lockref.lock);
-}
-
 static void __gfs2_glock_put(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
@@ -335,7 +329,8 @@ void gfs2_glock_put_async(struct gfs2_glock *gl)
 	if (lockref_put_or_lock(&gl->gl_lockref))
 		return;
 
-	__gfs2_glock_queue_work(gl, 0);
+	GLOCK_BUG_ON(gl, gl->gl_lockref.count != 1);
+	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
@@ -829,7 +824,7 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 			clear_bit(GLF_LOCK, &gl->gl_flags);
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-			__gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
+			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
 			return;
 		} else {
 			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
@@ -859,7 +854,7 @@ __acquires(&gl->gl_lockref.lock)
 
 	/* Complete the operation now. */
 	finish_xmote(gl, target);
-	__gfs2_glock_queue_work(gl, 0);
+	gfs2_glock_queue_work(gl, 0);
 }
 
 /**
@@ -907,7 +902,7 @@ __acquires(&gl->gl_lockref.lock)
 	clear_bit(GLF_LOCK, &gl->gl_flags);
 	smp_mb__after_atomic();
 	gl->gl_lockref.count++;
-	__gfs2_glock_queue_work(gl, 0);
+	gfs2_glock_queue_work(gl, 0);
 	return;
 
 out_unlock:
@@ -1139,12 +1134,12 @@ static void glock_work_func(struct work_struct *work)
 		drop_refs--;
 		if (gl->gl_name.ln_type != LM_TYPE_INODE)
 			delay = 0;
-		__gfs2_glock_queue_work(gl, delay);
+		gfs2_glock_queue_work(gl, delay);
 	}
 
 	/*
 	 * Drop the remaining glock references manually here. (Mind that
-	 * __gfs2_glock_queue_work depends on the lockref spinlock begin held
+	 * gfs2_glock_queue_work depends on the lockref spinlock begin held
 	 * here as well.)
 	 */
 	gl->gl_lockref.count -= drop_refs;
@@ -1649,7 +1644,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 		     test_and_clear_bit(GLF_FROZEN, &gl->gl_flags))) {
 		set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
 		gl->gl_lockref.count++;
-		__gfs2_glock_queue_work(gl, 0);
+		gfs2_glock_queue_work(gl, 0);
 	}
 	run_queue(gl, 1);
 	spin_unlock(&gl->gl_lockref.lock);
@@ -1715,7 +1710,7 @@ static void __gfs2_glock_dq(struct gfs2_holder *gh)
 		    !test_bit(GLF_DEMOTE, &gl->gl_flags) &&
 		    gl->gl_name.ln_type == LM_TYPE_INODE)
 			delay = gl->gl_hold_time;
-		__gfs2_glock_queue_work(gl, delay);
+		gfs2_glock_queue_work(gl, delay);
 	}
 }
 
@@ -1939,7 +1934,7 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 			delay = gl->gl_hold_time;
 	}
 	handle_callback(gl, state, delay, true);
-	__gfs2_glock_queue_work(gl, delay);
+	gfs2_glock_queue_work(gl, delay);
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
@@ -1999,7 +1994,7 @@ void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 
 	gl->gl_lockref.count++;
 	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
-	__gfs2_glock_queue_work(gl, 0);
+	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
@@ -2068,7 +2063,7 @@ __acquires(&lru_lock)
 		gl->gl_lockref.count++;
 		if (demote_ok(gl))
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
-		__gfs2_glock_queue_work(gl, 0);
+		gfs2_glock_queue_work(gl, 0);
 		spin_unlock(&gl->gl_lockref.lock);
 		cond_resched_lock(&lru_lock);
 	}
@@ -2192,7 +2187,7 @@ static void thaw_glock(struct gfs2_glock *gl)
 
 	spin_lock(&gl->gl_lockref.lock);
 	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
-	__gfs2_glock_queue_work(gl, 0);
+	gfs2_glock_queue_work(gl, 0);
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
@@ -2211,7 +2206,7 @@ static void clear_glock(struct gfs2_glock *gl)
 		gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
-		__gfs2_glock_queue_work(gl, 0);
+		gfs2_glock_queue_work(gl, 0);
 	}
 	spin_unlock(&gl->gl_lockref.lock);
 }
-- 
2.44.0

