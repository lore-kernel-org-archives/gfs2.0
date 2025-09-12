Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7027466D
	for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698248; cv=none; b=cBgEbpiyjH26n7kv8jOn/Eo6jueldYUyosSUB3vYBb+mEOy7exwr/+l7MnhjySpK3defWoh21wdFDsgYvzDDkZoskafbvRrQ2hTjh04xBG9uBKwDAPXiBAGv8JKiQ5cOjAkHXl0IdLHhdBDDWK/YJvQWaOuXNynL0vWtglXSs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698248; c=relaxed/simple;
	bh=o20p7GmDi8+ZFGPUj4WAT9L80iQUq9XRuj2nEHhmdqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAuHZ7x7Er7BiMnf//Tnl2evyhJwoFVZRtEKwNxm7wV8Ab0xlSTriCry7Md3gmIBP2P06m3ITRum/m1y7MR9//jP5JgFwguu7JZihYxbokgFPmGaz4R3x0eRCTJhDYxF2UdB0VeF+pCLKeR/rgBZG5Fvdi7YU3fd0TO4JK7PZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N91K2nUU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N91K2nUU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b61161dd37so17261771cf.3
        for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757698246; x=1758303046; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIIexxQJuuGcppYfGlH23qFT2xQkXBrd7Hq3B7cHXU8=;
        b=N91K2nUUrCyLu+dFnc7qqBF96B0GnyA1DCJZ+1lOscweuxmKTEo1DAY1UXozw6ITi4
         M/raObtAqFchDc3dHt5rYiZbP6sKRXr6uzXxEWb0eAb/9VCsDvrOiIAoBEYzsW+YPkyE
         eZzM7ASr6nhdfUqo1PD0Z5hhDJDcuoNgyhtfzMylx/Ja3SGwFUmc0nGNQValltv1XFr/
         uN2xFLl95p5lvJXhpX5lzWpX8R1+fKk8CCLeVw6UmPYjs+8hbuBbbqcRcPNwncTLdPCP
         h7+9qHGUyrVVsoRRQNRisriZEPR3jWRD4E961B9jlor3zuseYss/SPqZjx9y3gSiZgxQ
         LurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698246; x=1758303046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIIexxQJuuGcppYfGlH23qFT2xQkXBrd7Hq3B7cHXU8=;
        b=DFEFPwYOl70wIqRSJMXx7A9U1LuSc4clYaVcsgxtf6ALrtyDomjI8X9IaYdSfGDztf
         EQuke63keqC+RKWAZLaV3jMGKGZWh2mdTr5+RyvLBVhF8YhA01LrXtPZMUoTh5p1dVzh
         mHW/qce1E2PQJuqWLtyv6DIPvs53iplYU5r1Q7h7ipk8jB63I+pj5j3TrpJRqXyUh/9U
         iQIzb3rGRDCVY9LlBWDrRtnaoCDLjPYDRyDU/1ZVTGkn5R6yI4eX7PidWWqRX/ZyLViS
         nGyzKOKTXzb6uB2ENghXHxI7PGJxqUvroloYbk0pVpxiC69qjDAz3LX201RUJVZpMW+E
         /2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXSUeznQL6VpkbdhKQP9O3Y+dReUNFy6gQ4nhddi0VzcDZ2VfW8bvP4Qu3E5rRxY0r3TBvr@lists.linux.dev
X-Gm-Message-State: AOJu0YzvjAwjIFB5oMJXAu+kGHmty0iP8kJw5mDA6nkaCKSO9DwHz+ai
	yfL+eyimFMSKTZUOgIwMdR+mMB8zQd+TCJicx1edl1mt+/qpbSQGZJ3fpxCng0K6zda1FxqqQD7
	o3euEck3qLmdtJ7YxiZ7oOIeqxaYIvxU=
X-Gm-Gg: ASbGncs8sgGukOrkY9jkHcJ3oZLL6jCbHA3Ha/Xn6ztGLCLChb45CS8DU+HqMC8incQ
	xKnRlKwVSsmsi5hYX3Fj1332e6sOR2ay+MHzxaQRGbQ0I55x+AyQoLHVeEDOszUNPiya6nWW2z8
	7ixLpJaYu+75/6vwjAhbHg1OzvP3LtHKTBdDP0PiGvCke5fmdq7okKguVeUThsT0v5zRiugcXLe
	vx96FsPUpSJi+HuHOHBnULPnMM7oUhsT6H4nAIrQFjMqW3QAc6X
X-Google-Smtp-Source: AGHT+IEcdCSZjZDX72w4oinaB7XT6QqmpJZk3VMxTChZFpoYvtCeUS7bDJlGiyqj98thpHZJTlGF9yw6Sf32KJ6S4V8=
X-Received: by 2002:a05:622a:5c98:b0:4b2:8ac4:ef93 with SMTP id
 d75a77b69052e-4b77d0ff805mr50626621cf.78.1757698245900; Fri, 12 Sep 2025
 10:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com> <aMKzG3NUGsQijvEg@infradead.org>
In-Reply-To: <aMKzG3NUGsQijvEg@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 13:30:35 -0400
X-Gm-Features: Ac12FXwnGYyLDAMLNpwS8zmPZj5g0R1lO_gh0yPx8OPOW_t5xNmOKu_QWWNBsIc
Message-ID: <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:31=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +static void __iomap_finish_folio_read(struct folio *folio, size_t off,
> > +             size_t len, int error, bool update_bitmap)
> >  {
> >       struct iomap_folio_state *ifs =3D folio->private;
> >       bool uptodate =3D !error;
> > @@ -340,7 +340,7 @@ void iomap_finish_folio_read(struct folio *folio, s=
ize_t off, size_t len,
> >               unsigned long flags;
> >
> >               spin_lock_irqsave(&ifs->state_lock, flags);
> > -             if (!error)
> > +             if (!error && update_bitmap)
> >                       uptodate =3D ifs_set_range_uptodate(folio, ifs, o=
ff, len);
>
> This code sharing keeps confusing me a bit.  I think it's technically
> perfectly fine, but not helpful for readability.  We'd solve that by
> open coding the !update_bitmap case in iomap_read_folio_iter.  Which
> would also allow to use spin_lock_irq instead of spin_lock_irqsave there
> as a nice little micro-optimization.  If we'd then also get rid of the
> error return from ->read_folio_range and always do asynchronous error
> returns it would be even simpler.
>
> Or maybe I just need to live with the magic bitmap update, but the
> fact that "len" sometimes is an actual length, and sometimes just a
> counter for read_bytes_pending keeps confusing me
>

I think you're right, this is probably clearer without trying to share
the function.

I think maybe we can make this even simpler. Right now we mark the
bitmap uptodate every time a range is read in but I think instead we
can just do one bitmap uptodate operation for the entire folio when
the read has completely finished.  If we do this, then we can make
"ifs->read_bytes_pending" back to an atomic_t since we don't save one
atomic operation from doing it through a spinlock anymore (eg what
commit f45b494e2a "iomap: protect read_bytes_pending with the
state_lock" optimized). And then this bias thing can just become:

if (ifs) {
    if (atomic_dec_and_test(&ifs->read_bytes_pending))
        folio_end_read(folio, !ret);
    *cur_folio_owned =3D true;
}


Thanks,
Joanne
