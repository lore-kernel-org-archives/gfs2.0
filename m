Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469C15B579
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085503; cv=none; b=c+lOffV0D6M5XG1ULdd67Os17exRpu+l3BldDv6wwEFBoZC1oAYK0DwbRTcxa4GgmDNKFxOaJTVKWOdrs8UNeBXmr9RvpZQfWKj+dS+PP9QPxpat7ytiKyXJRZp9F8kf4Qx6nSFyEYmLKJPWQQLpJNGPpb+2abLsu2TzGUrKc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085503; c=relaxed/simple;
	bh=qI9zbi96jtKmzrRkY02OGQa1Mooj7/dk40ELjOK/8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9/5u9bTz1TA2aD2RPCJq0MJ84R9Tf3kbHAK8cvEdVWXme+TXzNh5mHhLTvZM6DqizzVlRP/NJHRPEvwYWL20CYsHdxqnnw6J3FNC8R4RJd+ADx5V4lPuR8DBQ3op+LTeOVwlEaId2bMpTckwYvn4CnffxqK5ajmNdD2f/ewdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFnQ7ZsU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFnQ7ZsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712085500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8qYFAK8L8MWcTt8WEY6WfEz3rXw4uL2fue0gA5TVYY=;
	b=YFnQ7ZsUGtBp8ohPN5+Qf+rm4PEneyQ3rf2/q7CuuB8/OLSNIgrDlHbUZWGPeAw/2tDsWo
	LJxVwdihMnCdd1mTirCqSLKbvSRBIAK5/bfAOHDlSKmDRgLG+XqlKLwAUyJp/WadzdrogF
	NZQ67Oia2CMmCc1l04KZUH3UOG01c0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-14VFbDIMOsaq_l-Q3lg8hQ-1; Tue,
 02 Apr 2024 15:18:19 -0400
X-MC-Unique: 14VFbDIMOsaq_l-Q3lg8hQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF1143816453
	for <gfs2@lists.linux.dev>; Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5CA040C6CC5;
	Tue,  2 Apr 2024 19:18:18 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv4 dlm/next 15/15] dlm: do dlm message processing in softirq context
Date: Tue,  2 Apr 2024 15:18:10 -0400
Message-ID: <20240402191810.1932939-16-aahringo@redhat.com>
In-Reply-To: <20240402191810.1932939-1-aahringo@redhat.com>
References: <20240402191810.1932939-1-aahringo@redhat.com>
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
   compatibility. Handling the callback in the receive part and not in a
   workqueue will reduce a unnecessarily context switch. Signaling the
   user that the callback context can run in a softirq context will
   force that the user of DLM will not sleep in such context and leave
   it "fast as possible" again.

Futher patches will unveil more improvements to switch to a per message
softirq parsing context. Especially if we getting DLM in a state that we
can allow concurrent message parsing.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 444dc858c4a4..6b8078085e56 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -204,6 +204,7 @@ static void process_dlm_messages(struct work_struct *work);
 static DECLARE_WORK(process_work, process_dlm_messages);
 static DEFINE_SPINLOCK(processqueue_lock);
 static bool process_dlm_messages_pending;
+static DECLARE_WAIT_QUEUE_HEAD(processqueue_wq);
 static atomic_t processqueue_count;
 static LIST_HEAD(processqueue);
 
@@ -877,7 +878,8 @@ static void process_dlm_messages(struct work_struct *work)
 	}
 
 	list_del(&pentry->list);
-	atomic_dec(&processqueue_count);
+	if (atomic_dec_and_test(&processqueue_count))
+		wake_up(&processqueue_wq);
 	spin_unlock_bh(&processqueue_lock);
 
 	for (;;) {
@@ -895,7 +897,8 @@ static void process_dlm_messages(struct work_struct *work)
 		}
 
 		list_del(&pentry->list);
-		atomic_dec(&processqueue_count);
+		if (atomic_dec_and_test(&processqueue_count))
+			wake_up(&processqueue_wq);
 		spin_unlock_bh(&processqueue_lock);
 	}
 }
@@ -1511,7 +1514,20 @@ static void process_recv_sockets(struct work_struct *work)
 		/* CF_RECV_PENDING cleared */
 		break;
 	case DLM_IO_FLUSH:
-		flush_workqueue(process_workqueue);
+		/* we can't flush the process_workqueue here because a
+		 * WQ_MEM_RECLAIM workequeue can occurr a deadlock for a non
+		 * WQ_MEM_RECLAIM workqueue such as process_workqueue. Instead
+		 * we have a waitqueue to wait until all messages are
+		 * processed.
+		 *
+		 * This handling is only necessary to backoff the sender and
+		 * not queue all messages from the socket layer into DLM
+		 * processqueue. When DLM is capable to parse multiple messages
+		 * on an e.g. per socket basis this handling can might be
+		 * removed. Especially in a message burst we are too slow to
+		 * process messages and the queue will fill up memory.
+		 */
+		wait_event(processqueue_wq, !atomic_read(&processqueue_count));
 		fallthrough;
 	case DLM_IO_RESCHED:
 		cond_resched();
@@ -1701,11 +1717,7 @@ static int work_start(void)
 		return -ENOMEM;
 	}
 
-	/* ordered dlm message process queue,
-	 * should be converted to a tasklet
-	 */
-	process_workqueue = alloc_ordered_workqueue("dlm_process",
-						    WQ_HIGHPRI | WQ_MEM_RECLAIM);
+	process_workqueue = alloc_workqueue("dlm_process", WQ_HIGHPRI | WQ_BH, 0);
 	if (!process_workqueue) {
 		log_print("can't start dlm_process");
 		destroy_workqueue(io_workqueue);
-- 
2.43.0

