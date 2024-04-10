Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A61163A9B
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756953; cv=none; b=KrLYyEYPB06nIc76UwK//vwrIx4P/wY8JfwyNOe4MKODRgKK5+Cjec0DjahTswgQ/NpOD1qU5YovVNlowKKkG60TkrJTLWQzi8XPTwpaU/zFHbqgFfYGY19pLiTnWe1Dg2xVRcMu4LbEJySs+odnFUZ1xScWfS/6adbBww2h1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756953; c=relaxed/simple;
	bh=rSlWpCtkejcmw0Z/BEu2JkfQjDHVVIS+Kzw1ItUVr48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esTZViXJtx149cGsjofqAJiD2E1hjN0Zr5GqpiZjs31oeD2iKEzPsEJpuvLUHbpBX3Jq8d+/B9/JEBXoeUCHYgflZdMK2qrDgsRQObB5BidpGTiKEp05WFBxBGEyrEKu5Y2afj+VaC1alqzFJVvLYcY9xlWdpTecz6LjsxwPNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5kq5+RI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5kq5+RI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6xBtc8FYOvklPypGpqrTr8OB63vf3oXRHw1K8YTg2I=;
	b=O5kq5+RIEuB71JoTypWYhvh9Wiz+Osg43mruSqbjMrKkBg8X8Uptyr2bvqRWxDnvdc5Afm
	1YaAhhr/Hk/+3LnghkSfKsO3wWBZE8Q7pk+h/K+CMw0cQD+yNUjdyzlAjTe8WZXSY2RZNK
	/j8cigH0GgHeX7Ak1cwY+hBj6xas6dc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-H4DSWBsRNXyC9QzuQXUYjw-1; Wed,
 10 Apr 2024 09:49:09 -0400
X-MC-Unique: H4DSWBsRNXyC9QzuQXUYjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B978F3C0C485
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABA17C27EAE;
	Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 4/9] dlm: fix avoid rsb hold during debugfs dump
Date: Wed, 10 Apr 2024 09:48:53 -0400
Message-ID: <20240410134858.3295266-5-aahringo@redhat.com>
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

Currently the debugfs calls dlm_hold_rsb() while iterating the
ls_rsbtbl hash and release the ls_rsbtbl_lock during dumping. We can't
do that in every situation because some rsbs don't get into the toss
state when they should be on the toss state e.g. when receive_remove()
is being called. To avoid this problem we don't use the hash as
iteratable datastructure. Moving to rhashtable implementation it should
be avoided to use the rhashtable to iterate over it due dynamic rehash
background operations that results into a whole new iteration of the
rhashtable datastructure. Instead of iterating over the hash we
introduce two lists ls_toss and ls_keep as DLM cares about the RSB_TOSS
state if iterate over all rsbs. On ls_toss are only rsbs that are on
RSB_TOSS state and on ls_keep the rsbs they are not in RSB_TOSS state.
There are only few situation to bring a rsb into toss state and back
which will be just a list_move() between those datastructures protected
by the ls_rsbtbl_lock to keep in sync with the hashtable and RSB_TOSS flag.

The advantage in debugfs is that we can simple use the predefined
debugfs dump functionality for linux lists. Instead of calling
dlm_hold_rsb() while dumping rsbs, we hold the ls_rsbtbl_lock the whole
debugfs dump.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c     | 233 +++++++-----------------------------------
 fs/dlm/dlm_internal.h |   4 +
 fs/dlm/lock.c         |  47 ++++-----
 fs/dlm/lockspace.c    |   3 +
 fs/dlm/recover.c      |  24 ++---
 fs/dlm/recoverd.c     |  34 +++---
 6 files changed, 84 insertions(+), 261 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 37f4dfca5e44..70567919f1b7 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -366,12 +366,10 @@ static void print_format4(struct dlm_rsb *r, struct seq_file *s)
 	unlock_rsb(r);
 }
 
