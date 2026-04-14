Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C886341
	for <gfs2@lists.linux.dev>; Tue, 14 Apr 2026 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132177; cv=pass; b=BJeFx+C7SKzuGRxbAxjjmzWS/T3CVrDOM+Po/QGGq7an4ipG6FcfJri8apbXVzbWzHALndpmwPCs8RHon5KoE9QSeeXpdQr3XRY+1UNwdTa78ojdaanK4w8VbKAbeh57jAjK5XbtOGcfSIx2nbgJVVcmWsddLJ/AqpDWM2AaZ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132177; c=relaxed/simple;
	bh=J9CZFbm9imKqTfEnPgpMollChYlJpTpsb4lx1M8IUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z19hiqyV3GzCriqvxCOCOb6cSRAzNsFr/JoVi2+kqQ4f2PG5H3wOY20MITJopHLBiX07cx1Ki96w7petT2LBfr/6GGjZXYqCo26VwcoGs9Ma0eeS/NxaIm8jrb2kybZVg/+Zochtt0dPCeBIiT1SJMMswmQoElNk41nC+YFKghI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idbdbuY0; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idbdbuY0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7991db3dc98so57351767b3.0
        for <gfs2@lists.linux.dev>; Mon, 13 Apr 2026 19:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776132176; cv=none;
        d=google.com; s=arc-20240605;
        b=WbUQyOqUaqV0IStQJjP0/EUDtmokZJiLqZBeF8Xz4uvjq2N8u7xQxjV9pk8j0CeSY9
         U+etxftJTJkXppOFVa8AFBdCsU3APmXAhmiAOdOQXAlljy6QLl2J20StLMrFqtvsXkuF
         i3n1zUdkchw3K4QeoPHm1h0/ZWpW9zVX9YEaiVbdl0dRcd7WVOsf0MOL9GFtof3Tf1YC
         Hpa/r0UYFjIM1UqUeyet8pwUP0xkwe2PrLU6okvFwCozix6d9u++PbY4C94OCmT2wI8t
         BmSDjOnFMpwB+BMO0BNwtnEziZrXKY+hMikL5XGdp5i5MIlPQqX9c48nzrkd8/YEmMuZ
         pGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdNUawKs4ElDaD1HAy5f1l3390/zog6++SP9nMeva18=;
        fh=YSUDtAMBt0ELmTcD+3XDp0DoLXzxcsuGmSa9dnOXaSI=;
        b=BLKPhD3waRka0+U7lL98YWHOdjvViAK0u/2pSpr/A5fM6BH2z2aOIRnJ1JgL3sg69O
         Bo0/14NJY6z80LZTrGMgG+aOJCwVATnEhKBuZL/FD68VTsmU0M1Vrk1B0UYrKP9l+ctp
         73h3HfppLZBQfzC4sKF4g1Au14UswR3O7Z0Vy1K6CbsmkmG3GzRCKUUAY+yxZ1axNoiB
         M0jPU7e9KOcTG0EuoejVWWAZHehtkB+i+dYjoN2rFJr40VXpVKw9Lr6bUxTGFcJcBn8k
         GAgCGNpj7ylTnBxS6o3+ZDbtdkIjOxYYEIEvdJbfxjEzDoAg+YDEvNtF5kMDf+3OhErA
         Is6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776132176; x=1776736976; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdNUawKs4ElDaD1HAy5f1l3390/zog6++SP9nMeva18=;
        b=idbdbuY0WBZoc92234FM7kR9ETY9Zupn4YYDDRC3CEV7a5Zy1n9lfMpYF6cHDGwgTK
         DIF1uaB3ZbQRXvDB73MydCwbGgCY+FCpc9keG3iqOe/0wMJEa5OfePYQnjS2mQbsJQtM
         UTRFvE8PuEj+9SNEdrjEW2Kv0r35fXI1mFws92C2KP4dY/5wsbOfOR6iOoouc2MUqYj/
         dCfLslrIQpew0NpejLf+UGqX9OChMItBi4QRBnmCmeYH0UpbMTL+U49aS0bBSmSYr9rH
         5LYG7uEG2nXczVeLuwZ9PyM+yLX0+UB8jJDsnm8vh3xUdbTkPaJjN+lOXHIeiS4h8AK4
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776132176; x=1776736976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdNUawKs4ElDaD1HAy5f1l3390/zog6++SP9nMeva18=;
        b=bSV2L+88q7d2q1FaH6qhRXGnPxbtuiLGIr0afSAJDaAg9OM/D5EXf/b2yb9azcJ/Tn
         0lD67YMZ0lpdMG8X+AVZ7AcIzHiw0C9YZDbHFHPhYl9nld4gXVVVUzM8GGGAkusVMzbC
         RMDPrkz/jnzl+Nipha39cP1eUn327YF0IAUfFufnXVh9fbgjFSYGWdDhHxwHHdnUduA9
         2Y+2ZLxRtD74zCGnnx6W8J/Fdn7DKobMuE6IIRlCniXAxjV4iffjCYvlGBMvfUNRH114
         OATcqEKs8SdEBVMd8dXA+FhvIDsjSZhytRYyQ+Wo1xc7+AU6haIUQEh/EKavcSpHkhD+
         waIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/rXwj+BxcOPXoR1wsinDLaFsfRThDnTRnBoDvds1kP6WCmOJCh7oxRo8RLPIRFXiQNb8w@lists.linux.dev
