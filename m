Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3B3CF690
	for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034678; cv=none; b=Es+kg/v+nS4zTN7sNsiRD3EnAvYbT9qjT2RyEg+sElx1Bqzv/jNBIPkmQ0zjDwwGBuw7Zgl+LvWrC4ZBwfKx0pM0Z3z5nId1FMsV9fza6PRUowhtcgq/iLILnOQs6CJgMRyHawJ4yymI/mi7mps5rk8UlCZdNu/5twnThZax8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034678; c=relaxed/simple;
	bh=Bp57fxXccEyZo7eCBMIJz7o2M6hhq1JUkfWOloseNpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn/nfck7r2UzGp92K2s5KEPecTAhD4pgVrxeJn5ksslsIvROHmgek3rmnfj08l/WvlQ3HRFrip7zU+9ei00qUSSo2r15np8IIJwfoYU9oBNXilNLLQhsJnu5fP6iLEjQPNMGRX2n8YnkObIyIT82h7GGMf/M8yXsAih+7oOm/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy/8GavL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy/8GavL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777034674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1t1MXe2Q9a3etDjKSutlvVl0W5gekoYOezAKFlbUB4=;
	b=Fy/8GavLwD73a+mi94bdL1ypLuohK0scb8dfo/+m8vzash2spODv/hfr7WDfvAxePwLEzQ
	rm5FYl2p86bOGRG/kCfqUbm3jHL52BWALY162UC1BxlEgjzv0pmAI8Fb5z1rs0CPsY0UA2
	MBXx5heIvv9wDcBUzQ+o1/Oyyzvwn4g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-jpbBJdcdNDe3MDcyPVCZtw-1; Fri, 24 Apr 2026 08:44:27 -0400
X-MC-Unique: jpbBJdcdNDe3MDcyPVCZtw-1
X-Mimecast-MFC-AGG-ID: jpbBJdcdNDe3MDcyPVCZtw_1777034667
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-799001d7289so191412197b3.1
        for <gfs2@lists.linux.dev>; Fri, 24 Apr 2026 05:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777034667; x=1777639467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1t1MXe2Q9a3etDjKSutlvVl0W5gekoYOezAKFlbUB4=;
        b=Q7ePkrHYJGCvkcqXBDFPb1V8UZ2r9ZyejYAnWx1oj7WMGWvCiMuvXJdBZINi55P15O
         J4yvnemejs/AVVR4TrVsAZ9NiMJ0zy0fzGaHNM17d5bh0cKzZMrtJUaPs7dpqpx015c/
         U/nHpDoGpYXTXUkgO9HaASKV5lU8RGXlVNgF23ZvtUJmoP9pIjpRu8X1eUicSwvW+ef4
         V//LNuTq1WqgHbxuPQj6FQody7eAnrcg9TjUEULlKK1TjGFeF9JmtMV1+t27zV9Gs0AX
         LS0UwvCYVUi2vTrFGPUghDPzekPSEsh+pfB5JroUw8Z/BSAjih6u3wsJbIoShYSJRZ2k
         xmXg==
X-Gm-Message-State: AOJu0Yx+CIsBejmvjcnQYWc4zqzdEIRqg7Zz8cGw8boHN8Ic+LrsnSor
	vuCOm3wMIRtqme4zGe4pxVFG7x0O7fjdcNkWQJhbeXTLTyHs1bgeho7SrQ8i4F71ImoiHOZ0zWH
	3wtoDjpmhxXPf8MifQdPHxU0RLyeMjsFo8asT2T/60tjssgQQrDNQuP2B0ZpngJGxYmAf/+OjJA
	e7FU+29XYvg5QpDzWgnPyZfeoRJys9MA==
X-Gm-Gg: AeBDiesAc3hY2L/OeKKKdYjLmdqghTvz0ZhAlKVmj+WuFsHuI/PwRwUF2s89ZWShLyD
	xgUC0V/87ADVpeQs+Us3LbIYHfbc7tEM0hrdP9c3vWi8pEDj8u2Ch5i2QieqzJXRNlrW1LCTQX/
	FxJXLnKu6kjTlUcnh/5650T0jk4alObMBuoJRB8qRMRjSLrhrLCZfKtQ7y+gqxr5S5g5VOu0+q5
	TwfjQfFh0KXif3FRp729PBZVgzu7g2lY8TVxmE9VX7BrIqEzuva+PRYVlipbtFJOkeTxhnkFe2P
X-Received: by 2002:a05:690c:e04e:b0:7b1:3579:2ef7 with SMTP id 00721157ae682-7b9ecfb47d1mr262730897b3.28.1777034666704;
        Fri, 24 Apr 2026 05:44:26 -0700 (PDT)
X-Received: by 2002:a05:690c:e04e:b0:7b1:3579:2ef7 with SMTP id
 00721157ae682-7b9ecfb47d1mr262730757b3.28.1777034666277; Fri, 24 Apr 2026
 05:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424040656.1366-1-2200013188@stu.pku.edu.cn>
In-Reply-To: <20260424040656.1366-1-2200013188@stu.pku.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 24 Apr 2026 14:44:14 +0200
X-Gm-Features: AQROBzC60mXWk5Uv2V0FRrCX_wdkHhC5Es22EvlVFYR6nABiIy8qXPZXGkmA51Y
Message-ID: <CAHc6FU5C-qu_mtN8FnXy3nY_jnskDr2EQqESqCrwU4MrDy9_VQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: keep per-bio end_io when splitting journal head reads
To: Wxm-233 <2200013188@stu.pku.edu.cn>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7vEFKqFr6gC1oIhZcIIuIJBRLWoUlHSZAw5JnYjlVOw_1777034667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 24, 2026 at 6:16=E2=80=AFAM Wxm-233 <2200013188@stu.pku.edu.cn>=
 wrote:
> gfs2_find_jhead() can split a folio across two bios when part of the
> folio is already queued in the current bio and the remaining blocks
> need a new bio.
>
> That split path currently calls bio_chain(new, prev).  But journal read
> bios need to retain gfs2_end_log_read() and bi_private so that each bio
> completes its own folios with folio_end_read().  Replacing the new
> bio's completion handler with the block layer chaining callback breaks
> that expectation,

please see commit 469d71512d13 ('Revert "gfs2: Fix use of bio_chain"')
for a hint on how this works.

> and fuzzing workloads can hit a BUG in bio_chain() on this path.

What specific test case / reproducer is causing problems?

> Keep the per-bio completion state for the new bio and only submit the
> previous bio.
>
> Signed-off-by: Wxm-233 <2200013188@stu.pku.edu.cn>
> ---
>  fs/gfs2/lops.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 6586963..3d0fad3 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -481,12 +481,16 @@ static void gfs2_jhead_process_page(struct gfs2_jde=
sc *jd, unsigned long index,
>  static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iove=
cs,
>                                   sector_t sector, blk_opf_t opf)
>  {
> +       bio_end_io_t *end_io =3D prev->bi_end_io;
> +       void *private =3D prev->bi_private;
>         struct bio *new;
>
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, opf, GFP_NOIO);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D sector;
> -       bio_chain(new, prev);
> +       /* Each journal read bio must complete its own folios. */
> +       new->bi_end_io =3D end_io;
> +       new->bi_private =3D private;

We surely are not going to hand-roll bio_chain().

>         submit_bio(prev);
>         return new;
>  }
> --
> 2.45.2.windows.1
>

Thanks,
Andreas

