Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8915B963
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085505; cv=none; b=A8UK/OT6eUHYzoMKoglGns53jPLv5BvMYngX2hAN3Bt/tpKxjiDEYrOHjvaDoSlwB4ACtEhpFXUCWwLwZXBkw7VUTXqVpen7QFX++CpoS7teNQEVoW+hBdRWEE3MbvwmGMNZETx3lzUgdh3kjj/umJsdhM6h8NtwDGrcfsz6WRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085505; c=relaxed/simple;
	bh=pDjxqT3tEuU0Hd9uBeSKwtGTnWiRxgmrsYG3M/dNxZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBzizKXEm9xo18CYT1AyMSJzH2XYbhpC+0ualMO6JQ+QmiBAKuhUGgBIJsrE/+uqeQYEeSRaZSg+YA2IjPnycs7c9QCGUtxNnOeGFCS68NYv6VSQ+RdTggUvyai7PFPWNgtVnpyI8wI/r4wnFzqpqgT1D5s7XcP32j3NDAHi/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlecsJRE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlecsJRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvb1RcSAFymzOmTUVg6x9+/dVkNGX7WBRd2e/EjiDfA=;
	b=DlecsJREM2WQfwC1eVsiU8meO6TXGGilv3j8o5tp9yTbRvsIBLGh2OwvPWpIvyBOGBF1x0
	zhDmavSwV3ysCE+oktYWyA9NCZppq2xZb1PJVbrK7roJB9ntSELeqJnzBvLhUaJ5n8UxXx
	lxl/Ry63LSdqObO93+Fo37sHjPjUF10=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-CsZ1rFTVNrub5s_w04y36A-1; Tue,
 02 Apr 2024 15:18:19 -0400
X-MC-Unique: CsZ1rFTVNrub5s_w04y36A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DAAE29ABA0A
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 823DF40C6CBF;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 06/15] dlm: move root_list to ls_recover() stack
Date: Tue,  2 Apr 2024 15:18:01 -0400
Message-ID: <20240402191810.1932939-7-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch moves the per lockspace ls_root_list list which is mainly
used for snapshoting all dlm_rsb from a hash to a list to do recovery
handling into the recovery function ls_recover() as stack variable.

Doing that shows that there is no need for locking the ls_root_list
which is created at the beginning of ls_recover() and destroyed at the
ending of ls_recover(). As there can't be concurrent execution of
ls_recover() at one time it should be safe to store all rsbs in the
ls_root_list and using the rsbs res_root_list holder.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c          |  6 ++---
 fs/dlm/dir.h          |  3 ++-
 fs/dlm/dlm_internal.h |  6 ++---
 fs/dlm/lock.c         |  6 ++---
 fs/dlm/lock.h         |  2 +-
 fs/dlm/lockspace.c    |  2 --
 fs/dlm/recover.c      | 30 ++++++++----------------
 fs/dlm/recover.h      |  8 ++++---
 fs/dlm/recoverd.c     | 54 ++++++++++++++++++-------------------------
 9 files changed, 47 insertions(+), 70 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index 10753486049a..3da00c46cbb3 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -47,15 +47,13 @@ int dlm_dir_nodeid(struct dlm_rsb *r)
 	return r->res_dir_nodeid;
 }
 
-void dlm_recover_dir_nodeid(struct dlm_ls *ls)
+void dlm_recover_dir_nodeid(struct dlm_ls *ls, const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		r->res_dir_nodeid = dlm_hash2nodeid(ls, r->res_hash);
 	}
-	up_read(&ls->ls_root_sem);
 }
 
 int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
diff --git a/fs/dlm/dir.h b/fs/dlm/dir.h
index 39ecb69d7ef3..5b2a7ee3762d 100644
--- a/fs/dlm/dir.h
+++ b/fs/dlm/dir.h
@@ -14,7 +14,8 @@
 
 int dlm_dir_nodeid(struct dlm_rsb *rsb);
 int dlm_hash2nodeid(struct dlm_ls *ls, uint32_t hash);
