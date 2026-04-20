Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A2347BD7
	for <gfs2@lists.linux.dev>; Mon, 20 Apr 2026 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688574; cv=none; b=foVHcO7IQ1ENIhttiHFFokY7n50cZ6ykSCh+Th1Ly8oLekRQyL6QthAg6/mdmKH0fY+neEXvGMZq6vRI2x41gBtUod2NXnNC646DZ1/nYP5nBcI5PFrMEBvO61FTkRc34ic3rRFYs/6p9UnEMS+foKe3WamiYFCOiEmL8sJ6WUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688574; c=relaxed/simple;
	bh=qdOdMpqPdV68/NCdKCYjugQnD2JYid7Y38q+dR+KC+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNYwMfmSjb8aeUpwL1Dxb9QXBoNV8iN8YMUUzEQXMddm1kKiaOWBdSU3LsW0gOEWI31Al1UZcoujwnXhE1gTQ0tkD1S9jKTPSbpA/5h30N92vjBfmlMsc6v9TOjXu3LUYcFWx+8fqeQ+Jq6c428bDOQTZg/Rll5HqVDk5SYIiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZ+jpZAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ+jpZAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776688571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fx56vBuYKQtfBv6HqCiZTLNRB425mz1mOridRKnvUBg=;
	b=fZ+jpZAS8OOk8wLM53OQBnAVfxTHRsHCXcVurnRgPDC7+sWY3U0mrIqU7x0k+4IKZ2TNA2
	IKz8jwsbNzI2Ry0ljAFN1PWYuAiGU3G+PLml2HkLikjaQT4nCh6XOycEzFjqO2Qf8Ktcjd
	LJerZEhX69DJDn2rXAqlA8Vfc7FofMg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-RqFH1xnbOv2Z9m6l3stSxw-1; Mon, 20 Apr 2026 08:36:10 -0400
X-MC-Unique: RqFH1xnbOv2Z9m6l3stSxw-1
X-Mimecast-MFC-AGG-ID: RqFH1xnbOv2Z9m6l3stSxw_1776688569
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79a670a5fe9so67665037b3.1
        for <gfs2@lists.linux.dev>; Mon, 20 Apr 2026 05:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688569; x=1777293369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fx56vBuYKQtfBv6HqCiZTLNRB425mz1mOridRKnvUBg=;
        b=TOm+64FE0Z/5XheOGZjsQ3t9/jlweTDfP9F4FmZqVgKyU+75LftHp2uo4hsnENC6Z7
         XmgZqeyadIve5U2D+V1MvB+5RTAA7FfsfuSbPRgkQ3H0PeHeHlN9YdXC3qJ7IEQ7saw/
         0fYo5GuJ1fY/P9EGPZIn8nMA8a1v3sBc1R7Ld51CWXYZf6VB02kLliQ6+FO4Xp8RycV9
         2ZNTHeRNMocbEsR/mgHdTAjlfckTxpVI+9icG72SF8151B6wPzyLa0FD01+DZrjA8AUQ
         VP71LczQggdVt9FcggImM52OQ7/XgbCTfc1puOqme/tOOB2EjUHIEtacdz3v2N1YqGo+
         6ZEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9D8cPbfT6QR+JT5vqH6ngrGoaATGnYozPBdl72h5t5QSiUcDMtczK7ifRIPxlEqTAa0Gsw@lists.linux.dev
X-Gm-Message-State: AOJu0YxzdI1LtraU2++vXRQyUa9iyXhKNTEm1FqSG6lMqApCuLJXXXJ8
	cpT/4/d0Dpdp3Xgp7SFH6zciVhA+D5Ll4VVrj/nF79m+RrhGff4ROHoA0FL6jN63KullAYyclOn
	egr+SI3VUrmT6yTkBdrijCauFHPP1PNWgmUI8Zg6wIDhhhj/qaP8X13Je9QpIhC5MxNWPrRMbek
	hZnPWhrTkgVUso+mFSMz5RJ7cb0CvxMg==
X-Gm-Gg: AeBDieu11oT9rWHuTflG0G5Il8BPfV7ylSzyzIp4LsZ9HlKlN971pXD1AhdUi+XDr/m
	8mRyyhuXFC1qgD59rtN0JzimDNsUF+g+DBS9zzJb2PqpWMnYikEftnBiGPDc20uV38q07WOwfbD
	2LrogaQfv4ERV4EqmCptnhk3QlKzLjHQ1pa6mHWRAbKnSH8DUi7idT+1kjEIxKHEi/fBGwCv7Gy
	/FfnBKzFC1TYdUAr+11aDXVxL4hcBhVAdtIO9t369NB4Q7mBqvj8MaOcA0VnpaY0QKPnvCTGqgj
