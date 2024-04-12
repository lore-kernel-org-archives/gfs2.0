Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058B446BD
	for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949868; cv=none; b=MXNxVIdYFF290ZWlX5H5kzBpWrzlcxgbKRX6Xm1OGIol142+jd5kXByTin2+dZonor/2TxgDeCWRISQ2Cl5uhpGnmvjpdxuvjHqoMOsv6N6hNchVG4C+Z3bcePlfRWGEF/TK35QfaSAKQuvPmOkS1OVpPnWg8DTVNSy6uHOyj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949868; c=relaxed/simple;
	bh=vm9UzXIHLkkJI/7uzKAAiHDWW7ha8HSQR56J22ROg/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGAR4orPU4Tspi9KeVpB+D+4qFBZqxi0Hr4NijbGz5++sYUvxBvCDt9agMhEBrvbt1HH3I3qixfY3E1S8SjM3OiW1PPo9GF23fxJ8K85Npb8sEiaZNM35wPRzgo9uXRecqjcDA8WUmIoU2lk1a7AlBX2RYLSj9zrQY1o5ilJns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEKHl91W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEKHl91W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712949866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40wnd0ns5Cn1V+lkxsqKsd6oiolToRzE4MZK/aSgzvQ=;
	b=IEKHl91W8D6agaEcLqS99VrRDehGlVBUkVO32w20b7DA09qiMAhfOsAeyx2Y2SFOYVcrIk
	X5AhSn6m921eEjh1L1M7Oj7lHXqfIYq/Xjj9869qcG309D5Wk0DaL/VjRT3+mCgyU5be7B
	5pUR9CfNol6zLQJG4hGSbExaIS3Roiw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-u9s44B_fNu6NZkQvjkJMMg-1; Fri, 12 Apr 2024 15:24:24 -0400
X-MC-Unique: u9s44B_fNu6NZkQvjkJMMg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d8a1f8c17fso12048721fa.3
        for <gfs2@lists.linux.dev>; Fri, 12 Apr 2024 12:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949862; x=1713554662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40wnd0ns5Cn1V+lkxsqKsd6oiolToRzE4MZK/aSgzvQ=;
        b=jIWDkGfmglhcuiyj1rtFkVtEFY3tTngvwtQKEYuH1YIaWFb7/TKfy59K8gW6tE1/qy
         p6W1rR2DHWtte4tFG+5Y8yl0YXfbINeCU/eVeWNg+nroRMHKozb3ClYBcRY2uEqjiDYo
         Vu/X0C6m7nhsEQvhzY7b2mOQSiT8w4grRsnTbKTg9phU2G0UsnfyKwWcwum9WG4rQZD1
         dkMLvtjAbMrV1jE7pcSxKJm8Wjt26KsIwTUPVLfEOAUUPuJNXBQDHBvabOusMPLVG/mo
         Cq1SaqfOkM6FhWGJ7rrDlSx5E8JHXaCiwZS1GM0EEiMmyras45f7OLfVNPUfOVuUbius
         ZdhA==
X-Gm-Message-State: AOJu0Yx8YJxVC6wN4O2DZ42ME0b/AsL8iHBHhxRUWsidYFqW8VFBlK/n
	zzjfsvOrBdWz4SQK0HrJ7SUljpqPjgh2Lc6tUhO8Ua3I43jrUEWNj+MazvjOnALRNwYkZRvOO3I
	22NAOTs2ORrCpDlyo+4E7zmXRcR7dU8eqSMLeM6IO+JHkSnzH7gAlCfqX8qrUBytZQJEZOm8ml2
	efRgy3WbzVQfwx6pb9xG3vaXVSRfrXIDGHNw==
X-Received: by 2002:a2e:9d03:0:b0:2d8:bda5:c5f5 with SMTP id t3-20020a2e9d03000000b002d8bda5c5f5mr2868921lji.35.1712949862494;
        Fri, 12 Apr 2024 12:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz7REzfSETP2faPkFCeoMzoxtJGGufPbaORodVs4JPB8I/Dn0Yxf/G3d+Uinf+ueJb0NkZzQ1qRnRbN26uJ24=
X-Received: by 2002:a2e:9d03:0:b0:2d8:bda5:c5f5 with SMTP id
 t3-20020a2e9d03000000b002d8bda5c5f5mr2868907lji.35.1712949862034; Fri, 12 Apr
 2024 12:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412134314.173067-1-aahringo@redhat.com> <20240412134314.173067-9-aahringo@redhat.com>
 <CAK-6q+h2Fbzh_9=gsX8rq4fXoCA8T6jAWHz0ywymaNVoSeiweA@mail.gmail.com>
