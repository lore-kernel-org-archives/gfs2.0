Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD325199E89
	for <gfs2@lists.linux.dev>; Sat, 16 Aug 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755313716; cv=none; b=Rs5XUKPzgce+GKpBQlcR8ibxEUyCE4JEqMCSHEwQC4q7UvMcehSIEG4ih7zXeVlDGf1DkjsIe5AQbKsidtllf17US2wIuvoPmrUINdNGLxcuiBebFxUFn/TaEjwsRnaGmFo+Y5o3ULDEYlb+5Og4lYLbB768W9A6gcUSfr0F2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755313716; c=relaxed/simple;
	bh=nyBuEQ/G1p92SKtYKVzlV3Tx8j1SPkqBXGOjxzxf7fA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZqnqhsRyFq3PQhscGYOPzQsw7slZEasnGl9jnI7Mi1vDIFFjTyYFvdsjw3N0RYxWIqJ556BMvpRKKoUuhzlVsOFBWSIIsWOH92hQhl/nP3HaYnQegHqIxrZzMrHJ9QyHnbmZsMo7Evsi3jqH8IxBLx0rnWyVFKVlpNV1FFWlrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e56ff8e3d1so76000975ab.1
        for <gfs2@lists.linux.dev>; Fri, 15 Aug 2025 20:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755313714; x=1755918514;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=138n+argR6uLDPv6aVP0D03lRs53irjeTxbVz8oWTHM=;
        b=lfstmIEgoPTTm0ys4pz1LYlqP8aAZmn6qNuUAdajaC0+vtMvi6VMr5m0+b4L5wDXJK
         OV/hocSMyuuFsi+EinLr1/XUpIFoeB6Jp2nagFc1PKlHzm1fXI3KacFHU2XZpJnlP1Oz
         8jpyuxqPB1sETorkyzDhOmWxX7ghc8mxamRHw7JxOLGm+L1DIQ8uEWJew1mVkoQG7x4M
         JRBZ7vaIiNy8x/q8ie1w8IDP/ektpnHaXUb7DOREkU+0RG4IRUnigTfXohhg1jWXMa40
         PNmK3mTof0MeAC2dxM1mRkC6tR/CjUr8gB6tczW7eIRqawAQFFjBD1hH5WBp0ARN3+OW
         0hwg==
X-Forwarded-Encrypted: i=1; AJvYcCUcQcAZT/2p57dIK8p74qpfcNHc50K8tKOOPHixZm89p4MZVXRcqyW6tfm3PBTlgpYcGzUh@lists.linux.dev
X-Gm-Message-State: AOJu0YyVtYhLATe5BgJR7RSfrTxVOWTGAiaRFiG2lOzOxEkSZDEfNZ0e
	OeSJ0HQrrcnDRXvN81XoJM3xUwHC0rVW83+Xei+NSrmkk5M/TsOvyP1BrrcOBQ+UQYoUoE0dCJm
	qmSJE1WwPwpQ/rKzw2ycLd7VKSQbhMkCMrb+EsKR6Klvj7QxlACNFzdX0ucE=
X-Google-Smtp-Source: AGHT+IEceZ0PWZFB2t8TDnYaXK13+9FAKr7svpc69eNH+jDRTGmHlAJxefkwFy0blHARAq6ChAfFBZED83U9Y0S/yIh1jJ6sOovm
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:3e5:4c7d:b799 with SMTP id
 e9e14a558f8ab-3e57e8b10f3mr82422895ab.13.1755313713752; Fri, 15 Aug 2025
 20:08:33 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:08:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689ff631.050a0220.e29e5.0034.GAE@google.com>
Subject: [syzbot] [gfs2?] INFO: task hung in __gfs2_log_reserve
From: syzbot <syzbot+e1c0c6cfbf89afd6043b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d2a3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a286bd75352e92fa
dashboard link: https://syzkaller.appspot.com/bug?extid=e1c0c6cfbf89afd6043b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124e53a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb896162d550/disk-931e46dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45f6f857b82c/vmlinux-931e46dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f16e70143e1/bzImage-931e46dc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f940547f87f4/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=114ebdbc580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1c0c6cfbf89afd6043b@syzkaller.appspotmail.com

INFO: task syz.3.81:6420 blocked for more than 143 seconds.
      Not tainted 6.17.0-rc1-next-20250814-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.81        state:D stack:25224 pid:6420  tgid:6419  ppid:5999   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x80/0xd0 kernel/sched/core.c:7903
 __gfs2_log_reserve+0x208/0x400 fs/gfs2/log.c:535
 __gfs2_trans_begin+0x549/0x890 fs/gfs2/trans.c:91
 gfs2_trans_begin+0x6f/0xe0 fs/gfs2/trans.c:118
 sweep_bh_for_rgrps fs/gfs2/bmap.c:1533 [inline]
 punch_hole+0x1e92/0x2ca0 fs/gfs2/bmap.c:1860
 gfs2_iomap_end+0x4f8/0x6c0 fs/gfs2/bmap.c:1178
 iomap_iter+0x313/0xde0 fs/iomap/iter.c:79
 iomap_file_buffered_write+0x7fa/0x9b0 fs/iomap/buffered-io.c:1065
 gfs2_file_buffered_write+0x4ed/0x880 fs/gfs2/file.c:1061
 gfs2_file_write_iter+0x94e/0x1100 fs/gfs2/file.c:1166
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6079d8ebe9
RSP: 002b:00007f607ab5e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6079fb5fa0 RCX: 00007f6079d8ebe9
RDX: 000000000208e24b RSI: 0000200000000040 RDI: 0000000000000005
RBP: 00007f6079e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6079fb6038 R14: 00007f6079fb5fa0 R15: 00007ffc464b02d8
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7655 Comm: syz.4.375 Not tainted 6.17.0-rc1-next-20250814-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:102 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
RIP: 0010:unwind_next_frame+0x130e/0x2390 arch/x86/kernel/unwind_orc.c:494
Code: c1 e8 3f 48 01 c8 48 83 e0 fe 4c 8d 3c 45 00 00 00 00 49 01 ef 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 75 27 49 63 07 4c 01 f8 49 8d 4f 04 4c 39 e0 48 0f 46 e9 49
RSP: 0000:ffffc9000c347038 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: ffffffff8fc13fd0 RCX: dffffc0000000000
RDX: ffffffff8fc13fd0 RSI: ffffffff90421854 RDI: ffffffff8be34ba0
RBP: ffffffff8fc13fd0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000c347158 R11: ffffffff81ac38c0 R12: ffffffff8233ae18
R13: ffffffff8fc13fd0 R14: ffffc9000c347108 R15: ffffffff8fc13fd0
FS:  00007fd1ce43f6c0(0000) GS:ffff888125c0f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbb56ad000 CR3: 00000000563d8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf5/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x8d/0x4a0 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2435
 shmem_alloc_folio mm/shmem.c:1908 [inline]
 shmem_alloc_and_add_folio+0x447/0xf60 mm/shmem.c:1947
 shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2597
 shmem_get_folio mm/shmem.c:2703 [inline]
 shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3353
 generic_perform_write+0x2c5/0x900 mm/filemap.c:4176
 shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3528
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1cd58d69f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007fd1ce43edf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007fd1cd58d69f
RDX: 0000000001000000 RSI: 00007fd1c4600000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000001f78a
R10: 000020000005e5c2 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fd1ce43eef0 R14: 00007fd1ce43eeb0 R15: 00007fd1c4600000
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
