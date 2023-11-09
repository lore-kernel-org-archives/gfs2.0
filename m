Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CD38F8A
	for <gfs2@lists.linux.dev>; Thu,  9 Nov 2023 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7njR+5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ooj0huzmXViB3IPA+8ZsWf/tvcP9vcxEUy2C65Cs8hg=;
	b=I7njR+5VaSGAzjJKJG/tRQdCd+Vy6IlZzOaXnHS7TcA/N14Y6l0Iw/0U/5TrlowBXZcyDX
	tvh0l4sxjL2sCegLJ4ikGAf20wlxJnLKwTmbf++ZFY4eCbfT12TvBe4eIcSvQGZFFpBel9
	ntXSxo/riwSxOgiQCX/86jmq0fGyP1k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1P0Tkx-7N0GfDGPxnciy7A-1; Thu, 09 Nov 2023 16:52:50 -0500
X-MC-Unique: 1P0Tkx-7N0GfDGPxnciy7A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc23aa0096so13381505ad.2
        for <gfs2@lists.linux.dev>; Thu, 09 Nov 2023 13:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566769; x=1700171569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooj0huzmXViB3IPA+8ZsWf/tvcP9vcxEUy2C65Cs8hg=;
        b=WQKiqgA/nXUX9N3bY24UlBn4dK1VfLiu+8Hd6YHptMs3OPGEscw1pwIx94dNWIB9sL
         e+hiNQq0IBaj470lXsyr2O4Hk62lWcKv61J9AL0J7KuYZVYU6YN22+6UyrI2krt8BPII
         pUHumgzSZ9ENcp0OTNQpF19MknHcXGiJkydYBxEf4bg0arB9YGGV/as/itwP7anyN0Nf
         YoC52mY941CsTgjnvC8jLjiffI80ZoBW9WHFef20nTo5Uyc8TrMxSPyjEhjwqKEjx18J
         7MQ8FTviGPWT5z1E6jdlhWVDpVud/LEvOVQe5glX9tsn6LfrF2Xuotcy+z8SADJ3j5tx
         5Ugg==
X-Gm-Message-State: AOJu0Yw1aeJChzZkvYPU59H3iuy4EFex1iQYTUbjo6DEY+czvar3WYUf
	tEY78bD5NAwf4k1pgLvd/69epBhDL7FDzJ3S0zddpwTHQcg2Aad0y93wBxHvtErvOCRHBKIVsGi
	O109TycaMp/JZR6UnQl7Q/a4gpSMnxQ==
X-Received: by 2002:a17:902:d2cf:b0:1cc:42b1:934b with SMTP id n15-20020a170902d2cf00b001cc42b1934bmr6973375plc.18.1699566769073;
        Thu, 09 Nov 2023 13:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2w5kiS+35bQf1w6M0QjE1cVW4EjHgMurxmQucKCpYNIosx46laiJfbx3QyQx2atURPUqY64X628qUAuI/IrU=
X-Received: by 2002:a17:902:d2cf:b0:1cc:42b1:934b with SMTP id
 n15-20020a170902d2cf00b001cc42b1934bmr6973354plc.18.1699566768767; Thu, 09
 Nov 2023 13:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-4-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-4-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 9 Nov 2023 22:52:37 +0100
Message-ID: <CAHc6FU6-a5Xf1Zesj0Y9udXLaxg5nnK5t9GPxA_b5PHNU8brvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gfs2: Convert stuffed_readpage() to stuffed_read_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Use folio_fill_tail() to implement the unstuffing and folio_end_read()
> to simultaneously mark the folio uptodate and unlock it.  Unifies a
> couple of code paths.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 9611bfceda4b..ba8742dc91f8 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -403,18 +403,18 @@ static int gfs2_jdata_writepages(struct address_spa=
ce *mapping,
>  }
>
>  /**
> - * stuffed_readpage - Fill in a Linux folio with stuffed file data
> + * stuffed_read_folio - Fill in a Linux folio with stuffed file data
>   * @ip: the inode
>   * @folio: the folio
>   *
>   * Returns: errno
>   */
> -static int stuffed_readpage(struct gfs2_inode *ip, struct folio *folio)
> +static int stuffed_read_folio(struct gfs2_inode *ip, struct folio *folio=
)
>  {
> -       struct buffer_head *dibh;
> -       size_t i_size =3D i_size_read(&ip->i_inode);
> -       void *data;
> -       int error;
> +       struct buffer_head *dibh =3D NULL;
> +       size_t dsize =3D i_size_read(&ip->i_inode);
> +       void *from =3D NULL;
> +       int error =3D 0;
>
>         /*
>          * Due to the order of unstuffing files and ->fault(), we can be
> @@ -422,22 +422,20 @@ static int stuffed_readpage(struct gfs2_inode *ip, =
struct folio *folio)
>          * so we need to supply one here. It doesn't happen often.
>          */
>         if (unlikely(folio->index)) {
> -               folio_zero_range(folio, 0, folio_size(folio));
> -               folio_mark_uptodate(folio);
> -               return 0;
> +               dsize =3D 0;
> +       } else {
> +               error =3D gfs2_meta_inode_buffer(ip, &dibh);
> +               if (error)
> +                       goto out;
> +               from =3D dibh->b_data + sizeof(struct gfs2_dinode);
>         }
>
> -       error =3D gfs2_meta_inode_buffer(ip, &dibh);
> -       if (error)
> -               return error;
> -
> -       data =3D dibh->b_data + sizeof(struct gfs2_dinode);
> -       memcpy_to_folio(folio, 0, data, i_size);
> -       folio_zero_range(folio, i_size, folio_size(folio) - i_size);
> +       folio_fill_tail(folio, 0, from, dsize);
>         brelse(dibh);
> -       folio_mark_uptodate(folio);
> +out:
> +       folio_end_read(folio, error =3D=3D 0);
>
> -       return 0;
> +       return error;
>  }
>
>  /**
> @@ -456,8 +454,7 @@ static int gfs2_read_folio(struct file *file, struct =
folio *folio)
>             (i_blocksize(inode) =3D=3D PAGE_SIZE && !folio_buffers(folio)=
)) {
>                 error =3D iomap_read_folio(folio, &gfs2_iomap_ops);
>         } else if (gfs2_is_stuffed(ip)) {
> -               error =3D stuffed_readpage(ip, folio);
> -               folio_unlock(folio);
> +               error =3D stuffed_read_folio(ip, folio);
>         } else {
>                 error =3D mpage_read_folio(folio, gfs2_block_map);
>         }
> --
> 2.42.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