In-Reply-To: <CAK-6q+h2Fbzh_9=gsX8rq4fXoCA8T6jAWHz0ywymaNVoSeiweA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 12 Apr 2024 15:24:11 -0400
Message-ID: <CAK-6q+gvgB+R2wv_Jhj_XQi1WXwh2_hSA8BGEFX94vqb8CVDWA@mail.gmail.com>
Subject: Re: [PATCH dlm/next 8/9] dlm: likely read lock path for rsb lookup
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 10:53=E2=80=AFAM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Fri, Apr 12, 2024 at 9:43=E2=80=AFAM Alexander Aring <aahringo@redhat.=
com> wrote:
> >
> > As the conversion to rhashtable introduced a hash lock per lockspace
> > instead of doing a per bucket hash, this patch will change the hash loc=
k
> > handling as holding only a read lock in a very likely hot path in DLM.
> >
> > This hot path is to lookup rsbs and they are in keep state. Keep state
> > means that the RSB_TOSS flag isn't set. If this likely read lock path i=
s
> > the case we don't need to hold the ls_rsbtbl_lock in write lock at all.
> > If it's on toss state holding the ls_rsbtbl_lock in write lock is
> > required. If we see that the rsb is in toss state, we hold the
> > ls_rsbtbl_lock in write state and relookup (because the rsb could get
> > removed into the transition from read to write state) and check if the
> > rsb is still in toss state. However this is an unlikely path as toss
> > rsbs are cached rsbs. Having the rsb in keep state is very likely.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/dlm/debug_fs.c     |   4 +-
> >  fs/dlm/dir.c          |   4 +-
> >  fs/dlm/dlm_internal.h |   2 +-
> >  fs/dlm/lock.c         | 269 ++++++++++++++++++++++++++++++------------
> >  fs/dlm/lockspace.c    |   2 +-
> >  fs/dlm/recover.c      |   4 +-
> >  fs/dlm/recoverd.c     |   8 +-
> >  7 files changed, 206 insertions(+), 87 deletions(-)
> >
> > diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
> > index 70567919f1b7..6ab3ed4074c6 100644
> > --- a/fs/dlm/debug_fs.c
> > +++ b/fs/dlm/debug_fs.c
> > @@ -413,7 +413,7 @@ static void *table_seq_start(struct seq_file *seq, =
loff_t *pos)
> >         else
> >                 list =3D &ls->ls_keep;
> >
> > -       spin_lock_bh(&ls->ls_rsbtbl_lock);
> > +       read_lock_bh(&ls->ls_rsbtbl_lock);
> >         return seq_list_start(list, *pos);
> >  }
> >
> > @@ -434,7 +434,7 @@ static void table_seq_stop(struct seq_file *seq, vo=
id *iter_ptr)
> >  {
> >         struct dlm_ls *ls =3D seq->private;
> >
> > -       spin_unlock_bh(&ls->ls_rsbtbl_lock);
> > +       read_unlock_bh(&ls->ls_rsbtbl_lock);
> >  }
> >
> >  static const struct seq_operations format1_seq_ops =3D {
> > diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
> > index 9687f908476b..b1ab0adbd9d0 100644
> > --- a/fs/dlm/dir.c
> > +++ b/fs/dlm/dir.c
> > @@ -200,9 +200,9 @@ static struct dlm_rsb *find_rsb_root(struct dlm_ls =
*ls, const char *name,
> >         struct dlm_rsb *r;
> >         int rv;
> >
> > -       spin_lock_bh(&ls->ls_rsbtbl_lock);
> > +       read_lock_bh(&ls->ls_rsbtbl_lock);
> >         rv =3D dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
> > -       spin_unlock_bh(&ls->ls_rsbtbl_lock);
> > +       read_unlock_bh(&ls->ls_rsbtbl_lock);
> >         if (!rv)
> >                 return r;
> >
> > diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> > index 98a0ac511bc8..b675bffb61ae 100644
> > --- a/fs/dlm/dlm_internal.h
> > +++ b/fs/dlm/dlm_internal.h
> > @@ -585,7 +585,7 @@ struct dlm_ls {
> >         spinlock_t              ls_lkbidr_spin;
> >
> >         struct rhashtable       ls_rsbtbl;
> > -       spinlock_t              ls_rsbtbl_lock;
> > +       rwlock_t                ls_rsbtbl_lock;
> >
> >         struct list_head        ls_toss;
> >         struct list_head        ls_keep;
> > diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> > index 419e7bdb3629..644f2b88f44a 100644
> > --- a/fs/dlm/lock.c
> > +++ b/fs/dlm/lock.c
> > @@ -342,15 +342,15 @@ void dlm_hold_rsb(struct dlm_rsb *r)
> >
> >  /* TODO move this to lib/refcount.c */
> >  static __must_check bool
> > -dlm_refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
> > +dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
> >  __cond_acquires(lock)
> >  {
> >         if (refcount_dec_not_one(r))
> >                 return false;
> >
> > -       spin_lock_bh(lock);
> > +       write_lock_bh(lock);
> >         if (!refcount_dec_and_test(r)) {
> > -               spin_unlock_bh(lock);
> > +               write_unlock_bh(lock);
> >                 return false;
> >         }
> >
> > @@ -358,11 +358,11 @@ __cond_acquires(lock)
> >  }
> >
> >  /* TODO move this to include/linux/kref.h */
> > -static inline int dlm_kref_put_lock_bh(struct kref *kref,
> > -                                      void (*release)(struct kref *kre=
f),
> > -                                      spinlock_t *lock)
> > +static inline int dlm_kref_put_write_lock_bh(struct kref *kref,
> > +                                            void (*release)(struct kre=
f *kref),
> > +                                            rwlock_t *lock)
> >  {
> > -       if (dlm_refcount_dec_and_lock_bh(&kref->refcount, lock)) {
> > +       if (dlm_refcount_dec_and_write_lock_bh(&kref->refcount, lock)) =
{
> >                 release(kref);
> >                 return 1;
> >         }
> > @@ -378,10 +378,10 @@ static void put_rsb(struct dlm_rsb *r)
> >         struct dlm_ls *ls =3D r->res_ls;
> >         int rv;
> >
> > -       rv =3D dlm_kref_put_lock_bh(&r->res_ref, toss_rsb,
> > -                                 &ls->ls_rsbtbl_lock);
> > +       rv =3D dlm_kref_put_write_lock_bh(&r->res_ref, toss_rsb,
> > +                                       &ls->ls_rsbtbl_lock);
> >         if (rv)
> > -               spin_unlock_bh(&ls->ls_rsbtbl_lock);
> > +               write_unlock_bh(&ls->ls_rsbtbl_lock);
> >  }
> >
> >  void dlm_put_rsb(struct dlm_rsb *r)
> > @@ -572,7 +572,7 @@ void dlm_rsb_toss_timer(struct timer_list *timer)
> >                  * lock, however this is only a trylock if we hit some
> >                  * possible contention we try it again.
> >                  */
> > -               rv =3D spin_trylock(&ls->ls_rsbtbl_lock);
> > +               rv =3D write_trylock(&ls->ls_rsbtbl_lock);
> >                 if (!rv) {
> >                         spin_unlock(&ls->ls_toss_q_lock);
> >                         /* rearm again try timer */
> > @@ -587,7 +587,7 @@ void dlm_rsb_toss_timer(struct timer_list *timer)
> >                 /* not necessary to held the ls_rsbtbl_lock when
> >                  * calling send_remove()
> >                  */
> > -               spin_unlock(&ls->ls_rsbtbl_lock);
> > +               write_unlock(&ls->ls_rsbtbl_lock);
> >
> >                 /* remove the rsb out of the toss queue its gone
> >                  * drom DLM now
> > @@ -671,16 +671,8 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, =
const void *name, int len,
> >
> >  static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
> >  {
> > -       int rv;
> > -
> > -       rv =3D rhashtable_insert_fast(rhash, &rsb->res_node,
> > -                                   dlm_rhash_rsb_params);
> > -       if (rv =3D=3D -EEXIST) {
> > -               log_print("%s match", __func__);
> > -               dlm_dump_rsb(rsb);
> > -       }
> > -
> > -       return rv;
> > +       return rhashtable_insert_fast(rhash, &rsb->res_node,
> > +                                     dlm_rhash_rsb_params);
> >  }
> >
> >  /*
> > @@ -775,24 +767,47 @@ static int find_rsb_dir(struct dlm_ls *ls, const =
void *name, int len,
> >                         goto out;
> >         }
> >
> > -       spin_lock_bh(&ls->ls_rsbtbl_lock);
> > + retry_lookup:
> >
> > +       /* check if the rsb is in keep state under read lock - likely p=
ath */
> > +       read_lock_bh(&ls->ls_rsbtbl_lock);
> >         error =3D dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
> > -       if (error)
> > +       if (error) {
> > +               read_unlock_bh(&ls->ls_rsbtbl_lock);
> >                 goto do_new;
> > +       }
> >
> >         /*
> >          * rsb is active, so we can't check master_nodeid without lock_=
rsb.
> >          */
> >
> > -       if (rsb_flag(r, RSB_TOSS))
> > +       if (rsb_flag(r, RSB_TOSS)) {
> > +               read_unlock_bh(&ls->ls_rsbtbl_lock);
> >                 goto do_toss;
> > +       }
> >
> >         kref_get(&r->res_ref);
> > -       goto out_unlock;
> > +       read_unlock_bh(&ls->ls_rsbtbl_lock);
> > +       goto out;
> >
> >
> >   do_toss:
> > +       write_lock_bh(&ls->ls_rsbtbl_lock);
> > +
>
> There might be improvements with rhashtable per bucket locks, but this
> is now simple to do and the most part it is in read lock only anyway.
> I need to think more about this because ls_toss/ls_keep list need to
> be addressed here because are associated if the rsb is still part of
> the hash.
>
> > +       /* retry lookup under write lock to see if its still in toss st=
ate
> > +        * if not it's in keep state and we relookup - unlikely path.
> > +        */
> > +       error =3D dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
>
> we don't need to do a lookup again, we only need to check if the rsb
> is still part of the hashtable, there is no other hashtable it can be
> part of.

We can't do that, because others removing the rsb from the hash during
the read_unlock() and write_lock() time will be freeing it and this
causes a use after free when we check if the rsb is still part of a
hash. We can prevent this case by holding the rcu read lock (without
introducing ref counters for toss rsbs again) and freeing the rsb with
call_rcu() but this might be something for later...

- Alex

