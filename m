Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D2154C09
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206390; cv=none; b=DXRsLQFnvmNq71FEP1Q2xJaRTrYbMtNT4JbY5YKkYs++HVxPiBuI9b7aemoj3iXCBmTHRE6ZM1gzXWdbthei5u8C54/Pf0Ao0MBiIDJ+EkRr6UTIxMKd0RuAzaoSqdgCQMCh4nY+ojc3YH3cKmuA+OQQS21aKMZQF8u0BVOqOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206390; c=relaxed/simple;
	bh=VQlDUdEfyqpOhhj0zFfNiLNA6rAu7xXH17FDbZPTn3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQmoV0qs/D2PS3oc+BfKlMne8jEAvBXu7/xwRkDPLtxt+O/KZxVWU3lXkCK49BR75xf38n4zri8bkW1n7JmpYup2Op2YUDoRjkDn1CQHrOsFDdFr4vK54vMQiuHM6IXO4Utj0KCOiSkPAmCse0PtQTk+BQkwyZBmPXl5a5GKhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiyVjF4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiyVjF4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713206387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsMmr4NrhaRV5lIc2QtWT+o+Rp0of5xmvXvolK3znyg=;
	b=RiyVjF4UM45eHAi7eGqdSjsP0tyNXJC+pXDSlog/0W8PtBvq1k1vOCbBsJQuCIflvSW+37
	sPzkhX2lJawKYqdPd3bObv0I8uEOVY56uEJiWKwWN/I2B7VwqpxFZoYiRhjKLta1RPJU9S
	2H7tEZPJEeP1ViMsyS01AYio+F6H/NM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-IKtwN6ImM2mCTsoCbWndvw-1; Mon,
 15 Apr 2024 14:39:45 -0400
X-MC-Unique: IKtwN6ImM2mCTsoCbWndvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 399E53830094
	for <gfs2@lists.linux.dev>; Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29AE4C13FA2;
	Mon, 15 Apr 2024 18:39:45 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 dlm/next 7/9] dlm: drop scand kthread and use timers
Date: Mon, 15 Apr 2024 14:39:41 -0400
Message-ID: <20240415183943.645497-8-aahringo@redhat.com>
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

