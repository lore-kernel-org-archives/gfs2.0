Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D215B13C
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145309; cv=none; b=bPOR9Ulm8+6ILwHZdWA5BHq0XwWbYcFXqePO9hrSQEuz93gMm3D8T+IhcC2IJB/3TcRNTqHj2a17dmnLamVu2lVIaAtevrmDwz35QJ0lL2tkRY1zqpHSbUDmjjXluZZ8LOxQUyrs8MnwHkfzycHnm1LD2XUBkgrFRq03vvuBhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145309; c=relaxed/simple;
	bh=lM4E+0QDfWeiHiQEc8/d7xk75Z3XLq+R4ATU188GEVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHAk1eEk3W2uOeslPr8nrtM94qf1rJIYNRIQ2PQZsmu71LfcwwrrdZxCDAxlFCVrPdeM2UGBTXY5rOemxq+ivAHsEvRulRH06Vb+hnLd8Q6s0pNj+SHPAhoBGBfJJjfL+LaS+MK5x1mu0xk5p6iy9+1ZlHhTRkSye/SYGS/1ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TL+rcIva; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TL+rcIva"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4503ccbc218so19715581cf.1
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145306; x=1723750106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjfT3NMblUo7sZTNjknqk3yM6nPmAl4UxLqtdr8jd/U=;
        b=TL+rcIvaWlEwD5Czw3CA8wJZQ2Q1jng/d1/Xo8HW7D9cQFRw+H9O7XHE4Y/8AHmrzf
         Aklkj8BVJLiXaxlX82POV9oj1wnFp15n7+AzWx6crGfHJ4riurqf2bS3voETh30nER9N
         GoLjlEZzgo9VwY0O1tZ/L7wC8L3krhf0bKq4Icx/9nYZizpYzXI28xKAlfKFe7SQQc58
         P/f4FpWEpO2H0IkK3OpIKqhVAkcVNcfkVcBNe4MQqLl58WJzQhlO5BoyOZ7Kh7MOjcQ/
         7tiSM4WD/+PZOk+lPGr5uVvzZZyKW24Foui1F34WlE4tHCD/5l1RkPthYBQLXPYo/b1/
         /4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145306; x=1723750106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjfT3NMblUo7sZTNjknqk3yM6nPmAl4UxLqtdr8jd/U=;
        b=ARG0SpgS/e40AqCvE+AmWDVyZNRyMK/VOxnLdLe+FqXCwTWf3vRSH8OFXTpEzn8g46
         VK5k7rq3N4c9ruXF7hVdb0SY5EPdNO3oes7p/1wkFSKNeUDFc4w4ad+WSRxqN7k4+se1
         j77EPTmZQuJHsnDjqmM77JevkmYW9ZDfp01tLLbS879rUDy15z5C9JjAEuYA95cA6WF3
         lWmO/RqsMK96sh20QsYt/nRourws2lecjYBNyt0jwSusNWfquB6BEYb3LA4ozlnrXbsa
         KewOdEfZfdIMSnThONyhVyegj0u8hdeSCs7PbRBtIiJAlyPDFOHJ2e5vn2Ya27RYQRWG
         zwVA==
X-Forwarded-Encrypted: i=1; AJvYcCXUfPcacra+2aOaBXclzLPK+vKV13FWOalECYOobVE9QWK6pDrVb1FmMPS29naH/GdroZO2aIMMGKE+GgurxZLn3Utzhg==
X-Gm-Message-State: AOJu0Yz3HaYMnRKDXX4/m79ag52+Dp2YKVSMHjV4MvFlfXe/8ylejeoX
	fOLq5U9bpzzlwampJDQr1SZtXoa0hu7Qgsl66OzUruVUVFi4261J3E1H/lrUO4pGfmlW7I+8Lbd
	K
X-Google-Smtp-Source: AGHT+IGSh+lZaiCIMZedN+ZNZCZXZjbXsLY7KjtrhuBLT/ySiKQHjkhCsGdxbJMDj7u/JeFTXRzKag==
X-Received: by 2002:ad4:5ca8:0:b0:6b5:e761:73ce with SMTP id 6a1803df08f44-6bd6cb0fcb5mr41503466d6.16.1723145306354;
        Thu, 08 Aug 2024 12:28:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76aceasm69502006d6.6.2024.08.08.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 07/16] fanotify: rename a misnamed constant
Date: Thu,  8 Aug 2024 15:27:09 -0400
Message-ID: <5d8efd2bf048544e9dcc7bb00cb9013837e3db6c.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
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

