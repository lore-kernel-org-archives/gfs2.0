Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA918A92F
	for <gfs2@lists.linux.dev>; Tue, 30 Jul 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353879; cv=none; b=TJRqyjkHRyaIfeRN8DOdFHoEWsN+QQod/PxhqbZHKHclUwMdr7fQZoPMlfPMnPLbatuhiUN98R0h86xYuhTw1ibhWFeVSYX2mORjG8NPwWrvj1eWvDPHMjwjZb3jdsAigz3ed5jZcZyckPNbjBJ18YlyJ2zkEqJD2R5cvfyEJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353879; c=relaxed/simple;
	bh=f/B9MPjdXQXwCAWdMV4OFACasrZgZwYN89K5nK7VnzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHmqsd8Ha/TPo2rw8v2dytAe1/1YsQ3cnN3KJOVlx5M+oMXfnuBWeoVBkyCANfEgSHzLGPe27j5CU/dysIaZInYjtUHAb0y6GPw6psu9uBYWHIuA0TvoT9HbTt/SIRnwybjdlvz6nuz1VPjv+h/ZUO6Oje+e2Rhr5RppmPGa4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjVPZ6BC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjVPZ6BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722353876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3ewTpuZoMO//qD7ai0P5L3NUJTCmzZ1N4WbCrlBJZA=;
	b=cjVPZ6BCc+OVudK8BYYao+XuAd57JP4/eVeyNHqgga+jrA3X5BEZ7UlYsTz3S8cgupF8N4
	33sSAndbDt4p+UjhpDGQNLeevmsaowO10RV+Wb6oNthdD8c49xRQeFnesH9GMY3RRP4RiH
	PeCy/BLujMTj4MKjmDsneQh9Wk9R7a0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-1SLMgj_VOJ-dwlU16_Alrg-1; Tue, 30 Jul 2024 11:37:52 -0400
X-MC-Unique: 1SLMgj_VOJ-dwlU16_Alrg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef315c6990so34860901fa.1
        for <gfs2@lists.linux.dev>; Tue, 30 Jul 2024 08:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353870; x=1722958670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ewTpuZoMO//qD7ai0P5L3NUJTCmzZ1N4WbCrlBJZA=;
        b=S72AtzJ/XAXigxkRMMLt72LaGeXp6IYfTLlLb4Wk6ISoaivciLV+K8234TEvRABpF8
         U6lHBMmV9NWGuMUNOpixNEdD4hDw5xwuYR3GjmmbB2M/Y+TVJtaYY/e7zPJdNJXTlt7K
         J3OPME4iGdnOg7JKwAJoEGvflS/kgvz0VsrxsRPk+3Y8VKmdsPIUnB/dVZymOTtDxcMf
         BtzHa4YnQxg8Ube9vWeyiVyn7ms+eAGUH9eweH88Jqd+YADI2i3m2qI6PaZ/JfeEEx2Z
         BxYAWWADhiznYNLJyyM6xo2xT9JEvgI8zn8yiNvJ13nUMJZ7MCdFNqAWOJvHPZ19vBVc
         R0jw==
X-Gm-Message-State: AOJu0YxmEZPtmR+Yuxbq3Zu+KoaS2iQ5TT5SX3vYcNmQMbNsF8InmDeX
	NTgyo/nMQQwmYik+bRaXpSQovHcNuieIggq9qshcubhmGjnf5yDpMMVTfgXNztBoDpnz/iaIU1O
	qrbtNJvVnIPkSnc4P52KzRIbpTUq8ki1d4IAVdjhVEnlI1tl+6i40OPeaJPxAs3eCeJv9wtyU5O
	+o3BSGSGnA6YBxw/0SlA2976iLEA==
X-Received: by 2002:a2e:9e05:0:b0:2ef:1efb:1b6b with SMTP id 38308e7fff4ca-2f1478f991dmr7458791fa.15.1722353870637;
        Tue, 30 Jul 2024 08:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNZHA556Ld3iOZcPHTr2KDXiGDK+Di0+z8zqwUc39fi5X/XQUIgvdPhyQotPGmlNVS3VQQAEhzL9wQKZz0aak=
