Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13D25A2C3
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801961; cv=none; b=Ux4pkpBmLw1y4iCXZz78Ea/LNofdVrXl2RMvRzMqMvsv7J1CegJOPnDheWC72eewN4jvNgl5XNwJXjQ0f20DXToIScpgii+eMhIbB48uUI6UJ7lD5mJElia6ttwODFk7A1+4F7nGYr7GSkUrnEd+F3RF9dsUCMBG266F7RWkI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801961; c=relaxed/simple;
	bh=sC6wgHO9eH3gbsuq2AvQ1YiNFJHZ09MzLzk7cPXCjXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccWY7H9SJJW0GxzdeysEkvFYYL+8+ymr/uovz17/GCPJ3crKi1HJVMb7ysa0/IRK9oR2XJBDt8iE09HTQopamQSX0vmEkhMOO32kDstRQ18HIQcjWP64e/Iv1+hffNgzshKBZjSf/+MrkO6LKi6A1ujHUU4CyBWBhkdtQ5SU0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUZ3JJzK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUZ3JJzK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a752944794so10210271cf.3
        for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801959; x=1751406759; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltCO+pg+j7mpPUg7UdU9LwNKVjQTEPshXqjMTkedVoM=;
        b=HUZ3JJzKU6BdulEDPSb/gF2Mb3EIcGPdchTl9X4Z8Jzy/w2KZpDt6PgQjOvyR4Xv1h
         SuQIokoDMUbWRiIwOu1xNXZCBNc2GCF/C4OVDuN2useC6+L4JBfoA9IK8r/PGJ6FdNyy
         HwK30j3nf4OxFHK3fdLxGR4bYPVdPMPzoMoZ/TirQGA30JqgAjak5QfpzA60wMhl6Gps
         gAs2ykFEj0l6Jx38By4T0IP+CaalFxGeAj8SNpaTtQ5+YiCRvVcwL1zXNWqOuOGwWg3E
         gTU415Az8zB92t1CeSgTmvV0RshFMFCnGzC8a95bv4V8stROK6KNGjEbjnMKhUX6a19f
         TdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801959; x=1751406759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltCO+pg+j7mpPUg7UdU9LwNKVjQTEPshXqjMTkedVoM=;
        b=RX3lLrC/jMwrPsvcTP1Y1f4TldGPFNBZrClhm451joPMC/agmYfluoEjdm2xrx/3Gc
         eJTOS819tNECLtVRQPg3FUxOsWKIFOkl3IT45A+10ac0FmlBlr73Mm7E3Rk7BpdwEAm6
         PtBmDhTCfQ8fHYBLB/F1lYe5Q/2imGPir6Ra7ZU0M872deL/dJwAUPfmyX7Lxd0s78WU
         fzYHEMrkors6bg9nu0HI93CrXkwRB+ERW2nToNd4zX6or6QZIgw7slrm2xs85kKATZg7
         vWDJpu6D5HgeQ309ets78xC/F487zFx+qKk9DCOSpn2rOPRSc/1MlDKmAO+6pBnTUMs6
         ohEg==
X-Forwarded-Encrypted: i=1; AJvYcCULjoiKZjpNpZeOSxNSut+iEi1xHmPqKr6IbdwpDsL2dgkrtJIcw83Ft3fkkOf0g2aDuNOo@lists.linux.dev
X-Gm-Message-State: AOJu0YzCrMGjwh2xQonwFXvyrROFPsGHvUgkfzk4rk0kAFPT/lgH+6WG
	Fy7vrqoXYTEXNLeivTP8iu3NtuvbiulRKEr1WuNbmVtdlIaEo/wVZmwTXif+MmFE9SehQYuj1Qz
	MUU2ljQi/RKq06GD3APJV0DtVdP4wlYk=
X-Gm-Gg: ASbGncsY5UGZEwUZVZthhlYSDwq9r8fSsQOTZuqzrp9PTJ6XnQLjvimcAa9BEZhNtLW
	RkUblnJ8p0dVaa5bNbuXv9mPch0Zm6Rl5O/AFU/bijN9VUA7B4VOs3CeK+esKUkvLEDbb2j+0sr
	2fDy6jo3rY2w4PsvwHh6xpP9nUYyOmoG6+ZIyj+lyn6EplVLu9d+VXRohgXThz4B1er88kuw==
X-Google-Smtp-Source: AGHT+IEIQcJlanYBWh+8JVVLaoapTGSrgVkcezH2Jd6X25FPNZsLIeGIDE4Mxrm30rGzbSOgcFfRB0zEa0wED6oydcY=
X-Received: by 2002:a05:622a:18a7:b0:4a7:bf73:c5fb with SMTP id
 d75a77b69052e-4a7c06da56fmr14930661cf.22.1750801958965; Tue, 24 Jun 2025
 14:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-13-joannelkoong@gmail.com> <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
In-Reply-To: <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 14:52:27 -0700
X-Gm-Features: AX0GCFuoxidmV2DONKGBu8GGbT28tUoZhYdBBWC_-QHWqMqDdAas9tv1y3pzzhg
Message-ID: <CAJnrk1Yh957g9Brs1YA3AXnGxaAkHvp9Eummpx8sJtbr4JZJMQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, brauner@kernel.org, 
	djwong@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:07=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 24 Jun 2025 at 04:23, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> >  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_it=
er *from)
> >  {
> >         struct file *file =3D iocb->ki_filp;
> > @@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
> >         struct inode *inode =3D mapping->host;
> >         ssize_t err, count;
> >         struct fuse_conn *fc =3D get_fuse_conn(inode);
> > +       bool writeback =3D false;
> >
> >         if (fc->writeback_cache) {
> >                 /* Update size (EOF optimization) and mode (SUID cleari=
ng) */
> > @@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb=
 *iocb, struct iov_iter *from)
> >                                                 file_inode(file))) {
> >                         goto writethrough;
> >                 }
> > -
> > -               return generic_file_write_iter(iocb, from);
> > +               writeback =3D true;
>
> Doing this in the else branch makes the writethrough label (which is
> wrong now) unnecessary.

Hi Miklos,

That's a great point, I'll get rid of the writethrough label in v4.


Thanks,
Joanne

>
> Thanks,
> Miklos
