Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57F1420B6
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902174; cv=none; b=Z8CWNACm953p4JJVsfR7k110ER0sqR2/wio8MPGBoOyk7/ejsw2B1N8kI2WXxWkiyxgnDWLaDpF2G3eW+LRLUbvxd9BVABdNWjW1+Yw/ODdIy4oBdeD3JAANfniEY4pDvIPxa/RDDlKeoqHmQim6fF+a1mrTJ3v4pzqDRTpvQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902174; c=relaxed/simple;
	bh=AZjUJ8yDjL/NGfUliyOTbcJoyMCmYGi9WzpwjCN37xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvpitO8NK2YMJwv1Q1bJTgmV1kK2h1yM3eAgn9VX12ZkUfCE8vQ02EkY97ahzzLbjeLjgvW/pHzrXL2kpNDTsZK6z3GJFWkp5207nfQ/EToYYGfo9lCJiXaK9hRMYUC874PTTBkIGE1RUiNi9wwV7X7fWKUhYXtDbHLZ2ESdMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9R0EROJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9R0EROJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713902171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHq/RP60LOTVGYgwAOua6owb0Wg8jgwRZrKLhgQjp7E=;
	b=G9R0EROJDmGiX8JTwelUAOV7ZLyiGpeTaucg6vSnNXMHc6VGKZOIQc9DrBuuLwNgRedICz
	xfbdQCl8NHYjrkiQvh1vgHXu1L529lzIsPy6n7aZWm82h17mK7wKT672H8roe29/MQZh9l
	NsTru6gKgDYH6RB5VwU5O3DQTKbh+Sc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-nptgTRV7Nu2zdtRL6emNDA-1; Tue,
 23 Apr 2024 15:56:05 -0400
X-MC-Unique: nptgTRV7Nu2zdtRL6emNDA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C31E3C02521
	for <gfs2@lists.linux.dev>; Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9309540C5C2;
	Tue, 23 Apr 2024 19:56:04 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 06/10] dlm: using rcu to avoid rsb lookup again
Date: Tue, 23 Apr 2024 15:55:55 -0400
Message-ID: <20240423195559.1527187-6-aahringo@redhat.com>
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
 fs/dlm/recover.c      |  1 +
 4 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 5600365684ef..606d201c59f0 100644
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
index 5ecc50a001d9..5b05b3a2f43a 100644
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
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index f493d5f30c58..75d44d51636a 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -894,6 +894,7 @@ void dlm_clear_toss(struct dlm_ls *ls)
 		if (!list_empty(&r->res_toss_q_list))
 			list_del_init(&r->res_toss_q_list);
 
+		/* no rsb_clear_flag(r, RSB_HASHED) necessary */
 		free_toss_rsb(r);
 		count++;
 	}
-- 
2.43.0

