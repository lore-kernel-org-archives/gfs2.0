Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071F2066F7
	for <gfs2@lists.linux.dev>; Tue,  8 Jul 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010088; cv=none; b=EYcB7+RR/gKMwiffjNzNboXz5vCO5WlfUlNKoXNuml2YSKo/xeGfFf3Huwa8KQpNH3DsU58fOZnGWtnHgFKj9BdhtWOER4KP0jvOGmMKGbvXLWzwAjnQIoF/8cRgUK0e9oICD3Mk2xkHva+z0viTqXC5X/sWIoByuzbjecRRAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010088; c=relaxed/simple;
	bh=KH80pBGvK95duvfP05FBqteazR1TV1r1R/kYwzUSEMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teSJ6KkSY9JCZFx+ShidH9fbAJQ9FUhoqEsslcGVYL0Po4bp5RjYgJQ6VaRanuPwahPxWB1l0AERsbWGnRVIUFQR0qKs7bwvRj3s4W5e3PaWN+HK6MrlWxNWUz8jm5rAkVLhFFNVDeo+n7XlMHX5Dtm4Gj3RYF8e5lq136Y84KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0jrJ9d4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0jrJ9d4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a44b9b2af8so28963171cf.3
        for <gfs2@lists.linux.dev>; Tue, 08 Jul 2025 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010086; x=1752614886; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/n4FQqDZgscE96T/Q1Cm/w2ztQMgw6w5bX/UKWRgK4=;
        b=D0jrJ9d4YFUSnqzaiPLY5zbVS6EuBvMCQkQsImfm4GUkBXAAvBjHMbDjnUK3Vx8Tdx
         9rdI8P8K4R0EXYz2Ryfm+qTQUX0ElcTn3SiE+2JSxaBx94Rrht7bAjNiccCO5Ys+hCWr
         Gnqo/Ga9ytj9EBpVqwQsoGaBuCOpCY6n2iMMzgeiups+IIonjr2CocPeOYZrdwNgFR94
         TZvVCG0vijDHo9NZphh6+I68+Aq4eOBh9wh9DCWZQl2cMOShSERYsmOPatrsrNiMnhoS
         7/4uNhFNgX35DdUZ2eVHPi4FTovVAI4vsCpsIJj9U0VxEtix4khQ3EqnWonhY45JgYt+
         U0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010086; x=1752614886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/n4FQqDZgscE96T/Q1Cm/w2ztQMgw6w5bX/UKWRgK4=;
        b=nGSWd5CEB6zhqcuEDL3kakSXYPBB41qCXXTDxc71I/UT/ABIFsyBLhntHz8fhQhPaK
         eppWKibI5LeoMlsM1gRzhVce7twNGKqVgRng9tiKqWC0LvWeHrauYGnUXcqVqpL+5g2P
         KboUtVOFnq9L48A+/YHw5Dhq5JZj3MokdRwXRW7UhIBRWFroOodaVeoAB7zIGd73WlAX
         N6MI9aCkOhf9jRItOF8GnMUS13m31yCOh7K8Y+df8w0HoZQIN4jyY7fCx7c5lBrg26l3
         hevII/i9Doy1I60U4FQB/lIcKuaF1lltB9UwreGZfk5q4PatGN94SXMk5D4/6jjjRQNw
         m3sA==
X-Forwarded-Encrypted: i=1; AJvYcCX0xTd+m1bCVhdxr/DZ7W1AXJcLFStuA/8CU3mpZFyp33ipsYoioKoV+AR0BnF/0L8timQ6@lists.linux.dev
X-Gm-Message-State: AOJu0YwCTd6laZvI1rJeAcQc4PHGCjEQNcZc0ACDx97pv7n8yoQRYGFI
	61N6hT7D2ZaLYI8c2QLHiURxLcCNZ28xvyzyqXlzWkSvqS0bGn1mAZgoitCnvtIVXHTS/RmTL4C
	ctdGB7v8HFMGAJ3sVifietnz6ZfU1Dad7VXA0
X-Gm-Gg: ASbGncuukqXxTVITaDfwSDgKW7whkdtQ8rbOBBnz8McVE4QVvdmIc5H6WZ5hHl9+Owr
	wMfRFKW1+NaDWyXkVBWrqiHDTh+ooLy6C/OtWJwYQPFdVo1kP2pEcbI5bhQbyxN6yU3KSuPoTC7
	z/GhxxD9bt1W0nznN32w+3Yk4iEVr11q3bg14KjkSto6U=
X-Google-Smtp-Source: AGHT+IG6ppwNXJOKmfyqWRjL2gzJNhHTbHsi1CugYOTLDE1djdPPUcm+bXlr2zgXs2duHd/3iqXiYYXnEEW980chRDc=
X-Received: by 2002:a05:622a:400e:b0:4a5:912a:7c64 with SMTP id
 d75a77b69052e-4a9987bee22mr356017581cf.30.1752010086409; Tue, 08 Jul 2025
 14:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-15-hch@lst.de>
In-Reply-To: <20250708135132.3347932-15-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:27:55 -0700
X-Gm-Features: Ac12FXzq0wErtxHImDMLoetaoL0NgHH4F4Hld2zkUOUcA0tdUmgfprT2nRYpH2M
Message-ID: <CAJnrk1YjEtFd-jR=E-QPPy5DkkbScimBNAvoWa1xjo8NQOxuwA@mail.gmail.com>
Subject: Re: [PATCH 14/14] iomap: build the writeback code without CONFIG_BLOCK
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Allow fuse to use the iomap writeback code even when CONFIG_BLOCK is
> not enabled.  Do this with an ifdef instead of a separate file to keep
> the iomap_folio_state local to buffered-io.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/Makefile      |   6 +--
>  fs/iomap/buffered-io.c | 113 ++++++++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 55 deletions(-)
