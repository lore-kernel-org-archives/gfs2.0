Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7A23C51D
	for <gfs2@lists.linux.dev>; Wed,  6 May 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035848; cv=pass; b=frdhVGIdJQRkdsUdfnPIjLM5rbI+7ZTHQikRqhN8V6kY/roF82Mh4t3nzU3nckKInHNKcYGvmzsxJdOVfFYSVdeSgov/IgJ6nTQxzwInis5dCMFLzAjSXT6zHoPVGS+UlqXpfTc52n6qnBECdfybYL/rcwxYjcFuweMh8q3ha8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035848; c=relaxed/simple;
	bh=+u9tBokXFfr+7CPn+zP8jkS/6ugRjgJqBGW73KpsT2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA+06ubzS8XdB9YrR0fgGTETbKLJ0eg0+N4Tbki20MQ0qEdT5yVbdU4ROQhZ+CWq75xDcTpZK2SonSGFmphKR92gWSRK5XXl/J60EcBqly1Rr1xIFw8pUbIg2Pyh06eBoctfrVNCRuvmkWuKwJ+bM+MOSjdiP2B+oJYYUzX8dS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lyd0H+d2; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyd0H+d2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9d9971d059so821627466b.2
        for <gfs2@lists.linux.dev>; Tue, 05 May 2026 19:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778035844; cv=none;
        d=google.com; s=arc-20240605;
        b=iity1C5LYSUNntaJn8PDUj98Qpz6ZY8CL7w3MLfVbuO3ko94U/ZID4cOYchCgqDA1g
         mQ8MeXSTgb7IpDWpqo0fR+NB6uccB8QeBte94zbt/W7EtfFU50TNZuj8AaDDPQxR683s
         FRPOL2aYeoEgfr9lR7mcNkU9eqanhES05FH11KPDu+3+gnTr+7HU0fCKl2wDYj0vOowA
         gCELUWfOdjkLl4t8CPkgIfm+jEzpR4m+lyfTHV05Mt0FxehGog+QnXLnoddk4MOa8PqM
         viR8TFEA1nGWJgrHwiZsgRgFHgzp5g1VQXa3IzvOhZyyUsqDE/SA9uqeaNkAfM3hdOBH
         KwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLqIvfiVGGIaw71mOEqXTaAByUqBM9m3wQlL4CRDz3s=;
        fh=RcQLR3QDQ8l/NiGAuglofB30FavQcz2VzsBYzr8p5eg=;
        b=NIzN66/L28+Y8T2yewZEFwIkDooQrYnFw+ILqnKgSKlFG0Sts0WkEJBHMAoZ2fEplO
         99sfYdm5a147Wqk5sxP4WAMC93S1nF60LXVvc5uMBFsmPKL4Y7pcSCbzSfJecwh2iJPa
         lC8PKpuNvOpsjshPVHpFC8wPUmKBlm/hsDXm/4Si+WQ5gYjgflin0hdBJkrWJN9LHDSm
         Sq2hVGjdiBNenWbqsYEUskzvMs5zmSW2aGL3s53aKh+yMhpgCPWajY5PlRrtITtVVznC
         ib+KmRe6GVky3MwJrBo49giMRSLvPPR0IBPAnG9qcreSTFb4t2FhcgvhfmmO+gpZOCN+
         umWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778035844; x=1778640644; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLqIvfiVGGIaw71mOEqXTaAByUqBM9m3wQlL4CRDz3s=;
        b=Lyd0H+d28NhaN3RndFXbpW8F33vre78go0PXUoA6cJr7BmqQwwUi6unFZF1x1bQEJG
         zbhYvITvNx6SbQ+DDIiIb0F4L+uh2CfBoq/2iHIwRpMYv1ZQd++wVndL0aWetVcZsF/R
         nYLqueqXNN2ETy1ks32XgpIugAs3aXv+cqedYdggDy4b0dz7rsTPygYBTAdiIVqDX92k
         9pJ2y5O1V7XEpvrXS0SufFRypLEPvGZamuAE4SCoCEyxQzZrB5gKkSoEjSJiO6oN2SfK
         TZcPTiy3iouGnwQYutfDe9eimvMklT8zQxiMIPPbtApOnzFbvUOSQL+XDRd1GoyBgu1r
         YOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778035844; x=1778640644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLqIvfiVGGIaw71mOEqXTaAByUqBM9m3wQlL4CRDz3s=;
        b=LrL9fqLyWmFz66j32wmZ50lnhQ9KnRdsogmGSonyYpSxjR2kv/NScNF7yI/7Nt+gnc
         K5tVkHrpbePA0SxjuxSGorfK2G+KLFS0mvTVvKYyTznJYfDgWfJYgGUTRJknHQf3vu+2
         7PnI+KJZNrCvGOQHNpWrNEEWtvdBr1Od6CfiHTxkCBMlWp8QcoBo4co+P8yRXc67j2Sm
         4lJZn1aGmjYqmYaGgnDhZ9YH/PQ2Yve49C7WqWWAm07VoXEerqNzfubLV2QYKs37Q77m
         2vkjR4tBqPi57Evvvrd7bbfUMQbjbGCTA6NFOgQb2uFyH09GjtItzOhd+oPe4+pdPRsY
         z8gA==
