Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EA26C391
	for <gfs2@lists.linux.dev>; Tue, 28 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646084; cv=none; b=Ji4HAsCHndWm4oTAKo55W11KNKUsgGAhlbj8MkpwKlgT6Z46CkjjiOyu5JFsTL5x/iUDnV455kCduBAi1rm/BQkQclas8fHCfHQQ0TF0Wd9oI4tM4ah2s0EVxB9oMYQXhwrhPTK6r4S6/6vX3kDjRYSKqc/rfGv/afW8PP03PHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646084; c=relaxed/simple;
	bh=GqS5YZgkq8cny8rkJuSXt0cOfrho4136xi4TMhibHPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMC2PhVWzPvKo82fC8ueQFssQtbKSLBURqWND5NlFlSuIizOwm/XuHs0H9cGXRNfTSUIvqCK02yHDGLF3G1TxB/SgvjgmGw5CpzrUQ6LlbDNJmJ2NifJWbmdkVkVAtPS/gqjIKtwpTpHpCxjPWbIkyE1CNL8Mast8h8ubr2zZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akVvOOfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akVvOOfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761646081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xj8LBCzX8LJmWzMdp8W85zEkAFig7TXNyDoN0MesWYw=;
	b=akVvOOfXQcAkPR/7nxj71U0zmxEJwnQ8ILDj85GLKB7v2NNCaQZor209qXErOU3r5X/AcA
	RK2IdmtzDjFIzLunZJOlkOscP2PUDUXbYGeB2uQ6F9vHkXkN4x5C8i9+kUowQpD0z0pTSr
	caF7IgTcbpjbAs4/6If04KS/aDFTnbo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-bFd6v-NyMo2ixlPJ2TGUoA-1; Tue, 28 Oct 2025 06:08:00 -0400
X-MC-Unique: bFd6v-NyMo2ixlPJ2TGUoA-1
X-Mimecast-MFC-AGG-ID: bFd6v-NyMo2ixlPJ2TGUoA_1761646080
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-785ebbc739bso45717117b3.0
        for <gfs2@lists.linux.dev>; Tue, 28 Oct 2025 03:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646080; x=1762250880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj8LBCzX8LJmWzMdp8W85zEkAFig7TXNyDoN0MesWYw=;
        b=QqCai/2bTEVPZCmBkgqS/vQXAbLnV7X8xfA4kI4Y1HrKJhMkfxsK+BYIUzpLonTzsG
         +OepliOIvkJBvbEF0w70aXqphB4VCRCynoe/bqTkq8JjflbN25j7Pjhuz88t/vO4VqYf
         NhMbeFQY7slXmtdWA4u3/MrDYF7izuLcO5smM7GhVend3kO+BOe6QYOfwe3fQbeUxEbc
         oBwDu43sXC6hUsVDYhf/ooFPrPDSlElFysyPQincuGWD8MKdf0Rd4iMSsaCYxFgfML2q
         f34088fXoRYqIOb3yTRdmUhkwuMZonR2Cl1gIxihiamOwZDoEXW/ppckrAZPx5m5rebJ
         Px1Q==
X-Gm-Message-State: AOJu0YwSD+E3g2FHlym2AhpHebQXQHb8y9MBrUbEbm6VjrgtFHDAKvQ2
	IgFhyaD07kIVWUbi5NsuvhdU0JBS2ibOS3ZgHGp0Fz3yUqg+lLpBTKC5EMczVfAPQLzAwSvME5R
	7avoBjf3kEqftOxnyJGENbLuAFlLkNCGAJE/J+kVpHECGS7J7KgMNNrvWbcseo/BcPBupwHy/tp
	t6yWBz+veenR9fvOpWJ4wR+uBgDkPkBA==
X-Gm-Gg: ASbGncvjxZ/xwbI6LohBKLVSyEIamotI9XWUhZu06KhT2jyqF8om8TjVCelhBP8axwX
	GZEBdj8EbqLrGg3YT1o8AnZyLsMSwunMi5oiWhrxRDsyEB+oHfqSnQavYatimz2CA3s7KqTOVQJ
	BSE45tDrbdqx2K+IZyJgzd9V75BEb/Qnj3P8FkqQFlQuh6Xg3M4eUsig==
X-Received: by 2002:a53:d007:0:b0:63e:22b1:21ba with SMTP id 956f58d0204a3-63f6b92f77fmr2414441d50.7.1761646080093;
        Tue, 28 Oct 2025 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFx/GfvxsfTd+6dhGpIu93wCMrLMghQK4gRq00glwICMhgo0YRDanztGVVvNApzngH11UOdDJf/aBvqoRGVMg=
X-Received: by 2002:a53:d007:0:b0:63e:22b1:21ba with SMTP id
 956f58d0204a3-63f6b92f77fmr2414424d50.7.1761646079789; Tue, 28 Oct 2025
 03:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251027110041.426022-1-hsukrut3@gmail.com>
In-Reply-To: <20251027110041.426022-1-hsukrut3@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 28 Oct 2025 11:07:48 +0100
X-Gm-Features: AWmQ_bkz6SxHJddTnDiI4TmSykmKugAy99eWur8qPyHRD_vTfTlIvGnmY06clos
Message-ID: <CAHc6FU6FanLe+b9RX=Lao2MQ2JOJU3JKNOsTTX3NUzNNzWfuAA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: document ip in __gfs2_holder_init kernel-doc comment
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: "open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, shuah@kernel.org, 
	david.hunter.linux@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9W3vV7Tqdlrt83FzpIlGNvnCCqZEd-I140mV-QdMt64_1761646080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:01=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.c=
om> wrote:
> Building with W=3D1 reports:
> Warning: fs/gfs2/glock.c:1248 function parameter 'ip' not described
> in '__gfs2_holder_init'
>
> The ip parameter was added when __gfs2_holder_init started saving the
> gfs2_glock_nq_init caller's return address to gh_ip. This makes it
> easier to backtrack which holder took the lock. Document @ip to silence
> this warning.
>
> Fixes: b016d9a84abd ("gfs2: Save ip from gfs2_glock_nq_init")
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  fs/gfs2/glock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 91d0afec4087..bc6f236b899c 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1163,7 +1163,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number=
,
>   * @state: the state we're requesting
>   * @flags: the modifier flags
>   * @gh: the holder structure
> - *
> + * @ip: caller's return address for debugging
>   */
>
>  void __gfs2_holder_init(struct gfs2_glock *gl, unsigned int state, u16 f=
lags,
> --
> 2.43.0
>

Applied, thanks.

Andreas

