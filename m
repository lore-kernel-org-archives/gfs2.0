Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EE44C77
	for <gfs2@lists.linux.dev>; Thu, 24 Apr 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508666; cv=none; b=JVw+R6Cn/DfhZ9Ey3AhFPb/z08i52ibXWy5nKXgC7CnZRrqUSurihiQoj2yOtj95sEWX4uRxPXBd/2NRlGlrkU08dGcvrrP3l2XfcwRicJNDcU0WLr7WndtkP4TuRKqfrqa4fyV0b7w3U0mOvMG39KpFIHykNfR0e1fGd85AG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508666; c=relaxed/simple;
	bh=T/9rsbKATAUG/xGMTizs3ShSIMkltrGGP/EbsXeUF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mA4bHWe6TtKE0wAoK0H4v6k23Rgm25zfFkzClovQ0O0cDeMR7a2TMdFG/dSKA68jp4hGqsTr16v8T9Bl8rv4I6AwUvI9H0/AW67w3VCF2bBGTJeJ2JIXXHxiyov5R4HmOhGBaDSNMEdCFtE83KcE261HVgT0t/T4UL2RUhuTt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cwgghp6K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwgghp6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tywcRj40Mj2Vhr1FB2hPRZ6CN9CLSBILvYmzLPAgu0M=;
	b=Cwgghp6KHPn2ZwbuAKpU5TAgb66f6WzV/u1LS2+UrFTGsxcR7d3r92BhW8lRGydm9Uj1Se
	hjSKQcVXqtJovQy5JLP5rIwRaChifJzbMKr08SM84HjNIBHQ23isG0aMuQyc2pH02wQE6x
	LqJBLeJ6x6BRVwHB34E72aJRg3Mq2iY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-f3J2yMibMIGNQDXa785CGg-1; Thu, 24 Apr 2025 11:31:01 -0400
X-MC-Unique: f3J2yMibMIGNQDXa785CGg-1
X-Mimecast-MFC-AGG-ID: f3J2yMibMIGNQDXa785CGg_1745508661
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254e0b4b85so12488275ad.0
        for <gfs2@lists.linux.dev>; Thu, 24 Apr 2025 08:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508659; x=1746113459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tywcRj40Mj2Vhr1FB2hPRZ6CN9CLSBILvYmzLPAgu0M=;
        b=aX/AzwO8++bWstuL4VpccHJawlCccErMXqbLosqeW3bFwM07ISN13bvD/LekzF1FOD
         UBNyggYjKdMUvx5/CR0rrEXDTQWcDinbB01MTJz6xa05VMKtteAJlBi7LzirHkyKiyrt
         EbalERZ12F4W+rNlQIXxyYsGN3MRE/JLfvba41IanEGy9eLiqbUyWPRpGIOqbbLVk9Ks
         10XEYywa1sCPYo3gvIdmw5npZTll5uJdrSD2FZ7ncuTqgn3i0xp7YjgciEGzHuwPSzH5
         DR66nYf0HtPxl/V/jd5X3OECp0oy87vEK0CjMti8VYgN756JorI8SFCdqRDDii0iCsQu
         j2Ew==
X-Gm-Message-State: AOJu0YyE6Y4ju6iuNZW65d2W3gDJNNzaPTdow4g4yDrb7eS4IJCkPV2p
	A7SVH4Nvi2Y3xdAy8GkOfrys5RIIhIxw1YQTylkOWw7ySMLC7/YMA3tLk6cjuZI5Ok8hsry2KVO
	LRlPICJeYySzZLX11hABaAkuqjDj5wVfx5hmJbYjjoQFUubzjJiTmFddkibsjEATc4o+4g4yTnu
	1wwgHFRC961vrKtldf6ucMN8QnTR0I1ziIYGkO
X-Gm-Gg: ASbGnctVtY3x7YyGVK4SixfM3qmZj6d2kjCnLoyz/a9fF/ylp+/t2woD+dtMxymhjG/
	gZq3s1wzDJRaxa95sj/DVd9m17YYa40DUuYIk79G0IRIAIemhN+GbLk20R3zlzjJQNVw=
