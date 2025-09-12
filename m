Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1C30C60D
	for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692893; cv=none; b=SQH3YVi6Uy4O8A+V2xm3IngbLnBoxJGoN+YgtZUrTYzxr8EM9SrTtxwcuhkG3sB03trLGo6RzskqmM27ZNUAl9UNd2prY4cF24VqbKD7tp3ZZLtKBNW4N3rnpTEWXcpz62hd5uwcZGF1LO92yeWPKro+K+Fwh0H6b0e6CPyuiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692893; c=relaxed/simple;
	bh=MRVkhyLhBzuYU060K/KA1IS9FmS+Zv1ZvikNViDB1i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEARs53PouCsW/1RbOEPO3orL94T2TNmWtzWu2XUN7xLPKDLAabIhJrNjGzCm1c3RP9lRMDUJhvqwC/aDdkUAP44fyEL7Vmslq9X6LTqC6Wp7ppkWySD+k2B2Lf+nvIjoJWp4KgH6o0Vty1rwWK3rf4eYv4N+ENC+N5ParQk1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GquYWEEs; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GquYWEEs"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b60144fc74so23317451cf.2
        for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692891; x=1758297691; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=GquYWEEsiZXecH3kporkHS2IoiVH+RlPhm2r43z+pgUjuB+bzRTf+FSEE0ALzMMmPx
         3NTw4UtWbSjAQc8YKHXtaQVRCNXCVP7oBybWvzIrhVeYzG852vapdii/MgdSkN1AqyWL
         zwt9CtyXp8Phksd+OomzrG+zwFfB0tlZUMLoCJPJCk6kSUdewDK31whPzQGQlWmWgQuy
         DDnJ0oIx6zUpwyi0eTOH9l5+RRy1Kt+7sVhFrvchL2fXqZScmUr32Rdkl8Y9v1t4v2od
         tSmM06iKYP5sgPFUgej4L+LVFRH6ofYpb6JeKYwAgRW8DTOSaA+H6IDlh4vna+8uQNBL
         tkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692891; x=1758297691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=bJ8Lw1ICewHGClGwpv0AZOBhvY6B/KDZ1Y6286hEiqHfZDGmNj6zqRd8zCMF6PwXt6
         3R0alcYg1kKEYzAlWpdllwyhM10et1r1HKt7gMpLKC9jDBZE90NNU525RRz3npCVH0dG
         DYKq0TcL+pL72Y1kVOg4c58WFWYl+tYNIaJzJlh9Ah5BBrVDXexpSmTotn7NKJFUawDJ
         zj0iQPkE0XQkRCTL0IPJydOrxtoLZ4GhnV6NkrJXQD7vcTTmGtIiYWGTIiCplxAX/Snx
         w7bgE/o3fUEmVFmqNo/jHLp1JGNpHtK5gSJAj1kMVJFClnmKKFyqWp4E4enn9MOSGDRe
         V3JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpKJqfuBampwyUp/zuHYCB4WDImlr+30Uh+uAWKWCZlH5Uafgkcj9oVIDG/7bNHcof5WL1@lists.linux.dev
X-Gm-Message-State: AOJu0YwDxLvDbm3Agwf4ISm2F6aKvpVw8ryTIcl0eMsU17QVqQE6qN8y
	Gv8i4fIN39zAVmZEORiRkGkue+DxiEic/aKvXUwtg0RrL/mhax0r/rvgXybzuCoIy8yjShTADae
	RsTVRKnEW+3sYMqL2f2YpYYFN6gYmQJ8=
X-Gm-Gg: ASbGnctfA2AJY5vum1H0Ij2UDUv3ClWMF6i2erAgD4gilCYvPOWyWGbxJorMhg/EWsP
	0GNp4fwfOaprD/pZG0NB4faowoNCwrJgC2c9Z4EqAzfmA10LDSSl9H30ivUdjlNrvLIayhNR84A
	Ejw00RQqN9TamaIh+IZGZoZqaycD4uF4T94Zl3fIflaR3IMfRE8LC4+s7euWYvDJ3X9KOgUZxL3
	wfbBl5zg9ALRiNiqxxHl8sN7VVr3xa9dfe3e+Gk/wTO4YL3ZOrr
X-Google-Smtp-Source: AGHT+IFpEJeHHGMR/+rANXvYCLHGXODc/LHx0ut1LxSgKOWEZt2yvx1hw4BgafRJMV62S+17la7+3LzfUFy0mc1meoE=
X-Received: by 2002:a05:622a:4244:b0:4b5:da13:3b70 with SMTP id
 d75a77b69052e-4b77cfab1a5mr44965001cf.10.1757692890378; Fri, 12 Sep 2025
 09:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-2-joannelkoong@gmail.com> <aMKt52YxKi1Wrw4y@infradead.org>
In-Reply-To: <aMKt52YxKi1Wrw4y@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:01:19 -0400
X-Gm-Features: Ac12FXyzQBWaHPsdA5p-aXewM42KENc2X1_esV-qMD6PmHLNB3vND9MBVb-40GM
Message-ID: <CAJnrk1bFQTKKBzU=2=nUFZ=-CH_Pc5VAj8JCJoG0hgNszMp2ag@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] iomap: move async bio read logic into helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +static void iomap_read_folio_range_bio_async(const struct iomap_iter *=
iter,
> > +             struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
>
> The _async here feels very misplaced, because pretty much everyting in
> the area except for the odd write_begin helper is async, and the postfix
> does not match the method name.
>
> Also as a general discussion for naming, having common prefixed for sets
> of related helpers is nice.  Maybe use iomap_bio_* for all the bio
> helpers were're adding here?  We can then fix the direct I/O code to
> match that later.

Great point, I'll change this to "iomap_bio_read_folio_range()" for
the async version and then "iomap_bio_read_folio_range_sync()" for the
synchronous version.
>
> >  {
> > +     struct folio *folio =3D ctx->cur_folio;
> >       const struct iomap *iomap =3D &iter->iomap;
> > -     loff_t pos =3D iter->pos;
>
> Looking at the caller, it seems we should not need the pos argument if
> we adjust pos just after calculating count at the beginning of the loop.
> I think that would be a much better interface.
>

Sounds good, in that case I think we should do the same for the the
buffered writes ->read_folio_range() api later too then to have it
match

Thanks,
Joanne
