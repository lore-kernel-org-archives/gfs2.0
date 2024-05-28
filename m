Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAD17B413
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930771; cv=none; b=k3aFw+nqVyhkNcNXzvyg+PIl2VuEKWZfKwfXLQuMSFtlPMS1ZGH5Ku3e0Lvzf6A/Rq3yHWNeJ4LSkywUp43jAhBSDLszj1FiRvxbzJ6OFdCGhN/nCoGXCiAY3HIT+Bary0nd3DuEFrVxYT319F5vy0R7ZP/Ei97yFCU2/gRhEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930771; c=relaxed/simple;
	bh=g5mcVlTIeIo8thBCYszjApRtvpnfxUKRUinoKRGuoKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOr602uWw85BBIqqtfFCdwd9JbW2nKK4OGw5/B58yAP1r7jJQEPibV+J3H8oyTjfrDS5q2639ys7P1UL4sKWci3cpHPba6X3UxBIih2R6UOI8oYxfc6Kbi1+ZWQjTE6vVLVbOSU43el8SbP3IYpkvJt/MAr5PZal23bmmiDDABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB651kaE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB651kaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716930768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXnMkcbwzCqLah9EWjbh9I5lAoPiHwguKZWzFX/idfo=;
	b=GB651kaETlovBR8pQ2kVoyJLpaGYYhSJZGiyCQk9J+zye1qIYpo0TxPbaWobSMvQBhheK4
	aY+5uYJY5RtOIzgZyRTlH7k3wnj1DR2vBYgWPSnJz+dCvdIvmHiSteI7oDbIDJfm7QQnKA
	SJ0cBGq8iV5sWVH6F0Ky59Algeq6PnQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-R9P4ELEWPceyqXDRQT2wjA-1; Tue,
 28 May 2024 17:12:47 -0400
X-MC-Unique: R9P4ELEWPceyqXDRQT2wjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17CFE3C025B2
	for <gfs2@lists.linux.dev>; Tue, 28 May 2024 21:12:47 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC66200BC93;
	Tue, 28 May 2024 21:12:47 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.10-rc1 07/11] dlm: using rcu to avoid rsb lookup again
Date: Tue, 28 May 2024 17:12:37 -0400
Message-ID: <20240528211241.2140441-7-aahringo@redhat.com>
In-Reply-To: <20240528211241.2140441-1-aahringo@redhat.com>
References: <20240528211241.2140441-1-aahringo@redhat.com>
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

This patch converts the rsb to be protected under rcu. When the rcu lock
is held it cannot be freed. In combination with the new introduced flag
RSB_HASHED we can check if the rsb is still part of the ls_rsbtbl
hashtable, it cannot be part of another table. If its still part of the
ls_rsbtbl we can avoid a second dlm_search_rsb_tree() call.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  2 ++
 fs/dlm/lock.c         | 64 ++++++++++++++++++++++++++++++-------------
 fs/dlm/memory.c       |  9 +++++-
 3 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 61dc58bdd006..5acdc6c2b4b8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -333,6 +333,7 @@ struct dlm_rsb {
 	struct list_head	res_recover_list;   /* used for recovery */
 	struct list_head	res_toss_q_list;
 	int			res_recover_locks_count;
+	struct rcu_head		rcu;
 
 	char			*res_lvbptr;
 	char			res_name[DLM_RESNAME_MAXLEN+1];
@@ -366,6 +367,7 @@ enum rsb_flags {
 	RSB_RECOVER_GRANT,
 	RSB_RECOVER_LVB_INVAL,
 	RSB_TOSS,
+	RSB_HASHED,
 };
 
 static inline void rsb_set_flag(struct dlm_rsb *r, enum rsb_flags flag)
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 818e4b282b14..69a25ec82d1e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -582,6 +582,7 @@ void dlm_rsb_toss_timer(struct timer_list *timer)
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
+		rsb_clear_flag(r, RSB_HASHED);
 
 		/* not necessary to held the ls_rsbtbl_lock when
 		 * calling send_remove()
@@ -658,8 +659,14 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 
 static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
 {
-	return rhashtable_insert_fast(rhash, &rsb->res_node,
-				      dlm_rhash_rsb_params);
+	int rv;
+
+	rv = rhashtable_insert_fast(rhash, &rsb->res_node,
+				    dlm_rhash_rsb_params);
+	if (!rv)
+		rsb_set_flag(rsb, RSB_HASHED);
+
+	return rv;
 }
 
 /*
@@ -773,12 +780,11 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
  do_toss:
 	write_lock_bh(&ls->ls_rsbtbl_lock);
-
-	/* retry lookup under write lock to see if its still in toss state
-	 * if not it's in keep state and we relookup - unlikely path.
+	/* retry lookup under write lock to see if its still hashed and in
+	 * toss state if not it's in keep state and we relookup - unlikely
+	 * path.
 	 */
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error) {
+	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_TOSS)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			goto retry;
@@ -949,12 +955,11 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
  do_toss:
 	write_lock_bh(&ls->ls_rsbtbl_lock);
