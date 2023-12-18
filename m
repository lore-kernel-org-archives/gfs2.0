Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58870129EF3
	for <gfs2@lists.linux.dev>; Mon, 18 Dec 2023 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0Jg80+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702907326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhDDEFTDhjYhvtfQlESbxHByQJdQ2TnJ8f1uuNdNatQ=;
	b=R0Jg80+C95DZ2Gg5xSProdGgeFePrds6c839r40j6Gd5hEoukBtgKa1zLDdXh8sacOPdrM
	P7UvpHXRouu+Ni0BEWlumUKB9He4Kl0bm7ghPhk7IWazcTYWhIPfssL2yh0ZpGkBCRfHlt
	H3wdcGLogf5xVPZ4b0Ht1hzqySu9150=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-EZkiN4pPMEurM0NSlIDFfQ-1; Mon, 18 Dec 2023 08:48:44 -0500
X-MC-Unique: EZkiN4pPMEurM0NSlIDFfQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d1e2283b6dso36895325ad.2
        for <gfs2@lists.linux.dev>; Mon, 18 Dec 2023 05:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907322; x=1703512122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhDDEFTDhjYhvtfQlESbxHByQJdQ2TnJ8f1uuNdNatQ=;
        b=oan5rZPKuetAMwf6S0flw0Had1YOOxyLio847FJ5SY4/Ys+dJ1zHQtMStYueYcLquX
         BKGcxCqwi7TCb5J9b5eFoKSC4TrC90R6SGLYv5L9MmNU/1sYs31sqtBTGkqX9TYI/FPc
         Xxd1ZaXB1DoVQJjCd8h1QJXeSt6X7omlgKZwviQl7P6DcXFWLg4vow3O0MC3nhdR16gt
         9S5qAectgUtrI1432dEUyWqcVOYthOT1DuCgh219CHLFF6VSkGvL+FDLQZA3mZJJN8mw
         m74IG+dL7BhwpzU7pg0EGOPajHgCC7Iy1FA2I5FMfTrbRYGJoo7Au+SuTR4U5b2XsevY
         Eoxg==
X-Gm-Message-State: AOJu0YyPEuH4bDqMsqC2ytPQ9xtPH9METFV4ZtZrsUbROBFYW6epDsKy
	X3lLLR1n4jESOPEfhFBQ/puEww6Ry5bcU3AyzZjy6SjIsryvGNw9WnaqSjrmnw18H3/FeayeIdR
	5SP2FByi/pmaukL9sTyrUir34eqdyUQ==
X-Received: by 2002:a17:903:32c5:b0:1d3:6419:ca60 with SMTP id i5-20020a17090332c500b001d36419ca60mr10444706plr.92.1702907322702;
        Mon, 18 Dec 2023 05:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb32JgCLJHPwoc92XqOiPO1zdUJBAs18FABhH1jgrmkBec52NXs9L8i7bQwBFUmnRgNacXD21k2cHX7vyaRlo=
X-Received: by 2002:a17:903:32c5:b0:1d3:6419:ca60 with SMTP id
 i5-20020a17090332c500b001d36419ca60mr10444693plr.92.1702907322343; Mon, 18
 Dec 2023 05:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231106162129.10556-1-osmtendev@gmail.com> <CAK6rUAMxhhw6JNBryrBZHvpZZo+69rr157skoHFJgbm3+_fmtQ@mail.gmail.com>
