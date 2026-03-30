Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94487324B31
	for <gfs2@lists.linux.dev>; Mon, 30 Mar 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883261; cv=pass; b=kS+WaMBVLrOGU+tIx520GbvmFYAdQqmI7UE0LLjBJ3rR13Ff9T1JxfEacrkdX+UvV0gpcBOZ0KUIJLpSK9VHb5Nn99HA7jsBl4or3hb3vheGIHUVD0eMagx22KFI8mi49EnhXaijqO7F915bu6hPsyAZBxet9tfK8rIprGtqzGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883261; c=relaxed/simple;
	bh=/x13DKtZaVDG7yiVUGXh9eKmBd78HM6nIK9Tv56z6jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msI4nDMCqv1UoyN52kBs8GF4LoGOksxt/Yr/T7CMnT26Jzb/afP/Zf6gTYncAmjD1oHQ1D+u7OE41K9oj5kllTNbuZV8cQ8HXGTyoDRmGXKQzzo/C5ZObNvvizOb4Uk30xi4u07tfaJ6TeNaIF7flYAComUwRKTOh2wpJJD68Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKERoQM1; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKERoQM1"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-953ac1602f8so1121353241.1
        for <gfs2@lists.linux.dev>; Mon, 30 Mar 2026 08:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774883257; cv=none;
        d=google.com; s=arc-20240605;
        b=i0slDCeLiyffpjWpYrLhtl3OIinJPaVGfdDb4GQphDtPH8eRhA4xMMtN5MRmAr7SZA
         0zorQ5RHhdr2Qpy9Qs/pGiKhirlOHbGiwLQFfTvkxSYW4yRwEsa41+1KN2yNpAnGSpJh
         Sy+wlyL+me81beXN8zesOAvBJXPIKiyQcJ/Ng5TAKGkk03Ehh4ULpIDKDJOIFSf/9BsE
         sMOetFCkglJt0IpkCinZkIUjvaZcH56yhF+esSRP3HeGG4kDqFe6HdAgblIdLiXBOAHL
         3ZJfdhqOtp30r5PgUKUZ5qpSYexhzo9ChlrM99/14/pzubjFVmvrQkalym7Ppeu8wyWe
         qtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        fh=h1l5FowlI9DbbyI+FZ4RcDaWCby94yV8hIuI5GGWhWA=;
        b=YCDcwdzP92iOXo2GjI8oE8DgcSBILys750vJUC9CvmEZE/nPh/h15mNjKjMqdsSBs9
         xc1AmXs3W6gQSty58NHXzyxPazpldvvTZYND2n/qMqWgDr+FCgSVxejNr/kpZLFPnW9L
         xctiyd1zSqH2FZOmGhsWDfuKuUcW3uzKaaWP7XmeUGgkOdonp8aQGcnluVbAY6jGvFhN
         AKBVvo/bXk73f9c1qR603W+92dl/dREASa+Mb7rOv3NcCaOCgILoyR+ortyYnthMXCW1
         TwEK1AGvs3amhdoSgHUcOs4i+k0X9Vsp8nl4r+ZBiXMyTLO0HBalHQeD5Xv1yUhoRZsT
         VKng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883257; x=1775488057; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        b=qKERoQM1fVPBhTJQ9NOEB/hJZ4lRQ1vjUcbeqGdf6Asbcv5i2Z6Hzfj+Jz1/xOGVl7
         fi5t7m0ZAfQuuoCyWJ2Xz3F7UG9ez1nZWBa7ZDBcutTdp0B8c5DUiNu7peIXvjs7tnrj
         n6qJa4A0Q43iPSg2gFkU35lmy57GWlmupnGRLFPdtNkjI3hfi6DTp+fJYYdlfMssrpm2
         0+Wni5leP7nc15i6AR/M8c16El+5ylR4YpjWK+IZ5h8AOxZBhJJoayT7U0tTmKYAtGNo
         b95J97NunzQ4wLGF/eIx2F72lLpbxNzZCilzq82rXQ/0ClNtT3Rv1MMONFhf0Ks4wln/
         5lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883257; x=1775488057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i27yBCASimAbh8aqvQTLYNbe/ak/AL7sQPeMVmtc+JI=;
        b=TCEjTwsrd97LzbG367KJ0D6m2U8PDatHoo56zZzreDBf/a8jNs2fnxxx9rNSCl0eCb
         XxWpMR7TNqqf6utalmik13wa3g7aRSG06VphxktlSQfIqf0ZaREp5G7IQiboR6cfr8nA
         m9nGWjnpxZAYQFQE3vr79qsM4/d7DpZWsvGobmN8Um9+mcoBmjRsKziJInzAEnZUlUtf
         gzocfeLkj6tYbo2m5a3XBK4ZktNZy16y3t8M1Vu/QRWMgbFuR/5zq41XnpBKVdeVbSAa
         hwgss9+cbEZGbrwHp2mfSFPVDNaYSdvGt0v447b+KgjjuD3N1E2HvAjZLOsnQ4d4e8on
         wPMw==
