Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2B28A1D5
	for <gfs2@lists.linux.dev>; Sat, 22 Nov 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794970; cv=none; b=t9xiUwq6fWZZ/H8MFquySo97v+44mnyp5YC6p8a2ndPTWg1yv4qCdVKNdjuG3bFVgnXVCzRpzZhqbzKjxTlNwGZ5E/zSYdYpxkDClvrk2txcRfH8C2VEn2QnHTu+39sIIUSWAhnhWjd4+YdI+dcM/SuigSa70y/2yiQeYmCLLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794970; c=relaxed/simple;
	bh=3qML6mAdP3XOHu6CRgEfvtbrG4LVKi3a96yUcu5LMO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCLX62FbjC0yoV7M74PZ4xsKvWfACnoVfWtWCsrSMvwUqilKuN8PgvcsA1Zb1SwTceZYlKOMWKbWK/+fm8mj0SZ/k1e5y/K/4yhbOo/0RGXvXGEM/dzrKoO/KhrcFmSvqW5yxQyvO1wk2gVH+3TRc6Cp+OvOaAGFkSw19y1HPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFNGP3cE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNGP3cE"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b29ff9d18cso273370685a.3
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763794967; x=1764399767; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=NFNGP3cEcVI4DzLS8NwKrlYEZXToc2D655GsOaN0h/xdx3GhMFMY6HxuOMewSZteBX
         3q4kK2ozIT2dDMgGY6DgcZU4IH/Z9mc9Ojpt110/BGVvIruSFX/UjNt2N7IKwc8IQwSO
         UJhSWqjuQfnHfNAFaIzmtKHXGZvBnxdUPkFWyOsXcg37FwRRQzz5cSUAhVb7s4mWAmRZ
         e+SePYfBxAY0+2Npkz41TWtvs35beVKSqj9m5CfvxcZH5ShcV0UBNWSH0B+2hX9BCruh
         6b/07c085YvLMnAqigV3uqmcNT04sUvNIJMX4MDTacTj4tU3w67f0Z+iOjj2qoFtSwjl
         oLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763794967; x=1764399767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=Gwqe4ztGrqhVsQfRNFkW3Vwgb0P5SnxVz36Lo5dCuaDg96hJlIMS9frM94/8jg1mT4
         pH81GnRrg0mC+cfokfc7l9Y2olCGZivuKixlJUEF/FSzRKa5+YuC2tbxEoO4Ccxsl/53
         Xe6qRN4yc5lfUCG5qUv3/jzazDP6z0qscjwoagGQDm62T7kOXJ8JJcwBhd2QAUvwEP5b
         ILd6k7VbBF+1F+H4wBISN+zjWWd/n4Wessn48bFPpZnK02tSUlHdJxzm64VBhDj5Z+dn
         by8JC5bUomsNs2SYJ1Dn1GS5/FC9sohcetOkqGvQyqNpX4DLAnY/mlUdThOruNof50pK
         Zp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvwtBobjLfPBDHGF7A7LsjemNCSOToEM9oupuUaOqd80hihIX0kBTe1wdoUPtpt3Qrquew@lists.linux.dev
X-Gm-Message-State: AOJu0YxS/H+z9SlnuKc9l3wNwH8IHgCSXyHUO4m0b9U3a8TUe8vBdwaB
	L9GjfTJa6Y4I+GmydBfePh9Jn9GDh2s6J/9YNTmXWsG7Zwe4MZYTdZANwV98NzkFIbw9x3VZTtA
	jifFuXvtkTxbK9zP5Q1cRy9DkdLgOKgk=
X-Gm-Gg: ASbGncuqB1U/JEgRGboupDgXJo/f3B7n9Ng6XJyMWdYkQEvcxgM9hijtr+dD0fyAvPj
	pZb1Df1muc87czQhYZilukgAIGVKMaJN6h63+245/dT2NxvJBrLMAgJpxEB93l8aCFEEcWFdM7z
	77URjNaouQmzllH394wMdkuQuKrwaXZSapg11eXqr3R12QWPvW0UwiW3nhMYpXK9j4Ck5TlZQ+p
	FONeh1klPQb+7Q6s2dBaBhOG3+djiYoc0qrMMfxd2EpoLGAtaogflrgiSQjqvUm9miXs2E=
X-Google-Smtp-Source: AGHT+IEjcPOv6aPW6JO4Bb1jDowgVciSWSsWd+FNjyx3VBhgbx3Pj6ddYbo0M3Mtuw+ANHFx2AKfX0TCp1WB72JEhOk=
X-Received: by 2002:a05:620a:7106:b0:8b2:e5da:d316 with SMTP id
 af79cd13be357-8b33d48b7d4mr603659585a.87.1763794967475; Fri, 21 Nov 2025
 23:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-3-zhangshida@kylinos.cn> <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
In-Reply-To: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:02:11 +0800
X-Gm-Features: AWmQ_bnR6g2ivQ9YSC5w0bIwME61y28InS6FucoZ4PBrcXjaLHV0KwJ_bufirnM
Message-ID: <CANubcdXx8Lp1JsqG3ctAE2V6jpuvJL93UH+7yHaAFtdMjHdijw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E5=85=AD 01:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 55c2c1a0020..a6912aa8d69 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, =
struct bio *new)
> >         }
> >         return new;
> >  }
> > +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
> >
> >  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
> >                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> > --
> > 2.34.1
>
> Can this and the following patches please go in a separate patch
> queue? It's got nothing to do with the bug.
>

Should we necessarily separate it that way?
Currently, I am including all cleanups with the fix because it provides a r=
eason
to CC all related communities. That way, developers who are monitoring them
can help identify similar problems if someone asksfor help in the
future, provided
that is the correct analysis and fix.

Thanks,
Shida

> Thanks,
> Andreas
>
