Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D20218E91
	for <gfs2@lists.linux.dev>; Mon, 16 Jun 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113687; cv=none; b=XxHTIdowcS8/DDtcIo6ohuW8wr9fVMiwDyCt84WWBunUFyGJxntMUTAvkgPLLkyfznsoeZAfkvizKp4eS72+KlfQm37zwYuo+qs7n6YPvwvxLW7K/D9nGio0AM0Qvy2q005mlpUq0rQeLQIaWD/6JudlAj4B8gTemhZ/ad31YwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113687; c=relaxed/simple;
	bh=inPAqPrOtDNVaozV1C1i+2LoqHXKY7Bds7t8a+M8nXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1l88+McvlmAT2j/v9rtQhxUdQecUubxJOm6aVVlpN5pwHuBraPIiGH4Mxq9eFlMsDfXofw0kyfs+HlkQMgXKtQNGyx7gvdikHx8ttLS4NesVEvabZ0KGhs3B54uQPJ+Fpqi+ShOefRHlsDqeJTJOR8m3oCxuSkZY/3lxN/xT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvFmYwdX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvFmYwdX"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a720e806so45516201cf.0
        for <gfs2@lists.linux.dev>; Mon, 16 Jun 2025 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750113684; x=1750718484; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WL/UMQqitgkRFF+lKPomLCl0TVFnS09W2kKVqIDwx0=;
        b=MvFmYwdXZPpj9lZ0vn1pmytsAFSLGfk7O4ZZSQL2E1fnywUZNm+twS9+Fqa72FPF9k
         6KtrqSHoPAGDb7IU84WN43FNu5hN4+v7RcMcRjxKLWoZLTrVOC/iJSMptzP65EOXEACp
         4Zu4slcaV/UP9OcTYx/ug0SyinIt7WYsG5lixm5M0qn7GQNUCpng9ZBCxTUTgzvBI81e
         fo8Y7H8nEmiQqTnr9XGtBj9VcHTHVGxK03JlbVAxvokcbpcuy53QNS8VJR4G2nIuOfR1
         4q3V6VsHkZSSFbpHilUITUjcA8gMFFhD/8qJfkcv8PvL62djQn98UhIXSVQuQ1UuGWDN
         Q/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113684; x=1750718484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WL/UMQqitgkRFF+lKPomLCl0TVFnS09W2kKVqIDwx0=;
        b=Xa4WG2veeSFAlw4RTU9pVUZpfGNqnCuayyDlmeFXgRm0hohZIbDA/mLs5uTXdh94lP
         ss2eqxroMdVk9BO8lQFG89zuaiJ1YiXoFtZ0waSBGJLxWkf9VN4qYO3ykAPTW99hU2Wd
         JMK545oEJJn/tLL7KXfxoBrWi/9Os3KwkfLCutAU6pt3jLtitPcqGbUQtSdS80psaIud
         We9hRWVxh0vSheKFOviSzLaQpXUDLf64/CH0t9C3FVGPbWV0b2KnXZKcALQLPuGO3+6F
         7CuzLUxt3EjZklkMA0yNSDDHVqzL7vevj7uyFxgotvPR+fWtsgsTlWfdqcZ8a/kmBxr+
         arRw==
X-Forwarded-Encrypted: i=1; AJvYcCXVycvoBR6awwj6ep3Q7iO1lJR7voBwWKa4tXsoB1ASvLxp51ZSRYqJLFnqPKijDZ9dwERV@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4WMaYLA+HERKGq1MtUf9kgAHgKCV0rDq944LewF0kMenYiEG0
	o+NN0CPMA89Xp96pKKue6LsCcq0smjiXnuXLR4ipGSyNI3QXJtz2Yn/5wnC8dbkoi3h3N8+V33E
	zsa5YopQAcsGsQXQrzc6KmM/XxA8VySU=
X-Gm-Gg: ASbGncv1glGhtzi+UdxWO6Il5Zr4KdraIgNAO4N90gkPohwtuz4ImRNYr0vXS/H09LB
	gaodymihN8Z+zDU+6MNYPK9ik4MQsliAx5xZf7aQS/7z8IptXFotViaFu09BbIYihUZA/ZGkznh
	9xCrFu6n9twcVSs5HkNLw4vnLO/gWK4o/VrDzXHc1gVXhgQ5FGCXKZr7p8r9g=
X-Google-Smtp-Source: AGHT+IHuAxsCbrWGwkw03dlSUJn9epjHOdMLKt5Zl0+G9NRpBomRwzlIH5uUAOsyo8GUgH47FEvUywiYSWAAGhG2bZY=
X-Received: by 2002:a05:622a:109:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4a73c51f8f9mr162394071cf.6.1750113683870; Mon, 16 Jun 2025
 15:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-4-hch@lst.de>
