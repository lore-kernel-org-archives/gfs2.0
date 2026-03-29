Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192321E091
	for <gfs2@lists.linux.dev>; Sun, 29 Mar 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824761; cv=none; b=YWndyiJCduQLVSlW197/JXvXclvPM8Kgf/OJPI7B6cmHU7upOktlHvc2hUyC518jG82f41UFqIf2p3U6Rzg2cNE0vuz4pzSW0izmGlO6uuBA6/2bIl3GyWmWJ5MnD4EWkCt20vP9Bbc3S1sV5FHWzy4Z5hZBrzwCh1fDfBbuzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824761; c=relaxed/simple;
	bh=nOXiRR+FXuha/5dc+QAhM8z58MffYBNXef0ZbP+ekhM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=An6l8wWq4AeXpxUFrMx0n2fxDdxv42ZWRwW3ra+BRuYY9KbOfzkRVq34vQuF3Zhx0Iqgn+fm8evWOaEe6iA6QC24UMVWlaZF5Sy9qOs7eASB8OxLx6Z/y+NXLH3IjyMbbNFIfN8b+rCR7msTEJ6bL+2ICoLXO/FXPmO/2TDnBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-41c47598af2so12891044fac.3
        for <gfs2@lists.linux.dev>; Sun, 29 Mar 2026 15:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774824758; x=1775429558;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B81TQsW/xNZ36oLeUcSGKMcpF0RCRwIfn9hPr4wEQRA=;
        b=KPBUVOCe39QuSETGG9t0xR+k5MHNqh86SjLIPUyCANRk8PX40m+fhykEiL99pXAm1J
         82b+r30+wHCQb8MFQBcgE1oTtECBbJ23m61RRKZd+8/ZnqR3fXUvcbu3pMqUOXfu3ejJ
         4oOTxneaucMykib32g0o5pygGZLwJKbfs0Wy4+QX4T/vPDj5x+hcBRgyNYvbWmxExj8n
         Mx8yFUFT4KEUD8uPAIfISjFcz8fE7Sq3DL9tCQmcjBQ5p4JORhtI0TNEQY+an/P+Xumf
         JLf0ZgOLRuoYvNNH4Vqln52UhF/uwSoIjoWaJoi1kB65tz5Cz0DRu5z82bxUJYCre2oM
         ATfg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQvgOXy0e5M5Uf1EZ0n4Neup6spLyHRapI44Mn0qlTjlN/Et53c+jfF07UbpW8J6C+S1W@lists.linux.dev
X-Gm-Message-State: AOJu0YzevSlBmE32gy0+r5vTntk2Y1R5xtdTyssmI4o+2VEnphsmThA5
	94PF0Dg7EHjhRAj8J7q2aSwZeT0UZ9j4nZBSV4Z0Pd0IOqFlJ6vtwbvSwyVftwgwYQRX4FNT4iE
	bsO+MDv9ucZ/EvYLXxvZ7iA+g2CHR6zwTk6HAGz1bN8eAsqVE7q8W6BINWdI=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4df3:b0:67c:1b3d:c82 with SMTP id
 006d021491bc7-67e185ee3e8mr5712189eaf.8.1774824758548; Sun, 29 Mar 2026
 15:52:38 -0700 (PDT)
Date: Sun, 29 Mar 2026 15:52:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c9ad36.a70a0220.128fd0.003b.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in gfs2_clear_rgrpd
From: syzbot <syzbot+97b91714fa078416b2a6@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb71ab2bf722 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122a355a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93740e6c6567fcec
dashboard link: https://syzkaller.appspot.com/bug?extid=97b91714fa078416b2a6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f32db9a438fc/disk-eb71ab2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb85a1b2b7/vmlinux-eb71ab2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24ff0a180fe6/bzImage-eb71ab2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97b91714fa078416b2a6@syzkaller.appspotmail.com

INFO: task syz-executor:11706 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22152 pid:11706 tgid:11706 ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_timeout+0xc3/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2cc/0x5e0 kernel/sched/completion.c:153
 __flush_work+0xa17/0xc50 kernel/workqueue.c:4327
 gfs2_clear_rgrpd+0x117/0x740 fs/gfs2/rgrp.c:731
 gfs2_put_super+0x7d1/0x860 fs/gfs2/super.c:637
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1725
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4d5b9d9d7
RSP: 002b:00007ffd4bd918d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff4d5c31f90 RCX: 00007ff4d5b9d9d7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd4bd91990
RBP: 00007ffd4bd91990 R08: 00007ffd4bd92990 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd4bd92a20
R13: 00007ff4d5c31f90 R14: 00000000000fc517 R15: 00007ffd4bd92a60
 </TASK>
