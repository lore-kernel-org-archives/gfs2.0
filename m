Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A63A6B89
	for <gfs2@lists.linux.dev>; Wed, 23 Sep 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197330; cv=none; b=XgaR2HFvAj31hpVwiOi37TdOOylPPVxA6xfI+bLr6aPohfRbcAPaM+bporwwdjQ2JD4uUndIgPDYLagXu3/JFalC24f6WTfDjs8bPv9Nno1gZk8LjNH6xDaBD7JFw6kybKoEY5OexdyJGOcPpRfgwXEPb18IPsVoXNY/qsrVih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197330; c=relaxed/simple;
	bh=/ivY9I/EG9+DSzOaxxM5obfKFkrp4hNLEWa7/4iEB2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuIIVT0fuKVdNeB/hUzwjA4ShXG8LNfBeUk7MQK5PoNWhXoO+GzfEkAcl082Sc0bOImf448QemBpwHIym8vVvVEsCL1MOQ4oMQiJhHVyssdSXA2co5N2WqJqbjrnM6NiryPIPf1Rynv4EfzquQYn9a/Ei0ZO2M7u8OV6QRcc4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVa9EvIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVa9EvIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790197326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
	b=iVa9EvIMSOmnDA9b474bHGTgWhK9mWBlyGQKdZQE95Fl4XI9BIsnvggctghhWj+sy7pem6
	xGGy6iqdWcoKa7a0a2pYuF0GR1vTCxs9at+pTfTjxCJfE3MLhup9MRqLB8NNYBVVzD2C09
	JFu3I0BtsFSnHHXt4+KQDU6TfjFWhyU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-jtD3CWSXPUmJvcF6yTXpmg-1; Wed, 23 Sep 2026 17:02:05 -0400
X-MC-Unique: jtD3CWSXPUmJvcF6yTXpmg-1
X-Mimecast-MFC-AGG-ID: jtD3CWSXPUmJvcF6yTXpmg_1790197324
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c70f5abc2so1569959d50.1
        for <gfs2@lists.linux.dev>; Wed, 23 Sep 2026 14:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197324; x=1790802124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teMaf0NJPbuhvSvBaJzyDInJb+MTYgx/6C4I8crlQU8=;
        b=e+M0HNsi4Y2ePiSCC3H56NSLyPPQzfscOZMkIi8cTcHDYPcHwRu/RsfSPc0FaGbgKC
         PBiElseekUxRvf5hUr7qmA7TNHxc08FZYOnDK47l0rs+v9vlE+d8aj23uPOE6SiByTDr
         IKrFFfOJ6v6avvBenM12VzLroujaxTn5QZh9mJ5BDRYowFrAcLyAGwZK/COZ1esNQOkV
         jiZAXRrnpO3cTFLWevc9TQ2te7BcbKc+LxZ5sVjoU6zQufCdSosojYSsDqA4ESVSL8W2
         z/nkdmN9mmzybPO7F9zd4M4oYgjCeo52FsYYOc1w3oYiy73IXZZ4XN6M5XquF+2sP9p8
         XtFA==
X-Forwarded-Encrypted: i=1; AKwUvBwGs9OwAWNRSAz+1XlW4G45a+4NYCywxYncgSDXOeSn4j3MrePRjQ6LQx5byiDeZybZZU4O@lists.linux.dev
X-Gm-Message-State: AFuF++lJ8z5IN06t/HiV3tgMpGbgAbxaxYI2afL/rlIJx6lvx9e6aBlS
	CTxktUbcqdis8A0EeVltimHNPz06jNgifawTtwlxSOr5Qh5ZWnM+loS5RdZ+rmLH5jea0lPTFxW
	nHiqTod9qJ/pDZaAdzUiV7vFFwO+uXNfCnvamdLjFJPal8YAx/SEUqPqAFUr9GUEYiEwI3oB2T2
	wfsMxR957CqQZY8ky5dPAEOexvSiSnkw==
X-Gm-Gg: AYBFou1ZY6iguZetwDbdYYx2McsrD5JO7/D6HX832ZsZuoUIlnOl/lf9tynudwCYSAR
	V7PeUI3McGWbMjeoLxgOWYYij83G4s0gJJCjBCYTRWLzg6rmeIkqyuaC8YIWYeFYPpq6Q+nT2Tc
	R5JbxxTbZXJET2nA83g73G5w95BWLqc+HxAaNdC4XML5aBftfbV3TaIernhKpYfT3nLybu5iuHj
	ZpaYWjRfYzThjb6ya/2vk2porgw8x1uufp/5Y+9F32kQg==
