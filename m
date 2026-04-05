Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352C1A6805
	for <gfs2@lists.linux.dev>; Sun,  5 Apr 2026 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775424636; cv=none; b=F1TZzuvwrjjd0fUpFmtPHGPpySIAxCSxDpIChN6/WmdSmxi8m/pIvmgWoXRMTBAZ0AJxxaKwVM1wTmxP6bHB8y+OVXJdpvt3UMojsrGh3ZD/ebZ/keRmI7xHSIRi37Gj51ZPcAU2WEQZOMnmK/YYmdx7bcb82dS7GIaEb3isczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775424636; c=relaxed/simple;
	bh=HltSBvigOXYHjNRjfQLGnwaeJBA74o6CcIdwairAPWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LzYTpGYSC+6O8hGalCzLSzBa3NFB2+zFW5IzXYAhAFiZYeeuN7tBep7+GzZWkpMbQJX7rBOAZ0iiXeONdobOiq7f6JjjQJy0vUECqAzfc7yNdOBsNSfISRa5khn/wRE/0EUiKVuMEqhfssv3e1uyc9B8AzRoD9QAzniDhpcIlL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67e44358ce0so4642708eaf.0
        for <gfs2@lists.linux.dev>; Sun, 05 Apr 2026 14:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775424634; x=1776029434;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WHoMP9qSjWNK7RJVlSPjHrLQmOhO4K7APOnPp1oa3s=;
        b=ZsfSxeQkx/k1LJ5FmJJyBDBJsQ5+4fN//bzC8dHhyiyba3R11UQiAIODKvDLrDxDTM
         08wWY/OCNnTI1j2YTrz2Tp+8Aqy5Sqrx95v95mOod6dDnwqBsII34i/THHYMUhP4UOVR
         RsnIsP1tCwWonbmRNkZ46us5682IjzcTr8QV5NrE1RP/fiX2FqnBnxI0ZFgHXaiHkJds
         BFu0ypRhLAYp8rpfrb/aAlH0tWFKGg+QAFQEb/SsLMheYbd+m+X9uPJCMBGKcSlm3CSb
         b7W9XkBr9sCQ2maTlmcSDqucEf0HCrVXDVPfAVKUkC7NMBEefJaUWKIS+bcVUV17YRUi
         QK1w==
X-Forwarded-Encrypted: i=1; AJvYcCXUHHRlBT2sn83/LIZM2WQoqnQ3y1Ovyua/IlALr3HNuR8CKW/b276UJu5viB2/Apafzznu@lists.linux.dev
X-Gm-Message-State: AOJu0YwHZPzLtajyK/+PRPVekRi7ocrlAVSqjeJMsPrcael/kSV0wpcd
	VfvgC98pwH1I6obl/s5o9YSK7geZ2EpzZoE/yCMGqsXTESrsBi43sVEDyYTSTa6jIuG1W/NClUO
	kE+Ej62ZhXGQSbMQ+ET1g851TVvr102Oz/S/6Dqdb+EILtb5stSd0VIgM9tI=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168d:b0:67d:2cb:207a with SMTP id
 006d021491bc7-68221822058mr5762572eaf.55.1775424633824; Sun, 05 Apr 2026
 14:30:33 -0700 (PDT)
Date: Sun, 05 Apr 2026 14:30:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d2d479.a70a0220.a26f2.0033.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_ail_drain
From: syzbot <syzbot+84a21b16aba9f279d96a@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1791c390149f Merge tag 'char-misc-7.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128e21ca580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d46eab0cfd31c214
dashboard link: https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-1791c390.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b381e1a524fb/vmlinux-1791c390.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de59bbdaba20/bzImage-1791c390.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84a21b16aba9f279d96a@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: jid=0, already locked for use
gfs2: fsid=syz:syz.0: jid=0: Looking at journal...
gfs2: fsid=syz:syz.0: jid=0: Journal head lookup took 109ms
gfs2: fsid=syz:syz.0: jid=0: Done
gfs2: fsid=syz:syz.0: fatal: invalid metadata block - bh = 9381 (bad magic number), function = gfs2_meta_buffer, file = fs/gfs2/meta_io.c, line = 496
loop0: writeback error on inode 9428, offset 5376000, sector 29444
==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x92/0x190 lib/list_debug.c:62
Read of size 8 at addr ffff888040098118 by task kworker/0:5/5313

