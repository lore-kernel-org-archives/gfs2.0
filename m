Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9317C6
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDucU/Ql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9f3mDAziciy94U+QfVP0VUSudZt+Unr/VnsYf3iYPUA=;
	b=TDucU/QlHSY6rLNJm8HAMfZaX6IiX3h1EVFdzFgdkaWxeMv/Ha/oF49QX8Hg3EQApY/ktp
	WUzmcaPr9N5xpAafypuiv7yM+qWAWFSjLCGo1Qb0l2UIG/AYsghPgImbEFBVavrOcelOHJ
	FUw3J3kd87sCwb+LzKJd2joQLyD5Mfg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-vjwH2OqDOWWbRmRHpfxQQA-1; Tue,
 24 Oct 2023 20:53:59 -0400
X-MC-Unique: vjwH2OqDOWWbRmRHpfxQQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 041D71C0519C
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:59 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA3EB40C6F79;
	Wed, 25 Oct 2023 00:53:58 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 09/10] dlm: convert message parsing locks to disable bh
Date: Tue, 24 Oct 2023 20:53:52 -0400
Message-Id: <20231025005353.855904-9-aahringo@redhat.com>
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

This patch converts all spinlocks involved in message parsing to it's
_bh version. The reason to do that is to convert the message parsing
into softirq context and we need to prevent that those locks can be
interrupted by a softirq if those are held.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c          |  28 +++----
 fs/dlm/debug_fs.c     |  32 ++++----
 fs/dlm/lock.c         | 174 ++++++++++++++++++++++--------------------
 fs/dlm/lock.h         |   4 +-
 fs/dlm/lockspace.c    |  51 ++++++-------
 fs/dlm/lowcomms.c     |  16 ++--
 fs/dlm/member.c       |  22 +++---
 fs/dlm/midcomms.c     |  40 +++++-----
 fs/dlm/rcom.c         |  26 +++----
 fs/dlm/recover.c      |  56 +++++++-------
 fs/dlm/recoverd.c     |  12 +--
 fs/dlm/requestqueue.c |  12 +--
 fs/dlm/user.c         |  34 ++++-----
 13 files changed, 258 insertions(+), 249 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 1f2f70a1b824..e3c0903aaa6f 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -127,19 +127,19 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		return;
 	}
 
-	spin_lock(&lkb->lkb_cb_lock);
+	spin_lock_bh(&lkb->lkb_cb_lock);
 	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
 	switch (rv) {
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
 		kref_get(&lkb->lkb_ref);
 
-		spin_lock(&ls->ls_cb_lock);
+		spin_lock_bh(&ls->ls_cb_lock);
 		if (test_bit(LSFL_CB_DELAY, &ls->ls_flags)) {
 			list_add(&lkb->lkb_cb_list, &ls->ls_cb_delay);
 		} else {
 			queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work);
 		}
-		spin_unlock(&ls->ls_cb_lock);
+		spin_unlock_bh(&ls->ls_cb_lock);
 		break;
 	case DLM_ENQUEUE_CALLBACK_FAILURE:
 		WARN_ON_ONCE(1);
@@ -150,7 +150,7 @@ void dlm_add_cb(struct dlm_lkb *lkb, uint32_t flags, int mode, int status,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	spin_unlock(&lkb->lkb_cb_lock);
+	spin_unlock_bh(&lkb->lkb_cb_lock);
 }
 
 void dlm_callback_work(struct work_struct *work)
@@ -162,14 +162,14 @@ void dlm_callback_work(struct work_struct *work)
 	struct dlm_callback *cb;
 	int rv;
 
-	spin_lock(&lkb->lkb_cb_lock);
+	spin_lock_bh(&lkb->lkb_cb_lock);
 	rv = dlm_dequeue_lkb_callback(lkb, &cb);
 	if (WARN_ON_ONCE(rv == DLM_DEQUEUE_CALLBACK_EMPTY)) {
 		clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-		spin_unlock(&lkb->lkb_cb_lock);
+		spin_unlock_bh(&lkb->lkb_cb_lock);
 		goto out;
 	}
-	spin_unlock(&lkb->lkb_cb_lock);
+	spin_unlock_bh(&lkb->lkb_cb_lock);
 
 	for (;;) {
 		castfn = lkb->lkb_astfn;
@@ -190,14 +190,14 @@ void dlm_callback_work(struct work_struct *work)
 
 		kref_put(&cb->ref, dlm_release_callback);
 
-		spin_lock(&lkb->lkb_cb_lock);
+		spin_lock_bh(&lkb->lkb_cb_lock);
 		rv = dlm_dequeue_lkb_callback(lkb, &cb);
 		if (rv == DLM_DEQUEUE_CALLBACK_EMPTY) {
 			clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-			spin_unlock(&lkb->lkb_cb_lock);
+			spin_unlock_bh(&lkb->lkb_cb_lock);
 			break;
 		}
-		spin_unlock(&lkb->lkb_cb_lock);
+		spin_unlock_bh(&lkb->lkb_cb_lock);
 	}
 
 out:
