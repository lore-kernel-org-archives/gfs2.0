Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B1930FA7
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo+d6nNKE+EIchcN7YW+XEiU6sgPMrNfhdkIflmsjKg=;
	b=dw05GDvMmhsQle8KDMo9XYFBAvSKORJGA3ppBZhhAlJ191R7yXJnwbT0TLHZSLkFvoeHQP
	DGMsBfTpu6+R8VYn7EnRnbw0XDWvSnG2p3/Cxyimj8CVZHgMKK9FSunpy54NZtfevlcLDG
	l60qTrO+hjLSRuz72eaUtl4ubT6v+q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-bv-Whpc0NOGzBMjp_uE-zA-1; Fri, 08 Sep 2023 16:46:24 -0400
X-MC-Unique: bv-Whpc0NOGzBMjp_uE-zA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B195F801FA9
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 892D821EE56A;
	Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 07/10] fs: dlm: ls_root_lock semaphore to rwlock
Date: Fri,  8 Sep 2023 16:46:08 -0400
Message-Id: <20230908204611.1910601-7-aahringo@redhat.com>
In-Reply-To: <20230908204611.1910601-1-aahringo@redhat.com>
References: <20230908204611.1910601-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch converts the ls_root_lock semaphore to a rwlock to not
sleep during dlm message processing.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dir.c          | 14 +++++++-------
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         |  4 ++--
 fs/dlm/lockspace.c    |  2 +-
 fs/dlm/recover.c      | 28 ++++++++++++++--------------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index f6acba4310a7..c70e286f3dbc 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -51,11 +51,11 @@ void dlm_recover_dir_nodeid(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		r->res_dir_nodeid = dlm_hash2nodeid(ls, r->res_hash);
 	}
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 }
 
 int dlm_recover_directory(struct dlm_ls *ls, uint64_t seq)
@@ -216,16 +216,16 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	if (!rv)
 		return r;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		if (len == r->res_length && !memcmp(name, r->res_name, len)) {
-			up_read(&ls->ls_root_sem);
+			read_unlock(&ls->ls_root_lock);
 			log_debug(ls, "find_rsb_root revert to root_list %s",
 				  r->res_name);
 			return r;
 		}
 	}
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 	return NULL;
 }
 
@@ -241,7 +241,7 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 	int offset = 0, dir_nodeid;
 	__be16 be_namelen;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 
 	if (inlen > 1) {
 		r = find_rsb_root(ls, inbuf, inlen);
@@ -302,6 +302,6 @@ void dlm_copy_master_names(struct dlm_ls *ls, const char *inbuf, int inlen,
 		ls->ls_recover_dir_sent_msg++;
 	}
  out:
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 }
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 65db6f834f04..9106e20e6c20 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -642,7 +642,7 @@ struct dlm_ls {
 	spinlock_t		ls_clear_proc_locks;
 
 	struct list_head	ls_root_list;	/* root resources */
-	struct rw_semaphore	ls_root_sem;	/* protect root_list */
+	rwlock_t		ls_root_lock;	/* protect root_list */
 
 	const struct dlm_lockspace_ops *ls_ops;
 	void			*ls_ops_arg;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 989603643c03..1031f233a3ad 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5216,7 +5216,7 @@ void dlm_recover_purge(struct dlm_ls *ls)
 	if (!nodes_count)
 		return;
 
-	down_write(&ls->ls_root_sem);
+	write_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		hold_rsb(r);
 		lock_rsb(r);
@@ -5231,7 +5231,7 @@ void dlm_recover_purge(struct dlm_ls *ls)
 		unlock_rsb(r);
 		unhold_rsb(r);
 	}