X-Received: by 2002:a17:902:f70f:b0:224:24d3:60fb with SMTP id d9443c01a7336-22db47f56damr41518075ad.10.1745508659570;
        Thu, 24 Apr 2025 08:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIWjl1jg5AS/NsmlmOugICus0sCRrmOqESj2SNxQU1/e3qfGwymZWawrOOz2GUswskvGonRagAvH/8v7vBPsA=
X-Received: by 2002:a17:902:f70f:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-22db47f56damr41517735ad.10.1745508659145; Thu, 24 Apr 2025
 08:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250423162717.1234285-1-agruenba@redhat.com> <e3af30f8-f777-487a-a0b1-9b2ac3bd546d@redhat.com>
In-Reply-To: <e3af30f8-f777-487a-a0b1-9b2ac3bd546d@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 24 Apr 2025 17:30:46 +0200
X-Gm-Features: ATxdqUEpEgk86QYviFwiObwzJE6QSGR5_RMcOw7ann3HFuJ-AdjfC7PdhAbxEwk
Message-ID: <CAHc6FU6XuNHAYrdd-OmY6-sE=NFB=sqJHx9cQkyvkAC9wvni1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gfs2: deallocate inodes in gfs2_create_inode
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ADnejbUs7MjFYRP4K-1UCVRw5minrHl_G6_BzV8I47M_1745508661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:08=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> On 23/04/2025 17:27, Andreas Gruenbacher wrote:
> > When creating and destroying inodes, we are relying on the inode hash
> > table to make sure that for a given inode number, only a single inode
> > will exist.  We then link that inode to its inode and iopen glock and
> > let those glocks point back at the inode.  However, when iget_failed()
> > is called, the inode is removed from the inode hash table before
> > gfs_evict_inode() is called, and uniqueness is no longer guaranteed.
> >
> > Commit f1046a472b70 ("gfs2: gl_object races fix") was trying to work
> > around that problem by detaching the inode glock from the inode before
> > calling iget_failed(), but that broke the inode deallocation code in
> > gfs_evict_inode().
> >
> > To fix that, deallocate partially created inodes in gfs2_create_inode()
> > instead of relying on gfs_evict_inode() for doing that.
> >
> > This means that gfs2_evict_inode() and its helper functions will no
> > longer see partially created inodes, and so some simplifications are
> > possible there.
> >
> > Fixes: f1046a472b70 ("gfs2: gl_object races fix")
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >   fs/gfs2/inode.c | 23 +++++++++++++++--------
> >   fs/gfs2/super.c |  8 ++------
> >   fs/gfs2/super.h |  2 ++
> >   3 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > index 0b2d75106b1c..95c39798901b 100644
> > --- a/fs/gfs2/inode.c
> > +++ b/fs/gfs2/inode.c
> > @@ -697,10 +697,11 @@ static int gfs2_create_inode(struct inode *dir, s=
truct dentry *dentry,
> >       struct gfs2_inode *dip =3D GFS2_I(dir), *ip;
> >       struct gfs2_sbd *sdp =3D GFS2_SB(&dip->i_inode);
> >       struct gfs2_glock *io_gl;
> > -     int error;
> > +     int error, error2;
> >       u32 aflags =3D 0;
> >       unsigned blocks =3D 1;
> >       struct gfs2_diradd da =3D { .bh =3D NULL, .save_loc =3D 1, };
> > +     bool xattr_initialized =3D false;
>
> This variable isn't used in this version.
>
> >
> >       if (!name->len || name->len > GFS2_FNAMESIZE)
> >               return -ENAMETOOLONG;
> > @@ -813,11 +814,11 @@ static int gfs2_create_inode(struct inode *dir, s=
truct dentry *dentry,
> >
> >       error =3D gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, C=
REATE, &ip->i_gl);
> >       if (error)
> > -             goto fail_free_inode;
> > +             goto fail_dealloc_inode;
> >
> >       error =3D gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, C=
REATE, &io_gl);
> >       if (error)
> > -             goto fail_free_inode;
> > +             goto fail_dealloc_inode;
> >       gfs2_cancel_delete_work(io_gl);
> >       io_gl->gl_no_formal_ino =3D ip->i_no_formal_ino;
> >
> > @@ -842,8 +843,10 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       if (error)
> >               goto fail_gunlock3;
> >
> > -     if (blocks > 1)
> > +     if (blocks > 1) {
> >               gfs2_init_xattr(ip);
> > +             xattr_initialized =3D true;
> > +     }
> >       init_dinode(dip, ip, symname);
> >       gfs2_trans_end(sdp);
> >
> > @@ -898,6 +901,14 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       gfs2_glock_dq_uninit(&ip->i_iopen_gh);
> >   fail_gunlock2:
> >       gfs2_glock_put(io_gl);
> > +fail_dealloc_inode:
> > +     set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> > +     clear_nlink(inode);
> > +     mark_inode_dirty(inode);
> > +     error2 =3D evict_unlinked_inode(inode);
>
> So we're switching to only checking ip->i_eattr and calling
> gfs2_ea_dealloc() indirectly with the initialized argument always true.
> I don't think that's right as ip->i_eattr gets set much earlier than the
> gfs2_init_xattr() call.

