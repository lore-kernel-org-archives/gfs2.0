Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EDE1A238F
	for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317146; cv=none; b=LeISbPykmD7SMRGWi/5vhu1hZfk07yKNlVR6bBARk2qaq7l61Rrs80wJ2SV0vpxQ0t0aWGsu3mrJk1dAiPVAwbzFn8q05ZjAfQqfCCqTpBVj1noENE90PgyBqpjPxK+5A5fe20d9/1pb6ZV0VIRS2nePKOdx725Usx5LW73duSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317146; c=relaxed/simple;
	bh=nqG4zh+kHvMInvyQ9gQCc4CsAgJQ86U7Qt1LNvskd/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7dlY1dIgn5xlLJEDGE1rm+hHEGc6+4fNOTbUVNADc6HTn1f2WmrjEwd2dUS13jmmOg6xTQzrR9a8c9IKjPLebXV8C0ymm+sLG8lDpnOHqt10KgUm2ynZ+UXpJzx+hYSEJR2SQXAVJo6n4tzNY4/7I+9kjqfAev1ax2WuTFIevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhF0zrM2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhF0zrM2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d53f4960so2365726a91.3
        for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317145; x=1761921945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4n0UnjLUys/j015DW1wlIcevAZ741dIgKslESCiUAc=;
        b=RhF0zrM2+dFzGrtYq4x90H27l9lm2F/juVMkFepzDNoqu9Hq4XSz5Qbjt9n13lU6W3
         2fbjrCrE4IzTn0uioy6cwPN1YD8qrjUnTjhi88m3AnCQfwZjpNE76FcE2+m3exKxGR41
         X8muGOwjuEHLuT1r5CiraWsjg9JQTT0jEQ5JYUSRIHCBSUFv2sN9T72Ecp8OJ6oYEey0
         F8FnU8vsu2Q+gq+ehLKLwMq+rlNnlX6G/OJfaLiihdDLZ/JOk5TQbdiIw4t2PZ6UY5gv
         /WLOucuXaP9Bak7qi5mUAql1cfA/+meTq5aF+z8q6zGtleexnjmIHBrn/b0gQieVxNBW
         j+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317145; x=1761921945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4n0UnjLUys/j015DW1wlIcevAZ741dIgKslESCiUAc=;
        b=e0zULyb0kI43TonMs5anhsYkhrrTJh9YEIw13WYY5ZhIDtFMC2ry1UKtv73rG81NC6
         5UA65SPceOlip97JfioovfAWySK/tj1g78Xc6Hynd13q4ItVcamgsYGmrlzGFd0htDyP
         lpxTjf3eI/Rh73wvRT2IGUHNrlq8ZioqMblaE02uUlOMibuX9ry1j8qwtRDu5pHfSUS5
         KhnKoQOdPP9CRCqLjFBDJykJjXAzHi76Auq4Hi7ma2Hgss61Z/cUGjpjlxZWGBsgeBqo
         tyj8dZPlq3puFihuNnMuYwE9IpK61HDlCAmxzr3Y4lCH9ULNwZMZfKfieqZgaeWmdBPn
         T0ZQ==
X-Gm-Message-State: AOJu0YwzwCrV5tTzIfpZf1FnOCC3rVWQsDpQVSOhXyKONezzNtF4UHZ9
	AInDpcAuHkrHcMHBl+tD203bCbf/fC026kZJ1zrrnRMM219f4u0DVlKf
X-Gm-Gg: ASbGnctDO3VjckDvEdlZx7/+msABqSnzVwMcMGZFEQAILO0ggP06OcA4bxBT1c74jzn
	+Jh6yzzEoqrCWZYZUd9niRvUE+2iENreqn3NTHwmeOTrFKaPvwu2n4sORrOGAm5f6VyGmt7kaO9
	Qmv60g4VSDTimaAo7ezcs5dsSyCpzF9wHSf2T2lXZyZOsZQID9yhrLgXQgiuqmblJmSQabRf16R
	QoYhU4vlQVdtQj6Mku46amIhs8NYD9VPHr+EWCeUKZNW1uNraSC/uZOApfNPlkh9TZWOyBoi5d6
	uSGno+KrD1g6HzpNhlvkT3x73e0KDyNZC9tgFZCuKwOABVEmxIPXzf6n0X4lbznpSqna2gUNufr
	xL+EGJRI+4gDzlLLkuQjE884ZugtdM0u1mFwbw55mWzlfpJLbHu2EBwTl2Wo5mmsT+1AcDvEoKG
	Ep2wnR1hNP/NvYETJgVs32VMLxMkWzo8HmxtQxx92+l2yHfjkC4/Oi2FJ2
