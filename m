Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CD1DEFDA
	for <gfs2@lists.linux.dev>; Sun,  9 Mar 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541632; cv=none; b=q3EGZGxrbKg8GYaE+Lz+0jFpcw6BsWy1Rl8GvT71FMafmtJ5pZSiH3sta/DitBFZwPmiYzKM8gUtPCyMg2PiiC37U4RybYWBfgQfW127Hrgxk5tXtIkDLYIBDdi1SZnbKpqUXRJBFHWo0NpK0FAyIHTLnVSDxd0s8YwJS2BBZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541632; c=relaxed/simple;
	bh=ksP0cXW8blsb4N3DQKO2j9P0hpNgct+vTqOK+wzNzc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0awWnV5BGhKYAZRUZR4r0+U0Vkak5cl28pUHDA5ckQE6a/EngI+2ZOM8wH3Eybdjje5q7p6hT5VCwy94ByWxSFoJCYBspVlGoiZ3A9TdQe7i628Qhas9b+qULDGoXSzOZA/KNr6jvTfp//YztayPI9Ju+gQHKjmofSWMTwzljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5VQ+1C/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5VQ+1C/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741541629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeae9JjlVYfhzOaUnO+d6huNE0ieO5ZoDoGmXZOCzww=;
	b=a5VQ+1C/4Uur6a7DZdJ9v7j2SwV8CH+DaDtxv42afQ+DTay//dfNF/zQ4Gq4YeRTdFkUsi
	pbl9LNJUqE0wrs3nHqihUnZKVPaA8yHGD0F0oFl+t1IqApJCNbOjOgRDksUyTpziVln2th
	rMUshwbJCbIzzblcM1Nsr39Qr/3Do1A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-aKx_6HJYNvqq94CQqJWupA-1; Sun, 09 Mar 2025 13:33:48 -0400
X-MC-Unique: aKx_6HJYNvqq94CQqJWupA-1
X-Mimecast-MFC-AGG-ID: aKx_6HJYNvqq94CQqJWupA_1741541627
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223f3357064so53545625ad.3
        for <gfs2@lists.linux.dev>; Sun, 09 Mar 2025 10:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541627; x=1742146427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeae9JjlVYfhzOaUnO+d6huNE0ieO5ZoDoGmXZOCzww=;
        b=AOf+l/VO4XQ3eh6/vzxNzW3chfB+/5PwWiHXg/aKFhVGjQCnswGe0ed3Y9PHj7HxXH
         2GekGX/WzkhdZyT4kEhvePrONo/c2lSSaaP1tHqKyig2X5RScP8ezc2/LrBnqsxisBTS
         JuJwiTzk8qg2UUEa+Jp75CyVY+1lFkDtfgwzaulLeRcsFL8WylrWPWuBvx0b4h5CIv1j
         B5iS1sg+IT3YhubpIYYdBdMPSEnEABXzBBhN4XJnrTmav3ZryERb0qgmHQLi6lIRtw8t
         SR2lUvvcAt4clrCh6K9rwR5wXSnMVh8lw4RGWvGno1esJEzlhtUuHkFrSxxSvlPsPeCw
         YCRQ==
X-Gm-Message-State: AOJu0YyK6twvL8Un9a4/kFfA2VNJnI1WDRpVYHZlf915YLSe6l/lvG40
	SIce6SvGmhkLSYRasCN9p5lvAqnCjQjYV3cNVIvsmbu4VfGo/vyR/VMAH6Z4RAbeUWn7tyIvD24
	0vwzCWh4eG8232dls7gKX7nlRbYFwoCe0fX+r52x/6IRIBTFhxIlGv5jnfyZVH7shBSpijQ1Siq
	7YrwcsmCtKGyr+kDQ5Q9pvoxCY9A==
X-Gm-Gg: ASbGncuSiSWsThr8JJR3bSvqItmA5QiVMrvJ/7jsvh66xSLzZSMXpog16jjXvUY64kQ
	jyY9JDbFk08Y36XCs8NuutY/txDPPdezblzZVvIAJ+vaNljy+8BkoLjv/djsJch64g3J206w=
X-Received: by 2002:a17:902:ec91:b0:223:5e54:c521 with SMTP id d9443c01a7336-22428407e93mr160560605ad.0.1741541626935;
        Sun, 09 Mar 2025 10:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVeDJCNpU/bu5I9HyJljFTkBhxqx876qq4ego7LCzUKnkF4Lo6jqqGi8h0EorvxRQ+zWmeRpKHOCEFD82UudY=
