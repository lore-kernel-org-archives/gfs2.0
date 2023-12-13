Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F516C8E7
	for <gfs2@lists.linux.dev>; Wed, 13 Dec 2023 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dquEkPq0"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b88f2a37deso5182426b6e.0
        for <gfs2@lists.linux.dev>; Tue, 12 Dec 2023 22:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702449370; x=1703054170; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kcmFWfftq2G2Pe8r2jvIeDmGVCfNhd3HCerTRPIks3k=;
        b=dquEkPq0KB9ohU8AKfv+1jxayUAPI7g6JhjGkNlqdScb5gNOW9Zt0B+LZRQFTEEMCA
         EOaGfvF4U7cYquYbDhXjKNrbTGJuaYRXWFhfUJi2pOOS6FUGiStUoGj4BBA3NOXX5OFA
         SZyucPOglpBgmFgatlkubZlRmV9pEAdAs7ItRFlFPtoVnZplVQGc4wH8GGXJKtLuKUrG
         1/YlzLr3asIxEZuES3EHMw15Y3s3tCo/z5ac5KOoJfKo9tp2ogK+e3++5u7tcozL+B9B
         jzbWGRGbiHeZysSOtO5HOL+bXf2g4e85R0bozGqIHI82rhnkULEmoK2mrhMwp+28cvzN
         UDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702449370; x=1703054170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcmFWfftq2G2Pe8r2jvIeDmGVCfNhd3HCerTRPIks3k=;
        b=VAjtNNH36V47WkCpKBrw+gQ9dL1Cx0wwtCB0hb1ynmuoYua9S87rAGPuqe74+fTZHD
         eVtVyRvbOKT0KM3+O1/FXijkq0FS3oi2IyxX/EmNGc4rx2WzMZhD/Dkk8hh18hskWkd8
         anqmjbds3yz1b/giCbr9ZtC3qCTRyg0/K2HvERpRmRCGTt2xRk4imToDEg6yJ8KAf/fM
         JzthRCuzdL9i+vikGficjh4oEB19rrXeuRjXX7TsuqEu4qY66HUKhj4wfj8RI/I89Hob
         I669m3sfOg5FTP27dxL8jGUSdjjtwzbgC3nCSoOxBDjNjlsglAk2efXKkwQ6ZbjOtCpE
         aX0w==
X-Gm-Message-State: AOJu0YzaYoyhHev0zJOrDn5cvvCJs0sPjGQhyfPzlaiox475K9vvE8Ec
	UDH2MxWqL2BLQowxVSnBGe5PTXlNthQAStF4ZP4=
X-Google-Smtp-Source: AGHT+IGt0rw2dSwB6cz4IETPSpNy/wIiv8FLtWZOOgCFCgAlDlmlV89gTjiEln7X3htaLqkTToHUF7rrI6ej3rLsABk=
X-Received: by 2002:a05:6808:10cc:b0:3b8:b063:5049 with SMTP id
 s12-20020a05680810cc00b003b8b0635049mr10985998ois.74.1702449370274; Tue, 12
 Dec 2023 22:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Wed, 13 Dec 2023 14:35:58 +0800
Message-ID: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
To: syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com
Cc: brauner@kernel.org, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug with repro.c and repro.txt since it
relatively large please see
https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6

Since this bug in the dashboard
https://syzkaller.appspot.com/bug?extid=3D0c64a8706d587f73409e use
kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/log/?id=3Daed8aee11130a954356200afa3f1b8753e8a9482
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Ddf=
91a3034fe3f122

my repro.c use the seem config and it crash report like below, and
it=E2=80=99s almost can make sure it the same as bug reported by syzobt.

TITLE: WARNING in vfs_utimes
CORRUPTED: false ()
MAINTAINERS (TO): [linux-kernel@vger.kernel.org]
MAINTAINERS (CC): [brauner@kernel.org linux-fsdevel@vger.kernel.org
viro@zeniv.linux.org.uk]
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) !=3D current) &&
!rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): y
WARNING: CPU: 2 PID: 12763 at kernel/locking/rwsem.c:1370 __up_write
kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 2 PID: 12763 at kernel/locking/rwsem.c:1370
up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 2 PID: 12763 Comm: c90 Not tainted 6.6.0-rc1-00072-gaed8aee11130-dirty=
 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 20 99 4a 8b 48 c7 c6 60 9b 4a 8b 48 8b 54 24 28 48 8b