@@ -225,9 +225,9 @@ void dlm_callback_stop(struct dlm_ls *ls)
 void dlm_callback_suspend(struct dlm_ls *ls)
 {
 	if (ls->ls_callback_wq) {
-		spin_lock(&ls->ls_cb_lock);
+		spin_lock_bh(&ls->ls_cb_lock);
 		set_bit(LSFL_CB_DELAY, &ls->ls_flags);
-		spin_unlock(&ls->ls_cb_lock);
+		spin_unlock_bh(&ls->ls_cb_lock);
 
 		flush_workqueue(ls->ls_callback_wq);
 	}
@@ -245,7 +245,7 @@ void dlm_callback_resume(struct dlm_ls *ls)
 		return;
 
 more:
-	spin_lock(&ls->ls_cb_lock);
+	spin_lock_bh(&ls->ls_cb_lock);
 	list_for_each_entry_safe(lkb, safe, &ls->ls_cb_delay, lkb_cb_list) {
 		list_del_init(&lkb->lkb_cb_list);
 		queue_work(ls->ls_callback_wq, &lkb->lkb_cb_work);
@@ -256,7 +256,7 @@ void dlm_callback_resume(struct dlm_ls *ls)
 	empty = list_empty(&ls->ls_cb_delay);
 	if (empty)
 		clear_bit(LSFL_CB_DELAY, &ls->ls_flags);
-	spin_unlock(&ls->ls_cb_lock);
+	spin_unlock_bh(&ls->ls_cb_lock);
 
 	sum += count;
 	if (!empty) {
diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 26abeff5b602..ca65481df70d 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -372,7 +372,7 @@ static void print_format5_lock(struct seq_file *s, struct dlm_lkb *lkb)
 
 	/* lkb_id lkb_flags mode flags sb_status sb_flags */
 
-	spin_lock(&lkb->lkb_cb_lock);
+	spin_lock_bh(&lkb->lkb_cb_lock);
 	list_for_each_entry(cb, &lkb->lkb_callbacks, list) {
 		seq_printf(s, "%x %x %d %x %d %x\n",
 			   lkb->lkb_id,
@@ -382,7 +382,7 @@ static void print_format5_lock(struct seq_file *s, struct dlm_lkb *lkb)
 			   cb->sb_status,
 			   cb->sb_flags);
 	}
-	spin_unlock(&lkb->lkb_cb_lock);
+	spin_unlock_bh(&lkb->lkb_cb_lock);
 }
 
 static void print_format5(struct dlm_rsb *r, struct seq_file *s)
@@ -508,7 +508,7 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 
 	tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-	spin_lock(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
 	if (!RB_EMPTY_ROOT(tree)) {
 		for (node = rb_first(tree); node; node = rb_next(node)) {
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
@@ -516,12 +516,12 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 				dlm_hold_rsb(r);
 				ri->rsb = r;
 				ri->bucket = bucket;
-				spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+				spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 				return ri;
 			}
 		}
 	}
-	spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 
 	/*
 	 * move to the first rsb in the next non-empty bucket
@@ -540,18 +540,18 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 		}
 		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-		spin_lock(&ls->ls_rsbtbl[bucket].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			node = rb_first(tree);
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
-			spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 			*pos = n;
 			return ri;
 		}
-		spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 	}
 }
 
@@ -572,7 +572,7 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 	 * move to the next rsb in the same bucket
 	 */
 
-	spin_lock(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
 	rp = ri->rsb;
 	next = rb_next(&rp->res_hashnode);
 
@@ -580,12 +580,12 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 		r = rb_entry(next, struct dlm_rsb, res_hashnode);
 		dlm_hold_rsb(r);
 		ri->rsb = r;
-		spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 		dlm_put_rsb(rp);
 		++*pos;
 		return ri;
 	}
-	spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 	dlm_put_rsb(rp);
 
 	/*
@@ -606,18 +606,18 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 		}
 		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-		spin_lock(&ls->ls_rsbtbl[bucket].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			next = rb_first(tree);
 			r = rb_entry(next, struct dlm_rsb, res_hashnode);
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
-			spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 			*pos = n;
 			return ri;
 		}
-		spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 	}
 }
 
@@ -824,7 +824,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 
 	mutex_lock(&debug_buf_lock);
 	dlm_lock_recovery(ls);
-	spin_lock(&ls->ls_waiters_lock);
+	spin_lock_bh(&ls->ls_waiters_lock);
 	memset(debug_buf, 0, sizeof(debug_buf));
 
 	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
@@ -835,7 +835,7 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 			break;
 		pos += ret;
 	}
-	spin_unlock(&ls->ls_waiters_lock);
+	spin_unlock_bh(&ls->ls_waiters_lock);
 	dlm_unlock_recovery(ls);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 091a8e58c06c..4d8d6caeeb2b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -342,10 +342,15 @@ static void put_rsb(struct dlm_rsb *r)
 	uint32_t bucket = r->res_bucket;
 	int rv;
 
+	/* TODO we need a kref_put_lock_bh(), however this
+	 * is only an optimization.
+	 */
+	local_bh_disable();
 	rv = kref_put_lock(&r->res_ref, toss_rsb,
 			   &ls->ls_rsbtbl[bucket].lock);
 	if (rv)
 		spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+	local_bh_enable();
 }
 
 void dlm_put_rsb(struct dlm_rsb *r)
@@ -358,17 +363,17 @@ static int pre_rsb_struct(struct dlm_ls *ls)
 	struct dlm_rsb *r1, *r2;
 	int count = 0;
 
-	spin_lock(&ls->ls_new_rsb_spin);
+	spin_lock_bh(&ls->ls_new_rsb_spin);
 	if (ls->ls_new_rsb_count > dlm_config.ci_new_rsb_count / 2) {
-		spin_unlock(&ls->ls_new_rsb_spin);
+		spin_unlock_bh(&ls->ls_new_rsb_spin);
 		return 0;
 	}
-	spin_unlock(&ls->ls_new_rsb_spin);
+	spin_unlock_bh(&ls->ls_new_rsb_spin);
 
 	r1 = dlm_allocate_rsb(ls);
 	r2 = dlm_allocate_rsb(ls);
 
-	spin_lock(&ls->ls_new_rsb_spin);
+	spin_lock_bh(&ls->ls_new_rsb_spin);
 	if (r1) {
 		list_add(&r1->res_hashchain, &ls->ls_new_rsb);
 		ls->ls_new_rsb_count++;
@@ -378,7 +383,7 @@ static int pre_rsb_struct(struct dlm_ls *ls)
 		ls->ls_new_rsb_count++;
 	}
 	count = ls->ls_new_rsb_count;
-	spin_unlock(&ls->ls_new_rsb_spin);
+	spin_unlock_bh(&ls->ls_new_rsb_spin);
 
 	if (!count)
 		return -ENOMEM;
@@ -395,10 +400,10 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	struct dlm_rsb *r;
 	int count;
 
-	spin_lock(&ls->ls_new_rsb_spin);
+	spin_lock_bh(&ls->ls_new_rsb_spin);
 	if (list_empty(&ls->ls_new_rsb)) {
 		count = ls->ls_new_rsb_count;
-		spin_unlock(&ls->ls_new_rsb_spin);
+		spin_unlock_bh(&ls->ls_new_rsb_spin);
 		log_debug(ls, "find_rsb retry %d %d %s",
 			  count, dlm_config.ci_new_rsb_count,
 			  (const char *)name);
@@ -410,7 +415,7 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	/* Convert the empty list_head to a NULL rb_node for tree usage: */
 	memset(&r->res_hashnode, 0, sizeof(struct rb_node));
 	ls->ls_new_rsb_count--;
-	spin_unlock(&ls->ls_new_rsb_spin);
+	spin_unlock_bh(&ls->ls_new_rsb_spin);
 
 	r->res_ls = ls;
 	r->res_length = len;
@@ -584,7 +589,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 			goto out;
 	}
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (error)
@@ -654,7 +659,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		goto retry;
 	}
 	if (error)
@@ -703,7 +708,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
  out_add:
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
  out_unlock:
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
  out:
 	*r_ret = r;
 	return error;
@@ -728,7 +733,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	if (error < 0)
 		goto out;
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (error)
@@ -786,7 +791,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		goto retry;
 	}
 	if (error)
@@ -801,7 +806,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
  out_unlock:
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
  out:
 	*r_ret = r;
 	return error;
@@ -1018,7 +1023,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error < 0)
 		return error;
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (!error) {
 		/* because the rsb is active, we need to lock_rsb before
@@ -1026,7 +1031,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		 */
 
 		hold_rsb(r);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		lock_rsb(r);
 
 		__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
@@ -1052,14 +1057,14 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 	r->res_toss_time = jiffies;
 	/* the rsb was inactive (on toss list) */
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 
 	return 0;
 
  not_found:
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		goto retry;
 	}
 	if (error)
@@ -1077,7 +1082,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error) {
 		/* should never happen */
 		dlm_free_rsb(r);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		goto retry;
 	}
 
@@ -1085,7 +1090,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		*result = DLM_LU_ADD;
 	*r_nodeid = from_nodeid;
  out_unlock:
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 	return error;
 }
 
@@ -1096,13 +1101,13 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 	int i;
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock(&ls->ls_rsbtbl[i].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
 			if (r->res_hash == hash)
 				dlm_dump_rsb(r);
 		}
-		spin_unlock(&ls->ls_rsbtbl[i].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
 }
 
@@ -1115,7 +1120,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 	hash = jhash(name, len, 0);
 	b = hash & (ls->ls_rsbtbl_size - 1);
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (!error)
 		goto out_dump;
@@ -1126,7 +1131,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
  out_dump:
 	dlm_dump_rsb(r);
  out:
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 }
 
 static void toss_rsb(struct kref *kref)
@@ -1208,11 +1213,11 @@ static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
 	spin_lock_init(&lkb->lkb_cb_lock);
 	INIT_WORK(&lkb->lkb_cb_work, dlm_callback_work);
 
-	spin_lock(&ls->ls_lkbidr_spin);
+	spin_lock_bh(&ls->ls_lkbidr_spin);
 	rv = idr_alloc(&ls->ls_lkbidr, lkb, start, end, GFP_NOWAIT);
 	if (rv >= 0)
 		lkb->lkb_id = rv;
-	spin_unlock(&ls->ls_lkbidr_spin);
+	spin_unlock_bh(&ls->ls_lkbidr_spin);
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
@@ -1233,11 +1238,11 @@ static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
 {
 	struct dlm_lkb *lkb;
 
-	spin_lock(&ls->ls_lkbidr_spin);
+	spin_lock_bh(&ls->ls_lkbidr_spin);
 	lkb = idr_find(&ls->ls_lkbidr, lkid);
 	if (lkb)
 		kref_get(&lkb->lkb_ref);
-	spin_unlock(&ls->ls_lkbidr_spin);
+	spin_unlock_bh(&ls->ls_lkbidr_spin);
 
 	*lkb_ret = lkb;
 	return lkb ? 0 : -ENOENT;
@@ -1261,6 +1266,10 @@ static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	uint32_t lkid = lkb->lkb_id;
 	int rv;
 
+	/* TODO we need a kref_put_lock_bh(), however this
+	 * is only an optimization.
+	 */
+	local_bh_disable();
 	rv = kref_put_lock(&lkb->lkb_ref, kill_lkb,
 			   &ls->ls_lkbidr_spin);
 	if (rv) {
@@ -1274,6 +1283,7 @@ static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
 			dlm_free_lvb(lkb->lkb_lvbptr);
 		dlm_free_lkb(lkb);
 	}
+	local_bh_enable();
 
 	return rv;
 }
