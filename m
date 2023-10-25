Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA21380
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+dpH5os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdcRO3ymp/0WTO0PenXNdshS9aaYiahR/mgbT8R7pvQ=;
	b=I+dpH5os9pqBq1DvpAzZ0ssfzyBEnEPkEY9sbAA/7v6prfFvLqWqBZS5NVFMHWEYDROuJA
	nVS5D4LbfMXkZa7AinulWf6YAdazSpQjekh2FHrYkyMH+HkVtkyE69wxo0ijaYjVFKQ+FQ
	cpAeXrEPUZ+irDZ8MpXdTUu2/oQNrDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-acC6AsX8OSySlJH8vVtX3g-1; Tue, 24 Oct 2023 20:53:59 -0400
X-MC-Unique: acC6AsX8OSySlJH8vVtX3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C74D984B106
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD1CC40C6F79;
	Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 03/10] dlm: move root_list to ls_recover() stack
Date: Tue, 24 Oct 2023 20:53:46 -0400
Message-Id: <20231025005353.855904-3-aahringo@redhat.com>
In-Reply-To: <20231025005353.855904-1-aahringo@redhat.com>
References: <20231025005353.855904-1-aahringo@redhat.com>
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
ending of ls_recover(). In between only functionality is called doing
read only access to the root_list stack variable.

A special case is assigning the per lockspace ls_recover_dir_root_list
variable to the stack variable. The ls_recover_dir_root_list get
accessed by another concurrent process dlm_copy_master_names() during
the time between ls_recover_dir_root_list is set and set to NULL again.
This is done by a special distributed barrier functionality between
dlm_recover_members_wait() and dlm_recover_directory_wait(). A comment
was made to mention about this handling which might be changed to a
better behaviour in future. However setting the ls_recover_dir_root_list
to the stack variable and set it to NULL in this specific time will show
us potential issues with the recovery handling if it's breaks.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c          | 27 +++++++++-------------
 fs/dlm/dir.h          |  3 ++-
 fs/dlm/dlm_internal.h |  4 +---
 fs/dlm/lock.c         |  6 ++---
 fs/dlm/lock.h         |  2 +-
 fs/dlm/lockspace.c    |  2 --
 fs/dlm/recover.c      | 52 +++++++++++++------------------------------
 fs/dlm/recover.h      | 12 +++++-----
 fs/dlm/recoverd.c     | 25 ++++++++++++++-------
 9 files changed, 55 insertions(+), 78 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index f6acba4310a7..bed83ef6b8a5 100644
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
@@ -216,16 +214,14 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	if (!rv)
 		return r;
 
-	down_read(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, ls->ls_recover_dir_root_list, res_root_list) {
 		if (len == r->res_length && !memcmp(name, r->res_name, len)) {
-			up_read(&ls->ls_root_sem);
 			log_debug(ls, "find_rsb_root revert to root_list %s",
 				  r->res_name);
 			return r;
 		}
 	}
-	up_read(&ls->ls_root_sem);
+
 	return NULL;
 }
 
