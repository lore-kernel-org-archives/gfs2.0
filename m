Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04C4F96A6
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977350; cv=pass; b=t2dyUjViXVXogf4cwYks4lbV/UQcawTycfWVepiH5zZtW0RF/n7nbNSzFmCzynGud0BdAjO7XxlnrxZ2/rHJDntYESoMHXiRdS09HdC54Es0/fvgaLiTBe5mUkOPeum8MxLuqPrJyNus1lljwjYwPTGbR3K/7uP+l8STCXOwCbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977350; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNLC6ReR1O5O4XtSoKpg0aKEKDX851ovlymhTDZqSBmijfZktP6EnG2PXR+rTrHKxFUv71BMl+iaeeGdzoo5T+WP0Y0s42TXJNMCeMngINkYd8ZtNV2uBEXP+hhjRHH9zqR78uZ64L92AjpRhmZQoQfGz3iPkPvumYTDAqKSILM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLbPmIoL; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLbPmIoL"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35179d0747fso306968eec.1
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=aAV/fX5Ttl58VuhmiLRWtphg87TOalofNeVT5fQqzKPe3XfKvotU8qEDVsntspeOoO
         BNMFFw4dQs2gjmoH6Nax2rkLqVX2Wd3lV5Zm9EBnJS+YQr1zz4Bdr04ph4NDAlgC5YBL
         4iYlDhBSwVtkJDwisTUmgQbWlEYGdOwMl1r4MDXNiTGelA7m8ZIYoFH0gnG9gfbv60ly
         AEbJjPlLvs4JPkaFgKL2lA6mBbW4GQaym/qsT3NmoB7bc9JqH/XLeCZWwZegTuDHZylF
         dsqLzEJNdWPr/g0mh6cPSsHgyaKkNvdJ5/j5Q2wvCs4h6+voBxCYCcV0k1njYHftY28w
         +QqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=U1vI/yMpIWhaWEmH1PXY5SoVvrYcMiYGBjn4yQD7Yck=;
        b=W77Z+mtnvU7p9kbPWK6a1CSojAg2rd2nxDnyMqFTYvwvhzwhQeMVySpkovsr50o3gY
         Oi09oeBD/mbd03Jak7i+QHrmwovyVZcUo7Fxv3/6o2XSLntxOz3WVUM+kuTIteCNjwET
         rIh0c6DuyIHmsd0jn6RbRPyMyu6cFrwuLF0jP+x2qKsiDVwQ9oK/DWK90tv1pqCyVo1O
         qi2pFmF2EZ6VCZ+pufVwW+mDva1Lt5RWelWdXhMPT8ioxhDmaY62nZtHq2rEbXRv7JJ4
         eReTzv1W0Jn+dvOEZWVcExbeX4gXWcI/5y+zerg98BIlqORfElmCBr/kU0Wt8x8+/8dg
         6B7w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=SLbPmIoLauM1g8rEXO7a+x+nNVHrDaZgKcHl6ue405vowb/MnJ5zaXEmtCizeCPpbq
         2vMzWDo3Gg+bIVKxZQr9u+O4X9oxi7JIr3iJlGG0RH6OQDmN/zKQweSXoR2fqVgDgABO
         CVo0sZO0YQdXbzKYy566UQXdcOL5EnU2eL6bxGJl5t9xeZ7vH2Bu40IOu9wBorkOVVnl
         reur63f9XcBgwUABd4IS2VqgaWIig9qTPdx+AQZ3/N/rrAJn0X8PvFJrY83CYTO9xVxX
         wY3MyJX90m4WBvId2WpRBNFCFCQ1xEC4EBxrfDoN56t170MYuo01X3TJ59B3Nw8SSH3h
         WB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=uoVF4w/dyYdBrtV44D0b6in1r2SjFMeZk9ho9QczmtjpEKOcP6z0hA/uZ6M5koGrtB
         NaS5OgEzoxa9fc/UQj73P7l3lckaYj2bR6dzrc82YkT2YH1R+Q6UgXLuzdSq036o2RtH
         VNOUinjts1jOxGWHKAS4FPgjCY4XJDBfDyHyqiinStsD4soI8bPj90C3MvmiKyo9jeIz
         mr7CAo+0oJ7UQ+N+GlLDmoN01DXpXcL/qVPp4+hsVc3fo7VIWqfi58jBqZnu03sGHQNp
         dJ/5rDonjrZYFk8IEawirLNoTscaLppv/3Lw9w2Q22nijURoW65/pvJz5HsnXBBDKxQ5
         cOEA==
X-Forwarded-Encrypted: i=1; AKwUvByohC8iAbW9rTPfK8KtMPYx9l31vPGKTJOu/oqlQiBs72c/wecPlQXxj3Cg2eGUmuBzghEt@lists.linux.dev
X-Gm-Message-State: AFq9FYLBTTdCiX3cg1mrodAcrI+45vum3QCp10qR1wq9KyWkzMUP4Z/I
	ghpokZhln3T/eSrcfRCf3UIsFeQ21Q47rsb3IagOIHN+CL7uPoO9wp1Sug0FplrSLDeqfqjplXV
	aLpli0fAiM8tSJuG6glxzjlqc63fIDyU=
X-Gm-Gg: AYBFou2GCA65ZdFzsIiH3+zWbUOY6IAiy0D7rbDswvMN+0ZfmV5nWsSKqPzmjYKs8H7
	h65zjFnmoW94Xcf/43zr01sbFit6tiZb7ui2+bfNB2hU0h2i8ybS5TMUl2Uaqc/ao+9MQH8YRLo
	ZH1hW7UDcBZOBhKCMSfVbM2wDrj4U7rqYUbp+GMcObhK2BCZ9PIRMd6bRzPtQ5mevdd+mzkuFF6
	8pXZJESM8NDnqgPRA+MR/UfXbRvEMfVljzsCwORwsO3Pvx1Kji3vduOECbznDkU3uVTBMwX3F5d
	Z+6pEsCLdw6yGXkjsAi1RqH03yeLgLYXLDRLXNBFCxfA1OYvPoRrjiSci64+CNCPIN5et9IwkfJ
	DsIfS30RvTqkZg2AH843/IkQApGhmjtMkM51bz5l6e5T/77RKyHq1oTKh35+TpK1M/QFXVKyCFA
	nUY1Nk5geFAX1Zsk2GvDFHirJwDjfQvcjJBZ+XOJORr6PDcU54CLM=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
