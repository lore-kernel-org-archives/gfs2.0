Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186767;
	b=b9GXcUQZsgEf26eusDAs3JETZy1H4BauvRdiX0O2tTKdSYb98XccRt2rhXDMuzPsYnJj
	 5qjOfgSZF41OT1dj8ZQXqcQ/GjKQH3f2raOr90zrpMXyn2pOB2e7LWmtv9oDoeiSd7q/x
	 i3hxOnhjSDEMlfyjqq+y3JdcOnIf+a+Yz8aTy+VpEa6Ayv1sOhI2siuZBVbNmOc7FL7Cr
	 kkq4nYZwpTYiyjWS9UYd8PNDQ5vWAu2p71ONrGj7xkdhcchlR7uQro6a+CGFiJmcgW+yl
	 MeJeTxZT5akL3mEdYyKXzv3njNrid8gmDVzRE6wNlGEdG7vBsUIH7MjkRqWGR4xsqyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186767;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=a6cJ/VJz7Yt3gmoDG4b+/PHMpwNOflXazzrFrJdxnLgLjz/SGM/V7pRRgvbwo03TA0OA
	 eWlWaHDhdBjlZgRnCF8jbGZQUB+5166voP3oi37xPemZi3yKT2hRIGa/0pdePbCFrO8Gn
	 W/mWw8poNbVg93VHCS4T+LBbO+TI4L9GIapdrenvvtQHaXduBo57OITy/14EuEESHGrgk
	 moAMZOsrv1/SX3ggsjcvlV2Odc/whRQY4zavGuMmauorxWs2UJqWUufqnejH/PvXtTQiZ
	 en6bVQ46B3BwN1WVoyOlnwxnFTG3UgNFUkuFH/oNjaii41kcXEKt3CLunSSbUvHv0eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DnANfGTH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747B60A5BFC
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 14:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E747B60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DnANfGTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795186766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
	b=DnANfGTHiK3MTAV93BOgIhdNpq5Pgu/yxVw8eNgYO5tmEJGDdN59tApebJVtAf14r09uIj
	aOF1GUJwKhmWCCS+pbXgkcP3juJEkRN6/DdwnMFHSNPq6Q22O5V3J5dKPREVEjbco3PcW3
	Srzeeh2ifR/M9aWLxPYp2DwLl06Eddo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-EV0AFQdxNtmOA33_l7o4zA-1; Fri, 20 Nov 2026 14:59:23 +0000
X-MC-Unique: EV0AFQdxNtmOA33_l7o4zA-1
X-Mimecast-MFC-AGG-ID: EV0AFQdxNtmOA33_l7o4zA_1795186763
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b4ca583164so23645497b3.0
        for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 06:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186763; x=1795791563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz/9X/xDs27LNeUzfwpYSxQHLLpaMzHuDFNMaboauyg=;
        b=o2uHjpEi8Ix4XdYQoOV55ScaYveX621y/nunm+G1Rx9DOxxe9SuBOjovXvhEYs9jln
         an/6XbKeOVOVlnUO2g4gZKTPscpXhVeLbnBYUl2/WfMURiI2Wa4Qgy1YjMAIWuJ2PzBG
         mqBlXtBFMGLSGOpoceDFZjJabAbkvR1z7UG3P9w5XuSO0jjwk663+oyqnbKrRta430i+
         0fMOlQhMJ2YeOwHuLBtM9oqslrzTWudY2W0Kj2bDi/loxWc1TwQ5RANbfBWfMKriQmim
         AAU2D6FFlZ4GdJfaMs1wSmrysIkRgcR90tlj2PM6Im0Dbwjt5C5vBqQO22qo+il3y8DG
         hpEw==
X-Forwarded-Encrypted: i=1; AL+hErHUWF8UhzlV3QQkAbFe2YfUaIyP4irJ2bDR9S3157wodv5zoobWOE2L2wzaEVHWn9hZlNNX@lists.linux.dev
X-Gm-Message-State: APuU4Z8vhhZRH8/fBUo3g/uNdA56jCxglAY+kzGpXirHbbYlnsbJAiax
	4hD9GcPN3TVHwQnk+WT7zBZefVg8+SbSjVAkOxuvuWTdPAkM66av/3cxbX9izbyoTwe16nJ20mQ
	fnJ7/FUaMRxGj78fJRfJB7sTqFNctC6kIQPxE5jzPLT0ZopKt4/2ZOcSq8HBJzL/N7nd8VP7me8
	msXXTjMNixc6u7rVJfc4gjF/HBUWWuAg==
X-Gm-Gg: AZFdTZeLFyMCgX6vyyjUapdcOhyPGuGW4bvRFdJrmb/3K/Uh8KxeRtxxR/uQAaPoBf2
	ldC9c7B4FNy4CbdescdTBGjq3ONlBgD6lqDIrAtywbmRTD1uWQUcB1jK65pACbPnu4EyL6fg5sA
	nLzHJ0J3/bNRZ26U5J7r30jzefCSzWkHYljBlCgoptwNVSrEdU4zNUzyqsazGvJVXKYMMBspJVr
	7C6jS69yp6s+v9GAyAp0a4mKGvfXi7pd7lJ+/NSDQ3GVA==
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id 00721157ae682-8b518d25cadmr18702587b3.4.1795186762669;
        Fri, 20 Nov 2026 06:59:22 -0800 (PST)
X-Received: by 2002:a05:690c:6893:b0:8b0:8a77:e9b8 with SMTP id
 00721157ae682-8b518d25cadmr18702267b3.4.1795186761947; Fri, 20 Nov 2026
 06:59:21 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn>
