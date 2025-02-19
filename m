Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD5198E9B
	for <gfs2@lists.linux.dev>; Wed, 19 Feb 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739938208; cv=none; b=TC33LSKEVj9qUUYc4Fwz/ylR7qdNbBdmpc8F0qDA2vT93DpAbD5RcRL3QZlhQof/Vyvcy8OpJDG194YATYviGuq3MfaAqoPDtnA8nWOs9+B7vmdANsbULduCeiTFLxl7SUxW/0rjVbjHZwqCPyJCLVhkZcewFFdXKAofCyTZEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739938208; c=relaxed/simple;
	bh=ZOirXPpBpdNGB7ZgyOBcoKSNUIN5EKFgmGrgDMY+S7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQINm2819fNQt2W0NjWQKtlSCcVlxEbfz8pxIPj8zLt2QRsiADal0lS4G8YK63VZoBjPCTWCDcSg6NbRA8Bmmh2GClgHqeJ8yxCS4rc2sZToToGHta6kWpcsaM8nhDbQ+LEKkYCdBPmBV250i++5bjf5xhn56bo4mw6Tknz4gXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=hVjUfyHh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="hVjUfyHh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c665ef4cso93133635ad.3
        for <gfs2@lists.linux.dev>; Tue, 18 Feb 2025 20:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739938205; x=1740543005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTKcTvnZS+L4I/Okb1EcSfxpGxRo5kjtPkphxD7WsUg=;
        b=hVjUfyHhKPaCYG2n+5T1nGaxlemLjYor5vJLl8HmlTgK1Xvtweyb8W51KdWi2z6W7x
         vpNfKYH0u45q2lUmHfWvG60c+WUpbagnhO+lyAwV2eI/6WhJkcLwjIi67iW86rQOpm1J
         UHwPVstWpKsPQ2OHJpPoHcG6FHCBJs0dur5Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739938205; x=1740543005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTKcTvnZS+L4I/Okb1EcSfxpGxRo5kjtPkphxD7WsUg=;
        b=UYczZrFol0VpnGXiP7pvB+z0tff8qwBLC/dB7XNiZtJbD7N7GfVH/v1V1xdRoZhW2f
         D/rlcNBBihPN0YuwrLx6wiSBgQX018fGyA/Tj2v3VotqMx3BG5nme37c70Ocrj7m6dyq
         JlX2lKqz4rpdeoILNDqkU1iK7KEE+IZDXowPaD4MeR3rZf+aIYVLKZWOq7/DAJzLz/xd
         VXaAw1JzvyaXZMxa2u7HyzIG4ToPZxG67//L458KdN58DMFhvE/9YBQ5NfQpSl8aXsJ+
         v5MSxK3tgrWFAd4/u6BNNxNvMmA/RX7frPgyCfe5VbMo0ak9cpT6v1e8stn5e2s9sifX
         ipuw==
X-Forwarded-Encrypted: i=1; AJvYcCVwj2XOExXhm03ViwpkGTqsBs6PHE1KdD/JQZrst4RNp95kWVvLozXAFAVsLNl+cSBGGmEB@lists.linux.dev
X-Gm-Message-State: AOJu0YyIBiAkDDGA4Slvt0C1KpI7q0X0MIIa9Ww8qMxoj9ihs/7W0pFS
	/e/MzogpkrVF8shv5wXK8WCTaBS/Lu458eqkgObFx8WyIi8U+QCzdPXe2iwXgNE=
X-Gm-Gg: ASbGncsJxqGpyIygn+vJvuATLJedj7WOwnE3nZcwn9RbN36GuJki8KMJMLeGRMnBZmt
	Jms4piibUlh334TzROWqwNnwq8AiA9lighnJP6UyClsFYSv6X/eBOc99wRhSLgLKAd66qIjrxRp
	hWkJfo1DkCCex1qEG4S0ivETVP11rlYy+7R09VrBMCaLN9mmSmpdDsFbjKodT2tie+xo4PtawxS
	pXPoM/TB2jvRtOz9GowOHllJKjVw3l1GwLNGc/+CR2NzV6WYU2ql5dj290GGumuQC3nOPxZQcAn
	UpjRQZwrPFDGL4E7DN7v4VPdHh2sqhbLNJ4+lQ==
X-Google-Smtp-Source: AGHT+IE95oE8H0jpyiD4lMrH6AwDHLPJK4zW/l3ZyQjtTXz+PaOQkTdIX/VbUgxNkRLRLE6AUmBcOA==
X-Received: by 2002:a05:6a00:18a4:b0:730:9446:4d75 with SMTP id d2e1a72fcca58-732618e4f34mr23223656b3a.17.1739938205439;
        Tue, 18 Feb 2025 20:10:05 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546149sm10825772b3a.36.2025.02.18.20.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 20:10:04 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: andreas.gruenbacher@gmail.com
