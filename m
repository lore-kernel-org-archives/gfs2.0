Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A651E47B3
	for <gfs2@lists.linux.dev>; Mon, 20 Jan 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387916; cv=none; b=VOxpq2mJ/oUjH1xWPde6zKs7dvVmTzsa/5IWhW9iuBlpslJg7uDOW9vNekPIw8oVvI2IQDVfhkZArHQPOVV63Ss36K4k1+ALpWDuwliWaV9w1Jg9+9OOOpZGEx6lxFCDq0kwca6+T2dMF1V095DiVOAhcZky1mPGyZuMK1jst2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387916; c=relaxed/simple;
	bh=Oda9mln6fEOlY14aL6317hxcaxqFGoBRiFYJ48KMZC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYnApABZSrzKNG6i1bdqnzjbD4sHr6Qcwol+Ndy93C3hQYzm1XFuml4WVl0o1kg6+ro8fHVMRW2X1q/nqCmHe6XHhZDiE/I7cyiyOzZ/29cQeAFcT+gupqM+nFusGmtjwkhSxCp8jT3Laz+g/uwIQZAs2FpPMa9jvJIAK0lSqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEVoNbcM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEVoNbcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737387913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
	b=SEVoNbcM7P+atvX8ZABpCkGKNZ34/pnJ0jl/2ui4+by9mzNgWYtDrRW4tzKQaUHYqs630w
	PJotek0dejVkbYDDBlU4UafKTGDOr6JwepTdsbch4SFczyPIumsi8JtVNAEpkkTfg9wtZu
	9ycoIpMXQbJOwRbSE87bAwIxgra0JF4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-l3wd0StONcKOKR0KLwBiNw-1; Mon, 20 Jan 2025 10:45:11 -0500
X-MC-Unique: l3wd0StONcKOKR0KLwBiNw-1
X-Mimecast-MFC-AGG-ID: l3wd0StONcKOKR0KLwBiNw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166464e236so140703005ad.1
        for <gfs2@lists.linux.dev>; Mon, 20 Jan 2025 07:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737387911; x=1737992711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIGGrFqr7H0caVdn+ErlhooF/AWh7D0WDDnrCqb47yA=;
        b=qxRSPn9oDjyXtxc2P79IolHGRRdJRArl7cRlV6FiriA2ZmvsOcs642nk82cREqQkOQ
         lygfd6UwHWh9Ux6ClAXJa+t9ceZ/c1dDSwKqomyrvFmDGCmrhR4TisVz1w8bBEpClUrp
         lSNTGFsH+vDgzEVJg+ID32rPKcsQP+jhuQGZOZHljnVQ9szQmgWauFE1uroWzE+sYxnK
         IkWpXiDf5QYmOmqGvATxYda/FHgtHlzCOHXBk+zfiiKBudOwM+nnWuA/x9yGWTO+foJ9
         Nutcms0Q5H7PAIymOsWCW+z3ANldThL6dOYkkb/XG/GtgVZmBX5Q9rQ+aWUYNqM8aL3J
         BMiw==
X-Forwarded-Encrypted: i=1; AJvYcCUEyUP9Qx00ZtrJmEIJns3O8z4CK5LlXgqlJQ2D7azkGxMf7mVKabkUNZIhWGbAs+FQwyxd@lists.linux.dev
X-Gm-Message-State: AOJu0YwcWkpKFkPMnzvk+UlI5UveesSuvOPbKn2BhBIkPXzzYfdoZh1X
	pYxiddjAT5STyAMvjmAr2LlzDNc3g2Jhwfew4sbaFevCiFOmRu6oXrQgHZ0NUNqz2VKlKDonivQ
	5XWzzT6VTn2FsGO6a6xE8k7CPLopB1/tuNrAvp6HdZ0K14whe9+JH9PTFLPyicJQxd5bIQ4Vz86
	wZr08Tf+MoHueggYsVo1MQLf7jog==
X-Gm-Gg: ASbGncuGU5hQ8bYlpPI0M/JOipLN2Io4LrB+uzofAzjY5DFm1pLm/2G6kByzLa0WpjM
	MYtniEhx2Y24KQAiAMl10Ic65vlJC/hyyeHm6FPxzV20hs/4W6g==
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id d9443c01a7336-21c355b641dmr185100485ad.13.1737387910849;
        Mon, 20 Jan 2025 07:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuQe5UfQ3x73vBIKz+Vas2Vh1EUeCLsJdDGZT/xsX13VrNUtSO8YwlyHZngSzILoKv0/LIxcX/SpneTI4V0bM=
X-Received: by 2002:a17:902:d50e:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-21c355b641dmr185100145ad.13.1737387910533; Mon, 20 Jan 2025
 07:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250116043226.GA23137@lst.de> <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de> <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com> <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
In-Reply-To: <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 20 Jan 2025 16:44:59 +0100
X-Gm-Features: AbW1kvbnR4jxYY1OmmWJQiLZ57eqMNbLkpoGBmLc4oA3QTE98Cmi7zx5BVBckp0
Message-ID: <CAHc6FU6EpaAyzFPdJUa97ZZP76PHxJb-vP8+tzcZFRYT5bZeGQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZghBEQFm9x-ddwGcJpS6odzGPGb83Sope9j1ihw1Y_A_1737387911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 4:25=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> > On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrot=
e:
> > > Well, if you can fix it to start with 1 we could start out with 1
> > > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > > because it initialize the lock in the slab init_once callback and
> > > the count on every initialization.
> >
> > Sure, can you add the below patch before the lockref_init conversion?
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > gfs2: Prepare for converting to lockref_init
> >
> > First, move initializing the glock lockref spin lock from
> > gfs2_init_glock_once() to gfs2_glock_get().
> >
> > Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> > common case.  Compensate for that in gfs2_quota_init() by adjusting the
> > count back down to 0; this case occurs only when mounting the filesyste=
m
> > rw.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
>
> Can you send this as a proper separae patch, please?

Do you want this particular version which applies before Christoph's
patches or something that applies on top of Christoph's patches?

Thanks,
Andreas

