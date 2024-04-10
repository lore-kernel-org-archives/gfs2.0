Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6216C426
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756956; cv=none; b=QFymyFJ64CC5eNBu2XLAKfT9LFIWRQygJ5zdRUNCg7fcrqvkmB4OkKmG2c57gn1y8EMVXFGl1BLHY834R+mKhs6kBZBx/CxVp6RZ1lYMoWYNKviXH5D8X97qhJ5WAB034xDlaN6qn/LpNoPRiSAVTesPqkQCnYGPrqCFZdeOJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756956; c=relaxed/simple;
	bh=9VlcPv+AfOpYT8a2FQYjwefbeyccQe2T4jz9GM61X/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0LPdnlext0Mgd5BFQUrZYkgB5iKqEAMuE1D40iVoRjcojU/7xMMb/tIApJMLvkxuybcieIYTfsh7eOTjponVZGOip52CPqmIw5h8tTHRP3tT4H1xjjPVKpoYwgtfYJRYEqgJnBtmcFVSuf9EjOYvQ9PZl3K99ImHh9F7ZIxA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOx+0iTU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOx+0iTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GK16VYQv/oznr0WNEIhdIjromh22oDZDjXq9uRCDeok=;
	b=dOx+0iTUpTndK70+/79OtY22z7WbjRwwJD5GleZMQmjHqPDDXJcZLUr6tXgyinLfjU3do0
	DFN9LV4guBN8Uj4Rt2niJKasd1ZBLMuQBNZko3FB7GmAHOPSSn9uEOoWEEFH/b8m8skIzl
	RrAOqejtbzLq3KtOmS4TO/C0qAMxbUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SoAgGZEqPten0GzSAhf8hw-1; Wed, 10 Apr 2024 09:49:09 -0400
X-MC-Unique: SoAgGZEqPten0GzSAhf8hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D5F80B55D
	for <gfs2@lists.linux.dev>; Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D95D0C27EB0;
	Wed, 10 Apr 2024 13:49:08 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 7/9] dlm: drop scand kthread and use timers
Date: Wed, 10 Apr 2024 09:48:56 -0400
Message-ID: <20240410134858.3295266-8-aahringo@redhat.com>
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

