Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4A22A7E6
	for <gfs2@lists.linux.dev>; Fri, 28 Nov 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293431; cv=none; b=XB7E2wOqxmFeyvITHEgnae20xdW3aZktyl5D13v3xQytFh/fWFUcYUToopkeBxT2OgHm8e5rOOl/d1CdOi9p/+nUPm/F3kZhuPaJNUcMbM04V42PvxguYhalCDu1RiiKDSe41cu8kg4LWHvu3upAEFpAbHOAKM+ugGd9IyC8FuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293431; c=relaxed/simple;
	bh=KBcsmp5at+jJviL3J+0mcROw+lr8j4mNJ+AGY+9OtGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3hLKRrveeEKFcI1i0cgDl1kuiNAGw6HTOhWBfHNvY6bQMQLltnesU6vfN3VB2SZsqrTTOJZS21toLDCfJZugTZZ7RYKTfGNfxWaC3s+PHfex/KGqWn7buAn8KQxsGgx42owd9oCpNOCvlLD4UGwEOJTWyZOnNshZY5c4naJQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EohoMbcs; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EohoMbcs"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed82ee9e57so18729681cf.0
        for <gfs2@lists.linux.dev>; Thu, 27 Nov 2025 17:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293428; x=1764898228; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=EohoMbcslBppWCzyB78X0zdPUNazPZ+8ULHM/CB+1nxoiM5i34w5x6N51p9GbRm31g
         nL2+wQVDPaEK7VbUMREkHLMucLKNjZUV7jn/PSSp4EwX1Ad4Ynm/WsPG5KqQGEUa6ApI
         TdeqPqTpAQIvPKJbCNuOAwd5v4T2f/cHDrn44XHK5JidfVviE0kakqc8QlAJBbK4Qz48
         g+qH1iOCHXfYRSy3OaDmahzOWlPhv6oLq6scohMU8qtZXz0Hy0EF0+OjcHVd6CUMgXpZ
         RI/P1ty+0fgEvclEs9VPhgt2kT8NZa5fFXXVqPcl9d1ZnhvzMpH0QOf+agOuGYgn7URI
         A1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293428; x=1764898228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=w529XJJQoQTpGWrnFGq/waKn8KMk1YdpNMwQ/jxLN1YvQ6nNc52wvzEhI2DAHQlr7i
         uLY46QBqHuF8/Nt7Dp6o5heZhnhG2QgPLCeKX+PTw5d/w8FvlpmVRvmvdGbUHn+VF3Dh
         nRqAA3PPEakmYzAj+D3wpYu5VL42+1Nx6Mwyg/RqGIQhu54MI9EIpqFBXb4Ri6aA1ToH
         hDXGfX0UyUkIc182zqJGbDjEfFftr1ZQSoqHFs0JnpgMZ1WtR9kpLHVre11UEOKHPFzm
         DfMn5Pxlj4QLL5LZHwX4LCN4sSt1JrLKLnHH26XhLRjhiPwx309soTgUBVmJT6exVxlc
         iORA==
X-Forwarded-Encrypted: i=1; AJvYcCUYUEWI8qDqstm6mZpLB0IVWl+RcYnCnCditI56keQbr6z4p4XrtmL68XDh5C0GxYXchiXK@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv9Iyi8SyfisKKv2S+bABLC/fNt9kVHfH6PV+eXN5rI5tgD7JF
	DSXhLhGvguJ1+C3IHsXaWTK7Ti4nyUY62Xvb1ckZSyksLf9S7oyAtNztk+PtgJDum5sLWk9G2lU
	CSZV2pp8IDABmSggTPdJriB1rBKDspoE=
X-Gm-Gg: ASbGncsHZnBMeFW9KwS4pgejuVOlg4SWhvpI1jiiLD2iy7Pge3q26wPezCgTjZVC5tL
	oYwDFg0PRsLJQ/LczS/NjbpsLP7G+IR1POkr8TJ/iTxoNyX5wUXpRjs4hru33I1DjOzPhpcNt9a
	LOgOnVDX+eiuzBDSa7ln1VrCcVg0n3unV9e2gkiR5C/7veoO6sydcu5046OT0yEN9Y9eqaprPow
	hpk1T6fPIdeLslwSrKH+DVZiyElk8yDqziSuai+DhW7YYPPKqX/SAxnsNxIsjBkeP46k6o=
X-Google-Smtp-Source: AGHT+IHLwC+N+hhLqdlufghZ5fhnM4rSYysjvUV/1fIoNRweHCYWM0pQrvWGMYNUf8igtQ6F3vcEMbZAHieS7voSeP4=
X-Received: by 2002:ac8:57d0:0:b0:4ee:827:7e62 with SMTP id
 d75a77b69052e-4ee58b05b62mr339066531cf.82.1764293427985; Thu, 27 Nov 2025
 17:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
In-Reply-To: <aSf6T6z6f2YqQRPH@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:29:52 +0800
X-Gm-Features: AWmQ_bnZka8N-6d6tnub2wv_mKK_srvt07g0FExU0PMtOqpsh3yITqQM0jweo2c
Message-ID: <CANubcdVhDZ+G5brj6g+mBBOHLyeyM9gWaLJ+EKwyWXJjSoi1SQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
> > No, they are not using bcache.
>
> Then please figure out how bio_chain_endio even gets called in this
> setup.  I think for mainline the approach should be to fix bcache
> and eorfs to not call into ->bi_end_io and add a BUG_ON() to
> bio_chain_endio to ensure no new callers appear.  I
>

Okay, thanks for the suggestion.

> > If there are no further objections or other insights regarding this iss=
ue,
> > I will proceed with creating a v2 of this series.
>
> Not sure how that is helpful.  You have a problem on a kernel from stone
> age, can't explain what actually happens and propose something that is
> mostly a no-op in mainline, with the callers that could even reach the
> area being clear API misuse.
>

Analysis of the 4.19 kernel bug confirmed it was not caused by the
->bi_end_io call. Instead, this investigation led us to discover a differen=
t bug
in the upstream kernel. The v2 patch series is dedicated to fixing this new=
ly
found upstream issue.

Thanks,
shida
>
