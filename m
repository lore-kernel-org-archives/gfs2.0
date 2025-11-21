Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEF2D3731
	for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741618; cv=none; b=kIgEjDgoxJaGn7cprWuebMYLN0HmUBwy8wWTZvJjXDLXESqf7xR8fI05eC1XxpMsraygQybI/+V2+F9RCN7cTcGRmtZO4gavPg2v+G/qna4y2P+cbTp+LU3wUWxmW/AtxhVMF8LmGd8/yL0/b3KKrk4Du0fFWfm05Znpw1gR0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741618; c=relaxed/simple;
	bh=dMK0oCGPkhBORnYflGD+Nd/wtsiqo9P9q5j0HWkQypo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwm/A+ZnV9mloJM84aKIegSYeTiikaN1g1Bp6q8VSOTk/3ik/DpLFvaa9x0w3QvuJ3zIObc9qTWhTJp6pj8kLN92kRQLqdSkPjeXFgcW3eFDSDft5vMf8PRjw3qiaRZKiRPkQPhhqefMkMgepfE6rsv/QxxOzdX75Y4i83tZWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcNQhhhh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcNQhhhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
	b=LcNQhhhhpJ9wRd7zseKWpTJ3jS4xzTdefbyazCyQs6KiM94uuKs5frKIxOWAOiyiQVTRl5
	FpwZDTgFDVXCxw2WRUxWRkZShZSpeqkihAI/XF1Y49UN16KSOoxRo7x9rYkpuLLoPj1BeB
	CbyfCBjqxyvVVqsEpfXvtMqk4aivARs=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-lGxT9eaEMTKbInKoDhehzQ-1; Fri, 21 Nov 2025 11:13:32 -0500
X-MC-Unique: lGxT9eaEMTKbInKoDhehzQ-1
X-Mimecast-MFC-AGG-ID: lGxT9eaEMTKbInKoDhehzQ_1763741612
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e3421b8f3so2705781d50.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 08:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741612; x=1764346412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh93R5tPjAC6W1rTnWq/i2ZvU4feR2Tgy6yZhs+i3/0=;
        b=LQA5g7ZifIRs1Sgc60MpJpoMO/V4+ghNRzwaO6OiA0QRfOWOJs3lKqiWs8TBjEKpnd
         OPV1bct7fTmuhouDxMCpbG81ePkLy2qkpco2JlQ4qJpZkGW9D2Wu6lfGZngm/TnkU+p5
         qudK+bjfSdIhYQft6fxemMU8tQEtPAw4WaaO3TM+z7wRclN1EiEa12Ac132CEOLjz6+R
         /ijPNviWn+45tgtGjl7q9w0XHPaCjhBv8b6DR/4BmRoOwxRTyYZ+DsP2xDjXfhW+LI5v
         wY+FUlJBOLL1cDFhtC690o+mcdWjyoz0x4j+J8KheQ+i13XrABgO4VqGLYdCrBost2uX
         OQVA==
X-Forwarded-Encrypted: i=1; AJvYcCUQmPJpAx+nZ8vRLhqMjgux6ccxGXRSu1LKHpESgqQFmyaxGk1oWPvURP972+ce2QIqovjV@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6vtDuZoEXEs0YgXIMpWFtczdBU+ctHGepojg8zvw5IMPEwr7R
	+sz016y42WsRUj9ob523eUL/N/rzXyr+sd/Exoyuvox+zNdQB80AI6LfM/Y74l/BB7dLl3USHiU
	j8cDVSZAoOmCPkz20VJBJxl9E11wGxUm2OGAwa6LFlWKMrzNAyh8r11DgrZqh+raXYuUhwYc+6F
	2JmbJTd/VAFdsd7eVQ+bvTtYM4LvUoCA==
X-Gm-Gg: ASbGncuFoy9PPnIKMhV3oQ2qzQRO9FE6SyqgG6bbNSqU0iN13qezPaBwxc2wUe1XUHC
	R3P7DpUFULx0P82hmUSvNX6seTbwVt2N73dD8slWN/l85cIIWuNIYKDZ7tgJkYzuuAzi6IcBBGH
	+rhr3CohmPWXlbIGEPdVF4jlGfvbcbBeSkEe8BWE35FfStTMBlDSWD9cUhYR7c5wWW
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id 956f58d0204a3-64302b122d9mr1963773d50.85.1763741612190;
        Fri, 21 Nov 2025 08:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQHJg27kBmo+3qPSDwMS0FzdloscgwgQdqDmCn0XCLoSgo3nmRsjJwwBETY525KvvMg6grxlgTavlZWQ/uK4U=
X-Received: by 2002:a05:690e:1699:b0:641:f5bc:6979 with SMTP id
 956f58d0204a3-64302b122d9mr1963750d50.85.1763741611792; Fri, 21 Nov 2025
 08:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-2-zhangshida@kylinos.cn> <aSA_dTktkC85K39o@infradead.org>
In-Reply-To: <aSA_dTktkC85K39o@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 21 Nov 2025 17:13:20 +0100
X-Gm-Features: AWmQ_bmosC4btoZ-wa-ksr6NsYAdeqQOhz6k6QYvia4F3jK6NJjmea5Iy6uFTHo
Message-ID: <CAHc6FU7NpnmbOGZB8Z7VwOBoZLm8jZkcAk_2yPANy9=DYS67-A@mail.gmail.com>
Subject: Re: [PATCH 1/9] block: fix data loss and stale date exposure problems
 during append write
To: Christoph Hellwig <hch@infradead.org>
Cc: zhangshida <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: op02PAekWolHyJcNiPTsSDUKuUiy5Yo3FLmVXfF8X_Y_1763741612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:38=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Fri, Nov 21, 2025 at 04:17:40PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..55c2c1a0020 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > -     bio_endio(__bio_chain_endio(bio));
> > +     bio_endio(bio);
>
> I don't see how this can work.  bio_chain_endio is called literally
> as the result of calling bio_endio, so you recurse into that.

Hmm, I don't actually see where: bio_endio() only calls
__bio_chain_endio(), which is fine.

Once bio_chain_endio() only calls bio_endio(), it can probably be
removed in a follow-up patch.

Also, loosely related, what I find slightly odd is this code in
__bio_chain_endio():

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;

I don't think it really matters whether or not parent->bi_status is
already set here?

Also, multiple completions can race setting bi_status, so shouldn't we
at least have a WRITE_ONCE() here and in the other places that set
bi_status?

Thanks,
Andreas

