Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D98F5B
	for <gfs2@lists.linux.dev>; Wed, 28 May 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433621; cv=none; b=Zk4S9cHYTsbvoR7tN7FtSwHN8YzoJ/OnPMDFLm2iqcKL7fxNBaSyuVFTQZSTLYFrsv7SNBCgL7m3cohqMU5gj3a9d/4Qcelfv2sNYp7XLzaWpNjR2J2WsIqYVF6iVdQYXoiKM3wqbtXF7NR37LeC0txi6jPJzwOnn/+sHSXn+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433621; c=relaxed/simple;
	bh=6atfnO6Hqh06X691eUuocyP2yjAR5z9W7QDo8CWRkJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g29MtmY4hGYoGZ9pvUJXcVFaeJnpRWy6GceZPThKkx8R98LWfOV9ZSxkd00AXqFf7kJWgtmkZLPQ4nXWk8RaQRqu/H6FggNH5f/MR45hN7lE3Zk5TOMh0/J+kh1vVy0kvTOAGTkA3RQsXPL43H72MsIHUaDqDhVVheo2j9fbA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAexdvva; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAexdvva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748433617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7GOEzgV5yycdin9ndY2/7BcE8zwy+mJsf09IHsECj8=;
	b=EAexdvva2I7JuJdE0lc++nAnDbrsaRCnFA4bkb5L/1Sbdw8xTgsjpvOYPQpZ4NQ7OsmUu2
	T7XKCI7j6fF2AO3qnR3Xzf2EgvNaRZsE28MtoFi0kDJEg07KNvA9/sdeMqLWghcAMe0GxL
	HkAcihKji1fpa2tuq9paBhi7rn6Dlb0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-aiR0a2uqM7O8U1NIapM-bA-1; Wed, 28 May 2025 08:00:16 -0400
X-MC-Unique: aiR0a2uqM7O8U1NIapM-bA-1
X-Mimecast-MFC-AGG-ID: aiR0a2uqM7O8U1NIapM-bA_1748433615
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a63984ec7so26331651fa.1
        for <gfs2@lists.linux.dev>; Wed, 28 May 2025 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748433614; x=1749038414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7GOEzgV5yycdin9ndY2/7BcE8zwy+mJsf09IHsECj8=;
        b=fDxfdMJAnML2Z8hi6nwZ5tzR4iAxHMF858jt02M6s000Xbb/aiPPg0hpjaEKqLdsK4
         rtlpGYQSd1sZxuCHvQcp8JJSpRU2x5/lPj3ZhLeRHa1XU5YEjElM7QKmsC11RUNna44h
         MyKqT/c44GEXCkR7zMZTrjKmYfkldAFFbTQiairTbFolBvItItZzn//ZIsce5vYPlMK2
         hwZ0tC20mFhuKlJ1UZZgMvB2jfn/BE+y3S/em2mdiaiux2qnB+Ysq/xW6u4l6rckOXLJ
         Ou6HndcEWDQ42UI6vpoGiy/iOusXQMTFj1b2/GsT5kZ1hsjSe0E5cWNztJZEtEafuBMk
         N4sg==
X-Forwarded-Encrypted: i=1; AJvYcCWYOh1wjEqCGLnAJcMQ9iUW2o4hDacc8t2F4A3gqA0yR1tWdkRmPXgO5tVMhp4vmK8Tu+Ko@lists.linux.dev
X-Gm-Message-State: AOJu0YyqETDBvLOZqwsWRxgLmUV0ih2ORR2pAnfqX1JsqYBGwLIxMsrU
	O2KG/EQ0M3YMy4+9BvXDbF1M5ew4TF6Vf5v1Devbotw4Yl1dsICJDL561csm860fkBjVQij8bNY
	4IfKFMUjhH4mxeJixPWn9o6GpRPLiLrpolZC2t8PSy1q4f2ynVXnlyDTuhSzX/GWBPYH0YRTsav
	kwXoc01ND4NAO3J7i1frRqJrkFJK24RA==
