Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A741A08A4
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599080; cv=none; b=uQfFX66PLZ92nAvqkP1N81+zbhyFSvK8DoomGg1r4SOpb3QDh58nFDsuMp2j3zu0CBtpWAZk6FMgJr7YLNVtscfud36XfhVrryoJ3hEzZ2jfOGfiByprDQyWAf/OOWjBaWBQfvbJ2wtnhCQLz9gToPKm5ZLu1CEV/qruDNhL+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599080; c=relaxed/simple;
	bh=973XqR4jW8r/IG78J6bODQDZlg43akqJI1MChRZ7Ua8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mn/SHSsIwvwHBSiQNDLhUG27n6SfJzeVbitK4Z1Z2VmuOE+mlOeurHOazALUWKnV2HmAN2JmGNquddNk4il/eW7Sx3gfWgxDcEnb9CGm5z8HbZqIZ07wiaygF4SHroE1o8rr0eFReqNvUbFN9m+/VZ5Kbz4Yhv3RnCKZ6U0LpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2gq1Vom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2gq1Vom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdaR1SL2qrVP1Ef5qZIq0qB6sxHzcqPjOKjyCzT67JY=;
	b=J2gq1VomM2b4L11TmwTn1rAZL2xeIftqBBVyEEZMnELQTQy3LlVPI6Up7fCi+iBMC+QXSa
	dOMHEHPM53BBHHLeEP+3d7s7VVoo81yIGN83M9TeWTLg422EzVXsvwPcRz30E/jtTHG1fl
	R5nQl15CAGR/lFz8T9/NCLNh4+7JvI8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-mYwWds1OPuKuLAUBR7IBRw-1; Thu,
 11 Sep 2025 09:57:57 -0400
X-MC-Unique: mYwWds1OPuKuLAUBR7IBRw-1
X-Mimecast-MFC-AGG-ID: mYwWds1OPuKuLAUBR7IBRw_1757599076
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CF8119107DD
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:56 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EF8219560BD;
	Thu, 11 Sep 2025 13:57:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 15/20] gfs2: Get rid of GLF_INVALIDATE_IN_PROGRESS
Date: Thu, 11 Sep 2025 15:57:20 +0200
Message-ID: <20250911135726.657575-16-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ALwoqxC_pqpfmyoj1ZX2auhi6nYfo1OI7DoGyQfxh4Y_1757599076
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Get rid of the GLF_INVALIDATE_IN_PROGRESS flag: it was originally used
to indicate to add_to_queue() that the ->go_sync() and ->go_invalid()
operations were in progress, but as we have established in commit "gfs2:
Fix LM_FLAG_TRY* logic in add_to_queue", add_to_queue() has no need to
know.

Commit d99724c3c36a describes a race in which GLF_INVALIDATE_IN_PROGRESS
is used to serialize two processes which are both in do_xmote() at the
same time.  That analysis is wrong: the serialization happens via the
GLF_LOCK flag, which ensures that at most one glock operation can be
active at any time.

Fixes: d99724c3c36a ("gfs2: Close timing window with GLF_INVALIDATE_IN_PROGRESS")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c      | 16 +---------------
 fs/gfs2/incore.h     |  1 -
 fs/gfs2/trace_gfs2.h |  1 -
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5361a2641cdb..e8b630a58da8 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -703,17 +703,6 @@ __acquires(&gl->gl_lockref.lock)
 
 	GLOCK_BUG_ON(gl, gl->gl_state == target);
 	GLOCK_BUG_ON(gl, gl->gl_state == gl->gl_target);
-	if ((target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED) &&
-	    glops->go_inval) {
-		/*
-		 * If another process is already doing the invalidate, let that
-		 * finish first.  The glock state machine will get back to this
-		 * holder again later.
-		 */
-		if (test_and_set_bit(GLF_INVALIDATE_IN_PROGRESS,
-				     &gl->gl_flags))
-			return;
-	}
 	if (!glops->go_inval || !glops->go_sync)
 		goto skip_inval;
 
@@ -732,7 +721,7 @@ __acquires(&gl->gl_lockref.lock)
 		goto skip_inval;
 	}
 
-	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags)) {
+	if (target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED) {
 		/*
 		 * The call to go_sync should have cleared out the ail list.
 		 * If there are still items, we have a problem. We ought to
@@ -747,7 +736,6 @@ __acquires(&gl->gl_lockref.lock)
 			gfs2_dump_glock(NULL, gl, true);
 		}
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
-		clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 	}
 	spin_lock(&gl->gl_lockref.lock);
 
@@ -2316,8 +2304,6 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'y';
 	if (test_bit(GLF_LFLUSH, gflags))
 		*p++ = 'f';
-	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, gflags))
-		*p++ = 'i';
 	if (test_bit(GLF_PENDING_REPLY, gflags))
 		*p++ = 'R';
 	if (test_bit(GLF_HAVE_REPLY, gflags))
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 78a00239e384..cd8a3f469291 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -319,7 +319,6 @@ enum {
 	GLF_DEMOTE_IN_PROGRESS		= 5,
 	GLF_DIRTY			= 6,
 	GLF_LFLUSH			= 7,
-	GLF_INVALIDATE_IN_PROGRESS	= 8,
 	GLF_HAVE_REPLY			= 9,
 	GLF_INITIAL			= 10,
 	GLF_HAVE_FROZEN_REPLY		= 11,
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 26036ffc3f33..1c2507a27318 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -52,7 +52,6 @@
 	{(1UL << GLF_DEMOTE_IN_PROGRESS),	"p" },		\
 	{(1UL << GLF_DIRTY),			"y" },		\
 	{(1UL << GLF_LFLUSH),			"f" },		\
-	{(1UL << GLF_INVALIDATE_IN_PROGRESS),	"i" },		\
 	{(1UL << GLF_PENDING_REPLY),		"R" },		\
 	{(1UL << GLF_HAVE_REPLY),		"r" },		\
 	{(1UL << GLF_INITIAL),			"a" },		\
-- 
2.51.0