X-Gm-Message-State: AOJu0YykbpTbk4zhbJhyKz/LLjChjVq2hnZwzgIZI3WoGpeA6NNkpp4u
	CUtnLWhNt2dXe6m9iOQzUparTTOZpUFWQXlZBHtQ9JfZ7nNJeCvlTIAKQKXDkYrIx9lx2szx0DT
	AJCy3ffej86ZwThhuie0Zs6ttwpaDSLo=
X-Gm-Gg: AeBDietGPhrwRzf3ohnCrmxxe3gK86UQjyKxeUtRMXZp2pO5z2y5Kj/3vGsiIeuwRMf
	uBKSO9buD0sSpK7AAhotKk6GY7OKu9FxyDo+ucQUE7ff1Iej5coay9JhE7wIXHpPkJzL0He9nio
	+NZUJ53eOSrnwqxdN6XgpVJYXZeuwvvuYN8xb/IFuRj7EAVTSd5pyo2X6HtGlruArg+kfxKwi6i
	zFUKowQVQnxYtv8MeVwWuwnAoIXyVkT/zK9mEkAkcltx1E8NruhekGa8zoQXTCi+/V/KWk4ovIG
	HJKyC9FO5iFcnD5vkm4yKS/pBnOlSToPkKM/VBh09avMTTCf62pzs1At3CyIgf8IQQ==
X-Received: by 2002:a17:906:eeca:b0:bab:ba5a:fcb8 with SMTP id
 a640c23a62f3a-bc56d80d789mr51608466b.32.1778035843287; Tue, 05 May 2026
 19:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260428040408.981582-1-gality369@gmail.com> <CAHc6FU70L29zLCcVC3VMZu6pCMhoZTzAxCgFoEESnXqtrKV8jw@mail.gmail.com>
