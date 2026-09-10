Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D282DEA68
	for <gfs2@lists.linux.dev>; Thu, 10 Sep 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002268; cv=none; b=DYicCMhUcu8NxPOcf/dMAIJ7cOgRAlBzHUtXWgG8ow0JSZCD5HK71mOvV1ak6iPZWmm8ePCnmznPtzU3H7Ld8ZMPVA4XUj5l071CsFRVxyth0dBiWbiQ3dQ22g7eQTYXAQTr2tRfUEIE0maH7zQdtvYcLNs7iU45jY4E5o5S+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002268; c=relaxed/simple;
	bh=mWn/tOYN/oYbXIavSes/REld/1aayyzzPz/1/Bfa4gA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hZgsSgLcoDVCsjtt3KjVNk0pDNspjImWGmahp7wPI5O3MivNRDBV9MShAxwRbl+rVMItrjqfrT55VcXPOC9C54Gw+a1xbqM+AlNC9hk60NoYVUKJ78W5EZioC3ZZPX14jBBuDK67OxnCfFUjOp0UYhzga6WtZVk/393tZGIyMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-6a3900cb2b5so2521186eaf.0
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 18:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789002264; x=1789607064;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLb09Mp1DQLChGTZFYW0/uDIbPhs1mn+Bc6CziDe9cQ=;
        b=tDBzs0inBMsWKhvjptumR3+X3+t9nqLG2h00zmZ/Ht79SrIS6SuGUpbbQ0XsPJjFQX
         DbSsnWl8gNZ6aYtFxOLUFf9wH77pbudJDan3Eck2ZBSS+9wDDenwTSaupVWFF8WVy2TW
         jPkzTD3UG00QseLiTJbWlujf7aHlaLsRx2ys6uC4/XhqvsFj7XxIccYnuP5RKUBo/2KF
         ULQubNvaIq3tzNmwZfV3+luucxJu8TVp9Ty1QtLxdrbSgdOruoWTgaf+7HMesVgEw7Wj
         2RnjErTgyKTEy5glPyN83Frct6EtBpdOfqu4rjmA9qoCliFyP8+2+G15DEJKVV/0QcGO
         0ayQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOhYog69S9G9DJDw2JDGOCkrM172DaC8LxzpCeS6fxbdz6nmlCsWOAbVqVU7WOtZFzdbPW@lists.linux.dev
X-Gm-Message-State: AFuF++kVI2Zo6ebeV/k9g2YfFxo7wnOY92l1KxkFQKPO6utjHCW6oYLr
	i7SC6IcotLZp1m+sUMP9dC5LwR2IYTJ0BmH/cFgM00GGrRcYPufuIeSEqaWctjdgfltMv1mZQXz
	hMNlx0NfnIKpLOy9K+hnVV83XWQ78KofBXpJFka9/lY6ISP3ATLXWQyQ8OGs=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c09:b0:6b3:5537:8dbe with SMTP id
 006d021491bc7-6b6fade3f17mr21596619eaf.11.1789002264645; Wed, 09 Sep 2026
 18:04:24 -0700 (PDT)
Date: Wed, 09 Sep 2026 18:04:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa20218.6e6c5f9e.28f11f.002a.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_remove_from_ail
From: syzbot <syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c297ed90fbba Merge tag 'configfs-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eeb125580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19560cab9a915237
dashboard link: https://syzkaller.appspot.com/bug?extid=ab91b239b20ae188b9cb
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5ff72f9f684/disk-c297ed90.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0681a6a0fbd/vmlinux-c297ed90.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9182b2171db9/bzImage-c297ed90.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab91b239b20ae188b9cb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x1b1/0x1d0 lib/list_debug.c:62
Read of size 8 at addr ffff88807c647920 by task kworker/0:6/5768

CPU: 0 UID: 0 PID: 5768 Comm: kworker/0:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Workqueue: events gfs2_withdraw_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __list_del_entry_valid_or_report+0x1b1/0x1d0 lib/list_debug.c:62
 __list_del_entry_valid include/linux/list.h:140 [inline]
 __list_del_entry include/linux/list.h:261 [inline]
 list_del_init include/linux/list.h:333 [inline]
 gfs2_remove_from_ail+0x138/0x340 fs/gfs2/log.c:79
 gfs2_ail_empty_tr fs/gfs2/log.c:287 [inline]
 gfs2_ail_drain+0x39c/0x6b0 fs/gfs2/log.c:954
 do_withdraw+0xeb/0x300 fs/gfs2/util.c:126
 gfs2_withdraw_func+0x349/0x3d0 fs/gfs2/util.c:236
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7723:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7773:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6626
 gfs2_glock_dealloc+0xd0/0x160 fs/gfs2/glock.c:134
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x56/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3181
 gfs2_glock_free+0x35/0xa0 fs/gfs2/glock.c:150
 glock_work_func+0x437/0x4d0 fs/gfs2/glock.c:1003
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2272
 __queue_work+0xa60/0x1370 kernel/workqueue.c:2448
 __queue_delayed_work+0x357/0x450 kernel/workqueue.c:2617
 queue_delayed_work_on+0x180/0x1e0 kernel/workqueue.c:2669
 queue_delayed_work include/linux/workqueue.h:715 [inline]
 gfs2_glock_queue_work+0x75/0x120 fs/gfs2/glock.c:198
 do_xmote+0x453/0x680 fs/gfs2/glock.c:718
 run_queue+0x555/0x6a0 fs/gfs2/glock.c:757
 glock_work_func+0x35b/0x4d0 fs/gfs2/glock.c:987
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c647808
 which belongs to the cache gfs2_glock(aspace) of size 1176