-void dlm_recover_dir_nodeid(struct dlm_ls *ls);
+void dlm_recover_dir_nodeid(struct dlm_ls *ls,
+			    const struct list_head *root_list);
 int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq);
 void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 			   char *outbuf, int outlen, int nodeid);
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 3524f2b33f2c..f434325d5bc8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -674,10 +674,8 @@ struct dlm_ls {
 	wait_queue_head_t	ls_recover_lock_wait;
 	spinlock_t		ls_clear_proc_locks;
 
-	struct list_head	ls_root_list;	/* root resources */
-	struct rw_semaphore	ls_root_sem;	/* protect root_list */
-	struct list_head	ls_masters_list;	/* root resources */
-	rwlock_t		ls_masters_lock;	/* protect root_list */
+	struct list_head	ls_masters_list; /* root resources */
+	rwlock_t		ls_masters_lock; /* protect root_list */
 
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index e0ab7432ca4d..43a2f4d0af53 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5227,7 +5227,7 @@ static void purge_dead_list(struct dlm_ls *ls, struct dlm_rsb *r,
 
 /* Get rid of locks held by nodes that are gone. */
 
-void dlm_recover_purge(struct dlm_ls *ls)
+void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 	struct dlm_member *memb;
@@ -5246,8 +5246,7 @@ void dlm_recover_purge(struct dlm_ls *ls)
 	if (!nodes_count)
 		return;
 
-	down_write(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		hold_rsb(r);
 		lock_rsb(r);
 		if (is_master(r)) {
@@ -5262,7 +5261,6 @@ void dlm_recover_purge(struct dlm_ls *ls)
 		unhold_rsb(r);
 		cond_resched();
 	}
-	up_write(&ls->ls_root_sem);
 
 	if (lkb_count)
 		log_rinfo(ls, "dlm_recover_purge %u locks for %u nodes",
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b54e2cbbe6e2..c8ff7780d3cc 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -31,7 +31,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 int dlm_search_rsb_tree(struct rb_root *tree, const void *name, int len,
 			struct dlm_rsb **r_ret);
 
-void dlm_recover_purge(struct dlm_ls *ls);
+void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list);
 void dlm_purge_mstcpy_locks(struct dlm_rsb *r);
 void dlm_recover_grant(struct dlm_ls *ls);
 int dlm_recover_waiters_post(struct dlm_ls *ls);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index c427c76b5f07..da756e5c0f6c 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -580,8 +580,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_recover_list_count = 0;
 	ls->ls_local_handle = ls;
 	init_waitqueue_head(&ls->ls_wait_general);
-	INIT_LIST_HEAD(&ls->ls_root_list);
-	init_rwsem(&ls->ls_root_sem);
 	INIT_LIST_HEAD(&ls->ls_masters_list);
 	rwlock_init(&ls->ls_masters_lock);
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 6abc283f8f36..172c6b73f37a 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -519,7 +519,8 @@ static int recover_master_static(struct dlm_rsb *r, unsigned int *count)
  * the correct dir node.
  */
 
-int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
+int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq,
+			const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 	unsigned int total = 0;
@@ -529,10 +530,8 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 
 	log_rinfo(ls, "dlm_recover_masters");
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		if (dlm_recovery_stopped(ls)) {
-			up_read(&ls->ls_root_sem);
 			error = -EINTR;
 			goto out;
 		}
@@ -546,12 +545,9 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 		cond_resched();
 		total++;
 
-		if (error) {
-			up_read(&ls->ls_root_sem);
+		if (error)
 			goto out;
-		}
 	}
-	up_read(&ls->ls_root_sem);
 
 	log_rinfo(ls, "dlm_recover_masters %u of %u", count, total);
 
@@ -656,13 +652,13 @@ static int recover_locks(struct dlm_rsb *r, uint64_t seq)
 	return error;
 }
 
-int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq)
+int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq,
+		      const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 	int error, count = 0;
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		if (is_master(r)) {
 			rsb_clear_flag(r, RSB_NEW_MASTER);
 			continue;
@@ -673,19 +669,15 @@ int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq)
 
 		if (dlm_recovery_stopped(ls)) {
 			error = -EINTR;
-			up_read(&ls->ls_root_sem);
 			goto out;
 		}
 
 		error = recover_locks(r, seq);
