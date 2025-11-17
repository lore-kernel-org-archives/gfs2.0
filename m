Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C248F62
	for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381560; cv=none; b=bhCkldmR77vIiE5ObYSxan6FO/MusmxxbVQxkwv69VRs6cXMm9pkUtVIoSXj7a/lwnRV8l//CS+ZgFNFh2AmPfwwkapj5x1Vrqrn667ryPg7hp7FZD6t5xaFZtrappxjzpwcK4qPmJddhuazDDXTRsCM8c0mhhRw1XeuZt8u+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381560; c=relaxed/simple;
	bh=saAYCu4eiU3Jge8JsPWNw9nzwFKwGWLSX4GU4zf7bB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XspUGg9LnIkUICMzNxb4VA7IFuL+w8zEWLKjJdSweODND2G8FmKj4nBtuVzKdGqBUdQXHSZv96pYHUSdnEd7cItloV92ywY98voFlaf+NazwTAYY0RwaX1ZwR6bdemjFMF68PgNvtDtJZnUSOPMOr7mSPGVGTPnR78jtHpY+n2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYqMrEhJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYqMrEhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763381557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPhmmnzzo0IAvfCDhtDu9/1Y5TnmBsP9OGtY1P52Igc=;
	b=dYqMrEhJdQJHFNWEX1Z7Y4Qae8Rf4FsTfM3LPffrZkExP8fVP1NFHD7M/Cd5ZkHz9J15kv
	/uBmBuxOnb0/ffd/Z7Ggvp+ZIv2beKa0yzZ5FHCqszuoPt74npwO13a518JRL7rY18kHH4
	M/TeP4k1ISugoZYF0FuysaMQPGWcg6E=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-0ZLXVEHXNPqQGSwuNzTfVQ-1; Mon, 17 Nov 2025 07:12:35 -0500
X-MC-Unique: 0ZLXVEHXNPqQGSwuNzTfVQ-1
X-Mimecast-MFC-AGG-ID: 0ZLXVEHXNPqQGSwuNzTfVQ_1763381555
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787e19a09c3so68570367b3.1
        for <gfs2@lists.linux.dev>; Mon, 17 Nov 2025 04:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381555; x=1763986355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPhmmnzzo0IAvfCDhtDu9/1Y5TnmBsP9OGtY1P52Igc=;
        b=TzdfyvwdYYSoDYz9GslWTwByHJIP9ggkIF0k3eIkummHDe54FyHuna+zHrrt4BAxz0
         vOwHy4Wizi6ojbPztc9gs3lBJDTRW1jLxushHOj7ZF+L3kHOMnxp7iMDXDy+pFclBq85
         D8/jpCsmPfRFfxjmbHTE9NpscJ7GZNfhlvjZMaMZ+6ZPgisZU0pDgxL6NjiAr+7fcB5z
         y+Ptih0R/5aYfGzd0DryabY1cTAGB8mlXWAUbA4dIWu0FGtMJRmj/cRVB75A0vyFmMpq
         3sQ4q/qpKpY+5+57OtYB++sVJsGKfCTA4KnrYe0TUuEHb8l1QnkB4JXgtG3J4QAEjbuq
         ixyA==
X-Gm-Message-State: AOJu0Yyicu5B4MzH7nvPzuiN7HLOHV704wgdSMJ1cfx5fD4eWSlMvJgI
	EFYOPmXayHZxyaUYUl9+NB1ip9IcjMWFPoMNuMgZZsubQ9GfK5jV4V9X+8U1Zx3kwo+jzhmYhYu
	jDKkIBsCNcfHGiCdQN6kvGhgBfZzH+2Kl4vZUU61Elk5YIkHIwA5uLAEn8eN2xqSqNInsiJ1eAm
	ThL+bj6t+nQNUTlRpsHKIN2vVfZ1Gup9d0x3j/PA==
X-Gm-Gg: ASbGncsYZATSkx/hvXYVG3PL67ssk5VV8C2ljlDwvY07iS1KU2fKSZxKZ5oQKN2eWIU
	Std8qiVlLI0de/H5sXRYkHOpVX9K4PFJGrBfpKJcUwWYUYTd8Y2lyLkcDbtoRuKhSvDoxRAyTZO
	Jz9emACCSc3YMHLzMUVv0tH34bu0A8FxGQdE7qDv6vlU2uNxySjzDctw==
X-Received: by 2002:a05:690c:90:b0:787:badd:50 with SMTP id 00721157ae682-788206bfc02mr138851777b3.27.1763381554975;
        Mon, 17 Nov 2025 04:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4r0M5lif5S7+S8iLzezdRcbWePdKT38v4RQ0QvfaV3Jzgw7TgT0opqP1qftfnEimGnOtljJJWiY+Gx6+VeX0=
X-Received: by 2002:a05:690c:90:b0:787:badd:50 with SMTP id
 00721157ae682-788206bfc02mr138851567b3.27.1763381554593; Mon, 17 Nov 2025
 04:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251117090603.13658-1-a.velichayshiy@ispras.ru>
In-Reply-To: <20251117090603.13658-1-a.velichayshiy@ispras.ru>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 17 Nov 2025 13:12:23 +0100
X-Gm-Features: AWmQ_bkjDwJ9z5c1GJ3sctEcdVmcfPdIR8JIhJfF2g5XjHKcFGcbuJc6lk02HJU
Message-ID: <CAHc6FU7p1NOfX_=aNEJsMSWCMHfbojbg5LGMUarOyqcdNq-Q2Q@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: fix freeze error handling
To: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o4wMRjqG4TqK0MoY2fO2LAt966lzLQdx2wPq-r9rEjw_1763381555
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:06=E2=80=AFAM Alexey Velichayshiy
<a.velichayshiy@ispras.ru> wrote:
> After commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"),
> the freeze error handling is broken because gfs2_do_thaw()
> overwrites the 'error' variable, causing incorrect processing
> of the original freeze error.
>
> Fix this by calling gfs2_do_thaw() when gfs2_lock_fs_check_clean()
> fails but ignoring its return value to preserve the original
> freeze error for proper reporting.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
> ---
>  fs/gfs2/super.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 644b2d1e7276..54c6f2098f01 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -749,9 +749,7 @@ static int gfs2_freeze_super(struct super_block *sb, =
enum freeze_holder who,
>                         break;
>                 }
>
> -               error =3D gfs2_do_thaw(sdp, who, freeze_owner);
> -               if (error)
> -                       goto out;
> +               (void)gfs2_do_thaw(sdp, who, freeze_owner);
>
>                 if (error =3D=3D -EBUSY)
>                         fs_err(sdp, "waiting for recovery before freeze\n=
");
> --
> 2.43.0
>

Applied to for-next, thank you.

Andreas

