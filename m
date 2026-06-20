Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDC4A32
	for <gfs2@lists.linux.dev>; Sat, 20 Jun 2026 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934258; cv=none; b=k/pwi9Hwa8B5+LKDGCUca/rfB2mMBudcFD8bCYH6g/6R4UREiIU9tczxdX/9ddnqlUoQbC6iYLhshED0gWe6bSs+uoiwPAG52QAjz2Azlkw0bu3smSLTGJ5CnyUs99zHtFBw+KHvYIKtlhxe+8V/8JdQ+qnH0mtPPeSOWvp+sI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934258; c=relaxed/simple;
	bh=Q5wkh/JNfxQjkYOMqy60RzKXwdNMboXXHG7qb1q9D8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HMxdvAFDVsWnhFBfMbKMlcpcd4+DCP3pEASVv8SYlNcGzN5zgetfCcrqOXv9hEs97qisloUR/A5nuy/bEMlPo7+eTVZy4XWWHGUfGNPMQsTHC/MztjHXL1UHUxJTg+orD4GQtrONz2ZFl9Y1HbcOncndYbvY/vbEHFCXA0OHuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-48952d1c293so5225586b6e.3
        for <gfs2@lists.linux.dev>; Fri, 19 Jun 2026 22:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781934256; x=1782539056;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y43eojcAvEHAn0hv4KTVYoiHlgtkQWpJmn00zqArVqM=;
        b=e9FqFBeShhZ3W9EQyYy5i1pf2mLODhae2R8ZhuktVmaZmyf/ovRBTrDskMNgCGFAD2
         ShrlIu+0iIZn3zObgzmFzxq73XE0j7+wyTLxlwmuTel/H9/MrBqTw046ogms3yhRxrs7
         OQJMWIxcmNt/UkkJgHi5B447NUrqD+1pQC4bsm0dMPHRZKuShIhtdT/oz7rqdyAyoUiu
         XMOUIe0n6Jka3MPX+Gp1clVpL4vMKrZW58X908YjgcjXRGR82vB7u1gczRsLZfU81pSZ
         o0zF51ES+Y404BSnasnHY29KgivGxCWvwiGb738FIsTCP9XWprpSrRb0sk2sAsdnFsnp
         4qDg==
X-Forwarded-Encrypted: i=1; AFNElJ+NcWmZkPVZTwjrgx7WPheI6MoCSAjPmc0CnTdsanJ+gKJwiujsUnRC6ncNPie4xz68qlOz@lists.linux.dev
X-Gm-Message-State: AOJu0YzaMadqlRA2oaUjl7+RViutorfLnQA3il+XjNyBnOtfEgyoVPDW
	fdgznAq0fpFYVBEATvI84Eq6yzGWa87Snr6lXnxjbooajodlh4hdBKvTB2lRpUyvYgkNVwPAJJi
	MqA2hV7QwdPSfdGmt8JjlB+Mmka+oO65CQgDQJFPMkowdF9pM/oatZ45TtL4=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f93:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-48abe716442mr2014295b6e.7.1781934255988; Fri, 19 Jun 2026
 22:44:15 -0700 (PDT)
Date: Fri, 19 Jun 2026 22:44:15 -0700
In-Reply-To: <694e6ff0.050a0220.35954c.0071.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3628af.0a659fcc.10d66d.0000.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_glock_dq (2)
From: syzbot <syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a975094bf98c Merge tag 'exfat-for-7.2-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157bc2ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5fece1a9477c321
dashboard link: https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1391e566580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e34d56580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a975094b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c6e219ebae0/vmlinux-a975094b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ee0600dd547/bzImage-a975094b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b036c6932e75/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12d95b7a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4deac15fac R14: 00007f4deac15fa0 R15: 00007f4deac15fa0
 </TASK>
