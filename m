Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE78209F22
	for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515647; cv=none; b=MdyYhUCjDKs7dr1FQ4KV4lK/mnhKztGv9sQ/eh3Zz1lWxlF5Ri7kFdV68in9hxWBKao99WxxCPb0zxiLWSoelPK6jvq+PMAV2YcQqglixvh9e/8/IghKewthxMjLCfAo9wnuJA38yKj947T15G1DP2yiEeGlLesLAtc/kzyKdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515647; c=relaxed/simple;
	bh=NAQiGk80VjqvbpuvESkzQU2kxGNl9rtN0DPNrl1lPuY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KGUuOTI++qCCb+oJM9U/1xtwYLqghfcButjD3u8aEVT2PvHOuUKLasL7A9Qk6zsUk0m1edjh7AkFcEKZyjF2gbcgHS0JljkcAhIstAC53JfPlEgKTkaXaCi6oKc1egxSxZiuLq9b+zzmNn0oVu64VJqcRtwNBMSsCp9iyOOCcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9cd0b54c1so16784465ab.0
        for <gfs2@lists.linux.dev>; Fri, 10 Jan 2025 05:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736515644; x=1737120444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s08zFBhTt0qHfwsDazKjwokyPbrwx7EUANv/++j6rz8=;
        b=TDs4oVn9SfM6JPZCuYJsHeSLHcp7Q/q3g8VTFmWrfAjhjhwOQmHL2brQ/tCmLmtQAH
         yzf998nOgJBp3dYrUVMoCsncpec7z6qrEBegmIYGaxFx3dtnaUED7laESi915c7krjOJ
         G+Scl361ivmmrRanBb0Hm6T9KbPue1PrEBGofebE2wqyewMOaKSCZwM+GTNRNSbrviFf
         UKyZNImHOT6AuUiz/om1d9k0OPn697iZIoiK6IQmL+Pd0AU1Z26aeDqrCNEiBvtc02xv
         Z8ciM6mM7cFxGnAKaMpc4bNMpkdeVYirvfw/kAfUZbPA24/pyLfN5SmgJDLe+XD3PERd
         XOhA==
X-Forwarded-Encrypted: i=1; AJvYcCUs0hvhFxDD+swHKsHPj0Q6Yw5Vsfvom2UtSNsOFHB3/L9TpySWYLk8osz6HR9iSYm4eJkn@lists.linux.dev
X-Gm-Message-State: AOJu0YwXzW8B8kRytkdi93BrDF+ryKmjVRLXm+lxLiK/xeyJsUTbHfWp
	K4Ac2jW+vl4XJKuRgF+VYScU5T0Ozc9SPZFr4jlbWv7QqwTnG6Js6Bn3VK4JCTacd2ED178eLfm
	HwXVUyUzSQyxAAWX18G/pYNFk7B9tS9TJCPaaywUHshiPSBvp9DysfFw=
X-Google-Smtp-Source: AGHT+IHGhNm/AVqUc/ustwbzKDIx0IY2mjX14gM9ktHN15scKlBJUxj4dtsF3x+uCZpD4Z2kiC6wTDAYiJnM09y5UpwRj6rWqmOW
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388b:b0:3bd:c7f5:41d2 with SMTP id
 e9e14a558f8ab-3ce3a86a560mr80140965ab.4.1736515644545; Fri, 10 Jan 2025
 05:27:24 -0800 (PST)
Date: Fri, 10 Jan 2025 05:27:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6781203c.050a0220.d0267.002a.GAE@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-out-of-bounds Write in rgblk_free
From: syzbot <syzbot+d5b53cf19f5ea6035afa@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bc21e701a6f MAINTAINERS: Remove Olof from SoC maintainers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f056c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5b53cf19f5ea6035afa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0bc21e70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2606f19b18d1/vmlinux-0bc21e70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05ceefcd2fcc/bzImage-0bc21e70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5b53cf19f5ea6035afa@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
==================================================================
BUG: KASAN: slab-out-of-bounds in rgblk_free+0x4bf/0x960 fs/gfs2/rgrp.c:2275
Write of size 2010 at addr ffff88803638b880 by task syz.0.0/5320

CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller-00012-g0bc21e701a6f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 rgblk_free+0x4bf/0x960 fs/gfs2/rgrp.c:2275
 __gfs2_free_blocks fs/gfs2/rgrp.c:2523 [inline]
 gfs2_free_meta+0x99/0x280 fs/gfs2/rgrp.c:2550
 ea_dealloc_unstuffed+0x7cf/0xb00 fs/gfs2/xattr.c:303
 ea_remove_unstuffed fs/gfs2/xattr.c:342 [inline]
 ea_set_remove_unstuffed+0x1cb/0x290 fs/gfs2/xattr.c:1086
 __gfs2_xattr_set+0x6f8/0xcf0 fs/gfs2/xattr.c:1217
 gfs2_xattr_set+0x35d/0x460 fs/gfs2/xattr.c:1258
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f08385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f090d6038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f2f08575fa0 RCX: 00007f2f08385d29
RDX: 00000000200001c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007f2f08401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f08575fa0 R15: 00007ffe07c008d8
 </TASK>

Allocated by task 5320:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x285/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 rgblk_free+0x3fe/0x960 fs/gfs2/rgrp.c:2273
 __gfs2_free_blocks fs/gfs2/rgrp.c:2523 [inline]
 gfs2_free_meta+0x99/0x280 fs/gfs2/rgrp.c:2550
 ea_dealloc_unstuffed+0x7cf/0xb00 fs/gfs2/xattr.c:303
 ea_remove_unstuffed fs/gfs2/xattr.c:342 [inline]
 ea_set_remove_unstuffed+0x1cb/0x290 fs/gfs2/xattr.c:1086
 __gfs2_xattr_set+0x6f8/0xcf0 fs/gfs2/xattr.c:1217
 gfs2_xattr_set+0x35d/0x460 fs/gfs2/xattr.c:1258
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x2af/0x430 fs/xattr.c:665
 path_setxattrat+0x440/0x510 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803638b800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 128 bytes inside of
 allocated 1024-byte region [ffff88803638b800, ffff88803638bc00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36388
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801ac41dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801ac41dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080080008 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea0000d8e201 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1135, tgid 1135 (kworker/u4:10), ts 73253366672, free_ts 73173839158
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xdb/0x2880 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_inform_bss+0x15f/0x1080 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0xec1/0x2070 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x3ce/0x5e80 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x3bb/0x720 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1969/0x2d70 net/mac80211/ibss.c:1607
page last free pid 5320 tgid 5319 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 stack_depot_save_flags+0x7c6/0x940 lib/stackdepot.c:674
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4317
 kvasprintf+0xdf/0x190 lib/kasprintf.c:25
 __kthread_create_on_node+0x1a9/0x3c0 kernel/kthread.c:445
 kthread_create_on_node+0xde/0x130 kernel/kthread.c:513
 init_threads+0x38/0x270 fs/gfs2/ops_fstype.c:1085
 gfs2_fill_super+0x2068/0x24d0 fs/gfs2/ops_fstype.c:1264
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff88803638bb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803638bb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803638bc00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88803638bc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803638bd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
