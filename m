Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728C1684A5
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229109; cv=none; b=KonRiaE86048W+H+i6ARMKuIn5Dw8CYGa33bQeel0s1rQWUdfvyWHQkZhKXT4LyIjJ6jppJNZVXQbkmlhsrPm8oGqSHhxylF3K9jlzIMHoCTy5VrzLC/Vy+VWc43i3EF0ydGacan0iJd4pzS1uzqKtDXi0nxJOIhDQdQEVgeY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229109; c=relaxed/simple;
	bh=RuLIdPYLf2U7vdfwd0GY223a6ukGYtQumd4qAvMMF1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p56QfwEo7bra1nzdzqy0/WEvGJ7CYRMdyDO6l3GUQ8+U3k8umpny4nhTqAfco55o+3ctSttKMm2KSJENYaug9mybZRm1boV2VgboJMPyNbDOb7LXG9YCudF77KMhWxlMu6z4VOc8yq+uQXEkYgarf8NjOMThlMgNubwwTdkV36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Sw8TJPL5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Sw8TJPL5"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f51981b1beso892965e0c.2
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229107; x=1723833907; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=Sw8TJPL5iGHhmM4SAXU2t0AOQkRCblwYyNpOevoXEuU0OYljeAo5FS2x0dlD/CR2dw
         Adc66Xhr/sJizJSymRWqxP1QEW6HnJXt1C1sBGyybt+sAzw7PHAKA2JRsQkynpZhSGLG
         aDeKO4swY0XDn4EDxlDeY4xKSZ5eey7Z4VM3IJnBi6pmTXNdWIZvBegYwEJn+Ed2WWDH
         isVc4xw/LFO/bmde15tl/yu8yhr9MB74J5Etu3rvgxdUmevoFeHeoaMPHwpzWlNvrEh3
         Fmo7rmUZ7QuGujMWwAU8zbXMYpzo0wDVDQqW6rwtumNyX0q3TYwyDkHAw7wUarsz1lix
         ZzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229107; x=1723833907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=BgRg1DYqqs+rT8nfi5hZEeiUslX+GGF/DKU08yw5rgWB/E0NL2LhAVJV+ystOTE2T6
         VZ03bgULk20bIyUe49SLavTUi6n33C4IbWHny6RhVfiQmaHGxEj/07JefLAPPbFVOVqt
         5Muvpmp6/b/X9aBkD04CYZWEPGenqBd5HstN2H75ecEb943quccaYEH7IesYKfrayCVy
         cagpEE8SS/89CjRd/HsDJEA3Jka88jPkVS06uKNXD4FX0vlO0agmqJxim4cBiWE6TM+p
         jj1D4R1sYWaPkqFXKnqzv0MjKqVQBgxOU3GbxFkmiWYXTL98WO5u375msnuXW7XodmTn
         zGlg==
X-Forwarded-Encrypted: i=1; AJvYcCX0P+NYfxdKZHmOOhREeQICEuoLWiu+aLJdoHa5ewK1XIK0KWFY2GrHHLweeW01I6ZbUz7FMko0dSqurmdrvLYzBUrVNw==
X-Gm-Message-State: AOJu0YzJ66gRBXZv4DLLn30yDp6obsYuP2kna7ou3tkRGFG4jtKbMRAf
	aW4UgXMA/UB46/MKTHa9sBndZHwYDksRHf3klgCvQPsMrUjV5WXZAqFd6TLlr8M=
X-Google-Smtp-Source: AGHT+IGUWdpCO0sBCfPtcyZHbJHTY/osXSdQ3Pyi+lrF8mR+tISGnHR7UyJz8usggEUqavTayntxAQ==
X-Received: by 2002:a05:6122:7d4:b0:4f6:a5ed:eb11 with SMTP id 71dfb90a1353d-4f912dfd583mr3098244e0c.8.1723229106822;
        Fri, 09 Aug 2024 11:45:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d71cf9sm4378885a.44.2024.08.09.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 11/16] fanotify: disable readahead if we have pre-content watches
Date: Fri,  9 Aug 2024 14:44:19 -0400
Message-ID: <9a458c9c553c6a8d5416c91650a9b152458459d0.1723228772.git.josef@toxicpanda.com>
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

With page faults we can trigger readahead on the file, and then
subsequent faults can find these pages and insert them into the file
without emitting an fanotify event.  To avoid this case, disable
readahead if we have pre-content watches on the file.  This way we are
guaranteed to get an event for every range we attempt to access on a
pre-content watched file.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/filemap.c   | 12 ++++++++++++
 mm/readahead.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index ca8c8d889eef..8b1684b62177 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3122,6 +3122,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't populate our mapping with 0 filled pages that we
+	 * never emitted an event for.
+	 */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
 	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
@@ -3190,6 +3198,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
+	/* See comment in do_sync_mmap_readahead. */
+	if (fsnotify_file_has_pre_content_watches(file))
+		return fpin;
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
diff --git a/mm/readahead.c b/mm/readahead.c
index 817b2a352d78..bc068d9218e3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 
 #include "internal.h"
 
@@ -674,6 +675,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 {
 	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
 
+	/*
+	 * If we have pre-content watches we need to disable readahead to make
+	 * sure that we don't find 0 filled pages in cache that we never emitted
+	 * events for.
+	 */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
 	 * as we'll need it to satisfy the requested range. The forced
@@ -704,6 +713,10 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (!ractl->ra->ra_pages)
 		return;
 
+	/* See the comment in page_cache_sync_ra. */
+	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
+		return;
+
 	/*
 	 * Same bit is used for PG_readahead and PG_reclaim.
 	 */
-- 
2.43.0