Currently the scand kthread acts like a garbage collection for expired
rsbs on toss list to clean them up after a certain timeout. It triggers
every couple of seconds and iterates over the toss list while holding
ls_rsbtbl_lock for the whole hash bucket iteration. To reduce the amount
of holding the ls_rsbtbl_lock time we handle free of cached rsbs (tossed
rsbs) on a per rsb timer. If it expires the rsb deletes itself out of
the rsb toss queue that is an ordered queue of tossed rsbs. First entry
is the earliest rsb to expire the last is the lastest rsb that will expire.
The res_toss_time is now an absolute value of when it will be expired
before it was the time when the rsb was tossed. It was an debug
functionality for debugfs anyway, we change a little bit the semantic
here.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  16 +-
 fs/dlm/lock.c         | 382 ++++++++++++++++++++++++++----------------
 fs/dlm/lock.h         |   2 +
 fs/dlm/lockspace.c    | 105 ++----------
 fs/dlm/member.c       |   2 +
 fs/dlm/recover.c      |   5 +
 fs/dlm/recoverd.c     |  10 ++
 7 files changed, 283 insertions(+), 239 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index cf43b97cf3e5..98a0ac511bc8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -334,6 +334,7 @@ struct dlm_rsb {
 	struct list_head	res_root_list;	    /* used for recovery */
 	struct list_head	res_masters_list;   /* used for recovery */
 	struct list_head	res_recover_list;   /* used for recovery */
+	struct list_head	res_toss_q_list;
 	int			res_recover_locks_count;
 
 	char			*res_lvbptr;
@@ -584,13 +585,20 @@ struct dlm_ls {
 	spinlock_t		ls_lkbidr_spin;
 
 	struct rhashtable	ls_rsbtbl;
-#define DLM_RTF_SHRINK_BIT	0
-	unsigned long		ls_rsbtbl_flags;
 	spinlock_t		ls_rsbtbl_lock;
 
 	struct list_head	ls_toss;
 	struct list_head	ls_keep;
 
+	struct timer_list	ls_timer;
+	/* this queue is ordered according the
+	 * absolute res_toss_time jiffies time
+	 * to mod_timer() with the first element
+	 * if necessary.
+	 */
+	struct list_head	ls_toss_q;
+	spinlock_t		ls_toss_q_lock;
+
 	spinlock_t		ls_waiters_lock;
 	struct list_head	ls_waiters;	/* lkbs needing a reply */
 
@@ -601,9 +609,6 @@ struct dlm_ls {
 	int			ls_new_rsb_count;
 	struct list_head	ls_new_rsb;	/* new rsb structs */
 
-	char			*ls_remove_names[DLM_REMOVE_NAMES_MAX];
-	int			ls_remove_lens[DLM_REMOVE_NAMES_MAX];
-
 	struct list_head	ls_nodes;	/* current nodes in ls */
 	struct list_head	ls_nodes_gone;	/* dead node list, recovery */
 	int			ls_num_nodes;	/* number of nodes in ls */
@@ -640,7 +645,6 @@ struct dlm_ls {
 
 	spinlock_t		ls_cb_lock;
 	struct list_head	ls_cb_delay; /* save for queue_work later */
-	struct timer_list	ls_timer;
 	struct task_struct	*ls_recoverd_task;
 	struct mutex		ls_recoverd_active;
 	spinlock_t		ls_recover_lock;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index fee1a4164fc1..7c97181a04fe 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -320,6 +320,11 @@ static void queue_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rqmode)
  * Basic operations on rsb's and lkb's
  */
 
+static inline unsigned long rsb_toss_jiffies(void)
+{
+	return jiffies + (READ_ONCE(dlm_config.ci_toss_secs) * HZ);
+}
+
 /* This is only called to add a reference when the code already holds
    a valid reference to the rsb, so there's no need for locking. */
 
@@ -416,6 +421,229 @@ static int pre_rsb_struct(struct dlm_ls *ls)
 	return 0;
 }
 
+/* connected with timer_delete_sync() in dlm_ls_stop() to stop
+ * new timers when recovery is triggered and don't run them
+ * again until a dlm_timer_resume() tries it again.
+ */
+static void __rsb_mod_timer(struct dlm_ls *ls, unsigned long jiffies)
+{
+	if (!dlm_locking_stopped(ls))
+		mod_timer(&ls->ls_timer, jiffies);
+}
+
+/* This function tries to resume the timer callback if a rsb
+ * is on the toss list and no timer is pending. It might that
+ * the first entry is on currently executed as timer callback
+ * but we don't care if a timer queued up again and does
+ * nothing. Should be a rare case.
+ */
+void dlm_timer_resume(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+
+	spin_lock_bh(&ls->ls_toss_q_lock);
+	r = list_first_entry_or_null(&ls->ls_toss_q, struct dlm_rsb,
+				     res_toss_q_list);
+	if (r && !timer_pending(&ls->ls_timer))
+		__rsb_mod_timer(ls, r->res_toss_time);
+	spin_unlock_bh(&ls->ls_toss_q_lock);
+}
+
+/* ls_rsbtbl_lock must be held and being sure the rsb is in toss state */
+static void rsb_delete_toss_timer(struct dlm_ls *ls, struct dlm_rsb *r)
+{
+	struct dlm_rsb *first;
+
+	spin_lock_bh(&ls->ls_toss_q_lock);
+	r->res_toss_time = 0;
+
+	/* if the rsb is not queued do nothing */
+	if (list_empty(&r->res_toss_q_list))
+		goto out;
+
+	/* get the first element before delete */
+	first = list_first_entry(&ls->ls_toss_q, struct dlm_rsb,
+				 res_toss_q_list);
+	list_del_init(&r->res_toss_q_list);
+	/* check if the first element was the rsb we deleted */
+	if (first == r) {
+		/* try to get the new first element, if the list
+		 * is empty now try to delete the timer, if we are
+		 * too late we don't care.
+		 *
+		 * if the list isn't empty and a new first element got
+		 * in place, set the new timer expire time.
+		 */
+		first = list_first_entry_or_null(&ls->ls_toss_q, struct dlm_rsb,
+						 res_toss_q_list);
+		if (!first)
+			timer_delete(&ls->ls_timer);
+		else
+			__rsb_mod_timer(ls, first->res_toss_time);
+	}
+
+out:
+	spin_unlock_bh(&ls->ls_toss_q_lock);
+}
+
+/* Caller must held ls_rsbtbl_lock and need to be called every time
+ * when either the rsb enters toss state or the toss state changes
+ * the dir/master nodeid.
+ */
+static void rsb_mod_timer(struct dlm_ls *ls, struct dlm_rsb *r)
+{
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *first;
+
+	/* If we're the directory record for this rsb, and
+	 * we're not the master of it, then we need to wait
+	 * for the master node to send us a dir remove for
+	 * before removing the dir record.
+	 */
+	if (!dlm_no_directory(ls) &&
+	    (r->res_master_nodeid != our_nodeid) &&
+	    (dlm_dir_nodeid(r) == our_nodeid)) {
+		rsb_delete_toss_timer(ls, r);
+		return;
+	}
+
+	spin_lock_bh(&ls->ls_toss_q_lock);
+	/* set the new rsb absolute expire time in the rsb */
+	r->res_toss_time = rsb_toss_jiffies();
+	if (list_empty(&ls->ls_toss_q)) {
+		/* if the queue is empty add the element and it's
+		 * our new expire time
+		 */
+		list_add_tail(&r->res_toss_q_list, &ls->ls_toss_q);
+		__rsb_mod_timer(ls, r->res_toss_time);
+	} else {
+		/* check if the rsb was already queued, if so delete
+		 * it from the toss queue
+		 */
+		if (!list_empty(&r->res_toss_q_list))
+			list_del(&r->res_toss_q_list);
+
+		/* try to get the maybe new first element and then add
+		 * to this rsb with the oldest expire time to the end
+		 * of the queue. If the list was empty before this
+		 * rsb expire time is our next expiration if it wasn't
+		 * the now new first elemet is our new expiration time
+		 */
+		first = list_first_entry_or_null(&ls->ls_toss_q, struct dlm_rsb,
+						 res_toss_q_list);
+		list_add_tail(&r->res_toss_q_list, &ls->ls_toss_q);
+		if (!first)
+			__rsb_mod_timer(ls, r->res_toss_time);
+		else
+			__rsb_mod_timer(ls, first->res_toss_time);
+	}
+	spin_unlock_bh(&ls->ls_toss_q_lock);
+}
+
+/* if we hit contention we do in 250 ms a retry to trylock.
+ * if there is any other mod_timer in between we don't care
+ * about that it expires earlier again this is only for the
+ * unlikely case nothing happened in this time.
+ */
+#define DLM_TOSS_TIMER_RETRY	(jiffies + msecs_to_jiffies(250))
+
+void dlm_rsb_toss_timer(struct timer_list *timer)
+{
+	struct dlm_ls *ls = from_timer(ls, timer, ls_timer);
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *r;
+	int rv;
+
+	while (1) {
+		/* interrupting point to leave iteration when
+		 * recovery waits for timer_delete_sync(), recovery
+		 * will take care to delete everything in toss queue.
+		 */
+		if (dlm_locking_stopped(ls))
+			break;
+
+		rv = spin_trylock(&ls->ls_toss_q_lock);
+		if (!rv) {
+			/* rearm again try timer */
+			__rsb_mod_timer(ls, DLM_TOSS_TIMER_RETRY);
+			break;
+		}
+
+		r = list_first_entry_or_null(&ls->ls_toss_q, struct dlm_rsb,
+					     res_toss_q_list);
+		if (!r) {
+			/* nothing to do anymore next rsb queue will
+			 * set next mod_timer() expire.
+			 */
+			spin_unlock(&ls->ls_toss_q_lock);
+			break;
+		}
+
+		/* test if the first rsb isn't expired yet, if
+		 * so we stop freeing rsb from toss queue as
+		 * the order in queue is ascending to the
+		 * absolute res_toss_time jiffies
+		 */
+		if (time_before(jiffies, r->res_toss_time)) {
+			/* rearm with the next rsb to expire in the future */
+			__rsb_mod_timer(ls, r->res_toss_time);
+			spin_unlock(&ls->ls_toss_q_lock);
+			break;
+		}
+
+		/* in find_rsb_dir/nodir there is a reverse order of this
+		 * lock, however this is only a trylock if we hit some
+		 * possible contention we try it again.
+		 *
+		 * This lock synchronized while holding ls_toss_q_lock
+		 * synchronize everything that rsb_delete_toss_timer()
+		 * or rsb_mod_timer() can't run after this timer callback
+		 * deletes the rsb from the ls_toss_q. Whereas the other
+		 * holders have always a priority to run as this is only
+		 * a caching handling and the other holders might to put
+		 * this rsb out of the toss state.
+		 */
+		rv = spin_trylock(&ls->ls_rsbtbl_lock);
+		if (!rv) {
+			spin_unlock(&ls->ls_toss_q_lock);
+			/* rearm again try timer */
+			__rsb_mod_timer(ls, DLM_TOSS_TIMER_RETRY);
+			break;
+		}
+
+		list_del(&r->res_rsbs_list);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
+
+		/* not necessary to held the ls_rsbtbl_lock when
+		 * calling send_remove()
+		 */
+		spin_unlock(&ls->ls_rsbtbl_lock);
+
+		/* remove the rsb out of the toss queue its gone
+		 * drom DLM now
+		 */
+		list_del_init(&r->res_toss_q_list);
+		spin_unlock(&ls->ls_toss_q_lock);
+
+		/* no rsb in this state should ever run a timer */
+		WARN_ON(!dlm_no_directory(ls) &&
+			(r->res_master_nodeid != our_nodeid) &&
+			(dlm_dir_nodeid(r) == our_nodeid));
+
+		/* We're the master of this rsb but we're not
+		 * the directory record, so we need to tell the
+		 * dir node to remove the dir record
+		 */
+		if (!dlm_no_directory(ls) &&
+		    (r->res_master_nodeid == our_nodeid) &&
+		    (dlm_dir_nodeid(r) != our_nodeid))
+			send_remove(r);
+
+		free_toss_rsb(r);
+	}
+}
+
 /* If ls->ls_new_rsb is empty, return -EAGAIN, so the caller can
    unlock any spinlocks, go back and call pre_rsb_struct again.
    Otherwise, take an rsb off the list and return it. */
@@ -451,6 +679,7 @@ static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 	INIT_LIST_HEAD(&r->res_convertqueue);
 	INIT_LIST_HEAD(&r->res_waitqueue);
 	INIT_LIST_HEAD(&r->res_root_list);
+	INIT_LIST_HEAD(&r->res_toss_q_list);
 	INIT_LIST_HEAD(&r->res_recover_list);
 	INIT_LIST_HEAD(&r->res_masters_list);
 
@@ -638,6 +867,9 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 	 * valid for keep state rsbs
 	 */
 	kref_init(&r->res_ref);
+	rsb_delete_toss_timer(ls, r);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+
 	goto out_unlock;
 
 
@@ -777,6 +1009,9 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 * valid for keep state rsbs
 	 */
 	kref_init(&r->res_ref);
+	rsb_delete_toss_timer(ls, r);
+	spin_unlock_bh(&ls->ls_rsbtbl_lock);
+
 	goto out_unlock;
 
 
@@ -1050,7 +1285,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
 			    r_nodeid, result);
 
-	r->res_toss_time = jiffies;
+	rsb_mod_timer(ls, r);
 	/* the rsb was inactive (on toss list) */
 	spin_unlock_bh(&ls->ls_rsbtbl_lock);
 
@@ -1070,7 +1305,6 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	r->res_master_nodeid = from_nodeid;
 	r->res_nodeid = from_nodeid;
 	kref_init(&r->res_ref);
-	r->res_toss_time = jiffies;
 	rsb_set_flag(r, RSB_TOSS);
 
 	error = rsb_insert(r, &ls->ls_rsbtbl);
@@ -1082,6 +1316,7 @@ int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 	}
 
 	list_add(&r->res_rsbs_list, &ls->ls_toss);
