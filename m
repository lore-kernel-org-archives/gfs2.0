Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA42C237E
	for <gfs2@lists.linux.dev>; Fri,  9 Oct 2026 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507509; cv=none; b=SvDOYe6HGlUmyTM/WPhAvxnldA6/AFfvRRbg4+XSa3m10rrNxFc+htQ8s6LsCGhFK0Hbe448RFR8IJB7bThfyqkDK/tPm5ie1JGq6Tbj174KBbLAf75dbYIAJMnxtL78FkTiL64VYE6disRulPfG67l2zHq4mA+w7+6O/i+7B1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507509; c=relaxed/simple;
	bh=3yPuhfD84KwC73dPAVHE0vS+lXhgM6oCGs/AYnlXxy0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AL/kSKatU22AYIwDV6f6TogtOBzahfVciBSDThpDsgite5sQPCOlrIUtIm9eWuBtDXVk14Ew90hMPzofVAsXzjuCmuWrdLrLjcUnHfd8mGNTDabJ7pmDU5Glt52ukfLtWtpghKuzsbyutR+e/F3oNSAndQROb7Ekb3iXQEAmzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4db3db8687fso8542704b6e.0
        for <gfs2@lists.linux.dev>; Thu, 08 Oct 2026 17:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791507506; x=1792112306;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfRS8O+PZsYPZMXJ6aEnZrFK6HP91gIC/Y4XevvXUpA=;
        b=Kx3r726HwXwqc21uaroN6nAtP/7cKmn1rCQEEV0EKMDAhCfo6fKhsOBPEl98GNYR7z
         OQ+oC1SkkwfEXUpDI+hTBcKJbjpZdmjv8qQJhUBEWidipZP3XF/XRLXRn2HCbT/52RKo
         J/WnauTyAmBYLPf2AS6BqT0XkPTXnMrzvbn/MEkZVI6cFtMbSTM5FiLtK2xyogeNcDSo
         3RamtMMWlvGikZhE320zEkFfE7SiWvpyQFVzxG2V+lT7V9wX2UGKB3tH69qF1gQ0sFKB
         DwOnpchHzA1YoR72UGprOwycrAs/qMaqnIT6XAuE7t8EIG8IkNAJ5LtROu67qyrU+DO+
         BJhQ==
X-Forwarded-Encrypted: i=1; AKwUvByaNJ8+uLfmY+6vnrd+oYEt43f82MvZH9RSM9Q2Qbaja4PcBpHZXzz03LPaeykprRfwIpdY@lists.linux.dev
X-Gm-Message-State: AFuF++nDIe4sAMUfkfnS7DUwm0z+oR8LB6MOz2p7dbCT+nUI25o53obp
	5jhUHmZOdFnpVw8QMOyceeJAdh673F6HIzbVEW+bxaQguzdrO3P07lBtXRjC2WcZNg14tQ2Yfor
	qhVjDMInnNFpYTidOoUe25VjUB2pXzrdFMq2rQdiyIKxTfxLC07ZLo303HcE=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1308:b0:4f6:1336:cdf9 with SMTP id
 5614622812f47-50c556ae285mr314577b6e.35.1791507506354; Thu, 08 Oct 2026
 17:58:26 -0700 (PDT)
Date: Thu, 08 Oct 2026 17:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac83c32.bbc4c7f9.15faa7.0008.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in
 gfs2_withdraw_func (2)