Right ... this code is so awful ...

I've sent a fixed version that will hopefully be final.

Thanks,
Andreas

> Andy
>
> > +     if (error2)
> > +             fs_warn(sdp, "%s: %d\n", __func__, error2);
> > +     ip->i_no_addr =3D 0;
> >   fail_free_inode:
> >       if (ip->i_gl) {
> >               gfs2_glock_put(ip->i_gl);
> > @@ -912,10 +923,6 @@ static int gfs2_create_inode(struct inode *dir, st=
ruct dentry *dentry,
> >       gfs2_dir_no_add(&da);
> >       gfs2_glock_dq_uninit(&d_gh);
> >       if (!IS_ERR_OR_NULL(inode)) {
> > -             set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
> > -             clear_nlink(inode);
> > -             if (ip->i_no_addr)
> > -                     mark_inode_dirty(inode);
> >               if (inode->i_state & I_NEW)
> >                       iget_failed(inode);
> >               else
> > diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> > index e25a24ae2197..c154fc209816 100644
> > --- a/fs/gfs2/super.c
> > +++ b/fs/gfs2/super.c
> > @@ -1258,9 +1258,6 @@ static enum evict_behavior evict_should_delete(st=
ruct inode *inode,
> >       struct gfs2_sbd *sdp =3D sb->s_fs_info;
> >       int ret;
> >
> > -     if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
> > -             goto should_delete;
> > -
> >       if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
> >           test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
> >               return EVICT_SHOULD_DEFER_DELETE;
> > @@ -1290,7 +1287,6 @@ static enum evict_behavior evict_should_delete(st=
ruct inode *inode,
> >       if (inode->i_nlink)
> >               return EVICT_SHOULD_SKIP_DELETE;
> >
> > -should_delete:
> >       if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
> >           test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags))
> >               return gfs2_upgrade_iopen_glock(inode);
> > @@ -1301,7 +1297,7 @@ static enum evict_behavior evict_should_delete(st=
ruct inode *inode,
> >    * evict_unlinked_inode - delete the pieces of an unlinked evicted in=
ode
> >    * @inode: The inode to evict
> >    */
> > -static int evict_unlinked_inode(struct inode *inode)
> > +int evict_unlinked_inode(struct inode *inode)
> >   {
> >       struct gfs2_inode *ip =3D GFS2_I(inode);
> >       int ret;
> > @@ -1314,7 +1310,7 @@ static int evict_unlinked_inode(struct inode *ino=
de)
> >       }
> >
> >       if (ip->i_eattr) {
> > -             ret =3D gfs2_ea_dealloc(ip, !test_bit(GIF_ALLOC_FAILED, &=
ip->i_flags));
> > +             ret =3D gfs2_ea_dealloc(ip, true);
> >               if (ret)
> >                       goto out;
> >       }
> > diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
> > index b27a774d9580..46f32f66082b 100644
> > --- a/fs/gfs2/super.h
> > +++ b/fs/gfs2/super.h
> > @@ -15,6 +15,8 @@
> >   #define GFS2_FS_FORMAT_MIN (1801)
> >   #define GFS2_FS_FORMAT_MAX (1802)
> >
> > +int evict_unlinked_inode(struct inode *inode);
> > +
> >   void gfs2_lm_unmount(struct gfs2_sbd *sdp);
> >
> >   static inline unsigned int gfs2_jindex_size(struct gfs2_sbd *sdp)
>

