Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793E350D52
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432046; cv=none; b=E/IUuFsZQEwMd8yyfc6fz3uzkzNYBxcSyzLylgZkdpOLIcj4vDLie7jPqy+QbkoQ9KVsYQNubLYnitCfW/Aa7vVy02dnnIetApnAiOw0zWIQKkzu9Q1fgiILeXuP50tjydsF9l2v1oGBj/rrmSPmTNHQOu5xuG5huvqH0+xFw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432046; c=relaxed/simple;
	bh=6JlSmRBzOwfJDw81Wdqg0lZlZvfb9SVf6c+eUyxm70k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL6gjbJSZDDDxqCvGM+9VjEq3EEZAgR1mdDZqo9IDqlDxCe/C6oU0oCAva2c+hozmP1Cd8kKHvuCpWZp7yFKlQdgiHmjXJQjKiFYPUwoL/Z39uuXHHIUVnk9AgJFBU41joWwGsle7yWpS1Sw/GPP95Zc3gK/8Fl08hCOzwsBLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMtMbhvr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMtMbhvr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80e3612e1a7so730986585a.0
        for <gfs2@lists.linux.dev>; Tue, 09 Sep 2025 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757432044; x=1758036844; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm019m6Jpg9WlE0fDkKmwk8SZTc8G6zXBvzps0igUOY=;
        b=mMtMbhvrDQxTDBIGFXfw98caNaZ83K8X5E1HBT3X1hiYRnoCPBWP3XqGRRWmYsSpOr
         MkHmhJB+VtnOt/fpNsJBhbBdCuxcR7/WVjFC/ynwIhA8/JExADQn65kTdHU/Qv1IFG2n
         867m+Ygw1m27UjyrbDPYqMT3rrDhWHC4eWBazjZxo9HZk2qxxdoedlU5coUGJVLNB0mq
         o6uAy/LDtRrijVd51eQ20Soo/bxUuUMeLOxhBFO1aafhk1WEZ/BT8b2QRt0QTOpbdkd6
         I6ciF8z/HKUu5l6LVb5LGpsV9xk5zyNMz4XrbT2rLOsAsyyY6kMiStc1xPQWi+rH0P/y
         XsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432044; x=1758036844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm019m6Jpg9WlE0fDkKmwk8SZTc8G6zXBvzps0igUOY=;
        b=sQbDRF+7KkZ/U1eefZwKDQeN1tow6RTfkt893bpEHRtjwzqJuhv0UXyUdYF3ojbJko
         ayRFXFZ7NWTMBVzXp9HFg6x5frXEmBWHR1KhqSMvr/dFD+zrS/lO4O2c7O9Cl5sH3WVW
         PGrARxljGby4wXJXQ+vx3keCAN1MthFBvBuXvurS14nzoXfN262ZJXE+MhWi7vWoueo1
         VfD5ekTDTsqECHF5iLfpkTnGZEI/ICucWUBFLWusEY1XvJYwW6+2faVODhFvc7clDHQf
         TajKTG+Y3a/UfExrKkG6TiJzJO1JAJw7/WAh01kBYMM4Caapf3X/e0wPprpAuKtSJPSg
         x3sw==
X-Forwarded-Encrypted: i=1; AJvYcCXnpuZmtVmmxUQpU4fqophrCH9UyP+5Vg8Q7sZ8yoXFAMomOBB1vgzJP+B+WjRNAxwOQQqA@lists.linux.dev
X-Gm-Message-State: AOJu0YytDEb/lEoh8uP/IarFOwxdxIr62A5pkRjnoTRHrJt3nwgXnJm7
	GjkqteTGQTt0foZ2KhyXV5gi9VB8IKujk69VZvefOcvWDXgL4GCfCgasoSLkUB/3NvPpLkVXsHu
	7zeuejQMG+ShDaS3N32HU0LEb4wmCVxzFbZ31
X-Gm-Gg: ASbGncuf+gxOiKeRQTZFbUQciugtGmjHpP2DEliuUlgiu1aZGb5/EghOpGwa9UG8Yds
	2NBVeFAzAbbatSLqyMv7HKi5evpy0nQuCWDSN0eyKTRvzDfiPW2hfXYzEzu0PyZMmiBAUxe8Zmb
	y3Wm8fISDcubrzK1kA7hdtsINAmR0gww+UFEML4GyRDM13pfrdHV8HvlDmPjnklG+ca4M4W6eZD
	khuL2pKztWl6Y11m0/3C5w=
