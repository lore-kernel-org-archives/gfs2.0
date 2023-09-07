Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086063A3
	for <gfs2@lists.linux.dev>; Thu,  7 Sep 2023 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694123959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mri6beWiID4asbPWRQrPQjNokn8SfJnHK3M3UNS2qjc=;
	b=MTWLWl5eCp7qprsU6f/Np+WgnopL2zXM0cQlBST3aAsvpfFhzTMGQA4ou1L4Ls7wJ/vfKE
	IQ2TZFU82VtTOkX12PzkWQ9113FvakqTpEPfW3RU1ZCliYRUtK8macf+t1EIm9x5cGRtQs
	feySM1i5M7SYIMN0gc6qXXu6DfLk84g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Lj9yN47zPdSvs8MT8uL00g-1; Thu, 07 Sep 2023 17:59:17 -0400
X-MC-Unique: Lj9yN47zPdSvs8MT8uL00g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1c09c1fd0abso20114025ad.2
        for <gfs2@lists.linux.dev>; Thu, 07 Sep 2023 14:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694123956; x=1694728756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mri6beWiID4asbPWRQrPQjNokn8SfJnHK3M3UNS2qjc=;
        b=ahGUid0oqnOtSOXKBCJJwInWMjyS56FxfXwSxWuM1BRMcSusqY8obaUb6CN4jsys8u
         DB2Hf5eoojCXcaVPXyPUyw5S67Glh+OwrulPXSE31BwQ5LmTAjX1cTczx6gIX1CdMWdj
         ZEIoKcpGykU4Vpt1JkrXA6W2046XpHi2dqHDg9jObaKHsR2e1rluGkv1Iw+MpnHrOAnz
         qldI6gb8sWADx8OniLFTRqe7RXVEIbIawuAYFDo8EeTBOs9zqTKKJb1forskt91RHRGy
         SaZgdSCtVUFj25MtdbJNRh/pOJYwkTmLPxjJU707b87cCtrtn3fAx9qo9cudnsZr2VYh
         LF4g==
X-Gm-Message-State: AOJu0Yyr4C8p8oUJM/t+IP7GYyU70wx97CeI70hOCUPjH+war0bdaEbW
	229UTmR2Uj9lesG5T1idIbO1Nxs7zaXaw/F6icrAAqVFx2hqQ++w/S3FhSDpsvKrZgkYtoIlnH+
	3XGdvtsyPV0Udmas83CMigCUD4TSMoA==
X-Received: by 2002:a17:902:d48c:b0:1c0:d7a8:a43e with SMTP id c12-20020a170902d48c00b001c0d7a8a43emr964817plg.53.1694123956196;
        Thu, 07 Sep 2023 14:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrU/A9ZzaS6yi2+Of4m/F7LXROvto+rKs08j3Jr5DgLGV+As8IFwkcuIeTZNSLAUETqDTsjAazkbywRuetP/U=
X-Received: by 2002:a17:902:d48c:b0:1c0:d7a8:a43e with SMTP id
 c12-20020a170902d48c00b001c0d7a8a43emr964808plg.53.1694123955857; Thu, 07 Sep
 2023 14:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230907150025.685598-1-rpeterso@redhat.com>
In-Reply-To: <20230907150025.685598-1-rpeterso@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 7 Sep 2023 23:59:03 +0200
Message-ID: <CAHc6FU4bfFB8GOECBysLtJNQZQkY1RJdqTAXOZYotwUwXzoOZg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: glock shrinker reform
To: Bob Peterson <rpeterso@redhat.com>
Cc: gfs2 <gfs2@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 5:09=E2=80=AFPM Bob Peterson <rpeterso@redhat.com> w=
rote:
> Before this patch the gfs2 glock shrinker had several problems. Inode
> glocks would often be put onto the LRU with a reference count of 2,
> in the EX state, until a demote request came in from another node.

What are those references being held for?

> When the shrinker called count_objects, gfs2_glock_shrink_count returned
> the number of glocks on the LRU, which is wrong. According to shrinker.h
> it should return "value for the number of freeable objects" but not all
> of glocks on the LRU are freeable.
>
> The shrinker itself only freed glocks if the reference count was zero.
> But if the reference count ever got to zero, __gfs2_glock_put would have
> already removed them from the LRU and freed them (via lm_put_lock).

So apparently this means being in the cache counts as one reference.
That doesn't seem to be documented.

