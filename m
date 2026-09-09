Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679F55C1A6
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959318; cv=pass; b=OTdDdKRPRav+NfHeuTnBzrlfEEclH708097kU631eFsJeFI14xIemI5O64S1yK9q9VMdiEOn/u9PwqreEED79lQyEskti5I8AQ/e/bAyFTeU0+YlZEKAj0oD5Q2bz51Xu1BKv6iE7OTEiVVUiu0MBd+HViLjwY0Ztqw4WO/ry3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959318; c=relaxed/simple;
	bh=ZfDt8S7Tc0KZXJPH2FTRtp7wfHfUNB5cPyGvFtf4FAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJF+77wfNkVoLZOaq0ktilJvkVL25ecGp2FmmPQ9x60vqrUniEwIqtydUKqao5/pMFELNzo9cc224OljooexWSv/qWMy91V3mvNXu/70LDaJ39QTt3LB82Vc/uSo9lfh89ene81CbX3a6co0hYmMw6LhRy4lwl1W0dEcQHeUClo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ovh1rSMP; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ovh1rSMP"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-878ed0f17bfso36089597b3.1
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 06:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788959315; cv=none;
        d=google.com; s=arc-20260327;
        b=DzbAyc3t71jXvsz72GTe/g2ThWa2wUXBKmI4x0DYbw4qTy3sQSlCMdZdvmhL6PSv2+
         Hk26zVI5/RIplsU9ghYWdupTLHQq7PdVB5ZH/mY6qS9X8VyhW4iyLXvtlNjf0bosjbVi
         DoJwl7T8OZhQzD3qbbFMiTKgOmOugcy+epEE0rxEr8e0/zFc/0WJUDRimzV9PoRCoEuo
         3SrbWgOM6oJKgR8UwGI7nTG39Jw0RLQr9N0W89by12F4wbjDVfZVtVmiQKGzMVyTA1Mj
         06sTXY1OMdQ3Sc4owr64i370NBWspoPycypCvgIb6SnnMi1YyIUd4rSLa9sBsQiFEj4P
         6EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        fh=ukMfcRFflLdgxKtap3Ime9z4JDMPksCNSUKhK9qzZhU=;
        b=hRpQUfMLvuAZRGcNhhiUIzfmeXMOzxe5sTRzIjz2IPhubMn9jAp/L0Yb8QGfCNttBe
         WkVtOXkXgyClu0C8htvalL7tOKMQaKrHWkXz9CCcda4NJYXvnxlbll39CIOKdC/BA0/k
         CD92fGoVjiBsQw4A4bB3HQj6kHpSruNN3VIWqPD5vPlAwngi7lOPeXcXh2QguZMBTpEj
         X2weah5UE1hkXGI+zkO6mms44p+KFUO9ldmZnn0b03O/kkya9TyA+MKZZL350HKwyMIO
         6h5iyO0agk6UKvYY5vRWBCAKITywEATJ/fSzLKBLHnBw8OqSR8DZbNIh+v8vkCaXgbCg
         swYA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788959315; x=1789564115; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        b=Ovh1rSMPA2oNAkAtONuqEh1BDnLwSRuEzmG4Pj5d/RgaCSOMuTLYxmQ8rbjOnQEOb8
         25OS8FhosjmoidfDN9ean2xwVvLVYLPmHi4meDVmx/YINpKQ2kBIpmx+ovNoDRT5e8dP
         9H0lrnPx2YZOkkBsgJEQslxO1JbbgO5yycyLVkVxm9zqT3Jlu7Yn1qvJzpR7n/6phTuE
         6lzSWxRbToL9s2nmQ6OA6pRtg4f2ayVe4qlMJChmGUDs4Wqmy8qqP00Ye7fWz6MKlDaz
         NbMpD2TnYUgwHqNEbIFdihWtuJqIUYvwZgludOr/KudcYq6fYzNj48sqvFtjXSUgWIOr
         s/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788959315; x=1789564115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnhkoTwgBT+xmQamF4svidVUoLvRUKP0o6WY6qmR4PQ=;
        b=Nv7SXBcHLq4vszhxy4DkR7Cd0RwrcWbfj+UsA9U4b173S2l1Uj+znKc9jhxeexwH0c
         7tUsW6oB/9an0fsoLb4p2aRYYvAyT3pm8lHZg78vR9PmIRFMsa6vEZ76M389yyUIAMuZ
         DHl9reSWhFicIuzy+/JlWaxGVzVatqAb86neqzIhfU3QEeXjoE7gFr5Bexx0aukLLD+2
         CIIt80YUfwaWQefWvMRj3W/N13OYh/Mh4BYzlkWNOV17A+FRhkuJ49a67BmPx0BeWVGk
         4eEJ7TL09CbQtPFx+8QGv4Mkcg4rM9PoqumQUiK130P2adIcZPSsZBlzWhUFVqwHczmu
         LN6Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3/3C4ZaR80rOSj1hB89t52EQFYTlgQhZGfjpgzB2Y77COsMcqKw9Zx1lO7htyyZD7WgbK@lists.linux.dev
X-Gm-Message-State: AFuF++knY+S13XE0XNSWCuq0lmKUh7rbtZf7IFBwaboZw0Jw0eieJeQw
	Y+nWpRJLHKXTu6Xr1jdTMkO74vxC8i66OtOrjFMXYLc+tJvhxNtqtsuLjiVVR8rpimX6fz6qHbo
	9DnTHY372bPs7UHMDNnOZKL4XVB6w11Yyks6VQR8P8w==
