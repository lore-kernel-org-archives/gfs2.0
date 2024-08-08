Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5215F3EA
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145314; cv=none; b=lTw5RCu/2Gcd6yBDVfUnBHgWlg4MTRZ09IIlFs1TELlJYCEs2ck5a8LHFD0p4ukuaCFoHvtphcPqxnvPX9xUaw+2PdO6SSKpLONsAs94lf/96zKFrbYHxC8iL6Opy3M1D6vK8tz6BwVgewnKyRbf6g4yxMtgUycBq9GbQ5q8s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145314; c=relaxed/simple;
	bh=SRLbOqJ8zAl5qD12oNCtm7iiNr2HczkPZnZesiep1gI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESzuapz/g0JKpJZJgxUKadfXw+mN2R/TuXRCUu/+dTH7+llYfg1gxxug9dVw/u5L/x2IqCzXBbQ64UDZY6b04UXpT0eEVXPZnJgX2ZafdoM4L3xVasZz4hA9c07Uapo7574L8ZfGHmto0AMJZDHTWQrVekPXUyK7qoc2Nd+z4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WD7dm9Yc; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WD7dm9Yc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe28eb1bfso7150901cf.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145312; x=1723750112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ0oLpoVqilzi+VChanZFK4WtdGvxjCPwQLhvVUYV3Q=;
        b=WD7dm9YcwHwpy78ZSLHOD2ebzj4vu4iNF26KeF/eQHkxmHpss/qW/mC7CLZQFkMXvC
         /ytpniHkdzvypYqzClOegvMi1vPabxPA9VYQE0QViHCBx4Ql6DKSTK7Di72purYO7OXd
         w6OnwIp36EAy6VpkI/9JpCgF7VE8D00N9/D34kzK/i1t5Mu36rFHL0F1UbHJI0m5nxVi
         hYSF6th8Amioq3zlKt35klGq0GJVFhH+hYPXQ79kdgfAY7ot3oUmd4UD8SyA1/3iFjbn
         dU9BdosAKLMfPx1A10VbuEKRtpsVUOKkMagJpxJxNEeGAQOpYEh+XXYWt64GjspIFqKf
         Khxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145312; x=1723750112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ0oLpoVqilzi+VChanZFK4WtdGvxjCPwQLhvVUYV3Q=;
        b=dOKzC1bkJD8zS04RAap4IfnGCf0U+VePnOCA9obwP+9xelfPNVrcGp2EFQ/3Ad+BEB
         pkfCyNgsCNNDDxjtCQi8OACJ7eIubI2ICVoanHi3mNpViDawzYSienAvG8ZWWekAHcMP
         R/Tl1lFIj+6stCoykSxEO6zoL78n3eILM3bztAfzONViaWeA/IXlQg30HnQMnWci/3AZ
         HDmQwhol+YcX8gk+zGOSxlBJbJAzicaHoPXguf7k5zJ/TM4WoPSdU1dd3o8nEy6siuzI
         A4WqrMtpGJZ3ZOxOwa3nd05uHcPFVEeNgsnPkSRmFdyKqspIfzCza7Prhd/JTMI+zq9S
         /LKg==
X-Forwarded-Encrypted: i=1; AJvYcCU+cSMCELjc251hoDE3JaXfNOCn5Wbe5zzNjzbNwnCMBOYiQYgH3NzHPzYxQ6UZ4vkQ5lmcmaEsZ1iadcSUoODCbhv35Q==
X-Gm-Message-State: AOJu0Yy6DjV9MXIft6l6yMZc1P3kQBVAigMDy0YlcCApJR6jDPr+IEUi
	fX82JV5pmTx/UH2UyDbMSeiYHqu9alQJKXg+daGvldoYI949sprgcHATkYqpQT4=
X-Google-Smtp-Source: AGHT+IFCnvBLMQYwV4xdiQDtXkQ4ye2f9PGHfgns1lK+Hj5Gxr/FET7hfoWmkMYm+Nx3ymsaFXyQDA==
X-Received: by 2002:a05:6214:5687:b0:6bb:b1b7:a690 with SMTP id 6a1803df08f44-6bd6bce1ea6mr31418406d6.22.1723145311777;
        Thu, 08 Aug 2024 12:28:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839ee1sm69475856d6.89.2024.08.08.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 12/16] mm: don't allow huge faults for files with pre content watches
Date: Thu,  8 Aug 2024 15:27:14 -0400
Message-ID: <8b4c1abeff52322da354a4df2881ec13b7493fdd.1723144881.git.josef@toxicpanda.com>
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

There's nothing stopping us from supporting this, we could simply pass
the order into the helper and emit the proper length.  However currently
there's no tests to validate this works properly, so disable it until
there's a desire to support this along with the appropriate tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..3010bcc5e4f9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -78,6 +78,7 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
+#include <linux/fsnotify.h>
 
 #include <trace/events/kmem.h>
 
@@ -5252,8 +5253,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
+	/*
+	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
+	 * a huge fault if we have a pre content watch on this file.  This would
+	 * be trivial to support, but there would need to be tests to ensure
+	 * this works properly and those don't exist currently.
+	 */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
@@ -5263,6 +5273,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 	vm_fault_t ret;
 
@@ -5277,6 +5288,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 	}
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -5296,9 +5310,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
+	/* See comment in create_huge_pmd. */
+	if (file && fsnotify_file_has_pre_content_watches(file))
+		return VM_FAULT_FALLBACK;
 	if (vma->vm_ops->huge_fault)
 		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -5310,12 +5328,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
 	vm_fault_t ret;
 
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+		/* See comment in create_huge_pmd. */
+		if (file && fsnotify_file_has_pre_content_watches(file))
+			goto split;
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
-- 
2.43.0

