Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EF471D09
	for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316875; cv=none; b=C1w4rMUkZ4iLgRE8Giw5rOqqmy4hS5A+iwxjGdGsjDzxY3HSd/pwXtqffnXSRVDOzsS6OZiUuRatSkkYwZwcDI48GisGMfElLdPmLaAvxzcOIaJoRZI3bEcL8rmYbp2PkKJfAlOu0PObYzfRxicRjMh2CPg/B8/TgJTo8/UVtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316875; c=relaxed/simple;
	bh=1qHc1vG+5eFC+XMUvGsfkxVTjPKBUO/DSjc8eaOqMJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMuG8IFZQ5L2gZetKCUD9s0y3TYkxSDbjuzX4kxidqVQBvzTPBUOPCaI03pGHrC4hdMgRm2PhxS6xIJh9ka0H0utpqUDv40TeCe9vOyGoQOSW2yzd104/h/FPgasTgOqSF2Hu76JBYH8xF4ZBadSRXihNLqw2SZXkZatWz88YFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClW0ENRr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClW0ENRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787316872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3T0DA5j0vwcwUo9HIMuCVlwa1ONI5AchHTxjE6rvQY=;
	b=ClW0ENRr0SKnR1vPRfriR0uw0as8k/CXALmMG9BQsnaHQHARf7jF3kHlTCJB5rGM3UJ6uh
	hFzf6PxC2P6DzFr08BJBDFBdbL1+KPjR9E42e/fwaajyG7dXvc6Vm/RmZv/ONRKb4V2owl
	1iC/R3qK5sKQuNkIPVdFCgyCN7edqWs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-NZJeaVrqMEyLX_l0eDN40g-1; Fri, 21 Aug 2026 08:54:31 -0400
X-MC-Unique: NZJeaVrqMEyLX_l0eDN40g-1
X-Mimecast-MFC-AGG-ID: NZJeaVrqMEyLX_l0eDN40g_1787316871
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cebffd238so870212d50.2
        for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 05:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787316871; x=1787921671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T3T0DA5j0vwcwUo9HIMuCVlwa1ONI5AchHTxjE6rvQY=;
        b=U8xbuS+LGsIprmXF0r5qdtX7c50VmQWLt8XLnWl3zr1uV0Ocm5nx/dU35xiuyaWPM8
         RKHbQrC95pPODLEyc07rGQxuqs+naTXOianWfWrB6THmvG4xX1sAbXoIOmDNb6c0hM+R
         /2zTAImb96QgCqc85HckmgS6WMuRE4NMJLjZOr9ya1hTNXen2cW4Yp1thFRPt0jX7V/4
         WrY1wvKvakTYUof+OWnfrICYsu3JC4yKFh9cU/ImKtO6z5je+8M1wwmId6yipjyKftK7
         1qyh14UnLCnZ4lpqITThpx45Ev9SgYdPbbmzuPpva9lS5rUOoc4y/o4W1qzcVwlUmB1U
         Ywkw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7REJpyVbayU3v5pYj6kBUb+r6nr3IaHT1VUWvYhipsQ3j5zigH2ieLMLLDKxBYEjUuXVw@lists.linux.dev
X-Gm-Message-State: AFuF++krGB3aRl0xyH4/RcQuN+kBIzJMhvunuHJOBNngEVJsHntqlib5
	0RboOsiVOairWSpdPgl9TxOZrE6GzJr7ucAtrL1r8v3cHfwmLCqS0/4oj/QOEiFbJdYDxyQlBKp
	BTpbUWnNJa37Ijs7ogtDaqVH98TDWANATv1LWm47QLrN92eXFXzk1sxxZ2gfTZg5mCucxBD1vVe
	QKF+Ws8uY7KWvahYuRW3Y5Ve9LQxWG6w==
