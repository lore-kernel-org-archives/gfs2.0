Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186599;
	b=fdmnAuH9fzrWRUsGv0mokq3wROrMazF51quUKmTU/wfPWHddhby7Fb5OYiY7BugDe4Qr
	 9qJdAUZbUIbeV/+A56kj04JaMI8OCuCh5gWI4StKEInUYHSoewA4DhThNFwHeKXX5xznQ
	 LkkeQBMYiUgL61RzsyCSuIUrbv6cRrEO/u3Z/E443CN+svkZEkBQkwU+VJv/GAbo9KWRr
	 nrDbiiHgCbCVuNYuDgFAZb4JJCNswIuVa1A6TFouQfw1c1oX4M+s4VXE8puPVOQ4v6+Ih
	 jQ23URRlY3s9Gw0/H39KvjUhO9/S73ovkxRgkRKGRnfFhgHfJTq+E6GHTt7RTWlSeAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186599;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=rknusYU4360ZfLZlC0yT3gO1HyGFHSYoJcOfCxS0dBo62fkq9VNnt58CRAf3ozPyhkv8
	 SmkudPmoUJCLak1jEz3d3L/mLSO2oT0rGl/bqDd0vFosL6DAeTHecdIITtlEttfjZG9ac
	 bsHK0HnnlCfpGOJhiiJdAA+8BnQ3iZwUeyW8mPbOC41dLNnZLkYajawqldZ8XrWdHe9rP
	 iHCpYLhU1yTImF/gX3oj2BU7Jx3yD2VXQMfnhc2J7ugjjt7bYrBrSFXhUFDyWMn2yzqRB
	 y0z8wstfpOjzp4sf1oBxzVJUA8Wg+S8ZA6usNE2+auMf1jiMC6Bzzg6H/C/AZOlOUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZP56w4sc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48378606A325
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 14:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48378606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZP56w4sc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
	b=ZP56w4sc63v91u/w1PUxUnl1hmUqQuMuAfJscSUK0SIttyHRu0HoQOyydrMVE4aVDs6L9D
	jNmyUHibVk5szTacaZ0ARER9uquihUTW0rJ30NCD7b8S4ZRJbI18WGCHx+13fovmviWSO8
	Nj9UWRXjZL9QTNPjE3b5JPtkMnf2YEE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-hML675EXMJ6XVLQgWMR0xA-1; Fri, 20 Nov 2026 14:56:36 +0000
X-MC-Unique: hML675EXMJ6XVLQgWMR0xA-1
X-Mimecast-MFC-AGG-ID: hML675EXMJ6XVLQgWMR0xA_1795186595
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0d978e4faso15182527b3.0
        for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 06:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186595; x=1795791395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yo11Eu8FVAj7BGu1LSTgiAFkJHWFwxDpoxDkv06j5xE=;
        b=PWrnaa8mJNKgatmnm6d67WbjFn3FU0+h8LH02GFKE0+Snb0JjbOUsa6pWoopVCps7b
         5oa+UrAOM1yjIDqq2F1r36dEC0GnPjkSzWhDuADO7cGZ9YwZqHgybhMG4OdWFuaytvC8
         NrKZY2wijvn2TPjFq/GJkmEwQgoXHqcXuBiUZyuKLAlNue5IInt4VEdELt/SFt9szP9f
         KDId/qOJgXNaO1f1Zlp6VL+3eMp83Ob10oJ5rzl8Y0W6fHyjg9T7DqcpCYemBz9/UssI
         YJp2O+nZ0dQDKlPuuMNQI38wtGxHlYX2SYP4UkeMaDMkYwWh35HSwg2qZ1fpTVJ7xbA9
         Zqlw==
