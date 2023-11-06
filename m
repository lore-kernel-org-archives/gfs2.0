Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABF28DC9
	for <gfs2@lists.linux.dev>; Mon,  6 Nov 2023 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRiNeR/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699283574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyNTZV5EWEbVcsjEEcix1QYAz8PWV6uUt3nEay8zko8=;
	b=ZRiNeR/kEZw2ZrfvY/JkOcCu/jISuu38JHt2SeSwYbjkYB41E+P85/D/G+2Qz8amkCkHOU
	MTFXp/4sJBxDuVxMt+29w4v0BD73qTMmc0PRGBygGagns/HQg97adoL4qJPj+nhzXwY46v
	+uv+/xlu0ge5nkd21spWnyJOGcakaXI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-POqN9vepOhK3KHD13CaIkg-1; Mon, 06 Nov 2023 10:12:52 -0500
X-MC-Unique: POqN9vepOhK3KHD13CaIkg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9d216597f5fso326847566b.1
        for <gfs2@lists.linux.dev>; Mon, 06 Nov 2023 07:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283571; x=1699888371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyNTZV5EWEbVcsjEEcix1QYAz8PWV6uUt3nEay8zko8=;
        b=EywfdRChO0W3J7LYKzepaaCOBJsVVvufvnwhs0mVP0Yr3fr5B9gySibMeH5Fmh6AAl
         T13KZPL/GwZqcsn/l8JhPiYsXO2DS4sRC8Sg+YAikTaNiogWi0MXd9XGSgmhj6wi5uOM
         ObfJOqdR1ltm0/0Rdzpoyh1oD4tEFRJgnZacyY2iJym8y6J53oVHh/SP5iBW9nGYfFzu
         YSl4gG92YbsYrGrlJcCJk/wHdPvkSw0m/sVjaLe+DfHp5okdAESKEJgP0Eg+aCw/i7t0
         o33hIflzH1Uc+8QiK17h7mGG4emOg8XH1aQ9UtvbLkMcwSR8LGthX0f6+ApHGdFutJqg
         E6CQ==
X-Gm-Message-State: AOJu0YyXHs67Rcwr9mcTUK4rcA15mqwJDgOgIvGCYileYcX/o8hBb5mW
	VuC0+RG71RqA1yIZekhFOgaFUGlEwQbu0jLEsJaTIyttqy59ikE2PN1LKrIjptuFI+ZXUFY27ih
	FG8ehL3VmzWGo9u7ND4M50umsR4zxfVsqRWOWJSVh
X-Received: by 2002:a17:907:9811:b0:9dd:7ccf:77f8 with SMTP id ji17-20020a170907981100b009dd7ccf77f8mr7562495ejc.20.1699283571260;
        Mon, 06 Nov 2023 07:12:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2YEM5ISvIiyX5pdjuegtQ5SrrbIrBKyeYx0DojFwg+/s7On1aAWyRlcVDxxj3a+zujzRpSSTVBh3dtBe/Xmo=
X-Received: by 2002:a17:907:9811:b0:9dd:7ccf:77f8 with SMTP id
 ji17-20020a170907981100b009dd7ccf77f8mr7562474ejc.20.1699283570957; Mon, 06
 Nov 2023 07:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103161635.1902667-1-aahringo@redhat.com> <20231103185414.GD8262@noisy.programming.kicks-ass.net>
 <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com> <20231106111104.GK8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231106111104.GK8262@noisy.programming.kicks-ass.net>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 6 Nov 2023 10:12:39 -0500
Message-ID: <CAK-6q+iwqjkuxVqt6hMw3uoq0UsZxvx_x2rdLDtsBSdURpjv-g@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To: Peter Zijlstra <peterz@infradead.org>
Cc: will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com, 
	mark.rutland@arm.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 6, 2023 at 6:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 03, 2023 at 03:20:08PM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Nov 3, 2023 at 2:54=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:
> > >
> > > > diff --git a/lib/refcount.c b/lib/refcount.c
> > > > index a207a8f22b3c..e28678f0f473 100644
> > > > --- a/lib/refcount.c
> > > > +++ b/lib/refcount.c
> > > > @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
> > > >  }
> > > >  EXPORT_SYMBOL(refcount_dec_not_one);
> > > >
> > > > +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lo=
ckptr),
> > > > +                           void (*unlock)(void *lockptr),  void *l=
ockptr)
> > > > +{
> > > > +     if (refcount_dec_not_one(r))
> > > > +             return false;
> > > > +
> > > > +     lock(lockptr);
> > > > +     if (!refcount_dec_and_test(r)) {
> > > > +             unlock(lockptr);
> > > > +             return false;
> > > > +     }
> > > > +
> > > > +     return true;
> > > > +}
> > > > +EXPORT_SYMBOL(refcount_dec_and_lockptr);
> > >
> > > This is terrible, you're forcing indirect calls on everything.
> > >
> >
> > Okay, I see. How about introducing a macro producing all the code at
> > preprocessor time?
>
> __always_inline should work, then you get constant propagation for the
> function pointer.
>

Thanks, it is always good to learn something new.

> But indeed, perhaps a macro is more convenient vs the irq flags
> argument. You'll then end up with something like:
>
> #define __refcount_dec_and_lock(_ref, _lock, _unlock) \
> ({      bool _ret =3D false; \
>         if (!refcount_dec_not_one(_ref)) { \
>                 _lock; \
>                 if (!refcount_dec_and_test(_ref)) { \
>                         _unlock; \
>                 } else { \
>                         _ret =3D true; \
>                 } \
>         } \
>         _ret; \
> })
>
>
> bool refcount_dec_and_spinlock_irqsave(refcount_t *r, spinlock_t *lock,
>                                        unsigned long *flags)
> {
>         return __refcount_dec_and_lock(r, spin_lock_irqsave(*lock, *flags=
),
>                                           spin_unlock_irqrestore(*lock, *=
flags));
> }

I was thinking of solving the additional flags parameter with
prototype and argos macros e.g. TRACE_EVENT() is doing it, but this
version looks much better.
I will send a patch and do similar things with _kref_put_lock().

- Alex

