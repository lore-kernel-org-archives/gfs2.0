Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967B154BE5
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206394; cv=none; b=aQr5oakDBVYI7vKAKc+lCyeR9DZM1bWJRzVtq6DYyaBt6SHTvEGW1JVjBBDKr5FC5pjuAgZ4kuc/GXSSSezAifftAwS+7PTOffJltbKjGYw8yHR6Xuwfcstul970+MWS/554618BvkwDBkllnIau2VqesFHvNUdhJU+Rw+UC5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206394; c=relaxed/simple;
	bh=H4d6190sQ72t36/4HIImmjiSWYuOhp7Hj2+MNVGnmXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf/qRvV0HBYWuZ2/XZk8fZylSyaS6IcwdUd8JTq8GSAUmQteQjsR38hMnlM8VE6+yFmCx/gy4m6uXxy3ewNg7RcpOeC/zRBugAmwwTSE9t7NSKVI9HofE2RIO4aZOiQHYrV0F8LJqmCFh9BGSNiZg9EbzxiC2N5eGrc46qc21dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeWDLpbF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeWDLpbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHUe+4Ey+pe/hHGXQemAsm33/YEq/ew1ki2X23WC3q8=;
	b=AeWDLpbFNGT370e5UevZQ7Ib0CdZDNWSw56WJk7FoWBRgA1Ho8RVKD8MfgQvX76p5cBn61
	sC4BX2Ldswq9yvVX20BZ5XHjW52pBS+9/xrK5XE2hibZjq+y/sKjAP48ZtZsFkYUN8WAIO
	R7+Slca+nAKr1Qp9EfStVWa+uAdLcaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-XVPrWRoxMaG3TjrXBvMM1w-1; Mon, 15 Apr 2024 14:39:46 -0400
X-MC-Unique: XVPrWRoxMaG3TjrXBvMM1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B0ED8877C4
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF37C13FA4;
	Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 5/9] dlm: switch to use rhashtable for rsbs
Date: Mon, 15 Apr 2024 14:39:39 -0400
Message-ID: <20240415183943.645497-6-aahringo@redhat.com>
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

This patch switches to use the rhashtable implementation to lookup rsbs
instead doing an own bucket hash implementation. The rhashtable
implementation deals internally to handle the hashbuckets depending on
the amount of the entries it stores. Currently ls_rsbtbl_size to set the
bucket size is only a guess, in reality we don't know how the user is
using DLM. We move this decision to the rhashtable handling that does
this dynamically during runtime.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c       |   8 ++
 fs/dlm/config.h       |   2 +
 fs/dlm/dir.c          |   6 +-
 fs/dlm/dlm_internal.h |  18 ++---
 fs/dlm/lock.c         | 172 +++++++++++++-----------------------------
 fs/dlm/lock.h         |   2 +-
 fs/dlm/lockspace.c    |  35 ++++-----
 fs/dlm/recover.c      |   3 +-
 8 files changed, 86 insertions(+), 160 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index e55e0a2cd2e8..517fa975dc5a 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -63,6 +63,14 @@ static void release_node(struct config_item *);
 static struct configfs_attribute *comm_attrs[];
 static struct configfs_attribute *node_attrs[];
 
+const struct rhashtable_params dlm_rhash_rsb_params = {
+	.nelem_hint = 3, /* start small */
+	.key_len = DLM_RESNAME_MAXLEN,
+	.key_offset = offsetof(struct dlm_rsb, res_name),
+	.head_offset = offsetof(struct dlm_rsb, res_node),
+	.automatic_shrinking = true,
+};
+
 struct dlm_cluster {
 	struct config_group group;
 	unsigned int cl_tcp_port;
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index 4c91fcca0fd4..ed237d910208 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -21,6 +21,8 @@ struct dlm_config_node {
 	uint32_t comm_seq;
 };
 
+extern const struct rhashtable_params dlm_rhash_rsb_params;
+
 #define DLM_MAX_ADDR_COUNT 3
 
 #define DLM_PROTO_TCP	0
diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index f8039f3ee2d1..9687f908476b 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -198,14 +198,10 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls *ls, const char *name,
 				     int len)
 {
 	struct dlm_rsb *r;
-	uint32_t hash, bucket;
 	int rv;
 
-	hash = jhash(name, len, 0);
-	bucket = hash & (ls->ls_rsbtbl_size - 1);
-
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[bucket].r, name, len, &r);
+	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 	if (!rv)
 		return r;
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 6d06840029c3..cf43b97cf3e5 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -34,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/jhash.h>
 #include <linux/miscdevice.h>
