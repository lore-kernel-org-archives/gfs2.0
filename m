Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DE42E421
	for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661177; cv=none; b=sAdSGOyUku1pau4CdKf5oGxz3Tp5+UuV3fAJ3gZjc2JZTCRi56hecsEiboGXmhrkzijvxp9oD53TphFcdGjThvUUF1L5AoRsO0kZY4nL56zpb9lm7a1/k5GSDgfe9moFrijNvQMhjKHWQdDhtQ0bIRoXAFWRrdAARF3rob2ibCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661177; c=relaxed/simple;
	bh=M8uzU3Aqp/1CuSsptAirP4P6I3joyhvmWRiIDDD/B2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pigGBUgjcn8O4fUKuJkhpp71+JqMkZKVV+Bcwxy7PpwRclH0XObrD5DSyW9f1ZlP2eBWrTs3Rzh3++CaCziTsphUPKgwPRX1ueghgfF95FzcZ9OC4wB/wtku1zIJZ70XSt7WqvpfX1MHz/kOccIfiVPDA6AYGRBQp0/JLJIPdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBkkCOX8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBkkCOX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787661172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPRObTmEZKyvm6vBWaRxlO8NbXdKA+J+omeMfbVA/Lw=;
	b=OBkkCOX8oIuUym3AVheOayz0IXuWeKWT8B4V5hFd+YG2WCyE4OqNr2F0foApPvWawGJs8l
	ND32JQWSpk4Z4mS3EqZMP8MhXusYyYZkPvrpvRolRhiXMSfFCPlRQaCrSekwSSMi3Qh6CF
	519hqfJJGlhyZsoo2gkzECcnKtNyILg=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-EJIxp1MANAWKU-2ban9oCw-1; Tue, 25 Aug 2026 08:32:50 -0400
X-MC-Unique: EJIxp1MANAWKU-2ban9oCw-1
X-Mimecast-MFC-AGG-ID: EJIxp1MANAWKU-2ban9oCw_1787661170
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66cc65a15dfso10498372d50.0
        for <gfs2@lists.linux.dev>; Tue, 25 Aug 2026 05:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661170; x=1788265970;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPRObTmEZKyvm6vBWaRxlO8NbXdKA+J+omeMfbVA/Lw=;
        b=ZUZinPLYC+KF/BrEhxIb6rNxhbMoYV2HYO69AW4x0fhMsObwLgxt2x++NeLrkpXWsE
         Rib2hUJGbI/2carq1SmzAvXnxkHjB3LWzkuE48vv5MaYG/qXJKLIKZF34XjbJn2NJpLa
         I0ccXGS8sPm38gUILkB22Q0fx9LrUeGk5M9hphsjLc3w1gus5SO2H3DrZG1bbCU7IV1R
         BV/wraFWw4GiivAgaRStrKn5iHB5hVx3hSkGFtzPJW0s9k8hFek3nSz46ni3cyaA3CWN
         dkgCge+1rgj6W0PYUxqgtPZwyj1xUZTFqpiBYWhKM+i/fUa/QpbGFgfdFVA8z/a80UnB
         RYoA==
X-Forwarded-Encrypted: i=1; AHgh+RpZSBNbJtK+SrKJjXLlbfdd34EmT381/Xkp1GU+WfxW/fFkfe70GB8zQ0Qjvw6DdAdfSbFs@lists.linux.dev
X-Gm-Message-State: AFuF++l60qfTbMzchcM4X4IADjIR7pg91cWAWNXPy3+Jwm6IITEO8ppE
	RU0KiNUHx5C369G2ITpjlAqCD5C9s5E/58GAoX0Sxf0xr3INTIOYny6i8IniThPGVnbba9ydvmW
	ZMkA8XraiWrAiArFluiKpH2TB7AllFiKZBbsQqsoHGDe4+aypfXqJRoOBkoDyiAEhlRtkIGcZFF
	S6lNt23tewmUa9wuP1zJRQzWFa6VJhGg==
X-Gm-Gg: AR+sD11Gi1AgzcmhYbjngrgoDKumZ3ZxwN+rDM8FwqlWNpIMpTjkHgam8Ir0uSho5O6
	nOlhZFn988/002dAz5VHcT4dpSueccQph9C2DJtg9/fPb7/UQOly6yKWz/6AOLAfIJfZm/4ngPv
	deTHF6o3muq8um+8oNQFSwQ4VJe8mF0T1XWJBbNeQq2De5f9HSZOkP3+f8HtpxUQph4P9KQ6yxR
	W3dtn1RW2+7ZSl+c+Glpeo7rcr9tDv8yoMSImjVQxDB
X-Received: by 2002:a05:690e:1b4a:b0:66c:7f92:176c with SMTP id 956f58d0204a3-66ce49d463emr9970710d50.2.1787661170149;
        Tue, 25 Aug 2026 05:32:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1b4a:b0:66c:7f92:176c with SMTP id
 956f58d0204a3-66ce49d463emr9970696d50.2.1787661169714; Tue, 25 Aug 2026
 05:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260825015501.633078-1-zenghongling@kylinos.cn>
In-Reply-To: <20260825015501.633078-1-zenghongling@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 25 Aug 2026 14:32:37 +0200
X-Gm-Features: AcwNN1XP1t7k1_DlEJUC9PdFBgn2lfUsyuwWijLKZOvRz1bm7IRYBgwAS4qIx3Y
Message-ID: <CAHc6FU7NwTZ1gAcX2zyg2yg+2BQq=JtjVTwNNfuh_wASDqEceA@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: move brelse() after buffer head accesses
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: anprice@redhat.com, swhiteho@redhat.com, gregkh@linuxfoundation.org, 
	rpeterso@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UDHw5iluIWkOPrrzD5vkQI-01yVeBHgCH-kn8yqr3Sw_1787661170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:55=E2=80=AFAM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
> The brelse() call happens before all buffer head accesses are complete.
> While the reference counting prevents a real use-after-free in practice,
> this pattern is error-prone for future maintenance.
>
> Move the brelse() call to the end of the function to make the intent
> clearer and eliminate potential static analysis warnings.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Andrew Price <anprice@redhat.com>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  Change in v2:
>  -Correct the commit.
> ---
>  fs/gfs2/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 78bba8cc10b8..a92c84146de9 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *b=
h, int meta)
>                         set_bit(TR_TOUCHED, &tr->tr_flags);
>                 }
>                 was_pinned =3D 1;
> -               brelse(bh);
>         }
>         if (bd) {
>                 if (bd->bd_tr) {
> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *b=
h, int meta)
>         }
>         clear_buffer_dirty(bh);
>         clear_buffer_uptodate(bh);
> +       if (was_pinned)
> +               brelse(bh);
>  }
>
>  /**
> --
> 2.25.1
>

Merged, thanks.

Andreas

