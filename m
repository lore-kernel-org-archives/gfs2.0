Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E9156C78
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145304; cv=none; b=SeqHm5kXhxzB5w3ISAWmTM/JoQuMlbM/KRhLaOsJWyQRa13Ofi1sev8Qakuj/OQawKBxXlTdU+NdrgPEV2p3MuL0uxbhWJK9qsrAox0UiYs9wEhr9Ajlwr9sP7HPQX2XoHa2XkaKEeu4fz6HjMgDAAz6SxBCoFbEbqf+WG+1Zuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145304; c=relaxed/simple;
	bh=VnNy26VUpNnims6UXBrv9Si64DHRDQUU01RSugTpPdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFTg5xA0oo/9266lDEjdP9xW8SL5YDHW6Kyjcm4HI9n52xipfoktUy0czvXWIEEvLecCY/NoCbDQw/2VwtT2xoM7iIHV5Xhcd0vkh5jc5g1rBt5Y6V9m8asuqd+q8isTMlCegKe3pdbk5r1LUNETgvEKDT4w2WQFZH55y4glOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=z+qPqcLz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="z+qPqcLz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b795574f9dso7650636d6.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145302; x=1723750102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36ugo1TfvovnnnUK9ncR3kaa9VL4nnnXrq63bAYq2UE=;
        b=z+qPqcLzBAYMW33meMlVcY2e9hdQ6TpR/NOClXYgW3XHlxDOec8K1oPjQnSAaFYvJs
         nTcuInRTcyCL3zwfobXsy+xAHE+Oi+uWx8VvCr4Xxg4Te02TpDPDRDxnv+qd+PTyzBWg
         gK7Kb6nS9YZORQ4FWplVDlg8rYiA9t5UNri0PVcoxM64Kv1KOzcPQGJMgreKiZ1gR/N6
         QNzoCI9QWsCHGLXRCT0jnzg7tWsLIIzfWF6XJp3I3UIa2/01FvWcK92i6IC7pLjKs73V
         4PnjEjW3NssB3oVHE8Bw71o2EOD7cfayX8DP1uRXnUDo2K0xiMEpxjhULKWn56hJ4I/S
         wWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145302; x=1723750102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36ugo1TfvovnnnUK9ncR3kaa9VL4nnnXrq63bAYq2UE=;
        b=jW8GVmYfXs8ZPZ7uGR1uhs5AXM6qKRVYDUARVSdvnZ5i9UadsatD9A2t0jIOMXVcIj
         azJq3D9at5ap4bcqgHcf10Xmoohi82dSztiUu08E93m7dMaf+gi9fbTd4/xeS9d5WuH5
         yBk3l+so3lErhva1Pqvok938xvd8sLpKeQbz940V0FV2CTFzU99U3CX1P5FvXb375sbk
         aZEqQf+YIs1Bx2XMqOVq2SUFn9t1S6KmQLcX8+bjOlomW7xSJ9LyXTXVG1J/0eSzbgoJ
         l4iI2S/wSihuICKi78b2fuO+lIWLrGOMzJ15aw+oPpdVKI7MRh59m1eTe6NoUDtCwJCc
         yD5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2j8K2YGo7Q92fedVXBb9vZr6PLBjrhIpiRF/QBoCVMKGNxgFSq58YT7G1XqS0LNfNpXB+VtGkqyMEQlEXpXL7nAS8/Q==
X-Gm-Message-State: AOJu0Ywy32g5B+qhOChbRjhLAaRtTJWeTtERlr9QHMJ0Bbpe3wr0Dnnk
	lOXWaL5zos3S3afFd1meSDgGwLwNvGPSildjzr8G2gcQobO10gWJwdb234mQtEY=
X-Google-Smtp-Source: AGHT+IEHt4QHrJ4mSzrw5WD3LjHgxaV0kWINjLNd9fffAZjVvdMOxmyVWHGrqTt/kBpNz8Get2nkdQ==
X-Received: by 2002:a0c:f207:0:b0:6b9:60ad:a9e2 with SMTP id 6a1803df08f44-6bd6bcae45bmr36797866d6.11.1723145301692;
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c777e01sm69809966d6.1.2024.08.08.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 03/16] fsnotify: generate pre-content permission event on open
Date: Thu,  8 Aug 2024 15:27:05 -0400
Message-ID: <b44f4cc462c7ef6bac3ace31686dc96fac408dd9.1723144881.git.josef@toxicpanda.com>
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

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on open depending on
file open mode.  The pre-content event will be generated in addition to
FS_OPEN_PERM, but without sb_writers held and after file was truncated
in case file was opened with O_CREAT and/or O_TRUNC.

The event will have a range info of (0..0) to provide an opportunity
to fill entire file content on open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               |  9 +++++++++
 include/linux/fsnotify.h | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3a4c40e12f78..c16487e3742d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3735,6 +3735,15 @@ static int do_open(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
+
+	/*
+	 * This permission hook is different than fsnotify_open_perm() hook.
+	 * This is a pre-content hook that is called without sb_writers held
+	 * and after the file was truncated.
+	 */
+	if (!error)
+		error = fsnotify_file_perm(file, MAY_OPEN);
+
 	return error;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 028ce807805a..a28daf136fea 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -168,6 +168,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 		fsnotify_mask = FS_PRE_MODIFY;
 	else if (perm_mask & MAY_READ)
 		fsnotify_mask = FS_PRE_ACCESS;
+	else if (perm_mask & MAY_OPEN && file->f_mode & FMODE_WRITER)
+		fsnotify_mask = FS_PRE_MODIFY;
+	else if (perm_mask & MAY_OPEN)
+		fsnotify_mask = FS_PRE_ACCESS;
 	else
 		return 0;
 
@@ -176,10 +180,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 
 /*
  * fsnotify_file_perm - permission hook before file access
+ *
+ * Called from read()/write() with perm_mask MAY_READ/MAY_WRITE.
+ * Called from open() with MAY_OPEN without sb_writers held and after the file
+ * was truncated. Note that this is a different event from fsnotify_open_perm().
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
+	return fsnotify_file_area_perm(file, perm_mask, &file->f_pos, 0);
 }
 
 /*
-- 
2.43.0

