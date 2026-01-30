Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949636B061
	for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774524; cv=none; b=g27xiGu/5RFbuoDVkbYuPI+4RnNYM1oRMwGPcqu2XR3Y7urD4AphFdPUytkyShjZaB6Rqygg9wKGRXxvXya9B3Kol9KwWlSRVQTqH1MEgtefkgMSpCYaw4zY7VPePbgnahbUAf0BJ/S/g0GxWWN4pYJN5rcvAHRUcgynxxVDPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774524; c=relaxed/simple;
	bh=LscoGqgvjS9EyKfVXT0o2401xM7VGLtOquRueXYlfGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7quBhnbGhTKYdrbyhYcDgaQ1vVHt+TVZnPk/ulx1+0z19aD4I56tqEWozk3wt8oMzCs8aE7GuSUPRBg+7Wox5u9lcjac63ehKjD63pgRDkRC0aDMAzx08jVcqfKvA8OcUMwUAEZVEJM6BvBrCmkr7ePYurEOal+cg1h++w3/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6+V8RDs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6+V8RDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769774522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLwB2G7Aol3Iav7v43ToW8V1IIb1NGvoSV5/VD2hgJ4=;
	b=X6+V8RDs6XEzFmdiux93u6m2cUfaFhF+FYWhRO+HJpdtT+gtNvx84nT6q0Vkay6/FOCSIs
	XERGtW8ID8LUXIyrkK0bWgcavhira4KRZTyef6ZowJpVlX20pHhr7IbGMSJiVMSepUt76H
	7tbRa7VL4etKrbT/qqQ8I8em3yI0THQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-94anEzJSOWmIB1R7TNHy5Q-1; Fri, 30 Jan 2026 07:02:00 -0500
X-MC-Unique: 94anEzJSOWmIB1R7TNHy5Q-1
X-Mimecast-MFC-AGG-ID: 94anEzJSOWmIB1R7TNHy5Q_1769774519
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7948fd222d0so30839947b3.3
        for <gfs2@lists.linux.dev>; Fri, 30 Jan 2026 04:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774519; x=1770379319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLwB2G7Aol3Iav7v43ToW8V1IIb1NGvoSV5/VD2hgJ4=;
        b=p2+NDvyrwy+CMKs7vCgM3UXq8O3dAPIXN2jG18OXjd59H9SAkI54oApxEdkBdvlomM
         MWqXonuv1MB1/Uu1FQiv3+ff6qdZkzkNU5F+SNre6Hd1vDtGFvbvm1V3A64KRvlnJ+Cw
         SbUEurCiFD1CP4slXGhLPrVqgpOTiXu4rUME4oxOO7Q54Wop1H2iaE5peYoIo/SdNa/X
         vtHPacuj5HdyUyiSyZgM4ZoFm/vTNrGZ0acmLNJF2u/wTYnRZgIzQPm+W45UmnDFcVpd
         RrKICLc2Zo6KXtXapnsMLSUsnX4GoAxBZWHNhcwE87BLQUQP1v5ZBilYSNRIyXZBXboG
         XgZQ==
X-Gm-Message-State: AOJu0Yxf/1Utf0/69WM+EFSpmRU/qWsicDX9CafcxapTnLE1bEo+oRv3
	GSkfOC7ptW4iijXyerRowwxGWw6OhqJb4n4ymUZILv7bGTgHf5RXTrQF+bLN4JprkkyXdlqkBDa
	MvCbJsZI7YSg1oLHFJhpejJysm66+fH0/GveUKCfryR8ZFXl3gmCN4BLHO0YvjqEK1hXrTD2SAQ
	y2wuuK3Mh1FdnctAaJH+s459bSq1HyM48UmFXGmMCM
X-Gm-Gg: AZuq6aJtjP2UKIBMMH99aTvvE1xBHKwQxRWxdVmB+9scBSGDsoXMJ1IiVCB6QbjYWgo
	8EDsjoFlhECLjGRh9lRL47dFH7ALqWG6p2R60DjME225KpT20vU8rTX+YW4qHpyBfTHIwcvZdoP
	UQMJif87CSI44qLCyQisO4vfjfGYdKmekSFFUdmPxGIJrTiUmS5rIuHsPiKQ2t54sJ12a4Ypaya
	ohL3s6wgu1hgB/sMTExJViSxDwqG0kTiqdHvnTQTgqQE9QxdlN5NA==
