Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C731AA785
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054834; cv=none; b=ChWhIsBs+s4VVBL43GggJi05IjknnKd+0seSsFVhzsoRM5VQeyZGAgIacrl13GMRYoyUM+e27XcRaEzZ+QS4zuJJqx4vUmQYapZ2zLDtFONdcVaOJ6Sdkgu3T4W35oEW5vhSyLBG2uM2ruyWsr+djAEtRONjGVRNUH8W7TQtiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054834; c=relaxed/simple;
	bh=3blknSYDq/zZqIrl23PU5zPaxSOhsHKnOb982Kn5GQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqI0FK+0bUaSmk0uoH3NQm//AwghsVzU0aXKfheqdNYSRaPoGVa5GFQD4GirWiwLuhJYlKU2yIGhCbQa3LdX9QfPvIbcfi9psa2gjm3LZu7dP5mLMe6QgYgPdOYmFd//H99OpOuJB3y8Le5/D0W3RVEEJp9knszRIOADqpXEqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ59Wgko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ59Wgko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728054832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LziguoEGhlOHcgujwsXARihNwSMNZenuPmbp2mwjHSo=;
	b=JZ59Wgko9n8CXOPT5PCtGm7dccq6RODB8zitBUDJ3s2+1/w8BZ8CP/npVkVL4F1PrzTzkb
	ylt1LLRz72cGpqUhYX72vWzsT7X7LYz9v2DGv66W15CUFNVDkyNmsYEmuoY0fYIlEStkIg
	Jwy4HP2lWZN/Zy1tyMZvHAROa9kJbfE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-dP8AlCONMYSCgT8c5L3KUg-1; Fri,
 04 Oct 2024 11:13:51 -0400
X-MC-Unique: dP8AlCONMYSCgT8c5L3KUg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19ADD1955E77
	for <gfs2@lists.linux.dev>; Fri,  4 Oct 2024 15:13:50 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 549DD19560AE;
	Fri,  4 Oct 2024 15:13:49 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH v6.12-rc1 4/7] dlm: handle port as __be16 network byte order
