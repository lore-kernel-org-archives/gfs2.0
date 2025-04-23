Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC01386DA
	for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425241; cv=none; b=Kv9QXB0etjnXZlli/4AiD1PiIzd21RxkzS7RuSlGnj1E1dBC5UoJtpyzEv01AwCiEFvBaW8241OPL4EBvpeqdesJiTCzynM0V9QfJhfZxSCW5kgo2+Nv1/Yr4fWscgoOFx6tBIchh4/PS+nrBui2Xo5QSoaOPx+Eo4vrFowpv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425241; c=relaxed/simple;
	bh=ZhMVYO8m095axBKxv2P+gGFjPb34TAyBfymP3uQH54w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqnC+pDUZrKgHu1rbMAmKkqXyiT5DtRNKAAr4tGSzm4wvztSsPX0L5F/bCKQgnIHmUNQpiqzqoKg0PpnvnjSZmLMSNIDGe0KjM9QSSoa7MsXPH1zj6UjcJQsBL4iGJYp3OjpAYTzGZ5GbuJxQ458iNkhWeLv095h4VCJaWtbXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGUr42dQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGUr42dQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745425238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOIsvx1Y4QVZ2l1yqESI95labD/vCw0DgsddiCIinUU=;
	b=PGUr42dQ/MTbhqABDY+Fk1RxzhW23gq+nIC33EsitG+q/H1fQZO9q90yRdJ0jbtsxl11gR
	f7Zdu24UcsfskHR0toqvIrz461CjramxYXXm+SUovzKasrM7XKU4Wh4Nacn6PcrmCvElrZ
	/sw5C/7m9sgSqFQOsJwZH5CAa+XCFrc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-dOBfDtIoNWuo45ciDAcmfw-1; Wed, 23 Apr 2025 12:20:37 -0400
X-MC-Unique: dOBfDtIoNWuo45ciDAcmfw-1
X-Mimecast-MFC-AGG-ID: dOBfDtIoNWuo45ciDAcmfw_1745425236
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225107fbdc7so180805ad.0
        for <gfs2@lists.linux.dev>; Wed, 23 Apr 2025 09:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425236; x=1746030036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOIsvx1Y4QVZ2l1yqESI95labD/vCw0DgsddiCIinUU=;
        b=bjBM1RTq9v1WvWA4snvNIJlZlGnrkLSuBzAeKwB3pfVEaDZmDwGkTQgYYgBmCVdyiT
         Qum84P8k/JdoCapDiNH37lsFrkMoed3S/tUWP/SLXld4OLLkiAoWX/jF8bRk+afajtYy
         EeVzOxD3SJJMGYUs1Lzex+rT7ji2gbvlNP+zqcZqvOn1DL9KXzJJwWPIih0VC9NjvhzJ
         nggN+j70mcpqsXcjQiWzZWHSZNoahHdF9HOZUQMm7Ow8J716XmJIhoeb1+oij/g9cdjP
         cxvDEOockpQLHGZLDAkAbvbTUDVu4AndvvqtJr3o1bDCwZQW0r2a3qg3mZpO4xIpAnCK
         QvPQ==
X-Gm-Message-State: AOJu0YxLrIZxL059AsIY+t8OVn9cbm0GadiNA+/lvrtO9pQyDabU/IDc
	6l7KHgTHaZEvoqgiP/F+VSynvyuZC+yo1a1pU3kt6t6jpwe4C4u+wH4S0yO/7UAvuYtRJYCNS2j
	p01AS9RPfCxba+4KB5GZ/DgNJS5P+3CXKhilWM7hcj3iyXdIGmTmnPAfc/PB8dWG46Df7M3o5XQ
	HvNIaJ9O+jUDzqr0KS4mLZN8hBNA==
X-Gm-Gg: ASbGnctvXPcCoezZKxYseikfOwpWmK42JtEXKnJz+fHCKQ3vXZVs1mFaE6Q7+bWAxEh
	v6MB+RfqN88gEGMVXeEAaXzeSojcSZ8vGFT1sC39LjEyJaZARSN2xsAFE4iPn4lKpRJo=
X-Received: by 2002:a17:902:f611:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22c5359e628mr235297605ad.20.1745425235959;
        Wed, 23 Apr 2025 09:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj+tQUUDizkucR7q4R4mirp2XdUb2UYANqOHpDF5FIBJ7GD75BOg9YH++0Q/uCHBan4293y9qz9x35O8rsdXM=
X-Received: by 2002:a17:902:f611:b0:21f:85af:4bbf with SMTP id
 d9443c01a7336-22c5359e628mr235297325ad.20.1745425235552; Wed, 23 Apr 2025
 09:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250422095407.1221362-1-agruenba@redhat.com> <20250422095407.1221362-3-agruenba@redhat.com>
 <f3b6e966-b0c0-43cf-92e5-3d3ef24f2049@redhat.com>
In-Reply-To: <f3b6e966-b0c0-43cf-92e5-3d3ef24f2049@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 23 Apr 2025 18:20:24 +0200
X-Gm-Features: ATxdqUFP4K5kWwXwM5ppG3kGR9UTB7jErgUhPyFSwpCDiSzhw5ZZ9L5FGzvD4ho
Message-ID: <CAHc6FU6TOMNXJbdhjDvOxoOkdXntApz+kGj8YdifUDE49=i-_g@mail.gmail.com>
Subject: Re: [PATCH 3/3] gfs2: deallocate inodes in gfs2_create_inode
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QHTV-oZW5qQnqwU20iXYjGEGYkqN0x2i5zwc3LvHga0_1745425236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:42=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> Something occurred to me...
>
> On 22/04/2025 10:54, Andreas Gruenbacher wrote:
> <snip>
> > @@ -898,6 +901,14 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       gfs2_glock_dq_uninit(&ip->i_iopen_gh);
> >   fail_gunlock2:
> >       gfs2_glock_put(io_gl);
> > +fail_dealloc_inode:
> > +     set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> > +     if (ip->i_eattr)
> > +             gfs2_ea_dealloc(ip, xattr_initialized);
>
> Is it safe to throw away the return value here?

At this point, we've already encountered an error. When deallocation
results in an additional error, the best we can do is report that
error. And that's actually what gfs2_evict_inode() does, so let me
change gfs2_create_inode() to do the same.

> I guess it probably is if gfs2_ea_dealloc() failures always flag a withdr=
aw, but it's difficult
> to check all the paths.

It's really gfs2_ea_dealloc()'s problem to trigger a withdraw when
necessary; not all failures lead to a withdraw.

> Andy
>
> > +     clear_nlink(inode);
> > +     mark_inode_dirty(inode);
> > +     gfs2_dinode_dealloc(ip);
> > +     ip->i_no_addr =3D 0;
> >   fail_free_inode:
> >       if (ip->i_gl) {
> >               gfs2_glock_put(ip->i_gl);
> <snip>

Thanks,
Andreas