X-Received: by 2002:a53:ac9b:0:b0:63f:b4ee:7915 with SMTP id 956f58d0204a3-649a83a93f9mr2277137d50.11.1769774519148;
        Fri, 30 Jan 2026 04:01:59 -0800 (PST)
X-Received: by 2002:a53:ac9b:0:b0:63f:b4ee:7915 with SMTP id
 956f58d0204a3-649a83a93f9mr2277099d50.11.1769774518408; Fri, 30 Jan 2026
 04:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130092134.62407-1-kartikey406@gmail.com> <CAHc6FU4myfqhqjB=xxVh9JZWi=un4tWYKWRSm0YJZ6DRh3UTZQ@mail.gmail.com>
In-Reply-To: <CAHc6FU4myfqhqjB=xxVh9JZWi=un4tWYKWRSm0YJZ6DRh3UTZQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 30 Jan 2026 13:01:47 +0100
X-Gm-Features: AZwV_QhRS57MBX6ZC-LlxqW2jcOGkzFPNq39-v3_pVKmY7AS2CJf9Rrq4hAqS-I
Message-ID: <CAHc6FU7f3ffoma263VbQAowjQYoC1K6f_=Ubp-mP_R5pds2PeA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in iomap inline data write path
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edwWLEof3TWoehmsAw9Wro1H_4Jz0EZ2kj6ZkRqcY7k_1769774519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:33=E2=80=AFPM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> Hello Deepanshu,
>
> On Fri, Jan 30, 2026 at 10:21=E2=80=AFAM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
> > The inline data buffer head (dibh) is being released prematurely in
> > gfs2_iomap_begin() via release_metapath(), while iomap->inline_data
> > still points to dibh->b_data. This causes a use-after-free when
> > iomap_write_end_inline() later attempts to write to the inline data
> > area.
> >
> > The bug sequence:
> > 1. gfs2_iomap_begin() calls gfs2_meta_inode_buffer() to read inode
> >    metadata into dibh
> > 2. Sets iomap->inline_data =3D dibh->b_data + sizeof(struct gfs2_dinode=
)
> > 3. Calls release_metapath() which calls brelse(dibh), dropping refcount
> >    to 0
> > 4. kswapd reclaims the page (~39ms later in the syzbot report)
> > 5. iomap_write_end_inline() tries to memcpy() to iomap->inline_data
> > 6. KASAN detects use-after-free write to freed memory
> >
> > Fix by storing dibh in iomap->private and incrementing its refcount
> > with get_bh() in gfs2_iomap_begin(). The buffer is then properly
> > released in gfs2_iomap_end() after the inline write completes,
> > ensuring the page stays alive for the entire iomap operation.
>
> I agree with this analysis and fix. Some nitpicking below.
>
> > Note: A C reproducer is not available for this issue. The fix is based
> > on analysis of the KASAN report and code review showing the buffer head
> > is freed before use.
> >
> > Reported-by: syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dea1cd4aa4d1e98458a55
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >  fs/gfs2/bmap.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index 131091520de6..e70095809e4a 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -887,6 +887,8 @@ static int __gfs2_iomap_get(struct inode *inode, lo=
ff_t pos, loff_t length,
> >                               sizeof(struct gfs2_dinode);
> >                 iomap->type =3D IOMAP_INLINE;
> >                 iomap->inline_data =3D dibh->b_data + sizeof(struct gfs=
2_dinode);
> > +               iomap->private =3D dibh;
> > +               get_bh(dibh);
> >                 goto out;
> >         }
> >
> > @@ -1144,6 +1146,12 @@ static int gfs2_iomap_end(struct inode *inode, l=
off_t pos, loff_t length,
> >         struct gfs2_inode *ip =3D GFS2_I(inode);
> >         struct gfs2_sbd *sdp =3D GFS2_SB(inode);
> >
> > +       /* Release buffer head for inline data */
> > +       if (iomap->type =3D=3D IOMAP_INLINE && iomap->private) {
> > +               brelse(iomap->private);
> > +               iomap->private =3D NULL;
> > +       }
>
> We're not using iomap->private for anything else and that field is
> zeroed out automatically, so this can be simplified to:
>
> if (iomap->private)
>   brelse(iomap->private);

And then we've also got iomap->private leaking a dibh reference in
gfs2_iomap_get() and gfs2_iomap_alloc().

> > +
> >         switch (flags & (IOMAP_WRITE | IOMAP_ZERO)) {
> >         case IOMAP_WRITE:
> >                 if (flags & IOMAP_DIRECT)
> > --
> > 2.43.0
> >
>
> Thanks,
> Andreas

