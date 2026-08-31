Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781883E0C7A
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177584; cv=none; b=WsZXu3qmhGiOr6Rh75Hyqi72m7F8ZMjIzsPRU++81S5pM+qIObb7fUtu9Smg8/8zZZ3X1wUOymYP091VZjw0pKGZq8JniLsJpCE0e70FYTOKed/kQU7fdFGwgZQhLRdJ1im0LMvUtfyxG4HA7FrwzrDaP4fdGU0f4h5BTUbXEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177584; c=relaxed/simple;
	bh=XtJMReRayz5u01/Y3Wpc4UtRjykDXRN/p8mH13avm/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkszlsSTZwVH6Lf0wv7JcdkKUu/6oFFJZNDzZ61wngXGDb1PuP1nY2eTQHAcUa8qOMR6m+nCludh0ArxL6QQRPR27rE7CHWAxpxGhpGv/aihXhWBccWpugpgnN+ytj4IpogQHhk2ohbW2GejslMiHtgOM+1vxjPYzWSwPY5BaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy/E+XSr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy/E+XSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788177582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
	b=Xy/E+XSrh71kXZu59maxYKDw3JlHiG+HciQk1nJMf/WHb25YIGnJSfe5ZLZ/cxrwt+JorI
	dCpGSTuHR8xI0/91ui2lP+6+FIKUvw51qqKXJIBbsR18tooKL6d1blU2oEnPk/lcEbZ2ur
	ijniync+IMo+yGGzg1EqLpEio6Hezn0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-JfhzWK9tPtebPZdzpbqqqQ-1; Mon, 31 Aug 2026 07:59:38 -0400
X-MC-Unique: JfhzWK9tPtebPZdzpbqqqQ-1
X-Mimecast-MFC-AGG-ID: JfhzWK9tPtebPZdzpbqqqQ_1788177578
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c73057f18so4886112d50.3
        for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788177578; x=1788782378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpUyKt6NKpZOqi2PHbUzsqSHu/r4oFmeIS7Q+YbCn84=;
        b=X4k30e4zNICYPQbOd978XNB1FBsSfnhwgbCKJCfpcs2I/GdFFkIjNPwCTonzF45T6J
         zdfBu7McalhFqVYfARaumBdzGITH+Z86TshdG7YQ0I9ug9J+W9VrNz/KxvQ0ISEc5Fw0
         +xgkJgF0eD2/HzE2K3QG/1IBCwIo3kj+s2/dT2J9crlck8gzuiWG7TolJH6lXM2DIcA0
         lMpMABx4bmCRWOYZcQajMgwU0ez9h6O2CZlBu7kUMr3f7kQVWfGiv54mJ5Q2aen0qGt8
         fbMrYHPNRM6UIDefe+uHj8A2MNWW+lOZCM0zIa/s7FP41TzEG6nYjgha8MLVCOiWryS0
         /tTg==
X-Gm-Message-State: AFuF++krREhY30RzfhIcnVM4DreHZXTY43K21690ygg+QvbiARgAX+Wv
	fk1zc6CSRR4185fRTna1w2twAGoXtnJmvju+uZn9e3amKhPjuEn/tLav6wvXBecs7hMiIsOjgZH
	lh0ODxFidVjC92hXo/24LcC4KMym0KlUbdqdKND9XzkwufRNCTEjVADtv2i9EguIfsudyBciYe4
	NLax2NygdjgkZvSTcJLitjyftYcKmsXg==
X-Gm-Gg: AYBFou05QBZ83BGRgWO3O/65WC22QQBaVO1Fy94k2b71TamX2wWooKyQ5GbPGcpM1Or
	8CJvYZmBRSIkj1xrd9mkYOR489n2abkpxIjhaCxbYl6676yFQIDRuw78Z60P6IAQkJ9PRMAXStD
	PR2YAW6y9XPY0RQRplxP60iEeoaRpxddXJEyD7Llz95qdaKatttIcSNwmYnh+pRf8HUGkPnvvv5
	lKOL94HGkxc6JC4HPknKCp0qv476o0D60h9V7MbimdU
X-Received: by 2002:a05:690e:43c6:b0:66f:80b6:e954 with SMTP id 956f58d0204a3-66f80b6f278mr708892d50.42.1788177578162;
        Mon, 31 Aug 2026 04:59:38 -0700 (PDT)
