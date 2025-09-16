Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC92D0292
	for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065021; cv=none; b=nV1Czp2UZh/gAZFOdWPoMEgmvlyUCXPv1ry3zNiCGveyZSUPipmcLKTvHfcOoxyOsdNZAKyTM2M94SukCSHdqJ4aDnaK/JMVezMuPhH4KFEY1ZcgZ0rRB5oiXNlCi3wjlljU+obw48Wa4cC5ebjjfOMF02w5GnZLyDe8zYPAHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065021; c=relaxed/simple;
	bh=giTIA+oN2GPG2AJcIuFo/Yqay6xFcr7uFNP4OUqU5dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuQD7QrmkTNTcCJh7w36/A5xtpwaITccE3VFBndY6uOsKM1nwWMeDUzrXjU46eWvaxyp/KkC9tLIeByOHDGPv8S3Ai9x/2dvWL2duEFQWNDYPf1RAjQK+zVegExXnyOYoySmnUk+uZal/tH+kf+ZslGiU0t2uHjFJvVozVLncZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+Mc0Uxj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Mc0Uxj"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b7a8ceace8so25727831cf.3
        for <gfs2@lists.linux.dev>; Tue, 16 Sep 2025 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065018; x=1758669818; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=a+Mc0UxjwYMCOO7ja4KLRaPqEaH4F2WBO0LRGMzUrjLQYc/I8PHPmEd/fh6QCpvacY
         coqsMOLqI4oy1nrFNG0Gxh3gwX0vHt2dEepV+qUd/baTl1gJkV8SxOJ0g0oGhs+seXm9
         RY2YJcd1jgeN0tcCkkHM8C5ER8GSFM0KzL9ZD3CNnJQlu4tOPfVZm2jCkd6Keg/1Z3Q4
         JFDwuK7dZhk9ufr1KTa6vg93NJYQXrk0vkTXlm+HnK3sUOwtHag7V0BHWBwb8XJKmfpH
         KpwJeNcThdRBPgZ3pVsmsnwZm7DH7jsvCGVOXU0OVaAOT9TS1S7Cok7pGQeY9b4GUss5
         EEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065018; x=1758669818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ3YjBHZupiI/fSqsW54w4BEZGVyy/jiIbt6znTHb9g=;
        b=jXAPbZmHvSIJnGOxPSmuOAsc+eGHYzzJv6vNWiMzMLlW4FjV+rPte1njgRs5E2E5r9
         4NUGUuYWFu31lVJvYGoo0Lia7GeUmylQkkvtPRPtwBHkORbY3dlb2XuT4uGF/uIX6Iwy
         RTC3PAuZtGUWRAWzzwWCynsgO51gJaPk0ip1uj6Iyjoh3oYyowO3CUMF2cWH/PXgKQC/
         hOa+1ux5K+HXjAuL9vU13ntBKPIpqmIGgJei+m40UKvTfnVggnuTO6R1jqEZguiu2O+n
         cDb1z+8fHUshtuPuZd5NL3OZYMOJZxG/1YJoghktixjz0CB+PeWhoKGHclnTOkUxa18P
         Bk5g==
X-Forwarded-Encrypted: i=1; AJvYcCUIugoSXgAmDp1o+XY8FQE9GoIhrbSrxH2YShP7AY06p5bk8MVsb4COtRjGJGwtzNh107ey@lists.linux.dev
X-Gm-Message-State: AOJu0YxQzEvFzjNkiYFPXig6lhY6PRQEJ7FAmx/9WwwAhQZbLrC/eBAy
	EcwE7yGH05dFbxA1G7Er1QLYHCcX9Pw2r9uA6/QAi9yMrtiipqG+hlgigeR1jBnmEnyGew133ZV
	rvotNuXZ3bLPy7lErqOftKF6H8S8b9aL4WHMl
X-Gm-Gg: ASbGncvxOvXoYaVN6CDsl1Gd8EW24iv58O/sTbAJ2PlqLcI8UmMhLRlm9FalIE6YVC3
	3KixkpK8v0xjbiP+A8Z+Ru7FtXmAyREgErVeRpW165JB7ULNQVp9zizdDE/zodJ8Nkzj7ETWkKU
	fAS8PkFbK0UNsiGzGW9U2tde8JWuvoKg9wcFWY6fchjbCXL+VsRUFmeCH7IGYt8vzc9f5KCfVvW
	Q4nPbxcQTEybspyGR1ClNnHLJSPscGQoE5gUY7uUb/LRFDRO50=
X-Google-Smtp-Source: AGHT+IGKNa7p053KroFdDHY8BCrv3xAn02NwZmDseFgEiIugEgF/oIBHgUVbXPtDWUz4HmAdeW9tnpZMVTofJgWdSvM=
X-Received: by 2002:ac8:7f4a:0:b0:4b3:f0d1:bc0e with SMTP id
 d75a77b69052e-4ba66e0cbfcmr3622001cf.25.1758065018571; Tue, 16 Sep 2025
 16:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com> <aMK2GuumUf93ep99@infradead.org>
In-Reply-To: <aMK2GuumUf93ep99@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Sep 2025 16:23:27 -0700
X-Gm-Features: AS18NWBTxeNfj7HS1GZNQzeWa7wYyaeuCFdkWQy1IIWJ1KkRr7vB0nVtSJ8Auok
Message-ID: <CAJnrk1a6UYzY=t-RJtoifxfkXQe-bKMhOnKtnvoP-X1fkPvb6g@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:44=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:19AM -0700, Joanne Koong wrote:
> > There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> > readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> > allows non-block-based filesystems to use iomap for reads/readahead.
>
> Please move the bio code into a new file.  Example patch attached below
> that does just that without addressing any of the previous comments:
>
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index f7e1c8534c46..a572b8808524 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -14,5 +14,6 @@ iomap-y                               +=3D trace.o \
>  iomap-$(CONFIG_BLOCK)          +=3D direct-io.o \
>                                    ioend.o \
>                                    fiemap.o \
> -                                  seek.o
> +                                  seek.o \
> +                                  bio.o
>  iomap-$(CONFIG_SWAP)           +=3D swapfile.o
...

The version of this for v3 is pretty much exactly what you wrote. i'll
add a signed-off-by attributing the patch to you when I send it out.

Thanks,
Joanne
