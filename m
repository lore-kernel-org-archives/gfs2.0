Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6455625EA
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996286; cv=pass; b=Pi088meLBXvvg4jSlfJq1QF50x4RoUkVpyxuN5RDY4563/QYQ8mINr2+79IZjMg3D7EncgY6xUPNSFZiSLAUyPY3uOH3JluPb2NxEkYYLbQVKE6ZfgVWeu7Q5o1J4/uJ593lSkooLg59TkraOVRzSPaL0ei5lQ1ZR/iAGx7ABsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996286; c=relaxed/simple;
	bh=aCsxctc/xcnHv1pMHQu5CMpv8HUZNsqkMA91yRiQJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWR06swWaT2Nf9YeN/UIZ+tmroWT1foqy2wzA7RRmHfEB1YO5u2P206F35m4YSofCTP2zbDLud3XQ9XqPvWlNOqkD8XpJLcOI8Jg/Z3xDBiJuXQ6bBOLFPjcjku8Hhy62rse0gqjhxEao2QoMpiLUIqPr0QpETAtRLiPKqWDFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHCdWONi; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHCdWONi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso41009385e9.1
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996283; cv=none;
        d=google.com; s=arc-20260327;
        b=Gq03HpLeseF/PHXiw+1HIgERPlUFcWV3AsX61RLtfB10LTKURwrqfGCNRXQXuqRENU
         0MQusp8BZTlxd4t+zmFwzB+lDN8HpwRUbV+M6VNtbcU3xy9e4h1xPYU/751Ea1JsRu7l
         9GZjcSC963S0IEkI/P76bN1rv8VjKa3Qg+BTkn3lZHsgulOqfvUOthScIsg4/DL7acpS
         vA0hy8FYDwc/YMHSSi9zBJPyAQEixIQSRmRjk3cY9k3ucuZClfYj9i0ElX5EPPLWxeGV
         FurNR16lCE2oAkZ/JeyaEwwm3KeMdaQA/rEQx34f42h03g//JG8i8ufOYDYIu+lHxXav
         5/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=tUx8Prc5n8Ut3qvrxWsbpOHN4f8l55y3kqYg/tcL+dc=;
        b=ns+8CcijS4b6AyF55nFkMYVC2CpN3OsIK4mrAnRcGLOVHEQXpp/P/E+sFG/zcJ2fYg
         ZU3dXDs3o4nVfRPBBdFXjyM/r3aff/4070kzdEwl9bZm6OAneSB1+40Ab1WXGk5SwCkz
         nHfuq8AiHmaHWb+tcexaav3tk8dzvKihEjokMEJl03n55iiogW3X50GfX48TD50+vHvY
         DiekOiKxa0/fBsyWZOIY63Q+0ywE6ik6YqU71SV3k4rNJNgjn0XiPjDZV0a02oo/7DGE
         Tuhl8wW/jzB5lB4RAVg6Hvj6I1PShRW4teGpQoMRDiSFJcFcOMYqsIkobXSrWIJa+Bco
         LgeA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996283; x=1792601083; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=tHCdWONidYFLf/5JJ4O5xvPMJ/ULyez9anuE1DWBjid8ypUoFMFHn+rkdkv2HPIWt8
         4uKt35aLjqBfWC6RfSUsl4RE+Gkzsm8ShSOzy8pqCbEmU45R8H8Ru4RvCadkk474lKyb
         R6mByCbBO2VOZ4fr9xu9bQabzHRJbNC3VUlNy/7zx6KoZBNd9RzDpul0DeVytNI1emq3
         CU6SHrZxz7tn2rOh5FHvUa4S7ap3C3/6GFOIIRkwX69oeH1Ym/gjchAN6+MNwD5M50OS
         o1NTgyt0uPGo36E+c1blwJahGijGf090albuEe8/T6DCJ42AsKOY9jc1E9s9mSF4nFXQ
         A28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996283; x=1792601083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=HqeL6S9h+QR1GLgTS0kMZjLD5/NetesW1xYxAtefdXRw2fuF67lFLV2qgdDtzBzYRV
         tFrXPfjdi0CGb63mQKrySZ5457pfFw3UxLGGxTEzHe3Z3V2QuVed5th0VY3rQ6gY+E7P
         0wmrPBfyBtd9WqJMfs8rnwARaq9Au7E6kk4ygQ6fUs35pOt5a9jtfESrKssdL9dbuNrJ
         3h3NxY5hP8wqvplThbcAmnnaUlW7MxMFFrkOzjSvqXzZi9W2E7Rgs/hgqNQ5T9qPv9o7
         fQt5cJrOU2vAr9KGDUtqWRr8mL8RIq51NaiGhlFBm3HD6U674XF8oObb+vnZjx9X++Si
         YEOA==
X-Forwarded-Encrypted: i=1; AKwUvBwZEvstk/weqhFjahi1eA7hS/H20yW6yStrStCjpXp+g0D5C8MLswwOgB/wgT0v80YIZeAf@lists.linux.dev
X-Gm-Message-State: AFq9FYIzhjvIm4x+3UZ3TkmnUz+n9xjzNHE75ADF28E22GC2ADU7QwRi
	70uFf5OV6JuZIEG5Z4l6c5CNH2u0NIRBCq82roD451Bj+EwK7uWKRAcXls0BNZL0pzxgVcGPboL
	YAfy2b9nPyV7Jj4HjPy9P5sLLvEksA+G0N8J8ay46
X-Gm-Gg: AYBFou1F+9RKydiT4P4QRj+3LsP2kQ7ZixcfCdl1RhmLOAin9Xh2Ite8yo9O1X7aSVE
	5qh3ia4nnt2+l+EFySG40SWLIkq0oCsQZ3j2E1qV0Q4Ym0RJ9YOtW1YmKRkgqrfGr1jGG5rp4Jr
	u8pIzOJWbNv9RlVlIiz3p1vGEWZqv8BoXhPEy4Ttd9JTlanQGlvFJoiZ0or6NT+Bxqr1HH7quYs
	Z0BGz0p+vsHvIGqLq9tytl2ipB+2n6/OaLyzpQqs96N7terFQA3y1s9Ef0VuzIKhR6Pwyw+ulQY
	sd9MnOBZQxX7olMOdMc+lD9Yf7DEhoeHM8uJxxSl6cu0KW0WTBwLEZog4ZCvFeBFQLarZgJstB+
	i7eY6+7L1u6EZ2ewAzHFSl0KCXfyuBWX2aLz+npQu+xlbShxvmOqyttpW+oOrrGDp8OJZ8fsURa
	egbye+EY/7GwT70XRRvpdwbODN6+FCQQwz0Rv9Ia4blrqIWJLOYqoI
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
