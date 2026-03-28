Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AE4A3E
	for <gfs2@lists.linux.dev>; Sat, 28 Mar 2026 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774661074; cv=none; b=QWVH0hx5qrpOeuVdQQpBVNSQMnIZnjoKx1pjYmotZwOMH/REiSWaInveKmZ0Q/e8sbOC1RqvwQc68bceSqLY5ePkW1rYGmi6OeGQexc+6jXlUK+72ikGSUGHkNmhots9Qr0B5sNLLo5TseSkgBKNk1ajg1uum1cmLrOYG2PLk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774661074; c=relaxed/simple;
	bh=LRVC/Li0ggrPjjgr/s41x2IOWB8IItht7g1paJHkAec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uIVNXmOdba72cy7GgIwOZ78d8KWGeoegfg7+vzzZ0JInYekdxQhol0atqOP5zViq4/N9Wvgbn97zBSAHDaUhdLilXWQS9V5TFKDXIW1JysNn+AKvoGKGsBKZOziA5XrGfrwZemIOkNIPM0QfrOGWQhlZMyPwDKaUwCDl8QxgxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-672c40f3873so10719941eaf.2
        for <gfs2@lists.linux.dev>; Fri, 27 Mar 2026 18:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774661072; x=1775265872;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5DMV8H8PaMNIGkxWfcGHGKhIoxj06eGzGyKBWb9A3k=;
        b=o1brS58o9la0G1Qq8nWf3hCQvSM1cSX627niDSvfHCj8Ey0bHAzeQLk91giaJWX/SB
         QqA1nS6ByJ47Fxvp0lBeHstbnPCwrfS5qHHetvYWk5U1s1PSDAZmpEvVaNhYXDdDCk82
         iTeS8BpF3/xhd9jn30NLfXZyov4+w+1tuMdI+FNeOGfsmYlPguMUg104y5E8C6R5CBGg
         PJWQ4KNUSFdXsgvLlk1QP87j9fVcIUZn4MkjGOZh+EiyMCVeribw+UxYg5BpbV3qZSr7
         DJiO5OtoXMygLYXxb7U8IRbx2Z6xbPy1z13fEN2Ve/fc0Xd/R8mpo2xyawQHOnl7uNuf
         ni8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl7T35XI0li3MNJyUDBu0PKpBAWd5cW5MU2xo5n33AUSKxJP/5EPyAA9oPrOI0BnFDDaDp@lists.linux.dev
X-Gm-Message-State: AOJu0YzPGk3gPk7ydYTbBx/T/q6sBxvlvyTXV9gaXxSNdJUaUEzxbOQw
	uMEyOcXCFcto48Wqv1q359FsB31Oh7vdnePQ8Dyw5nXPingVcJC0NcGYYFF0VrXkFyQkUYvX8mJ
	nBdFQYBwK9Ihr4FKEaxdNKkj1a5Ol2FqUPOCmR8GHGYU0q3uDU+ts2y0JpRs=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:62a:b0:67d:f992:86e5 with SMTP id
 006d021491bc7-67e186e7ad4mr2488019eaf.46.1774661071902; Fri, 27 Mar 2026
 18:24:31 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:24:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c72dcf.a70a0220.128fd0.0010.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task kworker/NUM:0H:NUM blocked in I/O wait
 for more than NUM seconds.
From: syzbot <syzbot+cbe76ae6ba264c7a9bb4@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e77a5a5cfe43 Add linux-next specific files for 20260326
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d4f06a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51ca7cbda5f81780
dashboard link: https://syzkaller.appspot.com/bug?extid=cbe76ae6ba264c7a9bb4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63883a48e879/disk-e77a5a5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cfdff9b548ab/vmlinux-e77a5a5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2e4eca37d44/bzImage-e77a5a5c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbe76ae6ba264c7a9bb4@syzkaller.appspotmail.com

INFO: task kworker/0:0H:11686 blocked in I/O wait for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0H    state:D stack:26808 pid:11686 tgid:11686 ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: gfs2-glock/syz:syz glock_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5354 [inline]
 __schedule+0x165c/0x5520 kernel/sched/core.c:6966
 __schedule_loop kernel/sched/core.c:7049 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7064
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7891
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
 inode_go_inval+0x13c/0x360 fs/gfs2/glops.c:366
 do_xmote+0x289/0x760 fs/gfs2/glock.c:699
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1011
 process_one_work kernel/workqueue.c:3278 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3361
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3442
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:16279 blocked in I/O wait for more than 144 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22376 pid:16279 tgid:16279 ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5354 [inline]
 __schedule+0x165c/0x5520 kernel/sched/core.c:6966
 __schedule_loop kernel/sched/core.c:7049 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7064
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7891
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit+0xb9/0x310 kernel/sched/wait_bit.c:52
 out_of_line_wait_on_bit+0x13b/0x190 kernel/sched/wait_bit.c:67
 wait_on_bit_io include/linux/wait_bit.h:105 [inline]
 gfs2_evict_inode+0xbd2/0x12d0 fs/gfs2/super.c:1493
 evict+0x61e/0xb10 fs/inode.c:846
 free_local_statfs_inodes fs/gfs2/super.c:1532 [inline]
 gfs2_put_super+0x635/0x860 fs/gfs2/super.c:632
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1725
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:269 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4c7ef9d9d7
RSP: 002b:00007ffda8fcac98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f4c7f032050 RCX: 00007f4c7ef9d9d7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffda8fcad50
RBP: 00007ffda8fcad50 R08: 00007ffda8fcbd50 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffda8fcbde0
R13: 00007f4c7f032050 R14: 0000000000129899 R15: 00007ffda8fcbe20
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8e75d0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e75d0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e75d0e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5600:
 #0: ffff888036bb20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13a0 drivers/tty/n_tty.c:2211
