Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DFA55
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002241; cv=none; b=aWki989L2O8qJqK0baXsztU8/+bT53ckV/RMFeihmc5kwhUrqxeGY+fuz9YWU/MLu2QSS65TN1l8oNUp/bHiLNf4MtEBc3o97yiwb/R9Lkmign5h5GAoSW9gowlqm3OT6J7mQFMqEvFIqit2R7/glF+WxO4qLCAlOWQfJBvBN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002241; c=relaxed/simple;
	bh=upUj6TCPT6WMhAirIQtVS3X8wmCVmp2HBTM0NCrhmbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Y4ZtMQ/QWuxoqoJHvjgAUYhGRZ9CUTwWHbwLxmva+4gjAGebprFfih36Jl7wmw4xjQbubIoGJ0s5vpyZ2cEn+RhRYL2xSor2NtyHbSHrnrZ7KviTsrQHv82WnDWxO9c5YHI8HWs/B+5hL30uVIw8Yw430POX+Z9eUDn5r31r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1XFqC2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1XFqC2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tejb/GlkEVfLbOlhvQlr5RFUKB5LpOubqipd/ZQHlp4=;
	b=M1XFqC2CLh0kgG+6exmKPHWdgLhEup1a3XiDO/8fgr9q0yw/BfWPH3R6/LwldhkyaHGPY6
	rKiwbW1Apo9i03WWodPt5N+xd81BhT8Co0KmQXDtUyy2UoP6dk7XRqI63oyQSsawvb5X1o
	ZucUZWR3BLOTyga5NcOn3rT4uimmhQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-fKXqSnAYNtqLWdS9tUQZkQ-1; Wed,
 29 May 2024 13:03:56 -0400
X-MC-Unique: fKXqSnAYNtqLWdS9tUQZkQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EBF31C05122
	for <gfs2@lists.linux.dev>; Wed, 29 May 2024 17:03:56 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6D09400057;
	Wed, 29 May 2024 17:03:55 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/15] gfs2: Rename GLF_FREEING to GLF_UNLOCKED
Date: Wed, 29 May 2024 19:03:40 +0200
Message-ID: <20240529170352.571141-4-agruenba@redhat.com>
In-Reply-To: <20240529170352.571141-1-agruenba@redhat.com>
References: <20240529170352.571141-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Rename the GLF_FREEING flag to GLF_UNLOCKED, and the ->go_free glock
operation to ->go_unlocked.  This mechanism is used to wait for the
underlying DLM lock to be unlocked; being able to free the glock is a
consequence of the DLM lock being unlocked.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c    |  2 +-
 fs/gfs2/glops.c    | 16 ++++++++--------
 fs/gfs2/incore.h   |  4 ++--
 fs/gfs2/lock_dlm.c |  4 ++--
 fs/gfs2/util.c     |  6 +++---
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d1fb0b2b5649..959668e22c9d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2378,7 +2378,7 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'o';
 	if (test_bit(GLF_BLOCKING, gflags))
 		*p++ = 'b';
-	if (test_bit(GLF_FREEING, gflags))
+	if (test_bit(GLF_UNLOCKED, gflags))
 		*p++ = 'x';
 	if (test_bit(GLF_INSTANTIATE_NEEDED, gflags))
 		*p++ = 'n';
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 68677fb69a73..39bb6758a2a0 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -648,21 +648,21 @@ static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 }
 
 /**
- * inode_go_free - wake up anyone waiting for dlm's unlock ast to free it
- * @gl: glock being freed
+ * inode_go_unlocked - wake up anyone waiting for dlm's unlock ast
+ * @gl: glock being unlocked
  *
  * For now, this is only used for the journal inode glock. In withdraw
- * situations, we need to wait for the glock to be freed so that we know
+ * situations, we need to wait for the glock to be unlocked so that we know
  * other nodes may proceed with recovery / journal replay.
  */
-static void inode_go_free(struct gfs2_glock *gl)
+static void inode_go_unlocked(struct gfs2_glock *gl)
 {
 	/* Note that we cannot reference gl_object because it's already set
 	 * to NULL by this point in its lifecycle. */
-	if (!test_bit(GLF_FREEING, &gl->gl_flags))
+	if (!test_bit(GLF_UNLOCKED, &gl->gl_flags))
 		return;
-	clear_bit_unlock(GLF_FREEING, &gl->gl_flags);
-	wake_up_bit(&gl->gl_flags, GLF_FREEING);
+	clear_bit_unlock(GLF_UNLOCKED, &gl->gl_flags);
+	wake_up_bit(&gl->gl_flags, GLF_UNLOCKED);
 }
 
 /**
@@ -728,7 +728,7 @@ const struct gfs2_glock_operations gfs2_inode_glops = {
 	.go_dump = inode_go_dump,
 	.go_type = LM_TYPE_INODE,
 	.go_flags = GLOF_ASPACE | GLOF_LRU | GLOF_LVB,
-	.go_free = inode_go_free,
+	.go_unlocked = inode_go_unlocked,
 };
 
 const struct gfs2_glock_operations gfs2_rgrp_glops = {
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 60abd7050c99..aa6dbde9cd19 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -224,7 +224,7 @@ struct gfs2_glock_operations {
 	void (*go_dump)(struct seq_file *seq, const struct gfs2_glock *gl,
 			const char *fs_id_buf);
 	void (*go_callback)(struct gfs2_glock *gl, bool remote);
-	void (*go_free)(struct gfs2_glock *gl);
+	void (*go_unlocked)(struct gfs2_glock *gl);
 	const int go_subclass;
 	const int go_type;
 	const unsigned long go_flags;
@@ -329,7 +329,7 @@ enum {
 	GLF_LRU				= 13,
 	GLF_OBJECT			= 14, /* Used only for tracing */
 	GLF_BLOCKING			= 15,
-	GLF_FREEING			= 16, /* Wait for glock to be freed */
+	GLF_UNLOCKED			= 16, /* Wait for glock to be unlocked */
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
 	GLF_VERIFY_EVICT		= 18, /* iopen glocks only */
 };
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 49059274a528..cb2ad0031f9e 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -134,8 +134,8 @@ static void gdlm_ast(void *arg)
 
 	switch (gl->gl_lksb.sb_status) {
 	case -DLM_EUNLOCK: /* Unlocked, so glock can be freed */
-		if (gl->gl_ops->go_free)
-			gl->gl_ops->go_free(gl);
+		if (gl->gl_ops->go_unlocked)
+			gl->gl_ops->go_unlocked(gl);
 		gfs2_glock_free(gl);
 		return;
 	case -DLM_ECANCEL: /* Cancel while getting lock */
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index af4758d8d894..7e79b1a9e35f 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -206,9 +206,9 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 * on other nodes to be successful, otherwise we remain the owner of
 	 * the glock as far as dlm is concerned.
 	 */
-	if (i_gl->gl_ops->go_free) {
-		set_bit(GLF_FREEING, &i_gl->gl_flags);
-		wait_on_bit(&i_gl->gl_flags, GLF_FREEING, TASK_UNINTERRUPTIBLE);
+	if (i_gl->gl_ops->go_unlocked) {
+		set_bit(GLF_UNLOCKED, &i_gl->gl_flags);
+		wait_on_bit(&i_gl->gl_flags, GLF_UNLOCKED, TASK_UNINTERRUPTIBLE);
 	}
 
 	/*
-- 
2.45.1

