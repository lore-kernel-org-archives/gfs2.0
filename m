Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5530E839
	for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693448; cv=none; b=sjAjvd6QKLDH+LEvpTYDctT0Qee0oakIW0I9jDtNtyOIuFu5HF+BT43E0J1+Nzsc6ZPvGOy6G4CQmiyDvDJRO2OYGuwh09rlEO8jt8Q/mJZjGEZb/TBmhF6DVDuxOaRkVYHeX7nIVKhczggh9GHW8fUUethaO1Ml2sFBW/VbdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693448; c=relaxed/simple;
	bh=0RHe6bpoJIZwIozT53G/9zPYXo1UJgO60j6sIrqFoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNVUY2rA424kQsfSMkTKp/WfiYsODpdbRoplBQHXytOmeoZqjkRbcM2oMdekGKx/3wnlhDn/S0FPj5x950nnpTNKqXZJBL/E96vWgH2nA6V3b60Ckj7FP/Oqzii1DCwJJRQ+dHhubc5lSnoOhDpDg88crRhOulx5Z1r8s3fiWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4RSzqtO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4RSzqtO"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-723c971b63bso16462166d6.1
        for <gfs2@lists.linux.dev>; Fri, 12 Sep 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757693446; x=1758298246; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=S4RSzqtONkfRUlO/hoTZv3VvxaXE6hEfDLKUuNAB/ML8J8xvt/+cbw+oNjtktKJ8SO
         LrW6ldnwPiihi3/b896KrtHXy2xLL6+iWOK9JrulTYJ/hAyPgnfJE9ooKNOvNxpJlbT7
         s79Wk6PiaSEMgbJcjQ4XwUPA64wTqvYNySI1tDMR6g2Gr+Tj25pFR4CNfLIuMRJJN7Uo
         XTt4Af8KGeqg/VRtUTcLZbu1VGiTxIswYfdlq71qt+LYKppmXe6ZwYYei1CEu+tBCvPT
         G6WjoM5N6ow9N04DJXEqdFgahj3QXtqabatlmcqIOcU4D9AgrKQkh1eEcIoUKVeRSepp
         YBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693446; x=1758298246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=uaanAY9jg692D9VOEJtVyj7KV+GLYClYDTHNafJcUKDF2/Q9RA9H6h8nHCE6p5HOea
         L9NzNGXUPCgZ9Ec0TWvicz0O0BGNGOrxm26EjxkXEFJyop2NKh/Eo2qEBStTjLDX3D4d
         hOm5Lg+UuToYwVl7l3cN+3jLnmHXzzGbaLt0yqqPLACgTiM2ZjAQyZzO7ALo0bu2PoUz
         rvpCza7TPLTp97ydOrPHu7lJQVTQJ/fIrvyCz5ZcHL1GrufgXk57NvzXiuawnLKNFcXq
         re6NkKLSztQ15Tkphp9iWGAArJy5JsiWkODA+eskMKIInxKIfHpRVUkFAqk8bmi1CbWN
         Qxyw==
X-Forwarded-Encrypted: i=1; AJvYcCXBCsPRflzFdDy2dyvU+nSmzgOPFwIYWgycoyEAFF/lAs407VBqgwGQeM4+8mxv+qJWDTp+@lists.linux.dev
X-Gm-Message-State: AOJu0YyzQrfhNweXwrkmuAdCy46BNDzpBLgAxZUbprXmHZ+xtoF8PhtW
	ED1m+WZcIUIIUC3RXaenzvJ0fJhuPqAFY/Wz7lEEZwkL40aMyl0wYA6poe4leGGSeMzXsbFxPC+
	NbGTDQl3b0VqCWPHn/M7UTiHknCG1e/M=
X-Gm-Gg: ASbGncs/O36rBOppwJeJFxYgVpM86lDn1asxFOLN3S0Ax+FU1Kkk9OxucFm6kH+7Oko
	/cz0PafFe+idAg8wy4FxyUTeC0+mJlST8vHZ2BQRBBhKlys2hpcopChJMtSfRen47Lr/K/kweDO
	l82/2PFPTRE8iFZSNldDivPCTbWdohFpz/ja2LAH99SaGeOeeIBwQ+PodBp5UBnKNmrT7GpIFgq
	PL/u4Qgotd3zatEfOGZqWescONLhYKUN+ecGTbADmUrNysMIW8u
X-Google-Smtp-Source: AGHT+IEW7Q+2d2hor5P3hr9ksasgPpy8ttcb/zSz69+p8aktjcDEYkFuq3rxTSdGTnR+6WW44n0sCoS+JUh7Itaiy9s=
X-Received: by 2002:a05:622a:4cb:b0:4b2:eeed:6a17 with SMTP id
 d75a77b69052e-4b77d12a30bmr47218771cf.46.1757693446130; Fri, 12 Sep 2025
 09:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-5-joannelkoong@gmail.com> <aMKudxVnwafaoqmm@infradead.org>
In-Reply-To: <aMKudxVnwafaoqmm@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:10:34 -0400
X-Gm-Features: Ac12FXytydEpN3AbZfB7NDTCU5MSfYzu7GMuXUcwO8TmZQQa1qHB0P4yWy0TUqQ
Message-ID: <CAJnrk1Y6VZUA0g8223cPvmO_FjnKmemVGQck0_9DVcZkw-yGxg@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: store read/readahead bio generically
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +     void                    *private;
>
> private is always a bit annoying to grep for.  Maybe fsprivate or
> read_ctx instead?
>

I'll change this to read_ctx. It'll match the "wb_ctx" in struct
iomap_writepage_ctx.

Thanks,
Joanne
