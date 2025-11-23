Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41031AA1D2
	for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940639; cv=none; b=LC54DXGpqleTs8RPtvRQnUs6wu9VWM3vMbcOoTTmx7HbAE97OClCviU0nDO98HPvga/YVCh7jX+lPvewWV4CHKznlQcFlDioz3gd5XYBWVaLVK0jifObl85A9t0Yh/PG70ttjC/jjcRkUMvhbPQdhWI+pB5y3id/pEpdBNWuhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940639; c=relaxed/simple;
	bh=Pvy+F/m1v4duxz98B8A4THddFFHNKkG0VyGvrA1/Ghc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij6hgc4r/idyEPoG1SnwrerIr6dZih2F/DBMxbsotqYUIiGqc9Ug+7N4mC7nvubPxWPWjojvGYpvRHiNL9v+OOlrEjf5bRdF+xVEkyRDkQbQeHb13e/G9Gd57wU1ZtdnRbfHc4es9TtIdvHgisiUaxUgAr8DAronVM7x4emUmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGRz6qfG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGRz6qfG"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so6256885a12.3
        for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940636; x=1764545436; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv1JE5X/TS2XRlCcr9C03MtYzcReh6WHKJs1xEyd0dc=;
        b=kGRz6qfGI2L6wX8W98KgRsQl7f2XHjt9B5fcI1TNQk+5jem+tz4k1RzU4kD5RZwq+5
         1AbeSEFYABYuF6pAQ2uP5C16cOX6WbxKRpzJGgKYb6DjvsV2WZDkawmXwVBSytqAajvI
         PlJ3YV9RHEmKglwUdYX2YWPHL6L9j9P162MG6YB5O3DYV6Ri7+yF3R/msomr0nn3QPqI
         FBdCZ2D0yZb8TmC77DC5XhuhF62yZplWJBGkrqfdl0CBbjGtEAQzEw9sr9L5piQ2U4fO
         zAXhB/bwsck1zxQwhzQMOU1QWhXs5Qs0Xhv+9LVtRxTF6dLOQWRhfBCrF6pnKxbasexo
         MXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940636; x=1764545436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tv1JE5X/TS2XRlCcr9C03MtYzcReh6WHKJs1xEyd0dc=;
        b=GwqDrlDiGkFKVchEHLrER4rGxIYTNMRyVr60mgAsK5AHUak1Xd4KX5y5EtD436RAdJ
         2EHNCuTe/mBTMlHYyBNJC3224w25e+Q0Kl47w6ZzLEY+xShS2h/MbbUZbtkxIlYykbHm
         o86u9SozeEqNILGwHa5/10tFw9HP1CLxuYdZREfxoPQmeFCK45wA5qHa2xYFkeb+05iZ
         Ch7noMAFEE0wXZ1uGWIFxfgKDGND+zAkrwXvyNkpaabThuvaolRTaPB9faykWr4IhOn9
         QuOitBrFeqswD68aMQ4f/qnvEBSZGO2pSJ6kKI7q9iI7nFT7lUo1P4V4ELBWZF5wx+xn
         W4mA==
X-Forwarded-Encrypted: i=1; AJvYcCW0bxdbyZ9zo6V4c4eO+N2yilXcKyp6nEN1gFG8sajvmmakuHr3Pi9hI/GHz9dT8N6wfdAM@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjd8rpj1qkMp1abJguoCw4TTeTWaoCgCErJnBXXa+Y8KsvbUPE
	m5KE8leqjZdilCFnQZzMWPUd7BfF7FvHsnO4+hpdEwxZ+VLoLwRb96r0z1/vmeUTOOyMpcULpvE
	MIS7wFugKZx+Z/+iZSAJOm1XWKPq3HTU=
X-Gm-Gg: ASbGncv6TQtuf8biFp3JPcC9bxNOVjU9Qnvk5qlh606Rt3ZeoVKOXwmmjjGo4NG/RuI
	k9cxGME8yHOLgWZbwPeHIZYrqPsaULl6hE0pqGtEbExA55xnl/6H6ZWaCE/pIeHggKUuVvm4Lug
	S4AKFKYF5/MNocWX4ac0zJIsGqbmF+AJtzXaC42CQd/y+VLRPNRJgTHRxnCSyg9TF9XdIgAOUMi
	29z1qBGkcDDmJFwZAnUXHJgrHvejIB4FEaOc7Lh9Fys473cZUVIiJeuBC/xJbLaZipUyrPQwuxz
	h7SrJn87Ee+13quYawtXF/RXfg==
X-Google-Smtp-Source: AGHT+IFACleFPfRJHavpCopq/JWN/8si0EbIS//Ul6+WVCK4Crm5e9hbCoTl2sh8Dc+b09tn/XsfFa3aiDUK7P/EwP0=
X-Received: by 2002:a17:907:3f0a:b0:b76:3478:7d52 with SMTP id
 a640c23a62f3a-b76716953d5mr1131277866b.38.1763940635991; Sun, 23 Nov 2025
 15:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com> <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
In-Reply-To: <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 00:30:24 +0100
X-Gm-Features: AWmQ_bnRjWi2l5zhUCy1mj4g00Fx_wZn7EMrRH3tB0z1DC07GbSG7TAii6GFwyg
Message-ID: <CAGudoHHmOhtKYTEbqf4MA+1gxOPBwA0akba+sFadNdAC1uA3-Q@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:29=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Sun, Nov 23, 2025 at 11:44=E2=80=AFPM syzbot
> <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com> wrote:
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
> > RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
> > Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01=
 00 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 =
c0 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
> > RSP: 0018:ffffc90003747518 EFLAGS: 00000007
> > RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
> > RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
> > RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
> > R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
> > R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
> > FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000558e8c347168 CR3: 0000000077b26000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  mark_usage kernel/locking/lockdep.c:4674 [inline]
> >  __lock_acquire+0x6a8/0xd20 kernel/locking/lockdep.c:5191
> >  lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:351 [inline]
> >  insert_inode_locked+0x336/0x5d0 fs/inode.c:1837
> >  ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1675
> >  ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1309
> >  ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
> >  lookup_open fs/namei.c:4409 [inline]
> >  open_last_lookups fs/namei.c:4509 [inline]
> >  path_openat+0x190f/0x3d90 fs/namei.c:4753
> >  do_filp_open+0x1fa/0x410 fs/namei.c:4783
> >  do_sys_openat2+0x121/0x1c0 fs/open.c:1432
> >  do_sys_open fs/open.c:1447 [inline]
> >  __do_sys_openat fs/open.c:1463 [inline]
> >  __se_sys_openat fs/open.c:1458 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1458
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fc35f98f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
> > RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
> > RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
> >  </TASK>
> >
>
> The bug is in ntfs. It calls d_instantiate instead of
> d_instantiate_new and consequently there is no wakeup to begin with.
>
> I'm going to chew on it a little bit, bare mininum d_instantiate
> should warn about it and maybe some other fixups are warranted.

As in I'm about to turn in, will post patches on Monday.
