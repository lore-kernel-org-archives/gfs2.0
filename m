Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DD19BA8
	for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9/9wHjE"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9beb863816so4226485276.1
        for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698690833; x=1699295633; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=s3wGblsRiK6/AFSjBkoHrTi5nWX0/YH41Hzeikt22js=;
        b=m9/9wHjEzLdH//b5bqigtSox950dekTHI8LWpL9W+OH5ciwry8Ff81rJjcqbzIyO9g
         GjgbYZplxt3r/z2SEQ93cZRVOOsU3YdRpLeTGpgl1Dnp/vmwWbJLVFnAg/6jIgvFzXnK
         3OvLCgo5QrtCE8rMfNkeMFeup2R5Udo5p+jBl9WY5+ptv985fwe1eR/ZQUA79bhfzfJy
         02LrChQafGxy+bn5pGy6kzK+73cKlzmGxRPTIais1ZkpkMdVhYaEp0FXzEzRn8jhD5AE
         bUeN8O7+xDO0UllmxFyVAHerjHsCFNSg0PNQktyfPHkpalExcQOe3z8+EvjMBahHwmpu
         1G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698690833; x=1699295633;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3wGblsRiK6/AFSjBkoHrTi5nWX0/YH41Hzeikt22js=;
        b=rtIi3muRCl7BE7iIN5j4WMLj/laP4FvdmiTUWHm2q+JJgAuuNkPTHnfu9OWRK9UQ4L
         TQECrYBE55TnHgEIf63JbgeTXjwErO5qGibb5A1W6/bZjQf8ColjpiXC3WsDtEKGtQmP
         1UMOzVkMrGJgRuocdhY5r03aeGa54dpbzJ4BvnpAPMX162rJmU8VdCQAuRc5gTHoDixN
         fDb0lmnySK1PBjMeEr5KlFHCfmiCDIh+Va+0fbu4LV8PTD2xX6+m43ME1zrLS5ZPWpPn
         N3XIlmHhERedMPixRV/TuWoU9JZk7srtZ3cxtT3mVtLJ33mMwuVNNJ7kdUV2wutdipxe
         30aQ==
X-Gm-Message-State: AOJu0YzCDHVikglaP8ZWCEi377DVkGCKHyCgnJY447UhxBVMwfGE2sWl
	7wfpDzG3DLqLGBraTKPDuiJnyTyahSg=
X-Google-Smtp-Source: AGHT+IE4ATf46D8rlYIxlbp+w+U7L++0uL8XbP1WRMWvm1HDGThoi5jN18YcI5LWsmw1EUJl0awsog==
X-Received: by 2002:a25:b10:0:b0:d9b:e8bf:4703 with SMTP id 16-20020a250b10000000b00d9be8bf4703mr9629005ybl.10.1698690833426;
        Mon, 30 Oct 2023 11:33:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p201-20020a2542d2000000b00da0c49a588asm4155938yba.8.2023.10.30.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:33:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 30 Oct 2023 11:33:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
Subject: Re: [PATCH] gfs2: Initialize metapaths outside of __gfs2_iomap_get
Message-ID: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 20, 2023 at 01:22:44AM +0200, Andreas Gruenbacher wrote:
> Initialize metapaths outside of __gfs2_iomap_get().  This saves us from
> having to release the metapath in gfs2_iomap_begin_write() before
> calling __gfs2_iomap_get() a second time.
> 
> Also gets rid of several instances where mp_aheight remains at 1 for
> stuffed inodes (which have a height of 0).  In those cases, mp_aheight
> isn't being used, though.
> 

In linux-next:

