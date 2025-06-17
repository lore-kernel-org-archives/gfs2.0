Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B51CAA62
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188937; cv=none; b=YD2HzZ/hZ/VsYdb5KQR7W0O9IMSvO7Mw5QjxOVYx7wRtLr4bayuL/Ne0ybW5gl34K0L0bQ7UkyTxgfGiSbtTh2v+DYCefkU8btxpwpMZnsnOIg4J05L/OkXY86KteLDyLgzU7szGU5cHTdzH72hPQ4yvuDETCA7PYWAWL6+CmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188937; c=relaxed/simple;
	bh=aHeR5TvY2TOMqEvpw3v/Isa3CBFokUQe/mc7hD6LOfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaaKxrEyxB9PezySKHO/DYxm/2X+yebF2v2uOaiv1XwNJujFyuNs22YwBbDeMPUmYyJpzwQw6JYyDIU1zJH1+K3MryObDuit/f8vh22ONg75HQRqVnXZSCVdLUgLoepkpxAiBNEOyamIFfurjZamWgItFImwLNOVpAcGdqooWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NirB/mFg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NirB/mFg"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44e94f0b0so74358531cf.1
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188935; x=1750793735; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/9a3nTLF3crPDcU7zdTz0aCFqms9P7e0P7pfzgojxs=;
        b=NirB/mFglRjaHT9RC0DXqvNdKUzCx+sRiBlI1UXLOHcPtH6PAOU/ljfNpl71Alzc9N
         hkVGnAsY+rMnGJ+ZsXKuG/kvAHtcrR9/HIaPjEQgaR32j2kk0CEACGeKWnDU+7pwgxow
         Dg1vg7VeN7Qh8Wc8ok3eYOTxyR8N8QIRJxHBakh7GH9+pZLy50EcJo/b90hdfoqbUyBn
         OULK5Mgzf0urgEPwVTkXincAwl3tcvDPuIDvK5SWD1Sm6ZlREAGsZ7SBtFSa48WJ8aNV
         lcSUSSPpzTGnWsnva6t/dCUMA7DSjo7jY9p6XNsZ913/sJlpVqcTEQ0x+PC1IaH3d5AX
         4q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188935; x=1750793735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/9a3nTLF3crPDcU7zdTz0aCFqms9P7e0P7pfzgojxs=;
        b=iSbCtobKw2sG+9W4JWeLf3z9C+Kvr8roKEo8kYiC4BcoE0rweOfACCX8Gs022wMU90
         Lt5l/MxZBa7qBLRe3vdW62+tlszv9Fr+pouvi8U2GP0oCdmB3NMa4QdVjxgDIKsYfy9F
         ILFQtr/4DFybJmeNqrPc2L0989PS4qDefbirBrmsw8jAbf/BQLQ7/VK1rOLTjbQI2rI7
         WPOTTKsjLkcuGzcUA9E5ITOkwV4seQT9E/+ppnuGfiivDs0HHwfR9o/rV/UrkYXzHw1y
         lOILROtNNt+OfnIP5QzSohE2UaEy50GGdC0OepXkAjCOd9toHMJFmU8xvKSZ9+kTi9bo
         H4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4MyOPWDLAfTZTHSmZAz75iFL+pHwuaIXsvB3PpVzaH5cCI3+j6lwG1zbpcfXGprh8/vz@lists.linux.dev
X-Gm-Message-State: AOJu0YwqeSaCUrlpVS2mNYP6KqT2EudWHDWbbS4vUWgtAGKvwoZ9Fa65
	SNNBST0H/awr1Zm2Q1XpcBETIGECZDHPfGwh0w3J4bkiZEAr4MHCz31214QqWGXkiwx290yl5pC
	bOH/JlW8kkbu4vTOzVckJD3OQKIs5bWA=
X-Gm-Gg: ASbGncsQkonvDHKwBtlgrSs+iRgWm33TZnHRshS8e+aN2nYqsrFgaz38K1R+Yo8950O
	yVJTdvIWrzI3/WgOHjCrBVqq9Hl535CDhoK/zJ4Idj2cwyTgLx6h0h/fNqFJK7TlO4yOltDu60o
	Pj2lsMgmbEDdtisIs7uGWwYCgFILKM8UcDk6CSCcqgeRuGeDNygx6Tmh95xpDrTM8UfqDtbw==
X-Google-Smtp-Source: AGHT+IGNWRrg78f2AdGVRIQIV7dWobH96xkUMSYd2uhj7HCCB8qHyFk4aKVijp1u4DOGWFfSZF3McIhV6rZZcXgCPlY=
X-Received: by 2002:a05:622a:11c1:b0:4a3:96b7:2a73 with SMTP id
 d75a77b69052e-4a73c533a1cmr231209081cf.16.1750188934744; Tue, 17 Jun 2025
 12:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-7-hch@lst.de>
In-Reply-To: <20250617105514.3393938-7-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 12:35:23 -0700
X-Gm-Features: AX0GCFtb7h0lrcd8zlSxCJeX_oEZLGvjTqKxxkACd5AlnwnZgcq3jlm-zucC95I
Message-ID: <CAJnrk1a8xkwwLthOrs3o+Jn8tqSCyEpOnomXL3+ONopFxd7QTA@mail.gmail.com>
Subject: Re: [PATCH 06/11] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in ioend.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
>
