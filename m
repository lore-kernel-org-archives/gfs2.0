Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D13DEAC1
	for <gfs2@lists.linux.dev>; Fri, 10 Jul 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675785; cv=none; b=WX7fcUTIo4G9Fd7gMFgvjuIewNfcPlsvWCBP7TUAoWwr/DOPd1W3opDRIxqHWXuZb1wBT6tvrG/6Hmw49IMQV6k3eZGCNkJOZ7lPfKXcOsndEfDoFuCz4eKrsbH9+ZcV9LnHCqBMwyYWYHdLbi8+Wce4X36+agwiSuh5rJtKVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675785; c=relaxed/simple;
	bh=4ieCCDJ5H/rjXNm4Of+5Nh2IRMy8yRejL0AX/t6i5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUYz7LAF67bv1IVcDwMi5PmQO8lVBwsR7337y4Ckk2gmNKh2YTPOGt+FZV+UzsuW5h+8WnKgBAWtsj4yYAootqyXqcu9DngUeAsyP4KkyAOZusDhiBCZAZ/dW3YYyQ5RtCGT8G+MNuZQajwK7JAieNsP73OWPeAZ/yWgdHpYo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8nCS5c2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8nCS5c2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84874b52eabso693403b3a.0
        for <gfs2@lists.linux.dev>; Fri, 10 Jul 2026 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783675782; x=1784280582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcNr7aPJDaQGbJ8tF3tPtyZ2+lpmBfwpMh1imQLrr50=;
        b=X8nCS5c28kjtNjaPtpjBcvYDqN0f+4163GMm+c7GfeI8QkrJyt33AHSA/YhLHfoNWV
         gvTbDUfWITfgogJEUUulAaaxO2z2tmqGQHRMv2NjU/4DC2w9aOZCzn44myjPW7chTkwF
         FAs5D1uDG71O7bQ8pEH8o4sDwd+ZICiVPgc+4drvMUnLGV7Hxyc4b/LnLXQnWW338Wpo
         C7nNH8kTs70y8PTLoUixF+a1EIbqqRv1HAdqYI7nVT73RIWj9i6FhuwihWiJTKpkMl2G
         STg9N5oZWuHqsyYphIlD4GJEGsFWi+2ocrs/qpG7umGZncRGlNCnMsinoLdbA48SFcK8
         tYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675782; x=1784280582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcNr7aPJDaQGbJ8tF3tPtyZ2+lpmBfwpMh1imQLrr50=;
        b=U2d+Qd0FkMrJnfWcY7mEHoz+KgPAOrDv3k3VruWFalpmxNVMlfsPIJUBpJWuWRprEG
         9VVSAP2lceGd5NgSgvGbw5IqSdVCcfdqFMYBOjee2OwrlZ8eRz1ulA71xnKZJb358pfP
         bu8eIYydXzJQ3KpQhgYVXw3OlXZ+8hapkVVkk0fPDuxHHKDASTVkD+/2YPuk3u/eRK/X
         eTdLzRFUblM/Pxjak8eZ3W0KC7vgynYiC8tDDMXGAPdcoEEUg+LOGQQXIXVLTZW6JJmR
         tOXHdI9pTtLZXl+eV+mUqMiKZzYKciNiycm/TDTFGApxICeK2MP5nxIeuGBFzVGpCviK
         uSZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgO3bzSICfcpDkfdiOLYX1IR3hwxY0el92rYZJGCbY/oSsee2KZaqmHy+UVu0HQiRPBFs8@lists.linux.dev
X-Gm-Message-State: AOJu0YxbbTrTqEEITsRgxpAW6hAq0qPl3+cHnEWTpnylPJnkj6S0TtGG
	0WUw6HuPsdC3301Mks9Sd+m3RMimoQwRi1hIt5K2dvM1+yrqvk6Z0HWv
X-Gm-Gg: AfdE7cl5e4dGEpzzes24hIhqG4+HQLTD47c/KTEhzEF5+ljCKkSBht2rhrcwTAJDxCY
	6gHwVlVVOe714w+fyx1k99tdEijbu3BYawu3sxULOqHcxiFcZZuVIUZ+jQ2JciLqm3VMfTPeRt4
	XfMk5YgSNLn3tppHruFvjhhevLu8V+3OzGMElpTMnJ/vl6bYNZk5W+6kAOgxXHw6VPRC2pxdhbZ
	X2lcs7kq6AcSdjfClV2IC0tjRqnm8U6uR2v10rCzyX5UrbwVyNE5Xhzh/3zHaV+HxKDoFZdywZt
	V063PzssttECJk5KLgxva0MvbFjBWi9CFut7avnUltnYluHgzaSHDBDeQhYApH/g6eh4iFTx2Mp
	yHRjMZ+kXPJteyWVrHmTv3OZII3CpxJHT34drsIOIRy9vuMjRF34cE4QQIC26SKgb5Bbj6BQF5S
	MXpydKOisBrvqM7wF5RFzdxF8=
X-Received: by 2002:a05:6a00:3011:b0:848:80ec:5d2 with SMTP id d2e1a72fcca58-84880ec0b07mr281171b3a.51.1783675781683;
        Fri, 10 Jul 2026 02:29:41 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db0eaasm9982141b3a.52.2026.07.10.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:29:40 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: r772577952@gmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH] gfs2: stop logd and quotad before kill_sb log flush
Date: Fri, 10 Jul 2026 17:29:32 +0800
Message-ID: <20260710092933.3631376-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
References: <CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gfs2_kill_sb() issues a synchronous log flush before stopping the gfs2_logd and
gfs2_quotad kthreads. Given a corrupted filesystem image, that flush can spend a
long time while holding sd_log_flush_lock. Since the background threads are
still alive at that point, gfs2_logd can be woken and block on sd_log_flush_lock
in gfs2_logd(), and gfs2_quotad can block on the same lock through
gfs2_statfs_sync() -> __gfs2_trans_begin(). The threads can then remain in
uninterruptible sleep long enough to trigger the hung task.

Stop the background threads before the kill_sb log flush. gfs2_destroy_threads()
waits for both kthreads to exit via kthread_stop_put(), so after it returns
there is no live logd or quotad thread that can wait behind sd_log_flush_lock.

Closes: https://lore.kernel.org/lkml/CANypQFasb8voDrg=O9xJikYHdRFeupb5VP2VeJaZ_wFNMoGr2Q@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/gfs2/ops_fstype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 9b9e70f14d25..d087845a75d6 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1776,6 +1776,8 @@ static void gfs2_kill_sb(struct super_block *sb)
 		return;
 	}
 
+	gfs2_destroy_threads(sdp);
+
 	gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KILL_SB);
 	dput(sdp->sd_root_dir);
 	dput(sdp->sd_master_dir);
-- 
2.43.0