X-Forwarded-Encrypted: i=1; AL+hErHHD4BNVjmck8x4MrQDICYpiXKEqnod8Q2tyF1NNp8HmvkpYJVMrqX9OA18/ixgvJn0nQrD@lists.linux.dev
X-Gm-Message-State: APuU4Z/NmBEacQOgTg/n9IPls1sQfPfhpqvdD84SuvOvzHmQSrSEt+4l
	nQYViFZh9ea5M3To6x5oXLMEnOkY2AvLNQBWMdgGOKBzmMKGWiN4RM9XyXPrGYloeKdHkYQajir
	kIaOmJwl40KyPcby4kGemY2BLmbOmSG/jcYrlwJLe3vEcMN3afwyEqk4O4mqz1baInZOHJJggkk
	ip7U+YpFHs9v7XiFthrNOGzLMVSxYzUw==
X-Gm-Gg: AZFdTZdym5S4kd5kAAq1Cq4pADcw2pKRN42CSdT/bTEaZB8E/WC2K8L4hVhZIYa9JS8
	2FQ0EKHYGTq+jUJbItiq0NbyO1k/OtWxu1w6TVm9hQH5y06kTt4NaC0Xcz+lPTeg3I9vydne+QL
	dGwlx+JgDDlETw06yYagGJyLaHFhJ5SBA6WaRRXKaTRa50qD+dy0lsp4hXhyhOg0W1Ftyr9pnMg
	EFov/AyOoqHSDB3ROjQUwVkoZpCnQFjpU2gVUNOw3tbNg==
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id 00721157ae682-8b5204dbbf4mr17277367b3.48.1795186595404;
        Fri, 20 Nov 2026 06:56:35 -0800 (PST)
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b5204dbbf4mr17276957b3.48.1795186594739; Fri, 20 Nov 2026
 06:56:34 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-2-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:56:23 +0100
X-Gm-Features: AclHuK-KPlGaYd21yj03z7EB2mPfkwiCHXM0MaDKxGgj2dWKdsX7kpdNXfvoeLg
Message-ID: <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5M4z1gFIF-m_7r_-S-nOX8I4duC25QXeF0I8fMrYC5I_1795186595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:19=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> Iterating the cached inodes of a superblock is open coded in the
> kernel. Add super_iter_inodes() for the callers which can work without
> holding the sb->s_inode_list_lock.
>
> For super_iter_inodes():
> -- By default, it runs @iter_fn with a referenced inode and with
>   sb->s_inode_list_lock dropped, so the callback is free to block and to
>   do whatever it wants with the inode except drop the reference the
>   iterator holds.
>
> -- Three flags change the default behaviour.
>
>   INO_ITER_F_REFERENCED restricts the walk to inodes which still have a
>   reference.
>
>   INO_ITER_F_NOREF does the opposite: only inodes whose reference count
>   has already reached zero are handed out.
>
>   INO_ITER_F_NOIGET tells the iterator do not call __iget for the inode.
>   Used with INO_ITER_F_NOREF in evict_inodes().
>
>   The flags are not orthogonal, so super_iter_inodes() warns if an unknow=
n
>   bit is set or if INO_ITER_F_REFERENCED is combined with either of the
>   no-reference flags.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>
> ---
>  fs/super.c                     | 87 ++++++++++++++++++++++++++++++++++
>  include/linux/fs/super_types.h | 29 ++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index c5a0658f7aaf..204c70c7f179 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -171,6 +171,93 @@ static void super_wake(struct super_block *sb, unsig=
ned int flag)
>         wake_up_var(&sb->s_flags);
>  }
>
> +static bool super_iter_check(struct inode *inode, int flags,
> +                            ino_iter_eligible_fn eligible, void *priv)
> +{
> +       bool ret =3D false;
> +
> +       if ((flags & INO_ITER_F_REFERENCED) && !icount_read_once(inode))
> +               return false;
> +       if ((flags & INO_ITER_F_NOREF) && icount_read_once(inode))
> +               return false;
> +
> +       spin_lock(&inode->i_lock);
> +
> +       if ((flags & INO_ITER_F_NOREF) && icount_read(inode))
> +               goto out_unlock;
> +
> +       if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
> +               goto out_unlock;
> +
> +       if (eligible && !eligible(inode, priv))
> +               goto out_unlock;
> +
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               __iget(inode);
> +
> +       ret =3D true;
> +out_unlock:
> +       spin_unlock(&inode->i_lock);
> +       return ret;
> +}
> +
> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @iter_fn: called for each inode, with a reference held
> + * @eligible: optional filter, called before the reference is taken
> + * @priv: caller data, passed to @iter_fn and @eligible
> + * @flags: INO_ITER_F_* control flags
> + *
> + * This function iterates all cached inodes on a superblock that are not=
 in