@@ -1407,7 +1417,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 	int error = 0;
 	int wc;
 
-	spin_lock(&ls->ls_waiters_lock);
+	spin_lock_bh(&ls->ls_waiters_lock);
 
 	if (is_overlap_unlock(lkb) ||
 	    (is_overlap_cancel(lkb) && (mstype == DLM_MSG_CANCEL))) {
@@ -1447,7 +1457,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 		log_error(ls, "addwait error %x %d flags %x %d %d %s",
 			  lkb->lkb_id, error, dlm_iflags_val(lkb), mstype,
 			  lkb->lkb_wait_type, lkb->lkb_resource->res_name);
-	spin_unlock(&ls->ls_waiters_lock);
+	spin_unlock_bh(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1546,9 +1556,9 @@ static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error;
 
-	spin_lock(&ls->ls_waiters_lock);
+	spin_lock_bh(&ls->ls_waiters_lock);
 	error = _remove_from_waiters(lkb, mstype, NULL);
-	spin_unlock(&ls->ls_waiters_lock);
+	spin_unlock_bh(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1566,13 +1576,13 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 	int error;
 
 	if (!local)
-		spin_lock(&ls->ls_waiters_lock);
+		spin_lock_bh(&ls->ls_waiters_lock);
 	else
 		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
 			     !dlm_locking_stopped(ls));
 	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
 	if (!local)
-		spin_unlock(&ls->ls_waiters_lock);
+		spin_unlock_bh(&ls->ls_waiters_lock);
 	return error;
 }
 
@@ -1588,10 +1598,10 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 	memset(&ls->ls_remove_lens, 0, sizeof(int) * DLM_REMOVE_NAMES_MAX);
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 
 	if (!test_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags)) {
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		return;
 	}
 
@@ -1648,7 +1658,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
 	else
 		clear_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
-	spin_unlock(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 
 	/*
 	 * While searching for rsb's to free, we found some that require
@@ -1663,16 +1673,16 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		name = ls->ls_remove_names[i];
 		len = ls->ls_remove_lens[i];
 
-		spin_lock(&ls->ls_rsbtbl[b].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
 		if (rv) {
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			log_debug(ls, "remove_name not toss %s", name);
 			continue;
 		}
 
 		if (r->res_master_nodeid != our_nodeid) {
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			log_debug(ls, "remove_name master %d dir %d our %d %s",
 				  r->res_master_nodeid, r->res_dir_nodeid,
 				  our_nodeid, name);
@@ -1681,7 +1691,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 		if (r->res_dir_nodeid == our_nodeid) {
 			/* should never happen */
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			log_error(ls, "remove_name dir %d master %d our %d %s",
 				  r->res_dir_nodeid, r->res_master_nodeid,
 				  our_nodeid, name);
@@ -1690,21 +1700,21 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 		if (!time_after_eq(jiffies, r->res_toss_time +
 				   dlm_config.ci_toss_secs * HZ)) {
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			log_debug(ls, "remove_name toss_time %lu now %lu %s",
 				  r->res_toss_time, jiffies, name);
 			continue;
 		}
 
 		if (!kref_put(&r->res_ref, kill_rsb)) {
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			log_error(ls, "remove_name in use %s", name);
 			continue;
 		}
 
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
 		send_remove(r);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 
 		dlm_free_rsb(r);
 	}
@@ -4169,7 +4179,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	hash = jhash(name, len, 0);
 	b = hash & (ls->ls_rsbtbl_size - 1);
 
-	spin_lock(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
 
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
 	if (rv) {
@@ -4179,7 +4189,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 			/* should not happen */
 			log_error(ls, "receive_remove from %d not found %s",
 				  from_nodeid, name);
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			return;
 		}
 		if (r->res_master_nodeid != from_nodeid) {
@@ -4187,14 +4197,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 			log_error(ls, "receive_remove keep from %d master %d",
 				  from_nodeid, r->res_master_nodeid);
 			dlm_print_rsb(r);
-			spin_unlock(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 			return;
 		}
 
 		log_debug(ls, "receive_remove from %d master %d first %x %s",
 			  from_nodeid, r->res_master_nodeid, r->res_first_lkid,
 			  name);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		return;
 	}
 
@@ -4202,19 +4212,19 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 		log_error(ls, "receive_remove toss from %d master %d",
 			  from_nodeid, r->res_master_nodeid);
 		dlm_print_rsb(r);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		return;
 	}
 
 	if (kref_put(&r->res_ref, kill_rsb)) {
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 		dlm_free_rsb(r);
 	} else {
 		log_error(ls, "receive_remove from %d rsb ref error",
 			  from_nodeid);
 		dlm_print_rsb(r);
-		spin_unlock(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
 	}
 }
 
@@ -4750,20 +4760,20 @@ static void dlm_receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
 				int nodeid)
 {
 try_again:
-	read_lock(&ls->ls_requestqueue_lock);
+	read_lock_bh(&ls->ls_requestqueue_lock);
 	if (test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
 		/* If we were a member of this lockspace, left, and rejoined,
 		   other nodes may still be sending us messages from the
 		   lockspace generation before we left. */
 		if (WARN_ON_ONCE(!ls->ls_generation)) {
-			read_unlock(&ls->ls_requestqueue_lock);
+			read_unlock_bh(&ls->ls_requestqueue_lock);
 			log_limit(ls, "receive %d from %d ignore old gen",
 				  le32_to_cpu(ms->m_type), nodeid);
 			return;
 		}
 
-		read_unlock(&ls->ls_requestqueue_lock);
-		write_lock(&ls->ls_requestqueue_lock);
+		read_unlock_bh(&ls->ls_requestqueue_lock);
+		write_lock_bh(&ls->ls_requestqueue_lock);
 		/* recheck because we hold writelock now */
 		if (!test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
 			write_unlock_bh(&ls->ls_requestqueue_lock);
@@ -4771,10 +4781,10 @@ static void dlm_receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
 		}
 
 		dlm_add_requestqueue(ls, nodeid, ms);
-		write_unlock(&ls->ls_requestqueue_lock);
+		write_unlock_bh(&ls->ls_requestqueue_lock);
 	} else {
 		_receive_message(ls, ms, 0);
-		read_unlock(&ls->ls_requestqueue_lock);
+		read_unlock_bh(&ls->ls_requestqueue_lock);
 	}
 }
 
@@ -4834,7 +4844,7 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 	/* this rwsem allows dlm_ls_stop() to wait for all dlm_recv threads to
 	   be inactive (in this ls) before transitioning to recovery mode */
 
-	read_lock(&ls->ls_recv_active);
+	read_lock_bh(&ls->ls_recv_active);
 	if (hd->h_cmd == DLM_MSG)
 		dlm_receive_message(ls, &p->message, nodeid);
 	else if (hd->h_cmd == DLM_RCOM)
@@ -4842,7 +4852,7 @@ void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
 	else
 		log_error(ls, "invalid h_cmd %d from %d lockspace %x",
 			  hd->h_cmd, nodeid, le32_to_cpu(hd->u.h_lockspace));
-	read_unlock(&ls->ls_recv_active);
+	read_unlock_bh(&ls->ls_recv_active);
 
 	dlm_put_lockspace(ls);
 }
@@ -5002,7 +5012,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb = NULL, *iter;
 
-	spin_lock(&ls->ls_waiters_lock);
+	spin_lock_bh(&ls->ls_waiters_lock);
 	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
 		if (test_bit(DLM_IFL_RESEND_BIT, &iter->lkb_iflags)) {
 			hold_lkb(iter);
@@ -5010,7 +5020,7 @@ static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 			break;
 		}
 	}