+	rsb_mod_timer(ls, r);
 
 	if (result)
 		*result = DLM_LU_ADD;
@@ -1126,8 +1361,8 @@ static void toss_rsb(struct kref *kref)
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
@@ -1150,15 +1385,12 @@ void free_toss_rsb(struct dlm_rsb *r)
 {
 	WARN_ON_ONCE(!rsb_flag(r, RSB_TOSS));
 
-	/* check if all work is done after the rsb is on toss list
-	 * and it can be freed.
-	 */
-
 	DLM_ASSERT(list_empty(&r->res_lookup), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_grantqueue), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_convertqueue), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_waitqueue), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_root_list), dlm_dump_rsb(r););
+	DLM_ASSERT(list_empty(&r->res_toss_q_list), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_recover_list), dlm_dump_rsb(r););
 	DLM_ASSERT(list_empty(&r->res_masters_list), dlm_dump_rsb(r););
 
@@ -1572,140 +1804,6 @@ static int remove_from_waiters_ms(struct dlm_lkb *lkb,
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
diff --git a/fs/dlm/lock.h b/fs/dlm/lock.h
index b56a34802762..8de9dee4c058 100644
--- a/fs/dlm/lock.h
+++ b/fs/dlm/lock.h
@@ -11,6 +11,7 @@
 #ifndef __LOCK_DOT_H__
 #define __LOCK_DOT_H__
 
+void dlm_rsb_toss_timer(struct timer_list *timer);
 void dlm_dump_rsb(struct dlm_rsb *r);
 void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len);
 void dlm_print_lkb(struct dlm_lkb *lkb);
