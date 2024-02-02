Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAC23BE
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893808; cv=none; b=ZLCnDbZ9bpWhzY3kf/Pzc80fR5dEoQVVUXz2qS+Xp9uUKvWOhghn8FaoyN4mAx30eAb/Cfw/W2QDb9XuVPWGGg+vNEwoXZSim+YQ16FcsHeoLz6EmxCUs4JHRuSjlbNPVGF8CdYcfhuYf4w/xF7TRTXqTtNVaks9pL/lEaOSYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893808; c=relaxed/simple;
	bh=IRlTYI4oG03pvRTM8dGWpH23zid0Ztsfbu7JJoUZdm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sa/JzaDdfFKb2zqM1GVbk4qu4I5KvYUKNPCILmsD5MAb59iDKNJYfRppg7eZZFNvQB/gvliNkWTZgZ/QhB6LACkAbtDvPooe+ofOU2mW9yx7KE3h9YTvUnqkYOMEdxUPAztQOQhE7dCMlRRAQYZTyCgBeasqBjU2hWZUuPnW1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcuNriUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcuNriUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706893805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTk0JFxQzlp6mPBbyfqa3i18NL6HA34RSSdQ5KDAWw=;
	b=LcuNriUIM/STWqs3+p+tm8Taj72jUKUWhkS1ztu1n59W0RQIc/neJZVcJSjdRuTClfnDVM
	L2MyIyY/vOrFoISvEYOP8IBo0zmdgswpVPl/0pKdd3nlK2ivxb6+HQZEYI2GPPIWdAoNrj
	Jm2vbmjzZ7TNEBMSwDuii11Q0iTNFnw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-6rchP_-9OAWmeECIv3SLMw-1; Fri, 02 Feb 2024 12:10:03 -0500
X-MC-Unique: 6rchP_-9OAWmeECIv3SLMw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d4a645af79so29007415ad.3
        for <gfs2@lists.linux.dev>; Fri, 02 Feb 2024 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893802; x=1707498602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJTk0JFxQzlp6mPBbyfqa3i18NL6HA34RSSdQ5KDAWw=;
        b=rTX6pBhD20ro7wyXAmlGBlT0Vm/mAQmkOnbRC0qLtrpd14wtZug9FNM9DffLIV5IR0
         TAiCUaM7KQy0n6154tIeQ6ywaZm+HObyEiIEosU9KkfjsnaQSyabL8uvSMlY0q2G49ba
         4KmuUhi0EBAsN7X2tqROvSVf/qbvlYs7Uq6ohQXXw0Kpzg7GUgO3KF4SWk0VHsSfSdJk
         St0odp/J9rwtV4RusuNY0Yxd/jJOMXF8e6VHGFDPiE2IHgI1eho4NEAZVr11OkDto9gb
         UMIE1TvMdmUCkS5nltHmoufSS5wnzCUU4xpSBB54J+SDYapOa1JAFaSc1lcwMqac8rzK
         /FZw==
X-Gm-Message-State: AOJu0Yx10cl1CQlp9BPF3P42TLwEBgbjOkVpMwu2SypEkvRuTF1bgAR6
	VVLBAEFydqwg3Gy0tTyFBwWjx4Vzfdn4n3VOx7D8JfVN7eTY0WlyEEoKGkpjF1ghLRGwSYozPLK
	9UX5D6elkyBccQ19BsbGZ/mUk8mwG0ASaPWHL2c/LKuMSw9pV3tv6IwGjGEUizD5pRIUeCdFcez
	Jp/lLfKmrKLFi0HKP29Xefw/EQlw==
X-Received: by 2002:a17:903:2584:b0:1d7:4b27:4ac3 with SMTP id jb4-20020a170903258400b001d74b274ac3mr5825632plb.31.1706893802695;
        Fri, 02 Feb 2024 09:10:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELDr0SEEOqeHzwNtiwopCvRghtuNZCXN6TezjOowI+0SUjlI4YuU68syKWVxndbPtXdVPKixy/0YA0mjVnU+Q=
X-Received: by 2002:a17:903:2584:b0:1d7:4b27:4ac3 with SMTP id
 jb4-20020a170903258400b001d74b274ac3mr5825624plb.31.1706893802377; Fri, 02
 Feb 2024 09:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240119212056.805617-1-agruenba@redhat.com> <20240202042312.GY2087318@ZenIV>
 <20240202045943.GA873800@ZenIV>
In-Reply-To: <20240202045943.GA873800@ZenIV>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 2 Feb 2024 18:09:50 +0100
Message-ID: <CAHc6FU6bmTjrB90BHxmSmLfuuJPPe1iSweaj8SUq=hkRnAmA2w@mail.gmail.com>
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking lookups"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:59=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Feb 02, 2024 at 04:23:13AM +0000, Al Viro wrote:
>
> >         if (gfs2_glock_is_locked_by_me(ip->i_gl) =3D=3D NULL) {
> >                 int noblock =3D may_not_block ? GL_NOBLOCK : 0;
> >                 error =3D gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
> >                                            LM_FLAG_ANY | noblock, &i_gh=
);
> >                 if (error)
> >                         return error;
> >         }
> >
> > See the problem?  In RCU mode we carefully fetch ->i_gl and verify
> > it's not NULL.  Then we proceed to dereference it again.
> >
> > IOW, these ip->i_gl below ought to be replaced with gl, or you are
> > risking a compiler fetching the sucker again and getting NULL this
> > time around.
>
> Wait, what's going on with this part?
>         if (gfs2_holder_initialized(&i_gh))
>                 gfs2_glock_dq_uninit(&i_gh);
>
> First of all, gfs2_glock_dq_uninit() can bloody well sleep in
> gfs2_glock_dq().

Right, we need to get rid of the sleeping there. It's a really bad
design and I'm trying to figure out how to avoid it.

The sleeping in gfs2_glock_dq_uninit() -> gfs2_holder_uninit() ->
gfs2_glock_put() can be avoided by deferring the final put to
workqueue context; that looks pretty simple to achieve in comparison.

> What's more, it drops a reference to ->gh_gl,
> i.e. our gl, in gfs2_holder_uninit().  Where is the matching
> increment of gl's refcount?

That happens in gfs2_glock_nq_init() -> __gfs2_holder_init() ->
gfs2_glock_hold().

Thanks again,
Andreas

