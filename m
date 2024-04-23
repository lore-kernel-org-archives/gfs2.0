Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C361422B8
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902170; cv=none; b=enir0o0LHXkxiW8wA0pz0K7QNHvUntzHWv2SExn5XvOt77w6D7oI2uAq5+n5xS6rw1kw+UnLhu/YTPUiDS0/cGm57xgcuJrlAANbEnY2TEiDEm07wiu9e1h9eMMK/+lnd4baClKJ0ELsj6IA3Ldjii749VhwUfQ8C8BvrAjXrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902170; c=relaxed/simple;
	bh=R1Kl9E4YyF3y4CGZdJkOVVuujAnyoE7lGcs38xEU4M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSqpkiDHgBEPulBM3skQYqcyyxOQJr9iJb74kWQOWgqoeGNKDzD1wPhRWIidXJ8GtZNwwDALl5jXAvOl3jxsP2oPXtGqCk1Lds2bnpOdU/pfIsMoEashgpkPXvgLcUkQrImvAffXO2i9jPA2gItysZGeTtCylBK9mqFTOfQeWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BM+ziK3L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BM+ziK3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lG+id1zrC/sB4jJmN/w6aGB1G/zwQ8D8RpvAe9NK9c0=;
	b=BM+ziK3Lg33eVJh5gyJAFyHsUHqWp+QJ3qBr36NzGVtcHyYj9MPHQWYd0U34Sls3/n0WVV
	eJo37jjhd7OIPcanLR76PBYnBPM0elxHPnC4o1HHM3GEJRC2+LZJ9NHXjCWVsUzM9jsXVH
	8cTs8KseDXITViqYz8P6ggw3oWBNCkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-TEj4bqckNUGLm5vvsV47oA-1; Tue, 23 Apr 2024 15:56:05 -0400
X-MC-Unique: TEj4bqckNUGLm5vvsV47oA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93A51810431
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8820B477F81;
	Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 05/10] dlm: drop own rsb pre allocation mechanism
Date: Tue, 23 Apr 2024 15:55:54 -0400
Message-ID: <20240423195559.1527187-5-aahringo@redhat.com>
In-Reply-To: <20240423195559.1527187-1-aahringo@redhat.com>
References: <20240423195559.1527187-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch drops the own written rsb pre allocation mechanism as this is
already done by using kmem caches, we don't need another layer on top of
that to running some pre allocation scheme.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  9 +----
 fs/dlm/lock.c         | 92 ++++++-------------------------------------
 fs/dlm/lockspace.c    | 11 ------
 3 files changed, 13 insertions(+), 99 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 47e73d9838fd..5600365684ef 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -322,10 +322,7 @@ struct dlm_rsb {
 	unsigned long		res_toss_time;
 	uint32_t		res_first_lkid;
 	struct list_head	res_lookup;	/* lkbs waiting on first */
-	union {
-		struct list_head	res_hashchain;
-		struct rhash_head	res_node; /* rsbtbl */
-	};
+	struct rhash_head	res_node;	/* rsbtbl */
 	struct list_head	res_grantqueue;
 	struct list_head	res_convertqueue;
 	struct list_head	res_waitqueue;
@@ -604,10 +601,6 @@ struct dlm_ls {
 	spinlock_t		ls_orphans_lock;
 	struct list_head	ls_orphans;
 
-	spinlock_t		ls_new_rsb_spin;
-	int			ls_new_rsb_count;
-	struct list_head	ls_new_rsb;	/* new rsb structs */
-
 	struct list_head	ls_nodes;	/* current nodes in ls */
 	struct list_head	ls_nodes_gone;	/* dead node list, recovery */
 	int			ls_num_nodes;	/* number of nodes in ls */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index e66972ed97b1..5ecc50a001d9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -389,38 +389,6 @@ void dlm_put_rsb(struct dlm_rsb *r)
 	put_rsb(r);
 }
 
-static int pre_rsb_struct(struct dlm_ls *ls)
-{
-	struct dlm_rsb *r1, *r2;
-	int count = 0;
-
-	spin_lock_bh(&ls->ls_new_rsb_spin);
-	if (ls->ls_new_rsb_count > dlm_config.ci_new_rsb_count / 2) {
-		spin_unlock_bh(&ls->ls_new_rsb_spin);
-		return 0;
-	}
-	spin_unlock_bh(&ls->ls_new_rsb_spin);
-
-	r1 = dlm_allocate_rsb(ls);
-	r2 = dlm_allocate_rsb(ls);
-
-	spin_lock_bh(&ls->ls_new_rsb_spin);
-	if (r1) {
-		list_add(&r1->res_hashchain, &ls->ls_new_rsb);
-		ls->ls_new_rsb_count++;
-	}
-	if (r2) {
-		list_add(&r2->res_hashchain, &ls->ls_new_rsb);
-		ls->ls_new_rsb_count++;
-	}
-	count = ls->ls_new_rsb_count;
-	spin_unlock_bh(&ls->ls_new_rsb_spin);
-
-	if (!count)
-		return -ENOMEM;
-	return 0;
-}
-
 /* connected with timer_delete_sync() in dlm_ls_stop() to stop
  * new timers when recovery is triggered and don't run them
  * again until a dlm_timer_resume() tries it again.
@@ -652,22 +620,10 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 			  struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r;
-	int count;
 
-	spin_lock_bh(&ls->ls_new_rsb_spin);
-	if (list_empty(&ls->ls_new_rsb)) {
-		count = ls->ls_new_rsb_count;
-		spin_unlock_bh(&ls->ls_new_rsb_spin);
-		log_debug(ls, "find_rsb retry %d %d %s",
-			  count, dlm_config.ci_new_rsb_count,
-			  (const char *)name);
-		return -EAGAIN;
-	}
-
-	r = list_first_entry(&ls->ls_new_rsb, struct dlm_rsb, res_hashchain);
-	list_del(&r->res_hashchain);
-	ls->ls_new_rsb_count--;
-	spin_unlock_bh(&ls->ls_new_rsb_spin);
+	r = dlm_allocate_rsb(ls);
+	if (!r)
+		return -ENOMEM;
 
 	r->res_ls = ls;
 	r->res_length = len;
@@ -792,13 +748,6 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	}
 
  retry:
-	if (create) {
-		error = pre_rsb_struct(ls);
-		if (error < 0)
-			goto out;
-	}
-
- retry_lookup:
 
 	/* check if the rsb is in keep state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
@@ -832,7 +781,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	if (!error) {
 		if (!rsb_flag(r, RSB_TOSS)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
-			goto retry_lookup;
+			goto retry;
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
@@ -898,9 +847,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		goto out;
 
 	error = get_rsb_struct(ls, name, len, &r);
-	if (error == -EAGAIN)
-		goto retry;
-	if (error)
+	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
@@ -952,7 +899,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		 */
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
-		goto retry_lookup;
+		goto retry;
 	} else if (!error) {
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
 	}