@@ -26,6 +27,7 @@ void dlm_scan_rsbs(struct dlm_ls *ls);
 int dlm_lock_recovery_try(struct dlm_ls *ls);
 void dlm_lock_recovery(struct dlm_ls *ls);
 void dlm_unlock_recovery(struct dlm_ls *ls);
+void dlm_timer_resume(struct dlm_ls *ls);
 
 int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
 		      int len, unsigned int flags, int *r_nodeid, int *result);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 890e1a4cf787..931eb3f22ec6 100644
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
 
@@ -582,6 +502,11 @@ static int new_lockspace(const char *name, const char *cluster,
 	INIT_LIST_HEAD(&ls->ls_dir_dump_list);
 	rwlock_init(&ls->ls_dir_dump_lock);
 
+	INIT_LIST_HEAD(&ls->ls_toss_q);
+	spin_lock_init(&ls->ls_toss_q_lock);
+	timer_setup(&ls->ls_timer, dlm_rsb_toss_timer,
+		    TIMER_DEFERRABLE);
+
 	spin_lock_bh(&lslist_lock);
 	ls->ls_create_count = 1;
 	list_add(&ls->ls_list, &lslist);
@@ -661,9 +586,6 @@ static int new_lockspace(const char *name, const char *cluster,
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
- out_rsbtbl:
-	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
-		kfree(ls->ls_remove_names[i]);
 	rhashtable_destroy(&ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)
@@ -696,7 +618,6 @@ static int __dlm_new_lockspace(const char *name, const char *cluster,
 	if (error > 0)
 		error = 0;
 	if (!ls_count) {
-		dlm_scand_stop();
 		dlm_midcomms_shutdown();
 		dlm_midcomms_stop();
 	}
@@ -777,7 +698,7 @@ static void rhash_free_rsb(void *ptr, void *arg)
 static int release_lockspace(struct dlm_ls *ls, int force)
 {
 	struct dlm_rsb *rsb;
-	int i, busy, rv;
+	int busy, rv;
 
 	busy = lockspace_busy(ls, force);
 
@@ -812,8 +733,13 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_recoverd_stop(ls);
 
+	/* clear the LSFL_RUNNING flag to fast up
+	 * time_shutdown_sync(), we don't care anymore
+	 */
+	clear_bit(LSFL_RUNNING, &ls->ls_flags);
+	timer_shutdown_sync(&ls->ls_timer);
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
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 6401916a97ef..c46e306f2e5c 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -641,6 +641,8 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	spin_lock_bh(&ls->ls_recover_lock);
 	set_bit(LSFL_RECOVER_STOP, &ls->ls_flags);
 	new = test_and_clear_bit(LSFL_RUNNING, &ls->ls_flags);
+	if (new)
+		timer_delete_sync(&ls->ls_timer);
 	ls->ls_recover_seq++;
 
 	/* activate requestqueue and stop processing */
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index d43189532b14..960a14b95605 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -889,6 +889,11 @@ void dlm_clear_toss(struct dlm_ls *ls)
 		list_del(&r->res_rsbs_list);
 		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
 				       dlm_rhash_rsb_params);
+
+		/* remove it from the toss queue if its part of it */
+		if (!list_empty(&r->res_toss_q_list))
+			list_del_init(&r->res_toss_q_list);
+
 		free_toss_rsb(r);
 		count++;
 	}
diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 5e8e10030b74..c831e0275912 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -98,6 +98,16 @@ static int enable_locking(struct dlm_ls *ls, uint64_t seq)
 	spin_lock_bh(&ls->ls_recover_lock);
 	if (ls->ls_recover_seq == seq) {
 		set_bit(LSFL_RUNNING, &ls->ls_flags);
+		/* Schedule next timer if recovery put something on toss.
+		 *
+		 * The rsbs that was queued while recovery on toss hasn't
+		 * started yet because LSFL_RUNNING was set everything
+		 * else recovery hasn't started as well because ls_in_recovery
+		 * is still hold. So we should not run into the case that
+		 * dlm_timer_resume() queues a timer that can occur in
+		 * a no op.
+		 */
+		dlm_timer_resume(ls);
 		/* unblocks processes waiting to enter the dlm */
 		up_write(&ls->ls_in_recovery);
 		clear_bit(LSFL_RECOVER_LOCK, &ls->ls_flags);
-- 
2.43.0

