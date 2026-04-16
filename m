Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E33E2750
	for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352940; cv=pass; b=SzRLWFE9Y4fZgtjspdzEkF6thqnyOWbX3KeBTz/DV34ZBdM2jOhLn0S0+Rv4G5YBcBreg1zC+bZuFFhcS/Y7RFU3QecVHZL6B8fIWUpZq1lb+EylfLypu9Xj+xGxlOvtPvz+/Su0tIkZPeQWVnczU+RkTd+ak/kOGnKf0d34LWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352940; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTG8f5H2IqtR7Dkm7aIa5QKtwvsuSC1OLtkpub1mFBUbR1PNRJnij3bU/3sA74a6y2HOfpK5d5d16H/yGYChbDRmiSaBy09vtmdXxQZE26sPTmu1cN9B/HzU22QLZHTJ+/r0B4pXtPZrOyrt/1AA6EFwzYOQQcb70Jg5VYqCALE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4FWCXJd; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4FWCXJd"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-612d8a59cc0so712976137.3
        for <gfs2@lists.linux.dev>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=FKcoqiYguTLdAL3dL/7gyK9cPeNarjcSaCInVaFTHgvWkj0tmRVv6Bko1/tPgWB9ku
         7ipfS7InlEAXrv/U6+IQH9003bIW4E7A2ge9pjiocxtp66cKY8KYIbrhfs2uekl5Y++P
         VmVwiw53SA4auSDZwSOIEhHRyDAPgtp8OqG+/0en8VcTtd+vTKvQKxlYDWCvQ4G0CfBM
         nKXGt0aEotMWT556fUC+4nSYPx8EtxCWOt+rP3E44CTttkN/1GJUxiz9s+a0VQX7HVTv
         Y5TlBvwNsFx11HTbe47FhLCRl4GXoFDD/5cs+iZbmI2+DDoDlISSXoVFTPT/OnZfnypf
         tEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=R3qjCu9c6uhEC18HdaUtFaZlPJhMtBEXNpR8isdE1LE=;
        b=DBggl+HTU3RbGLZe/XYzGQMrGg+t7bYsVLIFdJCS+hihXcyXqEQ7XgHC6Fss024oTu
         M9tS9aiQ/YI9CV7PiyDYpw0sbv1XQH9EVzOq/3SQdvttO2UKxY4eTm8hmBIil9uXAXtQ
         rc107VZIh46ngUcm3MiRy1dA0E1LaOS5Bu5auCGSC+3X6qRvHya9zmmlTPixQb3oTtIU
         Ch8a68Wwtl6bgXDBoyI1uSoHYyW4VP+E9bbkF2hKA2tohWod/09otM4hRZNielgTAAmm
         Mm0L8vPNC14yb7ywUo14N8ljJPvddb8TnXMSS7eXTPwFb7Ui7OizeVsO5qox5TSMEHOf
         4RQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=k4FWCXJdETRJ11r9AtP2fThBUV87gATa3LOWWW4CX5ZByobTreHZm+pd4sq3hkQ+nU
         9Lnby5CSy2aCJpOf9wZ2Xcf8rWCv+JHR5JFxlyRSoJ5vpR8s+7Pezm1B3VGWJMK/HGjf
         H4gzQIT9FdGfyBccgs5WGdQZTAidaOJfUAD5FdGc8PRaP49f/O8ZFG9dTA054BOO5zIE
         nK/jsXenlJjJV5rUe6f/V3bntWCVzp6nD07U5DXiaZF53s8GeBLI5s7UJv65ZwzbuGwD
         nRFpNvUoskyn/H7XcsFiyYvsssZ2rZsKSXhiXc8bz+Von2JgKEIkfvp7J3ScevkKM5XM
         RKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=I6dASyJUVqcS8+6Q027mq+wKTZSK7AH4yeKENbck9/3um0GaVRczEsqv9cfNIxrMHD
         apOc2u03i5pWYXJccRgZYtalu28qaE086JLji7WOrK2zlsemLnNnZUH1x4bqN+Sxt9C8
         HnlIExyg5uR+O6jdOZ0h4HLf9oSOpqPsy55gajWQFkJLKZW1FkQ+Bheg7/R1IH8Gxft8
         5AIWsiEaHUaTrbBT3Y/22Ui1YJTvXw07SgTh712ld4kW3sIt4B0IKIX2tmaR1Mbch9FJ
         z3gSjKDy84IW7r4FBIT10xMbKf8YjQWsm2VULEnsyXgWfsj2Ck9kYtvByM9Scoa2Y7YS
         FjEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Rq7I80MhWG7KY3C9YYwgMcnwauNZjEtaFjRDgsE2SS4dVUpJbeTZnN+uOGMdjmIJu4Wg/@lists.linux.dev
X-Gm-Message-State: AOJu0YwNrNXNaOAkB80rIHa2jN2/k9pJeR5TVzMzoYQaP2ljw+wgYLr1
	HUz7bjfmtMe9MpmgTL7g/AbWlcK6gDyi1iwncw3BIIMyKburp8L725CyFplti5NhbyCVWwUA5nd
	Xl/NyYfTNbUn000qUNoSVUiIwgEgqdf8=
X-Gm-Gg: AeBDievmNYbj9e5PFlXEankgD5M7/qFcYmACxEPfXaLa4XaXHna6VeWXCS9yndxFTxf
	ih5zqrh2IAZS3KV7NakqadMPg+VVL594pH++b4wmibsxsJnga3JJBglvwtF0hiUyULHQNRFBY6D
	HxMQItFYbR1xYfGpy1YFMtOdDyHrDAwQDvGm/7Ew6/C85ABHMvC5WX3GBZoPs6n8PTPi8Vm9cq+
	PJU1V/roVwHLoK4i15r3dwQTFFaUABmNdKlngKC9AoH+DpxnbM/HWFUpZbTQkRgxg5sKyxPFDQz
	c6i9ZHdLBD/uavHxB1kmrn0dbXerbed4jazhGC93vA==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
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

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy
