Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287B350285
	for <gfs2@lists.linux.dev>; Sun, 15 Mar 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582703; cv=pass; b=a/Xai8GZG1bLLNx+d7hcpvcDg0bEvQnoJ35ZQzZmouKOt3T++z9f4e9SrsIGQUlRlsWLy5UGhScVPIdEAq9y7sG44AWXd6gqcBm+ncgFWAsosGc6H02ZS6JxZbVHCyC5rHtl0s7gVNKGK71QUDcTthsnloWQ5IO2qmIEumunWKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582703; c=relaxed/simple;
	bh=Vs01mlsWygXmaXPS3h5z1k3Hf3KZR9yElATURfIfNww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDaaqF19suhNrprom3Q5zmFWI/n8dTWxjqIzX2rv/fwx0b7+xAAsWBhmdYYTBOrmsbCW1X5EprkHag33QSz7hlHMh3zdLBzuJMeEc5ePyIGAgjyN2MXMbwalByvJNiQHhM8kZewo5keqM0tPxLx2O0LHogCEouPa6XoOMXkZ+KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUGrH7Za; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUGrH7Za"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9704cd6951so378737766b.3
        for <gfs2@lists.linux.dev>; Sun, 15 Mar 2026 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773582700; cv=none;
        d=google.com; s=arc-20240605;
        b=eq/aQtxmAw/0QZvAX/jAn1FT9RWpnK+mSVbZlZRQD/Sqc2bTF8vGlvMTxQLaEhTOAR
         +NaEdUS5/6e/Xr+57GWAcPhH5EZLtzgJyJXP84et42YAmZtAd9vcHxvwSqwvtleQfVKZ
         ZAKL3g8807J3xiHWVz3qYMEGjNiWXqCyAVhFAfFTuJ2VR2bu16UKhsrRxFTD4yU1if6U
         zQqJh6RzWCLC0tAeHOlTb31InvYygRgWaY+f025MHVikrOfqqU17LMJSIipR9/wnu2wr
         IazYWB7Gm5eF/gVgKYbrcKwAth03PcQr7cMZh7tDNMTwDGI3irPsl2+GxFrINIy7thoe
         kCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        fh=aOWX2D+WSIEbC0VzBujij1PoTTnOtgO9eJ8DAWu3wlc=;
        b=UnJc1SUYvBmWtK9PzIHqVcaThisrwX+kI+hudIqJSQwE2F2rToIsIObuHtPJwW9mJ3
         QfCHABJ190SY5lvAQrBrHN1k3WMerEJ7l5jj6nuJHDWK2OTuVd1c6cpNQqt6RBjAVNmO
         7vqxa5TWr/tb+fPX+NMdaUUHQ9nKObLffSqooT7AFAvuN3M69Hu2C8+eMZBQwuC6fwmt
         Y+NwdEVbq73BFYKAdnkYPcuW12p95MYMx/Wz8KrazekT4vbG2q0CgQHngrv+TAxnIn1i
         ug7PH8IoMpxylgfJefltk9YyyQyRKGp4yn+5SO3Q1UcPJJkOnGyuIisOO3MrZFHBuu9S
         e1Mw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773582700; x=1774187500; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        b=NUGrH7Zaml+cat1S0G5MYFlnpROyLkUCvAzQyr+Tn/5kRAfHBoE98jX3ZGdjKRo04o
         u09W56kK4kbXPv8BScB40dTKwqfQrc/hA88CqsBNMfYpQNTgkTgkY6+gPOqX3xJ43iQH
         t7n8ZHnjx7ssS7sYFsNi+ax/X77m2HkuiEnKm3YIvQpQotR6xLHK1TyGWezOcB7d6QDU
         1pRfBmbmJozbxwnwcz3rjq4s62KcFnPyNU5kIdYiOEm8PzcMCQ/NU41DZq+JxinmMduy
         vfFHAwjqUFeVKA47oYXFmIb5P8bav+Et5fTjFeVQa25iO8MM+fCZ9d6ypcyD03zcDrrU
         3dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773582700; x=1774187500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        b=fzV0TlAWUrL/tmmUp16PVbpXHF6ytSRB6flDJlegigmKEpxc0nz1rFuawwL3YemoU9
         DSa2gaIELTmF0C9pxG+cWUwlCJuuN0WjU3lt1swuyg0Zdc0tqB6IIkrSKRlTUja6nujU
         t6Y/wFEWBvM/J3oOlES8ayrzG0B5ztFh4NwEpVBx12AeBfDwVBbgOwZ1GsPW2XZLmXrl
         mtxhutxDspkpzhQAMx+zzDpBAXA1Gvxgbp+DinAlINO8tuzvFTfqfk3blyukcdJkrB3L
         g47HREAR5Bu2qzjxzLKB79rKNixjYXamEcHZWRlS0l66G+h2X7T1zzV7vCtCtBWkLAsD
         xThQ==
