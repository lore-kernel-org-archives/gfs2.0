Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32B44C645
	for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586357; cv=none; b=dhTXMRQDHnU5m8+pxali6CPHyPqToNaTKZeIsbyr7/xoG/11frTNg9Qza9T7h4J3AMEzcjTWK23zXiWoRKBt8LDWUurlxzj2K39YF7byvJ3Ts8id/YL2gGsAM/9hCmWLsMLy6x1gZmGF8LL6JNlC/7+Ivm17bXJeulr130cEIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586357; c=relaxed/simple;
	bh=UInqlXNgzhrb7ad8QRZi8Gy1n6MNT5fZ8Q/MycMYy/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFaN1eArZrS111+YQ4iFqU2dxs2nsEWiv2N63YE22RDaJ12Z/JPVu56F/lsP+PUWLrtDnv3QMvaLKJV9MVGcrNmwK0n+9+ihGpv6A3tr79uxXtdOkHwaQlCsIPntjnCKYagUiirLaubt9CeLNVO/jbKmbEMXcKcSkMHDszScsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuhDpwdx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuhDpwdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787586352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJThwG3P8wPC5qmnmtgUc4+AUWw/9ToUlOyTB7RPu8k=;
	b=AuhDpwdxwiRGeb6gJof+Gz4zjpEO8rLciD9PuC07CjfZsaZtcT/AoVxrWtDEDQRPaQ6bCl
	BMbeEz9YVVNsX3QeUC9ROyfPsMJfNCGOjy4QeyL/sNss7Whx44LBSftv8XlevHUFQf5Sgd
	3b1sQyv9qaaWiqzAfHlf9cfadpc4wE8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-XYp1au_pMU2NCjlg1xVThg-1; Mon, 24 Aug 2026 11:45:51 -0400
X-MC-Unique: XYp1au_pMU2NCjlg1xVThg-1
X-Mimecast-MFC-AGG-ID: XYp1au_pMU2NCjlg1xVThg_1787586351
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836caf085e0so148573347b3.1
        for <gfs2@lists.linux.dev>; Mon, 24 Aug 2026 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586351; x=1788191151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJThwG3P8wPC5qmnmtgUc4+AUWw/9ToUlOyTB7RPu8k=;
        b=pwmytOIX9iDdt+RQlaq0Awf9xD23EvOG3bPuxV1lT+bdftjnr/5xVtoFTV2pE493/R
         FGpK05xs4Kg0s+Sw1qLujPr6/NWa8aTUaJwPh6I9XOSdRsa3Eq6smBK3XrOldKD0B1OP
         QEYcPYTpP/6pImivVpQPs2p6ouLKs7IPh/SwwuM+U6hp7LS3McWTkNMYpHDu5UikY0FI
         MHXXQ2rdbQJPYCyeqMH5OWkXmPnBxVtVnU8J2woHOSKXl1OuDE2Ss+UOmdiBvUmeXwcS
         cO8vUZXrO0BZU2e30BCFa46momr+FLTTRGLhg3dm+SfUpsq2CTBD/xIESjOc3Fv5EnUj
         7r+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqZmz8TgT9sIbj4hxyoNuUYIakInqnfC87XYAQqqL52KFtz1yKN45enEf1uCZK8anDl3A/Y@lists.linux.dev
X-Gm-Message-State: AFuF++nhFkdUaTgEm8t1j0imqop69RIsAbRd/cIfIKmhppIGQkambDWg
	ys5eIE9cBUBgKJJZKUT5jpa4AOdGGD3tTAj0zoUXaLC4s2iCSkDeYW8sGdV1sa8x5NH3C5VvqvQ
	7RI5lhdQxpFhX8axo+VmA6JoTZVTBFli/WkQKCXZFs5DOOWemyAp5FYch7idd+DXZaGqn1oIB+V
	VJQ8jfFFlaWhJkIphXCqxQLzGH0YosVQ==
X-Gm-Gg: AR+sD102ktJHZL2xtcbmZSMQAgOxHcxDVqinBPiM2a0Qp7To9vfe//HcbY07dVCJVbO
	ShQJwGEFgEh4ocCifOs7NgaXgZ4a1btlUKnAhDe1jkhVb8f/gxkYkAQxfWGnO4S7InB4SzAe/Yv
	K5yeuLzcidcN3kpXInwyDFSjm+MsOfbxrsIgd1LSP7PTXAGWYH5hAEtmtFS3RgA0JXyHyRahe1I
	uIN+o142jso8rm5jvR38usuI+eXWkwZkvDH6yikT3Qe
X-Received: by 2002:a53:afce:0:b0:66b:3c3c:c89e with SMTP id 956f58d0204a3-66ce4b4ae1dmr8668555d50.44.1787586350927;
        Mon, 24 Aug 2026 08:45:50 -0700 (PDT)
X-Received: by 2002:a53:afce:0:b0:66b:3c3c:c89e with SMTP id
 956f58d0204a3-66ce4b4ae1dmr8668536d50.44.1787586350347; Mon, 24 Aug 2026
 08:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617090143.735219-1-zenghongling@kylinos.cn>
In-Reply-To: <20260617090143.735219-1-zenghongling@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 24 Aug 2026 17:45:39 +0200
X-Gm-Features: AcwNN1VnN-ubuZro-Q0sxvU9as55cDmM0fFbTOUQLBDEK-akDtZ-rHK8G7fzWEs
Message-ID: <CAHc6FU6yfthCSOnpX38mWmVeRo5gOh0es2AwtpYM9ipV+kk74w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: swhiteho@redhat.com, gregkh@linuxfoundation.org, rpeterso@redhat.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, zhongling0719@126.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qp3yKx_5A1Rbue3RrpdAuGR0Ho3SG0EvmISoKTMUh8U_1787586351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:02=E2=80=AFAM Hongling Zeng <zenghongling@kylino=
s.cn> wrote:
> The function calls brelse(bh) but then continues to access
> the buffer head through bh->b_private, clear_buffer_dirty(),
> and clear_buffer_uptodate().
>
> After brelse() decreases the reference count, the buffer head
> may be freed, making the subsequent accesses use-after-free.
>
> Fix by moving the brelse(bh) call to the end of the function,
> after all accesses to bh have been completed.
>
> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")

That commit by Bob looks suspicious: bh->b_private data is usually
freed by the ->release_folio address space operation, so there should
be no need for freeing bufdata objects here. (That has little to do
with your commit, of course.)

> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/gfs2/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 78bba8cc10b8..a92c84146de9 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *b=
h, int meta)
>                         set_bit(TR_TOUCHED, &tr->tr_flags);
>                 }
>                 was_pinned =3D 1;
> -               brelse(bh);
>         }
>         if (bd) {
>                 if (bd->bd_tr) {
> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *b=
h, int meta)
>         }
>         clear_buffer_dirty(bh);
>         clear_buffer_uptodate(bh);
> +       if (was_pinned)
> +               brelse(bh);
>  }
>
>  /**
> --
> 2.25.1
>

