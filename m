Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363220A5C3
	for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150383; cv=none; b=U2gzsEV+n9FBw8u3fpTBFjC3fwHD1yW25dMOanrmVJ00XRO97GixAS0U3Uuc0nT0ClPll+jtM7QnNTq9QMaN7k48ICqh23BvB7PN+oW9V6Vkn+z02Rh2cJV5er8WDbklZBQ2z5okoG52TPOpmFZqmfyp1YJlHrbSYabQ1brQOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150383; c=relaxed/simple;
	bh=FR2KCLyu/2GbXcPjPH/X6xelUoeR8UTPwNQO/zPfKgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9OVDvMeS+LlhtPk70v2DYAe8zlFL2Gv51uY30LrcaBxFHChRey1BZgBBiAasH/pIAAQk7PS8cfv2YVTUEqJ/xkAwppFDM/RdoYSaz8G9X+u1SFHso9eddaVbQVLQkxuB05DURTh/GUxk/Qbbiii8K0C1vx60W6b3/iGmhx2/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUHJ6oaL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUHJ6oaL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38da6a1a20bso85884f8f.1
        for <gfs2@lists.linux.dev>; Fri, 21 Feb 2025 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740150379; x=1740755179; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJPdyizOB0x21fxn9rOUEk28N8cFU5WRv3xfy8oNV7U=;
        b=NUHJ6oaLNplyXa9VX7ow3S5Tu02ICg2R3QQuscd/FotI3e1QUJUDEr5NFn9iOAxhae
         2gHuCbmIu/6XMp8TKxruKItgYxbljeE48hvdhrl5n6WfZPZBaC2hZea/qDVCMzQGw72e
         rBJLARduPz76cHMdvBm5/UxDkiraajSw9hWUs0e02sHX09EWwhwFJXlv62SnDpuE9tgP
         SOcDL3QgbA0d8P3EhvTTlIn8mfGSuTocXU2kU/WVZNR3NjQCJJvQNkNBZuvTwD+rXwg8
         Mn7AWxZDuDkoKlBNlJ1Joe3oYSRhl24bxJ3kIixzIEbBrG9+49NcCOGR7Hwnd1paWfoH
         6jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150379; x=1740755179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJPdyizOB0x21fxn9rOUEk28N8cFU5WRv3xfy8oNV7U=;
        b=hf8B4JcqUr2TQusb+W+x8wwlkTiogxZk9qPLim9YtwMTN9t21YH/4V+nGnYs3oDNM6
         GE2l8mvmSrE9QEoHI84uDb1Yzp2bosdEhtGcDG8R/ipEz2USlT5J05+aUd8bh0xv7YZl
         gcRz+IvGRLsR73ArjxfUm0eSeYAdV+jKDmTIs10GPcjEAJjUOWtHjMfDEn0V+3ZtcXB6
         zZYxNwwbQaywRPwM7ze3/Cb+U2e7uZ+Gnf+5ZhbTmNYzRtbte7oGXCFUNHfmopGsaUtW
         6GsPLpIfh15NUTd44LWm8wu+QNoOR6zMoO6FiGhjsctbKeH4iFbLRymsm+gZkx+YiteR
         Gerg==
X-Forwarded-Encrypted: i=1; AJvYcCVVKV/4Tow6Eq8VaR0+RvUO3TM2o3Fb+dsjiZYEGGvQ1W2e9Kr99J6cBmGb2fddw9UF4kyo@lists.linux.dev
X-Gm-Message-State: AOJu0YwsZXkejQ9ulfLT9cqsLBjK4syeOjyrcRiUuuk6cgLIirt79BQy
	K92Amzz1b5T6an8U2eTXzAj7ZDN5WSTfLNMdZCyJe+OM01gPgVPoBtPNMi8IpUE=
X-Gm-Gg: ASbGncuU6lYzYmAXJrnrE4ppkRgKdFyLSYH/NttZWMgOipQd2p1fvIPIY+wAUJjTKkC
	wk1XiB/YZOFf9U6DrHB+A3rh7kL8XiVFIs3SWHzoXKVk07zefwngFvS8x4SlT0w52lUoKUcBSl1
	x1Vb3PYqLA5Cr3QvmhzYs4g7MEvv2+fbsa7BXxCanCAlkBS/oKLW3Xe3CoDbwnYH1YuHctQoip2
	1E15x+lyiVlS+3rZv7w1oEVfBMtWMTcjcD1pFLSCXH5vQbEQrQfiIqETZsYSSM38HKJ9jEnvsm/
	sBTHW86wKaRQWxE8FKOWma1ovP8Ve8mJwJRUUFd1
X-Google-Smtp-Source: AGHT+IH+Zri4YaXeYFzpE2FfO44Z/CTCJu/G+RWroH7nYpH208nCDGfmTM08UHJ/OhgJmFRWH8m3TQ==
X-Received: by 2002:a5d:5f83:0:b0:38f:2bfb:d98b with SMTP id ffacd0b85a97d-38f6e7571cdmr1302723f8f.3.1740150378761;
        Fri, 21 Feb 2025 07:06:18 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596103sm136584285ad.247.2025.02.21.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:06:18 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: teigland@redhat.com,
	aahringo@redhat.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ccaulfie@redhat.com,
	jfriesse@redhat.com,
	nicholas.yang@suse.com,
	glass.su@suse.com,
	gfs2@lists.linux.dev
Subject: [PATCH] dlm_controld: Support for extended value of kernel
Date: Fri, 21 Feb 2025 23:06:07 +0800
Message-ID: <20250221150611.21167-1-heming.zhao@suse.com>
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

