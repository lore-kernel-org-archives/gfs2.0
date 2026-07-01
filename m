Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7FE431E4E
	for <gfs2@lists.linux.dev>; Wed,  1 Jul 2026 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939081; cv=none; b=IuX7TChKtvYXEgI7ivEetu9RNtW7wduOpocad5Yl4b0Bh69pP2S9kQ5sWRwK/4gDKUH4Im5BCJ+ysddrLNGhlMxYiNugqbK/HviF+0d3glXEpoMZqEVxZfA1Bl1wci9GrFBcnf0sluL8UaT4qRwJZZ++C2b/vOJ0LgSolfXPzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939081; c=relaxed/simple;
	bh=CXbyE5jAZaxhOqn1wsrHntSB48IwpOuSpEKralUyb4c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bw1Z+bynR4KrQO1WrlMuEgVhYkW+mh/KRzOE2MP8PBKPjy0moYhZM8cGKQiSAjiRWOAlEGjRXI+C9vcQ75zy6IU5lWaY15lwdTSu9xczPREna4MHWHDSa8Jh278GG5YEaJSxU04vQyoN2LigEFNsBbC3XC552qB7x594LTudTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8d67CwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8d67CwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782939079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
	b=M8d67CwDGJgWwxhIubBTlpkFwjw7Fz+LyeDmRbAtbDgDKJ7unua66X0YgfLWXcSg4O/Bmo
	oYcmbo0g/MCWAwGgJteUXeTDW09mZ2YWbtj8GUSiqhklvqfMNVwbYkIcFRHdmostnV2u0m
	WN7ignq9bbi1+9h7gUTTBY2y0K6U8b8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-k2D8tiYxOFOGdd9lDzB8kQ-1; Wed, 01 Jul 2026 16:51:18 -0400
X-MC-Unique: k2D8tiYxOFOGdd9lDzB8kQ-1
X-Mimecast-MFC-AGG-ID: k2D8tiYxOFOGdd9lDzB8kQ_1782939078
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-664e1e408b2so3031384d50.0
        for <gfs2@lists.linux.dev>; Wed, 01 Jul 2026 13:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782939078; x=1783543878;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF81/sKTmZ1AnlJSj3x2T7mD8T/hF0ps/9K/nqtvitg=;
        b=AP34DQxTK6Fm24+oUQGQ9bdv1knPq7GThvKCfsxwPvIkgAQa8qW+tdG37W9mcPNHL2
         AZHi01SBj8NKERYFVX15sfIoJ+YqQHvhU+yXeCE3S2UJhcPXaKLc/MPyYx4gGxNyPnJL
         yDJ+/QPF57/u+FHKI3H3u/pA0gMNvqg/9ijdOMUA1Wl16itCKX8tLl4uBMVwBO4o0+hK
         sL7Q2tiZc563DAfDqtU4SE6ms4x0X5VUYmnTHZp5ipRNnnU4k1w1SoKWfUZ8apn98f3x
         Owebpnh90BBkSJgmuOCK3vyFgNwb9qxsKMoW4lxnOV5l636XTZAKy34ndxw5n/Z0ZHyS
         jbIw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/vAzJPDGvJF2Cu1rzF3SdgsA54BJMp8Fu4hR4puNZLzM21d+xyEOGee4WjUz7CHwRsKa8@lists.linux.dev
X-Gm-Message-State: AOJu0YzWbIqlPH4+zANaBGth9M9mx/QlMEnR3I8a8AXUk+rYueludnd3
	rRa/XdfteqJdhHqEY4165IsKw7XtFx/q5ffLdBnvFx3x0bveGZtvjwDLyaxlpnU28W4/l56ML1k
	MCeA915/xjfeNijlpd2KBkIthLlgidJ/an6yKusXXJJn3Mcuw1iDnyzG7Xt1YwntG3MkM6ZZcvC
	Mji+YKGttrAbIj9FiOkrLoYjgvXHdK8g==
