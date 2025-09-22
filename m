Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EE27A906
	for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583193; cv=none; b=DWiFXOF1YD7QR7eJJRWXeLkbKo2uT2F1zDfTbNmI8dDFUQDvxCqbAWskF++aoWsOZvPfdAxbN00mJlOvKx4U0FbXEZZymY5JBAbbnCOX/Wrs6YzO5WTFEH2n6d0p1vJ5srstsJbAhfw0OOdCLqT129ihfBgir7C30JNAg9oPl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583193; c=relaxed/simple;
	bh=/ZGhEdHxAf5En7VuJLPdUgSdRXXJT79QW6EW69v6ge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djm8q/Ahh8fl1ysdq2JGfugD2nkePQcaaVuXDRhv0+N36h/PUeujW84BnR2ntk2IxBqJTM1Hj7ouBEFMDA9AyIOtXuGQSowCvdOFFfBZbLR6qY5J4VdQk1JQ8q1VuC6Rl60Q9PemeihbnURdKyG9Wvd+ozhHr0jeCUToCorvVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf8HGs0y; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf8HGs0y"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b3d3f6360cso49720461cf.0
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583190; x=1759187990; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5DMISbR66sU4eakY+Mp7FN3sykHlkCNyCvZ3g2bpqQ=;
        b=Zf8HGs0yryQ6H8JqVDowOlf82DOdnlCe97F1fXoW0S9UcoKDR7LYU0MiQo+YrJcPsv
         tvMblY7SAFKJgKkA9voBS28EnF1zNK+lPa4xbmCzpIXIC0hzWYddMCGKqhtoIGo546Ja
         c03BZNxThjaoMicuEsG1SUFUTxNfi3oxHmHpi9T/34se5PC9MuQiKs5gN1oAcRJAMPko
         5x3Z1Nebd+GUxX1MYN/HRNVYqk+ISPmsvlwfpHYJKGpE5DaKiLF8mSLJPMyND4xX9zYA
         8gjyQpd+nVxPtostWhYIxRIN1/Ob1GO0Bxx415lmHbfLYtyv3Qb4BzfCFb8wbUF2mIbE
         9RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583190; x=1759187990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5DMISbR66sU4eakY+Mp7FN3sykHlkCNyCvZ3g2bpqQ=;
        b=egxV08tP1shNAEq0KGefNtNG6y556+u8RIzujJHX/ySF6LzAWI0oRJaaeFi6YDJzgH
         MSncxqBvFIFbRHwwuuK7omH+f+axMZum/ust0tPHJ65nmw1mhz4P52pop0RKHsRHldoc
         8zLlwGVqCJcmdvLC7OTC+KytC2IneH52K7QxLhzmD9dANqaHP1Hcvm2AWI1yZJEuvcfR
         I5ybw6ANbk7P1BN1fH7O2+SiqZpPRk0NQWVaVojfq6GozifMBl+krGbp51+8XlZJK4D4
         c9JptWFJzlZ/Yw7gQJ6TI9/iTTM4Fioj6wMbqaktBXqMXoDL6fX/y9+47t63yuHEKIPe
         dmzA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjqLfTqJg0XZwvXSZzwAwcu4w1cjew3hKwuCPkJLGOKCXW1LVozuU8eXyMxTg16W7WkKt@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi1NrIK9BjnvOyRZVYwsE2ypBOt4sccW1SQCzu79a5TZcRPd93
	NDoRqIgaDGkQzU1kslwqBX1KE9XnTDaYD/o0pqVNYAJmUXPog3/TyJhE6twVt4fNiGVYJBoioEz
	Lrr6cCQS4yyQuXbHLHOL014OLMEm8qAY=
X-Gm-Gg: ASbGncvy709lVXpcw38j/NAHEVBaftTQq2WXfs85iXjHmoKI2gDpDxSaZbP9sRqLfe3
	oKEglmrjCtj7//qQj1KyJqeRO5mWABENpd83MTeV8+dbhRGebgSnwy9turEXOiyWAK0JgxDUttg
	KK+jrA5DcwAb+gIPIx3vcO5lqZThCojNHsRTlou9uMR1q2hN2l4AOCp0qfZZ3j34WV+T7PswU7v
	H7YkIWAMefCuO5Ph8Shk5CaVu7HQ/M45sSD1+mh
X-Google-Smtp-Source: AGHT+IFNuzLvdXFomfA1KkmfecMlzvBTRMKqvNIwaHSdYbK7o03YrrosbHbAe4IFOO+/WLrkvS0LLAwLdqLBhZ8+gqc=
X-Received: by 2002:a05:622a:1496:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4d368f50c9fmr8453981cf.26.1758583189669; Mon, 22 Sep 2025
 16:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <20250916234425.1274735-11-joannelkoong@gmail.com>
