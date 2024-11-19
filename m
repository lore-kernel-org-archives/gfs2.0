Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BD1547FF
	for <gfs2@lists.linux.dev>; Tue, 19 Nov 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050400; cv=none; b=sRXPI7ly4cY9b/PKc3qhbqHeJpelGLy0PAcClgUEH85Bv1tMMqLz6Uez6s0oKIhynIvG1/RlJHEJpfAMZFDl7tVF6Ty44D7fS7EFSkm2NXN9WCxP398Yf8RiqUamhKZDPoLj70RHQXBM8EFcezEF7AaYzhuTenLsFKaESnlHs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050400; c=relaxed/simple;
	bh=/s6WsaKaozi3wDKJ8BOLBVJCbu98OaNOrs7s3ri7C/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBEk0z3gsvMhrAIwBNtu30vymvtMbFvuPl0osaHbK4e2N4GPypQLARjkIk0ylaTl3sH3LAEO1DQrRQH4nx13aBz90o1aPAIyrxTI3+T8SXcjXuPSf9KUCwzDL4VMUH7DKSL3oMpmoQb4S8Kmha4KezEQ2D59M08RGAcM52W7Q30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/vREocv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/vREocv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732050396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwF19w7XmgDcHOT4seam6LSIbpb3mDMqrL3Amgt3hho=;
	b=e/vREocvKgiguytbfJ83/jNDL+ORT/NHL08CPo/L3rf94UxaPG9Z+a5UKXP38dzg9b/eRF
	8S8W5B1iH/BmrxoNw5Kktjh+PxjTZXb9KpETIkxOvcwhK6ZaGad9c2bzysNTzLlTWm+Io8
	1WQxQAEyfsxY954sf/ZXU7LpRRFiVF8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-7FFOSlXyOjGfcatjQRbpTQ-1; Tue, 19 Nov 2024 16:06:35 -0500
X-MC-Unique: 7FFOSlXyOjGfcatjQRbpTQ-1
X-Mimecast-MFC-AGG-ID: 7FFOSlXyOjGfcatjQRbpTQ
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ff4e0a2a61so19848191fa.2
        for <gfs2@lists.linux.dev>; Tue, 19 Nov 2024 13:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732050392; x=1732655192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwF19w7XmgDcHOT4seam6LSIbpb3mDMqrL3Amgt3hho=;
        b=TQUkbMwwFacUfvvUOjAkKYp0giltd2SqFYFj0TwxWTJl2EhXg+bQxXT2lpwoJswyXM
         ntXc7UqYrAyzdy00goSXsBECsDiG7y5hW9z3Hd8ZbqPNN5ho2N8B3ngMVWCRDQftFp16
         IHNf3zH6LCIaBJkHaWIXZxp/jD69id96so7cuwLwK1dQAM4O/apIk7pwwXGvO3lnGx/E
         rJn1KF0KZQ0VlBdAT4iG/69XvxFLmdRawTDTsYtFO2Yq47Z5YS9Wh9dK16NsEpuAi7ag
         Ax/4QfwHoRzmhI900LDnfJbz/pN+4Lfi+FGIek0oCcbW1qAvTYjItO3i/tUrbu9ZpzX8
         PyaA==
X-Gm-Message-State: AOJu0YxDZWbEmQfj9g3yqUgIM5DDrth8ED+ohFKeoeRbVRnpkQV/2RNe
	3LVzjk/59eBQ0dorXRJO5Nqz/QW7VOHz3DZoj6u3SHXT9sgpeGBD/Af0xcvpGS/gOtxaounmoJz
	44H0wSx4Zy+WD45muw6ZtKchRzEeDLKCLWbs7kbaz8ry+k0iSR0IoPd+mtvgmfnlutB2YaPL9se
	ETERWDUerQ2+qPat2ayh+EOixG/0l9PZD0Qu3Y
X-Received: by 2002:a2e:a9a5:0:b0:2f7:a759:72a7 with SMTP id 38308e7fff4ca-2ff8dc877b3mr2717921fa.22.1732050392565;
        Tue, 19 Nov 2024 13:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx4oVpidcx5XnwMQSHQ15/GTGPXQxh7JzgenhLWu3AQZWHNe98Rv+LfqTJFzWVwB9gZavQQqqI6OrQzzABUZk=
X-Received: by 2002:a2e:a9a5:0:b0:2f7:a759:72a7 with SMTP id
 38308e7fff4ca-2ff8dc877b3mr2717801fa.22.1732050392100; Tue, 19 Nov 2024
 13:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241119205644.999314-1-aahringo@redhat.com>
