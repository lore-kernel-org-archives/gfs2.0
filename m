Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883014;
	b=3hsayoPP7ja8F3ITlWBDbKBWMxQkbRquUzE8aDUFyyS7Z6rtVDtTYro6dNQnS0/NoCcg
	 FQdqhOBIvFNXRZzLWIvXYoCA04QJq/nV/i3aX8unSSA+Fl/IZoC515T48qqz/DmeZwrkL
	 sTWOEtri3S2GNoR4uAvuamc76x0MKOEcjgDyNanUyGo82revt0FF+1vl2RqFPlfTRuNve
	 v28YJ0nhDcMeqV2Pt9EQVHCKXb48ncRt5SQiTJv5IpaK/ZLDrZJLoXs+XOqDGC71vfiO+
	 dk2u6JDcbwVtjFWRZiZcrDrpEIBkOSTkql3bZXq7Mj+wfxul3Z8m4VLGiaw/rrOIpNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883014;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding;
	bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
	b=y5iEs2cw5NXKcdTRUh67AWTRyMHm1kqH6kif9F/Xea/M9gIlSR/kNApyztottoEp7vgu
	 IjmyATj2NrrTbHGx/nurOJKzh2xw/Cam24vzmLtZOP9IX+Cr6hE/K0mGrtwyYzyH4hjpX
	 JDa4Wz8ULkWF6ptSo+HmeHsWlsvHJJLjE6Ll9PIeLEhuGy2OznxOuwLmY99s5x5dzps5f
	 fxzLKYKR6Q2TtydV8+lcFBLlcCPqQLnS0mFeXrtgaLfJdruyM5LgALjx0VSgeruI7HFV1
	 LCjHd1PJUsGEVSOyTykQLtDSHuKKMeWtX36c6dj+p2kHuSBvsNodbFMyIpbGzOBLikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="P/h/aMO4";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB3606A31C
	for <gfs2@lists.linux.dev>; Tue, 17 Nov 2026 02:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/h/aMO4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794883012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
	b=P/h/aMO4GpY/tOMsigSOoGa63/yrnXcmVHnBRlHcx52cUUbbZPcO3POhJdDJRdBMt/I4oT
	jm23e4veVR3/U5EAzOZR14b+mAvfcwRyuVvcHGL0GWW8WUAEd1ohhVYZJBIz3MOnXpgRZA
	0JV0eZg+YXwV1QGMviwAFnXkMBri/aE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-a-yKXjmZPFKUORF_seX0HQ-1; Mon, 16 Nov 2026 21:36:51 -0500
X-MC-Unique: a-yKXjmZPFKUORF_seX0HQ-1
X-Mimecast-MFC-AGG-ID: a-yKXjmZPFKUORF_seX0HQ_1794883011
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67db2bc1b82so2348134d50.2
        for <gfs2@lists.linux.dev>; Mon, 16 Nov 2026 18:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883011; x=1795487811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nc0Kx1j/LAZLLQGwSBqbBP8FB/6wPqlG0izEEFd5vzQ=;
        b=QeCIcg4nMBPyFZTwCLTvFoaxBL6CuQPsaj4hYUHm4PXKV0FnB32aMKTUe5oVWT8Qhl
         Rgf5WvEyq7hFHw/kCUjMB8/gTMbK0eNBHJWlM/rISVHXEehPXnKtcNCQXbwNp/kLm8qV
         H5QFTsowOeg3sA/d8WFS8ufbp5lhnnN4QP03eMNK6V1RuwYcBzp8Pz6t9raNebYvOEUS
         nUeJQwYAxkDNY0qQUEryVGb0Rt9+9DjaymMOn1zzp08jMMNC57ttD6Jz2YVwgPBsTeiz
         3pMYUG9pW2V5WY7CmHO7z0kIyZAd2N2LaqMo46DgWj/chmDhngO/6DpR9OZV96JgBFcN
         upDA==
X-Gm-Message-State: APuU4Z9KBXJW/pyLlOokxfkbk8mLgffU7rm8IJk6UdxL/jgw1Vi0p2AK
	RdzEzzN2Zil1A4aGWAG6S5tq0k8vmuquWdYU2OhNP3amf+sJC0dDx9X2Ovps/g0C0kEDT/Llsd2
	tM2tSvSOIMT2g01wGUwzsuETPmaqFe8VM/TLywcRIZ4mYWhX3sQzEb9lUUF3e1kW4rYNNNmDnei
	FqWV6rBOK9XlRDLBv1WPQYdzvVRFvm8Q==
