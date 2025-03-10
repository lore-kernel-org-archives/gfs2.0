Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD72206B7
	for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592198; cv=none; b=CpxfmxOmU8IiFIQ/EaPNjpHizO+Lcv95UhrvWtWXQ4xaN8vinDwzFkZgN951WPZ4IW1oQsz2VarB3NC6asojcEoBSWBoMtagdrIBcsk6Lq1yKrMEYmHOCrJ7YULCDWLTeUMENORVlI8e9mhk+L7IJsrR2dZ/ya93c9L1LWzG4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592198; c=relaxed/simple;
	bh=65PL2PzCZmIfdILq/Xfy2PwUcB+ICnXa7UcCEmoxgao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mag7AID0oXeNd6yZXyP70DzGgkQjwEMYnDhInrEh6tzC8R8Eke0XcuG+rcySwztEX5QL3jOJKpFZfnqV0LZhP9aseu94pQbLBiWmyv2GpmNVEZmKnu8aT6JQwk65mkjjiwfmquGuQecrVpqU7sfBqu49VAbxTSqZz1npvb5G+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fMEORhiN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fMEORhiN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39130728338so141626f8f.0
        for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741592195; x=1742196995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vh6KskP/TF4KRWImzSkY6nUbqAXxxnY1j7SjB4whIc=;
        b=fMEORhiNud0UnS+t/LpbSqF/hIdBTdyoQt/gEXtZfm/bLqDv1g33JJnSxb6ByRXn3j
         /2LhLOd4CQKr9oWmldFPqsRhikT+gXiUEsTuNkutFo979785AhZgeK5GgHbzO5oHMhRs
         646VtNWZx5IneD1d92mtGiHAcCdlCEc1IkR36EcxxBhaAgEm8z10nRnFkn32u74/HWgV
         h6DboY/ae0qRJ06Q1zZTWp367CEvUULXNfP/TcNJDf8D1hslsve2kvOpw/2UbsChbXOv
         FZZwPoASrnwEcRPwDvRinfMJlqyNhi1sd/Pjsbdowz4M2wG0LmYBF8rI3wzQFK7mck7Y
         bUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592195; x=1742196995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vh6KskP/TF4KRWImzSkY6nUbqAXxxnY1j7SjB4whIc=;
        b=QukFRH8GMq8zhP7tEyyZ9t0Jsfzm9kl80duK04Of09MI4a/4wY5GIH6r2juMgbvPdW
         ObzjxJ/+g5+LizYhRF6gjfySH43sxNoWygBV/pW/7NJQ7DSIflI4fqLwGVAbomcnyXpi
         fIjnP/nMCEZYGeyzhqI/yVCJiPzlqvKKG7NN5EzDj5Gr2Y7pzg5wxoPUej5YENgtE82+
         m2gpMLYaNjOmlkpMJQ1G/lO9BVAo0+l+JZROWSLig1aSJXBVEDtofTtdKJQpFftejoE7
         Qfh/aQnfglTRWmk+0cZ27g68BIvz/qUhABhWeEhhnzfFTovhZ90Pv7ly5mw6MZ+axb3o
         YfyA==
X-Forwarded-Encrypted: i=1; AJvYcCXpymfV7CL5xCMel0Wxg7DDz1NDx3AwbNNdrxXsKJm7s2folZY2P7O5toQllhvvoOmHDI+0@lists.linux.dev
X-Gm-Message-State: AOJu0YxVA8FlBm/vuHq5JNILOR1rZcYVQVOt6RMOCLB5e8MorMyq2/w3
	+4HI2plt/yX9g2mRPytQ4EWSV/GnbmSzS8uNEIEkM/hvOscHSWboTs6eZljZ0FQ=
X-Gm-Gg: ASbGncsI5C0NBxL7EPIPFwE2xGFoPqkgKmSBORfoi6p5IdIa0mfrJ1gXrRzUtGoNYmn
	A5d9+P1umXPQgYBt3dyBs1HHf6x6azhKPhnQuUcO42F455rEJUA7hn/eeDjRHhGg4FFy4Mk+0p8
	h3Ee4X5OaH/nojKQn+7Hndkb5QCMTFrIAhd5yZclLknmqOh3rgmMHnCPLEznw5OrMnZwH8c1bLT
	IR+PBSR1Es4AdlnGUrx9S3DhU0iVe8pJ/mkGHhLYSxK5tAdF/nJ2AV9zjDvuMhQlUwYYW+3VwSW
	1d/giJdQWPRpATIz4ArOdxRLjNXGyFBtH7tdQZc4fysXQujHlTx1rtlzUw3Mk3z1lTXYcw==
X-Google-Smtp-Source: AGHT+IH9SWWA2027InJghPpxLdT5aAYxuczjcW+JphK5PWmGbatAj4xgOfUhs0IQ3R4dWtVGealRog==
X-Received: by 2002:a5d:64ec:0:b0:391:2acc:aadf with SMTP id ffacd0b85a97d-3913bb4709bmr1498233f8f.6.1741592194866;
        Mon, 10 Mar 2025 00:36:34 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f9e0sm70806935ad.113.2025.03.10.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:36:34 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	glass.su@suse.com,
	zzhou@suse.com
Subject: [PATCH] dlm_controld: remove 'detect' mode from config item 'protocol'
Date: Mon, 10 Mar 2025 15:36:20 +0800
Message-ID: <20250310073623.18607-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the 'detect' mode for the configuration
item 'protocol'.

