Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263410;
	b=Mft6khh7ex73fGJkVWXtlbvLCqisZPLS8gm29Z/PqiPqtEetl3KrZFefKyHk7gpSJ8PE
	 lNxvlwfvnukRqdyECx5W9uCY1Q9FrGxn5NDdU7+Wu+RwIIyXgYReWqh6eSSVH34A6g5Rg
	 nmBRt+aigo3nL0scmlHoypp5GlkpasAdUwCor7HoTvKhskP57F0CC5vYwGcNLUUvifrvP
	 hw+rb4eON6IH85imN26i+Zs9RlsFXO7L5IrO8dVLki6P6PsvUoxgM52tQTBghoa7jFV1W
	 zPgqbVkd6RO6o94cj1XXk0inpSMKySsmW3Wm6kyfnr66nVOGCyX2XNWnT0yqMaTpbUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=C6kbgscWichXiUV7rK4fpOgCxUgohoJ2uG7uAPo0qUj9u8JM5hkoAIejYi9dGtxPhCHC
	 4RyrkGnYwpd8GFJdEwTyz9oPZiOlpaIiSy0sfXAQrrSjlvjeV2y3/ipiPHoAsd19r3IFW
	 NkcCeFzMI9PrxE8S7idcWEQSj42YpxEya4+QiKAdgSQIVNiuIjBUvxZHlGHDBfBW+F/0K
	 mxH9bSAUc2cx2ADUM6cQvm8Qh82hAba88zhQ20rrbHBtI0MMRe3ZwI+ofmhtqHWNFeLE9
	 S0xem0CpxxyEKTWrfejaSGHBUCQpoe65uDEPOjep5tiekk3lM3KEODdJM7ujZFrb3Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZP90t9oh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA31606A336
	for <gfs2@lists.linux.dev>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA31606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZP90t9oh
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so33401cf.0
        for <gfs2@lists.linux.dev>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=NYknYNbN1R3EtURiwTbR2FXxA7qaaWkBKTkljHj+n4f3QK7wZct2hRMfyqtLNWJJcI
         Ogw2eUkiZtyy5oKKe45CL6BiWzqmF1wN/iGCPJnJ+sa+WCUJDFSzHyAK9hJnDCSp2ZC/
         /+tkDwqnHhCe9rRlvpO8r/Q4mL3stZ/EuMPOjthzEMUmrwiKfkryixWwzP3J2FbbXkXA
         ORV7oVOniDxdk46gnHwt5Bb618wg5e0BNs2zqymBwP7ZSUR41ReG+XNA4l5kp3F5sqGb
         eQJRBUckrj19mDPwc1BEv/RlzXl1b4oDaXiUMi+HBKZqG3oMigWn/OHVbNS0qMHt4lzA
         M8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=OyBh2iBD5E+xS672ly1YlQ6nMGXekJsKbPVA/Xa/+a4=;
        b=RWc+eQNSD5AnWdufM1Fa26eMT3pwhgy5IJR4UU0GR+Uch/hNTSlwbSSYMoRUh4ewI8
         aVuOJS/XbWlVaQPCTN/yfmkoszTjuR4kFpMnR6ltUDj4sR++XOiFZ1+/BLJ4/9XrZtYP
         okkDQj4czzM+QQYcFYdV3WCJVG9H83tZAQKENGpqVDAk5FU5KcRaHtoYwt1d8KbLmILH
         t2L/TyauJJYq0rh05bdDEl5chpnNJjLTvuj9c7WDOKZRuiJSpknK19Yyx2m0m6uYl2Yd
         jcrm5wsjYuDNGuikSjhiioqfzqCkYFNoT/gGnV0qHw9Rt1PQmu06EHrPXMBvQApXhQ9K
         yVeQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=ZP90t9ohYibqkOp9Ohy3ox8XtEh149CAjReevbDrcEGSs7rdWPli/f26c+TCc2ar41
         7Po2ccGGcka/LYJu71k+QmIf6Vrutw7FTWWW6EZUryewggAsDLhDDbw/HbTJUBioynma
         weamWxMNU3YSowEX3kJlnQKFzpR8zFsHVd8fgvlEcSez5YHCYTwJ51HUIyZO0Ilh32Z6
         HnMHgvWtg4zv7yPqxqutPGfmtCobQFKY/NbtrPbG+NXWqLRwcVqCPyToE1w8Gedy7Jkc
         dmLUY6g06mye5MECRaC+ZFebseRoVBGZxEX8ESPvlox5eHTAQSdv/41DIFfNTEaEQTbB
         OT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=zl+FJG4KYBBZ5rvDRQoAnlD+AAF2ofKKxw6W5MbFtsLu8e+Viv+8lN0QtO5wVP+Bj0
         L5qtO9RAbUZhmJUO4wJy4BeEhvwZpQgmAp4X2hClI4h6y+c2J5HBGzMylMUgXg6ChX//
         QmvMg+Ns58+zIAX78xxDZFmUyZ2JfS99cZRFe2Ps34QqDREJ+FU7SwSlFlw6W3W/OVVC
         HtoUPCEHA0P/vYjjAhwKqL5p3Jtv+Dgnhq73Xk4lpBU0wSVY9d7HR7y2LlYsRJXt6c3s
         182jmNEfLqxFjTDmZen1rpwoPnprIuUtc3fDW45ItxohQiAyNbujdlUwfttDsOoUp38H
         hZuA==
X-Forwarded-Encrypted: i=1; AL+hErEjtpjskGUAjTjHEXgP3Vrd//ygfb7V9eikzNaQjaSNT91xfTsMIJc5+p5BnWItO/AC1s4m@lists.linux.dev
X-Gm-Message-State: APuU4Z8lHkOL0aVo+HJm30eSWsnFOf20Uwtw1z+bThVk2rCdRmwoQO7y
	M6bfFJ4Ax8KDH69lyfeLEsfH5pjq8cQqq1PCKyq5UT3WZI09rUy5ynqEsTn2FFuYLwai1sHk+Yx
	yxqFYCnLWRxRt3bpaRixwfqgCZG7fxLB54/5cD3HQ
X-Gm-Gg: AYBFou0mvOj39vEmLhAXGkczuRe8tL7Ikt9lSqxagXiYL86IQwcOld0zsOU3t9wkUb+
	L/K+nj99fg2MbJ6w8E2BMWK7NLgGGLfqUaZQABX686QMIXFyl2D1O4HCnGz5shyJJN059J+hnao
	zmDxMDQoPqfrTbg9/7xXhg+0sYRFH1uDQ2vs5dAWJ9iLMBOAZT7gZfalgRWfp4xclaC936lN1Nm
	aDhGEOG+S9b95A/qcITbczS8/YRvaf5ukCaeTMdTq52c4tRuao2rtVV8cr6YjSMtZ7Ecvu2dLWE
	ob65Hpm7BHv+NdopWMK7UyrLvKFEsprsuNiFRz65T0VW5NphnGVn1GeCza7WVDKNFHhf/9b6p/1
	gjJtc0gg48+iN91u0oeRNB2Dps9JZ1jv5X0zNPGN7yAZPltoGG8GDtM+3RdZD4UN9MkQ=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