gfs2: fsid=syz:syz.0: about to withdraw this file system
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 UID: 0 PID: 5476 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x73/0x2f0 kernel/locking/spinlock_debug.c:115
Code: c7 44 24 30 d0 83 a2 81 4c 8d 64 24 20 49 c1 ec 03 48 b8 f1 f1 f1 f1 f8 f3 f3 f3 49 89 04 14 4c 8d 77 04 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 f3 01 00 00 41 8b 06 3d ad 4e ad de 0f 85
RSP: 0018:ffffc90003797a80 EFLAGS: 00010203
RAX: 0000000000000004 RBX: 0000000000000020 RCX: 0000000080000002
RDX: dffffc0000000000 RSI: ffffffff8c296400 RDI: 0000000000000020
RBP: ffffc90003797b30 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1007fdb805 R12: 1ffff920006f2f54
R13: 0000000000000000 R14: 0000000000000024 R15: dffffc0000000000
FS:  0000555585a45500(0000) GS:ffff88808c848000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000006cb000 CR3: 000000003e1b2000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 spin_lock include/linux/spinlock.h:342 [inline]
 gfs2_glock_dq+0xbe/0xb40 fs/gfs2/glock.c:1598
 gfs2_glock_dq_uninit+0x25/0xb0 fs/gfs2/glock.c:1656
 gfs2_seek_data+0x176/0x250 fs/gfs2/inode.c:2246
 gfs2_llseek+0x1c1/0x270 fs/gfs2/file.c:75
 vfs_llseek fs/read_write.c:391 [inline]
 ksys_lseek fs/read_write.c:404 [inline]
 __do_sys_lseek fs/read_write.c:414 [inline]
 __se_sys_lseek fs/read_write.c:412 [inline]
 __x64_sys_lseek+0x14f/0x1e0 fs/read_write.c:412
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4dea99ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2c1b0b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007f4deac15fa0 RCX: 00007f4dea99ce59
RDX: 0000000000000003 RSI: 0000000000000006 RDI: 0000000000000005
RBP: 00007f4deaa32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4deac15fac R14: 00007f4deac15fa0 R15: 00007f4deac15fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x73/0x2f0 kernel/locking/spinlock_debug.c:115
Code: c7 44 24 30 d0 83 a2 81 4c 8d 64 24 20 49 c1 ec 03 48 b8 f1 f1 f1 f1 f8 f3 f3 f3 49 89 04 14 4c 8d 77 04 4c 89 f0 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 f3 01 00 00 41 8b 06 3d ad 4e ad de 0f 85
RSP: 0018:ffffc90003797a80 EFLAGS: 00010203
RAX: 0000000000000004 RBX: 0000000000000020 RCX: 0000000080000002
RDX: dffffc0000000000 RSI: ffffffff8c296400 RDI: 0000000000000020
RBP: ffffc90003797b30 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1007fdb805 R12: 1ffff920006f2f54
R13: 0000000000000000 R14: 0000000000000024 R15: dffffc0000000000
FS:  0000555585a45500(0000) GS:ffff88808c848000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000006cb000 CR3: 000000003e1b2000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c7 44 24 30 d0 83 a2 	movl   $0x81a283d0,0x30(%rsp)
   7:	81
   8:	4c 8d 64 24 20       	lea    0x20(%rsp),%r12
   d:	49 c1 ec 03          	shr    $0x3,%r12
  11:	48 b8 f1 f1 f1 f1 f8 	movabs $0xf3f3f3f8f1f1f1f1,%rax
  18:	f3 f3 f3
  1b:	49 89 04 14          	mov    %rax,(%r12,%rdx,1)
  1f:	4c 8d 77 04          	lea    0x4(%rdi),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 f3 01 00 00    	jne    0x229
  36:	41 8b 06             	mov    (%r14),%eax
  39:	3d ad 4e ad de       	cmp    $0xdead4ead,%eax
  3e:	0f                   	.byte 0xf
  3f:	85                   	.byte 0x85


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
