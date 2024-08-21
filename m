Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736491B2ED0
	for <gfs2@lists.linux.dev>; Wed, 21 Aug 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262114; cv=none; b=FqqhnixSWU5SJYx7kGlwBJdvU23y5dpY4Ksm7jl7OTwbPyNZ7dcQInLp1hw7sSsuKIY1iRXxXrbAN4o26gh7Y5Y3hKy3F/xrK8FzZj3htuGeTnu07SzmViV/19R0sXCBqOww6JNce/sO+H+zFh1bJRrmU5lHztdlYhW0U+sFWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262114; c=relaxed/simple;
	bh=lJHx3OSbEEPVy0QsUtl2SMna9ucj4s6ThUgvmDM2zkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akgnIs7z78bFdf3sQKuKxtJqrnvMZzJ5ycyP2YuQGiw7WNtU4Ly9qVFgsn/tCVjpBolmK7kOCVJvQndaI7BLyv05l7wqtp3Qez2/sIminm9/zy2VBZljq5GiJPqjf9DZwKwlnGDw1Q3ILbhSo2T/8+Dj2RTEF5WdFR7sMoaQs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSBgIkJv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSBgIkJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724262111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cowNrCIRL1hn88DkS2gvPwjwTNe7k5RZOOLKS07j64=;
	b=VSBgIkJv0QCZO5dZEFDblEC8yMaTURgTJ1IRZNZ3RcJg9blxKaXRPrwwKoYGqEB+GtUmjY
	oog4GtB6L/IEb2Ys31+u+UdO4DqT7wO4SIA8YUQ9pA1SnOdPBI2f0bgecUPeF6IYmqIUvY
	mFHMJN17+HSgp14P8EPepfSVYymVVMY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-yKDA9EylMmSYnVzEPEiYAw-1; Wed, 21 Aug 2024 13:41:50 -0400
X-MC-Unique: yKDA9EylMmSYnVzEPEiYAw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-201fa0bc77aso46849645ad.0
        for <gfs2@lists.linux.dev>; Wed, 21 Aug 2024 10:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262109; x=1724866909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cowNrCIRL1hn88DkS2gvPwjwTNe7k5RZOOLKS07j64=;
        b=S2iZi0xs+twASxTCTzS+WOvPXV3q6Szovc5VTG011PQudNnfvsLNrwVEKje4bKtZSr
         skgbtTCFjEm3Sv1IlApxwcUUk4R1XbW5TOUUCwse1tXCIIRL+X/Cbil9hs9m/zygjOs+
         YWKT5IH98lWmonf8FDhvDD1SEcncv2TmWSf/Jm1E5zlntG8dZWH6uJCy6hbKLRJmYBPP
         +NQA/EncKUtCn2vU6TV2f4I7UKQ3+t9DV3ce3ugo+tP3ANmHValTIWJtTbZkY4blR69u
         gf4mxwLoVxOXEnTPIiHeWoy3M+j/B3mibsvJGB4+cXPsjQ12Ve4GzC6YYXcXr7iHkX0c
         qzNw==
X-Gm-Message-State: AOJu0Yzkv7evmTY01KrIvkOqgA3at9s3NHo6Q1D02SNaWdcKMjXSpBPE
	VebXHHdqp4WtCOQA1Jq80x9uQ3/Ym5SGlMwn9c7vKzjGJOpfvFC1PI4FOqFKX96+cFvL3Q1Lg4C
	cR7g2vKZAFGhxOKMVF3C8uuktpwVLUE2xeWInmLeRCun2rS5fxSlKq2cURw3SiElX/A8+y7cbhd
	4JPpS42XKSu/WrTOz8O7pANCTPltu4GgcLHQ==
X-Received: by 2002:a17:902:fa84:b0:202:1b1e:c1e6 with SMTP id d9443c01a7336-2036818cb26mr24827085ad.44.1724262108841;
        Wed, 21 Aug 2024 10:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJfvoGXcEcqhhmu6MdAXcpbF6Lin373qLe1xFzZcX/kE4L+aYZOQBB5ATuZn9OWnspJaAf6ujkHJPEy0dIipo=
X-Received: by 2002:a17:902:fa84:b0:202:1b1e:c1e6 with SMTP id
 d9443c01a7336-2036818cb26mr24826955ad.44.1724262108177; Wed, 21 Aug 2024
 10:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820150827.139326-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240820150827.139326-1-sunjunchao2870@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 21 Aug 2024 19:41:36 +0200
Message-ID: <CAHc6FU6O_WOy9y6T3Lji-deT1NNfLos3vKMVprb5jLPcyuk=zw@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: fix double destroy_workqueue error
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: gfs2@lists.linux.dev, 
	syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:09=E2=80=AFPM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
> When gfs2_fill_super() fails, destroy_workqueue()
> is called within gfs2_gl_hash_clear(), and the
> subsequent code path calls destroy_workqueue()
> on the same work queue again.
>
> This issue can be fixed by setting the work
> queue pointer to NULL after the first
> destroy_workqueue() call and checking for
> a NULL pointer before attempting to destroy
> the work queue again.

Applied now.

Thanks,
Andreas

> Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd34c2a269ed512c531b0
> Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/gfs2/glock.c      | 1 +
>  fs/gfs2/ops_fstype.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 32991cb22023..5838039d78e3 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -2273,6 +2273,7 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
>         gfs2_free_dead_glocks(sdp);
>         glock_hash_walk(dump_glock_func, sdp);
>         destroy_workqueue(sdp->sd_glock_wq);
> +       sdp->sd_glock_wq =3D NULL;
>  }
>
>  static const char *state2str(unsigned state)
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 0561edd6cc86..5c0e1b24d6ec 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1308,7 +1308,8 @@ static int gfs2_fill_super(struct super_block *sb, =
struct fs_context *fc)
>  fail_delete_wq:
>         destroy_workqueue(sdp->sd_delete_wq);
>  fail_glock_wq:
> -       destroy_workqueue(sdp->sd_glock_wq);
> +       if (sdp->sd_glock_wq)
> +               destroy_workqueue(sdp->sd_glock_wq);
>  fail_free:
>         free_sbd(sdp);
>         sb->s_fs_info =3D NULL;
> --
> 2.39.2
>

