Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE112581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956582; cv=none; b=HYgeIZvsIVJcLOqa9wnFIts00e+f/WK3WXpzXF4tLpeg+T2q7SIUyr+gezxJrTufOArBJvlPLdk7VZHH1V+ErVVrmhH/ouXutqV3Rn4b7hOvUmiTO8ZtXX80TEaPblNYwGVdGqVcHLsALM/IyexbF5xJu6bzLOvStkhVZM1GSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956582; c=relaxed/simple;
	bh=AFuAzicJ6eaUcw8aHG2YJTMpRdV/2kKmvyt303qg7/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=N7Mwr2nR66Q4m+sOJBJtDftLOc2R3jKgNSwddtd6OXQ8JdYm9gg5GO15xQMSswG6fosOuCapNkuFp7HTPx9n0k67ReVTrt/UVOk8AhBvDI/zRFAjhDY97si/ucH/RKCj3c6dl28dyywCjHTu/kAvRsg/0KoOtkVzRys5eoLTL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNrY58hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNrY58hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au2DoYuR9wBL1qES+1o1yJ2ZFsCaWL5mcYcrbUZuXZE=;
	b=cNrY58hdovxFMbn6bdH/rG6mhFqu/TI841c8ocEnuX4UR5zqGR8tx14Qpc+DshH4nB7/jJ
	D3/tMsX48xzTSd1m4mVfTyi9WcI9MrfWR6FUhAP5k1lYFngke67caQNkEH/ZrPiKNQONUm
	ZDyVNb38HEVjBszLnNzMkrlF7Qths0I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-FpzaK_2cOFyfVV7V7hVmNQ-1; Fri,
 31 Oct 2025 20:22:58 -0400
X-MC-Unique: FpzaK_2cOFyfVV7V7hVmNQ-1
X-Mimecast-MFC-AGG-ID: FpzaK_2cOFyfVV7V7hVmNQ_1761956577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46D441800637
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 387211800586;
	Sat,  1 Nov 2025 00:22:55 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 13/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (5/6)
Date: Sat,  1 Nov 2025 00:22:22 +0000
Message-ID: <20251101002234.1286383-14-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: pSMG1hxxESH9Se5nCIhI5qlONr-XvuHINy5MBKM--mU_1761956577
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts parts of commit 601ef0d52e96 ("gfs2: Force withdraw to replay
journals and wait for it to finish").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 329e36cf19cb..c8ab86e22942 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -691,8 +691,7 @@ __acquires(&gl->gl_lockref.lock)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int ret;
 
-	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl) &&
-	    gh && !(gh->gh_flags & LM_FLAG_RECOVER))
+	if (target != LM_ST_UNLOCKED && glock_blocked_by_withdraw(gl))
 		goto skip_inval;
 
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
@@ -1539,7 +1538,7 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	struct gfs2_glock *gl = gh->gh_gl;
 	int error;
 
-	if (glock_blocked_by_withdraw(gl) && !(gh->gh_flags & LM_FLAG_RECOVER))
+	if (glock_blocked_by_withdraw(gl))
 		return -EIO;
 
 	if (gh->gh_flags & GL_NOBLOCK) {
-- 
2.51.0

