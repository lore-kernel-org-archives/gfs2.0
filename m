Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC081732;
	Thu, 20 Aug 2026 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184852; cv=none; b=rQV4u2jEIl2xGOKUpXCUAHu+vHKg8bQtQdRNx6YtrdncfDQmzvk+N2LTyuR2o+Bi2qTceiIuFhvkOC5wDSquiCDwe2P6RriwdAVggBZ+rxm0MMuLrGwOzHcjFhLYXERq0M9mUk7Bbw2zsrI60WkzC4T3HFn/uTeG3elcSeXo7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184852; c=relaxed/simple;
	bh=BwedfqMG2k0VErJWeElnhcQBn47fV0WmcYDpJ9LOkes=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I6tCgRg0iVctu4eezHVcR0+tifF74W/uQ4inseiHsWSJtVxxe08hS9IKVqP/L6T91p0SNAPpUtU3IwnhBJD6mQGnmJd0LlXryKgVZ5yPZWfW5Xy9+Z7r5U8cu8iyDYvzISQl2ymHWEK1Q6zRgubJCuhpGntdllVq6TUkwlFY+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EAoVIDTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EAoVIDTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA50E1F000E9;
	Thu, 20 Aug 2026 00:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787184850;
	bh=SWVI+GSgGh4hCFWcmCgPPS+9GFpBgLS6j7HiovZ615g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EAoVIDTONQzi2xvcOtoxAwsf3kxavm7K1DtkD/TId6smnEXdeGJRiaEKmYhcAdEX1
	 YPIGg3QZAOrOAOjxv+cIcer8vp94/C4tt9up2hpGMbxdyBFynvvfQ49Cwu/iz9Cz+o
	 c4N/73GK3ha8P0XL/A9qejq6JsdZ8W9p4LYj1qXM=
Date: Wed, 19 Aug 2026 17:14:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com>
Cc: apopple@nvidia.com, byungchul@sk.com, david@kernel.org,
 gfs2@lists.linux.dev, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 rakie.kim@sk.com, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] [gfs2?] WARNING in read_rindex_entry
Message-Id: <20260819171409.e30eed94c3f7eb44b38e5ec7@linux-foundation.org>
In-Reply-To: <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
References: <6a863306.ae6ddae5.3da009.0013.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 15:49:42 -0700 syzbot <syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10871279580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fdc3b566746377
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d20c3ad7d29227de28d
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14871279580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100d2a25580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c2a8c7d3a889/disk-15ef2f78.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2da78afed345/vmlinux-15ef2f78.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c4ffd97e4708/bzImage-15ef2f78.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/eaa4120812b6/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17f52a25580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com

Thanks.  Mounting an intentionally corrupted fs image, I assume.

It appears that GFS2 forgot to validate the `ri_length' which it read
from disk.  That gets used in compute_bitstructs()->kzalloc_objs() and
the memory allocator didn't like the excessively-sized allocation
attempt.

> gfs2: fsid=.: Now mounting FS (format 1801)...
> gfs2: fsid=..0: journal 0 mapped with 18 extents in 0ms
> gfs2: fsid=..0: first mount done, others may mount
> ------------[ cut here ]------------
> 1
> WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x2427/0x2dc0 mm/page_alloc.c:5280, CPU#1: syz-executor256/5629
> Modules linked in:
> CPU: 1 UID: 0 PID: 5629 Comm: syz-executor256 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
> RIP: 0010:__alloc_frozen_pages_noprof+0x2427/0x2dc0 mm/page_alloc.c:5280
> Code: e9 8d fb ff ff 31 d2 be 28 12 00 00 48 c7 c7 a0 64 e1 8b e8 5b 8c 69 ff 2e 2e 2e 31 c0 e9 02 ed ff ff c6 05 54 c1 9d 0e 01 90 <0f> 0b 90 e9 6f df ff ff 48 c7 c7 80 ae d3 8e 45 89 f7 44 8b 74 24
> RSP: 0018:ffffc9000345f0e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 1ffff9200068be36 RDI: 0000000000040d40
> RBP: 000000000000000b R08: 0000000000000005 R09: 0000000000000009
> R10: 000000000000000b R11: 0000000000000000 R12: 0000000000040d40
> R13: 1ffff9200068be74 R14: ffffffff9b759444 R15: 0000000000000001
> FS:  000055556d263400(0000) GS:ffff888123ee1000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055886dbe9978 CR3: 000000003394d000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0x1fb/0x540 mm/mempolicy.c:2490
>  ___kmalloc_large_node+0xe5/0x120 mm/slub.c:5274
>  __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5305
>  __do_kmalloc_node mm/slub.c:5322 [inline]
>  __kmalloc_noprof+0x5a1/0x820 mm/slub.c:5359
>  _kmalloc_noprof include/linux/slab.h:992 [inline]
>  _kzalloc_noprof include/linux/slab.h:1309 [inline]
>  compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
>  read_rindex_entry+0x4a1/0x1250 fs/gfs2/rgrp.c:931
>  gfs2_ri_update+0x6f/0x3b0 fs/gfs2/rgrp.c:1001
>  gfs2_rindex_update+0x40b/0x480 fs/gfs2/rgrp.c:1051
>  init_inodes+0x1f78/0x2790 fs/gfs2/ops_fstype.c:872
>  gfs2_fill_super+0x1d3d/0x2cf0 fs/gfs2/ops_fstype.c:1250
>  get_tree_bdev_flags+0x38c/0x620 fs/super.c:1640
>  gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1332
>  vfs_get_tree+0x92/0x320 fs/super.c:1700
>  fc_mount fs/namespace.c:1198 [inline]
>  do_new_mount_fc fs/namespace.c:3765 [inline]
>  do_new_mount fs/namespace.c:3841 [inline]
>  path_mount+0x7d0/0x23d0 fs/namespace.c:4161
>  do_mount fs/namespace.c:4174 [inline]
>  __do_sys_mount fs/namespace.c:4390 [inline]
>  __se_sys_mount fs/namespace.c:4367 [inline]
>  __x64_sys_mount+0x293/0x310 fs/namespace.c:4367
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff9e8de99ea
> Code: 56 53 b8 9d 00 00 00 0f 05 83 f8 ea 75 a2 c7 05 a4 30 0a 00 00 00 00 00 eb 96 e8 51 05 00 00 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc770eecc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffc770eece0 RCX: 00007ff9e8de99ea
> RDX: 0000200000000040 RSI: 0000200000000100 RDI: 00007ffc770eece0
> RBP: 0000200000000100 R08: 00007ffc770eed20 R09: 0000000000000000
> R10: 0000000000008cd3 R11: 0000000000000246 R12: 0000200000000040
> R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffc770eed20
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
