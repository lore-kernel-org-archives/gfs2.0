Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA61FC7F5
	for <gfs2@lists.linux.dev>; Tue,  4 Mar 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111501; cv=none; b=nYR6u8ql5+z57mK8PxozIiICLuU3blgC2MrtQDTo9DMadTZuHI/Zg3+a8MMjVf7/DjRhbHh8iuBDpp/S1+LCd+A4kNhvyjylXpBwJfCwC7hEUpfAlA2Hnt28q0dJ4gsXHOzMszRTkfW3Qgkmyq01ArDoq1mrNFUnA1mZtrhzK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111501; c=relaxed/simple;
	bh=+iHw/AbL3yUGgG7VpV5Ie6oEFdBjvaNBT0Oi36VxSNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hza5xZm0O3A1p1Jzblvw4dEmLpu9+ua5SjFQQSooA/nAklXnrBYbUyPoPp3pQMZ9EC9KLXXqMIpb+oRUK465/J5MrNan5g0xHbi7aK7hH/YIT6USU0+aoyOOuehHbyQMw7QVUa2i3/TUcGjfu0DGYnOgWM1TTo9GIL6RscLLrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AltrINsn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AltrINsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741111498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qk4CUy2r8U4RW0jZEcEfdfZKYycIqCP/Pkjx+JFW4J4=;
	b=AltrINsnI3nZ8ZZ1i4P4uRO+V055ZJ64fcV8lNPCrbKuxPaF5NF/AxI0LMATn/tImkcCca
	7RdZ1OeG3GnXwKFKNrT5vMSx5iVZd5Dp5joGpnVk8lB8xLRqNV9wZVmo+uNGuOjD0vRYmA
	FdlTJyhYHIendgMFTx3ZW3+ZfTvE2NM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-b058LddmPaaM4SsDgbou3g-1; Tue, 04 Mar 2025 13:04:56 -0500
X-MC-Unique: b058LddmPaaM4SsDgbou3g-1
X-Mimecast-MFC-AGG-ID: b058LddmPaaM4SsDgbou3g_1741111495
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5495f6428bdso1482662e87.0
        for <gfs2@lists.linux.dev>; Tue, 04 Mar 2025 10:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111495; x=1741716295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk4CUy2r8U4RW0jZEcEfdfZKYycIqCP/Pkjx+JFW4J4=;
        b=fUS2NIyDDwORIxjDZAOyDtJ5x9yIaDJjd8WWkZTiBj+P9uksrhLsokqxDWfTw9EFj2
         ie2ggavfLDLjljP0u/0VFxFWxoAPqWUgY4Op2MDdevPa/ltVtEixyTLd+pK8Q79EMWfI
         BHeAdfhvMvlYYQL+QQUjYsjBAYAJtWa/y41d4bUx/o2kexAmtiKYGcPAJrfzwzqAp5xt
         I4maaxSB3t3XQsaCDUgCdupLBbEoTR8izIShamhIXkkzseBpxA+vWo74b1XpceKvubd0
         aVM1JmuOZkCv3EueWFAE7CDJwtaIP1OyFDtR0s7ua/fM6niYHOWzLGLuxjjiikSiDeTF
         SUhg==
X-Forwarded-Encrypted: i=1; AJvYcCUKNpu7ybPI2ZdbLJqZoOWIU23fgxCl3NFgx5LjifV5oe95m6C8GhZ8ulylrwvuNjH4rPCr@lists.linux.dev
X-Gm-Message-State: AOJu0YwLIG87IeHAPIznzhNLWJtdXifjWKbnjliXHgbPbivdZdAEmBrN
	7/14YAHUCJDohu/4W/G2pPZVj7+V7Jh51iJC7lWqrjlpNaoUxQj1r/LRrnhcAD72IR14G/hL3jv
	ajLmrqMxkOjjOHqIr+Kw6ATGX7BSmGePt4KPNE8c21YBv6hPoirLoj7KdStm0LyNl85Rmwz+3gY
	hIiLLYAXgCqnYupUAc2QjZ01Cydg==
X-Gm-Gg: ASbGnct83eOuPgohlHUJOWjb0OuNXeD4mya/5gxIujUJeSyzzjOScgMkb6qpqL4adPh
	Y5c99C8BR7tSFuiTpKcbu4DYc5x+hmTky4E6V+mQYiC7dFmf2E3YBIZbQGEtfcJ67Ey6OgWXut2
	eBjVzb7IutwacanpiOQz2Th/FBzs8SuyY=
