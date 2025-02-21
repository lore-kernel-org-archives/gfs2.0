Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D6274BED
	for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150588; cv=none; b=qEmVOixvv6XqnsCd+MSv4sbik6Vl3x8JKF8vkD0upg0KvFKFIAu0QCEfdSLXs6PtJ0Sq459L+6Fq6oJUxjekXYm5tbyXy5i0rh+Odwat0iDgoWVDzsuGiZvcPCPiOfs+txNzdwPlU0Pj5nk9VZVE1yRfZfwXvHL5s2Wh4ZU7YTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150588; c=relaxed/simple;
	bh=FR2KCLyu/2GbXcPjPH/X6xelUoeR8UTPwNQO/zPfKgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK6MNH7kawxuZbnhtU4C4nbdc+iaepn0rpK4L7ZVK4AqRqWJQd4NQQUfUeckQHHvJZy9TO6RaxqE/bbbWEcqzF8E70Xa1VuD7fRjBg2R33T2x6yxBYUmXoKGlOE4Aa6XiOclkknD9yCu0uQlXK2Jz7ei51MLkAZwFAkDpGatjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aR20u71M; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aR20u71M"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f54938d1bso113239f8f.2
        for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740150584; x=1740755384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJPdyizOB0x21fxn9rOUEk28N8cFU5WRv3xfy8oNV7U=;
        b=aR20u71Mm+DUilx0F6Qzap322Gr4fLWqcafnIQ6F2xSfFXYAmDIic8Gn2jWbYOBxfR
         JRwMgwaSj9NdD6wLKhNk2zM43F08o35YA77ibeIxxpK2cV1YGdtbSJkLbcptknHeRsz1
         IoYTFy8UfI/95FHN0ydzI4n5JfWzodRJRx/7TteCQGN0hAZHBdyTvZrH7BJPhJhA1YX0
         Jo4W+3Dg+WkdQ66wLvt4jlEJOb01jEuqv0EV12U4XeAEvwDGNvmh7jpIdi1LxAdB/kZF
         A2NbbEmDWpYB5LSdv3+1Ho8+j2bCwP0un+kCX+nh5VqBoVYVoKCYD0+cc6k2mNZ/nUvb
         +nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150584; x=1740755384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJPdyizOB0x21fxn9rOUEk28N8cFU5WRv3xfy8oNV7U=;
        b=CzovW2mw/xWeUrCaNMaLrSsLzWvegIHyP7CWwxpnu2OeMGIex4GwpVJay691J3ax9c
         19ZdEZjON2pRvaLk+QlIjyLNaPpx7Bo1Vz4o3D4Y8ixOjSpEDauT+oC4Y0juSttS9w6x
         gy/Ud6NIvJDoVnugtQQ5K5fBcHl//qqjv5wDtj4vIIAgsdyic86HFsF7fAp+RwGCQDY9
         tL58x6KIb3xRNFXeWE20IBmMbDQ8jpqfLVv/wBU1Q/riOgQ2p6p2ew4LmmSws0i2CON5
         0KtG9aub53R9k0zQPOg7cf66d7TGKLT94B+sBHKRqrrROo1v0+0uYhd5l+nZCaYnlNEn
         KqAA==
X-Forwarded-Encrypted: i=1; AJvYcCXv6ylmhz39GjYq0g4k80Pxf+qKK3ddGHTUpjTqqaNGng1fCAy1Q3ifv0qSMroMhZxpH+IJ@lists.linux.dev
X-Gm-Message-State: AOJu0YzeMq3rxwcNYe11iM5VWEvuRJpN8ApTUWmkrdU6KuAbigHwAtQR
	cBfK9Z21gNvzaeo2S0IA+i54PhZOCzaIh9Y8/2vaa5+8cRztvPlSGf/IdKSDPVY=
X-Gm-Gg: ASbGncv5fMAN1fQZ4kNOIoShxexvFW0UWk/5ObeAQNnM0gUyXpO4wzUeFMqggbKPDCa
	MMxzulH8C8k6CwT//WdFs6nvKengkIB5uYv+RQ/2yUUS3GM4SoKNU0LoN1tjUdvXy0vQL834bMj
	bkAFX+5nIgoiljjn9oc8Ixd0VYN71hicNjIEINJjks5AJ0nqiIIZdkSSFBYqYLTFRORR+HmZIxc
	piwCC0dT5qZDcgO9QlEMWKav9o1sOpxFE4P6q4q4hi2lVMwo0kHK6U6VIED6MarXTMgSPcWP8n7
	vXc893htTxgdqkB6jMP2Ay710u1zr3yi1O6ekDMQ
X-Google-Smtp-Source: AGHT+IEYhKRSzvN5bpBNp8gicKd74N5BI8L/jo6zMc8u0JP02XZ4Dg27sYujb4+HEy2JJKIfIHcfWw==
X-Received: by 2002:a5d:47a3:0:b0:38b:eb86:694c with SMTP id ffacd0b85a97d-38f6e4bc8c8mr1204056f8f.0.1740150584500;
        Fri, 21 Feb 2025 07:09:44 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb02d9a9sm1505643a91.1.2025.02.21.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:09:43 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com,
	glass.su@suse.com,
	gfs2@lists.linux.dev
Subject: [PATCH] dlm_controld: Support for extended value of kernel DLM_MAX_ADDR_COUNT
Date: Fri, 21 Feb 2025 23:09:35 +0800
Message-ID: <20250221150937.21642-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch should work with the updated kernel dlm module, because
the code changes need to be aligned with the DLM_MAX_ADDR_COUNT value.

Another notice is that with the current dlm_controld code, users
should explicitly add 'protocol=sctp' to the dlm.conf in a corosync
3.x env.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
---
 dlm_controld/dlm_daemon.h | 6 +++---
 dlm_sand/sand_internal.h  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dlm_controld/dlm_daemon.h b/dlm_controld/dlm_daemon.h
index 4a533e3451e2..c902228f890f 100644
--- a/dlm_controld/dlm_daemon.h
+++ b/dlm_controld/dlm_daemon.h
@@ -175,10 +175,10 @@ EXTERN struct dlm_option dlm_options[dlm_options_max];
 
 #define MAX_NODES	128
 
-/* Maximum number of IP addresses per node, when using SCTP and multi-ring in
-   corosync  In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 3. */
+/* Maximum number of IP addresses per node, when using SCTP and multi-[ring|link]
+   in corosync [2|3]. In dlm-kernel this is DLM_MAX_ADDR_COUNT, currently 8. */
 
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
2.48.1

