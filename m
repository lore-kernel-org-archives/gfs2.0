Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6121684BE
	for <gfs2@lists.linux.dev>; Wed, 21 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022013; cv=pass; b=XSt4vp/6iBgWTn0ocdcsQ1Li5EQZvNHB/5f0JqeF8LhN5yaMyk+PQEwlg/V/k0eeR4jLyK9aIaO456KITcDs+/KndqAfxD9d7kX4zTmpNf7/uE3r9QXx+sLtCXiL6gFpKOzDg/oPeJuguKb2M/glXgYJSt6upPlzXqoyBgkBNyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022013; c=relaxed/simple;
	bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzON5uLaYJ4YHtAKDdKhZeymxwrCU/kQyhiIewdg0Yrk/ZH/6VGYxX7DCxlaluQj0M04WgxsACJj5UDrcUULM7mXiYe/7tvFszbHbKUvSD51ouXHRpVcmVbqNGdWqBwMj9XpnKb4MwpGVhiNk3oUWpFlXC91aGODE7P4ogCMHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMCoLL1b; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMCoLL1b"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so272340a12.3
        for <gfs2@lists.linux.dev>; Wed, 21 Jan 2026 11:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022008; cv=none;
        d=google.com; s=arc-20240605;
        b=J1RtNt5oKkWECRvMg//u0gHNoLm1IiHHAlPKnh0eIS5iPK0te8WKyc1gaT6B2he6QP
         AeJ4R0hI3DxygyMo/zKMYt7X++tKnOGPDNPz6QyL8aIf1GC1FA2hACvxkk7acgf4cJ4o
         E/AkuflwApauBjPzm1h229WPJxVYepTW4Ms/UtWkKOuY1uKu6MHN4m6W7wMtjHz+NKBT
         90zkbm7/aVFqhEegx6nnFxuyhDWDnWC182McpW6frsCqfZtv3/ChJTYeJ/3Ld3MT/4LK
         ivgUonOtPiXd+4uARWLLl8ZgWy4fei2ZhodpYC+roVObntffjnrgXiiVaNEeWnKB92n3
         J8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        fh=u5mvXkQ2xvdYuQreilbEkCKpkE/Kapz51d2HwRTeXhI=;
        b=PSipknXbsot3Kzpzd69C8jsEb0HuRSRJ9mQuTyx1n2KHYs52Dm4gRe7fGB6b5z/rk0
         +3fbz4vd1szBuKGFOwKC2YkawDkRbEL7Kxe5+mIXHV9Pl0I6bnva7J43LZrJkhCC21gL
         9pwvsWs13Y3y2z33bEZSvUatzfOSu4E0/FP9pe/8cLIaVvD4EWdVLyMCwUA8BD1VYr8h
         mWjmwmTEJ/YtDf9ZKHlOi+GUvsHZkTtU6nl40u+9d6zxVFVd+Se0oSHEz1uslPXPqfMH
         teKaSWRE2c/RvVSotJLcB39EdikRhX4kirWc/XiKJovKyxSK3xWmG9D5N0BwxnqhUVIx
         Sw7w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022008; x=1769626808; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=QMCoLL1bZyvirhp5VUtAW32YQlHA8H6aM35P8tzB8e9oGbypmucqmMUe8tXuUIIa3x
         xym/FuYuisZn5R+BhywsaCxFTFSr4phX3n7wNSwTZ04wO1RlPn5HSCRMCNxuvdBlyh1S
         jsg0Xzn9huSi5IBqzaxT929Tv0/fMbpul3wXQgTLFc+wy3w9aFZ4K5bWQRmLzb9bNtOx
         HBc136DE9/ZpmLZE10p1gsOBcDdtvpClYklcdzsDe01K7AnUc+VRkoc/VHWXC05e0cHr
         E3rNbFdFhfi5lGuHpAdbFCa5MU/7j5NgoyK0wl59QDxtGQN8kzluwtHzvEu0aLgcRxVS
         Xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022008; x=1769626808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
        b=Zx65qQXNuX4gQ7gL+1b3acif2n711Ub28QOBkfdVde/bCi+vK2/DuThxBR4MW0au/w
         TeeXB6+lqZr+g+nzEiLUKLDDIgqplRyTSZNM1AdO72mTJDUG/4w036LDEvnbv1vLrx59
         mlV+RSp6kNtymacZPtBuK2dJrrZ22EER++er0xWpt3lPsC8k9/XoS0Di1AHVL2fiNbqY
         Rswpv7MtUtOfEHUnmAPPax1/T8ofvL7TwNN1AzwleqYBCsgkD8ym+pBXLoH8JLuHnL0x
         pwVtn90m8IHeWK233/NKVlZNcNyKxM55gXshFP/zIEP1y2i3MQRougyFDkLC3U/PLCij
         ROjw==