-struct rsbtbl_iter {
-	struct dlm_rsb *rsb;
-	unsigned bucket;
-	int format;
-	int header;
-};
+static const struct seq_operations format1_seq_ops;
+static const struct seq_operations format2_seq_ops;
+static const struct seq_operations format3_seq_ops;
+static const struct seq_operations format4_seq_ops;
 
 /*
  * If the buffer is full, seq_printf can be called again, but it
@@ -382,220 +380,61 @@ struct rsbtbl_iter {
 
 static int table_seq_show(struct seq_file *seq, void *iter_ptr)
 {
-	struct rsbtbl_iter *ri = iter_ptr;
-
-	switch (ri->format) {
-	case 1:
-		print_format1(ri->rsb, seq);
-		break;
-	case 2:
-		if (ri->header) {
-			seq_puts(seq, "id nodeid remid pid xid exflags flags sts grmode rqmode time_ms r_nodeid r_len r_name\n");
-			ri->header = 0;
-		}
-		print_format2(ri->rsb, seq);
-		break;
-	case 3:
-		if (ri->header) {
-			seq_puts(seq, "rsb ptr nodeid first_lkid flags !root_list_empty !recover_list_empty recover_locks_count len\n");
-			ri->header = 0;
-		}
-		print_format3(ri->rsb, seq);
-		break;
-	case 4:
-		if (ri->header) {
-			seq_puts(seq, "rsb ptr nodeid master_nodeid dir_nodeid our_nodeid toss_time flags len str|hex name\n");
-			ri->header = 0;
-		}
-		print_format4(ri->rsb, seq);
-		break;
-	}
+	struct dlm_rsb *rsb = list_entry(iter_ptr, struct dlm_rsb, res_rsbs_list);
+
+	if (seq->op == &format1_seq_ops)
+		print_format1(rsb, seq);
+	else if (seq->op == &format2_seq_ops)
+		print_format2(rsb, seq);
+	else if (seq->op == &format3_seq_ops)
+		print_format3(rsb, seq);
+	else if (seq->op == &format4_seq_ops)
+		print_format4(rsb, seq);
 
 	return 0;
 }
 
-static const struct seq_operations format1_seq_ops;
-static const struct seq_operations format2_seq_ops;
-static const struct seq_operations format3_seq_ops;
-static const struct seq_operations format4_seq_ops;
-
 static void *table_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct rb_root *tree;
-	struct rb_node *node;
 	struct dlm_ls *ls = seq->private;
-	struct rsbtbl_iter *ri;
-	struct dlm_rsb *r;
-	loff_t n = *pos;
-	unsigned bucket, entry;
-	int toss = (seq->op == &format4_seq_ops);
-
-	bucket = n >> 32;
-	entry = n & ((1LL << 32) - 1);
-
-	if (bucket >= ls->ls_rsbtbl_size)
-		return NULL;
-
-	ri = kzalloc(sizeof(*ri), GFP_NOFS);
-	if (!ri)
-		return NULL;
-	if (n == 0)
-		ri->header = 1;
-	if (seq->op == &format1_seq_ops)
-		ri->format = 1;
-	if (seq->op == &format2_seq_ops)
-		ri->format = 2;
-	if (seq->op == &format3_seq_ops)
-		ri->format = 3;
-	if (seq->op == &format4_seq_ops)
-		ri->format = 4;
-
-	tree = &ls->ls_rsbtbl[bucket].r;
+	struct list_head *list;
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	if (!RB_EMPTY_ROOT(tree)) {
-		for (node = rb_first(tree); node; node = rb_next(node)) {
-			r = rb_entry(node, struct dlm_rsb, res_hashnode);
-			if (toss) {
-				if (!rsb_flag(r, RSB_TOSS))
-					continue;
-			} else {
-				if (rsb_flag(r, RSB_TOSS))
-					continue;
-			}
-
-			if (!entry--) {
-				dlm_hold_rsb(r);
-				ri->rsb = r;
-				ri->bucket = bucket;
-				spin_unlock_bh(&ls->ls_rsbtbl_lock);
-				return ri;
-			}
-		}
+	if (!*pos) {
+		if (seq->op == &format2_seq_ops)
+			seq_puts(seq, "id nodeid remid pid xid exflags flags sts grmode rqmode time_ms r_nodeid r_len r_name\n");
+		else if (seq->op == &format3_seq_ops)
+			seq_puts(seq, "rsb ptr nodeid first_lkid flags !root_list_empty !recover_list_empty recover_locks_count len\n");
+		else if (seq->op == &format4_seq_ops)
+			seq_puts(seq, "rsb ptr nodeid master_nodeid dir_nodeid our_nodeid toss_time flags len str|hex name\n");
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
-
-	/*
-	 * move to the first rsb in the next non-empty bucket
-	 */
-
-	/* zero the entry */
-	n &= ~((1LL << 32) - 1);
 
