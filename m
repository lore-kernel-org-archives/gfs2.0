Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A58F9EC
	for <gfs2@lists.linux.dev>; Wed,  5 Nov 2025 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318885; cv=none; b=oWN2AhHv2/RzmSAeXrs6h7n+Ey+Ve0eQvh25o8ugYbQhePjFSS9kywK7M7OUwCsvPJvX2YTtgxjHM2amp5Q2NJuEGwYhWt+/+lRIW2jg22QWj2litrmIESIK07HjMWDAf4iLOSgAF4jK2QNgpw9YoJ6ZnJ1Gh023Hjex5sSAv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318885; c=relaxed/simple;
	bh=k/Dfmw0uOqlgaK+NzMQiYIZv+vduY3tm0bqwnXI78NA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NebUvnzlakOVngDI7OLJKKgncZ1cP384NbPoAxG0orwZmAMcD8o0aCVMFfl9dqJrVZ32nq1R+k+tOn6XtpUZjFDz20hrB+9tTVYV9E2Gz2j8V71iq5Vv0HSvnt2z/dw3qMxAfJHN+rROhNzSlEKamVMXNjaWzYzC0ufWnqAR9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-433199c7fb4so47944945ab.3
        for <gfs2@lists.linux.dev>; Tue, 04 Nov 2025 21:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762318883; x=1762923683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ry5XN2qEEjcPMjyP+bh4cCFER2NPVwEWD6SSA3l7k94=;
        b=akGTXx+p1z6q86njHHnpZgU+WYUcRD0RGn4Waq/7hEkuLq9Dkx23h/loZYTnk16QGd
         cHf2CEVfahpQrR/yA1jRTR/fis0PTa8RVHmx5YQJC8p7x0ORoyt1aan6R6s3wue7HWxN
         B1WX6Hn3R172aCu8p+rnFkO516LI8XcYUdxUh3oepGBTTAi62ckg4eYC5uUnqMPDQ/ok
         rpZVvj0Et50PvW2FA6EaUxoeXwzJcTlObb+Fut14Aw1wtVSBrM8zD1TrtX/dzn5xj9B1
         NAXNEG++y93V192ru1hpjEvu1EmXqzAp5uM+pb/i+ckHqrbGJyREUdTVkTzjffDYzTzV
         w/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVM/7+mVnkJZUXEnVfkGhS89MLDlX52363vkOFswQJlv6LWYjg3S1igHvzbt1srk58y8Mc2@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/o16NukJG6FAUsdmNgS02njj2XslWjdIasLaLPryFGtYSi7/X
	Ww5o8TvfgThXI5ONKzactbHjMDE8/JaH/+hKCx/PqnR8RkyNZTLc9wB2CQJWPs9JveiqTxCx28S
	0fcgniJCyyk8ymgMHifl9MsD1jv8ozFaY8yAdQVBm0/KJoJA4F8KEWgVre0E=
X-Google-Smtp-Source: AGHT+IGvsw2Rj7MfwfKMyMLASKMfy8CeHPEcnQfbWg7vEDol1xv9UDcn7YUjmgiAxT/QeKAboN6HeI7qr/pM4VP8Sw2trPRbk2EU
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:431:d8ce:fa1d with SMTP id
 e9e14a558f8ab-4334076997fmr28977145ab.4.1762318883298; Tue, 04 Nov 2025
 21:01:23 -0800 (PST)
Date: Tue, 04 Nov 2025 21:01:23 -0800
In-Reply-To: <68550350.a00a0220.137b3.0032.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ada23.050a0220.baf87.0008.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in __gfs2_glock_put (2)
From: syzbot <syzbot+ef4ad020dc976d178975@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c9cfc122f037 Merge tag 'for-6.18-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1721a17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c42084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11df2114580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c9cfc122.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c3f2cad59d49/vmlinux-c9cfc122.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4cfb61ba836/bzImage-c9cfc122.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d8068067f45/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=104bc012580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef4ad020dc976d178975@syzkaller.appspotmail.com

loop0: rw=12288, sector=18446744073709551608, nr_sectors = 8 limit=32768
gfs2: fsid=syz:syz.s: Error -5 locking journal for spectator mount.
gfs2: fsid=syz:syz.s: G:  s:UN n:2/ffffffffffffffff f:an t:UN d:EX/0 a:0 v:0 r:-128 m:20 p:1
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:274!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5494 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__gfs2_glock_put+0x384/0x3e0 fs/gfs2/glock.c:274
Code: 3f 48 89 de e8 7d 0f ff ff eb 26 e8 b6 38 c3 fd e9 30 fe ff ff e8 ac 38 c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 2d df ff ff 90 <0f> 0b e8 95 38 c3 fd 31 f6 65 ff 0d 8c 02 72 0e 40 0f 94 c5 40 0f
RSP: 0018:ffffc90002a6f408 EFLAGS: 00010246
RAX: 29c52adf4a6b3d00 RBX: ffff88801131cfd8 RCX: ffff8880002c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffc90002a6ecc7 R09: 1ffff9200054dd98
R10: dffffc0000000000 R11: fffff5200054dd99 R12: dffffc0000000000
R13: 1ffff11007cab015 R14: ffff88803e558000 R15: ffff88801131d2c8
FS:  0000555578b1a500(0000) GS:ffff88808d732000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f461a63048 CR3: 00000000126a6000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_glock_put_eventually fs/gfs2/super.c:1183 [inline]
 gfs2_evict_inode+0xae7/0x1000 fs/gfs2/super.c:1458
 evict+0x504/0x9c0 fs/inode.c:810
 gfs2_jindex_free+0x39c/0x440 fs/gfs2/super.c:79
 init_journal+0x8f1/0x2260 fs/gfs2/ops_fstype.c:833
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
 gfs2_fill_super+0x1923/0x20d0 fs/gfs2/ops_fstype.c:1255
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1337
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9033190e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc08e3a548 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc08e3a5d0 RCX: 00007f9033190e6a
RDX: 0000200000000400 RSI: 0000200000012500 RDI: 00007ffc08e3a590
RBP: 0000200000000400 R08: 00007ffc08e3a5d0 R09: 0000000000804444
R10: 0000000000804444 R11: 0000000000000246 R12: 0000200000012500
R13: 00007ffc08e3a590 R14: 0000000000012636 R15: 00002000000004c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__gfs2_glock_put+0x384/0x3e0 fs/gfs2/glock.c:274
Code: 3f 48 89 de e8 7d 0f ff ff eb 26 e8 b6 38 c3 fd e9 30 fe ff ff e8 ac 38 c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 2d df ff ff 90 <0f> 0b e8 95 38 c3 fd 31 f6 65 ff 0d 8c 02 72 0e 40 0f 94 c5 40 0f
RSP: 0018:ffffc90002a6f408 EFLAGS: 00010246
RAX: 29c52adf4a6b3d00 RBX: ffff88801131cfd8 RCX: ffff8880002c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffc90002a6ecc7 R09: 1ffff9200054dd98
R10: dffffc0000000000 R11: fffff5200054dd99 R12: dffffc0000000000
R13: 1ffff11007cab015 R14: ffff88803e558000 R15: ffff88801131d2c8
FS:  0000555578b1a500(0000) GS:ffff88808d732000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd59ca21eb8 CR3: 00000000126a6000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
