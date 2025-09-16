Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B12F5A35
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050059; cv=none; b=LEx2JgsJV1k3P6A63RyInQJWO8LWCpInxX51jwypRVialaOFxXMSW9Ug/4j9Z9S7FoaW2qBc2gabYVgSf06b3lShqJGetvcIUaHw/Snlf2xxQVLRlDAmiC0Thjxv8o6Iyz/sbZR9I1AgCE1wTaqdGAnkAsFjapBAS1E85seavpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050059; c=relaxed/simple;
	bh=Xy7VXhh3YEK7cUVocua6pJ6f1HAClx0ThLQjwcRSeMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPCNu9vajrbV/VVFy72kZAEQK74byUham4Tzy28UfaS8q1svNuMfYdYqmrALETKhl5QKrgpvptYklUCOUattV8zLHLQSLuOFwch8xqs0T0IgdNQ8gBn8YcRMuDSFKwFQJNYwoO+ID10+Xfzagj2svQCViUZsot29oiHeyvwLdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCJU4cxt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCJU4cxt"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b61161dd37so45048101cf.3
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758050057; x=1758654857; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sDsCrroOBNAqKcWltn4wv/b9zaB4bt8yGtraqcOqWI=;
        b=FCJU4cxtIAEcyYO2MQbXGiSbhRkLDs95+lrWOJcExdtvspz2LyfLzB98uJLDcoZRu0
         w0mveiE8v7Bc9Y+Q70nOSHZTjRuQce89WgYSRfK57CDpea773Smjdpkq0KBxECVvRxog
         mmFlN3r4x1fqB9ZUlo0zWtF8NYzc0JR44K9o9rwLrK9W0YMa+lMI4n3p3cZm74j986XG
         HbqP+DXCYWDGnPG78mIu561/w9BJVmBn8COt/+tDJBLGzesdF9ic4aYFxO4rmJBZi54E
         KWWcF1A0Plyh7Y0ZRFFwadpjKf9ScY1molK9fBRKrEJ5Mzj7Kwtwf84kRwjnwb0XSqpo
         m8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758050057; x=1758654857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sDsCrroOBNAqKcWltn4wv/b9zaB4bt8yGtraqcOqWI=;
        b=vPi3eeX/ia4YDW+xyToaej0ItYhe7xy8dNNU4+RWgY0KXiYcQIn7w9YioH8V41ro9Q
         e/eRFPmM/ZkpWJH8Va7S4JRIWVmWfhESz3/tluLxjdj0yNU4BGcLwdd6TosPLlDpOemb
         Rns4kSSOYMVwwnedgX7OqiVsWVuGIb6LA33OhZn7yZPQqinR3NTylosaI2+ecpRggsei
         xRSSyrbi6jkZjEkeNPTLV50Oh5GlpYJ+Q2Yy9YtG+lD/l8Es2NSPNipqdnnSOOgkt2PK
         oJtKhJDkachP/1L3D1RyEW/Dlz2ztXuO8cT/37ZMOtggjMGOG8K3fdNKCeAxjq3sCF6/
         jg/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyWWtFcbMeOWpRxmbcg2a6xqhNFo06MsLK/QRq075YAAgK9FjC1QOYyvexo5KExGOp7Mc6@lists.linux.dev
X-Gm-Message-State: AOJu0YyN7mvJwhGsu8bQVE8Ia5snELOq+dIIeKAdvdoGvBYRl5Xbhksi
	3jXnHLjgD9duYNtamPGtTdm/yLal8pYuMJl76MMMSBXF71btiSg9q5/LwJhAFKEdRrNw3h4nhUs
	6ZeTAy+5eYI8dPU/xGY67bI0RmWWBhcE=
X-Gm-Gg: ASbGncvFy60GBKM6cKAD9B33H0JERRSpC8KdXSJR3gQeQALSewT3SH9wbSCTkA6mRnY
	vOUqFf0qdkoF+e5w1whEA0CDDGKnzvLW/XrZv3Uh5DQhLl5qaS0kYC7z7rGtx1seNlWa2vRmwAz
	RcS+HL8eDukwJRL0iQ3/kxNsfsC2UjCNSnJhW0ALcp5aNPYbPbWJyZgG+RQ9HdzZ5w+NJTsRVaL
	Gb9s9u6VI1O0OhAJZ5NF3IBvuIJRcR221p3gvsI9cgwyAN30cQ=
X-Google-Smtp-Source: AGHT+IEnrb16bzEhxxaatwm/RHyGJRLO1QGX6fXH1y0q6MaUT6DETIc88lYKeVZ10sb2epPRZw0BAX+3ZiCq+mA4Bjw=
X-Received: by 2002:ac8:5d0a:0:b0:4b6:cbd:8cb7 with SMTP id
 d75a77b69052e-4b77d0894f7mr223403051cf.54.1758050056106; Tue, 16 Sep 2025
 12:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com> <aMKzG3NUGsQijvEg@infradead.org>
 <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
In-Reply-To: <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Sep 2025 12:14:05 -0700
X-Gm-Features: AS18NWDZ6XCFv5ugS-Pg-arJpmWxy4cqI-2OS1xanpbZfZTkTFB40b8v2IMXcnk
Message-ID: <CAJnrk1YmxMbT-z9SLxrnrEwagLeyT=bDMzaONYAO6VgQyFHJOQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:30=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Sep 11, 2025 at 7:31=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > > +static void __iomap_finish_folio_read(struct folio *folio, size_t of=
f,
> > > +             size_t len, int error, bool update_bitmap)
> > >  {
> > >       struct iomap_folio_state *ifs =3D folio->private;
> > >       bool uptodate =3D !error;
> > > @@ -340,7 +340,7 @@ void iomap_finish_folio_read(struct folio *folio,=
 size_t off, size_t len,
> > >               unsigned long flags;
> > >
> > >               spin_lock_irqsave(&ifs->state_lock, flags);
> > > -             if (!error)
> > > +             if (!error && update_bitmap)
> > >                       uptodate =3D ifs_set_range_uptodate(folio, ifs,=
 off, len);
> >
> > This code sharing keeps confusing me a bit.  I think it's technically
> > perfectly fine, but not helpful for readability.  We'd solve that by
> > open coding the !update_bitmap case in iomap_read_folio_iter.  Which
> > would also allow to use spin_lock_irq instead of spin_lock_irqsave ther=
e
> > as a nice little micro-optimization.  If we'd then also get rid of the
> > error return from ->read_folio_range and always do asynchronous error
> > returns it would be even simpler.
> >
> > Or maybe I just need to live with the magic bitmap update, but the
> > fact that "len" sometimes is an actual length, and sometimes just a
> > counter for read_bytes_pending keeps confusing me
> >
>
> I think you're right, this is probably clearer without trying to share
> the function.
>
> I think maybe we can make this even simpler. Right now we mark the
> bitmap uptodate every time a range is read in but I think instead we
> can just do one bitmap uptodate operation for the entire folio when
> the read has completely finished.  If we do this, then we can make
> "ifs->read_bytes_pending" back to an atomic_t since we don't save one
> atomic operation from doing it through a spinlock anymore (eg what
> commit f45b494e2a "iomap: protect read_bytes_pending with the
> state_lock" optimized). And then this bias thing can just become:
>
> if (ifs) {
>     if (atomic_dec_and_test(&ifs->read_bytes_pending))
>         folio_end_read(folio, !ret);
>     *cur_folio_owned =3D true;
> }
>

This idea doesn't work unfortunately because reading in a range might fail.

I'll change this to open coding the !update_bitmap case with
spin_lock_irq, like Christoph suggested.

>
> Thanks,
> Joanne