X-Forwarded-Encrypted: i=1; AJvYcCXQC434TTVFq/7x4k9MzjsXsggfrejYE4Hvf525XA2cR+EvA7SdrfCeO4t4at6qhHIoc+mw@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7U9b6uwX87+ozNochWXtqS85A4Q6BZzU5Fljv+EMZxilVPw+n
	lF3A2Xpt7YUvsmMfn0axGcA33DdgYQXoUinvuLg4SDNhcst7MTQT5sFfFtVMawim9Fb/tKXuKMo
	KMGo9LhWo4w3/yrxhQxsNrmO3dQO/kMc=
X-Gm-Gg: AZuq6aKIIkc8gZfQepjcPbqxtn4oubQkwP50Jman4Zdh+Mv4Q6iJ5oe3GlmnIoCIfsn
	tYZu3KjnG1FSCPW9ijmGz2AYyF78MefhqBvXkA40tVAbZ0g+XowjcluipaPBWVhpBBjtZurWC4r
	wNtq154FiVM9pzx7WjbO+8r4vAFksh00SjLqFY+3cuIiUkTmErbFh0u29hq+rYbA/6ntRHLWUQA
	2JSYLxFG5pCes0BrnNyMWKBMAhe/7xybSQc7mvfYb37fspxiMKBcnDrhA09qfQwYVfdf9pURx4Z
	SVt8/S9MwjuxVLS0IQzTt/IQKkY=
X-Received: by 2002:a17:906:6a13:b0:b87:206a:a23b with SMTP id
 a640c23a62f3a-b8792f79852mr1477117366b.34.1769022007470; Wed, 21 Jan 2026
 11:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org> <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner> <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner> <176890211061.16766.16354247063052030403@noble.neil.brown.name>
 <20260120-hacken-revision-88209121ac2c@brauner> <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
 <176896790525.16766.11792073987699294594@noble.neil.brown.name> <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
In-Reply-To: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 19:59:56 +0100
X-Gm-Features: AZwV_Qh050IhjThhArfxNo-53HjJR0uLCcITEQOtntS-75Lw875opD6ONQssxps
Message-ID: <CAOQ4uxg+dC1o+6V7Nvxf8UW3H=0OvsGjEe76LNY6q8ZcpGDDJw@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
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
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
...
> > But if you really really want to set this new flag on almost every
> > export_operations, can I ask that you please set it on EVERY export
> > operations, then allow maintainers to remove it as they see fit.
> > I think that approach would be much easier to review.
> >
>
> We could probably do that, but I think the main ones that excludes it
> are kernfs, pidfs and nsfs. ovl and fuse also have export ops in
> certain modes that exclude NFS access, so the flag was left off of
> those as well.
>

For the record, my comments regarding fuse_export_fid_operations
and ovl_export_fid_operations variants were purely semantic -
it did not make sense to mark them as _STABLE_HANDLE, but
it does not matter if you set a flag on those ops, because they do
not implement ->fh_to_dentry(), on purpose, they are not
exportfs_can_decode_fh() by design.

Thanks,
Amir.
