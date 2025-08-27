Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18146F06A
	for <gfs2@lists.linux.dev>; Wed, 27 Aug 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259930; cv=none; b=q2id4jg1bp75zuEmRoAbcqxH6vt9xcxg61jO2SUSSk9HzqFaPto47tutG5jZ0Ga7ozY1odHbsEX1PHD5Hbq21riFnbW2ykc93BU0yA++KZmMg3mZMUuP4LRdfUAqBEr4QU0EKXz8/bWTbknClXFTl6GJfGFSRaeJ41JPeaGgr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259930; c=relaxed/simple;
	bh=/PHIjzfELyEcjuWJ6n7CUV26b4SYqlNVwYA00Smv+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTvnSk7Z3R48y0DsYlDB0ACPwrXV/4KnX2nw9eSMyUtVvm1QYQRI4Zg9/ct055Iz6+yv24RPgg4pvDwnp4cpGQZtebbEyiE5K5LYKTgE4aUvYs4mWtV/mv6OTUnPtsOuD+xcTNlIlHwTKGS+2KwuLq8EAy/CvzKQ921xEcO8dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZvMQiGT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZvMQiGT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2460757107bso58444905ad.2
        for <gfs2@lists.linux.dev>; Tue, 26 Aug 2025 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756259928; x=1756864728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwAVKmX/I1s2gxmBmbB2NeF4sEUvQzRSn/zd7XkVykY=;
        b=TZvMQiGTw8SLWnQcEnzVRifEd0FdKlNNxcAR8RRF0dX6o5N6bwmF3V8WAejx9rnhpJ
         XS+PSR8ZwqQor1DcNOTA1yfzgE6+mBRHwZRd3SR0/+jL9Db9kfI1eaWnSEzVC0ugtEp8
         nxqmjVj6kKvDbM2UD/Ju7itCtu71de78cCJzJSiweIvr62t8c8MWOEjNz9OGipc+EBWh
         xpknqSLorO45JCnFLvE6Utbmm1VuuutLsRbJGsA50520rJPjuHoukyDdf2ndDVFVReJX
         1coHUGBxsp0gLoLKRE+0X9zbt5yR5nlmFHCqxGY5MoAr2JT1mg8J/AaAkdGW067AD9ci
         IzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259928; x=1756864728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwAVKmX/I1s2gxmBmbB2NeF4sEUvQzRSn/zd7XkVykY=;
        b=QzcuA/Cr6t0ijdHSy3jHnvPx46Mwyc0ry70UT0v0dhRoGMZfb+KkeOXbDTHhqVN8qN
         II1dIOi7W7gIKtgIt2hEyEm/lSpG7sdGLxyNW1cX8/RaL/h7WF5QcG47VKwzFvjVhnLp
         c2V2xLLzWiKgU5DkmLt3MQ8e4rn1NBqtWU0+mdfG4SFEOVRimzU78CJkqijWqeotcV8u
         kmChzMJ1EN+QsLcFIFpFCUaZsmxj/H5NXWAHHft6qVmjeML9ytn3rXjHqsiZiH0sKi1J
         Wn4nZvaXO+hmm2KYf7FKNifR5emSENSD7IBs3erJ5HIJ6r014SqKpH06qM3LFxj1tWCG
         sLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW57ZAxzTKrFkntEKQl7jKhPU6/XZDmSPPnUhPNPDqBVJsr2bo125521/n7dH4pxCpHNeRO@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1ED3PeZ7Sla9BSKnNpK1W/9DSx2g59GhN6t77XD/tMhbVBf+m
	EqW/6/z5ZQWTUlpznqPNrnXRo+Vh/DjWmHsZ7fhgyV6FOshaNfgQi/mR
X-Gm-Gg: ASbGncuDPxKvb0ArrTrpcc1NXQExHC0Zm4EkZJYdkasguDNcN8hAKBujo4l07E0k6UT
	BThvr3MqmODZX4zBZfYo/UChyjL/mpQ1xy6inFxW/qb10t1PFfQ0ocXtnCWR3u8kRkDuzJ4vSxI
	tfFrhMmf6elxre/cTLJFt+YRbj35bNcyumnLKHR4UXiMhdXY+0yuCcHKElW1+Dxnw+Wv6BVLe3W
	Ujr/NWonguZhrv7D2derGpA8+VXGf608DGqWZcQJteDDz84S/R9hw6dwxbDnTenCHn8XmkWNnsV
	UoO8eP2NRx7qw9fkOMVCCEF/NPVJYgIJu7E3WC/ZBTw5EulMwnyGoB06dLt1IBuWwg0+m82eU7z
	l+OC1HC1vSrGhYQbGrKH3Dw==
X-Google-Smtp-Source: AGHT+IEqu4RZC/Mv07+32USt1O0T4CAeeWBTAgLYfe5hG6hvOS8qLArGzHVKAadPNj7IRfcUIr4W9w==
X-Received: by 2002:a17:903:1b6d:b0:246:b1fd:298c with SMTP id d9443c01a7336-246b1fd2fc8mr146952355ad.1.1756259928099;
        Tue, 26 Aug 2025 18:58:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffbb605sm11724412b3a.7.2025.08.26.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:58:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0A69424BFD0; Wed, 27 Aug 2025 08:58:44 +0700 (WIB)
Date: Wed, 27 Aug 2025 08:58:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] Documentation: gfs2: Consolidate GFS2 docs into its own
 subdirectory
Message-ID: <aK5mVOTFZhv53M8s@archie.me>
References: <20250826023913.14888-1-bagasdotme@gmail.com>
 <aK2iTlkp9iA3zESf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8VyT8roYB2Ttt/DO"
Content-Disposition: inline
In-Reply-To: <aK2iTlkp9iA3zESf@casper.infradead.org>


--8VyT8roYB2Ttt/DO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 01:02:22PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 26, 2025 at 09:39:13AM +0700, Bagas Sanjaya wrote:
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
>=20
> If this is to be done (and I'm not sure that it should be), why preserve
> the 'gfs2-' prefix on the file names?  We know the files pertain to
> gfs2, they're now in the gfs2 directory.
>=20

I'm just moving files, though.

Anyway, thanks for the suggestion. I'll apply it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--8VyT8roYB2Ttt/DO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaK5mUAAKCRD2uYlJVVFO
o/uCAP9GnbqUmuPnJizdP3UtvdrYHXV3y0wVhJEKGAO4a+a8dAD/bXtMoOL/d/Gd
22Rv85+RYilLre0239ddCTI+8COycgg=
=7WaC
-----END PGP SIGNATURE-----

--8VyT8roYB2Ttt/DO--