-	while (1) {
-		bucket++;
-		n += 1LL << 32;
+	if (seq->op == &format4_seq_ops)
+		list = &ls->ls_toss;
+	else
+		list = &ls->ls_keep;
 
-		if (bucket >= ls->ls_rsbtbl_size) {
-			kfree(ri);
-			return NULL;
-		}
-		tree = &ls->ls_rsbtbl[bucket].r;
-
-		spin_lock_bh(&ls->ls_rsbtbl_lock);
-		if (!RB_EMPTY_ROOT(tree)) {
-			node = rb_first(tree);
-			r = rb_entry(node, struct dlm_rsb, res_hashnode);
-			if (toss) {
-				if (!rsb_flag(r, RSB_TOSS))
-					continue;
-			} else {
-				if (rsb_flag(r, RSB_TOSS))
-					continue;
-			}
-
-			dlm_hold_rsb(r);
-			ri->rsb = r;
-			ri->bucket = bucket;
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			*pos = n;
-			return ri;
-		}
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-	}
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	return seq_list_start(list, *pos);
 }
 
 static void *table_seq_next(struct seq_file *seq, void *iter_ptr, loff_t *pos)
 {
 	struct dlm_ls *ls = seq->private;
-	struct rsbtbl_iter *ri = iter_ptr;
-	struct rb_root *tree;
-	struct rb_node *next;
-	struct dlm_rsb *r, *rp;
-	loff_t n = *pos;
-	unsigned bucket;
-	int toss = (seq->op == &format4_seq_ops);
-
-	bucket = n >> 32;
-
-	/*
-	 * move to the next rsb in the same bucket
-	 */
-
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	rp = ri->rsb;
-	next = rb_next(&rp->res_hashnode);
-
-	if (next) {
-		r = rb_entry(next, struct dlm_rsb, res_hashnode);
-		dlm_hold_rsb(r);
-		ri->rsb = r;
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-		dlm_put_rsb(rp);
-		++*pos;
-		return ri;
-	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
-	dlm_put_rsb(rp);
-
-	/*
-	 * move to the first rsb in the next non-empty bucket
-	 */
+	struct list_head *list;
 
-	/* zero the entry */
-	n &= ~((1LL << 32) - 1);
-
-	while (1) {
-		bucket++;
-		n += 1LL << 32;
+	if (seq->op == &format4_seq_ops)
+		list = &ls->ls_toss;
+	else
+		list = &ls->ls_keep;
 
-		if (bucket >= ls->ls_rsbtbl_size) {
-			kfree(ri);
-			++*pos;
-			return NULL;
-		}
-		tree = &ls->ls_rsbtbl[bucket].r;
-
-		spin_lock_bh(&ls->ls_rsbtbl_lock);
-		if (!RB_EMPTY_ROOT(tree)) {
-			next = rb_first(tree);
-			r = rb_entry(next, struct dlm_rsb, res_hashnode);
-			if (toss) {
-				if (!rsb_flag(r, RSB_TOSS))
-					continue;
-			} else {
-				if (rsb_flag(r, RSB_TOSS))
-					continue;
-			}
-			dlm_hold_rsb(r);
-			ri->rsb = r;
-			ri->bucket = bucket;
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			*pos = n;
-			return ri;
-		}
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-	}
+	return seq_list_next(iter_ptr, list, pos);
 }
 
 static void table_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
-	struct rsbtbl_iter *ri = iter_ptr;
+	struct dlm_ls *ls = seq->private;
 
-	if (ri) {
-		dlm_put_rsb(ri->rsb);
-		kfree(ri);
-	}
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
 static const struct seq_operations format1_seq_ops = {
diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index af88fc2f978c..6d06840029c3 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -339,6 +339,7 @@ struct dlm_rsb {
 	struct list_head	res_convertqueue;
 	struct list_head	res_waitqueue;
 
+	struct list_head	res_rsbs_list;
 	struct list_head	res_root_list;	    /* used for recovery */
 	struct list_head	res_masters_list;   /* used for recovery */
 	struct list_head	res_recover_list;   /* used for recovery */
@@ -595,6 +596,9 @@ struct dlm_ls {
 	spinlock_t		ls_rsbtbl_lock;
 	uint32_t		ls_rsbtbl_size;
 
+	struct list_head	ls_toss;
+	struct list_head	ls_keep;
+
 	spinlock_t		ls_waiters_lock;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 08ec1a04476a..a70b8edb5d3f 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -668,6 +668,7 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 		r->res_first_lkid = 0;
 	}
 
+	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
 	goto out_unlock;
 
@@ -730,6 +731,8 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
  out_add:
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
+	if (!error)
+		list_add(&r->res_rsbs_list, &ls->ls_keep);
  out_unlock:
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
@@ -801,6 +804,7 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		r->res_nodeid = 0;
 	}
 
+	list_move(&r->res_rsbs_list, &ls->ls_keep);
 	rsb_clear_flag(r, RSB_TOSS);
 	goto out_unlock;
 
@@ -826,6 +830,8 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	kref_init(&r->res_ref);
 
 	error = rsb_insert(r, &ls->ls_rsbtbl[b].r);
+	if (!error)
+		list_add(&r->res_rsbs_list, &ls->ls_keep);
  out_unlock:
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
@@ -1110,6 +1116,8 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		goto retry;
 	}
 
+	list_add(&r->res_rsbs_list, &ls->ls_toss);
+
 	if (result)
 		*result = DLM_LU_ADD;
 	*r_nodeid = from_nodeid;
@@ -1120,20 +1128,12 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 
 static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
 {
-	struct rb_node *n;
 	struct dlm_rsb *r;
-	int i;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
-			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			if (rsb_flag(r, RSB_TOSS))
-				continue;
-
-			if (r->res_hash == hash)
-				dlm_dump_rsb(r);
-		}
+	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
+		if (r->res_hash == hash)
+			dlm_dump_rsb(r);
 	}
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
@@ -1166,6 +1166,7 @@ static void toss_rsb(struct kref *kref)
 	kref_init(&r->res_ref);
 	WARN_ON(rsb_flag(r, RSB_TOSS));
 	rsb_set_flag(r, RSB_TOSS);
