Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD12ECD32
	for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929030; cv=none; b=TlJuXllMqF/k2WNonpY4/ypSxqhaQYxvWvBED8B0XxB2L9Dt/ov9EX0pZ51e5Xlf0tsKxmbfDYaVaI44dAoBJGMNihWPH80fvz8QOAQHFRZP+7YyJJbGK/qH8v5XE13sJjW7rwLAkP8tpZXC45TC1Lp8npxbsstlVmuHy7lN8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929030; c=relaxed/simple;
	bh=ltZGGpPSa0HhQECRftLDQ460uSs9j4JoAIdKxDd18xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndTsZvYWpfW7fPnuBrs/rsEtFnF13ANbKXgGuharReX0B9umarl6gs9xycl09XANmtB1D+5JASSFJUAh+VXQyJWzfdw+vSraa09WaHVBmC5LdLHZPtRwBZ55WJvu7cXCMNlnYUkElee/lwBOUQrO8ner+MUrTeCJDgfplvYKt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvCS6VSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvCS6VSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776929027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WabLTUulfk2gxS4+FSYtEJ/yqourTno2JhWtJJOQPck=;
	b=JvCS6VSpGnLhtR5g38dxOUBrGypSRGrse1W6uTCf/TY3RBQfa+fXtcBuKegDq5fmNDAUK7
	QxRvHgRO9SBoVal+5Ffvx1llPRxIo7oZMq33Ee/IfChBkre6iLBnNLpCgBuAqOlP8Ilz4Z
	TnFaab6FaZn+r6ZHWDLF+w+IeDG3kTI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-zEyrFskvPiSJTtQnXul6zw-1; Thu, 23 Apr 2026 03:23:45 -0400
X-MC-Unique: zEyrFskvPiSJTtQnXul6zw-1
X-Mimecast-MFC-AGG-ID: zEyrFskvPiSJTtQnXul6zw_1776929025
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79aa3a19ea3so110542187b3.0
        for <gfs2@lists.linux.dev>; Thu, 23 Apr 2026 00:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929025; x=1777533825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WabLTUulfk2gxS4+FSYtEJ/yqourTno2JhWtJJOQPck=;
        b=BQ/+3Rvwt2mVW0zWt3177g6/iUvr9iZXq4C8OLv3Mq/bQyZeuBS1a3eoRrOgjPxotf
         7Ir7chbJhEm7bBHCTjc6kX5+TpIOk5cTKCW1R0ACSPcpXOhNNmYKisWd3HvJL+3yoY36
         9XzL3G+cFsySxeCP81XeCcZ6J2O8m6sBXXJQWBkK70em9i2CL3hob5pWRJcQDNC+hs8U
         S2h8g3nr5KTwdYHyiKVGqFAgQga9Yu3q5sQO+2PNMftVDrlaH2bpzXfuFgw/Y5hiSTrZ
         0pmNjU0+yu8qUUkFIrcswtpmipyHkoKGByL9lfDYQT2QLW2GfJ1bNAGim5khUf7LY5lk
         8luA==
X-Forwarded-Encrypted: i=1; AFNElJ/v4GdeCfD5xXgxRpo4tvJiFgjtaZcEKag29RnBGchBbu1IdWrjjTb+9hmwIVXkJK+2PLtz@lists.linux.dev
X-Gm-Message-State: AOJu0YxiFG65tSf8dUIWYExk4R0hfTNcm1lExQ3+thATr4Rt/QxVKqr7
	t2k2cJvV5qJgRjq7VqRtrdsoTKfQUo6jH7WHngyTxVhWO7bis1PRNhnxdp0eYvJbaZ7tXzLfC2N
	KQf9uE5ehaH7mD+jwCY2QTdGGQjlwaxS6gHBY6oUC2TlerYE1BQo0lenVepAPTbhrHY4bkC2OQq
	8h+nzx+4Sg9to5L+8iahxtsHKvZdEcdA==
X-Gm-Gg: AeBDieuvD6s2ntiv1zC3nLvAKUY4K61vnZefmbBS0n5hz3jz7e3EiRmCEUUDtA5zgCw
	j7csQ4uZ5hInjK8dQ51gqhGg3C79pq9vRVJVda53hrIX3jz8WtnRIhmU8qpzILj2ZqiR/CN206b
	rNB8o39jQDJSQzare3afA3FI+zP/WNYRevUi+uF2kAeemeY1xW4CHmc96AoYVnYTghcjzHwIYnY
	HmmKgO6CvZOtlLWhd/UtHKa/wDoVn1HQCn7fbYyEcpKtTirPgTe77W2zC+w5FqoKVQIuz8uBruo
