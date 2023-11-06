Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F52E64F
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxOF+UjY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5afe220cadeso67015147b3.3
        for <gfs2@lists.linux.dev>; Mon, 06 Nov 2023 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699305880; x=1699910680; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RdEIUnfrd16mPMex7MqqZYwlL2xFlg4/43Dphzmx9M8=;
        b=MxOF+UjYq0cax+Wmfvl/3eg0ybCFW+esYM5M26kMc1hAXZ1xjlpj0glofk17XP16kE
         O3nwZqi2GjuN+jdbFkDyq/sS+pVnDFw8Xpzmt6X1A3Y0WUNWdFQ3pip+HJkEvMMzuHDx
         DWjhxVgfwFoU9QDlzc1+d1onSniyNzqUrug8GCuCygCUmGw1kbHztwgP9NmRMfdN8IiS
         2w0FZ+mZ63uyzgbHJC+XMy1PcuvDF10x1EJruUuEmdYgIa+UIW+USJordDBHUWsrNw+k
         vHilYbFWdNy3i6x8r06eb8oDoGwhCqZXGqb2RproZX3FEK3LkbAsBXUU97k6d/goNSma
         X8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305880; x=1699910680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdEIUnfrd16mPMex7MqqZYwlL2xFlg4/43Dphzmx9M8=;
        b=oFdx72k3pz4y7u8cJV1Ks1UMucUs9/s/barvYCYRit0EDcS9q5jakXgwEQU376Fr39
         DAWHn/WnXTgNOQwSeuN68HVfuDVOjXSaUihZFKoZOUi0gTzSpnTNCMupATpPEzaUBNSV
         Sys+ya1dPRbYsQkwp4rwb3K0W8RWdVIJD2O/mjW2BubvoKFO4X7AlxrYVagkpyiF9E8+
         lgChVcHh7QNaOuw/CgWvSZdtNozgML66G1DNpdO58p93i04SPaWWYjd+sZ7ZVaT4H0xs
         gxukUXA6fuZJnDWzzbwQL3A+sQTUGLACqERd6oAWecBdjNRUu3h7qDIO8HofU2GP+WKL
         WLfA==
X-Gm-Message-State: AOJu0Yz+VM6ICQeIwgIWYt7WVVu3Uwo2EHxX/k3tcwbDyG1vHECJsiaO
	egWpWNC5EtHBGau8Nzb0hz0bL0eaxkMn30JHM8QEKrAYHkuY7MfkXGyH90X04HntU1pvj4QBweS
	kxlRfhIyQfkbA13Rc/orCWcZUvg3cPqH2obZBbfLjxgSwsjhBauLbUeUs
X-Google-Smtp-Source: AGHT+IHAFKt4u4FlY2yLPoT34HEnwSfhJPmytVKYXvvDochEsMQmonstUOFiNOSSTQqVCJ8ycRoLPM1nAQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:109:0:b0:da0:c6d7:8231 with SMTP id
 9-20020a250109000000b00da0c6d78231mr577424ybb.0.1699305880527; Mon, 06 Nov
 2023 13:24:40 -0800 (PST)
Date: Mon,  6 Nov 2023 15:24:38 -0600
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106212438.663455-1-jrife@google.com>
Subject: [PATCH] dlm: use kernel_connect() and kernel_bind()
From: Jordan Rife <jrife@google.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com, teigland@redhat.com, Jordan Rife <jrife@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recent changes to kernel_connect() and kernel_bind() ensure that
callers are insulated from changes to the address parameter made by BPF
SOCK_ADDR hooks. This patch wraps direct calls to ops->connect() and
ops->bind() with kernel_connect() and kernel_bind() to protect callers
in such cases.

Link: https://lore.kernel.org/netdev/9944248dba1bce861375fcce9de663934d933ba9.camel@redhat.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Cc: stable@vger.kernel.org
Signed-off-by: Jordan Rife <jrife@google.com>
---
 fs/dlm/lowcomms.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 67f8dd8a05ef2..6296c62c10fa9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1817,8 +1817,8 @@ static int dlm_tcp_bind(struct socket *sock)
 	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
-	result = sock->ops->bind(sock, (struct sockaddr *)&src_addr,
-				 addr_len);
+	result = kernel_bind(sock, (struct sockaddr *)&src_addr,
+			     addr_len);
 	if (result < 0) {
 		/* This *may* not indicate a critical error */
 		log_print("could not bind for connect: %d", result);
@@ -1830,7 +1830,7 @@ static int dlm_tcp_bind(struct socket *sock)
 static int dlm_tcp_connect(struct connection *con, struct socket *sock,
 			   struct sockaddr *addr, int addr_len)
 {
-	return sock->ops->connect(sock, addr, addr_len, O_NONBLOCK);
+	return kernel_connect(sock, addr, addr_len, O_NONBLOCK);
 }
 
 static int dlm_tcp_listen_validate(void)
@@ -1862,8 +1862,8 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return sock->ops->bind(sock, (struct sockaddr *)&dlm_local_addr[0],
-			       addr_len);
+	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+			   addr_len);
 }
 
 static const struct dlm_proto_ops dlm_tcp_ops = {
@@ -1888,12 +1888,12 @@ static int dlm_sctp_connect(struct connection *con, struct socket *sock,
 	int ret;
 
 	/*
-	 * Make sock->ops->connect() function return in specified time,
+	 * Make kernel_connect() function return in specified time,
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
 	sock_set_sndtimeo(sock->sk, 5);
-	ret = sock->ops->connect(sock, addr, addr_len, 0);
+	ret = kernel_connect(sock, addr, addr_len, 0);
 	sock_set_sndtimeo(sock->sk, 0);
 	return ret;
 }
-- 
2.42.0.869.gea05f2083d-goog

