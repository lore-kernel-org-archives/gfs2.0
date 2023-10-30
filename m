Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90918AE9
	for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY9wAo1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698707587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvhqogOQJz8QwSQA0B7KIvNxtckaH85G4A7pegWEZYQ=;
	b=XY9wAo1x4ihOLkMOldKKuwMq9qwxTrD+2zclEi+n9BRyp0dNF+ZftR+4LBP7Lq32kEvicE
	NVcYbTVwYTKPN2sWOrutjAgMPQv6RnYzkkwcNrKi18Y6yz83XH+z/5ez9/N789zm/l8c6W
	kl2dQ3Gr8GRXT17Dlj6m021lUiiiuK0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-DVmwwHudNJq6Yz48darUGw-1; Mon, 30 Oct 2023 19:13:05 -0400
X-MC-Unique: DVmwwHudNJq6Yz48darUGw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso3811969a12.0
        for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 16:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707585; x=1699312385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvhqogOQJz8QwSQA0B7KIvNxtckaH85G4A7pegWEZYQ=;
        b=l9fwYXKWAdF+euLYanhHbBmcsuAUlM2JRYAdJTdZoPvCiEetRthcfMVh6p6uyu0j/V
         RamuRwaOs+BK3m1uib2IO03ZQKBmr/dkIFAwTITHXYPyqeFPHrPPie15zAc8L2zGISCD
         AzsqN0CmnDitvhsFD5N8ltorx/Ap2I3ues4Z5+uM5RV7AYYZDIuI5/kNNqELYDAQEm2l
         1iJCtTVWqh+zgH0DWFgtiuYY38QG7k5KXwDZxRsjjbE3b60wuRj57iZr8l0LssPSgTk7
         7PQr/aGhZeEhLjibpap2xDQr4Muhk4Fth1wYrBkH6yq7LZyKd+8XaFOWv5Y4jj2Qr5rt
         OCsw==
X-Gm-Message-State: AOJu0YwuwFxk2b8d5Z+XB5fliX0jFv9J1yBwid3MK5KLixh1vZScB8Jp
	wgEEwEcv12CVJja/CXG/coSCIsY5Q/pb30b2dJ0sZ7MsPcOV58pis1vcXLFkRcuCqkiVGaneBPc
	5AO6y/Ytju/XtnwGnpwqycyNgex+jTg==
X-Received: by 2002:a17:902:c7d2:b0:1cc:3c2d:1299 with SMTP id r18-20020a170902c7d200b001cc3c2d1299mr5406239pla.37.1698707584920;
        Mon, 30 Oct 2023 16:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2gWnqJt5cta3J37zqiZJ9WwN8gReRklqjUYsxUAtNkexgb6L7HHC+xRATfnBprlQa6SdGm4sDEGeV1EOQnbc=
X-Received: by 2002:a17:902:c7d2:b0:1cc:3c2d:1299 with SMTP id
 r18-20020a170902c7d200b001cc3c2d1299mr5406224pla.37.1698707584622; Mon, 30
 Oct 2023 16:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
In-Reply-To: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 31 Oct 2023 00:12:53 +0100
Message-ID: <CAHc6FU6PKutc1Ya+9Xqa0qXeJVVXMEcsX4HWwVnoZS-n9bmCgQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Initialize metapaths outside of __gfs2_iomap_get
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Mon, Oct 30, 2023 at 7:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On Fri, Oct 20, 2023 at 01:22:44AM +0200, Andreas Gruenbacher wrote:
> > Initialize metapaths outside of __gfs2_iomap_get().  This saves us from
> > having to release the metapath in gfs2_iomap_begin_write() before
> > calling __gfs2_iomap_get() a second time.
> >
> > Also gets rid of several instances where mp_aheight remains at 1 for
> > stuffed inodes (which have a height of 0).  In those cases, mp_aheight
> > isn't being used, though.
> >
>
> In linux-next:
>
> [   12.639126] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   12.639330] WARNING: suspicious RCU usage
> [   12.639550] 6.6.0-rc7-next-20231027 #1 Tainted: G                 N
> [   12.639647] -----------------------------
> [   12.639814] fs/gfs2/inode.c:1878 suspicious rcu_dereference_check() us=
age!

Thanks for reporting these issues.

This warning should be fixed by commit
c2607453f7d3 ("gfs2: Silence "suspicious RCU usage in gfs2_permission"
warning").

> [...]
> [   14.882512] kernel BUG at fs/gfs2/bmap.c:695!

That's a BUG_ON(mp->mp_aheight < 1) in __gfs2_iomap_alloc(). I think
the fix is as follows (sorry for the cut-and-paste):

@@ -1071,6 +1071,7 @@ static int gfs2_iomap_begin_write(struct inode
*inode, loff_t pos,
                        ret =3D gfs2_unstuff_dinode(ip);
                        if (ret)
                                goto out_trans_end;
+                       mp->mp_aheight =3D 1;
                        ret =3D __gfs2_iomap_get(inode, iomap->offset,
                                               iomap->length, flags, iomap,=
 mp);
                        if (ret)

Thanks,
Andreas

