Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB515990E
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145307; cv=none; b=DpB4TMghUhZxIWyI9ITZQcNCmR56Io9Mrek9SEfTDpYSeSc/AdYGXWexKZ1YIyH+4HL+4UayXWYKAI7WdnXIsvr6FEQ2Sx+RGHR0mzDVLQ/sbGzN8SVm1iVI7GZriwrfR5YC2SInywbmSvYD+Ke59lEPqXRHt1vVUvY5SXRHLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145307; c=relaxed/simple;
	bh=WsmgXkCKE6WJb4VZozDBI+nYHL1Hhl1EEmXlR/6WlbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmzUYchAjJKCtWJ/4ERaPNoOy0obJ2lnWvrjII+PzUqToIei7y6sPu4f18gA4bTDGd7dodtFsjXWcJtS2Wb4zk3vcAx53xX8p2N8AiLuF/60ImzE6qOf/Tn6HSOFb8KlfVbsZ5ryURKe+fFuoyjyovHMrNZkp5wuP1xNXlR2hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JVla/NzX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JVla/NzX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-268daf61e8bso474121fac.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145305; x=1723750105; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzenZXFB+zERTZqh582MYbJosgZh3nXgIyzY6rCrvew=;
        b=JVla/NzX58rRNXIRjCkuPWosK9eqDpibVjynw7jOQk81VA8sR0dCz8mW5bEKtg04jN
         9YYv4LqToBdr8FUFan9yKdME9M8AT8ilLbJ+kL4glMGnSRjGgeCV3m13EkSwpJ4VG+dG
         zwS614icld8ofWrYnpOzs8BXqGoRDkR+rKIxwjtWyoFyd7BG2LG7nrkuoD8q+Iq/5bal
         hcSa1iLfn6CZq45Czyl691Ir+Q8CDchs1ippX/kfswLRQ2BdEaXX0TE48ZqsGanp4Asy
         q82fhPGNN8LAgoCr3QmJYtp0cxGYN8+2lyg3fsFawOQAa2wa1PAHtF/g9LMxdfna4S9m
         8O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145305; x=1723750105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzenZXFB+zERTZqh582MYbJosgZh3nXgIyzY6rCrvew=;
        b=gNZ94tzuQD51iH4WmHlJlnSXxW4Ho8zzUcLSHU4UDEXzCDySY2b9Vev6NvB5JqqLuC
         81rtwPQIbudq69V8nihgdWN99ZQV8gpt28zlhSuiXFTVqSU+gla6ysxXGcehWAp3k1q0
         d5MX5Sr7Ow4Ocpxl5gFEXGJS2YWCuE8KFxZgwAwkFZXtu4gfwow9dZJpe8ufDlxBK/P6
         RaYOQ7THkKMvOZpN3DbnRsFVNFkh+vdiWsQArNaVbco3FQ/0M+qoqLPhuKKy6O/PXjOm
         MeMAW1YiKoy0KiDTwtXJTyjmtn0EwC7Yvpcwbb6meGu3Y24PY0XO9Jn4+6NY2kEoLzf+
         z1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUH+dACJZUawHCgkQUIUsumanqrM7cSw09lx89MQ4gcFdIfCYQzfsefh2fRgypvHMhp/pLcKvQiG4Th9kFqvINKwdGKeg==
X-Gm-Message-State: AOJu0YxnE1Y4RbPxrJs+gz55+MAqSi+ALgnjyRYzkdAMhaj3a7vg4gRx
	dzOs7GY3b4g8kOMJBhlv18sfdC53yxhY2ncrwhi2MqLBr7Z15dZWyGT/dfo/S7Y=
X-Google-Smtp-Source: AGHT+IGkNG2N1guMTFmAJrYc1Yq09hr5aUo8VHvIDmVB7iXoZ+EZU+kk+PU4rcOuv/UUDPzrVE22cA==
X-Received: by 2002:a05:6870:7247:b0:260:fd4c:6506 with SMTP id 586e51a60fabf-2692b63ea86mr3647958fac.19.1723145305309;
        Thu, 08 Aug 2024 12:28:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f254csm188758885a.68.2024.08.08.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 06/16] fanotify: pass optional file access range in pre-content event
Date: Thu,  8 Aug 2024 15:27:08 -0400
Message-ID: <4b45f1d898fdb67c8e493b90d99ca85ce45fd8d9.1723144881.git.josef@toxicpanda.com>
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

We would like to add file range information to pre-content events.

Pass a struct file_range with optional offset and length to event handler
along with pre-content permission event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 10 ++++++++--
 fs/notify/fanotify/fanotify.h    |  2 ++
 include/linux/fsnotify.h         | 17 ++++++++++++++++-
 include/linux/fsnotify_backend.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b163594843f5..4e8dce39fa8f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -549,9 +549,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	return &pevent->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
+static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
+							int data_type,
 							gfp_t gfp)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
+	const struct file_range *range =
+			    fsnotify_data_file_range(data, data_type);
 	struct fanotify_perm_event *pevent;
 
 	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
@@ -565,6 +569,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
+	pevent->ppos = range ? range->ppos : NULL;
+	pevent->count = range ? range->count : 0;
 	path_get(path);
 
 	return &pevent->fae;
@@ -802,7 +808,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	old_memcg = set_active_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
-		event = fanotify_alloc_perm_event(path, gfp);
+		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index e5ab33cae6a7..93598b7d5952 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -425,6 +425,8 @@ FANOTIFY_PE(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
+	const loff_t *ppos;		/* optional file range info */
+	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index a28daf136fea..4609d9b6b087 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -132,6 +132,21 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+static inline int fsnotify_file_range(struct file *file, __u32 mask,
+				      const loff_t *ppos, size_t count)
+{
+	struct file_range range;
+
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
+
+	range.path = &file->f_path;
+	range.ppos = ppos;
+	range.count = count;
+	return fsnotify_parent(range.path->dentry, mask, &range,
+			       FSNOTIFY_EVENT_FILE_RANGE);
+}
+
 /*
  * fsnotify_file_area_perm - permission hook before access/modify of file range
  */
@@ -175,7 +190,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	else
 		return 0;
 
-	return fsnotify_file(file, fsnotify_mask);
+	return fsnotify_file_range(file, fsnotify_mask, ppos, count);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 200a5e3b1cd4..276320846bfd 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -298,6 +298,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
+	FSNOTIFY_EVENT_FILE_RANGE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
@@ -310,6 +311,17 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct file_range {
+	const struct path *path;
+	const loff_t *ppos;
+	size_t count;
+};
+
+static inline const struct path *file_range_path(const struct file_range *range)
+{
+	return range->path;
+}
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -319,6 +331,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return d_inode(file_range_path(data)->dentry);
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *)data)->inode;
 	default:
@@ -334,6 +348,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
 		return (struct dentry *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry;
 	default:
 		return NULL;
 	}
@@ -345,6 +361,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_PATH:
 		return data;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data);
 	default:
 		return NULL;
 	}
@@ -360,6 +378,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return ((struct dentry *)data)->d_sb;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry->d_sb;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry->d_sb;
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *) data)->sb;
 	default:
@@ -379,6 +399,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 	}
 }
 
+static inline const struct file_range *fsnotify_data_file_range(
+							const void *data,
+							int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return (struct file_range *)data;
+	default:
+		return NULL;
+	}
+}
+
 /*
  * Index to merged marks iterator array that correlates to a type of watch.
  * The type of watched object can be deduced from the iterator type, but not
-- 
2.43.0

