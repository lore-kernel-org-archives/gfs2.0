Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F614F9F9
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229097; cv=none; b=MRVoeYwYYG9l3VRhNQWJibSEzTpOog2tpbD4i6ZK/PoUbrr9Y3pSNj29PVVKLXBPrDV5mA22Yj+V/3YMisqOxjK6rIxAZJd3ZR9+XQ0/0NgKzSTVGGNQTQCZ/BMZl8qFYkQ0LowhyZh5rKeq9jhre1F4uZ16IbIsaC44lXt/uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229097; c=relaxed/simple;
	bh=2T/bTyebmmWzgd79hiDdf0J2vl5OhNotJm/x2K/voWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEboWCLyBe8Oy8Pk8xGiHwLk+nNsuh1uMYn4AXSH8Z2fKetm4GcHQ/Qtu+1mkZOT5oGRt82zbHG0heJqZA3iJ4yIOu7bqYciaGGfW+gS+JEKIhJV0LUoJoN+iko9dUovU/n+PM5dq3ieh8A8FisT/4sgUzmxISb933+R2j3YdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i/x64MM9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i/x64MM9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d42da3e9so137143885a.1
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229095; x=1723833895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=i/x64MM9oxfqsC9WySrjWclbp/y6V7pUVZDKLaHd0qGRK48Q0Kp1oZ3RHbGhEAlGol
         4MaflIImM/9orcmiN5LFNT/bpIF2bb78jczpQ4eV9TEMk37L6nmiPDhwoEYZjmwUKZPX
         iBenTe8uL1fV9ob4JRXQk9uIt9PNByFK6DTv551CJvuCzjOh/0Jcc/6QwVz1XAXY2FMQ
         EcYofl523MAEdTk59H2jThg38/bqFWLWAGsYH1UHVRH9ISXpkuKxEmFAXF/f1nDVLvx1
         5UoYQQXE88UuguGj5pCEu4LsYQml0dh0b+LcTR6SHiso0MHE+BmTTaAVf/DO7k9fsd0T
         2h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229095; x=1723833895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=nr/R1rmnt+1OtFTJB3Za2V/lRYhbzVmNQFlMibGe8ovILsWm5LsX/HsnlJKPtbIbHR
         vQuUBLWc2NJGFAIZZK7JamAKwXq1smKbzm6Zn5Y53hFuT4R4PnwJsQ4sdrazTpavvusu
         U648RQjA3bX72uTn8y1GgO/tluyAlGLkGZYSPSGMgN2mCfcaRCb65uTJqnUk6NJg7vuG
         8+fawYUmb/0E5XM/U9c0Do6AHbmL8mM4UVNpwkzhNEfwUVrCrlyv3U8fYI8hcx3aN9Qy
         C28cTnd+9+y0CtxChFyVijYYcfMPRvoY7TyEjvBFds1jOHJJ3qnu9axRm6lNztnzb9to
         +R5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWdvO8oHViP9ICytjsoKh7egLalnFmuRE3+T8W0jpd+ndz3RzRrUlfWLL+d83W2ye6UWy1tYIbyC79BI7zdhTqPmM94A==
X-Gm-Message-State: AOJu0YykKLSMA73whScpgMIiYlMdZzoYbMTFrh/D6hhBFBdudNl9qrik
	V97u/qaw2T5NXFMv0ps0uMKgx+t3yOWOSupMzRPOkIInD8jBmVDT/X2Ih3SubJo=
X-Google-Smtp-Source: AGHT+IE+4cAeGI2IrLHm9+QXQfJeM6o9eDiy6XNCvfHvWZenBULR3s4f7ggKi9MJTEoPvfkVGp5AYg==
X-Received: by 2002:a05:620a:2589:b0:79d:6039:783c with SMTP id af79cd13be357-7a4c17f0865mr249153685a.41.1723229094969;
        Fri, 09 Aug 2024 11:44:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d820dbsm4254485a.66.2024.08.09.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:44:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 01/16] fanotify: don't skip extra event info if no info_mode is set
Date: Fri,  9 Aug 2024 14:44:09 -0400
Message-ID: <6a659625a0d08fae894cc47352453a6be2579788.1723228772.git.josef@toxicpanda.com>
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

New pre-content events will be path events but they will also carry
additional range information. Remove the optimization to skip checking
whether info structures need to be generated for path events. This
results in no change in generated info structures for existing events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ec313e9f6e1..2e2fba8a9d20 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->fd = fd;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0

