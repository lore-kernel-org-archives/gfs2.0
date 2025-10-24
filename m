Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733428D8ED
	for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333766; cv=none; b=DLVSVsET2+NqFYnLtBg9OWcCuCZi1u+FrpwvcckbrnCeQpxFSKNKhiklM0xwpyhaJZ5maeYH8rv3mxlwSlRS/g6q3/yTxTQeNsEhR1CMY9pA+ItEqk2iXkEePjrcG9a14gvF6qYOAsCBHjIJ+n4NfWA7a4bFPDrHCC5IQgY4vT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333766; c=relaxed/simple;
	bh=QgsR+Vv3MGDc6mihpTVQXoOx12Z77gAlV2xrGnLO6/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQSXj5ULwCYpGn6bxyNoKTN/kRYeP7u3aMzS28xBhBoNTeimI3qi/AHgXzFVZgbKWqsEL1vPf1xr6R+KwO6eje1WAeTXv3AX4uBkrujW1/ttMi0faHhpu1b1Lp61JCZrtKLhRjjHwiR1vnrH2TxUy4H53dbePk6dole2MtWLloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjDAxH2P; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjDAxH2P"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e89d2eaca9so15162561cf.1
        for <gfs2@lists.linux.dev>; Fri, 24 Oct 2025 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761333764; x=1761938564; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgVsq2p7ysLPME1WhWajPgNYUjlNdQ3sSEmcEy2qO6w=;
        b=XjDAxH2Pn2HhKmXoHXYw/TW+hF0ryiZGp6+cyffsKp/5C5ptno1aNPiV/talFMF7M1
         5bhkb3JkSk41nnX/12iiS21RiBM1WuiBv4SmVr8oMrc6UdcCW64nNVTIrn3mViuY5hwx
         Ov+tqImx97qYIzeKoGHtEk4D0ah6dDqBhUBzosrc7IDlTE8zlk8H10xJm3b1cqLStkTB
         4a4sNpQhHz5hA7ZJaVr33rumFf39GwekHopV44e+9E45FZc5bg5ixYAfAUT/TalWD4Lx
         usqS7o09+inBprnNyxXSpFYspWx8bK99Z2LHdBUmgnFSAsPiJM2rzHcVo5R9So6AYKg+
         JfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333764; x=1761938564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgVsq2p7ysLPME1WhWajPgNYUjlNdQ3sSEmcEy2qO6w=;
        b=gcFegCA+A1g1mr/6z42ar8Ejv6iGe8W5D53MQRV0UkkbVpBQU4WQvLLXMFp45FB5Ut
         n0nr8Gdx/PKcmvd3XP2FljN+e0/lvIgk6MXHTx6O2KTm/GzmSBNCL9P3o61mlLt8xJav
         fHt2kEqocJi+xUSKiJr2Q1rAADhquofOtM0OF7qzpNvmIoQPocUFq66Avi0P260C2+Nn
         4IsK+EpRCGddJos++gBT10jkMSj7dkkXMzaL5u/UdV783kPisvL6FSSrOMgulVV5NbWQ
         dfet19amE6LpoL6g0L0P+V1SmBGzQDYuQsS+2Q7LxDyrHvf9IxK8gr0cMTDBZnwzJ6YX
         bGCg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKpHPJBtEfb20m4LXwRqRpMMk3opWVCTCIPimpkAfu9Ol1D5CaR2rJTcRTlETWMIfQdPy@lists.linux.dev
X-Gm-Message-State: AOJu0YyZDe4DpSS9LD9GxE1kX5gkYc6gfCRzL1FTWLXomFeAVMu/C/yJ
	b5GtVemQELcpSZ1/SD5EYu/lxEU+0o3eSgCUMOji6nc49Rr1GfxaPs5MCO/lqz4levT5WUKdJXM
	X3s56ZWU1R33ym4pAHuqIWS1TDyuuSzc=
X-Gm-Gg: ASbGncseCySdZm3BB+cCUVcd3Hp3a1nk4nNbhIC+EwbMRYN83+QaA116WCtXL75d+1e
	e4a7l74BYxTHt2/Ole1H4lz0DiI5jOI6Z8h0SaECG+hOYMYRrLTwlPaxVKEBn9bhYsmJuJcS30w
	lD08Se0A8wnSlilGvyD79Pcty9K1jH0B8ES//MLUAcvxtUdIJeEFZXBK+3FJ+GxIji1v7JovPsZ
	/+G/YaTj5YDbujRPBmRE6LHG8Sh6oSkuVhiJYaZQUUAWpY1OkqVxXH8xHaxXjT/qqac3gL5kLcs
	7uDzSfRzJwq21rlAwxpK13AHFw==
X-Google-Smtp-Source: AGHT+IGxXnezM7H6ghoHWHVk0i5IpwGNkPTA0TF+xQoIAFjkCgqjiFTZpTBBYWa/w3Z7zp2bKm+jQ4qd+hmkKIGk2Xc=
X-Received: by 2002:a05:622a:138a:b0:4d8:531e:f896 with SMTP id
 d75a77b69052e-4e89d293c59mr371291051cf.27.1761333763653; Fri, 24 Oct 2025
 12:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com> <aPu1ilw6Tq6tKPrf@casper.infradead.org>
In-Reply-To: <aPu1ilw6Tq6tKPrf@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 12:22:32 -0700
X-Gm-Features: AS18NWDml_8GOzBxWkDpLBz16byJMfZB750GwQQx4HmcQAC4dkTAAf9RVH0Fz44
Message-ID: <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, hch@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:21=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Oct 24, 2025 at 09:25:13AM -0700, Joanne Koong wrote:
> > What I missed was that if all the bytes in the folio are non-uptodate
> > and need to read in by the filesystem, then there's a bug where the
> > read will be ended on the folio twice (in iomap_read_end() and when
> > the filesystem calls iomap_finish_folio_write(), when only the
> > filesystem should end the read), which does 2 folio unlocks which ends
> > up locking the folio. Looking at the writeback patch that does a
> > similar optimization [1], I miss the same thing there.
>
> folio_unlock() contains:
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>
> Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> when testing (excluding performance testing of course; it'll do ugly
> things to your performance numbers).

Point taken. It looks like there's a bunch of other memory debugging
configs as well. Do you recommend enabling all of these when testing?
Do you have a particular .config you use for when you run tests?

Thanks,
Joanne