The buggy address is located 280 bytes inside of
 freed 1176-byte region [ffff88807c647808, ffff88807c647ca0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c644
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
head: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7723, tgid 7722 (syz.3.658), ts 220778208215
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x4c4/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
page last free pid 7723 tgid 7722 ts 220636014324 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 stack_depot_save_flags+0x456/0x9f0 lib/stackdepot.c:735
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_node_noprof+0x30c/0x720 mm/slub.c:5582
 _kmalloc_node_noprof include/linux/slab.h:1196 [inline]
 alloc_worker kernel/workqueue.c:2755 [inline]
 init_rescuer+0x19f/0x550 kernel/workqueue.c:5795
 __alloc_workqueue+0xe82/0x1950 kernel/workqueue.c:5993
 alloc_workqueue_va kernel/workqueue.c:6033 [inline]
 alloc_workqueue_noprof+0xc7/0x130 kernel/workqueue.c:6049
 gfs2_fill_super+0x140f/0x2d00 fs/gfs2/ops_fstype.c:1197
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84

Memory state around the buggy address:
 ffff88807c647800: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c647900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807c647980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x1a4/0x1d0 lib/list_debug.c:65
Read of size 8 at addr ffff88807c647928 by task kworker/0:6/5768

CPU: 0 UID: 0 PID: 5768 Comm: kworker/0:6 Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Workqueue: events gfs2_withdraw_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __list_del_entry_valid_or_report+0x1a4/0x1d0 lib/list_debug.c:65
 __list_del_entry_valid include/linux/list.h:140 [inline]
 __list_del_entry include/linux/list.h:261 [inline]
 list_del_init include/linux/list.h:333 [inline]
 gfs2_remove_from_ail+0x138/0x340 fs/gfs2/log.c:79
 gfs2_ail_empty_tr fs/gfs2/log.c:287 [inline]
 gfs2_ail_drain+0x39c/0x6b0 fs/gfs2/log.c:954
 do_withdraw+0xeb/0x300 fs/gfs2/util.c:126
 gfs2_withdraw_func+0x349/0x3d0 fs/gfs2/util.c:236
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7723:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7773:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6626
 gfs2_glock_dealloc+0xd0/0x160 fs/gfs2/glock.c:134
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x56/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3181
 gfs2_glock_free+0x35/0xa0 fs/gfs2/glock.c:150
 glock_work_func+0x437/0x4d0 fs/gfs2/glock.c:1003
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2272
 __queue_work+0xa60/0x1370 kernel/workqueue.c:2448
 __queue_delayed_work+0x357/0x450 kernel/workqueue.c:2617
 queue_delayed_work_on+0x180/0x1e0 kernel/workqueue.c:2669
 queue_delayed_work include/linux/workqueue.h:715 [inline]
 gfs2_glock_queue_work+0x75/0x120 fs/gfs2/glock.c:198
 do_xmote+0x453/0x680 fs/gfs2/glock.c:718
 run_queue+0x555/0x6a0 fs/gfs2/glock.c:757
 glock_work_func+0x35b/0x4d0 fs/gfs2/glock.c:987
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c647808
 which belongs to the cache gfs2_glock(aspace) of size 1176
The buggy address is located 288 bytes inside of
 freed 1176-byte region [ffff88807c647808, ffff88807c647ca0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c644
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
head: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7723, tgid 7722 (syz.3.658), ts 220778208215
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x4c4/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
page last free pid 7723 tgid 7722 ts 220636014324 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 stack_depot_save_flags+0x456/0x9f0 lib/stackdepot.c:735
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_node_noprof+0x30c/0x720 mm/slub.c:5582
 _kmalloc_node_noprof include/linux/slab.h:1196 [inline]
 alloc_worker kernel/workqueue.c:2755 [inline]
 init_rescuer+0x19f/0x550 kernel/workqueue.c:5795
 __alloc_workqueue+0xe82/0x1950 kernel/workqueue.c:5993
 alloc_workqueue_va kernel/workqueue.c:6033 [inline]
 alloc_workqueue_noprof+0xc7/0x130 kernel/workqueue.c:6049
 gfs2_fill_super+0x140f/0x2d00 fs/gfs2/ops_fstype.c:1197
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84

Memory state around the buggy address:
 ffff88807c647800: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c647900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807c647980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in __list_del include/linux/list.h:241 [inline]
BUG: KASAN: slab-use-after-free in __list_del_entry include/linux/list.h:264 [inline]
BUG: KASAN: slab-use-after-free in __list_del_entry include/linux/list.h:259 [inline]
BUG: KASAN: slab-use-after-free in list_del_init include/linux/list.h:333 [inline]
BUG: KASAN: slab-use-after-free in gfs2_remove_from_ail+0x323/0x340 fs/gfs2/log.c:79
Write of size 8 at addr ffff88807c647928 by task kworker/0:6/5768

CPU: 0 UID: 0 PID: 5768 Comm: kworker/0:6 Tainted: G    B               syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Workqueue: events gfs2_withdraw_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 __list_del include/linux/list.h:241 [inline]
 __list_del_entry include/linux/list.h:264 [inline]
 __list_del_entry include/linux/list.h:259 [inline]
 list_del_init include/linux/list.h:333 [inline]
 gfs2_remove_from_ail+0x323/0x340 fs/gfs2/log.c:79
 gfs2_ail_empty_tr fs/gfs2/log.c:287 [inline]
 gfs2_ail_drain+0x39c/0x6b0 fs/gfs2/log.c:954
 do_withdraw+0xeb/0x300 fs/gfs2/util.c:126
 gfs2_withdraw_func+0x349/0x3d0 fs/gfs2/util.c:236
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7723:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7773:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kmem_cache_free+0x127/0x6c0 mm/slub.c:6626
 gfs2_glock_dealloc+0xd0/0x160 fs/gfs2/glock.c:134
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1260 kernel/rcu/tree.c:2919
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0x16a/0x210 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x56/0xc0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0xa5/0x9b0 kernel/rcu/tree.c:3181
 gfs2_glock_free+0x35/0xa0 fs/gfs2/glock.c:150
 glock_work_func+0x437/0x4d0 fs/gfs2/glock.c:1003
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2272
 __queue_work+0xa60/0x1370 kernel/workqueue.c:2448
 __queue_delayed_work+0x357/0x450 kernel/workqueue.c:2617
 queue_delayed_work_on+0x180/0x1e0 kernel/workqueue.c:2669
 queue_delayed_work include/linux/workqueue.h:715 [inline]
 gfs2_glock_queue_work+0x75/0x120 fs/gfs2/glock.c:198
 do_xmote+0x453/0x680 fs/gfs2/glock.c:718
 run_queue+0x555/0x6a0 fs/gfs2/glock.c:757
 glock_work_func+0x35b/0x4d0 fs/gfs2/glock.c:987
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88807c647808
 which belongs to the cache gfs2_glock(aspace) of size 1176
The buggy address is located 288 bytes inside of
 freed 1176-byte region [ffff88807c647808, ffff88807c647ca0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c644
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
raw: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff8881404313c0 dead000000000122 0000000000000000
head: 0000000000000000 00000002000c000c 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7723, tgid 7722 (syz.3.658), ts 220778208215
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 kmem_cache_alloc_noprof+0x4c4/0x6a0 mm/slub.c:5010
 gfs2_glock_get+0x1e5/0x1260 fs/gfs2/glock.c:1074
 gfs2_inode_lookup+0x2e0/0x920 fs/gfs2/inode.c:149
 gfs2_lookup_root+0x57/0xe0 fs/gfs2/ops_fstype.c:428
 init_sb+0xa17/0xfd0 fs/gfs2/ops_fstype.c:497
 gfs2_fill_super+0x1acb/0x2d00 fs/gfs2/ops_fstype.c:1219
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
page last free pid 7723 tgid 7722 ts 220636014324 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 stack_depot_save_flags+0x456/0x9f0 lib/stackdepot.c:735
 kasan_save_stack+0x3f/0x50 mm/kasan/common.c:58
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_node_noprof+0x30c/0x720 mm/slub.c:5582
 _kmalloc_node_noprof include/linux/slab.h:1196 [inline]
 alloc_worker kernel/workqueue.c:2755 [inline]
 init_rescuer+0x19f/0x550 kernel/workqueue.c:5795
 __alloc_workqueue+0xe82/0x1950 kernel/workqueue.c:5993
 alloc_workqueue_va kernel/workqueue.c:6033 [inline]
 alloc_workqueue_noprof+0xc7/0x130 kernel/workqueue.c:6049
 gfs2_fill_super+0x140f/0x2d00 fs/gfs2/ops_fstype.c:1197
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1887
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x320 fs/super.c:1947
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount fs/namespace.c:3848 [inline]
 path_mount+0x7d0/0x24c0 fs/namespace.c:4168
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount fs/namespace.c:4374 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84

Memory state around the buggy address:
 ffff88807c647800: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c647900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807c647980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c647a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
