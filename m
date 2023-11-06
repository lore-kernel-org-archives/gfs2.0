Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2A28E13
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQdTHdl4"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6711dd6595fso26118856d6.3
        for <gfs2@lists.linux.dev>; Mon, 06 Nov 2023 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699289869; x=1699894669; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0ZAwfM3+mJiakXzyhK+JHHtWlUzZmmuE1mXPkDLU8Q=;
        b=mQdTHdl4tc1LJx1zMDa5B34gzrqxC1qq3tgH14C8eFK4TCqgVl80aPENQxguNcDZ32
         wrYkp+iLqKROYLCLf5w2CvmCfY3cT7bvTdDP95en1nF+cY8MHpNz1BSOqt6z3hhfBQNW
         HzMGfcZVTSMtEp8AsIucvHTKlPeAL7tmrXyr9zhMyeu6JSM2yMHwNJ7NWs1DgRLrQsG5
         yV+DnQ4jg1Lto++7ZK8nr5wuzfJp0rk55BvN77Yf0CAf9KPGIieY5kTTteMIm+EV9fEV
         hBoewWmESAP6PR3MWQkdON5Qk0t/C1kuRaOj8rLTwV5R3MUf/d/SMbI3PNRO1KiAmjfQ
         wJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289869; x=1699894669;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0ZAwfM3+mJiakXzyhK+JHHtWlUzZmmuE1mXPkDLU8Q=;
        b=VUrTVSFZBzVcoYAiqb8khQkYMpZvkf32tNcsNLF9uhMbhvz9hxtuJ/sBL549hjraXG
         NKc3w+JzMhynKGi9gZjm3tZ43sgJzioxhFyYrS4TlwCTVS8RMLjzSEg/swbdpsSPTBEF
         yNRVCrV+Z26F4WxT19eNuK89Y0q1U4R0Y0/+YzIlkefjLGVIbS1cpk8Atid3yn0NKxsE
         1rcE6b72JPU6w4pMVqV5UBsMuM/i14J6/elTOGOPG8ClmZBNgzKw/0hqIH5wKJIXRfsE
         gVmfOrHWEitUK0T4zx0beEbXqZgi7bQOlYYy+Jql+ASIJPQ054LuA8oX9DovW/+uk3Bl
         B5cw==
X-Gm-Message-State: AOJu0YzumJBMkXcCh/+rehEY+tKkXmXpwlnqU4g1d7pYlFE8L+6MTdCl
	ocv+V9lL1D0FAcFqWW6SNFUFsk2dp4+Xo4CMHj1HPofMsos=
X-Google-Smtp-Source: AGHT+IEmVSFUYHTBDOLX+I5/fO6wp1TJR0LP2w28shnC55m7YE8bhpwQBJ6kHxxiPu3Ejn0GFnNDRy8kIt4ZXdoXk/8=
X-Received: by 2002:a05:6214:1cc2:b0:675:7b22:4f74 with SMTP id
 g2-20020a0562141cc200b006757b224f74mr7924714qvd.18.1699289868913; Mon, 06 Nov
 2023 08:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231106162129.10556-1-osmtendev@gmail.com>
In-Reply-To: <20231106162129.10556-1-osmtendev@gmail.com>
From: Osama Muhammad <osmtendev@gmail.com>
Date: Mon, 6 Nov 2023 21:57:37 +0500
Message-ID: <CAK6rUAOHJVCT=X_rHXa3bmsZrGmUOC5CHu5SjxcaOph5CwBabg@mail.gmail.com>
Subject: Fwd: [PATCH] fs:gfs2:rgrp.c: Fix kernel NULL pointer dereference
To: gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ---------
From: Osama Muhammad <osmtendev@gmail.com>
Date: Mon, 6 Nov 2023 at 21:22
Subject: [PATCH] fs:gfs2:rgrp.c: Fix kernel NULL pointer dereference
To: <rpeterso@redhat.com>, <agruenba@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, Osama Muhammad
<osmtendev@gmail.com>,
<syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com>


Syzkaller reported the following issue:

i_length = 1
ri_data0 = 19
ri_data = 2060
ri_bitbytes = 514
start=0 len=514 offset=128
gfs2: fsid=syz:syz.s:  R: n:18 f:00 b:0/0 i:0 q:0 r:0 e:0
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000004
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010e23f000
[0000000000000004] pgd=080000010b804003, p4d=080000010b804003,
pud=080000010a4e8003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3072 Comm: syz-executor147 Not tainted
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2313
lr : gfs2_rgrp_dump+0x90/0x138
sp : ffff80000fb93780
x29: ffff80000fb937a0 x28: ffff0000cb82a000 x27: ffff0000cb82a000
x26: ffff0000ca4de000 x25: 0000000000000808 x24: 000000000000080c
x23: 000000000001c103 x22: ffff0000ca4de000 x21: 0000000000000000
x20: ffff80000fb937e0 x19: ffff0000ca4de080 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c6800000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6800000
x11: ff808000092a5154 x10: 0000000000000000 x9 : ffff8000092a5154
x8 : 0000000000000000 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : ffff80000cc9c685 x0 : 0000000000000000
Call trace:
 gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2312
 gfs2_consist_rgrpd_i+0x78/0xe4 fs/gfs2/util.c:480
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x398/0x7e4 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x1b0/0x21c fs/gfs2/rgrp.c:1051
 init_inodes+0x11c/0x184 fs/gfs2/ops_fstype.c:917
 gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: f94036c8 f001cfa1 911a1421 aa1503e0 (2940a909)
---[ end trace 0000000000000000 ]---

The issue is caused during prinitng debug information when
accessing the pointer rgd->rd_rgl. So adding condition to
check the pointer is not NULL fixes the bug.

The patch is tested via syzbot.

Reported-and-tested-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 9308190895c8..307b952a41f8 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2306,7 +2306,7 @@ void gfs2_rgrp_dump(struct seq_file *seq, struct
gfs2_rgrpd *rgd,
                       (unsigned long long)rgd->rd_addr, rgd->rd_flags,
                       rgd->rd_free, rgd->rd_free_clone, rgd->rd_dinodes,
                       rgd->rd_requested, rgd->rd_reserved, rgd->rd_extfail_pt);
-       if (rgd->rd_sbd->sd_args.ar_rgrplvb) {
+       if (rgd->rd_sbd->sd_args.ar_rgrplvb && rgd->rd_rgl) {
                struct gfs2_rgrp_lvb *rgl = rgd->rd_rgl;

                gfs2_print_dbg(seq, "%s  L: f:%02x b:%u i:%u\n", fs_id_buf,
--
2.34.1
