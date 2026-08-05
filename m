Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9263B8BA5
	for <gfs2@lists.linux.dev>; Wed,  5 Aug 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951736; cv=pass; b=GdekZcPlmIgYq1dU41/KpkovfG1MyqKEWlKX65S6arBmrmxnkoZQpk1D63/pbqYftL9JX5I+B06FmxZVM/XiJabDq1vMawAGDJVAzclREOs9Qj3x3lzUOVqteo+6zdVsQb7hmEz+oBGg8BfKboxWO3kaJqsnSMaxXD4g2FouEe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951736; c=relaxed/simple;
	bh=EyaYqKudXSYNb2x8/wPi+3HpDy7w6KyE/JUWlmLyn/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVlj8Qc3ceLwElz09N1BQcTZ/1uXpo+Ibgm/YGt1GcbKXR3cm9ZN9PPZCXetHD6I11x+S4AADgJZOKOXg6jXn8ICviooXMb+8p2eDDgbdDElbGt3+gGiwU264WVYI2e+hB64oOrGMKFFdfEgv9i7lLN2In7SOVdRfzsQWsbfzMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coG4oOB2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coG4oOB2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so161900a12.1
        for <gfs2@lists.linux.dev>; Wed, 05 Aug 2026 10:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951733; cv=none;
        d=google.com; s=arc-20260327;
        b=qkFBCeLVI7pLlKt5lkDpS66sP6Uh8k1i3kPiKkaINx2L8Sglok0IgYWUQt4jPG+zGU
         xn1zlch6/upDgYNaq8M5XylSj+LOM6CE5xPf7YLIkW8DGwgPJBYUIUxQ34PUJOjFGkm0
         SJVlQJ09F4tXKJ05nTWliCbLN9ljc3g041plMsETIt3LI3UoCcBIoZCYF3zSIRA0x9al
         MrR1AQTWpi81bb0ydRfe8iDA4l8q2whOymSaQeLp5eUaDWR4tMK4L8OXn5F1940riinh
         RpWNmofDghkHWLAfnxw9Lhz7+8C1uh35f7F0z5AHYkmGgDkX3wcOxwJJ2uRB5gs3zaPX
         3j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXreRkBEGbHPBEEBrdZNIuUhCIMHTazKQC4iCv4R03M=;
        fh=+IYD8+TaLDmwhGIL9HhKpBiREmrCLlYoljbMV55f1JA=;
        b=UdwCDOvHpTkJdonb6F2+y6ZxUmxuY9bBslx1H5JWbqtk5ofSsVJsmFnbYlPzOZNytt
         smhabS29gfJgb/+/jkIe9+a8DUio3r50dh3z1p710OSZ/YWXkXH6OfL4FYm6/t8yQNkZ
         FCS2HM/jQURbPTxQHX7y2jUceowOkEa8kdjKhsNGnFvFqLSEoVewnFGYlzRwQ50kcX//
         7FGw54EE4hAvFvS82ZPrFMdAmFkmJxscWbONR/l9a5W+/6s1yxq3/oSnK2Uwxq9rsCa0
         ipZNMEEKCTXHOt91GimpIQXEHpFyLT7mJQ+1a2+UPj19lnujXijXyumBP7XUPy1xpWV5
         HU/g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951733; x=1786556533; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXreRkBEGbHPBEEBrdZNIuUhCIMHTazKQC4iCv4R03M=;
        b=coG4oOB2TpWBhsiHkQYLDFvPMmsPNLpXhTxsGWtiiN2DeYx5dy6J2Wh9dU0p4CUwj7
         6lmDz2/4B5Ya3YBbD26g8/DcJvT677LXWuFdmGPJ9mRwyHXh2EQ9UaXYSp63vxrUY5nR
         SMP4ac1p6EFsm2f4qeI62YlmSAQ6eseCjxWo3WdaFfD6/lO797/0LYH6s0iFfapUaAIl
         JkQZPL2He6X/kw35iblNGBWSbu7uDScV5gF/JSjZksEq9xObw5UjJFI91C1LqQGPgNSv
         gxSe8D9z9Ki/JqnGC0/RNMx3jjNjt80kBlE/ZXr+cBPP3dRS4jG0Qix7KzOdXWG9/nrr
         DTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951733; x=1786556533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXreRkBEGbHPBEEBrdZNIuUhCIMHTazKQC4iCv4R03M=;
        b=HNUc303o9lA2ipnCPLbMnfdAtt4r2IAuFiYBaApkaiNiNeIHkPzFfi1vjwR+zLQ52K
         xPIgxveCig70rTmo+m8KI4clm9OVNg6DqssSHCDB1ZT53zCLkJyfhulgcTP/tkCl7zJI
         a0eLV17UC0cfps87eJ23YeoNotpHFIl3OR2L4NILabxp+BvOleRjDr48TXHDOB/wErml
         /YBQFI3QbA+H6k3/YAFpX3WduC8YBx6ZHTxrnF3UZ8mPWoX0yjcL5AKFG4MqK/bHUGKq
         yz08X43HPMbT15fCzEbVj/H0+Kwiv4xKJpW6he2GQk0gErePpF2qUXA1qlDkQs57NxfG
         Xihg==
