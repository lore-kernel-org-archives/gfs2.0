Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805E25FA2C
	for <gfs2@lists.linux.dev>; Fri, 19 Sep 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305708; cv=none; b=ePCzXjdqZCVC4RnLhhtRfO1dTcRJb8hp+O+yWYwBYf5viYAJnVtJ4LMYuICnEhve0NvK6+FcbxpSItYz9JkuQVs01So7EtwI9G9kF0SCZ0Jd5Lo7KtPwdSkPEEbkJQ5Oh3bAoOf5EpwaCTh7wryoSv62zrfLhWk6TWEFDdFwx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305708; c=relaxed/simple;
	bh=SU7ouAUS4fSEsX0AQf3RRT7FNWxnC3izv7DdmJIVxho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABjM60VLRq53cINPbMHvHrEZOzKh6ConUrUROZItFPMCXrZRSYqI4et2izY0t1cksJ7A1YeRa+0AABwXiYaxfJtaF7C3ZE6iFEiqcfdPoLTjieyYCTegvFkH42A4WSs7nPhFwbd/OFQhgR78E/OW3KRIkTz3vQWlJLaSphjJeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mresiqco; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mresiqco"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b7997a43ceso27586981cf.1
        for <gfs2@lists.linux.dev>; Fri, 19 Sep 2025 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305705; x=1758910505; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=MresiqcoFDzyYeBLiH2ZDiqt4OBAQGbAIXap7sZEp2ZaQEe44TtQQNU9GyDBHSYwYX
         aSkTGdOYqSMI08Um6xfDhZo2ubWyTG1hMzlRnBUmpGB8BN4u57BM+2xEin8yBXYYY08D
         NQHwGgbCdmWl8l+s7incUgESmnPylWAzZDipv0qzg/WzR6W47gTEBuNa83jxsb/Pax5e
         tn6MBWvnLtVCoQ1/9JcEAPQLpCl5AHuGxhhWUl8Vx+envUI43Kq52RL9tBHPl5vDAzc2
         bRNWa1bJVNMsVdRXQo9c+VLEJidW1WcvrxBIhDe00eUc7ymd76BHeW56hD0EmyqY1lIc
         YVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305705; x=1758910505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rc3o0DtMuxjBD1JkaH5/eYeaLZxutE0LWJ2BWNFmsE=;
        b=QvN0fDR+fKZB/mbjM0+JFibpGkN6idDD8jI01hCQWwCF/U4P7o4AGDggVTaAfOpO2u
         sVaP0TvhVueyDc/t2ZRxr7DnOIJCick9xHxjnNDi3rIHBgND0Hcpjf85VN9cFG1jGMIn
         QEhUJGWvCeSjYnrxJPq7iwKBAuNFXm9e3EMKBZ/NSQ5qEgATZE7D5aDdjuLH8lHi9EAm
         Oxcz+CH6ac2CBUBLGTwDjVA7TLu2XF9wYxsuNoMGQw8YrkuddHc0Z7tN5mgjdG4d19S4
         p425pY280qawaS3tzRApsHMAkAUVhSDI6kz0uYKdvBPHNU5+JejMpXMlnnvY10dzjR38
         PvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPvh9T4PWiCGkXAkpNxns8dwf4TRY3ab6M+66C0sf5V/+B8B+C9i5/vdE+9JYr6RYQuMtS@lists.linux.dev
X-Gm-Message-State: AOJu0Yw95RYSfZ7dBPGOeqCi3hPKgMZPLF4DKPOHep/bV8sbgVOoYE0y
	JIaogDr+sNVKJ+EGHNg4FtmrJ8R/mjt75Zfmi1TuEjwkaU2sbYe0XQuWyyJocPm3OsSLj70C1Kt
	KtSCXawigxgZK3SL0759FuVr/7GMvjTQ=
X-Gm-Gg: ASbGncsBNXSVQBTelPRx3FErO75xaLp3RxZnV94SUJUjkuHJHCYlf872wC68gdInw9l
	WI6tJAj6nxB4C9iR6PqNswByceQfp/gZdndjZDZOeo81cFr2pO2Gpw/L5xM+zzBYD81De4+b9F9
	fxljgNOyMwVQpcrBUJosuDwUicW6r04mnRjjvy6jeDQsT7jzsgDy+2cfYRRdwLwMkxssRAVsL1j
	69YUL7iU3SbeE2nntGs2pEr/kHpFLQmuTGrI89d
