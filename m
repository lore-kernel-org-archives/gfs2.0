Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9215ECFA
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145313; cv=none; b=Ovat2NkgsjPFcQabKuPffzWX0ADbNDDu5UhBD3PdPngJjDOvlVln2OzDInYZNRfAA/Uj7wWIMJUVDriHFnHK/W4SvexoT7Od7zeLNhKQUh0n3dhHg+MxR6stxa01Iuaw0m0LjK2w2xXYD+ls7xDH1fxyJJfKeYV75gMrKY8MfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145313; c=relaxed/simple;
	bh=GuL24mTj9mXM70tRp2J+zNN/WSRlPMuaehdquMxMOMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUVbkdtQLLX3nuP22axLv4vr6VhdZjOEXEyr8M/lXCKeNaxw/dQ1u2JFqrjZ9CuDjzWIyLtPFxpffPnd5CBLjXV6ud8Awhby334yJke756p//bW2xqTMzvntMU1ZDmH1YTZ3HhDZe3foqmXWTQJXavHSjQwPjw/GHuM8DcL7P4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VIk3LEaP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VIk3LEaP"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fea2d40adso7503721cf.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145309; x=1723750109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2MplehQscA1+uvrWS0C9V1o5GwHxjl+BfkNu3cTe0I=;
        b=VIk3LEaPp8B14PiYhOu1xVYIqw1OW5ysTuxR8nfGSgaYQ6/dPjtVkEDD1XjzgF0a3a
         wXMbubLi8YCVVakH+D3A8K5eJ+cSM1Io0xiIH/FQEgu24xNNc9gNK1L23Z87Hx87ex1S
         hbI0XPouHzbm36NSEBUwZWkrYYIVJtNTlsOZicyjYK6E9DYEB/QwBjQZtqdd68K64OtR
         HK7WFTmfvSdusz/lDwDR9V1/ChFR0lsQV0Y6sutaQJi7hH2GK/h+Dh37RrrBLWc8BrTi
         dc4x4XGmD4oTsO7qq+NPV+y+N52MCASCNvbv0SbPbXCHWcTa0fzEzQ6KhWxpdl2m1EEY
         HCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145309; x=1723750109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2MplehQscA1+uvrWS0C9V1o5GwHxjl+BfkNu3cTe0I=;
        b=K8IHbFdX+8Mz2O24NcczHoLNYPEoOIWW2T550qj2f6MsXL5AqZCErvte+PVKiq5wVV
         CrlPC3JR9HjaE6kj9Y8kjGtJDPWH6cSg9zXkwlpfyeBuKGCGpXW9JixvgP5KoOE/XjEB
         a210MxdxFy8Um+jxtRK/XGXKEdcj7bPcqGo7j6nP8begl+y7ZupuaH3d1yHPnuOpoiOK
         V84UK/8eIKnQWb9SlAQ0wG619uGVyqxjgg0VOJN74OI4uoqjTMDPVNUJr6GK9h3fzI23
         DajdtB5IUGKPoDhCdnz1bjmd4rvY29RVAOkZCVIZrfYQUyCJN34ePaP8/te8yjSLXmYl
         4deg==
X-Forwarded-Encrypted: i=1; AJvYcCX8raNp2WMkJ/nyWshCBe4+R6qo//IC6vzYR+DpqSNnFsHXqnJaUXF8HMV0scNGMa2TGWtFKP8+wnrNoarbaSLfEqqbGw==
X-Gm-Message-State: AOJu0YwRhrWc3dmqTUx9WFJQxlLwMq9J+PxyAFa5pHXeVWvySmEtYb/d
	EYEUzNLGOfVEGo8G0/u/p1n2iTvPKB6ARgdB+/rmMw9bGsRt4mIZMNKOKbbZtks=
X-Google-Smtp-Source: AGHT+IFDsbaV/n8kDCGttZbX/69iKd/pkdvlPw0dlBa5DAGrReE31B6U9TrZPgrw5N0QpefXodV8nA==
X-Received: by 2002:ac8:6f0a:0:b0:440:6345:257f with SMTP id d75a77b69052e-451d42ff7c2mr40818221cf.60.1723145309461;
        Thu, 08 Aug 2024 12:28:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87db202sm15626721cf.72.2024.08.08.12.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 10/16] fanotify: add a helper to check for pre content events
Date: Thu,  8 Aug 2024 15:27:12 -0400
Message-ID: <531d057087b9430839ddd6082022e29a9066ef1f.1723144881.git.josef@toxicpanda.com>
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

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

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