From: syzbot <syzbot+88ffc513fdcbbb39cdf7@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a74306e2e676 Merge tag 'clk-fixes-for-linus-v7.3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16328835580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66e2e48805cd3a64
dashboard link: https://syzkaller.appspot.com/bug?extid=88ffc513fdcbbb39cdf7
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-a74306e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ceef0db30e25/vmlinux-a74306e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfca6997ed38/bzImage-a74306e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88ffc513fdcbbb39cdf7@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: jid=0, already locked for use
gfs2: fsid=syz:syz.0: jid=0: Looking at journal...
gfs2: fsid=syz:syz.0: jid=0: Journal head lookup took 101ms
gfs2: fsid=syz:syz.0: jid=0: Done
==================================================================
BUG: KASAN: slab-use-after-free in gfs2_withdraw_func+0x42/0x440 fs/gfs2/util.c:208
Read of size 8 at addr ffff888034454348 by task kworker/0:0/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events gfs2_withdraw_func
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 gfs2_withdraw_func+0x42/0x440 fs/gfs2/util.c:208
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5332:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x321/0x600 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 init_sbd fs/gfs2/ops_fstype.c:79 [inline]
 gfs2_fill_super+0x125/0x20d0 fs/gfs2/ops_fstype.c:1123
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1872
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x92/0x2a0 fs/super.c:1932
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3848
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5332:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x1c5/0x650 mm/slub.c:6802
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:751
 kill_block_super+0x44/0xa0 fs/super.c:1903
 deactivate_locked_super+0xbe/0x110 fs/super.c:586
 cleanup_mnt+0x3d3/0x460 fs/namespace.c:1317
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2272
 __queue_work+0xd07/0x10d0 kernel/workqueue.c:2448
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2501
 gfs2_end_log_write+0xcd/0x6c0 fs/gfs2/lops.c:212
 gfs2_log_submit_write+0x7e/0xb0 fs/gfs2/lops.c:245
 gfs2_write_log_header+0x775/0x950 fs/gfs2/log.c:894
 log_write_header+0x3d4/0x5f0 fs/gfs2/log.c:918
 gfs2_log_shutdown+0xbb/0x2b0 fs/gfs2/log.c:1325
 __gfs2_log_flush+0x16f9/0x1d90 fs/gfs2/log.c:1174
 gfs2_log_flush+0x34/0x50 fs/gfs2/log.c:1216
 gfs2_make_fs_ro+0x185/0x320 fs/gfs2/super.c:561
 gfs2_put_super+0x235/0x870 fs/gfs2/super.c:603
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:751
 kill_block_super+0x44/0xa0 fs/super.c:1903
 deactivate_locked_super+0xbe/0x110 fs/super.c:586
 cleanup_mnt+0x3d3/0x460 fs/namespace.c:1317
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888034454000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 840 bytes inside of
 freed 8192-byte region [ffff888034454000, ffff888034456000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34450
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b042280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b042280 dead000000000100 dead000000000122
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 04fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 15762288625
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2209/0x2280 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x217/0x5a0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7418
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x2c8/0x6c0 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x47b/0x720 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 acpi_ut_initialize_buffer+0xca/0x170 drivers/acpi/acpica/utalloc.c:-1
 acpi_rs_create_pci_routing_table+0x1c0/0xd90 drivers/acpi/acpica/rscreate.c:212
 acpi_rs_get_prt_method_data+0xdf/0x150 drivers/acpi/acpica/rsutils.c:456
 acpi_get_irq_routing_table+0x98/0xe0 drivers/acpi/acpica/rsxface.c:137
 acpi_pci_irq_find_prt_entry+0x163/0x1040 drivers/acpi/pci_irq.c:215
 acpi_pci_irq_lookup+0x45/0x690 drivers/acpi/pci_irq.c:299
 acpi_pci_irq_enable+0x1ee/0x7a0 drivers/acpi/pci_irq.c:414
 do_pci_enable_device+0x26f/0x4a0 drivers/pci/pci.c:2031
 pci_enable_device_flags+0x5ab/0x700 drivers/pci/pci.c:2122
page last free pid 55 tgid 55 ts 15754532717 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_pages_prepare+0x9eb/0xaf0 mm/page_alloc.c:1463
 __free_contig_range_common+0x174/0x340 mm/page_alloc.c:7072
 __free_contig_range mm/page_alloc.c:7117 [inline]
 free_pages_bulk+0x48/0x120 mm/page_alloc.c:5322
 vm_area_free_pages mm/vmalloc.c:3461 [inline]
 vfree+0x231/0x490 mm/vmalloc.c:3510
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3414
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888034454200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034454280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888034454300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888034454380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034454400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
