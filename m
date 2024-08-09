Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4C16A935
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229112; cv=none; b=sCWjDsToVm+rlRAwAGLMwbc0jPlRKF0bOmdyVZoHq1ALUPcqv02DT6/mByZRE45lghaFqfnl/HONCxX84ZDKO+Q/v3jRP7Zx5VeRusljQNo7XKzTJQdv7GOS+QOG3G8mZ4iMmUdKyHUbYsqTTApvRkneZntbHwSd4KE9AnXlvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229112; c=relaxed/simple;
	bh=/ZdKHR4pHjntJYSoUdVRDKcFzv/LrElzLuY8Xsnn2js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRk2+nxG/oirBe5wxrw9D8Ytyd5BaOWgE/MKSEFXGyxd0Ofp9s041+Bkik+HtZ+LYGWWe0N5+9v8fTwDIR0cuk0Lvl2xswUNpV5v92GbSdlUf+TVPm+Ypg8QJKA7GsjM2UVgLPti+6H3rOG4GtRPNnu5l+brXP/oVlY0a5iHwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=l/omyKzi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="l/omyKzi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d3874c1eso135838485a.2
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229110; x=1723833910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=l/omyKzifoTt2xSCGhdEPFXgm6qZ5zsuNE9E7uN+i68DV240/h7HE78VfRmykjnzyT
         mZC2MML+W8a7FHUu/CjsNICpcrMbJnDTe6KYQ68vXXVIuK7jVf3VqGucIL6wKtUyyRLM
         GNC33poAmrsH00TjmMLaxs5zXFW/+j4lspii4x3prT1mXRUwdm50k/JvuWSvfW1W4iKU
         +HrUKYfxhKS1F7SJiRzmwk6Em+KMva/ZrK6p5AfkQbCWxQA3lu/sV/N3wxbMzqQNdzvN
         DvAXAHFjylneAZnXoUs9tXC7vx+GvEvlYxMcZQN+H2XHZ8OP8pZZ5aDG6Y7jWoUNJ4Fq
         FNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229110; x=1723833910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6bShe37d+I+GAe4SQfQZex9z+pcNLPbf8dU2iG5Y0=;
        b=LDVuw+8o3ZviMAH9Yj3RHc/4y7kaR7jrDHo5te3xw3SkZDkNvLgMhOr9UCspQvN7FY
         +YfeswZG+PCnSCq5+P9pwiBC3oDxiShW3bSaarORa+Gt/4lcFupxnlppVMeRh34OP6+G
         bnth0IwTes8N4OwzYifaTOpH3qd1tb8ejy0PzLUa7hrCgT09/+oa67/N/gZigMdLPQOc
         kIyUiuGSFyPjrSp/yPJ5DCh41Z1gX8MB3a0vUe7fV/xVSXFQmuhN7/AHwLw77dN91iCF
         XLQoEsmy46hA72uBWK2TGPMLS8PWH+ki0pVqx4xhqEZe7ULxQrRuuYaBJLmVM/aL7e+5
         KcEw==
X-Forwarded-Encrypted: i=1; AJvYcCWTH7wjAnufl7hY4PKpkNT7+RAo6rQDdCz9brchmbp79Q7jbtZkev+pWRWzf/VjXo4aCzFxxhGh3bfcYsB20XnoGxAwWA==
X-Gm-Message-State: AOJu0YyUWhXQ4PemW9kwjPdsHtAfa3s6OsrRsLjjolDW0oz1amh2KwWp
	fh+FIeRF/OahRz5C8oBzHo4YwfchFhNy8KJpjJGVfP4W7rIQHiXWDAuc88Bj/nY=
X-Google-Smtp-Source: AGHT+IGkk+5fyo6NCGpzPleO9dzoJzviklkx5ZKaFGvNslWQvN9ZFJWRDyezozrA8VyzG3HLheVY+A==
X-Received: by 2002:a05:620a:29d0:b0:79f:dc6:e611 with SMTP id af79cd13be357-7a4c182c4bdmr273891485a.53.1723229110136;
        Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d8b0fasm4267685a.64.2024.08.09.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 14/16] bcachefs: add pre-content fsnotify hook to fault
Date: Fri,  9 Aug 2024 14:44:22 -0400
Message-ID: <b3fc6d63e23626033ff2764a82d3e20a059ac8a4.1723228772.git.josef@toxicpanda.com>
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

bcachefs has its own locking around filemap_fault, so we have to make
sure we do the fsnotify hook before the locking.  Add the check to emit
the event before the locking and return VM_FAULT_RETRY to retrigger the
fault once the event has been emitted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs-io-pagecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bcachefs/fs-io-pagecache.c b/fs/bcachefs/fs-io-pagecache.c
index a9cc5cad9cc9..1fa1f1ac48c8 100644
--- a/fs/bcachefs/fs-io-pagecache.c
+++ b/fs/bcachefs/fs-io-pagecache.c
@@ -570,6 +570,10 @@ vm_fault_t bch2_page_fault(struct vm_fault *vmf)
 	if (fdm == mapping)
 		return VM_FAULT_SIGBUS;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	/* Lock ordering: */
 	if (fdm > mapping) {
 		struct bch_inode_info *fdm_host = to_bch_ei(fdm->host);
-- 
2.43.0

