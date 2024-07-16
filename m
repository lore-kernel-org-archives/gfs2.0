Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922419A87E
	for <gfs2@lists.linux.dev>; Tue, 16 Jul 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135427; cv=none; b=YcZuMSgYj0s/3QZ83okOW80tnAJkLFlMCjMqxgw3pZLlX9Yld1OnMd7p77x4+pcQ7dIkUPXX4bMxaXOd2TL9YgU0h4QqCDf5wjwocqsI0eDNYGtsorQaGu4NZtTNbrnNm8kNTdf7gqsRr6QG5MTQMGF58oy2HTV2t/sFfji+Fnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135427; c=relaxed/simple;
	bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdiXctaPT9cYYRpqv4yY834uRmyNGnFFaYJnHkwLdTdlRtkILrclleGRZn/nxcXleMVnVCJgOT8Kwt3Mo4bCKNeJaEN0cI/knOFdrYrwPa9u4rf9lBub0jyr6+8sGLfsVv7el+0YyoxfmsT0fuWgtr2C36RyJqxhR/ndp08iIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdzDU6Ym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdzDU6Ym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
	b=MdzDU6YmnjxA/BPqN4A2tzroMnRW/HfclIMamTDJePpi0CLfSAY0ktuam55nXCexxXUeDq
	5gMxqk3N+UESaSe0AfSrws2iw/Aq/ZjZ20JPicSvUPPxjGLKEhQfwkr9FjtLEZodDipz7b
	eD8AkDprwf2fVKKxBbjea08cvy7TT2c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Wvx3yJ7jN22kaA4xImMuyw-1; Tue, 16 Jul 2024 09:10:22 -0400
X-MC-Unique: Wvx3yJ7jN22kaA4xImMuyw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52ea1a947aeso5681304e87.1
        for <gfs2@lists.linux.dev>; Tue, 16 Jul 2024 06:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135421; x=1721740221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
        b=Mya0YX7Ps6Xr1oHmgmfqSvuwqva33xvriId1L7nHBp2xVA0OiSqFE7Huxcv+b6zLg5
         3o6Ams8Udfd0ORwVMLxSnOuXBwkhWSbEplyntMTHfFcMFprT+WqIDuhzvEp9QAKCK1Nd
         w9cDmhUS/9pCiflS1eKIJAZWXG9HMGQ8DQhhCYSARI+rLAJnN+YBSOa+VF9lzsCjLcH1
         0NK/ZN5ocdfUr17dPMytQVi4wiW+xAO7QoZZ0y0frAv4Asu2DpDeiCLt/f24FfljgZuG
         rGXkJqmeug3dqDm4/IA6rEwVURt/VJUOumWmgYXNCUz9jRvGKXxRKtv/zb0xuUGQixPf
         ewJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhzBs4uXNrgYTsnz/WEBS0WGQub5aJgZTR7/1AMdY0ndjE6s/7oCGSmJBozXquM2OsJs0ipWIAgkjhoqvNfanOu6NwHA==
X-Gm-Message-State: AOJu0Yy5tB0uMAYgGTzBp9JfVmaZSBWTtHYDp/mbhIhB0is8cr1HbtE+
	tjxro6Kmfo7w3QZngl1U+Y6DNX/zz6MwmK9HPimoaLaYG962Q4C+g7/LvFbVHpF8oCYLGBYGdM0
	XvDBQ/enhl+q0jBbt9h3o6DA3B+T99SKA2xgnolto1qCzmkURgeOnJu7pIkzjeJ3K7WEFCGn7x4
	bZ51o+RTL526O7JRsCFV0CoWtIIg==
X-Received: by 2002:a2e:be05:0:b0:2ee:8b92:952f with SMTP id 38308e7fff4ca-2eef40b2fcemr15945951fa.0.1721135420994;
        Tue, 16 Jul 2024 06:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0+2ysOJp9MP5ZxmZgy3Wn0oI5vGQOyK2l9FcQNTEYAB8b/kz09NzAswEUe82pE7C4WMswef/74L9f5BSYjlo=
X-Received: by 2002:a2e:be05:0:b0:2ee:8b92:952f with SMTP id
 38308e7fff4ca-2eef40b2fcemr15945781fa.0.1721135420605; Tue, 16 Jul 2024
 06:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
 <3353d6c1-54ce-46c0-8b65-a0383c8da324@163.com>
In-Reply-To: <3353d6c1-54ce-46c0-8b65-a0383c8da324@163.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 16 Jul 2024 09:10:09 -0400
Message-ID: <CAK-6q+gvhDSrzUyHB=KAw=hMco5BAHxbXuhVYLdzHm12JEJG1g@mail.gmail.com>
Subject: Re: udev kset_create_and_add() with own struct kobj_type?
To: Lk Sii <lk_sii@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	David Teigland <teigland@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2024 at 8:15=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
> On 2024/7/15 23:27, Alexander Aring wrote:
> > Hi,
> >
> > I am currently implementing namespace support into the fs/dlm
> > subsystem. The DLM subsystem uses kset_create_and_add("dlm",
> > &dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
> > Underneath it creates for each lockspace a subdirectory using
> > kobject_init_and_add() with a non-static name and being known during
> > runtime.
> >
> > Now I want to add namespace support and need to change the "default"
> > kset->kobj.ktype =3D &kset_ktype; that is set by
> > kset_create_and_add()->kset_create() to my own kobj_type because I
> > need to implement a different ".child_ns_type" callback before
> > kset_register() is called.
> >
> you maybe use kset_register() instead of kset_create_and_add().
> you maybe find example codes from below kernel files:
> fs/nfs/sysfs.c
> fs/f2fs/sysfs.c
> fs/ubifs/sysfs.c

looked into the first one, it looks like potential new users for such
a new helper. This is what I am currently doing and it works, but I
mostly copy&paste the code of kset_create_and_add() just to set a
different "kobj.ktype" in the kset and feeling bad about it.

Thanks.

- Alex

