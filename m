Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819224BCAA9
	for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185407; cv=none; b=MmezSjiHqkMC4qIE3UgoWmocY7whHw0Y2Nxtz7ZX0tV5ES/JHzgXMTViey6iXa5HSIOFWCRzflnn+U460Iru2Vf+KjNEDViXBzy0Lcw0B/7SZ/BOvk9dWaK3ZQtZLeU6uBf4GL6serV09TMlY3Pv7ujSF+yBwBwezB6T346aTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185407; c=relaxed/simple;
	bh=2OTa5vFHZiOCswlLATKSWXrmSzZ3LfR3p7eYLycqjCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUsOEhfc85jERrG+sQl/sH4t+Xq5y08OBdMN2jORVUmxqwGNPVGU+HP4t/EsbKWINyEiAPvhVQ1vGxygJCiRdzpSuaOohcoBGpci42TQd/9NTiWymVpuOuCke7BlwkLrIppeVV81qO/W7oTOXJvHC2UkYxn3XJUN1qUKbQAZEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7KxFtNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7KxFtNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788185405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RD6fAg9Gc9vKAefpCTRM0Xuo2vXeMUEPiIg8uFFGyM=;
	b=Z7KxFtNswv3Cl0vUjH43hY3NaDhLSD9hcOnwY8L6UqMxm/jUoAPSpt0VoXs1ntLiXZdw47
	s41DPUOc9o5ZDk3Vc4hbXqYx9xtpNx1v7oOXtS1CXl+5yrOoY0audthIQdAthmV5i2j5cg
	AtJFVsiTavejP9vpqb7fPPfG230LzSY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-MzdNxjKTNmSWPHOuS93Ucw-1; Mon, 31 Aug 2026 10:10:03 -0400
X-MC-Unique: MzdNxjKTNmSWPHOuS93Ucw-1
X-Mimecast-MFC-AGG-ID: MzdNxjKTNmSWPHOuS93Ucw_1788185403
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-836caf085e0so70479297b3.1
        for <gfs2@lists.linux.dev>; Mon, 31 Aug 2026 07:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788185403; x=1788790203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RD6fAg9Gc9vKAefpCTRM0Xuo2vXeMUEPiIg8uFFGyM=;
        b=J8Vz8BPc3SqCP7OMRCuHQTidu7kfi8a0JDHsb4DgSGSvQ0KoRIQoBE3AEGIwlKyqov
         R/ceVk5zRqQtauKbd83jnWuAmF5dlWVq20MIpUhi6fW3dWxEnMjFxqkwqBnpSIz5I8iB
         GhRy4eb/Y6R4ONN60ZFpJPY4PgV2UL+G/zkLNAa1R4hQ8Cgxhqr0zur814tXeyOh+hA7
         rK5aOmMeYGpDdYMDrW1tSPYZX+fh0uFO7evQdpGrmwU5MEJqt2DIvYHFADBY/fwZVGOs
         0zgCH4G9OYj6yK7wjjWWtiJGkAaqwpzKk4AeWqwOjW9uTlMlaBAVPjV6XDlSycPhLQuy
         rklg==
X-Gm-Message-State: AFuF++k1WxcHpm4G2KFNT1RpD3MQvK3kN1b6sgBUpAYnfrN+o1V7rdD1
	4U2O7/7ZaavuCqVjBrcZNvqrX7Kbmp8dovyWUVAOb6EXfWozQrfFVK2t/GIjQlBuylvQQfqKIFO
	5pp28PNAJ4JE33Kv0v+zSoa14+2ElVISIF2Y8kO9Zd6S/UbZl9Vd3O6ZPZnWzgvHuxocAqbW6ZC
	zcgNLXiLaLNUN6N9RA42a0inR1wAzNRg==
X-Gm-Gg: AYBFou24YnIx6lRSH2T08mgfLB7EdUQkYv4Hlnpa34IILAtI3q4nGaC+4a28tL9m2oo
	X7zJBkAvLRCJutbIq8Py86hKCUYG6xeVbP9s8gBuyxn+kpFAnclL3nKPshU1fgPUWOsq5mlZEfR
	YGk2X9tIyPfxTBwnbGz4rdQK5XuimnqAambebO8bMrkPLqY6SkgH3c/WxgTq8/W2LIYxVUHy/TL
	gzQVffE2lWG6LOWMZ0dcJPW8SCU/02UuirqKhwpfuQQ
X-Received: by 2002:a05:690e:244a:b0:66f:8255:9f4b with SMTP id 956f58d0204a3-66f8745a1a0mr286928d50.8.1788185402989;
        Mon, 31 Aug 2026 07:10:02 -0700 (PDT)
X-Received: by 2002:a05:690e:244a:b0:66f:8255:9f4b with SMTP id
 956f58d0204a3-66f8745a1a0mr286906d50.8.1788185402359; Mon, 31 Aug 2026
 07:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260505223319.5661-1-shofiqtest@gmail.com>
In-Reply-To: <20260505223319.5661-1-shofiqtest@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 31 Aug 2026 16:09:51 +0200
X-Gm-Features: AcwNN1V7E0fQbuEwbFljk0Gdwb07ZyOSF7BaQw4kP-0aSTU-pu0QlfUzibp1_h8
Message-ID: <CAHc6FU7E4xiM7HZFBiv_i47iOhwFLg+0AYRaDU70tPFt7NB2Mw@mail.gmail.com>
Subject: Re: [PATCH] fs: gfs2: Fix typos in comments
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: opa1QilrD2Hc4F2JLon0SzJC2HN3qQQq-FYdqbgnSrw_1788185403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 12:33=E2=80=AFAM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:
> Fix spelling mistake in comments:
>  - occured -> occurred (twice)

Thanks for the patch. Could you resend with a signed-off-by header?

Andreas

> ---
>  fs/gfs2/lock_dlm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 7828ad0b6..563bb90a3 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -434,7 +434,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
>   * 10. gfs2_control sets control_lock lvb =3D new gen + bits for failed =
jids
>   * 12. gfs2_recover does journal recoveries for failed jids identified a=
bove
>   * 14. gfs2_control clears control_lock lvb bits for recovered jids
> - * 15. gfs2_control checks if recover_block =3D=3D recover_start (step 3=
 occured
> + * 15. gfs2_control checks if recover_block =3D=3D recover_start (step 3=
 occurred
>   *     again) then do nothing, otherwise if recover_start > recover_bloc=
k
>   *     then clear BLOCK_LOCKS.
>   *
> @@ -812,7 +812,7 @@ static void gfs2_control_func(struct work_struct *wor=
k)
>
>         /*
>          * No more jid bits set in lvb, all recovery is done, unblock loc=
ks
> -        * (unless a new recover_prep callback has occured blocking locks
> +        * (unless a new recover_prep callback has occurred blocking lock=
s
>          * again while working above)
>          */
>
> --
> 2.51.1
>