Currently the scand kthread acts like a garbage collection for expired
rsbs on toss list to clean them up after a certain timeout. It triggers
every couple of seconds and iterates over the toss list while holding
ls_rsbtbl_lock for the whole hash bucket iteration. To reduce the amount
of holding the ls_rsbtbl_lock time we handle free of cached rsbs (tossed
rsbs) on a per rsb timer. If it expires the rsb deletes itseld out of
rsb data structures. Addtional the timer can run on any cpu instead of
scand that was only running on one cpu, so there should be a performance
speedup handling such freeing of resources.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  15 ++-
 fs/dlm/lock.c         | 272 +++++++++++++++++++++---------------------
 fs/dlm/lockspace.c    | 105 +++-------------
 fs/dlm/recover.c      |  24 +++-
 4 files changed, 178 insertions(+), 238 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index cf43b97cf3e5..0ab76ed8685e 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -320,6 +320,7 @@ struct dlm_rsb {
 	uint32_t                res_lvbseq;
 	uint32_t		res_hash;
 	unsigned long		res_toss_time;
+	struct timer_list	res_toss_timer;
 	uint32_t		res_first_lkid;
 	struct list_head	res_lookup;	/* lkbs waiting on first */
 	union {
@@ -368,6 +369,7 @@ enum rsb_flags {
 	RSB_RECOVER_GRANT,
 	RSB_RECOVER_LVB_INVAL,
 	RSB_TOSS,
+	RSB_TIMER_KILLED,
 };
 
 static inline void rsb_set_flag(struct dlm_rsb *r, enum rsb_flags flag)
@@ -584,8 +586,6 @@ struct dlm_ls {
 	spinlock_t		ls_lkbidr_spin;
 
 	struct rhashtable	ls_rsbtbl;
-#define DLM_RTF_SHRINK_BIT	0
-	unsigned long		ls_rsbtbl_flags;
 	spinlock_t		ls_rsbtbl_lock;
 
 	struct list_head	ls_toss;
@@ -601,9 +601,6 @@ struct dlm_ls {
 	int			ls_new_rsb_count;
 	struct list_head	ls_new_rsb;	/* new rsb structs */
 
-	char			*ls_remove_names[DLM_REMOVE_NAMES_MAX];
-	int			ls_remove_lens[DLM_REMOVE_NAMES_MAX];
-
 	struct list_head	ls_nodes;	/* current nodes in ls */
 	struct list_head	ls_nodes_gone;	/* dead node list, recovery */
 	int			ls_num_nodes;	/* number of nodes in ls */
@@ -698,6 +695,13 @@ struct dlm_ls {
  * dlm_ls_stop() clears this to tell dlm locking routines that they should
  * quit what they are doing so recovery can run.  dlm_recoverd sets
  * this after recovery is finished.
+ *
+ * LSFL_TIMER_KILLED - a per lockspace switch that will kill all timers in
+ * sense of they don't do anything anymore. To set this flag the caller
+ * need to held the ls_in_recovery write lock. It's useful to just don't iterate
+ * over all timers and call timer_shutdown_sync() to stop every res_toss_timer
+ * that is currently ongoing and queued e.g. when release_lockspace() is called
+ * and we need to force to stop everything.
  */
 
 #define LSFL_RECOVER_STOP	0
@@ -712,6 +716,7 @@ struct dlm_ls {
 #define LSFL_CB_DELAY		9
 #define LSFL_NODIR		10
 #define LSFL_RECV_MSG_BLOCKED	11
+#define LSFL_TIMER_KILLED	12
 
 #define DLM_PROC_FLAGS_CLOSING 1
 #define DLM_PROC_FLAGS_COMPAT  2
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index fee1a4164fc1..b3f0b0445812 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -320,6 +320,11 @@ static void queue_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rqmode)
  * Basic operations on rsb's and lkb's
  */
 
+static inline unsigned long rsb_toss_jiffies(const struct dlm_rsb *r)
+{
+	return jiffies + (READ_ONCE(dlm_config.ci_toss_secs) * HZ);
+}
+
 /* This is only called to add a reference when the code already holds
    a valid reference to the rsb, so there's no need for locking. */
 
@@ -416,6 +421,108 @@ static int pre_rsb_struct(struct dlm_ls *ls)
 	return 0;
 }
 
+/* Caller must held ls_rsbtbl_lock and need to be called every time
+ * when either the rsb enters toss state or the toss state changes
+ * the dir/master nodeid.
+ */
+static void rsb_mod_timer(struct dlm_ls *ls, struct dlm_rsb *r)
+{
+	int our_nodeid = dlm_our_nodeid();
+
+	/* If we're the directory record for this rsb, and
+	 * we're not the master of it, then we need to wait
+	 * for the master node to send us a dir remove for
+	 * before removing the dir record.
+	 */
+	if (!dlm_no_directory(ls) &&
+	    (r->res_master_nodeid != our_nodeid) &&
+	    (dlm_dir_nodeid(r) == our_nodeid)) {
+		/* indicates we waiting for send_remove message */
+		r->res_toss_time = 0;
+		rsb_set_flag(r, RSB_TIMER_KILLED);
+		timer_delete(&r->res_toss_timer);
+		return;
+	}
+
+	rsb_clear_flag(r, RSB_TIMER_KILLED);
+	r->res_toss_time = jiffies;
+	mod_timer(&r->res_toss_timer, rsb_toss_jiffies(r));
+}
+
+static void dlm_rsb_toss_timer(struct timer_list *timer)
+{
+	struct dlm_rsb *r = container_of(timer, struct dlm_rsb, res_toss_timer);
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_ls *ls = r->res_ls;
+	int rv;
+
+	rv = dlm_lock_recovery_try(ls);
+	if (!rv) {
+		/* rearm timer */
+		mod_timer(&r->res_toss_timer, rsb_toss_jiffies(r));
+		return;
+	}
+
+	/* check if the timer was killed on a per lockspace basis
+	 * this flag is set when the ls_in_recovery lock is held
+	 * as write lock.
+	 */
+	if (test_bit(LSFL_TIMER_KILLED, &ls->ls_flags)) {
+		dlm_unlock_recovery(ls);
+		return;
+	}
+
+	rv = spin_trylock(&ls->ls_rsbtbl_lock);
+	if (!rv) {
+		dlm_unlock_recovery(ls);
+		/* rearm timer */
+		mod_timer(&r->res_toss_timer, rsb_toss_jiffies(r));
+		return;
+	}
+
+	/* timer got killed we do nothing, in case of the
+	 * timer got rearmed because a rsb switched to toss,
+	 * to keep and toss again and the timer of the first
+	 * toss state is still executed we check on if the
+	 * timer was rearmed then we have a new toss timeout
+	 * so we check if the timer is currently pending as
+	 * well.
+	 */
+	if (rsb_flag(r, RSB_TIMER_KILLED) ||
+	    timer_pending(&r->res_toss_timer)) {
+		spin_unlock(&ls->ls_rsbtbl_lock);
+		dlm_unlock_recovery(ls);
+		return;
+	}
+
+	list_del(&r->res_rsbs_list);
+	rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+			       dlm_rhash_rsb_params);
+
+	/* not necessary to held the ls_rsbtbl_lock when
+	 * calling send_remove() its gone from DLM now
+	 */
+	spin_unlock(&ls->ls_rsbtbl_lock);
+
+	/* no rsb in this state should ever run a timer */
+	WARN_ON(!dlm_no_directory(ls) &&
+		(r->res_master_nodeid != our_nodeid) &&
+		(dlm_dir_nodeid(r) == our_nodeid));
+
+	/* We're the master of this rsb but we're not
+	 * the directory record, so we need to tell the
+	 * dir node to remove the dir record
+	 */
+	if (!dlm_no_directory(ls) &&
+	    (r->res_master_nodeid == our_nodeid) &&
+	    (dlm_dir_nodeid(r) != our_nodeid))
+		send_remove(r);
+
+	dlm_unlock_recovery(ls);
+
+	free_toss_rsb(r);
+}
+
 /* If ls->ls_new_rsb is empty, return -EAGAIN, so the caller can
    unlock any spinlocks, go back and call pre_rsb_struct again.
    Otherwise, take an rsb off the list and return it. */
@@ -454,6 +561,9 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	INIT_LIST_HEAD(&r->res_recover_list);
 	INIT_LIST_HEAD(&r->res_masters_list);
 
+	timer_setup(&r->res_toss_timer, dlm_rsb_toss_timer,
+		    TIMER_DEFERRABLE);
+
 	*r_ret = r;
 	return 0;
 }
@@ -638,6 +748,15 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	 * valid for keep state rsbs
 	 */
 	kref_init(&r->res_ref);
+	/* force kill timer, we can't wait here that the timer
+	 * is done exectuing but we hold the ls_rsbtbl_lock lock
+	 * to make sure the timer does not do anything anymore.
+	 * The timer_delete() is just a optimization if the timer
+	 * is pending we stop to be executec if expired.
+	 */
+	rsb_set_flag(r, RSB_TIMER_KILLED);
+	timer_delete(&r->res_toss_timer);
+
 	goto out_unlock;
 
 
@@ -777,6 +896,15 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 * valid for keep state rsbs
 	 */
 	kref_init(&r->res_ref);
+	/* force kill timer, we can't wait here that the timer
+	 * is done exectuing but we hold the ls_rsbtbl_lock lock
+	 * to make sure the timer does not do anything anymore.
+	 * The timer_delete() is just a optimization if the timer
+	 * is pending we stop to be executec if expired.
+	 */
+	rsb_set_flag(r, RSB_TIMER_KILLED);
+	timer_delete(&r->res_toss_timer);
+
 	goto out_unlock;
 
 
@@ -1050,7 +1178,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
 			    r_nodeid, result);
 
-	r->res_toss_time = jiffies;
+	rsb_mod_timer(ls, r);
 	/* the rsb was inactive (on toss list) */
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -1070,7 +1198,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	r->res_master_nodeid = from_nodeid;
 	r->res_nodeid = from_nodeid;
 	kref_init(&r->res_ref);
-	r->res_toss_time = jiffies;
 	rsb_set_flag(r, RSB_TOSS);
 
 	error = rsb_insert(r, &ls->ls_rsbtbl);
@@ -1082,6 +1209,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	}
 
 	list_add(&r->res_rsbs_list, &ls->ls_toss);
