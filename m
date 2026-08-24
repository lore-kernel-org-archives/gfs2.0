Received: from na1pdmzitismtp01.tibco.com (na1pdmzitismtp01.tibco.com [160.101.131.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB23ACA42
	for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.101.131.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568438; cv=none; b=d0Ga+sL/bfCG7JxQtChAlF9m76WvPhfJ66TuY7gu7ZSbrksUUem7odC84c/6quT11NS55mzd/2qveiPP57QxLe70fDOZZXU6PhUG5v/Mp7gj/53T4fnvoEftk0UoFk1GIaLHV2uqOVtmGPKhb5R9ra2mhkQvu2OO28AThUAHpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568438; c=relaxed/simple;
	bh=vQk9htvfQ70VjZHALbkm5mSgGbb4EESrgNTTly2Xe0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfjvajycZGYDwxsbsEL0VkapkNr8yVeYwXS5ofGyRfL/7CS+4P1kkZaefMSsg+gqc1UiEmqhNhfyuxsldX3jAGQUwVkJgM8rwm+VDcIu5InN+oFnM04PummxtSNtFUyqEq/qot/61R5Bl0x3xoQF5SK5rYIFSRxgXnIhoNHX8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; arc=none smtp.client-ip=160.101.131.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: from mewpvdipd1070.citrite.net (unknown [10.113.40.46])
	by na1pdmzitismtp01.tibco.com (Postfix) with ESMTP id B4322443F5F2;
	Mon, 24 Aug 2026 06:36:21 -0400 (EDT)
From: Mark Syms <mark.syms@citrix.com>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	Mark Syms <mark.syms@citrix.com>
Subject: [PATCH] dlm: bound TCP failure detection with TCP_USER_TIMEOUT
Date: Mon, 24 Aug 2026 11:37:43 +0100
Message-ID: <20260824103743.162021-1-mark.syms@citrix.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DLM sets no timeout of any kind on its TCP sockets. When a connection
blackholes - the peer is still up, but the flow is silently broken - DLM
only finds out once TCP itself gives up after tcp_retries2
retransmissions, which is around 15 minutes with the default value of
15.

Until then the reliable transmission layer cannot make progress:
dlm_midcomms_unack_msg_resend() is only ever called from the socket
error/close path, so the unacknowledged message stays queued and every
node waiting on a lock held by the stuck node waits with it. This was
observed as a cluster-wide GFS2 stall of just under 16 minutes, with all
five nodes blocked in gfs2_glock_wait() on a single inode glock whose EX
holder could not be demoted because one DLM message to one peer was
stranded on a dead socket. Once TCP finally reported the error the
socket was reconnected, the message retransmitted, and the cluster
recovered in about two seconds.

The only lever available today is the system wide net.ipv4.tcp_retries2
sysctl, which also governs iSCSI, NFS and every other TCP user on the
host.

Set TCP_USER_TIMEOUT on DLM sockets instead, so that DLM bounds its own
failure detection independently of the global TCP tuning, and expose it
as a new cluster configfs attribute tcp_user_timeout_secs alongside
mark. Zero keeps the previous behaviour of relying on tcp_retries2.

On expiry the socket is aborted with ETIMEDOUT, which drives the
existing lowcomms_error_report() -> dlm_midcomms_unack_msg_resend()
path, i.e. exactly the recovery that already unwound the stall, just
promptly. Because the option is applied before connect() it also caps
SYN retransmission, which is harmless here as dlm_connect() retries
indefinitely.

The value is read when a socket is created, so a change made through
configfs takes effect for subsequent connections.

Accepted sockets now get the protocol socket options set explicitly
rather than inheriting them from the listening socket, so that inbound
connections also pick up the current configuration.

SCTP is not affected; TCP_USER_TIMEOUT has no SCTP equivalent.

Signed-off-by: Mark Syms <mark.syms@citrix.com>
---
 fs/dlm/config.c   | 16 ++++++++++++++++
 fs/dlm/config.h   |  1 +
 fs/dlm/lowcomms.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 53cd33293042..dd4d741c8797 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -98,6 +98,7 @@ enum {
 	CLUSTER_ATTR_NEW_RSB_COUNT,
 	CLUSTER_ATTR_RECOVER_CALLBACKS,
 	CLUSTER_ATTR_CLUSTER_NAME,
+	CLUSTER_ATTR_TCP_USER_TIMEOUT_SECS,
 };
 
 static ssize_t cluster_cluster_name_show(struct config_item *item, char *buf)
@@ -220,6 +221,17 @@ static int dlm_check_zero(unsigned int x)
 	return 0;
 }
 
+static int dlm_check_tcp_user_timeout_secs(unsigned int x)
+{
+	/* zero disables the timeout, anything else must survive the
+	 * conversion to the milliseconds tcp_sock_set_user_timeout() takes
+	 */
+	if (x > INT_MAX / MSEC_PER_SEC)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int dlm_check_buffer_size(unsigned int x)
 {
 	if (x < DLM_MAX_SOCKET_BUFSIZE)
@@ -237,6 +249,7 @@ CLUSTER_ATTR(log_debug, NULL);
 CLUSTER_ATTR(log_info, NULL);
 CLUSTER_ATTR(protocol, dlm_check_protocol_and_dlm_running);
 CLUSTER_ATTR(mark, NULL);
+CLUSTER_ATTR(tcp_user_timeout_secs, dlm_check_tcp_user_timeout_secs);
 CLUSTER_ATTR(new_rsb_count, NULL);
 CLUSTER_ATTR(recover_callbacks, NULL);
 
@@ -254,6 +267,7 @@ static struct configfs_attribute *cluster_attrs[] = {
 	[CLUSTER_ATTR_NEW_RSB_COUNT] = &cluster_attr_new_rsb_count,
 	[CLUSTER_ATTR_RECOVER_CALLBACKS] = &cluster_attr_recover_callbacks,
 	[CLUSTER_ATTR_CLUSTER_NAME] = &cluster_attr_cluster_name,
+	[CLUSTER_ATTR_TCP_USER_TIMEOUT_SECS] = &cluster_attr_tcp_user_timeout_secs,
 	NULL,
 };
 
@@ -1031,6 +1045,7 @@ int dlm_our_addr(struct sockaddr_storage *addr, int num)
 #define DEFAULT_LOG_INFO           1
 #define DEFAULT_PROTOCOL           DLM_PROTO_TCP
 #define DEFAULT_MARK               0
+#define DEFAULT_TCP_USER_TIMEOUT_SECS 0
 #define DEFAULT_NEW_RSB_COUNT    128
 #define DEFAULT_RECOVER_CALLBACKS  0
 #define DEFAULT_CLUSTER_NAME      ""
@@ -1046,6 +1061,7 @@ struct dlm_config_info dlm_config = {
 	.ci_log_info = DEFAULT_LOG_INFO,
 	.ci_protocol = DEFAULT_PROTOCOL,
 	.ci_mark = DEFAULT_MARK,
+	.ci_tcp_user_timeout_secs = DEFAULT_TCP_USER_TIMEOUT_SECS,
 	.ci_new_rsb_count = DEFAULT_NEW_RSB_COUNT,
 	.ci_recover_callbacks = DEFAULT_RECOVER_CALLBACKS,
 	.ci_cluster_name = DEFAULT_CLUSTER_NAME
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index 4ebd45f75276..3843d3bf0d0e 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -41,6 +41,7 @@ struct dlm_config_info {
 	unsigned int ci_log_info;
 	unsigned int ci_protocol;
 	unsigned int ci_mark;
+	unsigned int ci_tcp_user_timeout_secs;
 	unsigned int ci_new_rsb_count;
 	unsigned int ci_recover_callbacks;
 	char ci_cluster_name[DLM_LOCKSPACE_LEN];
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2aff1c7c17de..571a4d4094ec 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1049,6 +1049,12 @@ static int accept_from_sock(void)
 
 	sock_set_mark(newsock->sk, mark);
 
+	/* set the socket options explicitly instead of relying on them being
+	 * inherited from the listening socket, so that an accepted socket
+	 * picks up the current configuration
+	 */
+	dlm_proto_ops->sockopts(newsock);
+
 	down_write(&newcon->sock_lock);
 	if (newcon->sock) {
 		struct connection *othercon = newcon->othercon;
@@ -1839,8 +1845,22 @@ static int dlm_tcp_listen_validate(void)
 
 static void dlm_tcp_sockopts(struct socket *sock)
 {
+	unsigned int timeout_secs;
+
 	/* Turn off Nagle's algorithm */
 	tcp_sock_set_nodelay(sock->sk);
+
+	/* Bound the time a message may stay unacknowledged on a silently
+	 * broken flow. Without this DLM only finds out that a connection is
+	 * dead once TCP gives up after tcp_retries2, which is roughly 15
+	 * minutes with the default value of 15, and every lockspace user
+	 * waiting on a lock held by that node stalls for as long. On expiry
+	 * the socket is aborted, the error report path resends the
+	 * unacknowledged messages and lowcomms reconnects.
+	 */
+	timeout_secs = READ_ONCE(dlm_config.ci_tcp_user_timeout_secs);
+	if (timeout_secs)
+		tcp_sock_set_user_timeout(sock->sk, timeout_secs * MSEC_PER_SEC);
 }
 
 static void dlm_tcp_listen_sockopts(struct socket *sock)
-- 
2.55.0

