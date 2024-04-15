Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B103154C02
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206390; cv=none; b=PMbUHvKfzJsErx34JXZqEERhZvjmXRjNyrskM2kEi036lswBUzU6czT6bJCnockzB3EjUS7gvo0985qsH+eNZdLElu7CIxNTeSLhymXo2qejrAUo1D+ExEsTbsV4KHNa62wYi+MpeDiNdKDEjfu5GSBbY6N0Oc78nh7ci7VHB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206390; c=relaxed/simple;
	bh=PUyr4wKJJ6uaVg5CG+lyWDvJ4fszdx/1DS/OWfi5vx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQfwC9EInMG2fFZIE3Wl+P24M5ogI7ZyQMs1yZKzMort0baq77UrGjdzN5JvXqTDc2nSpuEfxSsyUIAcjaih/ghh/LvO4JU3Lmm6aWx1db7iH0KL7P3StdvdGe206Rbq6lcr/B70eNyWmdhLlkbTnIVy+AjYqGyTiZ+9y1bShn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzus84DY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzus84DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEWm5t1Sf5C90vzJscFuCkKK6YSi+zeOdckSFFCmDy0=;
	b=hzus84DY8k2LZHJCEAmRWWjpV8vdym/BBpmWWq9/PQCDHS5R2vkYVBjtRmLZ8XcK+m+EDy
	9pgaxdBMoNiywgSTb7fmvMGrVouaBXpJ7AlZzlC2ndlEqxdKXqYtSCEfv5VDQlPKB03qIx
	voa8xy14Ub2hllGsy/mzKiLwx+5OyUY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-UCmFksrPMrumkHkpHGJC6w-1; Mon,
 15 Apr 2024 14:39:45 -0400
X-MC-Unique: UCmFksrPMrumkHkpHGJC6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC6E299E74C
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFFBC13FA8;
	Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 8/9] dlm: likely read lock path for rsb lookup
Date: Mon, 15 Apr 2024 14:39:42 -0400
Message-ID: <20240415183943.645497-9-aahringo@redhat.com>
In-Reply-To: <20240415183943.645497-1-aahringo@redhat.com>
References: <20240415183943.645497-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As the conversion to rhashtable introduced a hash lock per lockspace
instead of doing a per bucket hash, this patch will change the hash lock
handling as holding only a read lock in a very likely hot path in DLM.

This hot path is to lookup rsbs and they are in keep state. Keep state
means that the RSB_TOSS flag isn't set. If this likely read lock path is
the case we don't need to hold the ls_rsbtbl_lock in write lock at all.
If it's on toss state holding the ls_rsbtbl_lock in write lock is
required. If we see that the rsb is in toss state, we hold the
ls_rsbtbl_lock in write state and relookup (because the rsb could get
removed into the transition from read to write state) and check if the
rsb is still in toss state. However this is an unlikely path as toss
rsbs are cached rsbs. Having the rsb in keep state is very likely.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     |   4 +-
 fs/dlm/dir.c          |   4 +-
 fs/dlm/dlm_internal.h |   2 +-
 fs/dlm/lock.c         | 269 ++++++++++++++++++++++++++++++------------
 fs/dlm/lockspace.c    |   2 +-
 fs/dlm/recover.c      |   4 +-
 fs/dlm/recoverd.c     |   8 +-
 7 files changed, 206 insertions(+), 87 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 70567919f1b7..6ab3ed4074c6 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -413,7 +413,7 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 	else
 		list = &ls->ls_keep;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	return seq_list_start(list, *pos);
 }
 
