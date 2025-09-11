Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935EF33CEAA
	for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601531; cv=none; b=kw3tLzThSwMCQ7D9mNmByumxsb82dKF8qhdO20/91RwWhZRZi3JH0XBDNToQm82oaUYZIxPIuKk9a5sXLhBkgQ1cIVhyLEWK8bw+cqI3iT/8fL4iABjxe0f8Bcrb6WlpQHceDZrk1Ji6v4sHxvb48NQMCmowu7/H1EsNuXoCbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601531; c=relaxed/simple;
	bh=8soN6rxMf+hbwzPFHAOw0SiZ9+BEZ+Zf4oVMft6IHs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/ZCDYRk7tNrv1lxOgF993/XuuiIKftxAwoM/dv0gHFeo1vvfKcy672lNjI0Fz21YzUALrMl7eFx+nYH2xqmEHUVchHVvmOeRv1HrveDBIaFot8TonAEVI1gbsiIYP2VecarxP+qMC//PYqe+R3xauH99M4tHySJOG8YvAiJldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWp05F3K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWp05F3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757601528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIPv42Je3ufieqUPVRa/WfMuWNmuQmCrniAmwNhdfvM=;
	b=GWp05F3KlG4MzvpOJfbQ03XdLljwV8AYx7HhvsGkxccwIAIVo9TOEvKbLXt0aaoRxyld3A
	d3OC4noc8Xoj+F6ZLJJsIotOITbzm2kOIuiIeT5JUrijQrsNsbVQKzL9Rwg1f1gfTPFxdR
	e6OvV/nJicseO7tadmvI/KDmDLiCp+k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-IrcSTfelOu-KPm8EVxueZg-1; Thu, 11 Sep 2025 10:38:46 -0400
X-MC-Unique: IrcSTfelOu-KPm8EVxueZg-1
X-Mimecast-MFC-AGG-ID: IrcSTfelOu-KPm8EVxueZg_1757601525
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-337e64e34c9so4482971fa.1
        for <gfs2@lists.linux.dev>; Thu, 11 Sep 2025 07:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601525; x=1758206325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIPv42Je3ufieqUPVRa/WfMuWNmuQmCrniAmwNhdfvM=;
        b=e9GyJ3UviwNWtdHhuc8Rbp6D+1XNRGn4JziqjV8tqOu9PbXsoLPG0MndOLzWLndRnD
         W82bK9f4RQACl42/9ZjCni6erQB0d0eBk5oZIhCPnVKbfnoGh05dQCChS/h2V25RiQNb
         7otRTE6+GOaTdpafD39JQ4VMnuO/XI/NPyiuP/ImzXxGK1kMD27QQPsTM5Q3P2q2Y4FN
         F6nt4F/XKm58aH4ptAr33+ej2b1geJONJP88KLon7svXM+ahh6aeuschBGs9BY4hFACl
         Jz3hp9nnlO2/mDOQSGWF5TxHABl9yV39qXovFYAFleMVr5tmSBlTZwJCZ1BodFhxgZLG
         lxfg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Fw/51lAolRw83thtEJtsc+3GOo0S9asY6m1hm6tfDv5xnkbQBX3F+Wmvf/94ztu0a5+8@lists.linux.dev
X-Gm-Message-State: AOJu0YwVcYuGwX8sCOy+EEB6GzrDCEA83A31mNfb6l8/aEljMtAXuqr/
	MDR2DmxvSZznNT7WdTl9NU3t9764Q4AHsYbQ2ypdVP2Wr8nsTJE+cSqPkDeBSzK+jbZ7rRK/F5K
	h12ynZ/+wDtBKEvXYsB/twJ1m25StwR+kL4xK3WiWf69fDpS2cWKDzNDmPBN9qRZvmbcbLRcbTn
	/YK//+l4svRp+oS4BZPl4qA6LwTGDUqw==
X-Gm-Gg: ASbGncv8Klk2xkxfWrrfky8jpmNUcCe08WffiXYf0QRibdmstuWr5b6YpoWsWu7/81S
	1Q2QRBZcHVLvl0tuO/8OMJYMOZFEeAEAhICWwk8t4n8mFn1nUeDXVQczO8vFuhOcHH1ojEVtkSK
	XUU3qGiXIh7EGeozK3M+c4MGfxNsYkBbPEsYPaxpMd4eGLTIgNAQetv9c=
X-Received: by 2002:a2e:b8c1:0:b0:337:f217:a785 with SMTP id 38308e7fff4ca-33b5cbcec6amr63395121fa.23.1757601525175;
        Thu, 11 Sep 2025 07:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbncV35xoEUNPKEtJTtLC8EEhusftfJk+xhn2Y5J2nM9pwSu2qk9ra9C5LYi9diVDd2gYDA6O1QJ6fGt/Xtv0=
