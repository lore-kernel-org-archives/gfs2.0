Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D61F8BBC
	for <gfs2@lists.linux.dev>; Tue,  1 Apr 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507305; cv=none; b=GG4R2OCfJ4yUkqqXnSm7qZuweNkA3jziJaewiuldPkcZVr4JKy62P55CdB//6l4rj4Z0+TCvT9U5I4eaFi1+AunXB2Qy2ZuopUlp4WDp7mxPI/FvVpaTwL/kFpuiof0i6w0+zaKLWnhRGepd1Tta6CyJeByF4BZ58UHjKSPxkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507305; c=relaxed/simple;
	bh=lAEC+Pf5uytHLCbc/4PM5Z7g7tEIjr/2/EY3vxgSUVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrwXBA5h6T/WxWUU9tcKRqRwFb1dznyP7MFwC1OU7ofPaJ2Fa2pprGz0W4kI1obObgqlpYsbaCgDRKoVRGBxYOsgEXcMCVA6htFjrSrrUF9bkFLWsOf1EDaJBQx6GYgzY595s/GOE2r1UkgEFidUcFi8qS5m/mhuF8VAPJNfOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTn3EeX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTn3EeX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743507302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF4YuDd97kbH9h4b0Huy41NC1nIWjQbGUIb1cXKzuDs=;
	b=YTn3EeX/GWjNmfvd0G65lj3cjm4D81oGDPLogLVUi3qZYSFJI3HEBMxXa/rlEIyyJdX8B+
	Uw8O64lc0MfT36c4bcd1UUItB8/KvVecfamFbd2NQ7KyzQUanIyKsD/gzyYc4d1U72QDu+
	b3yfYduIeQcBYIaYOXznGeLXe+nKWyI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-QtLTSWUsPWSTW-x7cqTiVw-1; Tue, 01 Apr 2025 07:35:01 -0400
X-MC-Unique: QtLTSWUsPWSTW-x7cqTiVw-1
X-Mimecast-MFC-AGG-ID: QtLTSWUsPWSTW-x7cqTiVw_1743507300
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-229668c8659so58085ad.3
        for <gfs2@lists.linux.dev>; Tue, 01 Apr 2025 04:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743507300; x=1744112100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF4YuDd97kbH9h4b0Huy41NC1nIWjQbGUIb1cXKzuDs=;
        b=YplYUDGWnHlex7gAGihRwj4i5rk2x8watXjugZEJBkn05MgORaOJvAI7s6Pu98JdkZ
         nD74RANJiLrD42RczI2Vw7VzpoYDt6TNgkUAvQ0LU1wGHNhHwG+IPK2f224ZWTZh3qzj
         dVk27tRk79M2iiRWX31TsB+q4k7xqF5nsNCr4p+FX59SP0ka5QTd4clkbWNeufJu6Vx1
         SYFFIsK2ltfQJS6t2IwXMleuNLumAz9EytZcZgZ5nafXP7+zq3mR0ZV+WR/VV0k5SlEA
         OjkB1CBO/ppvXx1iDkJGQBU+Zgdv6AnvC7aHuXJn6tF5l7MR/PfXXwlnyNfF+ufFw+Dq
         lHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUw35SMcUFKYV8+7mk+E71/4npWUL811yjoHWFsctBlDf4bBOma10CKSqcs7ATR0n4ZIxN@lists.linux.dev
X-Gm-Message-State: AOJu0YyD49zi49sw4fuR4XDyHS7qunaOHf0YScMkIDoUdyu5JBcxSpB/
	a3RzHqKUMutJumZVyc+8VP+lvTQPhw7487+RAqRH3lNdKlg6z6AESv6Sye1u/21sZau9Bb4reyP
	8lnoGlPKZ0ICRQLViiGdQjA3p4toVQXCRQFwN7TzSROT6rmSSzQYsZ6hoEcMQkDJoqIxseLjwUv
	M2MZiGLoakyG43bOkalNbOPDO3dw==
X-Gm-Gg: ASbGncu+pXOnyVKajO9bDkBMy+DyNPy0vciTqsWsX7BIthy2rw9sRcH5D3/RjEV2xlt
	i1Wc2kNAHedWyRNEsYmxHX0K/1LWvfu9jHmvAx3WpTOR1G4Pr9fsvnKZfECoc46YGSSbX5G8=
X-Received: by 2002:a17:903:2408:b0:21f:85af:4bbf with SMTP id d9443c01a7336-2292f95d1f0mr186006905ad.20.1743507299908;
        Tue, 01 Apr 2025 04:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSn5uOt98uhKZMMDLL1PKULGJN4KlvJ0HGSMvnm2Gb0y4uBbgD4AVkvun+hnHid4h00atdlaLqTwOr5wiMPx0=
X-Received: by 2002:a17:903:2408:b0:21f:85af:4bbf with SMTP id
 d9443c01a7336-2292f95d1f0mr186006645ad.20.1743507299575; Tue, 01 Apr 2025
 04:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250331230324.1266587-1-aahringo@redhat.com>
In-Reply-To: <20250331230324.1266587-1-aahringo@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Apr 2025 13:34:48 +0200
X-Gm-Features: AQ5f1JpDZFaI4ElGDN_h999frdCV6HsRsYbhA0HPvlCNr-3Y6fXIOT9mZSYMj88
Message-ID: <CAHc6FU7ny9PZeg6sipLc36VwiRChAbw=MtyCveGnX3pXLTfVKQ@mail.gmail.com>
Subject: Re: [PATCHv2 gfs2/for-next] gfs2: move msleep to sleepable context
To: Alexander Aring <aahringo@redhat.com>
Cc: stable@vger.kernel.org, gfs2@lists.linux.dev, david.laight.linux@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: djGa6WWKjvOGhfFi__FpO1XIGiEhT3DSN2PFo4ir3Is_1743507300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:03=E2=80=AFAM Alexander Aring <aahringo@redhat.com=
> wrote:
> This patch moves the msleep_interruptible() out of the non-sleepable
> context by moving the ls->ls_recover_spin spinlock around so
> msleep_interruptible() will be called in a sleepable context.
>
> Cc: stable@vger.kernel.org
> Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
>  - move the spinlock around to avoid schedule under spinlock
>
>  fs/gfs2/lock_dlm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 58aeeae7ed8c..2c9172dd41e7 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -996,14 +996,15 @@ static int control_mount(struct gfs2_sbd *sdp)
>                 if (sdp->sd_args.ar_spectator) {
>                         fs_info(sdp, "Recovery is required. Waiting for a=
 "
>                                 "non-spectator to mount.\n");
> +                       spin_unlock(&ls->ls_recover_spin);
>                         msleep_interruptible(1000);
>                 } else {
>                         fs_info(sdp, "control_mount wait1 block %u start =
%u "
>                                 "mount %u lvb %u flags %lx\n", block_gen,
>                                 start_gen, mount_gen, lvb_gen,
>                                 ls->ls_recover_flags);
> +                       spin_unlock(&ls->ls_recover_spin);
>                 }
> -               spin_unlock(&ls->ls_recover_spin);
>                 goto restart;
>         }
>
> --
> 2.43.0

Pushed to for-next, thanks.

Andreas

