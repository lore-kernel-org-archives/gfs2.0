Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB011C4A24
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956595; cv=none; b=AK/DOS/VhgKpK8S4mfVOHkvHdumHGggJjtJkSx3ulATcFQ9+IXOfg4JvFMIUcc04J/SDsueWxDfk7sOyGzcp4o/zxrF1wZ3egk4CwfNaZisQjtA5wWGOj/VDTVV2rwNNuGnKEskLoGlRIoZsaGESgwGHxPZ039GE+QWJ7ANbPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956595; c=relaxed/simple;
	bh=8DNAsybLK+/aLWrD9CG9fXyDgEVDY0H/y1zLMC5XFRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QE7Pd6TkBdtiuR3idaGvREbmRypqEn+7jF20K2+kdBA7MLx+DbrQU0xVvLW2zvCZmKVcnePLnPnVuC0hf5Ky8OhvB+9nf6z26nyXs5SV0z4r5E6suOehj8luwx8yDMdfUve528YY1th+k+V9Oj6OYXUKS+GVPoN8mkMDQErOME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiKHcYUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiKHcYUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761956592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sl28diu6176OU13mSY0ruuIAZfC9vsUwVCq6ZDGZ14=;
	b=TiKHcYUzc4QzW3UoWErVcP0juhghbLvknj/isPnsUIbMgiC/3Fx17hafpXjrMbHvHjacEG
	CzBb38KvZXQZmZWxEjVFB7gHJhAk90GHAycPggYBJUKG39UziQWc2JSjjPuGNV15fV3rSR
	Yuyt6VPj03w1or0Mhcn2oLoYZvIXQc0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-WsrRlEBMOTipitzzVhMPIA-1; Fri,
 31 Oct 2025 20:23:11 -0400
X-MC-Unique: WsrRlEBMOTipitzzVhMPIA-1
X-Mimecast-MFC-AGG-ID: WsrRlEBMOTipitzzVhMPIA_1761956590
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2F81800675
	for <gfs2@lists.linux.dev>; Sat,  1 Nov 2025 00:23:10 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3434018004D8;
	Sat,  1 Nov 2025 00:23:08 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 21/24] gfs2: New gfs2_withdraw_helper
Date: Sat,  1 Nov 2025 00:22:30 +0000
Message-ID: <20251101002234.1286383-22-agruenba@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yPxz0yKiX3duw0tq2770vFtn-BonlwLdT4sVcUBzqW4_1761956590
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, when a gfs2 filesystem is withdrawn, an "offline" uevent is
triggered that invokes gfs2-util's gfs2_withdraw_helper script.  The
purpose of this script is to deactivate the filesystem's block device so
that it can be withdrawn immediately, even before all the filesystem's
caches have been discarded.  The script provided by gfs2-utils never did
anything useful, and there was no way for it to report back its status
to the kernel.

To fix that, extend the gfs2_withdraw_helper mechanism so that the
script can report one of the following results by writing the
corresponding value into "/sys$DEVPATH/lock_module/withdraw":

 0 - The shared block device has been marked inactive.  Future write
     operations will fail.

 1 - The shared block device may still be active and carry out
     write operations.

If the "offline" uevent isn't reacted upon within the timeout configured
in /sys$DEVPATH/tune/withdraw_helper_timeout (default 5 seconds), the
event handler is assumed to have failed.

In addition, add an additional "errors=deactivate" mount option.

With these changes, if fatal errors are detected on a gfs2 filesystem
and the filesystem is mounted with the "errors=panic" option, the kernel
will panic immediately.  Otherwise, an attempt will be made to
deactivate the underlying block device.  If successful, the kernel will
release all cluster-wide locks immediately so that the rest of the
cluster can continue.  If unsuccessful, the kernel will either panic
("errors=deactivate"), or it will purge all filesystem I/O before
releasing all cluster-wide locks ("errors=withdraw").

