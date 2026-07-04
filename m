Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78301AC45D
	for <gfs2@lists.linux.dev>; Sat,  4 Jul 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170076; cv=pass; b=UXzOARWjhFYTe1iOeBjdM4pni6uwwkAek5v1dJd8VzMRt4dWFUz3do4B7OvoETaWEAKCt97PCLK82z2+RYUXaTG2mGXRPIzX4ApNuDc3ZDBfwnoB/+7qbYXvUYdee61IB58b9981nf2KNken0t7hwAEsfpPvjPxJj3+bv8HoQd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170076; c=relaxed/simple;
	bh=+y2QlpYXy53LRbWin9QJ6rJK9fXdfFDdAoOAbP9HlTc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U++muMLEy27YlbPBijzIpvhWjTKuMXd902fH2ksYoJyq2gmdQkMqRgGxuw7tW9vocGGtnId2w5e+/uMFIcVfDBK83acKPQZPvQz+XpgofgupAY8bjT7bZyITeFKEc9/jOZ+/V5UoUp+2TrULd7zBgh/d8iqNRts6qhl2ANbmiTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+MC47L/; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+MC47L/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c125ba77577so133467466b.1
        for <gfs2@lists.linux.dev>; Sat, 04 Jul 2026 06:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783170073; cv=none;
        d=google.com; s=arc-20260327;
        b=VN3L2ZeJQzqrxepa+PnE7Ivf1RIWbzClxAq2jdpx1MUisOorlIevLmuM3T84oPbagR
         +sXfiiJiKXtBOi/pFomfjuJ62oMIicLBkbxDaPaFby1BsMkGoypqa/RLt4Q5K6miM7ew
         0tLIbx7FaEJw6Q99j7zqg/pOpuCdyGoYcq1FlTsYtUrLm/tukM+4RefPF6nHaSkAyAks
         dLmyM2bu9YQ4NYQYxwb0KNaJaDlz+D5emA9F6BVN7Bmhxp8zqS7xbJEkV3XgihVtc95l
         dUaReKJV9Hvca+m7uoNm8XJ+z66WGfinShbA5p1pzGExgXSaZQIsTSoViuyacD/J0hVp
         BJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=M7zBP98ZYrt8Md0RThUsxtlTD2O2BJbKN5AKe+vB6VE=;
        fh=xYF7pPvPiXfToGuNRqub8SywdIX15x4EtRA2S2ip9x0=;
        b=EVWJJ/M+olFR10ZGonSiUzslreWoxlodV6bo51my5Dg9nweCWvuD3NuTjqHdOed7jZ
         PSGNWrIEio/M+paxo0eK35pZT0Iq+wQJ6nGsvgwFdgV8xF2oOrLW+NJk10kWFrQP2XdW
         gz5b4lOs/pcgfCMu92ImTm4whW5Uj/I3wq95Lhw86jtz3UBkABsOZi9Yhl6/pNEX4NtO
         yiVUEg7fMGgqrjuJ8sN6GQ7xCqrj6QsdwjI8YS7iQelItTNn1u1QW/kCdbtGYoARmUq4
         0cktZtHO93lw1hyzTyaBGZIYqrqFGWCtMNA85jlj4Zw6xiOGnIhCHSHVVO0WFvPzCsS9
         ESpg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783170073; x=1783774873; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M7zBP98ZYrt8Md0RThUsxtlTD2O2BJbKN5AKe+vB6VE=;
        b=N+MC47L/Ot0c4+JANiGHbA9Bs0l1df4vgAi7v6oBbPTramTtfmnB135TIdkpGPurPn
         /czTqXPl6s4s6dNqmbnaaqOZF1mG8ujFsbiuMKW8H8tg3d+6K3QddggGlEWEHqqasGP6
         bR1QIpdK/u3I/I/oE6woN2NoiFrH9o8ZZL3yJE7FXnIJ/ykgvXTLK7yuwz3jSX8mWq9D
         wpv6VeKPohhny1q6m0niKhVXEXQvggxsUH0bc9Ey8HQzknLAH15c+EmT4/g76dnpOvWq
         b2cX729XIWwa1tnejOFK66ScTr1pnKRNVwa4d7lSDBgUMhCz7/g62wO6FOhbjjrX5e76
         GYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783170073; x=1783774873;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7zBP98ZYrt8Md0RThUsxtlTD2O2BJbKN5AKe+vB6VE=;
        b=I1DIMRsmixAwNAOV/Udkttflm1VXfJQUCxQ32ESgHB0IYl7iXiC/r8KJVmAt1puIE0
         6nfYc5vp2Be131ysuMiHjrzuN1ovYzCfDr9fgR651M7UmwrsMprCdKvp570c332bvzIV
         qjbxfVKgfUvq4rBUj4MJO5EQBJz9vn9vAwVXxzF80w3fEYCufdCofA+a1Znvzt1x0Xi2
         yPgnygwvo1Z/n8eGKRLpNOhV3WhZ500PN9NafxmvkFOb1BxiNkZc0Vj6OhXoYLd9HWpf
         gJV8hOeSnYadkvbWJlzNPr4mvIx49tWMojl23shH8/N9iIADiiD8mS/BQSQ/G3lIFWxs
         p44g==
