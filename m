Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1118E743
	for <gfs2@lists.linux.dev>; Mon,  7 Apr 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744064975; cv=none; b=h/zx1OVF4nEr/MbogZ8KpkKBnQ6r8l7Z2SwAkn83owimg10E3XSv3DoiS7U9H6y8VDLzMeK6Jaken1afU0BXL3wUIEGMwrqO9c4b42SgU/ZaSaNvsJbQVajYydGP5zLJduI15PYYTjis9rTSCU8CXOGg8vyY8J1V4mhTIV8TxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744064975; c=relaxed/simple;
	bh=kAatK+aPE9wbfR5qfZGhnkq3HU/VznB1kKcm+hfzNi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6DJMsFPtlHthz5iSGvHbuBiUkpyRmD7XZAi0zJZ+FHOK/CcOEQQcTUxhJw2wWypsEQDj0nIexwElO4WpFFONYkyw4IEPWYmcri69ElK+OZbzO0/QwavANuKVs92Be6E7TI7dSmCpm+q6otLx/CyCc/KXfy2uARL+L5wzXAZXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agV5GBYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agV5GBYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744064971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8SXAEDNIur03Bv/jJCgntr5hegQz8OYL+2XGPm39ts=;
	b=agV5GBYPFVpjfdE2eSm6bRBRc0Qod8kumKLxMxLD5mZF/EDBIcR6vTPBnSmvNc7PlLdUdv
	A9BJ+dxnO/wHl2I02Y6+eIfIttywvQnHYHsyhmnoxWPki6nmPWfB5QHFxqpiZJ4BhqYDoO
	GsixrS36NniXobPNaisj19HgGOm80mg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-pwa4XPY3MCWG4ZuJoiZhFQ-1; Mon, 07 Apr 2025 18:29:29 -0400
X-MC-Unique: pwa4XPY3MCWG4ZuJoiZhFQ-1
X-Mimecast-MFC-AGG-ID: pwa4XPY3MCWG4ZuJoiZhFQ_1744064968
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241e7e3addso40139605ad.1
        for <gfs2@lists.linux.dev>; Mon, 07 Apr 2025 15:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744064968; x=1744669768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8SXAEDNIur03Bv/jJCgntr5hegQz8OYL+2XGPm39ts=;
        b=GdsYxsvRarUA25ZUMIPiGXbspVV/yiX93uvL099LJa9oPk0hejnLEAeDlc7vaDXzpu
         3mAVUmpL/wifBqhhjWRikS8p0ewNn7Yr5yaJdfUtsNGBhmZqFknuL/kD9K/fT7NScrJD
         zpWFmoE0hcAKPgUi9Mz05CcgaBoFVTDWL2c/4M2Mvv9NrQh2uwZZPaWADm0603eSl5F7
         8iW8abTuNDoW6sa2/+UHDzzCrUmL7uOX0hZ0krISbqhOs2a1XNQCy+tcLaADeheF8BNf
         iIKzVU2HG37PGg8h2UFJ6RGJKjwelxJxccuiuf8LB3HzgqsSZCBDn1U1Z2UElxRnigdL
         O8nw==
X-Forwarded-Encrypted: i=1; AJvYcCXXPlRkfCGVDei/Bdc6aBThdSqEUp2WMXLo4aW2jDYIcnaOdPAN9XY7lwYbX6hTsLc4u1as@lists.linux.dev
X-Gm-Message-State: AOJu0YweCFRV5m1d1LCYk6VwlfsKemfS5+sH+99BGIh0X4wRGNupc19a
	URTsXibWI+BpQZRDkbL0EYIVT4WeOB7ETa+y2EDqFZke7RhRTBmw4xE8OmxybUQQP5858HLU9ZY
	J2Zg3ed6bKPeTJHoBG8454QKovtEwcXi4lyKxw7652cNYRIYrrtsrSvURSOMJipGb8JSwgbIJKT
	RUvCZ0hzA/wf1Yztx7ni7Khv0NWQ==
X-Gm-Gg: ASbGncvh17sJaaaRU6gqB/aOs2Hu0YLbSEVi/294CI+w+ErGvX7Lfk3DJ+qXHPTcQ+/
	r5rYTBkW8fJCz1uxkfJR5UCAq1s+sLjgVDzGm7IOeNAiI+S/d4CATnQKdtm8nxv5ISEGX8bQ=
X-Received: by 2002:a17:903:120f:b0:224:de2:7fd0 with SMTP id d9443c01a7336-22a8a06ca21mr189102015ad.25.1744064968572;
        Mon, 07 Apr 2025 15:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCymDXMu2eOVPY7XIFoiefsTi6CUhyFSxZjgg+xvaCZgHO1XXxrrDF3+xcBtg9fZc1lZzyooVSs8hDBzqE/iU=
X-Received: by 2002:a17:903:120f:b0:224:de2:7fd0 with SMTP id
 d9443c01a7336-22a8a06ca21mr189101845ad.25.1744064968331; Mon, 07 Apr 2025
 15:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407184538.2686303-1-aahringo@redhat.com>
In-Reply-To: <20250407184538.2686303-1-aahringo@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 8 Apr 2025 00:29:16 +0200
X-Gm-Features: ATxdqUHCIAyURn1P6BFWL1fpw7PquFnYNOeK2oWMhAKV17jj1KwPYr5LXxO6NYY
Message-ID: <CAHc6FU7Tyc+_gcdqWYjr5QmybkJCG5JDJbsPwsb_tp7WFpufkA@mail.gmail.com>
Subject: Re: [PATCH gfs2/for-next] gfs2: only apply DLM_LKF_VALBLK if GLOF_LVB
 is set
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: miRCOxZJE0U-PbzUD8Zw8z4ArrJAd30pTo4uyHCKjo0_1744064968
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 8:45=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Currently there are cases when sb_lvbptr is NULL but gfs2 always sets
> the DLM_LKF_VALBLK that indicates lvb handling so sb_lvbptr should point
> to a user allocated lvb memory lvb. This currently makes no problems
> because DLM checks on sb_lvbptr being NULL when accessing sb_lvbptr and
> force handle it as DLM_LKF_VALBLK would not be set. This patch uses the
> same glock operation flag that indicates lvb handling to set
> DLM_LKF_VALBLK instead of always setting it as this is against DLM API.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/gfs2/lock_dlm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 58aeeae7ed8c..34037e23149b 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -328,6 +328,7 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
>  {
>         struct gfs2_sbd *sdp =3D gl->gl_name.ln_sbd;
>         struct lm_lockstruct *ls =3D &sdp->sd_lockstruct;
> +       uint32_t flags =3D 0;
>         int error;
>
>         BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
> @@ -361,8 +362,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
>                 return;
>         }
>
> +       if (gl->gl_ops->go_flags & GLOF_LVB)
> +               flags =3D DLM_LKF_VALBLK;

Let me change that as follows because this is the check
fs/gfs2/lock_dlm.c uses in other places already:

        if (gl->gl_lksb.sb_lvbptr)
                flags |=3D DLM_LKF_VALBLK;

> +
>  again:
> -       error =3D dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_VAL=
BLK,
> +       error =3D dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, flags,
>                            NULL, gl);
>         if (error =3D=3D -EBUSY) {
>                 msleep(20);
> --
> 2.43.0

Thanks,
Andreas

