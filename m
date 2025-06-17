Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBF20296A
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185225; cv=none; b=AeNrxV+uc4bIB8L13LE45G1C+MfUHipyWpGwPQ48GmWIaHc3wlKB6lRbR6JsCVuqr5x0pV3fPhAx1vnn6a09+P6magc9DQ3YSIm18aER88k3AIJk501lf34pUlTM1tK75FjoCi7xvw8bFTiAJxJqnvIkzShpk9/+Ymviu6zy+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185225; c=relaxed/simple;
	bh=Kiy2vvYzTePR5GbgQftAijWKBWPQ0QOg2Oqfa3TJE1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY7W1r5gULtIpa+lXx1w56p+etMChsLhsIM1KscMMolzHiSnRQKsEIy8Mx9O3oPmr/R8uxt51K5GcITiBC1qq3EUe6ScpCNyfeEcuzVKjnj3G+dbPNfmXL+lf80wJIjHt7zdmR51KiHsQ9WZ5ANhgBkP3lsCb9ZTmui8H0wgv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsFeLKtr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsFeLKtr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58d95ea53so62487971cf.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750185222; x=1750790022; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXit0RHUUQPu2ykL/aV51WJ3j1g/Vwgy0g4ePFqr+dQ=;
        b=MsFeLKtrFhLMEe3tLvVhKDdDcr3BDH1Ogf5DCzg6vYRO2KgEX2y6j2UP0iIRlYRt07
         aq9fqEsZ3DU9P3KneMGgZi61RKd2pOf/iq7OlPUgptS1s9eeCD5AE7kGcTqD4b4YuSWb
         SFXDDwhKUcyV7g0H0A8KEzZkFRHxbuTO62dxC7ioX//YRkZiCtIGJ1EzuHDsW08WPC9o
         P6r+95CPhpSoEO85GKYqTNrbmIEntoXd+bLplJh+hPKZcHRLnPvfdlo3ry7JhmY61mqg
         i6uY/DKqbGJ2qQQaHXDAlL3zHSd/dNGydW2r6rpBtnQLCKzi9OalwvkDE5aJC8XIRiEv
         OSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750185222; x=1750790022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXit0RHUUQPu2ykL/aV51WJ3j1g/Vwgy0g4ePFqr+dQ=;
        b=vHh+5PemLEm2v1T3aai9A6R/5+H9j3D8s8fQqC3pyqkt+f3emd2jfVKDwv5ClF4aZW
         tfzLNn7gY+Wtcx8yuwhLDGI5wXoCE9N43bRvzW/rcxxW4GWKj2vrH5KPr8yqr8GDiwGN
         0zFe/oDNGZkasLJmS1r2W9Qbk0UzfVjewrfw+o7uRnsC5MX6ZE7esCiIVFuHpYgSXgSU
         Fn0RiR5GCy0gOvVPcmK6Z1F6nFCj5IxRSp4Ef0Y+1uhrcCRpMoALjL0yV5pUANMJ1edQ
         NUz5LpZ/7pq+gsXtBYex7FEHUI8++moVHON1MlNh8ULBT8WqWuDdjt6bRy2ULVfZstsZ
         oEKg==
X-Forwarded-Encrypted: i=1; AJvYcCVMMulv4hDKUt56Hb2+8gj1Ncirm9zxiHJ7jnu+Xat6LfdLwwusY02FSWZ6ZzcQ8uge43Pt@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6QxJLEa1TzSr5ZLI5vWexTG1pDEtXHODtkAiyajt1kFMdPQX1
	OeqAhf62VOVehZGr4YhdVlyUUyyO2xdkN7eP3fj2mVyVo6OgRRZrgxVIpKtJXIwRLvzzb2POQk1
	s5oX+Yp2qYvoYH9yKHK1GxReo3Nq6eQA=
X-Gm-Gg: ASbGncsH+wwIVHjAPRyb7eYLuvnJ8hJZFlkYJg+vYXu9Xel4Wa02X0F4DZvCdVoh5tb
	xopMCmLKivscZZQ3enbJXx0D52InvTOmQswM0ZxHiqTYomH3XfBwygRUwFl8gIWEIA+qh1NxVmJ
	lSNSyzTKH7XMa6pI1smLRcDimarS9ivaxo7rnrglsBw/lmQH6QFKu23kMb5H8=
