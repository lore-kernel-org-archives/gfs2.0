Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73C193090
	for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164711; cv=none; b=AehJoqRTC+ITmKmT7R77CAIdo+m6tzLXhgcbQCrnAWQJ+smnXFjHzwr6MylLjTVO3wzxoMGkwcocOJbGDU9ZAQUlORhWB3W4RmAOGP/B2cjeaUkU6ZFQ2BFSI8IoxG+71YXn+lsOX+9cQ+ROiONVwt0UEH00hMP3g5+OmQIayXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164711; c=relaxed/simple;
	bh=ih/n8CrewKI6D1+9ualLUR3DuDWkOzuYv5KaIh7VetU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjrf4A3GQdsPU92c5mv6X75+4q/wekGNlF6zE9KB39cLdAEpfJRoyUYIorWN/SFSwclpbgCCE05lL9iA3r7YybkX2bGgdiLs7ZxcaWbB45Wc4D+GmrtWbyhwfrbUq7sd/5w/Vhe6ddkrVSeYYKx+r7/VrSh++Nk4tG/BoB7BD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hep0zoE8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hep0zoE8"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso4649205a12.1
        for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164708; x=1724769508; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlKyZcerJI/b+5rW9w5YGY77JDxGB+71LgW6P71rn+M=;
        b=hep0zoE8aC0fNgV9dAByNhCx3SCEfabZR19XLlorr5zuCn/F0Au4eeewPgw4jSOVUH
         BLZlNy5KxMcddTHsu74Rr5W/jOCBhe9pHYc35QEqDxB0fSbEG8Z6AW501GEuAd3BJk1l
         QIloCw3rNIAnXSYdwQiYZFj4RG7+xl/ouYuAb7upCp3sNO2ohWm/xucXfN90M7ReMXrw
         qE1XGy8AnqfL/e4f22aDeMxnAp76QuzBKaV1a2JPPKiCUMh5q/a7KhtvKyPebhy8uPn0
         N/AZXf3M8CUM+F7/InTYfcuBqbm+aCsHhmOYbWwHOkjrduOi26Y2te8EGvaFNWlbioyH
         QnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164708; x=1724769508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlKyZcerJI/b+5rW9w5YGY77JDxGB+71LgW6P71rn+M=;
        b=OMfE1nlx7Rnlu8zy1x2PvuGLfNQYcDW3OabQqVkBcS+KWFJ47lXM8NVgvolYdVQDXx
         C6n+8iddcBsO+GtSg73uWOQiLlZqLlqcg2IRXvaHP4U96f500WrMq2EZ9emmDZ5r95vT
         XLJynCWG7tszeEm8q34VnSf8nJEvquoBTF4ljW5N6vd1RXhfnbTwGlcSh//FBXTPpald
         Pqtq1BlSQcQgkVcAK93swJ6/QuUmB8+IHUVYTR2ADbrha+mf+4m2q66l4/AlX7L/cVw6
         p+t5ZM5bZ6VQtAM3e/psrY0HIeaZpHiXD9wTexdUrCNdyKp+ftA5YDSr0J6qfHDy/F96
         kVag==
X-Gm-Message-State: AOJu0Yw57oMp96k20X797twltGLKAFcR0nv6AOUwRARviaKys1RKWpQy
	G9NHWG+2XZyIFDHTvs/ZD5BmDF7QpMkwmEcQ3LBI0q3Vq9dJQWp6OrSwVeofasFUAq6ltRtrz5e
	vYsKWIIN7QuvA+OC+liubcD90VxA=
X-Google-Smtp-Source: AGHT+IE/Q/pID2ImU9RPleC5mWD1P480kdwVLhC0s8JHB9DkygTJCsuzHRZVusRgrZlKdW5KHj8OvpykW/N/5BC9NSk=
X-Received: by 2002:a05:6402:27cd:b0:5be:d5a8:e0e with SMTP id
 4fb4d7f45d1cf-5bf0d2d2ab5mr1738851a12.37.1724164707363; Tue, 20 Aug 2024
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com> <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
In-Reply-To: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 20 Aug 2024 22:38:15 +0800
Message-ID: <CAHB1Nagi560YvT_9LKevFGh-yvDxDTtTd04eskQ74OgcOamAeA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix double destroy_workqueue error
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=BA=8C 22:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Aug 20, 2024 at 5:32=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.=
com> wrote:
> > When gfs2_fill_super() fails, destroy_workqueue()
> > is called within gfs2_gl_hash_clear(), and the
> > subsequent code path calls destroy_workqueue()
> > on the same work queue again.
> >
> > This issue can be fixed by setting the work
> > queue pointer to NULL after the first
> > destroy_workqueue() call and checking for
> > a NULL pointer before attempting to destroy
> > the work queue again.
> >
> > Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> > Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/gfs2/glock.c      | 1 +
> >  fs/gfs2/ops_fstype.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index 12a769077ea0..4775c2cb8ae1 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
> >         gfs2_free_dead_glocks(sdp);
> >         glock_hash_walk(dump_glock_func, sdp);
> >         destroy_workqueue(sdp->sd_glock_wq);
> > +       sdp->sd_glock_wq =3D NULL;
>
> Here, sdp->sd_glock_wq is set to NULL,
>
> >  }
> >
> >  static const char *state2str(unsigned state)
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index ff1f3e3dc65c..c1a7ff713c84 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >         gfs2_delete_debugfs_file(sdp);
> >         gfs2_sys_fs_del(sdp);
> >  fail_delete_wq:
> > -       destroy_workqueue(sdp->sd_delete_wq);
> > +       if (sdp->sd_delete_wq)
> > +               destroy_workqueue(sdp->sd_delete_wq);
>
>
> > but here, we check if sdp->sd_delete_wq is NULL? That doesn't make sens=
e.

I'm not sure if I have missed anything important. My understanding is
that in gfs2_fill_super(), if execution jumps to the fail_lm label,
gfs2_gl_hash_clear() is called first, which internally calls
destroy_workqueue(sdp->sd_glock_wq). Subsequently, the code reaches
the fail_delete_wq label, where destroy_workqueue(sdp->sd_glock_wq) is
called again, leading to a bug.
If there is anything important I'm missing, please let me know.

>
> >  fail_glock_wq:
> >         destroy_workqueue(sdp->sd_glock_wq);
> >  fail_free:
> > --
> > 2.39.2
> >
>
> Thanks,
> Andreas
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>
