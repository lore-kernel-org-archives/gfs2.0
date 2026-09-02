Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FD360EEE
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369248; cv=none; b=mh0V6fzGwhjQpea8Mo87XgQBSN5PROA/gNyXiFEfvETIZvL7pHxwdlTnBt8U8To0jiumluFpnAm11twmWh+nHFKMsTNwQbH+WcbijQVYbGwkZxMl3amfV6nHPoCNFIv2U6EnFziDhbh97Sw8SCJIK42Ocox2jRgfcQX8VlirJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369248; c=relaxed/simple;
	bh=bfwhI9OAjh47z36flVQbjtzP7R5e2cBnzT6QQOuAGWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZFQu/vyqEEDeXJvnxEuyHSvQEAZXTNOksrkVfLA4ADIia2PTDfQXyDyn3oo4GLHspW9V7zCvzrFH1GqaWcwvSJYsUrEeyfIjazivG1N5vIm+qydQnnFFSo+2y6HfOkr05Rr1rjvNFB0+FJnhRIrM7bVJxxf5fIAx/9L1FoIGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbDBD32o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbDBD32o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788369246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
	b=BbDBD32o5W4ldSwmNMskOPBFOA6o8RaXvrTYQfpnlV4oy+74iUtYu47WFJZcAn1bxefzkT
	gDgb/+6H2v+Lhv+VNGRZXWxfHvrdusyA/jordOddJktuEhzxfwCL84Xw2PWrJ5Sfw7Z+kH
	S/lt51Tv2TUKZjg0unGwek87HNwhtNw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-yhbFqzecPBydn1iIozEXeA-1; Wed, 02 Sep 2026 13:14:04 -0400
X-MC-Unique: yhbFqzecPBydn1iIozEXeA-1
X-Mimecast-MFC-AGG-ID: yhbFqzecPBydn1iIozEXeA_1788369243
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b601f597b1so786419e87.0
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369243; x=1788974043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvYdpnd0F7jdbeopoRK0pYiwAofYBMgVV1eQGD1lnc0=;
        b=Wkgd4OwGEgWI6lj5sJxaYyP+4jHDhobjKFH+OTPFkJHy/e+ZOfwT66D5qobQLYRM+5
         AAxQzI+768/reH6J3Fe4klO3RdPAjO/VT9va7iWV3Sk3OQBjuFNk0UQ+HXU6OIcRmc4Y
         9AoiIRo4lEm8BUsybDnQ48eWWkWx4OjG4YAjRywC+OHuO/o04f99AsH7/+sBZsZAcqrI
         2mfY8p+qVr050E89QsPnjk4uuw/X1C/FxPt3a5Qzlxd0jhghzwZfwhb7JtQ7QFthtTOR
         ZOu2tN3wR8dyt9Bmad8VdH3DFAclPX+2JF4DTCjtuK27mJWCJvM9GxuyjOb9b/hQYiNI
         phRA==
X-Forwarded-Encrypted: i=1; AKwUvBwOu5NyVSjPEKgkByeVC9WaD1RP5dPI6Bp8hhQp56k0ESF/kVqg+h7EREdiVM10+HppXoQv@lists.linux.dev
X-Gm-Message-State: AFuF++lgv8PcKXOq2oMWWlqDo+dgxHAU50PK3GEm4kid1xI2UhGrDkFW
	erXrOoRZKx/M6qc7PRpFykBe2FOfLvErUfqEGXhXnNRGtsODMOMXtQRI+5tdyosUTROwjjgsiX6
	LvCWentHaRRRwaHrPT+SDV9M3+N64R0nYaVZjvCC7gvQAr3mcpyL907gd3bRyUzSsfUS89k0ogl
	32dkEUKxhlAv/PlLfx/Oc1a5R7CJNaXw==
X-Gm-Gg: AYBFou0ouOmvecjyzgp2fnNaKDZjOGoCd0h5DDcZDpcAT1YATNJwOY7G0604Mla4p/p
	kt95LT/Vj/mOQcwSABDV2FfsPH4WoqZFnbNzf6eUPjXqIw8pjYWFzUwjCTsmCaHkS2q/Zn4mfxf
	/FJ00OM4rW71ofh/S6RK8GWENhlgGVrAiyjxUw6sfSOLBqgBNVwwWyo8NW
X-Received: by 2002:a05:6512:3050:b0:5ae:ba1e:c0ad with SMTP id 2adb3069b0e04-5b60832e38amr1893403e87.6.1788369243076;
        Wed, 02 Sep 2026 10:14:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3050:b0:5ae:ba1e:c0ad with SMTP id
 2adb3069b0e04-5b60832e38amr1893389e87.6.1788369242614; Wed, 02 Sep 2026
 10:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
 <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
