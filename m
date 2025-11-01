Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C91D5174
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956587; cv=none; b=sHWnGlablG+zlLabO+be6gG756yZUFKAT48GV0jW/k/XIG2DQS8nqfvkKRakR7j82Dsw5qNLjQBknaAJkJKSyjDYcPRB7Y5dtSTMgm94eQ2+ByW+ZaoAFkSjSva+nvA+YHAQrSpzdBHUhgLSmKK9KPgm9E81w1OrxL6hD35ETC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956587; c=relaxed/simple;
	bh=J3o4zPeRfJAOGcbmOFQ5KNQCnn1s7KQtZ9DAYNKkhxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=b1SNotH3u8esIPF/C9DuIGd7ldCZRegQfGSx5PfQ+RjLKbj7Cp4e8Cz0ZovuXuUXgk4OLHW5//RHvZpbqF7cO08hDbhc0o5XU673DwgfQqZookPZBXeurByzoYUcMoi5ELBVbdpn6zdUd4nVwRBeGqTpNGQnNts2JX460d4uQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZueMKOGh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZueMKOGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIki3vLp/UAnqJ1JquzWnvFvx5RAueTf9LGzojnf0CA=;
	b=ZueMKOGh/3D4/sh2P5jiMzaBhBHlifhE1yIlAzDHyESSI+b3qlBwku9deLXq2xx5v1isy3
	yPlncN3QBM3IW10uDdDd8pGeVhLEbE8ywcvsTRsdD06GIQfE6j+9SEWchsWxCwns/a0MgG
	uWidqgNjsgPrfokZyI2ACrOAkM0N6vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-hS_vgU9OMhq2jJ_HZhdLhQ-1; Fri,
 31 Oct 2025 20:23:03 -0400
X-MC-Unique: hS_vgU9OMhq2jJ_HZhdLhQ-1
X-Mimecast-MFC-AGG-ID: hS_vgU9OMhq2jJ_HZhdLhQ_1761956582
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85D0C180057A
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:02 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7ABF318004D8;
	Sat,  1 Nov 2025 00:23:01 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 16/24] Revert "gfs2: Check for log write errors before telling dlm to unlock"
Date: Sat,  1 Nov 2025 00:22:25 +0000
Message-ID: <20251101002234.1286383-17-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Uy5KgKqTeKPtX3u5hFRpqmr1T0DZqjKHsjYXN9LixlA_1761956582
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts the rest of d93ae386ef3d ("gfs2: Check for log write errors
before telling dlm to unlock").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 26438cb08a97..439ed14260ce 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -725,22 +725,6 @@ __acquires(&gl->gl_lockref.lock)
 	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	/*
-	 * Check for an error encountered since we called go_sync and go_inval.
-	 * If so, we can't withdraw from the glock code because the withdraw
-	 * code itself uses glocks (see function signal_our_withdraw) to
-	 * change the mount to read-only. Most importantly, we must not call
-	 * dlm to unlock the glock until the journal is in a known good state
-	 * (after journal replay) otherwise other nodes may use the object
-	 * (rgrp or dinode) and then later, journal replay will corrupt the
-	 * file system. The best we can do here is wait for the logd daemon
-	 * to see sd_log_error and withdraw, and in the meantime, requeue the
-	 * work for later.
-	 *
-	 * However, if we're just unlocking the lock (say, for unmount, when
-	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
-	 * then it's okay to tell dlm to unlock it.
-	 */
 	if (glock_blocked_by_withdraw(gl) && target != LM_ST_UNLOCKED) {
 		request_demote(gl, LM_ST_UNLOCKED, 0, false);
 		/*
-- 
2.51.0

