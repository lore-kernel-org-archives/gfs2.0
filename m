Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18A25487E
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188180; cv=none; b=KsHJA+dhIovWvGb9BTIJYNTbOMEQZeHWX0tICpylcRs1aTOQ3g47PvGiKeigJC7cmcVmwB1FGo1VX+cS3GCuS6ssicawJnLC0qBNnJGeiJx1dca0w9H4kAS95fjjOoL+yqfamCDLzrwJi2wz/WauOoMuUskE+Oh1GhfysBTWAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188180; c=relaxed/simple;
	bh=FfaUNO8KpPoc0RWyB1GbfrG8lv9MFVQR/RiQ8i11xlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9/729bRkBdHeblTzFws4m4RbE0NL4fDxbBysBnjkciO614AmLXKvBJMOIanNx7MZJFFnr5+2maHssITo0cEd3LDMIDkNXMQkhLIB1r72QrnXMkIOiUecBBQ1pa/9B/dYzEJemLE4umm9e34YcMuTC+lvCpycfIrR5Rtu6sVqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnn6Wf+c; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnn6Wf+c"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3e5df4785so43254385a.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188177; x=1750792977; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTuPRhZ2hLfje0TtF5tXPw4TxRM1c2w1EC3x9NIb01o=;
        b=Bnn6Wf+cNlEyWrD2yUHz0CZUs48H8Vou8cYnB0GyUbCsHuzmFH6ZSrkxKkv9beUwxD
         HOZzkcIFe6uP6eN4hhL+SmGsZP38OeLLxStshhSuUQ4hmpwW8KgdKxWrjppxayTMR/1J
         LJhvCS/AvtPNNbwOjCVed9EZU9pPyAHlGXtyQPD+iWlDwswzeJ7NDbIwOqynOkulKMdH
         cFRqCuATLbAOvIh6UzNDc4eexsAms3hBYCEu/YXqNu/AIod/u648c8o9J/vV/Q+9RUX0
         dhhg1JjK6KrBKdlTHlFVVkywwd1z80wMhWt+m2cUi9AK2U7551xANGREnM96DoaM+8Pa
         6jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188177; x=1750792977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTuPRhZ2hLfje0TtF5tXPw4TxRM1c2w1EC3x9NIb01o=;
        b=d+MUJgheZ6tmrg8Hz0R2aPzXXfBAI3Jjya3LqVtPSi3o7LL61PsSLAAGxt8HXTkiIa
         O3If/Z543qclmpPjZGyH3TouPy3QH3XpCrBI3wefVclo3yrI/TRV22AnVRUoYdQGaaNl
         YNkY2vmeKVt6Xa99P9MBB4nLutC3Pqs7oys8mANdxigsJGE5guSN4qyzQIEpwQxJRRJR
         0CyONQ0ZXJpRrpbP3q9s2b2VQwPY+mElQhSw3P6tjs37TGlsszWw8+UH3yMmnrZ2IzZ3
         qChmmjQXLXrZ1hifMPbJVU0JcCDpKU9/ZEtOiw985iFY0ARya691lMB375uLsyEl1m8B
         ULiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Qf8gUv9jVb/obvVk89URftC2PmP+JJFsrZk3t3lwZceJ462Dnr9ogsVoiHCMdwN80DeU@lists.linux.dev
X-Gm-Message-State: AOJu0YzMGcP6E/TPU5PGDhzzbIogPzidoiDNt0w9/wB37k7oDMDkTCXo
	8FCFnP1S8bHHRFiUhbxjc3LQs35bbUYteJeHI+03tZiRM/9tm5e6zZFoeq3l+Wug1wOLo8ZZFPX
	X2XLc2VPaBn7bd3xOJcqu3cBDIg9Pt3U=
X-Gm-Gg: ASbGncsfltjDq0Boy+0kvZA4vEjmXyT4EEE69y0f+F7AtYq/Gx0hmdlrDhwxWQFW/Gy
	HUse78Z7/jfJvVmg+D9zVA7TOKYBEG9jY/x1QtX/X9qVZ93d+NIo1txy7+gA1nt5TWwU0LdvB+S
	vKJStGsTwOFu9aJz680zpHqSO635a8TUgcu5CT/fhgDyXeUSrhFsbIghpkTfeQG9VAcw8eUQ==
