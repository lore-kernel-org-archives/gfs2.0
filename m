Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204856;
	b=mwSb7KF2LN4UQOLbPg4WhHc8EdNWkjhoQ3A8zWCX3VDJXioTCm0dqzU39AIIeC1HTcEJ
	 R07RroSmaT+kT4ABn/Is3YFbjupgfSS8QzrrmFgY5/ZFc5jg6qKZBjvcOgkAn44Lw824f
	 ORPq9zFMwkYJXuT18j4MSkY53trkHmDL4goIV9aGguxErxOGjJJU9W4oIZIfqsGfFLBzX
	 UebYnjfr+yHSS7WpO9IILbXHO2JKu0WBKOGjQKrGJBZU/HwrXNDQKoEx2HnMX29K8hRgz
	 Swv7MIsb0qK+6sPbaalPucD62wK/66GQgRgp+jSI0aA6iRLQM+Wv6tyFEmeUgndchaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204856;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=kL5AX1AOhBV1RbfzHgaxI1ZcvMjfjO0D5M+aI4vHIPw=;
	b=2BLTMrz6unT0BpCFE/ut+Q9vQORPZSYr8P7EdF3NSLR5CKt8QsOpNqf/lrk9m4ZdT8F5
	 mm8vJhr8H+aHzWKspSHSBkHwFzh6XMuQhzXpDtcy/o/hNoDGVUh0PQqN/Gy8OV/zVqFQJ
	 BITVyMQcaQ0SrNQopZ9fZYhEqWcSj+PpoDVNuCLIY/J/4dvsA6podYCL+gJ1YkHJXHSX5
	 jdpWDpRS+OdpP0fJHsV6pVhXLJx8knjMVI3P8bJmMKT8O/XBybBl2z9IKTQav6saQ/Fnw
	 LSp7zlZYEdsAtk7ThWtGU7bt+qEOVZDE42RrdL7LyjGsjK0ew+fMFeEeLiPwOzZuKRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ss8X2V5T;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E9606A6DE
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4E9606A6DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ss8X2V5T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795204849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kL5AX1AOhBV1RbfzHgaxI1ZcvMjfjO0D5M+aI4vHIPw=;
	b=Ss8X2V5TQzdkk+Z9ibvsZ17p4hYoo+hyEptogQb7krEi7IElJt/YsAPtjCT2N7YlhyT0vI
	l4TRzKIeQ5Et4RxlQSxOcbXnq6ARFuntlYbgqVNwoX3LUoetAuQGg9VE6hBvoV04NHumxX
	5v+Ua9d8tLnm4sNJVpub7JSbRLKDFSE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-baCQte95OwKDp7-Aua4oOA-1; Fri,
 20 Nov 2026 20:00:45 +0000
X-MC-Unique: baCQte95OwKDp7-Aua4oOA-1
X-Mimecast-MFC-AGG-ID: baCQte95OwKDp7-Aua4oOA_1795204843
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6DA71801338
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 20:00:43 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1814E428;
	Fri, 20 Nov 2026 20:00:43 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCHv2 RESEND v7.4-rc3 1/5] dlm: fix socket hang on send buffer limitation with socket error
Date: Fri, 20 Nov 2026 15:00:36 -0500
Message-ID: <20261120200040.257152-2-aahringo@redhat.com>
In-Reply-To: <20261120200040.257152-1-aahringo@redhat.com>
References: <20261120200040.257152-1-aahringo@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RFEPxbiGcyqIX3U_FW7LYBgu-ocL5_ycT0g_i0FEmbo_1795204843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As Sashiko AI bot mentioned [0], a socket connection can get stuck when
the send buffer limitation is reached and a socket error simultaneously
occurs.

This issue can be reproduced with the following setup:
1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
2. Slow down DLM connections using netem.
3. Use tcpkill to randomly send TCP resets to DLM connections.

I instrumented debug printouts to confirm that the sk_write_space()
notifier callbacks were being executed, using step 3 to trigger random
socket errors.

With these changes, I can no longer reproduce the hang.

Changes included:
- Removed sk_write_pending counting, as this should not be modified
  at the socket application layer (or is at least unnecessary).
