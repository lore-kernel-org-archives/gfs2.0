Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4439768D
	for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366711; cv=none; b=CpmR0SfDQdVkAlUjKQIwVmr2HP6MZN+WFueYC0mFh8BPMvRdyuS0QMOGAgiPOQsqr96OzllQC46ue8ifC4ipWiszQAklqeRTdtDz/n6AjybVhmgoCpwFgyfUmBJby7O3YHVvX59t6T0TV4pIaZk20Z3vOvad8j+LWBFerGUfbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366711; c=relaxed/simple;
	bh=pIHlDQffJFrSx3puxqpbkeFdXRRUpFlmIa8EKzIC9pM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b9XHkcz5oxrQSuYoghaVM2pI8zZ720cehh25JDGJPdYLSBhQDra9wwnC1Py12cMZX/0K/L1D9GsPrV8RFsAJWcpG2HFoU+RkNMxEyb1sf584UjUr4k/vQJIyaJyzaan6i3yp8Q6J4VS5AtCn1KIG9LPBQ1X/VgqtKvbkeIT9IG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d7c5b6c1c6so7625880a34.3
        for <gfs2@lists.linux.dev>; Tue, 24 Mar 2026 08:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366709; x=1774971509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aaI9Nm5qCaJrACnN/GbjUZVpW2we1CPyX2jy49udH/A=;
        b=IQ0GtXJrrVZSMVThKCBJl+B+QQSxfdDVc/pCADYoKfkxcmKvygdJAsDJ3y2yHmHggC
         pXVM1xKSbEKNo0uiGsJXa/tA0hyhzlUmV9EXHYKuFPOKAUt2l+JKbElQPS/ynubYIBeH
         wf1wNhIECUJButVTVj84eXqzDe1xt6R1VEZ8Ci2A+1sftGHNpI+xLjs9lnyz38NhpxQ3
         zJyX5xSBMXM9nzOhUuWoK3prwfYiQuyO5Hf6VX2NS1O8HKbNBbaHKQYWugK9Nldh0P27
         1SM7n48Hb8e7IWA+I0tga86nxfD7oVtQXkfiRF+5hRgizJDN9fjno6fPAcGU5Gt88CJ9
         JAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1E5Q3r+y0Lw2cPZYjnN+ZKFQPDBP2lqCCrhbNHtu8ZmyuZVZ8+kF/U85ad5mHdkC9Xm/G@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw80LJVO1kT9tIMissXW7zOEmZqMb3iUaECtf2JIdH9kQMQBEW
	3ERdX8l0X8L1q4zY0lxOA6ycZo9f0P4ZOyzLMYaRxdZ5oSRP//b7rnc7Lb64fS5CJvupZTHBxjO
	QghzT+p+F+s214BlDQ8Pnq7kChlJISKkTVYKOLqu21F8uOQiDMVmdGLfDPKA=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f00a:b0:67c:25b9:d366 with SMTP id
 006d021491bc7-67dff5141ddmr118503eaf.42.1774366708977; Tue, 24 Mar 2026
 08:38:28 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c2aff4.050a0220.3bf4de.00b3.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in gfs2_fill_super
From: syzbot <syzbot+b441db1854c360b83221@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09c0f7f1bcdb Add linux-next specific files for 20260323
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142ade02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0c30527ccbcb0f2
dashboard link: https://syzkaller.appspot.com/bug?extid=b441db1854c360b83221
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145e16da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b33b52580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c320a7a1bc69/disk-09c0f7f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a5b231960d2/vmlinux-09c0f7f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e2b84b9674d/bzImage-09c0f7f1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a4941369e2d2/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=170daa06580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b441db1854c360b83221@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 32768
------------[ cut here ]------------
kmem_cache of name 'gfs2-bufdata/syz:syz' already exists
WARNING: mm/slab_common.c:112 at kmem_cache_sanity_check mm/slab_common.c:111 [inline], CPU#1: syz.4.21/6090
WARNING: mm/slab_common.c:112 at __kmem_cache_create_args+0xac/0x440 mm/slab_common.c:352, CPU#1: syz.4.21/6090
Modules linked in:
CPU: 1 UID: 0 PID: 6090 Comm: syz.4.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:111 [inline]
RIP: 0010:__kmem_cache_create_args+0xaf/0x440 mm/slab_common.c:352
Code: 86 8e 4d 8b 24 24 49 81 fc 18 68 86 8e 74 20 49 8b 7c 24 f8 48 89 de e8 3f 5c 9c 09 85 c0 75 e2 48 8d 3d 54 70 06 0e 48 89 de <67> 48 0f b9 3a 48 89 df be 20 00 00 00 e8 df 5d 9c 09 48 85 c0 0f
RSP: 0018:ffffc900025f7948 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88807ac1dac0 RCX: 0000000000000005
RDX: 000000007ac1da04 RSI: ffff88807ac1dac0 RDI: ffffffff9016e0b0
RBP: 0000000000000000 R08: ffffffff901246f7 R09: 1ffffffff20248de
R10: dffffc0000000000 R11: fffffbfff20248df R12: ffff8881442f37e0
R13: ffff88807caa0000 R14: 0000000000000050 R15: ffffc900025f7a60
FS:  000055555c597500(0000) GS:ffff888125548000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fefd604b544 CR3: 0000000035aa2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kmem_cache_create include/linux/slab.h:390 [inline]
 gfs2_fill_super+0x13a4/0x21d0 fs/gfs2/ops_fstype.c:1202
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1342
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
RIP: 0033:0x7fefd5f9da0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff558aaf78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff558ab000 RCX: 00007fefd5f9da0a
RDX: 00002000000124c0 RSI: 0000200000012500 RDI: 00007fff558aafc0
RBP: 00002000000124c0 R08: 00007fff558ab000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000012500
R13: 00007fff558aafc0 R14: 00000000000125c7 R15: 0000200000000180
 </TASK>
----------------
Code disassembly (best guess):
   0:	86 8e 4d 8b 24 24    	xchg   %cl,0x24248b4d(%rsi)
   6:	49 81 fc 18 68 86 8e 	cmp    $0xffffffff8e866818,%r12
   d:	74 20                	je     0x2f
   f:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
  14:	48 89 de             	mov    %rbx,%rsi
  17:	e8 3f 5c 9c 09       	call   0x99c5c5b
  1c:	85 c0                	test   %eax,%eax
  1e:	75 e2                	jne    0x2
  20:	48 8d 3d 54 70 06 0e 	lea    0xe067054(%rip),%rdi        # 0xe06707b
  27:	48 89 de             	mov    %rbx,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	be 20 00 00 00       	mov    $0x20,%esi
  37:	e8 df 5d 9c 09       	call   0x99c5e1b
  3c:	48 85 c0             	test   %rax,%rax
  3f:	0f                   	.byte 0xf


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
