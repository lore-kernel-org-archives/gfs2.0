Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38815168490
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229113; cv=none; b=U7R7dARKyd2K5NBDXx+t+YXJcOxnA5PWJ8KdQAHGLW0LJls0cgAjwqXdprTF+KE2HLaMmfGBpqyrtji1N/ztjBQvTbnt8hFZP1W6LLxSfy/s1snWXmbEg3Ntj4jZClm/h1onpOxNZkSc1OgoPxl5PGkf9si1DDBUt4tVEY4pOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229113; c=relaxed/simple;
	bh=NSHxxZRLFbsIgAXbtW5uSuQCtRZde7l6XJ/+Bc0hmhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT1wDEBhyCgv/zt+CxflmtVSlOTTvvYovdwASZ0AK0UGgDdSyTTswcJdaceV0A0eNhc4p1TByc/UTIqTh5b8o9RMKtmub9JQXGSrKP/98UIq/vNRhiFoJPxYcirIROpT8Q7D6E0UdO2o/2qq91W0reF8WoydFhOHNCjS2ZOT6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h/7gS0nb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h/7gS0nb"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1e4c75488so147132685a.0
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229111; x=1723833911; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=h/7gS0nbGM5GnQYyfFv3M7AHWWc0VuHZTkBkoRpoPCjyeNFERzKsC5fILQ1Y8TnZk/
         tNq9q0rVLYzlD+B5fjNFnfUTHlxKxD0j8cRaG53Fz1vnIkPhSUczmN7HStGPLLy5Suli
         NWwqOIUThHC6FiVTTF2qDNHCwi62Ose6wMwjCgrGgysL31FgpXHQgVoCELqDZoGoVaso
         tQj2jrlkXE70UGmYb1l+sxNFrLEQQODQe6ajEWc9nt3evevDwwdQPGQQv+YzcNibyy6h
         2/qE3z2+O1ie78c3THsiD0M2uOdUL2mTpShFuytbbdCMzQ68xI0ZJJrvWtbUrU9jRK40
         w9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229111; x=1723833911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOXg5Kh3dRzVUCha6XNrLJPIFEv9dDgQMOq3uyVXRLk=;
        b=i9rIXcVv+4iLpmqNlWw819j8j/ECni/La/pIbee9U/2h4jdQil4BkDXwvgdWUPRLKw
         gHJ7iLvll7osGFcqEzTZXfvML0hSDB5/+yLkWfvaOe4saVSKp+JvppMJYSyXdbBTfMVO
         UBR0MZfS18s90Dg6pGrXrVYTg6Z2SV4oCunhSgxAgD6JhPknk0+Bk+VHgYvJ2STUKXSD
         1seHF1C5332N4llqq//ZDIi+pldCb2yHPLHCPPcrB04MoGGzw7qBTQKIvMMDjMORhPvw
         0lNuKX380m8MKlEdvB2DGO4pSdpA7EkRhFviD8o+Ip7O3wIO9UWCDCAAm2kpL0nAR4S5
         MC+g==
X-Forwarded-Encrypted: i=1; AJvYcCV+u2hJi5RAihwQF2QZRswWRz/+thIivSKVHU+Nie02yOFHuY2LH6dSZ9tcBUZOshLnL9g6@lists.linux.dev
X-Gm-Message-State: AOJu0YwCS4TBumANbqWHy+WShdarGxCUPy+wNzxirE9ADoDwofP8WjUH
	btsqUCwpC8YKtH0YvXFjEBegPEbcv7Mu7ei/h4CRq4naEpi6PsxPF/wx4nvs1fw=
X-Google-Smtp-Source: AGHT+IFUlaCnTLIlVacmXjgmOXF1HYhqS4K6PRCpr55qRtWTp+PAc8BlcRL5nok82sjjl/gCBuRfmw==
X-Received: by 2002:a05:620a:bcb:b0:79f:b21:cfb2 with SMTP id af79cd13be357-7a4c17edf2dmr278139085a.40.1723229111208;
        Fri, 09 Aug 2024 11:45:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7ded208sm3899685a.89.2024.08.09.11.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 15/16] gfs2: add pre-content fsnotify hook to fault
Date: Fri,  9 Aug 2024 14:44:23 -0400
Message-ID: <71aa4357e168f298d18910495da7467eec5fb79c.1723228772.git.josef@toxicpanda.com>
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

