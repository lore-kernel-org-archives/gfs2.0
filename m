Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D2163A9B
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756956; cv=none; b=U4ZksqwTcX2OCRA5KhIcx80VDfG/OBPq2rwLwfVI14HFaP1RdCrp0fuWzOe06xOBdSCR8CnRnAUbyfO55D/J0zm+jG6m27TZDxzcBJGk91IUFY/+SY8gMpZfb+uoBPlGqcg4XWl1zPGQb2kimvPWxsQ8exg2rxI9Si/mItg8bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756956; c=relaxed/simple;
	bh=trCiIBfSCqCbL3NICQtjna39fyhCGkD/B4PHKp0ijO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7oC24H0wCopSFKJnyz6zYI91RHx8H1GXe/5+J8/mxfsuhOpCDMCom9fix0bp2Rx7Rn1vy0CIxFYg7m1LMs1rPHouxTXJlrj7xM6aXqHzz5hwBeYvKlWYhu5E8Vo9mo+McC2bzOLbu9O2OQ83sjZnTPvgGySCsDHEJHgKKX9jPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWbzKsv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWbzKsv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPB+UHA+YCX/sKzgufjmrJihFdVHsecDCTmDlhbVbyU=;
	b=SWbzKsv936RlFLxWVAEmxn0Wq/ajOqJyLEMQMbGpltuLKPgvuh8awLr5egYwaytJnf6/HP
	D5EI9afe9lnstLclefwXNJ4WIegoJee9hPIjEefL9incxpD9E4bP0XE6TCpFfpUYkSumx2
	vVW1wkwM+xyvcwIbTvy/ix1nIbnhhms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-rAl6Jg9-PYeUkeTqLEqaqQ-1; Wed, 10 Apr 2024 09:49:09 -0400
X-MC-Unique: rAl6Jg9-PYeUkeTqLEqaqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 045F518A099D
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:09 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E98FAC27EB4;
	Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 8/9] dlm: likely read lock path for rsb lookup
Date: Wed, 10 Apr 2024 09:48:57 -0400
Message-ID: <20240410134858.3295266-9-aahringo@redhat.com>
In-Reply-To: <20240410134858.3295266-1-aahringo@redhat.com>
References: <20240410134858.3295266-1-aahringo@redhat.com>
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
 fs/dlm/lock.c         | 260 ++++++++++++++++++++++++++++++------------
 fs/dlm/lockspace.c    |   2 +-
 fs/dlm/recover.c      |   6 +-
 fs/dlm/recoverd.c     |   8 +-
 7 files changed, 202 insertions(+), 84 deletions(-)

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
index 0ab76ed8685e..5714c073887d 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -586,7 +586,7 @@ struct dlm_ls {
 	spinlock_t		ls_lkbidr_spin;
 
 	struct rhashtable	ls_rsbtbl;
-	spinlock_t		ls_rsbtbl_lock;
+	rwlock_t		ls_rsbtbl_lock;
 
 	struct list_head	ls_toss;
 	struct list_head	ls_keep;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index b3f0b0445812..5cf94203b2db 100644
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
@@ -472,7 +472,7 @@ static void dlm_rsb_toss_timer(struct timer_list *timer)
 		return;
 	}
 
