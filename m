Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87634F461
	for <gfs2@lists.linux.dev>; Wed, 14 Jan 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380388; cv=none; b=LQTkmS0AoUbkBnnyQVF0A0/cJfPEuCWh0Q3jqnQXV6kSHj2YDonTgVIgkFuYsn3X8+z7GcCfum70Ee0b97nCSzSW2erp7F9F+v7KTysbEg8/8niKGTonPJd/OGL3Lkw32hFFXFwggVV6hpNdBmIb2LwYtQEaPJo0AFMMusuEtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380388; c=relaxed/simple;
	bh=2q5+7L9lp4rYGtqiFMieQT6+gWJ6Xt1i0lSorRhk3TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXatKkw+V3QuaAOCVxW0sC3k4DnbtIUmkbZl5wO5tKx4b0FmBOL2MDnvlePdcbXUnzvZa4YlPjJVD3NVxH4zHQ0FD4YH++qRnZmGYEF/WKV6uJrJzjZcR3p7bgnOgzu0BijCQBdYKRziJ+iOwRSZ2/JpGg/hiC1eR/2xgpaRUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXZnECSV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXZnECSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768380384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mC57iukE7dahb+QiB/aSL8Lhq1hdQsTNrwGoDOzmy/8=;
	b=BXZnECSVYd/PM8yaH1hLaYJQeH5Jp1av5WS4VvmhBRSK01c9dUJkkTA3OGuIbZZgrAUGVv
	rA2O8YWl3M0GYwE6EMC9JItB2l6nWMPgtimPrr2ZUv2u7VZ/kGalHQ4kROtecE1yB3wgY/
	z1gU780jh/ZHMnTYec6ygTRIMEjyG8c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-K_llE_ZTOL2BrMJgzRlfKw-1; Wed, 14 Jan 2026 03:46:22 -0500
X-MC-Unique: K_llE_ZTOL2BrMJgzRlfKw-1
X-Mimecast-MFC-AGG-ID: K_llE_ZTOL2BrMJgzRlfKw_1768380382
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79012391ce2so123957947b3.1
        for <gfs2@lists.linux.dev>; Wed, 14 Jan 2026 00:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380382; x=1768985182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mC57iukE7dahb+QiB/aSL8Lhq1hdQsTNrwGoDOzmy/8=;
        b=pBmD4BTQILVlwUGwXGd2u/OVlqW0vTtHz4wi1VA70UrSvDfXu59veheWyHtsrF+Cck
         AbAGS1Wp+3BOqK6sW8CeJzMr+CeoWpkxZqXb759sBunBnTMUE5iOWMKaY82zfUnriVsl
         6CURO+uG6hwkyJ4Xe6sr5wpJZjIksQjXsG8sNSUudxW3e3zRu/4jAS0QCXQJftu7+daR
         fa2EPVFMZGxyt1QQ5zEtKz9917G0zUzxFvHIlkzTVZWCjwF0CfUoMyIvsXC4FOPxpjs3
         aFaCjmxNZ+ux6rCedlNcGI07MiItIMSrAHZfKsKIvie0kM0arXW5fBdDgpXGVLW/z2VQ
         QAqQ==
X-Gm-Message-State: AOJu0Yx4LwPqXgkLGZLoLLn0Trz6CH7Dphm6jUk0BWDFMwFR0ehY6bBe
	FdaeD6YghaViae+7KNmi2uoN1Ha/VT/jFJqt4odsiSl+tEulhLaIQNIDw5bscJG2eZVniG2+KGt
	WZj74/A1GYL567hUG7DzkYcE1XlVRp2FQvvTBTknFZZD6mnYLjlSZ8KecmjAT9uAaH7cbCsUsNP
	2EHjacH5Md+0L5qrBqyfopGRNB0dIe5wJph6Df8P0r
X-Gm-Gg: AY/fxX5psStmJjxRozqE6yR7BLgm7FiSKpc9IDfcqTYQ6VT+OX7SKMVP4C0JeBbMJwN
	Ig8T16iNGqerQCVlkUApr8duBTrQSUapYRMt3GWS4XlAPnuRBs0eDhQCeNqkKyO5bVIZLKJEsle
	OK/CzhEQ1Bp0/rGVXBFR9CMdz/AyS9cXp6D6rNPaHWVLwHvrB2oXuSfnCzeZL8u8yhdX+5qjLqJ
	raQJPvv6TPxc1QKYNrE+3MxBVHPi/dm5Wo5QeDp9I0evUp7sjm5wA==
