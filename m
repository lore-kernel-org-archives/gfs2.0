Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F7194A44
	for <gfs2@lists.linux.dev>; Mon, 25 Nov 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534459; cv=none; b=Z25B+cEtjHjgMWrShP/p2Oh1ckzxYiy8M+eWO4YhaAXbyWiCnUcNNXAt1c+Qa4txTVTzCWCst6YvZAolLGJpkZy+kQU2bvwMwOcxkh/aGZeddySByPcU5nCrXLbjZ2P+4i89xmqeT4HsQAxIQL1tTg9aeXiWNrDU4hZQeosSqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534459; c=relaxed/simple;
	bh=oKiIL23t9JON49nCNZT6Ou8nEPC13GPtL4HwJhWTs4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRq9uNRhKO/UpFIz4RltLYAJhTiR6eF9T6wMjFzjy7755o2M761PEzPkDAhCh6/KHbUHl0G5SC4gGO46SCr1sfrwpqJJiorGKVOocpWHLWVWW5/y8ui3YhAF1iv+UoRZrUf4K0WhYZ+OLYHevOKPwStjmxIP22g/FIAKEybOT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReKwAG6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReKwAG6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732534456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
	b=ReKwAG6xggBXaHM0846BJLqrG1U3HtaIF6bfC1jba60opx5dw2+TDs8ph7rrsgYIQBRygm
	G31BUmR0nuumOQGhPzE9dwfIsDvIMDCZVfbAXdYYkGu9P0wK9R5eqJH+etgxbyOAkDF2HF
	5Ok34sL08A9NdYzQTpyrgxyNgY3pLAE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-CnvgkDW6NgGb3cN4dsRr6Q-1; Mon, 25 Nov 2024 06:34:15 -0500
X-MC-Unique: CnvgkDW6NgGb3cN4dsRr6Q-1
X-Mimecast-MFC-AGG-ID: CnvgkDW6NgGb3cN4dsRr6Q
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2120c877e75so46203555ad.0
        for <gfs2@lists.linux.dev>; Mon, 25 Nov 2024 03:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534454; x=1733139254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
        b=Zv2EUFl3WNJtU4F1xQZALelduXTQ68hv5ICNdnbf+rcokKcILAI7FLGFup+nH7OkF/
         EPQXAvN1gCDnJx6vZNNk1ni2XQ6+qroSBQC6laTU2dooegxqryLnLuMJrqWRUfZ96Azu
         DdIbc4kbgtEL3mKtGxnVLad8caZGXC9kMUEdP/xdtx1ZqBgqBDDb53g68QJIk0u5EZN7
         W7EyBPARvpwV3/+Z2qwTZYomdiwkqlA4xPtNZsvhBGFfKq2caDwrha7WjDh7snhVC4Z9
         bNWPRwJcnbYiDcloOckkgr9vs63FbdumViKZuKl5y8xFF1273388lbjBaE0vhKnrb+N0
         wpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN1mcSAEj5xVGIbkBI7y3mjEjCZL9QXe7A3Mkl/GbCM6YOBYH2pF9oa+uQ100MAYM4DbzH@lists.linux.dev
X-Gm-Message-State: AOJu0YzS+8sC3xdLyfLMN+/joRE+AVAELtzirTpAyGsylMWxjHmJvPzj
	38vtE6Ad39Fj/vJODG+F69kTVGZ1Mg+fX2NbQLjNCyyYV1CnGCJTYtIQ65BXZ5wnv6CQILtrWaA
	OEDFJWZgdr7OLesjxTW+8m7Qy6t1g1JT2SVzCfssoM/V5jw45uLDq+NfrMf9fNbP5Ca7w7o89XG
	E4wwB4BeN+yMxM+mr7ycLxueoCdQ==
X-Gm-Gg: ASbGncufllMip5PXJyxNF/zjOa8mmCxhEEz0e7SCmKG4OcrHgogNFnz7EgRSz8mdvZi
	Lg9mJrDTRfWQY3Dx4wRBNqUjfNtSSsQ==
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id d9443c01a7336-2129fd0fc42mr208252785ad.24.1732534454153;
        Mon, 25 Nov 2024 03:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHblig9i49prrqDlUeZETVKtu2gFAI4HQKWoBxXGngksx/l9PRt93GGuLopiLDUeU5NzeAE1cUQ0J/uiU3YMRU=
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id
 d9443c01a7336-2129fd0fc42mr208252465ad.24.1732534453881; Mon, 25 Nov 2024
 03:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241125104011.36552-1-cgoettsche@seltendoof.de> <20241125104011.36552-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-7-cgoettsche@seltendoof.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 25 Nov 2024 12:34:02 +0100
Message-ID: <CAHc6FU5t0cB=+9ijwx26NUEck1YS7304ue_5FRwqXRzBq14jjA@mail.gmail.com>
Subject: Re: [PATCH 08/11] gfs2: reorder capability check last
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, cocci@inria.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1QkW8XngutFTh4ZQVhol7zgGFezg-R6ddhKpEZq7w3E_1732534454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  fs/gfs2/quota.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
> index f462d9cb3087..988f38dc5b2c 100644
> --- a/fs/gfs2/quota.h
> +++ b/fs/gfs2/quota.h
> @@ -44,8 +44,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_ino=
de *ip,
>         int ret;
>
>         ap->allowed =3D UINT_MAX; /* Assume we are permitted a whole lot =
*/
> -       if (capable(CAP_SYS_RESOURCE) ||
> -           sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF)
> +       if (sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF ||
> +           capable(CAP_SYS_RESOURCE))
>                 return 0;
>         ret =3D gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHA=
NGE);
>         if (ret)
> --
> 2.45.2

Applied, thanks.

Andreas

