Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645527;
	b=ncDpxplKafwmFgvbcSluZkDDERdIivvUaAwTeMq0Nbnj6LNWXeQyzZj8GQ/pYpcZTj7v
	 +RhskyPLrHtWhUhIzewLnEKq3r0Rr/OPZ2EAPlJJ+kfVm+edEJCi9zqzSqnaMWoYdR+pH
	 RWwsp50cHOYQ4tn3iCwzs3hEBpz2Ozfr/kLN89vdxqp9KLmzDSNuMDhXVT3uNBz093MEi
	 XnAKVMsDRANwhgbGPzyLQYVleliguNcfuhJHJztO3P2MjrivG5nXmLhV4vPqeOL6hf5v6
	 ExYScvGVw6+pkR78nXluJfQXWHjisMn/rSgNyvVzmrd3VYFK6LfytvfG7ZOw/f/Kscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645527;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
	b=IZ46/SdqkHxfvZwymeDwuU/FSDuFxH/uMJQq6Q/CShQgs5cQy+OyOaXnGt7qiI7BCQa5
	 0CFCiUMJjcA1CYQqa4Cvc5VZjvBy0y4CrQG6G8CqZ0wGTR8uHKzd064Y9ur+do3XiFCRf
	 z6kgxTboRe6TMO1A9TO77Jk4zZe5iNqYdzxKLkKZRX7y/k/RmtcJvaxhcFtDgWSboiFQF
	 z/QNKkKAaHVpSt/59FYiVNqhl9h5TakChoraaoAySzz7q/vyr2W9PGU/doK6c1g0Yuwd8
	 reaFtzrbyptwubHlHwqpo8Qw2KDGbahK2TKVEbYBP1f5bWgiYMwjwzvjPkrEuV1o+dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ekP4czGG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0D606A6AA
	for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 22:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC0D606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ekP4czGG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795645526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
	b=ekP4czGGCiqJcCA2SyuuLWyFhEUyRJjw3MEZlcuMX+hxrfw8GEhYveFWMEQyaIYJJ6t1hz
	xTWol/ZLMNI0L3rXo3k+/W4yHgGGewDqIaRcK4Njp7fXDdUYYSGpuP7Qjz+6W6msI7b+Qk
	n3VQR6hwiPXJH0KnphfbNON7BhJ9iJA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--PshkQPnO2eIxdbd-7eQIA-1; Wed, 25 Nov 2026 22:25:24 +0000
X-MC-Unique: -PshkQPnO2eIxdbd-7eQIA-1
X-Mimecast-MFC-AGG-ID: -PshkQPnO2eIxdbd-7eQIA_1795645524
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b18c67095dso85831947b3.2
        for <gfs2@lists.linux.dev>; Wed, 25 Nov 2026 14:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645524; x=1796250324;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DAnq9jZ8WL+2JNYO3yb7/WAILtpdjC/5phjzX2RHlt4=;
        b=fY31ogxzdENFfrXOAGrF/1bb0Z1UQtiSVwhqdOaku1zkvclJVdAMtusD3IApGf0++v
         u4CNx6hfsL/xyeogi9Zci5l4/n8qqoS8F1jYx7EJ9/Lkz1+Z8Fzgl43tbF53sUeWujwf
         FwjbMi0PMTwSmaaqrefLY3l/DmRDA2fSetYcKOdBde4MQbnXHgH07FFQ+WOfOO2Yov0k
         WFw5SyiFSIyIuN3nqw80W5cVh89DYdI894RaVGZzq/qccfBsjwi/Q9XPeTUJC3zt9B07
         TJtRiMwDYiiprj93XQS6Rv3LXEdd1IWvK+gWSlI3bywP+5RpbDmk2u/Q38UiRbWqoy2W
         a0jw==
X-Forwarded-Encrypted: i=1; AL+hErG6YWrxqIoA+2AwjZ0ZyQ4eMORhy8rHGrQtm4sfBukYYNC4LL6qnoBLuDN7vLxc6EPX1EWP@lists.linux.dev
X-Gm-Message-State: APuU4Z9sZ+jitxfhlon2ajWZdiot96KhE1EAG5nc1RkQ6dS9BhBffNzW
	YLEJbqmtIXm5Fy8Y9W3wojD9oBMbTVGunfCVPek26H5jx4QKPC2TRWrMg1238WX0qlVEtQ4Tk5I
	jivRpHqulPQhfbFWJj9To0HtaB67NuHBnoeCL+r+kvsB94jxZzYsRTKtbumHkgH7PcW8fRwYZBC
	8fHDJOompurMmN/rFd9v4JrJzKWz+JlQ==
X-Gm-Gg: AZFdTZdDtC+XIcntVjT91dtF2ysg0rJY60qBWtUxTQT3vyLVI7WSCwBEbU5QNb6/x75
	mX8uYd4YMXG3FAbB/BD1Ko6S1pJxxtq23ZHIwy+77BK/aT8GUVmqpEvo3x9Kk6fO0+1Z47akAtA
	h+fBMN+LTgeSm7dYqVgYxBuaL0cSs4PheaXzRfk5iI//usxVq5iO7j/eCTVIsIiVZaSFser/6y8
	VxGAixBFUN3o3Mz7fJbIgJYeM5uksbT3ae1Phijq1oUqw==
X-Received: by 2002:a05:690c:3610:b0:8b3:2250:aed1 with SMTP id 00721157ae682-8b52045fff4mr82109037b3.26.1795645524008;
        Wed, 25 Nov 2026 14:25:24 -0800 (PST)
X-Received: by 2002:a05:690c:3610:b0:8b3:2250:aed1 with SMTP id
 00721157ae682-8b52045fff4mr82108897b3.26.1795645523329; Wed, 25 Nov 2026
 14:25:23 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261125091157.1822521-1-huangsj@hygon.cn>
In-Reply-To: <20261125091157.1822521-1-huangsj@hygon.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 25 Nov 2026 23:25:12 +0100
X-Gm-Features: Aa3M54qaE8GdHE2I6BQLUshqnPgXMm7o_gQT8cXZLdWKqWmzLqc31bUGv5jcvAY
Message-ID: <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
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
X-Mimecast-MFC-PROC-ID: zEWtViIYWV471OT_1sa49_HjHvK1taID-TcTzgnCt30_1795645524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Huang,

I have some thoughts ...

On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> This series adds a superblock inode iterator and converts the open-coded
> sb->s_inodes walks in the VFS to it.  The design follows the cursor-based
> construct proposed by Christian Brauner:
>
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner/
>
> and is the same direction as Dave Chinner's patch set:
>
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
>
> The caller owns the iterator state and drives the walk itself:
>
>   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
>   while ((inode = sb_inode_iter_next(&iter)))
>           /* do stuff */;

The pattern should be:

  for (CLASS(...); ...; ...) {
      /* ... */
      if (/* end iteration early */)
          break;
      /* ... */
  }

so that the iterator goes out of scope immediately when the loop ends.
Hide the details of the loop header in a macro and that this becomes:

  for_each_inode(inode, sb) {
      /* inode is referenced and unlocked here */
  }

Use that to convert the simple cases.

And then we've got preconditions that are checked while the inode is
locked. Those can probably go in an expression:

  for_each_inode(inode, sb, expression) {
      /* expression was true */
      /* inode is referenced and unlocked here */
  }

This unfortunately cannot be implemented on top of the
sb_inode_iter_next() pattern, at least not in a reasonable way, so we
actually shouldn't use that pattern.

The locked iterator would look like this:

  for_each_inode_locked(inode, sb) {
      /* inode is locked here */
  }

This doesn't cover all existing cases, but that's okay. Don't force
things into this pattern that are not a match.

We can always extend things further if it makes sense.

> The lock does not span iterations.  sb_inode_iter_next() takes
> sb->s_inode_list_lock, takes a reference on the next inode, drops the lock
> again and hands the inode out; the reference is what keeps the cursor on
> sb->s_inodes so that the next call can resume from it.  As the iterator
> is a cleanup class, a caller that breaks out early does not have to call
> sb_inode_iter_end() explicitly.
>
> Two optional channels let a caller keep its own state instead of filling in
> a shared context:
>
>   - iter->eligible is called with inode->i_lock held, so that a caller can
>     reject an inode before a reference is paid for.
>
>   - iter->status carries an error out of the walk.  Setting it to a
>     negative value makes sb_inode_iter_next() return NULL.

Nobody needs that. Just break out of the loop.

> Most callers just want a referenced inode and use no flags at all.  Three
> flags cover the walks that need something else:
>
>   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still have a
>     reference, preserving the "only handle referenced inodes" rule of
>     landlock's sb-delete walk.
>
>   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
>     already reached zero, and %INO_ITER_F_NOIGET suppresses the reference.
>     Neither keeps the inode alive, so the caller has to make the inode
>     unclaimable itself.

No flags.


