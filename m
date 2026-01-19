Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1313A35BE
	for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840990; cv=none; b=YR4UmGoKPmP/oP9qta7ddPTl1sBxdX6XGFKVL4g/cefSEQOgtQr5XUZeQKGH4QJ6JAfZh/Sjty6lbr5Tt8wt1LzQn/SGQpmMzaGQwRjyh0AEQdd3Ukdwrd09Ip1o6RkL9Wm5zbec1DTO87FcHh9dq22Vv5VzIEdQWqPm5jD/LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840990; c=relaxed/simple;
	bh=vfqhKWwiRrrnfWX4CrdJmI0n1g3fK/4yGHAQKrOzOrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMJaM8fSDfPTK5siT9dCqQGlN3IL+zhUjXn+j+A64bn4p5dxS7FVyYaYFoBKIdNOe8C8c8Z1wg5GmtKILGRiuwy2kdn7ln/uavwn8lfizrQOK5ITo0c84R2DyBEg5voFIzGz8wrq++wNPX1TVS4xXXWnAQQSNKIa2YpzetV7NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlnE+Ovg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlnE+Ovg"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-653781de668so6489507a12.2
        for <gfs2@lists.linux.dev>; Mon, 19 Jan 2026 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840987; x=1769445787; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=AlnE+OvgC+C59ATzlrDbJCf/UI+uhnkWYlLtfDnGdRHU+ks3JDWTujFVyLnsrKmZ3e
         r4sRBH/6I0iTRDX9k7Sk8bZlxYGVCgnn6jwuXvK3OIn9+M00pHPOjdW+H7yjxj4yIzhf
         cCC/VNros6yokyZt7E9fJcuV+6Tav1gehtRpFTxSCfVnJ63F0Olmu7/QtplMjS0NB0GP
         mzu1k7g4ODHcSf/+qCbnDEUfArL0r6/fQWp3nO+AaEUIcLxWQ4rlKi3Xs8gg1InAgL77
         CqRkrLCdJ6MRC90Q0BGvzwWMdvXFSJ8n0BdguFoCtNf9Gm/pqjVolTUxPTc7h7ShfjtP
         p1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840987; x=1769445787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=E89awYZLRk1IMmkObUy8R9OjbYBNBcmEpZE37YTu3r2+hF9nRVZFPB4XArxxCTWNdC
         qHUHYfEKFvW/RzOaDQUx9BEdkmIJyoRA8kZojTuBIqqtWUhX2GYmEmrDX8mc7/t6w7lF
         QNEJAEJZD5hsZEt0Z0EdoPRKnFnulMggyX7Jo2IdDp0TLks3nMJqa1wuoNSFxYa/CvCN
         w7hx7azyqnSCQ5wnhwTQReAyggf89eQLJDST61GqdmeatKYlQJwHHxUq4QzjY0rPRxrx
         oYSc1Z2Ic5lKO2dO5e2vOk+1LuN2qNoR421Bcpp6c1wYZBA2Yz71dLhI5YF29VmRGNoA
         pkbw==
X-Forwarded-Encrypted: i=1; AJvYcCUmcNtou681XTr2dHuJhbF8IIBhw4PAB1s9FhADcD4//4gUipFFl9ImjNmeH2slE5OXohMe@lists.linux.dev
X-Gm-Message-State: AOJu0YzP07bZcBSYyierOLNvtGgHGXlnME+wCUThhsK7i+mDtctvUkGl
	6VbRE0+OdFC8RntArFJw948cJgyFzGCoEKj7K1GCzs60K4Oepc35h8jpSy+KYkZLB6BiYdG92dZ
	71u5d3IMhZSIjSwUEOQaqz4AexiUvQDA=
X-Gm-Gg: AZuq6aJ7cVg305oynDWcVKFllTh8jgsp7+a0yU/MLDVZTrKz95uios37762XBcZQHw0
	zCpxHh7wGKAkz4hrqBNy28+SKn7y5DsI3jPgH1uLYGoK34pPHPcPCeuKuSeHBn/kk3sOtSi72Jf
	qDW6/jf4BxMzeZ23D+veeIHIQTBqKpqRcWpNpPrGXae93XkmVGJnglqqO+4pN+sFrpPkREohqrE
	RfTsnfFS/+4d4Ihz6KPRF3wKkfcZiTcn+j4BKHGJLKHinwLuZY68gs+sZETKDxUQaQmEQ7eeRj7
	pTAdhrP4t8U/+f4/SvZeIoeOpkTeww==
X-Received: by 2002:a05:6402:4304:b0:649:b200:afe9 with SMTP id
 4fb4d7f45d1cf-65452cca909mr8384256a12.27.1768840987066; Mon, 19 Jan 2026
 08:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:42:54 +0100
X-Gm-Features: AZwV_QiQ9eetgKyRnXUMiKJDXK2vIOYhTLzpDlKP7IN3cG_hSRVA59Z6sNZRsnw
Message-ID: <CAOQ4uxgXovX-rPuAE55D8x4jbNOQdAKJH3O5gpHJDMsT7kNGgw@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
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

On Mon, Jan 19, 2026 at 5:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
> indicate that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8ee=
f9360ea268241ff 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations =
=3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>
> --
> 2.52.0
>