> + * the process of being initialised or torn down. By default it runs @it=
er_fn
> + * with a valid, referenced inode, so it is safe for the caller to do an=
ything
> + * it wants with the inode except drop the reference the iterator holds.
> + *
> + * The flag INO_ITER_F_NOIGET changes that contract. It runs @iter_fn wi=
thout
> + * grabbing the inode with __iget().
> + *
> + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> + * Return other value if the iteration breaks.
> + */
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s)
> +{
> +       struct inode *inode, *old_inode =3D NULL;
> +       int ret;
> +
> +       WARN_ON_ONCE(flags & ~INO_ITER_F_ALL);
> +       WARN_ON_ONCE((flags & INO_ITER_F_REFERENCED) &&
> +                    (flags & (INO_ITER_F_NOREF | INO_ITER_F_NOIGET)));
> +
> +       spin_lock(&sb->s_inode_list_lock);
> +       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +               if (!super_iter_check(inode, flags, eligible, priv))
> +                       continue;
> +
> +               spin_unlock(&sb->s_inode_list_lock);
> +
> +               if (!(flags & INO_ITER_F_NOIGET))
> +                       iput(old_inode);
> +
> +               ret =3D iter_fn(inode, priv);
> +
> +               old_inode =3D inode;
> +               if (ret !=3D INO_ITER_RET_NEXT)
> +                       goto out_loop;
> +
> +               cond_resched();
> +               spin_lock(&sb->s_inode_list_lock);
> +       }
> +       spin_unlock(&sb->s_inode_list_lock);
> +       ret =3D INO_ITER_RET_DONE;
> +out_loop:
> +       if (!(flags & INO_ITER_F_NOIGET))
> +               iput(old_inode);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(super_iter_inodes);
> +
>  /*
>   * One thing we have to be careful of with a per-sb shrinker is that we =
don't
>   * drop the last active reference to the superblock from within the shri=
nker.
> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_type=
s.h
> index 72f4288e16c5..974d3c087952 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -80,6 +80,35 @@ enum freeze_holder {
>         FREEZE_EXCL             =3D (1U << 3),
>  };
>
> +/* Inode iteration callback return values */
> +#define INO_ITER_RET_DONE      0
> +#define INO_ITER_RET_ABORT     1
> +#define INO_ITER_RET_NEXT      2
> +
> +/* Inode iteration control flags */
> +/* Only iterate inodes that still have a reference. */
> +#define INO_ITER_F_REFERENCED  BIT(0)
> +/* Only iterate inodes whose reference count has reached zero. */
> +#define INO_ITER_F_NOREF       BIT(1)
> +/* Do not take a reference on the inodes handed to the callback. */
> +#define INO_ITER_F_NOIGET      BIT(2)
> +
> +/* REFERENCED and NOREF ask for opposite things, so only one may be set.=
 */
> +#define INO_ITER_F_ALL         (INO_ITER_F_REFERENCED | INO_ITER_F_NOREF=
 | \
> +                                INO_ITER_F_NOIGET)
> +
> +typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
> +
> +/*
> + * Optional filter, called from inside the inode's i_lock and before
> + * __iget(), so that an inode can be rejected without paying for a
> + * reference.
> + */
> +typedef bool (*ino_iter_eligible_fn)(struct inode *inode, void *priv);
> +
> +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> +                     ino_iter_eligible_fn eligible, void *priv, int flag=
s);
> +
>  struct super_operations {
>         struct inode *(*alloc_inode)(struct super_block *sb);
>         void (*destroy_inode)(struct inode *inode);
> --
> 2.53.0

Sorry to say, but this has gone quite a bit off course. Can you try a
construct like iomap_iter() instead?

Thanks,
Andreas