+#include <linux/rhashtable.h>
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/ratelimit.h>
@@ -99,15 +100,6 @@ do { \
   } \
 }
 
-
-#define DLM_RTF_SHRINK_BIT	0
-
-struct dlm_rsbtable {
-	struct rb_root          r;
-	unsigned long		flags;
-};
-
-
 /*
  * Lockspace member (per node in a ls)
  */
@@ -327,13 +319,12 @@ struct dlm_rsb {
 	int			res_id;		/* for ls_recover_idr */
 	uint32_t                res_lvbseq;
 	uint32_t		res_hash;
-	uint32_t		res_bucket;	/* rsbtbl */
 	unsigned long		res_toss_time;
 	uint32_t		res_first_lkid;
 	struct list_head	res_lookup;	/* lkbs waiting on first */
 	union {
 		struct list_head	res_hashchain;
-		struct rb_node		res_hashnode;	/* rsbtbl */
+		struct rhash_head	res_node; /* rsbtbl */
 	};
 	struct list_head	res_grantqueue;
 	struct list_head	res_convertqueue;
@@ -592,9 +583,10 @@ struct dlm_ls {
 	struct idr		ls_lkbidr;
 	spinlock_t		ls_lkbidr_spin;
 
-	struct dlm_rsbtable	*ls_rsbtbl;
+	struct rhashtable	ls_rsbtbl;
+#define DLM_RTF_SHRINK_BIT	0
+	unsigned long		ls_rsbtbl_flags;
 	spinlock_t		ls_rsbtbl_lock;
-	uint32_t		ls_rsbtbl_size;
 
 	struct list_head	ls_toss;
 	struct list_head	ls_keep;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index a70b8edb5d3f..defb90b56b72 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -436,8 +436,6 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 
 	r = list_first_entry(&ls->ls_new_rsb, struct dlm_rsb, res_hashchain);
 	list_del(&r->res_hashchain);
-	/* Convert the empty list_head to a NULL rb_node for tree usage: */
-	memset(&r->res_hashnode, 0, sizeof(struct rb_node));
 	ls->ls_new_rsb_count--;
 	spin_unlock_bh(&ls->ls_new_rsb_spin);
 
@@ -458,67 +456,31 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	return 0;
 }
 
-static int rsb_cmp(struct dlm_rsb *r, const char *name, int nlen)
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
+			struct dlm_rsb **r_ret)
 {
-	char maxname[DLM_RESNAME_MAXLEN];
+	char key[DLM_RESNAME_MAXLEN] = {};
 
-	memset(maxname, 0, DLM_RESNAME_MAXLEN);
-	memcpy(maxname, name, nlen);
-	return memcmp(r->res_name, maxname, DLM_RESNAME_MAXLEN);
-}
+	memcpy(key, name, len);
+	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
+	if (*r_ret)
+		return 0;
 
-int dlm_search_rsb_tree(struct rb_root *tree, const void *name, int len,
-			struct dlm_rsb **r_ret)
-{
-	struct rb_node *node = tree->rb_node;
-	struct dlm_rsb *r;
-	int rc;
-
-	while (node) {
-		r = rb_entry(node, struct dlm_rsb, res_hashnode);
-		rc = rsb_cmp(r, name, len);
-		if (rc < 0)
-			node = node->rb_left;
-		else if (rc > 0)
-			node = node->rb_right;
-		else
-			goto found;
-	}
-	*r_ret = NULL;
 	return -EBADR;
-
- found:
-	*r_ret = r;
-	return 0;
 }
 