X-Google-Smtp-Source: AGHT+IEX5+Zc6CDsncOD1U2YKgYTgfSBUwM+Np98fLDZTHhgs+0g9k59w3ppAgkJNjKS+pbJ2TSgiw==
X-Received: by 2002:a17:90b:4f:b0:33b:a38e:d868 with SMTP id 98e67ed59e1d1-33bcf8e95f3mr35727097a91.24.1761317144424;
        Fri, 24 Oct 2025 07:45:44 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3a:1aaa::2a8:13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2f28sm9344760a91.19.2025.10.24.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:45:44 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] gfs2: flush withdraw work before freeing gfs2_sbd
Date: Fri, 24 Oct 2025 20:13:33 +0530
Message-ID: <20251024144332.33773-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
References: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an ODEBUG warning where free_sbd() was freeing memory
containing an active work_struct (sd_withdraw_work):

  ODEBUG: free active (active state 0) object: ffff888026c285a0
  object type: work_struct hint: gfs2_withdraw_func+0x0/0x430
  WARNING: CPU: 0 PID: 6010 at lib/debugobjects.c:545
  Call Trace:
   free_sbd+0x1e4/0x270 fs/gfs2/ops_fstype.c:1308

The issue occurs when gfs2_fill_super() fails after initializing
sd_withdraw_work at line 1218. Some error paths (fail_lm, fail_debug,
etc.) skip the existing flush_work() at the fail_inodes label and jump
directly to fail_free, which calls free_sbd() without flushing the
potentially pending work.

free_sbd() is also called from init_sbd()'s error path before
sd_withdraw_work is initialized. Since the structure is allocated with
kzalloc(), work.func is NULL in this case.

Fix by adding a guarded flush_work() to free_sbd(). Check work.func
before flushing to handle both cases: when called after INIT_WORK()
(work must be flushed), and when called before INIT_WORK() (work.func
is NULL, skip flushing). This avoids the WARN_ON(!work->func) in
__flush_work().

Note: gfs2_put_super() already calls flush_work() before free_sbd()
(line 606), so the flush in free_sbd() will be redundant but harmless
for the normal unmount path.

Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
Fixes: 8fdd8a28fe5c ("gfs2: Asynchronous withdraw")
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
Testing performed:
- Reproduced original bug with syzbot C reproducer
- Verified fix prevents ODEBUG warnings in all error paths
- Tested early mount failures (unformatted devices)
- Tested all gfs2_fill_super error paths (4 scenarios)
- Parallel mount stress test (3 concurrent operations)
- Memory leak test (50 mount/unmount cycles, <4MB variance)
- Race condition testing passed
- Validated with syzbot on linux-next (Oct 22)
- All tests completed with zero ODEBUG warnings

 fs/gfs2/ops_fstype.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 08502d967e71..6cea03410e57 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -67,6 +67,14 @@ void free_sbd(struct gfs2_sbd *sdp)
 {
 	struct super_block *sb = sdp->sd_vfs;
 
+	/*
+	 * Only flush withdraw work if initialized. Work is initialized in
+	 * gfs2_fill_super() at line 1218, after init_sbd() succeeds.
+	 * Checking func avoids WARN_ON in __flush_work() for early failures.
+	 */
+	if (sdp->sd_withdraw_work.func)
+		flush_work(&sdp->sd_withdraw_work);
+
 	free_percpu(sdp->sd_lkstats);
 	sb->s_fs_info = NULL;
 	kfree(sdp);
-- 
2.48.1

