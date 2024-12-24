Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE837160
	for <gfs2@lists.linux.dev>; Tue, 24 Dec 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735029775; cv=none; b=aT1kWsCPuD4r5020Ww1p1vf1ivyYr7KIemZAb7lrO0rnDtU6FVJFOw0aQjMKk8KmULkvRjAGoGl0CzegIe5CuEr/UPmtHc+C5vlpJGioBiJFPZyEwAoxjxsEpNxRCKqJDxbBOTRgo7UgIdRDKffHhbmoaKg5yadYrHtQrNk76SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735029775; c=relaxed/simple;
	bh=wpRzYCRckOlhFLdq/GcFIn/9g9J3aY6VXFCs8fd4F2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2GpE31WZOCSz7d6LQ4Y2nLH8KBehSfpIy78LLbrp9sy+0ILAvmfs84QmIEB1TweBLB3m0KiHGmhirBZ2YzN/aRBdTzEHvj1k4qLN+UtERQZ1/CFNbZMuZJruQ3sp0gar7xNdlfyQxlEr8yLXEtOeaPZQN2pkad+/4WVQqNCRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d6wZ5Qgz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d6wZ5Qgz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3cd8e59fdso642856a12.3
        for <gfs2@lists.linux.dev>; Tue, 24 Dec 2024 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735029771; x=1735634571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aV6e7Wc5ToOrsnsgKUw8xVpER2wF0rl+0cSz6vaVNQ=;
        b=d6wZ5QgzeFkhe0sO6O7hzsj1t2X8o/TVm7D1e1pLqXiZAFu3idJNKvqffzDv/r9VSa
         XDC5EqANZiyohCK3Q1iJD671LwESPnWXndNihL/foRwNgYhdmePNhM8IUeiAnAz49Sxt
         E8d8e6svGJMDfs4VHlRDu8HNQ1RXqWx/iablB6ZEO05xZfX0Fhbbgq1Aj/9oKp1aQDKN
         +VwDxdUryUsbrkf45WYVvWJaN3yOThMc4CpiIIiSrHp3tov2qKsaE9EXKoHoL1/TkeKi
         PW0jf1fATPbYJ1cYyJRqz/NKTznj8MdkGAAAy48WHLqZcxMopNF7PmLeQzi0dLDTDYsW
         zGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735029771; x=1735634571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aV6e7Wc5ToOrsnsgKUw8xVpER2wF0rl+0cSz6vaVNQ=;
        b=fuzfIJmyFbfOC/+GJKeVqgCy4fAz4SmP7gqoZNbTrOamVgIIN1YIm4RgpA/J8nh86X
         aAgXC/tA9pxAauw6Y32b/gld5ABoypX+Dxd2jefUp4QkFW5fbv4WnUxWMs5XV65WGBMZ
         4oPDKM86zY2fC5fbew41KfcB/E2veMxW83N4isXeTTjqBTxHXWurNpYzynkYVy2dhTEU
         AZJjAzh3MhTKyNkkewrZGK49oZ8sX6vWPoZhXry9qUtroC80sWNkc4ZzKlEyULc+SIjx
         G5pfcKi5Tjej5ySBcJSegisfoSO4zOS39LtAeQYgQ/rsNji0ua1acr4wVak924aRkegx
         /qNw==
X-Forwarded-Encrypted: i=1; AJvYcCXLY7fL0cs8LnCYWydDmCjFEr2QvBdQeXPyparVosHJWf+VEK21D1GikbpnAmq/FGZ+uPF6@lists.linux.dev
X-Gm-Message-State: AOJu0YwOpX5fWh2wwEcTpOC/LNTPl58Q2K5yA0qjIw/8JmmjOulyekB2
	luTitAxmz8M/rcbs0w5ZPU6DYXzoq64J5I7ET5B6hG+sRlW/PiZekV8XxzCPrJ1038lk6nRR8Kx
	P
X-Gm-Gg: ASbGncvrk08QOYlEPwobN2FomSXPm+ml/oARR1P2SqObyO2NYThsth8v29PRm3BOC6m
	e5Vq/80lrX7WxbnryDr5oEmLV0Epz+5uGxwe6BD/ry9DoAiPycvlA401ghMRyKMnkyD6Le7MyAy
	T7OOHUrfHYkLX91P7EQRCrVjyjnNmkzIj62bDp8/DMdwMaHU8uadwGC/JYNG/HpS6WpyQqN9J8F
	a4PSxe0qXM2ZLd8GHg151cqTPSfXsfs5uCbZHlnuVmIPFWu0yf6EP/xGQ==
X-Google-Smtp-Source: AGHT+IGP6CTgcZSv1G9ULjI1XzfIdalsxbKspLUMz95xZ56oYp/V51rGr94WIdZPhAXoATy0pSGxlw==
X-Received: by 2002:a05:6402:5109:b0:5d0:bd3b:b9a9 with SMTP id 4fb4d7f45d1cf-5d81de1c38cmr5647237a12.8.1735029771596;
        Tue, 24 Dec 2024 00:42:51 -0800 (PST)
Received: from p15.suse.cz ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba73184sm8494332a12.17.2024.12.24.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 00:42:50 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com,
	glass.su@suse.com,
	gfs2@lists.linux.dev
Subject: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
Date: Tue, 24 Dec 2024 16:42:39 +0800
Message-ID: <20241224084241.13563-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224084241.13563-1-heming.zhao@suse.com>
References: <20241224084241.13563-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The totem.rrp_mode config item was obsolete in corosync3. And
this patch gives dlm_controld the ability to detect multiple
links.