X-Received: by 2002:a2e:9014:0:b0:30b:aabf:fb3 with SMTP id 38308e7fff4ca-30bd7a4612fmr397351fa.12.1741111495282;
        Tue, 04 Mar 2025 10:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYk1ZQZOgvf8aEmlLdgShfLT7Kg9efN/BBNtKJ7L8VCiggj878SlmkUbrEv9Pu1GF2ulpyDc0xAEcPfqRIOlA=
X-Received: by 2002:a2e:9014:0:b0:30b:aabf:fb3 with SMTP id
 38308e7fff4ca-30bd7a4612fmr397171fa.12.1741111494893; Tue, 04 Mar 2025
 10:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221150937.21642-1-heming.zhao@suse.com> <CAK-6q+iiMqW9eknqgVZiKjeUgSEAkL61Q-EbP8xwy_bayjS=fA@mail.gmail.com>
 <Z7zJ6OQIzC9Q20sG@redhat.com> <456aa9b1-a197-4de4-a062-2fe11bdaf179@suse.com>
 <3a8cbc24-c024-48ea-869f-687ea740ad7d@suse.com> <CAK-6q+g_bdNoptQ_bPUbzE9uL=strr6utQ3jM_1fxoMOpEjA7A@mail.gmail.com>
 <468a9169-3de2-4226-8aa1-61e0e211e4bd@suse.com> <CAK-6q+jEhV5hQSjZu6xj7Ap8FzzkFosQ04X+qH2MW8+MOd8Zvg@mail.gmail.com>
 <e5a4315c-c608-4133-8e1a-fc14c29d1594@suse.com>
In-Reply-To: <e5a4315c-c608-4133-8e1a-fc14c29d1594@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 4 Mar 2025 13:04:42 -0500
X-Gm-Features: AQ5f1Jq7ZyCbXEAoQQxUJn1atbu1fEbJSBhGpiq-PTmwTQwqeDD5fHxwkNgZSOA
Message-ID: <CAK-6q+hLKjaSbnupcc-b-yyT2uWwDEpSOdnyETVUMj9wV09CYQ@mail.gmail.com>
Subject: Re: [PATCH] dlm_controld: Support for extended value of kernel DLM_MAX_ADDR_COUNT
To: Heming Zhao <heming.zhao@suse.com>
Cc: David Teigland <teigland@redhat.com>, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev, 
	Roger Zhou <ZZhou@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t-MSofIZF_3crbBRP85NT2Bu5t4I4bkMmXZ9vfX99_w_1741111495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 3, 2025 at 10:07=E2=80=AFPM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> On 2/28/25 23:34, Alexander Aring wrote:
> > Hi,
> >
> > On Thu, Feb 27, 2025 at 8:09=E2=80=AFPM Heming Zhao <heming.zhao@suse.c=
om> wrote:
> > ...
> >>
> >> Let me summarize the above discussion/description:
> >> - TCP is the default.
> >> - stop trying to detect:
> >>     - use dlm.conf to switch from TCP to SCTP.
> >>     - corosync.conf 'rrp_mode' is not supported in corosync 2.x.
> >
> > yes, I would just drop the whole detect_protocol() function and don't
> > have the protocol setting depending on any corosync.conf related.
> >
> >> - TCP can work with multi-link, but only accept the first ip addr from=
 corosync.
> >
> > yes.
> >
> >> - SCTP can support max 8 ip addr for corosync 3.x.
> >>
> >
> > It shouldn't depend on which corosync version we are using, or? It
> > should be the same way for 3.x and any other version, see [0]?
> >
>
> Sorry for my English.
> Yes, there is the same way. There is no special code for corosync 3.x.
> My mean:
> After changing DLM_MAX_ADDR_COUNT (kernel) & MAX_NODE_ADDRESSES (dlm_tool=
s),
> the dlm layer supports max of 8 ip addrs (in SCTP mode). And the number 8
> is equal to the max number of multi-links in corosync 3.x.
>

ok. Node address configuration shouldn't depend on any Corosync
configuration, however I agree that dlm_controld is currently in a
state that it just simply works in a way that it gets the node address
configuration of its configuration from Corosync and this is fine for
now.

- Alex

