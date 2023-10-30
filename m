Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733B8C0D
	for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb0m0yyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698705520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVen+98WnwQurJDGWUrJb3G/4jC7KQVwkhzvb2b+SJw=;
	b=Lb0m0yyDTalZ/tdBSJY+96ludXfcy9no2TBm5Sh4NvG4hfcZhaP1E7p0acBaQ89iTeDUv6
	W4HolRXokKOrxi6D1g8O+gEvMYyDJcYx9xp2l29/b1BA/CFo57HfAgKW4L6CMHO8kz4rVu
	peoYTjfoNwdmKbPvn/Nnr/n/0YqDUDc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-IglihXaUMY2Xy_gWrs4wMA-1; Mon, 30 Oct 2023 18:38:37 -0400
X-MC-Unique: IglihXaUMY2Xy_gWrs4wMA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc5ac304e8so8230665ad.1
        for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 15:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698705516; x=1699310316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVen+98WnwQurJDGWUrJb3G/4jC7KQVwkhzvb2b+SJw=;
        b=vVPhhXZxx+9CsN4cl4Tg7xmTIInWD2srfxz/4waQVuJkgkSWBnklPLv/4fOmwENjWa
         NYXsWSMn1UjwlUDsi4V9kBIaIIyQkVx3JNueW9xy0Bw8rbaKeQBfp0npYoE8anZuxVX4
         CerHZ2MV560xjyWTeF4zbnfx1BwSebIE7WkmK9fLSaKSp/nVU9dpgWJASI/JKgWiae9R
         dqWUo89v+WgKKb64SWj0GC//G7Z8dHFFoAh0EXdavB1XFa7bUVwPDnkxK37PXfTMFmZg
         mmmnoaYA03Jj+W1pm8uUA6BKtO6Vuy5kAf0wY+lUbdQXfByQqpYb/7ZHbow7D2J6iy4/
         P47g==
X-Gm-Message-State: AOJu0YzU5bwBErfozSFqdhs3UwQXWYe6redGLjnJvg1MnCHDlZhK3by5
	Smg+SuXldZRZ7W4Qaj9VmlJ+6TbsvgQCHQ1q9c2IisJHV/3t3cPRKgI9VwEVt6cQbD2dP2XT93j
	br8WTliOrgvGb6hXhFPn8L9Fg9a7Djw==
X-Received: by 2002:a17:903:2448:b0:1c9:b2c1:13a3 with SMTP id l8-20020a170903244800b001c9b2c113a3mr9944353pls.49.1698705516020;
        Mon, 30 Oct 2023 15:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrq6wv4fAKDM89bR7AcFO6+rXEiZBdcum9FGjplZFEeTMyDffvE1uHbFQRJVOR54meCmmTMypGBZ3ZfVNBW9k=
X-Received: by 2002:a17:903:2448:b0:1c9:b2c1:13a3 with SMTP id
 l8-20020a170903244800b001c9b2c113a3mr9944338pls.49.1698705515709; Mon, 30 Oct
 2023 15:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <VI1P193MB0752B3C3E2DF69C56BF5D6D199A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752B3C3E2DF69C56BF5D6D199A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 30 Oct 2023 23:38:24 +0100
Message-ID: <CAHc6FU41DktH6+Hxsv3kYSiXenjoLJ58P6+mO9Yjhex5M0=aVA@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
To: Juntong Deng <juntong.deng@outlook.com>
Cc: rpeterso@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Juntong,

On Sun, Oct 29, 2023 at 10:11=E2=80=AFPM Juntong Deng <juntong.deng@outlook=
.com> wrote:
> In gfs2_put_super(), whether withdrawn or not, the quota should
> be cleaned up by gfs2_quota_cleanup() and wait for all quota to
> be deallocated.
>
> Otherwise struct gfs2_sbd has been freed before gfs2_qd_dealloc
> (rcu callback) is completed, resulting in use-after-free.
>
> Also, gfs2_destroy_threads() and gfs2_quota_cleanup() have
> already been called in gfs2_make_fs_ro(), so there is no need to
> call them again subsequently, whether withdrawn or not.
>
> Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D29c47e9e51895928698c
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  fs/gfs2/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a4b3655c5361..d21c04a22d73 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -602,13 +602,15 @@ static void gfs2_put_super(struct super_block *sb)
>         }
>         spin_unlock(&sdp->sd_jindex_spin);
>
> -       if (!sb_rdonly(sb)) {
> +       if (!sb_rdonly(sb))
>                 gfs2_make_fs_ro(sdp);
> -       }
> -       if (gfs2_withdrawn(sdp)) {
> -               gfs2_destroy_threads(sdp);
> +       else {
> +               if (gfs2_withdrawn(sdp))
> +                       gfs2_destroy_threads(sdp);
> +
>                 gfs2_quota_cleanup(sdp);
>         }
> +
>         WARN_ON(gfs2_withdrawing(sdp));
>
>         /*  At this point, we're through modifying the disk  */
> --
> 2.39.2

thanks for this fix, I've merged it.

Andreas

