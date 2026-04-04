Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29127FB18
	for <gfs2@lists.linux.dev>; Sat,  4 Apr 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315843; cv=pass; b=HUXBBbOx1pYdFPN6OmjIm6i7vVN2L9CSOjt4OsrtbFKRwZSCv2kqapNgTiw3a+EQlbvGiq9qVgxuHDzrtN5sqg2Kg51IoQdWmeo4r8HP/l1BVOZnR2nFFwHeMtvqnPFwml7REuX0JtXkoOAhniLoGxrnHkhMbzkz8ha32yJDfpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315843; c=relaxed/simple;
	bh=iJkUBTHI8W8Yq4GfHOouMA+FFui5r396sp7Kzj9EaR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfuvNlM/AI4nTnVu4x5XZojSTeYH9V/3NqaxczTprrXKQ3Z08RSE8TKLivwbAjba6CHZsmUJYr/ej0iBj0vLRteDqpApjw7JJfml72wX1//ivC06GUkktsNaU14p9ZDaDs3zXOJ7XfL4oPAoagvmytSyXCLDxp/PcFGn2M92qtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZltTvEZ; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZltTvEZ"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9539d9f1675so1721072241.2
        for <gfs2@lists.linux.dev>; Sat, 04 Apr 2026 08:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775315839; cv=none;
        d=google.com; s=arc-20240605;
        b=dLmf5zTFtJZKNKhIcUZgugeWG9/l6Cg5nwz1yonZ4tdNETxni5ZKA7XH1Qwfnozf4j
         dyhZgBpZADQaAsuDUzxQyjPysQYOzLTwYHkcd6hXQif6EOIPSUFATD9gMhOPsNR688u2
         GbM6/xI7tPc3fIeoYVtrJLXc70j86MqatyReaGYzyY1TVWDGK1U6Ok9cxFvIUKSGIVW2
         XkaTyeRLrNBfeOjWGbxxrw3Ad3BU8T+auHdB2F88RiYzQRFanReQGkSdk8m0rJw8YOK7
         UkRW8kMMGrLgKMMHyCQoKrSnQ+hvUncMQlNHcQ0cKZGxEtkah+plBxFq3jhVghli0lU5
         brww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        fh=p8HGv0EHSPwqdR66murGx8aSh29d+IoDUXbU4dcTURw=;
        b=QPbl+8nrHEe8FTsQ6Zaa8BQ0ZBv7Rse4zUUZsWj4LnsIQjV4gfUyIE6PzfQflWeyOx
         xTIA4txC07KofChiIHMCRfylQVeGxZ1AHU1EsmRwE1xSvTGbnONHQJd28H4PX+AgYUtk
         mfooi9JRAeUjtnec6ZPabzcKLwNgbaPTNcIeWLlVrmQgoLA2vMJfnvhCKTxWZZnL6MPe
         w5J9IUnVaJgi7Q3fBzAHHnQ1tqNflPBub4bH5Uif2yD5kIn6Yy60vHa4iRg8CKx6H6y4
         ejyrwhtPkiiJ7/UF36EKDGOt68iLdZoNO2Q1ZodYi3HggKzNMcK5i7F7gxfkYO5vG6vM
         s8FA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315839; x=1775920639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        b=YZltTvEZDDGhtdRiUh/xgQQ/xenpnEoshlTIeWVsddat4qe+qftvLVC96hMaj2bLze
         7NXeCw1Zvuv2PS4PSMB3S5rtUPZ/fR7qWe0s1OWuX73mtwCT2H7Mj/v+I7qznWQ+2G7F
         R2fswCC3fPxTburl8tkHSp0OqEVKYo18ACBdznpD/djytfKmz+vw6YIERHPU+zXQz1wm
         YSKJrsiCMGwoD1JWJjilUg20wa9XQZHW9KV1rmZmGM+1gPaqQlzVgyHP6udJ9xX8hIJG
         3Z6nl15wiWzV2LTDx7NwNLH5618sl1t4CrhEAiWIw7XILcDJzLAodO/UPBUU9EimUX/X
         80nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315839; x=1775920639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1MY/rgzPW8aC/hTJxOzosMzWp+WcyNGjBARHB4s6mE=;
        b=UHBeoAnLZM1sXM1/VA6OqBL5nrZsxmITet6Z4Qavf+5H/+wofK7PX+baDu1UNW3mNE
         QQ8yRexiVuV3er2I4YTb0IKQoLdoWj7JsCLAnRY82v4xODKqdinhxZ1CbY7mwu2XRzAi
         4UW3YoXFluiPAjvO06ncxuc3wTjd6WhlxA/waFjb5iNYDzZdkqrzx2AipSyRIuNv2iHw
         b9Su5GJqLGOLPsw56BB6j4cKmoMA91p8llvLI4cMfYLaCFTrDDzDv+EQ1fhBA0AMznIp
         JbWhV3w1dPGFI50jUDQik1wIcojht4QJD2mks9IsOzWUXc1hissiXU3NZZ+GxqKzETWZ
         /wEw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5GQXRK9O7adzUZiGyEvKhMyRAa1qGfpso5kMUCzH0OdBSRscjfu5W0y/3U6CZUGbfMJr@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl4qkYkxJ0Xq/uTJwpw/cvf1esIWmKpKuajapOSFr2NsGqmIbx
	kCC2W5Yo7LjJkfYucYe1wabYrPCkN/CcT/uWr9ZNcM3UXZjvuDjXeh4wq6fhYqrbJLyLSFji/l2
	fz3NwHbzoKpf6SMOy289eEoltRbpUXXM=
