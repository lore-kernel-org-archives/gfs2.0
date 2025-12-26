Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC31DC997
	for <gfs2@lists.linux.dev>; Fri, 26 Dec 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766748147; cv=none; b=jQUok4ojfm9azd27av8i2bGNSxhvGpVPG5KLZBUU8PhfZsJ7bh8NGQm5LHkDNbQ0Qq4TiTyj34REk0w2NYqqSc3K0tabMVNpBXaPhreGPcr3zJKfLwBTA8unIK7O1OtoVU6k6CDoRXUAbTklOoacP8/Esjk77TMLV6akmUKlnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766748147; c=relaxed/simple;
	bh=YiDB3Pi18vvDX+SVSqv45uQATxwsD7itiV65Flpy10E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VLvT5ZoDhZsmF/dH3ULMf5TnYRRk8KmCipSIN4faBt6XQ0KBrEOP5EhSa0BcCtZgCoRsVzVad94DiwniDfuqXovAxuuT99m8gEffE5NKBFAP+r72TyZZKGfRFEmAQIiE5oN4QCu+qQt1QVznOLtTngJm6Nl93GlB8sW+hKQQlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656bc3a7ab3so12367610eaf.2
        for <gfs2@lists.linux.dev>; Fri, 26 Dec 2025 03:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766748144; x=1767352944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogVNqnaKtx1T2cvDlNKsgmVLhqC3qTmoRO0AXbCoDG0=;
        b=CGG1/AlzTvdCM2mLvSCPgmKyh0bno7cttnaYujH1+Hb4mRTKQRdTBTERV6A2PmQIPJ
         nsLwXTPXoRanW/b8UlfMqPbw9VgbOvG7AvvfGnI5VvUMG5o3RvGzYpD22jJs7nNQkGBv
         Gi6RFn6vYVkAwrg9eUsLKwriMP9lFXi4O4Ud3EkNrIg/dy9Aaxj/tjX3JrNrsyzUserk
         qDtpMwL4D38+ZP5bYQSSD2Kz2bLI/S0Fq/t1t+Upo8e6rsIx+qClhPS4BrDGzL7gg2jg
         O23aZtQJ1kCY9PaZhdhB0iGWOja5B3t8wS9vnj08FSkge0gPfHc3cU3j7nI+9t9dcO6g
         BenA==
X-Forwarded-Encrypted: i=1; AJvYcCWgISYY2hKB1HxkWws+N3HrDe86J+tm2dTO0g0cAQuASIy++TXVNbc4LPg1S1Zijv6vgknL@lists.linux.dev
X-Gm-Message-State: AOJu0YyYRqd3GHbwREq/Am5oWRpHES/TkYXz0QtSt9BvgTMKKtQvEHYX
	CoIUwEWXZBCOaZBtmSwjxiy7h3wkO3nCpirDEkAEAIDLFwWmGakGRXqRIw6DigkKvyi7sFCDfSV
	x60cJz1lsfk9c1wrUpA+A2qyZSJ2xa/pVThzZw1748uFaHHePHCsEYA6sAhw=
X-Google-Smtp-Source: AGHT+IHlkq8EZIvOjAIOFQE97MrGzUdGQ3wu+1TpJYIsTSfDPaGWKh55WBmSdLLafoR27PfdvuVav711S6wnetn8H+Jkgk998s/3
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:827:b0:659:9a49:8f93 with SMTP id
 006d021491bc7-65d0e9fe02bmr9727546eaf.12.1766748144678; Fri, 26 Dec 2025
 03:22:24 -0800 (PST)
Date: Fri, 26 Dec 2025 03:22:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694e6ff0.050a0220.35954c.0071.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_glock_dq (2)
From: syzbot <syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccd1cdca5cd4 Merge tag 'nfsd-6.19-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1244ebb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ccd1cdca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a642b40c399/vmlinux-ccd1cdca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbe8deda746e/bzImage-ccd1cdca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
loop0: detected capacity change from 32768 to 0
gfs2: fsid=syz:syz.0: Error -5 writing to journal, jid=0
CPU: 0 UID: 0 PID: 5347 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 gfs2_withdraw+0xc3/0x1b0 fs/gfs2/util.c:250
 gfs2_end_log_write+0xcd/0x7c0 fs/gfs2/lops.c:212
 gfs2_log_submit_bio+0x99/0xe0 fs/gfs2/lops.c:247
 gfs2_log_flush+0xb0f/0x24c0 fs/gfs2/log.c:1099
 gfs2_write_inode+0x23f/0x3e0 fs/gfs2/super.c:447
 write_inode fs/fs-writeback.c:1582 [inline]
 __writeback_single_inode+0x7e1/0x1240 fs/fs-writeback.c:1802
 writeback_single_inode+0x493/0xc70 fs/fs-writeback.c:1858
 sync_inode_metadata+0xb9/0x110 fs/fs-writeback.c:2944
 gfs2_fsync+0x1a6/0x370 fs/gfs2/file.c:763
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:213 [inline]
 __do_sys_fdatasync fs/sync.c:223 [inline]
 __se_sys_fdatasync fs/sync.c:221 [inline]
 __x64_sys_fdatasync+0xb9/0x110 fs/sync.c:221
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f871158f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f870d9f5038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007f87117e5fa0 RCX: 00007f871158f7c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f8711613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f87117e6038 R14: 00007f87117e5fa0 R15: 00007ffde92d9398
 </TASK>
gfs2: fsid=syz:syz.0: about to withdraw this file system
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 0 UID: 0 PID: 5347 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 80 d5 35 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000e2f7b68 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b5e25de RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8b5e25de RDI: 0000000000000007
RBP: ffffffff8400f3f0 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1008cd3957 R12: 0000000000000000
R13: 0000000000000038 R14: 0000000000000038 R15: 0000000000000001
FS:  00007f870d9f56c0(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565502ea78c0 CR3: 0000000011bc9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:572
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 gfs2_glock_dq+0x50/0x7c0 fs/gfs2/glock.c:1577
 gfs2_glock_dq_uninit+0x25/0xb0 fs/gfs2/glock.c:1623
 gfs2_seek_data+0x16c/0x240 fs/gfs2/inode.c:2218
 gfs2_llseek+0x1a4/0x240 fs/gfs2/file.c:75
 vfs_llseek fs/read_write.c:389 [inline]
 ksys_lseek fs/read_write.c:402 [inline]
 __do_sys_lseek fs/read_write.c:412 [inline]
 __se_sys_lseek fs/read_write.c:410 [inline]
 __x64_sys_lseek+0x14f/0x1e0 fs/read_write.c:410
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f871158f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f870d9f5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007f87117e5fa0 RCX: 00007f871158f7c9
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f8711613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f87117e6038 R14: 00007f87117e5fa0 R15: 00007ffde92d9398
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 80 d5 35 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000e2f7b68 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8b5e25de RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8b5e25de RDI: 0000000000000007
RBP: ffffffff8400f3f0 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1008cd3957 R12: 0000000000000000
R13: 0000000000000038 R14: 0000000000000038 R15: 0000000000000001
FS:  00007f870d9f56c0(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565502ea78c0 CR3: 0000000011bc9000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	e9 80 d5 35 09       	jmp    0x935d5b8
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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
