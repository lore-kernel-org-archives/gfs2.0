Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE123033DA
	for <gfs2@lists.linux.dev>; Mon, 29 Jun 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766103; cv=none; b=SUMMbkUOVnTm1DrMPrlYyg/QZegEfgSYs7ns+EYFgenNodvyVepAxZi0KLk4P7nMaNF+ax8brP6/F3xdH+htYnNiAdX0CPf6Q3i2FRhXILrQu5j9eGyxuBJPRSzEPaajGo6WuL9V1a8Cj81VuDrJhgWkkKZt6Mj6zsLniDrFlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766103; c=relaxed/simple;
	bh=OUbVhrc+t2rO3ZhCZdch38euvYjsDV/+O8hDPwb4sc0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qqeDqYXFKu5FeXbzOOb5jDEtt9g2Ynud0Ota/cN8HClwbkb/E7PDd9ujsEKt2lyJbXYj7G7VvlKxw533UT43NHXmMOMCFUCibrviTRi3r/0CtYtoKq1rKW9OVPR1YuV7YfXswvsuP8a18Y2F0ov2z7EfKegyaah7Nw0Egw3hjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48e5de5a23cso4885107b6e.0
        for <gfs2@lists.linux.dev>; Mon, 29 Jun 2026 13:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782766101; x=1783370901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFwE3U6RLu7L0JrfkTqLMYih01tklGk8gkOxfzJFLJ4=;
        b=ns05P1EVGndlDG/6mrXHDXyUdZXKsYVQ3KKkmd9JuOSmdf1XVqkvm9krTRl6VAAD6Z
         eOHVMCcwF6Jn/dWbpbMvl+exXmPO5TaPdVUY3zuH6OVUOlX5aUEZvV9saFuQH4EUMBv/
         dahTyCUXEmXk8ruYD5skyPehRhajRXAZpm76y3WNd/U13TOjwOssd/i8nbNeeHSKttGR
         CWfEeslvY6/YaaqLVY7/L0kf5W5VivMV0lGz8XZJGh139jgo/neUWGjbkjSgGuUK7z9F
         xghNZeucBtb/aoQeyjtypFvdjQHjUhYQimanEvo7Yx1XTLf3dMjTyLY80XXsRkMIkyre
         +rdg==
X-Forwarded-Encrypted: i=1; AFNElJ/xUiiENYD+it5B/XiXGddk5Qu2jAvIE7rakM6GwRF2pIh4fM4bg1705+4UqPtK+WyCAa4V@lists.linux.dev
X-Gm-Message-State: AOJu0YzbLTQY8rQXHE0YrIgXreswBB6mCyO4NylHvQhrTqeQ1PZYBPyS
	RlJCpJVvNNCHjrY8Cj/jT1yAWFB73EH6zdgjw93b7kJu/TIOUkU0lshiBvhRXVV40Fe3CpOZyhC
	JKf7Q/hU80qsjzQAdkWWhmLhZEC9+lhzjo1h/yVNCfVimipSYqKRJa5jh0H4=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3089:b0:489:f088:5f70 with SMTP id
 5614622812f47-495eae01c05mr934536b6e.12.1782766100970; Mon, 29 Jun 2026
 13:48:20 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a42da14.b42ede87.8e801.0000.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in _find_first_zero_bit
From: syzbot <syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51cb1aa1250c Merge tag 'loongarch-7.2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10748efa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
dashboard link: https://syzkaller.appspot.com/bug?extid=cb79de2cc8b76fbf474f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b7c246580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1205b6b1580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/edf195a1627e/disk-51cb1aa1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e282a4f3a85b/vmlinux-51cb1aa1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a485374265d8/bzImage-51cb1aa1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/82f270d69c7c/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=17b48efa580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb79de2cc8b76fbf474f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5755 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:_find_first_zero_bit+0x29/0xb0 lib/find_bit.c:149
Code: 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 85 f6 74 46 48 89 f3 49 89 fe 49 bf 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 b8 55 7c fd 49 8b 06 48 83 f8 ff
RSP: 0018:ffffc9000365f6c0 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 000000000000f800 RCX: 0000000000000000
RDX: ffff888034374c40 RSI: 000000000000f800 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006cbecc R12: ffff888058d1d3f0
R13: ffff888034374c38 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125223000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8b8a06ea00 CR3: 000000000e746000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 find_first_zero_bit include/linux/find.h:391 [inline]
 slot_get fs/gfs2/quota.c:355 [inline]
 qdsb_get+0x133/0x340 fs/gfs2/quota.c:522
 gfs2_quota_hold+0x191/0x5c0 fs/gfs2/quota.c:606
 gfs2_dinode_dealloc+0x176/0x3f0 fs/gfs2/inode.c:488
 evict_unlinked_inode fs/gfs2/super.c:1329 [inline]
 gfs2_evict_inode+0x11cd/0x1400 fs/gfs2/super.c:1479
 evict+0x624/0xb50 fs/inode.c:825
 gfs2_put_super+0x300/0x860 fs/gfs2/super.c:618
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:647
 kill_block_super+0x44/0x90 fs/super.c:1665
 deactivate_locked_super+0xbc/0x130 fs/super.c:477
 cleanup_mnt+0x3d3/0x460 fs/namespace.c:1317
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x73a/0x2360 kernel/exit.c:1004
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1147
 __do_sys_exit_group kernel/exit.c:1158 [inline]
 __se_sys_exit_group kernel/exit.c:1156 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1156
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b89f9ce59
Code: Unable to access opcode bytes at 0x7f8b89f9ce2f.
RSP: 002b:00007ffc5b7df378 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8b8a03233c RCX: 00007f8b89f9ce59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000016 R08: 0000000000000000 R09: 00007f8b8a0322ca
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc5b7e0630
R13: 00007f8b8a0322ca R14: 0000555582f544e8 R15: 00007ffc5b7e49d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_find_first_zero_bit+0x29/0xb0 lib/find_bit.c:149
Code: 90 f3 0f 1e fa 41 57 41 56 41 55 41 54 53 48 85 f6 74 46 48 89 f3 49 89 fe 49 bf 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 08 4c 89 f7 e8 b8 55 7c fd 49 8b 06 48 83 f8 ff
RSP: 0018:ffffc9000365f6c0 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 000000000000f800 RCX: 0000000000000000
RDX: ffff888034374c40 RSI: 000000000000f800 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006cbecc R12: ffff888058d1d3f0
R13: ffff888034374c38 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125223000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8b8a06ea00 CR3: 000000000e746000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	f3 0f 1e fa          	endbr64
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	41 55                	push   %r13
   b:	41 54                	push   %r12
   d:	53                   	push   %rbx
   e:	48 85 f6             	test   %rsi,%rsi
  11:	74 46                	je     0x59
  13:	48 89 f3             	mov    %rsi,%rbx
  16:	49 89 fe             	mov    %rdi,%r14
  19:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  20:	fc ff df
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 b8 55 7c fd       	call   0xfd7c55f1
  39:	49 8b 06             	mov    (%r14),%rax
  3c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax


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
