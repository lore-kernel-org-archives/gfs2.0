Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3052DEA74
	for <gfs2@lists.linux.dev>; Fri, 19 Sep 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304716; cv=none; b=MTr+Sf8PbGKWnAQnEZuV75utCcLUhlofGTFQ4xJrGwAc/UFUJuCJdhc1p+a46bxBa3TAYL9uIFj8ttUcpJ8MEIo+e51CLajJfwqp6Nt+N8R+llMHjRUxPkfSpPaO646wc1FYpBIm6ToRbKJaswzDLhkTlPy9YGiZzMiOUXW4uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304716; c=relaxed/simple;
	bh=38Gs1Qar33XAo1Y7OS66uYvLqXMX9a7h0GZW0uT6IT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qzz+3UY8N3pY+JdEkaobwvSQh3JDCajbutjLN5+FGU1n2Cl9mGBCZPALLnFRyAA68H8dOVpq2Y4VLnGDrfxLvFIaDPQsixSxC00nLaQhZI94/b7gnJSSI5lGKyeIHinkwvRHM5W1sFevpVe1ygavnZ7sU7fBaXg9aB3uwWJUqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eymiwztl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eymiwztl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b7ae45a91cso16698961cf.2
        for <gfs2@lists.linux.dev>; Fri, 19 Sep 2025 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758304713; x=1758909513; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKiAXDkgrX2LUhD4TKk8v5QGpSKY+EpT1ETvTouA6rM=;
        b=EymiwztlZlSHVwEpRp7o82SL0CKPuJm60h+c0ZosN+WpJ/AOb37W6ZOsPbfbLtTB1b
         1A93gR5si1U1vFK4MYE/2p8BwpmxAA0fHzyYIYmlv+o1jpqqAf6iUGiglWEKT+iCM4da
         Anid0LNAyLnL00mz8mey9Pr8BhmRWCim2IhG373af/aXm+lD61C5ooKyYKXccL2uPiqh
         DrDOzyL8osaGQsIwWri/UkHH3m5soD7u2LpSu8R/H6ZblyFtsYD2C9OHumdVomwo1Cc8
         muJIsa1qU7xEOxdgxYCK7sxXLZTr6yXQefNYFB8jgKEQ2wYbKYOj9MJUMP5ckrsuna4E
         GJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304713; x=1758909513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKiAXDkgrX2LUhD4TKk8v5QGpSKY+EpT1ETvTouA6rM=;
        b=chLL3Ga+mE4TGtHBc+X9Y1WHyzcojlLhG1WqFpxP2Fl2Ibknvnrd1/KjFmtJj3w7UG
         n6Qgl8Ll1G3S6otpDuxQYv/rdckz/RPCFG9Uaff1aHgkLIRiF5uZdIqkTYq4cEKR9lSn
         9LKsts8dXHuawOOsGVhPIqX+9jsNCxg0JMoU/gxscNlJp4NWPUIFhz3j+5AN1CULln4+
         A5+8R4T3kotkdtyg/kq3geCXt6JVGidrihVmAVY3ciMIzn2Yr45GqO84qp3VVwUyN3ZT
         mhJa5Z//72d5f1Kg6dUUsyqENnO6J9qS8f8tq4M9qHO/a2bWqq2JW92HsF0LQA/NIm4M
         NrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUXKb7jPwNqtbO2/pzKm6OJIyJkBxbsr3QKCbg87p0QLplfeCoaX9XYL/2iLGEcU4sH3h0@lists.linux.dev
X-Gm-Message-State: AOJu0YxUw1vQ6k/l6QZt/+v974EAz/B6IRe57RfLtUaN1PgcAehKPC1x
	CJU8ESbCa2QfHBaurjLMRhVY1risWYPL/h2mqnRtq13ZaiIU6xL38bStgR62zWc2sDz3opeMeGI
	eRsol59J2UZE36h78b3huOkJWlUk5r30=
