Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD341FDA
	for <gfs2@lists.linux.dev>; Sat,  8 Nov 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762632054; cv=none; b=uP0gUnLJ/7BX0OYdPyVCl1lTozEiZ5XWIhhROjid3PSHgjMDMNeY/+w6Q8Lt7T43ZKLDMIu6VvpjdcvqpRwI7W1TuYG1UiLXKljiSHm/ae7sk8tJkt276dY9YMEl0qkuWmO1leyLe55cMZMA1j8so0g3lKi0OwNmFomxWapx6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762632054; c=relaxed/simple;
	bh=iwfcLfOtghbM9DC+PCDtTd3U3hVhPKz8QzyeDC8NeK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wrs3l14lZxuTwjPOem9RiFywdIF1HxOF2Eo+sxJg+vCirZG0nnNGGRkOnN3kgBS6mBIiI0yAhCOW5o2dp/L6OSQUmijUbgPYezExY/O2GUhn0wqzV0KmkIwDEa179qUmKOgmYN36/jwJ4wdaUh0vhNwxfdb/Q3J7TE7oSZ+4HW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZhNpS1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZhNpS1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762632052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vzuz0iSweWV07TK0XrRN6GhbSFKG/GySOsZ2Z667jzg=;
	b=IZhNpS1I5D1PeScyJTQXGv0JvFxNSqbToM06wUfmS47/GulBBo+sOGZ97S2G4Miz2rtOrW
	1f6GwFVf0Q92el8bp7ERT4NJmXP0tiFl4uwwOFRtI5mM19hO+8wK0HsDeNWjes6slQDXVu
	32+gcWXczFX8Jyr/TcRlE5ohdrmNyeE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-1JPg9ziuPnS_3Z1X3cE6xQ-1; Sat, 08 Nov 2025 15:00:48 -0500
X-MC-Unique: 1JPg9ziuPnS_3Z1X3cE6xQ-1
X-Mimecast-MFC-AGG-ID: 1JPg9ziuPnS_3Z1X3cE6xQ_1762632047
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-787df0d729aso4651337b3.1
        for <gfs2@lists.linux.dev>; Sat, 08 Nov 2025 12:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632047; x=1763236847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vzuz0iSweWV07TK0XrRN6GhbSFKG/GySOsZ2Z667jzg=;
        b=QrG872pjABoNUTvBrHoy8nVZ0Z9Ozy9kKYffGr1H0sjiuWextVxPEnLzxWaXi5DRG7
         DKoweOPqNk/N8JJrMXjChTRbJ8lUYvSbuOv/arN112JnSzdOISGODpReubRJScBUwWM1
         BCPGk2utoEix7g15C9b+XsEEineT91qS9sbLN7ymIfUpqYVpgFM9CTS6YIwSH8iXwju4
         +v07olfFhIkJRhavrQW6FQuOBuOe51m7OLQoxk1NOoNLtrEwbwyXGs4s2wBxA7vhH3xh
         Q8NMQDv3CypzB3mIX9DrfPAIGAKuna/Blv3adCP4reKoMkGRowca+LYS4/DsBc7E30gD
         P2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhE1Gd72WE6fDFZxPbdN+9PkfLQSZry2qECCa7Aks3peAlccaZWvskmqgbDF5vnMVM/cNO@lists.linux.dev
X-Gm-Message-State: AOJu0YzoQum6GhyYxhpkB/63v70EJoRN5wc0yJFISTsg6/oQV4WQ2uY6
	6nBg/q1l2rk4RN10osTE12hfdH8WdGK4/qv1vDyPBTD2szj4cmlqrrI92Y3lUhgUjg+Scj78Kf5
	d4RfQef9vv7OXuWhXqK7pMrH8nS3mM8BeH1JjiMdu0sMw7Fe5tyruZfQWNdqUAYLgVlzKm1iw58
	E3/veT1WrBVMK6RPzFhQfbL/i4Sz0m0w==
X-Gm-Gg: ASbGncsUJtFQveI3kdbYGdWB1yHLR4O0ex98r8gsT/mXCALamscP8KvqpFfuzR3Vg10
	MiQmMSh122suJIGLeRSYrLC3CYvj9zaw64ZG34hpjIE5QZdIZE66/OjLTgRCmazv2v2ldkBorY3
	8yNIqsD6vH/p2uVX7u0gIkGQF1R0LPmDV7vmK6IYl/JrH12JxwRQ2+jA==
X-Received: by 2002:a05:690e:2504:20b0:63f:ac1c:a375 with SMTP id 956f58d0204a3-640d4555979mr2313640d50.25.1762632047567;
        Sat, 08 Nov 2025 12:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSl+/IrDM1uqujfQ1tjlfbIwCNMT3s9OQgLH06kPlb0kAkNv2LeOZz+5jqoQhoqi1RXtRyDtIc+3ETlTDrhEk=
