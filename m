Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E536AA3
	for <gfs2@lists.linux.dev>; Mon, 18 Dec 2023 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM7IHFeo"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e2bd289172so21613397b3.0
        for <gfs2@lists.linux.dev>; Sun, 17 Dec 2023 21:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877776; x=1703482576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDry1DQ37KMIsh4yLwGrn53JYZWwufNx4QaZRjP5i0E=;
        b=IM7IHFeokSGhj4CL0YlJUD1I1qqwkk0F9WfEuQociV1+h6ZgXfKAl6rNWy1R2qiasd
         K2Qni6cVMl4M3wzTHvYN8rsDIiJmvsGRTwUwAHJvK1mz+iTrXSraZQb/4CEt2dBqxKsH
         mZezJIkIvzhTrbPxKEpsu1LcKSbA9yiVhIfRhaIKf7mZvDLf0gvfA5PQxJHgnc00NbC3
         7efgIu/GdwkoYqJNazOGN9ooDvbtIb0Pm5BOEcZxQHRh4XVbvrtLq5ZR/js91D1olZn5
         l6miaoPk6PV/FYpfnH6i0MQeIBPP4NGrG0tofp8hmmV4JZUQebkmh7QAEHHItq9v2QQJ
         rjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877776; x=1703482576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDry1DQ37KMIsh4yLwGrn53JYZWwufNx4QaZRjP5i0E=;
        b=t4QCHus7NUSZmXylX3opMtBZx7U7CpU8j3CEoSg8JLn9MYBbpoPsy/xhGtBlAujQKd
         7UhrRKihPboDnyj3ThDdu2dccDBkcPbR8/GEdRPwFMMKROWcS71hNpAYJ6D/l5gb2sI3
         N8cx1hHkxlAnnhNoRoyIraMZjPYdnn+3qIoWWrbNbXq9JT9WFcYXKXzIiTVHV3VNFcOc
         fcM1OIBLIN8MQbKy7DmwvfSkJ/ihcQtWDWoz2zBjoC6Fe1wPX2niUo/iOMzHiD1uMXLa
         IZEzUn5xg8u8u34tLTgvxdZTGzhxRm4akVbkYr9J93RYrSyBTrl7ZgrDM0lr8xwqK8eK
         eTxw==
X-Gm-Message-State: AOJu0YxwkcWfBC6K0TYVhLYANf3LC4BBzGr7ita3eNpA63+LXvjkuYwj
	mdTG/0z2QTma2rWla4Pund0=
X-Google-Smtp-Source: AGHT+IGvah0JsjA2F+IYd4urJNuYVMHs1pzrEYWk60U8sKdbaHJuXTLV80ktdp1fZPke6tGzK9vS0Q==
X-Received: by 2002:a81:5c87:0:b0:5d7:1940:dd6e with SMTP id q129-20020a815c87000000b005d71940dd6emr13503783ywb.68.1702877776601;
        Sun, 17 Dec 2023 21:36:16 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id o14-20020a056214180e00b0067aad395037sm2430271qvw.60.2023.12.17.21.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:36:16 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/2] gfs2: Use wait_event_freezable_timeout() for freezable kthread
Date: Mon, 18 Dec 2023 13:35:58 +0800
Message-Id: <20231218053558.1200822-2-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218053558.1200822-1-haokexin@gmail.com>
References: <20231218053558.1200822-1-haokexin@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A freezable kernel thread can enter frozen state during freezing by
either calling try_to_freeze() or using wait_event_freezable() and its
variants. So for the following snippet of code in a kernel thread loop:
  try_to_freeze();
  wait_event_interruptible_timeout();

We can change it to a simple wait_event_freezable_timeout() and then
eliminate a function call.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 fs/gfs2/log.c   | 4 +---
 fs/gfs2/quota.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index a268b69bb636..20059fc913e7 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1331,9 +1331,7 @@ int gfs2_logd(void *data)
 
 		t = gfs2_tune_get(sdp, gt_logd_secs) * HZ;
 
-		try_to_freeze();
-
-		t = wait_event_interruptible_timeout(sdp->sd_logd_waitq,
+		t = wait_event_freezable_timeout(sdp->sd_logd_waitq,
 				test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 173581736a6e..05ef8409b614 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1603,11 +1603,9 @@ int gfs2_quotad(void *data)
 		quotad_check_timeo(sdp, "sync", gfs2_quota_sync, t,
 				   &quotad_timeo, &tune->gt_quota_quantum);
 
-		try_to_freeze();
-
 		t = min(quotad_timeo, statfs_timeo);
 
-		t = wait_event_interruptible_timeout(sdp->sd_quota_wait,
+		t = wait_event_freezable_timeout(sdp->sd_quota_wait,
 				sdp->sd_statfs_force_sync ||
 				gfs2_withdrawn(sdp) ||
 				kthread_should_stop(),
-- 
2.39.2

