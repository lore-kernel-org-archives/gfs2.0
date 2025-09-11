Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610432ED3D
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599070; cv=none; b=Wt1+P2wyJHN6LQZqvvbEd3Zazd5OwrIteT7HLRJ+3I3vZHzEK6hlqDEzJZoQN2yBCzrnRaA11j2As9j9BRNCAUrgw4kD0U4M8szAztQKq3W1DELHgaXz0zGLrQi3ATyPBkyeyoX4B7qQvxC9TaPSKRYe0EtdXJULbd3X5WZDYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599070; c=relaxed/simple;
	bh=iRk50evbyZW9vqTQ4kyJAqQR5N1Ufsn0KdNXdjJCqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JO/kLATIlPlJvreKY66P4rE7X+6+fFACirMhdlS9yRQc8gwmbhrddHE48yNn3kUnP1RiHC6tVFx46zEKYKdMxfj6vahr452Ajjb9DGW1RlLR/xEROadbe4UDjYG7vkEwB6nP8KzPL9EWQp69Eu/at55lK0eEcqNHK0B45oSiEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGV0RibZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGV0RibZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhSedYnBjmNhj0rErkyODCW6X6NVuas02DGxmaYaFcs=;
	b=ZGV0RibZBFMy+/Nm7T5u6eFGyX0x5/hdzfBnbdy0ygQ+5jKuzFRo4S1DUXwHypOKJS8Qye
	7fkveDzOgYv9sERvTS/2rtAMj8369KGDRIjB0jcTwLDIVtKO7+kURvXEhAhPkGFmXwmAWN
	hk1+Sd+oUU465TyQySqn/hKixFJwxls=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-XVhOp0l1M7alV7DV_ZSB6g-1; Thu,
 11 Sep 2025 09:57:46 -0400
X-MC-Unique: XVhOp0l1M7alV7DV_ZSB6g-1
X-Mimecast-MFC-AGG-ID: XVhOp0l1M7alV7DV_ZSB6g_1757599065
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A03AD1956086
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 13:57:45 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62D3B19560B1;
	Thu, 11 Sep 2025 13:57:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 09/20] gfs2: Do not use atomic operations unnecessarily
Date: Thu, 11 Sep 2025 15:57:14 +0200
Message-ID: <20250911135726.657575-10-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: D_UFnTmSIUABJFXC42WTxBItC3k2rUiELYMywf3e8tg_1757599065
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The GLF_DEMOTE_IN_PROGRESS and GLF_LOCK flags and the glock refcount are
all protected by the glock spin lock, so there is no need for atomic
operations / barriers here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5bdb11de5b13..1ced38b9a5a2 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -646,8 +646,10 @@ static void finish_xmote(struct gfs2_glock *gl, unsigned int ret)
 	}
 
 	/* Fast path - we got what we asked for */
-	if (test_and_clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags))
+	if (test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags)) {
+		clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		gfs2_demote_wake(gl);
+	}
 	if (gl->gl_state != LM_ST_UNLOCKED) {
 		if (glops->go_xmote_bh) {
 			int rv;
@@ -891,14 +893,12 @@ __acquires(&gl->gl_lockref.lock)
 
 out_sched:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
-	smp_mb__after_atomic();
 	gl->gl_lockref.count++;
 	gfs2_glock_queue_work(gl, 0);
 	return;
 
 out_unlock:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
-	smp_mb__after_atomic();
 }
 
 /**
-- 
2.51.0

