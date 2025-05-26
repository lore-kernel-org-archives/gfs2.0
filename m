Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD123C2F
	for <gfs2@lists.linux.dev>; Mon, 26 May 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748218453; cv=none; b=BMf/22ZzF51EO0y9d9FjcVYUnqT3h3tjY5PFU8HKzJCCgyDtUX7ABOOYB322UGRbOMhsSNLdJgH6SQadWVfdkTezmvi+2Gs6rvxt0fOkJCr/ykKYBiIi6M+rHhnk3e4792EmO+PuoNJJcru0szGK0vKjVHrAsHfvtWigpW9Yuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748218453; c=relaxed/simple;
	bh=iDe4lZDbETTr6cH+2ajupIG1T+2mY+/63euX+PSeyeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhUL3GcbG1DXW+YyS0Tc8Bu298uBu4+i7tWQ+yE+i0NN7HQ7rwOS0GeIRpfwk5AbNUgm5aUoBbXDepeh+HjFtHb0qolRqw10J8Ifj2Zzza1oX3R/ZL96w+M3DoLtJRaOHnQpUBJeBVI8biZFeHQ59xt4if0Prt+QBw5YYkP8aP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ9IVZWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ9IVZWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748218450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN3oaj49SxpTapfrR5Kx6feyOINmy5ifmldeIsI+GdE=;
	b=PZ9IVZWN6RZbLn84cHlCwSQh6v2O+mzvI+YDLgqkcGc7t3Kpp4ov7JCHrAQOJmUqKgF9lZ
	pjafF2t2gyX3E6wZ8BY+lOZGiVk/ocnTJCxGIzy7E+hd2ukKxjX+ywWCYFYASIZ4KAHk7Y
	S+/ppUbtgXVppNL/EUfC4VsTaJXIO5w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-tkKcFBFMMd6IHNexROpnVQ-1; Sun, 25 May 2025 20:14:09 -0400
X-MC-Unique: tkKcFBFMMd6IHNexROpnVQ-1
X-Mimecast-MFC-AGG-ID: tkKcFBFMMd6IHNexROpnVQ_1748218448
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32813ff6168so13350111fa.1
        for <gfs2@lists.linux.dev>; Sun, 25 May 2025 17:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748218447; x=1748823247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN3oaj49SxpTapfrR5Kx6feyOINmy5ifmldeIsI+GdE=;
        b=dTdBt7Fo2SCpk8wzRZZiGZavBdwwEjIBu4PAprKuP3PpmiiogyIT8+I2zenJfq4uB6
         XHzarGDOOVWZV3iQic+Ut1SXZKwRsJqZjxhZTQaNWTWOTrNqpusyn5lgVd81rd43z/Kr
         sQKRn6Xeg3eSoG2/xA6KUF2gD6bGgbFqdRRxzVWJ+o5vhTSXpoFabryB5HnZFn+br8x2
         cVfX2nETz99CLclnIliNRs1uSez6gIQKukr5V4f3VTJt2yO+wpv2b0lqPGbte7/Xae2G
         9jVnCEiB43IPh/TBnDXTKUEfJYgmoejVT5lXdIkMu3PL7o6g8geGMOCvIrqzM3yDkofV
         4LNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcA2DAdWw36SwUoZN7QLcbaFDafX5LKzyFkY/DA2WNwOZImDczBJB1TNXIDRgZ8zprl0ro@lists.linux.dev
X-Gm-Message-State: AOJu0Yycg3nC1ZOlWCrCJaFc8u4eNMs/olp5qnj954SBshpk8XNXpmc3
	9DMLya15gpknjwFkOgLjJHDndvHUDFhzftCWNwuo0tEu8pNFFKyMlRBlE4fJ4aUSEpcYHas68fh
	Kbp2q1yIv5BZOfb2QMMRU2QeekMgBCbMdf5MAGLz97wfETEO2J2NDdNOhNmTAvwai2N2UMzRxpv
	cw5BpBvjLQ3pZWAASPuAw90Ue8gI4CYw==
X-Gm-Gg: ASbGncslza4AjbL4c2F4b8AFnEe2mKeBK6LuuTlDKj9scYHhooJ/QIfNeGA+LYMbQma
	GtG+3rs5EmGhoMVjQgsFRJlpkBpC2dprUEUGyruS61Ht32X83NB65BM0M9Y86JOOywnr0KUkfJC
	Umldz//wuy2AVZBvQcCRYQT0INe70=
X-Received: by 2002:a2e:9a0d:0:b0:306:10d6:28b0 with SMTP id 38308e7fff4ca-3295b9abf5bmr19741111fa.1.1748218447441;
        Sun, 25 May 2025 17:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYqd7DRtWr3jaLJFSDKEWBnLHgljTK2lxtoH5ZXpV4VmU21DbDCzjAl96FL+9zjwCpV7PWR8b4L3B3BLETJg4=
X-Received: by 2002:a2e:9a0d:0:b0:306:10d6:28b0 with SMTP id
 38308e7fff4ca-3295b9abf5bmr19741051fa.1.1748218447033; Sun, 25 May 2025
 17:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250522052453.GA42746@system.software.com> <20250522052806.GB42746@system.software.com>
In-Reply-To: <20250522052806.GB42746@system.software.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 25 May 2025 20:13:55 -0400
X-Gm-Features: AX0GCFtad-uSwrsrLSYZwA4ixTVDWUaEjIYDh7krVi0_0wqWeyR7j22VFo8HiVU
Message-ID: <CAK-6q+hOCq8aksDp33utOGwfFngnTbJo-mY3+FiCJVPzwP-xsg@mail.gmail.com>
Subject: Re: [RFC] DEPT(DEPendency Tracker) with DLM(Distributed Lock Manager)
To: Byungchul Park <byungchul@sk.com>
Cc: kernel_team@skhynix.com, linux-kernel@vger.kernel.org, 
	gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dmun7siyBjAdFoqHGIHcvoi6KA6uAAw9ryZNKaoxLLo_1748218448
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 22, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Thu, May 22, 2025 at 02:24:53PM +0900, Byungchul Park wrote:
> > Hi Alexander,
> >
> > We briefly talked about dept with DLM in an external channel.  However,
> > it'd be great to discuss what to aim and how to make it in more detail,
> > in this mailing list.
> >
> > It's worth noting that dept doesn't track dependencies beyond different
> > contexts to avoid adding false dependencies by any chance, which means
> > though dept checks the dependency sanity *globally*, when it comes to
> > creating dependencies, it happens only within e.g. each single system
> > call context, each single irq context, each worker context, and so on,
> > with its unique context id assigned to each independent context.
> >
> > In order for dept to work on DLM, we need a way to assign a unique
> > context id to each interesting context in DLM's point of view, and let
> > dept know the id.  Once making it done, I think dept can work on DLM
> > perfectly.
>
> Plus, we need a way to share the global dependency graph used by dept
> between nodes too.
>

Having everything simulated and having nodes separated as
net-namespaces in one Linux kernel instance is I think at first
simpler to do and will show the "proof of concepts".
Sharing data between nodes is then just some memory area that is not
separated by per "struct net" context.

- Alex

