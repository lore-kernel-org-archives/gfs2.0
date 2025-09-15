Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09F27A916
	for <gfs2@lists.linux.dev>; Mon, 15 Sep 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960311; cv=none; b=DCXENkWS93Ec/7WKlcy/H9BmPxW7/jlypA35KzULNFj7ObP5XidnEnrKpEse3zqUEsUYAIkzla8n6AY+IKLXBeU6Hn9sksZheS701i6aJsgsYYtSBT3kdT3+tYsCPjZJAjk+5xQBhG5CIFSa1Lx7l9qeYe8f19jNAcgLtpJmCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960311; c=relaxed/simple;
	bh=dvvXgzda8/966QcSfE46n1CFowAGbmr/81C9Zlq+wJU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kiepWDCx/11EhwwN5z47JpYEAsPCAVDAHtjDKqvBXbwSgQgwJb0vhwuYWttMELbzHkjhEiTztMhSuNafqhRxhkOZdcUJre50R34tBheq6s4cXUEGRnRy1uA382L8V7wu9pfUyK+upyg++3zH9dvrmkCar3ezg5v8GauGz5Nj1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42407a5686fso12779885ab.3
        for <gfs2@lists.linux.dev>; Mon, 15 Sep 2025 11:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960308; x=1758565108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdzrSAGu5HM6xTHKOz6og3u2f7HNh3yqow9C+qW9Vjw=;
        b=Qhuwt32s+otxO3kHiKiYG1xMjraqYl6vTubsgTyNhh4839W/C15ua/Ub96XMQJHg7m
         A6Ku0iJK9FA01NxlP4fmI8PQziTr3fMRvje5poe1FMwAnkYmGFveoVocHo97TejTiDUv
         DSQU8xrKfcE56f2GdaCTe4vDtMVIh+Bo8bLYdg6MhROut3k3woXGjtoum3eWyW860tY9
         WLqv+9U81uzvS/XpfLVA5JvEpDltvi6KV0jAVFPtTcfsZOcNQ2I92oBgp2NW5FDpBLgh
         X6p3bI8sXgo4qTUfDLuibjHonZKj+c/f9D9Sooqx4ieLA3G6R5OqVa+qyZpmQTJOxeo/
         aOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMF0qhJvI0Fx72IQrHU7qfyoGHyHz3Mb8a6p3uQKgDBFodxUpAG11oQVmacNqMGiYQ9uii@lists.linux.dev
X-Gm-Message-State: AOJu0YxD3CyCAmSVPzgpa3GZeqROEJ4avoORoLqh/BAy8KVTe/3cB03v
	N/YbsCHAH07ZIi7rA4yqaLMpbQ2E+ysURO4xlIR9TWh4lnI7AHeCM5Uruh3AdYISgvpNEnKGD71
	pJyu3Zr3gIIn65WclFaGdQQ6xoEOuiEMYtW8KLf3dOjOsft6qnCMQY2NWIjM=
