Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215D1E500
	for <gfs2@lists.linux.dev>; Sun, 10 Mar 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080866; cv=none; b=QMtuADDotBLlXyqyokj7my2hE7x9WrHpHUxDCOugGMt6nzCPjWMey/edRicCP9HfghVOO32pmI0p3+7L1fczIbfaoGIyrkJx98ZItysn4arqqBKG8gegqkWOzylOBtvD4/+m2w9mvn/FNyVMCdDm1B2PbKtL/fSz1bq9a6Ti0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080866; c=relaxed/simple;
	bh=1+85TM6DWrKvMp16s5nOlKNQ8Z8pNOix1zvC1hnv1WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+5KEqRtA3lZZNcbhyffTte8UWI0MYSljhUVhy7dZ0PyY9W8/FxkKjP57ZZQ/8Pdo9d2z4+Pnpc108W8c3n/z0kb7vA/16++lgczwK1zkt+IjmrLYmjyEXDPIUhtutW/OPh7o5HCbYzALJgklK9/uiJwzAmcBeRfnWpB3WzL+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrVM7FBX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrVM7FBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710080863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgfeUu7yryli9iAixZeZzFpDSBcpi7o4vea5YA3Pe6Y=;
	b=WrVM7FBXSCsDyS8hLdIzm+yTeBdjGVI3gPyhKLm/TEqitVe7qqKLE1pUQ/3V6R8m3fExft
	/vG8Z/Z9p7AmA+4/SjsR6DgIDkdUMRQ8CUa9kAd+nwup57uWOlNKMey0DQ4xZrIs31qFtO
	Gokxbq9VX8eiuj57eBxAj9DHdQNFBAw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Igm7YRXgOjOy-DmSUjW7zQ-1; Sun, 10 Mar 2024 10:27:41 -0400
X-MC-Unique: Igm7YRXgOjOy-DmSUjW7zQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d2b9aa4e35so22768591fa.3
        for <gfs2@lists.linux.dev>; Sun, 10 Mar 2024 07:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710080860; x=1710685660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgfeUu7yryli9iAixZeZzFpDSBcpi7o4vea5YA3Pe6Y=;
        b=FBCtt5qb2cMBwBzATOP2HOFoKiqQAYK8L6TYV8F+q6wtwqiGsNqxAcRuEWK8pv2Ksj
         UfdzV98CpaIiiWLbC+tx1q402muNnHVy8DZZ5/u+DjmL5TyRmKaxEqQJIeOVHJitOuUf
         NJgQBjNzqnrptVfIYnzz7QZ3sEZ556MrahIK3myk5ot+Mw2T2ZtCAN87Xdlx0qGIfnht
         YZC/0y/x2xCT7w/yCd2indeh9i32NzybGsE6VqXMmY869HHSIzgx1W2RzEi/CLP6VBfG
         ol4VQaEA2APocbhd+XCTtVUvc5fpDS9ce/VZXQoC8aVyysJEUiWohO13rHdei9us1HHY
         ZEUQ==
X-Gm-Message-State: AOJu0YzFbJdgLau3Edr1QRdSKgqSY2ENTxKMFHg8JSrpx8m2h2f2YWE8
	AvqauXShj4/ZZ7+isEC3O0JttI5BoXLcU10gDOEoZcpHebQdPK8k41i6GBqP68AlinaWIWnrwf1
	bH3xRpUgsONL/kOCGv8UMWaZh+W8PzYMJc9o2E3XqHq/mx+JvKeYlwU/+1pxkngz32MZwG7vAH5
	kHea4sUCE51mA9VodVOG9zU+NCZvcmlHZi9g==
X-Received: by 2002:a2e:be27:0:b0:2d2:a3bb:e319 with SMTP id z39-20020a2ebe27000000b002d2a3bbe319mr2635640ljq.1.1710080859889;
        Sun, 10 Mar 2024 07:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26ZUTeLIDVS+U9sEtvmM351nHSX87qp0NVfizPhX1OtyMsjzbhIyfvaLb3VdfByDR2MJbLJdrmwMeOSvf2E0=
X-Received: by 2002:a2e:be27:0:b0:2d2:a3bb:e319 with SMTP id
 z39-20020a2ebe27000000b002d2a3bbe319mr2635633ljq.1.1710080859554; Sun, 10 Mar
 2024 07:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308161818.2388451-1-aahringo@redhat.com> <20240308161818.2388451-2-aahringo@redhat.com>
In-Reply-To: <20240308161818.2388451-2-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 10 Mar 2024 10:27:28 -0400
Message-ID: <CAK-6q+h-RngJqJ6Rx2h4a0Qy1j+ZRvCn5E-3Qee7_P3pWXJonQ@mail.gmail.com>
Subject: Re: [RFC v6.8-rc6 1/7] dlm: fix user space lock decision to copy lvb
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 8, 2024 at 11:18=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch fixes the copy lvb decision in case of user space DLM lock
> requests. Currently the granted mode and requested mode is the same when
> evaluating the dlm_lvb_operations matrix. That reflects the diagonal of
> the dlm_lvb_operations matrix. Luckely it will mostly return a non zero
> result on its diagonal, but in case of requested mode PW or EX the
> diagonal returns 0, depending on the granted mode before the user might
> get an invalid lvb data that is marked as valid.
>
> This patch will move the decision if the lvb area should be copied or
> not to the enqueue callback functionality because the granted mode is
> known there. It also removes any lkb reference in the user callback
> result delivery functionality that is required for a future fix.
>
> Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/ast.c          | 16 ++++++++++++++++
>  fs/dlm/dlm_internal.h |  1 +
>  fs/dlm/user.c         | 17 +++--------------
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
> index 1f2f70a1b824..0582b6739b29 100644
> --- a/fs/dlm/ast.c
> +++ b/fs/dlm/ast.c
> @@ -12,6 +12,7 @@
>  #include <trace/events/dlm.h>
>
>  #include "dlm_internal.h"
> +#include "lvb_table.h"
>  #include "memory.h"
>  #include "lock.h"
>  #include "user.h"
> @@ -42,6 +43,7 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint3=
2_t flags, int mode,
>         struct dlm_ls *ls =3D lkb->lkb_resource->res_ls;
>         int rv =3D DLM_ENQUEUE_CALLBACK_SUCCESS;
>         struct dlm_callback *cb;
> +       bool copy_lvb =3D false;
>         int prev_mode;
>
>         if (flags & DLM_CB_BAST) {
> @@ -73,6 +75,19 @@ int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint=
32_t flags, int mode,
>                                 goto out;
>                         }
>                 }
> +
> +               lkb->lkb_last_bast_time =3D ktime_get();
> +               lkb->lkb_last_bast_mode =3D mode;
> +       } else if (flags & DLM_CB_CAST) {
> +               if (test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags) && lkb->=
lkb_last_cast) {
> +                       prev_mode =3D lkb->lkb_last_cb->mode;
> +
> +                       if (!status && lkb->lkb_lksb->sb_lvbptr &&
> +                           dlm_lvb_operations[prev_mode + 1][mode + 1])
> +                               copy_lvb =3D true;
> +               }
> +
> +               lkb->lkb_last_cast_time =3D ktime_get();
>         }
>

still buggy because the first callback should be copy_lvb =3D true which
isn't the case here but a later patch fixes that. However, I will fix
it.

- Alex