INFO: task kworker/0:2H:15523 blocked for more than 144 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2H    state:D stack:26680 pid:15523 tgid:15523 ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: gfs2-glock/syz:syz glock_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7831
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xec/0x4e0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x13b/0x190 kernel/sched/wait_bit.c:120
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer fs/buffer.c:72 [inline]
 lock_buffer include/linux/buffer_head.h:432 [inline]
 discard_buffer fs/buffer.c:1603 [inline]
 block_invalidate_folio+0x370/0x730 fs/buffer.c:1660
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0xcb/0x190 mm/truncate.c:160
 truncate_inode_pages_range+0x2ce/0xe30 mm/truncate.c:404
 do_xmote+0x289/0x760 fs/gfs2/glock.c:699
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1011
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:1/10:
 #0: ffff8880b863ade0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb6/0x150 kernel/sched/core.c:655
 #1: ffff8880b8624588 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
1 lock held by khungtaskd/31:
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5573:
 #0: ffff888031ef80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/11706:
 #0: ffff8880569ce0e0 (&type->s_umount_key#127){++++}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff8880569ce0e0 (&type->s_umount_key#127){++++}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff8880569ce0e0 (&type->s_umount_key#127){++++}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
2 locks held by syz-executor/13261:
1 lock held by syz.5.1964/14642:
2 locks held by kworker/0:2H/15523:
 #0: ffff88807c7b6d48 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88807c7b6d48 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90006c47c40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90006c47c40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
1 lock held by syz.2.3121/19222:
 #0: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x38d/0x770 kernel/rcu/tree_exp.h:961
2 locks held by syz.3.3122/19224:
 #0: ffffffff8fbcd048 (rtnl_mutex){+.+.}-{4:4}, at: tun_detach drivers/net/tun.c:634 [inline]
 #0: ffffffff8fbcd048 (rtnl_mutex){+.+.}-{4:4}, at: tun_chr_close+0x3e/0x1c0 drivers/net/tun.c:3436
 #1: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #1: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2d0/0x770 kernel/rcu/tree_exp.h:961

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 19222 Comm: syz.2.3121 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:pie_calculate_probability+0x511/0x7e0 net/sched/sch_pie.c:416
Code: 73 64 48 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 ef e8 c1 16 7b f8 4c 8b 7d 00 4c 89 ff 48 89 de e8 b2 df 10 f8 49 39 df <73> 49 48 8b 44 24 20 42 80 3c 20 00 74 08 4c 89 f7 e8 99 16 7b f8
RSP: 0018:ffffc90000a08b88 EFLAGS: 00000293
RAX: ffffffff89b4ae7e RBX: 000000000001c9c3 RCX: ffff888030b99e40
RDX: 0000000000000100 RSI: 000000000001c9c3 RDI: 0000000000000000
RBP: ffffc90016e00c68 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141174 R12: dffffc0000000000
R13: ffff88807ceee2da R14: ffffc90016e00c80 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125563000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0fb7579eb8 CR3: 000000008467f000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 fq_pie_timer+0x288/0x5b0 net/sched/sch_fq_pie.c:402
 call_timer_fn+0x192/0x640 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2039 [inline]
RIP: 0010:vprintk_emit+0x45d/0x560 kernel/printk/printk.c:2478
Code: 0f 84 44 ff ff ff e8 92 27 21 00 fb eb 44 e8 8a 27 21 00 e8 45 0e 09 0a 4d 85 f6 74 94 e8 7b 27 21 00 fb 48 c7 c7 20 27 75 8e <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 cb 16
RSP: 0018:ffffc90004cf75e0 EFLAGS: 00000293
RAX: ffffffff81a46455 RBX: ffffffff81a462cf RCX: ffff888030b99e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e752720
RBP: ffffc90004cf7690 R08: ffffffff90118cb7 R09: 1ffffffff2023196
R10: dffffc0000000000 R11: fffffbfff2023197 R12: 0000000000000000
R13: 000000000000004c R14: 0000000000000200 R15: 1ffff9200099eec0
 _printk+0xdd/0x130 kernel/printk/printk.c:2504
 __ext4_msg+0x2b9/0x2d0 fs/ext4/super.c:995
 ext4_put_super+0xb8/0xc40 fs/ext4/super.c:1300
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1725
 ext4_kill_sb+0x68/0xb0 fs/ext4/super.c:7459
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa64119c799
Code: Unable to access opcode bytes at 0x7fa64119c76f.
RSP: 002b:00007ffee2032268 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fa641417da0 RCX: 00007fa64119c799
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fa641417da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007fa641417cb0 R11: 0000000000000246 R12: 0000000000125e28
R13: 00007fa64141609c R14: 0000000000125d59 R15: 00007fa641416090
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
