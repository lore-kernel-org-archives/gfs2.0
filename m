Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990521767A
	for <gfs2@lists.linux.dev>; Mon,  8 Dec 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183647; cv=none; b=Pa60VNkaZ1sinCI0Wc/LjfKKmYDsobzY3d7W7ZAUUEZexGMY34UHNMTWdxzWWA5OeNrOlQgTDDzilPwqbazyy/IC7DrOSnvjsxfY+0Y6NON2WA/oJFec9iJ2PV6o2g71kjcMQAHsDwNUTQ6ntrBVvHck6t6uILoHOG/lWykzoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183647; c=relaxed/simple;
	bh=kzd/oZzprIhHSOjQUFDjQX+/721JGNpFEoBsVOIIheM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q4yvt4EHDqg245t4KZjD6dZ8PA4wzsttoujjDwKbLnPTPjK4jMJuTeMyhtwcNYSTv0eUxMZIKb0f612eyLBLmrnHWl7BU20bnSoARJU/pF8on/vfYkXsS8nga2/YLAEAKhI5MNQ/EwjakTQTFlQ0P3V0Knve11NgdSZ9pU/A21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65997ee5622so3154320eaf.1
        for <gfs2@lists.linux.dev>; Mon, 08 Dec 2025 00:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765183644; x=1765788444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1IpN2pmQ7ol4+J7MB/xS6YhjA2n80U+vKo8rOEL4NY=;
        b=eAuWLEUcLzM53hvSj1Cop4Onz+hmAqKaHA54rL6lR+/TnC0P9iXgA3F738FaDjVGky
         wn0J+yHocoR/jijWbAXaO0H45n219FmC6KA+huftUv7Rl5JqE69IK0kyI6vvqpS3uaN2
         CfZlHUDX52NI2xUi7TioBe6NLzj8eMPk6YmDBSs/HFFQiKiqgMcKg8xbTu+e9+Pcx2Di
         +GjRMujYnsyeGsp9O4f03jHiExjnnERCNgvHcm8jKU1cLlkEaKcBxs+CYnRH9ZEsSc5B
         C77KUCpnNDKmAUnF3K/0OgoLzNxY1ZbwFi5Jd8p4d6iJzJrefTHWnth/YYcRzybsA0Xd
         UkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmnDht0FB8MzbeV/2Tv/X7fcqDW1ODOWsbA1q15OcSj0J8MV3P+9e3FMx6/RIcOeL7ViBg@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb14lvuh9zLtly0ypSoOk0GdhuzRMYtI3h3JvLn6vb/YOJXR2G
	PzQu+faoKIeA/LXg7Wm/n46AS3ja5tsHSJrPEcXVum7KcKs4nMqWzzJhh3O+cbDAsOnbv/YjcYR
	kj8aZlHCicnDwFVi2IK9Y2YQF9dmCoPFK6qraDDRtEiwGBf4MNB6zt0HJUf4=
X-Google-Smtp-Source: AGHT+IET0/5G5dv0kZly2VOOV5QIpNyHCicrvyrrOsoWh+N7tVzup3wOK3nAJYhDBOet350wfuqT+/bNjUgDM3egPFFvDUhV2ogA
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d07:b0:659:9a49:8e8f with SMTP id
 006d021491bc7-6599a8c27c7mr2902981eaf.19.1765183644537; Mon, 08 Dec 2025
 00:47:24 -0800 (PST)
Date: Mon, 08 Dec 2025 00:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6936909c.a70a0220.38f243.0098.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_quotad
From: syzbot <syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2aa680df6806 Merge tag 'sound-6.19-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac701a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e44d84dbc04570e
dashboard link: https://syzkaller.appspot.com/bug?extid=4cb0d0336db6bc6930e9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1213bcc2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dcfbfa0a8815/disk-2aa680df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a6f7574c952/vmlinux-2aa680df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be0a631aa7d7/bzImage-2aa680df.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b2c257be04cf/mount_3.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11ffb192580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in gfs2_withdrawn fs/gfs2/util.h:187 [inline]
BUG: KASAN: slab-use-after-free in gfs2_quotad+0x19c/0x930 fs/gfs2/quota.c:1586
Read of size 8 at addr ffff8880754740a8 by task gfs2_quotad/syz/8747

CPU: 1 UID: 0 PID: 8747 Comm: gfs2_quotad/syz Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 gfs2_withdrawn fs/gfs2/util.h:187 [inline]
 gfs2_quotad+0x19c/0x930 fs/gfs2/quota.c:1586
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 8733:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3d5/0x6f0 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 init_sbd fs/gfs2/ops_fstype.c:79 [inline]
 gfs2_fill_super+0x11f/0x21b0 fs/gfs2/ops_fstype.c:1121
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1699
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1759
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8733:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6663 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6871
 free_sbd fs/gfs2/ops_fstype.c:72 [inline]
 gfs2_fill_super+0x14ef/0x21b0 fs/gfs2/ops_fstype.c:1316
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1699
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x2a0 fs/super.c:1759
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888075474000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 168 bytes inside of
 freed 8192-byte region [ffff888075474000, ffff888075476000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75470
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a027280 ffffea00009a8c00 dead000000000003
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a027280 ffffea00009a8c00 dead000000000003
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001d51c01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5660, tgid 5660 (dhcpcd-run-hook), ts 66112319039, free_ts 66011248304
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf2b/0x1960 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 __kmalloc_cache_noprof+0x411/0x6f0 mm/slub.c:5766
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x111f/0x1f70 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x340/0x1480 security/tomoyo/common.c:2198
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x149/0x1e0 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x15ce/0x1aa0 security/tomoyo/domain.c:888
 tomoyo_bprm_check_security+0x11c/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x89/0x270 security/security.c:794
 search_binary_handler fs/exec.c:1659 [inline]
 exec_binprm fs/exec.c:1701 [inline]
 bprm_execve+0x887/0x1400 fs/exec.c:1753
 do_execveat_common+0x510/0x6a0 fs/exec.c:1859
page last free pid 5655 tgid 5655 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2901
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3886
 put_cpu_partial+0x1f2/0x2d0 mm/slub.c:3961
 __slab_free+0x288/0x2a0 mm/slub.c:5947
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4948 [inline]
 slab_alloc_node mm/slub.c:5258 [inline]
 __do_kmalloc_node mm/slub.c:5651 [inline]
 __kmalloc_node_track_caller_noprof+0x51d/0x810 mm/slub.c:5759
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 bprm_change_interp+0x82/0xc0 fs/exec.c:1479
 load_script+0x6d0/0x860 fs/binfmt_script.c:125
 search_binary_handler fs/exec.c:1669 [inline]
 exec_binprm fs/exec.c:1701 [inline]
 bprm_execve+0x92e/0x1400 fs/exec.c:1753
 do_execveat_common+0x510/0x6a0 fs/exec.c:1859
 do_execve fs/exec.c:1933 [inline]
 __do_sys_execve fs/exec.c:2009 [inline]
 __se_sys_execve fs/exec.c:2004 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2004
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888075473f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888075474000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888075474080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888075474100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075474180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