In-Reply-To: <edf662bb-3c76-44c1-806d-43980d94a492@paulmck-laptop>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 13:13:50 -0400
X-Gm-Features: AcwNN1Uj-u9Sbn4q5EAK66MbAySJOC2taxXheyrOAkTZX6yUFqfWPab-4oh3oiU
Message-ID: <CAK-6q+geOEoHBAJdJ3ZdYF3WSLP9bbsY=6uxiJOY8a=qgiHZmQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: paulmck@kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>, teigland@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -dNAe8xKSkxEIlSp6GPPjM_juznJXz-vyjQRO-YbKZQ_1788369243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 12:50=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Sep 02, 2026 at 10:30:15AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Wed, Sep 2, 2026 at 10:16=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> =
wrote:
> > >
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote=
:
> > > >
> > > > >
> > > > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > > > >  srcu protected connection and node hash tables and hand each
> > > > >  element to call_srcu() for deferred freeing (connection_release(=
)
> > > > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > > > >  callbacks are invoked only after an SRCU grace period, which may
> > > > >  happen after the exit function has already returned.
> > > > >
> > > > >  These exit functions are reached from exit_dlm() on module unloa=
d.
> > > > >  Once they return, module teardown continues and the module text
> > > > >  may be unloaded while call_srcu() callbacks are still pending. W=
hen
> > > > >  such a callback finally runs, it executes freed module code and
> > > > >  touches the static SRCU domains that are being torn down, result=
ing
> > > > >  in a use-after-free.
> > > > >
> > > > I thought again about this and in my opinion this is not possible a=
s
> > > > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > > > handling when the module is unloaded.
> > >
> > > When the moudle unload, the srcu_module_going() will call cleanup_src=
u_struct()
> > > and free_percpu(ssp->sda) to release resource. but we not call srcu_b=
arrier(),
> > > the srcu_barrier() should be called before cleanup_srcu_struct().
> > >
> > >
> > > > I know that srcu subsystem does a lot of magic with modules init/ex=
it
> > > > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > > > See
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/kernel/module/main.c?h=3Dv7.3-rc1#n2711
> > > >
> > > > so this patch should be reverted. If they don't use a barrier there=
,
> > > > the fix should be in the SRCU subsystem, but I believe the current
> > > > SRCU implementation already handles this.
> > >
> > > The srcu_barrier() need to be called, there are some description
> > > from Documentation/RCU/rcubarrier.rst:
> > >
> > > rcu_barrier()
> > > -------------
> > >
> > > This situation can be handled by the rcu_barrier() primitive.  Rather
> > > than waiting for a grace period to elapse, rcu_barrier() waits for al=
l
> > > outstanding RCU callbacks to complete.  Please note that rcu_barrier(=
)
> > > does **not** imply synchronize_rcu(), in particular, if there are no =
RCU
> > > callbacks queued anywhere, rcu_barrier() is within its rights to retu=
rn
> > > immediately, without waiting for anything, let alone a grace period.
> > >
> > > Pseudo-code using rcu_barrier() is as follows:
> > >
> > >    1. Prevent any new RCU callbacks from being posted.
> > >    2. Execute rcu_barrier().
> > >    3. Allow the module to be unloaded.
> > >
> > > There is also an srcu_barrier() function for SRCU, and you of course
> > > must match the flavor of srcu_barrier() with that of call_srcu().
> > > If your module uses multiple srcu_struct structures, then it must als=
o
> > > use multiple invocations of srcu_barrier() when unloading that module=
.
> > > For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> > > call_srcu() on srcu_struct_2, then the following three lines of code
> > > will be required when unloading::
> > >
> > >   1  rcu_barrier();
> > >   2  srcu_barrier(&srcu_struct_1);
> > >   3  srcu_barrier(&srcu_struct_2);
> > > ....
> >
> > yes, I can see this makes problems when there is kmem_cache involved
> > and you need to be sure it's being done before you destroy the
> > kmem_cache.
> >
> > This is not the case here.
> >
> > I looked more into srcu functionality "cleanup_srcu_struct()"
> > (srcutiny) and it does "flush_work(&ssp->srcu_work)", workfn is
> > "srcu_drive_gp()" and the comment states "Workqueue handler to drive
> > one grace period and invoke any callbacks that become ready as a
> > result."
> >
> > In my opinion "cleanup_srcu_struct()" should be sure there are no
> > pending operations.
>
> If the user never passed this srcu_struct structure to call_srcu(),
> then there would be nothing to clean up.  Now, maybe all SRCU use cases
> are OK with the extra srcu_barrier() overhead at cleanup_srcu_struct()
> time, but as far as I know, that is still a "maybe".
>

Okay, I agree with the "maybe" argument, then maybe we add a comment
to "cleanup_srcu_struct()" that there must be a "srcu_barrier()"
called before. Except "call_srcu()" is never being used.

> And of course, cleanup_srcu_struct() has no ability to prevent the
> user from doing a (buggy!) concurrent call to synchronize_srcu() or
> call_srcu(), which would defeat any attempt by cleanup_srcu_struct()
> to do this pending-operation cleanup.
>
> Or am I missing your point?

I use "DEFINE_STATIC_SRCU()" that does the srcu cleanup for me and I
was confused I need to care about "srcu_barrier()" before module exit.
Then "DEFINE_STATIC_SRCU()" needs a comment as well to call
"srcu_barrier()" before module exit functionality as my initial
thought would be it would do that for me as I am even not a caller of
"cleanup_srcu_struct()".

All of this, of course, should happen in a safe context. Wheras for
"DEFINE_STATIC_SRCU()" I would assume after users module exit function
there is nothing going on anymore.

- Alex

