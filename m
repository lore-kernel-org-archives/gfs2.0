Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B636084
	for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjfNK2HW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703167901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmpbR4zRGyIfWBWmW3TWB17Ci3rGfKoAnT89Zuwgqao=;
	b=KjfNK2HWMMFPqVbW0kX02LqRYnc760MBx2Oxil7OjMiEnMQnrW0tKQaxhaeYfIGpD+MJVI
	Ban9Ulb25Th0HyOaYHvGIpfGbHAqOGyZximzSErMZsGuU2P49GvSuY6/4l6WQdJvte4wdt
	9tF9Zy/pSxWnKyir2SuIXY8IChKErbA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-pWFmOB27NCSELwjNcdwS_Q-1; Thu, 21 Dec 2023 09:11:39 -0500
X-MC-Unique: pWFmOB27NCSELwjNcdwS_Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so261628a12.3
        for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 06:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167898; x=1703772698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmpbR4zRGyIfWBWmW3TWB17Ci3rGfKoAnT89Zuwgqao=;
        b=OUodUfSwJ7pEihAEbkvxiHynBCL3ObKNKjqthADNayXcvo4MzLtnPxwBob3HJveHw2
         sQAeB/s14BkjdfbV1Q1LGstLsXtpe/qxL2bZQkAzdHig9MI+bRwwQvN39EnPwmfOt7Dy
         421CpydTEQCrMbVdLd6c2C7zpcGk/AFRqYrvAJYU3uGnqdGV8HUIzqpbU4kS7xsJltP1
         4JlwX7kZA9YVPY36+FLmDbi4+hrUmnu05B9PZoJdv8ApjHU7V31vTIyj4TEXno1Hd4ks
         ev1UcC0isFykzL3owKpxo5ZkjS54hmm6PYb/fOPQvjdguVqUSMLJyS8bammdT/q90/Wv
         ShJg==
X-Gm-Message-State: AOJu0Yzq4yT5tqra+xHeqnGu9P0GPZ84IobG2o4ifewB+/3nZ1jRGN2Y
	yOVtU7QGb4WsM59t3x6nOB3U54gwwKW6ZO6t0QBkLCvnbPRzrY0FBhUtvoh3Umso8CI0N8qXBo1
	IOhbl8QG7pYDSaa26Sa7Ja/pLHfYUFw==
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:1e6a with SMTP id cp9-20020a170902e78900b001d06ffe1e6amr13169408plb.77.1703167898613;
        Thu, 21 Dec 2023 06:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrmQ7AphNiGOI6sScviIQgDZwQpEoPAwYbzLtgmXILJaxyuzIa63kNWUED6YdDLexPci01nEJ6o+R6SIO+CFw=
X-Received: by 2002:a17:902:e789:b0:1d0:6ffe:1e6a with SMTP id
 cp9-20020a170902e78900b001d06ffe1e6amr13169395plb.77.1703167898304; Thu, 21
 Dec 2023 06:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231218053558.1200822-1-haokexin@gmail.com> <20231218053558.1200822-2-haokexin@gmail.com>
In-Reply-To: <20231218053558.1200822-2-haokexin@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 21 Dec 2023 15:11:26 +0100
Message-ID: <CAHc6FU5MK7zN36tsY_4YMuKxuo1yRuCgh4D4YSUR9OgjJ6vECw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gfs2: Use wait_event_freezable_timeout() for
 freezable kthread
To: Kevin Hao <haokexin@gmail.com>
Cc: gfs2@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kevin,

On Mon, Dec 18, 2023 at 6:36=E2=80=AFAM Kevin Hao <haokexin@gmail.com> wrot=
e:
> A freezable kernel thread can enter frozen state during freezing by
> either calling try_to_freeze() or using wait_event_freezable() and its
> variants. So for the following snippet of code in a kernel thread loop:
>   try_to_freeze();
>   wait_event_interruptible_timeout();
>
> We can change it to a simple wait_event_freezable_timeout() and then
> eliminate a function call.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  fs/gfs2/log.c   | 4 +---
>  fs/gfs2/quota.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index a268b69bb636..20059fc913e7 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1331,9 +1331,7 @@ int gfs2_logd(void *data)
>
>                 t =3D gfs2_tune_get(sdp, gt_logd_secs) * HZ;
>
> -               try_to_freeze();
> -
> -               t =3D wait_event_interruptible_timeout(sdp->sd_logd_waitq=
,
> +               t =3D wait_event_freezable_timeout(sdp->sd_logd_waitq,
>                                 test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_fl=
ags) ||
>                                 gfs2_ail_flush_reqd(sdp) ||
>                                 gfs2_jrnl_flush_reqd(sdp) ||
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 173581736a6e..05ef8409b614 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1603,11 +1603,9 @@ int gfs2_quotad(void *data)
>                 quotad_check_timeo(sdp, "sync", gfs2_quota_sync, t,
>                                    &quotad_timeo, &tune->gt_quota_quantum=
);
>
> -               try_to_freeze();
> -
>                 t =3D min(quotad_timeo, statfs_timeo);
>
> -               t =3D wait_event_interruptible_timeout(sdp->sd_quota_wait=
,
> +               t =3D wait_event_freezable_timeout(sdp->sd_quota_wait,
>                                 sdp->sd_statfs_force_sync ||
>                                 gfs2_withdrawn(sdp) ||
>                                 kthread_should_stop(),
> --
> 2.39.2
>

This also is looking good; applied as well.

Thank you,
Andreas

