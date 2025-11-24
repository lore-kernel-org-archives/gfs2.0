Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1292586E8
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763947728; cv=none; b=EaC1eS/p9PyMGcDnzpapcaP2ZWmqYhydsR+g8hybxjDxj3VoNhnalQF/bW6lzRMNIBGcJOpN3sqwJQP8bRBoFcUS9au5zxA9oc56SFHrkt4uXLOjuwBICDkNtVG8CdWZncbH4JZi3zZspWB8Svh60mAguO/U9/WHCtmlyyWLpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763947728; c=relaxed/simple;
	bh=Tdtix09h6RcCKm+k90F10JITFmAMc7QjiDjFYuJxxsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPaDQFERlmp897e3g5QWquiBiQqyTKJ7jMdVYUtfFn3sUa6UMrlWie8nXWHBowu6+X8r6As8SJVkP95xpAJr3sAnFhWYY59M1311GTQQ4hmSeQrW1YBoXK1SIiSqQrHDb/YPzsxxcJz44xQolQbqLiDosjDfPjqxaiWesI9ys4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X12erFp4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12erFp4"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-882451b353fso27102666d6.1
        for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 17:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763947725; x=1764552525; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=X12erFp4huV92f5OSxMo9GAWcUTYRMdr+QxMHYP88oq+BYfKDLErxOznnUnso+E5Ab
         oz7lnZ3unQj3yuASvRWMd2tuvhwqQn6saUPa9fa9kOenuQLvVKH09cbMnezTgCeTi1BV
         7IByyDrIEdHiCQ3Rz6hG4i5jWAVR7vhEAa7bssi8Z2mmEoN5kO5hW0zLp43oFuYO2MKm
         BhaEos5b42jUxSUh9WbqVANb9rhzzw43P1ssSn/1CswP/tSQUOVn/N1lArxsMDcrbaEr
         ay4q1caX3WPi5EToCaMFM7Utx4z4HsBAjeZ08N9Lf8N1o0CiaisDJlkWhJP106UkoODD
         R8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763947725; x=1764552525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=k4gNrhtA+lZWmJkPMPbklxD5M7IGM3mIFq+Q60SsoOf9zymUNS8g4SBWXhZMnSD0vi
         SaJKVo0rGbVxuAvWf0xtJ0ZbrthqYT11chCYwmwnu+LneXFMcKh0Dgpf1Irr66V//7Sl
         BgndgEbAX8HVNcLN4K8FXTknrkoB0B2GTB0EC0MKFm5/Comuz4c+cQk2I3TvhW1QtVhR
         D+C/BaP70PsLU0odxa0Np2yJbN0qwKlSt5fwehNNALJHpIctgDPEqCyW84SZM1yQTNrM
         YZdNyBa8KfFj2WRMTpSlK1d3PjMXZxzdz8HoctP5ZAWJrzS7kKAYJOwVGO6F36AqqXY1
         +EqA==
X-Forwarded-Encrypted: i=1; AJvYcCX3+0kwdYVR7MRIWFIm6KH2McOwN4BiPEg7XpUxLJDD+YpxOj/KtfhnSrAmsikco+NuVc2V@lists.linux.dev
X-Gm-Message-State: AOJu0YxQWyevGOntbK3SXLhCK17ePknJzfNp72QqA2wRWO747+VOIxMw
	rvcQPlg03eMtvbe8HWtEKK6yUhGBe+MXI8HA3e3VND6Z3hQzOr6s+AI4+MSmtnQ1ElBQw2DMSdy
	sLwJJgCuV0aM1gQPjoF7N+DWLDRMifuw=
X-Gm-Gg: ASbGncvjPgjr2RNmo3OQ57RAk4N/d3eOi7Xhn8XiO5oPRuWFC3sNKNCfS3+a+KgI1YW
	jIH12aMv7Gqa/M2YcbgGy1kpm8rBoQ5I53khMnkNXrAGTO9Rl1Gl3V76WcQpeUNhm6FRePjttj/
	Uf78q8g2t80JVXueeMcmiJXM/qn2QaEvcy8FAv2qbjzooQpco0OI6tR/rE6iWn+FSKdKr4KJUUf
	+gM/YgH5IIRaJRb4ULHR9Zt59dkIXNvUbpzUNJRNxmGpN6WtFQ6YGsB1Zbw5O7n3p0zRpoxhgv2
	CjpI9Q==
X-Google-Smtp-Source: AGHT+IFHZruP2YBfL7pdTjTDvePbwJad50RtaobjpQ37TLxnePvW54pVHPb5rvzSUyg3BEeJesXp2k7UVUVu8L9oRt8=
X-Received: by 2002:ac8:5d0f:0:b0:4ee:2080:2597 with SMTP id
 d75a77b69052e-4ee589103cfmr127248731cf.38.1763947725292; Sun, 23 Nov 2025
 17:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
 <aSMQyCJrqbIromUd@fedora>
In-Reply-To: <aSMQyCJrqbIromUd@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 24 Nov 2025 09:28:09 +0800
X-Gm-Features: AWmQ_blFIl-YjYfjpEue9I17YWgGWhW3tKNMKvxlJbU5ZD_pYkwFt7d133xm8_0
Message-ID: <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8823=E6=97=A5=
=E5=91=A8=E6=97=A5 21:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > > > static void bio_chain_endio(struct bio *bio)
> > > > {
> > > >         bio_endio(__bio_chain_endio(bio));
> > > > }
> > >
> > > bio_chain_endio() never gets called really, which can be thought as `=
flag`,
> >
> > That's probably where this stops being relevant for the problem
> > reported by Stephen Zhang.
> >
> > > and it should have been defined as `WARN_ON_ONCE(1);` for not confusi=
ng people.
> >
> > But shouldn't bio_chain_endio() still be fixed to do the right thing
> > if called directly, or alternatively, just BUG()? Warning and still
> > doing the wrong thing seems a bit bizarre.
>
> IMO calling ->bi_end_io() directly shouldn't be encouraged.
>
> The only in-tree direct call user could be bcache, so is this reported
> issue triggered on bcache?
>
> If bcache can't call bio_endio(), I think it is fine to fix
> bio_chain_endio().
>
> >
> > I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> > erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> > are at least confusing.
>
> All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involved
> in erofs code base.
>

Okay, will add that.

Thanks,
Shida

>
> Thanks,
> Ming
>
