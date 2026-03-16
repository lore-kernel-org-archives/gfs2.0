Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E13CFF6E
	for <gfs2@lists.linux.dev>; Mon, 16 Mar 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681764; cv=pass; b=g1pYaZSGb1ezmwcFwWzT3i5U3IdRhDnJ52H+IPAWQh5mHbkRsWMXE7kXSr3/ypg85AzCtcIss+av1IwhERAVEE7vj26Dgrmgt2JWI3PCG5U4xQkoqmvSAfvEA/a8cGICg/IibqbFO4w10oD+YOns+iXLnolQKbwcfCQeWtH1VlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681764; c=relaxed/simple;
	bh=38YIF2h9LQRciTDudLh6dbVHlCWQ+CVfx4lmwVgz+TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4emgaLSmLv2vraSTJnFMb8WQ4+EtDT3jLWM/O3IUNzYo5fyaSfX1S9/pXm+6NDrMB0fiEcvfvUgMNBYCSOnkb67O+U0/yiohD1PyIOpWd2VcKNOJNMBXrpHq2wBO8qDhd0wRnbxZsVzpAvo1OOY3CVif6XxYBJyfUKEHPQl4ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK0fBCxI; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK0fBCxI"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5fff18d44fbso3041818137.1
        for <gfs2@lists.linux.dev>; Mon, 16 Mar 2026 10:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681761; cv=none;
        d=google.com; s=arc-20240605;
        b=KKYV7nhD7U/+IQVSYnDpvyef1zNWeessymsVwUUbbG4EAfkywljSdi9OVDqmXMt5xt
         iDS/aIiskGZm96YDpIaH1ses4w7bINDXepWIkBRItaywNuZqf/cH6PdWCX1e9/QrZnrs
         T7VSGsbbcowqkvHJJTPfniNrZs0pwKYqEfMt6Eh4xSJnO/fEsAGsBayt9GmYAsLVIDv4
         jxrexcvDv/zxsy5D2IXFrTMOgB2B/zJrzS1k8s9nOJgaEtjSVEcF7FD+6Ve8+kL9YajX
         wnBfPftPPkXBSQEEiB1p4NqHoeEUyKSUHADdPZVfxivWQivCCjusiuhf7Qu5lvZ8Kn7D
         8iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        fh=XypOjL+MwETpL7gae1qjwGWMgLZXuC0cdCZ++NeyW/M=;
        b=Ksi6Pten41Mb7aif7IjaNgAp2oThm/wVmBTA0vFKwr71w7TFDBMeKqds10R/3SO78Y
         cDKA/qxqak8fZL5UuRNxU11trVPxER2OlZPpHX86gh4IHO0T1BkBbeIrt+y8BNMaD8kw
         J4Z8tXHADWUZAMfauvr5SgOJ4CUNl0N60dA9qXlFdYufuHH9/rqE5FIfPKirfH12Cbm0
         UYg9myqhFIB7shwYZJW0rSkEp0Khsik2LRCtpdF85fikk+Q6HhBTb/QhPaawj2sYSXO4
         Ok6WT3Y7V+N0ZDae3pQDIihHcFPNU+NtZdPJRsNeztd4YQBFBE8AsLk2Y9KKejWx8Ggd
         sFdg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681761; x=1774286561; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=hK0fBCxIwxOiBxPaMoqxQF+imiCcAxc/yw2H6LFTo6ba/Ze9JUzCoBXbgtNIUtA/wI
         yt5M8ZHPxZ/Vu9TPHAfuIle8Yw/ktlFP15k+CxXFyhj9RMaxs6b2Y7Z7nfVo4GdLQUGf
         APuolglyjkVqGcX1PmFRwBVzxhKMwq9kUzjRwg74JXgvW1qEqgBk0uibiZsn8+KUlEH5
         45zSvjW/UUY43d8CYb2UeoJ0f0UA4z9kTkwSzoQBYXSW+y+klpKpgbhe/sr4L3RMElTa
         kNUqNd6fSM2VoBk6ERn9cH8RxX6Oc5hijWe0AW3G/X6tZRfEEgI/Uk1et3aVgxX9AXQk
         IP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681761; x=1774286561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=jDbn6JQP4EzY3HL675VZIvfXMn5o8wYikedsqR7Hbqvvb/QRUuVjV7TiB4SwkGcWsr
         p8OPE02BgVC6gDOYxtrtrTXdMOhQKLwojcvuUnqeeuT6ll5Ybfj1agLnfkiB0AhHmCul
         GvazWDHMC7fvfEyS/ykUnrEZb44v65A49ycnAyAmQFxWtfdQK5c8boUQGQTVYkJZNy0w
         RYX8Kvqcd08xRQzEsXHALkd39ELTUdvU9QBzlA5VCyo1MKSlEcUlN8+2nh+1KrBYd9j3
         H3NSne0zpvMQ1od8dGh8SWgHt/XMDW3Txy9CKY5Muo0dajlEK4eH3cUi3wjEGAo43MMg
         etHg==
