Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D21A239A
	for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673348; cv=none; b=lHqnenYfSJRPmIfxuIs6UQzYCOOr6ToVYZAQuLhjbhJXnfrxNkeWX9ID9+bX+EOVsb88bXMwGUtEwNwq2+3GnbJ+AepVWDOvzy/8gwrttoz38nPHywdGr2W63c1nMdqJ/KZZGvK8oQTJBL0xLZ8nSUYGNFkcr+AEhVk8vhxhue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673348; c=relaxed/simple;
	bh=MFS0g2Z5IRkf3YmceofZFpLREHpV+cOaG7yFFk5dm7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyrTyoQPkLB5WXOzT2V3EUbUTCov39Aw9QAN6iBIch2JKS7LR/G285Z7bpcB+iC8wfaRamxIeuUV/ncYvjnWS8ZXFt4Z/2PaU7LV4qisJHTTyMmjpQdE8mHF4CypSIsrZJFhq+nrG8W22opcadPGKjlUXT1K5HgFMAf4ZpsMl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akPCgs0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akPCgs0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/WsJbIM2atGiMcqxAhoz3Z46gxSwmPLWq4ObW8vr/w=;
	b=akPCgs0NKTdls7uUUUl1LQiUtrPQMbfGi9Ss/U9K495BIJOpbw0uojJ8bocNUA8z4bO5DS
	+e3uweVeqtcWqigbsTio098pZj46knq4281TmA4OmnE3nGg2kyYWDrfLrbUxzgt4g7SN4I
	+WJre9HX8ZomUNg+fOfIZeaKqnlrmwg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-TjgGSRzFNrO7nOI-NK1sqg-1; Wed, 16 Jul 2025 09:42:24 -0400
X-MC-Unique: TjgGSRzFNrO7nOI-NK1sqg-1
X-Mimecast-MFC-AGG-ID: TjgGSRzFNrO7nOI-NK1sqg_1752673343
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2363bb41664so9138305ad.0
        for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 06:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673343; x=1753278143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/WsJbIM2atGiMcqxAhoz3Z46gxSwmPLWq4ObW8vr/w=;
        b=AQcad+vKREd1dnpDUrdwvPmClo/6srEylYlQT4KZkADdaGyvRSFp3D5rT+UJwrrUso
         j/cc+iBlOowhR3ylCeAeecpdX1cC+Ege69gF+H5jrgyqUufB/7HYmLkbbmrAieLSR29n
         CaCQxz09PKUUYzh35qcoAqQEvTB6YSDbLIKQLNpPeJJtplmacgu3JP6s+des5t5mliiY
         xbxE5F8zg0DQ3+tBBhgp+j5Aa/yJhwRSW1J/LM26Ep1qB/3tBPQF2gj/mFLkhp99jKCw
         UXDY9e92k29M4pqphOJpqjjr7m7iothH+kSrtAjbb2o8no+x85FLyLiVfN7eohNb4hWx
         VPdw==
X-Gm-Message-State: AOJu0YyWUdZQrSBhljliXQ8YW5RWDbeEuKD8oIcZw9hhylkLD38prKEX
	mG3kW6zKjJzZDam2uXBXVGZgA4WSKO7LenBIa5CaJM7kBjKG7DUtUrdIkJ7mePht8zxjQAl+/At
	XufNr3ykxF/7EzLZA979Z7Fhd0azgGITXmLmUv7/JUsli6qZ8Zc6TaHCrtHX0qKhP2r6y1sVrJY
	rV4aZ5DWSALyna+ztYg8s+/7xukv6/kw==
X-Gm-Gg: ASbGncvQHSw+LePafMTNZ9NdVW4bOFi38rppzSVnhPBHhvhV/EhaKQek+X82Ko8m0K5
	sJ/n3jHoB8x2hnq3R98izcFxCg90v7EmkNReJotRWBKhEZXXU/3luhONeysw5Pv3stmjHjZ0h+o
	p/GnMWaVVgAiKlSie0EFw=