X-Forwarded-Encrypted: i=1; AHgh+RrWDr/2iJOoucCh54DMfVmjn5z4Cs9jlsf1GT8KBQWKJM9FXONN05M3e3ylIet+OgGfM4GT@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg/o8RhtcAkZcoEIFIfrTxWKtkX8Mkt2j8zSsEezOdc1lPWTG2
	QjINLYBvkKOtkMnjXXTocECfcR/bi4hP94ABWGeClUoEF5K8QGphlKezNoZNGs/Wl3ZOSznS3aF
	ntRVKaKXjdAi6nKNEUCs8Dja+071k29A=
X-Gm-Gg: AR+sD12ctxzGTXDnpCaLLdWODIWepAIAXxeYvBJbq52D1GJwuPXYIdCV7VEF0uH8l27
	qxEbWfzPrGT+rFGNRYWG78ql3CjJTdR2xbr8qqdfBHy3u91XlUvYfigWFRNMQeRC+rYbsIvA0j+
	CWbiQyIzTbPMUNJTBwJ0LKszA5zsPBZ4jT2MWWm6Mjvy0TcaC3hNY3gZeV+JJcp+VHsWBbghBUV
	bK91tZjrNdD4UD3pSec6K6HWV95TPiNM3/sTbF/DdQr6v6mWPY1MjNe4POZb3HVS2XVW/b54Vvg
	CfNXSEedjJN4ToeLdADjxMgmQMvP+r91GLZgiwF1bqgP
X-Received: by 2002:a05:6402:4586:b0:69f:c929:b88 with SMTP id
 4fb4d7f45d1cf-6a18f0a9fbdmr501901a12.5.1785951732581; Wed, 05 Aug 2026
 10:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <41c6fee66724e374d4682124a1eb80041e22efb9.1785621505.git.coshi036@gmail.com>
 <z5jfe6bsxhgqqgjtxcm7ass2fslc4ynizvpmzlqxtr6rrfaopu@fxzntlxafmxj>
 <anDW5UTbF2d0EQmr@casper.infradead.org> <74ts4lwsq73mce3rvc7imisot436742ykzahnogysnbklot45b@q3nhfq55knx3>
 <anHyBATDe8yQEFNi@casper.infradead.org> <CACd_6n0zcg85_p=+dcVK__SECdom8K01BBsdzakuwJ1ibMhKJQ@mail.gmail.com>
In-Reply-To: <CACd_6n0zcg85_p=+dcVK__SECdom8K01BBsdzakuwJ1ibMhKJQ@mail.gmail.com>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 13:42:00 -0400
X-Gm-Features: AUfX_mzn0laRrr3SVV705RV57FVYpzTyUQWOE8QEtN7_m8lMA0sJaYZzNUqNq2w
Message-ID: <CACd_6n0hCFbEnJwKbMoR5qxdQoRoicKA8OE+Th6HshkL-NiKsA@mail.gmail.com>
Subject: Re: [PATCH 02/19] buffer: allow a buffer_head to point at memory
 outside the page cache
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correcting myself: it is not the kmem_cache pointer that lands at that
offset.  SLAB_MATCH(compound_info, slab_cache) puts slab_cache at word 1,
while ->mapping is word 3, so what a slab folio has there is slab_list.prev=
.
Not an address_space either way, so the reason for splitting the patch
stands, but I named the wrong field.

