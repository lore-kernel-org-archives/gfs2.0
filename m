Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CA30DECA
	for <gfs2@lists.linux.dev>; Thu, 18 Sep 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210522; cv=none; b=A61Nw93Cf/CZiQ4rTLtzqX2QCPzryGXgb5mUZJ/3DGRqEkZpQpHh14aY2ba9iZYaETlvGF0Iq08C/T3YqhL1/5/ymTA126H7Ja1qOPspzRteQC0roPbipjr4573NthTCOJ51PI7PhnRLGfG69SFCE6tTISNPddiRVn6NKOLVdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210522; c=relaxed/simple;
	bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXe0IaSVURIvi4B17lGVddLRKKebGqp5YdfZblnJTdoTn1Chh5PxiKs7hG/9iBXWsu5FgltetAAuPd8kgN9gwx5ua3kFz77d4xSxBAiZYjqtOZs9Uhe0HNP1gTtjOdHKg/M67Zb4DehyDgsQTIVD2CJABQkslyiJt9Rt/c0zwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYIKjKnf; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYIKjKnf"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-621b965a114so598589eaf.1
        for <gfs2@lists.linux.dev>; Thu, 18 Sep 2025 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210520; x=1758815320; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
        b=xYIKjKnflkMRbR+wm+14XTYMyNRdTwmhhCZtHjlYrw44gIoY9fWL1bnfOwkEaF3wu4
         TWt1X0WjkEo+fxFGNo3XZ6Qq1fwT2mQYyIgychrSvjsqSBqHJzJx2+jx9+vDnI3OwzQC
         FLS1eriMgUxshm8+lM/vItu/VT7XjbQI7UOsS0gbftJVScrk9b6qXnyVpjVwayD1HjfH
         34FYTRJPPSilCQ0vmr3ccivSvgLKuBgHsDJUadEOvCvS8cwhjXNlVSEsbBD/4lTc+kdg
         5TJcZEJa9FJ8jJFf3jVc472s247Jbr5RJTvLau7d2rQbgYMs5fYO3L8cKcvp1oE7mLJ+
         wYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210520; x=1758815320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuPAHF2wqUzCF+Ih+V96s2Pa8BfHBVrf909ozzJYxs=;
        b=jWcPF0dagqf6dB52JqYOz7dBbXjJfAFqNHOfmi0XnAn0mmHba2Njbdk+4SxtH7H5g5
         1I0jr6w10Pu3VsKeSVe+BHQU+Wo4s8754q3A6nXfZLB9fwOYA0yPADbjW2TRP1B+zJZ8
         JPvqGvOh+TDhyn8S06q1eJ9mujNYayCc3ciDiUNady3e7uAjZ5yBhb6/gPcDzML2D1Rp
         ttRoMkdjRhzT6u5KQecPn0PJzWxRqzWSozWHmYmXmXRT6elnUXSWKqNYptzxI1dcwD36
         3eR+J/CXv91wkhXcoTeT4aIhJjKikTgmOs5KmmSSZVcY1FdHeG2KQSrC6TmHkttxVRnK
         wT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvvzoguORTZiJO0SLS6TYeT2QrZgkk7qlTvcUFuysJqWhrR7lT0sTVD+AjhpuHITCq3pG1@lists.linux.dev
X-Gm-Message-State: AOJu0YyYOVNd+1dNp/BkZHp3GdVEpHZPlXa9l9bRSsQejAY24sXrqFRX
	zFTkAhXiEdUsEV4ZaF5xxY61oY2omYFcaKN/7DN9hgc4JN5LqTK79DKSW8mxITnh7m17teTThxO
	AYXIBwuaw3LyPHuXVzD4XOxAwqUVkNPism4rjcpV6
X-Gm-Gg: ASbGncv+V6fueRTgLznaM8iVvIArNggdN5LuYGaecbuWjual8FTL5kefIIVsiQ90GMV
	ZNDCuQ6DWVP0AZZ3nHTs/BIxcuG3n8pK1ZSCyxxL//t/DxHBy4btQS65y5neCS4sQwuuYHojfYW
	83V9dRFW7aQoi/i6yl3mFTujkOrBTTgeG2eHghHx22nI8rykv3HyJiR1ev1ILGmwGr5h0uy5wak
	9CT4MpdrpbSMtGFvtViipqzYp7PwCpNuyO1uyXfnk4lVSsVr/reQA21As/h/G8=