X-Gm-Gg: ASbGnctidGWbtLMBG4lwIjAmQMUqmr6OJbjL/xr4hxsebVyWkPL6BHdW+Kquvaxlj2g
	1FVOEcx/h4dx9uOFbECEmTdTSZtLB6U50oWPr7iFhg3V5WEJge/MjsyIYc95LJUD36n59Hl/myn
	GAl8IagCEe37pQt7w6NpPF/mrihDs=
X-Received: by 2002:a05:651c:543:b0:32a:77a3:877f with SMTP id 38308e7fff4ca-32a77a389c4mr8227511fa.2.1748433614326;
        Wed, 28 May 2025 05:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELaCLp5rNiD906NUGLnDvsVyzeESiJg149LhNzGAv/p0TZF497/9wv294JB6S4cCOFVPaMciiSxr2OriNU8+E=
X-Received: by 2002:a05:651c:543:b0:32a:77a3:877f with SMTP id
 38308e7fff4ca-32a77a389c4mr8227341fa.2.1748433613880; Wed, 28 May 2025
 05:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250522052453.GA42746@system.software.com> <20250522052806.GB42746@system.software.com>
 <CAK-6q+hOCq8aksDp33utOGwfFngnTbJo-mY3+FiCJVPzwP-xsg@mail.gmail.com>
In-Reply-To: <CAK-6q+hOCq8aksDp33utOGwfFngnTbJo-mY3+FiCJVPzwP-xsg@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 28 May 2025 08:00:02 -0400
X-Gm-Features: AX0GCFupcETx_3BXB8FtYUP8-a43n8SHBf9scY74BCrwjEMZFktfd2ES7qLyX0Q
Message-ID: <CAK-6q+j3QJCB6XERbJfEkvro=Kucq0PQHrCyrZ+LxDq5yHx+=g@mail.gmail.com>
Subject: Re: [RFC] DEPT(DEPendency Tracker) with DLM(Distributed Lock Manager)
To: Byungchul Park <byungchul@sk.com>
Cc: kernel_team@skhynix.com, linux-kernel@vger.kernel.org, 
	gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6AFfLNZ_Wl4E9FfUvDs8IsDbZki17Wsy40q8aG6zwOM_1748433615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 25, 2025 at 8:13=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Thu, May 22, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com>=
 wrote:
> >
> > On Thu, May 22, 2025 at 02:24:53PM +0900, Byungchul Park wrote:
> > > Hi Alexander,
> > >
> > > We briefly talked about dept with DLM in an external channel.  Howeve=
r,
> > > it'd be great to discuss what to aim and how to make it in more detai=
l,
> > > in this mailing list.
> > >
> > > It's worth noting that dept doesn't track dependencies beyond differe=
nt
> > > contexts to avoid adding false dependencies by any chance, which mean=
s
> > > though dept checks the dependency sanity *globally*, when it comes to
> > > creating dependencies, it happens only within e.g. each single system
> > > call context, each single irq context, each worker context, and so on=
,
> > > with its unique context id assigned to each independent context.
> > >
> > > In order for dept to work on DLM, we need a way to assign a unique
> > > context id to each interesting context in DLM's point of view, and le=
t
> > > dept know the id.  Once making it done, I think dept can work on DLM
> > > perfectly.
> >
> > Plus, we need a way to share the global dependency graph used by dept
> > between nodes too.
> >
>
> Having everything simulated and having nodes separated as
> net-namespaces in one Linux kernel instance is I think at first
> simpler to do and will show the "proof of concepts".
> Sharing data between nodes is then just some memory area that is not
> separated by per "struct net" context.

Alternatively the master node of the lock (this node knows everything
about the lock operations being done including the nodes that are
waiting to get the lock granted) can be used to detect cycles, we
already do that for some simple cases when converting locks directly
[0]. Maybe this is already enough to have all the information, but it
is not just a "wait_event()" mechanism, there needs to be some other
API to use DEPT for this case?

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.15#n2163