X-Forwarded-Encrypted: i=1; AJvYcCXsdBIPFty/axrALMot1Rk/50GAlx4p+xPMWtBSViKc0AdYSGV6GJRIXz+svXfHO1DC0vAf@lists.linux.dev
X-Gm-Message-State: AOJu0YyRujlf+USBBL7BM16ldgytDOGJ/ZKlEFrSjJylRzqqb0hCPD5W
	Wu7G1ax56EMeRU/uIiEZDT3uMD3MCw8fU2WWU5D+Cz5THegkER/Q42nQkAMFhbW1xlhp0iyKEAa
	exhK5B+eFDJyN+nNzwfJCZDqsaH0gkbc=
X-Gm-Gg: ATEYQzxJbzZyC/Ki2xxewbpgN2VinDHGgweVgQAvGVIq88E9ZT3RdAypS1yt2Oo+A4f
	t2VHUNmfL2maj0HLgEHNYfwOMt3bgsJBfI85llno6B8b5HK5VGLJ6nWR1lLlu0IwMugD8eLtUpX
	yrUwrdOnvXosU8jC2p60M+bv3Ib+62+21UwUPElrzkgkzIHYBajHe2FnaAjg5Qfwf1LSHoFYaBx
	chulpxTkxHkeYmRNVXi59elejV3/ULAggrWIM5zl0H988LKZrpejoM085PoaEWdbazxpGmAprFM
	Cw/mK7AQ0eKLyAvaKyAcIVboJIjY5pYJOzV26x7UvwbiceBvi1WjXJI=
X-Received: by 2002:a05:6102:32c4:b0:5e1:866c:4f8a with SMTP id
 ada2fe7eead31-6020e52dbbamr5788771137.20.1773681761421; Mon, 16 Mar 2026
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
In-Reply-To: <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 23:22:29 +0600
X-Gm-Features: AaiRm519sCKeQSwcsAIj83-gCCcOtyLCMrhp4On2ZfkD8pFyjWgcliN3tJw964Y
Message-ID: <CAFfO_h5pyrTTwJ3swHNLT=ZyeTJG=eHw626bTqQqAh+GeN3PhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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

On Mon, Mar 16, 2026 at 10:53=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Sat, 2026-03-07 at 20:06 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> >  fs/ceph/file.c                             |  4 ++++
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 63 insertions(+), 2 deletions(-)
> >
> >
>
> I pointed Claude at this patch and got this back. Both issues that it
> found will need to be fixed:
>
>   Analysis Summary
>
>   Commit: 7e7fa2653ca57 - openat2: new OPENAT2_REGULAR flag support
>
>   This patch adds a new OPENAT2_REGULAR flag for openat2() that restricts=
 opens to regular files only, returning a new
>   EFTYPE errno for non-regular files. It adds filesystem-specific checks =
in ceph, gfs2, nfs, and cifs atomic_open paths,
>   plus a VFS-level fallback in do_open().
>
>   Issues found:
>
>   1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips open-ti=
me-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
>   but does not strip OPENAT2_REGULAR. When a regular file is successfully=
 opened via openat2() with this flag, the bit
>   persists in file->f_flags and will be returned by fcntl(fd, F_GETFL).
>   2. BUILD_BUG_ON not updated - The compile-time guard checks upper_32_bi=
ts(VALID_OPEN_FLAGS) but the code now accepts
>   VALID_OPENAT2_FLAGS. The guard should cover the expanded flag set.
>

Good catches! I guess for issue 1 I need to modify the line in
do_dentry_open implementation to
f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGULAR);
right?
And for issue 2, I should change the VALID_OPEN_FLAGS to
VALID_OPENAT2_FLAGS in both build_open_flags in fs/open.c and in
fcntl_init in fs/fcntl.c, correct?

Regards,
Dorjoy
