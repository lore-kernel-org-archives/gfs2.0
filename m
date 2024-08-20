Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC39191F8C
	for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164899; cv=none; b=E2SiJICuZO7KOphIsdlRj2JeTnaekQH1gOakhJDBvYZBW+1aur5BiTcO/umRpS9SrLfseijBVrkjY32e8WKM4CQTwRwPse8d1oMWsJYPB7Bj3q9rdmNsB6Uu5FrzDSbyPkDaAJukYd36w0IwrWZU57AOIEX/oXS99DAUMAPJLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164899; c=relaxed/simple;
	bh=ol+KLWbA2n+RZgCVOjQA6F0ZFiUQopgZSe8GIuN2fzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqo8p1iGT28EdnEBQQwDbfjYAmS1ufEu2533/vKkZWi6z6vHfgAEZeOIA+PGAXV6giFyM2N5zsgsUozvV/0df0LuH3aNL9Ww5T7PTyPwLtT4J4A9fddlyBy+ckNFXIcjdOzRSQLX+XBK6kDjd1it0roFgOkewUEd+WuIjGiuI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxQ1Em0Z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxQ1Em0Z"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so11351711fa.2
        for <gfs2@lists.linux.dev>; Tue, 20 Aug 2024 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164896; x=1724769696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COJqsdsUimC40QurmxvQ2PDteURpDZpJHvtTTyWWXds=;
        b=FxQ1Em0ZyCpS5zI8GvxistJ/rCj+IemSubzVS6AT9lZ9CTz7uPMhOB28AeJYMKPyHH
         ozsAjsuwpXypWg8+PGhxRl1wal+YrkgvI45iLv1tZ0fIuelc2YK7PgWgpzbeBV7Bp22N
         IWRfoH3vgyHn3bgJGq9+8ZQqEu2SmKslsLiXqVp8Yc0lC1L5zQHYLuNOcQMr/tNWFuXR
         QiDLUxaflPxLCfBsCJWNDYZ7dVp+bt/DJIxGdYMS0J4laIbTfGNSSU9RWxyhkjEi08qO
         vzJddODWhYQFiFdSOaISIxjEfusaJZ/rLRBJBSL85rLdvRqSUzHty7IViELA4QpOiPbI
         vmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164896; x=1724769696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COJqsdsUimC40QurmxvQ2PDteURpDZpJHvtTTyWWXds=;
        b=wOUumG3MvSPkr3+2TP2vL2LBHxrkHBDS1G9OOwdYRnuqXKvkt4mZih0R6l6hPZht9D
         DJ5SUzEzigE+zEJdweQnz9bRq1bG2Ibskh/FmKO7HRWas6uH8gEczmM77VDFhZlkgFBB
         4P2MZKt9eRJMy4xDUyTSLXE5wieEyHzyMGRq9PXMYGAdkzJUTp6snpVz3yzS1FqWDFZ5
         SuvBLjkwkT+jOXGWa4ryScpB6fDqhl6zNY2fLo3jAoIltEC3ngoCxE1lx1VkzUtR/Gqb
         vpKJsQKV7oaY2ja1VGGLyPLeFYUWvKgrOOHpo4beDM2a+HrofQhuOCjXFCZwCwrJDk/r
         PD9A==
X-Gm-Message-State: AOJu0YyGmqtyG+oNPX5CDMWlEk73l/mSIw2V1Hx2Ll2VXqjDe6N6b18J
	+W/3dr+S9E43iGo1q2m6xdxdBn3gmmNiqYzvTLvFeUg8uh/XNYbWcAMsyfSDJhwxVGYM25r5Xf/
	eCHwKxDa8eOJNlwmO1rC03gnukU4=
X-Google-Smtp-Source: AGHT+IFs3rvyeXkj2tvWqusUlk0Gnjrjtiy6bfyOtPXdZdDMGbtqrAaEhUtsoSoT/xZRdVNT440vMqkHDu8HrJmMptM=
X-Received: by 2002:a2e:bc09:0:b0:2ef:23ec:9356 with SMTP id
 38308e7fff4ca-2f3be574b0amr101743041fa.8.1724164894866; Tue, 20 Aug 2024
 07:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820033148.29662-1-sunjunchao2870@gmail.com> <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
In-Reply-To: <CAHc6FU69hYhBS2rRyXUGAJSHpzNY+kNN9tZBcfWQbL_u5N-MvA@mail.gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 20 Aug 2024 22:41:22 +0800
Message-ID: <CAHB1NagXgRMj-Rhb=86L8kaXEe8H24=Of6nrUmhMVR2fxTqYkA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix double destroy_workqueue error
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=BA=8C 22:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Aug 20, 2024 at 5:32=E2=80=AFAM Julian Sun <sunjunchao2870@gmail.=
com> wrote:
> > When gfs2_fill_super() fails, destroy_workqueue()
> > is called within gfs2_gl_hash_clear(), and the
> > subsequent code path calls destroy_workqueue()
> > on the same work queue again.
> >
> > This issue can be fixed by setting the work
> > queue pointer to NULL after the first
> > destroy_workqueue() call and checking for
> > a NULL pointer before attempting to destroy
> > the work queue again.
> >
> > Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> > Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/gfs2/glock.c      | 1 +
> >  fs/gfs2/ops_fstype.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index 12a769077ea0..4775c2cb8ae1 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -2249,6 +2249,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
> >         gfs2_free_dead_glocks(sdp);
> >         glock_hash_walk(dump_glock_func, sdp);
> >         destroy_workqueue(sdp->sd_glock_wq);
> > +       sdp->sd_glock_wq =3D NULL;
>
> Here, sdp->sd_glock_wq is set to NULL,
>
> >  }
> >
> >  static const char *state2str(unsigned state)
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index ff1f3e3dc65c..c1a7ff713c84 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -1305,7 +1305,8 @@ static int gfs2_fill_super(struct super_block *sb=
, struct fs_context *fc)
> >         gfs2_delete_debugfs_file(sdp);
> >         gfs2_sys_fs_del(sdp);
> >  fail_delete_wq:
> > -       destroy_workqueue(sdp->sd_delete_wq);
> > +       if (sdp->sd_delete_wq)
> > +               destroy_workqueue(sdp->sd_delete_wq);
>
>
> > but here, we check if sdp->sd_delete_wq is NULL? That doesn't make sens=
e.
Oh... I see. Sorry for this stupid mistake. I will correct it and send
a patch v2.
>
> >  fail_glock_wq:
> >         destroy_workqueue(sdp->sd_glock_wq);
> >  fail_free:
> > --
> > 2.39.2
> >
>
> Thanks,
> Andreas
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>