+	rsb_mod_timer(ls, r);
 
 	if (result)
 		*result = DLM_LU_ADD;
@@ -1126,8 +1254,8 @@ static void toss_rsb(struct kref *kref)
 	DLM_ASSERT(list_empty(&r->res_root_list), dlm_print_rsb(r););
 	rsb_set_flag(r, RSB_TOSS);
 	list_move(&r->res_rsbs_list, &ls->ls_toss);
-	r->res_toss_time = jiffies;
-	set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
+	rsb_mod_timer(ls, r);
+
 	if (r->res_lvbptr) {
 		dlm_free_lvb(r->res_lvbptr);
 		r->res_lvbptr = NULL;
@@ -1154,6 +1282,8 @@ void free_toss_rsb(struct dlm_rsb *r)
 	 * and it can be freed.
 	 */
 
+	WARN_ON_ONCE(timer_pending(&r->res_toss_timer));
+
 	DLM_ASSERT(list_empty(&r->res_lookup), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_grantqueue), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_convertqueue), dlm_dump_rsb(r););
@@ -1572,140 +1702,6 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
 	return error;
 }
 
-static void shrink_bucket(struct dlm_ls *ls)
-{
-	struct dlm_rsb *r, *safe;
-	char *name;
-	int our_nodeid = dlm_our_nodeid();
-	int remote_count = 0;
-	int need_shrink = 0;
-	int i, len, rv;
-
-	memset(&ls->ls_remove_lens, 0, sizeof(int) * DLM_REMOVE_NAMES_MAX);
-
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
-
-	if (!test_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags)) {
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-		return;
-	}
-
-	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
-		/* If we're the directory record for this rsb, and
-		   we're not the master of it, then we need to wait
-		   for the master node to send us a dir remove for
-		   before removing the dir record. */
-
-		if (!dlm_no_directory(ls) &&
-		    (r->res_master_nodeid != our_nodeid) &&
-		    (dlm_dir_nodeid(r) == our_nodeid)) {
-			continue;
-		}
-
-		need_shrink = 1;
-
-		if (!time_after_eq(jiffies, r->res_toss_time +
-				   dlm_config.ci_toss_secs * HZ)) {
-			continue;
-		}
-
-		if (!dlm_no_directory(ls) &&
-		    (r->res_master_nodeid == our_nodeid) &&
-		    (dlm_dir_nodeid(r) != our_nodeid)) {
-
-			/* We're the master of this rsb but we're not
-			   the directory record, so we need to tell the
-			   dir node to remove the dir record. */
-
-			ls->ls_remove_lens[remote_count] = r->res_length;
-			memcpy(ls->ls_remove_names[remote_count], r->res_name,
-			       DLM_RESNAME_MAXLEN);
-			remote_count++;
-
-			if (remote_count >= DLM_REMOVE_NAMES_MAX)
-				break;
-			continue;
-		}
-
-		list_del(&r->res_rsbs_list);
-		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
-				       dlm_rhash_rsb_params);
-		free_toss_rsb(r);
-	}
-
-	if (need_shrink)
-		set_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
-	else
-		clear_bit(DLM_RTF_SHRINK_BIT, &ls->ls_rsbtbl_flags);
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
-
-	/*
-	 * While searching for rsb's to free, we found some that require
-	 * remote removal.  We leave them in place and find them again here
-	 * so there is a very small gap between removing them from the toss
-	 * list and sending the removal.  Keeping this gap small is
-	 * important to keep us (the master node) from being out of sync
-	 * with the remote dir node for very long.
-	 */
-
-	for (i = 0; i < remote_count; i++) {
-		name = ls->ls_remove_names[i];
-		len = ls->ls_remove_lens[i];
-
-		spin_lock_bh(&ls->ls_rsbtbl_lock);
-		rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-		if (rv) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_error(ls, "remove_name not found %s", name);
-			continue;
-		}
-
-		if (!rsb_flag(r, RSB_TOSS)) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_debug(ls, "remove_name not toss %s", name);
-			continue;
-		}
-
-		if (r->res_master_nodeid != our_nodeid) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_debug(ls, "remove_name master %d dir %d our %d %s",
-				  r->res_master_nodeid, r->res_dir_nodeid,
-				  our_nodeid, name);
-			continue;
-		}
-
-		if (r->res_dir_nodeid == our_nodeid) {
-			/* should never happen */
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_error(ls, "remove_name dir %d master %d our %d %s",
-				  r->res_dir_nodeid, r->res_master_nodeid,
-				  our_nodeid, name);
-			continue;
-		}
-
-		if (!time_after_eq(jiffies, r->res_toss_time +
-				   dlm_config.ci_toss_secs * HZ)) {
-			spin_unlock_bh(&ls->ls_rsbtbl_lock);
-			log_debug(ls, "remove_name toss_time %lu now %lu %s",
-				  r->res_toss_time, jiffies, name);
-			continue;
-		}
-
-		list_del(&r->res_rsbs_list);
-		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
-				       dlm_rhash_rsb_params);
-		send_remove(r);
-		spin_unlock_bh(&ls->ls_rsbtbl_lock);
-
-		free_toss_rsb(r);
-	}
-}
-
-void dlm_scan_rsbs(struct dlm_ls *ls)
-{
-	shrink_bucket(ls);
-}
-
 /* lkb is master or local copy */
 
 static void set_lvb_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 890e1a4cf787..df7ff5824830 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -29,8 +29,6 @@ static int			ls_count;
 static struct mutex		ls_lock;
 static struct list_head		lslist;
 static spinlock_t		lslist_lock;
-static struct task_struct *	scand_task;
-
 
 static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
 {
@@ -247,64 +245,6 @@ void dlm_lockspace_exit(void)
 	kset_unregister(dlm_kset);
 }
 
-static struct dlm_ls *find_ls_to_scan(void)
-{
-	struct dlm_ls *ls;
-
-	spin_lock_bh(&lslist_lock);
-	list_for_each_entry(ls, &lslist, ls_list) {
-		if (time_after_eq(jiffies, ls->ls_scan_time +
-					    dlm_config.ci_scan_secs * HZ)) {
-			atomic_inc(&ls->ls_count);
-			spin_unlock_bh(&lslist_lock);
-			return ls;
-		}
-	}
-	spin_unlock_bh(&lslist_lock);
-	return NULL;
-}
-
-static int dlm_scand(void *data)
-{
-	struct dlm_ls *ls;
-
-	while (!kthread_should_stop()) {
-		ls = find_ls_to_scan();
-		if (ls) {
-			if (dlm_lock_recovery_try(ls)) {
-				ls->ls_scan_time = jiffies;
-				dlm_scan_rsbs(ls);
-				dlm_unlock_recovery(ls);
-			} else {
-				ls->ls_scan_time += HZ;
-			}
-
-			dlm_put_lockspace(ls);
-			continue;
-		}
-		schedule_timeout_interruptible(dlm_config.ci_scan_secs * HZ);
-	}
-	return 0;
-}
-
-static int dlm_scand_start(void)
-{
-	struct task_struct *p;
-	int error = 0;
-
-	p = kthread_run(dlm_scand, NULL, "dlm_scand");
-	if (IS_ERR(p))
-		error = PTR_ERR(p);
-	else
-		scand_task = p;
-	return error;
-}
-
-static void dlm_scand_stop(void)
-{
-	kthread_stop(scand_task);
-}
-
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
 	struct dlm_ls *ls;