X-Received: by 2002:a2e:9e05:0:b0:2ef:1efb:1b6b with SMTP id
 38308e7fff4ca-2f1478f991dmr7458721fa.15.1722353870222; Tue, 30 Jul 2024
 08:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729193630.3344082-1-aahringo@redhat.com> <20240729193630.3344082-6-aahringo@redhat.com>
In-Reply-To: <20240729193630.3344082-6-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 30 Jul 2024 11:37:39 -0400
Message-ID: <CAK-6q+jLwBDYV0e45r2TvYkq7E+tGPe2mvPbAPiYzZenUpDq0w@mail.gmail.com>
Subject: Re: [PATCH v6.11-rc1 06/10] dlm: async freeing of lockspace resources
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2024 at 3:36=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch handles freeing of lockspace resources asynchronously besides
> the release_lockspace() context. The release_lockspace() context is
> sometimes called in a time critical context, e.g. umount syscall. Most
> every user space init system will timeout if it takes too long. To
> reduce the potential waiting time we deregister in release_lockspace()
> the lockspace from the DLM subsystem and do the actual releasing of
> lockspace resource in a worker of a workqueue following recommendation
> of:
>
> https://lore.kernel.org/all/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.S=
AKURA.ne.jp/T/#u
>
> as flushing of system workqueues are not allowed. The most time to
> release the DLM resources are spent to release the data structures
> "ls->ls_lkbxa" and "ls->ls_rsbtbl" as they iterate over each entries and
> those data structures can contain millions of entries.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/dlm_internal.h |   4 ++
>  fs/dlm/lockspace.c    | 100 +++++++++++++++++++++++-------------------
>  fs/dlm/main.c         |  10 +++++
>  3 files changed, 69 insertions(+), 45 deletions(-)
>
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index 32d98e63d25e..0562099e60eb 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -660,6 +660,8 @@ struct dlm_ls {
>         const struct dlm_lockspace_ops *ls_ops;
>         void                    *ls_ops_arg;
>
> +       struct work_struct      ls_free_work;
> +
>         int                     ls_namelen;
>         char                    ls_name[DLM_LOCKSPACE_LEN + 1];
>  };
> @@ -803,6 +805,8 @@ static inline void dlm_set_sbflags_val(struct dlm_lkb=
 *lkb, uint32_t val)
