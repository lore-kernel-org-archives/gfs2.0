Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C672631
	for <gfs2@lists.linux.dev>; Sun,  1 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360186; cv=pass; b=ARHuE90tNnET3npE4JdTJGK272P9OnfIqBOljEVbwu1RIVrv5ucq2UVo/wKvHsq1pFl4cL4ZCa1qysdgPQawBM6rpA2rqr53a9XvKVFRsKJwvYYc4kscB1QYp6ESYLw9ILO2tohD+tRbnYikUGXPYQfE01XFtxckMkz5IuO9gBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360186; c=relaxed/simple;
	bh=s7rfjnPtFd6SU6xoPH3SYe9hNrVk5+6PWUoUYgGCnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQniZ0UHdc0Yizy9PmPTEGDp2OFhJKPCRjfPV77k/T8NkaKK0CYx4j4zfGA5VcMkTwo+u5cw5fnZth1nOiTaprVbahdfzXNqT7JIe/4JZ3QxORvLoWArORPsJUlqNitaMaFUbYxJ6pFnwY0h2lbZgVbGApa2k7Cxz2NrjD++9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCjkP2Rw; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCjkP2Rw"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso52621241.1
        for <gfs2@lists.linux.dev>; Sun, 01 Mar 2026 02:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360184; cv=none;
        d=google.com; s=arc-20240605;
        b=KVqOgHfI0hStlZWUjnZwlwJtsGSHPvdpnkS//UwRs+xbM4pFQDOrd4fAepD1UE72Zo
         PlsqW865YD8M4GFAbrj/ycA8/2it/K56AM0JxRFZWsgjdXvz3Qj4hnELczOTSDJmswU9
         TizwbhlZcPBjHIa0cei4n0HghA8EIYYWrN8Msq9YSGvqoyceFAHhwnCG9WCRe9gE3qSg
         K28v2ENjpThsFth/TMvNWqcbZcMHQiU1ZqbIqaZYmDAX4ufvbQke4oaL4fMwsgJs6xrI
         MTeWoSz5xodq5DeWYgUMK/tKr9kY3ooxBopDzSfOM4qaV/GvkYj9WrvtjjDmf8FDho4G
         tx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        fh=3JWnt9rAK2EMi5hCllOOcla9ENjVCfmSR8O9Zd4mlEI=;
        b=YOmVyzhkArPIDc72NujaR96vR5yBxbWc01e98wVPW4RCr1HWAv1/CcgEblAo9b1zqe
         Q+L5al29ikhkSZrf4y4gmq6lxdT9Kf+kA1CQnMgFbR4AGXS6LR3rQBdjd9fvkhQ6bNju
         D1QmPzqAXMDDEaNPwYTtlxOtVK0a6FWxG+Fq4hBC89S6dn0HwfpTPbGMlRyK4vSNseMy
         CQfMGebdcWBe6hXmzhckfSg0VtihHTue4yj+vt+IffCL/E8cUn2q8zrizKHF3Jr6vwmf
         MoSetv95bgmwZ7XNSN1dIXZ3fWAXqFTJV1xnT2s8UKuR3kdHd2Lxo3KZ8PXe6tLkXalr
         3Y1A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360184; x=1772964984; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=cCjkP2RwvAsAb49uZATP1ijH2pyg4F7PddyreINN7A6VO2kSqw6i4NBoUzC8MNkQAh
         nP77TPevxGij4La/+zzEWGdhL9wpgNpvSFriVvoEo7ZHUEYIYj273RY8bY5OOlJpjiLz
         n010zgvbiQvySKUtxKTRd7PiDMG2U92djirLYQdtOwlfPdnZNZXXTMdI77dcjQOpdz25
         05irLPwS46LddEzaKzzGJ8HLqCuqKwsVod+3l5qY7sMGsf45hzepTedwGbYEXzfJXBfl
         CuEHqfCSNdgSJl9Y5XCzwAw/4SETHNTOIqseTyuR80nPtAihDX+zuP2rVG61rOC3GQ0q
         w4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360184; x=1772964984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=ERCsK1gNi9COGRLiy5bXNEDAe23dPrwMdIS5mCBKq5Z9WX892Z+4c0lCfATjkvFuHj
         BjbQrDFeZMRoiW+laQt80yZ7fOwa+a4lWRGhn7hiNM4U9qmJQSc5KYHdLVMM3g+EMDXf
         jtIRq1zjvIr4O9J5x3SFTTs/+xerx3F4Ar4P2xW7dOIR+1puY4ZtzuXZh6YL+de/OYdH
         vdnKvseBTWcGtbfn9bARTd2QbonBol56R8rBlsdt5kY8URJS/iV8ewTuSLWDoemHbjjv
         W3Q/vkkXwGdzTgOjYVK40zII7Vnq7n/AcPJaKj7530X6tKAR9We5LoiF5RR3+kqwbg7V
         PRKg==
