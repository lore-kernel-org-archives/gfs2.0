Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67926AAAB
	for <gfs2@lists.linux.dev>; Fri,  4 Jul 2025 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612588; cv=none; b=e+EA8PLckkhf+zy1gzZTQbzSPzqGezYijae8AiLa5ii2PqjuVLygini5I6wcq47FGIl7KbyzOLw9QE49prN63vAF3reDz4qrxbJaB6SUPkmX0gl57ZeoBLfAQzPiOOS9Tno9+JjnYzM9JLVCKBQlHZupTjTXPQXzlz1b5FoRAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612588; c=relaxed/simple;
	bh=FAT2JYkIVleheVO+4inwuHTSq5weBsTjw+VPUDu2v5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB/hzO9YAvKjevYXaRqTet9hzV5wM0LUzmGf09eNKgmmZsz4cfuGvZ9Kr1OX6RIjaP9l0lZBrV28bRuvDdZgzZ36JOTqdDR0RxZ1bEPdanTWU0eC1SZZP+/3J1mL5lJ05XZA72lp1d9/xCRIVDbYgQ/ZG/UB0ykw3sXus8LE9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHbVRYfq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHbVRYfq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so128106966b.1
        for <gfs2@lists.linux.dev>; Fri, 04 Jul 2025 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751612585; x=1752217385; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaqZISU/6/J0dA6aXHHwQAgG0zenTBPemNnfGP8tRRw=;
        b=WHbVRYfqjhppJ+e00l7gnlzqbR8yGBJOwZNSpLVo6bqqXxzcWC1Wwgx7fHbzAQ32T2
         iaW5Vv2G2JVHCoF1YYiE7OxE4uifYl5l6NDxjp4+HLzaVOWvThyW8la6c5PV/HPEh9ck
         Sf1cjG6AWo4vUf+v2pRRgfU9WAPeXRttm5tvMeNlpajKsi2U+4R1qz2oHupFz7pM5OrI
         b1r6EzBUzDcL3beEwENo5hMDcr1EBdFfDcZuLqcXvDJLsnZGIC0OI6nHr3OMM/73USED
         Wt+gZNmOEjiMB3UmKzbe1l7rmlTbXI4gkGPf9OzXbtXtn7OPkewICKaZET1fN6l27bPX
         PYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751612585; x=1752217385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaqZISU/6/J0dA6aXHHwQAgG0zenTBPemNnfGP8tRRw=;
        b=cl9iGDbmdI557SMFOgQjLSmn6L9zz64kvJ13ONu5GUhwN1+RLTtqQ138p2f+dYlPLz
         bxKbEn4QCKLIsFxPqPwnV3KvzYPYJdW5OjTBDCA27DFUJztaIBNp1bYIlbWPxCosdiXb
         Sv8AoB28bwBN0ON4Juvl+j/Kn/hbHlVG9dl+HVvQljAdamJoAHG3Vg1U87fPZVC+SH47
         yXwod4j5+W5fAJ0kTdWWrYiVGkR1EYw4zFOxv0yD2A9aGu95agGC54BtqjV4itUDhNyo
         53PqBslYXdrKhGBJLOjNpNYF8cR5cet0yqad+IYd6eMXPkmACYihD8sB38IJ47WBslSW
         Oitg==
X-Forwarded-Encrypted: i=1; AJvYcCVyM72VdiDPRdTemXNgW+l0f+scEQx9TUu1KqZaD7eyRBCkeKFWc+FoZWD+3n6WyG2kDdXt@lists.linux.dev
X-Gm-Message-State: AOJu0YyQXTDW7pPA7+3eh7PkVS1L3FFtngClQfdri5zecH8l1OH2rUFe
	jzdad5RdhYGMJ+oMfbKbQ9af2vR8GcQfGxfvrZ/J4cuhGmqsMDNJ+L/MQO1T6x+jsRKVPtJA7UK
	qExI0XyoeTBp6Naw2iU9GRx219DHDsSM=