X-Google-Smtp-Source: AGHT+IFqVuAbTud8sr5sQDzUbR4SVBdcuk43pldjIoGePaUBz5b0yq9EV02amkv9JjhitX99n9+uqsw7zVrBa9moCeo=
X-Received: by 2002:a05:622a:13c6:b0:4b5:d9a1:fe38 with SMTP id
 d75a77b69052e-4c0720ab81emr54958861cf.38.1758305705459; Fri, 19 Sep 2025
 11:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-8-joannelkoong@gmail.com> <20250918214953.GW1587915@frogsfrogsfrogs>
In-Reply-To: <20250918214953.GW1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 11:14:53 -0700
X-Gm-Features: AS18NWBx_3JdX9ikwterXg-lOW9lZ51jYQabtjy-zedgbMsJztKl5lVrFUJr6dY
Message-ID: <CAJnrk1Z1Cqi_PGhjRyiAOV-QrYLJyq=jh0_c+E9q0xYPjBmz_Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Sep 16, 2025 at 04:44:17PM -0700, Joanne Koong wrote:
> > The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
> > track folio ownership to know who is responsible for unlocking it.
> > Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
> > purpose and so that this can be generically used later on by filesystem=
s
> > that are not block-based.
>
> Hrmm, well if this is becoming a private variable, then I'd shorten it
> to "folio_owned" since it's not really in the ctx/cur anymore, but I
> might be bikeshedding now. :)

Oo I'll do this for ->read_folio (and for the arg name in
iomap_read_folio_iter()) since there's only 1 folio which makes it
obvious which folio it is, but for ->readahead I'll keep it as
"cur_folio_owned" to make it more obvious that the folio owned state
refers to the folio in ctx->cur_folio.

>
> > Since "struct iomap_read_folio_ctx" will be made a public interface
> > later on when read/readahead takes in caller-provided callbacks, track
> > the folio ownership state internally instead of exposing it in "struct
> > iomap_read_folio_ctx" to make the interface simpler for end users.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 6c5a631848b7..587bbdbd24bc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
> >
> >  struct iomap_read_folio_ctx {
> >       struct folio            *cur_folio;
> > -     bool                    cur_folio_in_bio;
> >       void                    *read_ctx;
> >       struct readahead_control *rac;
> >  };
> > @@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >       sector_t sector;
> >       struct bio *bio =3D ctx->read_ctx;
> >
> > -     ctx->cur_folio_in_bio =3D true;
> >       if (ifs) {
> >               spin_lock_irq(&ifs->state_lock);
> >               ifs->read_bytes_pending +=3D plen;
> > @@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct=
 iomap_iter *iter,
> >  }
> >
> >  static int iomap_read_folio_iter(struct iomap_iter *iter,
> > -             struct iomap_read_folio_ctx *ctx)
> > +             struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
> >  {
> >       const struct iomap *iomap =3D &iter->iomap;
> >       loff_t pos =3D iter->pos;
> > @@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >                       folio_zero_range(folio, poff, plen);
> >                       iomap_set_range_uptodate(folio, poff, plen);
> >               } else {
> > +                     *cur_folio_owned =3D true;
> >                       iomap_bio_read_folio_range(iter, ctx, pos, plen);
> >               }
> >
> > @@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const s=
truct iomap_ops *ops)
> >       struct iomap_read_folio_ctx ctx =3D {
> >               .cur_folio      =3D folio,
> >       };
> > +     /*
> > +      * If an external IO helper takes ownership of the folio, it is
> > +      * responsible for unlocking it when the read completes.
>
> Not sure what "external" means here -- I think for your project it means
> a custom folio read method supplied by a filesystem, but for the exist
> code (xfs submitting unaltered bios), that part is still mostly internal
> to iomap.
>
> If we were *only* refactoring code I would suggest s/external/async/
> because that's what the bio code does, but a filesystem supplying its
> own folio read function could very well fill the folio synchronously and
> it'd still have to unlock the folio.
>
> Maybe just get rid of the word external?  The rest of the code changes
> look fine to me.

Sounds good, I'll get rid of "external".

Thanks for reviewing this patchset!
>
> --D
>
