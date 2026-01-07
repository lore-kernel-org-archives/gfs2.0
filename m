Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6119AD5C
	for <gfs2@lists.linux.dev>; Wed,  7 Jan 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795287; cv=none; b=OwVk1jf19qEFxFHR43UsCk+PsOZpKSH0bOght6DCdnPbinMK6UnLgCMV+Y30XgkQT1EChis9tinp4+fHwgBxePG6wu09KNq4d9iT0FnWAeX1nxY22Ba1lb/AoI3PVMtBUCRor3Ha/nemk3QEymph6bIqQWSgkMe3A6PfbEatToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795287; c=relaxed/simple;
	bh=QNL1RP/JdhOmi5/rV45P2NsWogoItoqxDhCvmLtaWXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiSDq8+KxazOFtJ49/Ke5BTKDS9RxsAN8axxTi9zsGrwFHhyTLwK+5GjrqhgsyBeDATddZVt+fypubjt1Jx0GYt0Z7Ems61UFjnWcBmzLM7IV5EuhB78RVam/CX86e1i3txI2c9JHky61sMbkB0EkHr6ZRZiyDI6+214DYKdIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehb01eKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehb01eKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767795284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ2xstaENyoaXi9ftJgZjYoP0g4HtybPCVnpkoIo40A=;
	b=ehb01eKwqZGZbOevL0wK0xwGSLbqsk7oaMrJ1IlMPJqw5MTpbgm8UYWmLn1waN1Z4bBw3B
	5Zw9mxd4ZbXw1ZIZc+Cqmt4UTZr6536f39FX6RIXuVCixkdU198nw1cwxVGKf225avJMLA
	LnyUU4S80D6Hr4S5crKny15gA7JZBIY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Uc-EhF3NPjKVVi4lmxKJvg-1; Wed, 07 Jan 2026 09:14:43 -0500
X-MC-Unique: Uc-EhF3NPjKVVi4lmxKJvg-1
X-Mimecast-MFC-AGG-ID: Uc-EhF3NPjKVVi4lmxKJvg_1767795282
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38301605df8so2737431fa.2
        for <gfs2@lists.linux.dev>; Wed, 07 Jan 2026 06:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767795282; x=1768400082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQ2xstaENyoaXi9ftJgZjYoP0g4HtybPCVnpkoIo40A=;
        b=LIG6hDSPr054dSLQjaeFZVpQN9RJ8MtWoCL+EgVsU3lGP8UQPc5nUsOGbnAVbfJ7Bv
         a2Qr6TXTOIObJZ/2wzscgr0GGrTRRahqBOD1G9qZ6UxlRM7+einBNidxwI9+mD5DcmPQ
         kqmnPxy3dZNrvEIOdC5KC2rAUjY3mDYHKR6Nz96GbirYUJ917G0S3mvqM4wrfraJS04P
         gMItmzkN/f2O2akBih8+ChQBZF8dPuEttPf3AJvLg6d9J3BQxsRAgnJ+H2+cnmSEKIfV
         gccxK7v1osPnO6WBY8C21eeoLDoUbZY/TPOi0G/W+hamzuOSjeXbXH3ofJ3ks7taGQlW
         PAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXveXbLFOpEvxpw2liG4hI7uLutjacDBwVUtvGoPesP1RgxcvyQTE+/e79gau/0cQp4onuS@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0KwlM2o0IJ4esNO7+5tRFiiDNCL262bXPeO+H7Bx8LdeLPgju
	dFmHQHQUyPGYMWQr9Sxoh2rTjUn//2nwJ5o0lbKTJbJNdtfG2o9lTw5+K3wJwKNIFo/+YHqZtxG
	TLhjT0ZR22oK42fme5kwK7D4tSaSCrBuwEQsmuWqUyDsGS740bQF/ZQs+0oCGPj3upEtszgwwZS
	p9Es4xian2BkgzDtp5XsI7F11vVzyqaw==
X-Gm-Gg: AY/fxX4y9m6Bqsho1IH6/+MU+b0sDe/VVtEFdtfdbyldN5DYC2Qb2muxPwoZRdus7sQ
	akSsMlJKIh9/wh+quHEclTui6iuvOY9KzQwAJi6AeukgMrjobhLUFkLdfUwH0R26Pm71SS4JEuT
	OB1YqRAxn6J8PAOmybYxS3ibkCn93JW0C9uxM4dNxqrU3X1PZiBxyCjc644DR9RJUB7fz9jTc0b
	NcP93FdVbjogpT7xNtgX4+h0PFO
X-Received: by 2002:a2e:8a96:0:b0:380:989:f60e with SMTP id 38308e7fff4ca-382ff680159mr8904821fa.7.1767795281590;
        Wed, 07 Jan 2026 06:14:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKokhDVdin3q3d1qcbnrc1b7zSfgizQGUCp20GJG2jGcfMCECuRNHwfNw/eBAuzayukcFTCxt7CFl/E7WO3Ec=
X-Received: by 2002:a2e:8a96:0:b0:380:989:f60e with SMTP id
 38308e7fff4ca-382ff680159mr8904681fa.7.1767795281009; Wed, 07 Jan 2026
 06:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107073015.16562-1-alexs@kernel.org>
In-Reply-To: <20260107073015.16562-1-alexs@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 7 Jan 2026 09:14:29 -0500
X-Gm-Features: AQt7F2q-axPPTJWbaXmpV0uLqil13Xs9JH4QKnFAOZpv7g_Y0mwxWANdRn-AbZQ
Message-ID: <CAK-6q+jkL6ZVD3W7byROpUBwSEz4PP2vQcVdkfuaKbBAQUPyog@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/dlm/dir: remove unuse varible count_match
To: alexs@kernel.org
Cc: David Teigland <teigland@redhat.com>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QfE1fpXXldeTtCmLz3b1N2urdRdJSTBifKxAr1vwYB8_1767795282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 7, 2026 at 2:36=E2=80=AFAM <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> The variable was never used after introduced. Better to comment it if we
> want to keep the info.
>
> fs/dlm/dir.c:65:26: error: variable 'count_match' set but not used [-Werr=
or,-Wunused-but-set-variable]
>    65 |         unsigned int count =3D 0, count_match =3D 0, count_bad =
=3D 0, count_add =3D 0;
>       |                                 ^
> 1 error generated.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: gfs2@lists.linux.dev
> Cc: Alexander Aring <aahringo@redhat.com>
> Cc: David Teigland <teigland@redhat.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

