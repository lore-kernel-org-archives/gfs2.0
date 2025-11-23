Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186B21D3F2
	for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940597; cv=none; b=SAvLFmO2a6/uKgCbSEMDWvVMjaY2v+hfSiULqhqH7xao+3G8d7jIOA7zgdrTwuR1uKAq+4iWesiq4OYMxxz6v3GQ1y7log0xM++D1j14ssakmPpNNgmSQiPiJLdE8vYz2ghAqj6tY0DKSYWjbqMs8nNX9lTAemEbpyM1WP0YHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940597; c=relaxed/simple;
	bh=onfW0KRCunkrfENCokop5oWDP52dluPbHWVAUJlTB18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpHG1CpKSmgVtCkUYoa2qLht/SZMHA+NyBV7vC4A0nSXPJtXwru8S+jNuvJQwBqojoXSpC2X1/PbA0lw1loh9kG9ql3cPUxVZCgA0giFV5ofOaxL8DQvZUGg4/N5wWEL+IzzAlqhc7H217hfB7ZW4RMx2TQsMfGashICpLB3wIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqJeD0U3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqJeD0U3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b735487129fso550587766b.0
        for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940594; x=1764545394; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QCVkHe2B5C1rJZaKqIp5MAgrunRtVbuybu3HA4F0WE=;
        b=eqJeD0U3P0+GgZGNABLdIlLRN2SwfINLsTUPtylrn+eWxPDnxlXGEICUmd3tD8GrIX
         cYnBplOMmSDeYMXJb/AWe0rhNS7NzoZWULLgS1YD4Su9m6C+9TZ5v+j2rzYjD0Lumsg2
         Nj8e4cT+zF97HtCCQwxbLG0AzBHuWLUvbOBSvTIYpYXV3xBh9NcUICen23qGcQNu0k3r
         w5dkg+XhQJtfQafMiVL+SXN6zpPDJN9vf6i19OVJ4C2Nsqaw6SXkPek+kg+uERzG00Hx
         JTdmboQKKO931AkSnu5u0fKdxJMGAI295RwrB0pYRHFjY9gHYT7+vY1oE4CxRNee2eWI
         quIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940594; x=1764545394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QCVkHe2B5C1rJZaKqIp5MAgrunRtVbuybu3HA4F0WE=;
        b=KlD5ZgFwGjl9Al108qsjY8t3ZO73orRUbjLIAB38KnpfD0OrhvpWs35bBGdGFEJV8m
         ezlGHWNrGvkw+Mj30AWGglVJdeoMJ676g/SqACs7nAgOnMTS4Bd8krvpS7Pr3tBY1s3k
         jOBdZlCBFfuVqG78uF461NHo2nN2zLU93CJR0Pg1U5dygxY6hDgOzr3iHtHS4aTZieWT
         n69UCNdfyfaLTUN/IPRJKFMR6Oqc+TVHqkqVDkgh2ftybcasWpKLQUPqX7vdRgonfedG
         1YlZECQj5lcSFs2Re/DFtlNs7m0EOC7LvLhqV8txItvnhO4BYOFExT1UEz+HmmgFue5r
         vr8g==
X-Forwarded-Encrypted: i=1; AJvYcCWeYTaaUgKfHMkUN4yi9tPz9w2sOT8rT7qEesQtzB/gOTYlMq8hsuBf3TjvigXw3tf8Tn8G@lists.linux.dev
X-Gm-Message-State: AOJu0YzBr69g3ok6Td00WsDRu3jwWqurW3Y4jvVUSRwAuSshQYonu2nZ
	Nn2HB+aouYYdUpwniO/cDVcyZp/39Cskub2h7c3k6BPTtStsFnGCPBaPHwXffj4arGrvfCVz3Ig
	MWEKf+FCgNoiQOOTKNJPgZJi5Xh/Bws4=
X-Gm-Gg: ASbGncts8NY6tZ2ymvf9z8PXvcDJzOfh4HKxd5Ev8HAaHCR038FLinT0K24TW3jRZ8w
	FLdwvG8dwSvui2cgec64LlmJW2R6w6X0UoslHGxK34l1V1c7pjY3gjemRD7xUkDgqwOt7C/G917
	QLKvscOYcf5Blhti721YC9yc85393Ne5qid2ueymRTwVQdqegJWRePaQG/9Qn5iM/QnayhzERSZ
	3q0apy5xiUnvPgHzZ+nv4ogQLk7OdL7wdJeH+C1hZN8Bx9HgM9RrePtExpLJCTwr/9Zli+cG2UY
	bSDbO8hq8eBTm1r8RSOgu1yFBKLANaP6SDTr
X-Google-Smtp-Source: AGHT+IGgKBAH4WW3s6pZ/k0Q+yZ542U3x27zfw+0RPx6LN8evSEWSmV/hGBLBffbW2tyfSHD/D4vHIELW+iB1aUHTZ0=
X-Received: by 2002:a17:907:97d6:b0:b76:2d96:6c28 with SMTP id
 a640c23a62f3a-b76715acbd4mr972617166b.24.1763940593246; Sun, 23 Nov 2025
 15:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 00:29:41 +0100
X-Gm-Features: AWmQ_blW1s24U6SJWaHPmBzqy7U6b1FmGjPf-59EW4w_5ZdHcoASFYaoUUr_f48
Message-ID: <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 11:44=E2=80=AFPM syzbot
<syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com> wrote:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
> RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
> Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01 0=
0 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 c0=
 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
> RSP: 0018:ffffc90003747518 EFLAGS: 00000007
> RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
> RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
> RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
> R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
> R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
> FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558e8c347168 CR3: 0000000077b26000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4674 [inline]
>  __lock_acquire+0x6a8/0xd20 kernel/locking/lockdep.c:5191
>  lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  insert_inode_locked+0x336/0x5d0 fs/inode.c:1837
>  ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1675
>  ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1309
>  ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
>  lookup_open fs/namei.c:4409 [inline]
>  open_last_lookups fs/namei.c:4509 [inline]
>  path_openat+0x190f/0x3d90 fs/namei.c:4753
>  do_filp_open+0x1fa/0x410 fs/namei.c:4783
>  do_sys_openat2+0x121/0x1c0 fs/open.c:1432
>  do_sys_open fs/open.c:1447 [inline]
>  __do_sys_openat fs/open.c:1463 [inline]
>  __se_sys_openat fs/open.c:1458 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1458
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc35f98f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
> RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
> RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
>  </TASK>
>

The bug is in ntfs. It calls d_instantiate instead of
d_instantiate_new and consequently there is no wakeup to begin with.

I'm going to chew on it a little bit, bare mininum d_instantiate
should warn about it and maybe some other fixups are warranted.
