Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA1F508
	for <gfs2@lists.linux.dev>; Fri,  3 Nov 2023 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCua7FZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699039225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbdNnm6glXxbCyQwbEBZPF6AJpykiqEuJJGlXI5aA50=;
	b=LCua7FZd4gawAVE5ib1BqOv0nSFUJsjHUpwpsHmDvVgP30ai1R4UbS45TV1wG0ypXO0uy2
	GVQ/ZK4mcqr9tr0SDkjzH/rCmS7rMNBERR46PBqJ6kyRwPJUXOzHHEsCjnKm0XSRkk1uQX
	IgxQ63EWR58MVO8hSkGSQ9woWTUAJOo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-J7m8w1ZINKae3ur82k9DDw-1; Fri, 03 Nov 2023 15:20:22 -0400
X-MC-Unique: J7m8w1ZINKae3ur82k9DDw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c75886c044so164178966b.2
        for <gfs2@lists.linux.dev>; Fri, 03 Nov 2023 12:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039220; x=1699644020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbdNnm6glXxbCyQwbEBZPF6AJpykiqEuJJGlXI5aA50=;
        b=Ua2HKKR6kc4dls6vg4l/45/87GgEW2VSTQMOzOjFCzq+iHkU1HmPwnPu05n8UDwe4N
         kqTFGTFg2BnFN/zB1wEvwcKgUnaWPbLbl5BOWXYkqumqKXy+P6vvLdcZiiKFYuTh/ocK
         KKjw2glulwCd7J3cwkQbHrd3Uzk2lLz4GvoFshN375C2DI0S+CR5qzxMBWCMVnDz3kan
         +JIY9TPS0EzpOTVg/IHR4ltkGiPsspjmsiAyVabVlzdrzVg6Kz/n16Gwqj60QLFOBL7q
         A1eXQlqT4Fxe7IUxKSQrnQZRS0xPFgHTYjZVM9KtcFuG2RSTezHAHM3/9dqOGsFfnPn4
         1ADA==
X-Gm-Message-State: AOJu0YxGLLUuqICAz2Bz1KsJiiFXgtISRo5ZFQ3gPRyMVW6E+gpNuFp0
	YAPGsnBc+8g6HZVyZC0aPV41kIDNsXOVs64VgGwgVOr5MMe51vANfYhde9EyceZ5PsaAEapku7x
	Ud57tyMt/w8VmNoFUI0qn5v+zb/uE4g==
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id do21-20020a170906c11500b009d263ab6d4fmr8437339ejc.55.1699039220539;
        Fri, 03 Nov 2023 12:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVIlIiqTO8tXZwIEKnjzqKfHT36dgMA9qvb6+IwjXIIIl9wGqAGV0UwCtlu6/BMDIefpRHV4mH736kQorZILo=
X-Received: by 2002:a17:906:c115:b0:9d2:63ab:6d4f with SMTP id
 do21-20020a170906c11500b009d263ab6d4fmr8437329ejc.55.1699039220274; Fri, 03
 Nov 2023 12:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103161635.1902667-1-aahringo@redhat.com> <20231103185414.GD8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231103185414.GD8262@noisy.programming.kicks-ass.net>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 3 Nov 2023 15:20:08 -0400
Message-ID: <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To: Peter Zijlstra <peterz@infradead.org>
Cc: will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com, 
	mark.rutland@arm.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 3, 2023 at 2:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:
>
> > diff --git a/lib/refcount.c b/lib/refcount.c
> > index a207a8f22b3c..e28678f0f473 100644
> > --- a/lib/refcount.c
> > +++ b/lib/refcount.c
> > @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
> >  }
> >  EXPORT_SYMBOL(refcount_dec_not_one);
> >
> > +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockpt=
r),
> > +                           void (*unlock)(void *lockptr),  void *lockp=
tr)
> > +{
> > +     if (refcount_dec_not_one(r))
> > +             return false;
> > +
> > +     lock(lockptr);
> > +     if (!refcount_dec_and_test(r)) {
> > +             unlock(lockptr);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +EXPORT_SYMBOL(refcount_dec_and_lockptr);
>
> This is terrible, you're forcing indirect calls on everything.
>

Okay, I see. How about introducing a macro producing all the code at
preprocessor time?

- Alex

