Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDC1684A3
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229112; cv=none; b=KZyHJ5svoKYOfc3NA0fePsUKUmmwHbg714yxEEz1U6CVxgSJ8vF1NsgzsilBypBu9ut3ZzjogYvQAIyGz6LgFsVGAY6EZGTioMlGZvHheEc3puVFOfpS6MQWd4ijMvmDCnZsfqjqzeeopjAbw0VtAyHhTN8u2jCxMI1JG/Q1TKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229112; c=relaxed/simple;
	bh=tscezQI1ZJCg3YAyrWCq2E/Rnm9shAFZx+qPWD9XbK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4WLcayBPRKfgvti4QdttnsNS4ujXDOrKWU9i1h76GzLAQaRqw6+mX+seJE1kFZhRNoKoE2vXjnLN8dj47pK794av5/dEmIFk/3ceFrxMav77ylj87Rqg6LgOaYg6ZQ7WTpvCtK9aCpO7RxH0dFtFzPWTcbGUw0crLcs0Zcr9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IlxYx3Gk; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IlxYx3Gk"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70968db52d0so2478706a34.3
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229109; x=1723833909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tq/dxfAZjwPPjg1PG5V4muEOfHeX/hkEvWtSX3LI1so=;
        b=IlxYx3GklqXIAUiXLSeaS7+lW3IPh67iuermRAgF0yHTYEzRHdw9x4tHwFDkbXvfe6
         ecFK0ogl/BJ5FTetqMRmH2xQkTB8Zj342bYXCHcvlKOk8Z401tMK26+m1d4ywelp5jIx
         AK1TawPfXiA+ayOiOUyBXoT8sM8FaFm8d2IfoN6Oz2X5IfChlnWZq3ZokTbeb8gxRwtp
         ++MqcO3NzbfoY0wVr9VgJ5ts+3iLUHF3UqiIWpato5tbINWWIyQrNl8SJgEMo3K+o6Ko
         UFvSz/iP6686FzyHL2SDs4bWWEkABoa4OzPEs9jekzkY9+fYqrlXVZixi6ZnQftg43pj
         lnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229109; x=1723833909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq/dxfAZjwPPjg1PG5V4muEOfHeX/hkEvWtSX3LI1so=;
        b=NVeVx/1KCEoBRN8keU0u+baoBiQKuPnb0+nrSkc0Nnd+lqCPbMKMeGPpuEabO9ivRo
         mMzwoNGOo/c/OHPv/VnlUDfX6fI6rZJvYWGPMEwehrkwVw7F29HEAV/DhkOrG/TnVYsP
         Eb72GYhZ6TpXL/8V1Gfk4SvDpKN+WkGyTXpv/PoaLXm5rahXlfgMnPgAAK+rHihHJJsR
         z6drcW8sEeEnVMz3cIFj6lZBT41WmVGCrz86iypSqmvq4w+tibM3AiKc5XYneXwF5Jw/
         5qLi3B70zWFTcRQyJulwW7CcKF7TOrifJHpHlobxy9q6OiY/sydZ0l8ziz7n2D72t7mg
         +3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtnxNyP5nY1Hy0Sr/+L/GgxzPDSn1XrEg2V4j+c+51CULI9+73VYZTdFLfqIQ97Pf7g4egKU9TDo5QMF4xFnvS9ho61Q==
X-Gm-Message-State: AOJu0YyCDmnHS2CDakB0DW38ehIfDHJjNOG9DO3WaTXPrlWdngGsGmR7
	rbXFF8SolVQzS0xHZubH14YMETNAkH42PtxMB2oySMYpx76xAcPzkOuUrPiMU94=
X-Google-Smtp-Source: AGHT+IG4F1TTOLqKZBLjNqn30DvFz+DenH6TfxlvQpGn5Qaps2ATLz43MqJvTKMM+vFDGDh7wVA2WQ==
X-Received: by 2002:a05:6358:528d:b0:1a8:b066:e266 with SMTP id e5c5f4694b2df-1b176f7d27bmr316265755d.13.1723229109039;
        Fri, 09 Aug 2024 11:45:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c80132sm663116d6.42.2024.08.09.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 13/16] fsnotify: generate pre-content permission event on page fault
Date: Fri,  9 Aug 2024 14:44:21 -0400
Message-ID: <192b90df727e968ca3a17b6b128c10f3575bf6a3.1723228772.git.josef@toxicpanda.com>
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

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
on the faulting method.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill in the file content on first read access.

