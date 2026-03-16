Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF099331A57
	for <gfs2@lists.linux.dev>; Mon, 16 Mar 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677572; cv=pass; b=P+p6qyGTDq0bn8+PYLYpj2tOTxVeoL5ylOGMSth5x+0By3wUF7xKvQbp7v7/yjMrEJ0i4cNhjaguhbcPJYicnj1uto9CKv4djBGnRHEft5AtyOimqtGRDp4bW/z3JE/AYFmeN1YoswOvv7aY9JndCgxY/jWRX9Q1+3TessGS41E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677572; c=relaxed/simple;
	bh=mngjUXyQIGRdPpzvMVY93piHPQBoPK11l7fLKRKjC7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtNZY2v+9ml9dGnt/J98yKRlEwqCFmC1soAaX35FBGlOzFCXpov85rWI1DQ2sFhm4qKmRbxn0m7xhY1c04OnzeTnFoMBy4rkarxUJW/tzzh8NTcJ1Al9MkVURX5elfjt3Ra/EMJe39Y465ZzgIEihBxSBR5DtOyDtYaMevtW2E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBdBIDKm; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBdBIDKm"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ffbcfbcec4so1031513137.3
        for <gfs2@lists.linux.dev>; Mon, 16 Mar 2026 09:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773677570; cv=none;
        d=google.com; s=arc-20240605;
        b=bU4yVhicC0y+pk/hgjxUdLu9HWBaV4fnaLnjowacEXC8haN4EcOLC8Y7V2ytG5hYYt
         zKSnbhp3Ii5TjMcOfuO9dVqE6nWlmM6BBbmWJrY5O7T6hfoj9xkn6GK9XzuT68W/+5I6
         NxasRVRQK8dVcjgkXQ1soeikFV50Kd+c4NNKaGNbs1eXvUcqee4xfO7kRe3cAkdw0Cfh
         IhaLxWKKowIYem0gDC/vNroR3AwyMX8P/ii/ZzLEfT8d5e2sp1neZztGiCxX/dKW+c4P
         hp/uVx6fQBp5CSqJvc4wVlhvV99yu0kZtL8bUVbJbGfbPW1/scGWXoLRb9DeVKubvXg8
         tnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        fh=Kr0+9bKgzvyvHKoAWE48w5U+lJJFqq1BQPcOz3dQH6I=;
        b=YX83ls6BwmZd4kM0qZ510GPngI0/Cr0Hq/li76VfF6ZdKFYEMmu5c+7bxzxUXniQ3U
         /+Pp98BJ9AvxaabS+UuOXyFVJR8MBc+g8jrxZddRmsNByT++iVsJYsOtX0wnKhdfpgbB
         cG8SOyMrNwigl8h5uEi3yLOQOLIAqu7DWyb5pd8Y6M4mdxn+VwCUHHeLl4YlLp83kfkW
         eqnUGDUyzQmksPTWx6igcIcIzomPy4P85MUOJz0CTAifMTtlzaCMbwIzB+k3aEeI1yY/
         0ECcantKg8vBmYU4I8MdDwaSQt1krKSyQ40PyP9ZJAId4YiK5kPaEfghHbuiU+UvvfV5
         IcZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773677570; x=1774282370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=EBdBIDKm08+z2y6drgLzhUDVWK2iqyDa9AcyzM+kAb2o1OQyc3YguxxEGoBe+5tpqB
         DSwRDx8RRHDj7/wL0QEMXlqBZ1B+WVndm5ecyJZrJ14qauk30HniDPGNjxGs5ux5c81+
         GLQ9wHE+xRIT87GP9MlEcLenB0TrmCXfUzflndAl87POU1fMC6F5bvg/T7ubX2S1agVL
         YCW0i2dU4IUD8OORWyTI3jb29O91JJozMz/8dEESeBJbGKYCwrUrnFjpYXv8cTvW0Tr0
         ZQyvhaalEW6HhmeXdGtUoWYhgkg5Xs30+i76qxLf3YUrwgzy31hPfkc1wN76vOWAH+BF
         QudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677570; x=1774282370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=DgVIBXkwl56wUVqgvbp5FRrPVdfasv3dlm7k4j6JtVKXUsZcwZrkZGf3IcMS1M/kib
         nAZFjWOnnTy1HH11jEIAV/8WYR3rotCK24cbIUgAoNq3zXFVC+f3PTOBC6Wh3lvCbdLM
         j40CGdm2zw88ZgwVhyzqi8hk2Bb8ERw3edESvjzPUFCBwqLlFUa/liIRThJ6B5hetQwO
         kssg3C4giQRIHSxejmWwvrnO2a6lWt/w4E6nxrrKz5mkauyu7XQ84qP5QRlE8dENXNhV
         tA+AGopfuvrnlzAgUgrJJtYgAAahQCW1E2IfTiDMf97sx+XOZ59MjiWRHT5IW8tm+J/i
         5bzg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvteVgKLgSAdvaO59S6OCxoneqmdEYLWY/8cwJMa1+cmqRSouJY0vmDZMugT6qTtIkiIF@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqox/JVAWX6PkwDoWw4rD2NW3Qy79skiHD4n8EQ/UAhxKGnXJu
	UNkQ5lBrw8pB3O1BTDZy+Yxyl3Hj8XRc9zZuKNQNfjt2axxuLHpMgfSvIUL3Od3SDBeIZogFhM1
	FMTCbKhj7ewYBxbtgUmEoTt48mZJgJeI=
X-Gm-Gg: ATEYQzwL/PtqP0G2vDT7GnDEYZnrxpITUoyLwWj4IPXRGjzACzR/e4BTznXdj1OezWA
	8ZVyhR70dL0suAMPhsCl/r2pLh7gAQ+b/Qz9Xn3lNp+vsKC87klC1JODJcYYjUaL2SKCjbcE2Xs
	fpu9I06w6JScLSbTUHwP1DsILWECeUIZ6h/O88IaZHyNXiRRpYLWKKrlOh+H7LOqoFardPvX7n9
	BtbcdVf62wFcGSwSX7ja7C9bxKi5yQbf9p0C/BVBofj/9Xz2DIofdMwheth/CjNbAOcXxcNneJ9
	98UjoCEG3+F713rW3nefMgOhOvu3L1L4Er+6L3doOoLV
X-Received: by 2002:a05:6102:b0f:b0:5ff:fbe4:8a7 with SMTP id
 ada2fe7eead31-6020e52bc2cmr4525326137.24.1773677569597; Mon, 16 Mar 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 22:12:38 +0600
X-Gm-Features: AaiRm53PnIFKVZg8YyfIZR4HMQW1Q6cca8fQLreG4GsNHelMK8lmfHxNIAUkk-o
Message-ID: <CAFfO_h6iNKbcKUi+Em2emRvXdZCfxcm7HnCenpTg9pSsHMb6YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy


On Sat, Mar 7, 2026 at 8:07=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
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
> The following filesystems have been tested by building and booting the ke=
rnel
> x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR=
 that
> regular files can be successfully opened and non-regular files (directory=
, fifo etc)
> return -EFTYPE.
> - btrfs
> - NFS (loopback)
> - SMB (loopback)
>
> Changes in v5:
> - EFTYPE is already used in BSDs mentioned in commit message
> - consistently return -EFTYPE in all filesystems
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
>  fs/gfs2/inode.c                               |  6 +++
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 ++
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 14 ++++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 127 insertions(+), 31 deletions(-)
>
> --
> 2.53.0
>