X-Forwarded-Encrypted: i=1; AHgh+Rpyw5ODO3ZYfjklqO+aU5wrnD/o/dvTn4eL5zgeyMLGVsQ3ZT8qU67sXmS+vGyDin9yEtGW@lists.linux.dev
X-Gm-Message-State: AOJu0YxNzQQyhns5N/iRFlLR7cUNgHBFBMzlD9cEYP7IERflCBK0il6r
	qefjEyky7O9UG1AyU7cljg46wdzuKzRbw07LCDHGnRIJX/mQ9VgJ8M3bIoVimanFgOjVwY9P7Gf
	EwSYzxSSgu6TUE4BJ+0pXB92yO5DY+RaP3Tnspr0=
X-Gm-Gg: AfdE7cktVpB+24K2ezhRq2saUqVJP9oTv2k4xOksayxipm0i6rZ5PGzAtN26U1mSv3v
	vNfxbEmT9/vJF2nTbLjQCsNuv3FQB6YxYK/V2Qs60Sq9+JsRrX5LFzPsxuYMRw+CTtbQVh7kqZX
	sRBGzHySWqMLztyfcR2K+7w+L5pVQYctVyBHzEFL3XcoohacWRzsk20a5gOXcPMcujSVSZZ+gAV
	9AJDN7yq7ZgyygCPdaCmbIx4NRtnWElKxGsU1vznw/hkYWBZ4S8R/h8f3e5f0E6t4XRNCjjIQ==
X-Received: by 2002:a17:906:4fd4:b0:bee:f541:1dca with SMTP id
 a640c23a62f3a-c12e6ad3dffmr107850866b.28.1783170072783; Sat, 04 Jul 2026
 06:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 4 Jul 2026 21:00:33 +0800
X-Gm-Features: AVVi8CdYd7VaQ7lol0gT7wZ58qlgopMgv1JifFg5Tyl75AEn6h3UjKYGhKXokeE
Message-ID: <CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQqco4gjdmKVbdURg@mail.gmail.com>
Subject: [Linux Kernel Bug] KASAN: out-of-bounds Read in gfs2_unstuff_dinode
To: agruenba@redhat.com, gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We are writing to report a out-of-bounds issue discovered in the GFS2
subsystem. The issue is reproducible on the latest version of linux
(v7.2-rc1, commit dc59e4fea9d83f03bad6bddf3fa2e52491777482). Below is
the KASAN report:

---
==================================================================
BUG: KASAN: out-of-bounds in gfs2_unstuffer_folio fs/gfs2/bmap.c:63 [inline]
BUG: KASAN: out-of-bounds in __gfs2_unstuff_inode fs/gfs2/bmap.c:119 [inline]
BUG: KASAN: out-of-bounds in gfs2_unstuff_dinode+0x47c/0x1320 fs/gfs2/bmap.c:166
Read of size 9223372036854775984 at addr ffff888055ebb0e8 by task
gfs2_quotad/syz/9468