X-Google-Smtp-Source: AGHT+IHsvKQIqY1eKcTSpIDfewB71Vz1SzsjVHsBfXSv4SayZ8R1VsL4otO2UwFpXNAm9zonHXLetqA++OARoiEstzA=
X-Received: by 2002:a05:620a:a207:b0:814:ac72:cb53 with SMTP id
 af79cd13be357-814ac72ce37mr1348060785a.39.1757432042924; Tue, 09 Sep 2025
 08:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
In-Reply-To: <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Sep 2025 11:33:49 -0400
X-Gm-Features: Ac12FXxmaTYFDfytENNUUKz7GREv8kkuFk-74PyqDa4R1bwoLlwwHTGCX5N6tT0
Message-ID: <CAJnrk1aCCqoOAgcPUpr+Z09DhJ5BAYoSho5dveGQKB9zincYSQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	djwong@kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:14=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/9/9 02:51, Joanne Koong wrote:
> > There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> > readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> > allows non-block-based filesystems to use iomap for reads/readahead.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >   fs/iomap/buffered-io.c | 151 +++++++++++++++++++++-------------------=
-
> >   1 file changed, 76 insertions(+), 75 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index f673e03f4ffb..c424e8c157dd 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, =
size_t off, size_t len,
> >   }
> > +
> > +/**
> > + * Read in a folio range asynchronously through bios.
> > + *
> > + * This should only be used for read/readahead, not for buffered write=
s.
> > + * Buffered writes must read in the folio synchronously.
> > + */
> > +static int iomap_read_folio_range_bio_async(const struct iomap_iter *i=
ter,
> > +             struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen=
)
> > +{
> > +     struct folio *folio =3D ctx->cur_folio;
> > +     const struct iomap *iomap =3D &iter->iomap;
> > +     size_t poff =3D offset_in_folio(folio, pos);
> > +     loff_t length =3D iomap_length(iter);
> > +     sector_t sector;
> > +     struct bio *bio =3D ctx->private;
> > +
> > +     iomap_start_folio_read(folio, plen);
> > +
> > +     sector =3D iomap_sector(iomap, pos);
> > +     if (!bio || bio_end_sector(bio) !=3D sector ||
> > +         !bio_add_folio(bio, folio, plen, poff)) {
> > +             gfp_t gfp =3D mapping_gfp_constraint(folio->mapping, GFP_=
KERNEL);
> > +             gfp_t orig_gfp =3D gfp;
> > +             unsigned int nr_vecs =3D DIV_ROUND_UP(length, PAGE_SIZE);
> > +
> > +             if (bio)
> > +                     submit_bio(bio);
> > +
> > +             if (ctx->rac) /* same as readahead_gfp_mask */
> > +                     gfp |=3D __GFP_NORETRY | __GFP_NOWARN;
> > +             bio =3D bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > +                                  REQ_OP_READ, gfp);
> > +             /*
> > +              * If the bio_alloc fails, try it again for a single page=
 to
> > +              * avoid having to deal with partial page reads.  This em=
ulates
> > +              * what do_mpage_read_folio does.
> > +              */
> > +             if (!bio)
> > +                     bio =3D bio_alloc(iomap->bdev, 1, REQ_OP_READ, or=
ig_gfp);
> > +             if (ctx->rac)
> > +                     bio->bi_opf |=3D REQ_RAHEAD;
> > +             bio->bi_iter.bi_sector =3D sector;
> > +             bio->bi_end_io =3D iomap_read_end_io;
> > +             bio_add_folio_nofail(bio, folio, plen, poff);
> > +             ctx->private =3D bio;
>
> Yes, I understand some way is needed to isolate bio from non-bio
> based filesystems, and I also agree `bio` shouldn't be stashed
> into `iter->private` since it's just an abuse usage as mentioned
> in:
> https://lore.kernel.org/r/20250903203031.GM1587915@frogsfrogsfrogs
> https://lore.kernel.org/r/aLkskcgl3Z91oIVB@infradead.org
>
> However, the naming of `(struct iomap_read_folio_ctx)->private`
> really makes me feel confused because the `private` name in
> `read_folio_ctx` is much like a filesystem read context instead
> of just be used as `bio` internally in iomap for block-based
> filesystems.
>
> also the existing of `iter->private` makes the naming of
> `ctx->private` more confusing at least in my view.

Do you think "ctx->data" would be better? Or is there something else
you had in mind?

Thanks,
Joanne
>
> Thanks,
> Gao Xiang