CPU: 0 UID: 0 PID: 5313 Comm: kworker/0:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events gfs2_withdraw_func
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __list_del_entry_valid_or_report+0x92/0x190 lib/list_debug.c:62
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del_init include/linux/list.h:295 [inline]
 gfs2_remove_from_ail fs/gfs2/log.c:79 [inline]
 gfs2_ail_empty_tr fs/gfs2/log.c:287 [inline]
 gfs2_ail_drain+0x1b7/0xaf0 fs/gfs2/log.c:945
 do_withdraw+0x115/0x2f0 fs/gfs2/util.c:128
 gfs2_withdraw_func+0x2f3/0x430 fs/gfs2/util.c:-1
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5320:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4873
 gfs2_glock_get+0x27b/0xf40 fs/gfs2/glock.c:1098
 gfs2_create_inode+0xd1f/0x1630 fs/gfs2/inode.c:828
 gfs2_atomic_open+0x116/0x200 fs/gfs2/inode.c:1402
 atomic_open+0x14f/0x370 fs/namei.c:4342
 lookup_open fs/namei.c:4455 [inline]
 open_last_lookups fs/namei.c:4589 [inline]
 path_openat+0x10e9/0x3860 fs/namei.c:4833
 do_file_open+0x23e/0x4a0 fs/namei.c:4865
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5011:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x187/0x630 mm/slub.c:6295
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 lock_sock include/net/sock.h:1709 [inline]
 sockopt_lock_sock net/core/sock.c:1152 [inline]
 sk_setsockopt+0xe62/0x2e80 net/core/sock.c:1310
 do_sock_setsockopt+0x210/0x400 net/socket.c:2318
 __sys_setsockopt net/socket.c:2347 [inline]
 __do_sys_setsockopt net/socket.c:2353 [inline]
 __se_sys_setsockopt net/socket.c:2350 [inline]
 __x64_sys_setsockopt+0x18a/0x210 net/socket.c:2350
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 gfs2_glock_free+0x3c/0xa0 fs/gfs2/glock.c:152
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2199
 __queue_work+0xd03/0x1020 kernel/workqueue.c:2354
 queue_delayed_work_on+0x11a/0x1e0 kernel/workqueue.c:2574
 queue_delayed_work include/linux/workqueue.h:684 [inline]
 gfs2_glock_queue_work fs/gfs2/glock.c:224 [inline]
 do_xmote+0x515/0x760 fs/gfs2/glock.c:745
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1011
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888040098000
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 280 bytes inside of
 freed 1224-byte region [ffff888040098000, ffff8880400984c8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40098
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888031ae2500 dead000000000122 0000000000000000
raw: 0000000000000000 00000008000c000c 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff888031ae2500 dead000000000122 0000000000000000
head: 0000000000000000 00000008000c000c 00000000f5000000 0000000000000000
head: 04fff00000000002 ffffea0001002601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5319, tgid 5318 (syz.0.0), ts 85079790490, free_ts 85027417940
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 alloc_full_sheaf mm/slub.c:2834 [inline]
 __pcs_replace_empty_main+0x40a/0x730 mm/slub.c:4626
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 kmem_cache_alloc_noprof+0x37d/0x650 mm/slub.c:4873
 gfs2_glock_get+0x27b/0xf40 fs/gfs2/glock.c:1098
 gfs2_inode_lookup+0x29f/0xc50 fs/gfs2/inode.c:149
 gfs2_lookup_root fs/gfs2/ops_fstype.c:426 [inline]
 init_sb+0xa5a/0x12f0 fs/gfs2/ops_fstype.c:495
 gfs2_fill_super+0x16d6/0x21d0 fs/gfs2/ops_fstype.c:1217
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
page last free pid 5319 tgid 5318 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 stack_depot_save_flags+0x40e/0x810 lib/stackdepot.c:735
 kasan_save_stack mm/kasan/common.c:58 [inline]
 kasan_save_track+0x4f/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4873
 __kernfs_new_node+0xe9/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 kernfs_create_dir_ns+0x44/0x130 fs/kernfs/dir.c:1088
 internal_create_group+0x425/0x1180 fs/sysfs/group.c:176
 gfs2_sys_fs_add+0x27b/0x480 fs/gfs2/sys.c:730
 gfs2_fill_super+0x13a7/0x21d0 fs/gfs2/ops_fstype.c:1201
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338

Memory state around the buggy address:
 ffff888040098000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040098080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888040098100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888040098180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040098200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
