Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66C1F8BD6
	for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698591; cv=none; b=VRZNRU0/DpRk3X8La4OKt+FLbgGbKDKpiXf2d4rpKCCL+yM8TjMB8jtZUSK8Qu32bJSXtTz8QwsTemw6jCkEOmaovRrEUud8q6+1gerfPgUjx0/eo5g9RS2nys8Os5F/jxNcShO8IAG41Ex6XoRE1ODTGDHBnJLp+dmuFTEb2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698591; c=relaxed/simple;
	bh=yK0tz6ECng/GkzGWo1PQRHtl9PMBAN4W2lEev0pJQG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9nCHtpNHWaqP64+Nfh+dJvBWkWWPrzWgFdBqXrz5cPKjwKqB3hVN1KyKhpG88THT0XSxQ1okA6KleFhvOvvr6s9jVLhPQwiGTNVKiFG3Acv//ztEJdgsbTzo747ZOh5MkCQYALqHyriTC8CMkZ6O3vi/8zTLq9aU/Y9xpHlfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0DjAzVw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0DjAzVw"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b61161c32eso26604051cf.3
        for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757698589; x=1758303389; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaoWmn122bkATHsMm2TW6koAeUnmN4wL024VSWi/QfE=;
        b=D0DjAzVwIBJ/aWiZuuIW14nrNj7drs5kGZbDpzX+bNhreZpHw7SBoEjtWKQbS/yptE
         bE0fboLR0TSoT5YmoyoGz32LgQO4wfmrjRSjdSJPRBjLpfCGgGYhzqeaiRzdKjs3BtdP
         9bvwfgNNzMUzA4SAYfjhf4ZswzpmmBSixXf/hZlxSlBaCyQn0hY9rHjK9fFWAfyRltql
         hIVz/J3jTvIRtEy0/3+ZmkGQ3i7TuPo827kzTM63yQsE0tfEyjyIkocC1XgvHSZcsQlR
         oyaXDAS5KrGstmZNYg5W67IxHkaOiRo64yRYXCEMtR/w6AVqNroFOUMCrDY2IgxirnxT
         xgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698589; x=1758303389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaoWmn122bkATHsMm2TW6koAeUnmN4wL024VSWi/QfE=;
        b=GCD3NS4XuFPSBr7wgqKOTlX/jMpEbECwRi6SOewEtCrIChKQSVDOp+9efvlItn/FBW
         qlUATKZvF9mBlb0qX6mUk1XwgdH3rDP0FMD94zuaDxRQdlnA/IhqkyWspe4j57q91Rop
         VZgTeHT4aSOkmOsoJJn8H/iPpcP2KjIaiAoj2LcTjoQHiTXG7zXlbD4ajj4hlq23OC6z
         C9ummUX8/FZAN/PvW9RS2QEbN2AM4NOED4LYzACQ2T5AUcxBIZ3596evZ9seMjSOI/BO
         ry7WLAdIGnWDbzBfYFYTT8P+HpNVjM3Q+98V/j/+b9BV9izefLb3zSL22oGUc5laSlg2
         dhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUazIrhAYsgO0lmR0JqmttCLkeYFimX/Z1avbFkDz9UATNhVMAc7/y+UUzolDY/bexso0Yv@lists.linux.dev
X-Gm-Message-State: AOJu0YwfJsqQJewXDCz9o3DYygJ/y59ziXDffPXbH+18QRGJyur8j6Gb
	d1i4xWuh0d9JRP1W6C1So/7QmqoqOoAf+ZY0ufGl1ebFcrkahEEUUX/ADh6f5fzcFrGXfN86oZl
	Pb4sbvmLcFzeAHScagMzDILQeg6cA/Yo=
X-Gm-Gg: ASbGnctlpVfX/H8UJnrzt/pTw3sFBrjcch/rTb6KBBbU+Hr9erHAhwQHuYNSkBW7Zgf
	/TAOqthzdt2OsNT/Dj4tXr3QamFR5BHyMuo93qJTX8QlxWMfppV3msBUvCJX2jkVnJj59NhqE9I
	e+UVsTW03ZYIYEJh7U/MvF8pG2fIWD+tCxudZX9A7nEhBpjWmoEbqFYkZR+gBPQRneL2r5lkVSl
	5ybgu+fsrrD+sysT7bs95SspKyY6j7kKVXAewZSNmIn8lLsuqAZ
X-Google-Smtp-Source: AGHT+IH7GMrBmyVYd7mK7Xmpyd9r7k7cyb03zWtnoaxVf5aKJ9xehKSBV/1hqSTeEYXKWJdrlpEgvVzc7a+DG2b03cg=
X-Received: by 2002:a05:622a:581a:b0:4b5:4874:4f92 with SMTP id
 d75a77b69052e-4b77d0137b3mr62431321cf.13.1757698588919; Fri, 12 Sep 2025
 10:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com> <aMKx23I3oh5fN-F8@infradead.org>
In-Reply-To: <aMKx23I3oh5fN-F8@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 13:36:18 -0400
X-Gm-Features: Ac12FXza_WwHTwR6ZN8SwpAjhAiC4oowkVj8eON9gC8viGDNCKpw6hOW6Wr675M
Message-ID: <CAJnrk1aKiKSTB3+c8BRbt+h9L5eq_Yy2y143fPUcUM04VTjd_Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:26=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> > +  - ``read_folio_range``: Called to read in the range (read can be don=
e
> > +    synchronously or asynchronously). This must be provided by the cal=
ler.
>
> As far as I can tell, the interface is always based on an asynchronous
> operation, but doesn't preclude completing it right away.  So the above
> is a little misleading.
>
> > +     struct iomap_read_folio_ctx ctx =3D {
> > +             .ops =3D &iomap_read_bios_ops,
> > +             .cur_folio =3D folio,
> > +     };
> >
> > +     return iomap_read_folio(&blkdev_iomap_ops, &ctx);
>
> > +     struct iomap_read_folio_ctx ctx =3D {
> > +             .ops =3D &iomap_read_bios_ops,
> > +             .rac =3D rac,
> > +     };
> > +
> > +     iomap_readahead(&blkdev_iomap_ops, &ctx);
>
> Can you add iomap_bio_read_folio and iomap_bio_readahead inline helpers
> to reduce this boilerplate code duplicated in various file systems?
>
> > -static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> > +static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> >  {
> >       struct bio *bio =3D ctx->private;
> >
> >       if (bio)
> >               submit_bio(bio);
> > +
> > +     return 0;
>
> Submission interfaces that can return errors both synchronously and
> asynchronously are extremely error probe. I'd be much happier if this
> interface could not return errors.

Sounds great, I will make these changes you suggested here and in your
comments on the other patches too.

Thank you for reviewing this patchset.

>
> > +const struct iomap_read_ops iomap_read_bios_ops =3D {
> > +     .read_folio_range =3D iomap_read_folio_range_bio_async,
> > +     .read_submit =3D iomap_submit_read_bio,
> > +};
>
> Please use tabs to align struct initializers before the '=3D'.
>