CPU: 0 UID: 0 PID: 9468 Comm: gfs2_quotad/syz Not tainted 7.2.0-rc1 #6
PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x153/0x7e0 mm/kasan/report.c:482
 kasan_report+0x147/0x180 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 gfs2_unstuffer_folio fs/gfs2/bmap.c:63 [inline]
 __gfs2_unstuff_inode fs/gfs2/bmap.c:119 [inline]
 gfs2_unstuff_dinode+0x47c/0x1320 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x219/0x800 fs/gfs2/quota.c:862
 do_sync+0x83d/0xc60 fs/gfs2/quota.c:976
 gfs2_quota_sync+0x359/0x460 fs/gfs2/quota.c:1372
 gfs2_quotad+0x3d5/0x930 fs/gfs2/quota.c:1620
 kthread+0x389/0x480 kernel/kthread.c:436
 ret_from_fork+0x509/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:ffff88804ea391e8 index:0x924 pfn:0x55ebb
memcg:ffff88801a49df80
aops:gfs2_meta_aops ino:1
flags: 0x4fff10000004004(referenced|private|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff10000004004 0000000000000000 dead000000000122 ffff88804ea391e8
raw: 0000000000000924 ffff888028fc3d20 00000003ffffffff ffff88801a49df80
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask
0x148c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL),
pid 9468, tgid 9468 (gfs2_quotad/syz), ts 216653316768, free_ts
216343012715
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x205/0x260 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x236a/0x23f0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5304
 alloc_pages_mpol+0x235/0x490 mm/mempolicy.c:2490
 alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
 alloc_pages_noprof+0xad/0x2b0 mm/mempolicy.c:2581
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2591
 filemap_alloc_folio_noprof+0x107/0x470 mm/filemap.c:1013
 __filemap_get_folio_mpol+0x402/0xf80 mm/filemap.c:2012
 __filemap_get_folio include/linux/pagemap.h:761 [inline]
 gfs2_getbuf+0x181/0x6d0 fs/gfs2/meta_io.c:145
 gfs2_meta_read+0xfa/0x890 fs/gfs2/meta_io.c:272
 gfs2_meta_buffer+0x118/0x2e0 fs/gfs2/meta_io.c:459
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:69 [inline]
 gfs2_inode_refresh fs/gfs2/glops.c:487 [inline]
 inode_go_instantiate+0xe4/0x12a0 fs/gfs2/glops.c:512
 gfs2_instantiate+0x168/0x220 fs/gfs2/glock.c:442
 gfs2_glock_holder_ready fs/gfs2/glock.c:1250 [inline]
 gfs2_glock_wait+0x1d4/0x2a0 fs/gfs2/glock.c:1270
 gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
 do_sync+0x465/0xc60 fs/gfs2/quota.c:938
 gfs2_quota_sync+0x359/0x460 fs/gfs2/quota.c:1372
page last free pid 9459 tgid 9459 stack trace:
 page_expected_state mm/page_alloc.c:1035 [inline]
 free_page_is_bad mm/page_alloc.c:1074 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 free_unref_folios+0xd4d/0x1480 mm/page_alloc.c:3011
 folios_put_refs+0x7b4/0x8a0 mm/swap.c:1045
 free_pages_and_swap_cache+0x3d6/0x440 mm/swap_state.c:589
 tlb_get_unmap_shift include/asm-generic/tlb.h:545 [inline]
 tlb_flush arch/x86/include/asm/tlb.h:16 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:509 [inline]
 tlb_table_invalidate mm/mmu_gather.c:338 [inline]
 tlb_table_flush mm/mmu_gather.c:376 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:415 [inline]
 tlb_flush_mmu+0x3a2/0x680 mm/mmu_gather.c:424
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
 unmap_region+0x272/0x2e0 mm/vma.c:491
 vms_clear_ptes mm/vma.c:1303 [inline]
 vms_complete_munmap_vmas+0x474/0xc20 mm/vma.c:1345
 do_vmi_align_munmap+0x3ed/0x440 mm/vma.c:1604
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1652
 __vm_munmap+0x207/0x390 mm/vma.c:3288
 __do_sys_munmap mm/mmap.c:1079 [inline]
 __se_sys_munmap mm/mmap.c:1076 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1076
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x184/0x5c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888055ebaf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888055ebb000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888055ebb080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                                          ^
 ffff888055ebb100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888055ebb180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
---

Following is the root cause analysis for this issue, note that
analysis is performed with the assistance of LLM, it maybe inaccurate.