X-Google-Smtp-Source: AGHT+IEYU6u90qWRP4xzwwfwq8GXq6WwIw0fatuYLLw+Dg88ARWf3lluvX0AH8s4qVDyGfm+zJH6aj1tg2aRRCze3IniLjS2j8yR
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:412:fa25:dd4e with SMTP id
 e9e14a558f8ab-4209d40ff57mr128806675ab.1.1757960308564; Mon, 15 Sep 2025
 11:18:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:18:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c85874.050a0220.50883.0017.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_print_dbg (3)
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    590b221ed425 Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143eb642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111f9b62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17888b62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63a963fc26db/disk-590b221e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c2013d30830/vmlinux-590b221e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ee4d3a8e8f6/bzImage-590b221e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/37ba65492173/mount_4.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14a23934580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe7697c1115925d6c: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x3b4c0088ac92eb60-0x3b4c0088ac92eb67]
CPU: 1 UID: 0 PID: 6163 Comm: syz.0.38 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:string_nocheck lib/vsprintf.c:653 [inline]
RIP: 0010:string+0x1bb/0x2b0 lib/vsprintf.c:735
Code: 15 a5 f6 eb b3 41 c1 fd 10 4c 89 6c 24 10 49 8d 5d ff 45 31 ed 4b 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 60 4b 8d 2c 2e 47 0f b6 3c 2c 31 ff 44 89 fe
RSP: 0018:ffffc9000383ef00 EFLAGS: 00010007
RAX: 0769801115925d6c RBX: 00000000fffffffe RCX: dffffc0000000000
RDX: ffff88802a435ac0 RSI: 00000000ffff0a00 RDI: 3b4c0088ac92eb67
RBP: ffffffff8bf0acfe R08: ffff88802a435ac0 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000000 R12: 3b4c0088ac92eb67
R13: 0000000000000000 R14: ffffc9000383f319 R15: 0000000000000030
FS:  00007fde6f5cd6c0(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f425685d000 CR3: 000000007d39e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vsnprintf+0x739/0xf00 lib/vsprintf.c:2926
 va_format lib/vsprintf.c:1728 [inline]
 pointer+0x940/0x1190 lib/vsprintf.c:2548
 vsnprintf+0x60f/0xf00 lib/vsprintf.c:2930
 vprintk_store+0x3c7/0xd00 kernel/printk/printk.c:2252
 vprintk_emit+0x15f/0x590 kernel/printk/printk.c:2399
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 gfs2_print_dbg+0x19a/0x1b0 fs/gfs2/glock.c:1444
 dump_holder fs/gfs2/glock.c:2287 [inline]
 gfs2_dump_glock+0x152d/0x1bc0 fs/gfs2/glock.c:2398
 gfs2_consist_inode_i+0xf5/0x110 fs/gfs2/util.c:446
 gfs2_dirent_scan+0x545/0x690 fs/gfs2/dir.c:-1
 gfs2_dir_read+0x804/0x16f0 fs/gfs2/dir.c:1600
 gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
 iterate_dir+0x399/0x570 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde6e78eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde6f5cd038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fde6e9d6090 RCX: 00007fde6e78eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fde6e811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fde6e9d6128 R14: 00007fde6e9d6090 R15: 00007ffeeef80a98
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:string_nocheck lib/vsprintf.c:653 [inline]
RIP: 0010:string+0x1bb/0x2b0 lib/vsprintf.c:735
Code: 15 a5 f6 eb b3 41 c1 fd 10 4c 89 6c 24 10 49 8d 5d ff 45 31 ed 4b 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 60 4b 8d 2c 2e 47 0f b6 3c 2c 31 ff 44 89 fe
RSP: 0018:ffffc9000383ef00 EFLAGS: 00010007
RAX: 0769801115925d6c RBX: 00000000fffffffe RCX: dffffc0000000000
RDX: ffff88802a435ac0 RSI: 00000000ffff0a00 RDI: 3b4c0088ac92eb67
RBP: ffffffff8bf0acfe R08: ffff88802a435ac0 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000000 R12: 3b4c0088ac92eb67
R13: 0000000000000000 R14: ffffc9000383f319 R15: 0000000000000030
FS:  00007fde6f5cd6c0(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f425685d000 CR3: 000000007d39e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	15 a5 f6 eb b3       	adc    $0xb3ebf6a5,%eax
   5:	41 c1 fd 10          	sar    $0x10,%r13d
   9:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
   e:	49 8d 5d ff          	lea    -0x1(%r13),%rbx
  12:	45 31 ed             	xor    %r13d,%r13d
  15:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 60                	jne    0x92
  32:	4b 8d 2c 2e          	lea    (%r14,%r13,1),%rbp
  36:	47 0f b6 3c 2c       	movzbl (%r12,%r13,1),%r15d
  3b:	31 ff                	xor    %edi,%edi
  3d:	44 89 fe             	mov    %r15d,%esi


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