-	up_write(&ls->ls_root_sem);
+	write_unlock(&ls->ls_root_lock);
 
 	if (lkb_count)
 		log_rinfo(ls, "dlm_recover_purge %u locks for %u nodes",
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index b2cb0621031f..265d69752b90 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -579,7 +579,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_local_handle = ls;
 	init_waitqueue_head(&ls->ls_wait_general);
 	INIT_LIST_HEAD(&ls->ls_root_list);
-	init_rwsem(&ls->ls_root_sem);
+	rwlock_init(&ls->ls_root_lock);
 
 	spin_lock(&lslist_lock);
 	ls->ls_create_count = 1;
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 752002304ca9..0d5b0f94eb46 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -529,10 +529,10 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 
 	log_rinfo(ls, "dlm_recover_masters");
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		if (dlm_recovery_stopped(ls)) {
-			up_read(&ls->ls_root_sem);
+			read_unlock(&ls->ls_root_lock);
 			error = -EINTR;
 			goto out;
 		}
@@ -546,11 +546,11 @@ int dlm_recover_masters(struct dlm_ls *ls, uint64_t seq)
 		total++;
 
 		if (error) {
-			up_read(&ls->ls_root_sem);
+			read_unlock(&ls->ls_root_lock);
 			goto out;
 		}
 	}
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 
 	log_rinfo(ls, "dlm_recover_masters %u of %u", count, total);
 
@@ -660,7 +660,7 @@ int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq)
 	struct dlm_rsb *r;
 	int error, count = 0;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		if (is_master(r)) {
 			rsb_clear_flag(r, RSB_NEW_MASTER);
@@ -672,19 +672,19 @@ int dlm_recover_locks(struct dlm_ls *ls, uint64_t seq)
 
 		if (dlm_recovery_stopped(ls)) {
 			error = -EINTR;
-			up_read(&ls->ls_root_sem);
+			read_unlock(&ls->ls_root_lock);
 			goto out;
 		}
 
 		error = recover_locks(r, seq);
 		if (error) {
-			up_read(&ls->ls_root_sem);
+			read_unlock(&ls->ls_root_lock);
 			goto out;
 		}
 
 		count += r->res_recover_locks_count;
 	}
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 
 	log_rinfo(ls, "dlm_recover_locks %d out", count);
 
@@ -858,7 +858,7 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 	struct dlm_rsb *r;
 	unsigned int count = 0;
 
-	down_read(&ls->ls_root_sem);
+	read_lock(&ls->ls_root_lock);
 	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
 		lock_rsb(r);
 		if (is_master(r)) {
@@ -880,7 +880,7 @@ void dlm_recover_rsbs(struct dlm_ls *ls)
 		rsb_clear_flag(r, RSB_NEW_MASTER2);
 		unlock_rsb(r);
 	}
-	up_read(&ls->ls_root_sem);
+	read_unlock(&ls->ls_root_lock);
 
 	if (count)
 		log_rinfo(ls, "dlm_recover_rsbs %d done", count);
@@ -894,7 +894,7 @@ int dlm_create_root_list(struct dlm_ls *ls)
 	struct dlm_rsb *r;
 	int i, error = 0;
 
-	down_write(&ls->ls_root_sem);
+	write_lock(&ls->ls_root_lock);
 	if (!list_empty(&ls->ls_root_list)) {
 		log_error(ls, "root list not empty");
 		error = -EINVAL;
@@ -914,7 +914,7 @@ int dlm_create_root_list(struct dlm_ls *ls)
 		spin_unlock(&ls->ls_rsbtbl[i].lock);
 	}
  out:
-	up_write(&ls->ls_root_sem);
+	write_unlock(&ls->ls_root_lock);
 	return error;
 }
 
@@ -922,12 +922,12 @@ void dlm_release_root_list(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r, *safe;
 
-	down_write(&ls->ls_root_sem);
+	write_lock(&ls->ls_root_lock);
 	list_for_each_entry_safe(r, safe, &ls->ls_root_list, res_root_list) {
 		list_del_init(&r->res_root_list);
 		dlm_put_rsb(r);
 	}
-	up_write(&ls->ls_root_sem);
+	write_unlock(&ls->ls_root_lock);
 }
 
 void dlm_clear_toss(struct dlm_ls *ls)
-- 
2.31.1

