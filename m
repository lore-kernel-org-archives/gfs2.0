Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C42F12AF
	for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505013; cv=none; b=Ozpxai6nrtH9hoBLX04PsDg5iCy7MupGdinC/x30kGDFu7BjVrLi5rJN39vO/aRRGhcF7mVH0D5rcHX1YFHJM7XipGgZrX1Qx0W7gwYL7/ROnN1QT7Z90DQpjcdI7zGGVuhXfiXk4YR80+iIwcT3Wderm+KybDYVIWqWYuKLKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505013; c=relaxed/simple;
	bh=K7EKeFZcYOwWj32Ok6OEcoTNGvsHPX2vPwhKzUVyoug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R03LYhjyTnYxUbnAY8t4frXG1u2dOlDJ10UtXgN+JgSlupDSwrPK+KXaWjAa4D3EWBpTjYKCvtDd6VuC6JCjkMkacQp1+terAwRo3MtjAJPFm43NgTu31ZnNZ6hOH8mbAXdViNzA4ZAAZkRP87OGpE0ncY7exvrgA/J5VO9oCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEekY90T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEekY90T"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso2620574a12.0
        for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505009; x=1769109809; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=nEekY90T4vPVH1ZBzrb9i02rBhSXN0D0YkVjYCf+wY158o3/iCS1FO48NRaCPQR7g6
         YNhtWU+ERCPEOY+Kc00hj0PtSrkM5E7Y9CPI7OuUXRY3R4xd6s79xpLtvMx6BZIukYI/
         HHSs4kNGjyZwx2Im2ZDuKi3YPSChdgZnD0ms0bF7IPONElFXV8Ii5r0qFmAfeSTsfivs
         urj9z3vJskvsx4FP54V1n1btkRmZKg3NOrmZQoKnX8OHLIfqQ77bQyGOQGmsrM5eXb0L
         R2rtpCS+8QkHlL7+zRtWCM0ZfJh8pBovg6WCBd1qDQfUcAC8uOOZelgclKIP2sTCn6nX
         P6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505009; x=1769109809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HpNW/ml4xLa7Q+ZYoOd6NCigBelaQL2RtJ0aaDh9mI=;
        b=LbjAQN63l714NqMAWHNcYpDQsT5+vWOuJ9VgWaCE+aQbmI+CxhbLhf0lnr9agvSV+0
         i5wM/o03eFA2Q0m6gwLYoFCUzCMhkxpPz4iJn+L67arueRbM7vrDqiqr97gI4BKMOktZ
         BZNazxh59NwUfmXiSpuwwJ6HGgWh8yvaJIKQi9rIByh0ArTruBOrugWQynq6CuO4w0WI
         jmquS/a5jX0LhQDlKTeenWXe5HGIsLLLgX9clxzVOX4Ltlh2ZKoXMDJkqa38VZD8TxJl
         YHC/PiZJWYEN8KRCtHgejzawKxrMZGRlQ4KEtj5OIzmr06obi+ob2w0BGAHmZdnz0Q3W
         T7bw==
X-Forwarded-Encrypted: i=1; AJvYcCWY3jhfQuQ7eBNa582jOtf7SxRUC20cKtbsEgmSQtvip11CZSILQQUKkxV+HM6WQx0YJ1BH@lists.linux.dev
X-Gm-Message-State: AOJu0YzqdWGHLu7qWJfQFz2xiekEgI507xvIK+efy108938qgkGzuxuu
	gydyN9LOpwZwFQ9XDv/82DaipZ5jvVrtyt5bwK2bG+FFeVzFMAtT+7a2YFIc6ZaKF6tFaqNIdJ8
	HuJPsvOVauSL3JJOnwmjzHsFgvM0EeDs=
X-Gm-Gg: AY/fxX6Zeiwpbxx1EtPpoxC5c1GUmjXMuYsd0EXhu8/gqvVHgRCc3iet0hEuVl9QenK
	LVl0Ir0eBYvXaUQ1H87WgNW6RwoVC3Zw2aiVqvqVWGQygW5fHv8koQn8Dn5MfLoKOFdEwOV1DcN
	dOWZhI5K++9dGp6wVtBZGKnuiWknW/S6XL0pUhZ/kPcLFqi2OTVPkHeA/JPoJ5XKSYE14xo5VMO
	BmwbSZ/drw0zhzn4fJHG+qfn6ZssqrEouqMZNPfsSo4Mg1MYwY2GL+ix6vQR4rD3d1rHB++MUZm
	oIXuAr6QA9/q6zmOvhQqN5NKHXEGWA==
X-Received: by 2002:a17:907:3e97:b0:b73:7c3e:e17c with SMTP id
 a640c23a62f3a-b879327e30bmr63085666b.44.1768505008810; Thu, 15 Jan 2026
 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:23:17 +0100
X-Gm-Features: AZwV_Qj21qC7f0_83CWGwxMbCuhLisWPoHuSIOsZGqfnrVByhBJVGvUqJqXdQ-8
Message-ID: <CAOQ4uxg304=s1Uoeayy3rm1e154Nf7ScOgseJHThw4uQjKwk0A@mail.gmail.com>
Subject: Re: [PATCH 29/29] nfsd: only allow filesystems that set EXPORT_OP_STABLE_HANDLES
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Some filesystems have grown export operations in order to provide
> filehandles for local usage. Some of these filesystems are unsuitable
> for use with nfsd, since their filehandles are not persistent across
> reboots.
>
> In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
> and return nfserr_stale if it isn't.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsfh.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195da2e=
8678b3fcb3d444d 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
>         dentry =3D fhp->fh_dentry;
>         exp =3D fhp->fh_export;
>
> +       error =3D nfserr_stale;
> +       if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES=
))
> +               goto out;
> +
>         trace_nfsd_fh_verify(rqstp, fhp, type, access);
>

IDGI. Don't you want  to deny the export of those fs in check_export()?
By the same logic that check_export() checks for can_decode_fh()
not for can_encode_fh().

Thanks,
Amir.
