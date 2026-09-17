Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666F386423
	for <gfs2@lists.linux.dev>; Thu, 17 Sep 2026 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628650; cv=none; b=nGsObnkjdDqETeEJVrN7H1j35ci2CxXxGOiHKFnYr68pTKUM/q5dpZ+vQg9X5C1E8m32Gd/4R7GPLpMw4Pr4PAg1fM4szWe5Ag/dW1IN7F8d+M/Zlpy6tZX0xgfZZusLWY/gbOYvM9ZpqH8bp/wf6lPO+uffGytWfFeg4r21QT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628650; c=relaxed/simple;
	bh=2Ly2/LRWkXMfU2MkgbguEmD+iSooGMDycTXP6N5rssE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RZhrG9n9MZQcRY5uuwGOu1cRKwZFUs+V7o1KodfjskbNWJi3gFUCu+64NxqioBWgH9qPW5DJA89UYeP0wIicV68xtqzD2+XPFuNz+7/oTIIeQpaf7ZLkAq6XM7ZnQ5RpqHTXfVI3vJ7f+pxswbHxtZe/VrRueJRA3UZXpJ6DNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NhVRC16O; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NhVRC16O"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RHsYtgG1oTWQr/Y5bXDIKrjDghtGdjie9uWX/nKOhUw=;
	b=NhVRC16Ob66hjWPUNWtgIvZRRrqFVzuR/GYWthKuBCytUowRE2ObcycKkLR5/f1wcIhLhzjPD
	sGB8hlW3j7wMqgOLHPpNMj6w2U8KoJfGMtHRKAJ/TWCucWro5sGzD+ELbU7gd60mZjmFkvt+nSb
	ntJRtB2g05ZucF8AxfdpWMc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hlmfY4FPSzmV7C;
	Thu, 17 Sep 2026 14:52:53 +0800 (CST)
Received: from whupemo200002.china.huawei.com (unknown [7.152.184.22])
	by mail.maildlp.com (Postfix) with ESMTPS id 012524055B;
	Thu, 17 Sep 2026 15:03:53 +0800 (CST)