In-Reply-To: <CAHc6FU70L29zLCcVC3VMZu6pCMhoZTzAxCgFoEESnXqtrKV8jw@mail.gmail.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Wed, 6 May 2026 10:50:17 +0800
X-Gm-Features: AVHnY4JB4bDTarFXL8f2UoVaDQmemsKOBfz8ekwvAU5GAJQIVFTuWMFJ-eqOy8o
Message-ID: <CAOmEq9WkD6iawEgtK=jFwisVeAeW6xhuBoBtN0hTt4JP184r6A@mail.gmail.com>
Subject: Re: [PATCH] gfs2: reject undersized EA records during xattr walks
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	r33s3n6@gmail.com, zzzccc427@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:27=E2=80=AFPM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> Hello ZhengYuan Huang,
>
> On Tue, Apr 28, 2026 at 6:05=E2=80=AFAM ZhengYuan Huang <gality369@gmail.=
com> wrote:
> > [BUG]
> > A fuzzed GFS2 image can crash in `ea_split_ea()` while servicing setxat=
tr:
> >
> > BUG: KASAN: slab-out-of-bounds in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr=
.c:835
> > Write of size 4 at addr ffff88801550a1c0 by task syz.0.379/950
> >
> > Call Trace:
> >  ...
> >  ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
> >  ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
> >  ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
> >  ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
> >  ea_foreach+0x3cd/0x5d0 fs/gfs2/xattr.c:140
> >  ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
> >  __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
> >  gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
> >  __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
> >  __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
> >  __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
> >  vfs_setxattr+0x167/0x390 fs/xattr.c:321
> >  do_setxattr+0x13c/0x180 fs/xattr.c:636
> >  filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
> >  path_setxattrat+0x1d8/0x280 fs/xattr.c:713
> >  __do_sys_setxattr fs/xattr.c:747 [inline]
> >  __se_sys_setxattr fs/xattr.c:743 [inline]
> >  __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
> >  ...
> >
> > Allocated by task 893:
> >  kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
> >  kasan_save_track+0x14/0x40 mm/kasan/common.c:77
> >  kasan_save_alloc_info+0x37/0x60 mm/kasan/generic.c:573
> >  unpoison_slab_object mm/kasan/common.c:342 [inline]
> >  __kasan_slab_alloc+0x9d/0xa0 mm/kasan/common.c:368
> >  kasan_slab_alloc include/linux/kasan.h:252 [inline]
> >  slab_post_alloc_hook mm/slub.c:4978 [inline]
> >  slab_alloc_node mm/slub.c:5288 [inline]
> >  kmem_cache_alloc_noprof+0x1f0/0x7d0 mm/slub.c:5295
> >  __do_sys_getcwd+0xe0/0x730 fs/d_path.c:416
> >  __se_sys_getcwd fs/d_path.c:412 [inline]
> >  __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
> >  x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.=
h:80
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Freed by task 893:
> >  kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
> >  kasan_save_track+0x14/0x40 mm/kasan/common.c:77
> >  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
> >  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
> >  poison_slab_object mm/kasan/common.c:252 [inline]
> >  __kasan_slab_free+0x6f/0xa0 mm/kasan/common.c:284
> >  kasan_slab_free include/linux/kasan.h:234 [inline]
> >  slab_free_hook mm/slub.c:2543 [inline]
> >  slab_free mm/slub.c:6642 [inline]
> >  kmem_cache_free+0x384/0x7a0 mm/slub.c:6752
> >  __do_sys_getcwd+0x3f8/0x730 fs/d_path.c:446
> >  __se_sys_getcwd fs/d_path.c:412 [inline]
> >  __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
> >  x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.=
h:80
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > and also as:
> >
> > BUG: KASAN: use-after-free in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:8=
35
> > Write of size 4 at addr ffff888023742118 by task syz.0.27/395
> >
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xd1/0x650 mm/kasan/report.c:482
> >  kasan_report+0xfb/0x140 mm/kasan/report.c:595
> >  __asan_report_store4_noabort+0x17/0x30 mm/kasan/report_generic.c:385
> >  ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
> >  ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
> >  ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
> >  ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
> >  ea_foreach+0x334/0x5d0 fs/gfs2/xattr.c:162
> >  ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
> >  __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
> >  gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
> >  __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
> >  __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
> >  __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
> >  vfs_setxattr+0x167/0x390 fs/xattr.c:321
> >  do_setxattr+0x13c/0x180 fs/xattr.c:636
> >  filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
> >  path_setxattrat+0x1d8/0x280 fs/xattr.c:713
> >  __do_sys_setxattr fs/xattr.c:747 [inline]
> >  __se_sys_setxattr fs/xattr.c:743 [inline]
> >  __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
> >  ...
> >
> > [CAUSE]
> > `ea_foreach_i()` validates only that each EA record has a non-zero
> > `ea_rec_len`, stays within the block, and has a valid type. It never ch=
ecks
> > that the record span actually covers the layout encoded by
> > `ea_name_len`, `ea_data_len`, and `ea_num_ptrs`.
> >
> > If a malformed record reaches `ea_set_simple()` with
> > `GFS2_EA_REC_LEN(ea) < GFS2_EA_SIZE(ea)`, the unsigned subtraction in t=
he
> > split test underflows and falsely claims there is enough free space.
> > `ea_split_ea()` then writes the new EA header outside the real record.
> >
> > [FIX]
> > Reject EA records whose reserved record length is smaller than their
> > computed layout size in `ea_foreach_i()`, which is the common parse
> > boundary for existing xattr metadata. This stops malformed records befo=
re
> > any update path can split or otherwise trust the broken geometry.
> >
> > Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> > ---
> > fs/gfs2/xattr.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
> > index b9f48d6f10a9..16cf31bde99a 100644
> > --- a/fs/gfs2/xattr.c
> > +++ b/fs/gfs2/xattr.c
> > @@ -96,6 +96,8 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct=
 buffer_head *bh,
> >                 return -EIO;
> >
> >         for (ea =3D GFS2_EA_BH2FIRST(bh);; prev =3D ea, ea =3D GFS2_EA2=
NEXT(ea)) {
> > +               u32 ea_size;
> > +
> >                 if (!GFS2_EA_REC_LEN(ea)) {
> >                         gfs2_consist_inode(ip);
> >                         return -EIO;
> > @@ -109,6 +111,11 @@ static int ea_foreach_i(struct gfs2_inode *ip, str=
uct buffer_head *bh,
> >                         gfs2_consist_inode(ip);
> >                         return -EIO;
> >                 }
> > +               ea_size =3D GFS2_EA_SIZE(ea);
> > +               if (GFS2_EA_REC_LEN(ea) < ea_size) {
> > +                       gfs2_consist_inode(ip);
> > +                       return -EIO;
> > +               }
> >                 error =3D ea_call(ip, bh, ea, prev, data);
> >                 if (error)
> >                         return error;
> > --
> > 2.43.0
> >
>
> the '!GFS2_EA_REC_LEN(ea)' and 'GFS2_EA_REC_LEN(ea) < ea_size' checks
> can be combined here. Also, nothing prevents GFS2_EA_SIZE() from
> overflowing.
>
> Can you fix that?
>
> Thanks,
> Andreas
>

Thanks for the suggestions. I have sent a v2 patch addressing the issues ab=
ove.

Best regards,
ZhengYuan Huang
