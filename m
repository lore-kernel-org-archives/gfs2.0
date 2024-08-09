Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1021684B0
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229114; cv=none; b=EHxgTufm3aTxVE15KZlHBhuzpDH2nsQdrOUEmrrdlKAmI3kN/ZYO6NhqHLee85gJRZaHBx+EePN1iiyrJ0Fmg2tZ5e4u5Nv3mLFvbr/w4m4durB1N5vp8tHl8lTp9sMdpAo05KKviHKPhDgbUi2K5iv+NPYxQXBXsJcIH38FoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229114; c=relaxed/simple;
	bh=uxGrBiucD7p7Ovvt2NnMtbNYRzbUNbXg1SgQqjwZgKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOm5/RnF0y8QeWWFSVY3tPZ9/QsacuXfF96HXDjXDo6a18ctLqu/lgmJdE8ykD9+0mNEc8pFwdJNPKU8e+9SeFte6Cr/LMZE8r0bjGsStFcVT49+7Vhzy9Znt2rP/FvHCF8UHbWVVcdkboxkUg1lBu61RyZJY+WO1W0wiZc21tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bDZdYc4V; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bDZdYc4V"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1e0ff6871so139014685a.2
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229112; x=1723833912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBcIS8bGmeuMqrkOmKfrTgkr7F6YqxXKL01YAxI4iS8=;
        b=bDZdYc4VyMUOdVF/HoyNnc4kYPAFaFP5A+tWleO7Ag33pZy3s5/rkWNa4tapzctrrb
         y7u4pPRnz0oweYWZbBTSoo401+OPHoWCE2nMG6P07Umdnpprr4e55Nf9jLXwFQUpg77B
         WkMqGB4xhRs/cQrZw/7aUkMDYWakc+04IkItrYFgdj7KsA2Ta7wK7Y4Oo9SOfFD5Gtxg
         t3UngTjKWcnY3DAvc3+UBt6Om4IAFRqWFsHGkrtSQuqVCWu5/yHg5wnc/MAR3vYteGxf
         233/W3C7gHUpxMI0Sqx/t+CpRcznv99JHXI6urZkWbWC/aAst2NOe7KEe6LUk9mOy7/A
         M7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229112; x=1723833912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBcIS8bGmeuMqrkOmKfrTgkr7F6YqxXKL01YAxI4iS8=;
        b=cCRmpWjgzZR6etrziIjQ0mQIVXnZDD04K+NW4Gb8XzIBnCzFZv9Xy+4D7BBBATlPRi
         UdM/G9/RTlfSA6EsQrM+Q5gkbIxzfkwAZCSFpeDhs+3FXTMih4gJ0w9CtKeZc/S2c65v
         RGsSE6AVoPl6GC/+qiEG+5gSFXBPB0NnR2WWie0ATsUX7DCsMzzTkKao+rMml2Prxkhc
         /KSvG4MhBO41oYq8KxE2EzTu/6i2Mmj5aRkhmaIUZyxPBwvk00iHnIOKXL/K+6gxB/K6
         p5k4qMOCcNPMqQf9hC83y/2hsTCfcRugcjwTxXt1MmVZ4fEOfb1M/afWAx0zQER/Oci4
         lRHw==
X-Forwarded-Encrypted: i=1; AJvYcCWYD2BeDkojUlbMy2a5GVmLJ3f6sDhPna+iLRY/rkiClpx6S3uD8RLQeJx952dhOuVuxxawh7yYoGYHSeSaJssmjXOGfg==
X-Gm-Message-State: AOJu0YzcS6lbjSVRXKn10gja+taZjrThsZ8mC2JsM5Juu9yeTwb0M9Kc
	HvRuDoEDuYsvXeF5N2QO4IBcAO7HvOhJcrLjxykYrPCiIp4y2DKnRu0jQfmtgQc=
X-Google-Smtp-Source: AGHT+IEVNWswz8XKUFZnR+goo2+SardBOKKITXIcdyWrk78l67J7dmhAt2AUo3GEZ+BKyFRa3g0TFw==
X-Received: by 2002:a05:620a:172b:b0:79f:16df:a69f with SMTP id af79cd13be357-7a4c179206cmr276973585a.2.1723229112575;
        Fri, 09 Aug 2024 11:45:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dedd2dsm3895385a.76.2024.08.09.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 16/16] xfs: add pre-content fsnotify hook for write faults
Date: Fri,  9 Aug 2024 14:44:24 -0400
Message-ID: <89eb3a19d19c9b4bc19b6edbc708a8a33a911516.1723228772.git.josef@toxicpanda.com>
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

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..a00436dd29d1 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1328,8 +1328,13 @@ __xfs_filemap_fault(
 
 	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
 
-	if (write_fault)
-		return xfs_write_fault(vmf, order);
+	if (write_fault) {
+		vm_fault_t ret = filemap_maybe_emit_fsnotify_event(vmf);
+		if (unlikely(ret))
+			return ret;
+		xfs_write_fault(vmf, order);
+	}
+
 	if (IS_DAX(inode))
 		return xfs_dax_read_fault(vmf, order);
 	return filemap_fault(vmf);
-- 
2.43.0

