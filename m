Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0D49630
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229108; cv=none; b=khVzv2/KnrFlpTJgqFFql/8zipF086dUKTmbSDybULLW/X/1yNAky598qTR8/u9lsGKV7V5M8Pnm3tpWf4qXFlMkg+kN+7PRpY2x0tLwQPNW5wBHstS0U+aFli84D5pd4qk4u6Y2pCksd89V5AyFsxJFaZ+XfZvC4wHnyCszzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229108; c=relaxed/simple;
	bh=oIFEloV+HJRwW7KKzTETqcSZwuMF6cvmESmc2+RUi2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+dpcAR1+yqHHHL5ALGWamdpd7jljKsRp4Il5RFW0bHN0he7yvxAvE7A60gM3S4Fkv/ZnicnpfJjXETxiBJBjVXtnkwwJW/2wIMa79he7etI3WTlL3ZRoyjxEu3wbIBFAEqvwvibQ/ONB6fNj83l/NPD5S7TVnFdVRWSU97WFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RHUZIAGK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RHUZIAGK"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4519383592aso14371911cf.3
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229106; x=1723833906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=RHUZIAGK2FSnUDVDxvuzdctZwsAu/GbdH64YIizrjNN+fEpn6QB+i8W0j8B8OVsWGu
         2K3ITUkh1ScBj+yl2iRLkN9aJ8iyhytLn6adP++Zhz4ICTP0T5Ge6ndl0B1hCIRLr8kp
         GZnxgQnU4/CMvR5O2At7UUUOMWRR+4jHj1osXpFrFWHuy6W9ZOnMlrXLDx3zpU+Ki3eM
         G/98bTgKT3nKgyiWkScUFZVIZiT/WNQmaw6wEBmnVH0LRU8ss6duircse7gstTLq6nKl
         Yj54pPzxmLmOgyFlqL08iJ034mAp3s0nsIqRenIEpY5C5IGUR0aeeNejBzML/++D4i7L
         4XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229106; x=1723833906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=Gzg4yUaRIUYugvXKIGKQGFkD6qcptJWRujD1gu7q9jYGgQeXerHSxipA/ME3y6OXgZ
         sTIH5v+3laJdskr5bGPjTLGcG3WvcdGrwKlS9d9Jbhzb+jxrLMdxOMEB70Pyh74kUv8w
         tsGhgPH6rRKYF+IL+3obcAKA/ahiZ6IJsHaQ2D0quju5wOWIdnWRJVctI2r0beO+/eLr
         /22S2awQxWKe4ZDiYjbGx0uP+QEpblfnKNH3BNiVg1QkkdtGrmY0MVKfruul1HBrIelN
         z22SFlcd6WXfGBW2TqAeWRmlyz7GcV6BL1cbKEGB1c0wb7wUobhJZ+b1R3JxdS+vwglw
         brfA==
X-Forwarded-Encrypted: i=1; AJvYcCUoEz9eBlKsr30RdY0I5zhasSsAseoL9GHUQ7qbeY9OX4j6NzPID5AbINJ1DSG9gEorNDBrF88ZsYHgGq1cdic/LVs5KQ==
X-Gm-Message-State: AOJu0YyMRFU3r60LjoRL84QJoD/+NDju51zg54WXjKY2B+qcZWfNGekP
	4txlFjirNo6EHh5IIHbn4A30Yzgt4MPzbijnZYF0I929tVk7dQhwSrxH2XAe3GA=
X-Google-Smtp-Source: AGHT+IG5zQtNW/XpS3+QxRnw3j+AIzLNhodsoGZgh92MwyUW6bcO/0L9pxWR7KNpZnt4tIKD1u7yZg==
X-Received: by 2002:a05:622a:4084:b0:447:f7cf:7022 with SMTP id d75a77b69052e-453126ae6c5mr26804151cf.40.1723229105766;
        Fri, 09 Aug 2024 11:45:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1c3da4sm410271cf.29.2024.08.09.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 10/16] fanotify: add a helper to check for pre content events
Date: Fri,  9 Aug 2024 14:44:18 -0400
Message-ID: <b02993d0e384326194023c76e437c0ea838a5c06.1723228772.git.josef@toxicpanda.com>
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

