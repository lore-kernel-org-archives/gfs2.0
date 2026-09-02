Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4EE34A78E
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359435; cv=none; b=c6BWL7lG1LpE/oaPeQCwiRjIpeuXKLGfvkDnCQv7u3ZIsVgrZ14WhZsy3rxkG8W6PEy6EqUKhDPgfCmqz3LIALPwguY5Kc5niKojUIJq2T8TZcMMICJmYCxtC/PyiKLYVaFmCeRwuW3Jqf+ucbHBUrwrN2tQTAd8Bezx2bjE8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359435; c=relaxed/simple;
	bh=3vIL+Zi9cI5K4ONG+fTKiBTXtBVCBvQbed3WtggRMeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLopgstyCphJftbWEaPYh/UYA7VOxz909oLzTxwEMep9CUow9KRh9MOpK7sIKkwQsXJq/BbQS7/vlUg484LKYLehNC41+l6ajmEo7zJ+ZNSTztaXEdJq/cIDJr66kYelWVDKDIAVBOLkqgSUdpYOxu3JshRPp3N/zdIdsbkLjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YECIzG4s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YECIzG4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788359432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuuBPIWKXppe0fjH2ufB4IcRL908RTVx6ajLWwRfcv4=;
	b=YECIzG4sDaqfGi1x4bYBwFzpInfvRDePcNtS1NaJzU/gl9P/ntAp0hgMxjjdrzCGsH4Djq
	ayz1mS3As+vUsnw1ZdWPf53S/7TDFlEcQ76vRAXBnklVfH88XSz+wXLdSdQ5aE6ozwEafl
	9JO4diFvpRuXCboj/rAT6HKXwFeA1no=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-mvFOu8YjMvCqmYTxUJmMVA-1; Wed, 02 Sep 2026 10:30:31 -0400
X-MC-Unique: mvFOu8YjMvCqmYTxUJmMVA-1
X-Mimecast-MFC-AGG-ID: mvFOu8YjMvCqmYTxUJmMVA_1788359429
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a2073ff856so5070231fa.0
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 07:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359429; x=1788964229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wuuBPIWKXppe0fjH2ufB4IcRL908RTVx6ajLWwRfcv4=;
        b=WOMekkvZgDpUw0vnu5gghCvykSdQGjdDIY9pB5p8mJrgcrm/MbgKXrCSNx4I4J6k7q
         5iWEFVw5EfOj40HKKw6cMtBYm9fzTf+IhhqzWp+rWiqjFtiHuXtV6LpE0PJp4j7SFJpc
         mfO+lu2WYzSlpygj7gnTSK/mpzPIa/f10NsIfi+TB+Tonec1UGQ13QvdETgAwmwmnv4S
         spenQcwkKcnCFeOTFkZu7BVMsOmDOBPAeAzvQdns/WeDkbsjCS1/TbZWldkIGm54eZ2q
         0J1xk7TzkBMqk2CYQ7tITrQKorK9VCa535Gso89vGFb47asHg6sTSQJ+THLpbWVXNXb4
         e3Dg==
X-Forwarded-Encrypted: i=1; AKwUvByytKl4zCRpbMKyjS/MWlz2/18yzwTClg/CBunlFtrdCFSVGuU2BkwzNuaQoQVw0Y/GPrGp@lists.linux.dev
X-Gm-Message-State: AFuF++mLM8qDCjZOiOAvJX7zAoH1V6Fngfwqh5qnHFhQAbhBfK/T8dA0
	kEUTtvD8HZHi+bSqWHR2tYBhMXdOfPFW8CYthzT0s9ivsAV8QyQUUJf2UzsU2MD/p6UA9FWxY9g
	eO664VMstH6gpGsoTpquKcadXb2AGhXbdczkXlxkWy9yJGUUsyOHJlxl1uIVL+Rt3SOFR6iGwm4
	tGUcNhvDSsoJuYqDI0RgYeKLHRylKd7w==
X-Gm-Gg: AYBFou2wOzomkyPn7hzXdEUZVw0L39HsP6c3hwRg7y5iM8BxPPo06vHGiA+zQnuoKDX
	qOhyTN3JzC6oqKB1058UjG45aQVDNnR4vSYKtrAXWeOYEDwghQf0Ktj3M2N0KCYV0Gxzv2xq4ku
	OH2FVfmQoVJ7Mh5MjEpZpnDdOawHKGrlIIrPupFhzIaOdpTfbPo69Ow6ym