@@ -434,7 +434,7 @@ static void table_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
 	struct dlm_ls *ls = seq->private;
 
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static const struct seq_operations format1_seq_ops = {
diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index 9687f908476b..b1ab0adbd9d0 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -200,9 +200,9 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	struct dlm_rsb *r;
 	int rv;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 	if (!rv)
 		return r;
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 98a0ac511bc8..b675bffb61ae 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -585,7 +585,7 @@ struct dlm_ls {
 	spinlock_t		ls_lkbidr_spin;
 
 	struct rhashtable	ls_rsbtbl;
-	spinlock_t		ls_rsbtbl_lock;
+	rwlock_t		ls_rsbtbl_lock;
 
 	struct list_head	ls_toss;
 	struct list_head	ls_keep;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 7c97181a04fe..790d0fd76bbe 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -342,15 +342,15 @@ void dlm_hold_rsb(struct dlm_rsb *r)
 
 /* TODO move this to lib/refcount.c */
 static __must_check bool
-dlm_refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
+dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
 __cond_acquires(lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
 
-	spin_lock_bh(lock);
+	write_lock_bh(lock);
 	if (!refcount_dec_and_test(r)) {
-		spin_unlock_bh(lock);
+		write_unlock_bh(lock);
 		return false;
 	}
 
@@ -358,11 +358,11 @@ __cond_acquires(lock)
 }
 
 /* TODO move this to include/linux/kref.h */
-static inline int dlm_kref_put_lock_bh(struct kref *kref,
-				       void (*release)(struct kref *kref),
-				       spinlock_t *lock)
+static inline int dlm_kref_put_write_lock_bh(struct kref *kref,
+					     void (*release)(struct kref *kref),
+					     rwlock_t *lock)
 {
-	if (dlm_refcount_dec_and_lock_bh(&kref->refcount, lock)) {
+	if (dlm_refcount_dec_and_write_lock_bh(&kref->refcount, lock)) {
 		release(kref);
 		return 1;
 	}
@@ -378,10 +378,10 @@ static void put_rsb(struct dlm_rsb *r)
 	struct dlm_ls *ls = r->res_ls;
 	int rv;
 
-	rv = dlm_kref_put_lock_bh(&r->res_ref, toss_rsb,
-				  &ls->ls_rsbtbl_lock);
+	rv = dlm_kref_put_write_lock_bh(&r->res_ref, toss_rsb,
+					&ls->ls_rsbtbl_lock);
 	if (rv)
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 void dlm_put_rsb(struct dlm_rsb *r)
@@ -603,7 +603,7 @@ void dlm_rsb_toss_timer(struct timer_list *timer)
 		 * a caching handling and the other holders might to put
 		 * this rsb out of the toss state.
 		 */
-		rv = spin_trylock(&ls->ls_rsbtbl_lock);
+		rv = write_trylock(&ls->ls_rsbtbl_lock);
 		if (!rv) {
 			spin_unlock(&ls->ls_toss_q_lock);
 			/* rearm again try timer */
@@ -618,7 +618,7 @@ void dlm_rsb_toss_timer(struct timer_list *timer)
 		/* not necessary to held the ls_rsbtbl_lock when
 		 * calling send_remove()
 		 */
-		spin_unlock(&ls->ls_rsbtbl_lock);
+		write_unlock(&ls->ls_rsbtbl_lock);
 
 		/* remove the rsb out of the toss queue its gone
 		 * drom DLM now
@@ -702,16 +702,8 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 
 static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
 {
-	int rv;
-
-	rv = rhashtable_insert_fast(rhash, &rsb->res_node,
-				    dlm_rhash_rsb_params);
-	if (rv == -EEXIST) {
-		log_print("%s match", __func__);
-		dlm_dump_rsb(rsb);
-	}
-
-	return rv;
+	return rhashtable_insert_fast(rhash, &rsb->res_node,
+				      dlm_rhash_rsb_params);
 }
 
 /*
@@ -806,24 +798,47 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 			goto out;
 	}
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+ retry_lookup:
 
+	/* check if the rsb is in keep state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (error)
+	if (error) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_new;
+	}
 	
 	/*
 	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
-	if (rsb_flag(r, RSB_TOSS))
+	if (rsb_flag(r, RSB_TOSS)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_toss;
+	}
 
 	kref_get(&r->res_ref);
-	goto out_unlock;
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	goto out;
 
 
  do_toss:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+
+	/* retry lookup under write lock to see if its still in toss state
+	 * if not it's in keep state and we relookup - unlikely path.
+	 */
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (!error) {
+		if (!rsb_flag(r, RSB_TOSS)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry_lookup;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
+
 	/*
 	 * rsb found inactive (master_nodeid may be out of date unless
 	 * we are the dir_nodeid or were the master)  No other thread
@@ -837,8 +852,9 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		log_debug(ls, "find_rsb toss from_other %d master %d dir %d %s",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid,
 			  r->res_name);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if ((r->res_master_nodeid != our_nodeid) && from_dir) {
@@ -868,9 +884,9 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	 */
 	kref_init(&r->res_ref);
 	rsb_delete_toss_timer(ls, r);
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	goto out_unlock;
+	goto out;
 
 
  do_new:
@@ -879,15 +895,13 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	 */
 
 	if (error == -EBADR && !create)
-		goto out_unlock;
+		goto out;
 
 	error = get_rsb_struct(ls, name, len, &r);
-	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	if (error == -EAGAIN)
 		goto retry;
-	}
 	if (error)
-		goto out_unlock;
+		goto out;
 
 	r->res_hash = hash;
 	r->res_dir_nodeid = dir_nodeid;
@@ -909,7 +923,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		dlm_free_rsb(r);
 		r = NULL;
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (from_other) {
@@ -929,11 +943,20 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	}
 
  out_add:
+
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
-	if (!error)
+	if (error == -EEXIST) {
+		/* somebody else was faster and it seems the
+		 * rsb exists now, we do a whole relookup
+		 */
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		dlm_free_rsb(r);
+		goto retry_lookup;
+	} else if (!error) {
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
- out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	}
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
 	*r_ret = r;
 	return error;
@@ -957,24 +980,49 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	if (error < 0)
 		goto out;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+ retry_lookup:
 
+	/* check if the rsb is in keep state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (error)
+	if (error) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_new;
+	}
 
-	if (rsb_flag(r, RSB_TOSS))
+	if (rsb_flag(r, RSB_TOSS)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto do_toss;
+	}
 
 	/*
 	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
 	kref_get(&r->res_ref);
-	goto out_unlock;
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+
+	goto out;
 
 
  do_toss:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+
+	/* retry lookup under write lock to see if its still in toss state
+	 * if not it's in keep state and we relookup - unlikely path.
+	 */
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (!error) {
+		if (!rsb_flag(r, RSB_TOSS)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry_lookup;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
+
+
 	/*
 	 * rsb found inactive. No other thread is using this rsb because
 	 * it's on the toss list, so we can look at or update
@@ -987,8 +1035,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		log_error(ls, "find_rsb toss from_nodeid %d master %d dir %d",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid);
 		dlm_print_rsb(r);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (!recover && (r->res_master_nodeid != our_nodeid) &&
@@ -1010,9 +1059,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 */
 	kref_init(&r->res_ref);
 	rsb_delete_toss_timer(ls, r);
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	goto out_unlock;
+	goto out;
 
 
  do_new:
@@ -1022,11 +1071,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 	if (error)
-		goto out_unlock;
+		goto out;
 
 	r->res_hash = hash;
 	r->res_dir_nodeid = dir_nodeid;
@@ -1034,11 +1082,20 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	r->res_nodeid = (dir_nodeid == our_nodeid) ? 0 : dir_nodeid;
 	kref_init(&r->res_ref);
 
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
-	if (!error)
+	if (error == -EEXIST) {
+		/* somebody else was faster and it seems the
+		 * rsb exists now, we do a whole relookup
+		 */
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		dlm_free_rsb(r);
+		goto retry_lookup;
+	} else if (!error) {
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
- out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	}
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+
  out:
 	*r_ret = r;
 	return error;
@@ -1251,18 +1308,23 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error < 0)
 		return error;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+ retry_lookup:
+
+	/* check if the rsb is in keep state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error) {
-		if (rsb_flag(r, RSB_TOSS))
+		if (rsb_flag(r, RSB_TOSS)) {
+			read_unlock_bh(&ls->ls_rsbtbl_lock);
 			goto do_toss;
+		}
 
 		/* because the rsb is active, we need to lock_rsb before
 		 * checking/changing re_master_nodeid
 		 */
 
 		hold_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		lock_rsb(r);
 
 		__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
@@ -1274,10 +1336,31 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 		return 0;
 	} else {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto not_found;
 	}
 
  do_toss:
+	/* unlikely path - relookup under write */
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+
+	/* rsb_mod_timer() requires to held ls_rsbtbl_lock in write lock
+	 * check if the rsb is still in toss state, if not relookup
+	 */
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (!error) {
+		if (!rsb_flag(r, RSB_TOSS)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			/* something as changed, very unlikely but
+			 * try again
+			 */
+			goto retry_lookup;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto not_found;
+	}
+
 	/* because the rsb is inactive (on toss list), it's not refcounted
 	 * and lock_rsb is not used, but is protected by the rsbtbl lock
 	 */
@@ -1287,18 +1370,16 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 	rsb_mod_timer(ls, r);
 	/* the rsb was inactive (on toss list) */
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	return 0;
 
  not_found:
 	error = get_rsb_struct(ls, name, len, &r);
-	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	if (error == -EAGAIN)
 		goto retry;
-	}
 	if (error)
-		goto out_unlock;
+		goto out;
 
 	r->res_hash = hash;
 	r->res_dir_nodeid = our_nodeid;
@@ -1307,22 +1388,30 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	kref_init(&r->res_ref);
 	rsb_set_flag(r, RSB_TOSS);
 
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
-	if (error) {
+	if (error == -EEXIST) {
+		/* somebody else was faster and it seems the
+		 * rsb exists now, we do a whole relookup
+		 */
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		dlm_free_rsb(r);
+		goto retry_lookup;
+	} else if (error) {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		/* should never happen */
 		dlm_free_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 
 	list_add(&r->res_rsbs_list, &ls->ls_toss);
 	rsb_mod_timer(ls, r);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	if (result)
 		*result = DLM_LU_ADD;
 	*r_nodeid = from_nodeid;
- out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
 	return error;
 }
 
@@ -1330,12 +1419,12 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 {
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		if (r->res_hash == hash)
 			dlm_dump_rsb(r);
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
@@ -1343,14 +1432,14 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 	struct dlm_rsb *r = NULL;
 	int error;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error)
 		goto out;
 
 	dlm_dump_rsb(r);
  out:
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static void toss_rsb(struct kref *kref)
@@ -1478,6 +1567,36 @@ static void kill_lkb(struct kref *kref)
 	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
 }
 
+/* TODO move this to lib/refcount.c */
+static __must_check bool
+dlm_refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
+__cond_acquires(lock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	spin_lock_bh(lock);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_bh(lock);
+		return false;
+	}
+
+	return true;
+}
+
+/* TODO move this to include/linux/kref.h */
+static inline int dlm_kref_put_lock_bh(struct kref *kref,
+				       void (*release)(struct kref *kref),
+				       spinlock_t *lock)
+{
+	if (dlm_refcount_dec_and_lock_bh(&kref->refcount, lock)) {
+		release(kref);
+		return 1;
+	}
+
+	return 0;
+}
+
 /* __put_lkb() is used when an lkb may not have an rsb attached to
    it so we need to provide the lockspace explicitly */
 
@@ -4247,14 +4366,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	memset(name, 0, sizeof(name));
 	memcpy(name, ms->m_extra, len);
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (rv) {
 		/* should not happen */
 		log_error(ls, "%s from %d not found %s", __func__,
 			  from_nodeid, name);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
@@ -4264,14 +4383,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 			log_error(ls, "receive_remove keep from %d master %d",
 				  from_nodeid, r->res_master_nodeid);
 			dlm_print_rsb(r);
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			return;
 		}
 
 		log_debug(ls, "receive_remove from %d master %d first %x %s",
 			  from_nodeid, r->res_master_nodeid, r->res_first_lkid,
 			  name);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
@@ -4279,14 +4398,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 		log_error(ls, "receive_remove toss from %d master %d",
 			  from_nodeid, r->res_master_nodeid);
 		dlm_print_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
 	list_del(&r->res_rsbs_list);
 	rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 			       dlm_rhash_rsb_params);
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	free_toss_rsb(r);
 }
@@ -5354,7 +5473,7 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		if (!rsb_flag(r, RSB_RECOVER_GRANT))
 			continue;
@@ -5363,10 +5482,10 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
 			continue;
 		}
 		hold_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		return r;
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 	return NULL;
 }
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 931eb3f22ec6..04f4c74831ce 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -424,7 +424,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	INIT_LIST_HEAD(&ls->ls_toss);
 	INIT_LIST_HEAD(&ls->ls_keep);
-	spin_lock_init(&ls->ls_rsbtbl_lock);
+	rwlock_init(&ls->ls_rsbtbl_lock);
 
 	error = rhashtable_init(&ls->ls_rsbtbl, &dlm_rhash_rsb_params);
 	if (error)
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 960a14b95605..f493d5f30c58 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -884,7 +884,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 	struct dlm_rsb *r, *safe;
 	unsigned int count = 0;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
@@ -897,7 +897,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 		free_toss_rsb(r);
 		count++;
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	if (count)
 		log_rinfo(ls, "dlm_clear_toss %u done", count);
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index c831e0275912..17a40d1e6036 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -32,7 +32,7 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 		goto out;
 	}
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		if (r->res_nodeid)
 			continue;
@@ -40,7 +40,7 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 		list_add(&r->res_masters_list, &ls->ls_masters_list);
 		dlm_hold_rsb(r);
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
 	write_unlock_bh(&ls->ls_masters_lock);
 	return error;
@@ -62,14 +62,14 @@ static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 {
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		list_add(&r->res_root_list, root_list);
 		dlm_hold_rsb(r);
 	}
 
 	WARN_ON_ONCE(!list_empty(&ls->ls_toss));
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static void dlm_release_root_list(struct list_head *root_list)
-- 
2.43.0

