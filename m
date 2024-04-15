Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C8139CEC
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206389; cv=none; b=SrluuB8g2cUxqjK4YSYxpeOLVjz1uhWzxQox46HySilkbbSn1+yv5eNyZxPtZ7XxGYvtVA3xHPkEA+qA8juX/PZMy+LlvyrA9vYi7o5plq2YTbY9zbV4T9r3FZAmJq0+g2fu0DJNJgaIQ+tXaCxTjcTlyMYJV2GEXFtSPQCGy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206389; c=relaxed/simple;
	bh=X3pw3UVRYJDQPum8+o7Cmh0mFZ7zVRp/MiEiNwGXuoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfF2xBBv41NoGeg+zckjtj+ncUDloQDkjQ2r0oyR6JkpII6QkMqGYa1fkGgzdF+lv77lOWYVFNj0GJ5shZulnX4/Y5Su6P9mStwa2fgbqfGsMtgWTiMYVOFTyWD+QuLwaVT1NGX9HXKZBnXuZnIaPnStNCKK1qMYL8WCTq4tBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhkVvDUi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhkVvDUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6oKSL+6KyTedGWawz1BSpCIuS+9iVyqYPLCnxTAJj8=;
	b=ZhkVvDUiqGz4newqrWmJrvkT9c7mvdh+M7v/J8tQfXEXt8icLYfxuhTQExLhBjGoozSXqd
	cUppiOrC+Nz3MTrc5qhLaCbXwTkmmjHBtD2UYG1CU6Mu1qG7fRY7H+exOxGvnRCxEfcTZJ
	ZeiuXmvvzrN5EqkH1Y0R6NoGLxmaIj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-nUXYWckjNsOVMnp9o9BKIw-1; Mon, 15 Apr 2024 14:39:45 -0400
X-MC-Unique: nUXYWckjNsOVMnp9o9BKIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBD4F811005
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE104C13FA3;
	Mon, 15 Apr 2024 18:39:44 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 2/9] dlm: change to non per bucket hashtable lock
Date: Mon, 15 Apr 2024 14:39:36 -0400
Message-ID: <20240415183943.645497-3-aahringo@redhat.com>
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

This patch prepares to switch to use the resizable, scalable, concurrent
hash table (rhashtable) implementation instead of having a own per
bucket implementation. The rhashtable implementation deals with the
buckets internally for that reason we use a per lockspace rhashtable
lock to protect mutual rhashtable access. This might reduce the
perfromance of the hash, depends on how rhashtable lookup performs to
the current own DLM hash bucket implementation. However we switch to the
rhashtable implementation and a potential lockless access can be part of
future changes.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     | 24 +++++++-------
 fs/dlm/dir.c          |  4 +--
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 77 +++++++++++++++++++++----------------------
 fs/dlm/lockspace.c    |  2 +-
 fs/dlm/recover.c      |  4 +--
 fs/dlm/recoverd.c     |  8 ++---
 7 files changed, 60 insertions(+), 61 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index cba5514688ee..b8234eba5e34 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -452,7 +452,7 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 
 	tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	if (!RB_EMPTY_ROOT(tree)) {
 		for (node = rb_first(tree); node; node = rb_next(node)) {
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
@@ -460,12 +460,12 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 				dlm_hold_rsb(r);
 				ri->rsb = r;
 				ri->bucket = bucket;
-				spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+				spin_unlock_bh(&ls->ls_rsbtbl_lock);
 				return ri;
 			}
 		}
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	/*
 	 * move to the first rsb in the next non-empty bucket
@@ -484,18 +484,18 @@ static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 		}
 		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-		spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_lock_bh(&ls->ls_rsbtbl_lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			node = rb_first(tree);
 			r = rb_entry(node, struct dlm_rsb, res_hashnode);
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
-			spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			*pos = n;
 			return ri;
 		}
-		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	}
 }
 
@@ -516,7 +516,7 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 	 * move to the next rsb in the same bucket
 	 */
 
-	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	rp = ri->rsb;
 	next = rb_next(&rp->res_hashnode);
 
@@ -524,12 +524,12 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 		r = rb_entry(next, struct dlm_rsb, res_hashnode);
 		dlm_hold_rsb(r);
 		ri->rsb = r;
