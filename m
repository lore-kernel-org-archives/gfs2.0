Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669D401A14
	for <gfs2@lists.linux.dev>; Wed, 12 Aug 2026 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570359; cv=none; b=AeUFF7ngU3Vs/GB/DCi98ZwKjJqHD+9MW7sJA9nr8R0fDHefFy6kTWVxSrtoo92Ig+DAJqc8yRlLLGfv1do+3t0GGzOL9o5nWIw0i2Hpih9rIyEkXnQ1+LuL+RCsSG2cFn+hh63aBssmv9JhCtSSRaSdtq5pNzq+qUnMF3GcON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570359; c=relaxed/simple;
	bh=bPj4cnYhCEhqGNZLoZmRWpAgojRIiOu4jagm44TvQDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=EtcY6YDdN+BM3/XqKJmGR64MDomvlrAVrrqpFEKsSRMRB4j2GdemzItG/qBYDtjYFnmhjzz68RkWJihHPjH9muqRAW+MJmf77ELRvBPgsMKvk+4Tx12SCdEjgFtGY7lDxUSrvs7gPx50sAFzRto01BxCb39kzQbVmCoLCr1or9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiDooeBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiDooeBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786570356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2yRCKJqCg1hicBCjB972U+NWW50J2Hu/+efUzwnJeE=;
	b=YiDooeBOHWkxDpPZjE7gGOKVKLE3xx70DTAm0xh/d+D2Cf11w0u6dBTtxv5EvqMIOYZM0n
	xGCCkGsNH3tVRZEj0/OO8pzIRaWOD7vwCCtkfqpDEAHeYEVUR3cLrAZ3jqh7zTm2xDR4VU
	eE1eyQqJa0XlK+ih/zBBJGjeGHmuhCU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-Lz-zyPbuMGWuSRo6YhV6Xw-1; Wed,
 12 Aug 2026 17:32:34 -0400
X-MC-Unique: Lz-zyPbuMGWuSRo6YhV6Xw-1
X-Mimecast-MFC-AGG-ID: Lz-zyPbuMGWuSRo6YhV6Xw_1786570354
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4E94180074B
	for <gfs2@lists.linux.dev>; Wed, 12 Aug 2026 21:32:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.33.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83AD11956049;
	Wed, 12 Aug 2026 21:32:32 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: harden gfs2_glock_hold
Date: Wed, 12 Aug 2026 23:32:31 +0200
Message-ID: <20260812213231.1135602-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sPQlIiSir4BUXIAaN7TxFSm9fQX2joBE-kuUJQO6BQg_1786570354
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Function gfs2_glock_hold() is expected only to be called when the glock is
held, so use lockref_get_not_zero() instead of lockref_get_not_dead().

In addition, when an asynchronous callback arrives in gfs2_glock_cb(), the
glock can already be dead (from __gfs2_glock_put()), or it can be on the glock
lru list with refcount 0, so we cannot use gfs2_glock_hold() there.

With gfs2_glock_cb() now handling dead glocks, we can remove the racy check in
gdlm_bast().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c    | 6 ++++--
 fs/gfs2/lock_dlm.c | 3 ---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 558c8c660a3d..9cf59ee2f443 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -183,7 +183,7 @@ static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
 
 struct gfs2_glock *gfs2_glock_hold(struct gfs2_glock *gl)
 {
-	if (!lockref_get_not_dead(&gl->gl_lockref))
+	if (!lockref_get_not_zero(&gl->gl_lockref))
 		GLOCK_BUG_ON(gl, 1);
 	return gl;
 }
@@ -1769,7 +1769,9 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 {
 	unsigned long delay = 0;
 
-	gfs2_glock_hold(gl);
+	if (!lockref_get_not_dead(&gl->gl_lockref))
+		return;
+
 	spin_lock(&gl->gl_lockref.lock);
 	if (!list_empty(&gl->gl_holders) &&
 	    glock_type(gl) == LM_TYPE_INODE) {
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index ab7ac8e634bf..babce07b84f1 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -182,9 +182,6 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
-	if (__lockref_is_dead(&gl->gl_lockref))
-		return;
-
 	switch (mode) {
 	case DLM_LOCK_EX:
 		gfs2_glock_cb(gl, LM_ST_UNLOCKED);
-- 
2.55.0

