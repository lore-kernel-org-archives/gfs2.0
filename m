Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC32581
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956590; cv=none; b=U+3+FwQnsYdCEiR4t47UtAL1afNV6xNPAU4f4w+/IebfEn9ZVD9HEyzrneZlQIMYORidJ2HfF3tLMk+bg+bmrPJEfqq7tnVQCTZlzECJf8gicFSV0AdQ5s8huY4GaQVo7ZfeePgJeQUAz9cfdBhIZ4jaXgDGqYcGXSnN7GQ0PN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956590; c=relaxed/simple;
	bh=1tjLAfQ2vJBTpkxR5JbWWQsrX90jiFPL3p/oM7UdCmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DwB3l/vcTsIPFIf2CEcuGpTCjNAxygETfsQG9hsVWt62VpYe1VA/Qc4YxdeKO9CXfn6SxpjHB2uKYC24deP488elfGUqr4z2Nj6iQ4mVRv87ljLhgedEmwh5D3PbPCjay+F/hV/FdsXsRtcnFGjdNRfz29P+qFd+0GZfCXgbeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFvOy3rz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFvOy3rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amKU+Hs1iWKyt+G+OV+rEf8y506V6HZjj+4Lgxs2YRQ=;
	b=IFvOy3rzb2R3TmoXuSsIGAO8ZiISFMtA9kWtxQ66W1cxCEqtjMNXYRlz4vRd3173swN03z
	2mH30yDldj1jzA88YPW2FoS5juwRPOa6wyoGlQdH2mcOuakRxCYK5gfsFIawjZ/WWLFCFd
	OaYk+uJEU5S5W+e2fyGaTzNznWuSw88=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-fuh_-QNFPCiQf3tmj7h2Ew-1; Fri,
 31 Oct 2025 20:23:06 -0400
X-MC-Unique: fuh_-QNFPCiQf3tmj7h2Ew-1
X-Mimecast-MFC-AGG-ID: fuh_-QNFPCiQf3tmj7h2Ew_1761956585
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A046195608F
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E8F6180035A;
	Sat,  1 Nov 2025 00:23:04 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 18/24] Revert "gfs2: fix infinite loop when checking ail item count before go_inval"
Date: Sat,  1 Nov 2025 00:22:27 +0000
Message-ID: <20251101002234.1286383-19-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: TAzgdsXRtF5Lmr_VS7pNr3cX5fG9b-cxQCC3hzPuh_I_1761956585
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current withdraw code duplicates the journal recovery code gfs2
already has for dealing with node failures, and it does so poorly.  That
code was added because when releasing a lockspace, we didn't have a way
to indicate that the lockspace needs recovery.  We now do have this
feature, so the current withdraw code can be removed almost entirely.
This is one of several steps towards that.

Reverts commit 33dbd1e41a1d ("gfs2: fix infinite loop when checking ail
item count before go_inval").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 17 +----------------
 fs/gfs2/glops.c |  3 +++
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3637aa3df7c5..ee6d7fc78a2d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -678,23 +678,8 @@ __acquires(&gl->gl_lockref.lock)
 		goto skip_inval;
 	}
 
-	if (target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED) {
-		/*
-		 * The call to go_sync should have cleared out the ail list.
-		 * If there are still items, we have a problem. We ought to
-		 * withdraw, but we can't because the withdraw code also uses
-		 * glocks. Warn about the error, dump the glock, then fall
-		 * through and wait for logd to do the withdraw for us.
-		 */
-		if ((atomic_read(&gl->gl_ail_count) != 0) &&
-		    (!cmpxchg(&sdp->sd_log_error, 0, -EIO))) {
-			gfs2_glock_assert_warn(gl,
-					       !atomic_read(&gl->gl_ail_count));
-			gfs2_dump_glock(NULL, gl, true);
-			gfs2_withdraw(sdp);
-		}
+	if (target == LM_ST_UNLOCKED || target == LM_ST_DEFERRED)
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
-	}
 	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 232bd4310ebc..549b59157ed4 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -232,6 +232,7 @@ static void rgrp_go_inval(struct gfs2_glock *gl, int flags)
 	end = PAGE_ALIGN((rgd->rd_addr + rgd->rd_length) * bsize) - 1;
 	gfs2_rgrp_brelse(rgd);
 	WARN_ON_ONCE(!(flags & DIO_METADATA));
+	gfs2_assert_withdraw(sdp, !atomic_read(&gl->gl_ail_count));
 	truncate_inode_pages_range(mapping, start, end);
 }
 
@@ -358,6 +359,8 @@ static void inode_go_inval(struct gfs2_glock *gl, int flags)
 {
 	struct gfs2_inode *ip = gfs2_glock2inode(gl);
 
+	gfs2_assert_withdraw(gl->gl_name.ln_sbd, !atomic_read(&gl->gl_ail_count));
+
 	if (flags & DIO_METADATA) {
 		struct address_space *mapping = gfs2_glock2aspace(gl);
 		truncate_inode_pages(mapping, 0);
-- 
2.51.0

