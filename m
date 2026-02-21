Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13132244186
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688981; cv=pass; b=YTBXms7sJcE3Cz+tr6A6Qj3ixZ5e6QOV8VfTCvS4wKhZc+BgyE4fmgWSqdZV2KgJaumVbAkjuuRir62ex8OxkPVNkFWcZlU0WxAYuFWJW5sllwqEtf98vJyRmUdwRa2GF3KKOmVmMXvpBOAmysuBmqEA6hV4IZg8M91NmJIRha8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688981; c=relaxed/simple;
	bh=23P6V3/EZFsgY+c1DhMXwm+sT4gSINYfgO8QSA/c/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EX2TGw/Is/Q14l96xhlvgaBsaUw1MoYdq2jo423qz3Xa81JfibPDD5DM3wmHSyaE0COIEZUR4ZpnxKPYJ122EYZhhkrMXqDFP+svHw4XKOYVCo2YHruY+h8+HIpRhsTtrqtVw70FSmF2cYRi3eyZG5ur+PPOq4mKI/ngfKgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZtwSLXZ; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZtwSLXZ"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-948ab1c79ebso961685241.1
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 07:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771688979; cv=none;
        d=google.com; s=arc-20240605;
        b=MH6dat02usqEsYo48Gu7RfUjaXDewKU/2Off9qNQiIj31bFyGwjJIdFqCRX7cNmVxB
         zqe2TH8XYSxPPC7Timr7wYPadMmPRNoBiDv7z0oj6/We2YaTq8xITLGMKXljP9ib9nVy
         29ceqSDOYhDwnzL5Iv+DrZFhDvgJ4M3bwyyp80LCrWxD+gwXBUQzWnX4DU3bmOduEf/M
         fiaLZF525KzV0eyU/avdW7ej94LRpD1JbTqMcvHTPY2IqUvwR4Tcb3WNYjWNgy6pWwGw
         8J9oPL2FEPnAcA7ZzNEVpzWptC+sspEGh0RnpEnyxBP+N9+WzvxAsC6vvXmQCtWyxWBL
         r+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        fh=tSKDgqBXB6MZ9+omIzHzz++mdXx9IxrNKr6qvdpD3h0=;
        b=f8QAU4N0Q0BVM7wz6kfPqFB8rUlIHXPPGubj8UZRvcFe9VzWarpnhWAHWMsdwndLMd
         z5PokjiWX63mrWoz6GHrayZsWHaty3CAQyEjN2XORJhU0IrbT5+TAbeLmTtV4PeVo6z1
         8h1v4j4ErovJpMB0TSIjxi7d84Yh6Jd7FJXAJyCbQCFJq8NGaNcrOO4m2axKWoXuHVC9
         ctDNwNQyGo6wVqS+46mPT/3ENZFDkZSVh7OEwUyVGwkr4a4OUTOZvtGzteBTbrTb4PVu
         +LTDrsncQCKW5HnHFFTTQZtX0nDgmmJVguMy6vrhlcjyy+MEC8amid4pZu20jLtqt4nI
         1WQw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771688979; x=1772293779; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=ZZtwSLXZvtS/aNr/yOjUoSzVUnWrBpVrC0GMEhy02Hl7+uAE3Tl6um2JQ2wMCj0upP
         jOlfwiAz+BOuSglkTpF/Opw8SmrUdk4qMpqy5DmyaI0RgYd7WB671Ze6vQJxXf3NZvEe
         6N1mA8ZwAoN7IghYkp2HAOA/YWl7rS1ReQi6nFlibhMhcd/aSP//L6lohhd0ZszN+WXx
         eDYGuiOYvYJZXrUSrudb7IoKSQLmV6iyl0G3dKnzEk4pCBLQHbIMu8gkrmc3gZjhfBa8
         /QcWrwbwghl6RNuqkWAqnIa6jHI+0VigkYuQPlIEv9z+LV10ov0CRwXrOjl73tmg2MAl
         jAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688979; x=1772293779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=wnctc2xa/nIAaunVA/5V/CeK46mWDKyeooBmvXmUN883LqKETpiNRaJj/H/KBwzhwo
         5qNnX/vXTFvBGNLrhOGBlKoBlO1mNdQw0dVX4VzHMCh1ao1EUoaAYpYMerZo+BNz0TLv
         Samcudx4wfAluXD/n+jOEDVIgzUThScnT08ie/QnVdM17x2HnnB3Wm/ugZX+MBym3raI
         uDtPv/ZtoGA0CSPbIG0yrvUusmGJUVPS9Rw/GWEfncuY49cmiJDzb66fpeYNMLyoOE3M
         HLIlXD239NVPQNoSvO6lYUd/ujb813p3dmSKNLx81Fb5SS4IiKimXOTS8TPENhfcdFE2
         OIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd82UutmH5F6HaVG2U0Bk8wqk2wn/vgAFwk7fZmTXCzUYILmQYwfrXZb0rXFq7nYWNyN1M@lists.linux.dev
X-Gm-Message-State: AOJu0YyhZfzv6WPJ9z+lHNA2bmFEKnNw8Dgb6HC1Zj3WRvnt+1WrM3pn
	4x8JL3zLRLjrnbrOzKOZYpCYPZSFXw4iks1w5hAnTLDfHyi6/ojneuAWS/WWsCWrQFRBPLsvVCc
	I6R+G4jJJFyS6VIr2Tq6IEzjpdfLhYn4=
X-Gm-Gg: AZuq6aKZaqXn7j0JAN66i6z3ZepHSgR1sJTKxp9G24TnxYN+4SB6/lsWVJ3a1Lk9fSa
	kcc6Utjn1mgmMIAbiVpteqCfoJ022R4OUfEsxAdw01YK/W/z0UHpUVf38u7MScAB0xakrodP/pc
	Y2bEZ6VA3jgpdYJTuaRXngX0yGLftBeRb+RQQgSb2ux+ewN8aCxReiRp32gge00TO2pfsdqY5ws
	u8IPl3/dkqigt9O6D5Uj7uUM5jXVWoZ7OSLdCQ6Z+uZs3ObaYb5aFIoa+OPX6w3BCFUqC541X4q
	dPyrGOLA1pdupu2koL+KYbc+ZUPdmyWOKRYyPdxYK6E=
X-Received: by 2002:a05:6102:6cd:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5feb30aa44cmr1230671137.29.1771688978916; Sat, 21 Feb 2026
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 21 Feb 2026 21:49:27 +0600
X-Gm-Features: AaiRm52uxICzwXE4h2cG-NB71vMvoLaBUhNK0X1besn-bhoE2jLckvjHX39jcu4
Message-ID: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
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

I am not sure if my patch series made it properly to the mailing
lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
The patch series does have a big cc list (what I got from
get_maintainers.pl excluding commit-signers) and I used git send-email
to send to everyone. It's also showing properly in my gmail inbox. Is
it just the website that's not showing it properly? Should I prune the
cc list and resend? is there any limitations to sending patches to
mailing lists with many cc-s via gmail?