4c 24 18 4d 89 e0 4c 8b 4c 24 31
RSP: 0018:ffffc9000af5fbe0 EFLAGS: 00010292
RAX: d361770a4cb50c00 RBX: ffffffff8b4a9a00 RCX: 0000000000000000
RDX: ffff8880298fbcc0 RSI: ffff8880298fbcc0 RDI: 0000000000000000
RBP: ffffc9000af5fcb0 R08: ffffffff8155ef6f R09: 1ffff1101732516a
R10: dffffc0000000000 R11: ffffed101732516b R12: 0000000000000000
R13: ffff88807c966d68 R14: 1ffff920015ebf84 R15: dffffc0000000000
FS: 00007fc89df2d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc89df2e000 CR3: 000000014aab9000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
<TASK>
inode_unlock include/linux/fs.h:807 [inline]
vfs_utimes+0x4dc/0x790 fs/utimes.c:68
do_utimes_path fs/utimes.c:99 [inline]
do_utimes fs/utimes.c:145 [inline]
__do_sys_utime fs/utimes.c:226 [inline]
__se_sys_utime+0x1f2/0x2f0 fs/utimes.c:215
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x43deb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1c 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c8
RSP: 002b:00007fc89df2d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000084
RAX: ffffffffffffffda RBX: 00007fc89df2d6c0 RCX: 000000000043deb9
RDX: 0031656c69662f2e RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007fc89df2d220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffb0
R13: 0000000000000016 R14: 00007fffd3267590 R15: 00007fffd3267678
</TASK>
TITLE: kernel panic: kernel: panic_on_warn set ...
CORRUPTED: false ()
MAINTAINERS (TO): [linux-kernel@vger.kernel.org]
MAINTAINERS (CC): [brauner@kernel.org linux-fsdevel@vger.kernel.org
viro@zeniv.linux.org.uk]
Modules linked in:
CPU: 2 PID: 12763 Comm: c90 Not tainted 6.6.0-rc1-00072-gaed8aee11130-dirty=
 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 20 99 4a 8b 48 c7 c6 60 9b 4a 8b 48 8b 54 24 28 48 8b
4c 24 18 4d 89 e0 4c 8b 4c 24 31
RSP: 0018:ffffc9000af5fbe0 EFLAGS: 00010292
RAX: d361770a4cb50c00 RBX: ffffffff8b4a9a00 RCX: 0000000000000000
RDX: ffff8880298fbcc0 RSI: ffff8880298fbcc0 RDI: 0000000000000000
RBP: ffffc9000af5fcb0 R08: ffffffff8155ef6f R09: 1ffff1101732516a
R10: dffffc0000000000 R11: ffffed101732516b R12: 0000000000000000
R13: ffff88807c966d68 R14: 1ffff920015ebf84 R15: dffffc0000000000
FS: 00007fc89df2d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc89df2e000 CR3: 000000014aab9000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
<TASK>
inode_unlock include/linux/fs.h:807 [inline]
vfs_utimes+0x4dc/0x790 fs/utimes.c:68
do_utimes_path fs/utimes.c:99 [inline]
do_utimes fs/utimes.c:145 [inline]
__do_sys_utime fs/utimes.c:226 [inline]
__se_sys_utime+0x1f2/0x2f0 fs/utimes.c:215
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x43deb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1c 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c8
RSP: 002b:00007fc89df2d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000084
RAX: ffffffffffffffda RBX: 00007fc89df2d6c0 RCX: 000000000043deb9
RDX: 0031656c69662f2e RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007fc89df2d220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffb0
R13: 0000000000000016 R14: 00007fffd3267590 R15: 00007fffd3267678
</TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 2 PID: 12763 Comm: c90 Not tainted 6.6.0-rc1-00072-gaed8aee11130-dirty=
 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1f4/0x2f0 lib/dump_stack.c:106
panic+0x31e/0x7a0 kernel/panic.c:340
__warn+0x32e/0x4c0
__report_bug lib/bug.c:199 [inline]
report_bug+0x2ca/0x520 lib/bug.c:219
handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:237
exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:258
asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 20 99 4a 8b 48 c7 c6 60 9b 4a 8b 48 8b 54 24 28 48 8b
4c 24 18 4d 89 e0 4c 8b 4c 24 31
RSP: 0018:ffffc9000af5fbe0 EFLAGS: 00010292
RAX: d361770a4cb50c00 RBX: ffffffff8b4a9a00 RCX: 0000000000000000
RDX: ffff8880298fbcc0 RSI: ffff8880298fbcc0 RDI: 0000000000000000
RBP: ffffc9000af5fcb0 R08: ffffffff8155ef6f R09: 1ffff1101732516a
R10: dffffc0000000000 R11: ffffed101732516b R12: 0000000000000000
R13: ffff88807c966d68 R14: 1ffff920015ebf84 R15: dffffc0000000000
inode_unlock include/linux/fs.h:807 [inline]
vfs_utimes+0x4dc/0x790 fs/utimes.c:68
do_utimes_path fs/utimes.c:99 [inline]
do_utimes fs/utimes.c:145 [inline]
__do_sys_utime fs/utimes.c:226 [inline]
__se_sys_utime+0x1f2/0x2f0 fs/utimes.c:215
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x43deb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1c 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c8
RSP: 002b:00007fc89df2d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000084
RAX: ffffffffffffffda RBX: 00007fc89df2d6c0 RCX: 000000000043deb9
RDX: 0031656c69662f2e RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007fc89df2d220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffb0
R13: 0000000000000016 R14: 00007fffd3267590 R15: 00007fffd3267678
</TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

