Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540115687C
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145319; cv=none; b=mO0hagIImtNJNd7j7jzP987Aa4ZF7TvvEu07RlFKpmSsb92AFexVIekWML9IGY5j5EzWuLPdWErMHLPBYp8XavuAoskwTfMw8VF4m5RjNUVX7hb+xHqUM+Ti+292WRavd6gWEl6AhCnTHkwhV8PMcmP+6bHtSZ84BmgDMTTUK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145319; c=relaxed/simple;
	bh=NX0d0m9ReKcqhm2PuSfHrLPH/9MXqCB++0q0ouz1III=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5aVF3yqca5lXNFIWEa71bQqOGvutD+bu+qdMQpaC05h5EHm+9UZjBBG/bXOlKcuPWYhXgdHSzt+Gi8xjxgCuGDj32nWBaZJtWDnFkeh8xdKFE39FEE1uQdk4YGSHySNP5AB3DlsP+92P87YEccCP1SoqfgB8DWH7kT2Vd2IC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IijrN43f; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IijrN43f"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a337501630so81973585a.3
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145316; x=1723750116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCXucMs8l0Ng5ZAiC85xGGR8b9zvUxCeXymlHlDJx8U=;
        b=IijrN43fBvVO1/NngHu7RIJFNuFSP727ZTg5bNgZ5AAGQnDnpeY0gCM39dqH+JQTmE
         jJB72IITwibyhxdGb7zAQBjHcGiFHjZGyJ4bXlli+/Uy+BG9X8x8Dzb/eMCX73AfYXEE
         MyfoHoLIxsdmPzov6JTt2kMWuADgoQCReLUlXRweGCoHBK4G22RSzMGvn5tOnsgeMea9
         9FWBret9zDJdH+iY9zPTxCftLkPZM4hq5DvvOdjT15oZhdl5nyzuKIUIOygWUjl/YujK
         iKU8BWH2kwVGloqJEwTFlhPr8V5UpPOk/LuQGcSt8HUPwijykalYzxLRBrRVk1wVMRHA
         OxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145316; x=1723750116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCXucMs8l0Ng5ZAiC85xGGR8b9zvUxCeXymlHlDJx8U=;
        b=jxCr4+QdpRG9xY47veCEUB6zgdbK7bxf0ghDhfX7l0eSs+12KhZdI0pwpgYLZ4OIVe
         1aiQTlA0xWr17DhrBNi+950GDCbnk7hQphmOwXQIo7B/7ThgPJPyRaAspDu9TRXE9ES0
         fxZm9I0pXcnK2jyMSNPz7J51b4qlcMaIUk4xck/vnbpde/fG1oDmvUXJ9F2rwpgD7kRz
         EYCoPppi9hMA3BfPxePXRd42haUE3O4acCxMshhuGCKn+heUFwwl3pqghp59ANuqc8Xd
         Mc6FaJPrhOBA3C/hxxRzzcbskNxZa4B63PQdXID+reJliuunTWrRGIQWqFlW9hqrTlVv
         rSCg==
X-Forwarded-Encrypted: i=1; AJvYcCWbhs9wvc8z5EMagtTY9jGyKOp78jaD79z44gs+FB+jLriwPg4x+QkXWmVLJoeo8DoqD5f5tlmCdptRXZ9vwF0BSyo+rw==
X-Gm-Message-State: AOJu0YxvU/23QqMPhfIFbA6XyynvGaFuIXDsmCjjankH0noTIdnSPHVP
	9jmGHPQU3yaL24yegzxCiCOcyz5k0orDLV218Vnu/T2G2oMgULMs0INSYn82hSk=
X-Google-Smtp-Source: AGHT+IFqTokrODzDW+F7aRkm8RWDe1d2EvLJDXo8zz/Qi7NPVBOa+VCzv+goifozXKnE/sORJ8j7uA==
X-Received: by 2002:a05:620a:3943:b0:79d:7246:ea67 with SMTP id af79cd13be357-7a3817f799emr380397285a.33.1723145316678;
        Thu, 08 Aug 2024 12:28:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786b5a15sm187770785a.101.2024.08.08.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 16/16] xfs: add pre-content fsnotify hook for write faults
Date: Thu,  8 Aug 2024 15:27:18 -0400
Message-ID: <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>
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

xfs has it's own handling for write faults, so we need to add the
pre-content fsnotify hook for this case.  Reads go through filemap_fault
so they're handled properly there.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_file.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc9686..585a8c2eea0f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1325,14 +1325,28 @@ __xfs_filemap_fault(
 	bool			write_fault)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	struct file		*fpin = NULL;
+	vm_fault_t		ret;
 
 	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
 
-	if (write_fault)
-		return xfs_write_fault(vmf, order);
 	if (IS_DAX(inode))
 		return xfs_dax_read_fault(vmf, order);
-	return filemap_fault(vmf);
+
+	if (!write_fault)
+		return filemap_fault(vmf);
+
+	ret = filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin)
+			fput(fpin);
+		return ret;
+	} else if (fpin) {
+		fput(fpin);
+		return VM_FAULT_RETRY;
+	}
+
+	return xfs_write_fault(vmf, order);
 }
 
 static inline bool
-- 
2.43.0