X-Google-Smtp-Source: AGHT+IF1oRcUYqtuy8CTN4wSMNbz61SUuHkItva/h/FYcPTQ4RNMEUHrwHb8hpEqd4QLM5oHeKNbVzWm1rEYkiMESjk=
X-Received: by 2002:ac8:5808:0:b0:4a3:4412:dfcd with SMTP id
 d75a77b69052e-4a73b7abdfdmr254036501cf.22.1750185222234; Tue, 17 Jun 2025
 11:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-4-hch@lst.de>
In-Reply-To: <20250617105514.3393938-4-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 11:33:31 -0700
X-Gm-Features: AX0GCFutUYFJGsElnkJ4NOIykqgr8d5QqMM5WShX49zcWmxqY_Bwr-kEPw_EzNk
Message-ID: <CAJnrk1br2LkVvRgMAojU6sQ9KAc0pTzcd_hxGx7MMqZuEyr_yA@mail.gmail.com>
Subject: Re: [PATCH 03/11] iomap: refactor the writeback interface
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
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
>  block/fops.c                                  |  25 ++-
>  fs/gfs2/bmap.c                                |  26 +--
>  fs/iomap/buffered-io.c                        |  93 +++++------
>  fs/iomap/trace.h                              |   2 +-
>  fs/xfs/xfs_aops.c                             | 154 ++++++++++--------
>  fs/zonefs/file.c                              |  28 ++--
>  include/linux/iomap.h                         |  20 +--
>  8 files changed, 187 insertions(+), 184 deletions(-)
>
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentati=
on/filesystems/iomap/operations.rst
> index 3b628e370d88..b28f215db6e5 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -271,7 +271,7 @@ writeback.
>  It does not lock ``i_rwsem`` or ``invalidate_lock``.
>
>  The dirty bit will be cleared for all folios run through the
> -``->map_blocks`` machinery described below even if the writeback fails.
> +``->writeback_range`` machinery described below even if the writeback fa=
ils.
>  This is to prevent dirty folio clots when storage devices fail; an
>  ``-EIO`` is recorded for userspace to collect via ``fsync``.
>
> @@ -283,15 +283,14 @@ The ``ops`` structure must be specified and is as f=
ollows:
>  .. code-block:: c
>
>   struct iomap_writeback_ops {
> -     int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *in=
ode,
> -                       loff_t offset, unsigned len);
> -     int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> -     void (*discard_folio)(struct folio *folio, loff_t pos);
> +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> +               struct folio *folio, u64 pos, unsigned int len, u64 end_p=
os);

end_pos only gets used in iomap_add_to_ioend() but it looks like
end_pos can be deduced there by doing something like "end_pos =3D
min(folio_pos(folio) + folio_size(folio), i_size_read(wpc->inode))".
Would it be cleaner for ->writeback_range() to just pass in pos and
len instead of also passing in end_pos? I find the end_pos arg kind of
confusing anyways, like I think most people would think end_pos is the
end of the dirty range (eg pos + len), not the end position of the
folio.

