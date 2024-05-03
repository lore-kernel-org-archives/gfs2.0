Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90C210FB
	for <gfs2@lists.linux.dev>; Fri,  3 May 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763072; cv=none; b=Y68oBeKm0spNOk1OnemMdpSDOpsaJbittosK+pL8v95eY2nn4v9MyVNBLhPxCMISaMA+aLt4mDREhqgY+owDYqrzg7gIe3ruY9IDfA8BjNuxEV4E0s1JfjhQT+tF1nY6+GODT7UdA6l7p4z0uVpJS+gwDwfqCBS5VL/CtSKch9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763072; c=relaxed/simple;
	bh=VlYGvg30VXjOnYOnvFtFihmydrnqz0GOaYXR3PXcftQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKqR+WKJqprS2k3DoeVUOBCX81lQ/f0d+gwfo9zT61Xakr5uppv+F/f24ceNIZbaasR4i2BHJvv+4VrEHAUppkyvOTV/cZELw8rYHI/h0/EiyA2Y/ultAZvoCqdhEWVM6TxvzW+UpjSI6LoS27DLWZPUyvmhXDZJxH98ArLQeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa3DKrQ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa3DKrQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714763069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6ovhXrSwasBCa/uuGPOrNPHzs8EL5HuNVawLpdIDNM=;
	b=Fa3DKrQ8/2wWPAakNpwJMpjp828p0FZuiYd+3xsUskho213g/MNROxfrnhAM4sgyoTNnYV
	OLF6F9EvqA8zsM+oGj/ctS7KXJbpP33pzsQEKU+2UhwiEacvCnf77Jdnh1mP0l9H/e/jTb
	Y4t3ZOVbHO3/R3Y3gEoqzrJ7MIAXVAY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-k3jJVE6UOWe8WELIpab5EQ-1; Fri, 03 May 2024 15:04:28 -0400
X-MC-Unique: k3jJVE6UOWe8WELIpab5EQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso8307647a12.3
        for <gfs2@lists.linux.dev>; Fri, 03 May 2024 12:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763067; x=1715367867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6ovhXrSwasBCa/uuGPOrNPHzs8EL5HuNVawLpdIDNM=;
        b=tBQfL4UFYBLdWzpEY7OEtGm4trGG7+dpmXStxflbSN48PX/wIW6YdwKDV4CTtuO7h5
         ZogHZUz2Kpvlw8A3dCPQ9ytNSSl8BZZaijDdvJBwjewz7SGibF6nudpIh4aGi+3DYJo2
         zEyk0frIrTeTP2+xyCgrYI3ynjrDwudkPX72xoKwXKVcC65NxspdOIgtV3eqMpM5ztoQ
         YMR8KuqvCnycVZdR37/Xw1euX2U4PlRVh5IOpXvsxpYr37tAGOvlXgqyfX0NM5OFJo50
         hX88ueQUVFCMFBcK3ZCBa2I3E4rkX6XJffASXe9wunwH34Lp2vZGctbRAM4HWEQhfg8x
         /c5g==
X-Forwarded-Encrypted: i=1; AJvYcCWFLeQvxEm+wOIfIkIe+88KE5BXasqoK6eG1k/3MMdJFQmHUv7tW4cmlDjk0XDS6/z8UkGEtPZ1H12DRl6gG7ANThAp7w==
X-Gm-Message-State: AOJu0YyKZRRvYpD2pq9d9+7Tjz/PMg0RW002S9lOwbq993a41MpBIs/L
	C7rxP5Lvr6jIzSmNrj37Jv2r7uHRSvpfAhzIx6CWRqXzhqKppsSdJ02siCcB4pzZyTZmskDkcYg
	mFOJ2P2wdAhGDFCHm8EZgFOPL+VPSaflPAqivYnr7JzPXQWEmhyM/PTF8LaA99LYXv6XXWiQb/l
	Ya0x4FB18wfpPMXxnpJYuZKtHXMw==
X-Received: by 2002:a17:902:db04:b0:1e0:b562:b229 with SMTP id m4-20020a170902db0400b001e0b562b229mr4212425plx.47.1714763067194;
        Fri, 03 May 2024 12:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2FgJeIsYYkRQ3inPysisa/T31GJfL7VK1Q1r8SBkYFgkFKg36TVOUAeigYb5lnnmZ40CoxuAdAcqC+HyAx6E=
X-Received: by 2002:a17:902:db04:b0:1e0:b562:b229 with SMTP id
 m4-20020a170902db0400b001e0b562b229mr4212404plx.47.1714763066839; Fri, 03 May
 2024 12:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240403172400.1449213-1-willy@infradead.org> <20240403172400.1449213-3-willy@infradead.org>
 <CAHc6FU6gdBq5+GYqcxUEfvypTokAsoGWSEt19jJUyBpVXW5myw@mail.gmail.com> <ZjUtSAxhcMnQ71fO@casper.infradead.org>
In-Reply-To: <ZjUtSAxhcMnQ71fO@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 3 May 2024 21:04:15 +0200
Message-ID: <CAHc6FU4c6+Bz+1fzj-anNGm8TQhvLSGHMnd37S58kG_FeM88rw@mail.gmail.com>
Subject: Re: [PATCH 2/4] gfs2: Add a migrate_folio operation for journalled files
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 8:30=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Thu, May 02, 2024 at 10:23:41PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Apr 3, 2024 at 7:24=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > For journalled data, folio migration currently works by writing the f=
olio
> > > back, freeing the folio and faulting the new folio back in.  We can
> > > bypass that by telling the migration code to migrate the buffer_heads
> > > attached to our folios.
> >
> > This part sounds reasonable, but I disagree with the following assertio=
n:
> >
> > > That lets us delete gfs2_jdata_writepage() as it has no more callers.
> >
> > The reason is that the log flush code calls gfs2_jdata_writepage()
> > indirectly via mapping->a_ops->writepage. So with this patch, we end
> > up with a bunch of Oopses.
> >
> > Do you want to resend, or should I back out the gfs2_jdata_writepage
> > removal and add the remaining one-liner?
>
> Ugh, I see.  If you could just add the one-liner for now, and I'll
> come back with a better proposal next for merge window?

Sure, pushed to for-next.

Thanks again,
Andreas

