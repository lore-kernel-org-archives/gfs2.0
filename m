Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A7158A33
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145303; cv=none; b=Mx7m9tVA/gtPuiAo2n+5fiVlXkS41/FCWuI8IL6jDY7Jf5YLv7JG5P9xWJr42waPw0IqR6+skECdHxED72q18kfhkQshtTBbs3zFtkWFoBodKvBK1boZE7i9b9XKBqQcJiID/O52KBcUIH+MscU3hFWWYZ2CnQ5dCKtJclRascU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145303; c=relaxed/simple;
	bh=2T/bTyebmmWzgd79hiDdf0J2vl5OhNotJm/x2K/voWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgvN3vHfo7Wk0xDZu94OMx0ehmsgDC/P2cgb6n9rxT3CaO7FBxxdNlfFGgSL1vVd611Sbiu1JjOC/qTyM2BJebTjVbhPAHJWo6gjwrhxLVwFtKRv+hf76tvIcs5fXAjX6iLTCVUZD1jWI2zgb9GFY33E1uvDgY0i+HT++TAteOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2lW5L8g1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2lW5L8g1"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d7a544e7so83797085a.3
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145299; x=1723750099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=2lW5L8g1p5Z0JLBIEMJANcNNrJi5oo9dLjwomXcL+mADZfHnZYSDlW5X17lKdixe9C
         bI76mLTtLQWkJBc6KdPTEdvvSAxCMVpqgJNoFYGrVbbU8b0qK7YcJrXJyHBe1HDiwgWL
         VDq0tUdKKYIUv8DuyuuRXgxbIzeIyBM0jxX2JH16kHOwY/wzEjamzKuirOqz9l00+m9A
         qj3LIlCRPqPpCYJYzRynWJIolxRVOK/GioVdIe6EYaNM587jXVhfqNCF0h3crHW2isua
         EC1RrzKBuYDD4LxSHhRCBAC9VGUn7fpRHYvKa8FjLSEU4G1eI6jek7wBKh0QUFfhBs2d
         LUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145299; x=1723750099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=tR68fNP7YIRRIuPpx/8DA5WlYip539ZT5/QPS8hInqyhh/HUOC5dg3kcGFOL0jJCsb
         cEs+FrdGNwbIWo8qINgpKZ63cl6jxXj42lOk/vP1FwaQd4Uo18nHG7imLgKRZQS4Q0LL
         4PGgZEXHHx+5TEZIMsgqs3j4GKXT56tKO22UMX74LssO6WCFV+tC/mekuABGP1S0O2c7
         GlsTYP/OfPv5SMFiBH+Bad0kKMMGGW6n7j7+PJeORYZeXKRHFzJ79PDzTTTI4WEhcWXA
         LDShaL52eK9K0LhIa5GxbPze98nCQml0Rk6yP+ZARwtLFBr2IbINl4cDG+QDmNNkpVmt
         /7kw==
X-Forwarded-Encrypted: i=1; AJvYcCWPCSFZ/b3LVUVJtPsCL1pjlaBRqZN+G0QpCkmrHOamQKKQ1dNVa19IsKijAg54BTusq4noz20SYMmXTNTi/3joCzlPuA==
X-Gm-Message-State: AOJu0YzAZ7dHvlWCANzcFKCpwDpsPs1vaY7tIDlstbDaZQJRszBibP9S
	HMji2GOZSnkQ6uQ6H0otqTIFu8nI0PQEfBMOkJAvLBfzaJTTl/18TaQupgemOwg=
X-Google-Smtp-Source: AGHT+IHIPxOimm17lsK2mRhrmoBs8JQ3/lrD4oPi09uZKL/T2UFWVQatxODNJLMYL/PxGf3Q64nPmg==
X-Received: by 2002:a05:620a:2596:b0:7a3:49dc:e4c8 with SMTP id af79cd13be357-7a38183e77dmr296678685a.31.1723145299430;
        Thu, 08 Aug 2024 12:28:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c86ff90fsm15610521cf.5.2024.08.08.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 01/16] fanotify: don't skip extra event info if no info_mode is set
Date: Thu,  8 Aug 2024 15:27:03 -0400
Message-ID: <6a659625a0d08fae894cc47352453a6be2579788.1723144881.git.josef@toxicpanda.com>
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