>                           __DLM_SBF_MAX_BIT);
>  }
>
> +extern struct workqueue_struct *dlm_wq;
> +
>  int dlm_plock_init(void);
>  void dlm_plock_exit(void);
>
> diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> index bf14016d53e1..e1df92853a53 100644
> --- a/fs/dlm/lockspace.c
> +++ b/fs/dlm/lockspace.c
> @@ -315,6 +315,56 @@ static int threads_start(void)
>         return error;
>  }
>
> +static int lkb_idr_free(struct dlm_lkb *lkb)
> +{
> +       if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_ifl=
ags))
> +               dlm_free_lvb(lkb->lkb_lvbptr);
> +
> +       dlm_free_lkb(lkb);
> +       return 0;
> +}
> +
> +static void rhash_free_rsb(void *ptr, void *arg)
> +{
> +       struct dlm_rsb *rsb =3D ptr;
> +
> +       dlm_free_rsb(rsb);
> +}
> +
> +static void free_lockspace(struct work_struct *work)
> +{
> +       struct dlm_ls *ls  =3D container_of(work, struct dlm_ls, ls_free_=
work);
> +       struct dlm_lkb *lkb;
> +       unsigned long id;
> +
> +       xa_destroy(&ls->ls_recover_xa);
> +       kfree(ls->ls_recover_buf);
> +
> +       /*
> +        * Free all lkb's in xa
> +        */
> +       xa_for_each(&ls->ls_lkbxa, id, lkb) {
> +               lkb_idr_free(lkb);
> +       }
> +       xa_destroy(&ls->ls_lkbxa);
> +
> +       /*
> +        * Free all rsb's on rsbtbl
> +        */
> +       rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL)=
;
> +
> +       /*
> +        * Free structures on any other lists
> +        */
> +
> +       dlm_purge_requestqueue(ls);
> +       kfree(ls->ls_recover_args);
> +       dlm_clear_members(ls);
> +       dlm_clear_members_gone(ls);
> +       kfree(ls->ls_node_array);
> +       kfree(ls);
> +}
> +
>  static int new_lockspace(const char *name, const char *cluster,
>                          uint32_t flags, int lvblen,
>                          const struct dlm_lockspace_ops *ops, void *ops_a=
rg,
> @@ -445,6 +495,8 @@ static int new_lockspace(const char *name, const char=
 *cluster,
>         spin_lock_init(&ls->ls_cb_lock);
>         INIT_LIST_HEAD(&ls->ls_cb_delay);
>
> +       INIT_WORK(&ls->ls_free_work, free_lockspace);
> +
>         ls->ls_recoverd_task =3D NULL;
>         mutex_init(&ls->ls_recoverd_active);
>         spin_lock_init(&ls->ls_recover_lock);
> @@ -627,15 +679,6 @@ int dlm_new_user_lockspace(const char *name, const c=
har *cluster,
>                                    ops_arg, ops_result, lockspace);
>  }
>
> -static int lkb_idr_free(struct dlm_lkb *lkb)
> -{
> -       if (lkb->lkb_lvbptr && test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_ifl=
ags))
> -               dlm_free_lvb(lkb->lkb_lvbptr);
> -
> -       dlm_free_lkb(lkb);
> -       return 0;
> -}
> -
>  /* NOTE: We check the lkbxa here rather than the resource table.
>     This is because there may be LKBs queued as ASTs that have been unlin=
ked
>     from their RSBs and are pending deletion once the AST has been delive=
red */
> @@ -667,17 +710,8 @@ static int lockspace_busy(struct dlm_ls *ls, int for=
ce)
>         return rv;
>  }
>
> -static void rhash_free_rsb(void *ptr, void *arg)
> -{
> -       struct dlm_rsb *rsb =3D ptr;
> -
> -       dlm_free_rsb(rsb);
> -}
> -
>  static int release_lockspace(struct dlm_ls *ls, int force)
>  {
> -       struct dlm_lkb *lkb;
> -       unsigned long id;
>         int busy, rv;
>
>         busy =3D lockspace_busy(ls, force);
> @@ -732,34 +766,10 @@ static int release_lockspace(struct dlm_ls *ls, int=
 force)
>
>         kobject_put(&ls->ls_kobj);
>
> -       xa_destroy(&ls->ls_recover_xa);
> -       kfree(ls->ls_recover_buf);
> -
> -       /*
> -        * Free all lkb's in xa
> -        */
> -       xa_for_each(&ls->ls_lkbxa, id, lkb) {
> -               lkb_idr_free(lkb);
> -       }
> -       xa_destroy(&ls->ls_lkbxa);
> -
> -       /*
> -        * Free all rsb's on rsbtbl
> -        */
> -       rhashtable_free_and_destroy(&ls->ls_rsbtbl, rhash_free_rsb, NULL)=
;
> -
> -       /*
> -        * Free structures on any other lists
> -        */
> -
> -       dlm_purge_requestqueue(ls);

this.

> -       kfree(ls->ls_recover_args);
> -       dlm_clear_members(ls);

and this.

Should stay here, it does more than just releasing memory. But the
rest should be okay to handle it in the background in a different
context in some kind of slow path. As mentioned in the commit msg it
is mostly about the data structures here that may contain millions of
entries (we don't know what the DLM user is doing)  and we are doing
"our best" to return faster from the release_lockspace() function.

- Alex

