Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0F1CA85
	for <gfs2@lists.linux.dev>; Sun, 16 Jun 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563179; cv=none; b=nqdUpXuIZq2uq568dMpVUKmc84Q9+BBePFey9rp9J2i3kDZQZJrke6YJtEOcTYMTlwHgmKsbe6bpoF0Z/JDvDT6y7X/97qtZnQ7bfDZcTw5ekABFQgU/bj88/AWBBCD/s5NjhKtCslPx/Ntl4jYYPCAbs6CMF80wFEY4SEKByd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563179; c=relaxed/simple;
	bh=/G4aNnkHL8BKKpL0cwbl5gPc5z1AVOIpFwjJYrxzmXk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sSBOG35sX3hL9vEmcXLIhx8pKdFn7n54iwi2+6DxEBUdfoaklod9ruFoLxqqHMnJ/aCZ1QZiR4WMw9RZXUwxprjVpvZAs1q6SJfLRtUcTh9Z4ef8MTiLtfrwZijupLTOZU6hO0xvg+rcrDrL/183zHMAhyHFx6IP/IeyasTpXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBCgTt9j; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBCgTt9j"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6325b04c275so20257217b3.3
        for <gfs2@lists.linux.dev>; Sun, 16 Jun 2024 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718563176; x=1719167976; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dBSl06qJo9WqlcLCJnHJhoAsogpiHmjtS8y3UqH/+k=;
        b=VBCgTt9ju8XQd7XL4NjDbOX1k4EdGnkQvKG+O9mjLEVyRfijSlYMvfNNZEywTk3vz+
         15xkXi86NQify24HMUA2dA0FCjLlM1nqgSqykUzh/vtSVhybs0rty2IOQqYIc/CwyaWd
         ZZe+7QlwGdzEIs+wHin93nIgMrF5ygFr2XIsesjLNWYSD5Wp4abK/YQn9mAi0qThAEaa
         /+r5o5h9G0d8oW8jtWkhINRauXGvlup7OcEWoDcOAFgH5WTLPfngUZikwG5tRJ76cDfv
         KxdvBfYYuXDYNL4/pd1lGW6hCXBbH2tBtjDlG42aNJMs4UVzv7xE9VjfgF+8G9bV8wX3
         EcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718563176; x=1719167976;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dBSl06qJo9WqlcLCJnHJhoAsogpiHmjtS8y3UqH/+k=;
        b=kgNZqV9KWekRzJggSbUfSQ9fwqaOcnb5PHs3PxMXQx6CclVZxmGs5b1GFAduRamP12
         SOk0sniVGd0yv1INm2ewTbFKMjUy7OQnaYu9xNt26IMJcd1KjzxN7G3Mk6ij3iQsV6+J
         F0vxcGfqBia/1n+wzvs7tbf1p5DXfDNrAqxOK2EbowYbq9wWyz5MZnCJEuRXBTWs0dFz
         W7hefmwG7svwTFTBpM+uv18L4dvA2AFygmiik+g7mNd6Km6yjOXuJrGFHP6EY/jRDaEm
         7oiW1z+ibLC13Zc7OzYgT7gG/c+dNCi5Ad8z3r34ElnxPrdQG773Cxbn9FKD5Es4+dZL
         mcyw==
X-Gm-Message-State: AOJu0YwdabnUAak80yBzQtdZbrL6R3sZhFkPxxJAnprEWBWjkU6bOd7T
	BuV/HzhqBUTRv81zq2UyVM+U9OYKHlDL1SZ66icg4c4fzuURyevTo0yB2xGjZQM=
X-Google-Smtp-Source: AGHT+IHllHBEFQ/LRwlTVTg49AyukzQWYrrDxCc6xs6p+B7PVO2zBLAIAD3q+tzIE+Ha86yVkFTHig==
X-Received: by 2002:a81:5c56:0:b0:610:b464:9f1a with SMTP id 00721157ae682-63224321323mr72687657b3.45.1718563176203;
        Sun, 16 Jun 2024 11:39:36 -0700 (PDT)
