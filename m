Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1353D1CD7
	for <gfs2@lists.linux.dev>; Tue,  6 Oct 2026 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319343; cv=none; b=nua9U2B3QtR90G16iL5naXl3dixIA3rxQayaebxnKa5jUtY/+E6NH2LSMwkUj4thNgJwMxaZ0b4UVahncx5o3RqL20WTgBYm4JyBVyMapUGS9b6lzFLCs73B2PAswfPQ0r+TJqix5fcVwpAeYqzh2MNJ1AmZSvd3aouOYpQv1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319343; c=relaxed/simple;
	bh=+nORsYlS7Yv+mwbjfI/EW2E88iULyaaBS/+y0CFsdOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc/6q/o8TsgiSKdTbIAxkGRzxZji8EmMTUk2XawhN2V9vbcJDYtk/LykhUE9/QeX80r9fsADQTG8E3lzIwMLXDhR+mbcneP9Dj44ZGYdpzl3AUtQw6Lv22UIy1lkUAMEb0AWfxVeno9G8zNoPej1C7ZY+I1/mpHqKSUoSkpgqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fT0XkXaY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT0XkXaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791319339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFT7m0xKcvqNQAKmV39ppldm2c+AaUkF1Lbywy1q/kA=;
	b=fT0XkXaY3VyvFs5B3txZ89Q/k+/zMPdcTuA1X4CUiw1nA7HvwaGyZmOgPI0KSRN+AqG5t8
	Z4hwnSiy9IBDzNsNxhTIh/AIuDGX362Dk8vXPvx/TCh+xePpuhrtg83aKO4fR/1C1LJC3Y
	sB+4PWMeoQiJJqy4Ial8oBumSFy8Bxo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-K4S9v9zlNAyOh_7ZrqLZUg-1; Tue, 06 Oct 2026 16:42:18 -0400
X-MC-Unique: K4S9v9zlNAyOh_7ZrqLZUg-1
X-Mimecast-MFC-AGG-ID: K4S9v9zlNAyOh_7ZrqLZUg_1791319337
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a87b92bdaeso20300621fa.0
        for <gfs2@lists.linux.dev>; Tue, 06 Oct 2026 13:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791319337; x=1791924137;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFT7m0xKcvqNQAKmV39ppldm2c+AaUkF1Lbywy1q/kA=;
        b=AFgS2xp5plyOxEyu8JHh1oRPctrYMFTeOnWKyNvzJiRYhGyV0fMYdRKygeua4eQZlE
         1F3/PBnde4LS3dOWRvgFEHsDEzCa5I4qiTGzzw67O6MLhthqeoajLH1jiWH2bnDcJGBV
         T/AqnJYknOYYuQMH9pirwwAjxPy4Ua14c2wwX1dccIj+rwSS6FniDwgfRNa5L9UJJDCZ
         mWJO8L/aYaXKK+p4FXbPXv+lbtlrMS2RIvEXlIYmDhZOXrAKIheAPUZ4mjR/Lv+BvIQ3
         Y3hr1uFwWsJsdLJXbkn4xLXZKdzo65riDQBLGlXb86czLsCohxzeqAxPRyg6zTb/Ahsm
         Vvzg==
X-Forwarded-Encrypted: i=1; AKwUvBzu7styE2C7PHDnbY/diyQddmTnfIJoZEu8PYQ/jyMxV+TcJplfVWm4tEIlCbWZ5keHbTus@lists.linux.dev
X-Gm-Message-State: AFq9FYLKtgcVlheTj0KHSgnd3bnVQF5+1293kqdanWl/RhbPTpe/7vBh
	D84wzUvuoiv3Lre9mADFcdWD6AbbhMSWvcEp/wrqEUGcBFiEgueOkMgLQ/tzpBcjdEfBRe1tp6W
	O4bVrzgtY0GHe8GAUkFZy7v4gg1JapPkTmTrloIym8QWQNYMfKjAVGn/hhIodYjdt9O9VQppxJt
	3SEvXeOWLhllg4UsTJGYoy98kmqBNnfA==
