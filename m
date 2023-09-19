Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8973AC1E
	for <gfs2@lists.linux.dev>; Tue, 19 Sep 2023 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695162512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cF5FIFh22usSjm39Z5xoUee1aW1ZyPpmGmyoy2xhnY=;
	b=gdjePfiLYaj5E1li0cfkqDNx92o4DRV/au1ym3/Lgjuoxw6HWP1bCmmbHYgjrb4M+mzBB3
	73R0j21Hp70T2FdNcD3Krsj9U4dOwA8aUpL5COTGRDPN0kHKGU2UKSFrIOn/3laJJaiHIM
	qHDLoVN551zwI6VAwZwDLA2ouxNyogU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-Qq8DynWTNtGJtRaX4bdvfQ-1; Tue, 19 Sep 2023 18:28:31 -0400
X-MC-Unique: Qq8DynWTNtGJtRaX4bdvfQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2764e63b6abso2816330a91.0
        for <gfs2@lists.linux.dev>; Tue, 19 Sep 2023 15:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695162510; x=1695767310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cF5FIFh22usSjm39Z5xoUee1aW1ZyPpmGmyoy2xhnY=;
        b=d1Z/jUO5oQvSmGiYvoR/JeIze36FCwIQ4e12zsSn/M3ewaJoHZ55FBSooI6Ae1R/uV
         9rksGCi8UpqE3iZbETWykVLiT5GefhP+/nwFBhoJy30RRSlloY28Euy9mg8M2TkKOt2e
         psGa0YnFh9/2YSwPaB4ZCMG61HR5fcqC2pXgdf8v4fA6zOux2fwOiCjqm3moFnWctDG8
         TBymsmfXTnLtgrXeeDVUYUS+OBZfRavmMYOHMNRi/bWq+LbccCn/nL5JVClwjy2aGI8o
         LXKg0KuFLh6cSn7hMX8PG28deCVUziGbORmBmhAIKB/RhG5OvNyu/sOtoMorwx9VUMu5
         8wbQ==
X-Gm-Message-State: AOJu0Yz13sZobpUzUTaig1SxrMCXPtcIIlPKYE+ssvXWU6iqjDhTNrem
	lCNlsvt+A1iaLCR28nb9droFPjBtQeEZdK5CFCBVMpFcEB3n0cEasVFrDlQ62sGpGbI41lAZkCe
	Wds8ngQ4OYj/EqoHH8CWp5DXmHwx9vw==
X-Received: by 2002:a17:902:da8f:b0:1bb:a522:909a with SMTP id j15-20020a170902da8f00b001bba522909amr986883plx.37.1695162510069;
        Tue, 19 Sep 2023 15:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpbtgLZQnmIFpoycfoBrG7qrX9HqojmUsDe+wFjYsm20sUgmgqY2dFFCaMUztlbeAKetFEUenxQQWdQ1mbOy0=
X-Received: by 2002:a17:902:da8f:b0:1bb:a522:909a with SMTP id
 j15-20020a170902da8f00b001bba522909amr986862plx.37.1695162509799; Tue, 19 Sep
 2023 15:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230919045135.3635437-1-willy@infradead.org> <20230919045135.3635437-6-willy@infradead.org>
