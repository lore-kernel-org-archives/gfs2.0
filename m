Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FB12E4D
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998566; cv=none; b=CG3fQxPr1SHbtC/X2JRVGE/3XLZytOKDxB1Vv8Ckxxd25m96lxmarm0FKVxdbEvzcVcSD8e+/iTDYixL7Td+U9v66DXWsPNh2gQoGUnyzUO7R3HjXraz4OiZhKGyYVHeHkVLiyWY9oQsSTN2pE/35G4ofLbtczd6KXoywNCdbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998566; c=relaxed/simple;
	bh=YM0PDYUEA3GO9yQ98pKiZagO1u/NdOjBXUBfNA6vjU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtqDRC/zzrK9kNJWEGbcwOgVZrsl47cZZvQCsfmvq8RzE2ScIxUPd07WTidlMKgEnG7d+hWLmkwOVdVnFzFYn+LNdI/T3FhKMHrHEy4FOsC3Kt+gYQLTuAw66Gwq4GIRmqJ+SHI7NPTCzBJnLrm5VdHrEujoGQI7oA/L5e3Y1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjzYxy4e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjzYxy4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hjRzJzxEJ2wk6mtwi8td9kMsnLBZLVCazSNVcRICco=;
	b=RjzYxy4e7lp5SfCT9yYkPaN8pnksUpoSqlivcbGblPEo6DR6JwPR1lAFp1/QAshWOwYMzE
	dKb+9s036/iYUHiYxCtssozslGV2hdE4wNEZ43ezTI207ctS70ZgkNgO7w839drp7rj9T+
	17ksSU7HQqLOmgWNqa5xuERmqX12ahg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-5366TsBiOruSNy4etvO2uQ-1; Mon, 26 Feb 2024 20:49:19 -0500
X-MC-Unique: 5366TsBiOruSNy4etvO2uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95510108C069
	for <gfs2@lists.linux.dev>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C8702166AF8;
	Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv3 v6.8-rc6 18/18] dlm: do dlm message processing in softirq context
Date: Mon, 26 Feb 2024 20:49:09 -0500
Message-ID: <20240227014909.93945-19-aahringo@redhat.com>
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

This patch moves the dlm message processing from a ordered workqueue
context to a ordered softirq context. Later we want to call the user
defined ast/bast callbacks directly inside the dlm message processing
context instead of doing an additional context switch to the exisiting
callback workqueue. This should slightly improve the dlm message parsing
behaviour. There are two main reasons why to change to this behaviour:

1.
   Allow fewer scheduling possibilities for dlm message parsing context.
   This should deliver faster DLM user responses to ast/bast callbacks.
   Fewer interrupting of lock requests processing that might trigger a
   new lock request avoids situations that we don't finish lock
   requests. In future the DLM callback workqueue can be disabled by
   a kernel lockspace flag to signal the DLM kernel user is capable
   of exectuing the callbacks in softirq context. If this flag is set,
   the dlm processing gets rid of an additional queue_work() context
   switch that should take more advantage about the new softirq context
   because the last preemption possibility is removed from the message
   processing context.

2. Bringing the ast/callback callback to softirq context that the use is
   aware it should not block into this context. Later patches will
   introduce a per lockspace flag to signal that the user is capable to
   handling these callbacks in softirq context to solve backwards
   compatibility.

3. We can easily switch to a per dlm instance concurrent dlm message
   parsing when DLM is ready to handle it. This instance could be in
   e.g. per lockspace instance or more fine granulatiry instance such as
   per lock instance.

Futher patches will unveil more improvements to switch to a per message
softirq parsing context. Especially if we getting DLM in a state that we
can allow concurrent message parsing.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 444dc858c4a4..303d2837f68b 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -183,7 +183,6 @@ static int dlm_local_count;
 
 /* Work queues */
 static struct workqueue_struct *io_workqueue;
-static struct workqueue_struct *process_workqueue;
 
 static struct hlist_head connection_hash[CONN_HASH_SIZE];
 static DEFINE_SPINLOCK(connections_lock);
@@ -199,9 +198,9 @@ static const struct dlm_proto_ops *dlm_proto_ops;
 
 static void process_recv_sockets(struct work_struct *work);
 static void process_send_sockets(struct work_struct *work);
-static void process_dlm_messages(struct work_struct *work);
+static void process_dlm_messages(struct tasklet_struct *tasklet);
 
-static DECLARE_WORK(process_work, process_dlm_messages);
+static DECLARE_TASKLET_DISABLED(process_tasklet, process_dlm_messages);
 static DEFINE_SPINLOCK(processqueue_lock);
 static bool process_dlm_messages_pending;
 static atomic_t processqueue_count;
@@ -863,7 +862,7 @@ struct dlm_processed_nodes {
 	struct list_head list;
 };
 
-static void process_dlm_messages(struct work_struct *work)
+static void process_dlm_messages(struct tasklet_struct *tasklet)
 {
 	struct processqueue_entry *pentry;
 
@@ -971,7 +970,7 @@ static int receive_from_sock(struct connection *con, int buflen)
 	list_add_tail(&pentry->list, &processqueue);
 	if (!process_dlm_messages_pending) {
 		process_dlm_messages_pending = true;
-		queue_work(process_workqueue, &process_work);
+		tasklet_schedule(&process_tasklet);
 	}
 	spin_unlock_bh(&processqueue_lock);
 
@@ -1511,7 +1510,8 @@ static void process_recv_sockets(struct work_struct *work)
 		/* CF_RECV_PENDING cleared */
 		break;
 	case DLM_IO_FLUSH:
-		flush_workqueue(process_workqueue);
+		tasklet_disable(&process_tasklet);
+		tasklet_enable(&process_tasklet);
 		fallthrough;
 	case DLM_IO_RESCHED:
 		cond_resched();
@@ -1686,10 +1686,7 @@ static void work_stop(void)
 		io_workqueue = NULL;
 	}
 
-	if (process_workqueue) {
-		destroy_workqueue(process_workqueue);
-		process_workqueue = NULL;
-	}
+	tasklet_disable(&process_tasklet);
 }
 
 static int work_start(void)
@@ -1701,17 +1698,7 @@ static int work_start(void)
 		return -ENOMEM;
 	}
 
-	/* ordered dlm message process queue,
-	 * should be converted to a tasklet
-	 */
-	process_workqueue = alloc_ordered_workqueue("dlm_process",
-						    WQ_HIGHPRI | WQ_MEM_RECLAIM);
-	if (!process_workqueue) {
-		log_print("can't start dlm_process");
-		destroy_workqueue(io_workqueue);
-		io_workqueue = NULL;
-		return -ENOMEM;
-	}
+	tasklet_enable(&process_tasklet);
 
 	return 0;
 }
@@ -1734,7 +1721,10 @@ void dlm_lowcomms_shutdown(void)
 		hlist_for_each_entry_rcu(con, &connection_hash[i], list) {
 			shutdown_connection(con, true);
 			stop_connection_io(con);
-			flush_workqueue(process_workqueue);
+
+			tasklet_disable(&process_tasklet);
+			tasklet_enable(&process_tasklet);
+
 			close_connection(con, true);
 
 			clean_one_writequeue(con);
-- 
2.43.0

