Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51021154BE5
	for <gfs2@lists.linux.dev>; Fri, 20 Dec 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678895; cv=none; b=kJToz1HZ6P8w0AOzYBRqtOBOe0vDYAEjaTw+RCy0dfWO8xwxUOykG7qwkZXgeKswhvyhI9d34xdcglBCzjeRrPPlFGs8yA9HsYprkHvpWgf8euPd5HEZ0b9oG17JIeVe5cDmxeuyqvuR0GnoHWCsFldJ8y6he5Ti7UcAroRjilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678895; c=relaxed/simple;
	bh=9Z+xFWM0SFlUQdRL68QdW0WgmyTpBh9yaK8MbGuUiDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahL+VrWN7wZgB2HWTU3EnyqSDAAXXSkG0TiQsBn1BgvYox4nVjR/4wYtOIsiO71NEr2fE9cb3++GrCKauSzVnSiRsiJfd3APJmlErmeTVwA2L4qXDmrf0Kjp2rmqqp9BwuFy+6p2RvY4oCcB9udt2cX+pyyi/YbYz6lZqowmLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SDKw6YwC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SDKw6YwC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6a47a3da3so26306066b.1
        for <gfs2@lists.linux.dev>; Thu, 19 Dec 2024 23:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734678891; x=1735283691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY8BicOaAm/nH8Nmme+dKkUkkjDlD2mOrhuVRQJ6m1o=;
        b=SDKw6YwCDvFjskfamx7JwEqXe6NQIrLTWhcGM/KlEt69ZVjLRpnU8pWdpqurEDLKWy
         r10YD+JbQZeD+Nw5QUmAJ3xJdjCtZw8IqIFTOdRc8K5I+XfyRTl3s8DP940UDqAby+yI
         q2x5UYSeJDLLaR5UtRrOYujOwwARUrCH6kXWoDfgdT79x3EWiJ155TEHBh6L/gnqJgex
         CwKDXwFDOlTofbPXE5seoPW/oHnwmW3HX2FNYGpO/xZVzt/p1bYDWUPPxtlz1Ab+5lqG
         RS4QBwoq2e+9ImslxsP0YglIkRXFeUPWECGhJYuVqghN3Ie11jEaP6LneJ6lJq1soB+N
         p4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734678891; x=1735283691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MY8BicOaAm/nH8Nmme+dKkUkkjDlD2mOrhuVRQJ6m1o=;
        b=ivm8W29iWbViKY2zsfVO0BsAGsqy5vE2/MuX8IaDp12URGGEDz+tm+SIbVd+yQxsVZ
         hkyH6lndS/xFtvEvz4VS5IcNfukQpRPS6jGYinSNiP3eu2rc8cRj+4bQcdcihsevfLUA
         a0FDywSrP/wwhjPHA1fx+XO49ZhzCupVF2yjW1fs40zdLfhX6YEG/DgSSO+jvDE4C76w
         BrQJ22bgFvunfOXyak+6GgDmQKNIPPqG3nIsxeSvlRxF5EQLTG1YeQZ8glNmuYScGPYQ
         5BHSwR8MneOTuGO+MSadzT7LoGBIZR56e2zNlACabQUjuLGdpYe7hGnCUfv2370BpQq+
         FMnA==
X-Forwarded-Encrypted: i=1; AJvYcCU+LBuODmvgCm/Avf+x6dP+sxFi3lg7c6w0LWpqApgQwMZR6p+wikOfN/ACpIbNcXIzuZTC@lists.linux.dev
X-Gm-Message-State: AOJu0YwoQmufqZowR+9dJDdZn+ubRbzw6Odhc2mBGzN6GJaXOhFd3jxH
	zubhFEeIuPR5DMcTuyOKAza2kMiXbZyTtbLXagGoETlofY33wZ1whZwwI9PccJ4=
X-Gm-Gg: ASbGncu4pDEXtceHE2irIMfQa2QIeUGVTHbSflvHTziE/BC6brcWY6ovaA4FUhjiYBL
	lTZi+uOGTzH6TQLAQgSnEiA02CyckVfJiHCkEJenXNu1VA9uKeCRr/P9igHEJ09QdDDf329usHm
	WXyj4MkGhAuQC0wkYAxdRe/RorEYU5p2wY/mRHfWDrpM8bouFhgAb8qlRgTwcN9hLuvgpH9LHf0
	I5MwKHZXGQqlq6lv98t0UbuxeGmoJwVk7OQaGBcTwaWqQDTNWNnoMYf/UYn1bxmGoPkdJc=
X-Google-Smtp-Source: AGHT+IEJLH+6Vydgd15z1cPoHSdALgblpgGzrvDCqGjqQ/NRXZpkh2Fgki//DrulwXfUeFCzt6oDQA==
X-Received: by 2002:a17:907:9621:b0:aa6:a9a4:7bd6 with SMTP id a640c23a62f3a-aac2adb6962mr48437866b.6.1734678891527;
        Thu, 19 Dec 2024 23:14:51 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97432dsm22817355ad.110.2024.12.19.23.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:14:50 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	gfs2@lists.linux.dev,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com
Subject: [PATCH 1/1] dlm_controld: support corosync3/knet multi-link
Date: Fri, 20 Dec 2024 15:14:39 +0800
Message-ID: <20241220071440.16803-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220071440.16803-1-heming.zhao@suse.com>
References: <20241220071440.16803-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The totem.rrp_mode config item was obsolete in corosync3. And
this patch gives dlm_controld the ability to detect multiple links

And this patch should be work with updated kernel dlm module.
Because the DLM_MAX_ADDR_COUNT is changed from 3 to 8.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 dlm_controld/action.c     | 31 ++++++++++++++++++++-----------
 dlm_controld/dlm_daemon.h |  4 ++--
 dlm_sand/sand_internal.h  |  4 ++--
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/dlm_controld/action.c b/dlm_controld/action.c
index 60eb22a78c56..48a30a20f00f 100644
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
@@ -33,19 +36,25 @@ static int detect_protocol(void)
 		return -1; 
 	}
 
-	rv = cmap_get_string(handle, "totem.rrp_mode", &str);
-	if (rv != CS_OK)
-		goto out;
-
-	log_debug("cmap totem.rrp_mode = '%s'", str);
+	/* corosync3 supports MAX_NODE_ADDRESSES links at max */
+	for (i = 0; i < MAX_NODE_ADDRESSES; i++) {
+		snprintf(key, CMAP_STR_LEN, "nodelist.node.0.ring%d_addr", i);
+		rv = cmap_get_string(handle, key, &str);
+		if (rv != CS_OK) {
+			/* we just care the link number, ignore all error here */
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
-		free(str);
+	else
+		proto = PROTO_TCP;
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