-
-	/* retry lookup under write lock to see if its still in toss state
-	 * if not it's in keep state and we relookup - unlikely path.
+	/* retry lookup under write lock to see if its still hashed and in
+	 * toss state if not it's in keep state and we relookup - unlikely
+	 * path.
 	 */
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error) {
+	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_TOSS)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			goto retry;
@@ -1046,6 +1051,7 @@ static int find_rsb(struct dlm_ls *ls, const void *name, int len,
 {
 	int dir_nodeid;
 	uint32_t hash;
+	int rv;
 
 	if (len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
@@ -1053,12 +1059,20 @@ static int find_rsb(struct dlm_ls *ls, const void *name, int len,
 	hash = jhash(name, len, 0);
 	dir_nodeid = dlm_hash2nodeid(ls, hash);
 
+	/* hold the rcu lock here to prevent freeing of the rsb
+	 * while looking it up, there are currently a optimization
+	 * to not lookup the rsb twice instead look if its still
+	 * part of the rsbtbl hash.
+	 */
+	rcu_read_lock();
 	if (dlm_no_directory(ls))
-		return find_rsb_nodir(ls, name, len, hash, dir_nodeid,
-				      from_nodeid, flags, r_ret);
-	else
-		return find_rsb_dir(ls, name, len, hash, dir_nodeid,
+		rv = find_rsb_nodir(ls, name, len, hash, dir_nodeid,
 				    from_nodeid, flags, r_ret);
+	else
+		rv = find_rsb_dir(ls, name, len, hash, dir_nodeid,
+				  from_nodeid, flags, r_ret);
+	rcu_read_unlock();
+	return rv;
 }
 
 /* we have received a request and found that res_master_nodeid != our_nodeid,
@@ -1244,6 +1258,12 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
  retry:
 
+	/* the rcu lock here is combined to RSB_HASHED that the rsb did not
+	 * got freed during the read to write ls_rsbtbl_lock lock state change.
+	 * We can then simply check if the rsb is still hashed instead of doing
+	 * a lookup again.
+	 */
+	rcu_read_lock();
 	/* check if the rsb is in keep state under read lock - likely path */
 	read_lock_bh(&ls->ls_rsbtbl_lock);
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
@@ -1267,10 +1287,12 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		/* the rsb was active */
 		unlock_rsb(r);
 		put_rsb(r);
+		rcu_read_unlock();
 
 		return 0;
 	} else {
 		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		rcu_read_unlock();
 		goto not_found;
 	}
 
@@ -1279,19 +1301,22 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 
 	/* rsb_mod_timer() requires to held ls_rsbtbl_lock in write lock
-	 * check if the rsb is still in toss state, if not relookup
+	 * check if the rsb is still hashed and in toss state, if not relookup
 	 */
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error) {
+	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_TOSS)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
 			/* something as changed, very unlikely but
 			 * try again
 			 */
+			rcu_read_unlock();
 			goto retry;
 		}
+
+		rcu_read_unlock();
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		rcu_read_unlock();
 		goto not_found;
 	}
 
@@ -4306,6 +4331,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	list_del(&r->res_rsbs_list);
 	rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 			       dlm_rhash_rsb_params);
+	rsb_clear_flag(r, RSB_HASHED);
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	free_toss_rsb(r);
diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 15a8b1cee433..a7b994517bd8 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -101,13 +101,20 @@ struct dlm_rsb *dlm_allocate_rsb(struct dlm_ls *ls)
 	return r;
 }
 
-void dlm_free_rsb(struct dlm_rsb *r)
+static void __dlm_free_rsb(struct rcu_head *rcu)
 {
+	struct dlm_rsb *r = container_of(rcu, struct dlm_rsb, rcu);
+
 	if (r->res_lvbptr)
 		dlm_free_lvb(r->res_lvbptr);
 	kmem_cache_free(rsb_cache, r);
 }
 
+void dlm_free_rsb(struct dlm_rsb *r)
+{
+	call_rcu(&r->rcu, __dlm_free_rsb);
+}
+
 struct dlm_lkb *dlm_allocate_lkb(struct dlm_ls *ls)
 {
 	struct dlm_lkb *lkb;
-- 
2.43.0