X-Gm-Gg: AYBFou1rtu7MQR5zuoT8FL5zqstrUp6HGy0MP4DDb2xdTDuBmkEMvYKjFglG+cZN7qU
	2WapT+b/1wchRHKZ+vzjVyLz1SENuANLZr53YyfjIibS7ThoO0QM9zA+7S/j4QPxKxYtlFzh9OF
	TjUZCKqNNkdM4p49K9cauuyykHGHDVcujVwC7VAHx7lC05fM7YeLwBAIP4875MXRxoZHtOWhXdb
	htfAl9ZEkJx1ojMY7PEnVzphEoMTpXftiIcnziRmQmRTnOJ2nUbxLKivKKfBn232o/QGZYpouZv
	oLZ7gbKi+OCC0Fl8+e0X56h0CQF1NPrIMBMTF5+hH0NjQpxMCiz+mRN5CA==
X-Received: by 2002:a05:690c:e64e:b0:870:7983:948a with SMTP id
 00721157ae682-8712259c772mr89107647b3.4.1788959314936; Wed, 09 Sep 2026
 06:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909090112.790006-1-sunjunchao@bytedance.com> <pblp6tof6t6otp5kzelc3pyu2y2si4e7i62kp63c5symdaqrd3@q7drqoro2b73>
In-Reply-To: <pblp6tof6t6otp5kzelc3pyu2y2si4e7i62kp63c5symdaqrd3@q7drqoro2b73>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Wed, 9 Sep 2026 21:08:23 +0800
X-Gm-Features: AcwNN1U41_g-qadIrai6fD3kTUCArV1yDblgph8PCD2WJC1KBtLwz2cU_4D4HKM
Message-ID: <CAHSKhteB4aK_EtuZOBsjN-tmyqS-ycGAP3gxMsdfU3pVAH+9JA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/7] fs: preserve superblock inode walk
 positions across lock drops
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	djwong@kernel.org, ebiggers@kernel.org, sandeen@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 09-09-26 17:01:05, Julian Sun wrote:
> > [Motivation]
> >
> > We observed hung tasks in production during disk hotplug operations. A
> > kernel thread spends a long time in evict_inodes() while holding s_umou=
nt,
> > blocking other users of that lock and causing further stalls.
> >
> > The problem is that evict_inodes() restarts its walk from the head of
> > sb->s_inodes every time it reschedules. When a large number of referenc=
ed
> > inodes remain near the head, each restart scans those inodes again with=
out
> > making progress through that part of the list. The repeated scans can
> > delay eviction long enough to trigger hung-task reports. This is the sa=
me
> > problem that [1] attempted to address.
>
> Thanks fro the patch! What's really unexpected is that there are many
> inodes with incremented refcount at the time when evict_inodes() is calle=
d.
> Did you have a look who's holding those references? Or is evict_inodes()
> called through the fs_bdev_mark_dead() call (as you mention "disk hotplug
> operations")? There the filesystem is in fact in use so what you describe
> makes some sense.

Yes, the filesystem was still in use, and the disk was unplugged
directly without being unmounted. As a result, `fs_bdev_mark_dead()`
holds the `s_umount` lock and performs a large number of redundant
traversals, which takes a significant amount of time.
>
>                                                                 Honza
>
> > [Approach]
> >
> > This series introduces sb_for_each_inodes() for two purposes:
> >
> >   1. Consolidate open-coded s_inodes walks behind a common entry point.
> >   2. Retain each walk's position across drops of s_inode_list_lock.
> >
> > The iterator mechanism follows the approach used by cgroup task iterati=
on,
> > such as css_task_iter_next(). Active iterators are registered on a sepa=
rate
> > list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
> > removal path advances any iterator whose next position points to that
> > inode. These updates are protected by s_inode_list_lock, so a walker ca=
n
> > drop the lock and later resume from its saved position.
> >
> > Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), alre=
ady
> > contain their own position-preserving logic: they carry an inode refere=
nce
> > across iterations so that they can resume after dropping the list lock.
> > Moving that responsibility into sb_for_each_inodes() simplifies these
> > callers and lets their callbacks focus on the per-inode work.
> >
> > Patch 1 removes trailing whitespace from include/linux/fs.h.
> > Patch 2 introduces sb_for_each_inodes().
> > The remaining patches convert existing walks to the new interface.
> > remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
> > walks are simple and do not require the inode->i_lock locking imposed
> > by the callback interface. Converting them would add an unnecessary
> > lock/unlock overhead for every inode.
> >
> > [Testing]
> >
> > I tested this series with approximately 20 hours of xfstests case
> > execution, repeatedly running the auto group on ext4 and XFS, no new
> > issues were observed. And with this patch applied, the hung task that
> > previously occurred on every run no longer occurs.
> >
> > [1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicl=
oud.com/
> >
> > Julian Sun (7):
> >   fs: remove trailing whitespace from include/linux/fs.h
> >   fs: introduce sb_for_each_inodes().
> >   block: use sb_for_each_inodes() in sync_bdevs()
> >   fs: use sb_for_each_inodes() API.
> >   gfs2: use sb_for_each_inodes() for cooperative eviction
> >   quota: use sb_for_each_inodes() in add_dquot_ref()
> >   landlock: use sb_for_each_inodes() when detaching a superblock
> >
> >  block/bdev.c                   |  85 +++++++++----------
> >  fs/drop_caches.c               |  44 +++++-----
> >  fs/gfs2/ops_fstype.c           |  38 ++++-----
> >  fs/inode.c                     | 142 +++++++++++++++++++++++--------
> >  fs/quota/dquot.c               |  72 ++++++----------
> >  fs/super.c                     |   1 +
> >  include/linux/fs.h             |  29 +++++--
> >  include/linux/fs/super_types.h |   3 +-
> >  security/landlock/fs.c         | 150 +++++++++++++--------------------
> >  9 files changed, 295 insertions(+), 269 deletions(-)
> >
> > --
> > 2.39.5
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>