X-Forwarded-Encrypted: i=1; AJvYcCVknIWAgNG6cf7FXzJTUx+ia4Hk6nw8d8hS9uDmCoEsSXnCYrJL7Vk6bbaIlzEgBuklbJhb@lists.linux.dev
X-Gm-Message-State: AOJu0YyMZu6P02E8wv4Wc5lLMUxzkLshejD3Nu6SSmg6uBSSVs78ey0o
	uID961g62U1g2Y8qMhT0iFuUvVpPUwaDx919fMCTKn3ibTzEYWeMWadXYDQqUjQqEbr1kV5RKkL
	XZ3EwNIqhhI1OCNk5DEoA6G29G+w62KE=
X-Gm-Gg: ATEYQzz45iXUFB5Hf+gmiGWJzHumO0Fk/42k9bituhwEb6Kt4BRQF1sBHhwiB940xJX
	OUVZXSWMVwb4EGAKWnObspf2PlewffoNo9aC6pYYsXIO8viIi+mnk8ExCHWM2lyNEHrGQMGfLS2
	hIlASWIdeptvAbQa3VVtr4/qBtPYcR4tt2F2m7pXeAtx7l5jMm4DmCpkNeovFzPOJYbyCMWD6Am
	ZjglzGYiNfSMjN2/+alcfh4DgUeG4AEj8aL+EmMCEo2jV4cirjZRZVTee3Vi9zygqLU5IOhjZop
	P8wQjpCau82lHzY0Fp+x0meZ5pdLXjafFRFHKv74Fw==
X-Received: by 2002:a17:907:8dcd:b0:b93:c5a9:a5e6 with SMTP id
 a640c23a62f3a-b976507af92mr500109966b.2.1773582699724; Sun, 15 Mar 2026
 06:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net> <20260312214330.3885211-17-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-17-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Mar 2026 14:51:27 +0100