X-Received: by 2002:a05:690e:1898:b0:646:ba5e:4cf4 with SMTP id 956f58d0204a3-64903b45b26mr1042855d50.51.1768380382002;
        Wed, 14 Jan 2026 00:46:22 -0800 (PST)
X-Received: by 2002:a05:690e:1898:b0:646:ba5e:4cf4 with SMTP id
 956f58d0204a3-64903b45b26mr1042844d50.51.1768380381624; Wed, 14 Jan 2026
 00:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU50_ZQM2G3y_z11J99xgRUE5yGj5DHKhpgEQd4QpmCLTg@mail.gmail.com>
 <tencent_B55495E8E88EEE66CC2C7A1E6FBC2FC16C0A@qq.com>
In-Reply-To: <tencent_B55495E8E88EEE66CC2C7A1E6FBC2FC16C0A@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 14 Jan 2026 09:46:10 +0100
X-Gm-Features: AZwV_Qh2fjB-Hjjk7fbYXLuZdra1THHgnStpWuqdoBDK1bftldd-iTG9OFnPIXc
Message-ID: <CAHc6FU6q=pvFTcWL8CLv+qXAyRw8DmYqdHgUr=qBWF16uozCmQ@mail.gmail.com>
Subject: Re: [PATCH Next] gfs2: update end and prev bio for chain bio
To: Edward Adam Davis <eadavis@qq.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v3Eal-PB0-Knn5jCK85wlgBxYhVsq6bNrhaviZdeqBs_1768380382
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 3:18=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> On Fri, 12 Dec 2025 13:47:40 +0100, Andreas Gruenbacher <agruenba@redhat.=
com> wrote:
> > On Mon, Dec 8, 2025 at 7:12 AM Edward Adam Davis <eadavis@qq.com> wrote=
:
> > > The bios are created and initialized using gfs2_log_alloc_bio() in
> > > gfs2_find_jhead(), which sets bi_end_io and bi_private. When the I/O
> > > request is too large and needs to be split into multiple bios and
> > > submitted as a chain, the bug reported by syzbot [1] is triggered.
> > >
> > > When we need to submit multiple bios in a chain, we need to pass the
> > > bi_end_io and bi_private of the previous bio to the end bio to ensure
> > > that the multiple bios are correctly assembled into a submission chai=
n.
> > >
> > > [1]
> > > kernel BUG at block/bio.c:342!
> > > Call Trace:
> > >  gfs2_chain_bio fs/gfs2/lops.c:487 [inline]
> > >  gfs2_find_jhead+0x627/0xe40 fs/gfs2/lops.c:549
> > >  gfs2_recover_func+0x5f5/0x1c90 fs/gfs2/recovery.c:459
> > >
> > > Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
> > > Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Df6539d4ce3f775aee0c=
c
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/gfs2/lops.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > > index 97ebe457c00a..2de334034c74 100644
> > > --- a/fs/gfs2/lops.c
> > > +++ b/fs/gfs2/lops.c
> > > @@ -484,6 +484,10 @@ static struct bio *gfs2_chain_bio(struct bio *pr=
ev, unsigned int nr_iovecs)
> > >         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP=
_NOIO);
> > >         bio_clone_blkg_association(new, prev);
> > >         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> > > +       new->bi_end_io =3D prev->bi_end_io;
> > > +       new->bi_private =3D prev->bi_private;
> > > +       prev->bi_end_io =3D NULL;
> > > +       prev->bi_private =3D NULL;
> > >         bio_chain(prev, new);
> > >         submit_bio(prev);
> > >         return new;
> > > --
> > > 2.43.0
> > >
> >
> > thanks for this patch, it looks correct. However, the underlying
> > problem is that bi_end_io and bi_private are set too early, and if we
> > change the code to set those fields before submitting the bio, we
> > won't need this hack in gfs2_chain_bio().
> >
> > I have pushed patches doing that onto for-next:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/l=
og/?h=3Dfor-next
> >
> > Does this work for you?
>
> I think it's work for me.

It turns out that commit 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
was bad and needed to be reverted. This means that patch "gfs2: Set
bio->{bi_private,bi_end_ino} late" has been dropped from for-next as
well.

Thanks,
Andreas

