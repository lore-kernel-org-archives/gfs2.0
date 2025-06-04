Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BB23E33D
	for <gfs2@lists.linux.dev>; Wed,  4 Jun 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028969; cv=none; b=Amc1SbV11R9+KeV2XaW51YJ4fHSzWTepBu/FBbE0Vr0BYyMDaEP2tCHMxLHugR0oF5Mob9FuUkaIXbGbhpVf9+dbZSBeqJRsfq4sGf+5sUkN4qKAjhdQCOAlqTSzK/cnRHjRkuJNkYnohGGc/AroN7ujSQKsnuO3a4f/MVivANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028969; c=relaxed/simple;
	bh=A+Hb+IYZVbIrHhgOikz8cYlE64YeroKilPbQiRKqru4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSOhWiZv8ckkmt2dd5mAh81ein+UxSJvnbNVbuCVYBkohP40KyGlUa3tK3mUAT1PN4+M12jLzhU066uWC4gj6ausu8fR77bXzi41rIYx9+G9wZHEQ7yTkccpu9xm6bOrCfRhc/b6lq1Y3w4QsBFBjwO+B4JpWZIi3hDlB2JkmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4ircQXi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ircQXi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso2575386a12.2
        for <gfs2@lists.linux.dev>; Wed, 04 Jun 2025 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749028966; x=1749633766; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxD+BS5BNW9JlEJcYvio44SXpqyv8Wmatgad1UAi7lM=;
        b=i4ircQXijL1trrHbzXZnxhOB4Mb3UHKk2ga2jc4SKEAlh+Cf8qiOVb5ZAX7te/38o8
         t2ZDL71KsxQRy6Lr8x/rpo47Ty2cEG4/QqP/MTsd1zE2VSAF5WxVcZX1eBIoBWHhlssE
         KNwl5zgV6je1uEn5/nIyGUOtDERrP4Gd7SIYPIEo51gz0C5tuk0Ntg8vijeTte+ovffm
         52j540ujpM0zYKVifRBp8aU3KQHtmpDvNU9inwz+tJ0z/z0WokFah9pyNie3rAuteBd0
         C+qcA/Wu89sx4/czmxZf7bIEV1wRMMMXurlKdEmugkRueUzirUa99JmfSd+uQnWQv280
         JBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028966; x=1749633766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxD+BS5BNW9JlEJcYvio44SXpqyv8Wmatgad1UAi7lM=;
        b=YxiuhQ4XusTsKtLqmZMoboyT7NnoaIUYwzjpVs5ZHHp4lh1Ta+l3MZuBQVo0HX5gF9
         0/mhQdDANDpDtkEmrAeMkOhSrpn6leotVnhs7hc7AYfqDKEejdHqeMf/0gg7iQIDkcjb
         TDzUpMmp7y0I/KsyJlZxtsY05JExk2RTaoiPC819Pevd5tVEgzHA7xsoSrX2ZcqXxjqa
         6LqbInHYopbBMOLsgMrqE0S69D3Yu+lawVSWjHu+ypuxcaXQ3ZnwoDT7FkPFjtecjJia
         bXqxg1y+dSqw1Bxc/H/O28aasFCZCP96bM3VmlNTmVv5gNYW9dWMrVFYgGsNC0RH/4DC
         uG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWxIWzPdZfBUqqjQsEIxNdu0bIrcLZFQvTs3BpJrN6mEbrLLcutfmIzEd1bOJw1RI1YiCr9@lists.linux.dev
X-Gm-Message-State: AOJu0Yw++TpcICOKVstrSmo/ot8Yz9FhNwAorTzfdKtlRSqMmqX26qEv
	J8LvftiO0vDp/saxEWvBW5YY+PS8OzTpXYR+dL6U5ZasiXg0LcWppGBgbw/kZopRjIVhGUlNaAs
	vFV5FQy0S+Uz5eNrZpziLOBo4UyFoYGk=
X-Gm-Gg: ASbGncsWk8eFRkO+nrkAHBxqjNsjnlsiThkYm9TGZ2Sh6UUtQ2A7KtM6hV6bNmxkrdG
	XStosjqrEXaVFQYgDgofky5r8RyzG5qB3XybU1HAWwqus5uxG7hCX/esWpJ3JJqqRyrO93HzbV5
	ijyqMY+9k91B7SzPjbeiFtj9156XRyuHUo5cxtkVM5cmmNrfDP8tJOEtX+s+0uYG69v4r+hNDbg
	oS8
X-Google-Smtp-Source: AGHT+IFtmWSVIfRymSX8p9O1DuQ9uGU3imVuqryH0lzpbx4dWpXx940NayRL5XU/iX+3A15SSf0ibjMq2HLSlqBsVEw=
X-Received: by 2002:a17:906:a995:b0:add:fa4e:8a61 with SMTP id
 a640c23a62f3a-addfa4e8f2bmr123364566b.38.1749028965818; Wed, 04 Jun 2025
 02:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
In-Reply-To: <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 4 Jun 2025 14:52:34 +0530
X-Gm-Features: AX0GCFsIp4hEknwUTt7cvxyvZfmfYSDQ8XVwMfEKcuya3JVRf5uqzsLfTt2zwvo
Message-ID: <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, 
	p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > For xfs used this command:
> > > xfs_io -c "stat" /mnt/testfile
> > > And for ext4 used this:
> > > filefrag /mnt/testfile
> >
> > filefrag merges contiguous extents, and only counts up for discontiguou=
s
> > mappings, while fsxattr.nextents counts all extent even if they are
> > contiguous.  So you probably want to use filefrag for both cases.
>
> Got it =E2=80=94 thanks for the clarification. We'll switch to using file=
frag
> and will share updated extent count numbers accordingly.

Using filefrag, we recorded extent counts on xfs and ext4 at three
stages:
a. Just after a 1G random write,
b. After a 30-second wait,
c. After unmounting and remounting the filesystem,

xfs
Base
a. 6251   b. 2526  c. 2526
Parallel writeback
a. 6183   b. 2326  c. 2326

ext4
Base
a. 7080   b. 7080    c. 11
Parallel writeback
a. 5961   b. 5961    c. 11

Used the same fio commandline as earlier:
fio --filename=3D/mnt/testfile --name=3Dtest --bs=3D4k --iodepth=3D1024
--rw=3Drandwrite --ioengine=3Dio_uring  --fallocate=3Dnone --numjobs=3D1
--size=3D1G --direct=3D0 --eta-interval=3D1 --eta-newline=3D1
--group_reporting

filefrag command:
filefrag  /mnt/testfile
