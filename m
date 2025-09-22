Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AF26F46F
	for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580409; cv=none; b=pTvwnqvi7AKVTzG0YLWIzV23R90IDbGqLiX8GPfjaoGD8hAPtTNL3UXbCTZr5c6pq+WChjoi6GRtKqcYHmBmHnOzgyHPc4MUt71r6+5swrIHSVPy+7kQM7rkVDZeslJ9AG+cLwt3G3yXIFfveOTLuTF325tWE86wrJPTzLGML1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580409; c=relaxed/simple;
	bh=9gUnRWW1xSW7v428HK8QOTPfOJyiCrOBtECJftbi3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjDuNH0aH/cnQ/pQjofM/qXnOEieKjJ45Prq3lcPQ+TnpuQDgalSZnWGVEQoombv0OQdNs+E+jWyxNZw5YqL7YziiZgNORbhTmzgYH+fp+/mVVBCyRr1S6TXQGYBMOmLyv/8T3DftWLvdKEOUd+ExX8CBvhnElmFHdIhkRitdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctE/Zv3s; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctE/Zv3s"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b38d4de6d9so31133221cf.1
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580407; x=1759185207; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYsm3gMuZ6zP5BwF7VSAmryD1NVeBQnXrzftMRUOM78=;
        b=ctE/Zv3sJghMdBf2qMi8fwjLlN0akigiEZU8QRPn/i3pc6hu04L2Brk9qRgD3JhEwH
         8kcx8Ea3FVhsyobkyecOuhGLYFeL8pWKgCMkWgISi4jjRUhlkHXBCpB6LeVJYtjeEw0j
         UcnLOjhUilr0NrSGavken/ftiLc5NIjNnf5HNhEv7s2hWxI8shTfrtH1e0iJPfz2z5dd
         BD39gkb6gIFntkEwIQWdnbspHh6+cMXFs2o+cbUruI7fwVGwZL6qVKgA9f8OkdHYrcT+
         mFvVkm36CwkE8CKERt2pcisdigFmgCttdT+bgwss5DUSAC5n2MGkXhduy2/xsd36Jo3/
         h7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580407; x=1759185207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYsm3gMuZ6zP5BwF7VSAmryD1NVeBQnXrzftMRUOM78=;
        b=YVKZVSbZs6NWvO3Cd2AAmiqTF0rmJKmDuiFFt/7zPCL3RDwPwE/8gn2fw5PeigjwRe
         Z1a9mQ302il+OEUF1Sr6Bwsa0F3DReeWlI/C7+Ww+JI8VkreWgf95MZ1nJCpbWSm7muC
         /54VjLBl3L+NqjpxGKuoJo2VUKmqvBCaU36GAv5NtQ8UNo6gOWqY4AyIBCC353wMZLdh
         NRhBZGulDPFvLb6BWi3xAmgxwJOVNCeo1KrfQL4YIuur74XoU3pS6CFVxQzFFPlExw2w
         Xm1rXppPwCfVLlK9LEHCWRmZVh3Yjp8je/ddn0VoSKdi1Oa65y2XvLSWbQ8+U0aFKEZp
         zyyg==
X-Forwarded-Encrypted: i=1; AJvYcCWZSk1pox4lYV8xnO+d98Pr51A3FemIY0J1FIVJt09ZmK9V4Nhe/bszn8jqkjuKbiUkcEiu@lists.linux.dev
X-Gm-Message-State: AOJu0Yyfyh1qUUwJPQtJK/PoHjKJGcgrl2YnelOX2tAFJMf+pP037WHW
	smWYdyBsiBjd4D6KkZG2Vb0D2Y3L6XnLQ5J7gXpZlptICrdKIfIK91//15/RZWeDBJab+l3S9ei
	dq5tqlOGz5PrjYKumME3jg08a7SNmqXY=
X-Gm-Gg: ASbGnctio4VHSdeScfzOCeq2RQZYYzWB9umQMkdV85T9I8k5lKm99ScrgszDS6GrIGH
	dLBtWU/OsNlSqKNrtQFo6onSdG9FgXDocUu71Ua4GbxVQnmt4VY1Ziu29sLyrnFhPk/UsPUjIzP
	+TT11vTbZ5dUZCIm9faPUUxlan2AJjp+FC5IppUaqu1h4L6Ox6pMlgBsob0sQp/g4+YU0ed8suk
	bun6d0rZ6UL1XtcQkM63P/Q05z17dHpsI4lBA8o+igbBSQmCEA=
X-Google-Smtp-Source: AGHT+IF59spwoCjoNevIOS6EB4EogkJR/RYbcHdd3SU92QEm1R4zLwhxuNE22b2ZQB4jX2aAaCOjGDoVHvUFM8Uxyuo=
X-Received: by 2002:a05:622a:5490:b0:4b5:e856:2b6 with SMTP id
 d75a77b69052e-4d368a7f582mr6104971cf.27.1758580406619; Mon, 22 Sep 2025
 15:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com> <20250916234425.1274735-5-joannelkoong@gmail.com>
