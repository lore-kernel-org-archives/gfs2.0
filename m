Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695322B5A5
	for <gfs2@lists.linux.dev>; Tue,  2 Sep 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816473; cv=none; b=ku2kwGKLawuzfmBg305lLHWLXkjS8pnjdnT+ePktYRy0fqvDq4RoMjt7pNHG82K6MSMOZRvqnRuLB0FkCQMiQAJGNws1xe155PoBYAm8CmXFwiAeCMCcGAQikTseqlCtglLivcYELvmS4JwABSrin+KLvoi/OxDti5K5nM6PYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816473; c=relaxed/simple;
	bh=2VkunjB8a80+phnGTl7LNxUUS2cg5su4nZDfppC7mhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEBisNu1Cuzs8BR1S/gKmSCSTg81iFYD3KqhoJOvYBE015uDlzlNRVSxTsmMo9OYoWR1henMi5wakEAHiloiQ60hbVY33JbmL9ALAQ123wh+p7wwTNkKeBqBEV+BilFJYI0u0eP4xm604vj5ZhA2OFNj0ZnUlPdrQJzLJ90BT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsCfsWho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsCfsWho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756816470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha2JHE9mQgm+rthgNaELv4EMnR5aPkfNOf7BeyLfdcw=;
	b=XsCfsWhoxszeVErs0MqJiwikPJgB64JQDFTBLK0v0PEo1XveO/sNft6OIFx4+2jphxWREo
	+6QDrFxaMsL0ZS239nCBdQV/Ozuq1nKb4aLLf9fQ2Q7wlXbZwJo9S7CuLE7EcZN+mK4Cs9
	XZcVCfWyuNcKdxplZcB4wbfVQwOhT9s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-bCvAptKSP6CtjQyzap3dEA-1; Tue, 02 Sep 2025 08:34:29 -0400
X-MC-Unique: bCvAptKSP6CtjQyzap3dEA-1
X-Mimecast-MFC-AGG-ID: bCvAptKSP6CtjQyzap3dEA_1756816468
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f738792b0so2725998a12.3
        for <gfs2@lists.linux.dev>; Tue, 02 Sep 2025 05:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816468; x=1757421268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha2JHE9mQgm+rthgNaELv4EMnR5aPkfNOf7BeyLfdcw=;
        b=TilqtjWTpm+Go50InfQ7SkWBa/PxP0wqldp8UDwSBP2tO9GYmY+Y64U+DbwC0UcAas
         ZP1BSeKyvg/hXICyo9J6gvZ/EWcWZD8w5zlkIDj7qk+7z3HHULjPDQlOlxOQLttEKUT9
         HAq9uw9Lwjg7+4+PlgU+qWxIHD7FElnZGybFb/RVuGW+qwpWpDZVMTrGBVfrgbhHrYss
         hO6qhW3VQW8uflPm4/EsjWU4bRdep4UZifAmuqZYTrKRwvYf5PhB/kaDhwd7DumPMdkP
         oKKfNa5MjIszBK6tm43wgGs7A1TzRcWldsnfH30/LuaSC46NSLGqu9ZZQdP+LWNGDWI0
         1SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPFHpu/XBz1GmUR14yL/GkXt56a51AuQ0SANyExEfClAz1a5ULGl7uxiTY7SNBT5OD/eSZ@lists.linux.dev
X-Gm-Message-State: AOJu0YzFVcCnYuJxIuwPdKea4YPqoTwS/hoXRP0MWJiyfZn4+T14v9pH
	9mRSHPHbpARIbMDANPm+jlMNv8p8kYRf+n3QhdYhT3Gyze2j2+92WYGUdb4TG90Q1z3DFM+igWb
	TCM9+sBgb9LYVU3YlKOWVfrB1YGpT3YPlg2FD0M8DfO5dEQYac//FLuMIO9PuGprrKkW9ipXjMc
	Wr83+022ll/bECbWwVH2MxizrtO7VuUA==
X-Gm-Gg: ASbGnctHFaRcQK4popoe8q7z9BzFkvfMf381VHcgqRa59xukaN+hv/PCdvxZ/0bBeId
	ES+GC4OUUm/VgD29Ifa9G7sIzVird0KtdzkoGiDvrBGs+uRmD2Tq6AihUrfvlmP8I/jpOnHp5QL
	p8AYBYg7RqaC9PTYJCDjs=
X-Received: by 2002:a17:903:41d1:b0:246:ae6e:e5e5 with SMTP id d9443c01a7336-249448744b8mr134647125ad.8.1756816468150;
        Tue, 02 Sep 2025 05:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCN5Dna2Yp8TYSDb+TUsfK66i8SK5iFQPVbZuu23hVbHf0NqGK7VSz4SAdTl9KrvE4loIkE3bT4PyidPyehXw=
