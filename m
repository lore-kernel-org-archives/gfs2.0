Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D521D3F6
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182880; cv=none; b=bl43Sj6b2OWm4sDfwaypYpmxCmrMn62jyygvi6OO1HRcAem1jE5/MGnYVLnUJb7SLuup3oCJA6R2PprCfJ/8ya4pT1B1C+PCRHjMNkMf68NT8eZgeinTi9gaT9SRAT9/1UELHlfaV4xrpjbwmeWTCKykPem/dVZNN7ozET4GX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182880; c=relaxed/simple;
	bh=bgxfn7vE3uVcZL4Z/4Xgrg5I++5k5UcZdX3exMfLzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ6XKglC8jKqBzjpWSDjVHh45/a9urkJ5Q9jvw8V577n0sqN5D2l4Zr7bqzDVha0OyVvBI/UrFN3dQgySxuyVaq+04NU+cxHL+bWDe85VvlO0MR/aNDdExGbFjr9Nd4mOYooKPZx6XE/cRXxvkQgVftrIkb4G+95UmfbPY1WOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPXrfsiw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPXrfsiw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a720e806so53785301cf.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182878; x=1750787678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTi4WuiI5rSn4d0VdM5D16B62aIH3ZTDCOZvLTT0owQ=;
        b=fPXrfsiwJL7838As8quN8feV0yk1g3B/Jz2AZy2B84j+6MG6SeaFT+h1qTtRYxilP+
         HOKh6oOAGEbn3iyRgMA74nNP+NYYHK18mO01UxKjau6/3Ph5mFVk/t+Zj+3XAszS64Gc
         0YKON/5d4NyWSF8Sypn/xthaAv8azO/OMbPmqIeEHGkrpYjVPh55qF1OvHn59G9LU7W9
         k1SCUj+RYE/gQAPEt+2siGr8S9dBQPj4UxFcNBqNDARgf0YJ7Icrrg293JKG9clL7br+
         R5BzMm8zlNMT0SXxlCaq46yKk6S14/M6Hyb8ePZ12tGYghudbKLw8VfFBCOlSh0Di4CR
         QYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182878; x=1750787678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTi4WuiI5rSn4d0VdM5D16B62aIH3ZTDCOZvLTT0owQ=;
        b=APUIiz4wZRyQ9lE8caY5X5CKaB14mrsXY78xTKlpZYONM9JRbs8P3EOc/QcueLcB2D
         xGoYsU+ypAu+eWzYzM2Dtk6gEWfqAIGDsy2muxg/OMV45C6BRwV48JM+Jsd6T776IOX5
         7ZaGk+ZX1wZnftn+my2P964pTBTYqSEUYBewVhzZK4jGOk7I9gE8Id0YH86rf+b7P5mb
         Quh1zF+GtXFYvm2oiksDwSNaeQL0GXF9V960VsVrYKPfHsHh9ErnyOGBLhEdPUn15AkY
         nv1YDtzCDvru0llO04WHKYzNWH4yuxtbt1MA3b/HyN88h81fYC3JQEwN9e1/I8Su69c/
         ROeA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtWv3qUSmk98JnYK0UUXlpOsJN5PyB0pT/7vqs9/At6pJUpEmG3Sd+N2huLfzKubWt9Cd@lists.linux.dev
X-Gm-Message-State: AOJu0YywkIxLLA3bv+IDt5L6ml93VjG+YsTSoaVuRGfGUaoAEi6oYt57
	PzQ/G6pjvvh8Nm5FTbbz52TViKQzCV5DC+obhd5vhA++yyGlIBXpmjf848j75lw3CeeBaJrAinj
	Drda4cafIqj1VyMXW6casQ7tp81QKUZg=
X-Gm-Gg: ASbGnctYFnjElcws456jApu01lWru1YV3vkKoKk5GAHsgAD2Nexu3G2I7U3lvpbTfxU
	T0nGrXnNBUPP7R+o8Bakka2+mTeEjws4b2jlcr9T3rPW6x42UqSnVPu5JHYeqnEAOiq6qSMOkyb
	Gv4i9hq0HxXrBN2royWusOaWHM1V2pstOQ41e47PtU3maCUEf8iyNFe5xKrgUjTuDMBuRadw==
X-Google-Smtp-Source: AGHT+IGex4UWv+HoV/9Li0Bva7BreKI2nwwf5CqKk1rUMlIevgG5vGMpxGPPINpdgZlO5LfDN26J5rEEDluUxSQJBGM=
X-Received: by 2002:a05:622a:18a1:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-4a73c560deamr198293591cf.22.1750182877938; Tue, 17 Jun 2025
 10:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-2-hch@lst.de>
In-Reply-To: <20250617105514.3393938-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 10:54:26 -0700
X-Gm-Features: AX0GCFsDdji5vutx2f9J16YcANLgGsyfwdscogvNs6WP3czKu7_D_i2PrHBn32E
Message-ID: <CAJnrk1YZyuAX+OjuGdRWq1QpNj7R2BU5+Zx8mam6k+VfT9bULQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] iomap: pass more arguments using struct iomap_writepage_ctx
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Add inode and wpc fields to pass the inode and writeback context that
> are needed in the entire writeback call chain, and let the callers
> initialize all fields in the writeback context before calling
> iomap_writepages to simplify the argument passing.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  block/fops.c           |  8 +++++--
>  fs/gfs2/aops.c         |  8 +++++--
>  fs/iomap/buffered-io.c | 52 +++++++++++++++++++-----------------------
>  fs/xfs/xfs_aops.c      | 24 +++++++++++++------
>  fs/zonefs/file.c       |  8 +++++--
>  include/linux/iomap.h  |  6 ++---
>  6 files changed, 61 insertions(+), 45 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index 1309861d4c2c..3394263d942b 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_write=
back_ops =3D {
>  static int blkdev_writepages(struct address_space *mapping,
>                 struct writeback_control *wbc)
>  {
> -       struct iomap_writepage_ctx wpc =3D { };
> +       struct iomap_writepage_ctx wpc =3D {
> +               .inode          =3D mapping->host,
> +               .wbc            =3D wbc,
> +               .ops            =3D &blkdev_writeback_ops

Would it be worth defining the writeback ops inside the wpc struct as
well instead of having that be in a separate "static const struct
iomap_writeback_ops" definition outside the function? imo it makes it
easier to follow to just have everything listed in one place

> +       };
>
> -       return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops=
);
> +       return iomap_writepages(&wpc);
>  }
