Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F56311956
	for <gfs2@lists.linux.dev>; Mon, 11 May 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511988; cv=none; b=oakYUOm/Bmx9ldvdl58rSLhLUonMmFK7DmN9Ffip/ri/nV+8QKkrbpWqfEtQod7/KxoWTwgjdJt5L/udBqnq3h5o9lbBHaTrd9wIs+YtIAO7C+O1c1xE4FodldRXnSBlZiezSGb+By4qE2/XP3KSm+flfyeh1vWRSQjlUs1L9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511988; c=relaxed/simple;
	bh=brx2KU/wiL/+yEW1kVqcUcRlwslsylQYZPQHGPmw6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fig8RWNx/KPV/KPutKA71+3W+TkCh+x7s8iS2aX7eLbqVHv4MfXJ8/QUBup6EAB/656/qIlWnTpxOpD7Gc2lVk2CITosQ0/h9h/+5fznsHE4U3kGstt8PRP8Jb0v2dmeDpZTJE9cO/tP7U4ftjGHMbNVd6eZrx04AgGeV9ThtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKguzuCM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKguzuCM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e5624c053so2502593f8f.2
        for <gfs2@lists.linux.dev>; Mon, 11 May 2026 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511985; x=1779116785; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34xvstp0JQmDP7OVPMLpiQZ8QCDJwr5lw4b5Z1m4HQA=;
        b=qKguzuCM2ppHqQ4QCE3oE2lHs8PfIGqdZ0CcsHI6ZtwzCqejGyT4u8QdBkOzfuNBOW
         VFL2KTV+5wpyVRg5bfiqaatLXOkQs526/uwOAJYz5ALeao43E6XDkNq6/wbyVl6+GKtj
         AVx94j2NpHKc4HRCx/CMqU1UNMbv/lcyt6UoNKST6JtfYa6xzE4oEZj9YQZnrcCTsPIW
         5n/4YkLYQfKMZjan3AesS9V9RDWQxqe8nWK2eIxCumCuAbRFXRjBCqPQdmvTyRXro+Vn
         /Rvv36b+SmgvdjwT/XKuIlUfXvwJUKu7atO4U/sqxxGsf7Fl4BID9KrXPfDsPZBaasZ/
         G/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511985; x=1779116785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34xvstp0JQmDP7OVPMLpiQZ8QCDJwr5lw4b5Z1m4HQA=;
        b=FOM7wB9QyFRLMtEg10femyaoCW1pJTeyPk8t7lTzJa0eVNBJEsO1lhyiY8F5jVQm09
         2hB+y2FhYrPpQsTvH47xioAfoG4mCTFpYVRRbWGeDL46vI/KuceiX5Eo46WgAhgqJDpc
         lsbcnwGP2dI+7UcTRw3xAalPj9nWjCqY3FOjn3ThJGJQWbbwuAClJNiDsWeMM/LwnURf
         Wm1eq/gNyoVdLcEVR5AafJao8eVe9W68EJcv7DfGVM7eq1kJ9EUNBqC4EFh4viXn/JTk
         9oOlKQTIqqTfFOFG1yMLuc6hWMWdxMo381KBEgwfddSFjCmyPbvyIkruz/EaOb4gyETu
         wLJw==
X-Forwarded-Encrypted: i=1; AFNElJ9PfZPQdKDEl2daz/jUzCR1TZRnr35ZSmC2/liO0gfiANQsrdLmbxNgmjCnjfvB2XXmP7lD@lists.linux.dev
X-Gm-Message-State: AOJu0YzMk0neIOiKRWh3Gzdi1BlxMXMDrTEgEqGLacDuOPZVKUjimDN1
	x5AB03twCt1rBVM/8WYJknKgDy/UW3OODZJnnE5nlkb7oaY2/cH+dvA0
X-Gm-Gg: Acq92OFS3M9M60xHzUfPytUbAkbVNUUq2wWUL6Urd48vfCH/wGcdrcYmhIM/019Bgjh
	uRlIOr/L1Unkvjh1sGhIq69UqSyxqyosHXaeay5X2SDYyAZ3D0npVPL4tQwBnQpgip8YPeErxo6
	0KNu9TIPx23YseqdHIpZCUsSfaE0lcp2bzdqRnRx5Ud4TSokRB8CDYWvdpBcoGr/dZi0zq4D8LM
	a/ZyxabHsXcjUPEgScRUTh4VcgAbAkiHkQAKGJsDQtYPLNeXGJY0msg1O4+1uZYN0Cs43L2kAci
	jXBhSOa1wlq+gcio7EXyu+qw5OPmg7dYwqPo7ddz4OHcLYcOVNgECnH4tnqq5R1RqSZBkYgYer7
	r7QFwHly4yPzDRQhweFfm2xQqh7zDb2R8iUvuOxTv6mAWhdakrG4NdbD4u9td6aj9NYlUzZh/g0
	elw5nMpdCFZwdLkPQb5H/ALSVqJ7HRJls/6wG4lIjovRjn0TUs
