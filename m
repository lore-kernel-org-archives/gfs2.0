Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1240264A76
	for <gfs2@lists.linux.dev>; Tue,  8 Apr 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111222; cv=none; b=aTHfVBVdMr3apcoBPtDGzk3QqqbWIBdxr/OPxvaDBCPTKcyrSBMMaGP9m97mOkqW+4hrugGMLd+P6xYsgm5NFqz2QOPF441Fakgwn5lQeuh6bycl4PxdfaGnXUMg5JfGyExIAR/J0tlzZvOYGehu5P8C75k5EQAylb+qeZy1hFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111222; c=relaxed/simple;
	bh=IsnK/CJhMOB5ezHxsAL2yUfPY5VpgkdOg9K3FGVRifE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqUu93IDa85v7DNj6erEDglvWqnRLVHJs6MfiTUm+Yhv94jjCSQ0GAcMp4p2FnHCH+BBWEYVmx6vJ+9Rt348PJXP5lZYbtzXXYJHtEJ4aj2ibDNara/aqdqgR2TbXzhDuKJyIlXF0LbL2B39YXHwepVxnxuJpgLMsorXdpr5hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAeHyMUA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAeHyMUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744111217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxlGUJtYElxMWl8rsjV0NknW3/JmIWt6QA0dt0dS8Gg=;
	b=bAeHyMUAP94fB9ysz77Kvf1WWv3x0bTWlbFqUJviOUWvw65a3weihLGFSARmTbpNSQW8Zs
	c1nSc83qGS4N6ei1t+PvHmil7jL7q033BXGuqAqgmxCz+gmXvUaKEajFbajEIEMzu4L1Xc
	qBVLqYd7Ka/kDVVMZiF+NbQG1H43We0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-b3Y-BnF-OT6FpddVgjlCPQ-1; Tue, 08 Apr 2025 07:20:16 -0400
X-MC-Unique: b3Y-BnF-OT6FpddVgjlCPQ-1
X-Mimecast-MFC-AGG-ID: b3Y-BnF-OT6FpddVgjlCPQ_1744111216
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b00e4358a34so578028a12.0
        for <gfs2@lists.linux.dev>; Tue, 08 Apr 2025 04:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111215; x=1744716015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxlGUJtYElxMWl8rsjV0NknW3/JmIWt6QA0dt0dS8Gg=;
        b=Dp+EF1OGPdwRB+aniogjKwCqk7h2Gkk/Zgqib6/gp8/xJdLoqV5RKKm2xSUQ6h6m96
         31fvpoEEY6IWJvtOh1rViTxVZwpKhj9ddsZC5YVv8x6fxTcG3QUD4iMsAymxbVta3MwL
         dzMb6coDYGyJ1kGLTBgtbIdM6KHecdPlRFLMCxUuRd+NtnkzcNYPkogsvu9r4TOotNDh
         9f6i2IR+GYzoF9ppyS+EE8RENmZNFEI5iKrRtkxknsDjcgGMykWhesQ3Li7vLjqqhMqM
         3rhBaFzLnB3gbvSMU74PgFsbyvNkW4jhauU4qbG33UE4h/3y9UzKB2p9jYCKYhcemjXI
         Gp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnwhUxf96uE+2XJaJpNnnMpWjCSWXKv+prxXETYN1bIVS57qnohJOb7cTkL7jB7n5fmYim@lists.linux.dev
X-Gm-Message-State: AOJu0Yzajjw6DuQSdM3McXUgfgqvB+fEgpSTFMXAOEBEdgS/qGHx0lRM
	izBSDEwnP3KewgLCBMjy2zU+VgPzUHeDR2H9dVxRZm6qNLlIBMDt7rr0QH9tIQqYnPYtlAjiYHY
	3eLiHxc4UTAlTXTN/n8PC/V18pRkIBn2mSJdb59f45YJWB+XhgYQngijWT7rCW3s/LLY/zZg+k+
	eyLo+P8tzzXFwvvylc50HTqEyQfw==
X-Gm-Gg: ASbGncvPtjJbpI7c9D6vHIxNBZML30RZof6RBmDjex64Zh1PPpSxi658gmNvs3SGeI1
	uTWO77wmbF5mj/Lp+WQVgE3jErhU0kcEZndOeRuelkabIdbsPUAv5XOeg/JZBAoaQyikKEKg=
X-Received: by 2002:a17:902:e809:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22a8a8cec34mr238994045ad.40.1744111215616;
        Tue, 08 Apr 2025 04:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfj3NzNQEOef+4bFL5S7xAlawV84jImrAOEcndKQ7zZiAPCt7WHwsWtCqW95u4ZSL3aeAqCFB/AGt6ESaJB0M=
X-Received: by 2002:a17:902:e809:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22a8a8cec34mr238988485ad.40.1744111210268; Tue, 08 Apr 2025
 04:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-2-agruenba@redhat.com>
 <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
In-Reply-To: <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 8 Apr 2025 13:19:58 +0200
X-Gm-Features: ATxdqUF091z-QTWG4loZUeytMgFUpudH-__g8f1MG4U6oA2wpIwWgfAYKS_mKk4
Message-ID: <CAHc6FU5HrGWYpOwd6OMhG7EdyjB3zp-RV5dP=W-=29VnYa96-w@mail.gmail.com>
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yGwimOle9pFnRwwAxid0v7Webk5ZkuhHbjzk1Ka5O3E_1744111216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:04=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/04/08 3:21, Andreas Gruenbacher wrote:
> > @@ -1156,6 +1146,18 @@ static int gfs2_fill_super(struct super_block *s=
b, struct fs_context *fc)
> >       sb->s_flags |=3D SB_NOSEC;
> >       sb->s_magic =3D GFS2_MAGIC;
> >       sb->s_op =3D &gfs2_super_ops;
> > +
> > +     /* Set up an address space for metadata writes */
> > +     sdp->sd_inode =3D new_inode(sb);
> > +     if (!sdp->sd_inode)
> > +             goto fail_free;
> > +     sdp->sd_inode->i_ino =3D GFS2_BAD_INO;
> > +     sdp->sd_inode->i_size =3D OFFSET_MAX;
> > +
> > +     mapping =3D gfs2_aspace(sdp);
> > +     mapping->a_ops =3D &gfs2_rgrp_aops;
> > +     mapping_set_gfp_mask(mapping, GFP_NOFS);
> > +
> >       sb->s_d_op =3D &gfs2_dops;
> >       sb->s_export_op =3D &gfs2_export_ops;
> >       sb->s_qcop =3D &gfs2_quotactl_ops;
>
> This will be an inode leak when hitting e.g.
>
>         error =3D init_names(sdp, silent);
>         if (error)
>                 goto fail_free;
>
> path, for what free_sbd() in
>
> fail_free:
>         free_sbd(sdp);
>         sb->s_fs_info =3D NULL;
>         return error;
>
> path does is nothing but free_percpu() and kfree().

Indeed, an iput() is indeed needed in that case.

Thanks,
Andreas

