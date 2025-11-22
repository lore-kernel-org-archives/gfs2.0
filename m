Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9002857C1
	for <gfs2@lists.linux.dev>; Sat, 22 Nov 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793802; cv=none; b=oJHN9zKBKuzgfYRZVDjFAC9Sr/e6GG8gInAE/jPXmB1hSY8psZSww7GSgMsBlqk8416H1WXXtB8lO4HaAVsXZi83H3CGfO8n28bNXQV2ZH+YYsof/EA92Wl7Du7Y5cajaA9f2sfgB3j7IuH/TSpNiPAaGupBKLuHBcCZ2+4rrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793802; c=relaxed/simple;
	bh=Y+DjqwAoCGZ7OJzLzIWqwIR/VPRlxdq59cBm2nqE3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By5UMPjgJEqVFZgAqrjH0WPpU7NN4Cma0hwe1yj9ll/lp+wVNeGbN/wYaoSk053GKI+H3hQ1SxLKI9vf+wlSMiGdvC+YuZcyEvBFKNmAuJty0Y/a25Hf4prXuEch/w/tyV4yTPiv2l+dv+DBQSbSXOhie2LoFbY1qREilQoIr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+slzDOh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+slzDOh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee328b8e38so24835321cf.0
        for <gfs2@lists.linux.dev>; Fri, 21 Nov 2025 22:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793799; x=1764398599; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=G+slzDOh1BvP23+OxTF1L/e5HLikMbIJLq2M5C4LdIA3w6Y9izCgHgKajG1PBXVRKj
         bxf9W1ywGugnrgY0oKms3lm8CNPEDUDry828EjlVkpxTsXy7Q1URDAyOmu2jO59tdpSx
         Ei3hralYrTCQlUx41/nPWc2qMKl63vZi7lT0tCSc7JpR7J9Rw4vv2ZCJt9Epc7Y//5KB
         /yXNvfLk98FlPJJPZ4b2dHXLOO/Cc6Ho4jt3ZbfSfHlUs6XdWvCx6vp9qUo8zZ7gy4RH
         ufNdp8hqkWg6clrUFVdaLNoBmTwlkAFiZ/QhPWw7A0OTaEGZlcginxKr9h1LcxUbSP8u
         sasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793799; x=1764398599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=hvcQVPML3SSA4XBgGo+iQQLuCN7LvFy3irJpetUYQgS9WvQTQinMGxrBtLARmBbex9
         dqzXX+JwFab6U+d6bC9J2HwBtyrOWx408dnOnKnF3/Lpw7MhtRCb2Bur0fhWwk5lH63U
         RUZeHlEbHJ5Lc55BAiM0ncqeeknzh6l4X2VzSLuXLMixbziMjm3pkV0Nqu3lgzAgPv9s
         YdLyvmV6cg1OUn5eiAPVCsZ1ne9yRBbd6D23bsoK1LB8NAfFar5/S4cwqzBUvJUlIgvu
         j9ca9MnEqBXqXT3Q7y12lHmzKhdqo9cLA52hkGJ3qTuTK3rX0Kpb0fY4kYlayA4ZUX8p
         pQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyqoc0RzSo3GAvf3sS4MAzY7r1himeECvw+rMKuYsWAoYvPNaylkOcH+3fA3EsEKmAdirH@lists.linux.dev
X-Gm-Message-State: AOJu0YwnPsP7vlMw/lzml4P5lsm0FEgppC+6dP9GOHKXoNhvrvXsiDSm
	xpvaTaOfRKgzeC7as4qzLmYz7Q+D+cqcy1FhKoouzgv9junP4vzQCHfin+xfE92/Rvjo36fSra4
	6xpNAuHtRV0LqYn3QoOBFA7xFjwbK1Ug=