Received: from smtpclient.apple ([2601:98a:4102:7e80:2c22:6bd5:784c:5f44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c1ff4fsm46687146d6.47.2024.06.16.11.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2024 11:39:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Follow-Up on Reported Kernel Bug KASAN: slab-out-of-bounds in
 gfs2_invalidate_folio 
From: Shuangpeng Bai <shuangpengbai@gmail.com>
In-Reply-To: <560390DD-0A30-43DB-BB5B-69BCEBF4F3B0@gmail.com>
Date: Sun, 16 Jun 2024 14:39:24 -0400
Cc: gfs2@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <62179000-BA08-4033-B6AE-EF3D2A4A0EA6@gmail.com>
References: <560390DD-0A30-43DB-BB5B-69BCEBF4F3B0@gmail.com>
To: agruenba@redhat.com
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Dear Kernel Maintainers,

I hope this message finds you well.

I am writing to follow up on the recent bug report KASAN: =
slab-out-of-bounds in gfs2_invalidate_folio. I was wondering if there =
have been any updates or progress on this issue. Additionally, please =
let me know if there is any assistance I can provide.

Thank you for your time and attention to this matter.

Best regards,
Shuangpeng

> On May 13, 2024, at 22:50, Shuangpeng Bai <shuangpengbai@gmail.com> =
wrote:
>=20
> Hi Kernel Maintainers,
>=20
> Our tool found a new kernel bug KASAN: slab-out-of-bounds in =
gfs2_invalidate_folio. Please see the details below.
>=20
> Kenrel commit: v6.8
> Kernel config: attachment
> C/Syz reproducer: attachment
>=20
>=20
> Best,
> Shuangpeng
>=20
> <repro.c><.config>
>=20
> [   94.491083][ T8162] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 94.492323][ T8162] BUG: KASAN: slab-out-of-bounds in =
gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [   94.493520][ T8162] Read of size 8 at addr ffff888154826a20 by task =
a.out/8162
> [   94.494581][ T8162]
> [   94.494936][ T8162] CPU: 1 PID: 8162 Comm: a.out Not tainted 6.8.0 =
#6
> [   94.495886][ T8162] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [   94.497147][ T8162] Call Trace:
> [   94.497621][ T8162]  <TASK>
> [ 94.498059][ T8162] dump_stack_lvl (lib/dump_stack.c:107 =
(discriminator 1))=20
> [ 94.498745][ T8162] print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:488)=20
> [ 94.499411][ T8162] ? __phys_addr (arch/x86/mm/physaddr.c:32 =
(discriminator 4))=20
> [ 94.500066][ T8162] ? gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.500852][ T8162] kasan_report (mm/kasan/report.c:603)=20
> [ 94.501469][ T8162] ? gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.502233][ T8162] gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.502987][ T8162] ? _raw_spin_lock_irqsave =
(./arch/x86/include/asm/atomic.h:115 =
./include/atomic/atomic-arch-fallback.h:2164 =
./include/atomic/atomic-instrumented.h:1296 =
./include/asm-generic/qspinlock.h:111 ./include/spinlock.h:187 =
./include/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)=20
> [ 94.503730][ T8162] ? __pfx_gfs2_invalidate_folio =
(fs/gfs2/aops.c:635)=20
> [ 94.504521][ T8162] truncate_cleanup_folio (mm/truncate.c:158 =
mm/truncate.c:178)=20
> [ 94.505281][ T8162] truncate_inode_pages_range (mm/truncate.c:357 =
(discriminator 3))=20
> [ 94.506110][ T8162] ? __pfx_truncate_inode_pages_range =
(mm/truncate.c:322)=20
> [ 94.506984][ T8162] ? __x64_sys_exit_group (kernel/exit.c:1029)=20
> [ 94.507707][ T8162] ? do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.508374][ T8162] ? entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [ 94.509247][ T8162] ? _raw_spin_unlock_irqrestore =
(./arch/x86/include/asm/preempt.h:103 ./include/spinlock_api_smp.h:152 =
kernel/locking/spinlock.c:194)=20
> [ 94.510071][ T8162] ? debug_object_active_state =
(lib/debugobjects.c:946)=20
> [ 94.510953][ T8162] gfs2_evict_inode (fs/gfs2/super.c:1509)=20
> [ 94.511707][ T8162] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 94.512528][ T8162] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/atomic/atomic-arch-fallback.h:2164 =
./include/atomic/atomic-instrumented.h:1296 =
./include/asm-generic/qspinlock.h:111 ./include/spinlock.h:187 =
./include/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 94.513249][ T8162] ? __inode_wait_for_writeback =
(fs/fs-writeback.c:1487)=20
> [ 94.514183][ T8162] ? __pfx___inode_wait_for_writeback =
(fs/fs-writeback.c:1487)=20
> [ 94.515126][ T8162] ? __pfx_wake_bit_function =
(kernel/sched/wait_bit.c:22)=20
> [ 94.515982][ T8162] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 94.516789][ T8162] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 94.517614][ T8162] ? wb_io_lists_depopulated (fs/fs-writeback.c:100 =
(discriminator 1))=20
> [ 94.518465][ T8162] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 94.519296][ T8162] evict (fs/inode.c:670)=20
> [ 94.519915][ T8162] iput.part.0 (fs/inode.c:1739 fs/inode.c:1765)=20
> [ 94.520609][ T8162] ? __pfx_gfs2_drop_inode (fs/gfs2/super.c:1025)=20
> [ 94.521429][ T8162] iput (fs/inode.c:1767)=20
> [ 94.522007][ T8162] gfs2_kill_sb (./include/sched.h:1984 =
fs/gfs2/ops_fstype.c:1770 fs/gfs2/ops_fstype.c:1793)=20
> [ 94.522720][ T8162] deactivate_locked_super (fs/super.c:433 =
fs/super.c:474)=20
> [ 94.523598][ T8162] deactivate_super (fs/super.c:507)=20
> [ 94.524372][ T8162] cleanup_mnt (fs/namespace.c:144 =
fs/namespace.c:1268)=20
> [ 94.525113][ T8162] task_work_run (kernel/task_work.c:181 =
(discriminator 1))=20
> [ 94.525847][ T8162] ? __pfx_task_work_run (kernel/task_work.c:148)=20
> [ 94.526638][ T8162] ? __put_net (net/core/net_namespace.c:667)=20
> [ 94.527324][ T8162] do_exit (kernel/exit.c:872)=20
> [ 94.527984][ T8162] ? __count_memcg_events (mm/memcontrol.c:722 =
mm/memcontrol.c:961)=20
> [ 94.528842][ T8162] ? __pfx_do_exit (kernel/exit.c:812)=20
> [ 94.529564][ T8162] ? __pfx__raw_spin_lock_irq =
(kernel/locking/spinlock.c:169)=20
> [ 94.530422][ T8162] ? zap_other_threads (kernel/signal.c:1389)=20
> [ 94.531215][ T8162] do_group_exit (kernel/exit.c:1001)=20
> [ 94.531965][ T8162] __x64_sys_exit_group (kernel/exit.c:1029)=20
> [ 94.532802][ T8162] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.533517][ T8162] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [   94.534478][ T8162] RIP: 0033:0x7f162e2ee146
> [ 94.535174][ T8162] Code: Unable to access opcode bytes at =
0x7f162e2ee11c.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   94.536235][ T8162] RSP: 002b:00007ffc8b584d98 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
> [   94.537548][ T8162] RAX: ffffffffffffffda RBX: 00007f162e3f38a0 =
RCX: 00007f162e2ee146
> [   94.538770][ T8162] RDX: 0000000000000001 RSI: 000000000000003c =
RDI: 0000000000000001
> [   94.539757][ T8162] RBP: 0000000000000001 R08: 00000000000000e7 =
R09: ffffffffffffff80
> [   94.540522][ T8162] R10: 0000000000000002 R11: 0000000000000246 =
R12: 00007f162e3f38a0
> [   94.541285][ T8162] R13: 0000000000000001 R14: 00007f162e3fc2e8 =
R15: 0000000000000000
> [   94.542056][ T8162]  </TASK>
> [   94.542359][ T8162]
> [   94.542595][ T8162] Allocated by task 8162:
> [ 94.543016][ T8162] kasan_save_stack (mm/kasan/common.c:48)=20
> [ 94.543491][ T8162] kasan_save_track =
(./arch/x86/include/asm/current.h:42 mm/kasan/common.c:60 =
mm/kasan/common.c:69)=20
> [ 94.543956][ T8162] __kasan_kmalloc (mm/kasan/common.c:370 =
mm/kasan/common.c:387)=20
> [ 94.544467][ T8162] __kmalloc (./include/kasan.h:211 mm/slub.c:3981 =
mm/slub.c:3994)=20
> [ 94.544500][ T8162] ifs_alloc.isra.0 (fs/iomap/buffered-io.c:167)=20
> [ 94.545641][ T8162] iomap_do_writepage (fs/iomap/buffered-io.c:138 =
fs/iomap/buffered-io.c:1793 fs/iomap/buffered-io.c:1975)=20
> [ 94.546152][ T8162] write_cache_pages (./include/page-flags.h:785 =
./include/page-flags.h:806 ./include/mm.h:2059 mm/page-writeback.c:2475)=20=

