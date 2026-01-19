Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA63A7824
	for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841016; cv=none; b=iwWzV/HYYeMc7IFrLloVW46zZMLt07HurmFYFCexLANqPStFYYyI3PU2qGL8FCmXK+6K98mBRMcCI0H4Ze7gXLscqSBd25rFhl7GuwFUzba9wPlWIgGsMXvjlAdxD0M91n7BEJMCq29N60X70RPLzZZmSH6q+aDXRbcZ0ECoask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841016; c=relaxed/simple;
	bh=CQ3IL8fqKnWIgvRv+IOv0Cfz8J1ZjzxNV5oCIJJcLY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RigvV8gVAQ6lrBFAOApDNlm78XmHDZanQ8UqSvC8XnpFHMzkHo7TTPoyvcis17+3hIBIRLXveiF7B/1Z/mlRITTkXEqcaYQJerTTHx89LWuTiY+KlRFbEZCwOczmVZMx+7G5QCbdxwY2UKaMxmMhFmAPn/5AiLrIuLOHurcj9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dte2BOvy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dte2BOvy"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so7600344a12.3
        for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841011; x=1769445811; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=dte2BOvy9smLAXf5E6CLaxy4tWSqQ2FY38x+55qUVbbzuT7XXop0zJNXqK74mRl0n7
         zc0l+bRgzNa1x8ApGP93awlG9F0kDIOnXt1XEnjEGDMg+0TzsA/6oyXDITB6yFD1Qd3n
         NvwR1Zhy1E+oT/EZLxrCqMdcXq0YSQzKJyrtKKi/BGQdEG2CtVcSSJTE5L/jdh2KSx8E
         fqzMrm27MSkyi5WUME0GnE4xe7oiqIbu+IR5NByDHmhGqtXSib4zAFrjaUH7MJl5pix/
         jJnihfIz/MVKxoIgnEcu2LUee8Ej9oq+gP7cCsKUM2qgLjs4c9S0woSDGySv1f9q9xuG
         Qn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841011; x=1769445811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=n8If0xAJAapKhyEjbjlbTcAwvvxz4oemiznYDHQRhYVfXk0GeeOKKBvhZYqP/yiaNU
         J3K8plTBzGLT2wkKJsyD3ci1tXE0hFo67xX16RjP3iL9vfKrfm2yIw7+rDl1PgcakHxr
         IVSTQ9rDxoTHoCk7sXWTcU7dIizj7q5kBPkY4VyeIp1SnNf2S/Kx9exGgRe5bY/ZYTHq
         LwPPOGDm+YSQMLKK96xk/O0VziHSeV3HMWnYk2uPBlUjtOQ5uqvC7cdyS5i0oUGDvjcp
         9mJAlKJkPN6N4cq/6+ymDkvmNAjBnjldLy9yxPjWbgpNJGgIqXbIAfi0DJy0NCHgOagb
         exjA==
X-Forwarded-Encrypted: i=1; AJvYcCWkCjhctzrH940KtnePsL61tIvmkY7xMN8RaGe+rQIOQIgvpGb8Hs8NC8ECiYigraZjlvS4@lists.linux.dev
X-Gm-Message-State: AOJu0YxRR6nc82VrWZqfl9/zrdzx5XBHJb2QPXsRUYYsf4Ol4zB0yLMF
	k9VDOKXtPmDHyraYHP9kZ+Jbp9LPHxwaKIFAbj5uutyuvMqyTkhpGt5cMrzgSUShTf8qGtyweMY
	8we9cJQsu+nPdKoTiSzVQi6XB7Iec+MU=
X-Gm-Gg: AZuq6aJUYc6gLAL+Gxl33l+d5RedDAGsRIDx2r8HSRq4krrLuK7Q9JlhECXq7y/no+7
	HuIWnuUx+fzWOcy2nEbhsRCQceoTEqQis5lnY9GiC/XiIWkXg6zah8Hqk6F/mRzDZr8mB9sgjbf
	PReEk6EXgrbzABuZJzK4Tvpnt1M9cSJdGcjsV+0g+3DgRzUqgaqZBjdGepQVjk1s0rpOGLVOHgd
	05Vlok19y/TTAc039tbsZLxpRdHr2bRE2K0n8Rygzb8BPEm7ZQaFDeNDLnUKNucBjwpb3Yi9DEZ
	tiwUSma20PRRVYIwz1UYLuIASeMZUNoDAruBr4b6
X-Received: by 2002:a05:6402:5106:b0:64c:584c:556c with SMTP id
 4fb4d7f45d1cf-654bb6192admr8530585a12.30.1768841011353; Mon, 19 Jan 2026
 08:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:43:19 +0100
X-Gm-Features: AZwV_QgQ6YFmczFqASwqjyOa509PoCTPsOB-sET1G173IBHOd4X5kFjH9N6z5MI
Message-ID: <CAOQ4uxjyTdf21G1Y=_5Eox58drVPA0gAMeSQZxh=T36_yzssNw@mail.gmail.com>
Subject: Re: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777=
b913dae1e2d0741 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_o=
perations =3D {
>         .fh_to_parent   =3D fuse_fh_to_parent,
>         .encode_fh      =3D fuse_encode_fh,
>         .get_parent     =3D fuse_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  static const struct super_operations fuse_super_operations =3D {
>
> --
> 2.52.0
>