-		if (error) {
-			up_read(&ls->ls_root_sem);
+		if (error)
 			goto out;
-		}
 
 		count += r->res_recover_locks_count;
 	}
-	up_read(&ls->ls_root_sem);
 
 	log_rinfo(ls, "dlm_recover_locks %d out", count);
 
@@ -854,13 +846,12 @@ static void recover_grant(struct dlm_rsb *r)
 		rsb_set_flag(r, RSB_RECOVER_GRANT);
 }
 
-void dlm_recover_rsbs(struct dlm_ls *ls)
+void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 	unsigned int count = 0;
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		lock_rsb(r);
 		if (is_master(r)) {
 			if (rsb_flag(r, RSB_RECOVER_CONVERT))
@@ -881,7 +872,6 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 		rsb_clear_flag(r, RSB_NEW_MASTER2);
 		unlock_rsb(r);
 	}
-	up_read(&ls->ls_root_sem);
 
 	if (count)
 		log_rinfo(ls, "dlm_recover_rsbs %d done", count);
diff --git a/fs/dlm/recover.h b/fs/dlm/recover.h
index 0b54550ee055..efc79a6e577d 100644
--- a/fs/dlm/recover.h
+++ b/fs/dlm/recover.h
@@ -19,12 +19,14 @@ int dlm_recover_members_wait(struct dlm_ls *ls, uint64_t seq);
 int dlm_recover_directory_wait(struct dlm_ls *ls, uint64_t seq);
 int dlm_recover_locks_wait(struct dlm_ls *ls, uint64_t seq);
 int dlm_recover_done_wait(struct dlm_ls *ls, uint64_t seq);
-int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq);
+int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq,
+			const struct list_head *root_list);
 int dlm_recover_master_reply(struct dlm_ls *ls, const struct dlm_rcom *rc);
-int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq);
+int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq,
+		      const struct list_head *root_list);
 void dlm_recovered_lock(struct dlm_rsb *r);
 void dlm_clear_toss(struct dlm_ls *ls);
-void dlm_recover_rsbs(struct dlm_ls *ls);
+void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list);
 
 #endif				/* __RECOVER_DOT_H__ */
 
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index dfce8fc6a783..f6acc7351625 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -62,23 +62,17 @@ static void dlm_release_masters_list(struct dlm_ls *ls)
 	write_unlock(&ls->ls_masters_lock);
 }
 
-static void dlm_create_root_list(struct dlm_ls *ls)
+static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 {
 	struct rb_node *n;
 	struct dlm_rsb *r;
 	int i;
 
-	down_write(&ls->ls_root_sem);
-	if (!list_empty(&ls->ls_root_list)) {
-		log_error(ls, "root list not empty");
-		goto out;
-	}
-
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
 		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			list_add(&r->res_root_list, &ls->ls_root_list);
+			list_add(&r->res_root_list, root_list);
 			dlm_hold_rsb(r);
 		}
 
@@ -86,20 +80,16 @@ static void dlm_create_root_list(struct dlm_ls *ls)
 			log_error(ls, "%s toss not empty", __func__);
 		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
- out:
-	up_write(&ls->ls_root_sem);
 }
 
