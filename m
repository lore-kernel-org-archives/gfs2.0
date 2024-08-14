Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233901CB33E
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670779; cv=none; b=TGmaVsc/iSwFm3kBOrC+pOK4bnZ3WSJ+SgxWUobAJnClqYLmSlKba0zIYdRCimJ5FH8QqlTk9JFJD2hsze62OsX4rk1nbvpgpAGlDWG9cfRV0iKZloMJe6DQD8NK3i2/4t92T7Sh9pVbHtIRkEwUIeHykPGisKpSU7NcrYVjdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670779; c=relaxed/simple;
	bh=oIFEloV+HJRwW7KKzTETqcSZwuMF6cvmESmc2+RUi2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2IRuWnXtg+5Ss7Tsx2BfAIakwpP2Z7+WjR32uWLW+351lVr1T6KzbRFZ5uVyRadcEIWiJ7dRMu4F5y8MDlRa9A3pgkxF17Z6NhA/AbgVa+1CrQYefubtB55/qXM5uF+p7grOduViafQxjojAmMCBab8ZPaZB7lWf8ajAqWl/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EbqS5BLH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EbqS5BLH"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fea44f725so2517531cf.1
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670775; x=1724275575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=EbqS5BLH0A5+xMIl2i7Sozc1gTNs6cIO0NFaj4wHD+NILl0IBuaJxuOiEinLGr/Crq
         LoliR4sZULhY4zSvx+P8U+B4AIn6cJtLTj1/vLQ3Bsdk+yq1hmE9UAge5s5u+Je0xicO
         eGfRXidY7SGe7OivyxEkrbRnJhQH6iMijtNASNeKzoD40/OKHwfWkpT4PfIfMmjIB2z2
         hhQQaQEXDMtcAFTltZqd+mMMthIyap/ZL5WwcK8/gVoOl+6+RHeMdTPPzQxL7hlAzBPA
         K7duWh9N/9mq8ID5YUuRCC31h/Ga3Quo4eTo4i9YzupBmLfUQALk8Qn+/J+OdyGcYtvr
         wRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670775; x=1724275575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=w9zwa3vYA9p4Um3TZtgYT6YJS9uTmNPl23XISfioy4vGl3Xf7mEEoKUg45OX5PUlLG
         nsZ1qyovv9HcEa8+L66Mtov4LpwyQHIjHXfRNxumfPKFvySAhwK3tj1gCUGktBdMqARn
         7RcVt+oFP/QqNxgmxwRI3eKkIwxlVlvKjkM4rXweMacukpnqKR24tfeHa+LpBZHDKMwu
         eDoTJ6WfPko6sYiks9AwD67wti+pvgPQI214p/mga3bVfUvXvxMfisBCRhr3EWlsgboV
         prqJScqVoHFoGFx6H9HjvASs7VukJlk74KN4TztkYuNdxxm40fbvWNuzwsMdvv0viK+O
         8YdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIlAF41iSOce4cmU1Dc0BrT4Xt67H3PxvONacdmx7pKWo8hvNSKT81QgWJjllVLSalwpiYv0DztcKUQSZiiFcwtUYOXg==
X-Gm-Message-State: AOJu0Yx4AG9nGy8cQumiH3b+n8Kmm8CRMjrwch4fVCO2j50L+7/eSq25
	JZ125M/8GRTHP8AUnrgCkj5j4WLZG+MWZvGkV6BKpKW81pLCVKy5lq9Y44V91h4=
X-Google-Smtp-Source: AGHT+IEd/MmUwaA1JVX+VfdhiUmDxdoXxYs9e30nr4Gux5C2du2HbwieZEhvSa2zBuHRp84nZOLlBA==
X-Received: by 2002:a05:622a:4c8e:b0:453:57b0:8814 with SMTP id d75a77b69052e-453678456ebmr18969301cf.6.1723670775058;
        Wed, 14 Aug 2024 14:26:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e22esm502161cf.74.2024.08.14.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 10/16] fanotify: add a helper to check for pre content events
Date: Wed, 14 Aug 2024 17:25:28 -0400
Message-ID: <b02993d0e384326194023c76e437c0ea838a5c06.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 12 ++++++++++++
 include/linux/fsnotify_backend.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 1ca4a8da7f29..cbfaa000f815 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -201,6 +201,18 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	return fsnotify_object_watched(inode, mnt_mask,
+				       FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 276320846bfd..b495a0676dd3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file);
+#else
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.43.0

