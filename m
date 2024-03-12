Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE55139580
	for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273819; cv=none; b=OP1Cia67LEWTGVnAP+ODOLnUW+IBhyOcGlz1dhyYtNuDEo6lq9cTMgFYYnXiKuCMvlNiHU4xJH0nayKvRl4t3miwCQS9ZGHINBt39vQjN4y91UobhxPt9Js3b8X7REbZSz0/acCibuNm/wbvU6Ut94VBSzyDLgsDc1zbDUmrYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273819; c=relaxed/simple;
	bh=Nn+6p/hmIw+razcPKWCs+SRAnYwR2JvVnyO+tYUgNrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDZwLMmh28q6UgJhgmfL7Hs8GI5WfvqgsI/I8ONeOdwb7LWsD4k8hlRXJ0g0FIVdgPXt9TvDh0w1LA57WuWRcGkOtB9bjyMYw/KjeNTUGO6b+mO/BH5tZyKZGfRifFs+lYox+Y8JoCPNHKexAWgI0crY1q67OtUQCMkMWta7H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoHfs2JK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoHfs2JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710273816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn+6p/hmIw+razcPKWCs+SRAnYwR2JvVnyO+tYUgNrQ=;
	b=QoHfs2JK1qAYuexiG4OFhBK3oSMwz6EO4ehVttsIa+Xqu6M9pfBIiFkTY4OTmZ5OjXwgHB
	89nBfUfxrmtXolfaBmFmqwRuLEDjvx2x+klx0yRdrzvAchCin3l9KWuLeyQEgJiogMSbw6
	WCqTJbw/VOPCY4r4bNS9rqpum/rwJIk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-SYa9D450Pq6c3CV_w5xV9Q-1; Tue, 12 Mar 2024 16:03:35 -0400
X-MC-Unique: SYa9D450Pq6c3CV_w5xV9Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d449d2db37so15244231fa.3
        for <gfs2@lists.linux.dev>; Tue, 12 Mar 2024 13:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273813; x=1710878613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn+6p/hmIw+razcPKWCs+SRAnYwR2JvVnyO+tYUgNrQ=;
        b=hh0MLnuTyznYltc3fSlipRneo5UV2akRX73Ew0+lzD9fwxO6g0rKrVq4GaN1UpmdXC
         wVGG26EG+EaHvw8wTk4CClCD4HXC4BWYon7FnNsRwbIxLcYdqiDgWVjWcGtNEuJKLRKA
         oM0RpylYeTyDrXjp6njwYeoeqneObfYTfITlZmNsojcOntKX6EEqRUR0xOI2JGaPD+r3
         0NGGGiygDWgGpTVdTxYkgE47mhruQZKGQ394o1o3VYp/wSrywxXhZB/a+n1qUSZPJ2WQ
         9Ob1supXylCn467RMsHsHnflTVLNEjzQNPBBnSC6mBeeklciFCLXXC8u96nFsP67rtKf
         MesA==
X-Forwarded-Encrypted: i=1; AJvYcCUlMIlQH9jejYOPr7P/cBI6ccjpX+vx5X0NMqd2g6FiuxMahIctFkjCAXnBXkVdh3QsTYhzZ6qHF7IFUKPTSwzTISn0eA==
X-Gm-Message-State: AOJu0YwkEulp84C2M3EwpqviIfCWthzFQbYDwbdeNMrbU5lEzJwS2CrK
	ZkeHuiDcR72tLVmkA97ty/wMZNjIFEkxOvoROJ1qOqS7v11vNYY0xADrFYeMXn2hlZQ9Vk+JcXm
	I1rbiAmrZt3IjrDAsH0QboyEszorsnSh0q9dJbuQALsfZKxOIuH7JLmNq524RaqJzLvrf5g1Z3T
	fnrSvBFx7FNBvS33XCmk+2hCLraw==
X-Received: by 2002:a05:651c:b0f:b0:2d3:1043:749a with SMTP id b15-20020a05651c0b0f00b002d31043749amr8461011ljr.21.1710273813734;
        Tue, 12 Mar 2024 13:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxmpPZsV05MBhF0gOUY8ImwCkxanwSe6nkpIgooua/tzfaK2qov+FBHBpWWx4FgFTfj5fxdGsoiC94TGXxl2U=
X-Received: by 2002:a05:651c:b0f:b0:2d3:1043:749a with SMTP id
 b15-20020a05651c0b0f00b002d31043749amr8461004ljr.21.1710273813450; Tue, 12
 Mar 2024 13:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr> <49396145-712d-44eb-884e-58eb19b1f4f2@linux.alibaba.com>
 <Ze7IiZmlhRaOgdhm@valentin-vidic.from.hr> <CAK-6q+jFv8tK4rF-xY6okTwhK87zMtOKP6fthzCQ-H8-4q=wbQ@mail.gmail.com>
 <Ze9bIiT3rAWTtPJp@valentin-vidic.from.hr> <CAK-6q+j2UDh0mi0KUTdtsRE8pj4+tuw_SU+yjzjsR3GCLURz=w@mail.gmail.com>
 <ZfANyOkQh4SgXoty@valentin-vidic.from.hr> <CAK-6q+hBa08LoAEhsdiiG4DarCGF-CWy41zDjU3zB81P7hHx1A@mail.gmail.com>
 <ZfCg6o3Kmkq78SIG@valentin-vidic.from.hr> <CAK-6q+j8Ag5yj6pn0P4wC2kRSNMVaHGmVY+G6+H5aYD1-ygzSw@mail.gmail.com>
In-Reply-To: <CAK-6q+j8Ag5yj6pn0P4wC2kRSNMVaHGmVY+G6+H5aYD1-ygzSw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 12 Mar 2024 16:03:22 -0400
Message-ID: <CAK-6q+iWzE_QgH3sYK6v8JS+p9KxaEGihoe-6WD1-pfz964bCw@mail.gmail.com>
Subject: Re: ocfs2 mount error
To: =?UTF-8?Q?Valentin_Vidi=C4=87?= <vvidic@valentin-vidic.from.hr>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com, 
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 12, 2024 at 3:55=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Tue, Mar 12, 2024 at 2:37=E2=80=AFPM Valentin Vidi=C4=87
> <vvidic@valentin-vidic.from.hr> wrote:
> >
> > On Tue, Mar 12, 2024 at 01:55:54PM -0400, Alexander Aring wrote:
> > > I was able to reproduce the issue and sent a fix out.
> >
> > Yay, thanks a lot for testing, I can confirm the patches fix the proble=
m
> > for me!
> >
>
> Then you can reply to the mail with:
>
> Tested-by: Valentin Vidi=C4=87 <vvidic@valentin-vidic.from.hr>
>
> that would help to bring the fix upstream.
>
> > > If you want to extend your debian testing using different approach
> > > (not libdlm) this can be done by:
> > >
> > > mount -t ocfs2_dlmfs none /dlm
> >
> > I tried that but fsck than fails to make a lock, so I think ocfs2_dlmfs
> > is only relevant when used with o2cb cluster type instead of corosync.
> >
>
> Yes, I think you are right. It is a replacement for
> corosync/dlm_controld handling. It seems I had both setup working at
> the same time, but it still uses kernel DLM locking.

It also requires a ocfs2-tools tool at a specific location:

/sbin/ocfs2_hb_ctl

maybe this is your issue why it wasn't working. My kernel was
complaining about it because it was missing in /sbin/

- Alex

