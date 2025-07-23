Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438F2F508E
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284128; cv=none; b=BTJkcxmoM9VoSPwSIONY5bNsn1YzgwFGz+385XXp6Sdfmob6BnqK0kU9bOQR/h6fDjaGWS+dbhAhiwvfKyRyfCR0eos/ErpamUQ0y94VmYo+Bs8T8gJddbv/I4UowWsjp/jTYnO+TdIL+Nrnhyv2ucnQ5P15B/mXkGf/B9Ya0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284128; c=relaxed/simple;
	bh=3rewIFtZkAWkk0I7iII+X3mTN5jLPrvHyDEB3DU7/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SniOaHYCMChFMBrlQQxHqcbkdO6Hp9D8uthGMuomlqQFoy4WcHRhQo3cOJ8bNLK4Ez0eMV4go3u5HBKv6JvPGOBS72wocBnv7xtstp9iGZzcCnwaBttBv3M2DTqtyv79raZB9U1+PEP87wLc0VdfWqrkTcwxuUC/JF8wYE6VLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMZ7qHEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMZ7qHEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753284125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw5HJiIdIntHEOO5MRekrMALEj3/gG4DZTeLgRN5JbA=;
	b=GMZ7qHECoQmatK2yA/dOvOzFl5EjI/vKqIwnq8vCbATR0Y9Uu+nCDjG+7Q7G2v1zAySbpK
	MmBdhiELWtreyDtfsyB095HiSnfw4NJMnHyrbL6g2od2aPXdSGMmGype4y3RuQYsFqJNTq
	l6kIBnvk3qXvHYoj2/ZrnLOky/Vd7Yc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-cH3cSyl0OFaCTh9hiLRdCA-1; Wed,
 23 Jul 2025 11:22:02 -0400
X-MC-Unique: cH3cSyl0OFaCTh9hiLRdCA-1
X-Mimecast-MFC-AGG-ID: cH3cSyl0OFaCTh9hiLRdCA_1753284121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F421956088
	for <gfs2@lists.linux.dev>; Wed, 23 Jul 2025 15:22:01 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 643E0195608D;
	Wed, 23 Jul 2025 15:22:00 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc7 2/5] dlm: introduce release parameter defines
Date: Wed, 23 Jul 2025 11:21:53 -0400
Message-ID: <20250723152156.2988833-3-aahringo@redhat.com>
In-Reply-To: <20250723152156.2988833-1-aahringo@redhat.com>
References: <20250723152156.2988833-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O_1WKDYUxbU7SH8tO8lrrsKDuNjb5LYOuO4_eKKl2h4_1753284121
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current force parameter of dlm_release_lockspace() has several
meanings and no defines for each value and renames it as option. This
patch introduces defines for each option value. Some values are only
there for checking lockspace states and return -EBUSY if necessary,
others values do special handling to report the release way (or not)
to the cluster manager in user space.

Let all upstream DLM users use those defines.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 drivers/md/md-cluster.c |  4 ++--
 fs/dlm/lockspace.c      | 20 +++++++++-----------
 fs/dlm/user.c           |  6 +++---
 fs/gfs2/lock_dlm.c      |  4 ++--
 fs/ocfs2/stack_user.c   |  2 +-
 include/linux/dlm.h     | 26 +++++++++++++++++++++++++-
 6 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 94221d964d4fd..05359bf7944d8 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -979,7 +979,7 @@ static int join(struct mddev *mddev, int nodes)
 	lockres_free(cinfo->resync_lockres);
 	lockres_free(cinfo->bitmap_lockres);
 	if (cinfo->lockspace)
-		dlm_release_lockspace(cinfo->lockspace, 2);
+		dlm_release_lockspace(cinfo->lockspace, DLM_RELEASE_NORMAL);
 	mddev->cluster_info = NULL;
 	kfree(cinfo);
 	return ret;
@@ -1042,7 +1042,7 @@ static int leave(struct mddev *mddev)
 	lockres_free(cinfo->resync_lockres);
 	lockres_free(cinfo->bitmap_lockres);
 	unlock_all_bitmaps(mddev);
