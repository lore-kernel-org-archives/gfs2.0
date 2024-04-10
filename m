Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5B16ABC4
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756955; cv=none; b=Mhj4b8FoCh3hCXzvCtSWY1Jek1o7Dh7smelVUgt2H2Mw8S3gZdAujPhImu0sKyGFww2vwgQq0YjfzIuDKzB5ErWH66PzdwZ7FhW3IojQLiyRsxX8y7774kLueKS1CioWranlgMMq6QivDD680Z0D8gUj3rWG9MZ3uJlu1XWw19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756955; c=relaxed/simple;
	bh=n59d619nRxhy395h3LKEdXA4ymnnWAWUu9/1P2TN2QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk6BDYNSc8GQUK5wj1fSwpjIN5V90tHDGwrOyL2rVtc6GSWymQWTO/SiWXHfsje5tekgEOwYWe+pTmPlUtEVaE8jQ9n2G70NjxsZFGpNY0VeaeWOBo8HCBbD+dVlhV4YfC0VaXy9UqpsZBqi2vdzrgQyHMezVCqWF0Qak4FK9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEZNxa3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEZNxa3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzDKeFfrM1inf2PyGP6UXgIZ2+Pdpn0NYz7cyVHa8oc=;
	b=KEZNxa3GarTJpLLcBoAHoL2GQRQW9S70rV35FTUhkaSNQnWUrTWO7vXZq9H9cGA2nYS4X/
	KP/d7XtlvXeMQJl9+58lgf9OKNIxD4vZ60IHOXS+79jD/kfV2DQ1uzEmmnJ61f601RfVPT
	BHjOfFQ5V6Qvox21VFYl9P65ABTO940=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-l29meZ4KNI6-mQbtmFPdig-1; Wed,
 10 Apr 2024 09:49:08 -0400
X-MC-Unique: l29meZ4KNI6-mQbtmFPdig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9DB01C2CDEC
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C973C26A4E;
	Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 3/9] dlm: merge toss and keep hash into one
Date: Wed, 10 Apr 2024 09:48:52 -0400
Message-ID: <20240410134858.3295266-4-aahringo@redhat.com>
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

There are several places in current DLM that can end in two lookups,
e.g. first look into the keep hash, then into the toss hash if its not
in the keep hash. However there can't be never the same rsb into both of
these hashs. This patch introduce a new rsb state flag "RSB_TOSS" that
signals if the rsb would be on the toss hash or not, which then would be
on the keep hash. Instead of those multiple lookups there is only one
now that reduce the amount of hash lookups in cases where the rsb wasn't
on keep hash. The move of an rsb from rsb toss to keep hash or vice versa
need to be done automatically anyway.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     |  29 ++++++++++--
 fs/dlm/dir.c          |   6 +--
 fs/dlm/dlm_internal.h |   4 +-
 fs/dlm/lock.c         | 103 ++++++++++++++++++++++--------------------
 fs/dlm/lockspace.c    |  13 ++----
 fs/dlm/recover.c      |   7 ++-
 fs/dlm/recoverd.c     |  12 ++---
 7 files changed, 98 insertions(+), 76 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index b8234eba5e34..37f4dfca5e44 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -450,12 +450,20 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 	if (seq->op == &format4_seq_ops)
 		ri->format = 4;
 