@@ -385,22 +325,9 @@ static int threads_start(void)
 
 	/* Thread for sending/receiving messages for all lockspace's */
 	error = dlm_midcomms_start();
-	if (error) {
+	if (error)
 		log_print("cannot start dlm midcomms %d", error);
-		goto fail;
-	}
 
-	error = dlm_scand_start();
-	if (error) {
-		log_print("cannot start dlm_scand thread %d", error);
-		goto midcomms_fail;
-	}
-
-	return 0;
-
- midcomms_fail:
-	dlm_midcomms_stop();
- fail:
 	return error;
 }
 
@@ -412,7 +339,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	struct dlm_ls *ls;
 	int do_unreg = 0;
 	int namelen = strlen(name);
-	int i, error;
+	int error;
 
 	if (namelen > DLM_LOCKSPACE_LEN || namelen == 0)
 		return -EINVAL;
@@ -503,13 +430,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	if (error)
 		goto out_lsfree;
 
-	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
-		ls->ls_remove_names[i] = kzalloc(DLM_RESNAME_MAXLEN+1,
-						 GFP_KERNEL);
-		if (!ls->ls_remove_names[i])
-			goto out_rsbtbl;
-	}
-
 	idr_init(&ls->ls_lkbidr);
 	spin_lock_init(&ls->ls_lkbidr_spin);
 
