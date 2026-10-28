Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201766;
	b=iapeeiXBLmEu3RIc3q7MBVLMA66BlT4EChi8snC2NrsCLkNclP476Vwi4/ERozjxnK3Y
	 1040iqzyylXMb4VJYP1+URLMcr/dDO9Q412ltN9smEh+l97bEyD7nEZB3V1vPFIvpvwC6
	 uEMSwONCO/lr2pMpWCFlGGEzYrm6suxrlWOoAHIAA1VVm5xYy5CSMEALyFLmyEXsLtHtg
	 y9eWIV14bzdk9pmS0xDB+uiyy3M8NxDvjxI72GejBgSKRqoV2nXLKfkYM7LwGIhCS41qG
	 Adysaf16e3JkoBKB5WAJLJJJ9WPySjWzrVrz+pxisOChsljT6ywrOLKq4Z9uoFpMj8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=ZYCF4ETt6LT+4v2GZ46rdKJ9kTfggsfEFHUFOWiz1HEeHv4+TJxaJSjyfl/WCgyosP4l
	 fUt8T329NRsiDrxposCsw70sQ9CDmQ7NOj3OwxIWXP6ZoS/0PapuYAUcvOdh3rA9q9zcb
	 9nWzMkSlwhONwiwu8EM10dPfge17chNEP2O0ri9FPFJ1nuFua8tUOHKTc3Tu19E48MC8J
	 9+cXdw+Rwspb/TdfRoopMkB0ImWl8x2yoyAL/19izTer2L8obOcTxjLESFXF7upBVx3QU
	 kTiCq5yGKAuSSXtYznkrpjfli+q/TXsdpVqCIEYbmPlv8zOAdQQnzKf93wAQ9LILIcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mf9SYFED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192EE606A321
	for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 15:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192EE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mf9SYFED
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-533202fe429so405261cf.0
        for <gfs2@lists.linux.dev>; Wed, 28 Oct 2026 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=Luq/1aewe1ZdGZmhtFe/pvN75DPPY0qdCMOiBZ+VoUZM/r57En5soNzJ4s3domrKbx
         T44W4wjPbUnyLU+dSgMPOxfNH13v0RqOGhBWJ5hWuzPUVRO6UYz7LfjEcRuxKyuNYDTC
         IvNjkdSFAq4TDUMDlXCxL66bOHZ90DnYyq7lhNix+Mt8UspMquxY1ay0nYWDfF1eiBcT
         SbHEF/NQXgAAH5HuQwt5EoVpgBiuzD5ktleQ8ousBxKuNwt7/2WprtrNk2KGTTWMr5iR
         IemP5W3GsAy9JaZEE5l/9q/4XsIl55SHTHOUVacgdptBpLv7Qrjy3R2uxg7FBR97aSWg
         dH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=8/VOgOIWFcN8YpWXEYIcOIw9Kn869SWHrfTQaT6jKT0=;
        b=STtd6pRTnJWJexNw/vUbbIjbevO8Fy3q1jBV5e+7NyWN6olBVSPnE5ijkOKyN5Dcrv
         VbqCpkwaKwmTTR98IHTXwoPC9XiaLnaGSMPfGX5Oeyr7Gc9zSqHowFERfSmfoXgiBGCg
         +wVhXmHbElotwDGANp3DDpF23QcInIDmAS9/uHKdxgiXY9f3j3HbGTzStLBE0ns3S7TV
         xFTi47kRq1wX/o97HWz38Z7cqpQbDbkhR2yeJzaDBlkg3TT/gfPxRLdArLbf5d/w7qSu
         nfOvCbreWhuyyJ6+48b9xYr2S5bOffsBiu57Cydlf/7uouCBNJkaK2yYQmRAa/jkv6xH
         IVWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=mf9SYFEDsXe9OqSwn09J5QZmBcn15LkHHvtkbfQliSti2e7W19ryef2jG3RkdgBwhI
         IwTjmnxuhDYN+t8bF2Vp5uN2WFqUEyK/rVLKx3VAusaUnJnRl2Ld8KtpwOsQ1lwp0onn
         aLHNtHGVY4EDlwcBMg0jFTAF4129pXjmNmFpxlpG9bV7lvFnEyycQZCvLbVBMOFNMQv2
         1qP8AF71HV61oaAbnYCwFdE+xSTiFYqdqjZZCOcIIfp6jgFGpiCItGna6P6IBA5zyvj8
         gO0liO8+lmOdqMjO7/FIXUCF0nbjWzkQl+TysWuAxtnpf2brbw5BqDTNBZ3YDRsu43Mh
         KPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=pisDb3asZdGIdJflddRDf6iDJQ048TCXXT3mw3vqavxh2s2rMoxFIgOuhumXwvT0OS
         NZCOxClppFykIaHT9e4V6BZtWxBZZpgt3q531iueVDkos5rw/eA7jvFP24pcaTUmbJze
         hsowJYMpKTU96oKZq5PZrusGrhEb+zkadXHCuCiKVdC2PsF/T2MGT/UUNmbTBUNr05dw
         mjVDARC02g0HeXnGayfW9zRnjofWE/35KOcyW5Nc4KxR/CaJkb1U3/jHq0QIe1qFhfsM
         HaPsG4wQ8kNynMG0ppzrZnl2q2BjJV9z7vEWiEwZuAEfh8BtWuZJHDeIhA0C5XCgRMQu
         SQog==
X-Forwarded-Encrypted: i=1; AKwUvBxbpQYuiNuwsEo+Rjadg/6L6GY8jiDswrI4MekLtiZtEPE073FHjtZfqhycrZZRzg5P0huk@lists.linux.dev
X-Gm-Message-State: AFq9FYLIeAZaoky8pRECbKDOZGcdkJdlGqNzlSWyjBYMqHGn0Dq4BCwG
	ZRnjuZLxT2hr8QPEFmRqV1ozsGlwTKiDUhxUsv/8TEe6ZgUAHx0BkVHTGdMyjaxefdgM5ghX+hF
	trODIgDzSrmETg+E4hnV43Fh/askvUf5Ih32t3N/x
X-Gm-Gg: AYBFou3ZZknVKCugy9kneC25U0RJu7xeV71OGd7Yr3i1WjElHks3hCKkHzY8ECp9hkx
	3jZ5JFoYJpUdrh5kCMExRHAb57e4jKNTQU3+9ylM7/qfQjbISJKJz/JeyPPsebzXqi3Q39xZ7HL
	qMchCu4Q6UZ15hSHZcsEyyMTdG4MEi9+pO1DSguY3MqDu4W59zC8TUl+SciUsXSoJjuRTxathiI
	ezbEZZ+OQADMRK/ehn8QtYbbBqhMz/eTMz8QC+oil4WaoyjD+2lGLKAFn4/cMoYArvtUBaQHWly
	v0HBJukRMQvPyqUPaMB/oXAk47QQjEnV2ylBqgdnYwNW5ydrRuQlPBJbPQgePIRLW0irmbmDWcL
	mlihqYrKyMxfwIk1ZtWmCybetSc4RAapaF2HQD52kYAUJ76VVKy0IrDjz8h8=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
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
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
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

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
