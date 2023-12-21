Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918926D6C4
	for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0cbWoGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703167830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlVJnKa/yWhQ8C8K+JZ2YshQ+iGXn7Ia+DVE3ZSzFGE=;
	b=Q0cbWoGTAK+z4R7ghV02tK/hRPSJQRhrvAhdWENZ3gIhfHvPnSqNzWET0GRfxIhXTevUBF
	D4U6iT/52UylSFQ5VSSUs4guSg43LjBR9IFVBRHKVlzWxatdW6pzoF3L5HC7w7pcC/9+W2
	cCO01EbKeDguPa2EETZSnIse87OH2Jg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-OCXJGC_XPbiuJhuhGotn9w-1; Thu, 21 Dec 2023 09:10:28 -0500
X-MC-Unique: OCXJGC_XPbiuJhuhGotn9w-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cd61dccd77so437536a12.3
        for <gfs2@lists.linux.dev>; Thu, 21 Dec 2023 06:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167827; x=1703772627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlVJnKa/yWhQ8C8K+JZ2YshQ+iGXn7Ia+DVE3ZSzFGE=;
        b=ry0pLgHGtbLGR5we5FQ3beRiUnb/3C/Sr6d3RtICdD8aF1UTFJjLA1wPpuHuwunBAU
         yd4NTda8G0/yhGt2P1uwjt8I3/0UYHOyUxWfeiZQIjHzPfcrGCT2JZQ/4cauarXN4FUB
         2CF7j/82aTDV73R0Gqjr89WbW1cZPRrB0sqDUrPrDQdNif8uOOFkxMpawBHrw/DCUeZl
         aGLOfh0oEszevGhqtFYSehWmFl6/IaqLJljL8nmp1XyMUv4Mj+GYS5zfRNXP6cfR8yXC
         vZWkfYcVxtcJFtHQWYtLI+OmXd1803mv0F6esk2b1GrseipON6Mum0Im5MdLXqKphyyQ
         Xsgg==
X-Gm-Message-State: AOJu0Yxd5ctHqKBE12R1ivjpaLbgX+4xLv0RWwql2tGbUXGoV1QIX1gm
	rZGnGJXfhl9vc9A6Hw1wpmYQaNLHoaJvEJlvq8IvNoTtw0ZyAA2jRY6g7WNCDk1FvxcCyC0KiJl
	zYFkCom5MgX2XPUKxh+yf/oClqZgNzg==
X-Received: by 2002:a17:902:6549:b0:1d3:fada:b5e8 with SMTP id d9-20020a170902654900b001d3fadab5e8mr1192000pln.4.1703167827658;
        Thu, 21 Dec 2023 06:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZ6imbcNnwWmt9JtxcmK35hxltCND/m1D6h16cvFFeSk3+9z54jfnkdkeoblDhLJKAH2enrYfTybRF75hwHY=
X-Received: by 2002:a17:902:6549:b0:1d3:fada:b5e8 with SMTP id
 d9-20020a170902654900b001d3fadab5e8mr1191990pln.4.1703167827324; Thu, 21 Dec
 2023 06:10:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231218053558.1200822-1-haokexin@gmail.com>
In-Reply-To: <20231218053558.1200822-1-haokexin@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 21 Dec 2023 15:10:15 +0100
Message-ID: <CAHc6FU7DJkL68oD5we35mgO7fOAptmy1G=d3XrgHjBpWSWaVGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gfs2: Add missing set_freezable() for freezable kthread
To: Kevin Hao <haokexin@gmail.com>
Cc: gfs2@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kevin,

On Mon, Dec 18, 2023 at 6:36=E2=80=AFAM Kevin Hao <haokexin@gmail.com> wrot=
e:
> The kernel thread function gfs2_logd() and gfs2_quotad() invoke the
> try_to_freeze() in its loop. But all the kernel threads are no-freezable
> by default. So if we want to make a kernel thread to be freezable,
> we have to invoke set_freezable() explicitly.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  fs/gfs2/log.c   | 1 +
>  fs/gfs2/quota.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index e5271ae87d1c..a268b69bb636 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1297,6 +1297,7 @@ int gfs2_logd(void *data)
>         struct gfs2_sbd *sdp =3D data;
>         unsigned long t =3D 1;
>
> +       set_freezable();
>         while (!kthread_should_stop()) {
>                 if (gfs2_withdrawn(sdp))
>                         break;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index fa47824acf13..173581736a6e 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1583,6 +1583,7 @@ int gfs2_quotad(void *data)
>         unsigned long quotad_timeo =3D 0;
>         unsigned long t =3D 0;
>
> +       set_freezable();
>         while (!kthread_should_stop()) {
>                 if (gfs2_withdrawn(sdp))
>                         break;
> --
> 2.39.2
>

This is looking good, thank you. I've applied it to our for-next branch.

Andreas