X-Received: by 2002:a05:651c:a10a:20b0:3a3:10fb:e174 with SMTP id 38308e7fff4ca-3a34fd9cd13mr8404521fa.12.1788359429358;
        Wed, 02 Sep 2026 07:30:29 -0700 (PDT)
X-Received: by 2002:a05:651c:a10a:20b0:3a3:10fb:e174 with SMTP id
 38308e7fff4ca-3a34fd9cd13mr8404391fa.12.1788359428932; Wed, 02 Sep 2026
 07:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
In-Reply-To: <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 10:30:15 -0400
X-Gm-Features: AcwNN1XyQQYH9ZucUvyr7upwsRM1Mjh1-Yp-CdGPc_PFgcogBJd27y1L4kMmbKk
Message-ID: <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LTJVI7sGJSYabA1HJWpr5pPiY71ImoNcB7wRHdeqgwk_1788359429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:16=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > Hi,
> >
> > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > >  srcu protected connection and node hash tables and hand each
> > >  element to call_srcu() for deferred freeing (connection_release()
> > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > >  callbacks are invoked only after an SRCU grace period, which may
> > >  happen after the exit function has already returned.
> > >
> > >  These exit functions are reached from exit_dlm() on module unload.
> > >  Once they return, module teardown continues and the module text
> > >  may be unloaded while call_srcu() callbacks are still pending. When
> > >  such a callback finally runs, it executes freed module code and
> > >  touches the static SRCU domains that are being torn down, resulting
> > >  in a use-after-free.
> > >
> > I thought again about this and in my opinion this is not possible as
> > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > handling when the module is unloaded.
>
> When the moudle unload, the srcu_module_going() will call cleanup_srcu_st=
ruct()
> and free_percpu(ssp->sda) to release resource. but we not call srcu_barri=
er(),
> the srcu_barrier() should be called before cleanup_srcu_struct().
>
>
> > I know that srcu subsystem does a lot of magic with modules init/exit
> > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > See
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/module/main.c?h=3Dv7.3-rc1#n2711
> >
> > so this patch should be reverted. If they don't use a barrier there,
> > the fix should be in the SRCU subsystem, but I believe the current
> > SRCU implementation already handles this.
>
> The srcu_barrier() need to be called, there are some description
> from Documentation/RCU/rcubarrier.rst:
>
> rcu_barrier()
> -------------
>
> This situation can be handled by the rcu_barrier() primitive.  Rather
> than waiting for a grace period to elapse, rcu_barrier() waits for all
> outstanding RCU callbacks to complete.  Please note that rcu_barrier()
> does **not** imply synchronize_rcu(), in particular, if there are no RCU
> callbacks queued anywhere, rcu_barrier() is within its rights to return
> immediately, without waiting for anything, let alone a grace period.
>
> Pseudo-code using rcu_barrier() is as follows:
>
>    1. Prevent any new RCU callbacks from being posted.
>    2. Execute rcu_barrier().
>    3. Allow the module to be unloaded.
>
> There is also an srcu_barrier() function for SRCU, and you of course
> must match the flavor of srcu_barrier() with that of call_srcu().
> If your module uses multiple srcu_struct structures, then it must also
> use multiple invocations of srcu_barrier() when unloading that module.
> For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> call_srcu() on srcu_struct_2, then the following three lines of code
> will be required when unloading::
>
>   1  rcu_barrier();
>   2  srcu_barrier(&srcu_struct_1);
>   3  srcu_barrier(&srcu_struct_2);
> ....

yes, I can see this makes problems when there is kmem_cache involved
and you need to be sure it's being done before you destroy the
kmem_cache.

This is not the case here.

I looked more into srcu functionality "cleanup_srcu_struct()"
(srcutiny) and it does "flush_work(&ssp->srcu_work)", workfn is
"srcu_drive_gp()" and the comment states "Workqueue handler to drive
one grace period and invoke any callbacks that become ready as a
result."

In my opinion "cleanup_srcu_struct()" should be sure there are no
pending operations.

- Alex

