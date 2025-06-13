Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD863595A
	for <gfs2@lists.linux.dev>; Fri, 13 Jun 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849567; cv=none; b=uEctS0ieaGkoTHJj7d/DGNz0fr4bN8a4PiOE5ipA78VaudU6qPIyFbzoQYmZkXCiojT1EM449l8tdwnOiWlbkgqCWsPHH4tkDyTnzcguJjVYse+cwAHQbt8p/v7XaFJ6nAOpFG6O5XTAnGx0yS81jKxA4/nSQs+nwTiQFkdfPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849567; c=relaxed/simple;
	bh=Zs5LfaL6+94qj3IC7QWQDOucAe9zFKUsjLIPTeGEZ20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=fUM1DaF/REWlsyN+NYfG6eZ2SfFFzj7xHWeL8Gr7sbt5AZA+CvFrF3BWDrDomm2RNfqdyLBCx21trdS0nEEy6PoQy/Z5Ytgl9p3SERTM9a6XgNZzM5QDrbMDJAaMe5lL5jKYOgC4W49fz8swEVQPPF/TTP+d/qLCmgiBm9NXWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XF423tpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XF423tpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749849564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDZcwzIFnfKKKCdhn2EckXv4Pt3byKeIhZInVXrYXMg=;
	b=XF423tpicLyVMzlbubHUHoOXXOCZ5tnpjrcAXbj7lhSo8hw9rvOccdVKKn9iOyUYkG3S1V
	OliXlMCM7r4lNpdpqToSUTl87Ohfi5xlCa8FFJop/ok7g6h72cC8QtB0yj7L0hM1ngCHE/
	spW27OCRlnQoly18ybL3lxChZTl43IE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-HkPbAK6GMsC0dOIdO7KQmw-1; Fri,
 13 Jun 2025 17:19:22 -0400
X-MC-Unique: HkPbAK6GMsC0dOIdO7KQmw-1
X-Mimecast-MFC-AGG-ID: HkPbAK6GMsC0dOIdO7KQmw_1749849562
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D45B51800366
	for <gfs2@lists.linux.dev>; Fri, 13 Jun 2025 21:19:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C8031956050;
	Fri, 13 Jun 2025 21:19:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.16-rc1] dlm: if forced set no linger before close
Date: Fri, 13 Jun 2025 17:19:18 -0400
Message-ID: <20250613211918.1302268-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n7sIgREbx0tc3BHZsQ6xOnWHljVvXuh4KY4ZSnBgCM4_1749849562
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

I currently observe an issue where an ETIMEDOUT occurred during a connect
after the same node got fenced before. On the peer side netstat showed
still the previous connection in FIN_WAIT1 state and having something in
the send socket queue. I assume the previous fence did a close by calling
dlm_lowcomms_close() but still had something in the send queue, so it
ended up by doing a graceful shutdown but in this case we know it cannot
succeed as the peer is already gone and lost its transport layer state.
When the fenced node came back and it wants to connect it returned
ETIMEDOUT as the peer it wants to connect still maintained the previous
connection that sits in FIN_WAIT1.

We will call sock_no_linger() if the socket close came from
dlm_lowcomms_close() that is usually called when the cluster manager
removes a node from the cluster e.g. on fencing, all other non hard
closed cases I left the behaviour as it was. This should prevent of
trying a graceful shutdown when something sits in the socket send queue
and discard all messages. In case of a fence this is what we want as DLM
recovery will handle a fenced node.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index e4373bce1bc2..253a1f9bc2e8 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -753,12 +753,13 @@ static void stop_connection_io(struct connection *con)
 }
 
 /* Close a remote connection and tidy up */
-static void close_connection(struct connection *con, bool and_other)
+static void close_connection(struct connection *con, bool and_other,
+			     bool no_linger)
 {
 	struct writequeue_entry *e;
 
 	if (con->othercon && and_other)
-		close_connection(con->othercon, false);
+		close_connection(con->othercon, false, no_linger);
 
 	down_write(&con->sock_lock);
 	if (!con->sock) {
@@ -766,6 +767,24 @@ static void close_connection(struct connection *con, bool and_other)
 		return;
 	}
 
+	/* in cases e.g. of fencing we know the other peer is fenced
+	 * out of the cluster. We assume that in this case the peers
+	 * transport layer state was gone. By default linger is off
+	 * that means the kernel will in background try to make a
+	 * graceful shutdown. We know that this is not possible and
+	 * a fenced node coming back and join a lockspace it could
+	 * run into ETIMEDOUT as a previous connection is still
+	 * maintained until some timeout occurs and the graceful
+	 * shutdown was given up. This timeout can vary regarding to
+	 * different parameters. To avoid the graceful shutdown we
+	 * enable linger and set the linger timeout handling to 0, this
+	 * will do a hard close without trying to graceful shutdown
+	 * the socket handling and immediately close the connection
+	 * with discard any data in the socket queues.
+	 */
+	if (no_linger)
+		sock_no_linger(con->sock->sk);
+
 	dlm_close_sock(&con->sock);
 
 	/* if we send a writequeue entry only a half way, we drop the
@@ -830,7 +849,7 @@ static void shutdown_connection(struct connection *con, bool and_other)
 	return;
 
 force_close:
-	close_connection(con, false);
+	close_connection(con, false, true);
 }
 
 static struct processqueue_entry *new_processqueue_entry(int nodeid,
@@ -1067,7 +1086,7 @@ static int accept_from_sock(void)
 			set_bit(CF_IS_OTHERCON, &othercon->flags);
 		} else {
 			/* close other sock con if we have something new */
-			close_connection(othercon, false);
+			close_connection(othercon, false, false);
 		}
 
 		down_write(&othercon->sock_lock);
@@ -1457,7 +1476,7 @@ int dlm_lowcomms_close(int nodeid)
 
 	stop_connection_io(con);
 	log_print("io handling for node: %d stopped", nodeid);
-	close_connection(con, true);
+	close_connection(con, true, true);
 
 	spin_lock(&connections_lock);
 	hlist_del_rcu(&con->list);
@@ -1503,7 +1522,7 @@ static void process_recv_sockets(struct work_struct *work)
 		/* CF_RECV_PENDING cleared */
 		break;
 	case DLM_IO_EOF:
-		close_connection(con, false);
+		close_connection(con, false, false);
 		wake_up(&con->shutdown_wait);
 		/* CF_RECV_PENDING cleared */
 		break;
@@ -1531,7 +1550,7 @@ static void process_recv_sockets(struct work_struct *work)
 	default:
 		if (ret < 0) {
 			if (test_bit(CF_IS_OTHERCON, &con->flags)) {
-				close_connection(con, false);
+				close_connection(con, false, false);
 			} else {
 				spin_lock_bh(&con->writequeue_lock);
 				lowcomms_queue_swork(con);
@@ -1667,7 +1686,7 @@ static void process_send_sockets(struct work_struct *work)
 		break;
 	default:
 		if (ret < 0) {
-			close_connection(con, false);
+			close_connection(con, false, false);
 
 			/* CF_SEND_PENDING cleared */
 			spin_lock_bh(&con->writequeue_lock);
@@ -1733,7 +1752,7 @@ void dlm_lowcomms_shutdown(void)
 			shutdown_connection(con, true);
 			stop_connection_io(con);
 			flush_workqueue(process_workqueue);
-			close_connection(con, true);
+			close_connection(con, true, false);
 
 			clean_one_writequeue(con);
 			if (con->othercon)
-- 
2.43.0

