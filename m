Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD890342524
	for <gfs2@lists.linux.dev>; Wed, 15 Apr 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253044; cv=none; b=hY1L1AfXnVurm/042vTSpWRZqQVQxSdSa468GAbeoDbcB/bIphgESrTmc6qDw22GLL/QOpQ1wXmvEPeNvGQGHSL3Osx81YKNVNNafseLhIteYiprgNdz+jFUb5QUOaJ4nJaR6ptppd0yhTnNnodaQmA6DbNgRQ91hqwxZ6P+fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253044; c=relaxed/simple;
	bh=HaHZZvKLCZvbBqQnF7Ww5wIVZsMKFyFteOLY2Tl2N/0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ndWCX9pGTB1W692830MaBhWNQj0jcXusYHMGRKpvanUJ7ZYxBPp/oRQtVh8nPugjyHes5rn2xqn3TyUBWZtgY2P4uxHke2kOSPOLqLSngG8rZJ8BpiFs/HSCbi5OH9hZjoJEgrhVUSAAeJLzP3wcAVR+fJZAO2aGbXl5z4qCun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7d7dfe2d094so7161030a34.3
        for <gfs2@lists.linux.dev>; Wed, 15 Apr 2026 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253041; x=1776857841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQpteXm1nR+b0zldzK54onIgN+eNMRx/NsepcgFBXeQ=;
        b=NMUTLoGe51kDV30Qjc/5EfTaYLBvX5cL0winx2CHnrldL+FCQcwkhyWA48oDMBqE8A
         rYsEL/HxWN1b2BsKpL5bNXlKxr3jtYxgM0bybWqp+luwRrDeD1A7+oDWy9wioyfFv1j5
         uTFxwIhcq/n3HXPS5fC9j9yuczm91W02P2XxWwdJspsaqm4qBy0MBylzxEJAbQB7/Asv
         N/aqaKf7qiLs+nRiJRmSMFNptHYglwrtuievqKvdRfBu50CC85l00oqJ1ZKuNaE6Fr1C
         AmAdGQc7ZbN0lqb0CXMqXVCgDLdpK7pzPYXdvJWb1DcyB3e1Dqzz1zYJs37c5RdTvrYl
         jxzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OdNmE44j63Rg6P5bqAr+rUKy/q/7B7hUiJsqtALjhgMofT81vji39k1My+U9jIxDrOh6m@lists.linux.dev
X-Gm-Message-State: AOJu0YxcpudvLkWBix4AyJEwXfQpbhbNmM4OdTiMmrWK4nBOt1DUZ3Fm
	f0VHBU6eOiv7BhWyOX91jBb2BqGS0cw5dKsUf1Pke9RToHWdlouMSVF/zy6Dtgj1jKANrqUF1Kl
	S2rSFcB43dAdS/AMgS3gWprl1yxCQhlLUxhGNQ0JJEkTSNi++A+HtimtFhJ4=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:210f:b0:692:1f42:f1b4 with SMTP id
 006d021491bc7-6921f42fc64mr2613374eaf.8.1776253041489; Wed, 15 Apr 2026
 04:37:21 -0700 (PDT)
Date: Wed, 15 Apr 2026 04:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69df7871.a70a0220.259bc5.0007.GAE@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in lockref_get_not_dead
From: syzbot <syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e6efabc0afca Add linux-next specific files for 20260414
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a47036580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56c2b36de3316f1b
dashboard link: https://syzkaller.appspot.com/bug?extid=642d0561f78362d67d3f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f3fb02580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f401ba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7099cbf73e4/disk-e6efabc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/439c402df1b9/vmlinux-e6efabc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0c0175fc76/bzImage-e6efabc0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/417e68633ca3/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15f401ba580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6017, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
4 locks held by syz.0.17/6017:
 #0: ffff888035b200d0 (&type->s_umount_key#54/1){+.+.}-{4:4}, at: alloc_super+0x28c/0xac0 fs/super.c:345
 #1: ffffffff8e620a78 (qd_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #1: ffffffff8e620a78 (qd_lock){+.+.}-{3:3}, at: gfs2_quota_init+0x854/0x1220 fs/gfs2/quota.c:1459
 #2: ffffffff8dfc8100 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8dfc8100 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8dfc8100 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8dfc8100 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #3: ffff88805d082b78 (&lockref->lock#3){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff88805d082b78 (&lockref->lock#3){+.+.}-{3:3}, at: lockref_get_not_dead+0x28/0xd0 lib/lockref.c:155
Preemption disabled at:
[<ffffffff841e0f2b>] bit_spin_lock include/linux/bit_spinlock.h:38 [inline]
[<ffffffff841e0f2b>] hlist_bl_lock include/linux/list_bl.h:149 [inline]
[<ffffffff841e0f2b>] spin_lock_bucket+0x3b/0x150 fs/gfs2/quota.c:98
CPU: 1 UID: 0 PID: 6017 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9162
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc2/0x400 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 lockref_get_not_dead+0x28/0xd0 lib/lockref.c:155
 gfs2_qd_search_bucket+0x139/0x210 fs/gfs2/quota.c:269
 gfs2_quota_init+0x86c/0x1220 fs/gfs2/quota.c:1461
 gfs2_make_fs_rw+0x143/0x230 fs/gfs2/super.c:149
 gfs2_fill_super+0x1bfd/0x2220 fs/gfs2/ops_fstype.c:1275
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3834
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4399 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4376
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc2a800da8a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3b870ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff3b870f30 RCX: 00007fc2a800da8a
RDX: 00002000000124c0 RSI: 0000200000012500 RDI: 00007fff3b870ef0
RBP: 00002000000124c0 R08: 00007fff3b870f30 R09: 0000000000004800
R10: 0000000000004800 R11: 0000000000000246 R12: 0000200000012500
R13: 00007fff3b870ef0 R14: 00000000000125fd R15: 0000200000000180
 </TASK>
gfs2: fsid=syz:syz.0: Corruption found in quota_change0file: duplicate identifier in slot 48768
gfs2: fsid=syz:syz.0: warning: assertion "!qd->qd_change" failed - function = gfs2_qd_dispose, file = fs/gfs2/quota.c, line = 129
CPU: 1 UID: 0 PID: 6017 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 gfs2_assert_warn_i+0x194/0x2c0 fs/gfs2/util.c:304
 gfs2_qd_dispose+0x466/0x570 fs/gfs2/quota.c:129
 gfs2_quota_init+0xcda/0x1220 fs/gfs2/quota.c:1470
 gfs2_make_fs_rw+0x143/0x230 fs/gfs2/super.c:149
 gfs2_fill_super+0x1bfd/0x2220 fs/gfs2/ops_fstype.c:1275
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3834
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4399 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4376
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc2a800da8a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3b870ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff3b870f30 RCX: 00007fc2a800da8a
RDX: 00002000000124c0 RSI: 0000200000012500 RDI: 00007fff3b870ef0
RBP: 00002000000124c0 R08: 00007fff3b870f30 R09: 0000000000004800
R10: 0000000000004800 R11: 0000000000000246 R12: 0000200000012500
R13: 00007fff3b870ef0 R14: 00000000000125fd R15: 0000200000000180
 </TASK>
gfs2: fsid=syz:syz.0: found 1 quota changes


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