In-Reply-To: <20250916234425.1274735-11-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Sep 2025 16:19:38 -0700
X-Gm-Features: AS18NWAQg0BFCZgWl1vhaunaCTNOq8KGV147wLJZI9ev6DW1qua4YY9D4BQheHU
Message-ID: <CAJnrk1Y7_P=LzzgeZS9tga4XhEhChrKOYPVZd+D8n69zJ7HXDA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
To: brauner@kernel.org, miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:50=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Non-block-based filesystems will be using iomap read/readahead. If they
> handle reading in ranges asynchronously and fulfill those read requests
> on an ongoing basis (instead of all together at the end), then there is
> the possibility that the read on the folio may be prematurely ended if
> earlier async requests complete before the later ones have been issued.
>
> For example if there is a large folio and a readahead request for 16
> pages in that folio, if doing readahead on those 16 pages is split into
> 4 async requests and the first request is sent off and then completed
> before we have sent off the second request, then when the first request
> calls iomap_finish_folio_read(), ifs->read_bytes_pending would be 0,
> which would end the read and unlock the folio prematurely.
>
> To mitigate this, a "bias" is added to ifs->read_bytes_pending before
> the first range is forwarded to the caller and removed after the last
> range has been forwarded.
>
> iomap writeback does this with their async requests as well to prevent
> prematurely ending writeback.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 55 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 561378f2b9bb..667a49cb5ae5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,38 @@ const struct iomap_read_ops iomap_bio_read_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
>
> +/*
> + * Add a bias to ifs->read_bytes_pending to prevent the read on the foli=
o from
> + * being ended prematurely.
> + *
> + * Otherwise, if the ranges are read asynchronously and read requests ar=
e
> + * fulfilled on an ongoing basis, there is the possibility that the read=
 on the
> + * folio may be prematurely ended if earlier async requests complete bef=
ore the
> + * later ones have been issued.
> + */
> +static void iomap_read_add_bias(struct folio *folio)
> +{
> +       iomap_start_folio_read(folio, 1);
> +}
> +
> +static void iomap_read_remove_bias(struct folio *folio, bool *cur_folio_=
owned)
> +{
> +       struct iomap_folio_state *ifs =3D folio->private;
> +       bool finished, uptodate;
> +
> +       if (ifs) {
> +               spin_lock_irq(&ifs->state_lock);
> +               ifs->read_bytes_pending -=3D 1;
> +               finished =3D !ifs->read_bytes_pending;
> +               if (finished)
> +                       uptodate =3D ifs_is_fully_uptodate(folio, ifs);
> +               spin_unlock_irq(&ifs->state_lock);
> +               if (finished)
> +                       folio_end_read(folio, uptodate);
> +               *cur_folio_owned =3D true;
> +       }
> +}
> +
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>                 struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
>  {
> @@ -429,7 +461,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         struct folio *folio =3D ctx->cur_folio;
>         size_t poff, plen;
>         loff_t delta;
> -       int ret;
> +       int ret =3D 0;
>
>         if (iomap->type =3D=3D IOMAP_INLINE) {
>                 ret =3D iomap_read_inline_data(iter, folio);
> @@ -441,6 +473,8 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         /* zero post-eof blocks as the page may be mapped */
>         ifs_alloc(iter->inode, folio, iter->flags);
>
> +       iomap_read_add_bias(folio);

Same here, it's not guaranteed that the whole folio is parsed here
because the current iomap mapping may only have part of the folio
mapped. The bias needs to be added before the first iomap_iter() call
and removed after all iomap_iter() calls are complete. I'll make this
change for v4.

> +
>         length =3D min_t(loff_t, length,
>                         folio_size(folio) - offset_in_folio(folio, pos));
>         while (length) {
> @@ -448,16 +482,18 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>                                 &plen);
>
>                 delta =3D pos - iter->pos;
> -               if (WARN_ON_ONCE(delta + plen > length))
> -                       return -EIO;
> +               if (WARN_ON_ONCE(delta + plen > length)) {
> +                       ret =3D -EIO;
> +                       break;
> +               }
>                 length -=3D delta + plen;
>
>                 ret =3D iomap_iter_advance(iter, &delta);
>                 if (ret)
> -                       return ret;
> +                       break;
>
>                 if (plen =3D=3D 0)
> -                       return 0;
> +                       break;
>
>                 if (iomap_block_needs_zeroing(iter, pos)) {
>                         folio_zero_range(folio, poff, plen);
> @@ -466,16 +502,19 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>                         *cur_folio_owned =3D true;
>                         ret =3D ctx->ops->read_folio_range(iter, ctx, ple=
n);
>                         if (ret)
> -                               return ret;
> +                               break;
>                 }
>
>                 delta =3D plen;
>                 ret =3D iomap_iter_advance(iter, &delta);
>                 if (ret)
> -                       return ret;
> +                       break;
>                 pos =3D iter->pos;
>         }
> -       return 0;
> +
> +       iomap_read_remove_bias(folio, cur_folio_owned);
> +
> +       return ret;
>  }
>
>  int iomap_read_folio(const struct iomap_ops *ops,
> --
> 2.47.3
>
