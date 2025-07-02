Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FD242D64
	for <gfs2@lists.linux.dev>; Wed,  2 Jul 2025 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498426; cv=none; b=Tri2XsGiGMfhrx4j9c8JOtuWG1gAJg+4ejgk/x4xNQgW6Z3aNVO9Epf2j5FDGQ7balpL1p9AQYOLd+WqTbtmT3XIWSBrja0DK3a2BxbrBHXostzHefp6Jld4ah7Wi+BMI932jZRagOF3ljjh0lFva0UR1q+y0URF20P4a2pZ0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498426; c=relaxed/simple;
	bh=blCkfpz21rn1nv9mgJ/oPvUVXFZla3hl/MNsev/a4Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUrthC9iEjbl+e0v9z3UDd5PuzC1WoF1K7gLHgeEAUpLmQVG4KnAuOYIdtTHX7o/J7Mg/8jl0L9x8KEX4WbzmUU0nhT3joQxRCEl6IEeFGxbxwjJS3Bh+KN1w+BlTxXXTRsUnMOJHCHxJZQRVasFnVxmv0HQlZavXj3WeBH6V7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU60CjJK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU60CjJK"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a76ea97cefso48738111cf.2
        for <gfs2@lists.linux.dev>; Wed, 02 Jul 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751498423; x=1752103223; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRo94/lWqiwbS1Rl5pxqVdA19w+jpv0tMe/8YRHBmYg=;
        b=IU60CjJKGSrKd+Ojqbln93W5AQtrn0FkWdrhh42veji1eQtn9ObGU6bUYYwxKyknOf
         Zn2TSiOaRKusFttGGioqbH6s8PJiwqdBe2uaerFrq5I1SR6SlMgtKB29WV98uaEx9Mct
         iT+n1xVhh2qrQItf65RlSO8iYRzMzVJiSMLdlPzY4C/9Vh5otcslV6anVWoX0vDm22Rf
         uvfyX2Z+pgs+DNr+M86mBQxHtI6z3dDEsSHTJxne6D4k9htl0hxefxwd4KQg5YOWkOlb
         JwJsX0Qr23I3DqKU6NPeTFktFflDPwramLDRZqoCc93GGUiOJNHuJEYfVV0DvNnG+zag
         CkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751498423; x=1752103223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRo94/lWqiwbS1Rl5pxqVdA19w+jpv0tMe/8YRHBmYg=;
        b=FxvIicCGW8TJZ3tU+2tr9fk/4Fxf/jbW/qI1uBY+8RgX47VedmhaocJPf/5Ul+WiPE
         wBpPuJd/5rdJdzICfjr/WybgV64c3lcjOS/I+Fvz5ZIz3eDeUQkU8a4Ypodr/kgYfYcy
         UJOMuz/HNRTuol9cnBfl4T9MyHMZEvLNx7W2qh4hy5DlyVYP1mm27vAYRwcXuB0SMQPK
         N4pgnn1Vqg3D9dJTuG12d2v3zSsOlNueBkdi5n+wHJ8OHItoC3FfWIYUql4lDh8HilqC
         lLDaDLSjSXDJeOslDAL/F9y0ehDz2T4v1LF/lBhUX0hJI/4JY7jf1S81nRrG6FJXx0p3
         /yow==
X-Forwarded-Encrypted: i=1; AJvYcCX8vAfvN6mMy8YYCOOzad99guraw2XYsPxjaR2jWsZXikpjthmaxoZawUEuwC2UrAVGXRSk@lists.linux.dev
X-Gm-Message-State: AOJu0Yy276/8eBXfA0GRhdngFauCzshg8bG6tOsvYNP+0poHiaak5nxw
	bENJFpjC6TfSrs7ARObpHuAW9CXLAcR7zeoIAe9oJBnpOrjfkocAtUEJwUKOyUNrg8F98yNxKS0
	cDrZl1D70GgZJtHb/C7bwS+o8d2fAjw4=
X-Gm-Gg: ASbGncufQVk1k4xdhLu84Q5C5utCeFNb0R1CmYTRRnNHlYe2tCd0y9X+/Rge9uswZKg
	6kDuEYy/JbBUL3q0We2EITcC3UhFfNVtO+mtSg4rg6CjXYeJmDfU24oSpVxn36C9mpWZhLsCzKg
	xs8zWMidQUuz1CDMCioEoQqBVHrm+ghaOsefN3xD0K22opzrV+bjJ8Tb5qlwI=
