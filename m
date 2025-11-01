Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CA1C4A24
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956566; cv=none; b=juIa6JzvIuDuQRlY8UqUKuHGR7ZpZ3fVnb5ffbGzX6G6+acVu4V38zEJGawbpb9OM/OxZrLNlyN+kfEDHzQJUXeruOcExwL9GX35BnY2vjbsHTzYSONo4LwnCZOdf8GQahquAZsGdD1AiGi31EIOBE7e+i22Xyt1cLFwtkTEfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956566; c=relaxed/simple;
	bh=XUW43N4T611Ay9yCd1G/VRh0WhOZSLYKl6Qpv8Mgi2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Vf+oaO/sW6OEl1S79k+te5uJUh/u2stJW83Wvs9wA8CQE6HDbs63/ohUZxr7malm0Y3OL1rDLnLpSirTqNcTysWiCwlxmElvAbbMmtOQfsvsR0X3eJn32SiNHkubbAfbyVqHbY1Qp4vpF7wZROeRnDSdrmdLhIv0fDuvHa7KU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8n4B5kI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8n4B5kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pK8YGVJAMhg5jJVVi+EN5Lo2nLXj/2IvjQ4xiqHYdBA=;
	b=W8n4B5kIYzW+vEyQIn6efcYP2ATtWm6mF7zfdRuQM2HG8444SCpzP7VPUvkBcqmEb0x/ZQ
	QWSZ1XtN996EnH0oUwPWLcj8Piqv26BQnz48yo20gEql+IQPOWfMrs2mnbvZgi9CXtlSsD
	Q/cj+9RRJE3e9qFMc+XBlEPeOQmTznI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-CmkZpGAQNHKoVQoivYNIxg-1; Fri,
 31 Oct 2025 20:22:40 -0400
X-MC-Unique: CmkZpGAQNHKoVQoivYNIxg-1
X-Mimecast-MFC-AGG-ID: CmkZpGAQNHKoVQoivYNIxg_1761956560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE85E19560B7
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:22:39 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2843180035A;
	Sat,  1 Nov 2025 00:22:38 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 02/24] gfs2: Asynchronous withdraw
Date: Sat,  1 Nov 2025 00:22:11 +0000
Message-ID: <20251101002234.1286383-3-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2nL0RR3zJ6KtMCPUjW3rkBrTSNbtqHOH4MH2rihpC1o_1761956560
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

So far, withdraws are carried out in the context of the calling task.
When another task tries to withdraw while a withdraw is already
underway, that task blocks as well.  Change that to carry out withdraws
asynchronously in workqueue context and don't block the task triggering
the withdraw anymore.

Fixes: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/ops_fstype.c |  2 ++
 fs/gfs2/super.c      |  2 +-
 fs/gfs2/util.c       | 55 +++++++++++++++++++++++++-------------------
 fs/gfs2/util.h       |  2 ++
 5 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 5a0ea416cfda..db0e72adb999 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -716,6 +716,7 @@ struct gfs2_sbd {
 	struct gfs2_glock *sd_rename_gl;
 	struct gfs2_glock *sd_freeze_gl;
 	struct work_struct sd_freeze_work;
+	struct work_struct sd_withdraw_work;
 	wait_queue_head_t sd_kill_wait;
 	wait_queue_head_t sd_async_glock_wait;
 	atomic_t sd_glock_disposal;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index a29e81b3e954..553cf6d922c0 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1215,6 +1215,8 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (error)
 		goto fail_debug;
 
+	INIT_WORK(&sdp->sd_withdraw_work, gfs2_withdraw_func);
+
 	error = init_locking(sdp, &mount_gh, DO);
 	if (error)
 		goto fail_lm;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 644b2d1e7276..a6e898861412 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -603,7 +603,7 @@ static void gfs2_put_super(struct super_block *sb)
 		gfs2_quota_cleanup(sdp);
 	}
 
-	WARN_ON(gfs2_withdrawing(sdp));
+	flush_work(&sdp->sd_withdraw_work);
 
 	/*  At this point, we're through modifying the disk  */
 
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 27fdcbce2d75..c454bea101de 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -309,43 +309,50 @@ void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
 	va_end(args);
 }
 
-void gfs2_withdraw(struct gfs2_sbd *sdp)
+void gfs2_withdraw_func(struct work_struct *work)
 {
+	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_withdraw_work);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	const struct lm_lockops *lm = ls->ls_ops;
 
+	if (test_bit(SDF_KILL, &sdp->sd_flags))
+		return;
+
+	BUG_ON(sdp->sd_args.ar_debug);
+
+	signal_our_withdraw(sdp);
+
+	kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
+
+	if (!strcmp(sdp->sd_lockstruct.ls_ops->lm_proto_name, "lock_dlm"))
+		wait_for_completion(&sdp->sd_wdack);
+
+	if (lm->lm_unmount)
+		lm->lm_unmount(sdp, false);
+	fs_err(sdp, "file system withdrawn\n");
+	clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
+}
+
+void gfs2_withdraw(struct gfs2_sbd *sdp)
+{
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
 		unsigned long old = READ_ONCE(sdp->sd_flags), new;
 
 		do {
-			if (old & BIT(SDF_WITHDRAWN)) {
-				wait_on_bit(&sdp->sd_flags,
-					    SDF_WITHDRAW_IN_PROG,
-					    TASK_UNINTERRUPTIBLE);
+			if (old & BIT(SDF_WITHDRAWN))
 				return;
-			}
 			new = old | BIT(SDF_WITHDRAWN) | BIT(SDF_WITHDRAW_IN_PROG);
 		} while (unlikely(!try_cmpxchg(&sdp->sd_flags, &old, new)));
 
-		fs_err(sdp, "about to withdraw this file system\n");
-		BUG_ON(sdp->sd_args.ar_debug);
-
-		signal_our_withdraw(sdp);
-
-		kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
-
-		if (!strcmp(sdp->sd_lockstruct.ls_ops->lm_proto_name, "lock_dlm"))
-			wait_for_completion(&sdp->sd_wdack);
-
-		if (lm->lm_unmount) {
-			fs_err(sdp, "telling LM to unmount\n");
-			lm->lm_unmount(sdp, false);
-		}
-		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
-		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
-		smp_mb__after_atomic();
-		wake_up_bit(&sdp->sd_flags, SDF_WITHDRAW_IN_PROG);
+		/*
+		 * There is no need to withdraw when the superblock hasn't been
+		 * fully initialized, yet.
+		 */
+		if (!(sdp->sd_vfs->s_flags & SB_BORN))
+			return;
+		fs_err(sdp, "about to withdraw this file system\n");
+		schedule_work(&sdp->sd_withdraw_work);
 	}
 
 	if (sdp->sd_args.ar_errors == GFS2_ERRORS_PANIC)
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index da0373b1e82b..f424ef2523c4 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -232,6 +232,8 @@ gfs2_tune_get_i(&(sdp)->sd_tune, &(sdp)->sd_tune.field)
 
 __printf(2, 3)
 void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...);
+
+void gfs2_withdraw_func(struct work_struct *work);
 void gfs2_withdraw(struct gfs2_sbd *sdp);
 
 #endif /* __UTIL_DOT_H__ */
-- 
2.51.0