> A second, internal iterator covers the walks that must not take a
> reference at all:
>
>   static inline int sb_inode_iter_locked(struct super_block *sb,
>                                          int (*iter_fn)(struct inode *,
>                                                         void *),
>                                          void *priv);
>
>   - It keeps sb->s_inode_list_lock held for the whole walk and takes no
>     inode reference, so @iter_fn only has an existence guarantee: it must
>     not block, and it must do its own inode state checks and its own
>     reference handling.  A callback returns a negative value to stop the
>     walk with that error, and 0 to continue.
>
>   - It lives in fs/internal.h as a static inline rather than being
>     exported: it is a VFS internal facility, and the small callbacks
>     inline into their callers.
>
>   It serves the three walks that cannot use sb_inode_iter_next():
>
>   - nr_blockdev_pages() is reached from si_meminfo(), which kdb calls, and
>     the iput() that the referenced iterator would do can sleep.
>
>   - remove_dquot_ref() has to scan I_NEW inodes as well, which the
>     referenced iterator filters out; it only touches the quota pointers,
>     and those have their own locking in dq_data_lock.
>
>   - the generic_shutdown_super() poisoning loop has to touch every inode
>     still on the list, including the I_NEW, I_FREEING and I_WILL_FREE
>     ones that sb_inode_iter_next() filters out, and it must not bounce
>     them through __iget()/iput(): the loop overwrites i_sb with
>     VFS_PTR_POISON, and evict() dereferences i_sb->s_op on the way out.
>
>   Patch 1 adds sb_inode_iter_next().
>   Patch 2 adds sb_inode_iter_locked().
>   Patch 3-5 convert the callers which cannot use referenced inodes
>           (nr_blockdev_pages(), dquot removal and the
>           generic_shutdown_super() poisoning loop).
>   Patch 6-11 convert the remaining callers (inode eviction, sync_bdevs,
>           drop_pagecache_sb, add_dquot_ref, landlock's hook_sb_delete
>           and gfs2_evict_inodes()).
>
>
> BTW:
>   This series is based on v7.4-rc2, and applies on top of the last commit
>   of that base, which is the small patch this series depends on:
>
>       v7.4-rc2-22-ga02161f70fcf
>       commit a02161f70fcf ("fs/drop_caches: skip filesystems without page cache writeback")
>
>   That patch was posted as:
>       https://lore.kernel.org/all/20260923070116.3226846-1-huangsj@hygon.cn/
>
> v3-->v4:
>    -the interface is redone as a caller-owned cursor, following Christian's
>     sb_inode_iter construct: sb_inode_iter_next() returns a referenced
>     inode with sb->s_inode_list_lock dropped, and the reference keeps the
>     cursor on sb->s_inodes.  The callback-based interface of v3, with its
>     ino_iter_fn and INO_ITER_RET_* return values, is gone.
>
>    -the iterator is wrapped in a cleanup class, so a caller that breaks out
>     of the walk does not have to call sb_inode_iter_end().
>
>    -an inode can be rejected before a reference is paid for: @eligible is
>     called with inode->i_lock held.
>
>    -the error channel is now iter->status rather than a three-valued
>     callback return.
>
>    -super_iter_inodes() and super_iter_inodes_locked() are renamed to
>     sb_inode_iter_next() and sb_inode_iter_locked(), and the latter stays
>     in fs/internal.h for the three walks that must not take a reference.
>
>    -evict_inodes() uses INO_ITER_F_NOREF | INO_ITER_F_NOIGET: it only
>     takes inodes whose reference count has reached zero, pins each one by
>     setting I_FREEING and dropping it from the LRU, and runs dispose_list()
>     with the list lock dropped.
>
>    v3: https://lore.kernel.org/all/20261120031305.3561045-1-huangsj@hygon.cn/
>    v2: https://lore.kernel.org/all/20261113115702.586594-1-huangsj@hygon.cn/
>    v1: https://lore.kernel.org/all/20261015093854.2082600-1-huangsj@hygon.cn/
>
> Huang Shijie (11):
>   vfs: add sb_inode_iter_next()
>   vfs: add sb_inode_iter_locked()
>   block: convert nr_blockdev_pages() to sb_inode_iter_locked()
>   fs/quota: convert remove_dquot_ref() to sb_inode_iter_locked()
>   fs: convert generic_shutdown_super() poison loop
>   fs/inode: convert evict_inodes() to sb_inode_iter
>   block: convert sync_bdevs() to sb_inode_iter
>   fs/drop_caches: convert drop_pagecache_sb() to sb_inode_iter
>   fs/quota: convert add_dquot_ref() to sb_inode_iter
>   landlock: convert hook_sb_delete() to sb_inode_iter
>   gfs2: convert gfs2_evict_inodes() to sb_inode_iter
>
>  block/bdev.c                   |  58 ++++++----------
>  fs/drop_caches.c               |  36 ++++------
>  fs/gfs2/ops_fstype.c           |  26 ++-----
>  fs/inode.c                     |  33 +++------
>  fs/internal.h                  |  25 +++++++
>  fs/quota/dquot.c               | 120 +++++++++++++++-----------------
>  fs/super.c                     | 121 ++++++++++++++++++++++++++++++---
>  include/linux/fs/super_types.h |  40 +++++++++++
>  security/landlock/fs.c         |  67 +++++-------------
>  9 files changed, 297 insertions(+), 229 deletions(-)
>
> --
> 2.53.0
>
>
>
>

