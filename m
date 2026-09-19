Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C738237F
	for <gfs2@lists.linux.dev>; Sat, 19 Sep 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836607; cv=none; b=hGPGdhdblgmuYxCy9R4azYACLp4ctUCn6qfI52CksDkYwVNAZOgDy9HucLD6Nnds/rvw+T3TPZ9uWIZiIttLpulJLIyhsGeM17JHbBM94U6pakUkX/QWlkONy3f5blX1jYAWBDH5/t0vC21ezqYFcbfsNY8wtg0qa/b9fgmsOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836607; c=relaxed/simple;
	bh=1oY3+giPHWz0CdoUqh5D52C+UH9EYo6twKyaCtg0Fhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlIHZ3l37ka4EIjVlDfPG8vs7sViyrj65XL9QQetwm40cpTE5xrFS0bh+7rB6VxucN6K8U75vY/ipRC0v1Qa0Sd6J47XEkOlneDbfaTvxq1ulnU99umn+hR2BDDjD4fNbfCwVcAgUTO8LFvNZtBuHiVPY+ILWO8+qLgF+6YyhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWti0NO7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWti0NO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789836603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
	b=DWti0NO7M5GOzv/mHpgKY7UUb1RPOxRK5G127tf2lGulceXlG6XYU69GMR7w/OPZ9+T+KO
	kzW6H8FIgbITCEo+v0MjlobWJnxdmRumGfH/AyDFxDWu5aVRLuoWk4YryYdNLvAJRkkE0C
	YML6lGp5qXAAAph75VxXcxwzrPsIiEc=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-KiXfbXrFMeaPl-q2d2gWog-1; Sat, 19 Sep 2026 12:50:01 -0400
X-MC-Unique: KiXfbXrFMeaPl-q2d2gWog-1
X-Mimecast-MFC-AGG-ID: KiXfbXrFMeaPl-q2d2gWog_1789836601
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6711c640f79so1547923d50.1
        for <gfs2@lists.linux.dev>; Sat, 19 Sep 2026 09:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836601; x=1790441401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw2O3A+XY8Iwe+GQb7YOsi3YCIQxb8QR4CEhrrgc/KM=;
        b=wgskb9dIz4TREGkdY4E53gX4YNCS3MyU7+bvsLBM/tJuq7nQmtsuKKMvzbqk2PexaX
         lQK0gT+fEEAsgD+PxGXnZ2ebNwBovOktQ+EALn0ouxI2K2R+4ixQ3+4c12H/10QUaMFE
         E/IDaU90nU+bO3u0Hlb4vjvi+7Rhqj/t0QkkYTQxpY/Kt85Io2VfcoDbYYDJqNozRCeG
         miBm1xyZnbwg98AQ43itsC4U7bX2ny8eGZ5WMhbVkfPr5vYQY02LxDyok8KZiG7tZ1my
         9nwvGIVNv9sO7o/NGDo1CNpd92OgzBUTSaJj5J/XRErX9PrMTncNSBxaWzQSmTkIjQgE
         rFgA==
X-Forwarded-Encrypted: i=1; AKwUvByU3+AZ7Q4ON4+Dcic3f1kjGOXkjWrKK8cKEiKvN7o5AQb2VGIdQWwbNIGVNyDE9YjAnfH0@lists.linux.dev
X-Gm-Message-State: AFuF++kqNGGd9SqZcXGlEoRqEamiiUrLUQR+S98asMB+hXQ9gNgA54lX
	Y1x6yvyCJurlSgPBs3AJkgLxAHxAJrRMTjAHPvCApfIDZaF803ikeNnihD9Buqz4Ev5So2FWW3/
	6rkrIJ8fGO47t26n+dJNJXSvbBO8o71c+mx9Ps0M10W8sDW89hJwCJIZVBtX69age0XrP0q78L7
	Zrk9r+0o4w5KAuFl1emx5/GPUBGoZvog==
X-Gm-Gg: AYBFou0kRTzn0O1FOqAde6bk5NV6xHu6F6pVeJaYxe2FfCK2NPeac8PAKIdVsMpnT1N
	/ltBtl9BNlPIo88rP6rij2grx+kO8XZtsV4PoTCi2dEh43WC/22D69tsQKhXzC5Basej0vQjeKP
	4wR+Op3qo83EOduZiAP+vkjdQKE+L9wpJSCID521WJYrgXvs7tqPKKUsL89L6GrrlVy8imXA5iU
	Go5cncNxu1RKyq/QuE/sQIuQb1AuVV0kIRggmrutbUewg==
X-Received: by 2002:a05:690e:e8a:b0:66e:5f08:82c0 with SMTP id 956f58d0204a3-67170436567mr2947643d50.26.1789836600932;
        Sat, 19 Sep 2026 09:50:00 -0700 (PDT)
X-Received: by 2002:a05:690e:e8a:b0:66e:5f08:82c0 with SMTP id
 956f58d0204a3-67170436567mr2947628d50.26.1789836600531; Sat, 19 Sep 2026
 09:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-4-neilb@ownmail.net>
In-Reply-To: <20260919022441.3305170-4-neilb@ownmail.net>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 19 Sep 2026 18:49:49 +0200
X-Gm-Features: AcwNN1Wzd3VwqVBZ8pDu1K46iGkfuTMoHWQj0DdBgADN8jcfrMQo_vnTAv0UsKA
Message-ID: <CAHc6FU4M59nodfn+NCDsr81Wdmvd1Ubw712FF56ekVWfe1+Nuw@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] gfs2: simplify atomic_open handling.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, gfs2@lists.linux.dev, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w1uVZ1tBXKYgaZP2why24r3d5Hq3mzvNu3DcoLoewQk_1789836601
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neil,

On Sat, Sep 19, 2026 at 4:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
> From: NeilBrown <neil@brown.name>
>
> gfs2 incorrectly returns -EFTYPE for any non-regular when __O_REGULAR is
> in force.  A symlink might not be an error, and nfsd needs to know if a
> directory was found.
>
> Neither this check, or the following check for a directory is needed.
> Both cases are handled correctly by instantiating the dentry and passing
> it to finish_no_open() - the caller will interpret the type.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/gfs2/inode.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index f361876c5583..7aa92bb31cf4 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -738,19 +738,10 @@ static int gfs2_create_inode(struct inode *dir, str=
uct dentry *dentry,
>         inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) ||=
 excl);
>         error =3D PTR_ERR(inode);
>         if (!IS_ERR(inode)) {
> -               if (file && (file->f_flags & __O_REGULAR) &&
> -                   !S_ISREG(inode->i_mode)) {
> -                       iput(inode);
> -                       inode =3D NULL;
> -                       error =3D -EFTYPE;
> -                       goto fail_gunlock;
> -               }
> -               if (S_ISDIR(inode->i_mode)) {
> -                       iput(inode);
> -                       inode =3D NULL;
> -                       error =3D -EISDIR;
> -                       goto fail_gunlock;
> -               }

as you note below, when the inode exists but it isn't a regular file,
we won't even get here (gfs2_dir_search() will have returned
ERR_PTR(-EEXIST)). So the above two if statements are dead code, which
contradicts the patch description. Could you please fix that?

> +               /*
> +                * This can only happen if "S_ISREG(mode) && !excl" so "f=
ile"
> +                * cannot be NULL.
> +                */

Is that comment useful without removing the below NULL check for file?

>                 d_instantiate(dentry, inode);
>                 error =3D 0;
>                 if (file) {
> --
> 2.50.0.107.gf914562f5916.dirty
>

Thanks,
Andreas