-static void dlm_release_root_list(struct dlm_ls *ls)
+static void dlm_release_root_list(struct list_head *root_list)
 {
 	struct dlm_rsb *r, *safe;
 
-	down_write(&ls->ls_root_sem);
-	list_for_each_entry_safe(r, safe, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry_safe(r, safe, root_list, res_root_list) {
 		list_del_init(&r->res_root_list);
 		dlm_put_rsb(r);
 	}
-	up_write(&ls->ls_root_sem);
 }
 
 /* If the start for which we're re-enabling locking (seq) has been superseded
@@ -131,6 +121,7 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 
 static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 {
+	LIST_HEAD(root_list);
 	unsigned long start;
 	int error, neg = 0;
 
@@ -147,7 +138,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	 * routines.
 	 */
 
-	dlm_create_root_list(ls);
+	dlm_create_root_list(ls, &root_list);
 
 	/*
 	 * Add or remove nodes from the lockspace's ls_nodes list.
@@ -163,7 +154,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		goto fail;
 	}
 
-	dlm_recover_dir_nodeid(ls);
+	dlm_recover_dir_nodeid(ls, &root_list);
 
 	/* Create a snapshot of all active rsbs were we are the master of.
 	 * During the barrier between dlm_recover_members_wait() and
@@ -179,7 +170,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_create_masters_list(ls);
 	if (error) {
 		log_rinfo(ls, "dlm_create_masters_list error %d", error);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	ls->ls_recover_dir_sent_res = 0;
@@ -192,7 +183,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	if (error) {
 		log_rinfo(ls, "dlm_recover_members_wait error %d", error);
 		dlm_release_masters_list(ls);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	start = jiffies;
@@ -206,7 +197,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	if (error) {
 		log_rinfo(ls, "dlm_recover_directory error %d", error);
 		dlm_release_masters_list(ls);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	dlm_set_recover_status(ls, DLM_RS_DIR);
@@ -215,7 +206,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	if (error) {
 		log_rinfo(ls, "dlm_recover_directory_wait error %d", error);
 		dlm_release_masters_list(ls);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	dlm_release_masters_list(ls);
@@ -233,7 +224,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 
 	if (dlm_recovery_stopped(ls)) {
 		error = -EINTR;
-		goto fail;
+		goto fail_root_list;
 	}
 
 	if (neg || dlm_no_directory(ls)) {
@@ -241,27 +232,27 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		 * Clear lkb's for departed nodes.
 		 */
 
-		dlm_recover_purge(ls);
+		dlm_recover_purge(ls, &root_list);
 
 		/*
 		 * Get new master nodeid's for rsb's that were mastered on
 		 * departed nodes.
 		 */
 
-		error = dlm_recover_masters(ls, rv->seq);
+		error = dlm_recover_masters(ls, rv->seq, &root_list);
 		if (error) {
 			log_rinfo(ls, "dlm_recover_masters error %d", error);
-			goto fail;
+			goto fail_root_list;
 		}
 
 		/*
 		 * Send our locks on remastered rsb's to the new masters.
 		 */
 
-		error = dlm_recover_locks(ls, rv->seq);
+		error = dlm_recover_locks(ls, rv->seq, &root_list);
 		if (error) {
 			log_rinfo(ls, "dlm_recover_locks error %d", error);
-			goto fail;
+			goto fail_root_list;
 		}
 
 		dlm_set_recover_status(ls, DLM_RS_LOCKS);
@@ -269,7 +260,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		error = dlm_recover_locks_wait(ls, rv->seq);
 		if (error) {
 			log_rinfo(ls, "dlm_recover_locks_wait error %d", error);
-			goto fail;
+			goto fail_root_list;
 		}
 
 		log_rinfo(ls, "dlm_recover_locks %u in",
@@ -281,7 +272,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		 * settings.
 		 */
 
-		dlm_recover_rsbs(ls);
+		dlm_recover_rsbs(ls, &root_list);
 	} else {
 		/*
 		 * Other lockspace members may be going through the "neg" steps
@@ -293,11 +284,11 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		error = dlm_recover_locks_wait(ls, rv->seq);
 		if (error) {
 			log_rinfo(ls, "dlm_recover_locks_wait error %d", error);
-			goto fail;
+			goto fail_root_list;
 		}
 	}
 
-	dlm_release_root_list(ls);
+	dlm_release_root_list(&root_list);
 
 	/*
 	 * Purge directory-related requests that are saved in requestqueue.
@@ -346,8 +337,9 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 
 	return 0;
 
+ fail_root_list:
+	dlm_release_root_list(&root_list);
  fail:
-	dlm_release_root_list(ls);
 	mutex_unlock(&ls->ls_recoverd_active);
 
 	return error;
-- 
2.43.0

