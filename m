Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F5253F07
	for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547698; cv=none; b=ulgN1aw44yFhYSjs5YxnIobkL3reqIBpX8m6U0qXWRmZCDImb9sHEK5oi8+1UmJvVbncqxmVIiYZAYQhxDNlbsf6Uf1cymV1euE/wneeaNRjir0XCUTd8FlVpnBalBflanG9R6ctYm8i4qlFTMnG2c88nEgNBGfcqiBcmLkvE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547698; c=relaxed/simple;
	bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWcg7EgILLSddfzHAIo6FiRBwmKJDq6VRuOUTABNJE/jlR/VUaIoyKqdAPRqHI0DydSsTsgnRjGqoqAhl27HJC5wdeECsHYYiAmdHGa8YM2nfefz4DJgH+VKsJ4LMnst/hzU6liBcZHdUdKNvfoK5sd4ERk0DJQVFlvTA0g31UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAI5y69p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAI5y69p"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cde6c65d1so671105ad.3
        for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757547696; x=1758152496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
        b=MAI5y69pz01qRW5N50gI0EseDcAwtE4bsoJ51MlEI5yaDDOJbiNuSbl8gtn4EUqFJH
         DxbpkJ1SHfWdJwe1my8jp1XlZ2ByfPFjaJA9G3QMFxouAw0yvaPThL9+2o9iXGYKO4z9
         9VVT+aOzC3xlLpDY6Qhavxn0NP7bZCtDOJnad5eeedUv2s0tne12pOhcP3KEoMgoFdoQ
         eoo37QVlgdmT/QG5Qk9WROqCW8qSuJukZ8S15l7nip3UlUgtoCyYITl1/s0DW5l9hgN4
         E2+gRg+i0BW2LyL9u46Lj7agCULrIN255kHcoLiQ/iHZtNQ6xYbH6lDO9oNqurGhfasR
         igEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757547696; x=1758152496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CIC7CwmIJL1HWJm+gFKpQIYWIydgvlXQgBo8aAnR68=;
        b=g/2ZdmLMCdNkcSL63VQrCQoPmtpNB8XmIcpLzw6jTN9ANO7sJBDoDaQXmITvPxv4kt
         28dQII4OwTRE8xf1jk4qD7beETAhpNcNlgXANrtQheb53U5E2KwOJwU34R27nxS9gVQn
         a2rfBwXdi8sh/2E+oyEm4EOreRRDeJUxUwXlRdJt4IPstiIoR7ADM9Tt4sdYGgPJFP/+
         M7IHWGJc8G5vp0P4kIhZ1nwTcPAa6rCgqWOdmHZfB6A9MaJ+qHLd1yByJkKJw/43xBj8
         deyb3Ne5hxX2tDeyF/YlYGgwUlSJ8evgM4KUiiNEhPvKNN70sLLiGT0yBIqgi3Ome/PQ
         Tilw==
X-Forwarded-Encrypted: i=1; AJvYcCX3n9FBD1nIO/sS54ENT8qIzAVcTj895WciCBJ7Dcxsg0lhxVrh7mp5stkJIkm5FmdFp9uS@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp1Yjk1AuAuEh1IPohGuUkC6Y+ZJSTlxGM4KWKNWwS++J2cQNc
	j2UhBPPaz/aj2FeZkTLW6mAjsr2SySUp6abjkZT46rXd7tPx99vWkRBqUuJTvVVYBCE=
X-Gm-Gg: ASbGncsr2SKBXA8s0uK8dxAphH5YUQTROeYwDzBiiN2uz2jaOCTCoR3thm63JATs+8B
	p4Hg14J68zbl/mdc2qZQIJAOb8XSMp3xPk+lDIs3id9zk3RGZ8XdjohV3bE0lLmj0IN0jz0+dyv
	9QaJEuzWxRKjaA0qvxFlIKF8DPO53yDdL/W2yJRaj72zv5wLIEPHwCY7vyLq+YiHhyCfZ5eNzCk
	Vxc+e1YFN6PEW3c9nlXR18zHEgnedacg90cRviCbdVXBTfzbrPFZS4iVYDaVE9b4gCc0y1THjTr
	I0TJelklC8wZ9jlt5X45SH26KbGEm38pFg18nclOd8a2UF6/joIFflEtCy78VbxHHbQvQzhW+IK
	Od85vCxD0UFRASqq5FcYY2FuHug==
X-Google-Smtp-Source: AGHT+IHU2zlntDNV6h4NG6CW9V6x20J9LTc0sJI2cj9065qL+Weta1oYP+ihM44ibqxT3EDmV8tEbg==
X-Received: by 2002:a17:903:3d0c:b0:25b:dcbf:43a2 with SMTP id d9443c01a7336-25bdcbf45e7mr7234665ad.52.1757547695955;
        Wed, 10 Sep 2025 16:41:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25be6fc0f23sm4297075ad.48.2025.09.10.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:41:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DD5B041FA3A1; Thu, 11 Sep 2025 06:41:31 +0700 (WIB)
Date: Thu, 11 Sep 2025 06:41:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>,
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
Message-ID: <aMIMq_8i4LUe9yOX@archie.me>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
 <874itbv23b.fsf@trenco.lwn.net>
 <aMC4LIltHWlpF9iY@archie.me>
 <CAHc6FU709iYrAVB+2DeL8+AkCMtgwtqC-7ikx+f=wqYPAZfjmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OVswxxCfIJEK97dT"
Content-Disposition: inline
In-Reply-To: <CAHc6FU709iYrAVB+2DeL8+AkCMtgwtqC-7ikx+f=wqYPAZfjmg@mail.gmail.com>


--OVswxxCfIJEK97dT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 01:25:13PM +0200, Andreas Gruenbacher wrote:
> Sure, I can take it. Can you please send your v4 patch to gfs2@lists.linu=
x.dev?

Of course! I will prepare it shortly.

--=20
An old man doll... just what I always wanted! - Clara

--OVswxxCfIJEK97dT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMIMqwAKCRD2uYlJVVFO
o1nWAPwJPNLFwTgriVEqnN7Jlnjk/u/i7R58qvOBwAL7J96sXQD9FuoTv+2Yb5va
sQrdnSCbUPZOLQWc88YU2k3Z+dgK1AQ=
=eyoj
-----END PGP SIGNATURE-----

--OVswxxCfIJEK97dT--