-static int rsb_insert(struct dlm_rsb *rsb, struct rb_root *tree)
+static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
 {
-	struct rb_node **newn = &tree->rb_node;
-	struct rb_node *parent = NULL;
-	int rc;
-
-	while (*newn) {
-		struct dlm_rsb *cur = rb_entry(*newn, struct dlm_rsb,
-					       res_hashnode);
+	int rv;
 
-		parent = *newn;
-		rc = rsb_cmp(cur, rsb->res_name, rsb->res_length);
-		if (rc < 0)
-			newn = &parent->rb_left;
-		else if (rc > 0)
-			newn = &parent->rb_right;
-		else {
-			log_print("rsb_insert match");
-			dlm_dump_rsb(rsb);
-			dlm_dump_rsb(cur);
-			return -EEXIST;
-		}
+	rv = rhashtable_insert_fast(rhash, &rsb->res_node,
+				    dlm_rhash_rsb_params);
+	if (rv == -EEXIST) {
+		log_print("%s match", __func__);
+		dlm_dump_rsb(rsb);
 	}
 
-	rb_link_node(&rsb->res_hashnode, parent, newn);
-	rb_insert_color(&rsb->res_hashnode, tree);
-	return 0;
+	return rv;
 }
 
 /*
@@ -566,8 +528,7 @@ static int rsb_insert(struct dlm_rsb *rsb, struct rb_root *tree)
  */
 
 static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
-			uint32_t hash, uint32_t b,
-			int dir_nodeid, int from_nodeid,
+			uint32_t hash, int dir_nodeid, int from_nodeid,
 			unsigned int flags, struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r = NULL;
@@ -616,7 +577,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (error)
 		goto do_new;
 	
@@ -690,7 +651,6 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		goto out_unlock;
 
 	r->res_hash = hash;
-	r->res_bucket = b;
 	r->res_dir_nodeid = dir_nodeid;
 	kref_init(&r->res_ref);
 
@@ -730,7 +690,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	}
 
  out_add:
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
+	error = rsb_insert(r, &ls->ls_rsbtbl);
 	if (!error)
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
  out_unlock:
@@ -745,8 +705,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
    dlm_recover_masters). */
 
 static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
-			  uint32_t hash, uint32_t b,
-			  int dir_nodeid, int from_nodeid,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
 			  unsigned int flags, struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r = NULL;
@@ -761,7 +720,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (error)
 		goto do_new;
 
@@ -823,13 +782,12 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		goto out_unlock;
 
 	r->res_hash = hash;
-	r->res_bucket = b;
 	r->res_dir_nodeid = dir_nodeid;
 	r->res_master_nodeid = dir_nodeid;
 	r->res_nodeid = (dir_nodeid == our_nodeid) ? 0 : dir_nodeid;
 	kref_init(&r->res_ref);
 
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
+	error = rsb_insert(r, &ls->ls_rsbtbl);
 	if (!error)
 		list_add(&r->res_rsbs_list, &ls->ls_keep);
  out_unlock:
@@ -843,23 +801,21 @@ static int find_rsb(struct dlm_ls *ls, const void *name, int len,
 		    int from_nodeid, unsigned int flags,
 		    struct dlm_rsb **r_ret)
 {
-	uint32_t hash, b;
 	int dir_nodeid;
+	uint32_t hash;
 
 	if (len > DLM_RESNAME_MAXLEN)
 		return -EINVAL;
 
 	hash = jhash(name, len, 0);
-	b = hash & (ls->ls_rsbtbl_size - 1);
-
 	dir_nodeid = dlm_hash2nodeid(ls, hash);
 
 	if (dlm_no_directory(ls))
-		return find_rsb_nodir(ls, name, len, hash, b, dir_nodeid,
+		return find_rsb_nodir(ls, name, len, hash, dir_nodeid,
 				      from_nodeid, flags, r_ret);
 	else
-		return find_rsb_dir(ls, name, len, hash, b, dir_nodeid,
-				      from_nodeid, flags, r_ret);
+		return find_rsb_dir(ls, name, len, hash, dir_nodeid,
+				    from_nodeid, flags, r_ret);
 }
 
 /* we have received a request and found that res_master_nodeid != our_nodeid,
@@ -1020,7 +976,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		      int len, unsigned int flags, int *r_nodeid, int *result)
 {
 	struct dlm_rsb *r = NULL;
-	uint32_t hash, b;
+	uint32_t hash;
 	int our_nodeid = dlm_our_nodeid();
 	int dir_nodeid, error;
 
@@ -1034,8 +990,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	}
 
 	hash = jhash(name, len, 0);
-	b = hash & (ls->ls_rsbtbl_size - 1);
-
 	dir_nodeid = dlm_hash2nodeid(ls, hash);
 	if (dir_nodeid != our_nodeid) {
 		log_error(ls, "dlm_master_lookup from %d dir %d our %d h %x %d",
@@ -1051,7 +1005,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		return error;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error) {
 		if (rsb_flag(r, RSB_TOSS))
 			goto do_toss;
@@ -1100,7 +1054,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		goto out_unlock;
 
 	r->res_hash = hash;
-	r->res_bucket = b;
 	r->res_dir_nodeid = our_nodeid;
 	r->res_master_nodeid = from_nodeid;
 	r->res_nodeid = from_nodeid;
@@ -1108,7 +1061,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	r->res_toss_time = jiffies;
 	rsb_set_flag(r, RSB_TOSS);
 
-	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
+	error = rsb_insert(r, &ls->ls_rsbtbl);
 	if (error) {
 		/* should never happen */
 		dlm_free_rsb(r);
@@ -1141,14 +1094,10 @@ static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
 {
 	struct dlm_rsb *r = NULL;
-	uint32_t hash, b;
 	int error;
 
-	hash = jhash(name, len, 0);
-	b = hash & (ls->ls_rsbtbl_size - 1);
-
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	error = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (!error)
 		goto out;
 
@@ -1168,7 +1117,7 @@ static void toss_rsb(struct kref *kref)
 	rsb_set_flag(r, RSB_TOSS);
 	list_move(&r->res_rsbs_list, &ls->ls_toss);
 	r->res_toss_time = jiffies;
-	set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[r->res_bucket].flags);
+	set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
 	if (r->res_lvbptr) {
 		dlm_free_lvb(r->res_lvbptr);
 		r->res_lvbptr = NULL;
@@ -1607,10 +1556,9 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 	return error;
 }
 
-static void shrink_bucket(struct dlm_ls *ls, int b)
+static void shrink_bucket(struct dlm_ls *ls)
 {
-	struct rb_node *n, *next;
-	struct dlm_rsb *r;
+	struct dlm_rsb *r, *safe;
 	char *name;
 	int our_nodeid = dlm_our_nodeid();
 	int remote_count = 0;
@@ -1621,17 +1569,12 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	if (!test_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags)) {
+	if (!test_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags)) {
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		return;
 	}
 
-	for (n = rb_first(&ls->ls_rsbtbl[b].r); n; n = next) {
-		next = rb_next(n);
-		r = rb_entry(n, struct dlm_rsb, res_hashnode);
-		if (!rsb_flag(r, RSB_TOSS))
-			continue;
-
+	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
 		/* If we're the directory record for this rsb, and
 		   we're not the master of it, then we need to wait
 		   for the master node to send us a dir remove for
@@ -1674,14 +1617,15 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		}
 
 		list_del(&r->res_rsbs_list);
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
 		dlm_free_rsb(r);
 	}
 
 	if (need_shrink)
-		set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
+		set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
 	else
-		clear_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[b].flags);
+		clear_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	/*
@@ -1698,7 +1642,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		len = ls->ls_remove_lens[i];
 
 		spin_lock_bh(&ls->ls_rsbtbl_lock);
-		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 		if (rv) {
 			spin_unlock_bh(&ls->ls_rsbtbl_lock);
 			log_error(ls, "remove_name not found %s", name);
@@ -1743,7 +1687,8 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 		}
 
 		list_del(&r->res_rsbs_list);
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
 		send_remove(r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -1753,14 +1698,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 
 void dlm_scan_rsbs(struct dlm_ls *ls)
 {
-	int i;
-
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		shrink_bucket(ls, i);
-		if (dlm_locking_stopped(ls))
-			break;
-		cond_resched();
-	}
+	shrink_bucket(ls);
 }
 
 /* lkb is master or local copy */
@@ -4174,7 +4112,6 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 {
 	char name[DLM_RESNAME_MAXLEN+1];
 	struct dlm_rsb *r;
-	uint32_t hash, b;
 	int rv, len, dir_nodeid, from_nodeid;
 
 	from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
@@ -4194,24 +4131,22 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 		return;
 	}
 
-	/* Look for name on rsbtbl.toss, if it's there, kill it.
-	   If it's on rsbtbl.keep, it's being used, and we should ignore this
-	   message.  This is an expected race between the dir node sending a
-	   request to the master node at the same time as the master node sends
-	   a remove to the dir node.  The resolution to that race is for the
-	   dir node to ignore the remove message, and the master node to
-	   recreate the master rsb when it gets a request from the dir node for
-	   an rsb it doesn't have. */
+	/* Look for name in rsb toss state, if it's there, kill it.
+	 * If it's in non toss state, it's being used, and we should ignore this
+	 * message.  This is an expected race between the dir node sending a
+	 * request to the master node at the same time as the master node sends
+	 * a remove to the dir node.  The resolution to that race is for the
+	 * dir node to ignore the remove message, and the master node to
+	 * recreate the master rsb when it gets a request from the dir node for
+	 * an rsb it doesn't have.
+	 */
 
 	memset(name, 0, sizeof(name));
 	memcpy(name, ms->m_extra, len);
 
-	hash = jhash(name, len, 0);
-	b = hash & (ls->ls_rsbtbl_size - 1);
-
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 
-	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl[b].r, name, len, &r);
+	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
 	if (rv) {
 		/* should not happen */
 		log_error(ls, "%s from %d not found %s", __func__,
@@ -4247,7 +4182,8 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 
 	if (kref_put(&r->res_ref, kill_rsb)) {
 		list_del(&r->res_rsbs_list);
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
 	} else {
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index 45a74869810a..33616d4b0cdb 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -29,7 +29,7 @@ void dlm_unlock_recovery(struct dlm_ls *ls);
 int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		      int len, unsigned int flags, int *r_nodeid, int *result);
 
-int dlm_search_rsb_tree(struct rb_root *tree, const void *name, int len,
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 			struct dlm_rsb **r_ret);
 
 void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 2b5771a7bf31..890e1a4cf787 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -410,9 +410,9 @@ static int new_lockspace(const char *name, const char *cluster,
 			 int *ops_result, dlm_lockspace_t **lockspace)
 {
 	struct dlm_ls *ls;
-	int i, size, error;
 	int do_unreg = 0;
 	int namelen = strlen(name);
+	int i, error;
 
 	if (namelen > DLM_LOCKSPACE_LEN || namelen == 0)
 		return -EINVAL;
@@ -498,15 +498,10 @@ static int new_lockspace(const char *name, const char *cluster,
 	INIT_LIST_HEAD(&ls->ls_toss);
 	INIT_LIST_HEAD(&ls->ls_keep);
 	spin_lock_init(&ls->ls_rsbtbl_lock);
-	size = READ_ONCE(dlm_config.ci_rsbtbl_size);
-	ls->ls_rsbtbl_size = size;
 
-	ls->ls_rsbtbl = vmalloc(array_size(size, sizeof(struct dlm_rsbtable)));
-	if (!ls->ls_rsbtbl)
+	error = rhashtable_init(&ls->ls_rsbtbl, &dlm_rhash_rsb_params);
+	if (error)
 		goto out_lsfree;
-	for (i = 0; i < size; i++) {
-		ls->ls_rsbtbl[i].r.rb_node = NULL;
-	}
 
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
 		ls->ls_remove_names[i] = kzalloc(DLM_RESNAME_MAXLEN+1,
@@ -669,7 +664,7 @@ static int new_lockspace(const char *name, const char *cluster,
  out_rsbtbl:
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
 		kfree(ls->ls_remove_names[i]);
-	vfree(ls->ls_rsbtbl);
+	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)
 		kobject_put(&ls->ls_kobj);
@@ -772,10 +767,16 @@ static int lockspace_busy(struct dlm_ls *ls, int force)
 	return rv;
 }
 
+static void rhash_free_rsb(void *ptr, void *arg)
+{
+	struct dlm_rsb *rsb = ptr;
+
+	dlm_free_rsb(rsb);
+}
+
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
 	struct dlm_rsb *rsb;
-	struct rb_node *n;
 	int i, busy, rv;
 
 	busy = lockspace_busy(ls, force);
@@ -834,19 +835,9 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	idr_destroy(&ls->ls_lkbidr);
 
 	/*
-	 * Free all rsb's on rsbtbl[] lists
+	 * Free all rsb's on rsbtbl
 	 */
-
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		while ((n = rb_first(&ls->ls_rsbtbl[i].r))) {
-			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
-			list_del(&rsb->res_rsbs_list);
-			rb_erase(n, &ls->ls_rsbtbl[i].r);
-			dlm_free_rsb(rsb);
-		}
-	}
-
-	vfree(ls->ls_rsbtbl);
+	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
 		kfree(ls->ls_remove_names[i]);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 512c1ae81a96..c21ef115123b 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -887,7 +887,8 @@ void dlm_clear_toss(struct dlm_ls *ls)
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
 	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
 		list_del(&r->res_rsbs_list);
-		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[r->res_bucket].r);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
 		dlm_free_rsb(r);
 		count++;
 	}
-- 
2.43.0

