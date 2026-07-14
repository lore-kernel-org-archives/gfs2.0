Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68851386579
	for <gfs2@lists.linux.dev>; Tue, 14 Jul 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031009; cv=none; b=N1mpD4hFm4vFLXRrPC14DQBwFWfUTo3FHJbTFO1Yg79AHRvgFPF7ENRG4GMl8DkxVhcp7MKV0NUAQ1pVWLEaMZ45iE2fl2O0UITrR40jDYO7VagUG/L/zv8XJ06KyscBvCM9qdK+Hz5RueYlQ2B6RgauhyIcyPOJ66OW5Z2LOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031009; c=relaxed/simple;
	bh=upwvEKsksYLs0Q6nc0qSMMCM5EFGtLUv5dIZP5FlF8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q5wROf1+L40O3XT4s9lkMs8GzCpH/+2i6lOgngIXWX4bWfflZ0eP9FieUKgAJk0J7fciqaHPWfj1y1MX7oTZfvQgYijRUFi30+Zd5GBXYUgjFWwfuLFFIrIC2CYlzFqCb7iR1cyxGiSdd4fHzmTfZ7WIoKEML5ZNH0gJKSdNYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtEV4B2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtEV4B2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784031005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVZ9jl+jAJ2eyy0/GUcM+33ePOhEYWYX7xnrqg0O8XY=;
	b=WtEV4B2hGJycVIpfPNicP4Uoh/AuUw/1vCNoieGyt9rAEWrWA+hKjnQknL5ntFEIPLBdFf
	S6KFhSyq0ECLEslzppBGOKFW4dUpR8Xp5nXKHYlx2lGXt2sGeMYl0yLORZcznixMkjFWLh
	tdy/HOGhRGg8mlhRZqK8EMnBNFWfKMc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-eopGXMb2N925UKwhUoIgPA-1; Tue, 14 Jul 2026 08:10:03 -0400
X-MC-Unique: eopGXMb2N925UKwhUoIgPA-1
X-Mimecast-MFC-AGG-ID: eopGXMb2N925UKwhUoIgPA_1784031002
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47345535410so4619797f8f.1
        for <gfs2@lists.linux.dev>; Tue, 14 Jul 2026 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031002; x=1784635802;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVZ9jl+jAJ2eyy0/GUcM+33ePOhEYWYX7xnrqg0O8XY=;
        b=NBJ7ZX/D0B9VtkTHua27gkbMzrxivNCpp3+VmNi8Dfrk8I+Rf6SvFwOIlH70dLhCvz
         VK0YPKKq8swKLABU3gENtyI58fb1hNcGYaBRGgLK3IzYzgvQMp9O+bPWh1gc1ECE7V8v
         X1e8uEMigMUjB6vkPfkbbPLSjIhIDHOKOT8Y/SbV90QCZ4mhCgmTjBFaUTkkm0+77mx0
         4BZqEEMUEpEYX1XFy87RejIHCK9rnEQHYoXLHs8i40XhxiktRyJ3bpjFARSFKW5/Gvfh
         bYqNlXAIeUcDxtbGM1R3x91izQ8o6cGSQc2A16EaV7WTQ6RYzzso8YftfF2XurO74AHN
         XBiw==
X-Gm-Message-State: AOJu0YzNFFx91N9x2eTKXkefcMRy9sI0XvjCA+llK9Cdsyj7Hpzfd59Q
	fU5LQ4R/dNfV6SVHVZloWLHmOVJ++EXFLFdkIMBVCBMq+aLrX/cY/WPNP2O5UWA217hWU6a5prc
	xA6OU6OMqsRoH0gPeRoMV6aXsO9KuUEGQLF7Hct6GeGQ/RgruMqvuxQ5MfeclpOU1hVvTv5pZyn
	YuXYkMSJzlwEfDQfbBTq6Er/+/PUsZMRHrUiaJWvMB
X-Gm-Gg: AfdE7cl1zkT5LTIRSL9DFZills3PQAOG7vrNsP68JjyKHokjIFsfl//Cf5XNcJLQj11
	L3sa4768t1kTAkhk7UaTq9+BgSrC5m3dCCxyjxScp3QqFQ6K5OULY0xhcWhtiIErJTgHfj2lTMh
	HtQjkWSGsiRTVEmUwzpgGQcO3v0FjSDOlG3SDQOvtK+a2OOlNv90fBAKfJnpE+JNizHrCREZL0B
	Tl9dMH7vmgrhHwiIpSMa/J0zD1JhjS8i7YJfECuRcUezrELvRuEZVTiZ8snJGYTQGyWPURxzAwf
	l+R4z+eDuNDXoX/yIxgea8EkyVEng0yS76EIkSdqiBM21lE0/g2AGDzQYQSYf/XT7XhzX8yShP0
	qXarO4CTaTE5NjKABx5j+U3OHyn3O47WXI9icd5cbqwhxL2i4rcivAKJFStMnJeQIDq0DAQc=
X-Received: by 2002:a05:600c:3488:b0:493:d216:ed8a with SMTP id 5b1f17b1804b1-49539651463mr16646355e9.16.1784031001842;
        Tue, 14 Jul 2026 05:10:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3488:b0:493:d216:ed8a with SMTP id 5b1f17b1804b1-49539651463mr16645895e9.16.1784031001226;
        Tue, 14 Jul 2026 05:10:01 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm136502775e9.7.2026.07.14.05.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 05:10:00 -0700 (PDT)