@@ -976,11 +923,6 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	int error;
 
  retry:
-	error = pre_rsb_struct(ls);
-	if (error < 0)
-		goto out;
-
- retry_lookup:
 
 	/* check if the rsb is in keep state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
@@ -1015,7 +957,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	if (!error) {
 		if (!rsb_flag(r, RSB_TOSS)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
-			goto retry_lookup;
+			goto retry;
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
@@ -1070,10 +1012,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 */
 
 	error = get_rsb_struct(ls, name, len, &r);
-	if (error == -EAGAIN) {
-		goto retry;
-	}
-	if (error)
+	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
@@ -1090,7 +1029,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		 */
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
-		goto retry_lookup;
+		goto retry;
 	} else if (!error) {
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
 	}
@@ -1304,11 +1243,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	}
 
  retry:
-	error = pre_rsb_struct(ls);
-	if (error < 0)
-		return error;
-
- retry_lookup:
 
 	/* check if the rsb is in keep state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
@@ -1354,7 +1288,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 			/* something as changed, very unlikely but
 			 * try again
 			 */
-			goto retry_lookup;
+			goto retry;
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
@@ -1376,9 +1310,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
  not_found:
 	error = get_rsb_struct(ls, name, len, &r);
-	if (error == -EAGAIN)
-		goto retry;
-	if (error)
+	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
@@ -1395,7 +1327,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		 */
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
-		goto retry_lookup;
+		goto retry;
 	} else if (error) {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		/* should never happen */
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 21d8572c39c5..c4d4c53e5897 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -429,9 +429,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	INIT_LIST_HEAD(&ls->ls_orphans);
 	spin_lock_init(&ls->ls_orphans_lock);
 
-	INIT_LIST_HEAD(&ls->ls_new_rsb);
-	spin_lock_init(&ls->ls_new_rsb_spin);
-
 	INIT_LIST_HEAD(&ls->ls_nodes);
 	INIT_LIST_HEAD(&ls->ls_nodes_gone);
 	ls->ls_num_nodes = 0;
@@ -687,7 +684,6 @@ static void rhash_free_rsb(void *ptr, void *arg)
 
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
-	struct dlm_rsb *rsb;
 	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
@@ -755,13 +751,6 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
-	while (!list_empty(&ls->ls_new_rsb)) {
-		rsb = list_first_entry(&ls->ls_new_rsb, struct dlm_rsb,
-				       res_hashchain);
-		list_del(&rsb->res_hashchain);
-		dlm_free_rsb(rsb);
-	}
-
 	/*
 	 * Free structures on any other lists
 	 */
-- 
2.43.0