+	list_move(&r->res_rsbs_list, &ls->ls_toss);
 	r->res_toss_time = jiffies;
 	set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl[r->res_bucket].flags);
 	if (r->res_lvbptr) {
@@ -1672,6 +1673,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 			continue;
 		}
 
+		list_del(&r->res_rsbs_list);
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		dlm_free_rsb(r);
 	}
@@ -1740,6 +1742,7 @@ static void shrink_bucket(struct dlm_ls *ls, int b)
 			continue;
 		}
 
+		list_del(&r->res_rsbs_list);
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		send_remove(r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
@@ -4243,6 +4246,7 @@ static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
 	}
 
 	if (kref_put(&r->res_ref, kill_rsb)) {
+		list_del(&r->res_rsbs_list);
 		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[b].r);
 		spin_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
@@ -5313,17 +5317,12 @@ void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
 			  lkb_count, nodes_count);
 }
 
-static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
+static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
 {
-	struct rb_node *n;
 	struct dlm_rsb *r;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	for (n = rb_first(&ls->ls_rsbtbl[bucket].r); n; n = rb_next(n)) {
-		r = rb_entry(n, struct dlm_rsb, res_hashnode);
-		if (rsb_flag(r, RSB_TOSS))
-			continue;
-
+	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
 		if (!rsb_flag(r, RSB_RECOVER_GRANT))
 			continue;
 		if (!is_master(r)) {
@@ -5358,19 +5357,15 @@ static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls, int bucket)
 void dlm_recover_grant(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	int bucket = 0;
 	unsigned int count = 0;
 	unsigned int rsb_count = 0;
 	unsigned int lkb_count = 0;
 
 	while (1) {
-		r = find_grant_rsb(ls, bucket);
-		if (!r) {
-			if (bucket == ls->ls_rsbtbl_size - 1)
-				break;
-			bucket++;
-			continue;
-		}
+		r = find_grant_rsb(ls);
+		if (!r)
+			break;
+
 		rsb_count++;
 		count = 0;
 		lock_rsb(r);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index b5184ad550fa..2b5771a7bf31 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -495,6 +495,8 @@ static int new_lockspace(const char *name, const char *cluster,
 	 */
 	ls->ls_exflags = (flags & ~(DLM_LSFL_FS | DLM_LSFL_NEWEXCL));
 
+	INIT_LIST_HEAD(&ls->ls_toss);
+	INIT_LIST_HEAD(&ls->ls_keep);
 	spin_lock_init(&ls->ls_rsbtbl_lock);
 	size = READ_ONCE(dlm_config.ci_rsbtbl_size);
 	ls->ls_rsbtbl_size = size;
@@ -838,6 +840,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
 		while ((n = rb_first(&ls->ls_rsbtbl[i].r))) {
 			rsb = rb_entry(n, struct dlm_rsb, res_hashnode);
+			list_del(&rsb->res_rsbs_list);
 			rb_erase(n, &ls->ls_rsbtbl[i].r);
 			dlm_free_rsb(rsb);
 		}
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index e53d88e4ec93..512c1ae81a96 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -881,23 +881,15 @@ void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list)
 
 void dlm_clear_toss(struct dlm_ls *ls)
 {
-	struct rb_node *n, *next;
-	struct dlm_rsb *r;
+	struct dlm_rsb *r, *safe;
 	unsigned int count = 0;
-	int i;
-
-	spin_lock(&ls->ls_rsbtbl_lock);
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = next) {
-			next = rb_next(n);
-			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			if (!rsb_flag(r, RSB_TOSS))
-				continue;
-
-			rb_erase(n, &ls->ls_rsbtbl[i].r);
-			dlm_free_rsb(r);
-			count++;
-		}
+
+	spin_lock_bh(&ls->ls_rsbtbl_lock);
+	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
+		list_del(&r->res_rsbs_list);
+		rb_erase(&r->res_hashnode, &ls->ls_rsbtbl[r->res_bucket].r);
+		dlm_free_rsb(r);
+		count++;
 	}
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index ad696528ebe7..5e8e10030b74 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -22,9 +22,8 @@
 
 static int dlm_create_masters_list(struct dlm_ls *ls)
 {
-	struct rb_node *n;
 	struct dlm_rsb *r;
-	int i, error = 0;
+	int error = 0;
 
 	write_lock_bh(&ls->ls_masters_lock);
 	if (!list_empty(&ls->ls_masters_list)) {
@@ -34,15 +33,12 @@ static int dlm_create_masters_list(struct dlm_ls *ls)
 	}
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
-			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			if (rsb_flag(r, RSB_TOSS) || r->res_nodeid)
-				continue;
-
-			list_add(&r->res_masters_list, &ls->ls_masters_list);
-			dlm_hold_rsb(r);
-		}
+	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
+		if (r->res_nodeid)
+			continue;
+
+		list_add(&r->res_masters_list, &ls->ls_masters_list);
+		dlm_hold_rsb(r);
 	}
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
  out:
@@ -64,21 +60,15 @@ static void dlm_release_masters_list(struct dlm_ls *ls)
 
 static void dlm_create_root_list(struct dlm_ls *ls, struct list_head *root_list)
 {
-	struct rb_node *n;
 	struct dlm_rsb *r;
-	int i;
 
 	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
-		for (n = rb_first(&ls->ls_rsbtbl[i].r); n; n = rb_next(n)) {
-			r = rb_entry(n, struct dlm_rsb, res_hashnode);
-			if (WARN_ON_ONCE(rsb_flag(r, RSB_TOSS)))
-				continue;
-
-			list_add(&r->res_root_list, root_list);
-			dlm_hold_rsb(r);
-		}
+	list_for_each_entry(r, &ls->ls_keep, res_rsbs_list) {
+		list_add(&r->res_root_list, root_list);
+		dlm_hold_rsb(r);
 	}
+
+	WARN_ON_ONCE(!list_empty(&ls->ls_toss));
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
-- 
2.43.0

