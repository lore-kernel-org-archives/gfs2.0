Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD410214A9B
	for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501072; cv=pass; b=QKMj5UAaV15WzLO3iuJAVVkBp3ve9gsjMDgnnWVIVdMtSbVWwFUVCfB1FAsAg03CqaTyS6BNeOP6S4cl41+buYU5gOP+hOIiKXAbBCQl4tQyo86Ugwb3kHdaynmBH2g+InOsWXO2ZfcwER0jBnyWEc/25J+reMy5WHSwnc4xB0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501072; c=relaxed/simple;
	bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuQ9SjB7LfQ/4++r7AR/FL/J2CSexQ6uebNLlM4wOfDXygMyNG9iLGAUwL9s21BiJ88ODyvfU7v1SdoT2doSMNGoVIYxIOdNhTss/Ca07QL4yvwKOxeFFTB+sbAjkRIfyY1jNR4OpxSUI7a5MhlOxoU+NKGNMhWXc6d3Nda8klQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLi6yUR1; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLi6yUR1"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so1674495a12.1
        for <gfs2@lists.linux.dev>; Thu, 15 Jan 2026 10:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768501067; cv=none;
        d=google.com; s=arc-20240605;
        b=d91bD2ZLyKvolavV1H45tZvlUzg+btIm1LK4lKP3U+AMF5UqB5A5sA4oQySxZAK1Tc
         ++L1EibJaEB9XI3MaxB7c5Hj0Cl60expUMU6noeqzg1vxcjWh4AeSz1oQQR4WfShFLxl
         yauOpvhxJ/7F4+q7geGcZqIzhN73+7LSHI6kYajRIoS/feyj9/tFnQUpRJr0bIO1rTaI
         7PVt5is/1x33nKrbq7Y3n9nBsFpirqv/l15V797ziDlxPzpxryyxgfstRxO9h/XyobZk
         SncLsq+jprEiFl+GJ30Mp3C6C3aCfSPQJOwVlPtmEN7jJkjLu2wFlxm5k6AKs+i/n7BG
         yBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        fh=nN53ImZOwUb8nuP32aBTDfYnyAioNWPJY7ilJBF0Bn0=;
        b=ZUhYDZTGC/B9wvmeIzDfB58gANK5KBqfLlsxArYK6g/20lpURUjt92d0pb+1LrFh+n
         gfuJthAujPuxqEFYpDeVUpnCWCVllHWOX/Av1Sx575PQH8Ikyl3h+stWs2QRw93X7Epm
         gR/z6kTvkD73z9zekSbnAO81e63WRhMeYPbwRhStHKcPQO50Z2L04ItO5CxlSJXKJGqf
         AYfqACnsylRaMK1nGb3K6WylMHljq3ofwHhkHBKIeMdQZ+H+biCI/4tVVaOx4/VF1YNG
         erdxS6uExAyL9cy6WYQGZPVWcSyJGINfAf/vZpvjnMQacL0tlMl9/2/r6g1YfrO9Pz/8
         tJxg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501067; x=1769105867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=gLi6yUR12i3npVpyhbKivi+F2vYd3B2E52Xxgw12yhsRxVXZBeORK5T/lny77S+bl/
         EeXxBqLyA/HuJAlr0qWn6Qbv9GYP7Bsii89kGGvLPQsQtOn6gmpMe67doQpGqSHNhJGK
         6m3RaH11JF5qjdeKb8JXVVjYmoMSjVjVn3gC98ENUK71xWUV2CNl1TKmRVG6u0VnlqKS
         7e0EllwSPUpjztmTAxP8tZFHLk313rddgqvHykz3VCL2P8vRJkSb1Sa1Xey0s3UglKx+
         A/AhHr4RKiXcwTgEx/lT+G+pipaPwlxacr99319gy0uh3L+w3y3AS5ll5bhOszL6YL7L
         5EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501067; x=1769105867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=Ig1jf9EjjuiFJGGqt9Qj+wS/AEya+Wq25QE9GzO0BFWmNgZrPMIc2p/jpNKnENl4Av
         B1qfvbHUtwJVdXwiLuiWrcNXUQQnn4EULZ1GEbjNGODk2DyXhzz29pyOaa0YtVmtxtFu
         ukLfvBbfJE1/Rbg3yCXyTPSEAyV02XVYkltWFeUrz42odPlFRriwCrZeV1zSAHVh3/as
         E+KQbSdg7wes/Qnew3WMFyq4Ug7X4zcvrbM7sxpDKqeKjhvDGoX7DWX29uBtHRjkgxyV
         7TGsg3AMxIo5wfl6YrFIgXx80cgBaSNbY16wWcJ1rQctdBndf5ro0999/joeAC3/RZ19
         MAsw==
X-Forwarded-Encrypted: i=1; AJvYcCUihZyHTdiTM5U1oUTabVEhAS69rpjdBlJ3StNjLx5xiHHASyCzjno5ZsZ9kKZtN6zc+R2n@lists.linux.dev
X-Gm-Message-State: AOJu0YyUVKJwk9h9g5uIfaCtrpieN6sVdZvqTMjz6OcFGuDz2Ta2nk31
	wj5ugjfPYodmVdso+QL1Oxo/mqSi1W5hMeHDtad21o4lQvZtlGcbBjr/A3u+d/4XJrvLeXE17o8
	ROIpuYiN/tymSLK5vX/7Lv9EoYFTB/YI=
X-Gm-Gg: AY/fxX4PbXrZrlEEDvox0i8M44BXqsI6CFgPerXci3+d6wwWG/bJz7OYNjcP4dZzdCI
	Vfm6Nxd3AxizhJrflpEK9i/C7kptoGz/SGWwsypYfzs9DvSxTvNkhSExoJrd2YxTdk/GyigzVSK
	Tn36JTqWpaT6//y4TksLI4pNwSfkkeS0IXIh7bV/ULUNaUSod9pYAGCNSkIEc8SA+AyFQ1PurbX
	Aq7nF6nZzNoKG7uV032uadO3U1YO/ir08B3YDyw12CV7fgOprQI1ir/bLF05Q75HBe5mQjMRJRa
	Oet1Kjhxd/8mES4oHtJZ8NCMDpwVIQ==
X-Received: by 2002:a05:6402:510f:b0:64b:7eba:39ed with SMTP id
 4fb4d7f45d1cf-654525ccad4mr346097a12.13.1768501066374; Thu, 15 Jan 2026
 10:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:17:35 +0100
X-Gm-Features: AZwV_QjhT3ZtgvkbHJB7796GEklGCbcNDL5CeRwrn_YYeN3X8FqPO-3_iRnRORw
Message-ID: <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
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

On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> In recent years, a number of filesystems that can't present stable
> filehandles have grown struct export_operations. They've mostly done
> this for local use-cases (enabling open_by_handle_at() and the like).
> Unfortunately, having export_operations is generally sufficient to make
> a filesystem be considered exportable via nfsd, but that requires that
> the server present stable filehandles.

Where does the term "stable file handles" come from? and what does it mean?
Why not "persistent handles", which is described in NFS and SMB specs?

Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
by both Christoph and Christian:

https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c0=
0c@brauner/

Am I missing anything?

Thanks,
Amir.