The corosync and dlm network protocol relationship table:

 -------------+-----------------------+---------------------
              | totem.transport=udpu  | totem.transport=udp
              +-----------------------+---------------------
 corosync 2.x |            |          |      multicast
              |   1-ring   | 2-ring   |---------------------
              |            |          |  default  | 2-ring
 -------------+------------+----------+---------------------
    dlm       |     tcp    | sctp     |   tcp     | sctp
 -------------+------------+----------+---------------------

 -------------+----------------------------+----------------------
              | totem.transport = udpu/udp | totem.transport=knet
 corosync 3.x |----------------------------+----------------------
              |      1-ring                | 1-link  | multi-links
 -------------+----------------------------+---------+-----------
    dlm       |       tcp                  |  tcp    | sctp
 -------------+----------------------------+---------+-----------

At last, this patch should be work with updated kernel dlm module.
Because the DLM_MAX_ADDR_COUNT is changed from 3 to 8.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 dlm_controld/action.c     | 44 ++++++++++++++++++++++++++++++---------
 dlm_controld/dlm_daemon.h |  4 ++--
 dlm_sand/sand_internal.h  |  4 ++--
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/dlm_controld/action.c b/dlm_controld/action.c
index 60eb22a78c56..4b54a28707c6 100644
--- a/dlm_controld/action.c
+++ b/dlm_controld/action.c
@@ -20,12 +20,15 @@ static int comms_nodes_count;
 #define CLUSTER_DIR   "/sys/kernel/config/dlm/cluster"
 #define SPACES_DIR    "/sys/kernel/config/dlm/cluster/spaces"
 #define COMMS_DIR     "/sys/kernel/config/dlm/cluster/comms"
+#define CMAP_STR_LEN  27
 
 static int detect_protocol(void)
 {
 	cmap_handle_t handle;
 	char *str = NULL;
+	char key[CMAP_STR_LEN];
 	int rv, proto = -1;
+	int i, link = 0;
 
 	rv = cmap_initialize(&handle);
 	if (rv != CS_OK) {
@@ -33,19 +36,40 @@ static int detect_protocol(void)
 		return -1; 
 	}
 
-	rv = cmap_get_string(handle, "totem.rrp_mode", &str);
-	if (rv != CS_OK)
-		goto out;
-
-	log_debug("cmap totem.rrp_mode = '%s'", str);
+	for (i = 0; i < MAX_NODE_ADDRESSES; i++) {
+		snprintf(key, CMAP_STR_LEN, "nodelist.node.0.ring%d_addr", i);
+		rv = cmap_get_string(handle, key, &str);
+		if (rv != CS_OK) {
+			/* we only care the link number, ignore all error here */
+			log_debug("[%d] %s rv:%d", i, key, rv);
+			continue;
+		}
+		log_debug("[%d] %s : %s", i, key, str);
+		link++;
+		free(str);
+	}
 
-	if (!strcmp(str, "none"))
-		proto = PROTO_TCP;
-	else
+	if (link > 1)
 		proto = PROTO_SCTP;
- out:
-	if (str)
+	else if (link == 1)
+		proto = PROTO_TCP;
+
+	/*
+	 * Since corosync3 retains rrp_mode but allows any value,
+	 * we should precisely match the rrp_mode value (none,
+	 * active, passive) used in corosync2 env.
+	 */
+	rv = cmap_get_string(handle, "totem.rrp_mode", &str);
+	if (rv == CS_OK) {
+		log_debug("cmap totem.rrp_mode = '%s'", str);
+
+		if (!strcmp(str, "none"))
+			proto = PROTO_TCP;
+		else if (!strcmp(str, "active") || !strcmp(str, "passive"))
+			proto = PROTO_SCTP;
 		free(str);
+	}
+
 	cmap_finalize(handle);
 	return proto;
 }
diff --git a/dlm_controld/dlm_daemon.h b/dlm_controld/dlm_daemon.h
index 4a533e3451e2..3ed4e235a83c 100644
--- a/dlm_controld/dlm_daemon.h
+++ b/dlm_controld/dlm_daemon.h
@@ -176,9 +176,9 @@ EXTERN struct dlm_option dlm_options[dlm_options_max];
 #define MAX_NODES	128
 
 /* Maximum number of IP addresses per node, when using SCTP and multi-ring in
-   corosync  In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 3. */
+   corosync  In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 8. */
 
-#define MAX_NODE_ADDRESSES 4
+#define MAX_NODE_ADDRESSES 8
 
 #define PROTO_TCP  0
 #define PROTO_SCTP 1
diff --git a/dlm_sand/sand_internal.h b/dlm_sand/sand_internal.h
index 4c2fc0897051..c17287abcd47 100644
--- a/dlm_sand/sand_internal.h
+++ b/dlm_sand/sand_internal.h
@@ -138,9 +138,9 @@ EXTERN struct dlm_option dlm_options[dlm_options_max];
    Copied in libdlm.h so apps don't need to include the kernel header. */
 
 /* Maximum number of IP addresses per node, when using SCTP.
-   In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 3. */
+   In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 8. */
 
-#define MAX_NODE_ADDRESSES 4
+#define MAX_NODE_ADDRESSES 8
 
 #define PROTO_TCP  0
 #define PROTO_SCTP 1
-- 
2.43.0