> The net result is that, under memory pressure, the vfs shrinker asked
> gfs2 how many glocks were eligible to be freed, and it responded "All of
> them on the LRU." But when it tried to free them, the reference counts
> were 1 or 2, so none were freed. Since none were freed, the vfs shrinker
> would repeatedly call the gfs2 shrinker hundreds or thousands of times,
> none of which did any real work.
>
> This patch changes gfs2_scan_glock_lru so glocks are counted as freeable
> if their reference count is <=3D 2 AND if they are in the Unlocked state
> or can be demoted. A parameter was added to indicate whether the
> eligible glocks should be freed or merely counted.

This looks highly suspicious and either not thought through, or
severely lacking in documentation. What sense does it make to try
disposing of a glock that's still referenced?

Once that is fixed, we can make sure we're always holding a reference
on the sd_jindex and sd_rindex glocks throughout, and the go_demote_ok
glock operation can be removed.

Can this code be changed to manage the LRU in a more sensible way, by
only putting objects on the LRU when they can actually be disposed of?

With this patch, the value of lru_count isn't ever looked at, so the
counter is now useless.

Thanks,
Andreas

> The gfs2_glock_shrink_count function then calls it with false, and if
> none are returned, returns SHRINK_EMPTY as per the shrinker requirements.
> The gfs2_glock_shrink_scan calls it with true, and frees any that
> qualify.
>
> Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> ---
>  fs/gfs2/glock.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 9cbf8d98489a..f31c2e040595 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1990,17 +1990,18 @@ __acquires(&lru_lock)
>  /**
>   * gfs2_scan_glock_lru - Scan the LRU looking for locks to demote
>   * @nr: The number of entries to scan
> + * @do_free: if true, eligible glocks are freed, if false, they are coun=
ted.
>   *
>   * This function selects the entries on the LRU which are able to
>   * be demoted, and then kicks off the process by calling
>   * gfs2_dispose_glock_lru() above.
>   */
>
> -static long gfs2_scan_glock_lru(int nr)
> +static long gfs2_scan_glock_lru(int nr, bool do_free)
>  {
>         struct gfs2_glock *gl, *next;
>         LIST_HEAD(dispose);
> -       long freed =3D 0;
> +       long freeable =3D 0;
>
>         spin_lock(&lru_lock);
>         list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
> @@ -2010,10 +2011,14 @@ static long gfs2_scan_glock_lru(int nr)
>                 if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
>                         if (!spin_trylock(&gl->gl_lockref.lock))
>                                 continue;
> -                       if (!gl->gl_lockref.count) {
> -                               list_move(&gl->gl_lru, &dispose);
> -                               atomic_dec(&lru_count);
> -                               freed++;
> +                       if (gl->gl_lockref.count <=3D 2 &&
> +                           (gl->gl_state =3D=3D LM_ST_UNLOCKED ||
> +                            demote_ok(gl))) {
> +                               if (do_free) {
> +                                       list_move(&gl->gl_lru, &dispose);
> +                                       atomic_dec(&lru_count);
> +                               }
> +                               freeable++;
>                         }
>                         spin_unlock(&gl->gl_lockref.lock);
>                 }
> @@ -2022,7 +2027,7 @@ static long gfs2_scan_glock_lru(int nr)
>                 gfs2_dispose_glock_lru(&dispose);
>         spin_unlock(&lru_lock);
>
> -       return freed;
> +       return freeable;
>  }
>
>  static unsigned long gfs2_glock_shrink_scan(struct shrinker *shrink,
> @@ -2030,13 +2035,15 @@ static unsigned long gfs2_glock_shrink_scan(struc=
t shrinker *shrink,
>  {
>         if (!(sc->gfp_mask & __GFP_FS))
>                 return SHRINK_STOP;
> -       return gfs2_scan_glock_lru(sc->nr_to_scan);
> +       return gfs2_scan_glock_lru(sc->nr_to_scan, true);
>  }
>
>  static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
>                                              struct shrink_control *sc)
>  {
> -       return vfs_pressure_ratio(atomic_read(&lru_count));
> +       long freeable =3D gfs2_scan_glock_lru(INT_MAX, false);
> +
> +       return freeable ? vfs_pressure_ratio(freeable) : SHRINK_EMPTY;
>  }
>
>  static struct shrinker glock_shrinker =3D {
> --
> 2.41.0
>
>