-	spin_unlock(&ls->ls_waiters_lock);
+	spin_unlock_bh(&ls->ls_waiters_lock);
 
 	return lkb;
 }
@@ -5077,9 +5087,9 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		while (!atomic_dec_and_test(&lkb->lkb_wait_count))
 			unhold_lkb(lkb);
 
-		spin_lock(&ls->ls_waiters_lock);
+		spin_lock_bh(&ls->ls_waiters_lock);
 		list_del_init(&lkb->lkb_wait_reply);
-		spin_unlock(&ls->ls_waiters_lock);
+		spin_unlock_bh(&ls->ls_waiters_lock);
 
 		if (oc || ou) {
 			/* do an unlock or cancel instead of resending */
@@ -5243,7 +5253,7 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 	struct rb_node *n;
 	struct dlm_rsb *r;
 
-	spin_lock(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
 	for (n = rb_first(&ls->ls_rsbtbl[bucket].keep); n; n = rb_next(n)) {
 		r = rb_entry(n, struct dlm_rsb, res_hashnode);
 
@@ -5254,10 +5264,10 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 			continue;
 		}
 		hold_rsb(r);
-		spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 		return r;
 	}
-	spin_unlock(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
 	return NULL;
 }
 
@@ -5601,10 +5611,10 @@ int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
 	}
 
 	/* add this new lkb to the per-process list of locks */
-	spin_lock(&ua->proc->locks_spin);
+	spin_lock_bh(&ua->proc->locks_spin);
 	hold_lkb(lkb);
 	list_add_tail(&lkb->lkb_ownqueue, &ua->proc->locks);
-	spin_unlock(&ua->proc->locks_spin);
+	spin_unlock_bh(&ua->proc->locks_spin);
 	do_put = false;
  out_put:
 	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, false);
@@ -5734,9 +5744,9 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 	 * for the proc locks list.
 	 */
 
-	spin_lock(&ua->proc->locks_spin);
+	spin_lock_bh(&ua->proc->locks_spin);
 	list_add_tail(&lkb->lkb_ownqueue, &ua->proc->locks);
-	spin_unlock(&ua->proc->locks_spin);
+	spin_unlock_bh(&ua->proc->locks_spin);
  out:
 	kfree(ua_tmp);
 	return rv;
@@ -5780,11 +5790,11 @@ int dlm_user_unlock(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 	if (error)
 		goto out_put;
 
-	spin_lock(&ua->proc->locks_spin);
+	spin_lock_bh(&ua->proc->locks_spin);
 	/* dlm_user_add_cb() may have already taken lkb off the proc list */
 	if (!list_empty(&lkb->lkb_ownqueue))
 		list_move(&lkb->lkb_ownqueue, &ua->proc->unlocking);
-	spin_unlock(&ua->proc->locks_spin);
+	spin_unlock_bh(&ua->proc->locks_spin);
  out_put:
 	trace_dlm_unlock_end(ls, lkb, flags, error);
 	dlm_put_lkb(lkb);
@@ -5935,7 +5945,7 @@ static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
 {
 	struct dlm_lkb *lkb = NULL;
 
-	spin_lock(&ls->ls_clear_proc_locks);
+	spin_lock_bh(&ls->ls_clear_proc_locks);
 	if (list_empty(&proc->locks))
 		goto out;
 
@@ -5947,7 +5957,7 @@ static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
 	else
 		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
  out:
-	spin_unlock(&ls->ls_clear_proc_locks);
+	spin_unlock_bh(&ls->ls_clear_proc_locks);
 	return lkb;
 }
 
@@ -5983,7 +5993,7 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 		dlm_put_lkb(lkb);
 	}
 
-	spin_lock(&ls->ls_clear_proc_locks);
+	spin_lock_bh(&ls->ls_clear_proc_locks);
 
 	/* in-progress unlocks */
 	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
@@ -5998,7 +6008,7 @@ void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 		dlm_put_lkb(lkb);
 	}
 
-	spin_unlock(&ls->ls_clear_proc_locks);
+	spin_unlock_bh(&ls->ls_clear_proc_locks);
 	dlm_unlock_recovery(ls);
 }
 
@@ -6008,13 +6018,13 @@ static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 
 	while (1) {
 		lkb = NULL;
-		spin_lock(&proc->locks_spin);
+		spin_lock_bh(&proc->locks_spin);
 		if (!list_empty(&proc->locks)) {
 			lkb = list_entry(proc->locks.next, struct dlm_lkb,
 					 lkb_ownqueue);
 			list_del_init(&lkb->lkb_ownqueue);
 		}
-		spin_unlock(&proc->locks_spin);
+		spin_unlock_bh(&proc->locks_spin);
 
 		if (!lkb)
 			break;
@@ -6024,21 +6034,21 @@ static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 		dlm_put_lkb(lkb); /* ref from proc->locks list */
 	}
 
-	spin_lock(&proc->locks_spin);
+	spin_lock_bh(&proc->locks_spin);
 	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
 		list_del_init(&lkb->lkb_ownqueue);
 		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
 		dlm_put_lkb(lkb);
 	}
-	spin_unlock(&proc->locks_spin);
+	spin_unlock_bh(&proc->locks_spin);
 
-	spin_lock(&proc->asts_spin);
+	spin_lock_bh(&proc->asts_spin);
 	list_for_each_entry_safe(lkb, safe, &proc->asts, lkb_cb_list) {
 		dlm_purge_lkb_callbacks(lkb);
 		list_del_init(&lkb->lkb_cb_list);
 		dlm_put_lkb(lkb);
 	}
-	spin_unlock(&proc->asts_spin);
+	spin_unlock_bh(&proc->asts_spin);
 }
 
 /* pid of 0 means purge all orphans */
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index 0f6b2700c0da..45a74869810a 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -69,12 +69,12 @@ static inline int is_master(struct dlm_rsb *r)
 
 static inline void lock_rsb(struct dlm_rsb *r)
 {
-	spin_lock(&r->res_lock);
+	spin_lock_bh(&r->res_lock);
 }
 
 static inline void unlock_rsb(struct dlm_rsb *r)
 {
-	spin_unlock(&r->res_lock);
+	spin_unlock_bh(&r->res_lock);
 }
 
 #endif
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 823a91fa9a74..306afe30d6b2 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -251,15 +251,15 @@ static struct dlm_ls *find_ls_to_scan(void)
 {
 	struct dlm_ls *ls;
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (time_after_eq(jiffies, ls->ls_scan_time +
 					    dlm_config.ci_scan_secs * HZ)) {
-			spin_unlock(&lslist_lock);
+			spin_unlock_bh(&lslist_lock);
 			return ls;
 		}
 	}
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 	return NULL;
 }
 
@@ -306,7 +306,7 @@ struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
 	struct dlm_ls *ls;
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (ls->ls_global_id == id) {
@@ -316,7 +316,7 @@ struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 	}
 	ls = NULL;
  out:
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 	return ls;
 }
 
@@ -324,7 +324,7 @@ struct dlm_ls *dlm_find_lockspace_local(dlm_lockspace_t *lockspace)
 {
 	struct dlm_ls *ls;
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (ls->ls_local_handle == lockspace) {
 			atomic_inc(&ls->ls_count);
@@ -333,7 +333,7 @@ struct dlm_ls *dlm_find_lockspace_local(dlm_lockspace_t *lockspace)
 	}
 	ls = NULL;
  out:
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 	return ls;
 }
 
@@ -341,7 +341,7 @@ struct dlm_ls *dlm_find_lockspace_device(int minor)
 {
 	struct dlm_ls *ls;
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (ls->ls_device.minor == minor) {
 			atomic_inc(&ls->ls_count);
@@ -350,7 +350,7 @@ struct dlm_ls *dlm_find_lockspace_device(int minor)
 	}
 	ls = NULL;
  out:
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 	return ls;
 }
 
@@ -365,15 +365,15 @@ static void remove_lockspace(struct dlm_ls *ls)
 retry:
 	wait_event(ls->ls_count_wait, atomic_read(&ls->ls_count) == 0);
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	if (atomic_read(&ls->ls_count) != 0) {
-		spin_unlock(&lslist_lock);
+		spin_unlock_bh(&lslist_lock);
 		goto retry;
 	}
 
 	WARN_ON(ls->ls_create_count != 0);
 	list_del(&ls->ls_list);
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 }
 
 static int threads_start(void)