X-Received: by 2002:a5d:54c9:0:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-4515b525080mr27913475f8f.16.1778511984482;
        Mon, 11 May 2026 08:06:24 -0700 (PDT)
Received: from alessandro-pc.station ([2a01:827:18f0:5400:54d6:8261:974:e7b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm25720099f8f.9.2026.05.11.08.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:06:23 -0700 (PDT)
Date: Mon, 11 May 2026 17:06:20 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: gfs2: fix sleeping function called from invalid
 context
Message-ID: <o3jsp54o4n6v7qokxdg3rrvthrz37gqmmgc4fzbnfc36iv6ehw@iwsgmnh5i7tx>
References: <20260429081516.566812-1-alessandro.zanni87@gmail.com>
 <CAHc6FU7ciE1yUDxM0RaksAEHf8S1msBGxN0qcmSy+Z7kBjyQPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7ciE1yUDxM0RaksAEHf8S1msBGxN0qcmSy+Z7kBjyQPw@mail.gmail.com>

On Mon, May 04, 2026 at 01:27:12PM +0200, Andreas Gruenbacher wrote:
> Alessandro,
> 
> On Wed, Apr 29, 2026 at 10:15 AM Alessandro Zanni
> <alessandro.zanni87@gmail.com> wrote:
> > The issue arises on a PREEMPT kernel because gfs2_quota_init
> > calls gfs2_qd_search_bucket while holding a bit spinlock and
> > triggering a "sleeping function called from invalid context"
> > bug.
> >
> > This patch refactors the quota initialization by splitting the
> > lock into separate locks, moving the search outside the atomic
> > section and using RCU lock for a safe access without holding the
> > bit spinlock.
> >
> > Modifications of this patch:
> > 1. Use rcu_read_lock() around the invocation of the function
> >    gfs2_qd_search_bucket() for the search.
> > 2. Add the spin_lock() around the insertion into the hash table
> >    and lists.
> > 3. Remove the usage of unused spin_unlock().
> 
> How is this better than Jie Wang's fix from April 23?
> 
> https://lore.kernel.org/gfs2/CAHc6FU7DLZrunqxQkY35voRraBxUG=wNucn_3s7LqF1BdrxzCg@mail.gmail.com/T/#m37764558ab05e4166ad27abf85576cd67957cbfb
> 
> I've had Jie Wang's fix applied already, and I've now also updated for-next.
> 
> > Fixes: de0d95c26c41c ("gfs2: Check quota consistency on mount")
> > Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=642d0561f78362d67d3f
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  fs/gfs2/quota.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> > index 5290865f27f1..48516cbc8b49 100644
> > --- a/fs/gfs2/quota.c
> > +++ b/fs/gfs2/quota.c
> > @@ -1456,17 +1456,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
> >                         qd->qd_slot = slot;
> >                         qd->qd_slot_ref = 1;
> >
> > -                       spin_lock(&qd_lock);
> > -                       spin_lock_bucket(hash);
> > +                       rcu_read_lock();
> >                         old_qd = gfs2_qd_search_bucket(hash, sdp, qc_id);
> > +                       rcu_read_unlock();
> >                         if (old_qd) {
> >                                 fs_err(sdp, "Corruption found in quota_change%u"
> >                                             "file: duplicate identifier in "
> >                                             "slot %u\n",
> >                                             sdp->sd_jdesc->jd_jid, slot);
> >
> > -                               spin_unlock_bucket(hash);
> > -                               spin_unlock(&qd_lock);
> >                                 qd_put(old_qd);
> >
> >                                 gfs2_glock_put(qd->qd_gl);
> > @@ -1480,6 +1478,8 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
> >
> >                                 continue;
> >                         }
> > +                       spin_lock(&qd_lock);
> > +                       spin_lock_bucket(hash);
> >                         BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitmap));
> >                         list_add(&qd->qd_list, &sdp->sd_quota_list);
> >                         atomic_inc(&sdp->sd_quota_count);
> > --
> > 2.47.3
> >
> 
> Thanks,
> Andreas
>

Sorry for the delay.

This patch seems already ok to me because it maintains atomicity with search and
insertion within the same critical section, bypassing the PREEMPT_RT sleep bug by
avoiding the lockref call while holding the bit-spinlock.

So, ignore mine.

Regards,
Alessandro