X-Gm-Features: AaiRm50yYPhN2uA9nBAPVNuAVUOhGIEBVS5rPtx5ZlpdDP1j4SB9NhEOC_7KNWo
Message-ID: <CAOQ4uxjmcNxsCmDSVgkTns=3BAuQcT3pVvsQzza+u3iqXqrz5g@mail.gmail.com>
Subject: Re: [PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:49=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> From: NeilBrown <neil@brown.name>
>
> When performing an "impure" readdir, ovl needs to perform a lookup on som=
e
> of the names that it found.
> With proposed locking changes it will not be possible to perform this
> lookup (in particular, not safe to wait for d_alloc_parallel()) while
> holding a lock on the directory.
>
> ovl doesn't really need the lock at this point.

Not exactly. see below.

> It has already iterated
> the directory and has cached a list of the contents.  It now needs to
> gather extra information about some contents.  It can do this without
> the lock.
>
> After gathering that info it needs to retake the lock for API
> correctness.  After doing this it must check IS_DEADDIR() again to
> ensure readdir always returns -ENOENT on a removed directory.
>
> Note that while ->iterate_shared is called with a shared lock, ovl uses
> WRAP_DIR_ITER() so an exclusive lock is held and so we drop and retake
> that exclusive lock.
>
> As the directory is no longer locked in ovl_cache_update() we need
> dget_parent() to get a reference to the parent.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/readdir.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f..d5123b37921c 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -568,13 +568,12 @@ static int ovl_cache_update(const struct path *path=
, struct ovl_cache_entry *p,
>                         goto get;
>                 }
>                 if (p->len =3D=3D 2) {
> -                       /* we shall not be moved */
> -                       this =3D dget(dir->d_parent);
> +                       this =3D dget_parent(dir);
>                         goto get;
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> +       this =3D lookup_one_unlocked(mnt_idmap(path->mnt), &QSTR_LEN(p->n=
ame, p->len), dir);

ovl_cache_update() is also called from ovl_iterate_merged() where inode
is locked.

>         if (IS_ERR_OR_NULL(this) || !this->d_inode) {
>                 /* Mark a stale entry */
>                 p->is_whiteout =3D true;
> @@ -666,11 +665,12 @@ static int ovl_dir_read_impure(const struct path *p=
ath,  struct list_head *list,
>         if (err)
>                 return err;
>
> +       inode_unlock(path->dentry->d_inode);
>         list_for_each_entry_safe(p, n, list, l_node) {
>                 if (!name_is_dot_dotdot(p->name, p->len)) {
>                         err =3D ovl_cache_update(path, p, true);
>                         if (err)
> -                               return err;
> +                               break;
>                 }
>                 if (p->ino =3D=3D p->real_ino) {
>                         list_del(&p->l_node);
> @@ -680,14 +680,19 @@ static int ovl_dir_read_impure(const struct path *p=
ath,  struct list_head *list,
>                         struct rb_node *parent =3D NULL;
>
>                         if (WARN_ON(ovl_cache_entry_find_link(p->name, p-=
>len,
> -                                                             &newp, &par=
ent)))
> -                               return -EIO;
> +                                                             &newp, &par=
ent))) {
> +                               err =3D -EIO;
> +                               break;
> +                       }
>
>                         rb_link_node(&p->node, parent, newp);
>                         rb_insert_color(&p->node, root);
>                 }
>         }
> -       return 0;
> +       inode_lock(path->dentry->d_inode);
> +       if (IS_DEADDIR(path->dentry->d_inode))
> +               err =3D -ENOENT;
> +       return err;
>  }
>
>  static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *pat=
h)
> --

You missed the fact that overlayfs uses the dir inode lock
to protect the readdir inode cache, so your patch introduces
a risk for storing a stale readdir cache when dir modify operations
invalidate the readdir cache version while lock is dropped
and also introduces memory leak when cache is stomped
without freeing cache created by a competing thread.
I think something like the untested patch below should fix this.

I did not look into ovl_iterate_merged() to see if it has a simple
fix and I am not 100% sure that this fix for impure dir is enough.

Thanks,
Amir.

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index d5123b37921c8..9e90064b252ce 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -702,15 +702,13 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
        struct inode *inode =3D d_inode(dentry);
        struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
        struct ovl_dir_cache *cache;
+       /* Snapshot version before ovl_dir_read_impure() drops i_rwsem */
+       u64 version =3D ovl_inode_version_get(inode);

        cache =3D ovl_dir_cache(inode);
-       if (cache && ovl_inode_version_get(inode) =3D=3D cache->version)
+       if (cache && version =3D=3D cache->version)
                return cache;

-       /* Impure cache is not refcounted, free it here */
-       ovl_dir_cache_free(inode);
-       ovl_set_dir_cache(inode, NULL);
-
        cache =3D kzalloc_obj(struct ovl_dir_cache);
        if (!cache)
                return ERR_PTR(-ENOMEM);
@@ -721,6 +719,14 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
                kfree(cache);
                return ERR_PTR(res);
        }
+
+       /*
+        * Impure cache is not refcounted, free it here.
+        * Also frees cache stored by concurrent readdir during i_rwsem dro=
p.
+        */
+       ovl_dir_cache_free(inode);
+       ovl_set_dir_cache(inode, NULL);
+
        if (list_empty(&cache->entries)) {
                /*
                 * A good opportunity to get rid of an unneeded "impure" fl=
ag.
@@ -736,7 +742,7 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
                return NULL;
        }

-       cache->version =3D ovl_inode_version_get(inode);
+       cache->version =3D version;
        ovl_set_dir_cache(inode, cache);

        return cache;