X-Gm-Gg: ASbGncsCFrIi/vzi9+fYzbC9ZpNf0ALkwUJNc5gAtb/0gcHqUiQQckNRkJA8dJ3PRTh
	hyuU0N/sKAA5dyAV9iDyKn5e/oc98mLofnvK34h10Odrkah/ThBV6mt4dWZpkWlG4wnabKlVfZg
	gK2D1UYbqCx/mhxg+8NCoFNHtRviSy3pNpBZUbhS0d2wgUVq6CjyOpWwcLiEReybkxNhBFhHw97
	ilM221iCPcLiwSQ3T5Iqfu/jDlHfScUZftuNm1n
X-Google-Smtp-Source: AGHT+IG5Mo3h/1ff88PwcUapAIlS2YVGSiLxAR3AL07FsknEHK18lG+gFQCk2zfPCcdMXf1hLVttPVUfviUqt89STrs=
X-Received: by 2002:ac8:7f4f:0:b0:4b5:fc2a:f37c with SMTP id
 d75a77b69052e-4c074b076d7mr48411081cf.74.1758304712602; Fri, 19 Sep 2025
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-13-joannelkoong@gmail.com> <aMKzG3NUGsQijvEg@infradead.org>
 <CAJnrk1Z2JwUKKoaqExh2gPDxtjRbzSPxzHi3YdBWXKvygGuGFA@mail.gmail.com>
 <CAJnrk1YmxMbT-z9SLxrnrEwagLeyT=bDMzaONYAO6VgQyFHJOQ@mail.gmail.com> <aM1w77aJZrQPq8Hw@infradead.org>
In-Reply-To: <aM1w77aJZrQPq8Hw@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 10:58:20 -0700
X-Gm-Features: AS18NWA4Ectn5ref1Zm-F0jRvHV38iLjidkioHaeJy9w2W9ibGS--sEYKpZ7E2Y
Message-ID: <CAJnrk1bKijv8cce+NdLV-bOvdU=HdZEb5M=pE5KhqCWX0dAOWA@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] iomap: add bias for async read requests
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:04=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Sep 16, 2025 at 12:14:05PM -0700, Joanne Koong wrote:
> > > I think you're right, this is probably clearer without trying to shar=
e
> > > the function.
> > >
> > > I think maybe we can make this even simpler. Right now we mark the
> > > bitmap uptodate every time a range is read in but I think instead we
> > > can just do one bitmap uptodate operation for the entire folio when
> > > the read has completely finished.  If we do this, then we can make
> > > "ifs->read_bytes_pending" back to an atomic_t since we don't save one
> > > atomic operation from doing it through a spinlock anymore (eg what
> > > commit f45b494e2a "iomap: protect read_bytes_pending with the
> > > state_lock" optimized). And then this bias thing can just become:
> > >
> > > if (ifs) {
> > >     if (atomic_dec_and_test(&ifs->read_bytes_pending))
> > >         folio_end_read(folio, !ret);
> > >     *cur_folio_owned =3D true;
> > > }
> > >
> >
> > This idea doesn't work unfortunately because reading in a range might f=
ail.
>
> As in the asynchronous read generats an error, but finishes faster
> than the submitting context calling the atomic_dec_and_test here?
>
> Yes, that is possible, although rare.  But having a way to pass
> that information on somehow.  PG_uptodate/folio uptodate would make

We could use the upper bit of read_bytes_pending to track if any error
occurred, but that still means if there's an error we'd miss marking
the ranges that were successfully read in as uptodate. But that's a
great point, maybe that's fine since that should not happen often
anyways.

> sense for that, but right now we expect folio_end_read to set that.
> And I fail to understand the logic folio_end_read - it should clear
> the locked bit and add the updatodate one, but I have no idea how
> it makes that happen.
>
I think that happens in the folio_xor_flags_has_waiters() ->
xor_unlock_is_negative_byte() call, which does an xor using the
PG_locked/PG_uptodate mask, but the naming of the function kind of
obfuscates that.
