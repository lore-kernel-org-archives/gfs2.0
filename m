Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CE2459C9
	for <gfs2@lists.linux.dev>; Fri,  6 Feb 2026 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354239; cv=none; b=F/JaUf0FHk3w56EQCHWZ1K9X0VirU16X12E1mlkCTnqE6mgqjkE8rgCLzRpleMTxqj0gR0tlHMfrCZslOiQRwZ1SLzB/xEh7EzRBj5yACH88GEHXsRac8MucXN7VVlIUPlDHwHHtQiuDh9FrS3wOO3CS0/mZCPiLLHrwg1AVbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354239; c=relaxed/simple;
	bh=Q98roVB5hZrAY/PrGD8FV1aQ+VKPQNxhBpZb1F+TS1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s/zTrYuAZ7XmMqiWM7ti7w+YBJG5azEOXNoCAfmCRAR6qwXoMPZuJXbw8NjaEO5TPIZHlXf/ToD3OF6a6RMW0CMaZslQtsVrKxuGbUSgPcVLZ/m0HeoY0bgr1/ex7EqUNmGoTs6PnDEveyULSvX0fh5iip+A872lhywhh3RcDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Alexander Aring <aahringo@redhat.com>, David Teigland
	<teigland@redhat.com>, <gfs2@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] dlm: use hlist_for_each_entry_srcu for SRCU protected lists
Date: Fri, 6 Feb 2026 00:03:29 -0500
Message-ID: <20260206050329.5834-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc10.internal.baidu.com (172.31.3.20) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

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
---
 fs/dlm/lowcomms.c | 12 ++++++++----
 fs/dlm/midcomms.c | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index b395800..59e91a6 100644
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
index 2c101bb..e08765b 100644
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
2.9.4