X-Google-Smtp-Source: AGHT+IHRdI3/f0y0wG23sczG3px7bi68sqYFlEBf1JzYzdrdRrmEOwVECbVEbOweo6w8hQnxNrazxSmbQ0I0Ii7zvmw=
X-Received: by 2002:ac8:5813:0:b0:4a7:1460:f1bf with SMTP id
 d75a77b69052e-4a73c4be974mr274238361cf.13.1750188177475; Tue, 17 Jun 2025
 12:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-5-hch@lst.de>
In-Reply-To: <20250617105514.3393938-5-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:22:46 -0700
X-Gm-Features: AX0GCFvfh7aYL5wq83zSBRZKADreiQZ79xGR92zC7vIzmrKoqBPJnWJXwA3DLRk
Message-ID: <CAJnrk1bgWwmE8XeYe4gRrYCZFwTsn5JT3Aw7B+morrOLiZowFg@mail.gmail.com>
Subject: Re: [PATCH 04/11] iomap: hide ioends from the generic writeback code
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so

I'm confused as to whether this is mandatory or not - afaict from the
code, it's only needed if wpc->wb_ctx is also set. It seems like it's
ok if a filesystem doesn't define ops->writeback_submit so long as
they don't also set wpc->wb_ctx, but if they do set
ops->writeback_submit but don't set wpc->wb_ctx then they shouldn't
expect ->writeback_submit() to be called. It seems like there's a
tight interdependency between the two, it might be worth mentioning
that in the documentation to make that more clear. Or alternatively,
just always calling wpc->ops->writeback_submit() in iomap_writepages()
and having the caller check that wpc->wb_ctx is valid.

> that the generic writeback code stops seeing ioends and bios.
>
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM

> ---
>  .../filesystems/iomap/operations.rst          | 16 +---
>  block/fops.c                                  |  1 +
>  fs/gfs2/bmap.c                                |  1 +
>  fs/iomap/buffered-io.c                        | 91 ++++++++++---------
>  fs/xfs/xfs_aops.c                             | 60 ++++++------
>  fs/zonefs/file.c                              |  1 +
>  include/linux/iomap.h                         | 19 ++--
>  7 files changed, 93 insertions(+), 96 deletions(-)
>
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentati=
on/filesystems/iomap/operations.rst
> index b28f215db6e5..ead56b27ec3f 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as fol=
lows:
>   struct iomap_writeback_ops {
>      int (*writeback_range)(struct iomap_writepage_ctx *wpc,
>                 struct folio *folio, u64 pos, unsigned int len, u64 end_p=
os);
> -    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> +    int (*writeback_submit)(struct iomap_writepage_ctx *wpc, int error);
>   };
>
>  The fields are as follows:
> @@ -307,13 +307,7 @@ The fields are as follows:
>      purpose.
>      This function must be supplied by the filesystem.
>
> -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> -    submission.
> -    This might include pre-write space accounting updates, or installing
> -    a custom ``->bi_end_io`` function for internal purposes, such as
> -    deferring the ioend completion to a workqueue to run metadata update
> -    transactions from process context before submitting the bio.
> -    This function is optional.
> +  - ``writeback_submit``: Submit the previous built writeback context.

It might be helpful here to add "This function must be supplied by the
filesystem", especially since the paragraph above has that line for
writeback_range()

>
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 063e18476286..047100f94092 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -391,8 +391,7 @@ sector_t iomap_bmap(struct address_space *mapping, se=
ctor_t bno,
>  /*
>   * Structure for writeback I/O completions.
>   *
> - * File systems implementing ->submit_ioend (for buffered I/O) or ->subm=
it_io
> - * for direct I/O) can split a bio generated by iomap.  In that case the=
 parent
> + * File systems can split a bio generated by iomap.  In that case the pa=
rent
>   * ioend it was split from is recorded in ioend->io_parent.
>   */
>  struct iomap_ioend {
> @@ -416,7 +415,7 @@ static inline struct iomap_ioend *iomap_ioend_from_bi=
o(struct bio *bio)
>
>  struct iomap_writeback_ops {
>         /*
> -        * Required, performs writeback on the passed in range
> +        * Performs writeback on the passed in range

Is the reasoning behind removing "Required" that it's understood that
the default is it's required, so there's no need to explicitly state
that?
