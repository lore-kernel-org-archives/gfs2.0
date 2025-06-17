Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D1288CBE
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199157; cv=none; b=Va3GrLmyGcfwjaJsC4RfIq2ZUKbFdaCskzJHUyvhtdj3BHGNdZKUtsb8QPdksn/AoB6rNzGqx2767rfk4pI6AOffDy7k7INwcIvLDs3g5nNy1XCojw0hl/K4+cpU7WUMiuJAUF9WeO0dRNX8QQJ2P9c77Oo/W3ou3nlU4+Vyg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199157; c=relaxed/simple;
	bh=IkHODsj3LMl6DlIAGg//NNU39NjtBqCmQQsRmb27n4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGF7TvQYXHRCUjecT1xNA4aXh7HMntY2k2vidQ62FT/7OjmEbPsibYYJk2uB5KnRe33aaJ8pqjNQyquDN/SM+bAlTCI6zhAw2lSHkt7gV6R9CcXkYZw285lXqvYjJpshgGa+t9hWocJylZw6Nn/GvkczXnPSnXT6kWJydGzojD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3mpmOzg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3mpmOzg"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fad79433bbso66640246d6.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750199155; x=1750803955; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOHudB3qWFtr4TV/okRv6w4AxszP8orrjoIXfZSBLrg=;
        b=B3mpmOzgvWhEv74WCEsrd2sRWPCTj4ASoGzoRL7JKMwWct/tmAVNWOQg6RdvS/EgMg
         SXmYxLvf61fE6BBp7P+AAPu56tW9QcpwjUkQAsJ4x4Wzk2qPpUiztGiZ3/I2co891kEV
         JaOXMkVQaD6sBatswe1Rt9gmimKFKWC86L/5+z8eiqM5Ot+s8wc2nWG6pdkQk/8KgjNn
         UkBdvmAjoCcIXJU6X5bFyTPv0FkUwTQg57J0y9b7OSUDqISwJ2Lq/rb/iqRc5+hbDZwS
         D8bLI8jT3IO+2bE3XdEcV8W1LGRXvM7jHou4uTXzlFrX1hJgGteJL/wvZi0L/Nc4b63S
         OWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199155; x=1750803955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOHudB3qWFtr4TV/okRv6w4AxszP8orrjoIXfZSBLrg=;
        b=kDyojs5HM+peDU0f23lnFFYgHN0ogdWIuxfKuCT50aJ5UW6rOXywGrTrVbC5YCEaHb
         WzyVlKsk3pXj0xGEsywxDGYYfMV1PAC64mak1WAjIlEiDRJE5/jLgAHKnBk6Tp5NxGnW
         qlyU5WjouqMWPMFw9fWHmwZzRAXAKcyytJAAF4BCG6MWeDOIKzDQQOyb0DX/M6jrpH/0
         P39niCV9oftZcVdb2wRt0zKM2/a40Bbz1lAbbUMNhhPtb4vsj4McVHiw4LGtRvMv4k2K
         +gybH1h/UKeUnGFrV7himJCphh8A51RIb01dIHPm/BN0yHWMP6RZXwvhjZhPtc6/wybm
         ++MA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9tkgGHt8E5xCbydhog3ZRagSbq/EGKfIujxfOSkNvfThsHjC+Q3mUIRmwnOAAX/ngnLu@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5nI9vQ9Odypm0a92zLHwzURHvytJLwynGHcLcQ4ywC6KG9NJq
	6PFC9XKt/zUjc5PiPqFyKoDa3WN472jbhbZEfPFtA0i+S1+SN3b4TQcPhXYDGSIMfhQIR+YQla/
	giK59UZsZRMowgCnwOGgGMHlkh3FfzLfacRQ5
X-Gm-Gg: ASbGncuS1JoyLUJhkfs8q2KFPiSLrtEp3pzbwxCn4ktHiKvX0MzDCd8E9T1dbDezLro
	RB/oyOvQYpD/buiUUGNg9oCXi+TyoaW3IF2nOY7JCgb3yikAbMcm59/lcBpDFdZ4xf92dQNUls1
	P2475n+VI4TwAUwIOO/0xP4CXpD7xnKnfllHiEKU5UxgrCzKHbNl8UgGBzDs8=
X-Google-Smtp-Source: AGHT+IFT2IbS7IY/ZG8utAx1TX8YtZX4KzeTFUBS4g3I5+hjckINK4fFIkyAX5117p/bYpzRPLh6P82Wyv/n/vAtbzc=
X-Received: by 2002:a05:622a:d1:b0:4a3:4d46:c2a6 with SMTP id
 d75a77b69052e-4a73c51f790mr202374651cf.7.1750199154958; Tue, 17 Jun 2025
 15:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-11-hch@lst.de>
In-Reply-To: <20250617105514.3393938-11-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 15:25:43 -0700
X-Gm-Features: AX0GCFsI21gwIMPwJfdvUohzFbNWXhMjQxHEzcHQpvBVMKKQzS8fPtvEOYy6xzg
Message-ID: <CAJnrk1YOtCnAD2R5G1sYipG=aTkWBdYfm-F0iioV55sE5A_HYQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] iomap: replace iomap_folio_ops with iomap_write_ops
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *f=
rom,
> -               const struct iomap_ops *ops, void *private);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops =
*ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t cou=
nt);
> @@ -344,11 +337,14 @@ bool iomap_release_folio(struct folio *folio, gfp_t=
 gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t l=
en);
>  bool iomap_dirty_folio(struct address_space *mapping, struct folio *foli=
o);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -               const struct iomap_ops *ops);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> -               bool *did_zero, const struct iomap_ops *ops, void *privat=
e);
> +               bool *did_zero, const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -               const struct iomap_ops *ops, void *private);
> +               const struct iomap_ops *ops,
> +               const struct iomap_write_ops *write_ops, void *private);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_o=
ps *ops,
>                 void *private);

Maybe you'll hate this idea but what about just embedding struct
iomap_ops inside iomap_write_ops?

eg
 struct iomap_write_ops {
        struct iomap_ops iomap_ops;
        struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
                        unsigned len);
       ...
}

and then only having to pass in iomap_write_ops?
