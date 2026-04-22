Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8D4A23
	for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859841; cv=none; b=RJ0pBvi4K9GwNTBAvBEA5Dlo2F7Nhuu+JEJ0kO1FQ2rEvI1cBsPZOpdXgMO3FuhO3IpsTXKYFNz7PfXExcuXgSkjufAUU7cZbwSnbLPS1gceG6Ih8auF5bz4UZy4HjHWbem3BoPa7oaM7BKlhzX9/sqHR9c27GwEgAlS2pui7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859841; c=relaxed/simple;
	bh=KADdOErpPNuveLmLOPmTskuJjHNbSanIKSk3/rpNIwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3+Yh1U3yD3plPP+x1TsIRy/VyZatkv9xMtinx+ZfVugZsRW731RNyJnOnKZLn7iy+hiRD41AVXj+teOk6gr29JoYZ2XTHNzU+gHPNVMows8RawuxbBQl06HXKQ+yTJbKlcOc24us61WS2akduw79WORhCVop1mKB+/1IfjbNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRwiu9ux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRwiu9ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776859838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r01gzGSMZ1OLeEQHZP3Kp4fLk35M3tRbC7hGVAlZKo=;
	b=DRwiu9uxMi8tKZc7GCuiBU9pSB8RrUf/kBmMIrCe+CpvdupbKGvct8DwiiDAPKdP0ELUZj
	LcaP+UL8yml1wp1WjDOs20OYZ0Ka4k7BkWjQdtPbHHBlUb9GMbBOCamj2CVcaZGiRlHHdk
	5E1ZymWb/+Ni1vO3yNWg5klcL4r/QBs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-HXUU4V0IMaqgEmlxN_V1AA-1; Wed, 22 Apr 2026 08:10:36 -0400
X-MC-Unique: HXUU4V0IMaqgEmlxN_V1AA-1
X-Mimecast-MFC-AGG-ID: HXUU4V0IMaqgEmlxN_V1AA_1776859835
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24a00d12cso54783425ad.1
        for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859835; x=1777464635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0r01gzGSMZ1OLeEQHZP3Kp4fLk35M3tRbC7hGVAlZKo=;
        b=rHrmcNXiMndnxKC+NhKrvgP9dkP2CuIIZZ7QIFnQPe/r54HGiieHE+hVvTr5dvLNSp
         0SRPHdE+Qn2aWco0TacjMRATpoF9DvYieF+o4y1zJBrq8m5mbjY5KViSy6Z7aLjCtDO8
         /0AvqVwSmL37Qrz2x+yQLKZH6yzo8+tUyQH7wzizzu1XlMlXtR3lvrQNhS1XK70hbgcD
         CsNW5jo1Kf7jg9F/+Qmx1b+rh5ctvB2n4QKgNjuMk+/tJA5PRwhb0asKpzFHTY+n6qGx
         QqxMzP6iEhI+mkfX3cnUVnl7Lxa/x0Z3C5qaT8iWYaE8h0H7r3jnFOj0n1UbEheRBVEl
         oq+A==
X-Forwarded-Encrypted: i=1; AFNElJ+KYUVm6i8+KyvY9SfexCWJemxKQmTuUEi2wsM5mWNWbWYIeXJNHaBtQt8dcY870h1hl79e@lists.linux.dev
X-Gm-Message-State: AOJu0YzXDZH8MUD422kt2xS7S3XiQe85QShm4GzPrvSFbAP+b2vF//7S
	7niehN3CCAcQOchwSYLbXB2N1MCE4+le9W5wGgot7OHub3IsnrEjuf/Z0h5iqFOPcYtKYpQ2v6W
	DXO6mjAvmAvqpufMprt4YRJC8o30S2n/atRFSMIx7/HdLCWUvQ2QlFbOpImNdiqalP/rJwLnAAK
	qJQOYWd5GInkJM8/ccRElX3qixy1p8Zg==
X-Gm-Gg: AeBDiesbdNzQ3/A4r59LmC7/Yp3kjNdTT9rvILETC9Inb57SUGgBIqN3D+VCy5YZ40i
	CzOOBzxEhKtWwoPsQynS+6P3JRLEd7i/7FnGlL4qzai9Y3EmLVN3ESkcUbwJalTJrmEhtqLbrI4
	cKZEktxJZuaC13kum3CLWADBMI91rilkrICd5FGDfH8NC6856Qbnb2ZcQfLe8GMUJZXLp8vlwGA
	wfWQIS3BYqH9pCS1PCAIG4y+8o+i/fu7CytlYNJ+rTRvNgcMDh4kJiy/3TQOVWZ/n7FkzFRj+La
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id d9443c01a7336-2b5f9f83117mr164229585ad.37.1776859834822;
        Wed, 22 Apr 2026 05:10:34 -0700 (PDT)
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id
 d9443c01a7336-2b5f9f83117mr164229125ad.37.1776859834071; Wed, 22 Apr 2026
 05:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
 <20260421163207.48565-1-jie.wang@intel.com> <20260421163207.48565-2-jie.wang@intel.com>
In-Reply-To: <20260421163207.48565-2-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 22 Apr 2026 14:10:22 +0200
X-Gm-Features: AQROBzANUIDb16bJGw2lu_xPFN6pVbfoAM1FiM3YNu5k6u_48FuHomgFAE9Ikbk
Message-ID: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gfs2: fix quota init duplicate scan
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oiqkh_VnPoxJngsJLgY5AwWHbJHWT6rzSul9daIsIBA_1776859835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

this is looking good except for one minor detail (see below).

On Tue, Apr 21, 2026 at 10:44=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrot=
e:
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
>  fs/gfs2/quota.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..df1cb99c3344 100644
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
> @@ -1458,16 +1472,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                         spin_lock(&qd_lock);
>                         spin_lock_bucket(hash);
> -                       old_qd =3D gfs2_qd_search_bucket(hash, sdp, qc_id=
);
> +                       old_qd =3D gfs2_qd_search_bucket_noref(hash, sdp,=
 qc_id);
> +                       spin_unlock_bucket(hash);
>                         if (old_qd) {
>                                 fs_err(sdp, "Corruption found in quota_ch=
ange%u"
>                                             "file: duplicate identifier i=
n "
>                                             "slot %u\n",
>                                             sdp->sd_jdesc->jd_jid, slot);
>
> -                               spin_unlock_bucket(hash);

Why didn't you just leave this spin_unlock_bucket() call inside the if
statement?

>                                 spin_unlock(&qd_lock);
> -                               qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
>                                 kmem_cache_free(gfs2_quotad_cachep, qd);
> @@ -1483,6 +1496,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                         BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitma=
p));
>                         list_add(&qd->qd_list, &sdp->sd_quota_list);
>                         atomic_inc(&sdp->sd_quota_count);
> +                       spin_lock_bucket(hash);
>                         hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_tab=
le[hash]);
>                         spin_unlock_bucket(hash);
>                         spin_unlock(&qd_lock);
> --
> 2.34.1
>

Thanks,
Andreas