X-Gm-Gg: AR+sD13mgf51AVi/gVk/742GAMo86Tt7TG3gmoQQa01wabOCx+mbCXpmagFYGfi+dI0
	CDq/dCBZmXLuZvEvQkHR5deObDxpH5g6svzCOcbjeYea0k6qffyupmWVMJ8zfV3qdqpcI7gmqwu
	8XSBwEDl53jyy3Wg2d5anXTgjxKZN9GTjt1qEKYEo57eTUSe0oV5X63Q+QXpZzXGecDeJbIucsd
	d9f/02HCShnLcMh3m/cX1CETO8A10SRpFpx9AvuVb0a
X-Received: by 2002:a53:ce8f:0:b0:66c:e3eb:9443 with SMTP id 956f58d0204a3-66ce4ac2100mr1991126d50.31.1787316870689;
        Fri, 21 Aug 2026 05:54:30 -0700 (PDT)
X-Received: by 2002:a53:ce8f:0:b0:66c:e3eb:9443 with SMTP id
 956f58d0204a3-66ce4ac2100mr1991100d50.31.1787316870126; Fri, 21 Aug 2026
 05:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a863306.ae6ddae5.3da009.0013.GAE@google.com> <tencent_D69518E8F6ED56CE0479766DD82CC56EF00A@qq.com>
In-Reply-To: <tencent_D69518E8F6ED56CE0479766DD82CC56EF00A@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Aug 2026 14:54:19 +0200
X-Gm-Features: AcwNN1WdIh2VqMnJFVL8XqYKLmq06uENKjCJ84-TLUojbAOKdvIO7i189zyeTag
Message-ID: <CAHc6FU4HnRSQmtLyTJsZ=qio7NEBFbkN=Y2GyG46=nn_TYi1pQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: valid the length of rgrp header
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com, swhiteho@redhat.com, 
	akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@kernel.org, gfs2@lists.linux.dev, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vbhRDgohBQQ-Kwi0C4CLucIbdVT0ieJyf_c98l6fI7s_1787316871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:37=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> When mounting a deliberately corrupted filesystem image, an excessively
> large rgrp header length is used in a call to kzalloc_objs() within
> compute_bitstructs(), and the memory allocator cannot handle such a large
> allocation request. This triggers [1].
>
> Add a check for the rgrp header length to avoid [1].
>
> [1]
> WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x2427/0x2dc=
0 mm/page_alloc.c:5280, CPU#1: syz-executor256/5629
> Call Trace:
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
>
> Fixes: bb8d8a6f54c1 ("[GFS2] Fix sign problem in quota/statfs and cleanup=
 _host structures")
> Reported-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9d20c3ad7d29227de28d
> Tested-by: syzbot+9d20c3ad7d29227de28d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/rgrp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 5988a165a830..53d097ce668e 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -899,6 +899,7 @@ static int read_rindex_entry(struct gfs2_inode *ip)
>         struct gfs2_rindex buf;
>         int error;
>         struct gfs2_rgrpd *rgd;
> +       size_t size;
>
>         if (pos >=3D i_size_read(&ip->i_inode))
>                 return 1;
> @@ -917,6 +918,13 @@ static int read_rindex_entry(struct gfs2_inode *ip)
>         rgd->rd_sbd =3D sdp;
>         rgd->rd_addr =3D be64_to_cpu(buf.ri_addr);
>         rgd->rd_length =3D be32_to_cpu(buf.ri_length);
> +
> +       size =3D rgd->rd_length * sizeof(struct gfs2_bitmap);
> +       if (get_order(size) > MAX_PAGE_ORDER) {
> +               error =3D -EINVAL;
> +               goto fail;
> +       }
> +
>         rgd->rd_data0 =3D be64_to_cpu(buf.ri_data0);
>         rgd->rd_data =3D be32_to_cpu(buf.ri_data);
>         rgd->rd_bitbytes =3D be32_to_cpu(buf.ri_bitbytes);
> --
> 2.43.0

Thanks. The patch I've pushed to 'for-later' for validating the
resource group geometry [*] should prevent this from happening in the
first place.

[*] https://lore.kernel.org/gfs2/20260821124944.1648686-1-agruenba@redhat.c=
om/

Andreas