X-Gm-Gg: AeBDiev7Q8jJCllpzLoNy3TVFnuslZRBXFaEB/beM3wIjkktt6S2pqdl9Z2Ar2bKYbZ
	6KSjw6Q8ux6HjOlR4bv+qWwNiTWhuiB6vKlBvlZlnF+3Er54cCs4WxYnNHv0S6eS+FvzLPZlA8Y
	ALdraSuKLy+z5yEyxfZSeu9MYdCx88dmfOhw5BQpQKp5PbcdC9Y7uxs+AcEvy4xDLKtUnxTAqsu
	sK7Pj0yxqDm8jhoGCJzsf83njg6ZPLeFM51Gb6PX36N4VCRYQymBFOs7n1gwnUx7KKaoBfkHGm/
	QdhEqqQM2evctCY9Kw9TEd/Ddcl8kl8Z6IvBWbd/aaI=
X-Received: by 2002:a05:6102:6046:b0:601:f85b:efeb with SMTP id
 ada2fe7eead31-605a4dced8bmr2528576137.9.1775315839238; Sat, 04 Apr 2026
 08:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <e526fbdb450a593b575355c1c9ae21f286427275.camel@kernel.org>
 <CAFfO_h75dF2s83VNtUaNuRmto1NVVcxo7kN6eAtNtN3ME8mPiQ@mail.gmail.com> <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
In-Reply-To: <4385168f2147efb8131d5fe4209e88d2d15a60bf.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 4 Apr 2026 21:17:08 +0600
X-Gm-Features: AQROBzCQF2-YPXzLWBuj6trmnUQAKh_7YQnhBAKjxSQrB6QucZDOdQgFzGpIDh4
Message-ID: <CAFfO_h4dhsXji=+FjO9EikX0_oUUDkWe8tC1F7u4WqhNAjRB=g@mail.gmail.com>
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

