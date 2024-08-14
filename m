Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992521D1F69
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670785; cv=none; b=iXX7uswilL8v+z40NZ/947Q1ba8IsYPaTzgzhkz2mOv16kEFLDnoo6Ac/HTHOG+yoeaLsj/A54/60GSsYDh38QY5pr83Th1p73w7X1FeRkdPl3tUVMXaDKMb0tX6lL5F0zLlO7PY1GnpAG4W8eLEK372rGN5MCX5i4VfUaf20IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670785; c=relaxed/simple;
	bh=S0mezk7lokrHR+8fcU6LAupASbj5zKj9YDRU//oGrc4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6OKoB842fqrMiFwYPAVWoY6S0P/k+HwYE8GmeD4ObrwhIPjUmNH4ugEgesPFaesyzM61Vkqao8ldWApddxHNDUJT4zElwqKZZRAntuHoEnnLT6MP1C+LeLpZHk+j4jttdh8piMboDH9P80nDCrpxZkvcFFA9hMfwiyfu1GllTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FpDGDD97; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FpDGDD97"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d7bc07b7so21122385a.0
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670781; x=1724275581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g0betjFPlSWGNNLN2rg+et8Qa/vCpguwAUALfab+wk=;
        b=FpDGDD97eyGqqNMHXxSmOuaYZ1p9dXtS/IGOM8P20LajLjMo4mmNJliljw91uzorfv
         aAG3aNV9oNXW9w17WceUKrkXZljV7AX9mZL4SIXqN2z/nY+2gcWUKXTVQ/szN+PGTODZ
         H9CvF19y2H5230pccOybBNPfANAz6aVi7OfSsyLV4oqnoURdUzzXsuttxAA3rlrTH3Lw
         LcF6rNZlwZpoCGYv9lTtq87Z076lAyjTzmB8mD71X8XCLTUK4k0bwpoQ1Xl/cTH/vNGf
         JO7VmFPdIk/2QBQQPZtLjecd/N3pngVHGvh/vbzLoAFiMG5DoSTSO46DmdZh/DaV/b/B
         7RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670781; x=1724275581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g0betjFPlSWGNNLN2rg+et8Qa/vCpguwAUALfab+wk=;
        b=oJZItdCocJSku2VTCQE+sdmYs7gQttQfdqfn3pabo+zNmBU9zD2SKztM7Z/naB5kIs
         yPHAkMSmV2L2mKtZxR1d6r3RkUfee7AbRB3azwiu+v1a05xQbG6liD0la6cyNpVt5eoz
         /4YwHIbmWxAnWCgkdkrC/p0xo1nTGuNwvXyZOLfwgem9HMGxDNGTt5237Z/SgCbQyA59
         EI82SKGWEY7pkzRTUVwXR8b8V53k4s0wALgHJuIsZINkskYITqPAi7HkJ1q79h3YX4bW
         vCnGwDqKsZOwT0ufb7BxzC5jUgdBk4n5VCGQF19PO8vGx2uAtBOWR44QjXQj+XbBbzzM
         EPMA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsxT5dVgZ+s+Ly8kKotfsicR7Nc0/pIRZRPPSwkMMhgFNX5YtmiQZUCbDvPjcXKOigOYCi1hOkyT5YuYRZdLD7D82vQ==
X-Gm-Message-State: AOJu0Yx7q7/j0W8ikM/Q0FdzS97N7li3s7v7fxJwFqD4mGZBqpJ4xEXR
	ztHb9Fem8SfGq/VL96F3/MmnfHobUwi662QoOg3tYFt/3bYY9yYEGLXu5+leb1I=
X-Google-Smtp-Source: AGHT+IEwLYSHYYTuAZJvUuE3hfd+/zuyGZIMkGIICNZLTcaMoU6Cqa81XGFABSQNoiEu298KSeXnZA==
X-Received: by 2002:a05:620a:288a:b0:79f:17d9:d86b with SMTP id af79cd13be357-7a4ee318773mr448400785a.12.1723670781667;
        Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072683sm480751cf.85.2024.08.14.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write faults
Date: Wed, 14 Aug 2024 17:25:34 -0400
Message-ID: <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
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

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..e61c4c389d7d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1283,6 +1283,10 @@ xfs_write_fault(
 	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
 	vm_fault_t		ret;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-- 
2.43.0