X-Received: by 2002:a17:903:41d1:b0:246:ae6e:e5e5 with SMTP id
 d9443c01a7336-249448744b8mr134646905ad.8.1756816467742; Tue, 02 Sep 2025
 05:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 2 Sep 2025 14:34:15 +0200
X-Gm-Features: Ac12FXz98W_t9ILV-_IT6ezCbhIE6zwQ_72FfTs2Xhipir90U7Uo_Cdjg4YnIrU
Message-ID: <CAHc6FU4=L+PU5i6j3cH2KjA+PtvBk-56=CaWN3+yHqHrGX=VrQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.com>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5MiFx0Jios5kvCE4xKG_lrTyuTlA-U97X8c0AxTI_nU_1756816468
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> The f_op->mmap() callback is deprecated, and we are in the process of
> slowly converting users to f_op->mmap_prepare().
>
> While some filesystems require additional work to be done before they can
> be converted, the gfs2 and udf filesystems (like most) are simple and can
> simply be replaced right away.
>
> This patch adapts them to do so.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/gfs2/file.c | 12 ++++++------
>  fs/udf/file.c  |  8 +++++---
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index bc67fa058c84..c28ff8786238 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -577,7 +577,7 @@ static const struct vm_operations_struct gfs2_vm_ops =
=3D {
>  };
>
>  /**
> - * gfs2_mmap
> + * gfs2_mmap_prepare
>   * @file: The file to map
>   * @vma: The VMA which described the mapping
>   *
> @@ -588,8 +588,9 @@ static const struct vm_operations_struct gfs2_vm_ops =
=3D {
>   * Returns: 0
>   */
>
> -static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
> +static int gfs2_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
>         struct gfs2_inode *ip =3D GFS2_I(file->f_mapping->host);
>
>         if (!(file->f_flags & O_NOATIME) &&
> @@ -605,7 +606,7 @@ static int gfs2_mmap(struct file *file, struct vm_are=
a_struct *vma)
>                 gfs2_glock_dq_uninit(&i_gh);
>                 file_accessed(file);
>         }
> -       vma->vm_ops =3D &gfs2_vm_ops;
> +       desc->vm_ops =3D &gfs2_vm_ops;
>
>         return 0;
>  }
> @@ -1585,7 +1586,7 @@ const struct file_operations gfs2_file_fops =3D {
>         .iopoll         =3D iocb_bio_iopoll,
>         .unlocked_ioctl =3D gfs2_ioctl,
>         .compat_ioctl   =3D gfs2_compat_ioctl,
> -       .mmap           =3D gfs2_mmap,
> +       .mmap_prepare   =3D gfs2_mmap,

This ought to be:
  .mmap_prepare =3D gfs2_mmap_prepare,

>         .open           =3D gfs2_open,
>         .release        =3D gfs2_release,
>         .fsync          =3D gfs2_fsync,
> @@ -1620,7 +1621,7 @@ const struct file_operations gfs2_file_fops_nolock =
=3D {
>         .iopoll         =3D iocb_bio_iopoll,
>         .unlocked_ioctl =3D gfs2_ioctl,
>         .compat_ioctl   =3D gfs2_compat_ioctl,
> -       .mmap           =3D gfs2_mmap,
> +       .mmap_prepare   =3D gfs2_mmap_prepare,
>         .open           =3D gfs2_open,
>         .release        =3D gfs2_release,
>         .fsync          =3D gfs2_fsync,
> @@ -1639,4 +1640,3 @@ const struct file_operations gfs2_dir_fops_nolock =
=3D {
>         .fsync          =3D gfs2_fsync,
>         .llseek         =3D default_llseek,
>  };
> -
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 0d76c4f37b3e..fbb2d6ba8ca2 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -189,10 +189,12 @@ static int udf_release_file(struct inode *inode, st=
ruct file *filp)
>         return 0;
>  }
>
> -static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int udf_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
> +
>         file_accessed(file);
> -       vma->vm_ops =3D &udf_file_vm_ops;
> +       desc->vm_ops =3D &udf_file_vm_ops;
>
>         return 0;
>  }
> @@ -201,7 +203,7 @@ const struct file_operations udf_file_operations =3D =
{
>         .read_iter              =3D generic_file_read_iter,
>         .unlocked_ioctl         =3D udf_ioctl,
>         .open                   =3D generic_file_open,
> -       .mmap                   =3D udf_file_mmap,
> +       .mmap_prepare           =3D udf_file_mmap_prepare,
>         .write_iter             =3D udf_file_write_iter,
>         .release                =3D udf_release_file,
>         .fsync                  =3D generic_file_fsync,
> --
> 2.50.1
>

Thanks,
Andreas