Cc: agruenba@redhat.com,
	chunjie.zhu@cloud.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] fix gfs2 umount timeout bug
Date: Wed, 19 Feb 2025 04:08:54 +0000
Message-Id: <20250219040854.46062-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHpGcMK0vez+c0NT-U40=JYy+_X-rtfR50KEZXiFXuA6E-tUmQ@mail.gmail.com>
References: <CAHpGcMK0vez+c0NT-U40=JYy+_X-rtfR50KEZXiFXuA6E-tUmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rapid response is much appreciated. Our kernel version is 6.6.22.

Our IO tests run on a 2-nodes GFS2 cluster. In our tests, there are lots of
file deletion operations, this causes heavy exclusive lock contention inside
the GFS2 cluster. At the umount time, we often see the following message
reported by kernel hung task detector.

After investigatin, I find that one or two iopen type glock instances are left
behind at umount time.

See the time sequence graph in my commit message, due to heavy lock
contention, node 1 DLM returns EAGAIN and then ECANCEL to GFS2 glock A lock
request, then, node 1 instructs all GFS2 IO applications to exit, and umount
follows up on node 1. During umount process, glock A is always in memory, we
can see gfs2_glock_dq cannot free glock A because glock state machine cannot
decrease the glock A refcount to be 0.

INFO: task umount:75342 blocked for more than 483 seconds.
      Not tainted 6.6.22+0 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:umount          state:D stack:0     pid:75342 ppid:75335  flags:0x00004002
Call Trace:
 <TASK>
 __schedule+0x3a0/0x1330
 ? srso_alias_return_thunk+0x5/0x7f
 ? srso_alias_return_thunk+0x5/0x7f
 schedule+0x53/0xc0
 schedule_timeout+0x76/0xf0
 ? __pfx_process_timeout+0x10/0x10
 gfs2_gl_hash_clear+0x135/0x140 [gfs2]
 ? __pfx_autoremove_wake_function+0x10/0x10
 gfs2_put_super+0x175/0x220 [gfs2]
 generic_shutdown_super+0x7e/0x170
 kill_block_super+0x16/0x40
 deactivate_locked_super+0x2f/0xa0
 cleanup_mnt+0xbd/0x150
 task_work_run+0x60/0xa0
 exit_to_user_mode_prepare+0x117/0x120
 syscall_exit_to_user_mode+0x22/0x40
 ? srso_alias_return_thunk+0x5/0x7f
 do_syscall_64+0x67/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? syscall_exit_to_user_mode+0x27/0x40
 ? srso_alias_return_thunk+0x5/0x7f
 ? do_syscall_64+0x67/0x80
 ? srso_alias_return_thunk+0x5/0x7f
 ? syscall_exit_to_user_mode+0x27/0x40
 ? srso_alias_return_thunk+0x5/0x7f
 ? do_syscall_64+0x67/0x80
 ? syscall_exit_to_user_mode+0x27/0x40
 ? srso_alias_return_thunk+0x5/0x7f
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? exc_page_fault+0x72/0x130
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7fb0823ebeab
RSP: 002b:00007ffcd0d45b68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fb081257000 RCX: 00007fb0823ebeab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fb081219980
RBP: 00007fb081257118 R08: 0000000000000073 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb081219980 R14: 0000000000000000 R15: 00007fb081257000
 </TASK>

> 
> > Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> > ---
> >  fs/gfs2/glock.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index 4a280be229a6..bf2445f0afa9 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
> >         gfs2_glock_queue_work(gl, 0);
> >  }
> >
> > +/**
> > + * IOPEN glock might be a zombie glock instance due to lock contention
> > + * between nodes in the cluster during fs umount, then it causes umount
> > + * timeout
> > + */
> > +
> > +static int is_zombie_glock(struct gfs2_glock *gl)
> > +{
> > +       if (test_bit(GLF_LOCK, &gl->gl_flags) &&
> > +               test_bit(GLF_DEMOTE, &gl->gl_flags) &&
> > +               test_bit(GLF_BLOCKING, &gl->gl_flags) &&
> > +               (gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
> > +               list_empty(&gl->gl_holders))
> > +               return 1;
> > +       return 0;
> > +}
> > +
> >  /**
> >   * clear_glock - look at a glock and see if we can free it from glock cache
> >   * @gl: the glock to look at
> > @@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
> >
> >         spin_lock(&gl->gl_lockref.lock);
> >         if (!__lockref_is_dead(&gl->gl_lockref)) {
> > -               gl->gl_lockref.count++;
> > +               if (!is_zombie_glock(gl))
> > +                       gl->gl_lockref.count++;
> >                 if (gl->gl_state != LM_ST_UNLOCKED)
> >                         handle_callback(gl, LM_ST_UNLOCKED, 0, false);
> >                 __gfs2_glock_queue_work(gl, 0);
> > --
> > 2.34.1
> >
> >
> 
