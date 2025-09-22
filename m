Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22614308F2D
	for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540899; cv=none; b=UyQBiXSCb8UwrVeDWjvmAStmn8PVJZHMwz0Y+VtwzXWhIFtt7E+oJeLoFtttkaNcQ4DHE2jq/BX/bblQc0MmsZW2pz9FnM46o7+oexET6HmefervwwBt4TfS97qkTG5sfCKKQVKvmFsYa0629du1CemORYm1hT0cZsiCD8JTxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540899; c=relaxed/simple;
	bh=Npwp37fasUaztNGjwbjQ24nWh04CyauLI9SVRQGWYVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nwo7FKfVWTUwO77F+24xiu+TNc5qE6IeUFkoGYdzWvAMlkOyac/FR68ZUDezQ9y+4O5+56E5P1Pvgf7BcL2z09zoo1Q0r3veHdQfZtowD7MBjnisvUw9KnmJOk/n4SEqOXd/Zu0yRkk+ILVcs06F3RPv2vA0ZtCxlDUMs4W8CLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1ASn9nH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1ASn9nH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758540895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBL6ran7eeZrT38sfsNjW8tntjx1L4Y7ebN1yvWq/ak=;
	b=c1ASn9nHobe0N+y8Id6gfcjNTZFd+GM8RMeyIGZDZTf2JKzIvV+JSao/4dnzXxA9T1Ltj1
	q9SdxyomWNY6y/hj8N+0Q63OSfnGPf6R13ctt2gd12zZXrhRewgXna42A3pZ8vp+5U+0rA
	2P6AyUUdLBkmEG/zOSeXptZomQ+IXiI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-cFciBkT_MjGwEfTIraKaEQ-1; Mon, 22 Sep 2025 07:34:48 -0400
X-MC-Unique: cFciBkT_MjGwEfTIraKaEQ-1
X-Mimecast-MFC-AGG-ID: cFciBkT_MjGwEfTIraKaEQ_1758540888
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ec2211659so4469518a91.0
        for <gfs2@lists.linux.dev>; Mon, 22 Sep 2025 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540888; x=1759145688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBL6ran7eeZrT38sfsNjW8tntjx1L4Y7ebN1yvWq/ak=;
        b=jgJx+vqHigwbu43B1z0iPTHdFDMp61eQ7BqhHB89lQJte7IocEthojgaX8U1mfqyh2
         Ni3D5RAkTNX9Cv0kAvWOC4+YwcnIIolzbTaKVICcebClWaY8AOd+3FIswvVAkHHx6uAP
         ML6AwETHJuFB4A6xnU2hB5Ewes7N2W4xjTf0OzKgPNkyY8DQMBgmWMowKLtXBfcPJOD9
         3WBBQ9S+ljR/6LDWvhPS84hkywSQqsYGCDk1Ug/pNRSQtDZLp8dqcm6wOA0Bmj9tL9lf
         pl49ljTpaHqE77oyXUv99YWwwN0/1dNBq0P/JPkoxtuWVc7BcqP4Sw0vhU0NPPRNKuYH
         /Mdg==
X-Gm-Message-State: AOJu0YxzkNzlLZ8MglYno0LCs4rqWr7bkMPkpszKjKwsDh0joXOTQyYN
	cqpYy+MRdd/6Fx6K6nT36dLEd9TqUDy01sS3lNJbAyqj3KvEVbfFcqpV7b1UZYlCOy8VDvr/Wrt
	aKbE1fB/+MM/IAkAOqytZJsLrPZ6jRqGFGuh1+UoK03Hoxk6B2y2u1xIy3E1S9bGQ4drvh8MgCy
	LwT1yGho//oNFC0zM5MBgLT9gX8XqRSg==
X-Gm-Gg: ASbGncviAelYAeR+zWgv+NWLKyvrF5gqbU06Xv8iFySxuTbenBDAhXbx75kqitWvW1v
	yDcbJDYDk35SWTbKuGe82R6qJnr0ow4/rihVpJKqDgaZipALU5YTGhv7RGV9jOVuSN1fcmQKcNT
	AfiTEnvEMIoebBNISZuok=
X-Received: by 2002:a17:902:ea05:b0:269:874c:4e48 with SMTP id d9443c01a7336-269ba550cd2mr171325255ad.47.1758540887716;
        Mon, 22 Sep 2025 04:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwLwdzoDbuGVYQuEXIHCwQRTwpdPRrzzjp4kgxXc6oHg0FWMGDElJOvb0KAxMjWimeR5uUisUdrOaN5DAr/3I=
X-Received: by 2002:a17:902:ea05:b0:269:874c:4e48 with SMTP id
 d9443c01a7336-269ba550cd2mr171324975ad.47.1758540887355; Mon, 22 Sep 2025
 04:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 22 Sep 2025 13:34:36 +0200
X-Gm-Features: AS18NWACBZeRywvdMekJd6TCUmlssvkKRWZotY-3FIzanJ_u6GG0-GRTwtWtIGg
Message-ID: <CAHc6FU4CVLe6ZxPR1Q3dc=5i1ARrNAjnB_NEK5_Y_Pecmk_4bQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: add bounds check for rd_length in compute_bitstructs()
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pd65mPY7g92bcNLhhme82VZYO36ky96MS1L14zgx7Pc_1758540888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kriish,

On Thu, Sep 18, 2025 at 10:49=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> compute_bitstructs() allocates an array of gfs2_bitmap structures
> using kcalloc(). The function only checked for length =3D=3D 0 but did no=
t
> guard against excessively large length values.
>
> If rd_length is too large, the multiplication inside
> kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS) can exceed
> KMALLOC_MAX_SIZE. This leads to the allocator calculating an order
> greater than MAX_ORDER when calling get_order(), which is invalid.
> As a result, __alloc_pages() warns about the bad request.
>
> This patch adds an explicit check that rd_length is not only non-zero
> but also within the maximum safe limit for kmalloc_array():
>     length <=3D KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap)
>
> This ensures that get_order() is only ever called with a valid size,
> resulting in an allocation order within MAX_ORDER
>
> Fixes: b9158815de52 ("Merge tag 'char-misc-6.9-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/gregkh/char-misc")
> Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7567dc5c8aa8f68bde74
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  fs/gfs2/rgrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 26d6c1eea559..a879e8030568 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -760,7 +760,7 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
>         u32 bytes_left, bytes;
>         int x;
>
> -       if (!length)
> +       if (!length || length > KMALLOC_MAX_SIZE / sizeof(struct gfs2_bit=
map))
>                 return -EINVAL;
>
>         rgd->rd_bits =3D kcalloc(length, sizeof(struct gfs2_bitmap), GFP_=
NOFS);
> --
> 2.34.1
>

this patch looks correct at a certain level of abstraction, but a
better approach would be to sanity check the resource group fields in
read_rindex_entry(). Andy and I are trying to work out a patch that
does that.

Thanks,
Andreas

