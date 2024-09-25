Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807B1D5AD5
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301842; cv=none; b=k/IU3MdLI6SyQgB19l2fXqhoXB3B4pM0t+j8IjnYkc+s1bTCxacrxJyYjxO3G/eyHVLKYLvu0HKB3JSgGpP3jbrxvQvIcWKPBJ6Fm7MMQCIZ4fHSjlFQzkJxfXEK09Du8v6+Zf6Jr7u2t1rMwz74fWujfKSjdvKyRxWhSieXCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301842; c=relaxed/simple;
	bh=LkoLfqr48gRYUe/rlr+CTJ60+6cMjrgjQKAft+uYX9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkouAkLiPNvRsuoaAid65R0xCFGX7WhyqkBq4eXb/o9Lpkr5TnoPnDQzlwBX0H0aEek0X2ufex6q1o7AW1h6gZuSDcbFDNAqV7Vd0lWG4T2a+EFsj4ITCYem2XagKIJpcOvETxiKQuRslulFFYbGwMjnT6I2eYDsxXy1GfMOmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSxwdLXL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSxwdLXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvvZNOJ2npow/qkjpp9xcH3C/38bNGS1FSTcOcAIrCE=;
	b=QSxwdLXLbZKRgTC0Kfl3zTa3FFKbDjWSwWi0YJaWsICMyMRyfQD1TszF6dH3/tRbXoeBIB
	iTO90imY+JAEL0wqmUiKKDOWQzDGMezXAJKzi2nmHt7jDCf73MG2PYlIeiVwHZYMcCIJwo
	NNU+TVjZQ+kqTEBPsT5KIf/ysNPJBAU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-1ZdojTMhNOyHLD3ux5NJgg-1; Wed,
 25 Sep 2024 18:03:57 -0400
X-MC-Unique: 1ZdojTMhNOyHLD3ux5NJgg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AAD31933E9F
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:55 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDEFD19560AA;
	Wed, 25 Sep 2024 22:03:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 12/16] gfs2: Update to the evict / remote delete documentation
Date: Thu, 26 Sep 2024 00:03:22 +0200
Message-ID: <20240925220331.417856-13-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Try to be a bit more clear and remove some duplications.  We cannot
actually get rid of the verification step eventually, so remove the
comment saying so.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 31 ++++++++-----------------------
 fs/gfs2/super.c |  6 +++---
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 3736e7f3b381..8fff36846145 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -965,13 +965,16 @@ static void gfs2_try_evict(struct gfs2_glock *gl)
 
 	/*
 	 * If there is contention on the iopen glock and we have an inode, try
-	 * to grab and release the inode so that it can be evicted.  This will
-	 * allow the remote node to go ahead and delete the inode without us
-	 * having to do it, which will avoid rgrp glock thrashing.
+	 * to grab and release the inode so that it can be evicted.  The
+	 * GIF_DEFER_DELETE flag indicates to gfs2_evict_inode() that the inode
+	 * should not be deleted locally.  This will allow the remote node to
+	 * go ahead and delete the inode without us having to do it, which will
+	 * avoid rgrp glock thrashing.
 	 *
 	 * The remote node is likely still holding the corresponding inode
 	 * glock, so it will run before we get to verify that the delete has
-	 * happened below.
+	 * happened below.  (Verification is triggered by the call to
+	 * gfs2_queue_verify_delete() in gfs2_evict_inode().)
 	 */
 	spin_lock(&gl->gl_lockref.lock);
 	ip = gl->gl_object;
@@ -1027,26 +1030,8 @@ static void delete_work_func(struct work_struct *work)
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	bool verify_delete = test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags);
 
-	if (test_and_clear_bit(GLF_TRY_TO_EVICT, &gl->gl_flags)) {
-		/*
-		 * If we can evict the inode, give the remote node trying to
-		 * delete the inode some time before verifying that the delete
-		 * has happened.  Otherwise, if we cause contention on the inode glock
-		 * immediately, the remote node will think that we still have
-		 * the inode in use, and so it will give up waiting.
-		 *
-		 * If we can't evict the inode, signal to the remote node that
-		 * the inode is still in use.  We'll later try to delete the
-		 * inode locally in gfs2_evict_inode.
-		 *
-		 * FIXME: We only need to verify that the remote node has
-		 * deleted the inode because nodes before this remote delete
-		 * rework won't cooperate.  At a later time, when we no longer
-		 * care about compatibility with such nodes, we can skip this
-		 * step entirely.
-		 */
+	if (test_and_clear_bit(GLF_TRY_TO_EVICT, &gl->gl_flags))
 		gfs2_try_evict(gl);
-	}
 
 	if (verify_delete) {
 		u64 no_addr = gl->gl_name.ln_number;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 90cdc9212f12..715821c837cd 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1272,9 +1272,9 @@ static enum evict_behavior gfs2_upgrade_iopen_glock(struct inode *inode)
 	 * exclusive access to the iopen glock here.
 	 *
 	 * Otherwise, the other nodes holding the lock will be notified about
-	 * our locking request.  If they do not have the inode open, they are
-	 * expected to evict the cached inode and release the lock, allowing us
-	 * to proceed.
+	 * our locking request (see iopen_go_callback()).  If they do not have
+	 * the inode open, they are expected to evict the cached inode and
+	 * release the lock, allowing us to proceed.
 	 *
 	 * Otherwise, if they cannot evict the inode, they are expected to poke
 	 * the inode glock (note: not the iopen glock).  We will notice that
-- 
2.46.0