X-Gm-Gg: ASbGncvGRAC/DXfg9env4kXualKOIlnHUQKUN+Saf52mEWKuMaSm6Vcwpgis2HTwixd
	eIcyZc93C+OqI60Ti7nMlksRfJTTbZ5KnwtyAhssuhdt2EcN8DHKp8+ybxTTYmEAYoDBhQTXlxj
	vZI0OmUSCnqqoIBya/kYk47Ga+WVSE2Upflq5uOxhepADPcUvgOWWxp1UNAocHZ1lhyLS//4qPi
	XYliTb9x1gHhyefAfKVGq+/ufpRZ7sCw96ZI8U6qPab6EkrP/+oN6tYfis+zGwMDbY6uHI=
X-Google-Smtp-Source: AGHT+IFYY0hB1AT6+W29RBnT+t78nVJtbCkr0AJ7fjgv+YE4gLfc5ZYb5TuO0P1olfjrCgZ/JHFnyc+OtjdZpbL7HYc=
X-Received: by 2002:a05:622a:653:b0:4ee:1301:ebaa with SMTP id
 d75a77b69052e-4ee5888fd9fmr61705651cf.54.1763793799235; Fri, 21 Nov 2025
 22:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <aSEvg8z9qxSwJmZn@fedora>
In-Reply-To: <aSEvg8z9qxSwJmZn@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 14:42:43 +0800
X-Gm-Features: AWmQ_bntN_rMHyZMaZTesMCRvMp7VgMi9_ZfkRlzVtT_jBUQrddcI4xac8nvuc0
Message-ID: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Hello everyone,
> >
> > We have recently encountered a severe data loss issue on kernel version=
 4.19,
> > and we suspect the same underlying problem may exist in the latest kern=
el versions.
> >
> > Environment:
> > *   **Architecture:** arm64
> > *   **Page Size:** 64KB
> > *   **Filesystem:** XFS with a 4KB block size
> >
> > Scenario:
> > The issue occurs while running a MySQL instance where one thread append=
s data
> > to a log file, and a separate thread concurrently reads that file to pe=
rform
> > CRC checks on its contents.
> >
> > Problem Description:
> > Occasionally, the reading thread detects data corruption. Specifically,=
 it finds
> > that stale data has been exposed in the middle of the file.
> >
> > We have captured four instances of this corruption in our production en=
vironment.
> > In each case, we observed a distinct pattern:
> >     The corruption starts at an offset that aligns with the beginning o=
f an XFS extent.
> >     The corruption ends at an offset that is aligned to the system's `P=
AGE_SIZE` (64KB in our case).
> >
> > Corruption Instances:
> > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> >
> > After analysis, we believe the root cause is in the handling of chained=
 bios, specifically
> > related to out-of-order io completion.
> >
> > Consider a bio chain where `bi_remaining` is decremented as each bio in=
 the chain completes.
> > For example,
> > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > bi_remaining count:
> > 1->2->2
>
> Right.
>
> > if the bio completes in the reverse order, there will be a problem.
> > if bio 3 completes first, it will become:
> > 1->2->1
>
> Yes.
>
> > then bio 2 completes:
> > 1->1->0
>
> No, it is supposed to be 1->1->1.
>
> When bio 1 completes, it will become 0->0->0
>
> bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> zero, and bio2 won't be done until bio1 is ended.
>
> Please look at bio_endio():
>
> void bio_endio(struct bio *bio)
> {
> again:
>         if (!bio_remaining_done(bio))
>                 return;
>         ...
>         if (bio->bi_end_io =3D=3D bio_chain_endio) {
>                 bio =3D __bio_chain_endio(bio);
>         goto again;
>         }
>         ...
> }
>

Exactly, bio_endio handle the process perfectly, but it seems to forget
to check if the very first  `__bi_remaining` drops to zero and proceeds to
the next bio:
-----
static struct bio *__bio_chain_endio(struct bio *bio)
{
        struct bio *parent =3D bio->bi_private;

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;
        bio_put(bio);
        return parent;
}

static void bio_chain_endio(struct bio *bio)
{
        bio_endio(__bio_chain_endio(bio));
}
----


Thanks,
Shida

>
> Thanks,
> Ming
>
