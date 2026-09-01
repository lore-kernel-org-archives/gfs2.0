Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE753371887
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248816; cv=pass; b=XUfB9I0e/MT83tI+y3y/oIpK10SrN0XUfTnf9oDRw4yWmzOatSa08cM8pq+r8/jI+G02wfoUv/xvSoQaP0PMZqVGFQAQ3TkFlavYcuc1xd+qmGHaHxOLudFVndxQ0W2jBNwJNlA5w64Lgr7oq7XhnVkF8fBAl8Qs1ob2DIGW+Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248816; c=relaxed/simple;
	bh=bChhXzbeBhbes45FfJAK24AsjmJ3Xgjhk77rbUpZzcY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BR/xBxm8de7LxT34FJLjHBxNbrR0drf8cwhjdleDSwdXwiUdPSepga9BpHsxrAeXlbSPYos+LyjFaGfPVkkqWKT8Flzfct7SvmmkuJ8W/E8iKF8JodxoeVX/ATyHJxOVupPZiiqOXFOXfmG+18WRvnVvid6nkJXcvTBGv939Acw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1W7l00X; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1W7l00X"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2020421077so666003066b.3
        for <gfs2@lists.linux.dev>; Tue, 01 Sep 2026 00:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788248813; cv=none;
        d=google.com; s=arc-20260327;
        b=PlHqWIUl6qLhtWBuvEvxZWQHbUP/MePhq4M3u55KrFn+zSmzxSeQtptp8s5d4mlRuU
         3rCWkTsk2WGtc9gtQFhVywzmVvQfOjV7ScdFdNgPXl4OJmBGXZv8GSjheEVzIhLz1rLv
         Y1bNU7Bj0dtEOWmBM0CS7a/QEGFt5CKbljwg6Jv+JUn/pEq3Vat3JauwCuF/kq5/fuqQ
         Ctwa1Xgch08tNlr5/OaNtlfwKyD+AmmybVIzuV/JqM+uFqNQJ7KESuDkp+ujScu+x3c/
         pkFsI/hpBZJdTmSh0BmGM1+1IOOefxOGpnctn+sGxxu01naTW2BTbHZHNyMJECoDDBGu
         XGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Ybk8qkBYVz+BvgMpglKGnqinvR4EkYYn1m3f60jBa+0=;
        fh=ssVmdmy+GJnZtMwlv1HnDiiCTg0ur4jiR4YdJJe+7nM=;
        b=dwM735aD6t8nf1tCIPXYv7n8AI430ELT3odIJ9NTIcuAmMZmMb0slFJODWXiMmr4Vk
         erTEXSHcejxC8UG3aomlDzv8hKirNswjx7khgk650xjf/gIQu8++0JI3CcAf6LHOA6fA
         pTVQLGRI9/AhvmGWi77cTaYuvW3FbcJcdSFm5Vrx8gIIwIvru5gYATbSHen+vTXnrdnN
         4DPoXJTH5H/GYmqQPNNWWCku1eR2wBKuEwBx5nbk6vWZC2l8MzkwQ/kAWzJ3SbpIkpls
         mJe+M9CIOQhZsO2XCNonv3+zWqIJC5LAaZSv9NNh08C5qduyLJATqIeg+L4qet+9zWj4
         klXQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788248813; x=1788853613; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ybk8qkBYVz+BvgMpglKGnqinvR4EkYYn1m3f60jBa+0=;
        b=B1W7l00XVi+QcIawAngKJS+Q8y67Y5Xs5PLrTL3pU3sMqQX9Rg5TRoDxMOw44DY192
         /S6XYSHk196YuPoBq3xEX3KLwoGP+IWGv9OUeywcxM6QNQkVHnXblgFREmZahvSbiG/9
         nojmWi7Cvk17SjHjxdJCO+eY2b9vmqXXMOMFhuse7M5ytspKoEOVCncxnZz31ctUFy+E
         4OzCiSN5DTEsaA+B2L8+KJkAhNGIcKniEpmcEozhD94wOZn/F7Qm5vFEFkKdDXdIO1x2
         7X6sn1xBfBZOgamlBJoBEysgvhQfGwCaUpaIsAUbJLaSFdDjpT8ADsXciCmlWmcoRGXN
         3yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248813; x=1788853613;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ybk8qkBYVz+BvgMpglKGnqinvR4EkYYn1m3f60jBa+0=;
        b=UEPif8lJvlsdmPmqFgR5YflrqzHbIJmivti7meofghzK+JhzsD248vnS58gkITLeWg
         m0RoDROguG3wSs0B50Danw0bJktKDEL/11cNMlDLSonaLS0tYHDIam1KcUf+6DyMsmqx
         L/r6Ov8mLQpSxG1InZllQ+c79huV50PANnaxC+iQbGS8z0pWjDHoQZJuryN7kq4/sFhC
         T8DRW+XAvU8ECl7eSVvXhjEGiXKDflZ9TIe1n/oDlVdZWJ2sn1qP24jlAk19tjoZgs60
         kZQl5lKpePokeuitw+cumDhVsrMbKda+TaRZRcgDAqV7lt9LY+uto98flFJWhgl43Jkf
         h0CQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsRughWMo7EuZKewO5QurG7uM3NmlvtcOuwQg0xZ7VI2DBp4DR4icz3rwgO22Bq1HTdSa9@lists.linux.dev
