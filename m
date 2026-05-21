Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E83368D5B
	for <gfs2@lists.linux.dev>; Thu, 21 May 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378578; cv=pass; b=cU4aBp1GTjkjCykVIiOIIAMbm8UrC+5Sm4Wg69BHPWrXcMC8iPs4FSwyCHQYNn5QU3lv1zkO9HHjsevydur20uGqlv0JrhflNQZBSgX8t4MdCXmE+Oih352oZSNPhtSWhWXwywvG8biuo1ckrnYxE4FSGPQVTJ4HyI8p2ayxcAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378578; c=relaxed/simple;
	bh=oTJGeDYTACLQP4b7lcnYS7MF/F8SkeHi472hQfd2CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoed14J5rO2QVUiQu2qylOOQv+fUAo63srtZYhmNFy0rBhCeFYd60eMd3OfWrngvV44bCub6YHyaewELgi/WZ+WLvsuWGjyljDIHTFqXttVRPAAn7Ug/DjMPAhK/ipPAy4GkU7LwwrOVF3ycgid2jRO2C1wkDEs3ULosAPeBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePH9aMjB; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePH9aMjB"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-631a7868228so4345364137.0
        for <gfs2@lists.linux.dev>; Thu, 21 May 2026 08:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378575; cv=none;
        d=google.com; s=arc-20240605;
        b=jyFyqdIDqWvhXklSgTdfFt+uCxfWXI+8NTmMJcw7lsL73UXHUOeqz//121PWLWDLxY
         oZR9SfjWSvZx88eyXaQoAsuQ4MLr3ksBm/TplkKaU23Dghd4Ebc2ymLbZ+BnLZ57uUh7
         0CTY/22Cpb8KDNFe6UJ5L7GdVJ/Faq5LN5iteGrX1aQi71roxIcWcQibd0C9jrApywYn
         cfd8xfc86/pk3+JF5NH4/fpfKJJDp1fML9leeuvs9wTSKqw4zLabWh/YWJSH2UXh/SqD
         GWewOjMr3NzRgz87QKGjrea46OCbZXw9CWT+coM3Ftz1EOJKVUvlK9e5r4m2StMRrv+Y
         mLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        fh=w+rJyS/uOj8qO/hqZ/Wc5H7yuvNoTSJ3FxFhYR9FaeA=;
        b=iwtEBGURT/zMmT6hS8jKn4W9pSrrN/l9xj6G0e6EkpX/YJZ1OA7zUvsH5f8NMwE0ws
         CJdczihc5Ckvn59xkVV4MDju+6V4/XCixaKLsWyHE9igV6J+ByReveln2IIuPYErgRBf
         fTSp80Kc4CT22H2/Sg/9GCqniN+xaPEkKh/df7QnJL/Npjga01AfVPLpZMkf61VAqn37
         TvJx7iCxBXwMe6QV4E+Oa9hUWRniJNL4Z2KGk8z4uGVc5zN5/tEQyoPuwqTT0L25jk+x
         BxYysI4EE/Cs1UD4K99KQzknLWITvqK6WJGCfCTFNdu7dBtrkbEVZ3Df8LmTeW1A7Y4L
         wbrg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378575; x=1779983375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=ePH9aMjBkrkGY8hyd9qeuxJInQTbvZGmr+QQs1fjdYIqlwhYf+Wc7i/BE4v51+HuE7
         oATd/aGoNVOVeOHp/lpsb6Szfi0CUmNPcyeJ/IpSGgnvtGF2IsQ+OiJtBKmbTiNJEdrv
         UkeQK00q/N34D6QwKn+SEUt15MBXoW0U7zC+ksAYB3SL9rkZ/4q6Ky8azi5+MRRGvoHI
         OYZLUfGEzW35dfmbpivsfFxJOm3o4mhkaTTfeYZ9kNbDZyX6oPhtgPyXaCjkUtYepR1d
         zGqtS5T9G+3IaK8noemPiFKwjIO+/C8ksscomNeU/pd4KdXOYdzO7nic9Lhh1BfhKDrT
         m/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378575; x=1779983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=lYrzNaC6GOL7Gy9CUTJWW7nGkvPj/4G7DKOZewvazBu4oSL+Iz0xynVI4ZtjNOn+Mv
         yru9k4oTodnem4A4z2pCRxelGpa/rHPKwiVCJJT7D9f34tIGU5mEhe3zNg1Y6jdIxhTP
         v12qhIkVnM1QRMjuNEYvLM7VQuV1rdlucPTQ36McyA2mo411AXH8730mmFmhcpXKib/7
         Scavwpg1OSQNhrbiFybNGETELdpIlizszwdFtLOKel6qS3eUdYVOVulDA8jpvemadSA9
         eHvkDXv8BXIpmvtxUx6oHa9cOmYBsz/yDeCUGRk7JfOvQXKkdYMHb9hpc01qV++vabpu
         Mv5A==
X-Forwarded-Encrypted: i=1; AFNElJ8zJPeQOFMyp2jkFhAcup/mW7WaU0bmzi9KRPjgX9xT7RCQOnScJ/olR3EDRKhWjYBROGQq@lists.linux.dev
X-Gm-Message-State: AOJu0YwYcVMlVIroNPg6gOrZ3fDbcSqFUp7KqrhzA9GyoBX9UW9ejF18
	diKc5oMyPDakkIh22Dp9Sh50f4nUqNv1anNrA+pJ/QhxopLwDplH4wr6HulsDw9Jfzi6GnwktrS
	Wv/TbZviXi2mQgwcPhFCygSiW4ECfOi8=
X-Gm-Gg: Acq92OE93sWCf1fbTnpF6JMidErSkea+jHbiTUbpNKXMPh+WXDW2GAgMQjvyYxV/Qab
	npnQ+cZpWD11ZLmlrkCCK1Enmwv9+MkevqzIzlDooCpCb9m836npwchpiDmRSA2KfDvjqyWalbm
	yr8ICYsuCkb2Mwz6ja7K1yefjaOCrZlbUDuA4ZWQ6kuB7h2gXL46OXgxmfmDvCa3NbCt/Cp0D5P
	LLGsE4Zqh8tKeCDaIyzNfvPRPG1i1p3ZeZxAZWxOfbK5M7dX6fvf42iB3uFeFcTTvyFT502hlt8
	2uWzMOsJk3DT+pmepQ5aWxYcG1mBKVdHEt2uw+MlwhpGy9t05MBN07k=
X-Received: by 2002:a05:6102:1591:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67390b66b29mr2592164137.13.1779378575543; Thu, 21 May 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <20260521-grube-leitfaden-0e5420c9bedc@brauner>
In-Reply-To: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 21 May 2026 21:49:23 +0600
X-Gm-Features: AVHnY4JMLUcx8yOSfS2Q9vtP8tvb48vFjP_vPMN644Wd5G5CD5CLlCbq3u4DVJI
Message-ID: <CAFfO_h4Em26Hfbv-DWF+9dNS8TBuGpfWjWFBUhLr7jYCKzj3_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature su=
ggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > > and thought it would be something I could do as a first patch and get=
 to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting th=
e kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REG=
ULAR that
> > > regular files can be successfully opened and non-regular files (direc=
tory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is tha=
t
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
>
> So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
> the upper 64-bit and internally use a __O_REGULAR bit. After having
> thought about it makes a lot more sense to move the openat2() only
> features into the upper 32-bit for the uapi space. I also ported the
> selftests to the TEST* framework to fit with Aleksa's recent rework.

Thanks for fixing up!

Regards,
Dorjoy
