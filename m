Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3342F0689
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431481; cv=none; b=X0Q+RUcQQY7vABWS+WP1i5f+az09S8a7iBRTi6N3pDKRuIZN5IXdTeDAZpwHlZDo7AwR9hPK1a/lMuIiI5Hhc82aVt1Drx2YX7HVVXljyhISQ4yyHHzWe8mb4VYxcKP0EvcR3+7JSPcxDnZA1YoIhveX8+nSD/ATxE9Ektl+LW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431481; c=relaxed/simple;
	bh=3R0m6L3Xc0jpTLVgVCR9emnQCAji/4frJjenqqSAQLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ItOpzB1UdDfOjePDlJdaALf9K8SdMDtCNVydvfFCctvrj/LtaExoy2XiMDVLj0UKTMQAIGz7D7cnCU2py/P/gKXRFcHgoy7MGU3p1UZ2JHwJlQ6grnhcJbVMpZbb0RtEh1/LSOhpLBqpjELdcGG3eV0h41F4lD8DGHJ3a9HSw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO/mFQCi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO/mFQCi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b548745253so80187891cf.0
        for <gfs2@lists.linux.dev>; Tue, 09 Sep 2025 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757431479; x=1758036279; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDbmDBECNsOMyPFBVxB/4/c6RAXu7g94A+5MaF46ZQw=;
        b=OO/mFQCiDUNOcrj42S5lJcWFza3G9JFMwYzD4QBgWPtXMPqkyqDgZ9Jh+FrYynYA06
         O6G2GfC1qvqRrhZvMcfqkOt4kHl0rKoxblpqx0XmVp3MjWWDiZcm7kS0/G0I4Qkblh46
         yBa4z1gsgnpMk0Bw1jB/c7RfS75ACFeD3hdssfCAkdCNHE9aek/hOXYQ2c0K9luqEkNz
         4YocdTBrLwHIYz/7k+4hQSMEaEsUJxUvzNgjjxCBp4fTtWoyVRCafkqXkTa2zPvM3rVv
         rgusDjkqk8JruvZXO+eU+/MBYbY9KdH9+VXojYHa2yuSU078a6Fn3mfk0IB6IcTUuAD1
         2lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431479; x=1758036279;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDbmDBECNsOMyPFBVxB/4/c6RAXu7g94A+5MaF46ZQw=;
        b=UGMvW6bTG1khRvcBsZsojQv0ccGraZvViabLaBXzjxxcYFNHD7GNVdCuoO1nM9qMXv
         2KPM1Y7GIrvHEZErMrC++WbsENRyEo5es1PpgOMp3MznMU59RkDg6/X7FtBNhP2Bk8DU
         eIstyb3iSLhZxACiuyxDk31Xu9//rvug0rwXVvHAvvfw6/K4y1+G10DHWoQdYGMYqPzU
         Z30JP1bQq0zVxjoxgEMaXBhlTbEVhtZYONWOfRlakBCDaQJa/iglqvGBDLv87RVRL+0b
         9ORZ+zCFnW0Lxf8BmOHQyNx/z9t6WjW8tmVJMWN8c+UAurJqQYMQtxl+lW5A649yaqpu
         T/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsrfLokwseSiFCs6Q4UidkHcG1pwTuDEhSvKqGICEXJI2ZW9GkfdgIxLDbXvckImzjYcX@lists.linux.dev
X-Gm-Message-State: AOJu0Yy21w7CHxaWY5Z7x3tO+VncbTogdhx4X8+6A938d4Jco68jfyWp
	6w/KGED8xGCLjtaqHzNYElRaDaQxUnqeglLFLWb8qPMzPlogi54nLKieWLgeVNDSJzii7OBAI1o
	kblyV0iAyRdLutsFMUAJP8ED/zjZni10=
X-Gm-Gg: ASbGncvGQljRTamb5iUVp0o5awN/GTHrm2QwgcNzTV4g6YaTGt3WIH9VeJ4rkY0FuE9
	w9KuDw6m1aGb10ShQR0RxNbt8otYMG4rkwAbmSvpy6rR6rrjhSPvgpDWVSlmZo8DlYJ0iy3cR4T
	YUjfMKDBkDbfL05n74vBqIinOB2JuP9yLluBmLfd70GL96r6RL7sEzC+WWGLfslPG7kGXNlYGzt
	QRF+lKphBZRye6J9TUyG4I=