X-Forwarded-Encrypted: i=1; AJvYcCWeLCfPyPTE0twdx0ZVMxuoo9Kwp/C3Sb/9oSrbBfH60q6N8ifNN5AMesDkAptktbGdNKey@lists.linux.dev
X-Gm-Message-State: AOJu0YyPTgce3hElZEkp+QSA65lE/zoBsM1/n1EQ+KKYAdrs5ju1/FRA
	MK9HYlUrak6n5DgIcjF6DRSD/OwbR7y3jCiRBavvwiZpybaUPAJJjJLr3E5UGEGb0caYnlgzBBA
	sqZrFWJl2y8RsldXgLUhYFhopZ210bsQ=
X-Gm-Gg: ATEYQzzhckSOV1dgssE21l5KJAqr4Bjg5YC94zphL7Tjiw11lENRIpYvnVpwLVZdEcS
	MyK3obT6hOyJj2Ys6qPLXsctOxSQMCvTcJnUr0vZ1kevWPWx5XwGRwxs6ZQzvfwpKISFhagWWOI
	uLr7ZrkzQ6kdvNRpTTgJV/hMdQc6YKhHURXAzlOSIuj0rVOmsbwC2fSkbkkbRlpAPg1sIaLAty7
	peglW5Ms29ZrXrAiZ1PkE8AOXL8Hny+cHcfCa4JmmL6uk0F/iKGeTQn0RJjdoaYba0Sz3l7zIjO
	dH6UxGV1GuDkOvMcnMhFWhzUTWsICaH3KMRilTDz+qw=
X-Received: by 2002:a05:6102:84d1:b0:602:6ccd:7772 with SMTP id
 ada2fe7eead31-604fbdd4504mr3414117137.2.1774883257420; Mon, 30 Mar 2026
 08:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
In-Reply-To: <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 30 Mar 2026 21:07:25 +0600
X-Gm-Features: AQROBzBiNZNQJDXYIA1g_QAQfKVpqrabu4vh65YgUWDTzh1Q_gvpOzHijv8ZYqQ
Message-ID: <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
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

