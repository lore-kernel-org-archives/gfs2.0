Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FB86657
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262276; cv=none; b=eK0cKaPAW8FrmIFa9bdzcbtUBwmVKGi7cdqz7DYArN3ER/gFKHizNpzI6hPnp3uwH5jv4hGsD2ZXi0HNfsQH+ZvoV7BgbtpZTKfhKcXYPpJ5HJN9Sftm2LAKXkLTTP6V6r0JTDVmVQPMO7BAQL2S0uw4TIb58kKDAPY5jkl3/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262276; c=relaxed/simple;
	bh=IQ2ud7zCXpLf35vgm0mKd0ctu4QhXLjOxKX/rmHdsCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSZQicmp98KarPs3jUgm1Vw3HtHTxtjtTd0xj8XxA9ccoigLEG2fq3A4Ea8+8yeA3gJYG6sJU6ATMhV+LER3HEMJ17aKbCRd97lcquKZkalKhnnyOHuzZIVoOOLuKNDZhB5g8CHSvzl4rRJgCUpqiAxlJYruP9YF3+VghHbG8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOVRnVWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOVRnVWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713262273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgxmYzuuG8ByIRknVn/LyoyOhmSpZpZRTG5RCHBgfRA=;
	b=IOVRnVWpUycD4xKb1edbDHGxj7kClo/N1VfvXwF9BjnOpzCrQhirlvCfRaQ5z6RwaDKRoN
	06gH6tHiZMk8R4YxYcR/NIAsML99h4RauX1lTgNd0MAZLm4Wf99DT1aN8D1wg1W0nJzrHw
	STaIFx3KOuZw/Ad6D59B3Elg3JuPY4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-O6okgLrHMsWmfm7u2KDA1g-1; Tue, 16 Apr 2024 06:11:12 -0400
X-MC-Unique: O6okgLrHMsWmfm7u2KDA1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D2C5801701
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7DA340B497D;
	Tue, 16 Apr 2024 10:11:11 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] gfs2: finish_xmote cleanup
Date: Tue, 16 Apr 2024 12:10:48 +0200
Message-ID: <20240416101050.636697-2-agruenba@redhat.com>
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

Currently, function finish_xmote() takes and releases the glock
spinlock.  However, all of its callers immediately take that spinlock
again, so it makes more sense to take the spin lock before calling
finish_xmote() already.

With that, thaw_glock() is the only place that sets the GLF_HAVE_REPLY
flag outside of the glock spinlock, but it also takes that spinlock
immediately thereafter.  Change that to set the bit when the spinlock is
already held.  This allows to switch from test_and_clear_bit() to
test_bit() and clear_bit() in glock_work_func().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2e81304fdf90..52d1ba7245d4 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -623,7 +623,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	struct gfs2_holder *gh;
 	unsigned state = ret & LM_OUT_ST_MASK;
 
-	spin_lock(&gl->gl_lockref.lock);
 	trace_gfs2_glock_state_change(gl, state);
 	state_change(gl, state);
 	gh = find_first_waiter(gl);
@@ -671,7 +670,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 			       gl->gl_target, state);
 			GLOCK_BUG_ON(gl, 1);
 		}
-		spin_unlock(&gl->gl_lockref.lock);
 		return;
 	}
 
@@ -694,7 +692,6 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	}
 out:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
-	spin_unlock(&gl->gl_lockref.lock);
 }
 
 static bool is_system_glock(struct gfs2_glock *gl)
@@ -841,15 +838,19 @@ __acquires(&gl->gl_lockref.lock)
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
 		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+			spin_lock(&gl->gl_lockref.lock);
 			finish_xmote(gl, target);
-			gfs2_glock_queue_work(gl, 0);
+			__gfs2_glock_queue_work(gl, 0);
+			spin_unlock(&gl->gl_lockref.lock);
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
 			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
 		}
 	} else { /* lock_nolock */
+		spin_lock(&gl->gl_lockref.lock);
 		finish_xmote(gl, target);
-		gfs2_glock_queue_work(gl, 0);
+		__gfs2_glock_queue_work(gl, 0);
+		spin_unlock(&gl->gl_lockref.lock);
 	}
 out:
 	spin_lock(&gl->gl_lockref.lock);
@@ -1106,11 +1107,12 @@ static void glock_work_func(struct work_struct *work)
 	struct gfs2_glock *gl = container_of(work, struct gfs2_glock, gl_work.work);
 	unsigned int drop_refs = 1;
 
-	if (test_and_clear_bit(GLF_REPLY_PENDING, &gl->gl_flags)) {
+	spin_lock(&gl->gl_lockref.lock);
+	if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags)) {
+		clear_bit(GLF_REPLY_PENDING, &gl->gl_flags);
 		finish_xmote(gl, gl->gl_reply);
 		drop_refs++;
 	}
-	spin_lock(&gl->gl_lockref.lock);
 	if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
 	    gl->gl_state != LM_ST_UNLOCKED &&
 	    gl->gl_demote_state != LM_ST_EXCLUSIVE) {
@@ -2181,8 +2183,11 @@ static void thaw_glock(struct gfs2_glock *gl)
 		return;
 	if (!lockref_get_not_dead(&gl->gl_lockref))
 		return;
+
+	spin_lock(&gl->gl_lockref.lock);
 	set_bit(GLF_REPLY_PENDING, &gl->gl_flags);
-	gfs2_glock_queue_work(gl, 0);
+	__gfs2_glock_queue_work(gl, 0);
+	spin_unlock(&gl->gl_lockref.lock);
 }
 
 /**
-- 
2.44.0