@@ -448,7 +448,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = 0;
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_for_each_entry(ls, &lslist, ls_list) {
 		WARN_ON(ls->ls_create_count <= 0);
 		if (ls->ls_namelen != namelen)
@@ -464,7 +464,7 @@ static int new_lockspace(const char *name, const char *cluster,
 		error = 1;
 		break;
 	}
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 
 	if (error)
 		goto out;
@@ -579,10 +579,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	ls->ls_local_handle = ls;
 	init_waitqueue_head(&ls->ls_wait_general);
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	ls->ls_create_count = 1;
 	list_add(&ls->ls_list, &lslist);
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 
 	if (flags & DLM_LSFL_FS) {
 		error = dlm_callback_start(ls);
@@ -651,9 +651,9 @@ static int new_lockspace(const char *name, const char *cluster,
  out_callback:
 	dlm_callback_stop(ls);
  out_delist:
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_del(&ls->ls_list);
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 	idr_destroy(&ls->ls_recover_idr);
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
@@ -752,7 +752,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 {
 	int rv;
 
-	spin_lock(&ls->ls_lkbidr_spin);
+	spin_lock_bh(&ls->ls_lkbidr_spin);
 	if (force == 0) {
 		rv = idr_for_each(&ls->ls_lkbidr, lkb_idr_is_any, ls);
 	} else if (force == 1) {
@@ -760,7 +760,7 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	} else {
 		rv = 0;
 	}
-	spin_unlock(&ls->ls_lkbidr_spin);
+	spin_unlock_bh(&ls->ls_lkbidr_spin);
 	return rv;
 }
 
@@ -772,7 +772,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	busy = lockspace_busy(ls, force);
 
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	if (ls->ls_create_count == 1) {
 		if (busy) {
 			rv = -EBUSY;
@@ -786,7 +786,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	} else {
 		rv = -EINVAL;
 	}
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 
 	if (rv) {
 		log_debug(ls, "release_lockspace no remove %d", rv);
@@ -914,20 +914,19 @@ void dlm_stop_lockspaces(void)
 
  restart:
 	count = 0;
-	spin_lock(&lslist_lock);
+	spin_lock_bh(&lslist_lock);
 	list_for_each_entry(ls, &lslist, ls_list) {
 		if (!test_bit(LSFL_RUNNING, &ls->ls_flags)) {
 			count++;
 			continue;
 		}
-		spin_unlock(&lslist_lock);
+		spin_unlock_bh(&lslist_lock);
 		log_error(ls, "no userland control daemon, stopping lockspace");
 		dlm_ls_stop(ls);
 		goto restart;
 	}
-	spin_unlock(&lslist_lock);
+	spin_unlock_bh(&lslist_lock);
 
 	if (count)
 		log_print("dlm user daemon left %d lockspaces", count);
 }
-
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index db71982d709d..28dd74aebc84 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -867,36 +867,36 @@ static void process_dlm_messages(struct work_struct *work)
 {
 	struct processqueue_entry *pentry;
 
-	spin_lock(&processqueue_lock);
+	spin_lock_bh(&processqueue_lock);
 	pentry = list_first_entry_or_null(&processqueue,
 					  struct processqueue_entry, list);
 	if (WARN_ON_ONCE(!pentry)) {
 		process_dlm_messages_pending = false;
-		spin_unlock(&processqueue_lock);
+		spin_unlock_bh(&processqueue_lock);
 		return;
 	}
 
 	list_del(&pentry->list);
 	atomic_dec(&processqueue_count);
-	spin_unlock(&processqueue_lock);
+	spin_unlock_bh(&processqueue_lock);
 
 	for (;;) {
 		dlm_process_incoming_buffer(pentry->nodeid, pentry->buf,
 					    pentry->buflen);
 		free_processqueue_entry(pentry);
 
-		spin_lock(&processqueue_lock);
+		spin_lock_bh(&processqueue_lock);
 		pentry = list_first_entry_or_null(&processqueue,
 						  struct processqueue_entry, list);
 		if (!pentry) {
 			process_dlm_messages_pending = false;
-			spin_unlock(&processqueue_lock);
+			spin_unlock_bh(&processqueue_lock);
 			break;
 		}
 
 		list_del(&pentry->list);
 		atomic_dec(&processqueue_count);
-		spin_unlock(&processqueue_lock);
+		spin_unlock_bh(&processqueue_lock);
 	}
 }
 
@@ -966,14 +966,14 @@ static int receive_from_sock(struct connection *con, int buflen)
 	memmove(con->rx_leftover_buf, pentry->buf + ret,
 		con->rx_leftover);
 
-	spin_lock(&processqueue_lock);
+	spin_lock_bh(&processqueue_lock);
 	ret = atomic_inc_return(&processqueue_count);
 	list_add_tail(&pentry->list, &processqueue);
 	if (!process_dlm_messages_pending) {
 		process_dlm_messages_pending = true;
 		queue_work(process_workqueue, &process_work);
 	}
-	spin_unlock(&processqueue_lock);
+	spin_unlock_bh(&processqueue_lock);
 
 	if (ret > DLM_MAX_PROCESS_BUFFERS)
 		return DLM_IO_FLUSH;
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index ac1b555af9d6..6401916a97ef 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -630,7 +630,7 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	 * message to the requestqueue without races.
 	 */
 
-	write_lock(&ls->ls_recv_active);
+	write_lock_bh(&ls->ls_recv_active);
 
 	/*
 	 * Abort any recovery that's in progress (see RECOVER_STOP,
@@ -638,23 +638,23 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	 * dlm to quit any processing (see RUNNING, dlm_locking_stopped()).
 	 */
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	set_bit(LSFL_RECOVER_STOP, &ls->ls_flags);
 	new = test_and_clear_bit(LSFL_RUNNING, &ls->ls_flags);
 	ls->ls_recover_seq++;
 
 	/* activate requestqueue and stop processing */
-	write_lock(&ls->ls_requestqueue_lock);
+	write_lock_bh(&ls->ls_requestqueue_lock);
 	set_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags);
-	write_unlock(&ls->ls_requestqueue_lock);
-	spin_unlock(&ls->ls_recover_lock);
+	write_unlock_bh(&ls->ls_requestqueue_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
 	/*
 	 * Let dlm_recv run again, now any normal messages will be saved on the
 	 * requestqueue for later.
 	 */
 
-	write_unlock(&ls->ls_recv_active);
+	write_unlock_bh(&ls->ls_recv_active);
 
 	/*
 	 * This in_recovery lock does two things:
@@ -679,13 +679,13 @@ int dlm_ls_stop(struct dlm_ls *ls)
 
 	dlm_recoverd_suspend(ls);
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	kfree(ls->ls_slots);
 	ls->ls_slots = NULL;
 	ls->ls_num_slots = 0;
 	ls->ls_slots_size = 0;
 	ls->ls_recover_status = 0;
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
 	dlm_recoverd_resume(ls);
 
@@ -719,12 +719,12 @@ int dlm_ls_start(struct dlm_ls *ls)
 	if (error < 0)
 		goto fail_rv;
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 
 	/* the lockspace needs to be stopped before it can be started */
 
 	if (!dlm_locking_stopped(ls)) {
-		spin_unlock(&ls->ls_recover_lock);
+		spin_unlock_bh(&ls->ls_recover_lock);
 		log_error(ls, "start ignored: lockspace running");
 		error = -EINVAL;
 		goto fail;
@@ -735,7 +735,7 @@ int dlm_ls_start(struct dlm_ls *ls)
 	rv->seq = ++ls->ls_recover_seq;
 	rv_old = ls->ls_recover_args;
 	ls->ls_recover_args = rv;
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
 	if (rv_old) {
 		log_error(ls, "unused recovery %llx %d",
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index ea0559e2a44d..7d75f86450d6 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -365,9 +365,9 @@ int dlm_midcomms_addr(int nodeid, struct sockaddr_storage *addr, int len)
 	node->users = 0;
 	midcomms_node_reset(node);
 
-	spin_lock(&nodes_lock);
+	spin_lock_bh(&nodes_lock);
 	hlist_add_head_rcu(&node->hlist, &node_hash[r]);
-	spin_unlock(&nodes_lock);
+	spin_unlock_bh(&nodes_lock);
 
 	node->debugfs = dlm_create_debug_comms_file(nodeid, node);
 	return 0;
@@ -478,7 +478,7 @@ static void dlm_receive_ack(struct midcomms_node *node, uint32_t seq)
 
 static void dlm_pas_fin_ack_rcv(struct midcomms_node *node)
 {
-	spin_lock(&node->state_lock);
+	spin_lock_bh(&node->state_lock);
 	pr_debug("receive passive fin ack from node %d with state %s\n",
 		 node->nodeid, dlm_state_str(node->state));
 
@@ -492,13 +492,13 @@ static void dlm_pas_fin_ack_rcv(struct midcomms_node *node)
 		wake_up(&node->shutdown_wait);
 		break;
 	default:
-		spin_unlock(&node->state_lock);
+		spin_unlock_bh(&node->state_lock);
 		log_print("%s: unexpected state: %d",
 			  __func__, node->state);
 		WARN_ON_ONCE(1);
 		return;
 	}
-	spin_unlock(&node->state_lock);
+	spin_unlock_bh(&node->state_lock);
 }
 
 static void dlm_receive_buffer_3_2_trace(uint32_t seq,
@@ -535,7 +535,7 @@ static void dlm_midcomms_receive_buffer(const union dlm_packet *p,
 	if (is_expected_seq) {
 		switch (p->header.h_cmd) {
 		case DLM_FIN:
-			spin_lock(&node->state_lock);
+			spin_lock_bh(&node->state_lock);
 			pr_debug("receive fin msg from node %d with state %s\n",
 				 node->nodeid, dlm_state_str(node->state));
 
@@ -576,13 +576,13 @@ static void dlm_midcomms_receive_buffer(const union dlm_packet *p,
 				/* probably remove_member caught it, do nothing */
 				break;
 			default:
-				spin_unlock(&node->state_lock);
+				spin_unlock_bh(&node->state_lock);
 				log_print("%s: unexpected state: %d",
 					  __func__, node->state);
 				WARN_ON_ONCE(1);
 				return;
 			}
-			spin_unlock(&node->state_lock);
+			spin_unlock_bh(&node->state_lock);
 			break;
 		default:
 			WARN_ON_ONCE(test_bit(DLM_NODE_FLAG_STOP_RX, &node->flags));
@@ -1183,7 +1183,7 @@ void dlm_midcomms_exit(void)
 
 static void dlm_act_fin_ack_rcv(struct midcomms_node *node)
 {
-	spin_lock(&node->state_lock);
+	spin_lock_bh(&node->state_lock);
 	pr_debug("receive active fin ack from node %d with state %s\n",
 		 node->nodeid, dlm_state_str(node->state));
 
@@ -1203,13 +1203,13 @@ static void dlm_act_fin_ack_rcv(struct midcomms_node *node)
 		wake_up(&node->shutdown_wait);
 		break;
 	default:
-		spin_unlock(&node->state_lock);
+		spin_unlock_bh(&node->state_lock);
 		log_print("%s: unexpected state: %d",
 			  __func__, node->state);
 		WARN_ON_ONCE(1);
 		return;
 	}
-	spin_unlock(&node->state_lock);
+	spin_unlock_bh(&node->state_lock);
 }
 
 void dlm_midcomms_add_member(int nodeid)
@@ -1224,7 +1224,7 @@ void dlm_midcomms_add_member(int nodeid)
 		return;
 	}
 
-	spin_lock(&node->state_lock);
+	spin_lock_bh(&node->state_lock);
 	if (!node->users) {
 		pr_debug("receive add member from node %d with state %s\n",
 			 node->nodeid, dlm_state_str(node->state));
@@ -1252,7 +1252,7 @@ void dlm_midcomms_add_member(int nodeid)
 
 	node->users++;
 	pr_debug("node %d users inc count %d\n", nodeid, node->users);
-	spin_unlock(&node->state_lock);
+	spin_unlock_bh(&node->state_lock);
 
 	srcu_read_unlock(&nodes_srcu, idx);
 }
@@ -1270,13 +1270,13 @@ void dlm_midcomms_remove_member(int nodeid)
 		return;
 	}
 
-	spin_lock(&node->state_lock);
+	spin_lock_bh(&node->state_lock);
 	/* case of dlm_midcomms_addr() created node but
 	 * was not added before because dlm_midcomms_close()
 	 * removed the node
 	 */
 	if (!node->users) {
-		spin_unlock(&node->state_lock);
+		spin_unlock_bh(&node->state_lock);
 		srcu_read_unlock(&nodes_srcu, idx);
 		return;
 	}
@@ -1314,7 +1314,7 @@ void dlm_midcomms_remove_member(int nodeid)
 			break;
 		}
 	}
-	spin_unlock(&node->state_lock);
+	spin_unlock_bh(&node->state_lock);
 
 	srcu_read_unlock(&nodes_srcu, idx);
 }
@@ -1352,7 +1352,7 @@ static void midcomms_shutdown(struct midcomms_node *node)
 		return;
 	}
 
-	spin_lock(&node->state_lock);
+	spin_lock_bh(&node->state_lock);
 	pr_debug("receive active shutdown for node %d with state %s\n",
 		 node->nodeid, dlm_state_str(node->state));
 	switch (node->state) {
@@ -1371,7 +1371,7 @@ static void midcomms_shutdown(struct midcomms_node *node)
 		 */
 		break;
 	}
-	spin_unlock(&node->state_lock);
+	spin_unlock_bh(&node->state_lock);
 
 	if (DLM_DEBUG_FENCE_TERMINATION)
 		msleep(5000);
@@ -1442,9 +1442,9 @@ int dlm_midcomms_close(int nodeid)
 	ret = dlm_lowcomms_close(nodeid);
 	dlm_delete_debug_comms_file(node->debugfs);
 
-	spin_lock(&nodes_lock);
+	spin_lock_bh(&nodes_lock);
 	hlist_del_rcu(&node->hlist);
-	spin_unlock(&nodes_lock);
+	spin_unlock_bh(&nodes_lock);
 	srcu_read_unlock(&nodes_srcu, idx);
 
 	/* wait that all readers left until flush send queue */
diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index 2e3f529f3ff2..be1a71a6303a 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -143,18 +143,18 @@ static int check_rcom_config(struct dlm_ls *ls, struct dlm_rcom *rc, int nodeid)
 
 static void allow_sync_reply(struct dlm_ls *ls, __le64 *new_seq)
 {
-	spin_lock(&ls->ls_rcom_spin);
+	spin_lock_bh(&ls->ls_rcom_spin);
 	*new_seq = cpu_to_le64(++ls->ls_rcom_seq);
 	set_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
-	spin_unlock(&ls->ls_rcom_spin);
+	spin_unlock_bh(&ls->ls_rcom_spin);
 }
 
 static void disallow_sync_reply(struct dlm_ls *ls)
 {
-	spin_lock(&ls->ls_rcom_spin);
+	spin_lock_bh(&ls->ls_rcom_spin);
 	clear_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
 	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
-	spin_unlock(&ls->ls_rcom_spin);
+	spin_unlock_bh(&ls->ls_rcom_spin);
 }
 
 /*
@@ -245,10 +245,10 @@ static void receive_rcom_status(struct dlm_ls *ls,
 		goto do_create;
 	}
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	status = ls->ls_recover_status;
 	num_slots = ls->ls_num_slots;
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 	len += num_slots * sizeof(struct rcom_slot);
 
  do_create:
@@ -266,9 +266,9 @@ static void receive_rcom_status(struct dlm_ls *ls,
 	if (!num_slots)
 		goto do_send;
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	if (ls->ls_num_slots != num_slots) {
-		spin_unlock(&ls->ls_recover_lock);
+		spin_unlock_bh(&ls->ls_recover_lock);
 		log_debug(ls, "receive_rcom_status num_slots %d to %d",
 			  num_slots, ls->ls_num_slots);
 		rc->rc_result = 0;
@@ -277,7 +277,7 @@ static void receive_rcom_status(struct dlm_ls *ls,
 	}
 
 	dlm_slots_copy_out(ls, rc);
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
  do_send:
 	send_rcom_stateless(msg, rc);
@@ -285,7 +285,7 @@ static void receive_rcom_status(struct dlm_ls *ls,
 
 static void receive_sync_reply(struct dlm_ls *ls, const struct dlm_rcom *rc_in)
 {
-	spin_lock(&ls->ls_rcom_spin);
+	spin_lock_bh(&ls->ls_rcom_spin);
 	if (!test_bit(LSFL_RCOM_WAIT, &ls->ls_flags) ||
 	    le64_to_cpu(rc_in->rc_id) != ls->ls_rcom_seq) {
 		log_debug(ls, "reject reply %d from %d seq %llx expect %llx",
@@ -301,7 +301,7 @@ static void receive_sync_reply(struct dlm_ls *ls, const struct dlm_rcom *rc_in)
 	clear_bit(LSFL_RCOM_WAIT, &ls->ls_flags);
 	wake_up(&ls->ls_wait_general);
  out:
-	spin_unlock(&ls->ls_rcom_spin);
+	spin_unlock_bh(&ls->ls_rcom_spin);
 }
 
 int dlm_rcom_names(struct dlm_ls *ls, int nodeid, char *last_name,
@@ -613,11 +613,11 @@ void dlm_receive_rcom(struct dlm_ls *ls, const struct dlm_rcom *rc, int nodeid)
 		break;
 	}
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	status = ls->ls_recover_status;
 	stop = dlm_recovery_stopped(ls);
 	seq = ls->ls_recover_seq;
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
 	if (stop && (rc->rc_type != cpu_to_le32(DLM_RCOM_STATUS)))
 		goto ignore;
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 4a4345455d7f..d3e177137b0b 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -74,9 +74,9 @@ int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
 uint32_t dlm_recover_status(struct dlm_ls *ls)
 {
 	uint32_t status;
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	status = ls->ls_recover_status;
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 	return status;
 }
 
@@ -87,9 +87,9 @@ static void _set_recover_status(struct dlm_ls *ls, uint32_t status)
 
 void dlm_set_recover_status(struct dlm_ls *ls, uint32_t status)
 {
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	_set_recover_status(ls, status);
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 }
 
 static int wait_status_all(struct dlm_ls *ls, uint32_t wait_status,
@@ -188,13 +188,13 @@ int dlm_recover_members_wait(struct dlm_ls *ls, uint64_t seq)
 
 		rv = dlm_slots_assign(ls, &num_slots, &slots_size, &slots, &gen);
 		if (!rv) {
-			spin_lock(&ls->ls_recover_lock);
+			spin_lock_bh(&ls->ls_recover_lock);
 			_set_recover_status(ls, DLM_RS_NODES_ALL);
 			ls->ls_num_slots = num_slots;
 			ls->ls_slots_size = slots_size;
 			ls->ls_slots = slots;
 			ls->ls_generation = gen;
-			spin_unlock(&ls->ls_recover_lock);
+			spin_unlock_bh(&ls->ls_recover_lock);
 		} else {
 			dlm_set_recover_status(ls, DLM_RS_NODES_ALL);
 		}
@@ -241,9 +241,9 @@ static int recover_list_empty(struct dlm_ls *ls)
 {
 	int empty;
 
-	spin_lock(&ls->ls_recover_list_lock);
+	spin_lock_bh(&ls->ls_recover_list_lock);
 	empty = list_empty(&ls->ls_recover_list);
-	spin_unlock(&ls->ls_recover_list_lock);
+	spin_unlock_bh(&ls->ls_recover_list_lock);
 
 	return empty;
 }
@@ -252,23 +252,23 @@ static void recover_list_add(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
 
-	spin_lock(&ls->ls_recover_list_lock);
+	spin_lock_bh(&ls->ls_recover_list_lock);
 	if (list_empty(&r->res_recover_list)) {
 		list_add_tail(&r->res_recover_list, &ls->ls_recover_list);
 		ls->ls_recover_list_count++;
 		dlm_hold_rsb(r);
 	}
-	spin_unlock(&ls->ls_recover_list_lock);
+	spin_unlock_bh(&ls->ls_recover_list_lock);
 }
 
 static void recover_list_del(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
 
-	spin_lock(&ls->ls_recover_list_lock);
+	spin_lock_bh(&ls->ls_recover_list_lock);
 	list_del_init(&r->res_recover_list);
 	ls->ls_recover_list_count--;
-	spin_unlock(&ls->ls_recover_list_lock);
+	spin_unlock_bh(&ls->ls_recover_list_lock);
 
 	dlm_put_rsb(r);
 }
@@ -277,7 +277,7 @@ static void recover_list_clear(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r, *s;
 
-	spin_lock(&ls->ls_recover_list_lock);
+	spin_lock_bh(&ls->ls_recover_list_lock);
 	list_for_each_entry_safe(r, s, &ls->ls_recover_list, res_recover_list) {
 		list_del_init(&r->res_recover_list);
 		r->res_recover_locks_count = 0;
@@ -290,17 +290,17 @@ static void recover_list_clear(struct dlm_ls *ls)
 			  ls->ls_recover_list_count);
 		ls->ls_recover_list_count = 0;
 	}
-	spin_unlock(&ls->ls_recover_list_lock);
+	spin_unlock_bh(&ls->ls_recover_list_lock);
 }
 
 static int recover_idr_empty(struct dlm_ls *ls)
 {
 	int empty = 1;
 
-	spin_lock(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_idr_lock);
 	if (ls->ls_recover_list_count)
 		empty = 0;
-	spin_unlock(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_idr_lock);
 
 	return empty;
 }
@@ -310,7 +310,7 @@ static int recover_idr_add(struct dlm_rsb *r)
 	struct dlm_ls *ls = r->res_ls;
 	int rv;
 
-	spin_lock(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_idr_lock);
 	if (r->res_id) {
 		rv = -1;
 		goto out_unlock;
@@ -324,7 +324,7 @@ static int recover_idr_add(struct dlm_rsb *r)
 	dlm_hold_rsb(r);
 	rv = 0;
 out_unlock:
-	spin_unlock(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_idr_lock);
 	return rv;
 }
 
@@ -332,11 +332,11 @@ static void recover_idr_del(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
 
-	spin_lock(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_idr_lock);
 	idr_remove(&ls->ls_recover_idr, r->res_id);
 	r->res_id = 0;
 	ls->ls_recover_list_count--;
-	spin_unlock(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_idr_lock);
 
 	dlm_put_rsb(r);
 }
@@ -345,9 +345,9 @@ static struct dlm_rsb *recover_idr_find(struct dlm_ls *ls, uint64_t id)
 {
 	struct dlm_rsb *r;
 
-	spin_lock(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_idr_lock);
 	r = idr_find(&ls->ls_recover_idr, (int)id);
-	spin_unlock(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_idr_lock);
 	return r;
 }
 
@@ -356,7 +356,7 @@ static void recover_idr_clear(struct dlm_ls *ls)
 	struct dlm_rsb *r;
 	int id;
 
-	spin_lock(&ls->ls_recover_idr_lock);
+	spin_lock_bh(&ls->ls_recover_idr_lock);
 
 	idr_for_each_entry(&ls->ls_recover_idr, r, id) {
 		idr_remove(&ls->ls_recover_idr, id);
@@ -372,7 +372,7 @@ static void recover_idr_clear(struct dlm_ls *ls)
 			  ls->ls_recover_list_count);
 		ls->ls_recover_list_count = 0;
 	}
-	spin_unlock(&ls->ls_recover_idr_lock);
+	spin_unlock_bh(&ls->ls_recover_idr_lock);
 }
 
 
@@ -886,7 +886,7 @@ void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 	int i;
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock(&ls->ls_rsbtbl[i].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
 			list_add(&r->res_root_list, root_list);
@@ -895,7 +895,7 @@ void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 
 		if (!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].toss))
 			log_error(ls, "dlm_create_root_list toss not empty");
-		spin_unlock(&ls->ls_rsbtbl[i].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
 }
 
@@ -917,7 +917,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 	int i;
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock(&ls->ls_rsbtbl[i].lock);
+		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].toss); n; n = next) {
 			next = rb_next(n);
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
@@ -925,7 +925,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 			dlm_free_rsb(r);
 			count++;
 		}
-		spin_unlock(&ls->ls_rsbtbl[i].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
 
 	if (count)
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index b3c9b704883c..67d8e84c2db2 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -32,9 +32,9 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 {
 	int error = -EINTR;
 
-	write_lock(&ls->ls_recv_active);
+	write_lock_bh(&ls->ls_recv_active);
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	if (ls->ls_recover_seq == seq) {
 		set_bit(LSFL_RUNNING, &ls->ls_flags);
 		/* unblocks processes waiting to enter the dlm */
@@ -42,9 +42,9 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 		clear_bit(LSFL_RECOVER_LOCK, &ls->ls_flags);
 		error = 0;
 	}
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
-	write_unlock(&ls->ls_recv_active);
+	write_unlock_bh(&ls->ls_recv_active);
 	return error;
 }
 
@@ -268,12 +268,12 @@ static void do_ls_recovery(struct dlm_ls *ls)
 	struct dlm_recover *rv = NULL;
 	int error;
 
-	spin_lock(&ls->ls_recover_lock);
+	spin_lock_bh(&ls->ls_recover_lock);
 	rv = ls->ls_recover_args;
 	ls->ls_recover_args = NULL;
 	if (rv && ls->ls_recover_seq == rv->seq)
 		clear_bit(LSFL_RECOVER_STOP, &ls->ls_flags);
-	spin_unlock(&ls->ls_recover_lock);
+	spin_unlock_bh(&ls->ls_recover_lock);
 
 	if (rv) {
 		error = ls_recover(ls, rv);
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 9b646026df46..719a5243a069 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -68,7 +68,7 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 	struct dlm_message *ms;
 	int error = 0;
 
-	write_lock(&ls->ls_requestqueue_lock);
+	write_lock_bh(&ls->ls_requestqueue_lock);
 	for (;;) {
 		if (list_empty(&ls->ls_requestqueue)) {
 			clear_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags);
@@ -96,11 +96,11 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 			error = -EINTR;
 			break;
 		}
-		write_unlock(&ls->ls_requestqueue_lock);
+		write_unlock_bh(&ls->ls_requestqueue_lock);
 		schedule();
-		write_lock(&ls->ls_requestqueue_lock);
+		write_lock_bh(&ls->ls_requestqueue_lock);
 	}
-	write_unlock(&ls->ls_requestqueue_lock);
+	write_unlock_bh(&ls->ls_requestqueue_lock);
 
 	return error;
 }