Best,
Chao

On Tue, Aug 4, 2026 at 7:06=E2=80=AFPM Chris S <coshi036@gmail.com> wrote:
>
> Agreed, and done - but not in this patch, which is worth flagging because=
 it
> is not obvious.
>
> folio_mapping() is doing two jobs here.  The one you are objecting to is =
the
> swap cache mapping.  The other is that it returns NULL for a slab folio, =
and
> that is the only reason this path is safe for jbd2's shadow buffers today=
 -
> they are the slab-backed buffers this series is getting rid of, and they =
do
> reach buffer_set_crypto_ctx() through __bh_submit().
>
> So doing it in this patch would leave one commit where shadow buffers sti=
ll
> sit on slab folios, and this code reads folio->mapping directly, i.e., ha=
nds
> fscrypt a struct kmem_cache and dereferences ->host on it.  Fine at the e=
nd
> of the series, broken in the middle of it.
>
> v2 does it as its own patch 4, after the jbd2 change.
>
> Chao
>
> On Tue, Aug 4, 2026 at 10:07=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Aug 04, 2026 at 10:07:39AM +0200, Jan Kara wrote:
> > > > Yes, agreed.  I think it's fine to add in some 'if (!bh->b_folio)'
> > > > tests, but only where they're needed for the occasional consumer.  =
This
> > > > really is a rare (but legitimate) case.
> > >
> > > Yes. If we were to write this code from scratch, I'd rather push for
> > > forming and submitting the bio directly instead of trying to bend the=
 bh
> > > layer for these temporary bhs. Eventually we might want to do this cl=
eanup
> > > anyway (since bhs don't really buy us much in this path) but not in t=
his
> > > patch set.
> >
> > I think that would be better, but it is out of scope.
> >
> > > > > >  static void buffer_set_crypto_ctx(struct bio *bio, const struc=
t buffer_head *bh,
> > > > > >                                   gfp_t gfp_mask)
> > > > > >  {
> > > > > > -       const struct address_space *mapping =3D folio_mapping(b=
h->b_folio);
> > > > > > +       const struct address_space *mapping;
> > > > > >
> > > > > >         /*
> > > > > >          * The ext4 journal (jbd2) can submit a buffer_head it =
directly created
> > > > > > -        * for a non-pagecache page.  fscrypt doesn't care abou=
t these.
> > > > > > +        * for memory that is not in the page cache at all.  fs=
crypt doesn't
> > > > > > +        * care about these.
> > > > > >          */
> > > > > > +       if (!bh->b_folio)
> > > > > > +               return;
> > > > > > +       mapping =3D folio_mapping(bh->b_folio);
> > > > > >         if (!mapping)
> > > > > >                 return;
> > > >
> > > > Do we want to call folio_mapping() here?  The only case where I can=
 see
> > > > this being useful is if we attach a buffer_head to an anonymous fol=
io,
> > > > and I don't see a good reason to do that.  I think this can just be
> > > >
> > > >     mapping =3D bh->b_folio->mapping;
> > >
> > > For all I know yes, bh->b_folio->mapping should be enough here. But I
> > > thought folio_mapping() is kind of preferred to open-coding?
> >
> > It rather depends on the path we're talking about.  Looking at the
> > implementation of folio_mapping(), it's actually mildly dangerous
> > to call folio_mapping() in this path.  If we were ever to point a
> > buffer_head at some memory on a page in swap cache, we'd get a pointer
> > to a swap_address_space.  I think we'd safely crash in that case becaus=
e
> > mapping->host would be NULL, but in other contexts doing things to a
> > swap mapping would be quite bad.
> >
> > So I think this should just be folio->mapping; don't risk getting a
> > pointer to a swap mapping.
