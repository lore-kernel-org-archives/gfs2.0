Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5F342517
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305586; cv=none; b=S5xkOAMq0GOAhR/W+mPhC5niF9RL55b3dVsKm0knO/EvD5CXb+LcR2AVJ3qQYqbnVrvzUShuIn/M305qxY+/BnYheA0OGhxb+wBUgEC/OPdy0/D7z59C4+P6Q4Kfqc5ujUATHxOe/b5xtLGcJYRCOTlm3BuoJmL+aoH6v8TiAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305586; c=relaxed/simple;
	bh=MS77guDeC8LWrQVAQG5u4wz0h/Xb5TNOhLwa6hQAFK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K63zA0YuCGuno+hAOwdAgG0YIsfGPRx6jKL2KJaXAS7R4aalijv0IMHDPVarQihZIF+F9+3oNq+PFzuAp0mdtmqxsmwxAJ68Mpu8iIFI5TBEpQdftTpUO7mrFndc/J4TEpyx+GJN4gPItBqMdogqUU9nEe7ephcY8sJO5BmZNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw2zedHf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw2zedHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777305584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6/HsmQki1uezXZvndAHbxsW5NRnIbepm5/WlGNWGRg=;
	b=Hw2zedHfkgPhFEPwQtxV1bjU0PSzY1wgw1B3xChIu6+CCoH0tA46Y4hEccXWo4TmKsMw+p
	fpFJ9+63fx1BFd/0SDDlmTJBpCps3ZeLWIgYygKp4S7BOlC3aYMeyrIW2aE0o/eVGdNnuG
	14Zujc7MSOf6NDF1/Z1f9QUJsSDkqu4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-6MQp5VNCMsWW0Ae2Md8A9A-1; Mon,
 27 Apr 2026 11:59:43 -0400
X-MC-Unique: 6MQp5VNCMsWW0Ae2Md8A9A-1
X-Mimecast-MFC-AGG-ID: 6MQp5VNCMsWW0Ae2Md8A9A_1777305582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C07195608F
	for <gfs2@lists.linux.dev>; Mon, 27 Apr 2026 15:59:42 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12B98300070A;
	Mon, 27 Apr 2026 15:59:41 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH RESEND v7.1-rc1 1/4] dlm: use hlist_for_each_entry_srcu for SRCU protected lists
Date: Mon, 27 Apr 2026 11:59:32 -0400
Message-ID: <20260427155935.2415989-2-aahringo@redhat.com>
In-Reply-To: <20260427155935.2415989-1-aahringo@redhat.com>
References: <20260427155935.2415989-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vKYcC5oBr161hG4XfUGYabkgjeX7n-1EqjKXVJ1dGfg_1777305582
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Li RongQing <lirongqing@baidu.com>

The connection and node hash tables in DLM are protected by SRCU, but
the code currently uses hlist_for_each_entry_rcu() for traversal.
While this works functionally, it is semantically incorrect and triggers
warnings when RCU lockdep debugging is enabled, as it expects regular
RCU read-side critical sections.

This patch replaces the incorrect macros with hlist_for_each_entry_srcu()
and adds the appropriate lockdep expressions using srcu_read_lock_held()
to ensure consistency with the underlying locking mechanism.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Acked-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 12 ++++++++----
 fs/dlm/midcomms.c | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 5b61427879195..2aff1c7c17de4 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -271,7 +271,8 @@ static struct connection *__find_con(int nodeid, int r)
 {
 	struct connection *con;
 
-	hlist_for_each_entry_rcu(con, &connection_hash[r], list) {
+	hlist_for_each_entry_srcu(con, &connection_hash[r], list,
+			srcu_read_lock_held(&connections_srcu)) {
 		if (con->nodeid == nodeid)
 			return con;
 	}
@@ -426,7 +427,8 @@ static int addr_to_nodeid(struct sockaddr_storage *addr, int *nodeid,
 
 	idx = srcu_read_lock(&connections_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(con, &connection_hash[i], list) {
+		hlist_for_each_entry_srcu(con, &connection_hash[i], list,
+				srcu_read_lock_held(&connections_srcu)) {
 			WARN_ON_ONCE(!con->addr_count);
 
 			spin_lock(&con->addrs_lock);
@@ -1729,7 +1731,8 @@ void dlm_lowcomms_shutdown(void)
 
 	idx = srcu_read_lock(&connections_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(con, &connection_hash[i], list) {
+		hlist_for_each_entry_srcu(con, &connection_hash[i], list,
+				srcu_read_lock_held(&connections_srcu)) {
 			shutdown_connection(con, true);
 			stop_connection_io(con);
 			flush_workqueue(process_workqueue);
@@ -1968,7 +1971,8 @@ void dlm_lowcomms_exit(void)
 
 	idx = srcu_read_lock(&connections_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(con, &connection_hash[i], list) {
+		hlist_for_each_entry_srcu(con, &connection_hash[i], list,
+				srcu_read_lock_held(&connections_srcu)) {
 			spin_lock(&connections_lock);
 			hlist_del_rcu(&con->list);
 			spin_unlock(&connections_lock);
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index d54bdd8fc4f2e..a5b363b4785f3 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -275,7 +275,8 @@ static struct midcomms_node *__find_node(int nodeid, int r)
 {
 	struct midcomms_node *node;
 
-	hlist_for_each_entry_rcu(node, &node_hash[r], hlist) {
+	hlist_for_each_entry_srcu(node, &node_hash[r], hlist,
+			srcu_read_lock_held(&nodes_srcu)) {
 		if (node->nodeid == nodeid)
 			return node;
 	}
@@ -1165,7 +1166,8 @@ void dlm_midcomms_exit(void)
 
 	idx = srcu_read_lock(&nodes_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+		hlist_for_each_entry_srcu(node, &node_hash[i], hlist,
+				srcu_read_lock_held(&nodes_srcu)) {
 			dlm_delete_debug_comms_file(node->debugfs);
 
 			spin_lock(&nodes_lock);
@@ -1325,7 +1327,8 @@ void dlm_midcomms_version_wait(void)
 
 	idx = srcu_read_lock(&nodes_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+		hlist_for_each_entry_srcu(node, &node_hash[i], hlist,
+				srcu_read_lock_held(&nodes_srcu)) {
 			ret = wait_event_timeout(node->shutdown_wait,
 						 node->version != DLM_VERSION_NOT_SET ||
 						 node->state == DLM_CLOSED ||
@@ -1396,7 +1399,8 @@ void dlm_midcomms_shutdown(void)
 	mutex_lock(&close_lock);
 	idx = srcu_read_lock(&nodes_srcu);
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+		hlist_for_each_entry_srcu(node, &node_hash[i], hlist,
+				srcu_read_lock_held(&nodes_srcu)) {
 			midcomms_shutdown(node);
 		}
 	}
@@ -1404,7 +1408,8 @@ void dlm_midcomms_shutdown(void)
 	dlm_lowcomms_shutdown();
 
 	for (i = 0; i < CONN_HASH_SIZE; i++) {
-		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+		hlist_for_each_entry_srcu(node, &node_hash[i], hlist,
+				srcu_read_lock_held(&nodes_srcu)) {
 			midcomms_node_reset(node);
 		}
 	}
-- 
2.43.0