X-Received: by 2002:a17:903:2f0c:b0:235:e94b:62dd with SMTP id d9443c01a7336-23e1a4ab52emr101535565ad.12.1752673343179;
        Wed, 16 Jul 2025 06:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ0cdSf6o1we+2mQ4NO/tzh1gCH+i2lAnWsQfGnBiRfKSMXij4KWj05uPKFh696Jx7vR5RpOwf/KqyeVGD5OI=
X-Received: by 2002:a17:903:2f0c:b0:235:e94b:62dd with SMTP id
 d9443c01a7336-23e1a4ab52emr101535225ad.12.1752673342775; Wed, 16 Jul 2025
 06:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716131207.79856-1-anprice@redhat.com>
In-Reply-To: <20250716131207.79856-1-anprice@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 16 Jul 2025 15:42:11 +0200
X-Gm-Features: Ac12FXwu_UjKXxNOCoDE6JKvnbrHo0fzW7eqeV-fMtrKDnGaC0gcQ4vfOwc01OA
Message-ID: <CAHc6FU4TsVx7NiuYFTFVFs6zFkeUP0=bxu2L4aAP_9PicMqEMQ@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: Validate i_depth for exhash directories
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i5uLAyCpqHOAXHj8iwaplncnFRtZww0kq26hVnTRSAU_1752673343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:12=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> A fuzzer test introduced corruption that ends up with a depth of 0 in
> dir_e_read(), causing an undefined shift by 32 at:
>
>   index =3D hash >> (32 - dip->i_depth);
>
> As calculated in an open-coded way in dir_make_exhash(), the minimum
> depth for an exhash directory is ilog2(sdp->sd_hash_ptrs) and 0 is
> invalid as sdp->sd_hash_ptrs is fixed as sdp->bsize / 16 at mount time.
>
> So we can avoid the undefined behaviour by checking for depth values
> lower than the minimum in gfs2_dinode_in(). Values greater than the
> maximum are already being checked for there.
>
> Also switch the calculation in dir_make_exhash() to use ilog2() to
> clarify how the depth is calculated.
>
> Tested with the syzkaller repro.c and xfstests '-g quick'.
>
> Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---
>
>  v2:
>   - Switch to using ilog2() in dir_make_exhash() as well
>   - Include linux/log2.h explicitly
>   - Re-tested
>
>  fs/gfs2/dir.c   | 6 ++----
>  fs/gfs2/glops.c | 5 +++++
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index dbf1aede744c1..509e2f0d97e78 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -60,6 +60,7 @@
>  #include <linux/crc32.h>
>  #include <linux/vmalloc.h>
>  #include <linux/bio.h>
> +#include <linux/log2.h>
>
>  #include "gfs2.h"
>  #include "incore.h"
> @@ -912,7 +913,6 @@ static int dir_make_exhash(struct inode *inode)
>         struct qstr args;
>         struct buffer_head *bh, *dibh;
>         struct gfs2_leaf *leaf;
> -       int y;
>         u32 x;
>         __be64 *lp;
>         u64 bn;
> @@ -979,9 +979,7 @@ static int dir_make_exhash(struct inode *inode)
>         i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
>         gfs2_add_inode_blocks(&dip->i_inode, 1);
>         dip->i_diskflags |=3D GFS2_DIF_EXHASH;
> -
> -       for (x =3D sdp->sd_hash_ptrs, y =3D -1; x; x >>=3D 1, y++) ;
> -       dip->i_depth =3D y;
> +       dip->i_depth =3D ilog2(sdp->sd_hash_ptrs);
>
>         gfs2_dinode_out(dip, dibh->b_data);
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index cebd66b22694c..66684ed77dfc3 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -11,6 +11,7 @@
>  #include <linux/bio.h>
>  #include <linux/posix_acl.h>
>  #include <linux/security.h>
> +#include <linux/log2.h>
>
>  #include "gfs2.h"
>  #include "incore.h"
> @@ -450,6 +451,10 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, con=
st void *buf)
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> +       if ((ip->i_diskflags & GFS2_DIF_EXHASH) && depth < ilog2(sdp->sd_=
hash_ptrs)) {
> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         ip->i_depth =3D (u8)depth;
>         ip->i_entries =3D be32_to_cpu(str->di_entries);
>
> --
> 2.50.1
>

Applied to for-next, thanks.

Andreas

