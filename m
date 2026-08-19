Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574C37A493
	for <gfs2@lists.linux.dev>; Wed, 19 Aug 2026 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179785; cv=none; b=IecTZAaEj5WYtltq0iJ0Bdnjq336/nBflRQSLpA7S4uef6aTSqcVcVh/9F6ik9BxLQjQWsIvLfOE2gGiidtcCqmrhX7khW92GJFtEbUJQImYDUNm1uQenSwXOh5YuWN5MJf2inyu73HHFamK1MYtu4dYaRCLhebzGFewz2ItkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179785; c=relaxed/simple;
	bh=l0IVb55Cm5rADMARpoDmuSQbcJbt0AcBxlqrvlSSfr0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ez4RwtSCq+G/DBLNDWdw3SgrRKqJmXVhIzqL3Edk4PDZQNg0NhgSY+C3kW8mC/F+7IUYD/nkxYZ/nd0N1MBHH8cKJa3tndqsqaDPf5kvG6tDwTTtGDcYGo1bQzrOCMZ6e7rYn0rUL1NK741PdmEtM0lK5emGRXbXXMXTq/JsDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f6.google.com with SMTP id 006d021491bc7-6b13d3220f3so356252eaf.0
        for <gfs2@lists.linux.dev>; Wed, 19 Aug 2026 15:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179782; x=1787784582;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCqoDLhjf0Dkjduz7a0RBFwdjE6QzDXkzBRoNUdCo+U=;
        b=EqfwiV6Qub8H+zgSGT/oRTrfFLaeGAX2XXbGTlL1nibpaqvXIqmkxBHV127wPcs6jL
         I9iIjvCvxOIbTAL4OIX6RXYf5v5QMxx1vUgiv6EgkUHaNmyS7xrdMXfQoNXMAr0eNpN2
         XyO+MvCtsv8opDiTTmEXTiKAqx5P5RAjO6Q/yo7ygqkSSZYsYhhMkkKUgO0OoKznGY1R
         FI2Qsjz9IGa0PEqiG52pRr9QmV4kw0sPoM7aHmnvo3NixWfsZ5QcE37u9iJt/iri969b
         vsQOEFPZ5TCDe/AEBQKAUsy9Zs4ME2Z47Dwg3czQgzZjN9B1OhSsghROxpkHsV8BG7xL
         pMtg==
X-Forwarded-Encrypted: i=1; AHgh+RrCaKWlQ5e2+CfCRKZvEIwJ3dJAIZXPWdPxoP9C0KHXTKQVWHySphABC7Ysoq5XozAvANW0@lists.linux.dev
X-Gm-Message-State: AOJu0YyTBtk+K7bB/ZS9kxjN/UGiK2n5R8fTfyMlSNeD9Ia3vg9mD3tN
	+aNn9ceETJZVtSttTNYUSqxMQvPrEH4RgJxygW2UY0ij6G93sfU92fOyQVa9+o4FbICTJ9By/Bk
	YUzFir4yaDp33S98LNctvzFPrQi/scJnLXtbj65Umrl6gNrEIHRWDX2U1jdE=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6aca:b0:6a3:a335:1ccd with SMTP id
 006d021491bc7-6b13c35fcb9mr8149031eaf.8.1787179782340; Wed, 19 Aug 2026
 15:49:42 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:49:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
Subject: [syzbot] [mm?] [gfs2?] WARNING in read_rindex_entry
From: syzbot <syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@kernel.org, gfs2@lists.linux.dev, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10871279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fdc3b566746377
dashboard link: https://syzkaller.appspot.com/bug?extid=9d20c3ad7d29227de28d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871279580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d2a25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2a8c7d3a889/disk-15ef2f78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2da78afed345/vmlinux-15ef2f78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4ffd97e4708/bzImage-15ef2f78.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eaa4120812b6/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17f52a25580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com

gfs2: fsid=.: Now mounting FS (format 1801)...
gfs2: fsid=..0: journal 0 mapped with 18 extents in 0ms
gfs2: fsid=..0: first mount done, others may mount
------------[ cut here ]------------
1
WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x2427/0x2dc0 mm/page_alloc.c:5280, CPU#1: syz-executor256/5629
Modules linked in:
CPU: 1 UID: 0 PID: 5629 Comm: syz-executor256 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__alloc_frozen_pages_noprof+0x2427/0x2dc0 mm/page_alloc.c:5280
Code: e9 8d fb ff ff 31 d2 be 28 12 00 00 48 c7 c7 a0 64 e1 8b e8 5b 8c 69 ff 2e 2e 2e 31 c0 e9 02 ed ff ff c6 05 54 c1 9d 0e 01 90 <0f> 0b 90 e9 6f df ff ff 48 c7 c7 80 ae d3 8e 45 89 f7 44 8b 74 24
RSP: 0018:ffffc9000345f0e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffff9200068be36 RDI: 0000000000040d40
RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000009
R10: 000000000000000b R11: 0000000000000000 R12: 0000000000040d40
R13: 1ffff9200068be74 R14: ffffffff9b759444 R15: 0000000000000001
FS:  000055556d263400(0000) GS:ffff888123ee1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055886dbe9978 CR3: 000000003394d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
 ___kmalloc_large_node+0xe5/0x120 mm/slub.c:5274
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5305
 __do_kmalloc_node mm/slub.c:5322 [inline]
 __kmalloc_noprof+0x5a1/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
 read_rindex_entry+0x4a1/0x1250 fs/gfs2/rgrp.c:931
 gfs2_ri_update+0x6f/0x3b0 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x40b/0x480 fs/gfs2/rgrp.c:1051
 init_inodes+0x1f78/0x2790 fs/gfs2/ops_fstype.c:872
 gfs2_fill_super+0x1d3d/0x2cf0 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev_flags+0x38c/0x620 fs/super.c:1640
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x92/0x320 fs/super.c:1700
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3765 [inline]
 do_new_mount fs/namespace.c:3841 [inline]
 path_mount+0x7d0/0x23d0 fs/namespace.c:4161
 do_mount fs/namespace.c:4174 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount fs/namespace.c:4367 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9e8de99ea
Code: 56 53 b8 9d 00 00 00 0f 05 83 f8 ea 75 a2 c7 05 a4 30 0a 00 00 00 00 00 eb 96 e8 51 05 00 00 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc770eecc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc770eece0 RCX: 00007ff9e8de99ea
RDX: 0000200000000040 RSI: 0000200000000100 RDI: 00007ffc770eece0
RBP: 0000200000000100 R08: 00007ffc770eed20 R09: 0000000000000000
R10: 0000000000008cd3 R11: 0000000000000246 R12: 0000200000000040
R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffc770eed20
 </TASK>


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