X-Gm-Message-State: AFuF++kkt/9YN+v0KnBqJAl/S3YOBJtA9wteKoCjRLFFpgfbEiXzglSa
	JfOZ4PrPUEqAanB7B+D2W4NsdylPhEwjGzN0pO8FFuyn1dz8L7a+hYcVSDojESFUDw4c8MasdQi
	TnpNdLgIiB9dFcsYQDrYydu7wSoxWk41CPClskJw=
X-Gm-Gg: AR+sD12kCG3qAGTAupnYGvoOSPlT9RDfq3baSdmMmSHkUbANOslTMEutyygIf/WMKBg
	LVYK7oKzZweDfj8Y/aeqRDbO0ZZWafJS8b+rwtq6+QumbBUqxQacTDG4SLSK6WQv2e3P1aYhfOP
	6Vgo0IEonwH0K7I6oeccZFOL1jvbz2KLMtlz9sEib03ryVJ9V60lV/DBr4Goe4ocuzlWEZX1DTd
	6CQ9JEyjjcC5g7PYn4UuB2nalyQaVfGP3jHOuX7zGyjHK8nI5qhbBAiSgg0rJ0xooV6aubJjYVA
	C9itkkk+wTZb8rpLC4kV7IbPJrhKNrTOPx5GrlU0ZsPVag==
X-Received: by 2002:a17:907:6d15:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c2556dab2c3mr2085222466b.9.1788248812456; Tue, 01 Sep 2026
 00:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Tue, 1 Sep 2026 15:46:11 +0800
X-Gm-Features: AcwNN1W-XgI-hDA_lO_Ex1bXkithzpHNQMY79nABhi6TQB1qx3O7SU0pWG_pBhc
Message-ID: <CANypQFa8u5Netk3O2-sb4fm3Mq8W7N292y8ZCP_YuZnrGtULiQ@mail.gmail.com>
Subject: [Linux Kernel Bug] KASAN: use-after-free Read in gfs2_rgrp_go_instantiate
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	r772577952@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We are writing to report an issue discovered in the GFS2 subsystem.  The
issue is reproducible on the latest version of linux (v7.3-rc1, commit
cee9395acd8043be0644b25c34bfa86623f2b935).  Below is the kernel report:

gfs2: fsid=syz:syz.0: Corruption found in quota_change0file: duplicate
identifier in slot 224440
gfs2: fsid=syz:syz.0: found 1 quota changes
==================================================================
BUG: KASAN: use-after-free in gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
BUG: KASAN: use-after-free in gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
BUG: KASAN: use-after-free in count_unlinked fs/gfs2/rgrp.c:1159 [inline]
BUG: KASAN: use-after-free in gfs2_rgrp_go_instantiate+0xb0d/0x1340
fs/gfs2/rgrp.c:1238
Read of size 8 at addr ffff888027516000 by task syz-executor199/9470