Message-ID: <d3f4025b-53a1-4a6b-ae66-31a8e005216e@redhat.com>
Date: Tue, 14 Jul 2026 13:09:59 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] INFO: task hung in __gfs2_lookup
To: gfs2@lists.linux.dev
References: <000000000000063e340615e2811c@google.com>
Cc: agruenba@redhat.com,
 syzbot <syzbot+8a86bdd8c524e46ff97a@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <000000000000063e340615e2811c@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: guLAxBAkdIx-M-NH8CWk-SEt67cwMwVV6YzOY85X2_E_1784031002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 10:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4118d9533ff3 Add linux-next specific files for 20240411
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=101fa5cb180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a

I took a peek at this one because it's the most regularly reproduced syzkaller issue for gfs2.

It's essentially just doing a `mount -o meta ...` and then trying to access the contents of the per_node directory, which waits for a glock that is permanently held by the plain gfs2 fs (if I understand correctly). That has always been the case as far as I can remember and the position has been that `-o meta` should only ever be used by tools (gfs2-utils).

There might be value in fuzzing the gfs2 'metafs' so I'm not sure if we want to ask the syzkaller devs to disallow the meta mount option for gfs2. For now I'll leave it with

#syz set prio: low

Andy
 > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509eb25180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbeaa3180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1eb8b3998228/disk-4118d953.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c17244f68cad/vmlinux-4118d953.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/df207f8c8f2a/bzImage-4118d953.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2b56e1dd3dfb/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8a86bdd8c524e46ff97a@syzkaller.appspotmail.com
> 
> INFO: task syz-executor359:5091 blocked for more than 143 seconds.
>       Not tainted 6.9.0-rc3-next-20240411-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor359 state:D stack:24984 pid:5091  tgid:5091  ppid:5088   flags:0x00004002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5409 [inline]
>  __schedule+0x17e8/0x4a50 kernel/sched/core.c:6746
>  __schedule_loop kernel/sched/core.c:6823 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6838
>  bit_wait+0x12/0xd0 kernel/sched/wait_bit.c:199
>  __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
>  out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
>  wait_on_bit include/linux/wait_bit.h:76 [inline]
>  gfs2_glock_wait+0xc7/0x2b0 fs/gfs2/glock.c:1344
>  gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
>  __gfs2_lookup+0x11b/0x280 fs/gfs2/inode.c:905
>  __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
>  lookup_slow+0x53/0x70 fs/namei.c:1709
>  walk_component+0x2e1/0x410 fs/namei.c:2004
>  lookup_last fs/namei.c:2461 [inline]
>  path_lookupat+0x16f/0x450 fs/namei.c:2485
>  filename_lookup+0x256/0x610 fs/namei.c:2514
>  user_path_at_empty+0x42/0x60 fs/namei.c:2921
>  user_path_at include/linux/namei.h:57 [inline]
>  ksys_umount fs/namespace.c:1916 [inline]
>  __do_sys_umount fs/namespace.c:1924 [inline]
>  __se_sys_umount fs/namespace.c:1922 [inline]
>  __x64_sys_umount+0xf4/0x170 fs/namespace.c:1922
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f83e9183587
> RSP: 002b:00007fffdb5f1f68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f83e9183587
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffdb5f2020
> RBP: 00007fffdb5f2020 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000202 R12: 00007fffdb5f3110
> R13: 0000555562dbd740 R14: 0000555562dac338 R15: 00007fffdb5f5290
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8e335ca0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
>  #0: ffffffff8e335ca0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8e335ca0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 2 locks held by getty/4849:
>  #0: ffff88802ad660a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
> 1 lock held by syz-executor359/5091:
>  #0: ffff888068e3d1f0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:801 [inline]
>  #0: ffff888068e3d1f0 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.9.0-rc3-next-20240411-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
>  watchdog+0xfde/0x1020 kernel/hung_task.c:380
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 4529 Comm: klogd Not tainted 6.9.0-rc3-next-20240411-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:__rb_insert_augmented+0x9/0x6b0 lib/rbtree.c:458
> Code: c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 41 56 <41> 55 41 54 53 48 83 ec 38 48 89 54 24 08 48 89 74 24 10 48 89 fd
> RSP: 0018:ffffc90004a4f518 EFLAGS: 00000086
> RAX: 000000052ae920a0 RBX: ffff8880b943e6c0 RCX: dffffc0000000000
> RDX: ffffffff816bbee0 RSI: ffff8880b943e710 RDI: ffff88807d890090
> RBP: 1ffff1100fb12019 R08: ffff88807d8900a7 R09: 0000000000000000
> R10: ffff88807d890098 R11: ffffed100fb12015 R12: ffff88802e575b18
> R13: dffffc0000000000 R14: ffff88807d890080 R15: ffff88807d8900c8
> FS:  00007ff2573a4380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005617143a8600 CR3: 000000002be1e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  put_prev_entity+0x62/0x210 kernel/sched/fair.c:5493
>  pick_next_task_fair+0x363/0xde0 kernel/sched/fair.c:8535
>  __pick_next_task+0xb0/0x2c0 kernel/sched/core.c:6030
>  pick_next_task kernel/sched/core.c:6120 [inline]
>  __schedule+0x729/0x4a50 kernel/sched/core.c:6702
>  preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
>  preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
>  preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>  _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
>  sock_def_readable+0x20f/0x5b0 net/core/sock.c:3353
>  unix_dgram_sendmsg+0x148e/0x1f80 net/unix/af_unix.c:2113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff2575069b5
> Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007fff461d0318 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff2575069b5
> RDX: 000000000000004e RSI: 0000556259833d70 RDI: 0000000000000003
> RBP: 000055625982f910 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
> R13: 00007ff257694212 R14: 00007fff461d0418 R15: 0000000000000000
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.937 msecs
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

