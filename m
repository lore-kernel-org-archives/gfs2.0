Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9125760
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785508; cv=none; b=JX+N6Tjb7wKZNyBHjZ1g2hM322HwpSToYHmpSVBRSiW9cXOhIETkubcw3MeLkssSueprqOrrmGRLxQ+TmB2IybtkD5zKzygGOGGPCfb6+B0d2KwOJIgJgNWNXkb7WKFJVxRhFuE8TVvrX+b0Y3yTOemw0pp2nzkOEbkotIABaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785508; c=relaxed/simple;
	bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8fa3F5sUdR9Nox7dmxcQpI8lVZNe0pZtHdxHpYbMUcFmB62965xvsPPhE8oJ/y0ZmtW9SRT8WzyLah9FIVb6OGr9GP+Pl/4qpKpRPsy9kWNHFbi+9gyATS/8TZN76v45a2p3nL3RA6F8pJPWQhaGFEGqMEuhB2j2COlfFKAmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LU8eo0Ml; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU8eo0Ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736785505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
	b=LU8eo0MlrGPy2QwbVBYhbwuVZeKjiJlddvCqisc0jxqBiMlmoRiFBFkPB/gsXbnw3Gok6+
	vgX0zc1GbbZwauo4lQjVKLHz6qNUpfeoJ4TkdCduAt31bQbggtFmuyqEKpIJRm8qx9yhCx
	v0wPxxYpElAgh51ve0yPlr/hY3LEDjU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-HTanvEhZPMO2_bG42MdxAg-1; Mon, 13 Jan 2025 11:25:04 -0500
X-MC-Unique: HTanvEhZPMO2_bG42MdxAg-1
X-Mimecast-MFC-AGG-ID: HTanvEhZPMO2_bG42MdxAg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21638389f63so53853725ad.1
        for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 08:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785503; x=1737390303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWCUhE6qRac4v5NNdRon+8rEi7kvW+EoMeYL1gMCuK0=;
        b=idjYwabtsRVeGznJZikBdfuqRlzGQtLsSji94JtOX3frkgbvXj6sTXZnGSIL6pVOvP
         RY3PN42QekCDc8qtoMkn5vfJ+p/udaesKuoCMY8hvxIUZsVWIIaS8wy5I7HekHlcrylj
         D7nEL3nTv7YTXIm/S7F7AWP9zl6BGKC3HyMxFkmI/XqU+BoMDkD3BycSSp7BnDN2hS4Z
         NusuJofmJDGHYu5Tq9ii6V5+c9uOghOlj99u21MYE9r+hu8cxHhDs4GO6bXvgfmsXzqh
         LHC9JQK41pvkl6seRtqFwtjwAgLgTkT9QVCDW6PcINzIOWTMLUt7uMISTG/cSu1e6Sob
         jUWA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7Ifr6RCEuvrr0c7SFYbRxdHLP038hrpSzz25PAcbxssoH467Gk/lnh/AiB7HNUWwzGI/@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf9njCtRzBlJIt1LMWDoleA/ywp+lbNmLoWms3hJsaAFb2ikcV
	mw0Jol12FEYxhxmogPgt42PN3w3pvYqw1lEM+dRYkO6vxbcf/aMS7/N7IZrqfI+jwe+tyWNT6XF
	CcnLjLgWOmdFx3X60yyyyDz8TEZM3pAqQOlA1rytDU7n3mii8f1s9xuxYKS/2xx3GzvPGszhr7u
	qg1KVx0sKeUMluYJmLwe6jzrqFYw==
X-Gm-Gg: ASbGncteQJw3IUl3jMxj/q1cy9ktSN2eZc1xh5qj+2b0Fx3qvATCpeFxXl/rGu3QBx5
	Iw8HyOI2bqdIwd7Y+HTSAXhUgCie1RffrMuMw
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21a83f5e4e5mr326959795ad.28.1736785503240;
        Mon, 13 Jan 2025 08:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0jUlx8LbipayI4T0xGE2BAcW+hI504rIz1zUuL1evo3KxMbXqucm99OrrMJgJ+Hjr+D71qSHHJbbelVmGJgA=
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id
 d9443c01a7336-21a83f5e4e5mr326959515ad.28.1736785502970; Mon, 13 Jan 2025
 08:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
In-Reply-To: <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Jan 2025 17:24:51 +0100
X-Gm-Features: AbW1kvbcavtL6uBmJAkF4VNFZU3Xvdt54cbg-SQZf3tWJEbZi3OHIXZdU6LM7HY
Message-ID: <CAHc6FU7Tng3OLB367Uo8aXRjPEfhCJiMOEUawhd3_bbHUPiVpw@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev, 
	Kun Hu <huk23@m.fudan.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7cK3OZNQ_T8VTFPXgJLt96bzk4I4ByV8a3UmFYcIAlc_1736785503
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:41=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Hi Jan,
>
> Am Fr., 10. Jan. 2025 um 18:18 Uhr schrieb Kun Hu <huk23@m.fudan.edu.cn>:
> > > Thanks. Based on the crash report and the reproducer it indeed looks =
like
> > > some mixing of iomap_folio_state and buffer heads attached to a folio
> > > (iomap_folio_state is attached there but we end up calling
> > > __block_write_begin_int() which expects buffer heads there) in GFS2. =
GFS2
> > > guys, care to have a look?
> > >
> >
> > Thanks to Jan.
> >
> > Hi Andreas,
> >
> > It seems that iomap_write_begin is expected to handle I/O directly base=
d on folio, rather than entering the buffer head path. Is it possible that =
GFS2 incorrectly passes data related to buffer head to iomap_write_begin?
> >
> > Could you please help us to check the exact cause of the issue?
>
> 32generated_program.c memory maps the filesystem image, mounts it, and
> then modifies it through the memory map. It's those modifications that
> cause gfs2 to crash, so the test case is invalid.

Ah, I misread, the memory map is distinct from the filesystem. So
forget about disabling CONFIG_BLK_DEV_WRITE_MOUNTED not working.

Thanks,
Andreas

