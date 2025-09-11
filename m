Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF127F747
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599074; cv=none; b=oJuQg0Ns+EqWes7NEe/R9a7zVoDVApt7TEB7lELjCT+NH2ypeYbPN3VTmbwMQbDT57YL7PZLDF7hv6liB878kplDCBsAr/SunKIfPSDTOlNM5w3QofraIi/FOoloRgB9VGTTuzkqxt8Gd3MvMa16WJJrJDCmioIflBc7cwDrQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599074; c=relaxed/simple;
	bh=o2FZdcNjMcEnX+VJ5C8s+ReJKHGZ1uskMXNQ1FDp7dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G6FNbHaQaqNrNDUKYrb9YvxVGpBiCPiHWsvssn1kPSACZaJXjoY1mEYQVRZlRS69Wqh0QtFLHWiOxkxMMXj5ERh/17MenUWqaYpOnGZOgI64FvThXI/PuUeqyHlrcbc68jS2DNAeYcQaojQyBO2XJ/J/K7VUQ1u0/Dnw6Ytwn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTZDhrpg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTZDhrpg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCs0okxgDhrTUR0PMRCW7LMld8Nzoom0RgLSGsgcG9Q=;
	b=QTZDhrpgQp7KBLzEms3XmbWRfNAtWXlI7UZAdfAHtzipU0oHRuPoyJWrInrM9hCuNqrZFf
	sOSw9oOgKxpLzIGVKVwY2q/c49x/Ac2HEx40chAi/y8hcgv6Xlzczn0t4h4/mxac/oTL3v
	yYXRWUtb+gico1kMZqTRqUnkcK+EdSY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-ueWkklRhPZu7p18BGjWoyw-1; Thu,
 11 Sep 2025 09:57:49 -0400
X-MC-Unique: ueWkklRhPZu7p18BGjWoyw-1
X-Mimecast-MFC-AGG-ID: ueWkklRhPZu7p18BGjWoyw_1757599069
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B3D1800447
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:49 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCD0619560B1;
	Thu, 11 Sep 2025 13:57:47 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 11/20] gfs2: Remove DLM_LKF_ALTCW / DLM_LKF_ALTPR code
Date: Thu, 11 Sep 2025 15:57:16 +0200
Message-ID: <20250911135726.657575-12-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6xi_EcK4Xdq-bubbRzElU_U8kci3vhk7ha136QZu6cQ_1757599069
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit 6802e3400ff45 ("[GFS2] Clean up the glock core") stopped passing
the LM_FLAG_ANY flag down to gdlm_lock() (then gfs2_lm_lock()).  Since
then, gfs2 effectively hasn't been using dlm's DLM_LKF_ALTCW /
DLM_LKF_ALTPR flags, but the code still suggests that it does.  Recent
testing shows that those flags don't even work reliably anymore, so
instead of fixing code that hasn't been used since 2008, remove it.

In addition, clean up how the flags are passed to [gd]lm_lock().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c    |  4 +---
 fs/gfs2/lock_dlm.c | 17 -----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 595891015415..6294a9f36318 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -695,14 +695,12 @@ __acquires(&gl->gl_lockref.lock)
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	unsigned int lck_flags = (unsigned int)(gh ? gh->gh_flags : 0);
 	int ret;
 
 	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl) &&
 	    gh && !(gh->gh_flags & LM_FLAG_NOEXP))
 		goto skip_inval;
 
-	lck_flags &= (LM_FLAG_TRY | LM_FLAG_TRY_1CB | LM_FLAG_NOEXP);
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
 	GLOCK_BUG_ON(gl, gl->gl_state == gl->gl_target);
 	if ((target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED) &&
@@ -809,7 +807,7 @@ __acquires(&gl->gl_lockref.lock)
 	if (ls->ls_ops->lm_lock) {
 		set_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 		spin_unlock(&gl->gl_lockref.lock);
-		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
+		ret = ls->ls_ops->lm_lock(gl, target, gh ? gh->gh_flags : 0);
 		spin_lock(&gl->gl_lockref.lock);
 
 		if (!ret) {
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 5daaeaaaf18d..427150a206cf 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -162,14 +162,6 @@ static void gdlm_ast(void *arg)
 	}
 
 	ret = gl->gl_req;
-	if (gl->gl_lksb.sb_flags & DLM_SBF_ALTMODE) {
-		if (gl->gl_req == LM_ST_SHARED)
-			ret = LM_ST_DEFERRED;
-		else if (gl->gl_req == LM_ST_DEFERRED)
-			ret = LM_ST_SHARED;
-		else
-			BUG();
-	}
 
 	/*
 	 * The GLF_INITIAL flag is initially set for new glocks.  Upon the
@@ -261,15 +253,6 @@ static u32 make_flags(struct gfs2_glock *gl, const unsigned int gfs_flags,
 		lkf |= DLM_LKF_NOQUEUEBAST;
 	}
 
-	if (gfs_flags & LM_FLAG_ANY) {
-		if (req == DLM_LOCK_PR)
-			lkf |= DLM_LKF_ALTCW;
-		else if (req == DLM_LOCK_CW)
-			lkf |= DLM_LKF_ALTPR;
-		else
-			BUG();
-	}
-
 	if (!test_bit(GLF_INITIAL, &gl->gl_flags)) {
 		lkf |= DLM_LKF_CONVERT;
 
-- 
2.51.0