-	rv = spin_trylock(&ls->ls_rsbtbl_lock);
+	rv = write_trylock(&ls->ls_rsbtbl_lock);
 	if (!rv) {
 		dlm_unlock_recovery(ls);
 		/* rearm timer */
@@ -490,7 +490,7 @@ static void dlm_rsb_toss_timer(struct timer_list *timer)
 	 */
 	if (rsb_flag(r, RSB_TIMER_KILLED) ||
 	    timer_pending(&r->res_toss_timer)) {
-		spin_unlock(&ls->ls_rsbtbl_lock);
+		write_unlock(&ls->ls_rsbtbl_lock);
 		dlm_unlock_recovery(ls);
 		return;
 	}
@@ -502,7 +502,7 @@ static void dlm_rsb_toss_timer(struct timer_list *timer)
 	/* not necessary to held the ls_rsbtbl_lock when
 	 * calling send_remove() its gone from DLM now
 	 */
-	spin_unlock(&ls->ls_rsbtbl_lock);
+	write_unlock(&ls->ls_rsbtbl_lock);
 
 	/* no rsb in this state should ever run a timer */
 	WARN_ON(!dlm_no_directory(ls) &&
@@ -583,16 +583,8 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 
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
@@ -687,11 +679,15 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
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
@@ -701,7 +697,8 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		goto do_toss;
 
 	kref_get(&r->res_ref);
-	goto out_unlock;
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	goto out;
 
 
  do_toss:
@@ -718,8 +715,9 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		log_debug(ls, "find_rsb toss from_other %d master %d dir %d %s",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid,
 			  r->res_name);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if ((r->res_master_nodeid != our_nodeid) && from_dir) {
@@ -741,6 +739,23 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
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
 	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
 	/* rsb got out of toss state, it becomes alive again
@@ -756,8 +771,9 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	 */
 	rsb_set_flag(r, RSB_TIMER_KILLED);
 	timer_delete(&r->res_toss_timer);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	goto out_unlock;
+	goto out;
 
 
  do_new:
@@ -766,15 +782,13 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
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
@@ -796,7 +810,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		dlm_free_rsb(r);
 		r = NULL;
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (from_other) {
@@ -816,11 +830,20 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
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
@@ -844,11 +867,15 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
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
 
 	if (rsb_flag(r, RSB_TOSS))
 		goto do_toss;
@@ -858,7 +885,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 */
 
 	kref_get(&r->res_ref);
-	goto out_unlock;
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+
+	goto out;
 
 
  do_toss:
@@ -874,8 +903,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		log_error(ls, "find_rsb toss from_nodeid %d master %d dir %d",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid);
 		dlm_print_rsb(r);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (!recover && (r->res_master_nodeid != our_nodeid) &&
@@ -889,6 +919,24 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
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
 	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
 	/* rsb got out of toss state, it becomes alive again
@@ -904,8 +952,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 */
 	rsb_set_flag(r, RSB_TIMER_KILLED);
 	timer_delete(&r->res_toss_timer);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	goto out_unlock;
+	goto out;
 
 
  do_new:
@@ -915,11 +964,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
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
@@ -927,11 +975,20 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
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
@@ -1144,7 +1201,10 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error < 0)
 		return error;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+ retry_lookup:
+
+	/* check if the rsb is in keep state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error) {
 		if (rsb_flag(r, RSB_TOSS))
@@ -1155,7 +1215,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		 */
 
 		hold_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		lock_rsb(r);
 
 		__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
@@ -1167,6 +1227,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 		return 0;
 	} else {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto not_found;
 	}
 
@@ -1178,20 +1239,39 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
 			    r_nodeid, result);
 
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
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
@@ -1200,22 +1280,30 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
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
 
@@ -1223,12 +1311,12 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
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
@@ -1236,14 +1324,14 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
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
@@ -1376,6 +1464,36 @@ static void kill_lkb(struct kref *kref)
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
 
@@ -4145,14 +4263,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
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
 
@@ -4162,14 +4280,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
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
 
@@ -4177,14 +4295,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
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
@@ -5252,7 +5370,7 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		if (!rsb_flag(r, RSB_RECOVER_GRANT))
 			continue;
@@ -5261,10 +5379,10 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
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
index df7ff5824830..07d47f3427bf 100644
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
index fb726dad3c53..d976c9eeed84 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -885,11 +885,11 @@ void dlm_clear_toss(struct dlm_ls *ls)
 	struct dlm_rsb *r;
 
 	while (1) {
-		spin_lock_bh(&ls->ls_rsbtbl_lock);
+		write_lock_bh(&ls->ls_rsbtbl_lock);
 		r = list_first_entry_or_null(&ls->ls_toss, struct dlm_rsb,
 					     res_rsbs_list);
 		if (!r) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			break;
 		}
 
@@ -897,7 +897,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
 		rsb_set_flag(r, RSB_TIMER_KILLED);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 		/* Wait until all killed currently running timer
 		 * callbacks are done. Killed as RSB_TIMER_KILLED
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 5e8e10030b74..2a17570cae70 100644
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

