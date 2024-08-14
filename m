Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6D1D0DC3
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670779; cv=none; b=ewRnC8yAoIu0TAPMau+6mXRRYhYk2sqfxG4Cm2+BT2CUGD9F61lL8Q7uISBJg1QIz0zWAJO3SPEJd4hyfXqaclFvV7BRqkaYt5JSR+EFGlhApM/5HBTU/4N3EMk649nffElHWZNIANGqOabmvHFEN1Pntqo6nz8++NzxzuQ2gh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670779; c=relaxed/simple;
	bh=RuLIdPYLf2U7vdfwd0GY223a6ukGYtQumd4qAvMMF1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAO/SpfMXoMJLW/Jzxkvt34XskvMZw0KIqI8ezK6qWmUmnt1381v9MQAfOQERSr8YwEGPbEZKI8Zs/AtHzpa9CBKTSzhgZ1mCrrIxtz9NmfjV7xK8UCs612jg5999T8nz2vHQeysYDVY1wBKdFeMtg6k4wOFFciETTsn518/DgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BIbIdq/N; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BIbIdq/N"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b797a2384cso1805906d6.0
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670776; x=1724275576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=BIbIdq/NtM04gLhBlOT5T8oFm8ATNL13/QtH38Ist5thTvMhOpQPBXpDOsvx6N/4is
         Vh1mMlCwDZqJBvti0XEGfFPugUTEmiAMrrmKK/CaUueEYpYh7J+XcOWGnkQPR4WgU9v9
         TI76xgaiLLWs+OnOdgQWZq96niM6+VB8UD9e8diN0j1sSghk84IhdIf2TmZI0L/wAjfM
         oC4btWNRTIs9Z2m4ulKHMM5KXAcYik7ppA2XRhN3pkREcbSoYMeABj9O/NCTmT2dfurH
         5WvKpdhww5OrubVzQU5KE5AFvXjiEI8YEqIsdgNTSHjfSSXS9LQfcGsFQ2Ru/IEMVh/n
         zBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670776; x=1724275576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ0y3/dQBSJxG2OyPRkhEh3Vj0wjByustgiYia+MZqs=;
        b=RgBdBd2+jfUFO80tPIRdCt0BRzMTz2Uoj4FBRTOfijoa3MdQzHPKkC43A0VO6sQUhW
         Q0PPAgUf8GQE4rqhIbuftmh3coMt7NB8F4rpty4n+6XdOFfr9RpS1SlmkgOP+DiitV9k
         bGs2mP67nO0jIF7/VDISky8lA3NFKk9tnuY6ZAfndR5kk6+BTujFX9jM6cWtxe0pw60U
         s3lFm3VgItx5+LqTBPJ93usfL4urDJmAGsVlf+SZyhaVFYa/suM/yhMV8iqPF7Mw6K8u
         6Iu1xmC48KGdk41IrvIURpPeD3mjQIIFpSpKHGgMdp7TE155NP1ILn9A7VI4e9ipUkL5
         naGg==
X-Forwarded-Encrypted: i=1; AJvYcCWrp+YQ1AJw/gMIrJ4nRQjmxWJ1YDrtoimUMoEULMO/yS+fDv5GQlj6mfPD9ugp9MYkYSE6nopMVnQ7soBHE+s9F27iEA==
X-Gm-Message-State: AOJu0Yy9JN7NJy7hD8lPeZJceQR73PbE9eLGohiMuAs6l/1EmSJ7NiY4
	VgmoFYq1m7qozD/CiUFrKQ4N4XPcep2kZgY1Lcu6EkhACcXh1VZbm1B8GDqY5ds=
X-Google-Smtp-Source: AGHT+IExGAEQEamrim6ho8QAd+QcOVhJTtOVmgmL6OYA606guNdAfaz4yD+2UP67QG+9AhpysKNQAg==
X-Received: by 2002:a05:6214:2e4a:b0:6b7:a9dd:ba58 with SMTP id 6a1803df08f44-6bf5d1fa365mr62306796d6.18.1723670776088;
        Wed, 14 Aug 2024 14:26:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe26c71sm618696d6.61.2024.08.14.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 11/16] fanotify: disable readahead if we have pre-content watches
Date: Wed, 14 Aug 2024 17:25:29 -0400
Message-ID: <9a458c9c553c6a8d5416c91650a9b152458459d0.1723670362.git.josef@toxicpanda.com>
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

