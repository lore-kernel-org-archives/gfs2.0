Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4214F78
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998564; cv=none; b=Yl8SSXk131WK4SbF7FyQTy7QYJ9y1u5IhpO2Ob6xjOYPNg7027ri8Bf1IrZA6HNSgx79ngFLvpPkEX7fIFBPbTSe3G4ZubPStLz5BDlDu/jfLubN5Ke9DM1WOfw6GUFua4O0EyIaH3LaPWAk6UE9GBPQZsE7PzcOL/+6TfSWnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998564; c=relaxed/simple;
	bh=N7ab6x8fum7CaAYD2aWdOfw+6FjhM0DtD/VHd24PAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6RIkTRzJ8uUmlrx8woAHfojF+j+K6WYlGXEfnu4zLaxsPxMTz7MbblxGVWJUfqVK4HtKxH9McMTMmXvkuVRPSjFCAFsj43h2DE/xX/Ybg1rh81pOuox6xTY/+e/PB5/AyKlKT73FzVjjwS1IDlHyp0mh0wdlm+YjWDm2sMhI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbbdYBXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbbdYBXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73ZVlNyHBo8gy7vjcvbH56F5zAGTQV9p32FgIrdTcSo=;
	b=UbbdYBXptbD5gdbYWkKM+PmTFWK1cRux4H/z7SE5ceLZBUeuPxPUybIXghMv+4FRHqEH/t
	NW1/aCjOAev7PueE1u3uevM9sbFg8XolOEoTPWSLX2gZdKctnEWrwjf7Ms4EgIZtFE6gSJ
	oRILtKJTBjFlvmXmQkfODWFFdc47CM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-N5xNEH42NxOuHwZuAMyoaA-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: N5xNEH42NxOuHwZuAMyoaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BDCF85A597
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 629922166B5E;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 14/18] dlm: make requestqueue handling non sleepable
Date: Mon, 26 Feb 2024 20:49:05 -0500
Message-ID: <20240227014909.93945-15-aahringo@redhat.com>
In-Reply-To: <20240227014909.93945-1-aahringo@redhat.com>
References: <20240227014909.93945-1-aahringo@redhat.com>
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
 fs/dlm/requestqueue.c | 41 ++++++++---------------------------------
 5 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 13225b28fa98..4cb1f38067d3 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -625,9 +625,7 @@ struct dlm_ls {
 	struct rw_semaphore	ls_in_recovery;	/* block local requests */
 	struct rw_semaphore	ls_recv_active;	/* block dlm_recv */
 	struct list_head	ls_requestqueue;/* queue remote requests */
-	atomic_t		ls_requestqueue_cnt;
-	wait_queue_head_t	ls_requestqueue_wait;
-	struct mutex		ls_requestqueue_mutex;
+	rwlock_t		ls_requestqueue_lock;
 	struct dlm_rcom		*ls_recover_buf;
 	int			ls_recover_nodeid; /* for debugging */
 	unsigned int		ls_recover_locks_in; /* for log info */
@@ -687,6 +685,7 @@ struct dlm_ls {
 #define LSFL_UEVENT_WAIT	7
 #define LSFL_CB_DELAY		9
 #define LSFL_NODIR		10
+#define LSFL_RECV_MSG_BLOCKED	11
 
 /* much of this is just saving user space pointers associated with the
    lock that we pass back to the user lib with an ast */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 267a18bcf2c6..10cebb418931 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4749,20 +4749,32 @@ static void _receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
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
index 42866190af38..0df0f07fa092 100644
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
index c05940afd063..9b646026df46 100644
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
 
@@ -93,41 +88,23 @@ int dlm_process_requestqueue(struct dlm_ls *ls)
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
+		write_unlock(&ls->ls_requestqueue_lock);
 		schedule();
+		write_lock(&ls->ls_requestqueue_lock);
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
@@ -158,17 +135,15 @@ void dlm_purge_requestqueue(struct dlm_ls *ls)
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
2.43.0