Export a simple helper that file systems that have their own ->fault()
will use, and have a more complicated helper to be do fancy things with
in filemap_fault.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/mm.h |   1 +
 mm/filemap.c       | 122 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ab3d78116043..3e190f0a0997 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3503,6 +3503,7 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index 8b1684b62177..842e5138f98b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -46,6 +46,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/fsnotify.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
  * that.  If we didn't pin a file then we return NULL.  The file that is
  * returned needs to be fput()'ed when we're done with it.
  */
-static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
+static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
+					   struct file *fpin)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
@@ -3190,12 +3191,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
  * was pinned if we have to drop the mmap_lock in order to do IO.
  */
 static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
-					    struct folio *folio)
+					    struct folio *folio,
+					    struct file *fpin)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
 	/* See comment in do_sync_mmap_readahead. */
@@ -3260,6 +3261,97 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
+/*
+ * If we have pre-content watches on this file we will need to emit an event for
+ * this range.  We will handle dropping the lock and emitting the event.
+ *
+ * If FAULT_FLAG_RETRY_NOWAIT is set then we'll return VM_FAULT_RETRY.
+ *
+ * If no event was emitted then *fpin will be NULL and we will return 0.
+ *
+ * If any error occurred we will return VM_FAULT_SIGBUS, *fpin could still be
+ * set and will need to have fput() called on it.
+ *
+ * If we emitted the event then we will return 0 and *fpin will be set, this
+ * must have fput() called on it, and the caller must call VM_FAULT_RETRY after
+ * any other operations it does in order to re-fault the page and make sure the
+ * appropriate locking is maintained.
+ *
+ * Return: the appropriate vm_fault_t return code, 0 on success.
+ */
+static vm_fault_t __filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf,
+						      struct file **fpin)
+{
+	struct file *file = vmf->vma->vm_file;
+	loff_t pos = vmf->pgoff << PAGE_SHIFT;
+	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
+	int ret;
+
+	/*
+	 * We already did this and now we're retrying with everything locked,
+	 * don't emit the event and continue.
+	 */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return 0;
+
+	/* No watches, return NULL. */
+	if (!fsnotify_file_has_pre_content_watches(file))
+		return 0;
+
+	/* We are NOWAIT, we can't wait, just return EAGAIN. */
+	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+		return VM_FAULT_RETRY;
+
+	/*
+	 * If this fails then we're not allowed to drop the fault lock, return a
+	 * SIGBUS so we don't errantly populate pagecache with bogus data for
+	 * this file.
+	 */
+	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
+	if (*fpin == NULL)
+		return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
+
+	/*
+	 * We can't fput(*fpin) at this point because we could have been passed
+	 * in fpin from a previous call.
+	 */
+	ret = fsnotify_file_area_perm(*fpin, mask, &pos, PAGE_SIZE);
+	if (ret)
+		return VM_FAULT_SIGBUS;
+
+	return 0;
+}
+
+/**
+ * filemap_maybe_emit_fsnotify_event - maybe emit a pre-content event.
+ * @vmf:	struct vm_fault containing details of the fault.
+ *
+ * If we have a pre-content watch on this file we will emit an event for this
+ * range.  If we return anything the fault caller should return immediately, we
+ * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
+ * fault again and then the fault handler will run the second time through.
+ *
+ * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
+ */
+vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf)
+{
+	struct file *fpin = NULL;
+	vm_fault_t ret;
+
+	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (ret) {
+		if (fpin)
+			fput(fpin);
+		return ret;
+	} else if (fpin) {
+		fput(fpin);
+		return VM_FAULT_RETRY;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(filemap_maybe_emit_fsnotify_event);
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3299,6 +3391,19 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * If we have pre-content watchers then we need to generate events on
+	 * page fault so that we can populate any data before the fault.
+	 */
+	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin) {
+			fput(fpin);
+			ret |= VM_FAULT_RETRY;
+		}
+		return ret;
+	}
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3309,21 +3414,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
-			fpin = do_async_mmap_readahead(vmf, folio);
+			fpin = do_async_mmap_readahead(vmf, folio, fpin);
 		if (unlikely(!folio_test_uptodate(folio))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
 	} else {
 		ret = filemap_fault_recheck_pte_none(vmf);
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			if (fpin)
+				goto out_retry;
 			return ret;
+		}
 
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
-		fpin = do_sync_mmap_readahead(vmf);
+		fpin = do_sync_mmap_readahead(vmf, fpin);
 retry_find:
 		/*
 		 * See comment in filemap_create_folio() why we need
-- 
2.43.0

