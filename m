Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3414463E
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876876; cv=none; b=XGn5l15hp0OlgUCJJEwdMqbmMKgO2w4c3ff3pRxkIqUt5ctTzKvC6OIussZF65ZKNkRuTogdwECPRs8LpUvvFiG1rtEEUNLFYYL+SOK8GVkLhu6XwOWVSQSDU37IcT88TOPC/cNSrRXeBM20XWY4Kk5k2V7/j2eHAQS3OefxK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876876; c=relaxed/simple;
	bh=wA8Lf3CZyMSyk/+YApk65f8FNwWV1iWFTXih4mLCFMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=np75XGvTlcO9OF1py11rNO+irK9cjF/4lkLTUUeWLci/7ITHndU3n90aCMNVlm1kGDaBG3OTiIeZ3YiNWC/Gqnp9uIcAlUsJs8/xTnVD+1BKFv4tohplpqUG9kXKAqVkUrTLo4g0PUSJt4XPfB1mTjVelhI3h70fhVPiMUISL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZBWBptl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZBWBptl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706876873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bSOagLCU9RA18uhSvbVE7xJJi/PABl/3SptPhadGyo=;
	b=TZBWBptlkOO5HudFcIia9dlVT5UTrFY9fq8kx9asUxZXS6Mmhplj0FG4+FYJCI/qX3l8KX
	RiRjrtJJMsqYF1BeHHJ4Ju30cDmmY7/Rne04LaE1MYXMqaESED0J5MXvjmLBc7wgvmb4Fx
	reI60OkyLoKuaRZ7UVIIqnCCoKe8ltk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-8oS1Ts5iNgGLodr0jX8ymw-1; Fri, 02 Feb 2024 07:27:52 -0500
X-MC-Unique: 8oS1Ts5iNgGLodr0jX8ymw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-290a26e6482so1952496a91.0
        for <gfs2@lists.linux.dev>; Fri, 02 Feb 2024 04:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876869; x=1707481669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bSOagLCU9RA18uhSvbVE7xJJi/PABl/3SptPhadGyo=;
        b=DR3HSvtnSVSEUcsiy0jnG18xZrVFsgYvOSonzDO19hgTph1DUrge3UTFkJ5bZkOucj
         hJ8o7vBDXlclr7kCdVPk0WmQP+oVwt6xE/gOE3POPJW54JuZEjeYUNJ+Ay0p61HGFMbY
         PTv2efFZ3vn1RnEEw7Xs0Q+8jmXfMw+RaL6snFyRjeAgGDRfQ5FuN9S0Kd+bvqlqekL0
         LZ+wA6gBbsgELtJ0P/kkyS7QSwpiMH1/FOxxv3m9sMgn7ZCsJRBd45G5yUb9sEHgSksb
         baBf6ZZNOcvXzMvZhG0y92Q6IoDbbg9YCLM9xSjOvgqbWGWWhRPND+aX+YtPKVUd7jaF
         YFfQ==
X-Gm-Message-State: AOJu0YxuCIvdLpP1GC1uUku16OuJ7ZSa+SrgT8WkZCgNWAjISJNUe0+l
	1GsYLlz3VGHYKi9tXeiuUWOGbOK3/JO/D2O2/YdnGVB5HK+G0va0QUaM86rTinBg9psjfE8FJS4
	AfameOutauPMafjVCT7VOkVbfqWRjQ0psmlmAvhkL9vEIhffWE/M=
X-Received: by 2002:a17:90a:b109:b0:296:3a8e:eee8 with SMTP id z9-20020a17090ab10900b002963a8eeee8mr1821277pjq.41.1706876869217;
        Fri, 02 Feb 2024 04:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhqMYloYVaa90BbAjZtT2EA4kNkQ2X2GfMp/4bupHtIhVjXyyclcgiK6YdCTsclPsISyq5QQ==
X-Received: by 2002:a17:90a:b109:b0:296:3a8e:eee8 with SMTP id z9-20020a17090ab10900b002963a8eeee8mr1821268pjq.41.1706876868926;
        Fri, 02 Feb 2024 04:27:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSxAZxruJWidru6j6sqHp3MCGb6P0oMvdXcakO87WfMF0/E91ccqCii0dveFflASqpY0gnMKQiY2srIt22FJj7Y80ewBM14D8fKvh/eYo50dRqf/8fp+Dti2zrCrk=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ab89000b0029604b0b7d1sm3821293pjr.15.2024.02.02.04.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:27:48 -0800 (PST)
Date: Fri, 2 Feb 2024 20:27:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240202122744.ejfpfrfbt6gnrese@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
 <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
 <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAK-6q+iiSgZBne_C-o3iGz=+dzjVupGX6t04JbzB9DZU__q-0w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 02, 2024 at 07:19:53AM -0500, Alexander Aring wrote:
> Hi Zorro,
> 
> On Fri, Feb 2, 2024 at 7:04 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> > > On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > > > This patch adds fcntl corner cases that was being used to confirm issues
> > > > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > > > implementation and in those corner cases issues was being found and
> > > > fixed.
> > > >
> > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > ---
> > > > changes since v2:
> > > > - move fcntl tests into one fcntl c file
> > > > - remove ofd and same owner tests, should be reflected by only one test
> > > > - simplify commit message (remove testname out of it)
> > > > - add error messages in fcntl.c to give more information if an error
> > > >   occur
> > > >
> > > >  src/Makefile          |   3 +-
> > > >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/732     |  32 +++++
> > > >  tests/generic/732.out |   2 +
> > > >  4 files changed, 358 insertions(+), 1 deletion(-)
> > > >  create mode 100644 src/fcntl.c
> > > >  create mode 100755 tests/generic/732
> > > >  create mode 100644 tests/generic/732.out
> > > >
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index 2815f919..67f936d3 100644
> > > > --- a/src/Makefile
> > > > +++ b/src/Makefile
> > > > @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > >     t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > > >     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > > >     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > > > -   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> > > > +   t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > > +   fcntl
> > >
> > > I think this function needs a less-generic name than "fcntl". Other the
> > > lock tests themselves look like a nice addition though.
> >
> > Yeah, the "fcntl" name is too "big", please rename it to show what it trys
> > to test. Hi Alexander, you can tell me the new name you'd like to change,
> > if you don't want to send a V2. That might help to catch the fstests release
> > of this weekend :)
> >
> 
> I was thinking about "fcntl_corner_tests", if this is okay.

Good to me, I'm rename to that if no more objection :)

> 
> Thanks.
> 
> - Alex
> 