-	tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
+	tree = &ls->ls_rsbtbl[bucket].r;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	if (!RB_EMPTY_ROOT(tree)) {
 		for (node = rb_first(tree); node; node = rb_next(node)) {
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
+			if (toss) {
+				if (!rsb_flag(r, RSB_TOSS))
+					continue;
+			} else {
+				if (rsb_flag(r, RSB_TOSS))
+					continue;
+			}
+
 			if (!entry--) {
 				dlm_hold_rsb(r);
 				ri->rsb = r;
@@ -482,12 +490,20 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 			kfree(ri);
 			return NULL;
 		}
-		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
+		tree = &ls->ls_rsbtbl[bucket].r;
 
 		spin_lock_bh(&ls->ls_rsbtbl_lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			node = rb_first(tree);
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
+			if (toss) {
+				if (!rsb_flag(r, RSB_TOSS))
+					continue;
+			} else {
+				if (rsb_flag(r, RSB_TOSS))
+					continue;
+			}
+
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
@@ -548,12 +564,19 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 			++*pos;
 			return NULL;
 		}
-		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
+		tree = &ls->ls_rsbtbl[bucket].r;
 
 		spin_lock_bh(&ls->ls_rsbtbl_lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			next = rb_first(tree);
 			r = rb_entry(next, struct dlm_rsb, res_hashnode);
+			if (toss) {
+				if (!rsb_flag(r, RSB_TOSS))
+					continue;
+			} else {
+				if (rsb_flag(r, RSB_TOSS))
+					continue;
+			}
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index 5315f4f46cc7..f8039f3ee2d1 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -205,12 +205,8 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	bucket = hash & (ls->ls_rsbtbl_size - 1);
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].keep, name, len, &r);
-	if (rv)
-		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].toss,
-					 name, len, &r);
+	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].r, name, len, &r);
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
-
 	if (!rv)
 		return r;
 
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 2c961db53b27..af88fc2f978c 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -103,8 +103,7 @@ do { \
 #define DLM_RTF_SHRINK_BIT	0
 
 struct dlm_rsbtable {
-	struct rb_root		keep;
-	struct rb_root		toss;
+	struct rb_root          r;
 	unsigned long		flags;
 };
 
@@ -376,6 +375,7 @@ enum rsb_flags {
 	RSB_RECOVER_CONVERT,
 	RSB_RECOVER_GRANT,
 	RSB_RECOVER_LVB_INVAL,
+	RSB_TOSS,
 };
 
 static inline void rsb_set_flag(struct dlm_rsb *r, enum rsb_flags flag)
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index af57d9d12434..08ec1a04476a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -616,23 +616,22 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 	if (error)
-		goto do_toss;
+		goto do_new;
 	
 	/*
 	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
+	if (rsb_flag(r, RSB_TOSS))
+		goto do_toss;
+
 	kref_get(&r->res_ref);
 	goto out_unlock;
 
 
  do_toss:
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
-	if (error)
-		goto do_new;
-
 	/*
 	 * rsb found inactive (master_nodeid may be out of date unless
 	 * we are the dir_nodeid or were the master)  No other thread
@@ -669,8 +668,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
-	rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
+	rsb_clear_flag(r, RSB_TOSS);
 	goto out_unlock;
 
 
@@ -731,7 +729,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	}
 
  out_add:
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
+	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
  out_unlock:
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
@@ -760,8 +758,11 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 	if (error)
+		goto do_new;
+
+	if (rsb_flag(r, RSB_TOSS))
 		goto do_toss;
 
 	/*
@@ -773,10 +774,6 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 
  do_toss:
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
-	if (error)
-		goto do_new;
-
 	/*
 	 * rsb found inactive. No other thread is using this rsb because
 	 * it's on the toss list, so we can look at or update
@@ -804,8 +801,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
-	rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
+	rsb_clear_flag(r, RSB_TOSS);
 	goto out_unlock;
 
 
@@ -829,7 +825,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	r->res_nodeid = (dir_nodeid == our_nodeid) ? 0 : dir_nodeid;
 	kref_init(&r->res_ref);
 
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
+	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
  out_unlock:
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
@@ -1049,8 +1045,11 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		return error;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 	if (!error) {
+		if (rsb_flag(r, RSB_TOSS))
+			goto do_toss;
+
 		/* because the rsb is active, we need to lock_rsb before
 		 * checking/changing re_master_nodeid
 		 */
@@ -1067,12 +1066,11 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		put_rsb(r);
 
 		return 0;
-	}
-
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
-	if (error)
+	} else {
 		goto not_found;
+	}
 
+ do_toss:
 	/* because the rsb is inactive (on toss list), it's not refcounted
 	 * and lock_rsb is not used, but is protected by the rsbtbl lock
 	 */
@@ -1102,8 +1100,9 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	r->res_nodeid = from_nodeid;
 	kref_init(&r->res_ref);
 	r->res_toss_time = jiffies;
+	rsb_set_flag(r, RSB_TOSS);
 
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].toss);
+	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
 	if (error) {
 		/* should never happen */
 		dlm_free_rsb(r);
@@ -1127,8 +1126,11 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
+		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
+			if (rsb_flag(r, RSB_TOSS))
+				continue;
+
 			if (r->res_hash == hash)
 				dlm_dump_rsb(r);
 		}
@@ -1146,14 +1148,10 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 	b = hash & (ls->ls_rsbtbl_size - 1);
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 	if (!error)
-		goto out_dump;
-
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
-	if (error)
 		goto out;
- out_dump:
+
 	dlm_dump_rsb(r);
  out:
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
@@ -1166,8 +1164,8 @@ static void toss_rsb(struct kref *kref)
 
 	DLM_ASSERT(list_empty(&r->res_root_list), dlm_print_rsb(r););
 	kref_init(&r->res_ref);
-	rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[r->res_bucket].keep);
-	rsb_insert(r, &ls->ls_rsbtbl[r->res_bucket].toss);
+	WARN_ON(rsb_flag(r, RSB_TOSS));
+	rsb_set_flag(r, RSB_TOSS);
 	r->res_toss_time = jiffies;
 	set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[r->res_bucket].flags);
 	if (r->res_lvbptr) {
@@ -1627,9 +1625,11 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		return;
 	}
 
