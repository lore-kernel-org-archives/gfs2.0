Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C64A0151
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359815; cv=none; b=kEHLKeng5fqVRHwvO3c8UsBXQI54fWjQu7cVQgHOkEdCzhOjXetlragxGqrpU8y/dnWoYqV4W4BAKiLCa6hbXxGP/k/HCecfxdaLdsOoodmzvUDdViNCwPzsSUgiJhjY4qI5rEkB3XFQkZnlYtkyYFnWpyElP/Vw3ngNXLqn6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359815; c=relaxed/simple;
	bh=TZmvaasfuNqPTtuT70sqqQUSwx1v/e/Zx2LqnB4yVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgeXiSgM5veXNayoFofbcBZoGsHZPvgoYoBDok6GaAQnpouZekRB8rUUQvuaqpwCEPbZ0gddse95XNFAfblveohtO/SY4yGJeeQY1u7b/rDg7qv1QUhePp7nLNFYNY0e0xeaauMhlt2m/4N7I9ilaNehn56KmU6e0wjvaPZPPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX1eR1A6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX1eR1A6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788359812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
	b=eX1eR1A6ZCuqt1byTeplHoQFpC7VUv7XiZtcKnlQzISYYOlqGdaYZtHRR3mmoPSuokgCMu
	+4M7rNlmFGGwVP5G7k7BQqi6cn9cLEN545Ce2/cIurgJikwFCXP9cPP3NuVpLhc2dgqgY/
	lPJH2PzEifUOChF7qPLsFOhrfXJQuIk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-y9BYPjhVN2CC55Cp-YwijQ-1; Wed, 02 Sep 2026 10:36:50 -0400
X-MC-Unique: y9BYPjhVN2CC55Cp-YwijQ-1
X-Mimecast-MFC-AGG-ID: y9BYPjhVN2CC55Cp-YwijQ_1788359808
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b5f157bab5so633129e87.1
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359808; x=1788964608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
        b=nUNHvDP0wdZo1psi9yTuH1A/aYPwP+yjEJn9A+6D6K9e6zqs+u5Dh15czmirPDfjfA
         3JcRMs6+9Tnn6XbAmPGQ61FfpGu4VBufDS//1iq8lFwK6geZOqOY5unRSxTykj+yS9NI
         KOMKBV4yZzMy9NlwuyP8p2m59FPXdHSeP+ZC+V3O19+ulCZADcASoD7GPTuzurjCb214
         sAtXLJ2/krMDempz3/6ZUbjzStSOxON2ArJh6s4pOV9+DlNEBQ9oKgJEdnppZH3gj+R9
         Yj9XoRrQCN2G+86RMEfeNyYMfqv9TmQqSDL6feg2GHWArQ/orrWeE8IqyqrfaI5p896z
         8jMA==
X-Forwarded-Encrypted: i=1; AKwUvByv9f1IIfLBiQojSPHKIb6vAmP5tb1f4ZYByLjiMwmwNmjbPU9EA9we6mg/p4649gxFizCe@lists.linux.dev
X-Gm-Message-State: AFuF++kdaA56TuAj0h47hyWgw9EusZ7CuOdaH/VM0YIHv0Kx4meAnvs6
	r8tCS4TztMrPrNXxX6AGAD7Ba/+ZZGlQCPtR9KSNlrZ1fKi4rbTUoJE9oF2w47pq5qW06j9JXu6
	aG8MCiKmTOxOjaMsxRod5sfybL8xYZq1CoLR0sZ3Aa8Lkyi1wUlHaNOBMBdS2t+8W0n7fSW6YIf
	uvRQ9w6dT79w6taJ4m3FNbvkoeG4Ktsw==
X-Gm-Gg: AYBFou0z4rIdi3Z5UzDcTEn8URRODgRJW4gngeMXRnF/4tNGSGX3ILlC7UNNeJ52Nz6
	Hy2v1ZYPEqAeqRFzZ9SBWJZec4Iu3UV//Ib1/hMxG7K7I96u+MlsfIhs1V3z5LUDdbKU7uBi4dP
	l4b78ddN2+fm4uyBlh7Gow3QCUI5CZzToVxkivsjbRZ80sgCnzMbvaMXjf
X-Received: by 2002:a05:6512:39c6:b0:5b2:a919:f9fb with SMTP id 2adb3069b0e04-5b608699880mr1867196e87.22.1788359808456;
        Wed, 02 Sep 2026 07:36:48 -0700 (PDT)
X-Received: by 2002:a05:6512:39c6:b0:5b2:a919:f9fb with SMTP id
 2adb3069b0e04-5b608699880mr1867179e87.22.1788359808018; Wed, 02 Sep 2026
 07:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
In-Reply-To: <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 10:36:36 -0400
X-Gm-Features: AcwNN1UVK4Wd1puy8en3G-MOknq5D1y938UAw3x7G2DdWgDZO_ERjPjfOaq8jX0
Message-ID: <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z7HklKL28yKVxEIl154sHNbTt7F9bUXp--_2qV51lcI_1788359808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:30=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > >
> > > Hi,
> > >
> > >  On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > >
> > >
> > >  The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
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
>
>      I should rephrase it:
>
>      Due to missed call to the srcu_barrier(), when invoke cleanup_srcu_s=
truct()

Then there need to be a MUST call of srcu_barrier() before
cleanup_srcu_struct() every time.

I am confused here.

- Alex

