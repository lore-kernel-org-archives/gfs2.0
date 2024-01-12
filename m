Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359961799C
	for <gfs2@lists.linux.dev>; Fri, 12 Jan 2024 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdDzESMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705018044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tYjcKqhrU6WbfLDJ6/l4ERbp/7MAis697mfyVb6apQ=;
	b=fdDzESMDjUDg8YjYt5M8w9fijpHSD3pUFy41riIqp2l//5dMXp7gJXNVObeiDsiNVvZtxU
	LubZACiGKghmhnFhG9j5+h67u7Gt6BdoYx2ZaPNJeB5wXxuA1rQLpPoL/oasi1AuNCHqYd
	K3/jnFMntnzV+EwpjYBaTI9PgJqzXQc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-IKdPQe4xNdS5e31i1h9c1w-1; Thu, 11 Jan 2024 19:07:22 -0500
X-MC-Unique: IKdPQe4xNdS5e31i1h9c1w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d4a645af79so64351225ad.3
        for <gfs2@lists.linux.dev>; Thu, 11 Jan 2024 16:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705018040; x=1705622840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tYjcKqhrU6WbfLDJ6/l4ERbp/7MAis697mfyVb6apQ=;
        b=cfXW+pCriTYI/94M0l4VrAxaRa34Jhl4QLwgXAYkjW72WazOtlBiwcZl3Lyvivba3s
         EmF02d0NiMlOuWAPIT0RRKl8i2fI7y0YGLfjbLKdATD25//gLk9G/NhNY6DtMIJrv9T+
         oDfzxXertk/s2/bVboV3jKwPGCdkZ5Okxq3S1V8w6ZI6FmtSyDz9xsN0nS8fH39FeXBA
         JfMwaFINhqLLxQfZi9eicGymicUlMkB5XHUFR1Yjxl0H9otFSFV4PCbVRJpdp4nqWmre
         OO6gK2gZDw41uYxsoMJH7bHDioVUROH5OETQCPTSudf3cim6PvrcQ27Hk+QoxzLkgZ6S
         aO+g==
X-Gm-Message-State: AOJu0YwUVCkVeqOsZwadWPckU+QeevqlrEG5pFnskyzo5eWgd8BYs23j
	l8N/rtxfb1M8xfHOdKkKcNvK9HQU7kkeFtS1eGMPKtwQDvApdAdq2KOZbVCiMJpIxUZV72UniyH
	sXGtFPinmtgiO87B3qa3MqABzCexMIXn5RJTPEmYQ6cpzhIL3
X-Received: by 2002:a17:902:f542:b0:1d4:9d07:eb13 with SMTP id h2-20020a170902f54200b001d49d07eb13mr127950plf.99.1705018040616;
        Thu, 11 Jan 2024 16:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkdxDnUk7dfYz0Ea3x3rRWQL4ZpnxSvz/S1aFjWLBDVATJmX1T+fnw9F2B9XaQzTaSY7hxIDkOzeunpd9CHDY=
X-Received: by 2002:a17:902:f542:b0:1d4:9d07:eb13 with SMTP id
 h2-20020a170902f54200b001d49d07eb13mr127936plf.99.1705018040253; Thu, 11 Jan
 2024 16:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240111174258.72123-1-anprice@redhat.com>
In-Reply-To: <20240111174258.72123-1-anprice@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 12 Jan 2024 01:07:08 +0100
Message-ID: <CAHc6FU7O81t4dvrLaLFVt6EjkiwUowQD+8gBg8bNfF7mXYEFkQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Improve gfs2_consist_inode() usage
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andy,

On Thu, Jan 11, 2024 at 6:43=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> gfs2_consist_inode() logs an error message with the source file and line
> number. When we jump before calling it, the line number becomes less
> useful as it no longer relates to the source of the error. To aid
> troubleshooting, replace the gotos with the gfs2_consist_inode() calls
> so that the error messages are more informative.

this looks acceptable to me.

gfs2_consist_inode() is used inconsistently, though: in some cases, it
reports an original error; in other cases, the error has already been
reported and gfs2_consist_inode() only provides additional details. I
guess we can't have nice code.

> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---
>  fs/gfs2/dir.c   | 28 +++++++++++++++++-----------
>  fs/gfs2/glops.c | 34 ++++++++++++++++++++--------------
>  fs/gfs2/xattr.c | 28 ++++++++++++++++------------
>  3 files changed, 53 insertions(+), 37 deletions(-)
>
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 560e4624c09f2..47355c87efc3b 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -562,15 +562,18 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct =
inode *inode, void *buf,
>         int ret =3D 0;
>
>         ret =3D gfs2_dirent_offset(GFS2_SB(inode), buf);
> -       if (ret < 0)
> -               goto consist_inode;
> -
> +       if (ret < 0) {
> +               gfs2_consist_inode(GFS2_I(inode));
> +               return ERR_PTR(-EIO);
> +       }
>         offset =3D ret;
>         prev =3D NULL;
>         dent =3D buf + offset;
>         size =3D be16_to_cpu(dent->de_rec_len);
> -       if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1)=
)
> -               goto consist_inode;
> +       if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size, len, 1)=
) {
> +               gfs2_consist_inode(GFS2_I(inode));
> +               return ERR_PTR(-EIO);
> +       }
>         do {
>                 ret =3D scan(dent, name, opaque);
>                 if (ret)
> @@ -582,8 +585,10 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct i=
node *inode, void *buf,
>                 dent =3D buf + offset;
>                 size =3D be16_to_cpu(dent->de_rec_len);
>                 if (gfs2_check_dirent(GFS2_SB(inode), dent, offset, size,
> -                                     len, 0))
> -                       goto consist_inode;
> +                                     len, 0)) {
> +                       gfs2_consist_inode(GFS2_I(inode));
> +                       return ERR_PTR(-EIO);
> +               }
>         } while(1);
>
>         switch(ret) {
> @@ -598,7 +603,6 @@ static struct gfs2_dirent *gfs2_dirent_scan(struct in=
ode *inode, void *buf,
>                 return ERR_PTR(ret);
>         }
>
> -consist_inode:

The code below is now unreachable, so I'll remove it.

>         gfs2_consist_inode(GFS2_I(inode));
>         return ERR_PTR(-EIO);
>  }
> @@ -609,14 +613,16 @@ static int dirent_check_reclen(struct gfs2_inode *d=
ip,
>         const void *ptr =3D d;
>         u16 rec_len =3D be16_to_cpu(d->de_rec_len);
>
> -       if (unlikely(rec_len < sizeof(struct gfs2_dirent)))
> -               goto broken;
> +       if (unlikely(rec_len < sizeof(struct gfs2_dirent))) {
> +               gfs2_consist_inode(dip);
> +               return -EIO;
> +       }
>         ptr +=3D rec_len;
>         if (ptr < end_p)
>                 return rec_len;
>         if (ptr =3D=3D end_p)
>                 return -ENOENT;
> -broken:
> +
>         gfs2_consist_inode(dip);
>         return -EIO;
>  }
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 45653cbc8a87d..ae8d4731907d1 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -409,10 +409,14 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         struct inode *inode =3D &ip->i_inode;
>         bool is_new =3D inode->i_state & I_NEW;
>
> -       if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
)
> -               goto corrupt;
> -       if (unlikely(!is_new && inode_wrong_type(inode, mode)))
> -               goto corrupt;
> +       if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
> +       if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         ip->i_no_formal_ino =3D be64_to_cpu(str->di_num.no_formal_ino);
>         inode->i_mode =3D mode;
>         if (is_new) {
> @@ -449,26 +453,28 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         /* i_diskflags and i_eattr must be set before gfs2_set_inode_flag=
s() */
>         gfs2_set_inode_flags(inode);
>         height =3D be16_to_cpu(str->di_height);
> -       if (unlikely(height > sdp->sd_max_height))
> -               goto corrupt;
> +       if (unlikely(height > sdp->sd_max_height)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         ip->i_height =3D (u8)height;
>
>         depth =3D be16_to_cpu(str->di_depth);
> -       if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
> -               goto corrupt;
> +       if (unlikely(depth > GFS2_DIR_MAX_DEPTH)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         ip->i_depth =3D (u8)depth;
>         ip->i_entries =3D be32_to_cpu(str->di_entries);
>
> -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip))
> -               goto corrupt;
> -
> +       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         if (S_ISREG(inode->i_mode))
>                 gfs2_set_aops(inode);
>
>         return 0;
> -corrupt:
> -       gfs2_consist_inode(ip);
> -       return -EIO;
>  }
>
>  /**
> diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
> index 8c96ba6230d1b..17ae5070a90e6 100644
> --- a/fs/gfs2/xattr.c
> +++ b/fs/gfs2/xattr.c
> @@ -96,30 +96,34 @@ static int ea_foreach_i(struct gfs2_inode *ip, struct=
 buffer_head *bh,
>                 return -EIO;
>
>         for (ea =3D GFS2_EA_BH2FIRST(bh);; prev =3D ea, ea =3D GFS2_EA2NE=
XT(ea)) {
> -               if (!GFS2_EA_REC_LEN(ea))
> -                       goto fail;
> +               if (!GFS2_EA_REC_LEN(ea)) {
> +                       gfs2_consist_inode(ip);
> +                       return -EIO;
> +               }
>                 if (!(bh->b_data <=3D (char *)ea && (char *)GFS2_EA2NEXT(=
ea) <=3D
> -                                                 bh->b_data + bh->b_size=
))
> -                       goto fail;
> -               if (!gfs2_eatype_valid(sdp, ea->ea_type))
> -                       goto fail;
> +                                                 bh->b_data + bh->b_size=
)) {
> +                       gfs2_consist_inode(ip);
> +                       return -EIO;
> +               }
> +               if (!gfs2_eatype_valid(sdp, ea->ea_type)) {
> +                       gfs2_consist_inode(ip);
> +                       return -EIO;
> +               }
>                 error =3D ea_call(ip, bh, ea, prev, data);
>                 if (error)
>                         return error;
>
>                 if (GFS2_EA_IS_LAST(ea)) {
>                         if ((char *)GFS2_EA2NEXT(ea) !=3D
> -                           bh->b_data + bh->b_size)
> -                               goto fail;
> +                           bh->b_data + bh->b_size) {
> +                               gfs2_consist_inode(ip);
> +                               return -EIO;
> +                       }
>                         break;
>                 }
>         }
>
>         return error;
> -
> -fail:
> -       gfs2_consist_inode(ip);
> -       return -EIO;
>  }
>
>  static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *da=
ta)
> --
> 2.43.0
>

Thanks,
Andreas

