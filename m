Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2232B640
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694205986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8i20XpPtsujogswA6tCQeWhaFPbqbVSlf/77e4AtQNE=;
	b=XhtQBqBhsog5fJG9ZGFMZw/znKKvvCE4uK9ryntzCMRpMNcaY4rSA+B+07xws5PfuJuHeo
	5t9eBrg6uwmHLjecQ7B7GZGxR/TOsVq/ksZ2SmeBsIbASS0OAqtof50Qmkco1fjNB67DF5
	bcL2y6H6qJxUkw9QWDygMyOUXdlPpMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-l7lM2WDpNZqXTnnNAfPpNg-1; Fri, 08 Sep 2023 16:46:25 -0400
X-MC-Unique: l7lM2WDpNZqXTnnNAfPpNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57F22800969
	for <gfs2@lists.linux.dev>; Fri,  8 Sep 2023 20:46:24 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB0C21EE56C;
	Fri,  8 Sep 2023 20:46:24 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: cluster-devel@redhat.com,
	gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [RFC dlm/next 10/10] fs: dlm: do dlm message processing in softirq context
Date: Fri,  8 Sep 2023 16:46:11 -0400
Message-Id: <20230908204611.1910601-10-aahringo@redhat.com>
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

This patch change the dlm message parsing context from a workqueue to
a softirq context. This will hopefully speed up our dlm message
processing by removing a bunch of implicit scheduling points such a
cond_reched() depends on the preemption model setting. A softirq
(except PREEMPT_RT) can only be interrupted by other softirqs or
higher prio context such as hardware interrupts.

This patch will only move the dlm message parsing to the right context,
there exists more ideas to improve message parsing like using lockless
locking when doing read access on datastructures or enable a parallel
per node message processing. Further patches will improve those
behaviors. For now this patch will reduce the amount of interruptions
when doing DLM message parsing.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 28dd74aebc84..93f7e8827201 100644
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
+static DECLARE_TASKLET(process_tasklet, process_dlm_messages);
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
@@ -1685,11 +1685,6 @@ static void work_stop(void)
 		destroy_workqueue(io_workqueue);
 		io_workqueue = NULL;
 	}
-
-	if (process_workqueue) {
-		destroy_workqueue(process_workqueue);
-		process_workqueue = NULL;
-	}
 }
 
 static int work_start(void)
@@ -1701,18 +1696,6 @@ static int work_start(void)
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
-
 	return 0;
 }
 
@@ -1734,7 +1717,10 @@ void dlm_lowcomms_shutdown(void)
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
2.31.1