The root cause for this issue is that, given a crafted GFS2 image,
which contains an invalid dinode size large enough to exceed what VFS
i_size can represent. gfs2_dinode_in() stores the on-disk u64 di_size
directly through i_size_write(). When the value is greater than
S64_MAX, the incore i_size becomes negative. This bypasses the
existing stuffed inode check:

if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip))

Later, quotad tries to unstuff the quota inode. gfs2_unstuffer_folio()
reads that negative i_size into a u64 and passes it to memcpy(), which
turns the size into a huge value and triggers the out-of-bounds.

A potential fix is as follows:

```
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..89c46c1d622c 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -52,16 +52,15 @@ static int punch_hole(struct gfs2_inode *ip, u64
offset, u64 length);
  * Returns: errno
  */
 static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct
buffer_head *dibh,
-                  u64 block, struct folio *folio)
+                  u64 block, struct folio *folio, size_t size)
 {
    struct inode *inode = &ip->i_inode;

    if (!folio_test_uptodate(folio)) {
        void *kaddr = kmap_local_folio(folio, 0);
-       u64 dsize = i_size_read(inode);
-
-       memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
-       memset(kaddr + dsize, 0, folio_size(folio) - dsize);
+
+       memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), size);
+       memset(kaddr + size, 0, folio_size(folio) - size);
        kunmap_local(kaddr);

        folio_mark_uptodate(folio);
@@ -92,9 +91,15 @@ static int __gfs2_unstuff_inode(struct gfs2_inode
*ip, struct folio *folio)
    struct buffer_head *bh, *dibh;
    struct gfs2_dinode *di;
    u64 block = 0;
+   loff_t size = i_size_read(&ip->i_inode);
    int isdir = gfs2_is_dir(ip);
    int error;

+   if (unlikely(size < 0 || size > gfs2_max_stuffed_size(ip))) {
+       gfs2_consist_inode(ip);
+       return -EIO;
+   }
+
    error = gfs2_meta_inode_buffer(ip, &dibh);
    if (error)
        return error;
@@ -116,7 +121,8 @@ static int __gfs2_unstuff_inode(struct gfs2_inode
*ip, struct folio *folio)
                          dibh, sizeof(struct gfs2_dinode));
            brelse(bh);
        } else {
-           error = gfs2_unstuffer_folio(ip, dibh, block, folio);
+           error = gfs2_unstuffer_folio(ip, dibh, block, folio,
+                            size);
            if (error)
                goto out_brelse;
        }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 28f32424ee64..33575fa681f5 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip,
const void *buf)
    umode_t mode = be32_to_cpu(str->di_mode);
    struct inode *inode = &ip->i_inode;
    bool is_new = inode_state_read_once(inode) & I_NEW;
+   u64 size = be64_to_cpu(str->di_size);

    if (unlikely(ip->i_no_addr != be64_to_cpu(str->di_num.no_addr))) {
        gfs2_consist_inode(ip);
        return -EIO;
    }
+   if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {
+       gfs2_consist_inode(ip);
+       return -EIO;
+   }
    if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
        gfs2_consist_inode(ip);
        return -EIO;
@@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip,
const void *buf)
    i_uid_write(inode, be32_to_cpu(str->di_uid));
    i_gid_write(inode, be32_to_cpu(str->di_gid));
    set_nlink(inode, be32_to_cpu(str->di_nlink));
-   i_size_write(inode, be64_to_cpu(str->di_size));
+   i_size_write(inode, size);
    gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
    atime.tv_sec = be64_to_cpu(str->di_atime);
    atime.tv_nsec = be32_to_cpu(str->di_atime_nsec);
@@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip,
const void *buf)
        return -EIO;
    }

-   if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(ip)) {
+   if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
        gfs2_consist_inode(ip);
        return -EIO;
    }
```

After applying the above patch, the reproducer no longer triggers the
issue on my machine.

If this solution is acceptable, we are happy to submit a formal patch.

The kernel console output, kernel config, syzkaller reproducer, and C
reproducer are available at google drive:
https://drive.google.com/drive/folders/1ccoNwjIK2rwJOzuq6tJXEnxFdwIDgw-3?usp=sharing

Please let me know if any further information is required.

Best Regards,
Jiaming Zhang