In-Reply-To: <20261120031305.3561045-1-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 20 Nov 2026 15:59:10 +0100
X-Gm-Features: AclHuK92MT1vYW09O4Urhd7Yf7t3vir7SJ2k6LlnKDbNPNtVZYsZ96-h_yHunoE
Message-ID: <CAHc6FU7URHetBU9XgP0DSEGjWQfq0tX+ohK8xRVZLEYzgJBeEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YvskXAzlak0-Sz99SA4TpzOlK28sgqi-7U-nO5wW3OY_1795186763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 4:13=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> This series adds two superblock inode iteration helpers,
> super_iter_inodes() and super_iter_inodes_locked(), and converts the
> open-coded sb->s_inodes walks in the VFS to them.  The design is based on
> Dave Chinner's patch set:
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
> About the two helpers:
>
>   int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
>                         ino_iter_eligible_fn eligible, void *priv,
>                         int flags);
>
>   static inline int super_iter_inodes_locked(struct super_block *sb,
>                                              ino_iter_fn iter_fn,
>                                              void *priv);
>
>   - super_iter_inodes() runs @iter_fn with a referenced inode and with
>     sb->s_inode_list_lock __dropped__, so the callback is free to block a=
nd
>     to do whatever it wants with the inode except drop the reference the
>     iterator holds.  The iterator releases that one reference per inode
>     itself, so the callback cannot leave a dangling inode behind.
>     It is exported because GFS2 can be built as a module.
>
>   - super_iter_inodes_locked() keeps sb->s_inode_list_lock held for the
>     whole walk and takes no inode references at all.  Its callback
>     therefore only has an existence guarantee: it must not block and
>     must do its own inode state checks and its own reference handling.
>     It is internal to the VFS, being declared in fs/internal.h.
>
>   - The callback is separate from the caller's data, so a caller keeps
>     its state in its own structure instead of filling in a shared
>     context:
>
>       typedef int (*ino_iter_fn)(struct inode *inode, void *priv);
>
>   - %INO_ITER_F_REFERENCED restricts the safe iterator to inodes that
>     still have a reference.  It preserves the "only handle referenced
>     inodes" rule of landlock's sb-delete walk.
>
>   - %INO_ITER_F_NOREF does the opposite: only inodes whose reference
>     count has already reached zero are handed out.  %INO_ITER_F_NOIGET
>     suppresses the reference.  Neither keeps the inode alive, so the
>     caller must make it unclaimable itself.
>
>    Patch 1 adds super_iter_inodes().
>    Patch 2 adds super_iter_inodes_locked().
>    Patch 3-5 convert the callers which cannot use referenced inodes
>            (dquot removal, nr_blockdev_pages() and the
>            generic_shutdown_super() poisoning loop).
>    Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
>            drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
>            and gfs2_evict_inodes()).
>
>
> BTW:
>   This patch set depends a small patch:
>   "fs/drop_caches: skip filesystems without fs writeback"
>   https://lkml.org/lkml/2026/9/23/675

That link doesn't work for me. When referring to other postings, can
you please use lore links?

There also is no posting of a patch with that title from that day on
https://lore.kernel.org/linux-fsdevel/. You may be referring to
https://lore.kernel.org/linux-fsdevel/20260920072811.2064247-2-huangsj@hygo=
n.cn/,
but that patch queue no longer applies. So please post patch queues in
a state that applies and optionally, make a git branch available.

(Also, enabling "git config --global format.useAutoBase whenAble" is a
possibility, but it wouldn't have helped in this case.

> v2-->v3:
>    -the callers' state no longer goes through a shared struct, the
>     callback now takes the caller's own @priv.
>
>    -super_iter_inodes() takes @eligible directly, so a caller can reject
>     an inode before the reference is paid for.
>
>    -rename super_iter_inodes_unsafe() to super_iter_inodes_locked() and
>     drop the rcu_read_lock(), which the list lock already covers.
>
>    -drop @ctx->prev; the resume point is gone with the unsafe iterator.
>
>    -evict_inodes() no longer goes through the locked iterator.
>     it now uses the unlocked iterator with INO_ITER_F_NOREF | INO_ITER_F_=
NOIGET.
>
>    -each caller gets its own patch.
>
>    v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.=
cn/
>    v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon=
.cn/
>
> Huang Shijie (11):
>   vfs: add super_iter_inodes()
>   vfs: add super_iter_inodes_locked()
>   fs/quota: convert remove_dquot_ref() to super_iter_inodes_locked()
>   block: convert nr_blockdev_pages() to super_iter_inodes_locked()
>   fs: convert generic_shutdown_super() poison loop
>   fs/inode: convert evict_inodes() to super_iter_inodes()
>   block: convert sync_bdevs() to super_iter_inodes()
>   fs/drop_caches: convert drop_pagecache_sb() to super_iter_inodes()
>   fs/quota: convert add_dquot_ref() to super_iter_inodes()
>   landlock: convert hook_sb_delete() to super_iter_inodes()
>   gfs2: convert gfs2_evict_inodes() to super_iter_inodes()
>
>  block/bdev.c                   | 101 ++++++++++--------------
>  fs/drop_caches.c               |  45 ++++-------
>  fs/gfs2/ops_fstype.c           |  29 ++-----
>  fs/inode.c                     |  61 ++++++---------
>  fs/internal.h                  |  31 ++++++++
>  fs/quota/dquot.c               | 139 ++++++++++++++++-----------------
>  fs/super.c                     | 106 ++++++++++++++++++++++---
>  include/linux/fs/super_types.h |  29 +++++++
>  security/landlock/fs.c         | 138 ++++++++++++--------------------
>  9 files changed, 370 insertions(+), 309 deletions(-)
>
> --
> 2.53.0

Thanks,
Andreas