X-Gm-Message-State: AOJu0YwbZ++X/yG/NGqdETF3Il8/i9R5sFk4TkB9KtG/SlTUQzxhP89N
	nOGTASnaspl4XRZTD8wtTCKKaOvnZ+iSFFLIwW5OYNKmPcYTQoJoHNgMTphiDO67mUIJGdZrF27
	L5aNAAjfNS2R0FRy0+v3lvqq4JKm1CKg=
X-Gm-Gg: AeBDiesUK2dvMGEu6qpDwrkhEU9BBLGgbP1ceU+e/Q1iJ4TaAqnBhrhdwU4bOk/ODDm
	C2bPjbiikqcuv7wpZG/5dirBdU86lNM4MqRmhFmdJMas0TC4b/lQOjTkDj+WUbkkA6fn4Jh8pLZ
	S8SA+oBkuVx0boac0/k9Q5CagE/Qbxe0/vk2TLDfhh1fD5rteNxYQQrDKVgFoh+Llqx5vb2uYdv
	iNTGMYd7+dFVv+kdQucGQfsDcasaLuzXywzvE8/IjyLXLsFDrO0eGgozlHrT4LW/KTod9sJNeph
	1ku0PNxUEVw20zjfvJdmmX8gpiNKFapDKR6XtzK9v6letaq5KNWN4jRa4uPIlDTyw5kiEIYx7ZY
	jyGOo/DE=
X-Received: by 2002:a05:690c:c504:b0:7b2:64f4:a2be with SMTP id
 00721157ae682-7b264f4a8bdmr80531697b3.3.1776132175803; Mon, 13 Apr 2026
 19:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325235155.9503-1-kartikey406@gmail.com>
In-Reply-To: <20260325235155.9503-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Apr 2026 07:32:43 +0530
X-Gm-Features: AQROBzDr8lPPwwUfVLA9rulzlfXlLs91mtlUicFrHD6wWwOVuy5EGDYGpokZ9ng
Message-ID: <CADhLXY7kjkQXxMwvOpcQ3mu3wBiv9JM3XqsO=+CFvwxCzvCXhA@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: reject journal extents with gaps
To: agruenba@redhat.com, willy@infradead.org
Cc: adas@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:22=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> A malicious or corrupted GFS2 filesystem image can have a journal
> extent list with gaps between extents. gfs2_find_jhead() advances
> blocks_read sequentially through all page indices, but only grabs
> pages for blocks it actually visits via filemap_grab_folio(). Pages
> falling in the gaps between extents are never grabbed. When the
> cleanup loop at out: calls gfs2_jhead_process_page() for these
> pages, filemap_get_folio() returns ERR_PTR(-ENOENT) which is passed
> directly to folio_wait_locked() without checking for errors, hanging
> the kernel task in uninterruptible sleep (state D) forever,
> triggering the hung task watchdog.
>
> Fix this by rejecting journal extents with gaps at mapping time
> in gfs2_add_jextent(). If the new extent does not start exactly
> where the previous one ended, return -EINVAL to reject the
> corrupted journal early, before any I/O is submitted.
>
> Fixes: f4686c26ecc3 ("gfs2: read journal in large chunks")
> Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9013411dc43f3582823a
> Link: https://lore.kernel.org/all/20260324033959.1456418-1-kartikey406@gm=
ail.com/T/ [v1]
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>
> ---
> Changes in v2:
> - Instead of checking ERR_PTR in gfs2_jhead_process_page(), reject
>   the gap at extent mapping time in gfs2_add_jextent() as suggested
>   by Andreas Gruenbacher.
> ---
>  fs/gfs2/bmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 1cd8ec0bce83..d3ba37291e4c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2219,6 +2219,8 @@ static int gfs2_add_jextent(struct gfs2_jdesc *jd, =
u64 lblock, u64 dblock, u64 b
>
>         if (!list_empty(&jd->extent_list)) {
>                 jext =3D list_last_entry(&jd->extent_list, struct gfs2_jo=
urnal_extent, list);
> +               if (jext->lblock + jext->blocks !=3D lblock)
> +                       return -EINVAL;
>                 if ((jext->dblock + jext->blocks) =3D=3D dblock) {
>                         jext->blocks +=3D blocks;
>                         return 0;
> --
> 2.43.0
>

Gentle ping on this patch. Please let me know the status of this patch

Thanks
