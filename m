Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D738BF81
	for <gfs2@lists.linux.dev>; Mon,  4 May 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901245; cv=none; b=nUHYe7wV+VwdYUWw+lNBKH3D0Ku3O4dUvfjbGZuRUAGObqHq8biBifds7asUqRG3PmalHShLT98XnqvhT9TC4Aw1xHI7DaIxvRmGkTHtoU49Cqt73PhcF+qFktVbWnT9rt5XBucSz4YLdCSnVUCqCzJJMsPp9WljmnTn43ghTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901245; c=relaxed/simple;
	bh=MqF6FUYgis3KwcqcTfQ6etplj3HIF7QPvFwcDfb6az0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otnMoGVKxOBBKnO+NhgoRjiy/gwpLNTuyLne4Yq4Vgjoevp2hmAYJ5nrmLFR4x4A8M6eJxYD/bwKvtrVim8Otj3lHSgjrrcignjoCVAfIxpWb29RpwhlE/N1yzfpY85h0TVzZ7nDmQZAkvglh9WNfyDQI7Ns/gnExmZU5RDtkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FeaNSksk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeaNSksk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777901235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8PT8QvrlTsvswyoEi3qIcZ8PVq3ZsvldIX7zwiXquk=;
	b=FeaNSkskYeGuTdUhfAkPG+79gtJzzhv2LkxbaLCY0MCiMq9DD6d1Vb1woEZJfJZkT6t1+R
	VM5/veHMJT0o9UNJMwNO/uOZZN23gE35acvHdpQWR5AQa0cHLM6WJ8cQmQe494Vq0Kn3MF
	sgrDuSVf3qPOInbLTJyPH3M+kgHenLY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-vCbj_dFbMDuyU_FPVJwSCQ-1; Mon, 04 May 2026 09:27:14 -0400
X-MC-Unique: vCbj_dFbMDuyU_FPVJwSCQ-1
X-Mimecast-MFC-AGG-ID: vCbj_dFbMDuyU_FPVJwSCQ_1777901234
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd49a2467eso78124597b3.2
        for <gfs2@lists.linux.dev>; Mon, 04 May 2026 06:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901234; x=1778506034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d8PT8QvrlTsvswyoEi3qIcZ8PVq3ZsvldIX7zwiXquk=;
        b=HNvPhaNzbWfys71oMGZN1SFqcr5Yk8XI6yaVos3wq6LkUsxyrJnU5mABX0pciOVKyS
         J2ObWBdJrMIZiN+8s0VKW3gBpAyo249DQP7RTbuUDUl+IEQXPDOI9mZgbuJ0i53cRxDm
         nxtoLzrM9E6Xf7hmzuW3Qawe7KsewQ9k2p+z9dWYLANLyCDEyolnRyGR9HAETMty2yum
         TcEOzVHDcBDYQc/zPggEdwkRkksodqXMo3z6Vgjr8cNc98ArQOV/BBSm8Z/gChFC7A55
         fyOmMqfsElfEetQLQD6R7tteFmm90BfzFZ4h6dFMEGnjkzghwK0rTUwV14fA0b1GYQJo
         lJtA==
X-Gm-Message-State: AOJu0YxyrqeZAwxegNJEMC+clgW8+uHrFHDPyeozsNv1Y3s38BDCoTYw
	1+3t4oOSVjjbmnslV1q5XlhFaqADcUFmK7CRu37Vp/qSx+BkEpJY6dy+Y3hyDulX8H8DCkZv4WD
	50IWS1CY16SUnY/E2BhgcT+comXJiJG5NALgJ8/LdujTp+AO1AG3pZYpeBINzMa09jTHO4Cf0gU
	Ol8svBM85ieLAlxJECsUbkwQG//HeSXA==
X-Gm-Gg: AeBDiev1HmPYJ0Tq04E/IsagUb7bZXVMUA7gJzl5zla6OHZGGSr9Mdiyjx2gL9e9bJz
	S/lMJWfpEO/3x38okzVtD/dgVUSnyJ4w9XOYfkDKKYkOdbmq33omj4sbe9Sqk2GkHnbt+is/lAR
	rU+38UITbCGaBwo4Qgkekj5WydjGDVDgV8YAb3i5E2c0WR/6LY9sje7Rd9CXyz4HGd1PeQiyRre
	d4+ENXN4Up7wQOioDKaP/gL4Kx4AOoVPyXSy8BYiYszRfA0To7VwicFrTGX+FxoLmNWnFzaFpJV