4 locks held by kworker/0:4/5946:
 #0: ffff8880202bf140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3253 [inline]
 #0: ffff8880202bf140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3361
 #1: ffffc90004d67c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3254 [inline]
 #1: ffffc90004d67c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3361
 #2: ffff88802a3ff1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:995 [inline]
 #2: ffff88802a3ff1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x17f/0x4f30 drivers/usb/core/hub.c:5899
 #3: ffff88807fb671d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:995 [inline]
 #3: ffff88807fb671d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1068
2 locks held by kworker/0:0H/11686:
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3253 [inline]
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3361
 #1: ffffc900060cfc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3254 [inline]
 #1: ffffc900060cfc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3361
1 lock held by syz-executor/15061:
2 locks held by kworker/1:2H/15068:
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3253 [inline]
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3361
 #1: ffffc900153efc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3254 [inline]
 #1: ffffc900153efc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3361
1 lock held by syz-executor/16279:
 #0: ffff88803c1a40d8 (&type->s_umount_key#115){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff88803c1a40d8 (&type->s_umount_key#115){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff88803c1a40d8 (&type->s_umount_key#115){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
2 locks held by kworker/1:0H/19207:
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3253 [inline]
 #0: ffff88802faa7540 ((wq_completion)gfs2-glock/syz:syz){+.+.}-{0:0}, at: process_scheduled_works+0xa35/0x1860 kernel/workqueue.c:3361
 #1: ffffc900058bfc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3254 [inline]
 #1: ffffc900058bfc40 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa70/0x1860 kernel/workqueue.c:3361
1 lock held by udevd/19920:
1 lock held by syz-executor/20111:
 #0: ffff8880503f80d8 (&type->s_umount_key#94){+.+.}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff8880503f80d8 (&type->s_umount_key#94){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff8880503f80d8 (&type->s_umount_key#94){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:508
4 locks held by udevd/21626:
 #0: ffff888077c88f38 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xb7/0xe10 fs/seq_file.c:183
 #1: ffff888058d01480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x5c/0x420 fs/kernfs/file.c:172
 #2: ffff88807808ee18 (kn->active#29){++++}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff88807808ee18 (kn->active#29){++++}-{0:0}, at: kernfs_seq_start+0xb2/0x420 fs/kernfs/file.c:173
 #3: ffff88807fb671d8 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:1000 [inline]
 #3: ffff88807fb671d8 (&dev->mutex){....}-{4:4}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
3 locks held by syz.5.2469/21733:
 #0: ffffffff8fbd7340 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fbd7340 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x722/0xbe0 net/core/rtnetlink.c:6986
 #1: ffff8880795fed88 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2794 [inline]
 #1: ffff8880795fed88 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff8880795fed88 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: tc_get_qdisc+0x330/0x1230 net/sched/sch_api.c:1555
 #2: ffffffff8e7633e8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
 #2: ffffffff8e7633e8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2d0/0x770 kernel/rcu/tree_exp.h:961

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
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1174 Comm: kworker/u8:10 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4869 [inline]
RIP: 0010:__lock_acquire+0x46a/0x2cf0 kernel/locking/lockdep.c:5187
Code: 0b 00 00 41 8d 4c 24 ff 83 f9 ff 41 bd ff ff ff ff 44 0f 4c e9 41 ff c5 41 8d 5c 24 01 49 ff cc 89 d9 83 c1 fe 78 40 45 89 e7 <41> 81 e7 ff ff ff 7f 83 f9 31 73 1d 4b 8d 0c bf 41 8b 8c ce 70 0b
RSP: 0018:ffffc9000594f2d0 EFLAGS: 00000057
RAX: 0000000000020007 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888029098bf0 R08: ffffffff81771696 R09: ffffffff8e75d0e0
R10: ffffc9000594f5d8 R11: ffffffff81b15b90 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888029098000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125542000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff269de92f8 CR3: 000000007f5e0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 rcu_read_lock include/linux/rcupdate.h:850 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 unwind_next_frame+0xc3/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4569 [inline]
 slab_alloc_node mm/slub.c:4898 [inline]
 kmem_cache_alloc_node_noprof+0x384/0x690 mm/slub.c:4950
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:819 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:876 [inline]
 nsim_dev_trap_report_work+0x29a/0xb80 drivers/net/netdevsim/dev.c:922
 process_one_work kernel/workqueue.c:3278 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3361
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3442
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0b 00                	or     (%rax),%eax
   2:	00 41 8d             	add    %al,-0x73(%rcx)
   5:	4c 24 ff             	rex.WR and $0xff,%al
   8:	83 f9 ff             	cmp    $0xffffffff,%ecx
   b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  11:	44 0f 4c e9          	cmovl  %ecx,%r13d
  15:	41 ff c5             	inc    %r13d
  18:	41 8d 5c 24 01       	lea    0x1(%r12),%ebx
  1d:	49 ff cc             	dec    %r12
  20:	89 d9                	mov    %ebx,%ecx
  22:	83 c1 fe             	add    $0xfffffffe,%ecx
  25:	78 40                	js     0x67
  27:	45 89 e7             	mov    %r12d,%r15d
* 2a:	41 81 e7 ff ff ff 7f 	and    $0x7fffffff,%r15d <-- trapping instruction
  31:	83 f9 31             	cmp    $0x31,%ecx
  34:	73 1d                	jae    0x53
  36:	4b 8d 0c bf          	lea    (%r15,%r15,4),%rcx
  3a:	41                   	rex.B
  3b:	8b                   	.byte 0x8b
  3c:	8c ce                	mov    %cs,%esi
  3e:	70 0b                	jo     0x4b


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
