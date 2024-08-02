Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AF15C12A
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619639; cv=none; b=rArRmvBu0wuVqNni9FgqwCa86MJ2Y09EijcrszoQ354rLB66IcwQ8XNFFJSWSVTSbWEbUyMxYburD90/LZvWnxP5OaKJ50kjWa1V9P/ER07uZdQsnpqGByq3k5Io9fzIL1tnLktdqFm2K9VduBpikJCYN0fShzKBiBFba1nnT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619639; c=relaxed/simple;
	bh=5RU/PAgHyzqnGLR3MmtEO2TJd3hZ762NJGhhA6DYxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccxtgRjZ7DaW9fAv7mm3fC73EWnHTCbyBIneeORn1brzUUT1YIaQzcgvnpavMdbYbDD/gObPJce2CQH8eapDhM08s5vVGtfSdzG0k7LhFzzSRioi1UCh8DHt+2W6+4H4Nhp6KPzNPJAd6b3xYKQ+nrV8QAEQ0S0bd3kSu6aEs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj1MSAod; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj1MSAod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722619635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp23Ez1hwoa5NI7s2C0qoFCTjcATsmEzZnZDP7LIWFo=;
	b=Cj1MSAodCm7e4gJUwyE4U5XaafYYB9LpP7Pa8mb5zTzeszfsqN4KhdagvnwQq2kDVJaHbB
	BwC7onW1LvIVTRPhX87qELbL3lKoPQEXbmTpxwBs3ZLl5koFerSmgv4k1CUM3qUQDWwGQf
	WXrqZhg/jfuiVsBrkjjbXc3qsOa/8JA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-J5IMU2V0PNOQ3p2MEromuQ-1; Fri,
 02 Aug 2024 13:27:13 -0400
X-MC-Unique: J5IMU2V0PNOQ3p2MEromuQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFFFC1944A96
	for <gfs2@lists.linux.dev>; Fri,  2 Aug 2024 17:27:12 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DA1F1955F6B;
	Fri,  2 Aug 2024 17:27:11 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCHv2 v6.11-rc1 10/10] dlm: do synchronized socket connect call
Date: Fri,  2 Aug 2024 13:26:47 -0400
Message-ID: <20240802172647.582745-10-aahringo@redhat.com>
In-Reply-To: <20240802172647.582745-1-aahringo@redhat.com>
References: <20240802172647.582745-1-aahringo@redhat.com>
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

To avoid -EINPROGRESS cases on connect that just ends in a retry we just
call connect in a synchronized way to wait until its done. Since commit
dbb751ffab0b ("fs: dlm: parallelize lowcomms socket handling") we have a
non ordered workqueue running for serving the DLM sockets that allows us
to call send/recv for each DLM socket connection in parallel. Before
each worker needed to wait until the previous worker was done and
probably the reason why connect() was called in an asynchronous way to
not block other workers. This is however not necessary anymore as other
socket handling workers don't need to wait.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2e3e269d820e..cb3a10b041c2 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -161,8 +161,6 @@ struct dlm_proto_ops {
 	const char *name;
 	int proto;
 
-	int (*connect)(struct connection *con, struct socket *sock,
-		       struct sockaddr *addr, int addr_len);
 	void (*sockopts)(struct socket *sock);
 	int (*bind)(struct socket *sock);
 	int (*listen_validate)(void);
@@ -1599,8 +1597,7 @@ static int dlm_connect(struct connection *con)
 
 	log_print_ratelimited("connecting to %d", con->nodeid);
 	make_sockaddr(&addr, dlm_config.ci_tcp_port, &addr_len);
-	result = dlm_proto_ops->connect(con, sock, (struct sockaddr *)&addr,
-					addr_len);
+	result = kernel_connect(sock, (struct sockaddr *)&addr, addr_len, 0);
 	switch (result) {
 	case -EINPROGRESS:
 		/* not an error */
@@ -1634,13 +1631,6 @@ static void process_send_sockets(struct work_struct *work)
 			switch (ret) {
 			case 0:
 				break;
-			case -EINPROGRESS:
-				/* avoid spamming resched on connection
-				 * we might can switch to a state_change
-				 * event based mechanism if established
-				 */
-				msleep(100);
-				break;
 			default:
 				/* CF_SEND_PENDING not cleared */
 				up_write(&con->sock_lock);
@@ -1831,12 +1821,6 @@ static int dlm_tcp_bind(struct socket *sock)
 	return 0;
 }
 
-static int dlm_tcp_connect(struct connection *con, struct socket *sock,
-			   struct sockaddr *addr, int addr_len)
-{
-	return kernel_connect(sock, addr, addr_len, O_NONBLOCK);
-}
-
 static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
@@ -1873,7 +1857,6 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 static const struct dlm_proto_ops dlm_tcp_ops = {
 	.name = "TCP",
 	.proto = IPPROTO_TCP,
-	.connect = dlm_tcp_connect,
 	.sockopts = dlm_tcp_sockopts,
 	.bind = dlm_tcp_bind,
 	.listen_validate = dlm_tcp_listen_validate,
@@ -1886,22 +1869,6 @@ static int dlm_sctp_bind(struct socket *sock)
 	return sctp_bind_addrs(sock, 0);
 }
 
-static int dlm_sctp_connect(struct connection *con, struct socket *sock,
-			    struct sockaddr *addr, int addr_len)
-{
-	int ret;
-
-	/*
-	 * Make kernel_connect() function return in specified time,
-	 * since O_NONBLOCK argument in connect() function does not work here,
-	 * then, we should restore the default value of this attribute.
-	 */
-	sock_set_sndtimeo(sock->sk, 5);
-	ret = kernel_connect(sock, addr, addr_len, 0);
-	sock_set_sndtimeo(sock->sk, 0);
-	return ret;
-}
-
 static int dlm_sctp_listen_validate(void)
 {
 	if (!IS_ENABLED(CONFIG_IP_SCTP)) {
@@ -1929,7 +1896,6 @@ static const struct dlm_proto_ops dlm_sctp_ops = {
 	.name = "SCTP",
 	.proto = IPPROTO_SCTP,
 	.try_new_addr = true,
-	.connect = dlm_sctp_connect,
 	.sockopts = dlm_sctp_sockopts,
 	.bind = dlm_sctp_bind,
 	.listen_validate = dlm_sctp_listen_validate,
-- 
2.43.0