On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
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
> >  fs/fcntl.c                                 |  4 ++--
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  8 +++++---
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  22 files changed, 67 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/u=
api/asm/errno.h
> > index 6791f6508632..1a99f38813c7 100644
> > --- a/arch/alpha/include/uapi/asm/errno.h
> > +++ b/arch/alpha/include/uapi/asm/errno.h
> > @@ -127,4 +127,6 @@
> >
> >  #define EHWPOISON    139     /* Memory page has hardware error */
> >
> > +#define EFTYPE               140     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
> >  #define F_GETLK              7
> >  #define F_SETLK              8
> > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uap=
i/asm/errno.h
> > index c01ed91b1ef4..1835a50b69ce 100644
> > --- a/arch/mips/include/uapi/asm/errno.h
> > +++ b/arch/mips/include/uapi/asm/errno.h
> > @@ -126,6 +126,8 @@
> >
> >  #define EHWPOISON    168     /* Memory page has hardware error */
> >
> > +#define EFTYPE               169     /* Wrong file type for the intend=
ed operation */
> > +
> >  #define EDQUOT               1133    /* Quota exceeded */
> >
> >
> > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include=
/uapi/asm/errno.h
> > index 8cbc07c1903e..93194fbb0a80 100644
> > --- a/arch/parisc/include/uapi/asm/errno.h
> > +++ b/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >
> >  #define EHWPOISON    257     /* Memory page has hardware error */
> >
> > +#define EFTYPE               258     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include=
/uapi/asm/fcntl.h
> > index 03dee816cb13..d46812f2f0f4 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH               020000000
> >  #define __O_TMPFILE  040000000
> > +#define OPENAT2_REGULAR      0100000000
> >
> >  #define F_GETLK64    8
> >  #define F_SETLK64    9
> > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/u=
api/asm/errno.h
> > index 4a41e7835fd5..71940ec9130b 100644
> > --- a/arch/sparc/include/uapi/asm/errno.h
> > +++ b/arch/sparc/include/uapi/asm/errno.h
> > @@ -117,4 +117,6 @@
> >
> >  #define EHWPOISON    135     /* Memory page has hardware error */
> >
> > +#define EFTYPE               136     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
> > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/u=
api/asm/fcntl.h
> > index 67dae75e5274..bb6e9fa94bc9 100644
> > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > @@ -37,6 +37,7 @@
> >
> >  #define O_PATH               0x1000000
> >  #define __O_TMPFILE  0x2000000
> > +#define OPENAT2_REGULAR      0x4000000
> >
> >  #define F_GETOWN     5       /*  for sockets. */
> >  #define F_SETOWN     6       /*  for sockets. */
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 66bbf6d517a9..6d8d4c7765e6 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct den=
try *dentry,
> >                       ceph_init_inode_acls(newino, &as_ctx);
> >                       file->f_mode |=3D FMODE_CREATED;
> >               }
> > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> > +                     err =3D -EFTYPE;
> > +                     goto out_req;
> > +             }
>
> ^^^
> This doesn't look quite right. Here's a larger chunk of the code:
>
> -------------------------8<--------------------------
>         if (d_in_lookup(dentry)) {
>                 dn =3D ceph_finish_lookup(req, dentry, err);
>                 if (IS_ERR(dn))
>                         err =3D PTR_ERR(dn);
>         } else {
>                 /* we were given a hashed negative dentry */
>                 dn =3D NULL;
>         }
>         if (err)
>                 goto out_req;
>         if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {
>                 /* make vfs retry on splice, ENOENT, or symlink */
>                 doutc(cl, "finish_no_open on dn %p\n", dn);
>                 err =3D finish_no_open(file, dn);
>         } else {
>                 if (IS_ENCRYPTED(dir) &&
>                     !fscrypt_has_permitted_context(dir, d_inode(dentry)))=
 {
>                         pr_warn_client(cl,
>                                 "Inconsistent encryption context (parent =
%llx:%llx child %llx:%llx)\n",
>                                 ceph_vinop(dir), ceph_vinop(d_inode(dentr=
y)));
>                         goto out_req;
>                 }
>
>                 doutc(cl, "finish_open on dn %p\n", dn);
>                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r_reply_i=
nfo.has_create_ino) {
>                         struct inode *newino =3D d_inode(dentry);
>
>                         cache_file_layout(dir, newino);
>                         ceph_init_inode_acls(newino, &as_ctx);
>                         file->f_mode |=3D FMODE_CREATED;
>                 }
>                 err =3D finish_open(file, dentry, ceph_open);
>         }
> -------------------------8<--------------------------
>
> It looks like this won't handle it correctly if the pathwalk terminates
> on a symlink (re: d_is_symlink() case). You should either set up a test
> ceph cluster on your own, or reach out to the ceph community and ask
> them to test this.
>

Thanks for reviewing. The d_is_symlink() case seems to be calling
finish_no_open so shouldn't this be okay?

> >               err =3D finish_open(file, dentry, ceph_open);
> >       }
> >  out_req:
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index beab8080badf..240bb511557a 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> >        * is defined as O_NONBLOCK on some platforms and not on others.
> >        */
> > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> >               HWEIGHT32(
> > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELAY)) =
|
> >                       __FMODE_EXEC));
> >
> >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 8344040ecaf7..4604e2e8a9cc 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode) ||=
 excl);
> >       error =3D PTR_ERR(inode);
> >       if (!IS_ERR(inode)) {
> > +             if (file && (file->f_flags & OPENAT2_REGULAR) && !S_ISREG=
(inode->i_mode)) {
>
> Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
>
Yes, I thought the masking off was happening after this codepath got
executed. Maybe it's better anyway to pass another flags param to this
function and forward the flags from the gfs2_atomic_open function and
in other call sites pass 0 ? What do you think?

Regards,
Dorjoy
