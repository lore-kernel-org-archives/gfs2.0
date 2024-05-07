Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD7AD5D
	for <gfs2@lists.linux.dev>; Tue,  7 May 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078641; cv=none; b=Goooej2mZMRd2LYzVpRzzF49PR6gfcwmZs4+7ayItqUpYvGlJrq9J5ADWinvxRMYd5VXK1RvaaBsyrMd3H5rgOznowySTtkky5zOjuk02Nm3VVyTpLA/+cdKaGKAfUGYyxR1wZWrF/BslkcdMgQvx38jQLiT5+bLmzuQOXf/+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078641; c=relaxed/simple;
	bh=R6/ghx+oulXLj/O2tORcTmOhs43cmHl3hPKomAh0IY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WevzNT08h5P9ZWVrzT4h7U0kxo41mqVnZSGWAWklt8Cs7uMGhkCEQRRGVxfnfMHL12S/4MhwlmkRNF6Y4itsN0ton2VAeR8/08jW4JX00374b/tK03KHSXV6OxHD7ALjhxpjpK2w8UWTioKcoPFZQowdEASM8vlKs3Cu74ptCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3D2EszP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3D2EszP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715078638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3fM9M0o1zX7/Jphueg0GnHxDtD9oKmu56hIjicWK1w=;
	b=B3D2EszPg4ZEM5Dmj9CDufck3ss6lekAWh5O+LiiqXMZHrfFsQoDhW5hILsPyBEq/HdR8v
	gI4CKpUZbJb5JztOjuJ2OLwx+8RWsZkKFVZSJfwVha5SEzrSa1g9USFPgaGMXIEecnQGMP
	Hpp5U/ODImd7XfEtfarmAss53PMVWLE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-OrbsHa7iNn647zHPYKMceg-1; Tue, 07 May 2024 06:43:57 -0400
X-MC-Unique: OrbsHa7iNn647zHPYKMceg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ee3b4f8165so14480295ad.3
        for <gfs2@lists.linux.dev>; Tue, 07 May 2024 03:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078634; x=1715683434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3fM9M0o1zX7/Jphueg0GnHxDtD9oKmu56hIjicWK1w=;
        b=vDNk8a+5/1flfHCO9ZCdm40WL/oSTbP+qhYoGYSK1r1ZCwXzeL8S4TqgjFz0pnhMiY
         QD/5rBKipFV8ZbUg3cIarq8NSyCsYz3s/n4Jr/mY9gzABKLI16CGTYYiOYtDxD4evXbj
         +VOdA8lvXHvqX4Oa4keAo/ErM7wpGsZUQwlhxdiWKkiq0kVGKBlCD9ErU7jme/mPVG77
         NBNK8A2WPAdt3809ZYLN4ZRb8dd2RanYyYsJy16f7KqFDQGtX3cGiTXY+EsilBwJbKvj
         tyKIPhcK1MMxRS6Z5b6VKONNkC4Z79PltkksQTY6rBfdoxLwHfZM4ZdY3R7Ncu8+9Zv0
         WDUg==
X-Gm-Message-State: AOJu0Yx04G+dErRFRoCjDMy2CCsKLYT3Aq/ZPLJLidSKd+3FKYbMoULM
	73yVhB4dVqGSYDlxFagbGtFozbj3642eYh06KFdWhR4WKY279j6zKqKE7JD0Cif9VPDDjuu8LTc
	4E05cSKVQq+tX8AgZFM8znKF0otfWdyY6p5C4NgTqccwMAJEoI100k5n8sHkY/XglXN/nCM1tsI
	2r1CqxC7wLMZxgTqBm+TJUUJP6ieMHVGCYHg==
X-Received: by 2002:a17:902:c947:b0:1e4:a667:550e with SMTP id i7-20020a170902c94700b001e4a667550emr14538051pla.20.1715078634194;
        Tue, 07 May 2024 03:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkqE7h3Ug3DYCUm3XLSnnG2LnyiQsj6L93HVfEkmFxKoF8scBOzOOHirbMZH0WbMIBnLnxvLclzYIESThmG0E=
X-Received: by 2002:a17:902:c947:b0:1e4:a667:550e with SMTP id
 i7-20020a170902c94700b001e4a667550emr14538037pla.20.1715078633785; Tue, 07
 May 2024 03:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507090448.8043-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240507090448.8043-2-wsa+renesas@sang-engineering.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 7 May 2024 12:43:41 +0200
Message-ID: <CAHc6FU4HqrOKqmJgYhERNbb0tWzsmp-0wfKgh1rAsC7-3HNR=A@mail.gmail.com>
Subject: Re: [PATCH] gfs2: make timeout values more explicit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:11=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> 'timeout' is a vague name for the return value of wait_event_*_timeout
> because it actually returns the time left. Because the variable is never
> used later, just drop the return value. Since variable 'timeout' is then
> only used to carry a fixed timeout value, drop this in favor of a fixed
> function argument as in the other call to wait_event_timeout() above.

Sure, applied.

Thanks,
Andreas

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  fs/gfs2/super.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index e5f79466340d..6d0265ebb9d4 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1261,7 +1261,6 @@ static bool gfs2_upgrade_iopen_glock(struct inode *=
inode)
>         struct gfs2_inode *ip =3D GFS2_I(inode);
>         struct gfs2_sbd *sdp =3D GFS2_SB(inode);
>         struct gfs2_holder *gh =3D &ip->i_iopen_gh;
> -       long timeout =3D 5 * HZ;
>         int error;
>
>         gh->gh_flags |=3D GL_NOCACHE;
> @@ -1292,10 +1291,10 @@ static bool gfs2_upgrade_iopen_glock(struct inode=
 *inode)
>         if (error)
>                 return false;
>
> -       timeout =3D wait_event_interruptible_timeout(sdp->sd_async_glock_=
wait,
> +       wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
>                 !test_bit(HIF_WAIT, &gh->gh_iflags) ||
>                 test_bit(GLF_DEMOTE, &ip->i_gl->gl_flags),
> -               timeout);
> +               5 * HZ);
>         if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
>                 gfs2_glock_dq(gh);
>                 return false;
> --
> 2.43.0
>

