Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C01DB124
	for <gfs2@lists.linux.dev>; Wed, 12 Mar 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781189; cv=none; b=kPLnK6WRlV3gRBznG3ukBVw7n06DTE23aBlN6NaJJG7WdNGlLtcoEOFyzykarNd8I3ggActAvs9zLTzXEJYSl9NQ/jQSXVrfD2z9is5pLuprO5cVR6QcqMQWgXb+KMwzw49La+XsdXcFEZPWM9aYdSqyDBGCyxmT6vYWmUTsgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781189; c=relaxed/simple;
	bh=xypOKUIiqk37jy40fQBLrtEj4ywFYn2sLMjN0PvYc7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMp6tnWbWP2C/QhgkPHyR/fdJ1CIawVwGfnshX/853A1lw+BNOx71WXEjREJXc0cj6tNn7v7/Pg8JgsHoDsRkWCMVpAbGRKmnWZYVT4dFxip7RI8kkPWUWsW3k3p2e3H9F9AmU0rBo9iT4OE2/EMnGet+zNj0e/ihVtBUpkBlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpwylycg; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpwylycg"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b58d26336so228549139f.2
        for <gfs2@lists.linux.dev>; Wed, 12 Mar 2025 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781186; x=1742385986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16gsqJtrWLlbGGVWtxUyKdKAGo91B2+znh+1e9ptq4Y=;
        b=kpwylycg8arSkroWmbEhxrlOln5FXDNDeUKshYRBbXVPx5kXhFZQIPbQTPYOL+222d
         AiVVEJwfOEL7ZpyR40khPEihGSdJAdTAa/f1YQM8mBZqefrXFBefzd0vwo4+h+hetALl
         bu1OuW+4qIoyP5r8/NXA/0Dm9No1MCcKJrlFqZOsWnLG/zOFq/1AdNlJyF4ZwHezdfD8
         ZIXANhNYk6biH2OWz54ddMppcyHEuhCBYYfGhgUY6LHS1vwrpukx2i2jEv1pfdxbnb0P
         9UvHp7tTIT0vCNx5es6A/ATFJIdBz734wBbd7d5Ke0Rr4Sp4iowXm0PyYj8kvmqUgusk
         S5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781186; x=1742385986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16gsqJtrWLlbGGVWtxUyKdKAGo91B2+znh+1e9ptq4Y=;
        b=nu9LOfUTSQSwRGC838p6nt3Rn5xzchf5BupMrPJZpoyUxpChmKTMc3F/+hTQj4AMF8
         s7LWUGskmAVagtbO0Fd9JdF/ohhs8vay6vyAXAiNUlFkMaGvPP6T3m/wUokZRWOiPd02
         pYYOMp8uvcLHCoVLdDq9JwgXHheTLADEz7XLeMBKybui4/xI9clqTrxspfS4VUFhI08V
         XfROJwrW289zKS1dJsOkTVcAvg+PNAYjyjpW6qLbKI6EVNLDo2r3lPHbwooi3YpY9giS
         MyazTUX8B1FIpApifAKgIzjw++2v6+q7X9lkmUQMS1BuWU1ai1q+o1kf/uAY7aYLyk+D
         9sGA==
X-Forwarded-Encrypted: i=1; AJvYcCUvjK1bGwnjDFQak/43SG+xbuq7cbAh1MJrQkY7l5+PEovTJZCwKm8F5JHuYLOxO5audbBb@lists.linux.dev
X-Gm-Message-State: AOJu0YzudWfFgKY3Tb/0GGWYzR+cNtJYInDthZehwD1M2Z7DQ/V51dQP
	dS8rAUo0Gl3T/vAupKeEYiE1IQv/6CB2zbNJ6Ae8OyWZbJZUPPevVTfVBdh8PEvrt3Q49cWfkAo
	Njhn6L0e+xHnIwOwNHC5KA2AuUlIILA==
X-Gm-Gg: ASbGnctU3cmV8PRWRAhuEpW3anfiGJswxE139zHSiZurgLMqrRkRodJ1zBgo1xn1v5s
	SWyPuPQpYS8DIppDeCY0L2F2Y6fDjRgSuCZRowiER8S4H5kfLCVkYoJwIuehqGvGNYW03umqYPh
	TOvTN4p1EKdBT6ixjE8Wjb3wcR
X-Google-Smtp-Source: AGHT+IGEsF+C5/vNm1H8T7WVPIYrmKDWuNPTJo1w2pmsEdpJ5Y2WsTAbWNetSHDpvj9YFbr4sOBl42eeBtR/jJ1a3Xg=
X-Received: by 2002:a6b:f20b:0:b0:85b:35b1:53b4 with SMTP id
 ca18e2360f4ac-85b35b158fcmr1451553539f.12.1741781186554; Wed, 12 Mar 2025
 05:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
In-Reply-To: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 12 Mar 2025 13:06:13 +0100
X-Gm-Features: AQ5f1JozYbhjkOmitxRJRrSxuAPTbJrtddEsFZS-Y5mUWrui6-xHADVYvGOMyYI
Message-ID: <CAHpGcMJ4HTSRzqEWpVDDZi66Y86LRKCob9PAkMFfZBWdpUDU5w@mail.gmail.com>
Subject: Re: [PATCH next] gfs2: Fix a NULL vs IS_ERR() bug in gfs2_find_jhead()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 12. M=C3=A4rz 2025 um 09:33 Uhr schrieb Dan Carpenter
<dan.carpenter@linaro.org>:
> The filemap_grab_folio() function doesn't return NULL, it returns error
> pointers.  Fix the check to match.
>
> Fixes: 40829760096d ("gfs2: Convert gfs2_find_jhead() to use a folio")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/gfs2/lops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 3853c422040b..0fd3b5ec7d8c 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -530,8 +530,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>                         if (!folio) {
>                                 folio =3D filemap_grab_folio(mapping,
>                                                 block >> shift);
> -                               if (!folio) {
> -                                       ret =3D -ENOMEM;
> +                               if (IS_ERR(folio)) {
> +                                       ret =3D PTR_ERR(folio);
>                                         done =3D true;
>                                         goto out;
>                                 }
> --
> 2.47.2

Applied, thanks.

Andreas
