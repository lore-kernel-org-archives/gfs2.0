Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C285616A9
	for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996101; cv=pass; b=b1sP/cxlT4FYxGqDGrtvnyiDY2JqK5UbnU27/fUIG2hc66NlwBTKlBbKt0NBtDNNSpN7npIrcM7DXxQR8yKh1mp4JHG9kioHJsvXF9lnqgEYiwZNqxq8rQr1FQWyYfSa6xIrOWBOMynqCac6eG8iIhlwlbfTBZS5wB0TMR1aPqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996101; c=relaxed/simple;
	bh=3mwSDPTFjJGkaatL1Lo6Mh8o6JdUk3CgZRH07sGguXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5lta3BKxoD45/kdQhjnfNzBF079UCz3i5kQw2R9bnvBNvKtoRinI84Le0IuKOlXJHQuCmOBTG+MpUiWKSI2bnDRzvkQCr6H2E9ebpxEF1L3c/FFKOClD1FARVglSRnXMwgqBp0VNxd/1VxFdElWe6gnNBeEm5j11dRS8W6L3ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ly1skk7c; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly1skk7c"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-535f598d126so605781cf.1
        for <gfs2@lists.linux.dev>; Wed, 14 Oct 2026 09:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996098; cv=none;
        d=google.com; s=arc-20260327;
        b=HOsclXXKlVcn7Sl8O8TQ4pMS/DKJ/MM6J5M1wCu3X0ZEmBuiXxTGcMocIYj1pyrSn0
         ut1i/4ReMahnEaZ15fbBXdRzFndg+S+Gc3rvfOyl6yeUnYwxj+voNCulLZK7nYZ/DlaT
         ez+jkGR4wRcj64KAD0b69B5OSR4J3uGT8kYoMuQ/styUItZsx65w+mN0kV3EcWZR+3wN
         5Kv9th80q5aYdlpZze1aq/dVUlW7xytboIwEZDnoICNrbHFBkNkz1Ca2Okpa3Tty3dJB
         /8G0qAxJPfD97H38vmt74yLDzLolFKNCPuD+RdLXVyZSKRvsclGS1U1m8ZGwHdPWrhif
         pF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        fh=e1Riu2hnaP4jnWNvLoeBFWBr6PaZDUvF2MicKSAK8Oc=;
        b=co868JxuZ2LLxvw0m/uahinP6NsR0llrxlSJvIDY0a8D6QH0ZDab26qlyNWCnAyw/I
         PcL6kUFqQLny354SYOvw3jBb6gth5W8VTJvPmkCit5vRfDEA3gnD1eJwUpBko0PIaLbc
         odt+9/9wZjnXdgDRvhaD5ed9EmQwOgPP2w5HIGyIlfcO3QRSPUSqOXhXY25ea1vsjC5O
         r4MGwO1JGwPsZAs5cm8H2kIRBeRLHvuk0adCqtKXGBqQiMLrUtvPV5l0pquIdVP0AWby
         SGq1omWtC5O4UUQZzmkNr1PUDcqF/5UBc92Tp8VV/iJFwSOrlpBJ5gLH+KDLLFnHVXSo
         U4HQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996098; x=1792600898; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=ly1skk7c4C5vtGV3cbo6BSQX4GNtmVPw0XKFFqv41FTNFWMCFyrmg2Fyxjf3VThmPR
         pgyjJocF+SdPMjLhEDzXX/DDorCTBQsIS2ld+8NZjNXG+cRbdk4M6Ggj/0MU6t2h/PmA
         lQmvSRlD7VjLpdXiOr9pQ7pI4sgy8yw8mFD6GPYaUs0E32YXG/7gxYXYiqFmB+ui1z9L
         1piWxiV7AIaycSJxubTi0hrzY05OL6MVX/vqIn36SCETJ/PVIiVcGFu3jZcl/m1ACgxH
         SRF9A62AY75MB2EGWgs4H7zxDhJHLXn5obq4bDg5/XAw6UJGguMcbYmdZqq47IWcvHXU
         meeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996098; x=1792600898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=Wk2eV3FJHM0p+ArbivfMmdK1d7leaPw+U8F5f0z6LX4tKyDOGyDjRLHlTdOoL7ST0B
         SqF27WpYxv+YTPazumGP10sfOYAce1Hdge/J496fdBK26HrbxTHaUUS5mR5KTvTkKywH
         qTzaCHTt779Z4GfofwYWj9JcO/QqNEjytceUDqQEvxkmFpxCM4DwaIhf+ay/s2Dnl7vr
         RfLZx8cPqMxY9sgBppYndTL1/bcNt1bfQZVlniFiWIwiJTRPfRZci5GTyy1wy//ilMa9
         tfJ97J2hR132PG7SzAexLf+9prmfgYGQoJbmTJgRF14oxTquuLWyXscumRYh88DnUDoN
         NMeg==
X-Forwarded-Encrypted: i=1; AKwUvByus2Cj84PXfgh4SUVM59P9+fjizIQhwEIVtQYyFq2iazt2z2f118lACJhD8N3cQHucQIh0@lists.linux.dev
X-Gm-Message-State: AFq9FYLLdxmcAWdvUYhvWsgne8FMcMR0f+xKRzUcF3q8x+Ueti99dd4W
	AazLrOoz1GdrIZmddu5t6fgcYFLHUaIw6CBc768SB/21fxXrT4kaOIFWjhMiNYaAep1/TWOlDcm
	0UfG+VH3eveRU0AktnzadwpxW+PY1dM3C48S0r96R
X-Gm-Gg: AYBFou26xLzph6CjvI90dDeVBlfxsq7hy3LmvTH+J1v2ZzK4PFl8Q2mW1G6n8TKukQA
	To6F9wrfFJobuE8/hMRLkt8hgkpK/3XS5eO/rKIpszBw3mvjXX2+TTwf4r3rtpA9GzHDxtQvICx
	XCiA5DZaTcphV7OR9rtYuLH9MdpK1Cr2bkEqJTX+COQtRJSar1UD5uWH/KJUjgZd3Awl+3ozxfY
	dZbf+8D6xyv1+z1Xot48VP4HzjIDxsU0oLs7O50kLSgRQBhkCVL0Yi+ahLPNmom5ZKW3+RvMPNH
	lLhhkJYGFBX3ODBX2gPUmPwVvTA0aaQ9eXP68yTLUj2MqZbFWKWzVRzzBLm8UPA6i2WNrJBGF0p
	KhVmWum5CZA==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook
