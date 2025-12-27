Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5341EB9F2
	for <gfs2@lists.linux.dev>; Sat, 27 Dec 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766833043; cv=none; b=ppmh6GIOPi0CGJzC7pjafF9RaNI90hhxqKhuGtGRNk4KYv6lUroLIJtrucXE6ZJNeKNS0bRGPwwwU4BiuVlXUL0CNI1+rPobYt0W6q8+0Z3gmP/NBW90BdOqd9uvCnxClnpewiU+yy7axg9B115ujNiwowu6bQ371Ii0ENvKFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766833043; c=relaxed/simple;
	bh=rhTQZ8vxq6jVhKHebvT16f5m7YIFue4TUDOLrxr5FNo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cLkosJvaLd4YFL1uhu9hPSg95Rp29WRXELIQMe9i0sjdyZNsMSbLmhzH51j0Ky+q8x1nPPdBHXbBQ32+JYmvU1IUSnTTJlbNi0gABuwyWpey5KeL1q9mX6XbPw9gMEd/pmc/G2pDA721uI5/L6zsBD25550MInLGICaF7F3OxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65eb49dd974so7494315eaf.1
        for <gfs2@lists.linux.dev>; Sat, 27 Dec 2025 02:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766833041; x=1767437841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddCccnQZPB/IsHqHveb8GoQBrKt86g09I97g6eGRJIE=;
        b=jPW0lufLic1WdT17W5ZnFJouUrf3zhYAoifupkp98GxBUkeMxw2BJzH4v6Nh5UFZc+
         HC0uczeMLQX4kA2ZiSmNTDhcQ7REYtqogcZt9BXf/jnxj5hBz64hte5AutO6EaJMqKIL
         3jomHCL7VBjfRfhRoWR9R/6Xuq+j4LluRkUXN/4qu20mXpt8LI0PhA3O/SYiFnKuMv44
         CGKA/q3BDsiyoDyKp8FhtnRbOf1AxYtVouu9BXaQWbbJR7eY08QDP4CFLIdp/MQqnhBL
         DKB5Ax/qWUwxYaOVhsrQ083/PHgpVQ47BpOGDSqOAq8jJ6YpJWxlum90dYl4R8WTrndP
         p/LA==
X-Forwarded-Encrypted: i=1; AJvYcCXkKIDiO43BddOtpTjvyQWUaScBNzE5h+L0e/7ZlJzK1BO/8Ev4GL8xN23PBvRX20mVtIWF@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb4DXPfAdp17NQExpwpySqmFcihlJ17e+/KhKWHXE9AFgwOjdZ
	IaJyV4jmpgglJ6hiO/KsmMeEtGbCRJOs8hv6gMbtRA4w7I2Y4faS9XBHEvIQSMzn/Gv9acuhu2q
	Fn8aGIIFjYa5KYsP0NSsIdrIiz11MCu4AbauOn9EuEKyuA39U1Y/oLocCK84=
X-Google-Smtp-Source: AGHT+IHiVyY1c/d3RCTIoZDEgt7T6m2cqR6ccFEaSb0YMyWtooHjP93VvGRSLBfDxrAD8QZtgaJzTgJ/x9VZLdFz+FcHkRwa9Idy
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2c0a:b0:659:a8f3:e10f with SMTP id
 006d021491bc7-65cfe770b7cmr10151415eaf.31.1766833041118; Sat, 27 Dec 2025
 02:57:21 -0800 (PST)
Date: Sat, 27 Dec 2025 02:57:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694fbb91.050a0220.35954c.008e.GAE@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_unpin
From: syzbot <syzbot+0c5024a57ccf4017c187@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1681cd84580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c5024a57ccf4017c187
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b9275466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16f89c42bab9/vmlinux-b9275466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54c5ab9b0ef0/bzImage-b9275466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c5024a57ccf4017c187@syzkaller.appspotmail.com

syz.0.0: attempt to access beyond end of device
loop0: rw=8390657, sector=68719479344, nr_sectors = 8 limit=32768
Buffer I/O error on dev loop0, logical block 8589934918, lost async page write
------------[ cut here ]------------
kernel BUG at fs/gfs2/lops.c:107!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5355 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_unpin+0x9ac/0x9c0 fs/gfs2/lops.c:107
Code: fe e9 24 fb ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 52 fb ff ff 4c 89 e7 e8 cf a6 25 fe e9 45 fb ff ff e8 25 fb bd fd 90 <0f> 0b e8 1d fb bd fd 90 0f 0b e8 15 fb bd fd 90 0f 0b 66 90 90 90
RSP: 0018:ffffc9000ae771b0 EFLAGS: 00010293
RAX: ffffffff840309fb RBX: ffff8880458af000 RCX: ffff88801f9e8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff11008b15e09 R08: ffff8880548e3917 R09: 1ffff1100a91c722
R10: dffffc0000000000 R11: ffffed100a91c723 R12: dffffc0000000000
R13: ffff8880458ae230 R14: ffff8880548e3910 R15: ffff888000e30000
FS:  00007fc9591536c0(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000010f15000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 databuf_lo_after_commit+0x15e/0x1b0 fs/gfs2/lops.c:1077
 lops_after_commit fs/gfs2/lops.h:51 [inline]
 gfs2_log_flush+0xf60/0x24c0 fs/gfs2/log.c:1110
 gfs2_jdata_writepages+0xf9/0x150 fs/gfs2/aops.c:370
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 filemap_write_and_wait_range+0x21f/0x320 mm/filemap.c:684
 filemap_write_and_wait include/linux/pagemap.h:65 [inline]
 iomap_bmap+0x1a6/0x3c0 fs/iomap/fiemap.c:106
 gfs2_bmap+0x171/0x200 fs/gfs2/aops.c:573
 bmap+0xac/0xe0 fs/inode.c:2040
 ioctl_fibmap fs/ioctl.c:76 [inline]
 file_ioctl+0x41d/0x780 fs/ioctl.c:326
 do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
 __do_sys_ioctl fs/ioctl.c:595 [inline]
 __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc95838f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc959153038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc9585e6180 RCX: 00007fc95838f7c9
RDX: 0000200000000280 RSI: 0000000000000001 RDI: 0000000000000008
RBP: 00007fc958413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc9585e6218 R14: 00007fc9585e6180 R15: 00007ffede3a3fa8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_unpin+0x9ac/0x9c0 fs/gfs2/lops.c:107
Code: fe e9 24 fb ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 52 fb ff ff 4c 89 e7 e8 cf a6 25 fe e9 45 fb ff ff e8 25 fb bd fd 90 <0f> 0b e8 1d fb bd fd 90 0f 0b e8 15 fb bd fd 90 0f 0b 66 90 90 90
RSP: 0018:ffffc9000ae771b0 EFLAGS: 00010293
RAX: ffffffff840309fb RBX: ffff8880458af000 RCX: ffff88801f9e8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff11008b15e09 R08: ffff8880548e3917 R09: 1ffff1100a91c722
R10: dffffc0000000000 R11: ffffed100a91c723 R12: dffffc0000000000
R13: ffff8880458ae230 R14: ffff8880548e3910 R15: ffff888000e30000
FS:  00007fc9591536c0(0000) GS:ffff88808d416000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000010f15000 CR4: 0000000000352ef0


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
