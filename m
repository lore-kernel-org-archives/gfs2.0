Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03541AC44D
	for <gfs2@lists.linux.dev>; Tue, 13 Jan 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274542; cv=none; b=EHV6bXxY92T+2sr7kLX86KAfPjyVXFZ/uRSLFdMVSu/QgLPHMV0a9lD2tDEJ4ah3lFXjd6QlN50A7KtL9/1LXle5v3/a+P67xEG3A8zWds0HWB0nBNk6I/5ZBNE2xAVNND4GSDBA051WnY1Viztneoa+n6fFOQdRj37edIhwOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274542; c=relaxed/simple;
	bh=lKR7AY4z5xoPB7Q6e3BXwFNPAyFlc73L8NdpOHwuVU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UFIuY3viWwvOSEuS3+Ibp23qUJ485nNson+sqCoFP7e80rVIYQst5xwn8dhRUvy249p1kkpR/eo/lf0R5eYukBULTlKOE0rdg87GjsZ1E4Jld/1Q+ftG5z9ya/PImt+Z0ZZwSFo/xPpEhiT8TkIJMOwkE/EyuscO74mJoOuKhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65b73eb22d2so8054666eaf.2
        for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 19:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768274539; x=1768879339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rz0nDXUBqPaqWQALw5EgBO1VOx7h9rLFkJ3Ln6Hvpo=;
        b=AhmEPKKvZpWLCT7thO2LhTBu9wh2h4NhOpVioJ3nGa8lumkyv6f/OAYUHDP+veewyy
         M9df53laBBeP7Wrv9seKptrpSNE2DAJFx56EiZq1g7EHrArDeeosR+4pp45GtOkzfCJJ
         JkgXIIh5rBGI9CKDbs/WDXKelIBRDhNaoTDjZpbyuEhhi16S5vOQ1JXcKEEWreuzMOaN
         /+6w0pvRTKh/xmtBBFaV60o70XP7pwEyOu4YZ9o3fxA8rpBS3VcnnSYCE6lFofkgclv7
         ZlnSJt2s/kTyHJ8yxL7c6D1upf92xU/lqGEZiR8BuTNrZO9FUQgoAI3QT3IyxY9POj7w
         sKww==
X-Forwarded-Encrypted: i=1; AJvYcCX0CFkk1ObI6WqAgRtvP3SH3KK9XV4wlHVo0Zl956allEg2j/2guwt/b1F2czCmzuBpZYf4@lists.linux.dev
X-Gm-Message-State: AOJu0YzjBqOJzZfBf4UPQXfAFTxyQBQOz8cbCOao6lxZt1A9gjFqdZdY
	oUUuIcEnrR4QyfBKX2NMw0SBlRF2TiJYQsPsewDRpCn2dawkx6f6WH7EDDGcsvlHDFyzzgvTyZk
	rc28QcwfgdMzmEed4mO9/IMPAmAgO1grcomadGW9O+6eQCvDexlcA3BrYP8k=
X-Google-Smtp-Source: AGHT+IFxqul7EjS45E89Rhpn68v33SWgMr2yeSdN9UUdJfXFLA2eWBbKCJUZe1QMOqb6adY1GoSBep0n4wLfUWCvfXmnLLaTJbwx
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1501:b0:65d:d0b:fd3d with SMTP id
 006d021491bc7-65f54ed1856mr8966379eaf.12.1768274539667; Mon, 12 Jan 2026
 19:22:19 -0800 (PST)
Date: Mon, 12 Jan 2026 19:22:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6965ba6b.050a0220.38aacd.0007.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_logd
From: syzbot <syzbot+749d3bbbb8e7c979e724@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b71e635feefc Merge tag 'cgroup-for-6.19-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120615fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=323fe5bdde2384a5
dashboard link: https://syzkaller.appspot.com/bug?extid=749d3bbbb8e7c979e724
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/050e17796fd0/disk-b71e635f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60a284938b94/vmlinux-b71e635f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/883a2deee354/bzImage-b71e635f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+749d3bbbb8e7c979e724@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in gfs2_withdrawn fs/gfs2/util.h:187 [inline]
BUG: KASAN: slab-use-after-free in gfs2_logd+0x189/0x1080 fs/gfs2/log.c:1295
Read of size 8 at addr ffff88802ea240a8 by task gfs2_logd/syz:s/15606

CPU: 0 UID: 0 PID: 15606 Comm: gfs2_logd/syz:s Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 gfs2_withdrawn fs/gfs2/util.h:187 [inline]
 gfs2_logd+0x189/0x1080 fs/gfs2/log.c:1295
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 15592:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5776
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 init_sbd fs/gfs2/ops_fstype.c:79 [inline]
 gfs2_fill_super+0x11f/0x21b0 fs/gfs2/ops_fstype.c:1121
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15592:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6878
 free_sbd fs/gfs2/ops_fstype.c:72 [inline]
 gfs2_fill_super+0x14ef/0x21b0 fs/gfs2/ops_fstype.c:1316
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802ea24000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 168 bytes inside of
 freed 8192-byte region [ffff88802ea24000, ffff88802ea26000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ea20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ffa7280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813ffa7280 dead000000000100 dead000000000122
head: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000ba8801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x528c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP), pid 14523, tgid 14522 (syz.5.1551), ts 1104103251109, free_ts 1104030934359
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
 prep_new_page mm/page_alloc.c:1865 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xe53/0x1820 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kvmalloc_node_noprof+0x6b6/0x920 mm/slub.c:7136
 lzo_alloc_workspace+0x143/0x2d0 fs/btrfs/lzo.c:97
 alloc_workspace_manager+0x16f/0x4b0 fs/btrfs/compression.c:795
 btrfs_alloc_compress_wsm+0x52/0xc0 fs/btrfs/compression.c:1123
 open_ctree+0x13a1/0x3d20 fs/btrfs/disk-io.c:3408
 btrfs_fill_super fs/btrfs/super.c:981 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1944 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2087 [inline]
 btrfs_get_tree+0x1061/0x1920 fs/btrfs/super.c:2121
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
page last free pid 14523 tgid 14522 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3886
 __slab_free+0x294/0x320 mm/slub.c:5952
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5270
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2498 [inline]
 do_sys_openat2+0xbc/0x200 fs/open.c:1426
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802ea23f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ea24000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802ea24080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88802ea24100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ea24180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