X-Received: by 2002:a05:690c:8d14:b0:7b8:1c95:89f0 with SMTP id 00721157ae682-7bad58a2ec4mr85796117b3.47.1776688569309;
        Mon, 20 Apr 2026 05:36:09 -0700 (PDT)
X-Received: by 2002:a05:690c:8d14:b0:7b8:1c95:89f0 with SMTP id
 00721157ae682-7bad58a2ec4mr85795917b3.47.1776688568853; Mon, 20 Apr 2026
 05:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260420110622.9742-1-jie.wang@intel.com>
In-Reply-To: <20260420110622.9742-1-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 20 Apr 2026 14:35:57 +0200
X-Gm-Features: AQROBzDx7BJAHPFMNIEV1hF_F_MlBKhY-y9yO_-lVunwUHHXDv5S8M6R0JBm0mU
Message-ID: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix quota init duplicate scan
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	gfs2@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YXGMSiWt8Q9X3AJSly3Lg3jqfU_vVot3E3eOZro_vfc_1776688569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thank you for the patch.

On Mon, Apr 20, 2026 at 5:20=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrote=
:
> gfs2_quota_init() checks for duplicate quota_change IDs while holding
> qd_lock and the quota hash bucket bitlock. That path used
> gfs2_qd_search_bucket(), which takes a lockref reference
> via lockref_get_not_dead().
>
> On PREEMPT_RT this may sleep, which is not allowed under the bucket
> bitlock, triggering "sleeping function called from invalid context".
>
> Use a no-ref bucket lookup in this path, then continue duplicate handling
> without taking a lockref there.

That should work ... but with that, can you at least implement
gfs2_qd_search_bucket() on top of gfs2_qd_search_bucket_noref()? Or
better yet, convert qd_hash_table into an rhashtable, like
gl_hash_table already is? That should allow a normal ref taking lookup
even on PREEMPT_RT.

> Also save the current qc pointer before iterator advance, and clear that
> saved slot on duplicate so the correct on-disk entry is zeroed.

This needs to go into a separate patch. Also, why not put the 'qc++'
into the third expression of the surrounding for loop?

> This patch fixes a bug reported by syzbot.
>
> Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D642d0561f78362d67d3f
> Tested-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> ---
>  fs/gfs2/quota.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..0191ba211670 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -275,6 +275,25 @@ static struct gfs2_quota_data *gfs2_qd_search_bucket=
(unsigned int hash,
>         return NULL;
>  }
>
> +/*
> + * Lookup variant for callers which already hold qd_lock + bucket lock.
> + */
> +static struct gfs2_quota_data *
> +gfs2_qd_search_bucket_noref(unsigned int hash, const struct gfs2_sbd *sd=
p, struct kqid qid)
> +{
> +       struct gfs2_quota_data *qd;
> +       struct hlist_bl_node *h;
> +
> +       hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist=
) {
> +               if (!qid_eq(qd->qd_id, qid))
> +                       continue;
> +               if (qd->qd_sbd =3D=3D sdp)
> +                       return qd;
> +       }
> +
> +       return NULL;
> +}
> +
>
>  static int qd_get(struct gfs2_sbd *sdp, struct kqid qid,
>                   struct gfs2_quota_data **qdp)
> @@ -1435,6 +1454,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                 for (y =3D 0; y < sdp->sd_qc_per_block && slot < sdp->sd_=
quota_slots;
>                      y++, slot++) {
>                         struct gfs2_quota_data *old_qd, *qd;
> +                       struct gfs2_quota_change *dup_qc =3D qc;
>                         s64 qc_change =3D be64_to_cpu(qc->qc_change);
>                         u32 qc_flags =3D be32_to_cpu(qc->qc_flags);
>                         enum quota_type qtype =3D (qc_flags & GFS2_QCF_US=
ER) ?
> @@ -1458,23 +1478,22 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
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
>                                 spin_unlock(&qd_lock);
> -                               qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
>                                 kmem_cache_free(gfs2_quotad_cachep, qd);
>
>                                 /* zero out the duplicate slot */
>                                 lock_buffer(bh);
> -                               memset(qc, 0, sizeof(*qc));
> +                               memset(dup_qc, 0, sizeof(*dup_qc));
>                                 mark_buffer_dirty(bh);
>                                 unlock_buffer(bh);
>
> @@ -1483,6 +1502,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
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

