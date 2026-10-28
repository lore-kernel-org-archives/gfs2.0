Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187551;
	b=YtQQ8uNjackVtli2lYLUfoJ3h0f92m1j06WFZWva1tpst0FuEcmUZNd9lhp5UtjzLdsN
	 jg2JOUuhWW7V13/4U5bCnlj9OCw9CwWEMrWldnEkLTqoiIsz6NZ7u5hrKRNhSxY8ZiPf8
	 oaD9kgTH1I4cAZnc+TuNkRqSL3f+YOcomAOqfnW9dTX1XYB+HHvgTXnOk7vcqJCrkw3e2
	 xrRbKFafDq4W1giVi3u+9nybSDA0+n2dwy8ty2Q58ib0+jGsPxF+fEACBY0SPeor16U0X
	 7iqXfMfv2caXE6W8KWtGpVwPugaeQWgvvrbSU6RFBbifp1Vu9SOLy0D4tAM61+Js4bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187551;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sOScShlNJOoFQgumDsqaC2sVgmpV4+y6Yzg+EW5P6X4=;
	b=glEZZGvMEws+CI7aEN0yVZ8xLDWCbfXoMkh3ztBpq1XCNxoKZ8Xjn4rOf1xkqezh2mTc
	 D3nRSFp8ZKwb1J8PqU+rjBY2GbSH8W/CnMhrYPdyuIWT4CoPIXFdaoFZwtWqY9lIShi9p
	 7A8YDRNDx182HmTNpzF8LD8oUa5GvggjqTm62IPb8WbvdWuTWRlaYK+hyVlI7AaD8JWOa
	 Cgu/JCZH1H9Ltpu++kySVvXo8JoRCQYmzFH3ZGxMnKMIJPzOkkoURZi+aS/lx+W9DqFaa
	 CQElHcLwsJ0v/cggBAjOwG0Yh6ZiDGEg5ZT9xqam1RzHo5D7+zHR0WIzbK3ZjS9yGbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3aBNqqF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E11606A31A
	for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3aBNqqF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C4C1F01829
	for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187550;
	bh=sOScShlNJOoFQgumDsqaC2sVgmpV4+y6Yzg+EW5P6X4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V3aBNqqFFHK8/iCpvfjUC4nqv71d4gzLapwxCef4YXC24PEvK5vHB+xdOeL7szLll
	 P+FI7kOVX15iyVgW6L5BqB5j66cUsU58EFNBVc4ed1gRumoqiCbC4e+4/fMtoPPsBi
	 389uKh3znOcDxhFOO4xeIVuJHUWRavRXaxLHJn2UManYPCHBMECjV9wAGJYHfg7uRm
	 oE9BZ712DtB2yvqohWmRmnKolH9LeojudIZ3GAkE5g2bjpf6/E/ujmhxw0Acr5Ue7J
	 /SryS8fSPLV7LahdfJR0nny8tZNZQ0l6lyXB4kclXqeLy9UOpL1SeAi4UciWGJrnY9
	 J8Z5+YeM8O4VQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso903750e87.1
        for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 04:39:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwbDGq02nM923KHXszj4ZkJRmGhrmhlYoW97tpmaDlu0L2CDct9QEc+3giDjFHXAvHDR2pv@lists.linux.dev
X-Gm-Message-State: AFq9FYIIi8UjeQSsC+QZnokX5hQyi4S9s07d103AlL5MO8mLbWYbUiUV
	3wpGBVf3l+3LsViZLrXvTrIRD8n1/m1CtSZ0RhU4202DcLs0gMn8TSIKxgQUbhT/RXzGPaKeldP
	CTb8NGA19vzVrJg33g4JFTZpHIZK0bM8=
X-Received: by 2002:a05:6512:1111:b0:5b9:6603:d451 with SMTP id
 2adb3069b0e04-5bfcad31c8emr697328e87.3.1793187548999; Wed, 28 Oct 2026
 04:39:08 -0700 (PDT)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
In-Reply-To: <20261027223847.652884-5-irogers@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 12:38:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
X-Gm-Features: AclHuK-NXF3tWCMDzaNjIN417c7ZMuQGYjVHoQ_x6BSITeW_KdKoI_jbnClXt6k
Message-ID: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> in the ondemand and conservative governors so their gov_attr_set
> kobjects have a valid release callback statically initialized, matching
> cpufreq_governor_dbs. Remove the redundant runtime assignment in
> cpufreq_dbs_governor_init().
>
> This prepares for annotating struct kobj_type::release with
> __must_init.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Do you want stuff to be picked up by maintainers, or do you want to
route it yourself?

> ---
>  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
>  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
>  drivers/cpufreq/cpufreq_governor.h     | 1 +
>  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
>  4 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpu=
freq_conservative.c
> index 02bfd46543e9..146a2353b1a2 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
>
>  static struct dbs_governor cs_governor =3D {
>         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -       .kobj_type =3D { .default_groups =3D cs_groups },
> +       .kobj_type =3D {
> +               .release =3D cpufreq_dbs_data_release,
> +               .default_groups =3D cs_groups,
> +       },
>         .gov_dbs_update =3D cs_dbs_update,
>         .alloc =3D cs_alloc,
>         .free =3D cs_free,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index f3bd3dbe7c41..f8b5aca09b6b 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_in=
fo *policy_dbs,
>         gov->free(policy_dbs);
>  }
>
> -static void cpufreq_dbs_data_release(struct kobject *kobj)
> +void cpufreq_dbs_data_release(struct kobject *kobj)
>  {
>         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj));
>         struct dbs_governor *gov =3D dbs_data->gov;
> @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *=
kobj)
>         gov->exit(dbs_data);
>         kfree(dbs_data);
>  }
> +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
>
>  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  {
> @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *=
policy)
>         policy->governor_data =3D policy_dbs;
>
>         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
>         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj=
_type,
>                                    get_governor_parent_kobj(policy),
>                                    "%s", gov->gov.name);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq=
_governor.h
> index 806d8fb4dff1..1026712bb79b 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(st=
ruct cpufreq_policy *policy
>  }
>
>  /* Governor callback routines */
> +void cpufreq_dbs_data_release(struct kobject *kobj);
>  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
>  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
>  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index 9942dbb38dae..7386d043c665 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
>
>  static struct dbs_governor od_dbs_gov =3D {
>         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -       .kobj_type =3D { .default_groups =3D od_groups },
> +       .kobj_type =3D {
> +               .release =3D cpufreq_dbs_data_release,
> +               .default_groups =3D od_groups,
> +       },
>         .gov_dbs_update =3D od_dbs_update,
>         .alloc =3D od_alloc,
>         .free =3D od_free,
> --
> 2.56.0.313.g2479322e68-goog
>
>
