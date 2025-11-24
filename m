Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B22E6CD5
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970875; cv=none; b=cHgEw8lCOTbm6IEY2HZPwrN5MQI1kJBVP9oEHXWzIpTtHG3EMQDwvJjJqnFtwipjEet5vNkG2Sh085Ub4nIlOBcW/CYThln/QmgD1vh1M3A6agO2Y4JSbdN840/xBuD8vXpSs81tCNgBwq25RRRhtBgzVnYWQK6FNuPC584vzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970875; c=relaxed/simple;
	bh=KT/F7f4tTQnA1jOwd5Ni1R6KPd8yFXBsZaKI46tuybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvOQqIVAu5p7lXQ8sFY05yx5ExSAiSYo67pTTb9GVh/DbL+jsxc1Fxzo1KKXIkRuG+1ss0NBWSoib+i98o0pnNeZ7mfBAyVLKziBC7u+VbieY/ot9PbspwTIOpAY679SAUlYFTcW1Inh+qXc+icquQuI5h/HQJtG9ebswulpjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKsxCK69; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKsxCK69"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735b89501fso442564966b.0
        for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 23:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970872; x=1764575672; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlC7yVANvKUySfKJcEi61tzYs7uhVVgRqqWDz/Q6iAM=;
        b=kKsxCK69Imu4mOpJnIll+E012+F0gpjl8CcWZZLEuwpKDfYnrjxbToAkVCErOCaug9
         i96d1Qa+APZVWuju5tE9LpZ9LjhRXMIsKCbO92HeCDeXIwvaCrkCfqzG2oZNgFBI3H0x
         V7NWqhsK3FF2v4mNH5jxCqXbkpJhsL+LJG19qpIQ6nCIm1gb0DzGm8PnY5Y37s75ml7c
         Psw0bmg5A25138GYZjWWHLxRfU615tZ5FZ6OpIR0XLeC4kNAeTlLxrwLx24cAzjsco5M
         Dw/sWvxMu8Y2nI0ESNDzb6D2IySYGL1EeV6P+l96weK0j07l/uzS4jryzyCRE5GojpEm
         sTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970872; x=1764575672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlC7yVANvKUySfKJcEi61tzYs7uhVVgRqqWDz/Q6iAM=;
        b=GgUTGsJ3lrNyS6j8vn4CAZsk/goM+NcFk5VI8aqw5WLO1OU5iT/W3Mbik93mkt+gub
         ouPn9yuzNz+g6xE0lj6GRNeKbUTjH2ZKsm6RYqTtedkHLwQg5Wxf6NN6rMc7gYuRBJKy
         Wfr7SnyOwV6k25wiscc0Gb526UECLdozn8Vw5Lx/BAz8PqEjkshXthEDqNoDeavUA13z
         JZlLQAAZgWcaA5GVDmIbguukIQsP/YmRVtHCSegaC6vJNq8GQ4p+BkEjxvYGv03tPLuN
         TDjHDXairFtNWPOXEEshO1s0akh+go+GW+yj5TQ3HyxJOt8tZnfJGeDU0btiNiQU1Jik
         CgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1EwoWvsCDyurO/HP6lMmGO5IGunlKkwUL54IEtP7dmrx6nzXwl7lEywDZQyROyCJgrYzH@lists.linux.dev
X-Gm-Message-State: AOJu0YyJTdlCBC3HtQeM58hjrh+DxPoMNUpm+ubu2tDM45wxiEGZ4hoE
	4niBOtYgdA7BUZP70KS5U6iNBThemXndb0d6VfLrcL0zq49+Tf6i9X8G
X-Gm-Gg: ASbGncu9Lmwu3Kby/m5Mqn8YgsbwvQa2gBsPwpnvZCSqtwBLPubGsvknzAvDqiG3vcE
	aKG64FLB9RPULyJdgtmZ8Nbu8Qu9o8kpVYL/urPyg0qVF7VMRkMeosWZtcH3rVqJfEkoxQ0aZFz
	eVa1USGGK6FDRIDkjsyzT5e/E2OG2gxw9h70aTb/8g+DQ5Os73FRhHGvBMMsDsPvDdD9RoktVdX
	1sO1FlCbBUKms7dzVma3md14PdAkABalVUTquyzUqg7C/sJ7yvDOcQiMd6RWLb0ersKBF2PVCSn
	WbQvQoyn+wf3VUj0UANTWSQ/z3c2V8Tsb2v5ugudE9Gmk7zk0PsZtOgmT17oqMtjCRLgl2O/mgD
	RIJbZKCS+QoYolRiQwgBhGNu1eSk9f2dyZMCD+XEXjxrd/FZuxvEW1Dz260l5vHlbLUtqAHjc9h
	osXqaXy+p+B+bSRL9LiFUzzZDRvl/Tjczo9DCkWcZyEOfZPFEmLtVPX8XH0/dk4+UPrco=
X-Google-Smtp-Source: AGHT+IGtWWuUYPLI1U4Pi4o0OYpw506S88/tH8OAcwEGuSXovPPfsg0e1IiBHAC3h7onJct5SaHDfQ==
X-Received: by 2002:a17:907:a04:b0:b6d:5363:88a9 with SMTP id a640c23a62f3a-b767154772bmr889142366b.9.1763970872065;
        Sun, 23 Nov 2025 23:54:32 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43e2sm1199292166b.39.2025.11.23.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:54:31 -0800 (PST)
Date: Mon, 24 Nov 2025 08:54:18 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org, neil@brown.name
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6924057f.a70a0220.d98e3.007b.GAE@google.com>

On Sun, Nov 23, 2025 at 11:13:03PM -0800, syzbot wrote:
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in __start_renaming
> 
> INFO: task syz.0.17:6473 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:27936 pid:6473  tgid:6471  ppid:6352   task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5257 [inline]
>  __schedule+0x14bc/0x5030 kernel/sched/core.c:6864
>  __schedule_loop kernel/sched/core.c:6946 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:6961
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7018
>  rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
>  __down_write_common kernel/locking/rwsem.c:1317 [inline]
>  __down_write kernel/locking/rwsem.c:1326 [inline]
>  down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
>  inode_lock_nested include/linux/fs.h:1072 [inline]
>  lock_rename fs/namei.c:3681 [inline]
>  __start_renaming+0x148/0x410 fs/namei.c:3777
>  do_renameat2+0x399/0x8e0 fs/namei.c:5991
>  __do_sys_rename fs/namei.c:6059 [inline]
>  __se_sys_rename fs/namei.c:6057 [inline]
>  __x64_sys_rename+0x82/0x90 fs/namei.c:6057
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2425d8f749
> RSP: 002b:00007f2426c44038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 00007f2425fe6090 RCX: 00007f2425d8f749
> RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
> RBP: 00007f2425e13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2425fe6128 R14: 00007f2425fe6090 R15: 00007ffcd5a91138
>  </TASK>
> 

So at the end of the day I think this erroneously bisected to my patch.
While it may sound like famous last words, hear me out.

The reproducer fails to trigger the problem on my test jig, thus I
resorted to asking syzbot.

First patch I sent for testing was merely a sanity check -- prior to my
patch inode_unhashed() checks were *always* executing, with my patch
they only happen if I_NEW was spotted. This patch "solved" the problem.

Second patch added some asserts on inode_unhashed() and syzbot had some
internal issues, ultimately it was not tested.

Third patch added even *more* asserts and t0his time around things
failed the previously reported way about half an hour of testing. But if
the first patch indeed solved something, the BUG_ONs would have
triggered instead.

So that's for testing.

In my first response I made a remark in my first reply that ntfs is at
fault.  After a quick skim I spotted d_instantiate() instead of
d_instantiate_new() and jumped to conclusions. It calls unlock_new_inode()
later which does the right thing, so it is fine AFAICS.

So what about correctness of my patch?

My patch lifted the go-to-sleep code from inode_wait_for_lru_isolating().
In principle that can be buggy but is just used rarely enough that it
went unnoticed. I don't see anything wrong with it though, including
after comparing it with __wait_on_freeing_inode(). Notably both
synchronize with the ->i_lock. No games played.

I figure maybe there is something fucky going on with ordering on wakeup
side:

inode_state_clear(inode, I_NEW | I_CREATING);
inode_wake_up_bit(inode, __I_NEW);

Going through __wake_up_common_lock takes a spinlock, which on amd64
would have a side effect of publishing that I_NEW store, even ignoring
therest of the ordering.

On going to sleep side to the flag is only ever tested with ->i_lock
held anyway, so it can't be an ordering issue on that front. The thread
could not have been missed from the sleepers list as going to sleep is
again ->i_lock protected, with the lock only dropped around the call to
schedule().

So I don't see how this can be buggy.

At the same time the traces report the thing off cpu is playing around
with rwsems with the __start_renaming et al patchset, while the code for
inode hash manipulation is decidedly *ON* cpu -- reported by NMIs, not
hung test detector.

In principle this still can be a thread hung waiting on I_NEW somewhere,
but syzbot did not produce a collection of backtraces for other threads.

However, given that the __start_renaming et al patchset is complicated
*and* that syzbot could mistakenly report (or not) a bug I'm led to
conclude the reproducer is highly unreliable and my commit landed as a
random victim.

All that said, I think the folk working on that patchset should take
over.

My patch is a minor optimization and can be skipped in this merge window
at no real loss,

My take is that the big patchset *should* be skipped in this merge
window given the above, unless the problem is uickly identified. 