> [ 94.546645][ T8162] iomap_writepages (fs/iomap/buffered-io.c:1993)=20
> [ 94.547109][ T8162] gfs2_writepages (fs/gfs2/aops.c:192)=20
> [ 94.547586][ T8162] do_writepages (mm/page-writeback.c:2553)=20
> [ 94.548048][ T8162] filemap_fdatawrite_wbc (mm/filemap.c:389 =
mm/filemap.c:378)=20
> [ 94.548575][ T8162] __filemap_fdatawrite_range (mm/filemap.c:413)=20
> [ 94.549125][ T8162] gfs2_log_flush (./include/spinlock.h:351 =
fs/gfs2/log.c:737 fs/gfs2/log.c:1105)=20
> [ 94.549606][ T8162] gfs2_fileattr_set (fs/gfs2/file.c:245 =
fs/gfs2/file.c:310)=20
> [ 94.550091][ T8162] vfs_fileattr_set (fs/ioctl.c:697)=20
> [ 94.550573][ T8162] do_vfs_ioctl (fs/ioctl.c:760 fs/ioctl.c:846)=20
> [ 94.551052][ T8162] __x64_sys_ioctl (fs/ioctl.c:870 fs/ioctl.c:857 =
fs/ioctl.c:857)=20
> [ 94.551551][ T8162] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.552002][ T8162] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [   94.552597][ T8162]
> [   94.552846][ T8162] The buggy address belongs to the object at =
ffff888154826a00
> [   94.552846][ T8162]  which belongs to the cache kmalloc-32 of size =
32
> [   94.554181][ T8162] The buggy address is located 8 bytes to the =
right of
> [   94.554181][ T8162]  allocated 24-byte region [ffff888154826a00, =
ffff888154826a18)
> [   94.555553][ T8162]
> [   94.555790][ T8162] The buggy address belongs to the physical page:
> [   94.556405][ T8162] page:ffffea0005520980 refcount:1 mapcount:0 =
mapping:0000000000000000 index:0x0 pfn:06
> [   94.557380][ T8162] flags: =
0x57ff00000000800(slab|node=3D1|zone=3D2|lastcpupid=3D0x7ff)
> [   94.558116][ T8162] page_type: 0xffffffff()
> [   94.558541][ T8162] raw: 057ff00000000800 ffff888011c41500 =
ffffea0005297580 dead000000000004
> [   94.559361][ T8162] raw: 0000000000000000 0000000000400040 =
00000001ffffffff 0000000000000000
> [   94.560177][ T8162] page dumped because: kasan: bad access detected
> [   94.560789][ T8162] page_owner tracks the page as allocated
> [   94.561335][ T8162] page last allocated via order 0, migratetype =
Unmovable, gfp_mask 0x12c40(GFP_NOFS|__3
> [ 94.563070][ T8162] post_alloc_hook (./include/page_owner.h:31 =
mm/page_alloc.c:1533)=20
> [ 94.563544][ T8162] get_page_from_freelist (mm/page_alloc.c:1542 =
mm/page_alloc.c:3311)=20
> [ 94.564092][ T8162] __alloc_pages (mm/page_alloc.c:4570)=20
> [ 94.564590][ T8162] allocate_slab (mm/slub.c:2191 mm/slub.c:2354)=20
> [ 94.565064][ T8162] ___slab_alloc (mm/slub.c:3541)=20
> [ 94.565562][ T8162] __slab_alloc.constprop.0 (mm/slub.c:3625)=20
> [ 94.566102][ T8162] __kmalloc_node_track_caller (mm/slub.c:3678 =
mm/slub.c:3850 mm/slub.c:3980 mm/slub.c:4001)=20
> [ 94.566675][ T8162] kstrdup (mm/util.c:63)=20
> [ 94.567064][ T8162] security_context_to_sid_core =
(security/sess/services.c:1544)=20
> [ 94.567637][ T8162] inode_doinit_use_xattr (security/sehooks.c:1392)=20=

> [ 94.568159][ T8162] inode_doinit_with_dentry =
(security/sehooks.c:1488)=20
> [ 94.568713][ T8162] selinux_d_instantiate (security/sehooks.c:6343)=20=

> [ 94.569220][ T8162] security_d_instantiate (security/security.c:3896 =
(discriminator 11))=20
> [ 94.569737][ T8162] d_splice_alias (./include/spinlock.h:351 =
fs/dcache.c:2974)=20
> [ 94.570192][ T8162] ext4_lookup (fs/ext4/namei.c:1883 =
fs/ext4/namei.c:1830)=20
> [ 94.570637][ T8162] path_openat (fs/namei.c:3478 fs/namei.c:3569 =
fs/namei.c:3799)=20
> [   94.571095][ T8162] page last free pid 4487 tgid 4487 stack trace:
> [ 94.571702][ T8162] free_unref_page_prepare =
(./include/page_owner.h:24 mm/page_alloc.c:1140 mm/page_alloc.c:2346)=20
> [ 94.572235][ T8162] free_unref_page_list (mm/page_alloc.c:2532)=20
> [ 94.572736][ T8162] release_pages (mm/swap.c:961)=20
> [ 94.573204][ T8162] tlb_batch_pages_flush (mm/mmu_gather.c:99 =
(discriminator 1))=20
> [ 94.573717][ T8162] tlb_finish_mmu (mm/mmu_gather.c:112 =
mm/mmu_gather.c:395)=20
> [ 94.574178][ T8162] exit_mmap (mm/mmap.c:3307)=20
> [ 94.574620][ T8162] __mmput (kernel/fork.c:1344)=20
> [ 94.575030][ T8162] mmput (kernel/fork.c:1366)=20
> [ 94.575406][ T8162] begin_new_exec (fs/exec.c:1314)=20
> [ 94.575890][ T8162] load_elf_binary (fs/binfmt_elf.c:997)=20
> [ 94.576374][ T8162] bprm_execve (fs/exec.c:1785 fs/exec.c:1825 =
fs/exec.c:1877 fs/exec.c:1853)=20
> [ 94.576827][ T8162] do_execveat_common.isra.0 (fs/exec.c:1984)=20
> [ 94.577379][ T8162] __x64_sys_execve (fs/exec.c:2129)=20
> [ 94.577858][ T8162] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.578304][ T8162] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [   94.578885][ T8162]
> [   94.579121][ T8162] Memory state around the buggy address:
> [   94.579655][ T8162]  ffff888154826900: 00 00 00 00 fc fc fc fc 00 =
00 00 00 fc fc fc fc
> [   94.580400][ T8162]  ffff888154826980: 00 00 00 00 fc fc fc fc fa =
fb fb fb fc fc fc fc
> [   94.581165][ T8162] >ffff888154826a00: 00 00 00 fc fc fc fc fc fa =
fb fb fb fc fc fc fc
> [   94.581935][ T8162]                                ^
> [   94.582428][ T8162]  ffff888154826a80: 00 00 00 fc fc fc fc fc fa =
fb fb fb fc fc fc fc
> [   94.583194][ T8162]  ffff888154826b00: fa fb fb fb fc fc fc fc fa =
fb fb fb fc fc fc fc
> [   94.583958][ T8162] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   94.594413][ T8162] Kernel panic - not syncing: KASAN: =
panic_on_warn set ...
> [   94.595479][ T8162] CPU: 1 PID: 8162 Comm: a.out Not tainted 6.8.0 =
#6
> [   94.596503][ T8162] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
> [   94.597818][ T8162] Call Trace:
> [   94.598344][ T8162]  <TASK>
> [ 94.598807][ T8162] dump_stack_lvl (lib/dump_stack.c:107 =
(discriminator 1))=20
> [ 94.599531][ T8162] panic (kernel/panic.c:344)=20
> [ 94.600156][ T8162] ? __pfx_panic (kernel/panic.c:278)=20
> [ 94.600862][ T8162] ? preempt_schedule_thunk =
(arch/x86/entry/thunk_64.S:45)=20
> [ 94.601729][ T8162] ? preempt_schedule_common =
(./arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6906)=20
> [ 94.602591][ T8162] ? check_panic_on_warn (kernel/panic.c:236)=20
> [ 94.603393][ T8162] ? gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.604199][ T8162] check_panic_on_warn (kernel/panic.c:237)=20
> [ 94.604968][ T8162] end_report (mm/kasan/report.c:226)=20
> [ 94.605647][ T8162] kasan_report (./arch/x86/include/asm/smap.h:56 =
mm/kasan/report.c:606)=20
> [ 94.606342][ T8162] ? gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.607198][ T8162] gfs2_invalidate_folio (fs/gfs2/aops.c:651)=20
> [ 94.608041][ T8162] ? _raw_spin_lock_irqsave =
(./arch/x86/include/asm/atomic.h:115 =
./include/atomic/atomic-arch-fallback.h:2164 =
./include/atomic/atomic-instrumented.h:1296 =
./include/asm-generic/qspinlock.h:111 ./include/spinlock.h:187 =
./include/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)=20
> [ 94.608878][ T8162] ? __pfx_gfs2_invalidate_folio =
(fs/gfs2/aops.c:635)=20
> [ 94.609807][ T8162] truncate_cleanup_folio (mm/truncate.c:158 =
mm/truncate.c:178)=20
> [ 94.610659][ T8162] truncate_inode_pages_range (mm/truncate.c:357 =
(discriminator 3))=20
> [ 94.611563][ T8162] ? __pfx_truncate_inode_pages_range =
(mm/truncate.c:322)=20
> [ 94.612549][ T8162] ? __x64_sys_exit_group (kernel/exit.c:1029)=20
> [ 94.613364][ T8162] ? do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.614114][ T8162] ? entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [ 94.615067][ T8162] ? _raw_spin_unlock_irqrestore =
(./arch/x86/include/asm/preempt.h:103 ./include/spinlock_api_smp.h:152 =
kernel/locking/spinlock.c:194)=20
> [ 94.615979][ T8162] ? debug_object_active_state =
(lib/debugobjects.c:946)=20
> [ 94.616898][ T8162] gfs2_evict_inode (fs/gfs2/super.c:1509)=20
> [ 94.617708][ T8162] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 94.618567][ T8162] ? _raw_spin_lock =
(./arch/x86/include/asm/atomic.h:115 =
./include/atomic/atomic-arch-fallback.h:2164 =
./include/atomic/atomic-instrumented.h:1296 =
./include/asm-generic/qspinlock.h:111 ./include/spinlock.h:187 =
./include/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 94.619353][ T8162] ? __inode_wait_for_writeback =
(fs/fs-writeback.c:1487)=20
> [ 94.620305][ T8162] ? __pfx___inode_wait_for_writeback =
(fs/fs-writeback.c:1487)=20
> [ 94.621277][ T8162] ? __pfx_wake_bit_function =
(kernel/sched/wait_bit.c:22)=20
> [ 94.622149][ T8162] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 94.623011][ T8162] ? __pfx__raw_spin_lock =
(kernel/locking/spinlock.c:153)=20
> [ 94.623873][ T8162] ? wb_io_lists_depopulated (fs/fs-writeback.c:100 =
(discriminator 1))=20
> [ 94.624741][ T8162] ? __pfx_gfs2_evict_inode (fs/gfs2/super.c:1473)=20=

