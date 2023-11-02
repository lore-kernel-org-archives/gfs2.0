Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5771548B
	for <gfs2@lists.linux.dev>; Thu,  2 Nov 2023 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl/HQ88h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698925864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXvh0HaN7chqLYewNa2LL+UKTHm+C7BuJqCkmXwm+hI=;
	b=Bl/HQ88hIG2ml5dl5zOH0bvAK4ookf/HlNsmk/TGXsQGhvrIp35zZDvE3ehryjcW3LVHuC
	D4MVgSSbtDA32wNBvVKgk8zGTuoRGFu+Rj7MlN0ftDx7CnRRm5l/3DHhMTJ9F9qdr2tD3p
	aCQug/DoSw4f+xrFP8ldGHbF2+2Qq5Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-sI9aEhCnO2Kjm4gFKtFKLQ-1; Thu, 02 Nov 2023 07:51:00 -0400
X-MC-Unique: sI9aEhCnO2Kjm4gFKtFKLQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc281f1214so7048125ad.2
        for <gfs2@lists.linux.dev>; Thu, 02 Nov 2023 04:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925860; x=1699530660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXvh0HaN7chqLYewNa2LL+UKTHm+C7BuJqCkmXwm+hI=;
        b=ZvXJAl9B4lCrykrxmwIPVRmlvF4dHxDWhH0EJ5L43RcmwAQ3HBI8QpT1oY6OC4JoHQ
         UTir292rSe3mv+0rYBhpqxCoEC49x9XeNDUAwvowJO+vVfDNkFcyRmV/2rMZ0eAOc/I0
         LdB84fHqdHQolMDKTzSNFsxjOUlvIspXeA44jZDsxmp6lwVtxOzDsGPuG0Pz3qmJ0/qk
         A1ksUniUNd1Zsn7F0ElezoZj9p3H08v9O9gH6bGzwBCgIzkgSluOpELOgKDjF/D/2fhV
         /hrUkj0iGDX7Y5rzJzulgFQ0OZlM4RAV7Gi3pFwxqom/qWjTzp+wYQCCa3F9JBwQ73WX
         UJlQ==
X-Gm-Message-State: AOJu0YytujJogGNeG9CLlOXRLMBUILd26w+CDXGBWUXkXLgzfAgREbAx
	xcsSECOyIVqMO2u3U7PbFC/3iCW6T0AXb4fLqonYAfQ4udQnyjZGODPxWVak9Ah/8T7n8eLFkEw
	JeitxB0mUise5pxTaJNkdO0iA5O18/g==
X-Received: by 2002:a17:902:ec91:b0:1cc:54fb:60f9 with SMTP id x17-20020a170902ec9100b001cc54fb60f9mr10689017plg.37.1698925859914;
        Thu, 02 Nov 2023 04:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeDlGc9ZGH6KLUUs2Oy1+WEmNgkUJb5lFfrVvtguyJjyCi7rE9YZlkZPXYJTVtaydPfwGnkT4uiclyiO5PhFc=
X-Received: by 2002:a17:902:ec91:b0:1cc:54fb:60f9 with SMTP id
 x17-20020a170902ec9100b001cc54fb60f9mr10689005plg.37.1698925859679; Thu, 02
 Nov 2023 04:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231102015141.1355762-1-suhui@nfschina.com>
In-Reply-To: <20231102015141.1355762-1-suhui@nfschina.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 2 Nov 2023 12:50:47 +0100
Message-ID: <CAHc6FU5H-Ju9129Xr3RGA6DePDL58tQ7nOkSJXdig4gJc1w+WA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: remove dead code in __acquires
To: Su Hui <suhui@nfschina.com>
Cc: rpeterso@redhat.com, nathan@kernel.org, ndesaulniers@google.com, 
	trix@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 2:54=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> clang static analyzer complains that value stored to 'gh' is never read.
> The code of this line is useless after commit 0b93bac2271e
> ("gfs2: Remove LM_FLAG_PRIORITY flag"). Remove this code to save space.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/gfs2/glock.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 3772a5d9e85c..347f8a020c82 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1524,7 +1524,6 @@ __acquires(&gl->gl_lockref.lock)
>                 return;
>         }
>         list_add_tail(&gh->gh_list, insert_pt);
> -       gh =3D list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_l=
ist);
>         spin_unlock(&gl->gl_lockref.lock);
>         if (sdp->sd_lockstruct.ls_ops->lm_cancel)
>                 sdp->sd_lockstruct.ls_ops->lm_cancel(gl);
> --
> 2.30.2
>

Thanks, I'll add this.

(The subject "gfs2: remove dead code in __acquires" is misleading
because the function this is in is called add_to_queue(); __acquires
is just an annotation.)

Andreas

