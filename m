Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47663B8D68
	for <gfs2@lists.linux.dev>; Fri, 12 Dec 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543676; cv=none; b=DL2rL0PcDlYN7EVPhHQmffex6uSYCR9hmnP3ow63TOmqcZRrHeTyW+Jhx/nHblXFM2dnhjDqeCxsZVaKYFUs+CjmPIeGzhaSFscrQ7XVXkXzbnbaq/Y37mUy4SN8ZOEJ57mFTabMH7nNhnxXyXrX1vmEh/eM65dKhqTbHaYfD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543676; c=relaxed/simple;
	bh=+XA7HAJzcFpc9m6JbPWoZosPl+zkxg/lxQaKdojZBxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXejoTDG//mAVo4fO/pGXqGlc9EMuM59t5w/QzFNSu5z5UohYjawOvg834pdWY3uTBGXdb2itn9+OzB7P/5YKn5KJTTom/somkFG3y2+3o/akr3QfC9krLfu7gjHQtu8wJrZYdOwnmv1OmtaMlKZ7qcCjYn7sBVojuWi+9mDsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA7tkDI+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA7tkDI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765543673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OrLeJOKP3lBe6ZeAu0DSL/CW+JFgGBEjV1o0wtyBa0=;
	b=ZA7tkDI+Mvi6esqil+q70aBzVwHeS/ka9bJvHeeNxFUdZGiwaV2zm7x0peNzbxvBZ5rNYy
	cXJzbTrncAH2G2mEWO/5wfA5wkMBhl13mXQadMvL7erNb8cEmX5r2SFEWn7ora8r40XRt5
	Wh2SvKBcEyKIZ6lSXpIdKo6PWtPqqj0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Ag15w8tdPiKecxLefLzu7Q-1; Fri, 12 Dec 2025 07:47:52 -0500
X-MC-Unique: Ag15w8tdPiKecxLefLzu7Q-1
X-Mimecast-MFC-AGG-ID: Ag15w8tdPiKecxLefLzu7Q_1765543672
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78c32de3643so16252567b3.0
        for <gfs2@lists.linux.dev>; Fri, 12 Dec 2025 04:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765543672; x=1766148472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6OrLeJOKP3lBe6ZeAu0DSL/CW+JFgGBEjV1o0wtyBa0=;
        b=CYS4i1AwLDoZdtqBOUi6RCBxNeKNCtfyUnCBP8KHwDop5xUvEiQ/lLFZCaLYbmr3/+
         E2eNPj2KdFVBX2OtH3QkEgjPayW3pM96rehIefP4BHNLyl9lOYRPdi/SMrnTQel9fdUv
         gvaik/tDcY3z71IMu7sHH9NNbVJSkw/G7PviJbMU+CQpAM/8o8BWtOT5Sak+dwdHuDA2
         LSP59LHoZGUzh/0ED5mctAKILWyZ5OPeyRz5BE31+zKiGpkY1iDyF/pCuhuCCYC3HUn5
         5mAce6tNB4iCKK8J+vQllta3zS/c9v0VEcraDH0t7Jfqz1LUxWE9KL8UeesL4zII/4Th
         ALzg==
X-Forwarded-Encrypted: i=1; AJvYcCXAd9c3Sc4nC7xBCmlk1v6dE9uLl3ztoer4SD4exCGGPFpr+1owwEUKA117MmPhZ3a9z0p8@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6IG+o10losvWwSlOZTomM5BaNRGdG3tq5BKTmaac/SQfwKF3/
	Yn9oGINL1xPlmJggrRQ7SxfGYCX1s45OMB0htn+pfpGmJ7c2VMQkLyp+6lm8yfNHaO4vQNrx1Wq
	H0a23J2U4Xu66R6WH4iDlgiq3Y3XL2vn9PmmixyQwA+DHN81C2tFsadeGcXo7kYYtOrW/idIEI9
	Bz+f27njT8JfdB9oYlF6e9XYK2mZq2OQ==
X-Gm-Gg: AY/fxX5aSqi3Iu4MoL7TbgCggAc2FaR2wGg3Q5ftVaoSaSJkUc552OovtNUCdGVlHkP
	havRUf4mtMAmIxPwSAKP0jYWpMJ2Mg9tHLMvTmSUSffJrjqP95S/tvlmvaV7H9RSA/xxeGH2H5G
	aZFuChe9p2u1pt0gXjBBKONF2HOIVqkMJJzY4+UZhHWaILdHTZjz8rOUVn0WHwuvTx
X-Received: by 2002:a05:690e:128c:b0:644:60d9:867b with SMTP id 956f58d0204a3-64555680460mr1101667d50.96.1765543671726;
        Fri, 12 Dec 2025 04:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFonvXEy0LhwPsusYzD2n7gRRjcjtvajKZY+QNDTaSqMCmq7q99KyzWe4K3rROsHq1ow94N866Wqt5YKli24kg=
X-Received: by 2002:a05:690e:128c:b0:644:60d9:867b with SMTP id
 956f58d0204a3-64555680460mr1101654d50.96.1765543671267; Fri, 12 Dec 2025
 04:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69351d9c.a70a0220.38f243.0049.GAE@google.com> <tencent_0136C09726370A4A04742377C566063C7109@qq.com>
In-Reply-To: <tencent_0136C09726370A4A04742377C566063C7109@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 12 Dec 2025 13:47:40 +0100
X-Gm-Features: AQt7F2p3F4Gc28-Oon42CnKLj6jgUuPiEieyp_HHsuX6XheDuPfaTjBJgvxKxkM
Message-ID: <CAHc6FU50_ZQM2G3y_z11J99xgRUE5yGj5DHKhpgEQd4QpmCLTg@mail.gmail.com>
Subject: Re: [PATCH Next] gfs2: update end and prev bio for chain bio
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gwWzdMYlyzQQ6Z3RciMsXwkl1Flctrj7o4_3CC8-34I_1765543672
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 8, 2025 at 7:12=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
> The bios are created and initialized using gfs2_log_alloc_bio() in
> gfs2_find_jhead(), which sets bi_end_io and bi_private. When the I/O
> request is too large and needs to be split into multiple bios and
> submitted as a chain, the bug reported by syzbot [1] is triggered.
>
> When we need to submit multiple bios in a chain, we need to pass the
> bi_end_io and bi_private of the previous bio to the end bio to ensure
> that the multiple bios are correctly assembled into a submission chain.
>
> [1]
> kernel BUG at block/bio.c:342!
> Call Trace:
>  gfs2_chain_bio fs/gfs2/lops.c:487 [inline]
>  gfs2_find_jhead+0x627/0xe40 fs/gfs2/lops.c:549
>  gfs2_recover_func+0x5f5/0x1c90 fs/gfs2/recovery.c:459
>
> Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
> Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Df6539d4ce3f775aee0cc
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/lops.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 97ebe457c00a..2de334034c74 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -484,6 +484,10 @@ static struct bio *gfs2_chain_bio(struct bio *prev, =
unsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> +       new->bi_end_io =3D prev->bi_end_io;
> +       new->bi_private =3D prev->bi_private;
> +       prev->bi_end_io =3D NULL;
> +       prev->bi_private =3D NULL;
>         bio_chain(prev, new);
>         submit_bio(prev);
>         return new;
> --
> 2.43.0
>

thanks for this patch, it looks correct. However, the underlying
problem is that bi_end_io and bi_private are set too early, and if we
change the code to set those fields before submitting the bio, we
won't need this hack in gfs2_chain_bio().

I have pushed patches doing that onto for-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?=
h=3Dfor-next

Does this work for you?

Thanks,
Andreas