On Thu, Apr 2, 2026 at 1:02=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Mon, 2026-03-30 at 21:07 +0600, Dorjoy Chowdhury wrote:
> > On Mon, Mar 30, 2026 at 5:49=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Sat, 2026-03-28 at 23:22 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE. EFTYPE is already used in BSD system=
s
> > > > like FreeBSD, macOS.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > > > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is retur=
ned
> > > > as it doesn't make sense to open a path that is both a directory an=
d a
> > > > regular file.
> > > >
> > > > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> > > >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> > > >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> > > >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> > > >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> > > >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> > > >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> > > >  fs/ceph/file.c                             |  4 ++++
> > > >  fs/fcntl.c                                 |  4 ++--
> > > >  fs/gfs2/inode.c                            |  6 ++++++
> > > >  fs/namei.c                                 |  4 ++++
> > > >  fs/nfs/dir.c                               |  4 ++++
> > > >  fs/open.c                                  |  8 +++++---
> > > >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> > > >  include/linux/fcntl.h                      |  2 ++
> > > >  include/uapi/asm-generic/errno.h           |  2 ++
> > > >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> > > >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> > > >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> > > >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> > > >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> > > >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> > > >  22 files changed, 67 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/inclu=
de/uapi/asm/errno.h
> > > > index 6791f6508632..1a99f38813c7 100644
> > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > >
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               140     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/inclu=
de/uapi/asm/fcntl.h
> > > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > @@ -34,6 +34,7 @@
> > > >
> > > >  #define O_PATH               040000000
> > > >  #define __O_TMPFILE  0100000000
> > > > +#define OPENAT2_REGULAR      0200000000
> > > >
> > > >  #define F_GETLK              7
> > > >  #define F_SETLK              8
> > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include=
/uapi/asm/errno.h
> > > > index c01ed91b1ef4..1835a50b69ce 100644
> > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > >
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               169     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > >
> > > >
> > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/inc=
lude/uapi/asm/errno.h
> > > > index 8cbc07c1903e..93194fbb0a80 100644
> > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > >
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               258     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/inc=
lude/uapi/asm/fcntl.h
> > > > index 03dee816cb13..d46812f2f0f4 100644
> > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #define O_PATH               020000000
> > > >  #define __O_TMPFILE  040000000
> > > > +#define OPENAT2_REGULAR      0100000000
> > > >
> > > >  #define F_GETLK64    8
> > > >  #define F_SETLK64    9
> > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/inclu=
de/uapi/asm/errno.h
> > > > index 4a41e7835fd5..71940ec9130b 100644
> > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > >
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > >
> > > > +#define EFTYPE               136     /* Wrong file type for the in=
tended operation */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/inclu=
de/uapi/asm/fcntl.h
> > > > index 67dae75e5274..bb6e9fa94bc9 100644
> > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > @@ -37,6 +37,7 @@
> > > >
> > > >  #define O_PATH               0x1000000
> > > >  #define __O_TMPFILE  0x2000000
> > > > +#define OPENAT2_REGULAR      0x4000000
> > > >
> > > >  #define F_GETOWN     5       /*  for sockets. */
> > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > index 66bbf6d517a9..6d8d4c7765e6 100644
> > > > --- a/fs/ceph/file.c
> > > > +++ b/fs/ceph/file.c
> > > > @@ -977,6 +977,10 @@ int ceph_atomic_open(struct inode *dir, struct=
 dentry *dentry,
> > > >                       ceph_init_inode_acls(newino, &as_ctx);
> > > >                       file->f_mode |=3D FMODE_CREATED;
> > > >               }
> > > > +             if ((flags & OPENAT2_REGULAR) && !d_is_reg(dentry)) {
> > > > +                     err =3D -EFTYPE;
> > > > +                     goto out_req;
> > > > +             }
> > >
> > > ^^^
> > > This doesn't look quite right. Here's a larger chunk of the code:
> > >
> > > -------------------------8<--------------------------
> > >         if (d_in_lookup(dentry)) {
> > >                 dn =3D ceph_finish_lookup(req, dentry, err);
> > >                 if (IS_ERR(dn))
> > >                         err =3D PTR_ERR(dn);
> > >         } else {
> > >                 /* we were given a hashed negative dentry */
> > >                 dn =3D NULL;
> > >         }
> > >         if (err)
> > >                 goto out_req;
> > >         if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry=
)) {
> > >                 /* make vfs retry on splice, ENOENT, or symlink */
> > >                 doutc(cl, "finish_no_open on dn %p\n", dn);
> > >                 err =3D finish_no_open(file, dn);
> > >         } else {
> > >                 if (IS_ENCRYPTED(dir) &&
> > >                     !fscrypt_has_permitted_context(dir, d_inode(dentr=
y))) {
> > >                         pr_warn_client(cl,
> > >                                 "Inconsistent encryption context (par=
ent %llx:%llx child %llx:%llx)\n",
> > >                                 ceph_vinop(dir), ceph_vinop(d_inode(d=
entry)));
> > >                         goto out_req;
> > >                 }
> > >
> > >                 doutc(cl, "finish_open on dn %p\n", dn);
> > >                 if (req->r_op =3D=3D CEPH_MDS_OP_CREATE && req->r_rep=
ly_info.has_create_ino) {
> > >                         struct inode *newino =3D d_inode(dentry);
> > >
> > >                         cache_file_layout(dir, newino);
> > >                         ceph_init_inode_acls(newino, &as_ctx);
> > >                         file->f_mode |=3D FMODE_CREATED;
> > >                 }
> > >                 err =3D finish_open(file, dentry, ceph_open);
> > >         }
> > > -------------------------8<--------------------------
> > >
> > > It looks like this won't handle it correctly if the pathwalk terminat=
es
> > > on a symlink (re: d_is_symlink() case). You should either set up a te=
st
> > > ceph cluster on your own, or reach out to the ceph community and ask
> > > them to test this.
> > >
> >
> > Thanks for reviewing. The d_is_symlink() case seems to be calling
> > finish_no_open so shouldn't this be okay?
> >
>
> My mistake -- you're correct. I keep forgetting that finish_no_open()
> will handle this case regardless of what else happens.
>
> > > >               err =3D finish_open(file, dentry, ceph_open);
> > > >       }
> > > >  out_req:
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index beab8080badf..240bb511557a 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -1169,9 +1169,9 @@ static int __init fcntl_init(void)
> > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_ND=
ELAY
> > > >        * is defined as O_NONBLOCK on some platforms and not on othe=
rs.
> > > >        */
> > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > >               HWEIGHT32(
> > > > -                     (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY))=
 |