@@ -135,7 +135,7 @@ void dlm_purge_requestqueue(struct dlm_ls *ls)
 	struct dlm_message *ms;
 	struct rq_entry *e, *safe;
 
-	write_lock(&ls->ls_requestqueue_lock);
+	write_lock_bh(&ls->ls_requestqueue_lock);
 	list_for_each_entry_safe(e, safe, &ls->ls_requestqueue, list) {
 		ms =  &e->request;
 
@@ -144,6 +144,6 @@ void dlm_purge_requestqueue(struct dlm_ls *ls)
 			kfree(e);
 		}
 	}
-	write_unlock(&ls->ls_requestqueue_lock);
+	write_unlock_bh(&ls->ls_requestqueue_lock);
 }
 
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 695e691b38b3..c0d35678ee54 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -206,7 +206,7 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		return;
 
 	ls = lkb->lkb_resource->res_ls;
-	spin_lock(&ls->ls_clear_proc_locks);
+	spin_lock_bh(&ls->ls_clear_proc_locks);
 
 	/* If ORPHAN/DEAD flag is set, it means the process is dead so an ast
 	   can't be delivered.  For ORPHAN's, dlm_clear_proc_locks() freed
@@ -228,12 +228,12 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 	if ((flags & DLM_CB_CAST) && lkb_is_endoflife(mode, status))
 		set_bit(DLM_IFL_ENDOFLIFE_BIT, &lkb->lkb_iflags);
 
-	spin_lock(&proc->asts_spin);
+	spin_lock_bh(&proc->asts_spin);
 
 	rv = dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags);
 	switch (rv) {
 	case DLM_ENQUEUE_CALLBACK_FAILURE:
-		spin_unlock(&proc->asts_spin);
+		spin_unlock_bh(&proc->asts_spin);
 		WARN_ON_ONCE(1);
 		goto out;
 	case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
@@ -247,19 +247,19 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	spin_unlock(&proc->asts_spin);
+	spin_unlock_bh(&proc->asts_spin);
 
 	if (test_bit(DLM_IFL_ENDOFLIFE_BIT, &lkb->lkb_iflags)) {
 		/* N.B. spin_lock locks_spin, not asts_spin */
