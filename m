Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39A233D99
	for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630516; cv=none; b=TBuPdVHWYwZSECDNi7fPVex2C3MtlGjZSPM9/3W3gmuhnJgQALq/1eTtmhowCWVFV2KyMBCUHo8L4TDyNiae5y8Cso6cPVd7B2eHCwQoBDY2dC3OXZJkbUQJjg9qjGoi/D0tSgwIObpPUqTdE2fgKjrIap9TZMQDFXZy2F2/y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630516; c=relaxed/simple;
	bh=SImQJADbpHTlvNCQBrZUtzCB2b/Tc0ig7xFDdyJ1a/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASzLeamjXedRY555OUNcZ3O3gHG6KzxkV4ptR6CnB8UVI35hdCdlqzGfK03/hDVa0i9Y0fClRqdtybMn24upGoZmn9uJ86CidrsMa9tRE2BhKAJ9dksiMgbGSSpPE1PElx5q3pKA4cL760u4EWiBPOkwG3aGYbu8PQN43ClsHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awgKyEr3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awgKyEr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741630513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pAe53a+t+jZXRC//+k31Dxd8ZsLFTZkf6JZER3Ffgc=;
	b=awgKyEr3EUkFLnrK6nF0Acq1vd/p4+N/qnPja/ZOd97SnVArd77IyhQSzStcPtcg2z82Tx
	fUBX8eQrWwjfMe/Qm5EzRmoa6fY5/aCdAfeqp5mqbgAy197Oqd7TD8AKQLBFDic3jan0Vg
	AmDUiYCNInNri7BnyuA1V3Y7eNFpHig=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-XiEj_VpxNXij_43ElQLmQw-1; Mon, 10 Mar 2025 14:15:11 -0400
X-MC-Unique: XiEj_VpxNXij_43ElQLmQw-1
X-Mimecast-MFC-AGG-ID: XiEj_VpxNXij_43ElQLmQw_1741630510
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224192ff68bso69154475ad.1
        for <gfs2@lists.linux.dev>; Mon, 10 Mar 2025 11:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630510; x=1742235310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pAe53a+t+jZXRC//+k31Dxd8ZsLFTZkf6JZER3Ffgc=;
        b=D1IWoL4ULxypCj7kh/Fquknb2J8keANvthBpM9xXLk+7BUBBrHmbpmvKixMmgB+hZ8
         q849eS408wxj4qQd/CVl/FGzH0QRZYR+w8NCSa8b+8SkV4UCvvQWvdVQHIQemxvKS5/A
         WXNxSckRrye5osHlDO4dCOAH7Fr6hUJeMom3W8d+DhAQPEOty7D5ss/tLmpa5LZm2Wem
         OY3JGMkrITOQ5oclsE0vU5bKOYcCvUXJBSJAx7jRER5MbmYJqX0qvJ1prBty4kTqjO9U
         qeTclBSYdf3V9ahy4BVkx/HhUYsMO2fuwzRonvODnVAp7eZ+qFhQL1dPFYxjMLXXt+/3
         fZcA==
X-Gm-Message-State: AOJu0Yxg8dXTm7X5oDnFlKvvRIyBzMXf09Xry7WdnSxwlYMP2//hNiWH
	vCXeKCoLhOSikvkfHiyL5i4nCf/LmQwI4s8RWA5fzwCrrULLAFJEPDr1e6fZQdSH5VrZdZMNytJ
	p3bwg/isZwt5dgpphlPbvCqvtutB5Iy20Dnfdtr3GezUicnWke+3mMu2ZFjJrvCDCfsocdQn1jL
	l7Fzrt3FSiMDUkJ+Q+2Cnj/QrIeA==
X-Gm-Gg: ASbGncvHyxv5zC+O7W2NiNe5LbDQWLgEIHyzayPF3LbW4Pj6ouw681SiC11nc4HtiIY
	J/Fb0v3wdQWEpnsiKTgWrbOqGMFs7f75NvdILlWh6xjqvqstTILuxBj8joJSLnCMt/HgRPFg=
X-Received: by 2002:a17:903:2f86:b0:220:c63b:d93c with SMTP id d9443c01a7336-225931ad50bmr10249275ad.44.1741630510330;
        Mon, 10 Mar 2025 11:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv1DkG5rlbNPTvM2luEYDXZzmIPhJvZg4f0mJY+AucA7HhO7+60DKAkDW/BhCblf16viK2KTiWJh3F2wdWK44=
X-Received: by 2002:a17:903:2f86:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-225931ad50bmr10248985ad.44.1741630510020; Mon, 10 Mar 2025
 11:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
 <Z84Ay7gj2JQMUuRE@casper.infradead.org> <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>
 <Z85gf3GfqNX3enPs@casper.infradead.org>
In-Reply-To: <Z85gf3GfqNX3enPs@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 10 Mar 2025 19:14:58 +0100
X-Gm-Features: AQ5f1JrB4RR5v156ID73ehkXOUBD7KfJ3QN8J_3DiPrwyJTjF8tKd9ZlAHWzC7w
Message-ID: <CAHc6FU6JuOB0HZ84qqYuseH-CEEmw5o9bMNLzVWVs80NRmpT0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uM690RtOpIpxisfSf47cH1l1kjnSEUKzAhX0nKZYaAU_1741630510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Sun, Mar 09, 2025 at 10:53:29PM +0100, Andreas Gruenbacher wrote:
> > On Sun, Mar 9, 2025 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > > On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> > > > On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
> > > > <willy@infradead.org> wrote:
> > > > > gfs2_end_log_write() has to handle bios which consist of both pag=
es
> > > > > which belong to folios and pages which were allocated from a memp=
ool and
> > > > > do not belong to a folio.  It would be cleaner to have separate e=
ndio
> > > > > handlers which handle each type, but it's not clear to me whether=
 that's
> > > > > even possible.
> > > > >
> > > > > This patch is slightly forward-looking in that page_folio() canno=
t
> > > > > currently return NULL, but it will return NULL in the future for =
pages
> > > > > which do not belong to a folio.
> > > > >
> > > > > This was the last user of page_has_buffers(), so remove it.
> > > >
> > > > Right now in for-next, ocfs2 is still using page_has_buffers(), so =
I'm
> > > > going to skip this part.
> > >
> > > How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
> > > 414ae0a44033 and all of those commits are in 6.14-rc1.
> > >
> > > $ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
> > > (no output)
> >
> > Hmm, you're right, it's only that automatic test that's based on an
> > older kernel. Sorry for the confusion.
>
> Looks like your for-next doesn't include v6.14-rc1.
>
> gfs2            104b4d597ff21b923b1e963c5793efcadeae047e
>
> is the entry in SHA1s for next-20250307.  And:
>
> $ git log v6.14-rc1 ^104b4d597ff21b923b1e963c5793efcadeae047e
> shows quite a lot of commits (9847 of them).  So I think you didn't pull
> from Linus before branching for the v6.15 merge window.

Right, this is the point at which gfs2-for-6.14 was merged into mainline.

>  Not sure how
> you manage your trees and how you'd like to improve this situation
> (do you rebase?  Do you want to bring in a merge commit of some -rc
> version?  If so, which one?)

I have rebased onto v6.14-rc1 now, so things should be fine.

Thanks,
Andreas

