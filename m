Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9862276049
	for <gfs2@lists.linux.dev>; Fri,  7 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500630; cv=none; b=EMN0V8eZeZq3B0J0U8NQyl0K5I3po81DHOOlhA2CS7lwd6JG/Yg53wsZLkDkLpQYE/pAkRyI3pCJOYquojmvp44PokkhDR7EYKj3/+CaHg8UCac2TUejc+3CeElIdN1/DHLJKCpAL3zPhAf6b+zNh7+Vz2jhYAoDjZLq6z2d3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500630; c=relaxed/simple;
	bh=UAl14U6B5q+JxSbC6zOGXXeST/5imgK01d1/ubbPwLg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GOCWGXORHVCTw8vkNx+u9LLjSVyCBAndGu60NVNeTHM9gyd1GeHQppnWGFZleXa6ynKTB1fnyvZw5wYya51k9cxCd5volipPRT6bi8J+O5tIat86LzdzO6seyVscpDhcZNRqzbN+DAteUPZcYd6szZuxu3wmeWaKd7Wsq/NpQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-433270dad0dso4451225ab.0
        for <gfs2@lists.linux.dev>; Thu, 06 Nov 2025 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500628; x=1763105428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heKd22WotK6iLCFnkpjRxex8mc4gSmHavY8BDrJ+pOM=;
        b=Sh08081k9OOs7wLnynBH6PzMsJmRadGF4boBr7ch/iL0760Dvy1ycGuD5i+U1ZSVan
         wDPgCSpQtURwfTOy4Aps7PbePs0hBpSaJoryQsEur1t0v5joebWa5cnI4o0Uhink9v9f
         BdFigWptz34nJ9s+XdLTfAeQV8EzgaMlrpIDftT9xDlS8xb0EBMTZynJxNI6HLv5iTwk
         MhLN7rLaShk4VV3q8k9MO/iMPGF3eOJfwCsOHj/LmomJ9DLhh8TdPWPetko63hpqYTZg
         oLCsu5R2Nv7K8PcNqA3oXNOGHJ+/u0GvsJRShLB03VWP0vCmLGPnHHnDii08Hb5lRiEm
         fykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKh1rDk54UnkDD5TCmrPv5HrxTUrF/W7aLaGij4q7XZZ541a9zFFrYGAYjDh8PJMwZtNvo@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7i8QvBs3vOfrWcPqIWXmvt15P1WviWolB2p15c7I0pzz5asmp
	YgLWUX81PIfiU6ZkFwWGz9OjGGGCKK5OpMGu7MU/ZaG3560sI/okXUSuV5yetuj0HEIK2XMaaQo
	+DzNe8qUbw7loaoMlC0B37mm4PumlASqoXLIKRTZ6iCziTwr2qmtC9gMGZf8=
X-Google-Smtp-Source: AGHT+IGhJ0q+jJIYSQuGSW5DTUmmUPhYBkaKKYwmwYvagBVwQ1SuE9hq+G1NX+r8i3arXD8hVFdOjr4kCMOoV5/BRIlEkuigt3YZ
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2282:b0:433:3060:f5b with SMTP id
 e9e14a558f8ab-43362a19bc9mr8881485ab.12.1762500627906; Thu, 06 Nov 2025
 23:30:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:30:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da013.a70a0220.22f260.0025.GAE@google.com>
Subject: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
From: syzbot <syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a39084580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba84f14f62e61a5fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171a7812580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1375dbcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0451ba3fe41/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e8c67119ab/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8e176e5054/bzImage-c2c2ccfd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1af9667b349a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=131a7812580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888126cf1000 (size 144):
  comm "syz.2.26", pid 6030, jiffies 4294942626
  hex dump (first 32 bytes):
    c0 ef 59 82 ff ff ff ff 05 00 00 00 db 1a 00 00  ..Y.............
    0b 00 00 00 00 00 00 00 06 00 00 00 00 00 00 00  ................
  backtrace (crc f56b339f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5287
    gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
    alloc_dinode fs/gfs2/inode.c:418 [inline]
    gfs2_create_inode+0xca0/0x1890 fs/gfs2/inode.c:807
    gfs2_atomic_open+0x98/0x190 fs/gfs2/inode.c:1387
    atomic_open fs/namei.c:3656 [inline]
    lookup_open fs/namei.c:3767 [inline]
    open_last_lookups fs/namei.c:3895 [inline]
    path_openat+0x13ef/0x1eb0 fs/namei.c:4131
    do_filp_open+0x102/0x1f0 fs/namei.c:4161
    do_sys_openat2+0xc1/0x140 fs/open.c:1437
    do_sys_open fs/open.c:1452 [inline]
    __do_sys_openat fs/open.c:1468 [inline]
    __se_sys_openat fs/open.c:1463 [inline]
    __x64_sys_openat+0xb2/0x100 fs/open.c:1463
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
