Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274704A483B
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361354; cv=none; b=GiZ8qQ8pr6eKE7u5OGuAuFffVyWcqfy+yYbYGN+rv89LS/Mu4IQtfhfO7aTAELRg+UbAVH18me2mJypuiU2ESro4nmPjBFVebfmPOKlPseaUqHffJNYnNssN8xuUksc1tyK1rsQo4Wnxg3S5k74VZJ0vgteD2uAUmzA0vgz4Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361354; c=relaxed/simple;
	bh=4hCdEHOD5c3EpnGTMHlUu8D7fgdaQakWWcnz0VXo2UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sforKorwWeO7wulWGGJXH9aegBtFBU9yctjxVPZkraO/1/QNXOoig7e2pI/I1gMyanwAl2RoPodMBGyf32zsuonw4PBP7bxYj//6aGnSjo7A7dEoHg1tkI5NELz530kVpEwSn88Db8sMEMgD6NFIDx6zQbLvK7jpthrprismgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMHEYdga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMHEYdga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788361346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
	b=FMHEYdgaCQBDpALaNskUyvogA8cNwPhTZI9ZiXmbDHDMUVCQ0Asd5YTKKVXbJf662vXotR
	yiLF9Pd1LgrWpfyFci8YUXugfX6n2AmHCUbbEKE0USDQmA0OKWeOiRjb4ujU85FoHcH5sq
	UYbll7afoN4w2HWB7Z4Mxitx2+eSdDk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-fI3yRd5FPpm6ILFb5mSRCA-1; Wed, 02 Sep 2026 11:02:25 -0400
X-MC-Unique: fI3yRd5FPpm6ILFb5mSRCA-1
X-Mimecast-MFC-AGG-ID: fI3yRd5FPpm6ILFb5mSRCA_1788361344
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a3540f42beso3890441fa.2
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 08:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361344; x=1788966144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
        b=kh8KYsDpFmNT1tDeG9uwM9ugv4o44Lbiqk3qGMoqQdK9x5pNFXqQsfEZ3jU2q3IVZp
         ictWP5VkwfwcwOO9ykMUOr2I0EuL4BDBQwqZj/nqn3JKzorffnA6myPwYj00AsOIAOrb
         AIUjIeN+vpq5djVZc+X6WzXp3V/TMACUIqtWpvIdODsQbRI+mC6BV0neOZIidsEsqQvr
         eiPVannGqTqpZd+RGUPe7jLEFUYEDdFUH7UxU4Qc5hpLwL0jeM2wML/3R+WRe1NxCGt1
         JzTBe3h+fyUtpkp5d9BhQd+1wPn9BZGrOLxVHA37qSeBDbqiSdht8kgw86Cud8Ncbpps
         LKrQ==
X-Forwarded-Encrypted: i=1; AKwUvByIOXm2+aGJeL+W2ZX92G4y32UKa/v7nh/hhK4cS/lczuHG5rHr3tpTvCq6yzAr6kYb/xQq@lists.linux.dev
X-Gm-Message-State: AFuF++kdeoBmM/Avp72+D9TBfcN77jdzjcxhdImZiF+exs792QylGdJx
	e2J3mdCpL0dnMY7o3ID1vUzThVchxLfzvIQwAvHu3njJLiYxNOtIb3pFED4hawsX2sqx30BB8Tp
	ov2a1NxGhgUIdWdzIrVC4YScYXZzlO8FjE2sahJeAol+SgOdxbqQ5a2G+3FZ7GN3BzNETcvw5RB
	U/jLHC1kogvbukmc4Bl8u3EjYkGeGtidz86OPvqCiq
X-Gm-Gg: AYBFou2XZBs92Jzgh9g8k2g2LHmft+6XIkteGyMXL8o4d0etHuFWePccIjiC3X1jNuD
	IGz20+J9ciQVHXH06NPfNSau61NCTWvCp+mZl0s97wu1BjdKpqsWaYyrB1JFxaLEgvGDFwkv1i0
	JjV97YmzsMkoTEu3pv6rW7hOvRQpv10Jmslo7DzcWQR0B+C4HJOdk7ifKt
X-Received: by 2002:a2e:9a04:0:b0:396:7547:439e with SMTP id 38308e7fff4ca-3a34fd41f57mr13878471fa.7.1788361343850;
        Wed, 02 Sep 2026 08:02:23 -0700 (PDT)
X-Received: by 2002:a2e:9a04:0:b0:396:7547:439e with SMTP id
 38308e7fff4ca-3a34fd41f57mr13878321fa.7.1788361343420; Wed, 02 Sep 2026
 08:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
 <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com> <2ff0e6ca8e1e05078a69dbd2b2ccd1e62fc4650f@linux.dev>
In-Reply-To: <2ff0e6ca8e1e05078a69dbd2b2ccd1e62fc4650f@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 11:02:12 -0400
X-Gm-Features: AcwNN1Uhwe44GL1WoqPHmRji7SmzGB5HOuEKMZek4F9ItyxN1HMNrCmnAfT5LSk
Message-ID: <CAK-6q+hfRsoznk9is9Z0XEkfhMjacw8urk7NkZ4cr=mw6HGwcg@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _dJFHeWONWo5pVTNrQ4PBYN46bqoSUA5dfHnM5e3wKg_1788361344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:49=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > Hi,
> >
> > On Wed, Sep 2, 2026 at 10:30 AM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > >
> > >  > Hi,
> > >  >
> > >  > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrot=
e:
> > >  >
> > >  >
> > >  > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > >  > srcu protected connection and node hash tables and hand each
> > >  > element to call_srcu() for deferred freeing (connection_release()
> > >  > and midcomms_node_release()). call_srcu() is asynchronous: the
> > >  > callbacks are invoked only after an SRCU grace period, which may
> > >  > happen after the exit function has already returned.
> > >  >
> > >  > These exit functions are reached from exit_dlm() on module unload.
> > >  > Once they return, module teardown continues and the module text
> > >  > may be unloaded while call_srcu() callbacks are still pending. Whe=
n
> > >  > such a callback finally runs, it executes freed module code and
> > >  > touches the static SRCU domains that are being torn down, resultin=
g
> > >  > in a use-after-free.
> > >
> > >  I should rephrase it:
> > >
> > >  Due to missed call to the srcu_barrier(), when invoke cleanup_srcu_s=
truct()
> > >
> > Then there need to be a MUST call of srcu_barrier() before
> > cleanup_srcu_struct() every time.
>
> If there are some call_srcu() call, the srcu_barrier() should be called b=
efore cleanup_srcu_struct().
> usually, when the cleanup_srcu_struct() run, we should ensure that there =
are no pending SRCU callbacks
> or ongoing SRCU grace periods at this time.
>

For me, this is a MUST because who is maintaining something to know if
it was ever called?

> there are another reason:
>
> The midcomms_node_release() srcu callback can call call_rcu(), we must wa=
it the all
> call_rcu() to complete, because rcu_barrier() which in dlm_memory_exit() =
is required
> to successfully intercept these RCU callbacks.
>

Yes, I can see why "nodes_srcu" is necessary as this has something to
do with kmem_cache is being involed.

The "connections_srcu" is necessary for the above reason that the srcu
API requires you to call srcu_barrier() before cleanup_srcu_struct()
because for whatever reason we don't do that in cleanup_srcu_struct()
as I understand it now.

- Alex

