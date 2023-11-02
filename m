Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CA1F94C
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTcP5Hh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698962955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=quL1P8zjNyP83VLw6Iz+uPPVRLwi5A3nZLxlDtFUwfs=;
	b=BTcP5Hh02rpByoV3iCimjMnejxJTzTGGzAC+HpfZtFOR35pPQYCk3swwT50/C3Pvj/YrZW
	Kw6rgTm2tTCyAir0MhVXj5nLhzJtcC2JawzA7QDNY/PY+xLhj+SrdK/6GBp1KIT3l68Oti
	ztDuukdPnFzrR1LZ6zb7Z2RpUEXlg9A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-3QP0OQUYOZWsiQwBxVkN1A-1; Thu, 02 Nov 2023 18:09:13 -0400
X-MC-Unique: 3QP0OQUYOZWsiQwBxVkN1A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b99999614bso1078692a12.0
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 15:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962952; x=1699567752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quL1P8zjNyP83VLw6Iz+uPPVRLwi5A3nZLxlDtFUwfs=;
        b=qPey+fUOqpSHYsKcbwbFxjVG39eD8HbrsW0hphQDAWo02FHZQPjjGRppT5wePdYVzu
         Uzgh8a6Nf1D58jL67Cc3vUykx5JNAWDHjg0M60M9bmBa5BlxFspslC1CXv6n8q9IhpJc
         5hFEvxSwDsN/BGUK5hK8ZoIDxQO55j8mKwr+88JIBdHH+xAR+bttdciUgzlYfY5C1aHE
         TD5f8uXq+1fDhWWeqUpgBul4+GjygSsK1xdkEGX6IcAIvl92Ku2KBw52aORbiNPKwM8w
         rMuYiFxJ85cXhnvNmr8j9ViMcIZGYF8rEJLjHRkfSPEhghC3f5R20McVaTwtCeDFqJ4R
         wIQA==
X-Gm-Message-State: AOJu0YyjRnW/lfSQOMYcXH0wwwbGbqFNz5r5h/u3UOgX9PcqfoZYXyoQ
	TpFanbt80IF7VFn+26uny4ox20+LEPpxZCJNa0RhksoD+AIJCIKugX53VfbDEuwHfHzpIyjYAOd
	AOn+qKXgBwnLHqhJsPbqLvN5NWYpRRg==
X-Received: by 2002:a17:902:da8d:b0:1cc:548d:423b with SMTP id j13-20020a170902da8d00b001cc548d423bmr13350242plx.60.1698962952059;
        Thu, 02 Nov 2023 15:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk5YD92mPf7xIfxXoaJ2Pocptuq02n9KdEFsjs9YP4Z8rtqf3l8Hn95sEeK8Zx2NiU8uV2g8mWTdNo9V/dc4A=
X-Received: by 2002:a17:902:da8d:b0:1cc:548d:423b with SMTP id
 j13-20020a170902da8d00b001cc548d423bmr13350232plx.60.1698962951807; Thu, 02
 Nov 2023 15:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231102195803.1212539-1-agruenba@redhat.com> <CAK-6q+h7zaCy7DZjYsmc0Z+w6iVhrWvLL2icrhXpWH5Z=aYEog@mail.gmail.com>
In-Reply-To: <CAK-6q+h7zaCy7DZjYsmc0Z+w6iVhrWvLL2icrhXpWH5Z=aYEog@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 Nov 2023 23:08:59 +0100
Message-ID: <CAHc6FU4Ym_nzTvvS6=1AjZm=de3X_kjd0Dn1x329L==WiDeqig@mail.gmail.com>
Subject: Re: [PATCH] gfs2: don't withdraw if init_threads() got interrupted
To: Alexander Aring <aahringo@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:50=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> Hi,
>
> On Thu, Nov 2, 2023 at 3:58=E2=80=AFPM Andreas Gruenbacher <agruenba@redh=
at.com> wrote:
> >
> > In gfs2_fill_super(), when mounting a gfs2 filesystem is interrupted,
> > kthread_create() can return -EINTR.  When that happens, we roll back
> > what has already been done and abort the mount.
> >
> > Since commit a28dc123fa66, we also call gfs2_withdraw_delayed() in
> > gfs2_fill_super(), but that only marks the filesystem as withdrawing an=
d
> > relies on a caller further up the stack to do the actual withdraw --
> > which doesn't exist in the gfs2_fill_super() case.  Because the
> > filesystem is marked as withdrawing / withdrawn, function
> > gfs2_lm_unmount() doesn't release the dlm lockspace, so when we try to
> > mount that filesystem again, we get:
> >
> >     gfs2: fsid=3Dgohan:gohan0: Trying to join cluster "lock_dlm", "goha=
n:gohan0"
> >     gfs2: fsid=3Dgohan:gohan0: dlm_new_lockspace error -17
> >
> > Fix this by getting rid of the ill-conceived gfs2_withdraw_delayed() in
> > gfs2_fill_super().
> >
> > Reported-by: Alexander Aring <aahringo@redhat.com>
> > Fixes: a28dc123fa66 ("gfs2: init system threads before freeze lock")
>
> nitpik, this is not the right commit, calling gfs2_withdraw_delayed()
> was already been there before if init_threads() fails just in super.c

Ah, so this problem was already introduced in commit 62dd0f98a0e5
("gfs2: Flag a withdraw if init_threads() fails"). Thanks for pointing
this out; I've looked up what that was supposed to fix and I've
updated the description.

Andreas