> [ 94.625575][ T8162] evict (fs/inode.c:670)=20
> [ 94.626200][ T8162] iput.part.0 (fs/inode.c:1739 fs/inode.c:1765)=20
> [ 94.626907][ T8162] ? __pfx_gfs2_drop_inode (fs/gfs2/super.c:1025)=20
> [ 94.627735][ T8162] iput (fs/inode.c:1767)=20
> [ 94.628327][ T8162] gfs2_kill_sb (./include/sched.h:1984 =
fs/gfs2/ops_fstype.c:1770 fs/gfs2/ops_fstype.c:1793)=20
> [ 94.629089][ T8162] deactivate_locked_super (fs/super.c:433 =
fs/super.c:474)=20
> [ 94.629992][ T8162] deactivate_super (fs/super.c:507)=20
> [ 94.630760][ T8162] cleanup_mnt (fs/namespace.c:144 =
fs/namespace.c:1268)=20
> [ 94.631469][ T8162] task_work_run (kernel/task_work.c:181 =
(discriminator 1))=20
> [ 94.632196][ T8162] ? __pfx_task_work_run (kernel/task_work.c:148)=20
> [ 94.632935][ T8162] ? __put_net (net/core/net_namespace.c:667)=20
> [ 94.633612][ T8162] do_exit (kernel/exit.c:872)=20
> [ 94.634273][ T8162] ? __count_memcg_events (mm/memcontrol.c:722 =
mm/memcontrol.c:961)=20
> [ 94.635120][ T8162] ? __pfx_do_exit (kernel/exit.c:812)=20
> [ 94.635833][ T8162] ? __pfx__raw_spin_lock_irq =
(kernel/locking/spinlock.c:169)=20
> [ 94.636701][ T8162] ? zap_other_threads (kernel/signal.c:1389)=20
> [ 94.637515][ T8162] do_group_exit (kernel/exit.c:1001)=20
> [ 94.638233][ T8162] __x64_sys_exit_group (kernel/exit.c:1029)=20
> [ 94.639069][ T8162] do_syscall_64 (arch/x86/entry/common.c:52 =
arch/x86/entry/common.c:83)=20
> [ 94.639828][ T8162] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:129)=20
> [   94.640782][ T8162] RIP: 0033:0x7f162e2ee146
> [ 94.641525][ T8162] Code: Unable to access opcode bytes at =
0x7f162e2ee11c.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   94.642646][ T8162] RSP: 002b:00007ffc8b584d98 EFLAGS: 00000246 =
ORIG_RAX: 00000000000000e7
> [   94.643938][ T8162] RAX: ffffffffffffffda RBX: 00007f162e3f38a0 =
RCX: 00007f162e2ee146
> [   94.645039][ T8162] RDX: 0000000000000001 RSI: 000000000000003c =
RDI: 0000000000000001
> [   94.646058][ T8162] RBP: 0000000000000001 R08: 00000000000000e7 =
R09: ffffffffffffff80
> [   94.647098][ T8162] R10: 0000000000000002 R11: 0000000000000246 =
R12: 00007f162e3f38a0
> [   94.648138][ T8162] R13: 0000000000000001 R14: 00007f162e3fc2e8 =
R15: 0000000000000000
> [   94.649181][ T8162]  </TASK>
> [   94.649730][ T8162] Kernel Offset: disabled
> [   94.650152][ T8162] Rebooting in 86400 seconds..
>=20

