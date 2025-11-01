Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3341C62
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956577; cv=none; b=ef4rm8b2/KUprZcYaQygHGDwYNkWUuUO7gPbRaNvDwnZfo3Y2R4K10rmlJb+T5UMHeEVzXw5AkCjDFL42x/ZgmzTzU1jWoC6UU0O7B+xoj/AcPYWEBx+zWhEEkUvOFson2jEOhsipGIXG67vpJkPXHLDkGRwLmpd1REaq7dcyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956577; c=relaxed/simple;
	bh=TN3uJcqG4htoE/iBxvhZhRjf9+mUEg3zXMUqowduMc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BMzVxx4cYJafLQnQvZKeq9EVzjUQ/4rBj951TSpT2GGXFvz2WJgYbHI9fOmCtrCCOMuj9UJ66eYG0/qVANVrXxWoNtWcSEtO3S7afdsdefo9wGJ3TWyy5J2U9lNPjq09HetJYIC7gXny+vfpQlDhuVSaEezhTLXA5qdcsIJ8Fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqIlPZKh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqIlPZKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3cq3iG1iaeCZp1ZANcirbe2qbpLOKr5wVQmodu47Cs=;
	b=JqIlPZKhOlhqSyUHnvY50OVWXQt8P8Ak35+gro1GXOVFql3QtUWnztD6g4EOClNgqKA7ag
	C063xurI1dUQx8d7MtrBCgexaj3ePQh2rC+97DCfqFTynTjURjOZmIlFh6k+cnPd1smIw7
	6aKmTEdA+ljb+8jYJyPdb1S2RrJOAj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-jMc1PMWSOOO6RTW6cNEFFw-1; Fri,
 31 Oct 2025 20:22:53 -0400
X-MC-Unique: jMc1PMWSOOO6RTW6cNEFFw-1
X-Mimecast-MFC-AGG-ID: jMc1PMWSOOO6RTW6cNEFFw_1761956572
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A124319560B2
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 959BB180035A;
	Sat,  1 Nov 2025 00:22:51 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/24] Revert "gfs2: Force withdraw to replay journals and wait for it to finish" (2/6)
Date: Sat,  1 Nov 2025 00:22:19 +0000
Message-ID: <20251101002234.1286383-11-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 7p5FoQ0Xfkv75GAGLLkmsIJIknd86kbvVCrSG-PtxF4_1761956572
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
 fs/gfs2/glock.c      |  2 --
 fs/gfs2/glops.c      | 19 -------------------
 fs/gfs2/incore.h     |  2 --
 fs/gfs2/lock_dlm.c   |  4 ----
 fs/gfs2/trace_gfs2.h |  1 -
 fs/gfs2/util.c       | 10 ----------
 6 files changed, 38 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 0601c55c1dc5..329e36cf19cb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2303,8 +2303,6 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'o';
 	if (test_bit(GLF_BLOCKING, gflags))
 		*p++ = 'b';
-	if (test_bit(GLF_UNLOCKED, gflags))
-		*p++ = 'x';
 	if (test_bit(GLF_INSTANTIATE_NEEDED, gflags))
 		*p++ = 'n';
 	if (test_bit(GLF_INSTANTIATE_IN_PROG, gflags))
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 9dfa90bfae3e..5564edd3b1b3 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -639,24 +639,6 @@ static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 	}
 }
 
-/**
- * inode_go_unlocked - wake up anyone waiting for dlm's unlock ast
- * @gl: glock being unlocked
- *
- * For now, this is only used for the journal inode glock. In withdraw
- * situations, we need to wait for the glock to be unlocked so that we know
- * other nodes may proceed with recovery / journal replay.
- */
-static void inode_go_unlocked(struct gfs2_glock *gl)
-{
-	/* Note that we cannot reference gl_object because it's already set
-	 * to NULL by this point in its lifecycle. */
-	if (!test_bit(GLF_UNLOCKED, &gl->gl_flags))
-		return;
-	clear_bit_unlock(GLF_UNLOCKED, &gl->gl_flags);
-	wake_up_bit(&gl->gl_flags, GLF_UNLOCKED);
-}
-
 /**
  * nondisk_go_callback - used to signal when a node did a withdraw
  * @gl: the nondisk glock
@@ -719,7 +701,6 @@ const struct gfs2_glock_operations gfs2_inode_glops = {
 	.go_dump = inode_go_dump,
 	.go_type = LM_TYPE_INODE,
 	.go_flags = GLOF_ASPACE | GLOF_LVB,
-	.go_unlocked = inode_go_unlocked,
 };
 
 const struct gfs2_glock_operations gfs2_rgrp_glops = {
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 191a5fcc5d74..c72c06d9e77c 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -223,7 +223,6 @@ struct gfs2_glock_operations {
 	void (*go_dump)(struct seq_file *seq, const struct gfs2_glock *gl,
 			const char *fs_id_buf);
 	void (*go_callback)(struct gfs2_glock *gl, bool remote);
-	void (*go_unlocked)(struct gfs2_glock *gl);
 	const int go_subclass;
 	const int go_type;
 	const unsigned long go_flags;
@@ -326,7 +325,6 @@ enum {
 	GLF_LRU				= 13,
 	GLF_OBJECT			= 14, /* Used only for tracing */
 	GLF_BLOCKING			= 15,
-	GLF_UNLOCKED			= 16, /* Wait for glock to be unlocked */
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
 	GLF_VERIFY_DELETE		= 18, /* iopen glocks only */
 	GLF_PENDING_REPLY		= 19,
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 301e17345f52..a118f71adb00 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -15,8 +15,6 @@
 #include <linux/sched/signal.h>
 
 #include "incore.h"
-#include "glock.h"
-#include "glops.h"
 #include "recovery.h"
 #include "util.h"
 #include "sys.h"
@@ -139,8 +137,6 @@ static void gdlm_ast(void *arg)
 
 	switch (gl->gl_lksb.sb_status) {
 	case -DLM_EUNLOCK: /* Unlocked, so glock can be freed */
-		if (gl->gl_ops->go_unlocked)
-			gl->gl_ops->go_unlocked(gl);
 		gfs2_glock_free(gl);
 		return;
 	case -DLM_ECANCEL: /* Cancel while getting lock */
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 1c2507a27318..fcfbf68ec725 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -59,7 +59,6 @@
 	{(1UL << GLF_LRU),			"L" },		\
 	{(1UL << GLF_OBJECT),			"o" },		\
 	{(1UL << GLF_BLOCKING),			"b" },		\
-	{(1UL << GLF_UNLOCKED),			"x" },		\
 	{(1UL << GLF_INSTANTIATE_NEEDED),	"n" },		\
 	{(1UL << GLF_INSTANTIATE_IN_PROG),	"N" },		\
 	{(1UL << GLF_TRY_TO_EVICT),		"e" },		\
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 3ffcba4fbbd4..797613503858 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -198,16 +198,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	iput(inode);
 	sdp->sd_jdesc->jd_inode = NULL;
-	/*
-	 * Wait until the journal inode's glock is freed. This allows try locks
-	 * on other nodes to be successful, otherwise we remain the owner of
-	 * the glock as far as dlm is concerned.
-	 */
-	if (i_gl->gl_ops->go_unlocked) {
-		set_bit(GLF_UNLOCKED, &i_gl->gl_flags);
-		wait_on_bit(&i_gl->gl_flags, GLF_UNLOCKED, TASK_UNINTERRUPTIBLE);
-	}
-
 	/*
 	 * Dequeue the "live" glock, but keep a reference so it's never freed.
 	 */
-- 
2.51.0

