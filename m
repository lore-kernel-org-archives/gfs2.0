Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AD3D1CB2
	for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503272; cv=none; b=bAolIHUW6rnRi3NZyqLRZIEg66PHBMXTdWEzwZB1g3I4cPxQLDzh35heNMfAAhd1BLeJv4o6ysZoAynurZ4fE70/6Y2EDuT5qjnoDoNJwLcMn0v9/NJz6BmVJYbB74zY1+xz1rWkwlR/q1T9NgQAmZSOZCHHE12pgnaoQWNdi8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503272; c=relaxed/simple;
	bh=AgB8BlDrSqCt2vWmdgQdkVNbgorviCbIMxtlMVxqyDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh3gw2nhLp9pWMt5mDqgvC5bRApsl7ajSCCIIBb6d7Aih00Wwd8lIBdXZpn1S4lJ7FfvJOrF8eMFLrH9grrpOJkSQeLQo2L2OKgBW+chOLG2qxCFRJRBzATZrZNtLzwKRwq6jUMs8fzJ8WD6ctpEqaYNwFkf8DBiCtLEaHXMNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keA0UF//; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keA0UF//"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d28870ddso663000f8f.3
        for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503269; x=1769108069; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=keA0UF//LoGcTcjLbnAo16BQWZbxuX9OQ/UlfT2s/yWzz4gT1A75fZLq0MvIxtvTRa
         KOBBFO2hT1j9itptCbAcitY6drTwmmiJq5fjIllYtLY3zM2aSo+dEvNLvOwJQL4IVd1O
         8W/qQ36e2PVpD6uKWxTwUiDDwKtwCgbgoN0xmgA+q00Vyk5Y+Pf99biNxm7TNp3BfigU
         jtlsHfHkmETd6OHaTIryoFOVfYcJyWe478pRxEmDRZhG6P3LQddz4NlvyjU7YUqu3wKf
         SEj3IgnGyxal3GEUEgUCj14qWhUnc04YBKZgN9yhUUsvIievOl9qtrQAnft2SVcK+w73
         FlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503269; x=1769108069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R/pIR9g5xBWqOZmQj/jDCO8xKQONNisoQQHHakrcMdk=;
        b=g7HzO1EigCyKpQW2QXJpuO3yVHGWuSXdDULAYmhIRqSF8rJsaZwLBhTk7UzsQ0Twhx
         7wU4g3TREYNLCNNwwkMGuDpfC8WJKFtr5Qm5z845sf+ErROWBYZDhWoSp1O5Wx3qcn6i
         aIz1BV47G2yTLnDoXP6BL5/3LrtpDV+C9UplckTe6shzOGAIr/8V6OiAOk0m43mSjvbo
         M626ctFJ/xbyvJKCQAKzGvA2caw9Jl/8+Ra1sYYyjAzb/IDcHaDmTouJ1g0Wnn5emD+u
         S2jPQIfvRdvzWk74YSIzczLfcD8KbCNw9fhUoAiZ/SbJuji/be+JytJPdqeeG6Ua5v1T
         iTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXCa43jaS4KnzeQvevmCHHkIUk9jNmOAJqRpCl8c9cq6+rO2x0bNAuu7C0pO1vjRzbQ04ym@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxypbyg3aR4vyyH0k9k6s1OpflsAtCC3xGAEgYVi/GjOf70Udi
	cstraHxAyCreHQR7fmM0g9iG2nfcy86tWXplXBgyrOHFunwzWtEmYc83r7IFY/7g/qotKNe/cxK
	dllIOtvoxJlps+xp6GHb3vLB5ylxQZcM=
X-Gm-Gg: AY/fxX6CazeCiCgJ7HwpLLZ0tbOhXHFmYz72VYwrnOkJto0TCaY7obSoAfz/9UEROke
	wxmo2qn8lDuN+e1xPzT0iu5vcGF6O2FaSCE7zM+/7/TZR+Q5J5DcqaEfWgqD62vvvdnbvcL4tTU
	P47txfzLWmVryDEs3Iec3I/ySHgvaci87HbhVAHUkswcKkChaw6y1KjJDGTIwwviHGEowGHvCn5
	p7I1JO6zfGFhd5z4a+T3d4nkd9Mz93qrT+8xfF4x/NtR5FVloY12DKIkTthVkv+bAjTUb3NC5rd
	hd6E2iZYgc6pgrDhUkxPgR43VcM1yA==
X-Received: by 2002:a05:6000:2313:b0:432:5c43:76 with SMTP id
 ffacd0b85a97d-43569bc17ebmr434376f8f.39.1768503268480; Thu, 15 Jan 2026
 10:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:54:17 +0100
X-Gm-Features: AZwV_QgNgqINU2MW0ct-_EKOImgQ1uAwJfq7nKBHPoIgHpyzlMCSNbXGV-6zTEg
Message-ID: <CAOQ4uxh4VaVL9PD7-_Op9Xs-z5Qrx8g6x2x5FccujQX-Cw9RqQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] fuse: add EXPORT_OP_STABLE_HANDLES flag to export operations
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

On Thu, Jan 15, 2026 at 6:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..1652a98db639fd75e8201b681=
a29c68b4eab093c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1208,6 +1208,7 @@ static struct dentry *fuse_get_parent(struct dentry=
 *child)
>  /* only for fid encoding; no support for file handle */
>  static const struct export_operations fuse_export_fid_operations =3D {
>         .encode_fh      =3D fuse_encode_fh,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };

These are used when the server declares FUSE_NO_EXPORT_SUPPORT
so do not opt in for NFS export.

The sad thing w.r.t FUSE is that in most likelihood server does not provide
persistent handles also when it does not declare FUSE_NO_EXPORT_SUPPORT
but we are stuck with that.

Thanks,
Amir.