X-Received: by 2002:a05:690e:408b:b0:671:70d1:d6d4 with SMTP id 956f58d0204a3-672ed8e80c4mr293367d50.70.1790197324206;
        Wed, 23 Sep 2026 14:02:04 -0700 (PDT)
X-Received: by 2002:a05:690e:408b:b0:671:70d1:d6d4 with SMTP id
 956f58d0204a3-672ed8e80c4mr293294d50.70.1790197323555; Wed, 23 Sep 2026
 14:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260921211712.1563575-1-agruenba@redhat.com> <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
In-Reply-To: <rhj2uhowkjekxgi7tkxko5odxw3zikthtnlef5f5owrfjzrt3r@nul7b7ldcb2g>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 23 Sep 2026 23:01:52 +0200
X-Gm-Features: AcwNN1Wx3An96hJa8GxLoJV99l3BMwVJSGq56GeWtJeaT0vWl86MXKjtrRWGLfo
Message-ID: <CAHc6FU4Rf9-r8m8SSb=e0k0zyoFhQAdjupHMWvT6rStBshntug@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: prevent premature evict in prune_icache_sb
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U9o9il6TC8gUII9OwKr81gHpvzURnwXbhN9M2lB5QWE_1790197324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan,

On Tue, Sep 22, 2026 at 1:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Hello Andreas!
>
> On Mon 21-09-26 23:17:11, Andreas Gruenbacher wrote:
> > Introduce a new I_NOPRUNE i_state flag for preventing prune_icache_sb()
> > from pruning specific inodes.
> >
> > prune_icache_sb() prunes clean inodes under memory pressure ("direct
> > reclaim").  An inode is considered clean when none of the i_state flags
> > are set; the assumption is that evicting inodes that don't have any
> > i_state flags set will be fairly cheap.
> >
> > Unfortunately, on gfs2, inodes can be clean in the sense that they won'=
t
> > require writing back to disk, but they may still have outstanding
> > revokes (as indicated by the GLF_LFLUSH inode glock flag).  To evict on=
e
> > of those inodes, those outstanding revokes need to be written out first=
.
> >
> > This requires flushing the log, which is already an expensive operation=
.
> > When in data=3Dordered mode, all the ordered data needs to be written o=
ut
> > before the log can be flushed, which makes things even worse.
> >
> > As previously discussed [*], we are currently also running into the
> > following warning in iomap_writepages() when flushing ordered data:
> >
> >     /*
> >      * Writeback from reclaim context should never happen except in the=
 case
> >      * of a VM regression so warn about it and refuse to write the data=
.
> >      */
> >     if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC | PF_KSWAPD)) =3D=
=3D
> >                     PF_MEMALLOC))
> >             return -EIO;
> >
> > So we need to prevent prune_icache_sb() from evicting inodes that have
> > any outstanding revokes.  This patch achieves that by introducing a new
> > I_NOPRUNE i_state flag.  When that new flag (or any other flag) is set,
> > prune_icache_sb() will skip those inodes.
> >
> > In the filesystem code, we set and clear the I_NOPRUNE flag in sync wit=
h
> > the GLF_LFLUSH inode glock flag.
> >
> > An alternative approach might be to allow filesystems to refuse evictin=
g
> > inodes that prune_icache_sb() has already selected.  This could be
> > achieved by changing the ->evict_inode super operation to return a
> > lru_status code or similar.  prune_icache_sb() would then have to
> > resurrect inodes that were already marked I_FREEING and put them back
> > onto the lru list.  This approach doesn't seem obviously better than
> > introducing I_NOPRUNE, so I haven't pursued this any further.
>
> So for situations like this I've written a patch set to allow filesystem
> to mark inode for deferred reclaim (from a workqueue) [1]. Would that wor=
k
> for you? It will definitely solve your problems with warnings in memory
> allocator.
>
> I don't want to have two different mechanisms for the same issue so if my
> solution doesn't quite work for you, let's discuss how to make it better
> :).

thanks, this would solve some of my problems. In the gfs2 case, inodes
are only in "deferred reclaim" state for a while (while they have
outstanding revokes) before becoming directly reclaimable again. So
I'd also need a way to clear the I_DEFER_RECLAIM flag again.

The I_DEFER_RECLAIM flag setting and clearing code would be racy and
ugly though, so I'm wondering if we can change the ->evict_inode()
super operation to return a DIRECT / DEFERRED status code instead. The
filesystem could then look at the filesystem-internal state and return
how to proceed with the inode. For example, fs2_evict_inode() would
probably request a DEFERED evict when GLF_LFLUSH is set, PF_MEMALLOC
is set, and PF_KSWAPD is not set.

Thanks,
Andreas