In-Reply-To: <20250916234425.1274735-5-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Sep 2025 15:33:15 -0700
X-Gm-Features: AS18NWANWqkKm48EgUYQpSCL1ismSoNPpJ2JmzDLzkmpUdQ92ZSUKuvOZrXN2QY
Message-ID: <CAJnrk1btMBosbCsvfG+jCJCoqQ8zrkjSrqhqp8XSSLU=Es64FQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_iter()
To: brauner@kernel.org, miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:50=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Iterate over all non-uptodate ranges in a single call to
> iomap_readpage_iter() instead of leaving the partial folio iteration to
> the caller.
>
> This will be useful for supporting caller-provided async folio read
> callbacks (added in later commit) because that will require tracking
> when the first and last async read request for a folio is sent, in order
> to prevent premature read completion of the folio.
>
> This additionally makes the iomap_readahead_iter() logic a bit simpler.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 69 ++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 37 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a1709e0757b..0c4ba2a63490 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -420,6 +420,7 @@ static int iomap_readpage_iter(struct iomap_iter *ite=
r,
>         loff_t length =3D iomap_length(iter);
>         struct folio *folio =3D ctx->cur_folio;
>         size_t poff, plen;
> +       loff_t count;
>         int ret;
>
>         if (iomap->type =3D=3D IOMAP_INLINE) {
> @@ -431,39 +432,33 @@ static int iomap_readpage_iter(struct iomap_iter *i=
ter,
>
>         /* zero post-eof blocks as the page may be mapped */
>         ifs_alloc(iter->inode, folio, iter->flags);
> -       iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, =
&plen);
> -       if (plen =3D=3D 0)
> -               goto done;
>
> -       if (iomap_block_needs_zeroing(iter, pos)) {
> -               folio_zero_range(folio, poff, plen);
> -               iomap_set_range_uptodate(folio, poff, plen);
> -       } else {
> -               iomap_bio_read_folio_range(iter, ctx, pos, plen);
> -       }
> +       length =3D min_t(loff_t, length,
> +                       folio_size(folio) - offset_in_folio(folio, pos));
> +       while (length) {
> +               iomap_adjust_read_range(iter->inode, folio, &pos, length,=
 &poff,
> +                               &plen);
>
> -done:
> -       /*
> -        * Move the caller beyond our range so that it keeps making progr=
ess.
> -        * For that, we have to include any leading non-uptodate ranges, =
but
> -        * we can skip trailing ones as they will be handled in the next
> -        * iteration.
> -        */
> -       length =3D pos - iter->pos + plen;
> -       return iomap_iter_advance(iter, &length);
> -}
> +               count =3D pos - iter->pos + plen;
> +               if (WARN_ON_ONCE(count > length))
> +                       return -EIO;
>
> -static int iomap_read_folio_iter(struct iomap_iter *iter,
> -               struct iomap_readpage_ctx *ctx)
> -{
> -       int ret;
> +               if (plen =3D=3D 0)
> +                       return iomap_iter_advance(iter, &count);
>
> -       while (iomap_length(iter)) {
> -               ret =3D iomap_readpage_iter(iter, ctx);
> +               if (iomap_block_needs_zeroing(iter, pos)) {
> +                       folio_zero_range(folio, poff, plen);
> +                       iomap_set_range_uptodate(folio, poff, plen);
> +               } else {
> +                       iomap_bio_read_folio_range(iter, ctx, pos, plen);
> +               }
> +
> +               length -=3D count;
> +               ret =3D iomap_iter_advance(iter, &count);
>                 if (ret)
>                         return ret;
> +               pos =3D iter->pos;
>         }
> -
>         return 0;
>  }
>
> @@ -482,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struc=
t iomap_ops *ops)
>         trace_iomap_readpage(iter.inode, 1);
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
> -               iter.status =3D iomap_read_folio_iter(&iter, &ctx);
> +               iter.status =3D iomap_readpage_iter(&iter, &ctx);
>
>         iomap_bio_submit_read(&ctx);
>
> @@ -504,16 +499,16 @@ static int iomap_readahead_iter(struct iomap_iter *=
iter,
>         int ret;
>
>         while (iomap_length(iter)) {
> -               if (ctx->cur_folio &&
> -                   offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) =
{
> -                       if (!ctx->cur_folio_in_bio)
> -                               folio_unlock(ctx->cur_folio);
> -                       ctx->cur_folio =3D NULL;
> -               }
> -               if (!ctx->cur_folio) {
> -                       ctx->cur_folio =3D readahead_folio(ctx->rac);
> -                       ctx->cur_folio_in_bio =3D false;
> -               }
> +               if (ctx->cur_folio && !ctx->cur_folio_in_bio)
> +                       folio_unlock(ctx->cur_folio);
> +               ctx->cur_folio =3D readahead_folio(ctx->rac);

Unfortunately, this logic simplification here doesn't work. It still
needs to check "offset_in_folio() =3D=3D 0" because the iomap mapping may
only map in part of the folio, in which case the next round of
iomap_iter() should still operate on the same folio. I'll make this
change in v4.

> +               /*
> +                * We should never in practice hit this case since the it=
er
> +                * length matches the readahead length.
> +                */
> +               if (WARN_ON_ONCE(!ctx->cur_folio))
> +                       return -EINVAL;
> +               ctx->cur_folio_in_bio =3D false;
>                 ret =3D iomap_readpage_iter(iter, ctx);
>                 if (ret)
>                         return ret;
> --
> 2.47.3
>
