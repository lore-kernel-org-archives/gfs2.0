Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC52F3A4AD5
	for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504464; cv=pass; b=NmFh1hgtzAmD+Suln4NZEReKn+UPZdGoy9HUQmZ67IjElj8yNd8dBOgyFGtHAbyDSsLDKfCDJj7O21qvn2DFJrG+zw2A2X+8sVQW6l8cRX5gGhHrFF37csNStDuvWKqcEBJld5203oOD56n7mSflsrYfcZAbTWKHoYk1o7WjGMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504464; c=relaxed/simple;
	bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIup8lgMjVk/tjAViHvzHnKUPdDxusg6VaZAr9ksv+oeDQVJJL3n2gor7DaIwRycHhXauew9uNRWgd+OKKQkcFOIzezECIkRgr6QJIeS5K21mRv1DnhWSZNifuxKynLQ/ABqpOPidKhiigvCXpRepo2Tvlct7mVKxa1PKP4pU0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBJFYY17; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBJFYY17"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee974e230so11957145e9.2
        for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 11:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768504461; cv=none;
        d=google.com; s=arc-20240605;
        b=QXUxwbgQYL5D1R09LvKYPKhbfmZYqvlWQNQMgo9uOpOJq535ezgnGQWr1VdkGtdINq
         T5NG6pbxvygi1m1BfVc2J3YMg8a0ucEaN6QXzOTD/JZ1XImVYNz6a7FKEnk7ljKCsvuj
         i/CXM4pkQTy89XnDXJotPtOXc9KIAFvWYpfKoK9OBesY7dRa2tYZz8XUyhRUc8cVocQR
         sB4XHcubNCbST2bbEe/adO33EtClkI5vqh6ghLCCIWUAPg4YBFIa8UT3nUYTSMsV7bwy
         1jNMymmWOUoiAbSMUvU4006IjyhpC7swxjxHksgiDRymXT/yO4QSX7UgmiF90RSkLvJG
         coUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        fh=9CFQXGtlsX2478YJ/JFDstJCm+lg8m7sAfcgj5gOipU=;
        b=WXUr1W8MOuq+RTLVf4d+Ys8VRA1BZdNAIu6QL9o4HBCCve4N7N72cQu+P89oOtAZDV
         t634mp4eSDuqnCXcomf2+REb5jtkdHRIVU7WN6qltgWw7RrwUOLkUnwbcwQQBo0DuPxR
         YmLHjg70hUj2OQN9rpKGgTqrdK+cBI+vlVUlXC3IvS6QUxPCQ/ixGC+fFxXx4UkofwV6
         OBGza8JHNDcGGGLhhyGl4GW5vW9/A2FXA0bYMu4vIAf3JSZGTrH6ITmp5xwnZJXf74zl
         ZWpnqx1+p4yko6HLJTKNXN1mnZzCj6L9nFjSMtKRqE39SGjak9ODLAwZerLrWhY69swX
         iAHw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768504461; x=1769109261; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=bBJFYY173slYj0lBnYonPJSrwhkaL1adHu/x1wOrsSOLvXeYqBdxFZTieyP+oOKoLj
         eabFMN1pSWXPuJfWQ+d2Xz9921O8J24lrI8yd+V9XnEQjt95SfFZOZQWnCmrXVndfjMc
         gaOMsa9lh2gRaWZHbd6p7iiaDCToDD9Y5yUTBW29TDiMGSDBn859YhLCbX1EVGBaJJN3
         F6oq+5P0n2/AiMbLcE+xRRD+Doaccae/ZJBKunreIScVmnmDeRLj9DtTUMY/9JVcwTug
         YjqVszlxASn751Hz5RDrxv1uZex+HjIuqUVRbwyoN/Psyt3PYOWomA/jtCeE9smjJGsf
         Tl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768504461; x=1769109261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpVL1RB5I8PR85y4mxEedr9T/Q0DYVA2jeDelSaqSc8=;
        b=u+0UwqZMFsaBcMN8GpjQTpUf+Q3GXXs2S+Nz4xK+AhrRo3mOFaBBFfDTcw0SLDOIk5
         qlr/Dc5AEhp+mejyJ85pFt7qukVj995l0Gu0ULzcgzhoJN3hiwmVi9UzJPEj+aUyQWjS
         6RDSZDngShnON1FW6Cj3kOiRxOYTSidSGVDTiEOn0f6wbohYkWuZnI1v3gMP2OxBMjUP
         9TbV+OnlkKueo91tkNbIXDNtdgSDsvpMGXTvvdafRS9txb/eVGtqq0DiO/v0igflRxGT
         M5Wsbm0ShZE+BQxADPNUNC/kI3MB5P8bmMxYsU3x9kmzqNVFI5MpgNoHRlJ8E6LQRFUI
         aPhA==
