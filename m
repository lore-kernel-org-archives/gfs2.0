Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FB335C7
	for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340544; cv=none; b=ZMOn6ka76MJgAA5KqodWEOxYXa2KaSZVZmdAfKWwK97Ay2BqOp29jZKTmb7AdKZ3R84GzT3cTGTRxjRBcd/gnvrvnA70KTQ7TL0nf16PdN416xhEuwts7X0xEs7lYtK2vAcGCelOcs90Cop8pIsIt4plPAt1jk7OYNNNiRfFDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340544; c=relaxed/simple;
	bh=E1DPCW4Gx9/aSyymSd8OFy+RGj5UBxPnSgSJShXTFto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9r8naF0Y4w2d30OBKYh2rGIxRYu68JcUjtrsjOO0YEAkMe5xPcPkLz2Zs1xH0Kk82dPwBobcOo9pvRXfvEFr6O6LeG5QRm0bHZ1ol09mejJknq89i6ZE3T6YYCKd+D9exSJ9sVE4jsTdKPFlirFKoFes+apXK5PeSKbOpjIrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2VFyq2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2VFyq2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713340541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TrZSS8syHLojkCZPcAFaKvnI3+Dx6bA+yOiVPy0Xgg=;
	b=f2VFyq2rimzt8tJyfswdXwksZjM0QGuPWD2XXrgJB74B6zI7/wQgsFoJtztvEtJZN7ihML
	LOFOaQlcAxt7gMo8DznwM0mvTvhnLq2DxmJeg3Ev22IshORDksicAVgr0sQK09RqPW4Xp/
	GjCfbgTwN2j+FLXMWDya8cRKgqhS8R4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-iIygHhf1Nv64KEIuOtm3rw-1; Wed, 17 Apr 2024 03:55:40 -0400
X-MC-Unique: iIygHhf1Nv64KEIuOtm3rw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6efef492e79so2853662b3a.1
        for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 00:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713340537; x=1713945337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TrZSS8syHLojkCZPcAFaKvnI3+Dx6bA+yOiVPy0Xgg=;
        b=r8zsE+sClKY2X2KkAcqDgJ57oKwENbflbqMRtwli/JmzQ4N+gn6a4j/4B+VSLYTC2u
         IaCVCY21r3/PQs1tCOjQHJRDoZf6kEhV2pL6Y2SDWXjNvLDAcT3bzHqUaVpBAtXmOWQ5
         SUECopUBDey6dTb+ri0/s3Lk3ppxZrXf8bWRZ4LZG1Po3kwe4Vo1NxJtg5xqfKqiNHB1
         e4CQ++TComEogQaz9zpbj/120fV6zmWk20pWGucFihC/LTQq2mah5/qTh8raTm4tY/Yz
         92VNhWmjWsDagfKJ7XXsI4hieoDuQ5s/7qgX6ns5cgIRUUkDCC3OndaSfsJjkqYQy9RO
         OdEw==
X-Gm-Message-State: AOJu0YzKtHMGtfc54Yh0GORQ+qvAcfaKcWSKerARbv43whEQmF8mbmzW
	NYMT4AGpx+lDGLg1ALKwPbfLBDQ5d0IOrXDBeTlp4ckHO6+QYrueE8ZplBGF0+hXdn4bK0BYG/D
	9fWfAGKltJE+MeA9QTCrIDbdumt30Wit45VqaPr36k+W5AOU1BOPQj9wdCQCyFK9zMoAEFDbLOp
	vmWKS2qxAyhymd4jLhPNQ9vbHqbQVLmWMQ5Mmm
X-Received: by 2002:a05:6a20:978c:b0:1a7:502:23e8 with SMTP id hx12-20020a056a20978c00b001a7050223e8mr12959797pzc.35.1713340537617;
        Wed, 17 Apr 2024 00:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUblo/INvH8ITBs1w8xacy5HcUQQCsv8uHHRbqRFtBaKnE169jJKztKfDnMNE23mRJyX0fD9aB4Mp+fEsLTrs=