In-Reply-To: <20230919045135.3635437-6-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 20 Sep 2023 00:28:18 +0200
Message-ID: <CAHc6FU7S8pC7yZETf9y0j2c+BS2QSK0370WoDcw+AwxLUgfobA@mail.gmail.com>
Subject: Re: [PATCH 05/26] gfs2: Convert inode unstuffing to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, reiserfs-devel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 7:00=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Use the folio APIs, removing numerous hidden calls to compound_head().
> Also remove the stale comment about the page being looked up if it's NULL=
.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/bmap.c | 48 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index ef7017fb6951..247d2c16593c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -43,53 +43,51 @@ struct metapath {
>  static int punch_hole(struct gfs2_inode *ip, u64 offset, u64 length);
>
>  /**
> - * gfs2_unstuffer_page - unstuff a stuffed inode into a block cached by =
a page
> + * gfs2_unstuffer_folio - unstuff a stuffed inode into a block cached by=
 a folio
>   * @ip: the inode
>   * @dibh: the dinode buffer
>   * @block: the block number that was allocated
> - * @page: The (optional) page. This is looked up if @page is NULL
> + * @folio: The folio.
>   *
>   * Returns: errno
>   */
> -
> -static int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head=
 *dibh,
> -                              u64 block, struct page *page)
> +static int gfs2_unstuffer_folio(struct gfs2_inode *ip, struct buffer_hea=
d *dibh,
> +                              u64 block, struct folio *folio)
>  {
>         struct inode *inode =3D &ip->i_inode;
>
> -       if (!PageUptodate(page)) {
> -               void *kaddr =3D kmap(page);
> +       if (!folio_test_uptodate(folio)) {
> +               void *kaddr =3D kmap_local_folio(folio, 0);
>                 u64 dsize =3D i_size_read(inode);
>
>                 memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), =
dsize);
> -               memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -               kunmap(page);
> +               memset(kaddr + dsize, 0, folio_size(folio) - dsize);
> +               kunmap_local(kaddr);
>
> -               SetPageUptodate(page);
> +               folio_mark_uptodate(folio);
>         }
>
>         if (gfs2_is_jdata(ip)) {
> -               struct buffer_head *bh;
> +               struct buffer_head *bh =3D folio_buffers(folio);
>
> -               if (!page_has_buffers(page))
> -                       create_empty_buffers(page, BIT(inode->i_blkbits),
> -                                            BIT(BH_Uptodate));
> +               if (!bh)
> +                       bh =3D folio_create_empty_buffers(folio,
> +                               BIT(inode->i_blkbits), BIT(BH_Uptodate));
>
> -               bh =3D page_buffers(page);
>                 if (!buffer_mapped(bh))
>                         map_bh(bh, inode->i_sb, block);
>
>                 set_buffer_uptodate(bh);
>                 gfs2_trans_add_data(ip->i_gl, bh);
>         } else {
> -               set_page_dirty(page);
> +               folio_mark_dirty(folio);
>                 gfs2_ordered_add_inode(ip);
>         }
>
>         return 0;
>  }
>
> -static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct page *page=
)
> +static int __gfs2_unstuff_inode(struct gfs2_inode *ip, struct folio *fol=
io)
>  {
>         struct buffer_head *bh, *dibh;
>         struct gfs2_dinode *di;
> @@ -118,7 +116,7 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *ip=
, struct page *page)
>                                               dibh, sizeof(struct gfs2_di=
node));
>                         brelse(bh);
>                 } else {
> -                       error =3D gfs2_unstuffer_page(ip, dibh, block, pa=
ge);
> +                       error =3D gfs2_unstuffer_folio(ip, dibh, block, f=
olio);
>                         if (error)
>                                 goto out_brelse;
>                 }
> @@ -157,17 +155,17 @@ static int __gfs2_unstuff_inode(struct gfs2_inode *=
ip, struct page *page)
>  int gfs2_unstuff_dinode(struct gfs2_inode *ip)
>  {
>         struct inode *inode =3D &ip->i_inode;
> -       struct page *page;
> +       struct folio *folio;
>         int error;
>
>         down_write(&ip->i_rw_mutex);
> -       page =3D grab_cache_page(inode->i_mapping, 0);
> -       error =3D -ENOMEM;
> -       if (!page)
> +       folio =3D filemap_grab_folio(inode->i_mapping, 0);
> +       error =3D PTR_ERR(folio);
> +       if (IS_ERR(folio))
>                 goto out;
> -       error =3D __gfs2_unstuff_inode(ip, page);
> -       unlock_page(page);
> -       put_page(page);
> +       error =3D __gfs2_unstuff_inode(ip, folio);
> +       folio_unlock(folio);
> +       folio_put(folio);
>  out:
>         up_write(&ip->i_rw_mutex);
>         return error;
> --
> 2.40.1
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