[   12.639126] =============================
[   12.639330] WARNING: suspicious RCU usage
[   12.639550] 6.6.0-rc7-next-20231027 #1 Tainted: G                 N
[   12.639647] -----------------------------
[   12.639814] fs/gfs2/inode.c:1878 suspicious rcu_dereference_check() usage!
[   12.639912]
[   12.639912] other info that might help us debug this:
[   12.639912]
[   12.640022]
[   12.640022] rcu_scheduler_active = 2, debug_locks = 1
[   12.640136] no locks held by cp/794.
[   12.640222]
[   12.640222] stack backtrace:
[   12.640381] CPU: 0 PID: 794 Comm: cp Tainted: G                 N 6.6.0-rc7-next-20231027 #1
[   12.640509] Hardware name: linux,dummy-virt (DT)
[   12.640673] Call trace:
[   12.640734]  dump_backtrace+0x94/0xec
[   12.641086]  show_stack+0x18/0x24
[   12.641143]  dump_stack_lvl+0xac/0xd4
[   12.641201]  dump_stack+0x18/0x24
[   12.641254]  lockdep_rcu_suspicious+0x16c/0x22c
[   12.641316]  gfs2_permission+0x194/0x1c0
[   12.641376]  inode_permission+0xf4/0x1a8
[   12.641435]  link_path_walk.part.0.constprop.0+0x2a0/0x384
[   12.641502]  path_lookupat+0x40/0x19c
[   12.641556]  filename_lookup+0x98/0x19c
[   12.641611]  vfs_statx+0x8c/0x184
[   12.641664]  vfs_fstatat+0xe4/0x128
[   12.641718]  __do_sys_newfstatat+0x2c/0x6c
[   12.641775]  __arm64_sys_newfstatat+0x20/0x2c
[   12.641834]  invoke_syscall+0x48/0x114
[   12.641892]  el0_svc_common.constprop.0+0x40/0xe8
[   12.641961]  do_el0_svc+0x20/0x2c
[   12.642021]  el0_svc+0x4c/0xe4
[   12.642079]  el0t_64_sync_handler+0x13c/0x158
[   12.642142]  el0t_64_sync+0x190/0x194
[   14.882259] ------------[ cut here ]------------
[   14.882512] kernel BUG at fs/gfs2/bmap.c:695!
[   14.882965] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   14.883163] Modules linked in:
[   14.883346] CPU: 0 PID: 794 Comm: cp Tainted: G                 N 6.6.0-rc7-next-20231027 #1
[   14.883489] Hardware name: linux,dummy-virt (DT)
[   14.883630] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   14.883782] pc : __gfs2_iomap_alloc+0x534/0x684
[   14.883905] lr : gfs2_iomap_begin+0x498/0x564
[   14.883991] sp : ffff800080c33590
[   14.884056] x29: ffff800080c33590 x28: 0000000000000010 x27: ffff342407132000
[   14.884235] x26: 000000000000001f x25: ffff800080c336f8 x24: ffffab511c180ba0
[   14.884368] x23: 000000000000000f x22: 0000000000000002 x21: ffff800080c33860
[   14.884487] x20: ffff3424079e1388 x19: 0000000000000001 x18: 0000000000000001
[   14.884604] x17: ffffab511959c8b4 x16: ffffab5119a0f7b8 x15: ffffab5119a0f26c
[   14.884722] x14: ffff342407133058 x13: 0000000000000000 x12: 00000000000503ca
[   14.884839] x11: 0000000076ded85c x10: ffff342407132f28 x9 : 0000000000000000
[   14.884982] x8 : 000000000000068f x7 : 000000000000001f x6 : 000000000000068f
[   14.885099] x5 : 0000000000000674 x4 : ffff342404f78d70 x3 : 000000000000d000
[   14.885217] x2 : 000000000000000d x1 : ffff342407132000 x0 : 0000000000000000
[   14.885367] Call trace:
[   14.885438]  __gfs2_iomap_alloc+0x534/0x684
[   14.885511]  gfs2_iomap_begin+0x498/0x564
[   14.885577]  iomap_iter+0x15c/0x43c
[   14.885638]  iomap_file_buffered_write+0x260/0x308
[   14.885709]  gfs2_file_buffered_write+0x134/0x378
[   14.885795]  gfs2_file_write_iter+0x308/0x474
[   14.885862]  do_iter_readv_writev+0xb8/0x144
[   14.885931]  do_iter_write+0x94/0x1fc
[   14.885991]  vfs_iter_write+0x1c/0x30
[   14.886051]  iter_file_splice_write+0x240/0x3b8
[   14.886108]  gfs2_file_splice_write+0x48/0x54
[   14.886153]  direct_splice_actor+0x30/0x44
[   14.886196]  splice_direct_to_actor+0xe4/0x254
[   14.886238]  do_splice_direct+0x90/0xdc
[   14.886277]  do_sendfile+0x2f0/0x384
[   14.886315]  __arm64_sys_sendfile64+0x158/0x168
[   14.886358]  invoke_syscall+0x48/0x114
[   14.886400]  el0_svc_common.constprop.0+0x40/0xe8
[   14.886445]  do_el0_svc+0x20/0x2c
[   14.886482]  el0_svc+0x4c/0xe4
[   14.886519]  el0t_64_sync_handler+0x13c/0x158
[   14.886561]  el0t_64_sync+0x190/0x194
[   14.886674] Code: b900b3ff 17fffeec 9103a0c6 17ffff9b (d4210000)
[   14.886868] ---[ end trace 0000000000000000 ]---
[   14.887001] note: cp[794] exited with irqs disabled
[   14.887299] note: cp[794] exited with preempt_count 1
Segmentation fault

