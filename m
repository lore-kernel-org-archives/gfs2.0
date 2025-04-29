Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C225FA02
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958568; cv=none; b=h75NFZUZu3aPyPYLDjh8VsxxCNltqHvqDo/gPQdnTNhVnoclJOzi24HP4FhHRRheoXrNS/d6MCghj6+DyY9ouFnhuvDW2Ktf1FM9KQPVO7qR9kRg8IKzuNGD32ztqoKXa0qm/wVyA9UzY2G2aX92Mk/kD7aoZNfF9/zjuJXViII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958568; c=relaxed/simple;
	bh=7gyrHZWvBBCyOGJMI3rJyCX2qZpjZlVr9ve41n182jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pmXab6StyXnhNJlc0iG7Izm8OOVp1D0Ja1QZL+fUB+1gzDzHNeCEFt8ZnpMQJ9fa/Svj9nAFAYO1c7igKTLmvfZ3XPz+isaqmbj93pyoLKEst24ix/pCqKqpxp6WAMEpsPm+m1p6fuJ0YMMSxPonR1FjMyLRXa7RrIGTH4tM9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggSJiFOW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggSJiFOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745958565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SX0sZg4k955pImrHu8wpa15DNLBLfbVR3qT0QRiWKsQ=;
	b=ggSJiFOWovhJoUcQfyySEQtCyg9MRU1pqluqpl4d+GQjlV6qDHPB0TajNTqVgl0h7RAPfA
	dHPecoZdiZ65d9XQ40AYlOMiA+yklvV2Lpn8f1o2gSveLurNwQt0Q3aUickzr+Xk9CegCj
	ACUDSyDoFk462gPLkCX5v/eE44G5lIE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-IkQXVmrzMsWyDdsi8fYC5Q-1; Tue,
 29 Apr 2025 16:29:22 -0400
X-MC-Unique: IkQXVmrzMsWyDdsi8fYC5Q-1
X-Mimecast-MFC-AGG-ID: IkQXVmrzMsWyDdsi8fYC5Q_1745958561
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CD3019560A2;
	Tue, 29 Apr 2025 20:29:21 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74BB319560AF;
	Tue, 29 Apr 2025 20:29:20 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	glass.su@suse.com,
	heming.zhao@suse.com,
	lidong.zhong@suse.com,
	aahringo@redhat.com
Subject: [RFC PATCH dlm/next 2/4] dlm: use SHUT_RDWR for SCTP shutdown
Date: Tue, 29 Apr 2025 16:29:11 -0400
Message-ID: <20250429202913.2908521-2-aahringo@redhat.com>
In-Reply-To: <20250429202913.2908521-1-aahringo@redhat.com>
References: <20250429202913.2908521-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdZcT1MxrC0eo_heK-gq2GJ4ookMjBMD3McstWkE9Hc_1745958561
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently SCTP shutdown() call gets stuck because there is no incoming
EOF indicator on its socket. On the peer side the EOF indicator as
recvmsg() returns 0 will be triggered as mechanism to flush the socket
queue on the receive side. In SCTP recvmsg() function sctp_recvmsg() we
can see that only if sk_shutdown has the bit RCV_SHUTDOWN set SCTP will
recvmsg() will return EOF. The RCV_SHUTDOWN bit will only be set when
shutdown with SHUT_RD is called. We use now SHUT_RDWR to also get a EOF
indicator from recvmsg() call on the shutdown() initiator.

SCTP does not support half closed sockets and the semantic of SHUT_WR is
different here, it seems that calling SHUT_WR on sctp sockets keeps the
socket open to have the possibility to do some specific SCTP operations on
it that we don't do here.

There exists still a difference in the limitations of TCP vs SCTP in
case if we are required to have a half closed socket functionality. This
was tried to archieve with DLM protocol changes in the past and
hopefully we really don't require half closed socket functionality.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 50c42b368c83..e4373bce1bc2 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -160,6 +160,7 @@ struct dlm_proto_ops {
 	bool try_new_addr;
 	const char *name;
 	int proto;
+	int how;
 
 	void (*sockopts)(struct socket *sock);
 	int (*bind)(struct socket *sock);
@@ -810,7 +811,7 @@ static void shutdown_connection(struct connection *con, bool and_other)
 		return;
 	}
 
-	ret = kernel_sock_shutdown(con->sock, SHUT_WR);
+	ret = kernel_sock_shutdown(con->sock, dlm_proto_ops->how);
 	up_read(&con->sock_lock);
 	if (ret) {
 		log_print("Connection %p failed to shutdown: %d will force close",
@@ -1858,6 +1859,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 static const struct dlm_proto_ops dlm_tcp_ops = {
 	.name = "TCP",
 	.proto = IPPROTO_TCP,
+	.how = SHUT_WR,
 	.sockopts = dlm_tcp_sockopts,
 	.bind = dlm_tcp_bind,
 	.listen_validate = dlm_tcp_listen_validate,
@@ -1896,6 +1898,7 @@ static void dlm_sctp_sockopts(struct socket *sock)
 static const struct dlm_proto_ops dlm_sctp_ops = {
 	.name = "SCTP",
 	.proto = IPPROTO_SCTP,
+	.how = SHUT_RDWR,
 	.try_new_addr = true,
 	.sockopts = dlm_sctp_sockopts,
 	.bind = dlm_sctp_bind,
-- 
2.43.0

