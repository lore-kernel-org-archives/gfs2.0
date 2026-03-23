Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98A3E1CE0
	for <gfs2@lists.linux.dev>; Mon, 23 Mar 2026 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296820; cv=none; b=cqqUCMCs8iA34UR/amLG5gz+T0ONDjvP03pSm00XeUQQJ2aP69cY+xjSQoZmwC+e4GI3d1ExyMuAdHBh0ExcFlsZXr5C1ehXO7t8Mp/6HSMWERgC7C4np3U/7Ti0mIc4dCsC54Z6wh4raBVhXVrfHzWtozh6AI+6pubQrJIe9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296820; c=relaxed/simple;
	bh=yOZ7Klbg0wjzSbfOCpH2CPNn2kdVxLSTN2bEo7T8xKw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pn9V1tpJ2XQ0D+1sdP3tUiIK6elWEXe9MoujUkTYJh2yY3VPiGUp1o+NdB5KgA4Offdco2z3VNS22hKX+NrFzaFPg3WB4iQiRYzdGwKVWwt9ZiiDWB5p+rjCDzC4cfiI7GLA98rqvq4/LlDGIrkEOkv4KK7OzyDSEaoEj4T1ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67df0afe34fso8380413eaf.0
        for <gfs2@lists.linux.dev>; Mon, 23 Mar 2026 13:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296817; x=1774901617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDkewDbI1Y+dYEMMaey0pfAkInBShO/li2pmkin9kn8=;
        b=fEIj+Mriy4mGI4G6pVjUutJT6wVsEchFJVAWxflex752k47CMXyqk62ZPjRX9b00so
         /SS2boZ1NYLUe8LBA6ehGaTozeDzbgkHEnQZyMLK0ACNO/52FSDKLvzS4VlI8t+qFUeX
         yZnySL+gw/6yZT/TW7zjDruqQewqLQGZNsiEdlLDpBaM3cVdRLd2C9EuiZG8pC4g/6OK
         7Ylr0Sh8JrzKt7hSLeKQCAArtqEJR03HFqWAU21hZTHL1CJVJvCVh+w7zG8hWyTWQ2Gg
         vRyctulsLfkOtAQT1baUI/0408voysVgEb12ASAo+SN9EjCvSMAnmiewV+uOzXG/XUfd
         xeuA==
X-Forwarded-Encrypted: i=1; AJvYcCVwPw5LaZF3KEVuloGtfWltPIB+6M2bT0Q5m2Qf3y8rJdC9Ja4ctha12lGyQB3nLeuhTrUi@lists.linux.dev
X-Gm-Message-State: AOJu0YwBtyb8BkJVPrxAI2gD1cMohSl4HWhhkrUsQKOdBjL+CYj9c+k2
	6wq4dReeYrwcLggHE17emUw7ZKX5ooAmqUtVTwBguVB70TG3cyDI9PLNUYSdsdIu2nd/8p1Jtpb
	NVSOdyCMNjkNkmfrc9OTMK1jsmklzkoFE7ouWd28LpcQQ1w0xaJFZqq7JsWY=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2103:b0:67d:e9e9:f6f with SMTP id
 006d021491bc7-67de9e91407mr4500447eaf.42.1774296816736; Mon, 23 Mar 2026
 13:13:36 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:13:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c19ef0.050a0220.3bf4de.00a9.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in gfs2_recover_journal (4)
From: syzbot <syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    785f0eb2f85d Add linux-next specific files for 20260320
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b352f6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c584910d0d74158d
dashboard link: https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b352f6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1528aada580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f7fd9c1a63/disk-785f0eb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c138da87c25/vmlinux-785f0eb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d1be64e56db/bzImage-785f0eb2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b8d9a874b489/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16fc7ada580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com

INFO: task kworker/0:3:5963 blocked in I/O wait for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:25400 pid:5963  tgid:5963  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: gfs2_recovery gfs2_recover_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5352 [inline]
 __schedule+0x165c/0x5560 kernel/sched/core.c:6964
 __schedule_loop kernel/sched/core.c:7047 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7062
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7889
 folio_wait_bit_common+0x6d8/0xbc0 mm/filemap.c:1324
 folio_wait_locked include/linux/pagemap.h:1245 [inline]
 gfs2_jhead_process_page+0x175/0x670 fs/gfs2/lops.c:470
 gfs2_find_jhead+0xbd2/0xd30 fs/gfs2/lops.c:586
 gfs2_recover_func+0x6cf/0x1f60 fs/gfs2/recovery.c:459
 process_one_work+0x9a3/0x1710 kernel/workqueue.c:3288
 process_scheduled_works kernel/workqueue.c:3379 [inline]
 worker_thread+0xba8/0x11e0 kernel/workqueue.c:3465
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.18:6005 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.18        state:D stack:24120 pid:6005  tgid:6005  ppid:5953   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5352 [inline]
 __schedule+0x165c/0x5560 kernel/sched/core.c:6964
 __schedule_loop kernel/sched/core.c:7047 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7062
 bit_wait+0x11/0xd0 kernel/sched/wait_bit.c:240
 __wait_on_bit+0xb9/0x310 kernel/sched/wait_bit.c:52
 out_of_line_wait_on_bit+0x13b/0x190 kernel/sched/wait_bit.c:67
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 gfs2_recover_journal+0xda/0x140 fs/gfs2/recovery.c:579
 init_journal+0x16ad/0x2280 fs/gfs2/ops_fstype.c:794
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:844
 gfs2_fill_super+0x1a38/0x21d0 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3764 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3840
 do_mount fs/namespace.c:4173 [inline]
 __do_sys_mount fs/namespace.c:4372 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4349
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f611259da0a
RSP: 002b:00007ffe1764d4e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe1764d570 RCX: 00007f611259da0a
RDX: 0000200000037f40 RSI: 0000200000037f80 RDI: 00007ffe1764d530
RBP: 0000200000037f40 R08: 00007ffe1764d570 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000037f80
R13: 00007ffe1764d530 R14: 0000000000037fc4 R15: 0000200000000300
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
1 lock held by khungtaskd/30:
 #0: ffffffff8e75d7e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e75d7e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e75d7e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5600:
 #0: ffff888037d8f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13a0 drivers/tty/n_tty.c:2211