-		spin_lock(&proc->locks_spin);
+		spin_lock_bh(&proc->locks_spin);
 		if (!list_empty(&lkb->lkb_ownqueue)) {
 			list_del_init(&lkb->lkb_ownqueue);
 			dlm_put_lkb(lkb);
 		}
-		spin_unlock(&proc->locks_spin);
+		spin_unlock_bh(&proc->locks_spin);
 	}
  out:
-	spin_unlock(&ls->ls_clear_proc_locks);
+	spin_unlock_bh(&ls->ls_clear_proc_locks);
 }
 
 static int device_user_lock(struct dlm_user_proc *proc,
@@ -832,10 +832,10 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	if (test_bit(DLM_PROC_FLAGS_CLOSING, &proc->flags))
 		return -EINVAL;
 
-	spin_lock(&proc->asts_spin);
+	spin_lock_bh(&proc->asts_spin);
 	if (list_empty(&proc->asts)) {
 		if (file->f_flags & O_NONBLOCK) {
-			spin_unlock(&proc->asts_spin);
+			spin_unlock_bh(&proc->asts_spin);
 			return -EAGAIN;
 		}
 
@@ -844,16 +844,16 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 	repeat:
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (list_empty(&proc->asts) && !signal_pending(current)) {
-			spin_unlock(&proc->asts_spin);
+			spin_unlock_bh(&proc->asts_spin);
 			schedule();
-			spin_lock(&proc->asts_spin);
+			spin_lock_bh(&proc->asts_spin);
 			goto repeat;
 		}
 		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&proc->wait, &wait);
 
 		if (signal_pending(current)) {
-			spin_unlock(&proc->asts_spin);
+			spin_unlock_bh(&proc->asts_spin);
 			return -ERESTARTSYS;
 		}
 	}
