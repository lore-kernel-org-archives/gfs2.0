Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515F15C8
	for <gfs2@lists.linux.dev>; Fri,  8 Mar 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915456; cv=none; b=UmBb+8gJZvZ1hCslz3ix12vQDaRZe5nttRKfVPh6y0RENwvK47sSgsRd7zF3OBhMAnL7t1sWda+QyHdokLXZlXtMo/1wHLSDx8CVlLP9H7voKZySzoF3nKTTkCo1o66croEhI7S3QSvY3+r3qxRo9twEJunroXetdURWkk2igWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915456; c=relaxed/simple;
	bh=KED6qbou+irwBRcxzVvDODZS2aWl14xZwZV9cA2F6mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=can4HHbnMnLbOhHk8/sjdsi4miTowKMp4iseReMFVv2mNZ3kUQ7isdEcPIzEMf9gWawJVhIWCNE+goyqqKqJjFVdCkp2RIhPW7R7XQO9YAgaKP/ZXKTprJ93MXpjXu5QpJh2gHjqTMZThtazTfctOXQ1IvEwd/o1Z7FnvNu2nWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhoDj3ZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhoDj3ZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709915454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0rhFOzxwPIQMYdfBLNIsMH+bdHyY6gP6owgi++KGkg=;
	b=KhoDj3ZGWNfMhg5BPQv53fvPkHD1WQgUMxlAuJOAfbr/0WRQRLvTVFEieUbBl2SXV4JibH
	N91BXRm27+d5v9PuGiDSKx9zmtUGADZvHczbvuob358wYWUDvCWF8Nm+1GTDcWGz/YeLDe
	R9F/mzocNkcaJHcB5rKO/k4FdwTnwyU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ffg_MD-XMG6o99cGrHMXJA-1; Fri, 08 Mar 2024 11:30:52 -0500
X-MC-Unique: ffg_MD-XMG6o99cGrHMXJA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d32d9a312eso16733041fa.2
        for <gfs2@lists.linux.dev>; Fri, 08 Mar 2024 08:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915450; x=1710520250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0rhFOzxwPIQMYdfBLNIsMH+bdHyY6gP6owgi++KGkg=;
        b=hF+dbcdNWQ8J49rAgnlRGTSeCaFGxfE02hLUqN2nLa87smPxsYreGQW9GZ8Z/p8S7u
         T5K+QbOoOkWzGhBzIB0py49M3OyoiBHCw0WWmhHzmJlhtQw1LRJufuBA0/lwDjFI0sVh
         cPzIp/ex9gtsQnKvBQyR6Ss97KBDixn3tBdjqrLUiuLN5juoHl8ZWjB1GPYKndI4rtkA
         fK5iw+B4RL60gA+lWCTPalCVKQ4MM4LCs9daeL59bKH7EPy304oLN3LiwYy1Vz0hbwo4
         OjIOARHxIVS8FdHfguKalxFDPjZ9nUugf8wUVCMYzijTqU6ek/g7+4lr7EoDnD54ia3F
         AtSQ==
X-Gm-Message-State: AOJu0YwC78Aje1KC+uPqcNNtisMK/S9glSRnjBNecQAeZIbhjJRexxDY
	c6VVRue2DqE7EDxNXyKIyO+9EHCPnZ590cPjrdzP4QrICAzQZgCJYYQdCWjvpelR0O7IAcVRYxx
	L7dTYXiekbm8JCe5pn6apXQnk5OH8/t+LjmbTw+iNV4xdFneV5+sf7ZmJhXn9oxDT+Ho+eA4bQd
	fqWCQ1PZUWJrLZT9u8ePIZXyClyHCUS1suIfGm
X-Received: by 2002:a2e:b816:0:b0:2d2:cb43:bc86 with SMTP id u22-20020a2eb816000000b002d2cb43bc86mr3399228ljo.45.1709915450715;
        Fri, 08 Mar 2024 08:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8vgAYucP/J8O4YzDNayADo6P6rIWtUW4MpmWv5DSEWxKUoaP9m2zgx3B6KK0csnNbZ43GjcLK+scxld4kWBk=
X-Received: by 2002:a2e:b816:0:b0:2d2:cb43:bc86 with SMTP id
 u22-20020a2eb816000000b002d2cb43bc86mr3399213ljo.45.1709915450406; Fri, 08
 Mar 2024 08:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308161818.2388451-1-aahringo@redhat.com> <20240308161818.2388451-7-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-7-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 8 Mar 2024 11:30:39 -0500
Message-ID: <CAK-6q+hYA-6MNcvrVYzZeJfy0xT_jMo5HaNU1h10i=P0pm9utQ@mail.gmail.com>
Subject: Re: [RFC v6.8-rc6 6/7] dlm: fix race between final callback and remove
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 8, 2024 at 11:18=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
...
> -}
> -
>  /* Figure out if this lock is at the end of its life and no longer
>     available for the application to use.  The lkb still exists until
>     the final ast is read.  A lock becomes EOL in three situations:
> @@ -198,6 +181,7 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t f=
lags, int mode,
>         struct dlm_ls *ls;
>         struct dlm_user_args *ua;
>         struct dlm_user_proc *proc;
> +       struct dlm_callback *cb;
>         int rv;
>
>         if (test_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags) ||
> @@ -229,11 +213,18 @@ void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t=
 flags, int mode,
>
>         spin_lock(&proc->asts_spin);
>
> -       rv =3D dlm_enqueue_lkb_callback(lkb, flags, mode, status, sbflags=
);
> +       rv =3D dlm_queue_lkb_callback(lkb, flags, mode, status, sbflags, =
&cb);
>         switch (rv) {
>         case DLM_ENQUEUE_CALLBACK_NEED_SCHED:
> -               kref_get(&lkb->lkb_ref);
> -               list_add_tail(&lkb->lkb_cb_list, &proc->asts);
> +               cb->ua =3D *ua;
> +               cb->lkb_lksb =3D &cb->ua.lksb;
> +               if (cb->copy_lvb) {
> +                       memcpy(&cb->lvbptr, lkb->lkb_lksb->sb_lvbptr,
> +                              DLM_USER_LVB_LEN);

That should be:

memcpy(cb->lvbptr, ua->lksb.sb_lvbptr, DLM_USER_LVB_LEN);

as for user space callbacks the lvbptr information is not in
lkb->lkb_lksb->sb_lvbptr it's in lkb->lkb_ua->...

I have it on my list to "more" merge the kernel and user space
handling to have it at one place only...

- Alex

