Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E018E1F
	for <gfs2@lists.linux.dev>; Sat,  5 Oct 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728161528; cv=none; b=meIvwA2t8r7YGtcDHpHJ4BLJJcdbnTmmZx4UJCRUpGYq/7IY0qUfVM6n//hNGTzXUqebqTsXSpcvJ/7EmQHza3LAyCDwpzabMmEDBtGQKUeanpiblBrNb2Pzcpp8KoIpayhasehF7vD+0qCAVFFnf0vuLvvtDgrVUWiLQh640ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728161528; c=relaxed/simple;
	bh=s8B4eyja5M5xtoltxX3DR5M4/3Iw5kDK1SimXauNsGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfWsATUoZdFF/VbBcKe9Cyma40gpFVBKNqbBIolfPXkX8aOppjLTcyDetNMMsodpVn65/PCraKPxYDBQcm+1bZ9nks1YWV7tCuFWKN7HfcgnsrLwt0S+rOutgd+SvewK5uTla6pkBxiuYygHivojMdYGqRvMLxXaXtH3uASoqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTWtN8vC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTWtN8vC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728161525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mz62X6btpnYoTfc7D3NDstSSNg114tlnpTOvps9eZiY=;
	b=jTWtN8vCh7FyTEmkqd+838Ilspx50PTJrY4xigdiJJqgGC6JimmZRiXn5+1osPFG5FetGt
	gq1JfIeIKw5B9dI2yauAbjGcOmSJS3uSn4hv/72UuMAjfwSSRooxt1Y3JCLh0jXgUgSvBm
	9t/BnzFViPiSEb/rPjN606cR7H6ILCg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ms4eDpmONVihOKyWrdfhJw-1; Sat, 05 Oct 2024 16:52:04 -0400
X-MC-Unique: ms4eDpmONVihOKyWrdfhJw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20b6144cc2aso28281345ad.0
        for <gfs2@lists.linux.dev>; Sat, 05 Oct 2024 13:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728161523; x=1728766323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz62X6btpnYoTfc7D3NDstSSNg114tlnpTOvps9eZiY=;
        b=GQAOuANvwpW1YDnxBn8dSGJshjC2bOXcML9AgNVTrhl16ehUUtYd0/Fce1Q23oyhBY
         Gc1/ZhuM0Ef05ezJ/sS3ribvT5ZuS5jFWrptO+v/cuWpVwfmmTsb9ewuLeE6aPsv95Yv
         VjY6ZfNLJ4pebJEgKNkxu2DpxQP0+iacuZSLJqWLWYbXsnnvsW2vrKrpngzm7b8W9VXB
         mfHdutMpIOabL0eI+eo8W50AtbYMI54bpybZyE71zgq3+FttkzsbyGEv+v0CLB9yYA5j
         M5sDBjj8gw74ZXYOBZAxJpL8saGVM5I1aKKkzlxdZRBi7J3t0sP1GudqCtm4T00wZk/Y
         mvJw==
X-Forwarded-Encrypted: i=1; AJvYcCVwei70VarzT6DPLi6m+PwOvaumusEf+hNZFSxQXLRWTY5u+xaZ/L8CnNzz/v5abEdCXWwW@lists.linux.dev
X-Gm-Message-State: AOJu0YxJmImk8pHbzDsjxlfTok7MYri0jdSF/WyLZ8nbYzTdFOl4o1Or
	15p94yKhU/aBWhWVTupI3qG868RJMU4I3rNUPiNfZ+rsbfN0Wrk2FO2RcDJMQLAO1myRibWxs7C
	4LJ2QziK7ZC+mzN9dcJKzZscPxKeMT6S7RdaGcN6EPtD7lX7Aqr95bAqAZdicxdPoAzBmqSfsS2
	+ZvPU7qc2NyhSykX3r/8CinKj1NA==
X-Received: by 2002:a17:902:e94e:b0:20b:831f:e905 with SMTP id d9443c01a7336-20bff497da0mr110602775ad.12.1728161523413;
        Sat, 05 Oct 2024 13:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAknPsQzvXAaP/dKtA/CoSloZTFuHBKR4lUspn4AHnO6uiUNrXZm8pYonj6UGF54Dbz/ZtxXd8HJ3dgZZcVok=
X-Received: by 2002:a17:902:e94e:b0:20b:831f:e905 with SMTP id
 d9443c01a7336-20bff497da0mr110602665ad.12.1728161523124; Sat, 05 Oct 2024
 13:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <66fca31e.050a0220.f28ec.04e4.GAE@google.com> <ZwFmiv0lqP02xPtq@fedora>
In-Reply-To: <ZwFmiv0lqP02xPtq@fedora>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 5 Oct 2024 22:51:51 +0200
Message-ID: <CAHc6FU5g+kvsA2r9XSOgLZYmc9nQuvPecXwJK7VaOXaLn3yZKg@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 6:23=E2=80=AFPM Qianqiang Liu <qianqiang.liu@163.com=
> wrote:
>
> #syz test
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 6678060ed4d2..d60d53810bc1 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -1537,11 +1537,13 @@ static struct inode *gfs2_alloc_inode(struct supe=
r_block *sb)
>         if (!ip)
>                 return NULL;
>         ip->i_no_addr =3D 0;
> +       ip->i_no_formal_ino =3D 0;
>         ip->i_flags =3D 0;
>         ip->i_gl =3D NULL;
>         gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
>         memset(&ip->i_res, 0, sizeof(ip->i_res));
>         RB_CLEAR_NODE(&ip->i_res.rs_node);
> +       ip->i_diskflags =3D 0;
>         ip->i_rahead =3D 0;
>         return &ip->i_inode;
>  }
>
> --
> Best,
> Qianqiang Liu

Added to for-next.

Thanks,
Andreas

