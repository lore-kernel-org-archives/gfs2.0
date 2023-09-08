Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD130F8E
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEF02d4zB53e62iD4kCNtakB8gJGVlVhn0ne2B8vNYc=;
	b=cPZVb+s4k73T+BDqtXogSkoxHfcEtPKbNNkC8t53bAfeA7Vc4qKQaG5niTFgiZOnLO/ByC
	89ZNYosMj8VDi2HYjuzl/rouAHv+lWbYdwGzGVkqRtxL2oKJ34CngbJ+7GHywCvqDg8ldS
	m218lPF8CcOsAqbsQR1FhXm5vL/DJ88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-uuHjCtQtMzq9XIZF3CCefA-1; Fri, 08 Sep 2023 16:46:23 -0400
X-MC-Unique: uuHjCtQtMzq9XIZF3CCefA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 824EE856DED
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59C3120BAE72;
	Fri,  8 Sep 2023 20:46:23 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 06/10] fs: dlm: make requestqueue handling non sleepable
Date: Fri,  8 Sep 2023 16:46:07 -0400
Message-Id: <20230908204611.1910601-6-aahringo@redhat.com>
In-Reply-To: <20230908204611.1910601-1-aahringo@redhat.com>
References: <20230908204611.1910601-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch removes the ls_requestqueue_wait and convert the
ls_requestqueue_mutex to a rw lock. Instead of calling wait_event() in
dlm processing which waits until all messages are processed and allow
new message processing after recovering is done, this patch is using a
bitflag to signal when a message should be saved for future or not. When
recovery processes all saved messages we will clear this bit again and
allow new messages to processed directly.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  5 ++---
 fs/dlm/lock.c         | 16 ++++++++++++++--
 fs/dlm/lockspace.c    |  4 +---
 fs/dlm/member.c       |  5 +++++
 fs/dlm/requestqueue.c | 39 ++++++---------------------------------
 5 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 383b26144a31..65db6f834f04 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -624,9 +624,7 @@ struct dlm_ls {
 	struct rw_semaphore	ls_in_recovery;	/* block local requests */
 	struct rw_semaphore	ls_recv_active;	/* block dlm_recv */
 	struct list_head	ls_requestqueue;/* queue remote requests */
-	atomic_t		ls_requestqueue_cnt;
-	wait_queue_head_t	ls_requestqueue_wait;
-	struct mutex		ls_requestqueue_mutex;
+	rwlock_t		ls_requestqueue_lock;
 	struct dlm_rcom		*ls_recover_buf;
 	int			ls_recover_nodeid; /* for debugging */
 	unsigned int		ls_recover_dir_sent_res; /* for log info */
@@ -686,6 +684,7 @@ struct dlm_ls {
 #define LSFL_UEVENT_WAIT	7
 #define LSFL_CB_DELAY		9
 #define LSFL_NODIR		10
+#define LSFL_RECV_MSG_BLOCKED	11
 
 /* much of this is just saving user space pointers associated with the
    lock that we pass back to the user lib with an ast */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3d17f4d6b765..989603643c03 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4746,20 +4746,32 @@ static void _receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
 static void dlm_receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
 				int nodeid)
 {
-	if (dlm_locking_stopped(ls)) {
+try_again:
+	read_lock(&ls->ls_requestqueue_lock);
+	if (test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
 		/* If we were a member of this lockspace, left, and rejoined,
 		   other nodes may still be sending us messages from the
 		   lockspace generation before we left. */
 		if (WARN_ON_ONCE(!ls->ls_generation)) {
+			read_unlock(&ls->ls_requestqueue_lock);
 			log_limit(ls, "receive %d from %d ignore old gen",
 				  le32_to_cpu(ms->m_type), nodeid);
 			return;
 		}
 
+		read_unlock(&ls->ls_requestqueue_lock);
+		write_lock(&ls->ls_requestqueue_lock);
+		/* recheck because we hold writelock now */
+		if (!test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
+			write_unlock_bh(&ls->ls_requestqueue_lock);
+			goto try_again;
+		}
+
 		dlm_add_requestqueue(ls, nodeid, ms);
+		write_unlock(&ls->ls_requestqueue_lock);
 	} else {
-		dlm_wait_requestqueue(ls);
 		_receive_message(ls, ms, 0);
+		read_unlock(&ls->ls_requestqueue_lock);
 	}
 }
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 79dd516bde5f..b2cb0621031f 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -554,9 +554,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	init_rwsem(&ls->ls_in_recovery);
 	init_rwsem(&ls->ls_recv_active);
 	INIT_LIST_HEAD(&ls->ls_requestqueue);
-	atomic_set(&ls->ls_requestqueue_cnt, 0);
-	init_waitqueue_head(&ls->ls_requestqueue_wait);
-	mutex_init(&ls->ls_requestqueue_mutex);
+	rwlock_init(&ls->ls_requestqueue_lock);
 	spin_lock_init(&ls->ls_clear_proc_locks);
 
 	/* Due backwards compatibility with 3.1 we need to use maximum
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index be7909ead71b..707cebcdc533 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -642,6 +642,11 @@ int dlm_ls_stop(struct dlm_ls *ls)
 	set_bit(LSFL_RECOVER_STOP, &ls->ls_flags);
 	new = test_and_clear_bit(LSFL_RUNNING, &ls->ls_flags);
 	ls->ls_recover_seq++;
+
+	/* activate requestqueue and stop processing */
+	write_lock(&ls->ls_requestqueue_lock);
+	set_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags);
+	write_unlock(&ls->ls_requestqueue_lock);
 	spin_unlock(&ls->ls_recover_lock);
 
 	/*
diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index ef7b7c8d6907..8a57a2d70561 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -48,10 +48,7 @@ void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid,
 	memcpy(&e->request, ms, sizeof(*ms));
 	memcpy(&e->request.m_extra, ms->m_extra, length);
 
-	atomic_inc(&ls->ls_requestqueue_cnt);
-	mutex_lock(&ls->ls_requestqueue_mutex);
 	list_add_tail(&e->list, &ls->ls_requestqueue);
-	mutex_unlock(&ls->ls_requestqueue_mutex);
 }
 
 /*
@@ -71,16 +68,14 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 	struct dlm_message *ms;
 	int error = 0;
 
-	mutex_lock(&ls->ls_requestqueue_mutex);
-
+	write_lock(&ls->ls_requestqueue_lock);
 	for (;;) {
 		if (list_empty(&ls->ls_requestqueue)) {
-			mutex_unlock(&ls->ls_requestqueue_mutex);
+			clear_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags);
 			error = 0;
 			break;
 		}
-		e = list_entry(ls->ls_requestqueue.next, struct rq_entry, list);
-		mutex_unlock(&ls->ls_requestqueue_mutex);
+		e = list_first_entry(&ls->ls_requestqueue, struct rq_entry, list);
 
 		ms = &e->request;
 
@@ -93,40 +88,20 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
 			  e->recover_seq);
 
 		dlm_receive_message_saved(ls, &e->request, e->recover_seq);
-
-		mutex_lock(&ls->ls_requestqueue_mutex);
 		list_del(&e->list);
-		if (atomic_dec_and_test(&ls->ls_requestqueue_cnt))
-			wake_up(&ls->ls_requestqueue_wait);
 		kfree(e);
 
 		if (dlm_locking_stopped(ls)) {
 			log_debug(ls, "process_requestqueue abort running");
-			mutex_unlock(&ls->ls_requestqueue_mutex);
 			error = -EINTR;
 			break;
 		}
 	}
+	write_unlock(&ls->ls_requestqueue_lock);
 
 	return error;
 }
 
-/*
- * After recovery is done, locking is resumed and dlm_recoverd takes all the
- * saved requests and processes them as they would have been by dlm_recv.  At
- * the same time, dlm_recv will start receiving new requests from remote nodes.
- * We want to delay dlm_recv processing new requests until dlm_recoverd has
- * finished processing the old saved requests.  We don't check for locking
- * stopped here because dlm_ls_stop won't stop locking until it's suspended us
- * (dlm_recv).
- */
-
-void dlm_wait_requestqueue(struct dlm_ls *ls)
-{
-	wait_event(ls->ls_requestqueue_wait,
-		   atomic_read(&ls->ls_requestqueue_cnt) == 0);
-}
-
 static int purge_request(struct dlm_ls *ls, struct dlm_message *ms, int nodeid)
 {
 	__le32 type = ms->m_type;
@@ -157,17 +132,15 @@ void dlm_purge_requestqueue(struct dlm_ls *ls)
 	struct dlm_message *ms;
 	struct rq_entry *e, *safe;
 
-	mutex_lock(&ls->ls_requestqueue_mutex);
+	write_lock(&ls->ls_requestqueue_lock);
 	list_for_each_entry_safe(e, safe, &ls->ls_requestqueue, list) {
 		ms =  &e->request;
 
 		if (purge_request(ls, ms, e->nodeid)) {
 			list_del(&e->list);
-			if (atomic_dec_and_test(&ls->ls_requestqueue_cnt))
-				wake_up(&ls->ls_requestqueue_wait);
 			kfree(e);
 		}
 	}
-	mutex_unlock(&ls->ls_requestqueue_mutex);
+	write_unlock(&ls->ls_requestqueue_lock);
 }
 
-- 
2.31.1