-	for (n = rb_first(&ls->ls_rsbtbl[b].toss); n; n = next) {
+	for (n = rb_first(&ls->ls_rsbtbl[b].r); n; n = next) {
 		next = rb_next(n);
 		r = rb_entry(n, struct dlm_rsb, res_hashnode);
+		if (!rsb_flag(r, RSB_TOSS))
+			continue;
 
 		/* If we're the directory record for this rsb, and
 		   we're not the master of it, then we need to wait
@@ -1672,7 +1672,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 			continue;
 		}
 
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
+		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		dlm_free_rsb(r);
 	}
 
@@ -1696,8 +1696,14 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		len = ls->ls_remove_lens[i];
 
 		spin_lock_bh(&ls->ls_rsbtbl_lock);
-		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
+		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 		if (rv) {
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
+			log_error(ls, "remove_name not found %s", name);
+			continue;
+		}
+
+		if (!rsb_flag(r, RSB_TOSS)) {
 			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_debug(ls, "remove_name not toss %s", name);
 			continue;
@@ -1734,7 +1740,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 			continue;
 		}
 
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
+		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		send_remove(r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -4202,17 +4208,16 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
+	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
 	if (rv) {
-		/* verify the rsb is on keep list per comment above */
-		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
-		if (rv) {
-			/* should not happen */
-			log_error(ls, "receive_remove from %d not found %s",
-				  from_nodeid, name);
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			return;
-		}
+		/* should not happen */
+		log_error(ls, "%s from %d not found %s", __func__,
+			  from_nodeid, name);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+		return;
+	}
+
+	if (!rsb_flag(r, RSB_TOSS)) {
 		if (r->res_master_nodeid != from_nodeid) {
 			/* should not happen */
 			log_error(ls, "receive_remove keep from %d master %d",
@@ -4238,7 +4243,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	}
 
 	if (kref_put(&r->res_ref, kill_rsb)) {
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
+		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
 	} else {
@@ -5314,8 +5319,10 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 	struct dlm_rsb *r;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	for (n = rb_first(&ls->ls_rsbtbl[bucket].keep); n; n = rb_next(n)) {
+	for (n = rb_first(&ls->ls_rsbtbl[bucket].r); n; n = rb_next(n)) {
 		r = rb_entry(n, struct dlm_rsb, res_hashnode);
+		if (rsb_flag(r, RSB_TOSS))
+			continue;
 
 		if (!rsb_flag(r, RSB_RECOVER_GRANT))
 			continue;
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index d33dbcd5f4a1..b5184ad550fa 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -503,8 +503,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	if (!ls->ls_rsbtbl)
 		goto out_lsfree;
 	for (i = 0; i < size; i++) {
-		ls->ls_rsbtbl[i].keep.rb_node = NULL;
-		ls->ls_rsbtbl[i].toss.rb_node = NULL;
+		ls->ls_rsbtbl[i].r.rb_node = NULL;
 	}
 
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
@@ -837,15 +836,9 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 */
 
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		while ((n = rb_first(&ls->ls_rsbtbl[i].keep))) {
+		while ((n = rb_first(&ls->ls_rsbtbl[i].r))) {
 			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
-			rb_erase(n, &ls->ls_rsbtbl[i].keep);
-			dlm_free_rsb(rsb);
-		}
-
-		while ((n = rb_first(&ls->ls_rsbtbl[i].toss))) {
-			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
-			rb_erase(n, &ls->ls_rsbtbl[i].toss);
+			rb_erase(n, &ls->ls_rsbtbl[i].r);
 			dlm_free_rsb(rsb);
 		}
 	}
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 9a4c8e4b2442..e53d88e4ec93 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -888,10 +888,13 @@ void dlm_clear_toss(struct dlm_ls *ls)
 
 	spin_lock(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].toss); n; n = next) {
+		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = next) {
 			next = rb_next(n);
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			rb_erase(n, &ls->ls_rsbtbl[i].toss);
+			if (!rsb_flag(r, RSB_TOSS))
+				continue;
+
+			rb_erase(n, &ls->ls_rsbtbl[i].r);
 			dlm_free_rsb(r);
 			count++;
 		}
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index fa6608363302..ad696528ebe7 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -35,9 +35,9 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
+		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			if (r->res_nodeid)
+			if (rsb_flag(r, RSB_TOSS) || r->res_nodeid)
 				continue;
 
 			list_add(&r->res_masters_list, &ls->ls_masters_list);
@@ -70,14 +70,14 @@ static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
+		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
+			if (WARN_ON_ONCE(rsb_flag(r, RSB_TOSS)))
+				continue;
+
 			list_add(&r->res_root_list, root_list);
 			dlm_hold_rsb(r);
 		}
-
-		if (!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].toss))
-			log_error(ls, "%s toss not empty", __func__);
 	}
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
-- 
2.43.0