X-Google-Smtp-Source: AGHT+IG9s4tMDn5+3npL/jz5mUHQ8KIgvpktx7fqFXcoH4WVcqnLgRMMx//WSoYNhumBoQZLuaZJvAAWFENRUKnlPLs=
X-Received: by 2002:ac8:7f89:0:b0:4a8:eb1:9b7 with SMTP id d75a77b69052e-4a9769f4383mr79493981cf.49.1751498422475;
 Wed, 02 Jul 2025 16:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-14-joannelkoong@gmail.com> <20250702181324.GH10009@frogsfrogsfrogs>
In-Reply-To: <20250702181324.GH10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 16:20:11 -0700
X-Gm-Features: Ac12FXyBoj6U4xrAWUwxsCBkfqXVQVy6soHuMPeiWNU01YCndBaQj6kmRs9zfcA
Message-ID: <CAJnrk1Z8ycJpyj3RuWvb-snKM6JxUQL5-RAhaHdVm+wz3u1+7w@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu, 
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:13=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jun 23, 2025 at 07:21:32PM -0700, Joanne Koong wrote:
> > Use iomap for dirty folio writeback in ->writepages().
> > This allows for granular dirty writeback of large folios.
> >
> > Only the dirty portions of the large folio will be written instead of
> > having to write out the entire folio. For example if there is a 1 MB
> > large folio and only 2 bytes in it are dirty, only the page for those
> > dirty bytes will be written out.
> >
> > .dirty_folio needs to be set to iomap_dirty_folio so that the bitmap
> > iomap uses for dirty tracking correctly reflects dirty regions that nee=
d
> > to be written back.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 124 ++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 75 insertions(+), 49 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index a7f11c1a4f89..2b4b950eaeed 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1837,7 +1837,7 @@ static void fuse_writepage_finish(struct fuse_wri=
tepage_args *wpa)
> >                * scope of the fi->lock alleviates xarray lock
> >                * contention and noticeably improves performance.
> >                */
> > -             folio_end_writeback(ap->folios[i]);
> > +             iomap_finish_folio_write(inode, ap->folios[i], 1);
> >               dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> >               wb_writeout_inc(&bdi->wb);
> >       }
> > @@ -2024,19 +2024,20 @@ static void fuse_writepage_add_to_bucket(struct=
 fuse_conn *fc,
> >  }
> >
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       uint32_t folio_index)
> > +                                       uint32_t folio_index, loff_t of=
fset, unsigned len)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> >       ap->folios[folio_index] =3D folio;
> > -     ap->descs[folio_index].offset =3D 0;
> > -     ap->descs[folio_index].length =3D folio_size(folio);
> > +     ap->descs[folio_index].offset =3D offset;
> > +     ap->descs[folio_index].length =3D len;
> >
> >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> >  }
> >
> >  static struct fuse_writepage_args *fuse_writepage_args_setup(struct fo=
lio *folio,
> > +                                                          size_t offse=
t,
> >                                                            struct fuse_=
file *ff)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> > @@ -2049,7 +2050,7 @@ static struct fuse_writepage_args *fuse_writepage=
_args_setup(struct folio *folio
> >               return NULL;
> >
> >       fuse_writepage_add_to_bucket(fc, wpa);
> > -     fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio), 0);
> > +     fuse_write_args_fill(&wpa->ia, ff, folio_pos(folio) + offset, 0);
> >       wpa->ia.write.in.write_flags |=3D FUSE_WRITE_CACHE;
> >       wpa->inode =3D inode;
> >       wpa->ia.ff =3D ff;
> > @@ -2075,7 +2076,7 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
> >       if (!ff)
> >               goto err;
> >
> > -     wpa =3D fuse_writepage_args_setup(folio, ff);
> > +     wpa =3D fuse_writepage_args_setup(folio, 0, ff);
> >       error =3D -ENOMEM;
> >       if (!wpa)
> >               goto err_writepage_args;
> > @@ -2084,7 +2085,7 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
> >       ap->num_folios =3D 1;
> >
> >       folio_start_writeback(folio);
> > -     fuse_writepage_args_page_fill(wpa, folio, 0);
> > +     fuse_writepage_args_page_fill(wpa, folio, 0, 0, folio_size(folio)=
);
> >
> >       spin_lock(&fi->lock);
> >       list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> > @@ -2105,7 +2106,7 @@ struct fuse_fill_wb_data {
> >       struct fuse_file *ff;
> >       struct inode *inode;
> >       unsigned int max_folios;
> > -     unsigned int nr_pages;
> > +     unsigned int nr_bytes;
> >  };
> >
> >  static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
> > @@ -2147,21 +2148,28 @@ static void fuse_writepages_send(struct fuse_fi=
ll_wb_data *data)
> >  }
> >
> >  static bool fuse_writepage_need_send(struct fuse_conn *fc, struct foli=
o *folio,
> > +                                  loff_t offset, unsigned len,
> >                                    struct fuse_args_pages *ap,
> >                                    struct fuse_fill_wb_data *data)
> >  {
> > +     struct folio *prev_folio;
> > +     struct fuse_folio_desc prev_desc;
> > +
> >       WARN_ON(!ap->num_folios);
> >
> >       /* Reached max pages */
> > -     if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
> > +     if ((data->nr_bytes + len) / PAGE_SIZE > fc->max_pages)
> >               return true;
> >
> >       /* Reached max write bytes */
> > -     if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_wr=
ite)
> > +     if (data->nr_bytes + len > fc->max_write)
> >               return true;
> >
> >       /* Discontinuity */
> > -     if (folio_next_index(ap->folios[ap->num_folios - 1]) !=3D folio->=
index)
> > +     prev_folio =3D ap->folios[ap->num_folios - 1];
> > +     prev_desc =3D ap->descs[ap->num_folios - 1];
> > +     if ((folio_pos(prev_folio) + prev_desc.offset + prev_desc.length)=
 !=3D
> > +         folio_pos(folio) + offset)
> >               return true;
> >
> >       /* Need to grow the pages array?  If so, did the expansion fail? =
*/
> > @@ -2171,85 +2179,103 @@ static bool fuse_writepage_need_send(struct fu=
se_conn *fc, struct folio *folio,
> >       return false;
> >  }
> >
> > -static int fuse_writepages_fill(struct folio *folio,
> > -             struct writeback_control *wbc, void *_data)
> > +static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *=
wpc,
> > +                                       struct folio *folio, u64 pos,
> > +                                       unsigned len, u64 end_pos)
> >  {
> > -     struct fuse_fill_wb_data *data =3D _data;
> > +     struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
> >       struct fuse_writepage_args *wpa =3D data->wpa;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >       struct inode *inode =3D data->inode;
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > -     int err;
> > +     loff_t offset =3D offset_in_folio(folio, pos);
> > +
> > +     WARN_ON_ONCE(!data);
> > +     /* len will always be page aligned */
> > +     WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> >
> >       if (!data->ff) {
> > -             err =3D -EIO;
> >               data->ff =3D fuse_write_file_get(fi);
> >               if (!data->ff)
> > -                     goto out_unlock;
> > +                     return -EIO;
> >       }
> >
> > -     if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
> > +     iomap_start_folio_write(inode, folio, 1);
> > +
> > +     if (wpa && fuse_writepage_need_send(fc, folio, offset, len, ap, d=
ata)) {
> >               fuse_writepages_send(data);
> >               data->wpa =3D NULL;
> > -             data->nr_pages =3D 0;
> > +             data->nr_bytes =3D 0;
> >       }
> >
> >       if (data->wpa =3D=3D NULL) {
> > -             err =3D -ENOMEM;
> > -             wpa =3D fuse_writepage_args_setup(folio, data->ff);
> > +             wpa =3D fuse_writepage_args_setup(folio, offset, data->ff=
);
> >               if (!wpa)
> > -                     goto out_unlock;
> > +                     return -ENOMEM;
>
> If we error out here, what subtracts from write_bytes_pending the
> quantity that we just added in iomap_start_folio_write?
>
> (It would have helped a lot if the cover letter had linked to a git
> branch so I could go look at the final product for myself...)
>

Ugh you're right, this needs to be accounted for in the error cases.
I'll fix this in v4. Thanks for spotting this. I'll make a git branch
and include a link to it in v4 as well.

> --D
>
