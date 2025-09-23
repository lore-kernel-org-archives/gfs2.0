Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D4285068
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668623; cv=none; b=ahped9RpwOftZnN9WtEgTRThcBtI3bca+dFcFBxD1COEznfNuYLQcXVljBc8kr3uWCgHGyVx9l0JeLTbI/HuySers0+uHzAXPz2ONLWM4Q21g7G11rXRseurTeHJvtLWCVRxR8RzDCTi4U45vepC6RYmMSAM20Sgz0I3hdjOrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668623; c=relaxed/simple;
	bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLUWhacHbLRQiSsO6ccIRhERJ5y08ql6p1uBmoT/hlBwCQA8Xjz9ow+Odu6Rsy7JJ6awBNivUYhoAjXwW0B1mSlhzYIWgY3dKQnkDYJD5K9Mkz3SSOM5CYz2Zh5hYtcCNMuOeiAdnoQeC45qAi8JFvJlBTiQZFPw/NuB0Eff1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMZk/cvM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMZk/cvM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo857620b3a.2
        for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 16:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758668621; x=1759273421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
        b=DMZk/cvMJkI2IVjjomHq81DNhBYWiYI2eRutv9MLEBvn7D7ORYRSoQLU7PONUjfX7M
         EubTXn0iaHSE677x7aPoOqlk1ANrbueScegMSYJb9khO6T0VqTLtEJLANdhJFBcsrQDr
         JjZHkPuBbQYtvDpd7ll7Qv7AhAA4Mu74yBlacJ7iTS0Oecgs6dzIVro8W00kt0X9wdKJ
         /YZzKwOJJVd32F38JbwM/J9F09gug+iIGqQa94AJjIbY3jLPNAKb/76p1RaUHPLmStKb
         +bQkB0n+JU7AIcnpjKEILCQGNC40mAYo/zACnbvKybChaRednX4rWzAQLyldK5vueeWw
         2h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668621; x=1759273421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHMaUS9naR0vIV9JTYsRgzOChzGdvox3pKFEbqzWur8=;
        b=rMUM+a3xzbGi3y0sn/Sltkl4wzzPDd9J3qDQGWGD7MveB9DIU6FU8ugz+koERdxRS8
         M6geRH2z510f+TlYHD3XRDGC89q0KsHu45NcejKS35z7/6zUNunSUZegLmC9PGqZDqAz
         25fQ9BXlITwf5eg1dfz9xjmuR8LcJYUCVEeb2dc8YuPdEgJyh4TEKelWogo4UwSeEUFx
         wDwBCIx4VhHIVbt+JwxPwzxoWtpk+6A7SK7vMc1oZPpHyWIZ8qZfh4UdQZQZv4bpgGt1
         GdkYU3ZZidmSz3XFCkBU9AvRFHN95/XqswByHbaij6w8h07k1WPVxWG2vgvdDpbPXOgs
         165w==
X-Forwarded-Encrypted: i=1; AJvYcCWnepwMYcKolNJ99dUTA/A+2IMgIWfmftJDOCsFOXWgyRN6OZ23Md9twZ4Zq+fm6lvgOAjS@lists.linux.dev
X-Gm-Message-State: AOJu0YyMUS/r+ghO7ONr6x0BEv5k1xii9CclN0FBUeI0VQRe6fXDVhox
	zMMAHqabQoF1q8CqqVoBY3bfI1bnIYWC7fvpB4/FbehbWuOHpg4wX2EI
X-Gm-Gg: ASbGncvNiwOx6t+jxnFWY092tihfsbgLBLwWjlxCng0spA/cgkHg+BFyYLLcZBOw/il
	AzHKKY9Oxf/m6sv85cHZnIcdgUUkkaLdhzYoXYDWMmo1Ak6D31qnvwO26nEc4Nf2f/U1pG0EOpp
	WzuiPW40nxmab89AhemPyiC/xZAydC54ZC2S8wbTH3YrDCshKnwzc3hn2ORbmSNzc3OjGygbG1e
	jCaqrV6N6ItEAgDI/NQudmBwdVTFNqXK+Waqe7KD+45rjIMkEdCG0iiJnBASNMMn7R6EMyWto8Z
	NitAa/c1cU1C5CRPF6l8Ju/WbVKUEG2ws/Xi/UL3n5rlNMfwJ1vZJLXC5In1oDgIH8KJ72F8iPA
	ZsiCmica4QhP3rE8oJTd/1SQKx7kRv8ql
X-Google-Smtp-Source: AGHT+IGB29W3TqgK5gfHdx17rWs6QdlKifvPHsUNAQVltUUYu2zh/Zwdpk0V6cpL4DLVztirvIJtZw==
X-Received: by 2002:a17:903:2352:b0:254:70cb:5b36 with SMTP id d9443c01a7336-27cc0db9ba4mr41304715ad.8.1758668621281;
        Tue, 23 Sep 2025 16:03:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-272435b6822sm103636345ad.125.2025.09.23.16.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:03:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1DAC6423FA7C; Wed, 24 Sep 2025 06:03:38 +0700 (WIB)
Date: Wed, 24 Sep 2025 06:03:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
Message-ID: <aNMnSapfyfwga0Oz@archie.me>
References: <20250911004416.8663-2-bagasdotme@gmail.com>
 <aNJ9yJ7XT4Pnsl9E@archie.me>
 <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TJFNCLqvXEgyfWhu"
Content-Disposition: inline
In-Reply-To: <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>


--TJFNCLqvXEgyfWhu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 01:44:18PM +0200, Andreas Gruenbacher wrote:
> On Tue, Sep 23, 2025 at 1:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > On Thu, Sep 11, 2025 at 07:44:17AM +0700, Bagas Sanjaya wrote:
> > > Documentation for GFS2 is scattered in three docs that are in
> > > Documentation/filesystems/ directory. As these docs are standing out =
as
> > > a group, move them into separate gfs2/ subdirectory.
> >
> > Hi Andreas,
> >
> > It looks like this patch isn't in 6.18 PR [1]. Should I resend it after
> > merge window (and for 6.19 instead)?
>=20
> Ah, I was already wondering what had happened to that patch.
>=20
> Can we just put this into the next (6.20?) merge window?

OK, I will resend after 6.18-rc1 is out.

--=20
An old man doll... just what I always wanted! - Clara

--TJFNCLqvXEgyfWhu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNMnRQAKCRD2uYlJVVFO
o0qlAP45w7y0ijoPca+WRWWR7uDsyafheW+piv5hf202bJQxhQEAnpSuvMubtyMj
GGi6LPIrwatrZPCjfKwexwl+kv/kRQQ=
=XR2A
-----END PGP SIGNATURE-----

--TJFNCLqvXEgyfWhu--
