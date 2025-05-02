Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD221D554
	for <gfs2@lists.linux.dev>; Fri,  2 May 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179551; cv=none; b=qaJo6yKDKvS6h0bNEREzuFxPi5IYa0wZGgxz/XZlEWGHjxaf9ZruSn2FHMG0kxM6mJ5I4xOyUbolxXamqwHda+0dZgYzH9LNUcVpKxVcHeaQy6+sWxG38rzNvr1K6c3A/kdkz25cae3iRZY4OT1XvvICcv+TvHO0p2vYzmLhVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179551; c=relaxed/simple;
	bh=ZS+f+Pfa5TGtF2r8wVszZHda4cYa5Eb0bHdA6ZwVU+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBtELmR+ajAadf4FPy0bgMq0CuMcQhDP95A2Tn5Ik2KbBZS+YCf6fhs7/XWD2kjBoVnm5/VscMhNhyoiP8DYS6L8kLu3gUDwrKw/VjeZ1en68b2gUlgQIX7RRUzHphXhyHw1Ld27rKlvTg8m9Kse5jfTvZODuoY6fDib9O9a1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhM2jYT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhM2jYT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746179547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXGsWu/sVUjfIQjTnfB+mQNrmVQD1XLyhhrYW1W2edU=;
	b=fhM2jYT31AO64MCUc2vunTVCKsZ9eDd4oEl4l+BTmqOj4cKaxcLSzSRAGkiCjE1T1GcMQ6
	2lGtXkMVPK+5P14ry7dj7iE1wyvkOFydaUYLzDDIuDTnKoQcnF+2VCpzoNIfW7LscCEQ0/
	fqjSKEUhu3S1xq6wKZoUtxrhAqOqPkc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-NeqssC7QPMqm4-arti9e_A-1; Fri, 02 May 2025 05:52:26 -0400
X-MC-Unique: NeqssC7QPMqm4-arti9e_A-1
X-Mimecast-MFC-AGG-ID: NeqssC7QPMqm4-arti9e_A_1746179545
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241ae15dcbso21373795ad.0
        for <gfs2@lists.linux.dev>; Fri, 02 May 2025 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746179545; x=1746784345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXGsWu/sVUjfIQjTnfB+mQNrmVQD1XLyhhrYW1W2edU=;
        b=nkIdd4EGzt8jsr7KOx025iU3TsjmgV4MfKC432IW9Lv8+xPk6UkBOVnLqcQTEOyGmr
         HClUZizC273pz9H4dZ4xw+9JIdsXI+mkSmibde0WyY3zXnmpkUOG9YU4q8l/A6AlRDSR
         USkHrZsJ/3/CVQ2bdmvsHcITgP2fz4bRDmfZ9XmB4j2J7Q1n8SoKdq6PYS4S2BtoQSvv
         gmNzvkHRerMp47vNwLlFikUjSBgZpTNj9X/QZevnHbqZROuE0E8KFvUzZQtQCGMSvIOo
         v/YRAtDJMpmhVnZ36hGPZoT8VNncpzR1OQ1u087KuEEo7GGkX7Wiv0279s92xRwCpfJk
         5n9w==
X-Forwarded-Encrypted: i=1; AJvYcCXR8UwTDq4+tV1xGtVpzgDSAdjYu0LU8dsY8c5mQNQtyK7hwcZc07X6IDj6eOTMcYk2TVjb@lists.linux.dev
X-Gm-Message-State: AOJu0YxwDG53D6tdjcM1coFtI/8zv3QR7Dp4IMleULvREEgtCflJrQtp
	lGiT0M9n5V1tk3Cd73EU+byHKd8x6Egkv9EVAAVJ9e3NKhWqZCNn0j4k6XM5DloubuzXiYweLKa
	NUJeFTaNxLFMKHgV8ALMEbng2bShCtYz4EimbpxQDxSpIflQQ2UqEBfiZAGGl2iI7Pq/4fIqQPs
	GieMxbIP+TjuFKQEXsBNZueBu38w==