X-Google-Smtp-Source: AGHT+IGZQIGtkvyQ7wUbXbPktQnaEGHmteV66ZUVON5NljKX83ZF9JtYWo+pN7TerpN49zbUut8goBymhFyWExBBTaQ=
X-Received: by 2002:a05:6820:c006:b0:624:abae:b650 with SMTP id
 006d021491bc7-624abaeb894mr2040726eaf.0.1758210519920; Thu, 18 Sep 2025
 08:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <68ca71bd.050a0220.2ff435.04fc.GAE@google.com> <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YKPWkaBXe7D2mftN2DMEBqFow80reUGE=2_U8oVFc1tQ@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 18 Sep 2025 17:48:28 +0200
X-Gm-Features: AS18NWAU9uKKLdv_CQUnITI5tezk67S_wzRhWyVluYMjy37dGuE_05c1-3Y9NYc
Message-ID: <CANp29Y5Y8iO+UbKHtDEc=0d+76WxbWJK1asLaux++_n+Pr+d5g@mail.gmail.com>
Subject: Re: [syzbot ci] Re: fuse: use iomap for buffered reads + readahead
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot ci <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com>, 
	syzbot <syzkaller@googlegroups.com>, brauner@kernel.org, djwong@kernel.org, 
	gfs2@lists.linux.dev, hch@infradead.org, hch@lst.de, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, miklos@szeredi.hu, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

On Wed, Sep 17, 2025 at 9:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Sep 17, 2025 at 1:37=E2=80=AFAM syzbot ci
> <syzbot+ci9b5a486340e6bcdf@syzkaller.appspotmail.com> wrote:
> >
> > syzbot ci has tested the following series
> >
> > [v3] fuse: use iomap for buffered reads + readahead
> > https://lore.kernel.org/all/20250916234425.1274735-1-joannelkoong@gmail=
.com
> > * [PATCH v3 01/15] iomap: move bio read logic into helper function
> > * [PATCH v3 02/15] iomap: move read/readahead bio submission logic into=
 helper function
> > * [PATCH v3 03/15] iomap: store read/readahead bio generically
> > * [PATCH v3 04/15] iomap: iterate over entire folio in iomap_readpage_i=
ter()
> > * [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_fo=
lio_iter()
> > * [PATCH v3 06/15] iomap: rename iomap_readpage_ctx struct to iomap_rea=
d_folio_ctx
> > * [PATCH v3 07/15] iomap: track read/readahead folio ownership internal=
ly
> > * [PATCH v3 08/15] iomap: add public start/finish folio read helpers
> > * [PATCH v3 09/15] iomap: add caller-provided callbacks for read and re=
adahead
> > * [PATCH v3 10/15] iomap: add bias for async read requests
> > * [PATCH v3 11/15] iomap: move buffered io bio logic into new file
> > * [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
> > * [PATCH v3 13/15] fuse: use iomap for read_folio
> > * [PATCH v3 14/15] fuse: use iomap for readahead
> > * [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial writ=
es
> >
> > and found the following issues:
> > * WARNING in iomap_iter_advance
> > * WARNING in iomap_readahead
> > * kernel BUG in folio_end_read
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> >
> > ***
> >
> Thanks. Do you get run on every patchset that is sent upstream or is
> it random? Trying to figure out if this means v2 is right and i just
> messed up v3 or if you just didn't run on v2.

The intent is to run on every patchset, but since the system is
currently still in the experimental state, some of the series are
skipped due to various reasons. E.g. syzbot tried to process v2, but
failed to find the kernel tree to which the series applies without
problems: https://ci.syzbot.org/series/7085b21e-ae1e-4bf9-b486-24a82ea9b37d

In the original email, there are links to the C reproducers, so these
can be used locally to determine if v1/v2 were affected.

--=20
Aleksandr

>
> Thanks,
> Joanne
>
