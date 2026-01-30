Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E661F09AD
	for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783004; cv=none; b=JXwBTLMT5zz4jrGlxL5eRKj/cYpCi0YqCmuFg61sny4WOj9uW9U+BRbIJV40j3InvzlVAOSjN9RJxUsA2Pst7k1en8GB3UB4OJI5ZZ8HEwks7qOIH4HreAHBn9aNunD5D8KTWw4gzHMzvltz3MI3/s3Na7211OKTQk31pvssDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783004; c=relaxed/simple;
	bh=e9q9szt2JNO1yS5n5AYuKIKasN78fxm9qOu9ZlApz5k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SiU+qFiIKD4JQvvO3+cXGv3MAK669Z2fkcG2zR6kdexXA1GjJlBlVQ2nOg9MCZUzRsVACUfrfT2SKTCrU9sFggjrZN3b2MPm969UdU2AqKZFXU0hNAbsj4H0LitSrFFYksh0QxamJyluFD2clXqyBVqNVGx5fg8VNT+Bog3D7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6630ee9fb15so3674060eaf.0
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 06:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783002; x=1770387802;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZtH8jP745S0hbPzFk1hVxJw6CYk1iPt9v9VCvDv5uo=;
        b=d6HjcFgeam6bKOJ1W2654WRPrU+Kz/1slY6UTsFIZ4h1XBdhgmDxJZsg5b4Bh/SbeE
         nYkWJMYYWIkgfFuRFR40ALN90ulst2RoXOotO2ffZ05k+Qat6ibalvJbndTsKIHiqvqg
         bNZJHVqpcm9Eqiyvi3iAYISDWr8uu2ZNuXmYI0B69fsT0oznrzMoXITbeJ6TQCgD3s3Q
         9z5WQAcbYj0Ggxp8wA4P9nTDrHCN6ADTjM9dUgSQikq4ah26EtxrgU/b7h6Ew152nTmI
         QKlviNPdRIarhrizR485O3KeiQfarkKDAAVkcMcIQElQDBn8oD8rN3aJvpnQjROMSpSE
         ZnAA==
X-Forwarded-Encrypted: i=1; AJvYcCVgdrtAjVK/89/JDYROb8XhrB7sjpFoN1eGuF2vYy559IYH8otGiDPRnafNLreJX5+43Fth@lists.linux.dev
X-Gm-Message-State: AOJu0YypCwCsGMxHjX3h5JscSACcn3Ko/7rFNgWcB3wNHxwWZoi5Wejc
	pRTEonGEIHt7SMBEz92sviqc5ufDvxB/YKdPkOaUkLhUytmpcd2m42mHxY4sxMwdQrQX95hBYXq
	fqrSTut125zZRFify4bAqXVNAZ+wuKjGBViYJqYsi8QSZQ7wU7m6TnN2pVNs=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a9:b0:662:ee4b:8b4f with SMTP id
 006d021491bc7-6630f050816mr1441883eaf.25.1769783002110; Fri, 30 Jan 2026
 06:23:22 -0800 (PST)
Date: Fri, 30 Jan 2026 06:23:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697cbeda.050a0220.142e72.0000.GAE@google.com>
Subject: [syzbot] [gfs2?] memory leak in __kthread_create_on_node
From: syzbot <syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8dfce8991b95 Merge tag 'pinctrl-v6.19-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14361322580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=aac438d7a1c44071e04b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1409c644580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16121694580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5812cc8b60db/disk-8dfce899.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47a4b40e4e44/vmlinux-8dfce899.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18e043c20056/bzImage-8dfce899.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ebd5c2300445/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15765d8a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888125a2dec0 (size 32):
  comm "syz.4.75", pid 6411, jiffies 4294948981
  hex dump (first 32 bytes):
    67 66 73 32 5f 6c 6f 67 64 2f 73 79 7a 3a 73 79  gfs2_logd/syz:sy
    7a 2e 30 00 00 00 00 00 00 00 00 00 00 00 00 00  z.0.............
  backtrace (crc d543dd03):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_node_track_caller_noprof+0x47b/0x690 mm/slub.c:5768
    kvasprintf+0x6e/0xf0 lib/kasprintf.c:25
    __kthread_create_on_node+0x9e/0x1c0 kernel/kthread.c:519
    kthread_create_on_node+0x73/0xa0 kernel/kthread.c:587
    init_threads fs/gfs2/ops_fstype.c:1065 [inline]
    gfs2_fill_super+0xdf8/0x1210 fs/gfs2/ops_fstype.c:1265
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1691
    gfs2_get_tree+0x26/0xd0 fs/gfs2/ops_fstype.c:1332
    vfs_get_tree+0x30/0x120 fs/super.c:1751
    fc_mount fs/namespace.c:1199 [inline]
    do_new_mount_fc fs/namespace.c:3636 [inline]
    do_new_mount fs/namespace.c:3712 [inline]
    path_mount+0x5a9/0x1350 fs/namespace.c:4022
    do_mount fs/namespace.c:4035 [inline]
    __do_sys_mount fs/namespace.c:4224 [inline]
    __se_sys_mount fs/namespace.c:4201 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4201
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888126a2a300 (size 4480):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 80 00 00 00 00 00 00 00  ................
  backtrace (crc 4b33760e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x422/0x590 mm/slub.c:5315
    alloc_task_struct_node kernel/fork.c:184 [inline]
    dup_task_struct kernel/fork.c:915 [inline]
    copy_process+0x286/0x2870 kernel/fork.c:2052
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

BUG: memory leak
unreferenced object 0xffff888109c85180 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c5f4f48b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x412/0x580 mm/slub.c:5270
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x2870 kernel/fork.c:2086
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

BUG: memory leak
unreferenced object 0xffff888102bd9780 (size 32):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
  backtrace (crc 336e1c5f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_cred_alloc security/security.c:209 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2763
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x2870 kernel/fork.c:2086
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

BUG: memory leak
unreferenced object 0xffff8881098abc00 (size 192):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff  ................
    01 00 00 00 00 00 00 00 80 d5 78 82 ff ff ff ff  ..........x.....
  backtrace (crc 1df624ea):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __kmalloc_cache_noprof+0x41a/0x590 mm/slub.c:5775
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    set_kthread_struct+0x58/0x150 kernel/kthread.c:125
    copy_process+0x1569/0x2870 kernel/fork.c:2150
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

BUG: memory leak
unreferenced object 0xffff88812baec5c0 (size 64):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    e0 35 8f 89 ff ff ff ff 00 00 00 00 00 00 00 00  .5..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8e7806b9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_task_alloc security/security.c:244 [inline]
    security_task_alloc+0x2a/0x260 security/security.c:2682
    copy_process+0xf07/0x2870 kernel/fork.c:2203
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

BUG: memory leak
unreferenced object 0xffff888101e37a80 (size 1152):
  comm "kthreadd", pid 2, jiffies 4294948981
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    90 7a e3 01 81 88 ff ff 90 7a e3 01 81 88 ff ff  .z.......z......
  backtrace (crc 1d024e88):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x412/0x580 mm/slub.c:5270
    copy_signal kernel/fork.c:1699 [inline]
    copy_process+0x1102/0x2870 kernel/fork.c:2218
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    kernel_thread+0x80/0xb0 kernel/fork.c:2712
    create_kthread kernel/kthread.c:486 [inline]
    kthreadd+0x196/0x260 kernel/kthread.c:844
    ret_from_fork+0x23c/0x320 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

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
