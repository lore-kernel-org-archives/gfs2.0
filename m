Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BC3A450C
	for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340751; cv=pass; b=evkzeOOgW+oogJGh2/4a3R/5TGVC0I+8/iVlI02YqYjywAkh7QIhEsO7hiYzxwKD2lLUF+fKChM0IMPKstbs0T7P6GiGru6rpd30lkbiQuEiBgu73m93bwV3xmaxZhV7AHPvwxuwAjvCH4ZcsBqG4dhZfR8+s1Qnw+mLX3kAT1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340751; c=relaxed/simple;
	bh=Bw7/eU46XNMmEAY5yaZoewjP327xtGOJwYlC+oEFeMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWe3e+VDVJDTfm01QPUqXAs7RVyzqW+lKVaRY/Hf/eV6PNWMTWHvBIhm4oxhKnhvr7C8aP/c2ztSlCqltxtmu7bBvPxmsMaMhkcZncDB8MS58aR+eU39bajdJGyFuLaIo1oUp2BenMYwt80lce675DzYbudD9o+SoZ8NbQyDYto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Cy9dJu; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Cy9dJu"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-954997c9014so3104368241.3
        for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776340749; cv=none;
        d=google.com; s=arc-20240605;
        b=USkhWPQGVRnGNf59C+8yygbiTjZkxa1WGMVVsNEBx3pvb2xkd4FMEjxZ2b6jDIgAha
         zfAEvoB4yDpXV64CfQQforXl0Ax/gU28GY1309+YbS3AGipLLZXsV3gx0XtFVr21dSfy
         SyAsgnh5zc81DpQNbBouAomUcqjMbwL8Wr7DWgkfSBMZOmbcwlO4HHnGP8UafdurSD6B
         RVPuoFSz5cgqCLjGQlJVjCKJPJChGvRhgspzobnaE+tLbi73fI9FzFCCe21ReRAdx9kv
         6sHx8ZVqfxGeiQElfoZAAQ11tDGhGeR34VNzbXP5gtEKMr9DuWYAjARFQbVAX5TRY2UQ
         Xo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        fh=6XMfaqd5sFJMjIH6qGdSxU/dgdH2FHu5ZWkLqF+gm4U=;
        b=SFGad6aK5vDm7FI1kVV0sd6xsUVAdMoBPthgZvSxy5gVSEejxul0BtOdHcDyGKnIJI
         r0DBtnFgo/KyHSJ3AMxSNPfajaEyt3qhh+iwh9tF2u/Y+XLaBi9kaq/p/I+wLsVxrIx7
         qzjztiKu2SyCbRR0Oq+d+TsorJwFWC3qrjvR2+/G48HBle3OeyzbsCx2ypoczmBrXroC
         UBTp14j8eaahSh2AchVFg2xDfZw86hE0E4DvSHRyi5IZoKYpKReXKEzEljc47tnu//V6
         3OTYdnXXoTlqFogIZdEuKU2KNkMApVfOGi83g/H7KJXAGalfebHo8aqSrrHBdBYWZMjn
         Y7bQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340749; x=1776945549; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=a7Cy9dJu8T2kaHOb7ZcZWKa9z4RuZe2pSnVAljV9WdISe7LiJ8IQOJ6vxbi4ZcqN8W
         p4IGCE0t4uFl70UPN40t6dGYRWbPlbhQ3r12npcKNNEBn8PPnXgYnWWtlnFvHOnlbV3A
         d0XiYI1fDSeloM45aQvxPH9oW/bpGrslC51x7Wm5iL4PZ2Sdw7g/vHo0uiUlOmXIdfbi
         YzOrBTXzBhlgfBTYB9k7a2BU7SASuIu8furwjRrVuw8gA+ZiJ9w12ltHE/C5hNVcp3Za
         qi7z2niAui3U6+weRp6loxthQraDm/OOjWlugo25sHDwXokbutQxLfrTKK68uk5YHy4w
         P06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340749; x=1776945549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=mbryANjNPKXQ0WvCUuPcD2XJzM5koTaazzC2dFoNo9pOwrgCgI3tpyc/sTFPwHYjX8
         gk49Axjw+5q29T/P/JJ8LU3fJbtUeRKle4NXX75n+llKWVDEHzsHEoeFKFurIUdUlOS7
         42kGP6EozUGU7PyifdwKIl5RlqWzGTum0zaTliriL97b20lYgVx+AM+HXvPNf8LhHT5k
         FUKqGinGDEZSDvu231LBQAVWMIxWdj8/ThaywSSYuihnNvtyc0Srceyvom2eBKfXWdCT
         7Jliw6YPg/0cXs0FL46vjvlYdzMnKS/wX52zNMPv3YK8yp2gf9Oyta72iN8vvkPYR/Xv
         65Fg==
X-Forwarded-Encrypted: i=1; AFNElJ8styaL0ReP7fiyw3Rik8vV328SqUgbuUr4HRrzlItGkta3Q0dVhR7JUpzBvPx3WN8VvV52@lists.linux.dev
X-Gm-Message-State: AOJu0YytsZOM3W0XbO8z7+kGxZH3s1PcNbpTdcKWCHSVHc3hUoRceQKm
	lUAxHT1RuzhJ5imzxO7s0FPtbWB386VPo+cIccqlNz0iKcV4mqdsqEXGDlYP8Nl9nHhmRwHIXOj
	Om7CKL94v77kF/yLKvvtHNZZQTc64UFQ=
X-Gm-Gg: AeBDievf3O6Vl6PXDPJgat2QxEf5RE5vcNNbkY49Us0+I0RXxmKUnh5vYKeeajwV/hr
	sodcdfKF1fAfo0pNcWpZYjfeSNNmzGGHHItsFZ0NAbMXTSWr/wZ9pNk9rlfw9rXWnkjJ/P0Dk8a
	rMuxfTKCgFHlSntaIOQUb6+aYSJWOcifkT26tEZiM3h6cY2XiYFAPuw2/JtOYQqx8gVLOqCv/Kz
	wGGb3P67q2e8tY5iCLTD7ZOC9KGt8Mxz96nXjghnbNk7wg9p6MjMM7P0ij25dQ/UjrX/XZzWao8
	mEhEgg1E54luxnQ3v5DiQJFucDaJWxYpW61wDGvChg==
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-60a00c36c76mr12126981137.26.1776340748680; Thu, 16 Apr 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
In-Reply-To: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 17:58:57 +0600
X-Gm-Features: AQROBzAEjiDzwaGAEKhFLRhObmxO2qMMzryZZhbLCURVPls0DvUuWHW8g_k7mMU
Message-ID: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>
> Aside from the nit below, feel free to take a
>
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
>

Thanks for reviewing!

> > diff --git a/fs/open.c b/fs/open.c
> > index 681d405bc61e..a6f445f72181 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> >
> > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2=
_REGULAR);
>
> It's not clear to me why you dropped this, I didn't see a review
> mentioning it either. (General note: Ideally the cover letter changelog
> would mention who suggested a change in brackets after the changelog
> line so it's easier to track where a change might've come from.)
>

Thanks for the general note. I will keep that in mind.

The review was from Jeff Layton in v5
https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f83981=
afb.camel@kernel.org/
" 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is
successfully opened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."

I think it makes sense to strip off as OPENAT2_REGULAR is an open time
only flag (like O_CREAT and the others already), right?

Regards,
Dorjoy