X-Gm-Gg: AZFdTZeAbE1vdXyj5IljTWy8RDwcIIcr55j/DIED1R7qELn2lkDrpp8n8IHHW8eSato
	v9kVm8i62JpFasHXR4GELwjbZcpp47vhcrfpRB2hlK+8bfIjgQwxkXZBwPjRKOjNUKybZ0vpHzN
	kQ1re2EMhtCLgku+Zm7OP3heqklkfVBlT6NqtsDWl6hqI+0gxWL4YoLYEiHgi5QSB3+dikvj2tw
	NduQONQhKyM+tnnTvK6bmHAFarPu1lwA1KT0KHbMRLfkw==
X-Received: by 2002:a05:690e:1286:b0:67d:ba39:f922 with SMTP id 956f58d0204a3-67dba39fc87mr2249542d50.105.1794883011243;
        Mon, 16 Nov 2026 18:36:51 -0800 (PST)
X-Received: by 2002:a05:690e:1286:b0:67d:ba39:f922 with SMTP id
 956f58d0204a3-67dba39fc87mr2249529d50.105.1794883010751; Mon, 16 Nov 2026
 18:36:50 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116180002.44336-1-founder@logarcheon.com>
 <20261116220843.378480-1-agruenba@redhat.com> <20261116232409.46988-1-founder@logarcheon.com>
In-Reply-To: <20261116232409.46988-1-founder@logarcheon.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 17 Nov 2026 03:36:39 +0100
X-Gm-Features: AclHuK8jipT2sqTxWhLP9_-fF2K8gGmgIWV6DE8puWPi_tixSxFnVaitHavNBps
Message-ID: <CAHc6FU5=ELOJiaP6VWg7q5S+=jULvgrB4mF7diNSUpOg1aiZZg@mail.gmail.com>
Subject: Re: [PATCH v2] gfs2: Fix NULL pointer dereference in gfs2_seek_data/gfs2_seek_hole
To: William Chuang <founder@logarcheon.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gwLOyzJyNPjucLkcInJ2o4bkeeho6xbIx10g-tKkY5g_1794883011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:24=E2=80=AFAM William Chuang <founder@logarcheon=
.com> wrote:
> gfs2_seek_data() and gfs2_seek_hole() call gfs2_glock_nq_init(), and
> independent of the outcome, they call gfs2_glock_dq_uninit().  When the
> gfs2_glock_nq() call in gfs2_glock_nq_init() fails, gfs2_glock_nq_init()
> returns with an error code and gh.gh_gl is set NULL.  This causes a NULL
> pointer dereference in gfs2_glock_dq().
>
> Fix that by only calling gfs2_glock_dq_uninit() when
> gfs2_glock_nq_init() succeeds.
>
> Fixes: 3a27411cb4bc ("gfs2: Implement SEEK_HOLE / SEEK_DATA via iomap")
> Reported-by: syzbot+5a5f492ccae698fd7434@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D5a5f492ccae698fd7434
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: William Chuang <founder@logarcheon.com>
> ---
> v2: Adopt Andreas Gruenbacher's version of the fix -- skip
>     gfs2_glock_dq_uninit() via `goto out` when gfs2_glock_nq_init() fails=
,
>     rather than guarding the dequeue with gfs2_holder_initialized(); rewo=
rd
>     the commit message to match. v1 posted at
>     https://lore.kernel.org/r/20261116180002.44336-1-founder@logarcheon.c=
om
>
>  fs/gfs2/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 2c2dc459c037..d4678e4832b3 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2253,9 +2253,11 @@ loff_t gfs2_seek_data(struct file *file, loff_t of=
fset)
>
>         inode_lock_shared(inode);
>         ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
> -       if (!ret)
> -               ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
> +       if (ret)
> +               goto out;
> +       ret =3D iomap_seek_data(inode, offset, &gfs2_iomap_ops);
>         gfs2_glock_dq_uninit(&gh);
> +out:
>         inode_unlock_shared(inode);
>
>         if (ret < 0)
> @@ -2272,9 +2274,11 @@ loff_t gfs2_seek_hole(struct file *file, loff_t of=
fset)
>
>         inode_lock_shared(inode);
>         ret =3D gfs2_glock_nq_init(gl, LM_ST_SHARED, 0, &gh);
> -       if (!ret)
> -               ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
> +       if (ret)
> +               goto out;
> +       ret =3D iomap_seek_hole(inode, offset, &gfs2_iomap_ops);
>         gfs2_glock_dq_uninit(&gh);
> +out:
>         inode_unlock_shared(inode);
>
>         if (ret < 0)
> --
> 2.43.0
>

Applied.

Thanks,
Andreas