- Moved clearing the CF_SEND_PENDING bit—which allows re-queuing
  swork (send worker for sendmsg())—to the sk_write_space() callback,
  since this callback notifies us that the underlying socket is no longer
  constrained by its send buffer.
- Handled the race condition between sendmsg() and evaluating
  SOCK_NOSPACE after sendmsg(), where sk_write_space() could be called
  in between, using CF_APP_LIMITED:
  - In sk_write_space(), queue swork again if CF_APP_LIMITED is set.
  - If CF_APP_LIMITED is not set, do nothing as send_to_sock() will handle
    it, confirming the race occurred.
- Introduced new handling in lowcomms_error_report() when a socket error
  occurs during send buffer limitation. If CF_APP_LIMITED is set, swork
  will be re-queued, which will fail and trigger a reconnect.
- Added various comments explaining the interaction with CF_APP_LIMITED.

[0] https://lore.kernel.org/netdev/179090395863.434549.3668493667259120759@kernel.org/

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 3929b164dc0d..6c972f1b412c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -521,12 +521,20 @@ static void lowcomms_write_space(struct sock *sk)
 
 	sk_clear_nospace(sk);
 
-	spin_lock_bh(&con->writequeue_lock);
-	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags))
-		con->sock->sk->sk_write_pending--;
-
-	lowcomms_queue_swork(con);
-	spin_unlock_bh(&con->writequeue_lock);
+	if (test_and_clear_bit(CF_APP_LIMITED, &con->flags)) {
+		/* signal to send again by clearing
+		 * CF_SEND_PENDING and queue swork.
+		 */
+		spin_lock_bh(&con->writequeue_lock);
+		clear_bit(CF_SEND_PENDING, &con->flags);
+		lowcomms_queue_swork(con);
+		spin_unlock_bh(&con->writequeue_lock);
+	} else {
+		/* CF_APP_LIMITED is cleared, so send_to_sock() will
+		 * simply reschedule work without hitting the
+		 * CF_APP_LIMITED path.
+		 */
+	}
 }
 
 static void lowcomms_state_change(struct sock *sk)
@@ -623,6 +631,20 @@ static void lowcomms_error_report(struct sock *sk)
 		break;
 	}
 
+	/* if waiting on sk_write_space() and an sk_err occurs, the callback
+	 * won't fire. Clear CF_SEND_PENDING so resend tasks can re-queue
+	 * swork, triggering a sendmsg() failure to initiate reconnection.
+	 */
+	spin_lock_bh(&con->writequeue_lock);
+	clear_bit(CF_SEND_PENDING, &con->flags);
+	/* dlm_midcomms_unack_msg_resend() does not always
+	 * trigger lowcomms_queue_swork() as it tries to
+	 * avoid to put pending messages into the lowcomms
+	 * sending buffer. Force it here again.
+	 */
+	lowcomms_queue_swork(con);
+	spin_unlock_bh(&con->writequeue_lock);
+
 	dlm_midcomms_unack_msg_resend(con->nodeid);
 
 	listen_sock.sk_error_report(sk);
@@ -1391,22 +1413,19 @@ static int send_to_sock(struct connection *con)
 		spin_lock_bh(&con->writequeue_lock);
 		if (test_bit(SOCK_NOSPACE, &con->sock->flags) &&
 		    !test_and_set_bit(CF_APP_LIMITED, &con->flags)) {
-			/* Notify TCP that we're limited by the
-			 * application window size.
-			 */
-			sk_set_nospace(con->sock->sk);
-			con->sock->sk->sk_write_pending++;
-
-			clear_bit(CF_SEND_PENDING, &con->flags);
 			spin_unlock_bh(&con->writequeue_lock);
 			release_sock(con->sock->sk);
 
-			/* wait for write_space() event */
+			/* wait for sk_write_space() event */
 			return DLM_IO_END;
 		}
 		spin_unlock_bh(&con->writequeue_lock);
 		release_sock(con->sock->sk);
 
+		/* the sk_write_space() came in between sock_sendmsg()
+		 * and check on SOCK_NOSPACE and the socket became
+		 * writeable again so just resched swork.
+		 */
 		return DLM_IO_RESCHED;
 	} else if (ret < 0) {
 		return ret;
-- 
2.43.0