2 locks held by kworker/0:3/5963:
 #0: ffff8880232a6140 ((wq_completion)gfs2_recovery){+.+.}-{0:0}, at: process_one_work+0x890/0x1710 kernel/workqueue.c:3260
 #1: ffffc900043b7c40 ((work_completion)(&jd->jd_work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x1710 kernel/workqueue.c:3261
1 lock held by syz.0.18/6005:
 #0: ffff8880346ce0d8 (&type->s_umount_key#54/1){+.+.}-{4:4}, at: alloc_super+0x28c/0xab0 fs/super.c:345
3 locks held by syz.1.203/6599:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6599 Comm: syz.1.203 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:mark_lock+0xa4/0x190 kernel/locking/lockdep.c:4774
Code: 0e 48 c7 c6 19 03 06 8e 67 48 0f b9 3a 90 31 c9 4c 89 fe 4c 89 f7 b8 01 00 00 00 85 69 60 74 10 5b 41 5c 41 5d 41 5e 41 5f 5d <c3> cc cc cc cc cc 49 89 fe 49 89 f7 e8 5b 94 ff ff 89 c1 31 c0 85
RSP: 0018:ffffc90000a08840 EFLAGS: 00000006
RAX: 0000000000000001 RBX: ffff88801d3dc8e8 RCX: ffffffff93c65330
RDX: 0000000000000008 RSI: ffff88801d3dc8c8 RDI: ffff88801d3dbd00
RBP: ffff88801d3dc8c8 R08: ffffffff84b9d570 R09: ffffffff9a4fdcb8
R10: ffffc90000a08a60 R11: fffff5200014114e R12: 0000000000000003
R13: ffff88801d3dc8c8 R14: ffff88801d3dbd00 R15: 0000000000000003
FS:  000055557c000500(0000) GS:ffff888125548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055910e737168 CR3: 000000006c700000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 mark_usage kernel/locking/lockdep.c:4674 [inline]
 __lock_acquire+0x6b5/0x2cf0 kernel/locking/lockdep.c:5191
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 debug_object_assert_init+0xb0/0x370 lib/debugobjects.c:1035
 debug_timer_assert_init kernel/time/timer.c:803 [inline]
 debug_assert_init kernel/time/timer.c:848 [inline]
 __mod_timer+0x4a/0xf30 kernel/time/timer.c:1025
 dsp_cmx_send+0x1abe/0x1b40 drivers/isdn/mISDN/dsp_cmx.c:1839
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
 handle_softirqs+0x22a/0x840 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:739
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:756
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2039 [inline]
RIP: 0010:vprintk_emit+0x45d/0x560 kernel/printk/printk.c:2478
Code: 0f 84 44 ff ff ff e8 a2 09 21 00 fb eb 44 e8 9a 09 21 00 e8 75 7b 0b 0a 4d 85 f6 74 94 e8 8b 09 21 00 fb 48 c7 c7 00 fc 74 8e <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 cb 18
RSP: 0018:ffffc90004b06e00 EFLAGS: 00000293
RAX: ffffffff81a547f5 RBX: ffffffff81a5466f RCX: ffff88801d3dbd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e74fc00
RBP: ffffc90004b06eb0 R08: ffffffff90123cf7 R09: 1ffffffff202479e
R10: dffffc0000000000 R11: fffffbfff202479f R12: 0000000000000000
R13: 000000000000002f R14: 0000000000000200 R15: 1ffff92000960dc4
 _printk+0xdd/0x130 kernel/printk/printk.c:2504
 set_capacity_and_notify+0x2c5/0x320 block/genhd.c:93
 loop_set_size+0x44/0xb0 drivers/block/loop.c:220
 loop_configure+0x9ac/0xdf0 drivers/block/loop.c:1079
 lo_ioctl+0x447/0x1fb0 drivers/block/loop.c:1534
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:804
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa17279c42b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffde9d10a80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fa17279c42b
RDX: 0000000000000003 RSI: 0000000000004c00 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffde9d10bb0 R14: 00007ffde9d10b70 R15: 00007fa169800000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
