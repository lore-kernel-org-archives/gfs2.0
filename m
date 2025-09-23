Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291426AEC
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625233; cv=none; b=aVVOE3LZIdTSalG7ojvm45NkABuGM828xEn+s2wQmWGCYt9M8+wjbOMYdaDcC6ueEkGJpXxWYHxA6t807sB+Cf5Qehle5nj5BRhRJnLdAHjJID2S3w6CTBT+EnYqdhdySQmmlZJA59vORntjWiF5nAkrAkwmsw78qD4fthyc0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625233; c=relaxed/simple;
	bh=GDxglpOBD85/zqKPgGqA6irkma4YXu4IN/8mmFFANvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL2nPhX6R+wUAnQrcMAKvqRL7sAfpvyv9TH7fE4vu3F7qlD/wyHuLuqp/iRyWRdYveEqndxu4avmkc1WN+cLW9r1B9r9yV9Gzws46t63A64mkjZHTS46F2fWVUXCfc1Hte+16ziT/1XREp7NISy6zNS+bWopEanwtUIH+PnnQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK/YYt1Y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK/YYt1Y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f3405c38aso1887428b3a.0
        for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758625231; x=1759230031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDxglpOBD85/zqKPgGqA6irkma4YXu4IN/8mmFFANvg=;
        b=jK/YYt1YPPVN58i+kLMw0sYq3/ByViZ0EhUjZiTG/2hWVJzZEka+mlZEzDSjZqU6Oa
         ZNz6prthpztNMzifnsAuA7B0aaCz6UdAq8GQ0uGU7UP6YMVzWFmjInt7wgKbxustudab
         4EhsALu28lGaun9myYX7LUBQXBD1M/qGWdt7FKCne+h4UzA+VqS9OovSzZ4gE6MhHZ/R
         gnsv3uUgjK/US2TrG4TyibdbNasM766FKUDSfbxnKt6vTljkjyAMcTvVBAuPrJx3ISfz
         sl2pGVmspnKBhhv4NFFrMQQaSdNcNN9UXm/g7FhohcX1kW2vW3ycFqRBZ4Sq2KLyEIHg
         DLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625231; x=1759230031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxglpOBD85/zqKPgGqA6irkma4YXu4IN/8mmFFANvg=;
        b=QmL5TkHha7CH7e95u9MrcfBHPGSe8838w5y9ns7O7HuPu0yjs1ZwLbqk0KsPNiJP74
         y21xJdDioNg17ht4BQHyTO8yZjEXoaL8HwcBSFMU7W3KPsIXREBvjWQrtRHduB0hJNrq
         x79GXly2qLt2scRoddzlK9cOB4i3LpbDxmA0DNCsF2RosrQO+nXK0/Z2C+92O/UWk3hB
         BHRT/MN9noKyoUtHjmXZJu4UaTccKJO+Tq4hHpmxLIpVdWng/sg/ntlEwFKhgdr5xcAV
         Bhvwj98Qbf3+07V7pyjNfK/e6305/6GDplk2Xqwv+4lPoQxG4ODnSxJHhpRBAdDIQKUH
         BJqg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bE0S9Ax4m/AzWoPXmrlBeS5H2fm0+zI5XQPHrTpn8Txlq+bw+Cr4YzmnZ+18u1VW/PmW@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyh5Tgoi7tgCCKKoWzGtBnV6lO3OPqNluYXfWhmyq+7WwQlGNy
	jjc2og3np50jn/kSvOPvT+jjQH8VosFAHujJeuOS9lO4URX0avcQlstP
X-Gm-Gg: ASbGncu49Xh3bMY0KFJaAyZNosk4oW8qLfAuRw83QfRou9qRBuXH9AUIo2QOqliloHJ
	cb4i2OVsg1LicEKrcvHdh8OXb3WHPs1VhesLiqvG32hFfBhVgkGeAcDRLH4nyy+/clcRS2lnNFr
	vzWaaQVOot0sbT/hxYMavUutUOzQD3s/ojmG2ykpwW2tP4i3BE78h9nFy2Z0gUCkAINJ+2T1BPT
	Ar7pEqz3V62GQ35c6jDczUPna4o2b3/BOyR+ALlItX8Kz4G+ICKbKpANK9/Aur7q+gzt9qPKEfQ
	0T6U4XhQ2Jn5IfZxd9jJaCVjk21/bEvoiL5dkmaU74GGYwfyjG4HEJ7zWdZXoGkTOpmpS11xsgf
	iK2iHL+ARrVUdPFCNatnY6Q==
X-Google-Smtp-Source: AGHT+IGlJnxXcG91si6Lov+UeTJK18aFcEv9DMAsss+SwJDyYu9wS6PnyUUHCx/J0lIhGRH6XH3NEQ==
X-Received: by 2002:a05:6a00:2d06:b0:77f:2e62:1e3e with SMTP id d2e1a72fcca58-77f53a1373amr2631781b3a.18.1758625229911;
        Tue, 23 Sep 2025 04:00:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0fc4cfbcsm10816814b3a.61.2025.09.23.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:00:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DD14641A2EDC; Tue, 23 Sep 2025 18:00:24 +0700 (WIB)
Date: Tue, 23 Sep 2025 18:00:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <aNJ9yJ7XT4Pnsl9E@archie.me>
References: <20250911004416.8663-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zS+cmMosgl12Kn56"
Content-Disposition: inline
In-Reply-To: <20250911004416.8663-2-bagasdotme@gmail.com>


--zS+cmMosgl12Kn56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 07:44:17AM +0700, Bagas Sanjaya wrote:
> Documentation for GFS2 is scattered in three docs that are in
> Documentation/filesystems/ directory. As these docs are standing out as
> a group, move them into separate gfs2/ subdirectory.

Hi Andreas,

It looks like this patch isn't in 6.18 PR [1]. Should I resend it after
merge window (and for 6.19 instead)?

Thanks.

[1]: https://lore.kernel.org/lkml/20250923090549.31521-1-agruenba@redhat.co=
m/

--=20
An old man doll... just what I always wanted! - Clara

--zS+cmMosgl12Kn56
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaNJ9xAAKCRD2uYlJVVFO
o3EtAP9KVxkoZ1irQ3++A8HUSRb7xWOkDTI/dXQuFagJgf77hwEAmv7lMeqvV4p6
v7FlBiDHPYQWC4/5lWxjwyZmlVwZgAo=
=Q3gu
-----END PGP SIGNATURE-----

--zS+cmMosgl12Kn56--
