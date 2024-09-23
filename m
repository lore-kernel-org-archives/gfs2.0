Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BF16419
	for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115027; cv=none; b=CpcFVm/hXQPlPB+jexdUiSWR84FB2IKK5dE8P3MEYq2seM0M2HDC0QhVB7tSv4H28zW6qR8Mp1Y7lc6HBbUti9PbuqD0PTdPr0SdvgHdh6VpGJfclMyL8KqhZQwF8G0S80VR1ItNcARmoR1HcOXawdjb8sMGskANlr5IxBnP1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115027; c=relaxed/simple;
	bh=pFx/BkxxmpbNt4KUQFbJiUIIkQmD3B08PsWJADsUSnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4r2Tv/VW2Nk3opi94nXGJ0fd4upSDNG/xmINRmxN47grXjU9pv92XOnu1vNo/hCc5sYjohsdH7VP7mVbBkMvLx30vsKcz3zyDletsd8ucQHy7TkvYS6ytI1jMNium6j2IxcbAr+OlKsRdzFSsXIfx654+Ye/ZB+MS1WI0HSu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm697ERg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm697ERg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727115024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoE+RFdwcbThteJHz1bouTpc6RqvgbuGTqx/2Pf6Jz4=;
	b=Dm697ERgHsUwwvjws2krI/kF7WUUEXd+bXpO/0v0Ql5J5JdZa2rkFq+SzvceQCPRDVVCgI
	uPCBw0v3SWIaXsEyjBh9he6LaFCfKXRNUO/7hER/5aUrxEVIwrqYUjuBj2hAv5uSFMqsRx
	H0/uTKTNzEWzgA8BKiLZ0jDZrIqT3JE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-_cR7PdxgPeSBXDqzm5sxNQ-1; Mon, 23 Sep 2024 14:10:21 -0400
X-MC-Unique: _cR7PdxgPeSBXDqzm5sxNQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-207a350559cso67631275ad.3
        for <gfs2@lists.linux.dev>; Mon, 23 Sep 2024 11:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115020; x=1727719820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoE+RFdwcbThteJHz1bouTpc6RqvgbuGTqx/2Pf6Jz4=;
        b=FEQ42cpdz6f5Acni0SSGm6U9HRT9EBGpm4VBdJvWNQRE53eZxbFBWG8ap2jUEjMC7w
         9pJiSFlSGSgGR5ohQSO7BvVWvB3fEB0sn00HRNW/MwBe80/eCnNH7lYj0TfQy8pViQ3a
         cE5oflZETHfLksqzdKO5etXeshVDHud0kZjIGWfUv7CqGmpSFgMatLbG46y7J6xMAWCd
         HLamSgYRe7yrSqqiCprZcSJ+UmX4Jp902FJBL9l6wpBD8uWh+3SYuQ0qXN2bq6kzmwCC
         D1Sj/mVw+g2D9d6h3idBDdgB1WK98hj4PuwbCHYNEVX3VH0CIplIEMeLHWdwgHFRLyX1
         3kYg==
X-Gm-Message-State: AOJu0Yz2YDJxe+VsbPQWx3aK6Kx9fW4mGmeRH3QOZevYhp5AAMSdPf5m
	PEO8Rv70d+FrEhPYw+BrzeOkvNpSJuCU8Dvxuq+1GmvSYFOkv02384QViYL7FW0H/Y4/GIjyK9o
	dMEMm/sZzHETY5/kQUDt01iVMK90hyw5NZHTEtNJu3zn7hZr86SlW0yn3Tv5HjM6I7YEekep+IE
	8EtQCc6Jsz1SOBD+e9fbX9eMywkQ==
X-Received: by 2002:a17:902:ce01:b0:207:6fd:57d5 with SMTP id d9443c01a7336-208d83cacacmr178819305ad.36.1727115020685;
        Mon, 23 Sep 2024 11:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOQdZIXq+wJ+Ii92m4IubK2BktRZXpOo4uRTIyG1lN+bua9WP9WBRnQ0j3KMKXjLeJb+dP39bnWsOTaUiXDtk=
X-Received: by 2002:a17:902:ce01:b0:207:6fd:57d5 with SMTP id
 d9443c01a7336-208d83cacacmr178819015ad.36.1727115020364; Mon, 23 Sep 2024
 11:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com> <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Sep 2024 20:10:07 +0200
Message-ID: <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 22 Sept 2024 at 07:00, Andreas Gruenbacher <agruenba@redhat.com> =
wrote:
> >
> > The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacf=
abd0:
> >
> >   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tag=
s/gfs2-v6.10-rc1-fixes
>
> This is just a repeat of the pull request you did (and I merged) back in =
July.

Hmm, indeed. I've just sent the right pull request; sorry for the confusion=
.

> I'm assuming you meant for me to pull something more recent, but I
> don't see any newer tag names either.
>
> Hmm?

It's tag gfs2-v6.10-fixes from yesterday; you should see that.

Thanks,
Andreas

