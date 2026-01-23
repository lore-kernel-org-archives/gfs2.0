Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50E19C553
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182276; cv=none; b=iALSlJdr1NstKzgvz6DIU85kRaoiPYuUNLQ+qfSOV33yxQCTsJ9EP6eH6lTbsDzb+71OrfsScAJhhAhmJeGsa/RHVyfdTR+yx2VBpJic5PsNQK0PGHwosGlUcqi6Dezao/TG54kAjSxYU8dZ3j9OSHdfn8aqeUEIQFP2Hiep7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182276; c=relaxed/simple;
	bh=f6hK82yS5mGMGM6uMeRq8kL7MuQmUtgeq4aLodz1lbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AXgDgHGDrOka5PHBrtSdHjj0eeeozGVc02t9bBK8tJ2WM6LsSARypNkcHjawaP3sjiJBmq5J268aow5PlqCTD6aJ8ay2zAKZEqCpKKySWJLszwCuRnvhe3A7KrcsO3zhLw8DHGuPWIkA9V7rqkSlRZnZa9V5xvL+KNcJzcFdzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYTDqUPq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYTDqUPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769182274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieI96Gtuv8srwQyyssWYHpiIm9UIhxIX7uftbRettj8=;
	b=bYTDqUPqh6mVpcHCQVXpPER55q8IruoYZRJ/WT3x98wUP42HXGU+DZHcibsNp6GR5hW/6l
	WMxIPAMm0X935mvO5q3W91bIz5MiXREuQ1325OwIyEVa72nfYMKQpTV+W092Dld4w40mtF
	ZL7ei62uoEEdg2+5xlnc7gCmyFnxZ5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-rrVCaL4lORuEFYa-bBWc6A-1; Fri,
 23 Jan 2026 10:31:13 -0500
X-MC-Unique: rrVCaL4lORuEFYa-bBWc6A-1
X-Mimecast-MFC-AGG-ID: rrVCaL4lORuEFYa-bBWc6A_1769182272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21E4718005B2
	for <gfs2@lists.linux.dev>; Fri, 23 Jan 2026 15:31:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EF2130002DC;
	Fri, 23 Jan 2026 15:31:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/13] gfs2: run_queue cleanup
Date: Fri, 23 Jan 2026 16:30:53 +0100
Message-ID: <20260123153105.797382-4-agruenba@redhat.com>
In-Reply-To: <20260123153105.797382-1-agruenba@redhat.com>
References: <20260123153105.797382-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9lbHOzJ0_le4Y5fMTItQjuDmihTXfr_Knr0ihMHJxU0_1769182272
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In run_queue(), instead of always setting the GLF_LOCK flag, only set it
when the flag is actually needed.  This avoids having to undo the flag
setting later.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index f358448d7b3d..776179933315 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -753,13 +753,10 @@ __acquires(&gl->gl_lockref.lock)
 
 	if (test_bit(GLF_LOCK, &gl->gl_flags))
 		return;
-	set_bit(GLF_LOCK, &gl->gl_flags);
 
 	/*
-	 * The GLF_DEMOTE_IN_PROGRESS flag is only set intermittently during
-	 * locking operations.  We have just started a locking operation by
-	 * setting the GLF_LOCK flag, so the GLF_DEMOTE_IN_PROGRESS flag must
-	 * be cleared.
+	 * The GLF_DEMOTE_IN_PROGRESS flag must only be set when the GLF_LOCK
+	 * flag is set as well.
 	 */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
@@ -770,12 +767,13 @@ __acquires(&gl->gl_lockref.lock)
 		}
 
 		if (find_first_holder(gl))
-			goto out_unlock;
+			return;
 		if (nonblock)
 			goto out_sched;
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
+		set_bit(GLF_LOCK, &gl->gl_flags);
 		do_xmote(gl, NULL, gl->gl_target);
 		return;
 	}
@@ -783,26 +781,22 @@ __acquires(&gl->gl_lockref.lock)
 promote:
 	do_promote(gl);
 	if (find_first_holder(gl))
-		goto out_unlock;
+		return;
 	gh = find_first_waiter(gl);
 	if (!gh)
-		goto out_unlock;
+		return;
 	if (nonblock)
 		goto out_sched;
 	gl->gl_target = gh->gh_state;
 	if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
 		do_error(gl, 0); /* Fail queued try locks */
+	set_bit(GLF_LOCK, &gl->gl_flags);
 	do_xmote(gl, gh, gl->gl_target);
 	return;
 
 out_sched:
-	clear_bit(GLF_LOCK, &gl->gl_flags);
 	gl->gl_lockref.count++;
 	gfs2_glock_queue_work(gl, 0);
-	return;
-
-out_unlock:
-	clear_bit(GLF_LOCK, &gl->gl_flags);
 }
 
 /**
-- 
2.52.0