@@ -875,7 +875,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 		 */
 		log_print("dlm_rem_lkb_callback empty %x", lkb->lkb_id);
 		list_del_init(&lkb->lkb_cb_list);
-		spin_unlock(&proc->asts_spin);
+		spin_unlock_bh(&proc->asts_spin);
 		/* removes ref for proc->asts, may cause lkb to be freed */
 		dlm_put_lkb(lkb);
 		WARN_ON_ONCE(1);
@@ -890,7 +890,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 		WARN_ON_ONCE(1);
 		break;
 	}
-	spin_unlock(&proc->asts_spin);
+	spin_unlock_bh(&proc->asts_spin);
 
 	if (cb->flags & DLM_CB_BAST) {
 		trace_dlm_bast(lkb->lkb_resource->res_ls, lkb, cb->mode);
@@ -925,12 +925,12 @@ static __poll_t device_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &proc->wait, wait);
 
-	spin_lock(&proc->asts_spin);
+	spin_lock_bh(&proc->asts_spin);
 	if (!list_empty(&proc->asts)) {
-		spin_unlock(&proc->asts_spin);
+		spin_unlock_bh(&proc->asts_spin);
 		return EPOLLIN | EPOLLRDNORM;
 	}
-	spin_unlock(&proc->asts_spin);
+	spin_unlock_bh(&proc->asts_spin);
 	return 0;
 }
 
-- 
2.39.3

