Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312C1552FD
	for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754596; cv=none; b=qPuKakAJBHgCHw9xjM2PMS+48OP9sDf/ZlS4UUYIwOlV22UU51+isYKJ7JqpW5l2+Im57pjx1Mfyc9M1y8oeEOHi8kKDSuTXv40B/FdPY3NdFHJfB6GzHhlkd6dAWfmMfSAXKQgmaOL21n8jPVq6soMNNcsDder6yE0ADjbhFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754596; c=relaxed/simple;
	bh=Op6DNkPC6eHPtYfufa74RLj648Tv43squgVRXyUVfnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhvJbCdzQ8cnDI2WOyNkC+aXjHH6L2wEvn3jVCaxDxI33hvI6ScpjmUgezWVPcnuffcYU5KbtL2ogX0lppq20Bj22KrkV9A5WH3jlr8tTighYbnZx4iN4HCAgqsaY5p7uh03Zwq/cdlIEzWhbIkbZGhAwpxkpc57y/EGvXtQiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fly4OYuX; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fly4OYuX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85322d9c606so44729985a.1
        for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758754593; x=1759359393; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B+Zh9yFHo6Xolwu3opD/Diih25AjkCAs1FmMFIzwVU=;
        b=Fly4OYuXWtoJGoK1IF72lgbSUIz/i5Fmo6zODbIEu0ho0Ylaz9b/tauF3VJy2j+S66
         R2FrBwI9byoHwMshHZqUFzX0rLOihuHwK02klYU3SPvowSkpV2dgnhsRv5pmFgkiD0DZ
         SrkzULcB/C3LcaUDOL7N8RK/yNoHGGwjmMjWm7AGBlp8ltlpqOzax45hGDDeka0UY5V0
         t+S0GjGxcejVXJ55N539QkwL+Y4vlKKfDyXgQBC7mKcNBZh0rp4o12fIg5dFfPaHaFIE
         ExsFP8K/OpBDXXAao12W6f36i9hZa+thU9DhnJp7zeDUIoVhzcgjvNvORhtMCexE2J22
         oasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754593; x=1759359393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B+Zh9yFHo6Xolwu3opD/Diih25AjkCAs1FmMFIzwVU=;
        b=hDjuYAwQu+IdzYYhvmB0OSP139p5SwQOmZ4a/jYJDmtlg5j4dZuBTT89Jp8KB7ScVh
         AXFJin2F+mehVn3nks1DTHQ4mSTWC7vMfd3HbqllhfiBJBMJqD/0aQWVjZ6oXz6giPYs
         YUKPenv2diVZZrzKRR6hsHifyLb9K01A0LS36X40JxtEOCitQ7p7SDMoRHEDXP6Za3uc
         iLGvkFtq7mHDgqMr3enoWcdAdkl64rSJGwrDZwfjYotqbY/CEcQKulQqUYEpA3sm5gpP
         XTP0Q9L7syfO2t0oKXnKseSGyN0X0l4vM5kO6JxrW2qgsfQewND3ZoxExG6T/9bxf4V1
         dt1g==
X-Forwarded-Encrypted: i=1; AJvYcCXqMkQTE6w4209YYjNEEkM3uRqlzlfHfcis7zVw6n46aLpDpohLCCi5bplzadcNtltS0lit@lists.linux.dev
X-Gm-Message-State: AOJu0Yw98OjgCCstELurooyKhAKP8E2wlEguispUi1LSJnXUhypF4e7m
	FPgr75VdOc3v7NOxoRd0fUvD9qxX9vYfUAmI7TH8xXKHUHUGSs2uV8QKvkN5J0ZMroVxg43fD6N
	DXCiscSstf/BZZgLA3uad79+JloO89bE=
X-Gm-Gg: ASbGncuCR+UYTcV7hdN1QmbN4BwOTAhKXns05atPQxVVPsH4nIz7cDUnyRon1cVaqF7
	9vQyZhfRvCNOlbNVknuIsGOUUnuCM09oQvqy68JpESZZLRaXerQRiA6R2t+yi3twIdHCfwFN202
	sLqJT0cgorxSVAT/Biz8s9fuS9tIs8hOLVSJHvr7+lSL5UnJVfKm1vn37ug/FMufars/QNhRfKM
	tPGtSDOiGVNJbDi1WJvvv5ZWUS3cwhFkc5wCNvq
X-Google-Smtp-Source: AGHT+IGzPzKs0y65h3LIZE6940gB4vV72Qyi3WZ6TBql4rL2B63TcdhnpA6Y4/6LPYw9/CuHLQab903G3U6TadwRTxg=
X-Received: by 2002:a05:620a:394f:b0:82a:5c45:c625 with SMTP id
 af79cd13be357-85adec4234emr191180885a.12.1758754593415; Wed, 24 Sep 2025
 15:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com> <20250918223018.GY1587915@frogsfrogsfrogs>
 <aNGWkujhJ7I4SJoT@infradead.org> <aNG3fnlbJhv1cenS@casper.infradead.org>
In-Reply-To: <aNG3fnlbJhv1cenS@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 15:56:21 -0700
X-Gm-Features: AS18NWAkh7IUvbVhGBD_bsGuTPZgO9EW5ULTCeoQsEee5-TykTnYOZdbSiLkTe8
Message-ID: <CAJnrk1ZoZqnX8YOBJBnNpr65FpMO_wNJBg42NCAiB1_c+Zr-ww@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	miklos@szeredi.hu, hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Sep 22, 2025 at 11:33:54AM -0700, Christoph Hellwig wrote:
> > On Thu, Sep 18, 2025 at 03:30:18PM -0700, Darrick J. Wong wrote:
> > > > + iomap_start_folio_read(folio, 1);
> > >
> > > I wonder, could you achieve the same effect by elevating
> > > read_bytes_pending by the number of bytes that we think we have to re=
ad,
> > > and subtracting from it as the completions come in or we decide that =
no
> > > read is necessary?
> >
> > Weren't we going to look into something like that anyway to stop
> > the read code from building bios larger than the map to support the
> > extN boundary conditions?  I'm trying to find the details of that,

Doesn't the iomap code already currently do this when it uses the
trimmed iomap length (eg "loff_t length =3D iomap_length(iter)") in
iomap_readpage_iter() for how much to read in?

> > IIRC willy suggested it.  Because once we touch this area for
> > non-trivial changes it might be a good idea to get that done, or at
> > least do the prep work.
>
> Yes, I did suggest it.  Basically, we would initialise read_bytes_pending
> to folio_size(), then subtract from it either when a request comes in
> or we decide to memset a hole.  When it reaches zero, we have decided
> on the fate of every byte in the folio.
>
> It's fewer atomics for folios which contain no holes, which is the case
> we should be optimising for anyway.

I think we can even skip subtracting when we encounter a hole and just
tally it all up at the end if we just keep track of how many bytes the
caller asynchronously reads in, and then just do read_bytes_pending -=3D
folio_size() - bytes_read_in to offset it. Actually, looking at this
more, I think it must be done this way otherwise handling errors gets
tricky.

I had missed that this approach leads to fewer atomics since now this
gets rid of the caller having to increment it for every range read in.
This approach does seem better. I'll make this change for v5. We
should probably do the same thing for writeback.

Thanks,
Joanne