X-Received: by 2002:a05:690e:2504:20b0:63f:ac1c:a375 with SMTP id
 956f58d0204a3-640d4555979mr2313610d50.25.1762632047093; Sat, 08 Nov 2025
 12:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <690da013.a70a0220.22f260.0025.GAE@google.com> <tencent_522CB56DC89514EA26EF8ACCAC784A6F540A@qq.com>
In-Reply-To: <tencent_522CB56DC89514EA26EF8ACCAC784A6F540A@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 8 Nov 2025 21:00:36 +0100
X-Gm-Features: AWmQ_blhcl_epfqlOQgyduWglj8EMc0vOT14tfe4JakxuJMK4J4sXVnwFDlUlaA
Message-ID: <CAHc6FU5E2UNyhLuwJVdv3xnHEcM_Si2oX06S+5mz_3uz3-QqnA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix memory leak in gfs2_trans_begin
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KalxEB4DUL9BX1zQ3nYnAL06xsggLL6K9ZqQniJ90rU_1762632047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Nov 8, 2025 at 10:13=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> According to log [1], a "bad magic number" was found when checking the
> metatype, which caused gfs2 withdraw.
>
> The root cause of the problem is: log flush treats non-delayed withdraw
> as withdraw, resulting in no one reclaiming the memory of transaction.
> See the call stack below for details.
>
>         CPU1                                    CPU2
>         =3D=3D=3D=3D                                    =3D=3D=3D=3D
> gfs2_meta_buffer()
> gfs2_metatype_check()
> gfs2_metatype_check_i()
> gfs2_metatype_check_ii()                gfs2_log_flush()
> gfs2_withdraw()                         tr =3D sdp->sd_log_tr
> signal_our_withdraw()                   sdp->sd_log_tr =3D NULL
> gfs2_ail_drain()                        goto out_withdraw
> spin_unlock(&sdp->sd_ail_lock)          trans_drain()
>                                         spin_lock(&sdp->sd_ail_lock)
>                                         list_add(&tr->tr_list, &sdp->sd_a=
il1_list)
>                                         tr =3D NULL
>                                         goto out_end
>

this bug report is against upstream commit c2c2ccfd4ba7, which
precedes the withdraw rework on gfs2's for-next branch. With those
patches, the race you are describing is no longer possible because
do_withdraw() now uses sdp->sd_log_flush_lock and the SDF_JOURNAL_LIVE
flag to synchronize with gfs2_log_flush().

I don't know why Bob chose to push the transaction onto the ail1 list
instead of freeing it in gfs2_log_flush(); that's something to clean
up. I've pushed an untested patch doing that to for-later.

Related commits:
58e08e8d83ab ("gfs2: fix trans slab error when withdraw occurs inside
log_flush")
f5456b5d67cf ("gfs2: Clean up revokes on normal withdraws")

Thanks,
Andreas

> The original text suggests adding a delayed withdraw check to handle
> transaction cases to avoid similar memory leaks.
>
> syzbot reported:
> [1]
> gfs2: fsid=3Dsyz:syz.0: fatal: invalid metadata block - bh =3D 9381 (bad =
magic number), function =3D gfs2_meta_buffer, file =3D fs/gfs2/meta_io.c, l=
ine =3D 499
>
> [2]
> BUG: memory leak
> unreferenced object 0xffff888126cf1000 (size 144):
>   backtrace (crc f56b339f):
>     gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
>     alloc_dinode fs/gfs2/inode.c:418 [inline]
>     gfs2_create_inode+0xca0/0x1890 fs/gfs2/inode.c:807
>
>
> Fixes: f5456b5d67cf ("gfs2: Clean up revokes on normal withdraws")
> Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D63ba84f14f62e61a5fd0
> Tested-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/log.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 115c4ac457e9..7bba7951dbdb 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1169,11 +1169,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct =
gfs2_glock *gl, u32 flags)
>          * never queued onto any of the ail lists. Here we add it to
>          * ail1 just so that ail_drain() will find and free it.
>          */
> -       spin_lock(&sdp->sd_ail_lock);
> -       if (tr && list_empty(&tr->tr_list))
> -               list_add(&tr->tr_list, &sdp->sd_ail1_list);
> -       spin_unlock(&sdp->sd_ail_lock);
> -       tr =3D NULL;
> +       if (gfs2_withdrawing(sdp)) {
> +               spin_lock(&sdp->sd_ail_lock);
> +               if (tr && list_empty(&tr->tr_list))
> +                       list_add(&tr->tr_list, &sdp->sd_ail1_list);
> +               spin_unlock(&sdp->sd_ail_lock);
> +               tr =3D NULL;
> +       }
>         goto out_end;
>  }
>
> --
> 2.43.0
>