X-Forwarded-Encrypted: i=1; AJvYcCUaMvvm50zqLnV22N5RHvuiBhBYOzrpfxnzK3WGgRUM2jWTFnTZO1GTaQnz+A3ufm9yrE8c@lists.linux.dev
X-Gm-Message-State: AOJu0YzBzDroypfzu03MUPjUQk6Bckm3UG2uij4PEmyyRzkmXcSBLwyw
	X3lqUM9TH+TCMe/H6NyyD9nuo5Z0kTjj7eJgIH5m2ubDrjhX2eQrawVbS28sJ063jxFX4oZeNnk
	+HtxCYt1Ovs58JbR5LjgZ8LSaPmQmGv8=
X-Gm-Gg: ATEYQzyTKZ9JG3Sioz1yrS1QE2PtFEhZUL0+za+y2o59fu+C+RfbW826fx6LtvGR4LQ
	END97i/xVQ/vcTwl0G2p2i7sOSzQhkGmRaprNJ0AyQNnaz/Ury+iCDTsW98dfkjaVoKzVtX7j6m
	mv5Geo8hbq1EMLqdJ3RvPb8qMah7cZ/Ryh6mZtA5nuFF7OgbdbMfUF5GQR6VE5dfw8hMKhtXMtG
	404De8P+1SPyfjefR7sabRXJv5mtW5AQPvVEEsxgzhLUKuBkDgS1w9CloPP2VOfNCnAvQ6yDcWQ
	aJnw/CzHSfli9E0bkHVVcpgCoxsavOzGntm+uhkzaw==
X-Received: by 2002:a05:6102:5091:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ff322bf4bdmr2863289137.7.1772360184080; Sun, 01 Mar 2026
 02:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 16:16:13 +0600
X-Gm-Features: AaiRm52S_i7uxGvz2GvDZgmu6T0jp37pcUwvZrAaDhnW-l9lgBlZerFtvlbrSME
Message-ID: <CAFfO_h6Y1QcW7mNGdCuY-_J6zrF_F8aW+Q8O9SvoBbXTxteFjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy

On Sat, Feb 21, 2026 at 8:59=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> I only tested this new flag on my local system (fedora btrfs).
>
> Note that I had submitted a v4 previously (that had -EINVAL for the atomi=
c_open
> code paths) but did not do a get_maintainers.pl. It didn't get any review=
 and
> please ignore that one anyway. In this version, I have tried to properly =
update
> the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs=
2,
> fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
> (fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, mo=
st of
> the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |=3D=
 FMODE_CREATED
> for the O_CREAT code path which I assume means they always create new fil=
e which
> is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead=
 of working
> if path is either a directory or regular file) as it was easier to reason=
 about when
> making changes in all the filesystems.
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - atomic_open codepaths updated to work properly for OPENAT2_REGULAR
> - commit message includes the uapi-group URL
> - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v3:
> - included motivation about O_REGULAR flag in commit message e.g., progra=
ms not wanting to be tricked into opening device nodes
> - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
> - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 0=
60000000 to 0100000000
> - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O=
_* macros from hex to octal
> - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v2:
> - rename ENOTREGULAR to ENOTREG
> - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) an=
d in arch/*/include/uapi/asm/errno.h files
> - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.=
h due to clash with include/uapi/asm-generic/fcntl.h
> - I have kept the kselftest but now that O_REGULAR and ENOTREG can have d=
ifferent value on different architectures I am not sure if it's right
> - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-=
dorjoychy111@gmail.com/T/
>
> Thanks.
>
> Regards,
> Dorjoy
>
> Dorjoy Chowdhury (4):
>   openat2: new OPENAT2_REGULAR flag support
>   kselftest/openat2: test for OPENAT2_REGULAR flag
>   sparc/fcntl.h: convert O_* flag macros from hex to octal
>   mips/fcntl.h: convert O_* flag macros from hex to octal
>
>  arch/alpha/include/uapi/asm/errno.h           |  2 +
>  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
>  arch/mips/include/uapi/asm/errno.h            |  2 +
>  arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
>  fs/ceph/file.c                                |  4 ++
>  fs/gfs2/inode.c                               |  2 +
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 +-
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 11 +++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 119 insertions(+), 32 deletions(-)
>
> --
> 2.53.0
>
