Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067159;
	b=V1ubF/1PjHcNUGlVWiQm+oQVmMzEf5Q9eIF3A3uGp/1uGYrjh3njq0D3lfJYJll2tOKU
	 tUq8nXPWrqDgKzFGZploeQZPwkrKjxNK9mDhaBRbe00/aJaWkqjNMhzceZ4qzh0NMdcaM
	 l4+S5JNglzYr1Zlzb1x1X7Bb5dw96YZL3BSs8x4WRApfbpOKHIqUo7bqMd0CUhXqN6lq1
	 irBn4gD0HSz7ngdkSBkh3PxTonuFQ+lzAZav/Al4mb35Y64KhNm5C2s88I+sGyn7KNjXR
	 8viDjcTvMnDCY1Ql25g+WWwhShE9wqkPeWUa/SkG4pOUDzjNTnmqiLPLSvfmbyUw3RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=So1WyqnL7WMZheN2PSrv3oeU+g6jxvyWOryNNOvN7xJxj31A8+sXHJ4hFY5lQJEHb7yv
	 pWvhgF1gTwYvMv6GKXtA7Zvg4z1scyUxkAiujhIsF/AeYUNDBLqNrwIhx5Qybfjt9GDGU
	 XWt13Ud1Qcjy5OHd6aGu4rvZX68wrIL16EubC1IgA3ifg/K7Uv5uymffbOM+g06rHFKFW
	 SY/VXgsRCYemHAI7I3Bai5x+A9E4HU1ZbZ6jzrpK3xwVJ7bPyKiaP6Jy7FY1gQFtMmVks
	 5c+ufah6qn4se0IYraefGfdxccQAblBhoxsnpc56wrG/CVm0zOhbDxce+maojfamDfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMxj3yB0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B9606A332
	for <gfs2@lists.linux.dev>; Thu, 19 Nov 2026 05:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 168B9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMxj3yB0
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so171501cf.0
        for <gfs2@lists.linux.dev>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=e2QsiTASC2Szii2USsy4r8a5zfe6OulNqXl22BFv1UFoBHtlQAvA13vX6RvqzESlPk
         Qeu132xpC45VXv9kDmzgVMMZ2wu4VsUMD9nhHIi5pV4GQqs+eJyaprMN42F3rYwwu483
         lVEBuVLWXBZlsuarSbbzVcrRVJiNsuXF94mHI1RMlL5eL9av3wuBucKLhlHFxUmh7doH
         JuqDFzmAUOEPpRH4r/QRcIhLrtnSGqvKzegSo/F+syxjsr1GluhfDqEBP5OTVzc9TZGp
         U6G/kj+IZtuysJ8gi0lFgpx7GakwX3PbXuWYrWL8Y7YvZr+swVD2lV//FAGwT23YfMdG
         TTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=HhJos9OepL/yP0nSlh+Q9Wtj7piaJCYzuiop7+Mf6So=;
        b=jav9Oz/W26OCg8jDKSf5Z6lp0Lh2P1GOAtuxu1fC+O+xXotIos2AlGieOP2FCiFic/
         3EFgz1F0K3TM8nitC3u52Zx7FDAcWOeKdHUyY6o5G+qgPeQqm5ARBkNoZIKS9iMhBHbW
         xfZWMRSnfM6MmslPdp51LVHq7UUW1nWzEHMkwBaBBrVqodZf6cmA8lhPrewEMTeTSWNN
         xxpuFMah6ak67Q1eugSYRdscXCj7ff6Q083Z7M7wxqxNTKXqUk68x85jxG5t9n+DTArb
         Qx213WqrRR/w1+vQHY1iSjqowjZzINpUuZ8AZu/mo0H/iKq2jUT+oU3dAJyiCT7TMhpL
         ybJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=JMxj3yB0SeAUHokTprfYVnrnmnS+Nxo3cczjmq3QQAOfFY6+gBYpfkzGSioGQ8MaaT
         9TcLPVQlTiiyLAcy5HbYgpaobHdwB4yb0nz9em2z5oxEKeLyVSIRtRD7ghLlVQDpESVp
         lbR5yGUGthueo8blACsDc54Ri2ML+0/lKnEgpTq7abthTw2uTpTi3VjzqOC/LMOvbPLc
         vbAjnK8Dp4ACS3bC2jUL8Yqi9Ak/QCMLL97O8cXzJ9g0FkzKoTefmYLT07Vmdfj/nSgt
         nTrKFZhlhf77LIKhdWcpjHZB9XGzJHjtgon1nmhQ5YDlKWjMjgcw0gIACUFXFgewRZLP
         Kgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=xacR/O1HA195PKjVZZienTBSJ4pndiVePBIPMsSjmqrJqE26sjCb42N8RuhKpQi+5C
         3JacFWw54h4gHJcYqX8wawb/iR3TNSy0JeM/z9YER4XcgkCrTx6OLaHOiv3EkoF8hjpq
         mVzrisJ9WuxN+TOelvR+maSyQpvvtf4LE6oGYYYRtlbUnvQ7tLHej50tHfLAt6ZQBko7
         StSx2o3nUAQYV0m5K/dJA7z32L4RJwHc5q2+RY+H0lVL/LnygddDeM49G3g3Blum5kPg
         hvxz7ytlaHIrTvCawiPBmK5rhZqcDP6t/Ytec0Dqq8fIxk1Ty/7O1dGVztLKYrLas7Ue
         7MyA==
X-Forwarded-Encrypted: i=1; AL+hErGpEkasy/3bolBhnmATl5YkrzalCUjXnDSulPKHtCoAIm7IIsPBhZAyyvUeahsr3bc6dkK4@lists.linux.dev
X-Gm-Message-State: APuU4Z/v4BeRzEByB1SL9U7ciGBiAFd/+Ym7NbyajDIDrv5XySe1cHFs
	0zSowsA9D0nBusspS36oDF2/Ql2aV9GBUQ7LO6yT1yeJR3/M8fn+bqp24aZGClVpfy76oYQvNxM
	6nszeX5Ipb0J/mwH/0pFVjpgR+S/jcGZarbu1z4Qy
X-Gm-Gg: AYBFou2gqSDh73KQM6OiUMxkWRpqiUpxNuoD63EmCALtNi1qaFy/9yW650oE54mu3Zp
	yc2tg72blMEnefhrbYPj2rgX2e+98THWq9f8QKpZbGYl3w+TOw1k9U6EF3mWgtApwYHBLdgGr8D
	MtPO/N2bSV0eVBmWLEjRO08z8BD5EiYRGGEUwvZAtuMZayjpXqBrWQdUILrmZLnL+uKf04U5jVt
	Hxl1ZPx1hrdis7miehMaXZU7bnP28NqxhL3nCMguHZDL7G0W6OgmxDiqcn4zDci9Seut47Qs6/N
	q+5vmjC1Ne+Ftr8MmZ0p7O44axKem+6QpQABVtINvX/njacotIlqC6g0kkYdBNcekRp/iE01vqm
	SavAwTlr9RISxZ69PcdDDkgX0g1YcFtIApA0R
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