X-Gm-Gg: ASbGncuVICZtrOQ4o259TdNpL0EAuMxSnenEBwd9BuLHrPKzNhmnc6VlFFNIKOsxlSl
	b2lnA3maZ2A74mfkhLrLCXzZHdzC3vOdrWr+fQYEIxcVK+gA2CcDGKreEuMv1CNyIvUc=
X-Received: by 2002:a17:903:2352:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22e1032ebc5mr35111515ad.36.1746179545274;
        Fri, 02 May 2025 02:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPi23jEaWUfx5+/hAlXlXqhO6rvOVoF1TJPb1nn7S1D1B2KjpWylLrHJ8i6Jmbfs80U/fXdvtp29JFcP9CCWA=
X-Received: by 2002:a17:903:2352:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22e1032ebc5mr35111125ad.36.1746179544756; Fri, 02 May 2025
 02:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <TYSPR06MB7158B63753ECD29758D09D49F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
 <20250501202943.e72b7bae3d1957efa60db553@linux-foundation.org>
In-Reply-To: <20250501202943.e72b7bae3d1957efa60db553@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 2 May 2025 11:52:13 +0200
X-Gm-Features: ATxdqUEmdWvqbf7pU_cAzCFcFc3sFR361fdkrY_4pFwKDQj8PiTwFoGn-3DHIGc
Message-ID: <CAHc6FU6O9ys6cbwOBmgz9e3EZgNDSRnnm6c=056VdJKF490ixQ@mail.gmail.com>
Subject: Re: WARNING in __folio_mark_dirty
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>, "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, 
	=?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yb0TlEq9PKWKLGEEKjdD5Y7N-hZOMghPkHYunQteXiY_1746179545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:36=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
> On Fri, 2 May 2025 03:26:20 +0000 "huk23@m.fudan.edu.cn" <huk23@m.fudan.e=
du.cn> wrote:
> > Dear Maintainers=EF=BC=8C
>
> Let's Cc the gfs2 developers.

On gfs2, these warnings should be fixed by the following two commits:

9e888998ea4d ("writeback: fix false warning in inode_to_wb()")
ae9f3bd8259a ("gfs2: replace sd_aspace with sd_inode")

The first one is in v6.15-rc3 thanks to Andrew; the second one is on
gfs2's for-next branch right now:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/=
?h=3Dfor-next&id=3Dae9f3bd8259a

> Do you know if this is reproducible on any other filesystem?
>
> >
> > When using our customized Syzkaller to fuzz the latest Linux kernel, th=
e following crash (37th and 76th)was triggered.
> >
> >
> > 37th=EF=BC=9A
> > HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> > git tree: upstream
> > Output:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN=
/2.%E5%9B%9E%E5%BD%92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20hfspl=
us_bnode_read/14call_trace.txt
> > Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15r=
c1/config.txt
> > C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc=
7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined=
/37repro.c
> > Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219=
_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_o=
utlined/37repro.txt
> >
> > 76th=EF=BC=9A
> > HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> > git tree: upstream
> > Output:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc7_todo=
/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined/76cal=
l_trace.txt
> > Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0305_6.15r=
c1/config.txt
> > C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0219_6.13rc=
7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_outlined=
/76repro.c
> > Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0219=
_6.13rc7_todo/76-UBSAN_%20shift-out-of-bounds%20in%20bch2_trans_iter_init_o=
utlined/76repro.txt
> >
> >
> >
> > The two errors seem to have the same error points, but there are a few =
differences in the process. They all trigger warnings in the __folio_mark_d=
irty+0xb50/0xf10 function of backing-dev.h:251. In __folio_mark_dirty funct=
ion, a warning is triggered when the code tries to access or modify the bac=
king-dev information. The 76th call stack has longer call chains from file =
writebacks: writeback work queues =E2=86=92 writeback inodes =E2=86=92 GFS2=
 write inodes =E2=86=92 log refreshes.
