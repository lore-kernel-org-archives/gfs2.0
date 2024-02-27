Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BC5C82
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998567; cv=none; b=bSIf1I+7E4WsnBQ8kFxYXC3Phs9XcE4OKJbaWEBbJyx2RKfGeeVrAJijqPuaO+ZQqgIl7yB6w/sDgjG2BawfptKdYOA67zPMZzkOxbtG8CBAyIMgAZp91C0vQ4TYhk9E+2XdA4+wxsjexfcHJuJ/mpRjUZmic1NkJregTc2HBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998567; c=relaxed/simple;
	bh=en2qDOXa7Y5hfI9TpFMzQ4VL+6qbQbmi8J771r921Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si2oosOTt/dIa7mWzK+Ax7zBO8uTAViIyriU0Vfsq/Ni4An5q8CSfNwX4sOe7uCvOVPtH3FXCpaVZYFb1ueI3qtRDXSjL9XxqIXyzLQrkENoD1agnNaN3ofqdiF0LWztRRSuW6SMyp23nO2wxEdWe0M5r48LcdksL3J/aK1/AEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvYRy35I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvYRy35I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doxvk8P5m46JbMRWpEkiv/Vlgg4kqNgNJVaCt0ic654=;
	b=QvYRy35ItTexARxSFBoboTuShLVZyAU56KrHWZWritcMx5c96DjWI64j14OLzBgK9A3QnL
	lFb2928wCDBrkturQcG5Zcwt0+v8jpFejuISzrpDzSu3rsN19uA05LU3Sq8rFq462nV/0P
	5OKKDrX+6U6z0PK7vyZfaMHn+WlPWpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-ykEtCq-0PjqkVSH4aDfulw-1; Mon,
 26 Feb 2024 20:49:19 -0500
X-MC-Unique: ykEtCq-0PjqkVSH4aDfulw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C35D3C1CC57
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 522E32166AE9;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 12/18] dlm: convert ls_waiters_mutex to spinlock
Date: Mon, 26 Feb 2024 20:49:03 -0500
Message-ID: <20240227014909.93945-13-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch converts the per dlm lockspace waiters lock from a mutex to a
spinlock.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     |  4 ++--
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 20 ++++++++++----------
 fs/dlm/lockspace.c    |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index b9deffeabbd1..8e7683840315 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -824,7 +824,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 
 	mutex_lock(&debug_buf_lock);
 	dlm_lock_recovery(ls);
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	memset(debug_buf, 0, sizeof(debug_buf));
 
 	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
@@ -835,7 +835,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 			break;
 		pos += ret;
 	}
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	dlm_unlock_recovery(ls);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 9aa1e3a09e02..5975d52f4061 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -565,7 +565,7 @@ struct dlm_ls {
 	struct dlm_rsbtable	*ls_rsbtbl;
 	uint32_t		ls_rsbtbl_size;
 
-	struct mutex		ls_waiters_mutex;
+	spinlock_t		ls_waiters_lock;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
 	struct mutex		ls_orphans_mutex;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index bd9ff32984c7..525635f42938 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1407,7 +1407,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 	int error = 0;
 	int wc;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 
 	if (is_overlap_unlock(lkb) ||
 	    (is_overlap_cancel(lkb) && (mstype == DLM_MSG_CANCEL))) {
@@ -1447,7 +1447,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 		log_error(ls, "addwait error %x %d flags %x %d %d %s",
 			  lkb->lkb_id, error, dlm_iflags_val(lkb), mstype,
 			  lkb->lkb_wait_type, lkb->lkb_resource->res_name);
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1546,9 +1546,9 @@ static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	error = _remove_from_waiters(lkb, mstype, NULL);
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1566,13 +1566,13 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 	int error;
 
 	if (!local)
-		mutex_lock(&ls->ls_waiters_mutex);
+		spin_lock(&ls->ls_waiters_lock);
 	else
 		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
 			     !dlm_locking_stopped(ls));
 	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
 	if (!local)
-		mutex_unlock(&ls->ls_waiters_mutex);
+		spin_unlock(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -4990,7 +4990,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb = NULL, *iter;
 
-	mutex_lock(&ls->ls_waiters_mutex);
+	spin_lock(&ls->ls_waiters_lock);
 	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
 		if (test_bit(DLM_IFL_RESEND_BIT, &iter->lkb_iflags)) {
 			hold_lkb(iter);
@@ -4998,7 +4998,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 			break;
 		}
 	}
-	mutex_unlock(&ls->ls_waiters_mutex);
+	spin_unlock(&ls->ls_waiters_lock);
 
 	return lkb;
 }
@@ -5062,14 +5062,14 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		/* drop all wait_count references we still
 		 * hold a reference for this iteration.
 		 */
-		mutex_lock(&ls->ls_waiters_mutex);
+		spin_lock(&ls->ls_waiters_lock);
 		while (atomic_read(&lkb->lkb_wait_count)) {
 			if (atomic_dec_and_test(&lkb->lkb_wait_count))
 				list_del_init(&lkb->lkb_wait_reply);
 
 			unhold_lkb(lkb);
 		}
-		mutex_unlock(&ls->ls_waiters_mutex);
+		spin_unlock(&ls->ls_waiters_lock);
 
 		if (oc || ou) {
 			/* do an unlock or cancel instead of resending */
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 5fe00bd1164d..42866190af38 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -515,7 +515,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	spin_lock_init(&ls->ls_lkbidr_spin);
 
 	INIT_LIST_HEAD(&ls->ls_waiters);
-	mutex_init(&ls->ls_waiters_mutex);
+	spin_lock_init(&ls->ls_waiters_lock);
 	INIT_LIST_HEAD(&ls->ls_orphans);
 	mutex_init(&ls->ls_orphans_mutex);
 
-- 
2.43.0