X-Received: by 2002:a05:690c:c4f1:b0:7ba:f6b4:3550 with SMTP id 00721157ae682-7baf6b43b80mr150284077b3.45.1776929024865;
        Thu, 23 Apr 2026 00:23:44 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:7ba:f6b4:3550 with SMTP id
 00721157ae682-7baf6b43b80mr150283857b3.45.1776929024334; Thu, 23 Apr 2026
 00:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
 <20260423133934.118970-1-jie.wang@intel.com>
In-Reply-To: <20260423133934.118970-1-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 23 Apr 2026 09:23:32 +0200
X-Gm-Features: AQROBzDbBcmEoeTHIEcuAp3NDqtCnbQ6TVIIR7Tik8-7O-p27QK_BYGe8WCpuOY
Message-ID: <CAHc6FU7DLZrunqxQkY35voRraBxUG=wNucn_3s7LqF1BdrxzCg@mail.gmail.com>
Subject: Re: [PATCH v3] gfs2: fix quota init duplicate scan
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ux5UIG4cvubCqvTQQ3EHFo2K3a3cc7WLwqxdkYOMan0_1776929025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 7:52=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrote=
:
> gfs2_quota_init() checks for duplicate quota_change IDs while holding
> qd_lock and the quota hash bucket bitlock. That path used
> gfs2_qd_search_bucket(), which takes a lockref reference via
> lockref_get_not_dead().
>
> On PREEMPT_RT this may sleep, which is not allowed under the bucket
> bitlock, triggering "sleeping function called from invalid context".
>
> Use a no-ref bucket lookup in this path, then continue duplicate
> handling without taking a lockref there.
>
> Refactor gfs2_qd_search_bucket() to build on top of the no-ref helper
> so lookup traversal stays in one place.
>
> This patch fixes a bug reported by syzbot.
>
> Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D642d0561f78362d67d3f
> Tested-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> ---
> v3:
> - Keep spin_unlock_bucket(hash) in the if (old_qd) path.
> - Drop the extra spin_lock_bucket(hash) before insertion.
>
>  fs/gfs2/quota.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..934397248fe7 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -254,9 +254,13 @@ static struct gfs2_quota_data *qd_alloc(unsigned has=
h, struct gfs2_sbd *sdp, str
>         return NULL;
>  }
>
> -static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
> -                                                    const struct gfs2_sb=
d *sdp,
> -                                                    struct kqid qid)
> +/*
> + * Lookup variant for callers which already hold qd_lock + bucket lock.
> + */
> +static struct gfs2_quota_data *
> +gfs2_qd_search_bucket_noref(unsigned int hash,
> +                           const struct gfs2_sbd *sdp,
> +                           struct kqid qid)
>  {
>         struct gfs2_quota_data *qd;
>         struct hlist_bl_node *h;
> @@ -264,12 +268,22 @@ static struct gfs2_quota_data *gfs2_qd_search_bucke=
t(unsigned int hash,
>         hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist=
) {
>                 if (!qid_eq(qd->qd_id, qid))
>                         continue;
> -               if (qd->qd_sbd !=3D sdp)
> -                       continue;
> -               if (lockref_get_not_dead(&qd->qd_lockref)) {
> -                       list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
> +               if (qd->qd_sbd =3D=3D sdp)
>                         return qd;
> -               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct gfs2_quota_data *
> +gfs2_qd_search_bucket(unsigned int hash, const struct gfs2_sbd *sdp, str=
uct kqid qid)
> +{
> +       struct gfs2_quota_data *qd;
> +
> +       qd =3D gfs2_qd_search_bucket_noref(hash, sdp, qid);
> +       if (qd && lockref_get_not_dead(&qd->qd_lockref)) {
> +               list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
> +               return qd;
>         }
>
>         return NULL;
> @@ -1458,7 +1472,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                         spin_lock(&qd_lock);
>                         spin_lock_bucket(hash);
> -                       old_qd =3D gfs2_qd_search_bucket(hash, sdp, qc_id=
);
> +                       old_qd =3D gfs2_qd_search_bucket_noref(hash, sdp,=
 qc_id);
>                         if (old_qd) {
>                                 fs_err(sdp, "Corruption found in quota_ch=
ange%u"
>                                             "file: duplicate identifier i=
n "
> @@ -1467,7 +1481,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                                 spin_unlock_bucket(hash);
>                                 spin_unlock(&qd_lock);
> -                               qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
>                                 kmem_cache_free(gfs2_quotad_cachep, qd);
> --
> 2.34.1
>

Thanks, I'll add this.

Andreas