> +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
>   };
>
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 65485a52df3b..8157b6d92c8e 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> -static int
> -xfs_map_blocks(
> +static ssize_t
> +xfs_writeback_range(
>         struct iomap_writepage_ctx *wpc,
> -       struct inode            *inode,
> -       loff_t                  offset,
> -       unsigned int            len)
> +       struct folio            *folio,
> +       u64                     offset,
> +       unsigned int            len,
> +       u64                     end_pos)
>  {
> -       struct xfs_inode        *ip =3D XFS_I(inode);
> +       struct xfs_inode        *ip =3D XFS_I(wpc->inode);
>         struct xfs_mount        *mp =3D ip->i_mount;
> -       ssize_t                 count =3D i_blocksize(inode);
> +       ssize_t                 count =3D i_blocksize(wpc->inode);
>         xfs_fileoff_t           offset_fsb =3D XFS_B_TO_FSBT(mp, offset);
>         xfs_fileoff_t           end_fsb =3D XFS_B_TO_FSB(mp, offset + cou=
nt);
>         xfs_fileoff_t           cow_fsb;
> @@ -292,7 +334,7 @@ xfs_map_blocks(
>         struct xfs_bmbt_irec    imap;
>         struct xfs_iext_cursor  icur;
>         int                     retries =3D 0;
> -       int                     error =3D 0;
> +       ssize_t                 ret =3D 0;
>         unsigned int            *seq;
>
>         if (xfs_is_shutdown(mp))
> @@ -316,7 +358,7 @@ xfs_map_blocks(
>          * out that ensures that we always see the current value.
>          */
>         if (xfs_imap_valid(wpc, ip, offset))
> -               return 0;
> +               goto map_blocks;
>
>         /*
>          * If we don't have a valid map, now it's time to get a new one f=
or this
> @@ -351,7 +393,7 @@ xfs_map_blocks(
>          */
>         if (xfs_imap_valid(wpc, ip, offset)) {
>                 xfs_iunlock(ip, XFS_ILOCK_SHARED);
> -               return 0;
> +               goto map_blocks;
>         }
>
>         /*
> @@ -389,7 +431,12 @@ xfs_map_blocks(
>
>         xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->dat=
a_seq);
>         trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
> -       return 0;
> +map_blocks:

nit: should this be called map_blocks or changed to something like
"add_to_ioend"? afaict, the mapping has already been done by this
point?

> +       ret =3D iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +       if (ret < 0)
> +               goto out_error;
> +       return ret;
> +
>  allocate_blocks:
>         /*
>          * Convert a dellalloc extent to a real one. The current page is =
held
> @@ -402,9 +449,9 @@ xfs_map_blocks(
>         else
>
> -static int
> -xfs_zoned_map_blocks(
> +static ssize_t
> +xfs_zoned_writeback_range(
>         struct iomap_writepage_ctx *wpc,
> -       struct inode            *inode,
> -       loff_t                  offset,
> -       unsigned int            len)
> +       struct folio            *folio,
> +       u64                     offset,
> +       unsigned int            len,
> +       u64                     end_pos)
>  {
> -       struct xfs_inode        *ip =3D XFS_I(inode);
> +       struct xfs_inode        *ip =3D XFS_I(wpc->inode);
>         struct xfs_mount        *mp =3D ip->i_mount;
>         xfs_fileoff_t           offset_fsb =3D XFS_B_TO_FSBT(mp, offset);
>         xfs_fileoff_t           end_fsb =3D XFS_B_TO_FSB(mp, offset + len=
);
>         xfs_filblks_t           count_fsb;
>         struct xfs_bmbt_irec    imap, del;
>         struct xfs_iext_cursor  icur;
> +       ssize_t                 ret;
>
>         if (xfs_is_shutdown(mp))
>                 return -EIO;
> @@ -586,7 +601,7 @@ xfs_zoned_map_blocks(
>                 imap.br_state =3D XFS_EXT_NORM;
>                 xfs_iunlock(ip, XFS_ILOCK_EXCL);
>                 xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, 0);
> -               return 0;
> +               goto map_blocks;
>         }
>         end_fsb =3D min(end_fsb, imap.br_startoff + imap.br_blockcount);
>         count_fsb =3D end_fsb - offset_fsb;
> @@ -603,9 +618,13 @@ xfs_zoned_map_blocks(
>         wpc->iomap.offset =3D offset;
>         wpc->iomap.length =3D XFS_FSB_TO_B(mp, count_fsb);
>         wpc->iomap.flags =3D IOMAP_F_ANON_WRITE;
> -
>         trace_xfs_zoned_map_blocks(ip, offset, wpc->iomap.length);
> -       return 0;
> +
> +map_blocks:

Same question here

> +       ret =3D iomap_add_to_ioend(wpc, folio, offset, end_pos, len);
> +       if (ret < 0)
> +               xfs_discard_folio(folio, offset);
> +       return ret;
>  }
