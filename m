Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD8620
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3yS1xYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azo0jMY9i80gHBrdO9P86VDRqJ4dXEG+WFPl60sryrQ=;
	b=A3yS1xYNbc/9JTdoZ7xFan/+thIMPAH9mYcHw+KJLGn/2bH2jYcyvRfP9DKI3ktD2+IjLA
	1KRy2aaEKLlWmlyvd/9oaNeNJZVGaO0L1pa6hx4wak9RQNuwfqQCC1h3K0bHAxnXJga7km
	5qufwU3GcmNAq2YMEpeGDlkEnKi6QCk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-0HGoyfX_O8uh20atpV0pvA-1; Tue,
 24 Oct 2023 20:53:59 -0400
X-MC-Unique: 0HGoyfX_O8uh20atpV0pvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A9E72824764
	for <gfs2@lists.linux.dev>; Wed, 25 Oct 2023 00:53:59 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.rdu2.eng.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0324940C6F7B;
	Wed, 25 Oct 2023 00:53:59 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 10/10] dlm: do dlm message processing in softirq context
Date: Tue, 24 Oct 2023 20:53:53 -0400
Message-Id: <20231025005353.855904-10-aahringo@redhat.com>
In-Reply-To: <20231025005353.855904-1-aahringo@redhat.com>
References: <20231025005353.855904-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

1. Bringing the ast/callback callback to softirq context that the use is
   aware it should not block into this context. Later patches will
   introduce a per lockspace flag to signal that the user is capable to
   handling these callbacks in softirq context to solve backwards
   compatibility.

2. We can easily switch to a per dlm instance concurrent dlm message
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
index 28dd74aebc84..b9de8d5b61b7 100644
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
2.39.3

