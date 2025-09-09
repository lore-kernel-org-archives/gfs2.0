Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24C2874E6
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460530; cv=none; b=d6vTrN8onh7N5/7wkxDFxKmp8DjAmq7PjB2bqLtcNaobPmxPZNqQj12gPdICZHlAjnjxcHs4iZrlQ3ogKEbasgjlKHNttr0d7XsA8E+93RmqNgNpqvaMekn84vLy/Vg9vdmPEb+aTkO8q/uxHy3F+MMkPCeAKJ00uovsS3K9qIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460530; c=relaxed/simple;
	bh=aP32tY/7gzIP/DubLKct8s8WemhrgWLqsffY5Vv1N34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdOsgVv+lw+qijW8RYQKvWw7SAVnKbIS7M1IYCAdZgKQtYnOakXAtGUM2ybD6pfgtaztqlINipu3MtiOnyHpYBHn01okc3qTm/aQg7klsOcmTm8arWdHfx3sICgVxFQU9+9j+3QFBZttiDUBm1igaGpzq3rimodGmLQydJ/wq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXrNJYrg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXrNJYrg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24c89867a17so62102905ad.1
        for <gfs2@lists.linux.dev>; Tue, 09 Sep 2025 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757460528; x=1758065328; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1py8/Jv9TkRWmTtTOdiRKj2ug1E6J/3gf1mMsVDV/8=;
        b=UXrNJYrgs0RrB9r1DDZJArIROGF/tzCLP9aYoZ1dEDWK+pMCLmHz3D66oWtAmsZZlL
         A65SJxXXdVUqg1Ga5u0b/MIkFZzk+vXlgsBCfpTQoxypIBL9orKxxMI4mYTh58MDDK79
         LVse7fzawisXGT8+4vZHCQz3TrhxzsBn0ITYe/7IbWR44ZRHs2jR1Oyt5TIFqiwdCG2D
         pjH3Fu46ZfX71A5nkX8UXyxQkBHXiytUJiZtebz6nbxmzWkH7HXELeijEAVjHahCf2Bh
         Kz5Eqq2k/ygtAcE4TXecBlLD4FyuRkd2qB+r0ErA9dVWhGda07kX/e30x8BaCzqr/2io
         +ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460528; x=1758065328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1py8/Jv9TkRWmTtTOdiRKj2ug1E6J/3gf1mMsVDV/8=;
        b=sP64Q9Pbx2Ns/vcAp8UwhxAyWzK5UK9V13ofD+GSdB62OKLg67IOpGOFdlPVfSJtWG
         CnstDwqkTxHfORPz9zrMxcN5hJE2wQho6Irn37nNbvLc2ho2rA25IqqGdUHWBCohP07P
         prAHC9CTDuEBdCknw0e55hH2JDfd1EFuU2j7hK4hbDzjlSCtLS1yb/LdgsOcyWt9I78z
         4OWh1B6SvH03yk+8NlubSPXT8sAhR+sbkl+2DWaaZSZHwAvqYHL1mKMFclNtY1thEJeU
         UUUp0UOyItto+aDLjOdadWkryeCWeNIwYvBQ1nN8dkLSU7w1OVUUv6wU0NQe7gc9wdoC
         ny9A==
X-Forwarded-Encrypted: i=1; AJvYcCVpSZSc+fubuAr5ozH6wW3PuFSVN3Az7xgqkTAftAr/5EESoTJw+l6KnR2Y/HyDTBsI2XwQ@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1mM69XyPXYvGhzXAOSRf6wrsnkqmuqb3kOxfb+TQOwn424JPW
	rUowtsxXLMYbrX8jzPWVEzu/Pc9DcLGTMHEmJph73K4xR+24ReHvQKEt
X-Gm-Gg: ASbGncuGiyf/duTzAaHLHxqmPRUqMIQ4Nt54mKfwdgsmfrj/xhIf9SxUQKmJh5WwpXx
	cdq1d1l3hTS81fWNJaJfE1I7XYQZpHEx7VokqN6Wkhb9A2FRQvkfCSbtfyQKoQk/jdT1+nlJcRx
	MdyYI21EV4nNyKwiB8l+sF94cV+/IM+t4u3kOkn8olZGb23svh+zE1y+iRNCvxMDs8kySyc6wyd
	B0XsCnYeS5JOt+N650K//im1kYAgb8RE94a4gkV24BOoJuLvcHX6SNbjOze33V+agdIQTADEhGc
	fQG0brSodz5Zn3mvDDEjwiTQ/y/NcBsZNuKMflvqnBNTPIyyVaWnoAMuNLv3fbBpqey9T6haA6e
	2gIWd/URg2wqnNy+1EI+Z2GWWpVI+Bue0vFP+
X-Google-Smtp-Source: AGHT+IHzV63aqLnTtdmYIOYinkzvvWyF2KLPwY/kTRq4fanCxApLrZjpsNTQgCocL2ksNOykityyIw==
X-Received: by 2002:a17:903:2286:b0:24a:f7dc:caa3 with SMTP id d9443c01a7336-251715f33f7mr163441345ad.37.1757460528309;
        Tue, 09 Sep 2025 16:28:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422e30sm8632275ad.23.2025.09.09.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 16:28:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B3704206923; Wed, 10 Sep 2025 06:28:44 +0700 (WIB)
Date: Wed, 10 Sep 2025 06:28:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>, James Morse <james.morse@arm.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
Message-ID: <aMC4LIltHWlpF9iY@archie.me>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
 <874itbv23b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yD03C9Tz4Fzfcskn"
Content-Disposition: inline
In-Reply-To: <874itbv23b.fsf@trenco.lwn.net>


--yD03C9Tz4Fzfcskn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 01:48:56PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
> >
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> > Changes since v2 [1]:
> >
> >   * Do not use wildcard on MAINTAINERS file entry and add review tag (R=
andy)
> >
> > [1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotm=
e@gmail.com/
> >
> >  .../filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.rst} |  0
> >  Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
> >  .../filesystems/{gfs2.rst =3D> gfs2/overview.rst}      |  6 +++---
> >  .../{gfs2-uevents.rst =3D> gfs2/uevents.rst}           |  0
> >  Documentation/filesystems/index.rst                  |  4 +---
> >  MAINTAINERS                                          |  2 +-
> >  6 files changed, 17 insertions(+), 7 deletions(-)
> >  rename Documentation/filesystems/{gfs2-glocks.rst =3D> gfs2/glocks.rst=
} (100%)
> >  create mode 100644 Documentation/filesystems/gfs2/index.rst
> >  rename Documentation/filesystems/{gfs2.rst =3D> gfs2/overview.rst} (96=
%)
> >  rename Documentation/filesystems/{gfs2-uevents.rst =3D> gfs2/uevents.r=
st} (100%)
>=20
> I'm not sure which tree this is meant to go through ...

There's linux-gfs2 tree (see MAINTAINERS)

>=20
> I do have one suggestion: the changes seem good as far as I go, but I
> would have made gfs2.rst into the new index.rst and avoided creating an
> essentially no-content file there.

As gfs2 docs currently only has not many (only three), I'm fine with your
suggestion.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yD03C9Tz4Fzfcskn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMC4JwAKCRD2uYlJVVFO
ozEKAP4lpszupR635IazRjMRtgE7q5h0RViow552zXI2EZ9Q/AD/YsypM+DqP+sS
MEaZ4dA30h6opucVYhImfFlnHvxq+go=
=JqMA
-----END PGP SIGNATURE-----

--yD03C9Tz4Fzfcskn--