@@ -661,9 +581,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
- out_rsbtbl:
-	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
-		kfree(ls->ls_remove_names[i]);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)
@@ -696,7 +613,6 @@ static int __dlm_new_lockspace(const char *name, const char *cluster,
 	if (error > 0)
 		error = 0;
 	if (!ls_count) {
-		dlm_scand_stop();
 		dlm_midcomms_shutdown();
 		dlm_midcomms_stop();
 	}
@@ -771,13 +687,19 @@ static void rhash_free_rsb(void *ptr, void *arg)
 {
 	struct dlm_rsb *rsb = ptr;
 
+	/* be sure no timer callback is still
+	 * running before free rsb, it was killed before
+	 * but killing will not guarantee that the callback
+	 * is still queued/or actually in excution.
+	 */
+	timer_shutdown_sync(&rsb->res_toss_timer);
 	dlm_free_rsb(rsb);
 }
 
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
 	struct dlm_rsb *rsb;
-	int i, busy, rv;
+	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
 
@@ -812,8 +734,12 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_recoverd_stop(ls);
 
+	/* dummy all res_toss_timer handling */
+	down_write(&ls->ls_in_recovery);
+	set_bit(LSFL_TIMER_KILLED, &ls->ls_flags);
+	up_write(&ls->ls_in_recovery);
+
 	if (ls_count == 1) {
-		dlm_scand_stop();
 		dlm_clear_members(ls);
 		dlm_midcomms_shutdown();
 	}
@@ -839,9 +765,6 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	 */
 	rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL);
 
-	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
-		kfree(ls->ls_remove_names[i]);
-
 	while (!list_empty(&ls->ls_new_rsb)) {
 		rsb = list_first_entry(&ls->ls_new_rsb, struct dlm_rsb,
 				       res_hashchain);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index d43189532b14..fb726dad3c53 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -881,18 +881,34 @@ void dlm_recover_rsbs(struct dlm_ls *ls, const struct list_head *root_list)
 
 void dlm_clear_toss(struct dlm_ls *ls)
 {
-	struct dlm_rsb *r, *safe;
 	unsigned int count = 0;
+	struct dlm_rsb *r;
+
+	while (1) {
+		spin_lock_bh(&ls->ls_rsbtbl_lock);
+		r = list_first_entry_or_null(&ls->ls_toss, struct dlm_rsb,
+					     res_rsbs_list);
+		if (!r) {
+			spin_unlock_bh(&ls->ls_rsbtbl_lock);
+			break;
+		}
 
-	spin_lock_bh(&ls->ls_rsbtbl_lock);
-	list_for_each_entry_safe(r, safe, &ls->ls_toss, res_rsbs_list) {
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
+		rsb_set_flag(r, RSB_TIMER_KILLED);
+		spin_unlock_bh(&ls->ls_rsbtbl_lock);
+
+		/* Wait until all killed currently running timer
+		 * callbacks are done. Killed as RSB_TIMER_KILLED
+		 * is set and the timer callback does nothing
+		 * anymore and dlm_clear_toss() takes over.
+		 */
+		timer_shutdown_sync(&r->res_toss_timer);
+
 		free_toss_rsb(r);
 		count++;
 	}
-	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
 	if (count)
 		log_rinfo(ls, "dlm_clear_toss %u done", count);
-- 
2.43.0

