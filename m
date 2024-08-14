Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A631CB317
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670783; cv=none; b=jbRO4wVFrw8FaDcBJLYAhSDwACZZYLzdWcZGB0+XqjUo1651ndKDeY//0PaNXeifwUQWNxACv9SktGHwKJ+d7YPZu/kydzvkZRNaapCuqdLh9IVmWHZTvrzibmvu6NaJwjo6N31jgASZEEgw52MR21MRyx6KhCRXYnzL5MF52G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670783; c=relaxed/simple;
	bh=NSHxxZRLFbsIgAXbtW5uSuQCtRZde7l6XJ/+Bc0hmhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHltL46zwwJQRzItxTP+dzSe4Um7LDyyWXCvN8Vg189MsPoanTs2B0T0IOXwQfOyAItIbVzyCk/h8ZuAXJOOh8wlWomZN618VTZGq2HhuAj/mU3Zv5MG5NROySF6kP2njUJzk6/nrPVRI3cU59SW2t4/GVmx9TWOJxUwk4wchUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=g30VtBwi; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="g30VtBwi"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5de0e47b9so205211eaf.0
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670780; x=1724275580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=g30VtBwixSprQ96UI1o70jGL6dvk3ED9WmodvCLmwfPH4uLPzAGH6UmFpPxatItMxW
         hz7BzXctO9aBlfLHvAtgji04Tv07HULvmEnqoHJDpK6n5hPknns/h6WquOgi5RzYbgjF
         FReUYNQeIZ2XLhWkWVLsNV7AV6jNN/hiGTg4XjX4L0DoZEDfyALb1Pts1FixfCmF7Z52
         c/kphfe+NPeC+cTqj5O3vEZuVaalyg+mLP2rtYgeLW6v83mv4XUm61M+pcS0Q22QitXt
         KTaa96+5t6xjCO92gwV8cmqj7KAU4jNv3+SSy3VIAstYh/tCvQcvtKcUDNlvuf70dssd
         MFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670780; x=1724275580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=QQUeKiqMe/8PnABHMGb/61RbzWWeI11XuYvGQok46zxhJJDFGyNsaBmOD7utqI8ZBh
         yrebPP2JrC9vRCnt6y7vUCLq8LbkTFCcSh0XMqBTS/5TkX0K+pgs2LzACqqUfrmNhQV9
         ErgJPLpMZ2XD0jyJWkEgIywdslbl/wRWeq5GvzoFN3Ua3OdPxSV+GSr8l8n1QbDShCqg
         Bo4P5Sy0I8ztfQmHN6Z7dVK7U2GBSWl+jtTw8wI/CDN0w3NjyWbuQ7fS4kB4b5kaOEZr
         J62bK7fs23ZEUl46UKhGbTCM6rb2AaUGFlPacVVlPtoSwkBOpghXUXPrTa5NOxYxExpQ
         VZPg==
X-Forwarded-Encrypted: i=1; AJvYcCVNHBkwk+WpqShxJ9f1KDIS26ZQS3qZdTkHtqqFUKe2AwCuqz1TvC6n9w1ah5c0HMzH+qro969nbKeRsrZIHgsLjw+9QA==
X-Gm-Message-State: AOJu0YyCKVzVExnnbLVYgRCclDFG4jFXhiy8MmcrCPoH9fUegCS+GX5e
	FNnuUCVzxtbHglM+jVG37ZlDtYEhWsZhqzD6FMkQezOOGTVDtrAZcreMUCBqP5M=
X-Google-Smtp-Source: AGHT+IH8MPr5SHX8NbOpfre4Dyt2H2WS5ph4VEJ8agevnX7RI8saF6DZ/UBE7sdnWVD/jUXsHLxmXQ==
X-Received: by 2002:a05:6358:6486:b0:1ac:ec74:a00a with SMTP id e5c5f4694b2df-1b1aab9017cmr527013655d.17.1723670780544;
        Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5b09sm8115785a.73.2024.08.14.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
Date: Wed, 14 Aug 2024 17:25:33 -0400
Message-ID: <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
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

gfs2 takes the glock before calling into filemap fault, so add the
fsnotify hook for ->fault before we take the glock in order to avoid any
possible deadlock with the HSM.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 08982937b5df..d4af70d765e0 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -556,6 +556,10 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err;
 
+	ret = filemap_maybe_emit_fsnotify_event(vmf);
+	if (unlikely(ret))
+		return ret;
+
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-- 
2.43.0

