Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070C161339
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229104; cv=none; b=iBsf7Uh2Wl+ry8x+yO5I2kQ5ZxifVbjmcAAC3/CTmJsmOkjdLE2tNsNACTAk7pmuBq0/qsVtJQa2VyAaT9GBBavZrWBRei4HszSds1o5IIaj4UN3tyP0/ggFEz3Nt7ZdAHdeIErXkPVmkCoqc5ABAv9I+4zYhPVVwe3BB0eUtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229104; c=relaxed/simple;
	bh=qausY9NaTn1Dmt/1fWvpjV6gSoo0TkpL7RjFx1j8ing=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StcBZuwr1x+8B/ee56KlTm4G/C25bFPSE+KfsC34asdlEASyO/D1kWdOj/NOHcM1NthWsNgMHuNfDVquNlEJEsSq4a4k30CzRs9r1i7tDO3rIiNxShGvbugwDY+krXgzVURsAZHXIGOkkoiENGkgvrQ/KJWH1t3kgpXwqSzBctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=asKtjzpb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="asKtjzpb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d3874c1eso135831685a.2
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229102; x=1723833902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=asKtjzpbRbwSzZBWGDTGQAzemf0UlvXQWhnHEdUp4mJlG2t3t6DP2VJfpHdb++aBnD
         NIkDyTRNRSNewqFZPNJDOlK+HPuAVI9IXnffzwfUZkDGcVWpHyJ77XdfjcO9SGXZPpe6
         se98/ivBlYAp2KVINvBDXBEt0++71i5j+zNZsw4T7rWmWMM1yViLmgg0akdVi6eqVNrV
         tjiKTQdyb/Izvxy0xRwrOpjvTgcM9fobmaI9rZFr28o++ZtgnCNP3Jiokt36AUahqAfr
         StaRlag8lywNCxWp2qQmW6iUffAaiZUckUmdLNltMLy4oaj+xBL1Iu9HxF+EKffZa1nb
         UC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229102; x=1723833902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=fw51f6wm0fRogNpowvLNdokItDfSh7b5ep8MMqXSmmHwSHFsuag/ytKm0l8IkqM1CI
         jIQH/odSzaUzTwgJYaQiAWg+YDICRZO46e6hFDRAR/NHzb6Txz7djFbVPYpdYqjpJIMe
         sDXQSobuRheOL27Z7JMg2hDUYn8rqgGvti0D2gY3QRydcPW2vD9L4oLxPjM16bsUv9V7
         IirQ4HgWCju1SN7nOXfC44CF4CZQw7z99JeGooyup9axj03NkWY75a+YcdUBxSpWNQGY
         lHpqMlzhdMdggOJa7T+VglBm+Wl6Tn90bYZUWIaZqjpgzP4G3xBjm89GF7J2OtCbFRBx
         A9LA==
X-Forwarded-Encrypted: i=1; AJvYcCVzJ/BZiEEtXFThSIKkxmEivHyHrpqNp2y+65DModjSGP7OxVn2bjDvkgyJQnlTs6sgYi9xAuYt9P0RUf7ceElAPXsXeA==
X-Gm-Message-State: AOJu0YwxmiGFbahZo50ND5p965rHBfbX5rufgJ/oh/wPAEYbkeaBBWdD
	GDR8hoURDF/SBtCM5Tq3D9vRGObXh+Hu7WINFZhp7wSzwsHv+Q1wLAfJoApGY8Q=
X-Google-Smtp-Source: AGHT+IEkhpIMThqLGfjbj+pLIWeCnA5xHzdhnlhYpQZelrB1iG6KHPgcncoqW+ZwWfT8YtGLgnfUUw==
X-Received: by 2002:a05:620a:718c:b0:7a3:785a:dc1c with SMTP id af79cd13be357-7a4c182c833mr251102085a.50.1723229101933;
        Fri, 09 Aug 2024 11:45:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d829d1sm4225385a.68.2024.08.09.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 07/16] fanotify: rename a misnamed constant
Date: Fri,  9 Aug 2024 14:44:15 -0400
Message-ID: <13c1df955c0e8af0aee2afce78b1ea1f2e3f8f66.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3a7101544f30..5ece186d5c50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -174,14 +174,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -511,7 +511,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0