Bisect results attached.

Guenter

---
Bisect:

# bad: [c503e3eec382ac708ee7adf874add37b77c5d312] Add linux-next specific files for 20231030
# good: [05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1] Linux 6.6-rc7
git bisect start 'HEAD' 'v6.6-rc7'
# bad: [d52da7870c3e3025dc99f7093e0692ad983ad0cd] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect bad d52da7870c3e3025dc99f7093e0692ad983ad0cd
# good: [b827ac419721a106ae2fccaa40576b0594edad92] exportfs: Change bcachefs fid_type enum to avoid conflicts
git bisect good b827ac419721a106ae2fccaa40576b0594edad92
# good: [b0c0193acb486569b801d2560971dfcef2d1c9b7] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
git bisect good b0c0193acb486569b801d2560971dfcef2d1c9b7
# bad: [76d1d091d23f160facca73abb439a4e0ea5a9315] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect bad 76d1d091d23f160facca73abb439a4e0ea5a9315
# good: [d42404914ba1d3d19c5a8da4dcbc53cac1ebd0f7] Merge branch 'for_next' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
git bisect good d42404914ba1d3d19c5a8da4dcbc53cac1ebd0f7
# bad: [a8a2e0e6c0db94f442d85c3909a8309ca6e34968] Merge branch 'overlayfs-next' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
git bisect bad a8a2e0e6c0db94f442d85c3909a8309ca6e34968
# good: [3fd2ca5be07f6a43211591a45b43df9e7b6eba00] svcrdma: Fix tracepoint printk format
git bisect good 3fd2ca5be07f6a43211591a45b43df9e7b6eba00
# good: [2280582b886fdcc3353de0cdbd2c90e9e481c9a9] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
git bisect good 2280582b886fdcc3353de0cdbd2c90e9e481c9a9
# good: [72675d6ab4f8c84632f92b8a25084d64313c8f49] ovl: do not encode lower fh with upper sb_writers held
git bisect good 72675d6ab4f8c84632f92b8a25084d64313c8f49
# bad: [26ad55ecccd5bc18e421b83bbceff225d3605871] gfs2: fs: derive f_fsid from s_uuid
git bisect bad 26ad55ecccd5bc18e421b83bbceff225d3605871
# good: [f778cbadda547222f71ec6d65e80167673038414] gfs2: Two quota=account mode fixes
git bisect good f778cbadda547222f71ec6d65e80167673038414
# bad: [6810cfb7dacd670ef81bcea256ac34d3f28b174d] gfs2: Get rid of gfs2_alloc_blocks generation parameter
git bisect bad 6810cfb7dacd670ef81bcea256ac34d3f28b174d
# good: [b653d916139330ffc940c43a4adcc1eb4d913f81] gfs2: Clean up quota.c:print_message
git bisect good b653d916139330ffc940c43a4adcc1eb4d913f81
# bad: [81118680a9cf6b24ea7943e0a7b2a98bf8d2b676] gfs2: Initialize metapaths outside of __gfs2_iomap_get
git bisect bad 81118680a9cf6b24ea7943e0a7b2a98bf8d2b676
# good: [26c239e3dafe8cce2dcc443fc17226c7454dc155] gfs2: Add metapath_dibh helper
git bisect good 26c239e3dafe8cce2dcc443fc17226c7454dc155
# first bad commit: [81118680a9cf6b24ea7943e0a7b2a98bf8d2b676] gfs2: Initialize metapaths outside of __gfs2_iomap_get
