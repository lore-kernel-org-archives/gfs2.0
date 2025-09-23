Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6051F4622
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641981; cv=none; b=OGs8QrX8WtvF9zsCxZ9anmlpVcrVRqh43o8ZKrV+orfq5sIyKcG62MsWWM2lu6UWSNAEJiDwfJ/hms5fXlp99Vm4utVsdzDUYnhACs+BQ9Peo4K7xGlSqpykndIarOYTRvi4DJV2gSbuXqGEgvhBfU5pN0p8d8kqmgoUIUksc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641981; c=relaxed/simple;
	bh=leaYlnpusCp0sviLQ30QGe0J2gUEvF7RJCcVhGVbZ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjhhlVyQgAIoDWk/voNi6RZdG3iA56mt3DkP031DpJXwXqdg2S95CiNAX6dBL3rUtlmFM3ZD92YYOCDGmzTshMkT9ybmdRMej9C1oLl/TsAJX79IYw7P36+7lkhKwDb0Y5UlNi5zH8VmPUWBilQ7OJdx/H9iRCC8LT7yLUz3NVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nhyviPEC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nhyviPEC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4cf068ffe4dso15344551cf.1
        for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758641979; x=1759246779; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=nhyviPECbYGIgxoOvzkbuHB2MIDPmMtNJD+S431H/L/yOAvr4CIYXpW3G+78CnIaSL
         wwFJKha0NRe/adJpHkI5b9OWB02qLxv/9DDVIC1Gjv2rNHC95zQUF52aZ9yx3jpOtMiH
         RhY86xT+uOI2IsTJhJb5qw2uLuEuVQy20EzVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641979; x=1759246779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=EzSLZf2o+Pm7czPtJLb7robcg4+wqeDfXkJW3pCB3wszbO+jfTuyGWUYS0lCgrRL/f
         HxYxjfVkkH33aYjFuV7lAcpJAa2mP9SLt/2D/Y8f8QJFsE3w6xJgSVGXGE9jZIHWqzkx
         4PhFl7tg16Ua9msEd8FpwxhFXR5uedCCWh+icuUC2g2aTXS+MozbZImrRAPhSaC6RPQk
         +UaSrWH7AkQ9NQupq/hlGqJ4SROsKzQqENw9wSnkg+K6+qByd4e0r3CZmWM3hA+dzYPW
         0JfNy2oCmRnQnaPXrhxsvQcrpt2TRPt7Khs3yaBeVilGp+pUDZ3jkNTn7f1E2bgDS1RA
         F0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVorV0kBKDhfn1PRDvSTzFDjx7kcZuCLhJUpvsd4K0xHfTKI5L9JBxEU6ZRdUx23V/gLYhf@lists.linux.dev
X-Gm-Message-State: AOJu0YzlJJbwfeYdPaCIE6hTuED+swYVGDtJ7c1bIfpqRohxZx2SqiPg
	tmDeqcDr9JdAlHqQOA7cyUMbonK9LjGWU/8OGZkwkDUgw6g7fGVvLNP5zqBZl5vObmdzPBy7+0l
	yKSIKNWWCTpWt8jPXQTvPVwrefVLOdAntGajRjVs4wA==
X-Gm-Gg: ASbGncv1yXflwEx/GxSQ2jxpJEdBjs7I2LMkKuxkOG5EU34lQq+5p0qvoq3GPCOo1Dy
	ZaU+ivb0RahGAEF8V0Y9IEZe7Twk3616PCHZ6nj7G5jIa8ZvpkerGQB270ovakqje5/dH17RF6Z
	D46s4EsS6cryy20GKPEqRZoDCgtoA5mYGRK5UmWL1XFXs6vxMA2OaeKbdxhljQaIeUmFlED1iLI
	nnQMfj5uQFmvH8m/ap99rn8qf0UnZTu4fo+hsWzuPM/nrKUDs69DeeJvu0Ckmdg33BuCgsJ4gGo
	KEjiQR4=
X-Google-Smtp-Source: AGHT+IGspaeUy0TVQz+LKc1fihw58Q7yPvQbyT2d42SL63rUJcZogQsEDyrgJGDuBFJvNYzyLCvEvUn0X00pmc3DhAA=
X-Received: by 2002:a05:622a:1b13:b0:4ba:c079:b0d8 with SMTP id
 d75a77b69052e-4d367081860mr29707731cf.17.1758641978539; Tue, 23 Sep 2025
 08:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com> <20250923002353.2961514-14-joannelkoong@gmail.com>
In-Reply-To: <20250923002353.2961514-14-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 17:39:13 +0200
X-Gm-Features: AS18NWD8_t8WUM8mJa_Wrlt8XR1hgYkR6Ub6lG20YNejgtDUqRhxsnnPFLDpPVI
Message-ID: <CAJfpegsBRg6hozmZ1-kfYaOTjn3HYcYMJrGVE_z-gtqXWbT_=w@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] fuse: use iomap for read_folio
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 02:34, Joanne Koong <joannelkoong@gmail.com> wrote:

>  static int fuse_read_folio(struct file *file, struct folio *folio)
>  {
>         struct inode *inode = folio->mapping->host;
> -       int err;
> +       struct fuse_fill_read_data data = {
> +               .file = file,
> +       };
> +       struct iomap_read_folio_ctx ctx = {
> +               .cur_folio = folio,
> +               .ops = &fuse_iomap_read_ops,
> +               .read_ctx = &data,
>
> -       err = -EIO;
> -       if (fuse_is_bad(inode))
> -               goto out;
> +       };
>
> -       err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> -       if (!err)
> -               folio_mark_uptodate(folio);
> +       if (fuse_is_bad(inode)) {
> +               folio_unlock(folio);
> +               return -EIO;
> +       }
>
> +       iomap_read_folio(&fuse_iomap_ops, &ctx);

Why is the return value ignored?

Thanks,
Miklos