X-Received: by 2002:a05:690e:43c6:b0:66f:80b6:e954 with SMTP id
 956f58d0204a3-66f80b6f278mr708883d50.42.1788177577730; Mon, 31 Aug 2026
 04:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831105425.622254-1-r772577952@gmail.com>
In-Reply-To: <20260831105425.622254-1-r772577952@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 31 Aug 2026 13:59:26 +0200
X-Gm-Features: AcwNN1XEYDO6BbANnYdL4InXzS-PGISlnDhdt4_420VqSyNsR953nV8_5jm--Yg
Message-ID: <CAHc6FU7x8J_pPKzbmSJEpB8AbcV1bJuEx5+i0nqMpboZ6xDF5g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] gfs2: reject oversized dinode sizes before i_size_write
To: Jiaming Zhang <r772577952@gmail.com>
Cc: gfs2@lists.linux.dev, anprice@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XV6xGl9X-fwgd_AUTxHipK-yMN8NZapWwokH8uNS_6s_1788177578
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 31, 2026 at 12:54=E2=80=AFPM Jiaming Zhang <r772577952@gmail.co=
m> wrote:
> A corrupted GFS2 image can store a dinode size that is larger than what V=
FS
> i_size can represent. gfs2_dinode_in() reads the on-disk di_size as a u64=
 and
> writes it directly into inode->i_size. If the value is larger than S64_MA=
X, the
> incore i_size becomes negative. That negative value can bypass the existi=
ng
> stuffed inode size check:
>
> inode->i_size > gfs2_max_stuffed_size(ip)
>
> Later, gfs2_quotad may try to sync the quota file and unstuff the quota i=
node.
> gfs2_unstuffer_folio() reads the negative i_size into an unsigned length =
and
> passes it to memcpy(), turning it into a huge copy size and triggering a
> out-of-bound issue.
>
> Reject dinodes whose size exceeds sb->s_maxbytes before storing the value=
 in
> inode->i_size. Also make the stuffed inode check use the raw on-disk size=
 while
> it is still unsigned.

applied with the changes noted below.

> Fixes: 70376c7ff312 ("gfs2: Always check inode size of inline inodes")
> Closes: https://lore.kernel.org/lkml/CANypQFaF6bvORKKbRALvEL0k_epFaneFiOQ=
qco4gjdmKVbdURg@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5-xhigh
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> ---
>  fs/gfs2/glops.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 28f32424ee64..8c5d257451d5 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -393,11 +393,16 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, co=
nst void *buf)
>         umode_t mode =3D be32_to_cpu(str->di_mode);
>         struct inode *inode =3D &ip->i_inode;
>         bool is_new =3D inode_state_read_once(inode) & I_NEW;
> +       u64 size =3D be64_to_cpu(str->di_size);
>
>         if (unlikely(ip->i_no_addr !=3D be64_to_cpu(str->di_num.no_addr))=
) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> +       if (unlikely(size > (u64)inode->i_sb->s_maxbytes)) {

The (u64) cast here is unnecessary, so I'm removing that.

> +               gfs2_consist_inode(ip);
> +               return -EIO;
> +       }
>         if (unlikely(!is_new && inode_wrong_type(inode, mode))) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
> @@ -418,7 +423,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>         i_uid_write(inode, be32_to_cpu(str->di_uid));
>         i_gid_write(inode, be32_to_cpu(str->di_gid));
>         set_nlink(inode, be32_to_cpu(str->di_nlink));

 Also, I'm moving the additional consistency check here.

> -       i_size_write(inode, be64_to_cpu(str->di_size));
> +       i_size_write(inode, size);
>         gfs2_set_inode_blocks(inode, be64_to_cpu(str->di_blocks));
>         atime.tv_sec =3D be64_to_cpu(str->di_atime);
>         atime.tv_nsec =3D be32_to_cpu(str->di_atime_nsec);
> @@ -462,7 +467,7 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, cons=
t void *buf)
>                 return -EIO;
>         }
>
> -       if (gfs2_is_stuffed(ip) && inode->i_size > gfs2_max_stuffed_size(=
ip)) {
> +       if (gfs2_is_stuffed(ip) && size > gfs2_max_stuffed_size(ip)) {
>                 gfs2_consist_inode(ip);
>                 return -EIO;
>         }
> --
> 2.43.0
>

Thanks,
Andreas

