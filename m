Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975E18A6D4
	for <gfs2@lists.linux.dev>; Tue, 26 May 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803929; cv=none; b=gS/GlTqAvCNQPut5+r3GRXOZ8ATBlRY3vQr3hFoHE0wvlEA4P4pD0RPdTFPZar/TDLAij4MLRY92sdJlS+q3IModBwWrBBO5JQ6zN0D9KwHAeZZW/oW6X1pL2X4loBbQwQ9sJiNBO5bIiUOE241ada7Pe+eMQvElTpH9muHI8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803929; c=relaxed/simple;
	bh=vW1j8FNLmA2cKuMZ9NwfwkLafNRWoDp5lDbzfN7AgQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb32yo/tTOx8dC8qm9yUYl2fUyCokfuy8JwQpI7eYZDmjB3UfwEMQHFaLKrPEKCTL4Ys7O4u5c9WXlA42NTA/Nr9PnVJ4O39BNtPPvD/OE2XXP3xqCeZ283trpjyAAeAz/Mqs5Ln/q6DEOzm4KhOXyy2LO425Wwv02l6Uc/ayBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWDSoFrQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWDSoFrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779803927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vW1j8FNLmA2cKuMZ9NwfwkLafNRWoDp5lDbzfN7AgQU=;
	b=PWDSoFrQL1k8/+6vhZS8Xz1JhrrBcJuFeR/xISYFdvBtey5lj3UmutV1sxM3lUzWdLFY0K
	aOevvO+ZEiQaN3Iqwd1uz+8/G8uDs2DW5hO98ao6DKTDj8ugweNBzUChxjpGOwYovXZ2rP
	UW5sPB3MvZcERnE8CApG4B7tL7ZdtFU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-IM56SADdNL-hKgAwAxyt3Q-1; Tue, 26 May 2026 09:58:45 -0400
X-MC-Unique: IM56SADdNL-hKgAwAxyt3Q-1
X-Mimecast-MFC-AGG-ID: IM56SADdNL-hKgAwAxyt3Q_1779803924
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38e83f0482eso41943861fa.3
        for <gfs2@lists.linux.dev>; Tue, 26 May 2026 06:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803924; x=1780408724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vW1j8FNLmA2cKuMZ9NwfwkLafNRWoDp5lDbzfN7AgQU=;
        b=aPWKCKhjW4r1A5NhTQyYsXTxkW6icm037B651Uk5rdmw/Tp+PDO0fo3c5OtT35nnj1
         3vPsM6wRavZzSrrpiFBIP24SVw9b98ZKvmeafMISVaJRffqRFtNJJOK/f90OX+9Ci41L
         G+a5/vFcbDdD7xqrlXZNhWrYk2sRPMvk5266LY5vTbx/tr8QkdhxiPB6fpyGthXC7hme
         jgoCJNeunxWZ3NhFpf+SoanxQ+Nm6OmU2SFtyXDmwqWOV8VaRDekLHikJT++SsCEjsEj
         Kf0Y+r2mAFDw6arihJdF6WC/UHFpPTeC1JXYsYVjUXS9FcpeBzb8lcFI/MxGOi4zZgjq
         4VFw==
X-Forwarded-Encrypted: i=1; AFNElJ/TYOzpCaLjK+R9aaej7mewfeIs/uTtWyl7BdUgOAvaR1TJQejHPosoVT3Bm0nVEUpxm4gp@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3xcTg/F+LouiJIgPa+x0h8OKo1wa41Ic1s1quLONx5siAoBaW
	g3nEc9Yt9iwyyAeUmH9OF9hEFDJK8jwQEntWCIw+kFIZwzTi5lHrXCfs1g8L65jReZc59613lLd
	/ZVgNBCRW9U70tp+dP8pR03zSCCXuTAqAWWNiIzxZMw5bCaANYy8FFI7AHhnYnWvhU/N6tQX9wu
	gp4GDBF1+gD1shzspiJasFi31TKG4W2Q==
X-Gm-Gg: Acq92OGZQDeWMbhq++Rhw7VQ0p/h7yQ/O9iuyy5dnhBTQyrUkOLNoaeNso5jutux+5h
	oRjxfVzjVEGhPPtVl5Yr/NLJllII2uzteVeTtrhdQ/Xr8TnS5hrBQgmkVfTPMLLQRfG6ixuhWed
	f1ocyI4VnIGqPh+50E4ZGDZHoKalTW6B71h/Y5HX872KEy2Jv8Ok+Xs5Z51l2CQm8uen33p9dPb
	XS6ew3Y4xD+RvPHx07utnV5f/Frn5tfejThOyP98z8R4UQ9DC4=
X-Received: by 2002:a2e:bd16:0:b0:38e:2aa7:398f with SMTP id 38308e7fff4ca-395d8c04ef2mr65433001fa.7.1779803923920;
        Tue, 26 May 2026 06:58:43 -0700 (PDT)
X-Received: by 2002:a2e:bd16:0:b0:38e:2aa7:398f with SMTP id
 38308e7fff4ca-395d8c04ef2mr65432851fa.7.1779803923467; Tue, 26 May 2026
 06:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517020315.1064253-1-joseph.qi@linux.alibaba.com>
 <CAK-6q+jvaQx6y_tOzks3utBWaTRjvVnDWrznBYRfWjTQBcefBA@mail.gmail.com> <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
In-Reply-To: <CAK-6q+iC3AgX7r2fZkvDJHibS0oqTwVCF4ZgV-1OFkV0d=R2Vw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 26 May 2026 09:58:32 -0400
X-Gm-Features: AVHnY4J_iE3RNm44kYnCCsqUub_522TQSYF5H1EgU4wiZxsnHkrUmEyvRRE_G8w
Message-ID: <CAK-6q+hPM=+fXkPSbr60Y6S1O_RfYGBUeL3mfVu0H1ymZ0gp6w@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: fix buffer overflow from negative len in dlm_search_rsb_tree
To: Joseph Qi <joseph.qi@linux.alibaba.com>, cve@kernel.org
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gregkh@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0IW5ZZ_sO6LLgvE-0phjtlBlkhUdMCdm1V-74xLMifw_1779803924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 25, 2026 at 1:39=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Mon, May 25, 2026 at 10:27=E2=80=AFAM Alexander Aring <aahringo@redhat=
.com> wrote:
> >
> > Hi,
> >
> > On Sat, May 16, 2026 at 10:03=E2=80=AFPM Joseph Qi <joseph.qi@linux.ali=
baba.com> wrote:
> > >
> > > commit 080e5563f878 only checks for len > DLM_RESNAME_MAXLEN, which d=
oes
> >
> > check with checkpath, it reports an error regarding how this commit
> > reference is done.
> >
>
> This also addresses CVE-2026-43125 [0].
>
> - Alex
>
> [0] https://lore.kernel.org/linux-cve-announce/2026050619-CVE-2026-43125-=
c9f9@gregkh/

cc the right folks cve@kernel.org as described in the kernel documentation.

There is another patch required for CVE-2026-43125 [0].

Joseph I think for v3 you should cc also cve@kernel.org and mention
this in your commit msg.

Thanks.

- Alex

[0] https://lore.kernel.org/gfs2/20260517020315.1064253-1-joseph.qi@linux.a=
libaba.com/