Received: from huawei.com (10.67.174.78) by whupemo200002.china.huawei.com
 (7.152.184.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 15:03:52 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <aahringo@redhat.com>, <teigland@redhat.com>
CC: <gfs2@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>, <yiyang13@huawei.com>
Subject: [PATCH] fs/dlm: fix NULL pointer dereference in __queue_work()
Date: Thu, 17 Sep 2026 06:46:57 +0000
Message-ID: <20260917064657.3260776-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200002.china.huawei.com (7.152.184.22)

The rawmsg debugfs file lives as long as its configfs comm entry and
is independent of the lockspace lifetime, but sending requires the
lowcomms io_workqueue, which only exists between the creation of the
first lockspace and the release of the last one (or a lowcomms start
failure); work_stop() then destroys the workqueues and resets their
pointers to NULL. Writing rawmsg while lowcomms is not running
therefore ends up in queue_work() with a NULL io_workqueue:

  BUG: KASAN: null-ptr-deref in __queue_work+0x27/0xf0
  Read of size 4 at addr 0000000000000100 by task syz.4.3355/21899

Regular sends racing with the last lockspace release have the same
problem, as work_stop() never waits for senders that hold
connections_srcu from dlm_lowcomms_new_msg() until their queue_work()
call.

Track the workqueues with a workqueues_up flag that senders check
inside their connections_srcu read-side critical section, and make
work_stop() clear the flag and call synchronize_srcu() before
destroying the workqueues. This gates all send entry points
(including the socket error retransmission path), while the socket
callback work queueing helpers check the flag as a defence in depth;
the flag is published with release and read with acquire semantics.
The rawmsg write now fails with -ENOTCONN.

Fixes: 9af5b8f0ead7 ("fs: dlm: add debugfs rawmsg send functionality")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 fs/dlm/lowcomms.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 fs/dlm/midcomms.c |  6 ++++++
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7c17de..b327bafc8c5d 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -184,6 +184,13 @@ static int dlm_local_count;
 static struct workqueue_struct *io_workqueue;
 static struct workqueue_struct *process_workqueue;
 
+/* Set while the lowcomms workqueues are up; published with release and
+ * read with acquire semantics. The send path must read it inside a
+ * connections_srcu read-side critical section, see work_stop(); the
+ * socket callbacks only use it as a racy best-effort guard.
+ */
+static atomic_t workqueues_up;
+
 static struct hlist_head connection_hash[CONN_HASH_SIZE];
 static DEFINE_SPINLOCK(connections_lock);
 DEFINE_STATIC_SRCU(connections_srcu);
@@ -216,7 +223,8 @@ static void lowcomms_queue_swork(struct connection *con)
 {
 	assert_spin_locked(&con->writequeue_lock);
 
-	if (!test_bit(CF_IO_STOP, &con->flags) &&
+	if (atomic_read_acquire(&workqueues_up) &&
+	    !test_bit(CF_IO_STOP, &con->flags) &&
 	    !test_bit(CF_APP_LIMITED, &con->flags) &&
 	    !test_and_set_bit(CF_SEND_PENDING, &con->flags))
 		queue_work(io_workqueue, &con->swork);
@@ -228,7 +236,8 @@ static void lowcomms_queue_rwork(struct connection *con)
 	WARN_ON_ONCE(!lockdep_sock_is_held(con->sock->sk));
 #endif
 
-	if (!test_bit(CF_IO_STOP, &con->flags) &&
+	if (atomic_read_acquire(&workqueues_up) &&
+	    !test_bit(CF_IO_STOP, &con->flags) &&
 	    !test_and_set_bit(CF_RECV_PENDING, &con->flags))
 		queue_work(io_workqueue, &con->rwork);
 }
@@ -544,7 +553,8 @@ static void lowcomms_listen_data_ready(struct sock *sk)
 {
 	trace_sk_data_ready(sk);
 
-	queue_work(io_workqueue, &listen_con.rwork);
+	if (atomic_read_acquire(&workqueues_up))
+		queue_work(io_workqueue, &listen_con.rwork);
 }
 
 int dlm_lowcomms_connect_node(int nodeid)
@@ -553,6 +563,13 @@ int dlm_lowcomms_connect_node(int nodeid)
 	int idx;
 
 	idx = srcu_read_lock(&connections_srcu);
+
+	/* queueing send work requires the lowcomms workqueues */
+	if (!atomic_read_acquire(&workqueues_up)) {
+		srcu_read_unlock(&connections_srcu, idx);
+		return -ENOTCONN;
+	}
+
 	con = nodeid2con(nodeid, 0);
 	if (WARN_ON_ONCE(!con)) {
 		srcu_read_unlock(&connections_srcu, idx);
@@ -1275,6 +1292,13 @@ struct dlm_msg *dlm_lowcomms_new_msg(int nodeid, int len, char **ppc,
 	}
 
 	idx = srcu_read_lock(&connections_srcu);
+
+	/* sending requires the lowcomms workqueues, see work_stop() */
+	if (!atomic_read_acquire(&workqueues_up)) {
+		srcu_read_unlock(&connections_srcu, idx);
+		return NULL;
+	}
+
 	con = nodeid2con(nodeid, 0);
 	if (WARN_ON_ONCE(!con)) {
 		srcu_read_unlock(&connections_srcu, idx);
@@ -1336,19 +1360,27 @@ void dlm_lowcomms_put_msg(struct dlm_msg *msg)
 	kref_put(&msg->ref, dlm_msg_release);
 }
 
-/* does not held connections_srcu, usage lowcomms_error_report only */
+/* usage lowcomms_error_report only, may run in softirq context */
 int dlm_lowcomms_resend_msg(struct dlm_msg *msg)
 {
 	struct dlm_msg *msg_resend;
 	char *ppc;
+	int idx;
+
+	idx = srcu_read_lock(&connections_srcu);
 
-	if (msg->retransmit)
+	/* retransmission requires the lowcomms workqueues, see work_stop() */
+	if (!atomic_read_acquire(&workqueues_up) || msg->retransmit) {
+		srcu_read_unlock(&connections_srcu, idx);
 		return 1;
+	}
 
 	msg_resend = dlm_lowcomms_new_msg_con(msg->entry->con, msg->len, &ppc,
 					      NULL, NULL);
-	if (!msg_resend)
+	if (!msg_resend) {
+		srcu_read_unlock(&connections_srcu, idx);
 		return -ENOMEM;
+	}
 
 	msg->retransmit = true;
 	kref_get(&msg->ref);
@@ -1358,6 +1390,7 @@ int dlm_lowcomms_resend_msg(struct dlm_msg *msg)
 	_dlm_lowcomms_commit_msg(msg_resend);
 	dlm_lowcomms_put_msg(msg_resend);
 
+	srcu_read_unlock(&connections_srcu, idx);
 	return 0;
 }
 
@@ -1685,6 +1718,12 @@ static void process_send_sockets(struct work_struct *work)
 
 static void work_stop(void)
 {
+	/* senders check workqueues_up inside connections_srcu, so once
+	 * synchronize_srcu() returns no queue_work() is in flight
+	 */
+	atomic_set_release(&workqueues_up, 0);
+	synchronize_srcu(&connections_srcu);
+
 	if (io_workqueue) {
 		destroy_workqueue(io_workqueue);
 		io_workqueue = NULL;
@@ -1713,6 +1752,7 @@ static int work_start(void)
 		return -ENOMEM;
 	}
 
+	atomic_set_release(&workqueues_up, 1);
 	return 0;
 }
 
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 8964164600d2..8dfac3b04239 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1499,6 +1499,12 @@ int dlm_midcomms_rawmsg_send(struct midcomms_node *node, void *buf,
 	struct dlm_msg *msg;
 	char *msgbuf;
 
+	/* the rawmsg interface is independent of the lockspace lifetime,
+	 * sending requires the lowcomms workqueues to be up
+	 */
+	if (!dlm_lowcomms_is_running())
+		return -ENOTCONN;
+
 	rd.node = node;
 	rd.buf = buf;
 
-- 
2.25.1