CPU: 0 UID: 0 PID: 9470 Comm: syz-executor199 Not tainted 7.3.0-rc1
#35 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x153/0x7e0 mm/kasan/report.c:482
 kasan_report+0x147/0x180 mm/kasan/report.c:595
 gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
 gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
 count_unlinked fs/gfs2/rgrp.c:1159 [inline]
 gfs2_rgrp_go_instantiate+0xb0d/0x1340 fs/gfs2/rgrp.c:1238
 gfs2_instantiate+0x168/0x220 fs/gfs2/glock.c:415
 gfs2_glock_holder_ready fs/gfs2/glock.c:1226 [inline]
 gfs2_glock_wait+0x1d4/0x2a0 fs/gfs2/glock.c:1246
 gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
 gfs2_inplace_reserve+0xc41/0x3330 fs/gfs2/rgrp.c:2093
 do_sync+0x616/0xc60 fs/gfs2/quota.c:962
 gfs2_quota_sync+0x359/0x460 fs/gfs2/quota.c:1372
 gfs2_sync_fs+0x4c/0xb0 fs/gfs2/super.c:662
 sync_filesystem+0xf1/0x240 fs/sync.c:56
 generic_shutdown_super+0x77/0x2d0 fs/super.c:748
 kill_block_super+0x44/0xa0 fs/super.c:1918
 deactivate_locked_super+0xbc/0x110 fs/super.c:603
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1317
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x708/0x22a0 kernel/exit.c:1008
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1151
 __do_sys_exit_group kernel/exit.c:1162 [inline]
 __se_sys_exit_group kernel/exit.c:1160 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1160
 x64_sys_call+0x18c6/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x170/0x540 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c39c96f2d
Code: Unable to access opcode bytes at 0x7f5c39c96f03.
RSP: 002b:00007ffc5256c978 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5c39c96f2d
RDX: 00000000000000e7 RSI: ffffffffffffffc0 RDI: 0000000000000001
RBP: 00007ffc5256c9d0 R08: 0000000000000000 R09: 000000000003b2e1
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 00007f5c39d6a600
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7effc363f
pfn:0x27516
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00009d6108 ffffea00009d86c8 0000000000000000
raw: 00000007effc363f 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask
0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 9361, tgid 9361
((udev-worker)), ts 96351902392
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x205/0x260 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x235b/0x23e0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x209/0x5a0 mm/page_alloc.c:5436
 alloc_pages_mpol+0x241/0x4a0 mm/mempolicy.c:2486
 folio_alloc_mpol_noprof+0x39/0x160 mm/mempolicy.c:2505
 vma_alloc_folio_noprof+0xdb/0x1e0 mm/mempolicy.c:2540
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 wp_page_copy mm/memory.c:4007 [inline]
 do_wp_page+0x119f/0x4b00 mm/memory.c:4472
 handle_pte_fault mm/memory.c:6582 [inline]
 __handle_mm_fault mm/memory.c:6707 [inline]
 handle_mm_fault+0x15a7/0x36d0 mm/memory.c:6876
 do_user_addr_fault+0xa7e/0x1360 arch/x86/mm/fault.c:1343
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x71/0xd0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
page last free pid 9361 tgid 9361 ts 103418286503 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 free_unref_folios+0xd80/0x14c0 mm/page_alloc.c:3022
 folios_put_refs+0x7b4/0x8a0 mm/folio.c:1034
 free_pages_and_swap_cache+0x25e/0x440 mm/swap_state.c:592
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu+0x3a2/0x680 mm/mmu_gather.c:424
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
 exit_mmap+0x473/0x9c0 mm/mmap.c:1328
 __mmput+0x118/0x430 kernel/fork.c:1193
 exit_mm+0x214/0x2e0 kernel/exit.c:614
 do_exit+0x69b/0x22a0 kernel/exit.c:996
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1151
 __do_sys_exit_group kernel/exit.c:1162 [inline]
 __se_sys_exit_group kernel/exit.c:1160 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1160
 x64_sys_call+0x18c6/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x170/0x540 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888027515f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027515f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027516000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888027516080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888027516100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

Following is the root cause analysis for this issue, note that the
analysis is performed with the assistance of LLM, but we try our best to
ensure the accuracy.

A rindex entry's ri_bitbytes is not checked against sb_bsize.
compute_bitstructs() splits ri_bitbytes across the blocks of the resource
group and gives the remainder to the last bitmap, whose length bi_bytes can
then exceed the size of the block that stores it. gfs2_bitfit() scans past
the end of that buffer, which KASAN reports as a use-after-free.

To fix this issue, a bitmap that does not fit in the block that holds it
should be rejected:

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 5988a165a830..689ff5a4e0df 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -804,6 +804,12 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
  bi->bi_blocks = bytes * GFS2_NBBY;
  }

+ /* A bitmap must fit in the block that holds it */
+ if (bytes > sdp->sd_sb.sb_bsize - bi->bi_offset) {
+ gfs2_consist_rgrpd(rgd);
+ return -EIO;
+ }
+
  bytes_left -= bytes;
  }


The kernel console output, kernel config, syzkaller reproducer, and C
reproducer are available at google drive:
https://drive.google.com/drive/folders/11t4bHrvlPdnH0bQi0R1QTc6btCaoTZQE?usp=sharing

Please let us know if any further information is required.

Best Regards,
Jiaming Zhang