@@ -236,26 +232,25 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
  			   char *outbuf, int outlen, int nodeid)
 {
+	const struct list_head *root_list = READ_ONCE(ls->ls_recover_dir_root_list);
 	struct list_head *list;
 	struct dlm_rsb *r;
 	int offset = 0, dir_nodeid;
 	__be16 be_namelen;
 
-	down_read(&ls->ls_root_sem);
-
 	if (inlen > 1) {
 		r = find_rsb_root(ls, inbuf, inlen);
 		if (!r) {
 			log_error(ls, "copy_master_names from %d start %d %.*s",
 				  nodeid, inlen, inlen, inbuf);
-			goto out;
+			return;
 		}
 		list = r->res_root_list.next;
 	} else {
-		list = ls->ls_root_list.next;
+		list = root_list->next;
 	}
 
-	for (offset = 0; list != &ls->ls_root_list; list = list->next) {
+	for (offset = 0; list != root_list; list = list->next) {
 		r = list_entry(list, struct dlm_rsb, res_root_list);
 		if (r->res_nodeid)
 			continue;
@@ -278,7 +273,7 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 			memcpy(outbuf + offset, &be_namelen, sizeof(__be16));
 			offset += sizeof(__be16);
 			ls->ls_recover_dir_sent_msg++;
-			goto out;
+			return;
 		}
 
 		be_namelen = cpu_to_be16(r->res_length);
@@ -294,14 +289,12 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 	 * terminating record.
 	 */
 
-	if ((list == &ls->ls_root_list) &&
+	if ((list == root_list) &&
 	    (offset + sizeof(uint16_t) <= outlen)) {
 		be_namelen = cpu_to_be16(0xFFFF);
 		memcpy(outbuf + offset, &be_namelen, sizeof(__be16));
 		offset += sizeof(__be16);
 		ls->ls_recover_dir_sent_msg++;
 	}
- out:
-	up_read(&ls->ls_root_sem);
 }
 
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
index dfc444dad329..66c67b17d273 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -629,6 +629,7 @@ struct dlm_ls {
 	struct mutex		ls_requestqueue_mutex;
 	struct dlm_rcom		*ls_recover_buf;
 	int			ls_recover_nodeid; /* for debugging */
+	const struct list_head	*ls_recover_dir_root_list; /* root resources */
 	unsigned int		ls_recover_dir_sent_res; /* for log info */
 	unsigned int		ls_recover_dir_sent_msg; /* for log info */
 	unsigned int		ls_recover_locks_in; /* for log info */
@@ -643,9 +644,6 @@ struct dlm_ls {
 	wait_queue_head_t	ls_recover_lock_wait;
 	spinlock_t		ls_clear_proc_locks;
 
-	struct list_head	ls_root_list;	/* root resources */
-	struct rw_semaphore	ls_root_sem;	/* protect root_list */
-
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 970b8499b66f..0218645e2f90 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5185,7 +5185,7 @@ static void purge_dead_list(struct dlm_ls *ls, struct dlm_rsb *r,
 
 /* Get rid of locks held by nodes that are gone. */
 
-void dlm_recover_purge(struct dlm_ls *ls)
+void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 	struct dlm_member *memb;
@@ -5204,8 +5204,7 @@ void dlm_recover_purge(struct dlm_ls *ls)
 	if (!nodes_count)
 		return;
 
-	down_write(&ls->ls_root_sem);
-	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+	list_for_each_entry(r, root_list, res_root_list) {
 		hold_rsb(r);
 		lock_rsb(r);
 		if (is_master(r)) {
@@ -5220,7 +5219,6 @@ void dlm_recover_purge(struct dlm_ls *ls)
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
index 0455dddb0797..cf7528144827 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -580,8 +580,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_recover_list_count = 0;
 	ls->ls_local_handle = ls;
 	init_waitqueue_head(&ls->ls_wait_general);
-	INIT_LIST_HEAD(&ls->ls_root_list);
-	init_rwsem(&ls->ls_root_sem);
 
 	spin_lock(&lslist_lock);
 	ls->ls_create_count = 1;
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ce6dc914cb86..4a4345455d7f 100644
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
@@ -889,24 +879,17 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 
 /* Create a single list of all root rsb's to be used during recovery */
 
-int dlm_create_root_list(struct dlm_ls *ls)
+void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 {
 	struct rb_node *n;
 	struct dlm_rsb *r;
-	int i, error = 0;
-
-	down_write(&ls->ls_root_sem);
-	if (!list_empty(&ls->ls_root_list)) {
-		log_error(ls, "root list not empty");
-		error = -EINVAL;
-		goto out;
-	}
+	int i;
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
 		spin_lock(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			list_add(&r->res_root_list, &ls->ls_root_list);
+			list_add(&r->res_root_list, root_list);
 			dlm_hold_rsb(r);
 		}
 
@@ -914,21 +897,16 @@ int dlm_create_root_list(struct dlm_ls *ls)
 			log_error(ls, "dlm_create_root_list toss not empty");
 		spin_unlock(&ls->ls_rsbtbl[i].lock);
 	}
- out:
-	up_write(&ls->ls_root_sem);
-	return error;
 }
 
-void dlm_release_root_list(struct dlm_ls *ls)
+void dlm_release_root_list(struct list_head *root_list)
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
 
 void dlm_clear_toss(struct dlm_ls *ls)
diff --git a/fs/dlm/recover.h b/fs/dlm/recover.h
index dbc51013ecad..9dffdd825fb6 100644
--- a/fs/dlm/recover.h
+++ b/fs/dlm/recover.h
@@ -19,14 +19,16 @@ int dlm_recover_members_wait(struct dlm_ls *ls, uint64_t seq);
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
-int dlm_create_root_list(struct dlm_ls *ls);
-void dlm_release_root_list(struct dlm_ls *ls);
+void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list);
+void dlm_release_root_list(struct list_head *root_list);
 void dlm_clear_toss(struct dlm_ls *ls);
-void dlm_recover_rsbs(struct dlm_ls *ls);
+void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list);
 
 #endif				/* __RECOVER_DOT_H__ */
 
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 4d17491dea2f..f0f26a6a322c 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -50,6 +50,7 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 
 static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 {
+	LIST_HEAD(root_list);
 	unsigned long start;
 	int error, neg = 0;
 
@@ -66,7 +67,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	 * routines.
 	 */
 
-	dlm_create_root_list(ls);
+	dlm_create_root_list(ls, &root_list);
 
 	/*
 	 * Add or remove nodes from the lockspace's ls_nodes list.
@@ -82,8 +83,15 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		goto fail;
 	}
 
-	dlm_recover_dir_nodeid(ls);
+	dlm_recover_dir_nodeid(ls, &root_list);
 
+	/* Those fields are set for dlm_copy_master_names() which only
+	 * access these fields during between dlm_recover_members_wait()
+	 * and dlm_recover_directory_wait(). If ls_recover_dir_root_list
+	 * get accessed outside of ls_recover() or those functions it is
+	 * a bug and a crash will signal we having problems here.
+	 */
+	WRITE_ONCE(ls->ls_recover_dir_root_list, &root_list);
 	ls->ls_recover_dir_sent_res = 0;
 	ls->ls_recover_dir_sent_msg = 0;
 	ls->ls_recover_locks_in = 0;
@@ -117,6 +125,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		goto fail;
 	}
 
+	WRITE_ONCE(ls->ls_recover_dir_root_list, NULL);
 	log_rinfo(ls, "dlm_recover_directory %u out %u messages",
 		  ls->ls_recover_dir_sent_res, ls->ls_recover_dir_sent_msg);
 
@@ -138,14 +147,14 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
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
 			goto fail;
@@ -155,7 +164,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		 * Send our locks on remastered rsb's to the new masters.
 		 */
 
-		error = dlm_recover_locks(ls, rv->seq);
+		error = dlm_recover_locks(ls, rv->seq, &root_list);
 		if (error) {
 			log_rinfo(ls, "dlm_recover_locks error %d", error);
 			goto fail;
@@ -178,7 +187,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		 * settings.
 		 */
 
-		dlm_recover_rsbs(ls);
+		dlm_recover_rsbs(ls, &root_list);
 	} else {
 		/*
 		 * Other lockspace members may be going through the "neg" steps
@@ -194,7 +203,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 		}
 	}
 
-	dlm_release_root_list(ls);
+	dlm_release_root_list(&root_list);
 
 	/*
 	 * Purge directory-related requests that are saved in requestqueue.
@@ -244,7 +253,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	return 0;
 
  fail:
-	dlm_release_root_list(ls);
+	dlm_release_root_list(&root_list);
 	mutex_unlock(&ls->ls_recoverd_active);
 
 	return error;
-- 
2.39.3