However, the repro.c can also crash the lastest kernel HEAD commit:
88035e5694a86a7167d490bb95e9df97a9bb162b use the same configuation.
It report below the same of the bug reported by syzbot:
https://syzkaller.appspot.com/bug?extid=3De14d6cd6ec241f507ba7.

TITLE: WARNING in __folio_mark_dirty
CORRUPTED: false ()
MAINTAINERS (TO): [akpm@linux-foundation.org
linux-fsdevel@vger.kernel.org linux-mm@kvack.org willy@infradead.org]
MAINTAINERS (CC): [linux-kernel@vger.kernel.org]
------------[ cut here ]------------
WARNING: CPU: 3 PID: 8118 at include/linux/backing-dev.h:255
folio_account_dirtied mm/page-writeback.c:2618 [inline]
WARNING: CPU: 3 PID: 8118 at include/linux/backing-dev.h:255
__folio_mark_dirty+0x936/0x1120 mm/page-writeback.c:2669
Modules linked in:
CPU: 3 PID: 8118 Comm: c90 Not tainted 6.7.0-rc5-00042-g88035e5694a8 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:inode_to_wb include/linux/backing-dev.h:252 [inline]
RIP: 0010:folio_account_dirtied mm/page-writeback.c:2618 [inline]
RIP: 0010:__folio_mark_dirty+0x936/0x1120 mm/page-writeback.c:2669
Code: f8 ff ff e8 5c 72 c8 ff 0f 0b e9 c9 f8 ff ff 31 ff e8 4e 72 c8
ff 4c 89 f7 48 8b 74 24 20 e8 bf
RSP: 0018:ffffc900142afa00 EFLAGS: 00010093
RAX: ffffffff81c92f96 RBX: 0000000000000000 RCX: ffff8880250f1e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801b12c2f8 R08: ffffffff81c92ab5 R09: 1ffff1100362585f
R10: dffffc0000000000 R11: ffffed1003625860 R12: 0000000000000001
R13: ffff88801b12c180 R14: ffffea000518f8c0 R15: 1ffff1100362585f
FS: 00000000023563c0(0000) GS:ffff88823bd00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0aff8f78 CR3: 000000001d875000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
mark_buffer_dirty+0x2ab/0x520 fs/buffer.c:1200
gfs2_unpin+0x142/0xad0 fs/gfs2/lops.c:111
buf_lo_after_commit+0x157/0x1b0 fs/gfs2/lops.c:745
lops_after_commit fs/gfs2/lops.h:51 [inline]
gfs2_log_flush+0x1f45/0x26a0 fs/gfs2/log.c:1115
gfs2_kill_sb+0x60/0x340 fs/gfs2/ops_fstype.c:1786
deactivate_locked_super+0xc8/0x140 fs/super.c:484
cleanup_mnt+0x444/0x4e0 fs/namespace.c:1256
task_work_run+0x257/0x310 kernel/task_work.c:180
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop+0xde/0x100 kernel/entry/common.c:171
exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x43f117
Code: 09 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66
2e 0f 1f 84 00 00 00 00 00 0f 18
RSP: 002b:00007fff0aff9728 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fff0affaa68 RCX: 000000000043f117
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff0aff97d0
RBP: 00007fff0affa810 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff0affaa58 R14: 0000000000000001 R15: 0000000000000001
</TASK>
TITLE: kernel panic: kernel: panic_on_warn set ...
CORRUPTED: false ()
MAINTAINERS (TO): [akpm@linux-foundation.org
linux-fsdevel@vger.kernel.org linux-mm@kvack.org willy@infradead.org]
MAINTAINERS (CC): [linux-kernel@vger.kernel.org]
Modules linked in:
CPU: 3 PID: 8118 Comm: c90 Not tainted 6.7.0-rc5-00042-g88035e5694a8 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:inode_to_wb include/linux/backing-dev.h:252 [inline]
RIP: 0010:folio_account_dirtied mm/page-writeback.c:2618 [inline]
RIP: 0010:__folio_mark_dirty+0x936/0x1120 mm/page-writeback.c:2669
Code: f8 ff ff e8 5c 72 c8 ff 0f 0b e9 c9 f8 ff ff 31 ff e8 4e 72 c8
ff 4c 89 f7 48 8b 74 24 20 e8 bf
RSP: 0018:ffffc900142afa00 EFLAGS: 00010093
RAX: ffffffff81c92f96 RBX: 0000000000000000 RCX: ffff8880250f1e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801b12c2f8 R08: ffffffff81c92ab5 R09: 1ffff1100362585f
R10: dffffc0000000000 R11: ffffed1003625860 R12: 0000000000000001
R13: ffff88801b12c180 R14: ffffea000518f8c0 R15: 1ffff1100362585f
FS: 00000000023563c0(0000) GS:ffff88823bd00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff0aff8f78 CR3: 000000001d875000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
mark_buffer_dirty+0x2ab/0x520 fs/buffer.c:1200
gfs2_unpin+0x142/0xad0 fs/gfs2/lops.c:111
buf_lo_after_commit+0x157/0x1b0 fs/gfs2/lops.c:745
lops_after_commit fs/gfs2/lops.h:51 [inline]
gfs2_log_flush+0x1f45/0x26a0 fs/gfs2/log.c:1115
gfs2_kill_sb+0x60/0x340 fs/gfs2/ops_fstype.c:1786
deactivate_locked_super+0xc8/0x140 fs/super.c:484
cleanup_mnt+0x444/0x4e0 fs/namespace.c:1256
task_work_run+0x257/0x310 kernel/task_work.c:180
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop+0xde/0x100 kernel/entry/common.c:171
exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x43f117
Code: 09 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66
2e 0f 1f 84 00 00 00 00 00 0f 18
RSP: 002b:00007fff0aff9728 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fff0affaa68 RCX: 000000000043f117
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff0aff97d0
RBP: 00007fff0affa810 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff0affaa58 R14: 0000000000000001 R15: 0000000000000001
</TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 3 PID: 8118 Comm: c90 Not tainted 6.7.0-rc5-00042-g88035e5694a8 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1f4/0x2f0 lib/dump_stack.c:106
panic+0x35a/0x880 kernel/panic.c:344
__warn+0x32e/0x4c0
__report_bug lib/bug.c:199 [inline]
report_bug+0x2ca/0x520 lib/bug.c:219
handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:237
exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:258
asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:inode_to_wb include/linux/backing-dev.h:252 [inline]
RIP: 0010:folio_account_dirtied mm/page-writeback.c:2618 [inline]
RIP: 0010:__folio_mark_dirty+0x936/0x1120 mm/page-writeback.c:2669
Code: f8 ff ff e8 5c 72 c8 ff 0f 0b e9 c9 f8 ff ff 31 ff e8 4e 72 c8
ff 4c 89 f7 48 8b 74 24 20 e8 bf
RSP: 0018:ffffc900142afa00 EFLAGS: 00010093
RAX: ffffffff81c92f96 RBX: 0000000000000000 RCX: ffff8880250f1e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801b12c2f8 R08: ffffffff81c92ab5 R09: 1ffff1100362585f
R10: dffffc0000000000 R11: ffffed1003625860 R12: 0000000000000001
R13: ffff88801b12c180 R14: ffffea000518f8c0 R15: 1ffff1100362585f
mark_buffer_dirty+0x2ab/0x520 fs/buffer.c:1200
gfs2_unpin+0x142/0xad0 fs/gfs2/lops.c:111
buf_lo_after_commit+0x157/0x1b0 fs/gfs2/lops.c:745
lops_after_commit fs/gfs2/lops.h:51 [inline]
gfs2_log_flush+0x1f45/0x26a0 fs/gfs2/log.c:1115
gfs2_kill_sb+0x60/0x340 fs/gfs2/ops_fstype.c:1786
deactivate_locked_super+0xc8/0x140 fs/super.c:484
cleanup_mnt+0x444/0x4e0 fs/namespace.c:1256
task_work_run+0x257/0x310 kernel/task_work.c:180
resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
exit_to_user_mode_loop+0xde/0x100 kernel/entry/common.c:171
exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
do_syscall_64+0x50/0x110 arch/x86/entry/common.c:89
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x43f117
Code: 09 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66
2e 0f 1f 84 00 00 00 00 00 0f 18
RSP: 002b:00007fff0aff9728 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fff0affaa68 RCX: 000000000043f117
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff0aff97d0
RBP: 00007fff0affa810 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000001
R13: 00007fff0affaa58 R14: 0000000000000001 R15: 0000000000000001
</TASK>


I hope someone figure out and hope it helps.

Best regards
xingwei Lee