-	dlm_release_lockspace(cinfo->lockspace, 2);
+	dlm_release_lockspace(cinfo->lockspace, DLM_RELEASE_NORMAL);
 	kfree(cinfo);
 	return 0;
 }
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index ee11a70def92d..be8dbf4822295 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -671,19 +671,20 @@ int dlm_new_user_lockspace(const char *name, const char *cluster,
    This is because there may be LKBs queued as ASTs that have been unlinked
    from their RSBs and are pending deletion once the AST has been delivered */
 
-static int lockspace_busy(struct dlm_ls *ls, int force)
+static int lockspace_busy(struct dlm_ls *ls, int release_option)
 {
 	struct dlm_lkb *lkb;
 	unsigned long id;
 	int rv = 0;
 
 	read_lock_bh(&ls->ls_lkbxa_lock);
-	if (force == 0) {
+	if (release_option == DLM_RELEASE_NO_LOCKS) {
 		xa_for_each(&ls->ls_lkbxa, id, lkb) {
 			rv = 1;
 			break;
 		}
-	} else if (force == 1) {
+	} else if (release_option == DLM_RELEASE_UNUSED) {
+		/* TODO: handle this UNUSED option as NO_LOCKS in later patch */
 		xa_for_each(&ls->ls_lkbxa, id, lkb) {
 			if (lkb->lkb_nodeid == 0 &&
 			    lkb->lkb_grmode != DLM_LOCK_IV) {
@@ -698,11 +699,11 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	return rv;
 }
 
-static int release_lockspace(struct dlm_ls *ls, int force)
+static int release_lockspace(struct dlm_ls *ls, int release_option)
 {
 	int busy, rv;
 
-	busy = lockspace_busy(ls, force);
+	busy = lockspace_busy(ls, release_option);
 
 	spin_lock_bh(&lslist_lock);
 	if (ls->ls_create_count == 1) {
@@ -730,7 +731,8 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force != 3 && dlm_user_daemon_available())
+	if (release_option != DLM_RELEASE_NO_EVENT &&
+	    dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
@@ -782,11 +784,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
  * lockspace must continue to function as usual, participating in recoveries,
  * until this returns.
  *
- * Force has 4 possible values:
- * 0 - don't destroy lockspace if it has any LKBs
- * 1 - destroy lockspace if it has remote LKBs but not if it has local LKBs
- * 2 - destroy lockspace regardless of LKBs
- * 3 - destroy lockspace as part of a forced shutdown
+ * See DLM_RELEASE defines for release_option values and their meaning.
  */
 
 int dlm_release_lockspace(void *lockspace, int force)
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 5cb3896be8260..51daf4acbe318 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -425,7 +425,7 @@ static int device_create_lockspace(struct dlm_lspace_params *params)
 	dlm_put_lockspace(ls);
 
 	if (error)
-		dlm_release_lockspace(lockspace, 0);
+		dlm_release_lockspace(lockspace, DLM_RELEASE_NO_LOCKS);
 	else
 		error = ls->ls_device.minor;
 
@@ -436,7 +436,7 @@ static int device_remove_lockspace(struct dlm_lspace_params *params)
 {
 	dlm_lockspace_t *lockspace;
 	struct dlm_ls *ls;
-	int error, force = 0;
+	int error, force = DLM_RELEASE_NO_LOCKS;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -446,7 +446,7 @@ static int device_remove_lockspace(struct dlm_lspace_params *params)
 		return -ENOENT;
 
 	if (params->flags & DLM_USER_LSFLG_FORCEFREE)
-		force = 2;
+		force = DLM_RELEASE_NORMAL;
 
 	lockspace = ls;
 	dlm_put_lockspace(ls);
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 7cb9d216d8bb9..082385a2e776b 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1397,7 +1397,7 @@ static int gdlm_mount(struct gfs2_sbd *sdp, const char *table)
 	return 0;
 
 fail_release:
-	dlm_release_lockspace(ls->ls_dlm, 2);
+	dlm_release_lockspace(ls->ls_dlm, DLM_RELEASE_NORMAL);
 fail_free:
 	free_recover_size(ls);
 fail:
@@ -1434,7 +1434,7 @@ static void gdlm_unmount(struct gfs2_sbd *sdp)
 	/* mounted_lock and control_lock will be purged in dlm recovery */
 release:
 	if (ls->ls_dlm) {
-		dlm_release_lockspace(ls->ls_dlm, 2);
+		dlm_release_lockspace(ls->ls_dlm, DLM_RELEASE_NORMAL);
 		ls->ls_dlm = NULL;
 	}
 
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 77edcd70f72c2..fe3224cc6e0b0 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -959,7 +959,7 @@ static const struct dlm_lockspace_ops ocfs2_ls_ops = {
 static int user_cluster_disconnect(struct ocfs2_cluster_connection *conn)
 {
 	version_unlock(conn);
-	dlm_release_lockspace(conn->cc_lockspace, 2);
+	dlm_release_lockspace(conn->cc_lockspace, DLM_RELEASE_NORMAL);
 	conn->cc_lockspace = NULL;
 	ocfs2_live_connection_drop(conn->cc_private);
 	conn->cc_private = NULL;
diff --git a/include/linux/dlm.h b/include/linux/dlm.h
index bacda9898f2b6..cc7a36244893d 100644
--- a/include/linux/dlm.h
+++ b/include/linux/dlm.h
@@ -87,13 +87,37 @@ int dlm_new_lockspace(const char *name, const char *cluster,
 		      const struct dlm_lockspace_ops *ops, void *ops_arg,
 		      int *ops_result, dlm_lockspace_t **lockspace);
 
+/*
+ * dlm_release_lockspace() release_option values:
+ *
+ * DLM_RELEASE_NO_LOCKS returns -EBUSY if any locks (lkb's)
+ *   exist in the local lockspace.
+ *
+ * DLM_RELEASE_UNUSED previous value that is no longer used.
+ *
+ * DLM_RELEASE_NORMAL releases the lockspace regardless of any
+ *   locks managed in the local lockspace.
+ *
+ * DLM_RELEASE_NO_EVENT release the lockspace regardless of any
+ *   locks managed in the local lockspace, and does not submit
+ *   a leave event to the cluster manager, so other nodes will
+ *   not be notified that the node should be removed from the
+ *   list of lockspace members.
+ */
+#define DLM_RELEASE_NO_LOCKS		0
+#define DLM_RELEASE_UNUSED		1
+#define DLM_RELEASE_NORMAL		2
+#define DLM_RELEASE_NO_EVENT		3
+
 /*
  * dlm_release_lockspace
  *
  * Stop a lockspace.
+ *
+ * release_option: see DLM_RELEASE values above.
  */
 
-int dlm_release_lockspace(dlm_lockspace_t *lockspace, int force);
+int dlm_release_lockspace(dlm_lockspace_t *lockspace, int release_option);
 
 /*
  * dlm_lock
-- 
2.43.0

