Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BC309DCF
	for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343146; cv=none; b=dZOfSwHz7v8nYzJKW69cgJOf0aBD5oBI10tmegefo9xL4Vw2efhHtkjxK1lK21GkGLH6zZishRS0kYKQJn/q8Vd/rEQ+y17Lp75FlMjyFZItO1gE24WfbppqDouVMFptgU7P098dIO9/BvBtDRof9Cg9JBwZ6CAk/17DyFqqmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343146; c=relaxed/simple;
	bh=mxdDRl5f6ypVZFwxoiySjpzvSm/XaHmi9pbQ4jbflIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/PjDwEkLCIBvMY2sbzr8C/wiRsTWfCyuucglaLAfPAwyEVYrTEm9eJzzopX+PAEPZjU9V6zET5dhdZcaTTjTs2aHoO8Dj76Juk4BER2sr6JWvxCnH2BklVYwifVmwpvdca0iHnGsnLn0H8/qZFjCwt0ZhIwKwhFekALubJwq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+2ZUwgS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+2ZUwgS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e886550a26so11694901cf.3
        for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761343142; x=1761947942; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=U+2ZUwgSO9YHnkmatXcBRyZ8FWGr5tRNSVWAkRAq6uPn3Q/GIpaBAVsgzuVU/35D8Q
         GOatnPO0gk2pCkyyWXrJqWVwpFxiohVSePTcPAz/PeOcyASpm195iMrdRNej5QFA7lhU
         0ZiyVStRxGysQHpYVhmWHTtsE1gfsinSDwgDAcClji4XBuenGfn6Dxj+LQto1GbX05SP
         /l5iyKQFUWxMiGtLm/l21FwA8FVvvUW+08adzLMlJzxnTJs13zZnqpBbgHZOARsJTl71
         M2rrCjDYcq6CQtAfEZJPkpot7FFrs5x9h6yDt1A2SlMVqB5zJIsQSMnVmsObI2EwLb1H
         xOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343142; x=1761947942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=sT+zG/QoAQ42polZoRGp0APU8TZmNEIG6VdKAusZmYsDz69KAkTWXHvKLOz96dHJ4T
         KlzA8KX9FUgPqw6O57F6yHfIV1FdWlbdlA2LXnm5er/XGKtRRg2En54D46AV+SsVII1W
         YwXWTyCAxXZP8kOSPAbR1iKIf/iBZTYc2DoUwvZ7DNIVmS++Fi+tgSe+ZUa06UbOkyYf
         wzs/INWChscnZqSuHaBj02Um8llln3tAfp5Cr7e89VaX0YHyskxMm19shX1t2f7bS5du
         YCsV9OUbIjXZqknqBLtAfGrw3RzLQleLMq58smtsrYy0bSKXWivTtL+mj0S49aGm8ixn
         N/ww==
X-Forwarded-Encrypted: i=1; AJvYcCW4nykfbXnlYX2O70BIwAVkidu1hlXsfTRVUZq5zKUAVKI8cMs6deOSOCpaPe/333FaCDQN@lists.linux.dev
X-Gm-Message-State: AOJu0YwVprHc1CzeazdrViiEg1sCO0ty2e6nL4eFV21yNKXs+yXp4iJS
	HoqtjwaiO53920p6cl8RX/rTNEXbXLmdxW0g3Vjj9uNKpAZ2cplxEQNgvD61ilWVY+DJNcbRX8S
	vaV3iqOwW3bgC5Ce4YJRV37THZ5Z2QJ4=
X-Gm-Gg: ASbGncv1IjTCGc3tMzhWi/gQgwzzImX2xGtVK3vsbWxokndL/s7w5N77zZnopsAYmzE
	lJM6/3k7r8iPmKWPy2tp7AAGIb9sH060gbuSMK3CPR+XocT2k9dXK2cZzonxll13EBBXRaCW8/Q
	pFr0pq2uvi4o5Mr8P0pjQBp0kVin5AWKflRXcQCqlaq7qgbQWKac1VUqkv0T4662p+vWXmoFkMA
	2C7gPt8ypJomnnOY3Tn74nZ3dQuJf7Be0ipg7Yp+FqzlohsKIcUxaAp4EIh8zOF5VeHyv44gZ9+
	64PHlbrautHFqao=
X-Google-Smtp-Source: AGHT+IEbBcSwdHcN87CM+xJKbvHNa6uFwmLTJi2BasWFhru45dH++MGND3s6/74r0tI8E8W9g7oqhkLME3Y3cb4B/Bg=
X-Received: by 2002:a05:622a:180a:b0:4e8:bbd4:99d8 with SMTP id
 d75a77b69052e-4e8bbd49fd5mr247392271cf.37.1761343142321; Fri, 24 Oct 2025
 14:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPu1ilw6Tq6tKPrf@casper.infradead.org> <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
 <aPvolbqCAr1Tx0Pw@casper.infradead.org>
In-Reply-To: <aPvolbqCAr1Tx0Pw@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 14:58:51 -0700
X-Gm-Features: AS18NWApxbcNiaK6JJ1--DN9zMQLqfqvI7dAP8Den9ypsz9jSVcP9ZxOIt1Gw7w
Message-ID: <CAJnrk1YZoFSMGHRK0M_=ND1RyXPgc6Ts4hh+UMOkrGqO5G884w@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, hch@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Oct 24, 2025 at 12:22:32PM -0700, Joanne Koong wrote:
> > > Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> > > when testing (excluding performance testing of course; it'll do ugly
> > > things to your performance numbers).
> >
> > Point taken. It looks like there's a bunch of other memory debugging
> > configs as well. Do you recommend enabling all of these when testing?
> > Do you have a particular .config you use for when you run tests?
>
> Our Kconfig is far too ornate.  We could do with a "recommended for
> kernel developers" profile.  Here's what I'm currently using, though I
> know it's changed over time:
>
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_SLEEP_DEBUG=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_SCSI_DEBUG=3Dm
> CONFIG_EXT4_DEBUG=3Dy
> CONFIG_JFS_DEBUG=3Dy
> CONFIG_XFS_DEBUG=3Dy
> CONFIG_BTRFS_DEBUG=3Dy
> CONFIG_UFS_DEBUG=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_SHRINKER_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_DEBUG_VM_IRQSOFF=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_DEBUG_LIST=3Dy
> CONFIG_X86_DEBUG_FPU=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>
> (output from grep DEBUG .build/.config |grep -v ^#)

Thank you, I'll copy this.
>