In-Reply-To: <CAK6rUAMxhhw6JNBryrBZHvpZZo+69rr157skoHFJgbm3+_fmtQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 18 Dec 2023 14:48:30 +0100
Message-ID: <CAHc6FU7hMr-LmNNb0Cbcp8Yy3NppRnExNUxm-vnqZQ2LveiJfA@mail.gmail.com>
Subject: Re: [PATCH] fs:gfs2:rgrp.c: Fix kernel NULL pointer dereference
To: Osama Muhammad <osmtendev@gmail.com>
Cc: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 16, 2023 at 1:05=E2=80=AFPM Osama Muhammad <osmtendev@gmail.com=
> wrote:
> On Mon, 6 Nov 2023 at 21:22, Osama Muhammad <osmtendev@gmail.com> wrote:
> > Syzkaller reported the following issue:
> >
> > i_length =3D 1
> > ri_data0 =3D 19
> > ri_data =3D 2060
> > ri_bitbytes =3D 514
> > start=3D0 len=3D514 offset=3D128
> > gfs2: fsid=3Dsyz:syz.s:  R: n:18 f:00 b:0/0 i:0 q:0 r:0 e:0
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000000004
> > Mem abort info:
> >   ESR =3D 0x0000000096000006
> >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >   SET =3D 0, FnV =3D 0
> >   EA =3D 0, S1PTW =3D 0
> >   FSC =3D 0x06: level 2 translation fault
> > Data abort info:
> >   ISV =3D 0, ISS =3D 0x00000006
> >   CM =3D 0, WnR =3D 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010e23f000
> > [0000000000000004] pgd=3D080000010b804003, p4d=3D080000010b804003, pud=
=3D080000010a4e8003, pmd=3D0000000000000000
> > Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 0 PID: 3072 Comm: syz-executor147 Not tainted 6.1.0-rc8-syzkaller-=
33330-ga5541c0811a0 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/26/2022
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2313
> > lr : gfs2_rgrp_dump+0x90/0x138
> > sp : ffff80000fb93780
> > x29: ffff80000fb937a0 x28: ffff0000cb82a000 x27: ffff0000cb82a000
> > x26: ffff0000ca4de000 x25: 0000000000000808 x24: 000000000000080c
> > x23: 000000000001c103 x22: ffff0000ca4de000 x21: 0000000000000000
> > x20: ffff80000fb937e0 x19: ffff0000ca4de080 x18: 00000000000000c0
> > x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c6800000
> > x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6800000
> > x11: ff808000092a5154 x10: 0000000000000000 x9 : ffff8000092a5154
> > x8 : 0000000000000000 x7 : ffff80000c091ebc x6 : 0000000000000000
> > x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> > x2 : ffff0001fefbecd0 x1 : ffff80000cc9c685 x0 : 0000000000000000
> > Call trace:
> >  gfs2_rgrp_dump+0xa0/0x138 fs/gfs2/rgrp.c:2312
> >  gfs2_consist_rgrpd_i+0x78/0xe4 fs/gfs2/util.c:480
> >  read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
> >  gfs2_ri_update+0x398/0x7e4 fs/gfs2/rgrp.c:1001
> >  gfs2_rindex_update+0x1b0/0x21c fs/gfs2/rgrp.c:1051
> >  init_inodes+0x11c/0x184 fs/gfs2/ops_fstype.c:917
> >  gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1247
> >  get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
> >  gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1330
> >  vfs_get_tree+0x40/0x140 fs/super.c:1531
> >  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
> >  path_mount+0x358/0x890 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
> >  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> >  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
> >  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
> >  do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
> >  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
> >  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
> >  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
> > Code: f94036c8 f001cfa1 911a1421 aa1503e0 (2940a909)
> > ---[ end trace 0000000000000000 ]---
> >
> > The issue is caused during prinitng debug information when
> > accessing the pointer rgd->rd_rgl. So adding condition to
> > check the pointer is not NULL fixes the bug.
> >
> Any feedback on  this patch.
> Thanks
>
> > The patch is tested via syzbot.
> >
> > Reported-and-tested-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotma=
il.com
> > Link: https://syzkaller.appspot.com/bug?extid=3Dda0fc229cc1ff4bb2e6d
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > ---
> >  fs/gfs2/rgrp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> > index 9308190895c8..307b952a41f8 100644
> > --- a/fs/gfs2/rgrp.c
> > +++ b/fs/gfs2/rgrp.c
> > @@ -2306,7 +2306,7 @@ void gfs2_rgrp_dump(struct seq_file *seq, struct =
gfs2_rgrpd *rgd,
> >                        (unsigned long long)rgd->rd_addr, rgd->rd_flags,
> >                        rgd->rd_free, rgd->rd_free_clone, rgd->rd_dinode=
s,
> >                        rgd->rd_requested, rgd->rd_reserved, rgd->rd_ext=
fail_pt);
> > -       if (rgd->rd_sbd->sd_args.ar_rgrplvb) {
> > +       if (rgd->rd_sbd->sd_args.ar_rgrplvb && rgd->rd_rgl) {
> >                 struct gfs2_rgrp_lvb *rgl =3D rgd->rd_rgl;
> >
> >                 gfs2_print_dbg(seq, "%s  L: f:%02x b:%u i:%u\n", fs_id_=
buf,
> > --
> > 2.34.1
> >

I've tweaked the commit message and pushed this fix to for-next.

Thanks,
Andreas