X-Received: by 2002:a17:902:ec91:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-22428407e93mr160560415ad.0.1741541626548; Sun, 09 Mar 2025
 10:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
In-Reply-To: <20250210133448.3796209-8-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 18:33:34 +0100
X-Gm-Features: AQ5f1JoErhymXT73WDCjWnMgsHtNHHCwZXK7ooTdMPlPz3zxsx8DcT30iEwSeZM
Message-ID: <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PjCxr7qHWihcOulgqtC1FMi2s5JY89gAX9l5s0xqEaY_1741541627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> gfs2_end_log_write() has to handle bios which consist of both pages
> which belong to folios and pages which were allocated from a mempool and
> do not belong to a folio.  It would be cleaner to have separate endio
> handlers which handle each type, but it's not clear to me whether that's
> even possible.
>
> This patch is slightly forward-looking in that page_folio() cannot
> currently return NULL, but it will return NULL in the future for pages
> which do not belong to a folio.
>
> This was the last user of page_has_buffers(), so remove it.

Right now in for-next, ocfs2 is still using page_has_buffers(), so I'm
going to skip this part.

Thanks,
Andreas


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c              | 28 ++++++++++++++--------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 30597b0f7cc3..8b46bd01a448 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -157,7 +157,9 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned int=
 lblock)
>  /**
>   * gfs2_end_log_write_bh - end log write of pagecache data with buffers
>   * @sdp: The superblock
> - * @bvec: The bio_vec
> + * @folio: The folio
> + * @offset: The first byte within the folio that completed
> + * @size: The number of bytes that completed
>   * @error: The i/o status
>   *
>   * This finds the relevant buffers and unlocks them and sets the
> @@ -166,17 +168,13 @@ u64 gfs2_log_bmap(struct gfs2_jdesc *jd, unsigned i=
nt lblock)
>   * that is pinned in the pagecache.
>   */
>
> -static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp,
> -                                 struct bio_vec *bvec,
> -                                 blk_status_t error)
> +static void gfs2_end_log_write_bh(struct gfs2_sbd *sdp, struct folio *fo=
lio,
> +               size_t offset, size_t size, blk_status_t error)
>  {
>         struct buffer_head *bh, *next;
> -       struct page *page =3D bvec->bv_page;
> -       unsigned size;
>
> -       bh =3D page_buffers(page);
> -       size =3D bvec->bv_len;
> -       while (bh_offset(bh) < bvec->bv_offset)
> +       bh =3D folio_buffers(folio);
> +       while (bh_offset(bh) < offset)
>                 bh =3D bh->b_this_page;
>         do {
>                 if (error)
> @@ -186,7 +184,7 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *sd=
p,
>                 size -=3D bh->b_size;
>                 brelse(bh);
>                 bh =3D next;
> -       } while(bh && size);
> +       } while (bh && size);
>  }
>
>  /**
> @@ -203,7 +201,6 @@ static void gfs2_end_log_write(struct bio *bio)
>  {
>         struct gfs2_sbd *sdp =3D bio->bi_private;
>         struct bio_vec *bvec;
> -       struct page *page;
>         struct bvec_iter_all iter_all;
>
>         if (bio->bi_status) {
> @@ -217,9 +214,12 @@ static void gfs2_end_log_write(struct bio *bio)
>         }
>
>         bio_for_each_segment_all(bvec, bio, iter_all) {
> -               page =3D bvec->bv_page;
> -               if (page_has_buffers(page))
> -                       gfs2_end_log_write_bh(sdp, bvec, bio->bi_status);
> +               struct page *page =3D bvec->bv_page;
> +               struct folio *folio =3D page_folio(page);
> +
> +               if (folio && folio_buffers(folio))
> +                       gfs2_end_log_write_bh(sdp, folio, bvec->bv_offset=
,
> +                                       bvec->bv_len, bio->bi_status);
>                 else
>                         mempool_free(page, gfs2_page_pool);
>         }
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 932139c5d46f..fab70b26e131 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -182,7 +182,6 @@ static inline unsigned long bh_offset(const struct bu=
ffer_head *bh)
>                 BUG_ON(!PagePrivate(page));                     \
>                 ((struct buffer_head *)page_private(page));     \
>         })
> -#define page_has_buffers(page) PagePrivate(page)
>  #define folio_buffers(folio)           folio_get_private(folio)
>
>  void buffer_check_dirty_writeback(struct folio *folio,
> --
> 2.47.2
>