-		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_put_rsb(rp);
 		++*pos;
 		return ri;
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	dlm_put_rsb(rp);
 
 	/*
@@ -550,18 +550,18 @@ static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 		}
 		tree = toss ? &ls->ls_rsbtbl[bucket].toss : &ls->ls_rsbtbl[bucket].keep;
 
-		spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_lock_bh(&ls->ls_rsbtbl_lock);
 		if (!RB_EMPTY_ROOT(tree)) {
 			next = rb_first(tree);
 			r = rb_entry(next, struct dlm_rsb, res_hashnode);
 			dlm_hold_rsb(r);
 			ri->rsb = r;
 			ri->bucket = bucket;
-			spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			*pos = n;
 			return ri;
 		}
-		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	}
 }
 
diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index ff3a51c759b5..5315f4f46cc7 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -204,12 +204,12 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 	hash = jhash(name, len, 0);
 	bucket = hash & (ls->ls_rsbtbl_size - 1);
 
-	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].keep, name, len, &r);
 	if (rv)
 		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].toss,
 					 name, len, &r);
-	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	if (!rv)
 		return r;
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 269c12e0824f..2c961db53b27 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -105,7 +105,6 @@ do { \
 struct dlm_rsbtable {
 	struct rb_root		keep;
 	struct rb_root		toss;
-	spinlock_t		lock;
 	unsigned long		flags;
 };
 
@@ -593,6 +592,7 @@ struct dlm_ls {
 	spinlock_t		ls_lkbidr_spin;
 
 	struct dlm_rsbtable	*ls_rsbtbl;
+	spinlock_t		ls_rsbtbl_lock;
 	uint32_t		ls_rsbtbl_size;
 
 	spinlock_t		ls_waiters_lock;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 4ff4ef2a5f87..af57d9d12434 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -369,13 +369,12 @@ static inline int dlm_kref_put_lock_bh(struct kref *kref,
 static void put_rsb(struct dlm_rsb *r)
 {
 	struct dlm_ls *ls = r->res_ls;
-	uint32_t bucket = r->res_bucket;
 	int rv;
 
 	rv = dlm_kref_put_lock_bh(&r->res_ref, toss_rsb,
-				  &ls->ls_rsbtbl[bucket].lock);
+				  &ls->ls_rsbtbl_lock);
 	if (rv)
-		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 void dlm_put_rsb(struct dlm_rsb *r)
@@ -615,7 +614,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 			goto out;
 	}
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (error)
@@ -685,7 +684,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 	if (error)
@@ -734,7 +733,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
  out_add:
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
  out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
 	*r_ret = r;
 	return error;
@@ -759,7 +758,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	if (error < 0)
 		goto out;
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (error)
@@ -817,7 +816,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 	if (error)
@@ -832,7 +831,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].keep);
  out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
 	*r_ret = r;
 	return error;
@@ -1049,7 +1048,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error < 0)
 		return error;
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (!error) {
 		/* because the rsb is active, we need to lock_rsb before
@@ -1057,7 +1056,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		 */
 
 		hold_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		lock_rsb(r);
 
 		__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
@@ -1083,14 +1082,14 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 	r->res_toss_time = jiffies;
 	/* the rsb was inactive (on toss list) */
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	return 0;
 
  not_found:
 	error = get_rsb_struct(ls, name, len, &r);
 	if (error == -EAGAIN) {
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 	if (error)
@@ -1108,7 +1107,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	if (error) {
 		/* should never happen */
 		dlm_free_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		goto retry;
 	}
 
@@ -1116,7 +1115,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		*result = DLM_LU_ADD;
 	*r_nodeid = from_nodeid;
  out_unlock:
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	return error;
 }
 
@@ -1126,15 +1125,15 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 	struct dlm_rsb *r;
 	int i;
 
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
 			if (r->res_hash == hash)
 				dlm_dump_rsb(r);
 		}
-		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
@@ -1146,7 +1145,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 	hash = jhash(name, len, 0);
 	b = hash & (ls->ls_rsbtbl_size - 1);
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].keep, name, len, &r);
 	if (!error)
 		goto out_dump;
