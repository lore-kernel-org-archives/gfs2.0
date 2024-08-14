Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607371C7B6F
	for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670770; cv=none; b=WQHJLmLmriiUZRil0TkaXZlfUtGkPNSPK0AvA1H7giCOk61fh9Ngp0soYwpuT8riIAz7cQh4Grt9Xj/ZR/AiCdUdMrvzLJjzlTqosQL+cqogyPNu9Wxi+rVwkTEhRknwF7csXk803A6eahhpJIKBK5hytGjEXBHhjd10bYz+S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670770; c=relaxed/simple;
	bh=2T/bTyebmmWzgd79hiDdf0J2vl5OhNotJm/x2K/voWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io3Iv+KOd8+S5nlbA66FxTQx1WBygXrABALUpjy1DvNugMFhUno9KEZh1XpWrI+VsvtLA88lQ4aBbU7AcQGmK7LnLSBtd5W/mMKTavqip+0HUi4IjVHvyDXWuX5ClF2pxeSDTKI61KFsmo1VFXj8i7cQYqmI9RoZ0JglYR0kXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SXbuP/eu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SXbuP/eu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fee8813c3so1824301cf.2
        for <gfs2@lists.linux.dev>; Wed, 14 Aug 2024 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670765; x=1724275565; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=SXbuP/euJrxoOyelCwx17016NKxda2GTkN6VTIpU+Y+6v9XQ4KdpSDqLFsv2nVtNXn
         XpyI32cQ1MrHXVNrqLoBSCSKA5WdKcsti82/B4uK/9aW2Itj+pkmUmJ+sZNY2LJsTiWU
         DpAoKQxqO2LTubtKPKGCv9pSTX13fnO/pucHL83qnswcljs/jvDAvL7dHjHQpmgxqd8+
         +5A6PL17rnZE4nAwfHJ+c0o+RWVktkYBNwWlutgfqGD838Yg6FkFmgQIaLh1m+1FRDFR
         YHsZq/62b7HbNrPC04LhuJdGZzHw4hRpiDItBiKXSlqn5CoHKOFff+qXOEGR5q9wZltE
         C62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670765; x=1724275565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=GgpupF2lkIcEIy4A5dWx9nWuZpfbh1x3ddSeEWwRck6Bhm2CIm7PwJyjQamiZkvVKz
         HlObYZNmzttBQ057rTUGNNlIFWk2OHS/IxbuEpV9c0pL9TT2297JwSGm62p5VStgLsnU
         qb6C7K9PG1egl+zLA72ohI+asV9bwnvbl8U4YJKKsgTKlAHkTVch2dNMLCpvItb57u08
         M0mG+uX3ZXvP/BDTmBHIT9D10NH8MUOB6YozIPqhK8DSTBVgmwwEBbysff+C0B31p3IV
         q4MdZ1CBDv/TpZxLdyaNb1reTXEz3JT16JJwagzRo+ensnHISzaqs9S0HfeQhcOB8IS1
         5koQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeq1NLQrJDXmgQkdp6wplDanpT/E5/6uUs4MTssm4Zbru4weIpdOLY33KiyJyyuaW1NPue88YkVgopMXIkAD7Ei8WCXA==
X-Gm-Message-State: AOJu0Yzduhj+VdhF9khabI4o5vkGHgMMRRQme4+qik8P832XOm/LFKi8
	gmlTf7EbhdwabLUYMphmZX/MRkgHrfBn5K4LlTmXPgJ/fZDPZHPBaoUStlxjtVU=
X-Google-Smtp-Source: AGHT+IFOosLEfbUYy+rk3DgRd8S4qUKsWD9x8eVobALgVUhAo3EcRpZRN6epvvOoKaA1rXEtmh1uXA==
X-Received: by 2002:ac8:6f0b:0:b0:447:ea03:454b with SMTP id d75a77b69052e-4535bbc9e18mr41862931cf.51.1723670765231;
        Wed, 14 Aug 2024 14:26:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff3465sm558691cf.31.2024.08.14.14.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 01/16] fanotify: don't skip extra event info if no info_mode is set
Date: Wed, 14 Aug 2024 17:25:19 -0400
Message-ID: <6a659625a0d08fae894cc47352453a6be2579788.1723670362.git.josef@toxicpanda.com>
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

