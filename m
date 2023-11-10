Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4438F9F
	for <gfs2@lists.linux.dev>; Fri, 10 Nov 2023 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIWC7mCa"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso3270733e87.2
        for <gfs2@lists.linux.dev>; Fri, 10 Nov 2023 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638645; x=1700243445; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=nIWC7mCa1SMDAeycysBexdXZmGWeiNRqa1p2ULrnuAq+jDTI2A5KCPVKNvOn+t+khG
         wIsDOIUIU5Bvd5edv0FZOXRejdLlluQfzhUK6jHXKxG37OY7R22Oufa+MIYR5XKdp0NC
         D0RHuq3TFvUkQB82EEbvejFl0q2YHT05ClcJcocxEHerfrvuPI1aTNdn7oaYilYsks5k
         UE7wfhPmlu/XNf9dDU7wPja85PbPleeByoYpz9LWEMs9QVHdqx0N7HvBgLrADhrfCqo3
         L2cHvh/q5ulUJt4ZP8GspKWSvfVHBeEenGe6Rbro87abuBK+HVPgrzgMW7M5t6aJqyNp
         CSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638645; x=1700243445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=tfkqb8Ba2vogd3Rzd6npgUpqmkJenXEu+1wbC4gOfOCRBt6maYRSW8FJjYh7CYsdL3
         UYbeontXfu8wIaMegqMvxCDYeqedXOafxjyasLXMq+IWsRnLrKjxbKEvEKI1A60vdgS6
         /RJowpCxJJMlft2wFp0VQ2p1a4i+sxAmg4Pn8R9G2KcFu2ZAHLSqCEBnBsciU14Yrugy
         Z9jH9552HEoeKbhANhSVbYBgNJob0yUZG8b4trWUug0JxXnRVssYRjlSfkl7Ts+w1myQ
         3YdmFoY7GdHnWGbb1yQ8OpHmkFgV8ExgEfXh2fjJOMWFqVXZPlT2tyv6Erqi7LYgtmg7
         Z4ww==
X-Gm-Message-State: AOJu0YzrwwI3KLIA5KK6rpw5xlV4BXi1YHXFWVKzPx6CsOiD0aTgq6yc
	GPiKl5aQ/buN8oHWmNNWwl4/eJDN3okIRxRS7QM=
X-Google-Smtp-Source: AGHT+IFh8ABulKL4lvR+Y27vT3gC7Y6r+A/cUSNaE107DZZDGksZhMpoVeGCNcPb4JO3asUj1EER8G3o9QliCpYHcLY=
X-Received: by 2002:ac2:55a3:0:b0:507:a12c:558c with SMTP id
 y3-20020ac255a3000000b00507a12c558cmr4208700lfg.46.1699638645020; Fri, 10 Nov
 2023 09:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com> <ZU5jx2QeujE+868t@casper.infradead.org>
In-Reply-To: <ZU5jx2QeujE+868t@casper.infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 10 Nov 2023 18:50:33 +0100
Message-ID: <CAHpGcMK5ODLzONNJiVAzLwxF9BKnFo=h+dP=TEtUXxDc+u+gkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 10. Nov. 2023 um 18:09 Uhr schrieb Matthew Wilcox <willy@infradead.=
org>:
> On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
> > On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > +static inline void folio_fill_tail(struct folio *folio, size_t offse=
t,
> > > +               const char *from, size_t len)
> > > +{
> > > +       char *to =3D kmap_local_folio(folio, offset);
> > > +
> > > +       VM_BUG_ON(offset + len > folio_size(folio));
> > > +
> > > +       if (folio_test_highmem(folio)) {
> > > +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> > > +
> > > +               while (len > max) {
> > > +                       memcpy(to, from, max);
> > > +                       kunmap_local(to);
> > > +                       len -=3D max;
> > > +                       from +=3D max;
> > > +                       offset +=3D max;
> > > +                       max =3D PAGE_SIZE;
> > > +                       to =3D kmap_local_folio(folio, offset);
> > > +               }
> > > +       }
> > > +
> > > +       memcpy(to, from, len);
> > > +       to =3D folio_zero_tail(folio, offset, to);
> >
> > This needs to be:
> >
> > to =3D folio_zero_tail(folio, offset  + len, to + len);
>
> Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
> which doesn't exercise this code, not gfs2 or erofs.  Thanks for
> fixing this up.
>
> I was wondering about adding the assertion:
>
>         VM_BUG_ON((kaddr - offset) % PAGE_SIZE);
>
> to catch the possible mistake of calling kmap_local_folio(folio, 0)
> instead of kmap_local_folio(folio, offset).  But maybe that's
> sufficiently unlikely a mistake to bother adding a runtime check for.

folio_zero_tail() is a bit of an obscure function, so I'm not sure if
there will be additional callers. The parameters are described as:

 * @offset: The byte offset in the folio to start zeroing at.
 * @kaddr: The address the folio is currently mapped to.

What about changing the @kaddr description to 'the (mapped) address
within the folio to start zeroing at' or similar?

Andreas