> > > > +                     (VALID_OPENAT2_FLAGS & ~(O_NONBLOCK | O_NDELA=
Y)) |
> > > >                       __FMODE_EXEC));
> > > >
> > > >       fasync_cache =3D kmem_cache_create("fasync_cache",
> > > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > > index 8344040ecaf7..4604e2e8a9cc 100644
> > > > --- a/fs/gfs2/inode.c
> > > > +++ b/fs/gfs2/inode.c
> > > > @@ -738,6 +738,12 @@ static int gfs2_create_inode(struct inode *dir=
, struct dentry *dentry,
> > > >       inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode=
) || excl);
> > > >       error =3D PTR_ERR(inode);
> > > >       if (!IS_ERR(inode)) {
> > > > +             if (file && (file->f_flags & OPENAT2_REGULAR) && !S_I=
SREG(inode->i_mode)) {
> > >
> > > Isn't OPENAT2_REGULAR getting masked off in ->f_flags now?
> > >
> > Yes, I thought the masking off was happening after this codepath got
> > executed. Maybe it's better anyway to pass another flags param to this
> > function and forward the flags from the gfs2_atomic_open function and
> > in other call sites pass 0 ? What do you think?
> >
>
> Also my mistake. That happens in do_dentry_open() which happens in
> finish_open(), so you should be OK here.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks for patiently reviewing this! I am planning on sending patches
for man-pages and looking into some xfs-tests for this. But I am not
sure if this patch series will get more reviews from others or if it
will be picked up in the vfs branch?

Regards,
Dorjoy