Note that the gfs2_withdraw_helper script still needs to be fixed to
take advantage of these improvements.  It could be changed to use a
mechanism like LVM Persistent Reservations.  "dmsetup suspend" is not a
suitable mechanism as it infinitely postpones I/O operations, which may
prevent withdraw from completing.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/incore.h     |  9 +++---
 fs/gfs2/ops_fstype.c |  9 ++++--
 fs/gfs2/super.c      |  3 ++
 fs/gfs2/sys.c        | 24 ++++++---------
 fs/gfs2/util.c       | 73 +++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 7a6ad36413d1..d05d8fe4e456 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -537,8 +537,7 @@ struct gfs2_statfs_change_host {
 
 #define GFS2_ERRORS_DEFAULT     GFS2_ERRORS_WITHDRAW
 #define GFS2_ERRORS_WITHDRAW    0
-#define GFS2_ERRORS_CONTINUE    1 /* place holder for future feature */
-#define GFS2_ERRORS_RO          2 /* place holder for future feature */
+#define GFS2_ERRORS_DEACTIVATE  1
 #define GFS2_ERRORS_PANIC       3
 
 struct gfs2_args {
@@ -554,7 +553,7 @@ struct gfs2_args {
 	unsigned int ar_data:2;			/* ordered/writeback */
 	unsigned int ar_meta:1;			/* mount metafs */
 	unsigned int ar_discard:1;		/* discard requests */
-	unsigned int ar_errors:2;               /* errors=withdraw | panic */
+	unsigned int ar_errors:2;               /* errors=withdraw | deactivate | panic */
 	unsigned int ar_nobarrier:1;            /* do not send barriers */
 	unsigned int ar_rgrplvb:1;		/* use lvbs for rgrp info */
 	unsigned int ar_got_rgrplvb:1;		/* Was the rgrplvb opt given? */
@@ -580,6 +579,7 @@ struct gfs2_tune {
 	unsigned int gt_complain_secs;
 	unsigned int gt_statfs_quantum;
 	unsigned int gt_statfs_slow;
+	unsigned int gt_withdraw_helper_timeout;
 };
 
 enum {
@@ -711,7 +711,8 @@ struct gfs2_sbd {
 	wait_queue_head_t sd_async_glock_wait;
 	atomic_t sd_glock_disposal;
 	struct completion sd_locking_init;
-	struct completion sd_wdack;
+	struct completion sd_withdraw_helper;
+	int sd_withdraw_helper_status;
 	struct delayed_work sd_control_work;
 
 	/* Inode Stuff */
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 71c327f6fadc..acd9eefd4ff3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -60,6 +60,7 @@ static void gfs2_tune_init(struct gfs2_tune *gt)
 	gt->gt_new_files_jdata = 0;
 	gt->gt_max_readahead = BIT(18);
 	gt->gt_complain_secs = 10;
+	gt->gt_withdraw_helper_timeout = 5;
 }
 
 void free_sbd(struct gfs2_sbd *sdp)
@@ -92,7 +93,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	init_waitqueue_head(&sdp->sd_async_glock_wait);
 	atomic_set(&sdp->sd_glock_disposal, 0);
 	init_completion(&sdp->sd_locking_init);
-	init_completion(&sdp->sd_wdack);
+	init_completion(&sdp->sd_withdraw_helper);
 	spin_lock_init(&sdp->sd_statfs_spin);
 
 	spin_lock_init(&sdp->sd_rindex_spin);
@@ -1395,12 +1396,14 @@ static const struct constant_table gfs2_param_data[] = {
 };
 
 enum opt_errors {
-	Opt_errors_withdraw = GFS2_ERRORS_WITHDRAW,
-	Opt_errors_panic    = GFS2_ERRORS_PANIC,
+	Opt_errors_withdraw   = GFS2_ERRORS_WITHDRAW,
+	Opt_errors_deactivate = GFS2_ERRORS_DEACTIVATE,
+	Opt_errors_panic      = GFS2_ERRORS_PANIC,
 };
 
 static const struct constant_table gfs2_param_errors[] = {
 	{"withdraw",   Opt_errors_withdraw },
+	{"deactivate", Opt_errors_deactivate },
 	{"panic",      Opt_errors_panic },
 	{}
 };
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 7e560eff9216..5b5d25e79d37 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1147,6 +1147,9 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 		case GFS2_ERRORS_WITHDRAW:
 			state = "withdraw";
 			break;
+		case GFS2_ERRORS_DEACTIVATE:
+			state = "deactivate";
+			break;
 		case GFS2_ERRORS_PANIC:
 			state = "panic";
 			break;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index db3bc4aee875..7051db9dbea0 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -425,26 +425,20 @@ static ssize_t block_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 	return len;
 }
 
-static ssize_t wdack_show(struct gfs2_sbd *sdp, char *buf)
-{
-	int val = completion_done(&sdp->sd_wdack) ? 1 : 0;
-
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+static ssize_t withdraw_helper_status_store(struct gfs2_sbd *sdp,
+					    const char *buf,
+					    size_t len)
 {
 	int ret, val;
 
 	ret = kstrtoint(buf, 0, &val);
 	if (ret)
 		return ret;
-
-	if ((val == 1) &&
-	    !strcmp(sdp->sd_lockstruct.ls_ops->lm_proto_name, "lock_dlm"))
-		complete(&sdp->sd_wdack);
-	else
+	if (val < 0 || val > 1)
 		return -EINVAL;
+
+	sdp->sd_withdraw_helper_status = val;
+	complete(&sdp->sd_withdraw_helper);
 	return len;
 }
 
@@ -591,7 +585,7 @@ static struct gfs2_attr gdlm_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
 GDLM_ATTR(proto_name,		0444, proto_name_show,		NULL);
 GDLM_ATTR(block,		0644, block_show,		block_store);
-GDLM_ATTR(withdraw,		0644, wdack_show,		wdack_store);
+GDLM_ATTR(withdraw,		0200, NULL,			withdraw_helper_status_store);
 GDLM_ATTR(jid,			0644, jid_show,			jid_store);
 GDLM_ATTR(first,		0644, lkfirst_show,		lkfirst_store);
 GDLM_ATTR(first_done,		0444, first_done_show,		NULL);
@@ -690,6 +684,7 @@ TUNE_ATTR(statfs_slow, 0);
 TUNE_ATTR(new_files_jdata, 0);
 TUNE_ATTR(statfs_quantum, 1);
 TUNE_ATTR_3(quota_scale, quota_scale_show, quota_scale_store);
+TUNE_ATTR(withdraw_helper_timeout, 1);
 
 static struct attribute *tune_attrs[] = {
 	&tune_attr_quota_warn_period.attr,
@@ -700,6 +695,7 @@ static struct attribute *tune_attrs[] = {
 	&tune_attr_statfs_quantum.attr,
 	&tune_attr_quota_scale.attr,
 	&tune_attr_new_files_jdata.attr,
+	&tune_attr_withdraw_helper_timeout.attr,
 	NULL,
 };
 
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 09fcfc04769b..ff63070ed6de 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -171,32 +171,91 @@ void gfs2_lm(struct gfs2_sbd *sdp, const char *fmt, ...)
 	va_end(args);
 }
 
+/**
+ * gfs2_offline_uevent - run gfs2_withdraw_helper
+ * @sdp: The GFS2 superblock
+ */
+static bool gfs2_offline_uevent(struct gfs2_sbd *sdp)
+{
+	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+	long timeout;
+
+	/* Skip protocol "lock_nolock" which doesn't require shared storage. */
+	if (!ls->ls_ops->lm_lock)
+		return false;
+
+	/*
+	 * The gfs2_withdraw_helper replies by writing one of the following
+	 * status codes to "/sys$DEVPATH/lock_module/withdraw":
+	 *
+	 * 0 - The shared block device has been marked inactive.  Future write
+	 *     operations will fail.
+	 *
+	 * 1 - The shared block device may still be active and carry out
+	 *     write operations.
+	 *
+	 * If the "offline" uevent isn't reacted upon in time, the event
+	 * handler is assumed to have failed.
+	 */
+
+	sdp->sd_withdraw_helper_status = -1;
+	kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
+	timeout = gfs2_tune_get(sdp, gt_withdraw_helper_timeout) * HZ;
+	wait_for_completion_timeout(&sdp->sd_withdraw_helper, timeout);
+	if (sdp->sd_withdraw_helper_status == -1) {
+		fs_err(sdp, "%s timed out\n", "gfs2_withdraw_helper");
+	} else {
+		fs_err(sdp, "%s %s with status %d\n",
+		       "gfs2_withdraw_helper",
+		       sdp->sd_withdraw_helper_status == 0 ?
+		       "succeeded" : "failed",
+		       sdp->sd_withdraw_helper_status);
+	}
+	return sdp->sd_withdraw_helper_status == 0;
+}
+
 void gfs2_withdraw_func(struct work_struct *work)
 {
 	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_withdraw_work);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	const struct lm_lockops *lm = ls->ls_ops;
+	bool device_inactive;
 
 	if (test_bit(SDF_KILL, &sdp->sd_flags))
 		return;
 
 	BUG_ON(sdp->sd_args.ar_debug);
 
-	do_withdraw(sdp);
+	/*
+	 * Try to deactivate the shared block device so that no more I/O will
+	 * go through.  If successful, we can immediately trigger remote
+	 * recovery.  Otherwise, we must first empty out all our local caches.
+	 */
 
-	kobject_uevent(&sdp->sd_kobj, KOBJ_OFFLINE);
+	device_inactive = gfs2_offline_uevent(sdp);
 
-	if (!strcmp(sdp->sd_lockstruct.ls_ops->lm_proto_name, "lock_dlm"))
-		wait_for_completion(&sdp->sd_wdack);
+	if (sdp->sd_args.ar_errors == GFS2_ERRORS_DEACTIVATE && !device_inactive)
+		panic("GFS2: fsid=%s: panic requested\n", sdp->sd_fsname);
+
+	if (lm->lm_unmount) {
+		if (device_inactive) {
+			lm->lm_unmount(sdp, false);
+			do_withdraw(sdp);
+		} else {
+			do_withdraw(sdp);
+			lm->lm_unmount(sdp, false);
+		}
+	} else {
+		do_withdraw(sdp);
+	}
 
-	if (lm->lm_unmount)
-		lm->lm_unmount(sdp, false);
 	fs_err(sdp, "file system withdrawn\n");
 }
 
 void gfs2_withdraw(struct gfs2_sbd *sdp)
 {
-	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW) {
+	if (sdp->sd_args.ar_errors == GFS2_ERRORS_WITHDRAW ||
+	    sdp->sd_args.ar_errors == GFS2_ERRORS_DEACTIVATE) {
 		if (test_and_set_bit(SDF_WITHDRAWN, &sdp->sd_flags))
 			return;
 
-- 
2.51.0