X-Gm-Gg: AfdE7clYHzA69ehWEcYKenGitFQe42Y8lHb502Ln/RlU4YLC1Qj2VXc/CZKrH15MH4J
	0icty0l7S62v+xD237fTeCPSbcu3wXFJLHBULus5L8tZcT6shc2AdpaiUCWz6KVYoFOIhoaPdCf
	LfwI0Y78JiaqWg3C5nU34ybkqBWCDBpuaR+NhsO+nrbZFDsjYRUqdiitb0Q31sB/G88qMAe0jmc
	m8tLuZ6lCSXj3EiqJaof3TIxgItGFEMM/8Q9PD7zNJoW6ukunXEUgo=
X-Received: by 2002:a53:ac88:0:b0:666:2480:2b0a with SMTP id 956f58d0204a3-66624802c95mr562174d50.50.1782939077554;
        Wed, 01 Jul 2026 13:51:17 -0700 (PDT)
X-Received: by 2002:a53:ac88:0:b0:666:2480:2b0a with SMTP id
 956f58d0204a3-66624802c95mr562129d50.50.1782939077080; Wed, 01 Jul 2026
 13:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 1 Jul 2026 22:51:06 +0200
X-Gm-Features: AVVi8CfsV3cGOgb6Svx2JkIRUFiPC3HXmSBXTyt1juuiIVniLQt7WCc-miACenM
Message-ID: <CAHc6FU4tz8-HmEf2_XKT0NT8N=rv5OMcY79PxTACkXAVLOAUpg@mail.gmail.com>
Subject: iomap_writepages WARN_ON_ONCE(PF_MEMALLOC)
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	linux-xfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1SVdaYGjkuXLWFiAG-bGn9alGRI5Pf6hW2YrBze_P-U_1782939078
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Christoph,

I'm running into a problem with the following check in
iomap_writepages() on gfs2 in RHEL-8:

        /*
         * Writeback from reclaim context should never happen except in the case
         * of a VM regression so warn about it and refuse to write the data.
         */
        if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) ==
                        PF_MEMALLOC))
                return -EIO;

In my case, reclaim is triggered by the following command:

  echo anything > /sys/fs/cgroup/memory/.../memory.force_empty

And we end up on this code path:

mem_cgroup_force_empty_write -> mem_cgroup_force_empty ->
try_to_free_mem_cgroup_pages -> do_try_to_free_pages ->
shrink_zones -> shrink_node -> shrink_node_memcgs -> shrink_slab ->
do_shrink_slab -> super_cache_scan -> prune_icache_sb -> dispose_list ->
evict -> gfs2_evict_inode -> evict_linked_inode -> gfs2_log_flush ->
gfs2_ordered_write -> filemap_fdatawrite -> __filemap_fdatawrite ->
__filemap_fdatawrite_range -> do_writepages -> gfs2_writepages ->
iomap_writepages

The PF_MEMALLOC flag is set in try_to_free_mem_cgroup_pages() before
calling do_try_to_free_pages(). We end up in gfs2_evict_inode(), and
the filesystem is required to evict the inode. At that point, gfs2 has
no way of recovering from an -EIO error from iomap_writepages().

That WARN_ON_ONCE() was originally added to xfs in commit 070ecdca54dd
("xfs: skip writeback from reclaim context") and later modified to
allow kswapd writerback in commit d4f7a5cbd544 ("xfs: allow writeback
from kswapd").

Before commit c2dc7e5589a1 ("iomap: move the PF_MEMALLOC check to
iomap_writepages"), the comment above the WARN_ON_ONCE() indicated
that the reason for rejecting the write was to prevent stack
overflows. But this code path triggers reclaim right at the top of the
stack, so that's certainly not an issue here.

Do you have any suggestions?

The above is on RHEL-8, but a similar code path exists in cgroups v2,
triggered via:

  echo reclaim_amount > /sys/fs/cgroup/.../memory.reclaim

That code path starts with:

memory_reclaim -> user_proactive_reclaim -> try_to_free_mem_cgroup_pages ->

Thanks,
Andreas

