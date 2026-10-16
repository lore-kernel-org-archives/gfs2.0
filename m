Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BF4EB862
	for <gfs2@lists.linux.dev>; Fri, 16 Oct 2026 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157631; cv=none; b=izEkDfEd47+FRvlclYALyDtdCIvNIeVtWnqkPzJgK8bphv7DUZWds7xfiJRWEHHdIvD0rUA+8rNYAY9BqXJ0CRxqpMTEIxbVZn8ag7/sbZ7GwXBkxDGtSHfbVAiePlPgLPNOH3bvGkN2qQ5F6QEmksxWK47v/zFE4uGxEiqfRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157631; c=relaxed/simple;
	bh=3lk5XqfehKwLu7vVEQ+sKEZmsogl7buMfXSGhmcAS+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tsdgrWdsDLJNXGgcOsfA0ITDpP8mELXrcR8PDM/yeBrlJSdxMC6ll1Nh1lcJukO5hKp13xxqYXgMjBn2gxg+HNgKZpTYtITRpKr/2nX22smFTlxOCDqcUj5LgHHNMO7EEu4aCoey+YCrYWTY5Z8hE/Ll805zBASMztYodKGd6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vxxn7ckr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vxxn7ckr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792157628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=87Gb41kyXVvdMG8SYSCEebbCiERoxCb1o5+DXXBWaY4=;
	b=Vxxn7ckrSqKTdnyEN91/E8pO1+3lwEomtM7WIjwcsrDY1apgVDoSq/89VrgHTs1ycRob5I
	ai4j7VtqwCnTPq10ZtXny2IyiO9LFfkEqHrvdsWkTNCAZvjguLtjoxC+DYZyGgzpeKAKI3
	qCQAhikM/DY2ZjYRXIvxNuczjWLHBjo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-As7HOr6EPheNrVYWjFbVwA-1; Fri,
 16 Oct 2026 13:33:46 +0000
X-MC-Unique: As7HOr6EPheNrVYWjFbVwA-1
X-Mimecast-MFC-AGG-ID: As7HOr6EPheNrVYWjFbVwA_1792157625
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71B351955DD9
	for <gfs2@lists.linux.dev>; Fri, 16 Oct 2026 13:33:45 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.102])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D56F7D8;
	Fri, 16 Oct 2026 13:33:44 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: remove unnecessary check in gfs2_freeze_lock_shared
Date: Fri, 16 Oct 2026 15:33:43 +0200
Message-ID: <20261016133343.332193-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CqUzijz158bQGdpn6SDwoM-Cmww3k3gI1bRcLL0ARzA_1792157625
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

gfs2_freeze_lock_shared() takes sdp->sd_freeze_gl without the
LM_FLAG_TRY or LM_FLAG_TRY_1CB flags, so gfs2_glock_nq_init() will never
return GLR_TRYFAILED.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 61b0668ecabc..529c3ec37a18 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -103,7 +103,7 @@ int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp)
 
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, flags,
 				   &sdp->sd_freeze_gh);
-	if (error && error != GLR_TRYFAILED)
+	if (error)
 		fs_err(sdp, "can't lock the freeze glock: %d\n", error);
 	return error;
 }
-- 
2.56.0