@@ -1157,7 +1156,7 @@ void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
  out_dump:
 	dlm_dump_rsb(r);
  out:
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static void toss_rsb(struct kref *kref)
@@ -1621,10 +1620,10 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 	memset(&ls->ls_remove_lens, 0, sizeof(int) * DLM_REMOVE_NAMES_MAX);
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
 	if (!test_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags)) {
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
@@ -1681,7 +1680,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
 	else
 		clear_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
-	spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	/*
 	 * While searching for rsb's to free, we found some that require
@@ -1696,16 +1695,16 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		name = ls->ls_remove_names[i];
 		len = ls->ls_remove_lens[i];
 
-		spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_lock_bh(&ls->ls_rsbtbl_lock);
 		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
 		if (rv) {
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_debug(ls, "remove_name not toss %s", name);
 			continue;
 		}
 
 		if (r->res_master_nodeid != our_nodeid) {
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_debug(ls, "remove_name master %d dir %d our %d %s",
 				  r->res_master_nodeid, r->res_dir_nodeid,
 				  our_nodeid, name);
@@ -1714,7 +1713,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 		if (r->res_dir_nodeid == our_nodeid) {
 			/* should never happen */
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_error(ls, "remove_name dir %d master %d our %d %s",
 				  r->res_dir_nodeid, r->res_master_nodeid,
 				  our_nodeid, name);
@@ -1723,21 +1722,21 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 		if (!time_after_eq(jiffies, r->res_toss_time +
 				   dlm_config.ci_toss_secs * HZ)) {
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_debug(ls, "remove_name toss_time %lu now %lu %s",
 				  r->res_toss_time, jiffies, name);
 			continue;
 		}
 
 		if (!kref_put(&r->res_ref, kill_rsb)) {
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_error(ls, "remove_name in use %s", name);
 			continue;
 		}
 
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
 		send_remove(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 		dlm_free_rsb(r);
 	}
@@ -4201,7 +4200,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	hash = jhash(name, len, 0);
 	b = hash & (ls->ls_rsbtbl_size - 1);
 
-	spin_lock_bh(&ls->ls_rsbtbl[b].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
 	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].toss, name, len, &r);
 	if (rv) {
@@ -4211,7 +4210,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 			/* should not happen */
 			log_error(ls, "receive_remove from %d not found %s",
 				  from_nodeid, name);
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			return;
 		}
 		if (r->res_master_nodeid != from_nodeid) {
@@ -4219,14 +4218,14 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 			log_error(ls, "receive_remove keep from %d master %d",
 				  from_nodeid, r->res_master_nodeid);
 			dlm_print_rsb(r);
-			spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			return;
 		}
 
 		log_debug(ls, "receive_remove from %d master %d first %x %s",
 			  from_nodeid, r->res_master_nodeid, r->res_first_lkid,
 			  name);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
@@ -4234,19 +4233,19 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 		log_error(ls, "receive_remove toss from %d master %d",
 			  from_nodeid, r->res_master_nodeid);
 		dlm_print_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
 	if (kref_put(&r->res_ref, kill_rsb)) {
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].toss);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
 	} else {
 		log_error(ls, "receive_remove from %d rsb ref error",
 			  from_nodeid);
 		dlm_print_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[b].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	}
 }
 
@@ -5314,7 +5313,7 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 	struct rb_node *n;
 	struct dlm_rsb *r;
 
-	spin_lock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (n = rb_first(&ls->ls_rsbtbl[bucket].keep); n; n = rb_next(n)) {
 		r = rb_entry(n, struct dlm_rsb, res_hashnode);
 
@@ -5325,10 +5324,10 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 			continue;
 		}
 		hold_rsb(r);
-		spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		return r;
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl[bucket].lock);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	return NULL;
 }
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 731c48371a27..d33dbcd5f4a1 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -495,6 +495,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	 */
 	ls->ls_exflags = (flags & ~(DLM_LSFL_FS | DLM_LSFL_NEWEXCL));
 
+	spin_lock_init(&ls->ls_rsbtbl_lock);
 	size = READ_ONCE(dlm_config.ci_rsbtbl_size);
 	ls->ls_rsbtbl_size = size;
 
@@ -504,7 +505,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	for (i = 0; i < size; i++) {
 		ls->ls_rsbtbl[i].keep.rb_node = NULL;
 		ls->ls_rsbtbl[i].toss.rb_node = NULL;
-		spin_lock_init(&ls->ls_rsbtbl[i].lock);
 	}
 
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 13bc845fa305..9a4c8e4b2442 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -886,8 +886,8 @@ void dlm_clear_toss(struct dlm_ls *ls)
 	unsigned int count = 0;
 	int i;
 
+	spin_lock(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].toss); n; n = next) {
 			next = rb_next(n);
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
@@ -895,8 +895,8 @@ void dlm_clear_toss(struct dlm_ls *ls)
 			dlm_free_rsb(r);
 			count++;
 		}
-		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	if (count)
 		log_rinfo(ls, "dlm_clear_toss %u done", count);
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index c82cc48988c6..fa6608363302 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -33,8 +33,8 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 		goto out;
 	}
 
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
 			if (r->res_nodeid)
@@ -43,8 +43,8 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 			list_add(&r->res_masters_list, &ls->ls_masters_list);
 			dlm_hold_rsb(r);
 		}
-		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
 	write_unlock_bh(&ls->ls_masters_lock);
 	return error;
@@ -68,8 +68,8 @@ static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 	struct dlm_rsb *r;
 	int i;
 
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		spin_lock_bh(&ls->ls_rsbtbl[i].lock);
 		for (n = rb_first(&ls->ls_rsbtbl[i].keep); n; n = rb_next(n)) {
 			r = rb_entry(n, struct dlm_rsb, res_hashnode);
 			list_add(&r->res_root_list, root_list);
@@ -78,8 +78,8 @@ static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 
 		if (!RB_EMPTY_ROOT(&ls->ls_rsbtbl[i].toss))
 			log_error(ls, "%s toss not empty", __func__);
-		spin_unlock_bh(&ls->ls_rsbtbl[i].lock);
 	}
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static void dlm_release_root_list(struct list_head *root_list)
-- 
2.43.0