X-Google-Smtp-Source: AGHT+IE6h/blzNtkiS7tRQSAW4vjy70N2RtjiCed7Thx/n7bpwfptLXKBBHGKN92aIlVAliSIdhlvRW+askAAL9wkJo=
X-Received: by 2002:ac8:5dd1:0:b0:4b5:f421:14dd with SMTP id
 d75a77b69052e-4b5f836b29cmr131506101cf.7.1757431478686; Tue, 09 Sep 2025
 08:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com> <aL9xb5Jw8tvIRMcQ@debian>
In-Reply-To: <aL9xb5Jw8tvIRMcQ@debian>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Sep 2025 11:24:25 -0400
X-Gm-Features: Ac12FXyx8pmrJDFeGMYZs3RCR1CTlhpwdwdT0peJF0IyLF-S26qPwC0nNO2DnTs
Message-ID: <CAJnrk1YPpNs811dwWo+ts1xwFi-57OgWvSO4_8WLL_3fJgzrFw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org, hch@infradead.org, 
	brauner@kernel.org, miklos@szeredi.hu, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:14=E2=80=AFPM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Joanne,
>
> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> > Add caller-provided callbacks for read and readahead so that it can be
> > used generically, especially by filesystems that are not block-based.
> >
> > In particular, this:
> > * Modifies the read and readahead interface to take in a
> >   struct iomap_read_folio_ctx that is publicly defined as:
> >
> >   struct iomap_read_folio_ctx {
> >       const struct iomap_read_ops *ops;
> >       struct folio *cur_folio;
> >       struct readahead_control *rac;
> >       void *private;
> >   };
> >
> >   where struct iomap_read_ops is defined as:
> >
> >   struct iomap_read_ops {
> >       int (*read_folio_range)(const struct iomap_iter *iter,
> >                              struct iomap_read_folio_ctx *ctx,
> >                              loff_t pos, size_t len);
> >       int (*read_submit)(struct iomap_read_folio_ctx *ctx);
> >   };
> >
>
> No, I don't think `struct iomap_read_folio_ctx` has another
> `.private` makes any sense, because:
>
>  - `struct iomap_iter *iter` already has `.private` and I think
>    it's mainly used for per-request usage; and your new
>    `.read_folio_range` already passes
>     `const struct iomap_iter *iter` which has `.private`
>    I don't think some read-specific `.private` is useful in any
>    case, also below.
>
>  - `struct iomap_read_folio_ctx` cannot be accessed by previous
>    .iomap_{begin,end} helpers, which means `struct iomap_read_ops`
>    is only useful for FUSE read iter/submit logic.
>
> Also after my change, the prototype will be:
>
> int iomap_read_folio(const struct iomap_ops *ops,
>                      struct iomap_read_folio_ctx *ctx, void *private2);
> void iomap_readahead(const struct iomap_ops *ops,
>                      struct iomap_read_folio_ctx *ctx, void *private2);
>
> Is it pretty weird due to `.iomap_{begin,end}` in principle can
> only use `struct iomap_iter *` but have no way to access
> ` struct iomap_read_folio_ctx` to get more enough content for
> read requests.

Hi Gao,

imo I don't think it makes sense to, if I'm understanding what you're
proposing correctly, have one shared data pointer between iomap
read/readahead and the iomap_{begin,end} helpers because

a) I don't think it's guaranteed that the data needed by
read/readahead and iomap_{begin,end} is the same.  I guess we could
combine the data each needs altogether into one struct, but it seems
simpler and cleaner to me to just have the two be separate.

b) I'm not sure about the erofs use case, but at least for what I'm
seeing for fuse and the block-based filesystems currently using iomap,
the data needed by iomap read/readahead (eg bios, the fuse
fuse_fill_read_data) is irrelevant for iomap_{begin/end} and it seems
unclean to expose that extraneous info. (btw I don't think it's true
that iomap_iter is mainly used for per-request usage - for readahead
for example, iomap_{begin,end} is called before and after we service
the entire readahead, not called per request, whereas
.read_folio_range() is called per request).

c) imo iomap_{begin,end} is meant to be a more generic interface and I
don't think it makes sense to tie read-specific data to it. For
example, some filesystems (eg gfs2) use the same iomap_ops across
different file operations (eg buffered writes, direct io, reads, bmap,
etc).


Thanks,
Joanne

>
> Thanks,
> Gao Xiang