In-Reply-To: <20241119205644.999314-1-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 19 Nov 2024 16:06:20 -0500
Message-ID: <CAK-6q+iUYG0hmEeERtPD-Eew2kRKu3+PZ35R9z1sxAJyW1-fOQ@mail.gmail.com>
Subject: Re: [PATCH dlm/next] dlm: fix missing rsb put on scan timer
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e42GOyv_Fl0DBZmFGzB1cBTRvi9qcObb1nfDqM6fv6E_1732050394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 19, 2024 at 3:56=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> I figured out we don't cleanup all rsb on toss list right now if all
> locks are unlocked in the cluster for a resource. After investigation
> I figured out the condition to add_scan() is wrong and I added a comment
> for the second important condition for all possible permuations of the
> boolean expression.
>
> The current expression:
>
> "(r->res_master_nodeid !=3D our_nodeid &&
>   dlm_dir_nodeid(r) !=3D our_nodeid))"
>
> it only covers the case when we are not the master and not the dir node
> which is the second case of the added comment in 2. Case 1 and 3 are
> forgotten.
>
> Remove also the del_scan() as it always should remove the rsb out of the
> scan timer when it's on, if it's not on del_scan() will do nothing.
>
> For find_rsb_nodir() the del_scan() need to be moved before clearing the
> RSB_INACTIVE flag as del_scan() is has a WARN_ON() on it.
>
> Fixes: c217adfc8caa ("dlm: fix add_scan and del_scan usage")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/lock.c | 53 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 15 deletions(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index b406322f26a7..5ea3919b62a0 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -906,9 +906,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const voi=
d *name, int len,
>                 r->res_first_lkid =3D 0;
>         }
>
> -       /* A dir record will not be on the scan list. */
> -       if (r->res_dir_nodeid !=3D our_nodeid)
> -               del_scan(ls, r);
> +       /* we always deactivate scan timer for the rsb, when
> +        * we move it out of the inactive state as rsb state
> +        * can be changed and scan timers are only for inactive
> +        * rsbs.
> +        */
> +       del_scan(ls, r);
>         list_move(&r->res_slow_list, &ls->ls_slow_active);
>         rsb_clear_flag(r, RSB_INACTIVE);
>         kref_init(&r->res_ref); /* ref is now used in active state */
> @@ -1071,10 +1074,10 @@ static int find_rsb_nodir(struct dlm_ls *ls, cons=
t void *name, int len,
>                 r->res_nodeid =3D 0;
>         }
>
> +       del_scan(ls, r);
>         list_move(&r->res_slow_list, &ls->ls_slow_active);
>         rsb_clear_flag(r, RSB_INACTIVE);
>         kref_init(&r->res_ref);
> -       del_scan(ls, r);
>         write_unlock_bh(&ls->ls_rsbtbl_lock);
>
>         goto out;
> @@ -1419,9 +1422,13 @@ static int _dlm_master_lookup(struct dlm_ls *ls, i=
nt from_nodeid, const char *na
>         __dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
>                             r_nodeid, result);
>
> -       /* A dir record rsb should never be on scan list. */
> -       /* Try to fix this with del_scan? */
> -       WARN_ON(!list_empty(&r->res_scan_list));
> +       /* A dir record rsb should never be on scan list.
> +        * Except when we are the dir and master node.
> +        * This function should only be called by the dir
> +        * node.
> +        */
> +       WARN_ON(!list_empty(&r->res_scan_list) &&
> +               r->res_master_nodeid !=3D our_nodeid);
>
>         write_unlock_bh(&ls->ls_rsbtbl_lock);
>
> @@ -1513,15 +1520,31 @@ static void deactivate_rsb(struct kref *kref)
>
>         /*
>          * When the rsb becomes unused:
> -        * - If it's not a dir record for a remote master rsb,
> -        *   then it is put on the scan list to be freed.
> -        * - If it's a dir record for a remote master rsb,
> -        *   then it is kept in the inactive state until
> -        *   receive_remove() from the master node.
> +        * - It's on scan list when there is no directory
> +        *   node functionality
> +        * or
> +        * - If we are the rsb master we need to call
> +        *   send_remove() to the dir node and delete ourself.
> +        *
> +        *   The second case is if we are not the dir node we
> +        *   need to delete ourself as well but don't call
> +        *   send_remove() as we are not the master.
> +        *
> +        *   There is a thrid case when the node is master and
> +        *   dir node at the same time. Then the rsb need to be
> +        *   added to the scan timer as well because the scan
> +        *   acts like a local send_remove() that is done
> +        *   immediately.
> +        *
> +        *   The fourth case is the one we need to avoid here,
> +        *   when we are the directory node and not the master.
> +        *   Then we never should be on the scan timer and
> +        *   waiting of receive_remove() of the second case.

meant the first case here...

> +        *   Then the condition is false.
>          */
> -       if (!dlm_no_directory(ls) &&
> -           (r->res_master_nodeid !=3D our_nodeid) &&
> -           (dlm_dir_nodeid(r) !=3D our_nodeid))
> +       if (dlm_no_directory(ls) ||
> +           (r->res_master_nodeid =3D=3D our_nodeid ||
> +            dlm_dir_nodeid(r) !=3D our_nodeid))
>                 add_scan(ls, r);

- Alex