X-Received: by 2002:a05:6a20:978c:b0:1a7:502:23e8 with SMTP id
 hx12-20020a056a20978c00b001a7050223e8mr12959787pzc.35.1713340537249; Wed, 17
 Apr 2024 00:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240409164508.79570-1-agruenba@redhat.com> <20240409164508.79570-14-agruenba@redhat.com>
 <f1c9bcc3-475f-4b1c-8a0a-078c200d31e2@redhat.com>
In-Reply-To: <f1c9bcc3-475f-4b1c-8a0a-078c200d31e2@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 17 Apr 2024 09:55:25 +0200
Message-ID: <CAHc6FU69L8htb_GuedG2NEgzE76hLdvddKGYEVhUuvpxjiWXUQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] gfs2: Fix "Make glock lru list scanning safer"
To: Andrew Price <anprice@redhat.com>
Cc: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:56=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> On 09/04/2024 17:45, Andreas Gruenbacher wrote:
> > Commit 228804a35caa tried to add a refcount check to
> > gfs2_scan_glock_lru() to make sure that glocks that are still reference=
d
> > cannot be freed.  It failed to account for the bias state_change() adds
> > to the refcount for held glocks, so held glocks are no longer removed
> > from the glock cache, which can lead to out-of-memory problems.  Fix
> > that.  (The inodes those glocks are associated with do get shrunk and d=
o
> > get pushed out of memory.)
> >
> > In addition, use the same eligibility check in gfs2_scan_glock_lru() an=
d
> > gfs2_dispose_glock_lru().
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >   fs/gfs2/glock.c | 24 +++++++++++++-----------
> >   1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index 2882a42e88aa..04e0a8ac61d7 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -1987,6 +1987,14 @@ static int glock_cmp(void *priv, const struct li=
st_head *a,
> >       return 0;
> >   }
> >
> > +static bool can_free_glock(struct gfs2_glock *gl)
> > +{
> > +     bool held =3D gl->gl_state !=3D LM_ST_UNLOCKED;
> > +
> > +     return !test_bit(GLF_LOCK, &gl->gl_flags) &&
> > +            gl->gl_lockref.count =3D=3D held;
>
> Wouldn't this comparison go wrong when the lockref count is > 1? In any
> case it's unusual to see a lockref count being compared to a bool.

We could do something like the below, but the result is the same:

  int count =3D gl->gl_lockref.count;
  if (gl->gl_state !=3D LM_ST_UNLOCKED)
    count--;
  return !test_bit(GLF_LOCK, &gl->gl_flags) && count =3D=3D 0;

> Andy
>
> > +}
> > +
> >   /**
> >    * gfs2_dispose_glock_lru - Demote a list of glocks
> >    * @list: The list to dispose of
> > @@ -2020,7 +2028,7 @@ __acquires(&lru_lock)
> >                       atomic_inc(&lru_count);
> >                       continue;
> >               }
> > -             if (test_bit(GLF_LOCK, &gl->gl_flags)) {
> > +             if (!can_free_glock(gl)) {
> >                       spin_unlock(&gl->gl_lockref.lock);
> >                       goto add_back_to_lru;
> >               }
> > @@ -2052,16 +2060,10 @@ static long gfs2_scan_glock_lru(int nr)
> >       list_for_each_entry_safe(gl, next, &lru_list, gl_lru) {
> >               if (nr-- <=3D 0)
> >                       break;
> > -             /* Test for being demotable */
> > -             if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
> > -                     if (!spin_trylock(&gl->gl_lockref.lock))
> > -                             continue;
> > -                     if (!gl->gl_lockref.count) {
> > -                             list_move(&gl->gl_lru, &dispose);
> > -                             atomic_dec(&lru_count);
> > -                             freed++;
> > -                     }
> > -                     spin_unlock(&gl->gl_lockref.lock);
> > +             if (can_free_glock(gl)) {
> > +                     list_move(&gl->gl_lru, &dispose);
> > +                     atomic_dec(&lru_count);
> > +                     freed++;
> >               }
> >       }
> >       if (!list_empty(&dispose))
>

Thanks,
Andreas

