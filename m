Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3C8472
	for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743461293; cv=none; b=sP41Mt2/qunurm8oMqHJxywMEQUyhZBo+0Jxud1qE9Zf3DOIoSe24uVQUw0MOnU2K042GKac6Sf1HXiFkPsJQGsvPh9WeDBRBf8gWRC/LMTUse64GphA35w6mohjLkl9X29/WtADBMcpdjr0MZHWYVeu0+goPc+UfKH0t5Jz5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743461293; c=relaxed/simple;
	bh=BSR/YE4VvrCgWKDYqFdKKPAg9EdcDDdcnOlXgIqD1tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYJUHI0TNqElid4aCVoAvbgE3CMBhFZ12MQKjBnj9UgbX9k+dKvMAaFG0EMAuTplQ866p2/n9rTNkUyMKDH8E3QuLdKqb1EA9q0vtHxPE2ax64rl86UZMGjvx9iE2E7NmuxrfGZn9cRM/7uCgzzBqWqI8FM5ZHaDOGq76L137yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ5a5MtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ5a5MtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743461290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCziBBZkDoyw5CJSLALhXd9AzxzhbuF2cQ278j0EGf8=;
	b=UQ5a5MtJ0OBtiiCIjQrReI2yU8+9LlX5jSPmdGpZcGQry6DFeDEuMCC2oZxAWXYUQ54cmT
	Vng6eTCefT4yub35h0Hv4e4Typaf1sdf7qQjuo2SzmgXMN6TOKnmYeXVplbbPIGnFEc0rJ
	FuP/kZvyqFmDHhjoS3/vBahZwUry0IQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-gd9PpYgMMFq4VspxpF4gDw-1; Mon, 31 Mar 2025 18:48:09 -0400
X-MC-Unique: gd9PpYgMMFq4VspxpF4gDw-1
X-Mimecast-MFC-AGG-ID: gd9PpYgMMFq4VspxpF4gDw_1743461288
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22651aca434so90989105ad.1
        for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 15:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743461288; x=1744066088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCziBBZkDoyw5CJSLALhXd9AzxzhbuF2cQ278j0EGf8=;
        b=uVmoDTmmlLlBIptfBMdxOn33GCX/vLC5iXGSjRLB/dYYp+FHiyVEMsjNeJfcNj+/4/
         UuK+bj6GqMAbaQ/O8apxr+ffT2ed/27/ksQJwpUWsinIAwpm+drWUlj3wmTDU+o1+H9w
         3MCn1sCTg1As3+Y6BIe1wLEyRr7xu2umNzgxpk/hQKdaxR17zcwEdbPsrUJ9plmy9oxd
         wLsnjCERAxb2ExEjHoUiOWT4sE6qjs9cOynJ0Nn0O9rDtp4ixroKHvDotf66mzSjkfdC
         C18FGNvVO0LL9c6ghO9pIxnarLC+14WpDpTW+GniGXu0cJn8x4667XTWXUl7g+McPHnI
         euPg==
X-Forwarded-Encrypted: i=1; AJvYcCUbf/3KaxXJEUPRfC15lRHhQmBwpAlEx8mDVl4e/DjzaCmcwCsZP0tBbw3taOW2gZ/DxQYz@lists.linux.dev
X-Gm-Message-State: AOJu0YwNjdKVWO8HCVzKhbZgfxwBNfb1BnhlQa2JapQViXPd2NPaouh1
	zyAn9OQunVRKDJr1hx4MomZ8KpEj94hvwPmrPtbOQk6Ruax+Yq56g9H9/FqPZjMiI6ToWoKNWMt
	dXDHcfqBY1DAEVQWgPuWUndABPByeqTaBg2hnlZXwiQiyugBoaORP/EOdA35tikQPnUIA4Uvzir
	C4jrBdo6XvcYIozTmDNUXbnlDpzw==
X-Gm-Gg: ASbGncuDqnwWvE27R+NpT56aJlceZdHrRXsCS1m1FtdAnQo7Y0PGvbuY+icpfZm3vLk
	XFJEqXqYAIjCRBesor2Gig98qPjNvaUWnwO8W1gwbstbmmhJ2ZFMNHFv+KKMhPwHAL+fppg8=
X-Received: by 2002:a17:902:d583:b0:216:7926:8d69 with SMTP id d9443c01a7336-2292fa0258fmr171378905ad.47.1743461288579;
        Mon, 31 Mar 2025 15:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnNrcz1PUNJsG7W4Aog0QsyUnRmVX9ycU5q46kOU1d5/CiVUvTjxAVQPgPwi30MEfGIB9IQEPSlUgjRKE8e4g=
X-Received: by 2002:a17:902:d583:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-2292fa0258fmr171378595ad.47.1743461288141; Mon, 31 Mar 2025
 15:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250331193656.1134507-1-aahringo@redhat.com> <20250331223154.1fd4b0dc@pumpkin>
In-Reply-To: <20250331223154.1fd4b0dc@pumpkin>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Apr 2025 00:47:56 +0200
X-Gm-Features: AQ5f1Jo0x_vIcaAtoeOm0IQjnrEDud_mqJISb-oUg9IB-eG_dm7BGB9V0hiCLU4
Message-ID: <CAHc6FU5rbJ1=Y2CRN2Wh0kCxbqrKT3ApZUBF0Rw_nUrTDEtNng@mail.gmail.com>
Subject: Re: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Aring <aahringo@redhat.com>, stable@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0R9JwTQb3AWKzHGTu_FJ-VXOPtUxsbohmPMiHvHRkio_1743461288
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:32=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Mon, 31 Mar 2025 15:36:56 -0400 Alexander Aring <aahringo@redhat.com> =
wrote:
>
> > In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
> > held. In this case we cannot call msleep_interruptible() as we a in a
> > non-sleepable context. Replace it with mdelay() to busy wait for 1
> > second.
>
> You can't busy wait like that.
> You've just stopped any RT process that last ran on the cpu you are
> on from running, as well as all any interrupts tied to the cpu.
> Also consider a single cpu system.

I agree. This is easy to fix by waiting after releasing the spin lock.

Thanks,
Andreas

>         David
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/gfs2/lock_dlm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> > index 58aeeae7ed8c..ac0afedff49b 100644
> > --- a/fs/gfs2/lock_dlm.c
> > +++ b/fs/gfs2/lock_dlm.c
> > @@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
> >               if (sdp->sd_args.ar_spectator) {
> >                       fs_info(sdp, "Recovery is required. Waiting for a=
 "
> >                               "non-spectator to mount.\n");
> > -                     msleep_interruptible(1000);
> > +                     mdelay(1000);
> >               } else {
> >                       fs_info(sdp, "control_mount wait1 block %u start =
%u "
> >                               "mount %u lvb %u flags %lx\n", block_gen,
>