In-Reply-To: <20250616125957.3139793-4-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 15:41:12 -0700
X-Gm-Features: AX0GCFtR--XxkERzvr8gwSYWc2aadVeMWoTPlaX86qB2gMy2QR5Xm4BOVPYXx5c
Message-ID: <CAJnrk1bFxRj=CF7g0YswktsPS=2oSBuHX6T3cyvTRRJjuAFyfw@mail.gmail.com>
Subject: Re: [PATCH 3/6] iomap: refactor the writeback interface
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Replace ->map_blocks with a new ->writeback_range, which differs in the
> following ways:
>
>  - it must also queue up the I/O for writeback, that is called into the
>    slightly refactored and extended in scope iomap_add_to_ioend for
>    each region
>  - can handle only a part of the requested region, that is the retry
>    loop for partial mappings moves to the caller
>  - handles cleanup on failures as well, and thus also replaces the
>    discard_folio method only implemented by XFS.
>
> This will allow to use the iomap writeback code also for file systems
> that are not block based like fuse.
>
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../filesystems/iomap/operations.rst          |  23 +--
>  block/fops.c                                  |  16 +-
>  fs/gfs2/bmap.c                                |  14 +-
>  fs/iomap/buffered-io.c                        |  93 +++++------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 154 ++++++++++--------
>  fs/zonefs/file.c                              |  20 ++-
>  include/linux/iomap.h                         |  20 +--
>  8 files changed, 170 insertions(+), 172 deletions(-)
> diff --git a/block/fops.c b/block/fops.c
> index 3394263d942b..2f41bd0950d0 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -537,22 +537,26 @@ static void blkdev_readahead(struct readahead_contr=
ol *rac)
>         iomap_readahead(rac, &blkdev_iomap_ops);
>  }
>
> -static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
> -               struct inode *inode, loff_t offset, unsigned int len)
> +static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> +               struct folio *folio, u64 offset, unsigned int len, u64 en=
d_pos)
>  {
> -       loff_t isize =3D i_size_read(inode);
> +       loff_t isize =3D i_size_read(wpc->inode);
> +       int error;
>
>         if (WARN_ON_ONCE(offset >=3D isize))
>                 return -EIO;
>         if (offset >=3D wpc->iomap.offset &&
>             offset < wpc->iomap.offset + wpc->iomap.length)
>                 return 0;

I'm not acquainted with the block io / bio layer so please do ignore
this if my analysis here is wrong, but AFAICT we do still need to add
this range to the ioend in the case where the mapping is already
valid? Should this be "return iomap_add_to_ioend(wpc, folio, offset,
end_pos, len)" instead of return 0? It seems like otherwise too, with
the new logic in iomap_writeback_range() function that was added,

   ret =3D wpc->ops->writeback_range(wpc, folio, pos, rlen, end_pos);
   if (WARN_ON_ONCE(ret =3D=3D 0))
        return -EIO;

returning 0 here would always result in -EIO.


> -       return blkdev_iomap_begin(inode, offset, isize - offset,
> -                                 IOMAP_WRITE, &wpc->iomap, NULL);
> +       error =3D blkdev_iomap_begin(wpc->inode, offset, isize - offset,
> +                       IOMAP_WRITE, &wpc->iomap, NULL);
> +       if (error)
> +               return error;
> +       return iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
>  }
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 11a55da26a6f..5e832fa2a813 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
>
> -static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
> -               struct folio *folio, u64 pos, u64 end_pos, unsigned dirty=
_len,
> +static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> +               struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
>                 bool *wb_pending)
>  {
> -       int error;
> -
>         do {
> -               unsigned map_len;
> -
> -               error =3D wpc->ops->map_blocks(wpc, wpc->inode, pos, dirt=
y_len);
> -               if (error)
> -                       break;
> -               trace_iomap_writepage_map(wpc->inode, pos, dirty_len,
> -                               &wpc->iomap);
> -
> -               map_len =3D min_t(u64, dirty_len,
> -                       wpc->iomap.offset + wpc->iomap.length - pos);
> -               WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +               ssize_t ret;
>
> -               switch (wpc->iomap.type) {
> -               case IOMAP_INLINE:
> -                       WARN_ON_ONCE(1);
> -                       error =3D -EIO;
> -                       break;
> -               case IOMAP_HOLE:
> -                       break;
> -               default:
> -                       error =3D iomap_add_to_ioend(wpc, folio, pos, end=
_pos,
> -                                       map_len);
> -                       if (!error)
> -                               *wb_pending =3D true;
> -                       break;
> -               }
> -               dirty_len -=3D map_len;
> -               pos +=3D map_len;
> -       } while (dirty_len && !error);
> +               ret =3D wpc->ops->writeback_range(wpc, folio, pos, rlen, =
end_pos);
> +               if (WARN_ON_ONCE(ret =3D=3D 0))
> +                       return -EIO;
> +               if (ret < 0)
> +                       return ret;

Should we also add a warn check here for if ret > rlen?

> +               rlen -=3D ret;
> +               pos +=3D ret;
> +               if (wpc->iomap.type !=3D IOMAP_HOLE)
> +                       *wb_pending =3D true;
> +       } while (rlen);
>