Date: Fri,  4 Oct 2024 11:13:40 -0400
Message-ID: <20241004151343.3952937-5-aahringo@redhat.com>
In-Reply-To: <20241004151343.3952937-1-aahringo@redhat.com>
References: <20241004151343.3952937-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This patch handles the DLM listen port setting internally as byte order
as it is a value that is used as network byte on the wire. The user
space still sets this value as host byte order for configfs as we don't
break UAPI here.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/config.c   | 55 +++++++++++++++++++++++++++++++++++------------
 fs/dlm/config.h   |  2 +-
 fs/dlm/lowcomms.c |  8 +++----
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/dlm/config.c b/fs/dlm/config.c
index 1980afaaa68c..42dcf3f06668 100644
--- a/fs/dlm/config.c
+++ b/fs/dlm/config.c
@@ -73,7 +73,7 @@ const struct rhashtable_params dlm_rhash_rsb_params = {
 
 struct dlm_cluster {
 	struct config_group group;
-	unsigned int cl_tcp_port;
+	__be16 cl_tcp_port;
 	unsigned int cl_buffer_size;
 	unsigned int cl_rsbtbl_size;
 	unsigned int cl_recover_timer;
@@ -132,6 +132,45 @@ static ssize_t cluster_cluster_name_store(struct config_item *item,
 
 CONFIGFS_ATTR(cluster_, cluster_name);
 
+static ssize_t cluster_tcp_port_show(struct config_item *item, char *buf)
+{
+	return sprintf(buf, "%u\n", be16_to_cpu(dlm_config.ci_tcp_port));
+}
+
+static int dlm_check_zero_and_dlm_running(unsigned int x)
+{
+	if (!x)
+		return -EINVAL;
+
+	if (dlm_lowcomms_is_running())
+		return -EBUSY;
+
+	return 0;
+}
+
+static ssize_t cluster_tcp_port_store(struct config_item *item,
+				      const char *buf, size_t len)
+{
+	int rc;
+	u16 x;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	rc = kstrtou16(buf, 0, &x);
+	if (rc)
+		return rc;
+
+	rc = dlm_check_zero_and_dlm_running(x);
+	if (rc)
+		return rc;
+
+	dlm_config.ci_tcp_port = cpu_to_be16(x);
+	return len;
+}
+
+CONFIGFS_ATTR(cluster_, tcp_port);
+
 static ssize_t cluster_set(struct dlm_cluster *cl, unsigned int *cl_field,
 			   int *info_field, int (*check_cb)(unsigned int x),
 			   const char *buf, size_t len)
@@ -191,17 +230,6 @@ static int dlm_check_protocol_and_dlm_running(unsigned int x)
 	return 0;
 }
 
-static int dlm_check_zero_and_dlm_running(unsigned int x)
-{
-	if (!x)
-		return -EINVAL;
-
-	if (dlm_lowcomms_is_running())
-		return -EBUSY;
-
-	return 0;
-}
-
 static int dlm_check_zero(unsigned int x)
 {
 	if (!x)
@@ -218,7 +246,6 @@ static int dlm_check_buffer_size(unsigned int x)
 	return 0;
 }
 
-CLUSTER_ATTR(tcp_port, dlm_check_zero_and_dlm_running);
 CLUSTER_ATTR(buffer_size, dlm_check_buffer_size);
 CLUSTER_ATTR(rsbtbl_size, dlm_check_zero);
 CLUSTER_ATTR(recover_timer, dlm_check_zero);
@@ -982,7 +1009,7 @@ int dlm_our_addr(struct sockaddr_storage *addr, int num)
 #define DEFAULT_CLUSTER_NAME      ""
 
 struct dlm_config_info dlm_config = {
-	.ci_tcp_port = DEFAULT_TCP_PORT,
+	.ci_tcp_port = cpu_to_be16(DEFAULT_TCP_PORT),
 	.ci_buffer_size = DLM_MAX_SOCKET_BUFSIZE,
 	.ci_rsbtbl_size = DEFAULT_RSBTBL_SIZE,
 	.ci_recover_timer = DEFAULT_RECOVER_TIMER,
diff --git a/fs/dlm/config.h b/fs/dlm/config.h
index 8a14a6e95463..2c5dcf5eaef1 100644
--- a/fs/dlm/config.h
+++ b/fs/dlm/config.h
@@ -29,7 +29,7 @@ extern const struct rhashtable_params dlm_rhash_rsb_params;
 #define DLM_PROTO_SCTP	1
 
 struct dlm_config_info {
-	int ci_tcp_port;
+	__be16 ci_tcp_port;
 	int ci_buffer_size;
 	int ci_rsbtbl_size;
 	int ci_recover_timer;
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cb3a10b041c2..df40c3fd1070 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -660,18 +660,18 @@ static void add_sock(struct socket *sock, struct connection *con)
 
 /* Add the port number to an IPv6 or 4 sockaddr and return the address
    length */
-static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
+static void make_sockaddr(struct sockaddr_storage *saddr, __be16 port,
 			  int *addr_len)
 {
 	saddr->ss_family =  dlm_local_addr[0].ss_family;
 	if (saddr->ss_family == AF_INET) {
 		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
-		in4_addr->sin_port = cpu_to_be16(port);
+		in4_addr->sin_port = port;
 		*addr_len = sizeof(struct sockaddr_in);
 		memset(&in4_addr->sin_zero, 0, sizeof(in4_addr->sin_zero));
 	} else {
 		struct sockaddr_in6 *in6_addr = (struct sockaddr_in6 *)saddr;
-		in6_addr->sin6_port = cpu_to_be16(port);
+		in6_addr->sin6_port = port;
 		*addr_len = sizeof(struct sockaddr_in6);
 	}
 	memset((char *)saddr + *addr_len, 0, sizeof(struct sockaddr_storage) - *addr_len);
@@ -1121,7 +1121,7 @@ static void writequeue_entry_complete(struct writequeue_entry *e, int completed)
 /*
  * sctp_bind_addrs - bind a SCTP socket to all our addresses
  */
-static int sctp_bind_addrs(struct socket *sock, uint16_t port)
+static int sctp_bind_addrs(struct socket *sock, __be16 port)
 {
 	struct sockaddr_storage localaddr;
 	struct sockaddr *addr = (struct sockaddr *)&localaddr;
-- 
2.43.0