X-Received: by 2002:a2e:b8c1:0:b0:337:f217:a785 with SMTP id
 38308e7fff4ca-33b5cbcec6amr63395031fa.23.1757601524652; Thu, 11 Sep 2025
 07:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
In-Reply-To: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 11 Sep 2025 10:38:33 -0400
X-Gm-Features: Ac12FXwK-hbBkhX-Cm9Le6saS3hUgNdFo5aoBszztbjqFgH7QHOAT5HCs_AG1SQ
Message-ID: <CAK-6q+hYROHr2eEyJ+j5VWpmwDQd+fA+ZmDTps4rDKXnCq6tHg@mail.gmail.com>
Subject: Re: [PATCH] * dlm: improve lock management and concurrency control
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <alessio.attilio@engineer.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lGNKP_MJf9CpPbdR0_UAyBO8zN-7zUZrp7HNl7Yn_rU_1757601525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 10, 2025 at 1:23=E2=80=AFPM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
> From: Alessio Attilio <alessio.attilio@engineer.com>
>
> This patch introduces several improvements to lock handling in the DLM
> subsystem, focusing on thread safety, correctness, and code clarity.
>
> - Added explicit locking (spin_lock_bh/spin_unlock_bh) around accesses
>   to proc->locks and proc->asts in dlm_clear_proc_locks, ensuring safe
>   concurrent operations during lock cleanup.
> - Replaced del_proc_lock with direct, lock-protected list operations
>   for improved clarity and correctness.
> - Updated send_unlock to set RSB_MASTER_UNCERTAIN only when releasing
>   the last lock on an rsb, ensuring proper master confirmation.
> - Improved handling of persistent and non-persistent locks by setting
>   appropriate flags (DLM_DFL_ORPHAN_BIT or DLM_IFL_DEAD_BIT) before
>   orphaning or unlocking.
> - Removed outdated comments related to mutex protection and serialization
>   assumptions, reflecting the updated concurrency model.
>
> Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>

The patch doesn't compile for me as well. Please also make sure to run
"scripts/checkpatch.pl" on your patch before sending it.

> ---
>  fs/dlm/lock.c | 99 ++++++++++++++++++++++++---------------------------
>  1 file changed, 46 insertions(+), 53 deletions(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 6dd3a524cd35..9170b5c09823 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -3654,12 +3654,33 @@ static int send_convert(struct dlm_rsb *r, struct=
 dlm_lkb *lkb)
>         return error;
>  }
>
> -/* FIXME: if this lkb is the only lock we hold on the rsb, then set
> -   MASTER_UNCERTAIN to force the next request on the rsb to confirm
> -   that the master is still correct. */
> -
>  static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
>  {
> +       struct dlm_lkb *tmp;
> +       int count =3D 0;
> +
> +       list_for_each_entry(tmp, &r->res_grantqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +       list_for_each_entry(tmp, &r->res_convertqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +       list_for_each_entry(tmp, &r->res_waitqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +
> +/*
> + * When releasing the last lock on the rsb, we mark the master as uncert=
ain.
> + * This ensures that the next lock request will verify the master node,
> + * maintaining consistency across the cluster.
> + */

After unlocking the rsb should be moved to the inactive/toss state, if
it's activated again it should be that there is a new lookup being
done when it's necessary.
This however is not being done at the state here. As you describe the
problem it is about multiple concurrent requests the problem might be
something different.
There should be no cancel/unlock requests at the same time, cancel is
only for requests or converts not for unlock, maybe what's missing
here is to check on an invalid API usage at [0]?

As far as I understood from your problem specification, a
stacktrace/reproducer/coredump would be much more helpful here.

...
> -       spin_lock_bh(&ls->ls_clear_proc_locks);
> -
> +       spin_lock_bh(&proc->locks_spin);
>         /* in-progress unlocks */
>         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueu=
e) {
>                 list_del_init(&lkb->lkb_ownqueue);
>                 set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
>                 dlm_put_lkb(lkb);
>         }
> +       spin_unlock_bh(&proc->locks_spin);
>
> +       spin_lock_bh(&proc->asts_spin);
>         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
>                 list_del(&cb->list);
>                 dlm_free_cb(cb);
>         }
> +       spin_unlock_bh(&proc->asts_spin);
>
> -       spin_unlock_bh(&ls->ls_clear_proc_locks);

This lock has after your patch only one lock/unlock user in user.c
which makes this lock obsolete, however it seems your user.c changes
are not part of your patch and got somehow missed.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.17-rc5#n2892