X-Received: by 2002:a05:690c:c4e9:b0:7bd:7b2e:f09a with SMTP id 00721157ae682-7bd7b2ef268mr88401677b3.35.1777901233721;
        Mon, 04 May 2026 06:27:13 -0700 (PDT)
X-Received: by 2002:a05:690c:c4e9:b0:7bd:7b2e:f09a with SMTP id
 00721157ae682-7bd7b2ef268mr88401357b3.35.1777901233151; Mon, 04 May 2026
 06:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260428040408.981582-1-gality369@gmail.com>
In-Reply-To: <20260428040408.981582-1-gality369@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 4 May 2026 15:27:02 +0200
X-Gm-Features: AVHnY4L3PuFAIEYcWPROmifsg5_30fmRJXiR9vmOJCWg0cYYcSDph0rumRTGI3I
Message-ID: <CAHc6FU70L29zLCcVC3VMZu6pCMhoZTzAxCgFoEESnXqtrKV8jw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: reject undersized EA records during xattr walks
To: ZhengYuan Huang <gality369@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	r33s3n6@gmail.com, zzzccc427@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d-nXLzV_IAtVkFqLLQjXEJcmTwTkq75J0NX6pTYd8gU_1777901234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello ZhengYuan Huang,

On Tue, Apr 28, 2026 at 6:05=E2=80=AFAM ZhengYuan Huang <gality369@gmail.co=
m> wrote:
> [BUG]
> A fuzzed GFS2 image can crash in `ea_split_ea()` while servicing setxattr=
:
>
> BUG: KASAN: slab-out-of-bounds in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c=
:835
> Write of size 4 at addr ffff88801550a1c0 by task syz.0.379/950
>
> Call Trace:
>  ...
>  ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
>  ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
>  ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
>  ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
>  ea_foreach+0x3cd/0x5d0 fs/gfs2/xattr.c:140
>  ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
>  __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
>  gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
>  __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
>  __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
>  __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
>  vfs_setxattr+0x167/0x390 fs/xattr.c:321
>  do_setxattr+0x13c/0x180 fs/xattr.c:636
>  filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
>  path_setxattrat+0x1d8/0x280 fs/xattr.c:713
>  __do_sys_setxattr fs/xattr.c:747 [inline]
>  __se_sys_setxattr fs/xattr.c:743 [inline]
>  __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
>  ...
>
> Allocated by task 893:
>  kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x40 mm/kasan/common.c:77
>  kasan_save_alloc_info+0x37/0x60 mm/kasan/generic.c:573
>  unpoison_slab_object mm/kasan/common.c:342 [inline]
>  __kasan_slab_alloc+0x9d/0xa0 mm/kasan/common.c:368
>  kasan_slab_alloc include/linux/kasan.h:252 [inline]
>  slab_post_alloc_hook mm/slub.c:4978 [inline]
>  slab_alloc_node mm/slub.c:5288 [inline]
>  kmem_cache_alloc_noprof+0x1f0/0x7d0 mm/slub.c:5295
>  __do_sys_getcwd+0xe0/0x730 fs/d_path.c:416
>  __se_sys_getcwd fs/d_path.c:412 [inline]
>  __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
>  x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:=
80
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 893:
>  kasan_save_stack+0x39/0x70 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x40 mm/kasan/common.c:77
>  __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
>  kasan_save_free_info mm/kasan/kasan.h:406 [inline]
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x6f/0xa0 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2543 [inline]
>  slab_free mm/slub.c:6642 [inline]
>  kmem_cache_free+0x384/0x7a0 mm/slub.c:6752
>  __do_sys_getcwd+0x3f8/0x730 fs/d_path.c:446
>  __se_sys_getcwd fs/d_path.c:412 [inline]
>  __x64_sys_getcwd+0x59/0x80 fs/d_path.c:412
>  x64_sys_call+0x15ac/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:=
80
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x93/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> and also as:
>
> BUG: KASAN: use-after-free in ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
> Write of size 4 at addr ffff888023742118 by task syz.0.27/395
>
> Call Trace:
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xbe/0x130 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xd1/0x650 mm/kasan/report.c:482
>  kasan_report+0xfb/0x140 mm/kasan/report.c:595
>  __asan_report_store4_noabort+0x17/0x30 mm/kasan/report_generic.c:385
>  ea_split_ea+0x1f3/0x230 fs/gfs2/xattr.c:835
>  ea_set_simple_noalloc fs/gfs2/xattr.c:888 [inline]
>  ea_set_simple+0x66f/0x7c0 fs/gfs2/xattr.c:951
>  ea_foreach_i+0x2a1/0x560 fs/gfs2/xattr.c:112
>  ea_foreach+0x334/0x5d0 fs/gfs2/xattr.c:162
>  ea_set_i+0x176/0x3d0 fs/gfs2/xattr.c:1063
>  __gfs2_xattr_set+0x8de/0xc60 fs/gfs2/xattr.c:1215
>  gfs2_xattr_set+0x2ed/0x450 fs/gfs2/xattr.c:1258
>  __vfs_setxattr+0x14f/0x1c0 fs/xattr.c:200
>  __vfs_setxattr_noperm+0x10b/0x5c0 fs/xattr.c:234
>  __vfs_setxattr_locked+0x172/0x240 fs/xattr.c:295
>  vfs_setxattr+0x167/0x390 fs/xattr.c:321
>  do_setxattr+0x13c/0x180 fs/xattr.c:636
>  filename_setxattr+0x16b/0x1c0 fs/xattr.c:665
>  path_setxattrat+0x1d8/0x280 fs/xattr.c:713
>  __do_sys_setxattr fs/xattr.c:747 [inline]
>  __se_sys_setxattr fs/xattr.c:743 [inline]
>  __x64_sys_setxattr+0xcd/0x150 fs/xattr.c:743
>  ...
>
> [CAUSE]
> `ea_foreach_i()` validates only that each EA record has a non-zero
> `ea_rec_len`, stays within the block, and has a valid type. It never chec=
ks
> that the record span actually covers the layout encoded by
> `ea_name_len`, `ea_data_len`, and `ea_num_ptrs`.
>
> If a malformed record reaches `ea_set_simple()` with
> `GFS2_EA_REC_LEN(ea) < GFS2_EA_SIZE(ea)`, the unsigned subtraction in the
> split test underflows and falsely claims there is enough free space.
> `ea_split_ea()` then writes the new EA header outside the real record.
>
> [FIX]
> Reject EA records whose reserved record length is smaller than their
> computed layout size in `ea_foreach_i()`, which is the common parse
> boundary for existing xattr metadata. This stops malformed records before
> any update path can split or otherwise trust the broken geometry.
>
> Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
> ---
> fs/gfs2/xattr.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
> diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
> index b9f48d6f10a9..16cf31bde99a 100644
> --- a/fs/gfs2/xattr.c
> +++ b/fs/gfs2/xattr.c
> @@ -96,6 +96,8 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct b=
uffer_head *bh,
>                 return -EIO;
>
>         for (ea =3D GFS2_EA_BH2FIRST(bh);; prev =3D ea, ea =3D GFS2_EA2NE=
XT(ea)) {
> +               u32 ea_size;
> +
>                 if (!GFS2_EA_REC_LEN(ea)) {
>                         gfs2_consist_inode(ip);
>                         return -EIO;
> @@ -109,6 +111,11 @@ static int ea_foreach_i(struct gfs2_inode *ip, struc=
t buffer_head *bh,
>                         gfs2_consist_inode(ip);
>                         return -EIO;
>                 }
> +               ea_size =3D GFS2_EA_SIZE(ea);
> +               if (GFS2_EA_REC_LEN(ea) < ea_size) {
> +                       gfs2_consist_inode(ip);
> +                       return -EIO;
> +               }
>                 error =3D ea_call(ip, bh, ea, prev, data);
>                 if (error)
>                         return error;
> --
> 2.43.0
>

the '!GFS2_EA_REC_LEN(ea)' and 'GFS2_EA_REC_LEN(ea) < ea_size' checks
can be combined here. Also, nothing prevents GFS2_EA_SIZE() from
overflowing.

Can you fix that?

Thanks,
Andreas