X-Forwarded-Encrypted: i=1; AJvYcCXMT+0bcXeV63qRYXzYEolP7ZlZyU/G/CmBVzgS+esp8nZWz1ceFHSf6msCANzhu5SbbdPk@lists.linux.dev
X-Gm-Message-State: AOJu0YzSHmpvicz4rh5YAQTXivo+B70yjyLr4B4tjZd5j5gieyt9mfz8
	vvB1/gEQmN7MsoZUjhawM2GHPPfXcfYJWyO9PDgIqudHf1H2NRsCw0D1OyOwsahJQ93vNfArdHd
	SXN+IuFqYSPNhLMHEYaUWh8qVSgdh7vY=
X-Gm-Gg: AY/fxX66AGFpVDx3LBiGNWXUZTe3ZeMAcccDsBM39IlKeUQuegYz6xAj/dN56oH+ovp
	aI28OoiztFYTHmBWphu4+wTI0XZgbvT8L1ZdUvDfUIUtkSKPreMEvPGtqLQptXC3b928PIeRCUo
	HMIVZLek4Rhr4p0+BeSRSASQeH25DHtul5qJqijE8+vi5ssghYEmUMiJj669dMXWNKY9RL89LT1
	a0lmW7fJALKmf4cyEUwviO0cBud5fZGuI8bCpAlz73LQ/nNRQdAPGTqLm3p2RJO3oxbd9PJ60OD
	sk6OMPNyUOkdpz+I4f5ucpMl1dZ8Bw==
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4801e30d482mr9929055e9.13.1768504460920; Thu, 15 Jan 2026
 11:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com> <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
In-Reply-To: <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:14:09 +0100
X-Gm-Features: AZwV_QgZJLcC_-bQ-_VIrtnGFnLgmiVjy_ytBB44u2cGVyBOwKNqVyWt_Jfm7Ds
Message-ID: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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

On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> >>
> >> In recent years, a number of filesystems that can't present stable
> >> filehandles have grown struct export_operations. They've mostly done
> >> this for local use-cases (enabling open_by_handle_at() and the like).
> >> Unfortunately, having export_operations is generally sufficient to mak=
e
> >> a filesystem be considered exportable via nfsd, but that requires that
> >> the server present stable filehandles.
> >
> > Where does the term "stable file handles" come from? and what does it m=
ean?
> > Why not "persistent handles", which is described in NFS and SMB specs?
> >
> > Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> > by both Christoph and Christian:
> >
> > https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e=
93c00c@brauner/
> >
> > Am I missing anything?
>
> PERSISTENT generally implies that the file handle is saved on
> persistent storage. This is not true of tmpfs.

That's one way of interpreting "persistent".
Another way is "continuing to exist or occur over a prolonged period."
which works well for tmpfs that is mounted for a long time.

But I am confused, because I went looking for where Jeff said that
you suggested stable file handles and this is what I found that you wrote:

"tmpfs filehandles align quite well with the traditional definition
 of persistent filehandles. tmpfs filehandles live as long as tmpfs files d=
o,
 and that is all that is required to be considered "persistent".

>
> The use of "stable" means that the file handle is stable for
> the life of the file. This /is/ true of tmpfs.

I can live with STABLE_HANDLES I don't mind as much,
I understand what it means, but the definition above is invented,
whereas the term persistent handles is well known and well defined.

Thanks,
Amir.