X-Gm-Gg: ASbGncvekDBaU3YPZUzDdaqFns4eKAYw4LUNFKBix4MHGYEbK+ggWeU/5Gt7ibPd9j0
	CmdxLl+izo3bR0n0ygYtGjMKqRHw+SKnwIpqDeQOR7sSUdOyI3gYqF7Qr0EBMoD/9gnFzzyYhdY
	vJD/xh0w63yV5tcdrzT0AnLkOSygASfSdZlh5QnBrUTppuGM4Z7PXg20JzDdT2deNWWu/HG/JDP
	hUkhY5uMjaPm48N
X-Google-Smtp-Source: AGHT+IFH2+aa5C0AYTaAo7ldMEn47RrhFOI48HXYOTWtH8oGOiUW5l/So1Lz10mwcD0zFkQkk89KO90EiAPC2WiMYa4=
X-Received: by 2002:a17:907:728e:b0:ae0:a813:1bc0 with SMTP id
 a640c23a62f3a-ae3fe78f7aemr85654066b.53.1751612584190; Fri, 04 Jul 2025
 00:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
 <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
 <20250702184312.GC9991@frogsfrogsfrogs> <20250703130500.GA23864@lst.de>
In-Reply-To: <20250703130500.GA23864@lst.de>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Fri, 4 Jul 2025 12:32:51 +0530
X-Gm-Features: Ac12FXwZOjAgWNZaCPF5YBUk5PhxDjzykQsiKelmwtL0Fjc6XgS6xeUIPE87xdw
Message-ID: <CALYkqXqE1dJj7Arqu_Zi4J5mTVhzJQt=kzwjS9QaY5VaFcV3Lg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, Christian Brauner <brauner@kernel.org>, jack@suse.cz, 
	miklos@szeredi.hu, agruenba@redhat.com, Trond Myklebust <trondmy@kernel.org>, 
	anna@kernel.org, Matthew Wilcox <willy@infradead.org>, mcgrof@kernel.org, clm@meta.com, 
	david@fromorbit.com, amir73il@gmail.com, Jens Axboe <axboe@kernel.dk>, 
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com, 
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 6:35=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Jul 02, 2025 at 11:43:12AM -0700, Darrick J. Wong wrote:
> > > On a spinning disk, random IO bandwidth remains unchanged, while sequ=
ential
> > > IO performance declines. However, setting nr_wb_ctx =3D 1 via configu=
rable
> > > writeback(planned in next version) eliminates the decline.
> > >
> > > echo 1 > /sys/class/bdi/8:16/nwritebacks
> > >
> > > We can fetch the device queue's rotational property and allocate BDI =
with
> > > nr_wb_ctx =3D 1 for rotational disks. Hope this is a viable solution =
for
> > > spinning disks?
> >
> > Sounds good to me, spinning rust isn't known for iops.
> >
> > Though: What about a raid0 of spinning rust?  Do you see the same
> > declines for sequential IO?
>
> Well, even for a raid0 multiple I/O streams will degrade performance
> on a disk.  Of course many real life workloads will have multiple
> I/O streams anyway.
>
> I think the important part is to have:
>
>  a) sane defaults
>  b) an easy way for the file system and/or user to override the default
>
> For a) a single thread for rotational is a good default.  For file system
> that driver multiple spindles independently or do compression multiple
> threads might still make sense.
>
> For b) one big issue is that right now the whole writeback handling is
> per-bdi and not per superblock.  So maybe the first step needs to be
> to move the writeback to the superblock instead of bdi?

bdi is tied to the underlying block device, and helps for device
bandwidth specific throttling, dirty ratelimiting etc. Making it per
superblock will need duplicating the device specific throttling, ratelimiti=
ng
to superblock, which will be difficult.

> If someone
> uses partitions and multiple file systems on spinning rusts these
> days reducing the number of writeback threads isn't really going to
> save their day either.
>

in this case with single wb thread multiple partitions/filesystems use the
same bdi, we fall back to base case, will that not help ?