After this patch, dlm 'protocol' behaviors:
- TCP is now the default protocol.
- Stop trying to detect:
  - use dlm.conf or dlm_controld command line to switch from TCP
    to SCTP.
  - corosync.conf 'rrp_mode' is not supported in corosync 2.x env.
- TCP can work with multi-link, but uses only the first ip address
  from corosync.
- SCTP can support up to 8 ip addresses.

Note: This change requires a corresponding update to the dlm kernel
function dlm_tcp_listen_validate().

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 dlm_controld/action.c       | 39 ++++++-------------------------------
 dlm_controld/dlm.conf.5     | 11 ++++++++++-
 dlm_controld/dlm_controld.8 |  2 +-
 dlm_controld/main.c         |  4 ++--
 4 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/dlm_controld/action.c b/dlm_controld/action.c
index 60eb22a78c56..10f0f67387b1 100644
--- a/dlm_controld/action.c
+++ b/dlm_controld/action.c
@@ -21,35 +21,6 @@ static int comms_nodes_count;
 #define SPACES_DIR    "/sys/kernel/config/dlm/cluster/spaces"
 #define COMMS_DIR     "/sys/kernel/config/dlm/cluster/comms"
 
-static int detect_protocol(void)
-{
-	cmap_handle_t handle;
-	char *str = NULL;
-	int rv, proto = -1;
-
-	rv = cmap_initialize(&handle);
-	if (rv != CS_OK) {
-		log_error("cmap_initialize error %d", rv);
-		return -1; 
-	}
-
-	rv = cmap_get_string(handle, "totem.rrp_mode", &str);
-	if (rv != CS_OK)
-		goto out;
-
-	log_debug("cmap totem.rrp_mode = '%s'", str);
-
-	if (!strcmp(str, "none"))
-		proto = PROTO_TCP;
-	else
-		proto = PROTO_SCTP;
- out:
-	if (str)
-		free(str);
-	cmap_finalize(handle);
-	return proto;
-}
-
 static int detect_cluster_name(void)
 {
 	cmap_handle_t handle;
@@ -870,12 +841,14 @@ int setup_configfs_options(void)
 	set_configfs_cluster("mark", NULL, optu(mark_ind));
 
 	proto_name = opts(protocol_ind);
-	proto_num = -1;
+	proto_num = 0; /* default is tcp */
 
-	if (!strcasecmp(proto_name, "detect") || !strcmp(proto_name, "2"))
-		proto_num = detect_protocol(); /* may be -1 */
+	if (!strcasecmp(proto_name, "detect") || !strcmp(proto_name, "2")) {
+		log_error("'detect' mode is not supported anymore, will use default mode (TCP).");
+		log_error("see dlm_conf(5) for details.");
+	}
 
-	else if (!strcasecmp(proto_name, "tcp") || !strcmp(proto_name, "0"))
+	if (!strcasecmp(proto_name, "tcp") || !strcmp(proto_name, "0"))
 		proto_num = PROTO_TCP;
 
 	else if (!strcasecmp(proto_name, "sctp") || !strcmp(proto_name, "1"))
diff --git a/dlm_controld/dlm.conf.5 b/dlm_controld/dlm.conf.5
index cb13eaf0db28..073baf883b38 100644
--- a/dlm_controld/dlm.conf.5
+++ b/dlm_controld/dlm.conf.5
@@ -77,13 +77,22 @@ enable_helper
 
 Options with (*) can be reloaded, see Reload config.
 
-.SH Reload config
+.SH Reload configuration
 
 Some dlm.conf settings can be changed while dlm_controld is running using
 dlm_tool reload_config.  Edit dlm.conf, adding, removing, commenting or
 changing values, then run dlm_tool reload_config to apply the changes in
 dlm_controld.  dlm_tool dump_config will show the new settings.
 
+.SH Protocol configuration
+
+Since the totem.rrp_mode configuration item was deprecated in Corosync 3,
+the DLM adjusts the protocol configuration item's style to ensure DLM
+functionality on both Corosync 2 and 3. The change is that the protocol
+configuration item no longer supports 'detect|2'. The default protocol is
+TCP if the user does not specify a protocol on the dlm_daemon command line
+or in dlm.conf.
+
 .SH Fencing
 
 A fence device definition begins with a
diff --git a/dlm_controld/dlm_controld.8 b/dlm_controld/dlm_controld.8
index 3aab388531df..d72ebb299f7d 100644
--- a/dlm_controld/dlm_controld.8
+++ b/dlm_controld/dlm_controld.8
@@ -31,7 +31,7 @@ For default settings, see dlm_controld -h.
 
 .B --protocol | -r
 .I str
-        dlm kernel lowcomms protocol: tcp, sctp, detect
+        dlm kernel lowcomms protocol: tcp, sctp
 
 .B --debug_logfile | -L
         write debugging to log file
diff --git a/dlm_controld/main.c b/dlm_controld/main.c
index 1c4333373617..6fb6dffeadaf 100644
--- a/dlm_controld/main.c
+++ b/dlm_controld/main.c
@@ -1817,8 +1817,8 @@ static void set_opt_defaults(void)
 
 	set_opt_default(protocol_ind,
 			"protocol", 'r', req_arg_str,
-			-1, "detect", 0, 0,
-			"dlm kernel lowcomms protocol: tcp, sctp, detect");
+			0, "tcp", 0, 0,
+			"dlm kernel lowcomms protocol: tcp, sctp");
 
 	set_opt_default(port_ind,
 			"port", 'R', req_arg_uint,
-- 
2.43.0