> > We have reproduced this issue several times on 6.15-rc1 again.
> >
> >
> >
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.=
edu.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
> >
> >
> >
> > 37th=EF=BC=9A
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: CPU: 2 PID: 9494 at ./include/linux/backing-dev.h:251 __folio_=
mark_dirty+0xb50/0xf10
> > Modules linked in:
> > CPU: 2 UID: 0 PID: 9494 Comm: gfs2_logd/syz:s Not tainted 6.15.0-rc1 #1=
 PREEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubu=
ntu1.1 04/01/2014
> > RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> > Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3=
 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 =
a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> > RSP: 0018:ffffc90014bb7b18 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff88804298cb58 RCX: ffffffff81f5408e
> > RDX: 0000000000000000 RSI: ffff888023edc900 RDI: 0000000000000002
> > RBP: ffffea00015c9d80 R08: 0000000000000000 R09: ffffed10085319a0
> > R10: ffffed100853199f R11: ffff88804298ccff R12: 0000000000000246
> > R13: ffff888049bd8bc8 R14: 0000000000000001 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff888097c6b000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ff2c7be9028 CR3: 000000000e180000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  mark_buffer_dirty+0x358/0x410
> >  gfs2_unpin+0x106/0xef0
> >  buf_lo_after_commit+0x155/0x230
> >  gfs2_log_flush+0xd95/0x2cb0
> >  gfs2_logd+0x29b/0x12c0
> >  kthread+0x447/0x8a0
> >  ret_from_fork+0x48/0x80
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > extracting prog: 1h56m11.644263162s
> > minimizing prog: 14m12.695891417s
> > simplifying prog options: 0s
> > extracting C: 32.234365976s
> > simplifying C: 9m50.565845853s
> >
> >
> >
> >
> >
> > 76th=EF=BC=9A
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: CPU: 3 PID: 3051 at ./include/linux/backing-dev.h:251 __folio_=
mark_dirty+0xb50/0xf10
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 3051 Comm: kworker/u18:5 Not tainted 6.15.0-rc1 #1 P=
REEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubu=
ntu1.1 04/01/2014
> > Workqueue: writeback wb_workfn (flush-7:0)
> > RIP: 0010:__folio_mark_dirty+0xb50/0xf10
> > Code: ff ff 48 8d 78 70 e8 af e3 76 09 31 ff 89 c6 89 44 24 08 e8 72 d3=
 c5 ff 8b 44 24 08 85 c0 0f 85 af f9 ff ff e8 51 d1 c5 ff 90 <0f> 0b 90 e9 =
a1 f9 ff ff e8 43 d1 c5 ff 90 0f 0b 90 e9 59 f5 ff ff
> > RSP: 0018:ffffc90011e2f410 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff88804266bfd8 RCX: ffffffff81f5408e
> > RDX: 0000000000000000 RSI: ffff888043e48000 RDI: 0000000000000002
> > RBP: ffffea000086e9c0 R08: 0000000000000000 R09: ffffed10084cd830
> > R10: ffffed10084cd82f R11: ffff88804266c17f R12: 0000000000000246
> > R13: ffff888012bf87f0 R14: 0000000000000001 R15: 0000000000000001
> > FS: 0000000000000000(0000) GS:ffff8880eb46b000(0000) knlGS:000000000000=
0000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6410e8e140 CR3: 0000000023648000 CR4: 0000000000750ef0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> > mark_buffer_dirty+0x358/0x410
> > gfs2_unpin+0x106/0xef0
> > buf_lo_after_commit+0x155/0x230
> > gfs2_log_flush+0xd95/0x2cb0
> > gfs2_write_inode+0x371/0x450
> > __writeback_single_inode+0xad7/0xf50
> > writeback_sb_inodes+0x5f5/0xee0
> > __writeback_inodes_wb+0xbe/0x270
> > wb_writeback+0x728/0xb50
> > wb_workfn+0x96e/0xe90
> > process_scheduled_works+0x5de/0x1bd0
> > worker_thread+0x5a9/0xd10
> > kthread+0x447/0x8a0
> > ret_from_fork+0x48/0x80
> > ret_from_fork_asm+0x1a/0x30
> > </TASK>
> >
> >
> >
> > thanks,
> > Kun Hu
> >
>

Thanks,
Andreas