X-Gm-Gg: AYBFou221c7D/oEVaJlpCXsknDcWgohcER1JPR7ta4PBn2x5vPiZpA4lfLQP44Zxo3D
	vgzSB8Fqjm0ixNHhswbKiCnN+JjQJU52QAh8dIj9rZpGwOP1HKuLXU2cZQsnNlLcSgUqd3zjql9
	I4YFBWZ8zbd4jSW154Dic81Z/JPA0F9wHChUYbvU1bIlW9G53Y779buyxU
X-Received: by 2002:a05:651c:2106:b0:3a7:812b:cec with SMTP id 38308e7fff4ca-3a9a2a7b138mr366721fa.0.1791319336825;
        Tue, 06 Oct 2026 13:42:16 -0700 (PDT)
X-Received: by 2002:a05:651c:2106:b0:3a7:812b:cec with SMTP id
 38308e7fff4ca-3a9a2a7b138mr366701fa.0.1791319336338; Tue, 06 Oct 2026
 13:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909112108.2281-1-yogeshgaur.83@gmail.com> <20261004051912.1045-1-yogeshgaur.83@gmail.com>
In-Reply-To: <20261004051912.1045-1-yogeshgaur.83@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 6 Oct 2026 16:42:05 -0400
X-Gm-Features: AclHuK9zRWsg9g2pZlcc1R4T_aayXvkIoFMFVaZS1a7QD2EKuiHEd0bOPe31Y_A
Message-ID: <CAK-6q+i9WbR0qTAzWPFHGvFQM-Lv0JJcu8rvt+_ZTBS7TSJMzg@mail.gmail.com>
Subject: Re: [PATCH v2] dlm: don't publish a lkb in ls_lkbxa before it has an rsb
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jjIajr9p4AHM9Y6mBiO-CR8hXjFnn38dDwVp19FvvYI_1791319337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 4, 2026 at 1:19=E2=80=AFAM Yogesh Gaur <yogeshgaur.83@gmail.com=
> wrote:
>
> _create_lkb() puts a new lkb into ls_lkbxa straight away, which is also
> what assigns its lkb_id, but the lkb only gets an rsb later, when
> request_lock(), receive_request(), dlm_recover_master_copy() or
> dlm_debug_add_lkb() call attach_lkb(). In between, find_lkb() hands the
> lkb out with lkb_resource still NULL, and its callers go straight for
> the rsb:
>
>         r =3D lkb->lkb_resource;
>
>         hold_rsb(r);
>         lock_rsb(r);
>
> For the userspace API the lkid is simply whatever was written to the
> misc device, so a lkid can be aimed at a lkb that another thread is
> still building, and hold_rsb() reads res_flags off NULL:
>
>   BUG: KASAN: null-ptr-deref in rsb_flag fs/dlm/dlm_internal.h:386 [inlin=
e]
>   BUG: KASAN: null-ptr-deref in hold_rsb fs/dlm/lock.c:334 [inline]
>   BUG: KASAN: null-ptr-deref in unlock_lock fs/dlm/lock.c:3333 [inline]
>   BUG: KASAN: null-ptr-deref in dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c=
:5956
>   Read of size 8 at addr 0000000000000050 by task syz.3.570/7893
>    rsb_flag fs/dlm/dlm_internal.h:386 [inline]
>    hold_rsb fs/dlm/lock.c:334 [inline]
>    unlock_lock fs/dlm/lock.c:3333 [inline]
>    dlm_user_unlock+0x2ab/0x690 fs/dlm/lock.c:5956
>    device_user_unlock+0x1ca/0x260 fs/dlm/user.c:321
>    device_write+0x905/0xed0 fs/dlm/user.c:590
>
> Make it impossible for ls_lkbxa to hold a lkb without an rsb instead of
> filtering such lkbs in find_lkb(). _create_lkb() now only reserves the
> lkb_id, by passing a NULL entry to xa_alloc(), so xa_load() returns NULL
> for it; attach_lkb() stores the lkb once lkb_resource is set. All four
> attach_lkb() callers hold the rsb lock, and nothing takes an rsb lock
> under ls_lkbxa_lock, so taking it there adds no new lock ordering.
>
> An lkb that never gets an rsb is still released by __put_lkb(), whose
> xa_erase() frees the reserved id as before, and detach_lkb() already
> copes with a NULL lkb_resource. The lkb_id is still assigned at create
> time, so it is available to tracing and to the caller as before.
>
> The xa_for_each() walks in lockspace.c skip reserved entries. For
> lockspace_busy() that means an lkb still between create and attach no
> longer makes the lockspace busy. That is the same as the request
> arriving just after the check, which can already happen; the caller
> holds a lockspace reference, which remove_lockspace() waits for.
>
> The unchecked r =3D lkb->lkb_resource goes back to the original DLM
> import, but an untrusted lkid only became possible once the userspace
> device interface was added, so that is the tag below.
>
> Fixes: 597d0cae0f99 ("[DLM] dlm: user locks")
> Reported-by: syzbot+da6dc573ce5e6624f505@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dda6dc573ce5e6624f505
> Suggested-by: Alexander Aring <aahringo@redhat.com>
> Assisted-by: LLM
>
> ---
> v2: Following review, stop ls_lkbxa from ever holding
>     a lkb without an rsb, rather than filtering such lkbs in find_lkb().
>     _create_lkb() now only reserves the id; attach_lkb() publishes the
>     lkb. Subject changed to match.
> v1: https://lore.kernel.org/all/20260909112108.2281-1-yogeshgaur.83@gmail=
.com/
>
> Not runtime-tested; syzbot has no reproducer for this report. Built
> with W=3D1.
>
> ---
>  fs/dlm/lock.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 2609e4fdeba8..2b7f3ff94310 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -1488,10 +1488,22 @@ void free_inactive_rsb(struct dlm_rsb *r)
>  /* Attaching/detaching lkb's from rsb's is for rsb reference counting.
>     The rsb must exist as long as any lkb's for it do. */
>
> +/*
> + * An lkb only becomes visible to find_lkb() here, once it has an rsb.
> + * _create_lkb() just reserves its lkb_id in ls_lkbxa.
> + */
>  static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
>  {
> +       struct dlm_ls *ls =3D r->res_ls;
> +       void *old;
> +
>         hold_rsb(r);
>         lkb->lkb_resource =3D r;
> +
> +       write_lock_bh(&ls->ls_lkbxa_lock);
> +       old =3D xa_store(&ls->ls_lkbxa, lkb->lkb_id, lkb, GFP_ATOMIC);
> +       write_unlock_bh(&ls->ls_lkbxa_lock);
> +       WARN_ON_ONCE(old);
>  }
>
>  static void detach_lkb(struct dlm_lkb *lkb)
> @@ -1525,8 +1537,9 @@ static int _create_lkb(struct dlm_ls *ls, struct dl=
m_lkb **lkb_ret,
>         INIT_LIST_HEAD(&lkb->lkb_ownqueue);
>         INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
>
> +       /* reserve the id only, attach_lkb() publishes the lkb */
>         write_lock_bh(&ls->ls_lkbxa_lock);
> -       rv =3D xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOM=
IC);
> +       rv =3D xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, NULL, limit, GFP_ATO=
MIC);

Now, all potential iterators need to check if there are reserved lkbs
(being NULL) in ls_lkbxa which makes it not better.

What I meant what ls_lkbxa should contain only valid lkbs (not
reserved as being NULL) that have a lkb_resource set up and not being
NULL. An lkb should always have an rsb.

- Alex

