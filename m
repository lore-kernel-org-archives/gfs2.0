Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BB17A30A
	for <gfs2@lists.linux.dev>; Fri,  7 Aug 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060838; cv=none; b=tGtLTn8pophOEv7iQGnBuZhVN/SJOeVrfgp2d2p1RsmWe3QHlZfcv0QmC53Bxayn+KVL/0NJNMsLWnfDbiFuWiQ6moFPezC8A8WdAldz5VF5oo7kERM/M4F9fgHlYj36VK+pXLZIeHYt3e3DrVj9TahaLIqPu0oJPintojQp+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060838; c=relaxed/simple;
	bh=A/82UPe7Wl8AV+Y1N2mBt7PwmTi+Mi4cIfxgdux3cM8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ItPMbkT7oAluYwJmj9kKLQcT4nJIcZlbXBDh/bpsnVUQEZ2lQZMk/r2SXheMmMpj6Cv1pMlSY7MiBA250r3t/y1OICaPl3d8uT1k717szuhAESJpjWeT/CR+LI4ZtwAOCVPvkqU1vwm8CnmksNNEWq7QYzfnRrkiQ0wJRzvOtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a7c64fbbc6so1559456b6e.2
        for <gfs2@lists.linux.dev>; Thu, 06 Aug 2026 17:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060836; x=1786665636;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeVwARPoHgM/UIINZdBQHmw/RIEM96j5LkO43vmWrjM=;
        b=ZPk/WI+Rg33HZc9G39HmZKEFB3iMa1xDItR0okhZ0NyQA9ZWQg+SUQeVhiGHsvIG9Y
         tHEmfG9HGVDNKjcoE2u4mZS4g2Z38leJy1ci8iVGZuo6QFl4xV7Gzta0QZPOASvAHkYb
         AjQ4Y6JwqR0v8fyb+N4+6HavRkeL+TKMypEyoQQtcxHaUHR1bm9hx6bPo0g0c0MCf4Ek
         BPczaV+ie4RTeMeMxkFSH9eZ2iR03FK5OfkEwOZE6omEe/jkCVExVftW9hBbdmZ9TOVP
         eHU9sFydCRYPeYHgHiq0ATI03hznHUfBjZDS7w+gEbPZdpcY2R9lXDSO31ht3YWECAuP
         gWSA==
X-Forwarded-Encrypted: i=1; AHgh+RrYFZXA8wzfbYQlvEOh+5B3S3xAHC79QaLfcIzHjGxHNXy+tKlY3iNrB5VRKrcFY4xfUbWb@lists.linux.dev
X-Gm-Message-State: AOJu0YzCZeo305ALIb2U9PXQeHp5HYqfcYXc6NNVAC08xeICXnfn5opD
	AGMdl/EjPVvIYTqVeL1siZG4xmpajDyBoBd4S3IC5eYXg4U+gMgFhiVz4GCagdagb2uwATOleIN
	BvxCRjwvoFwLkzoUT4bpHUgYQCIL8KWk29Nr0P/LSmDdEbbKYwq8diOqJ50k=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1792:b0:487:530f:5754 with SMTP id
 5614622812f47-4afae1a151bmr11910933b6e.20.1786060835881; Thu, 06 Aug 2026
 17:00:35 -0700 (PDT)
Date: Thu, 06 Aug 2026 17:00:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a752023.b50370da.49fe0.0016.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in do_uevent
From: syzbot <syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com>
To: aahringo@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12237e32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=b114bbe890d76037877c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f5bb9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13737649580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32c9dc084aaa/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7604244b0a9/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4cd321f6fe47/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com

INFO: task syz-executor291:5623 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor291 state:D stack:26184 pid:5623  tgid:5623  ppid:5622   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x125c/0x6730 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7326
 do_uevent+0x427/0x530 fs/dlm/lockspace.c:206
 new_lockspace fs/dlm/lockspace.c:583 [inline]
 __dlm_new_lockspace+0x1698/0x1fa0 fs/dlm/lockspace.c:638
 dlm_new_user_lockspace+0x60/0x90 fs/dlm/lockspace.c:671
 device_create_lockspace fs/dlm/user.c:414 [inline]
 device_write+0x930/0x1c90 fs/dlm/user.c:606
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf45fdf6c9
RSP: 002b:00007ffc57d9a3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007faf45fdf6c9
RDX: 0000000000000080 RSI: 0000200000000d00 RDI: 0000000000000005
RBP: 6769666e6f632f2e R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffc57d9a518
R13: 0000200000000008 R14: 00007faf46072c40 R15: 0000000000000002
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6775
5 locks held by kworker/u8:2/36:
 #0: ffff8880b843b520 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x140 kernel/sched/core.c:667
 #1: ffff8880b8424568 (psi_seq){-.-.}-{0:0}, at: psi_sched_switch kernel/sched/stats.h:218 [inline]
 #1: ffff8880b8424568 (psi_seq){-.-.}-{0:0}, at: __schedule+0x2e8e/0x6730 kernel/sched/core.c:7228
 #2: ffff8880b8426298 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x124/0x1d0 kernel/time/timer.c:1004
 #3: ffffffff9b978ca0 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x144/0x4b0 lib/debugobjects.c:873
 #4: ffffffff8ea99840 (text_mutex){+.+.}-{4:4}, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
1 lock held by klogd/4968:
 #0: ffff8880b843b520 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x140 kernel/sched/core.c:667
2 locks held by getty/5376:
 #0: ffff8880357b10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
1 lock held by syz-executor291/5623:
 #0: ffffffff9b7cf4c0 (&ls_lock){+.+.}-{4:4}, at: __dlm_new_lockspace+0xb8/0x1fa0 fs/dlm/lockspace.c:632
1 lock held by dlm_recoverd/5625:
 #0: ffff888079814a18 (&ls->ls_in_recovery){+.+.}-{4:4}, at: dlm_recoverd+0xbd/0x1f90 fs/dlm/recoverd.c:400

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x21c/0x2a0 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xcb1/0x1030 kernel/hung_task.c:561
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: d6 8b 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d a3 5f 10 00 fb f4 <e9> 3c 4a 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e807e10 EFLAGS: 00000246
RAX: 00000000000c7b8b RBX: ffffffff8e891480 RCX: ffffffff8bbb42d5
RDX: 0000000000000000 RSI: ffffffff8e1a8186 RDI: ffffffff8c402680
RBP: fffffbfff1d12290 R08: 0000000000000001 R09: ffffed101708678d
R10: ffff8880b8433c6b R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffffffff1d00fc6 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888123dd8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558a95fb1660 CR3: 000000000e994000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:768
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x3a7/0x5b0 kernel/sched/idle.c:355
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:454
 rest_init+0x251/0x260 init/main.c:717
 start_kernel+0x48e/0x490 init/main.c:1175
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x158
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
