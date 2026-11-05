Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909249;
	b=PRA4Heds7DoyCJSCumTVbjhozmqcT/ylmcwzioVBz3AZKkNjTcS5B4EgWXqb6rA/mFA8
	 THakx8FnNWK6btrEqD8dbNUPaf+mRRJSBM61EuRgc14KVFBSwfC7cMFlas+S/DM/engKF
	 mUm6PfgsX9OgQKwLZnbO2Wp1vp3IOIpNgDoSjGtw0RyCyWFJleF1hmwXg0NIn3xDMilNS
	 YcKWOcAKhl/M/Uj0X6m18nWydILC31zjGxD2REQaDWAIQjUSYnbLN72lfVZm7BM493yE7
	 sgj1V7gVhhYYSA0RPFpv03MseTO8l1TdhrIGii/6SSM2859LB027SGcy/iLubQwT/QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909249;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
	b=JNudlIJ4fOjCsodSoSyPKSO2i5VGiRHXM5x/pBY0q/2AKoT9STP77p23V6RJyTHhzxIT
	 OXBblRDSPTZGZQ4crGtK1QUj0MwmzUl4Sb3TpDzLXJqy5w1HCe/XIsrTHMJI4yTmakLSb
	 zl4Ot5nActFb85Ji0SJiFCUiwCqj7o9QbFiC8tIv2XSXKV27xdXMw6Q2sIjKNQOGWWsnK
	 kuazOrlyy8y5dWlfDrcy3wy9XpW5ghiDkAywtI34V9PYtnIZIim3JMiOyqKUwwSzRyydO
	 82ocqHZZHodOe03flNCRdJm8k2DoMeEVrUflMtXCpnUxJh3BmC8YbGTv82wisXqVMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GAfX30/p";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E860A2630
	for <gfs2@lists.linux.dev>; Thu,  5 Nov 2026 20:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A87E860A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GAfX30/p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793909247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
	b=GAfX30/p/r6CwycZ4cN9HgiTM1XqRqFEeYwRqZEJuJdl8TlDoUEZIg03Hq59z01lbLleZi
	ou23LG6kzJahOcQNjgXFwA6bhfEyWVud5k1QaXKfeTS+dOXtUzY53DNGcmY/XYrwUDuUwP
	QmXzOQmjg89/P5uwGtWCI+oASz8EVhw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-MMM4FnGbPUisftLpTWDXFA-1; Thu, 05 Nov 2026 15:07:24 -0500
X-MC-Unique: MMM4FnGbPUisftLpTWDXFA-1
X-Mimecast-MFC-AGG-ID: MMM4FnGbPUisftLpTWDXFA_1793909244
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b30ffeb2f5so35353687b3.0
        for <gfs2@lists.linux.dev>; Thu, 05 Nov 2026 12:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909243; x=1794514043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlBVJT4GPajviox7GVvnaU/1fuJu0H3trSYA5DJJsWk=;
        b=Vq5bf6pCRojwUiLyMy2/9SQUIjFLR/YorDMVbMQejTN0ZR1yQsyIHhDolO0NqAPb6n
         pOcx1b5Bn7cIdDlhOob6vwMo7CGjDtMHD+GyP3R312IoMZM8YbEFFM0my93f9UbhSPBy
         SSurMfvizxDcAtT2PCTpZU40GHemiGZiupnE88wW/VMfzGuQiDP9/pW0DYExNfnT7qtm
         qLKbMxDxeILU137EF+VbF5ysznN8QVhDm8NXGSkKvTSXxYdZz+pzZyMU49RQBLSFPJH9
         kGUJPfsSX5rV1cnrDFxDJV97v6EvaxWJr8ds5SLRIrT1pMTWf0ESyeNS9+8CRPj21LZC
         ++IA==
X-Forwarded-Encrypted: i=1; AL+hErFjuD+NUKSTO4lki1a/EWceU6vkwULYc13Imjr3NmRf2qG+FtS9YTlv+nRSEl+Wcvxn8CKP@lists.linux.dev
X-Gm-Message-State: APuU4Z+UyBCNVTtS5DY51GDbT1c8tb7PyqVu+inJnDM4l/75lfOOGXsH
	1bP1io/9VWlce74eRn/YiQ1V3zch+TxDhGrak8Fx5k17IMpWWpjmdmhocKvCT36S9k9xdlKcHCF
	8c8h1DnMPbTSJHwqVZIm0Kxppkz8aeN72HVZI94IaceL+7wIjrmCK5VTXhdn1GLb/JQJ3kgcouN
	y6HO5YmW/z2XEsMb5ArJOq6Uc1auSsLg==
X-Gm-Gg: AYBFou0evR8wtftRE+zzMSd4PWAtito/Ar5YtRObSU4XwqqGvkPYvzgKxzZlI+H3X3t
	atqMMsOP7b0YR37YZsv5EDj15UZGboFNyOQkqOSUCv5zOJPYCEua/ru7wpGyCMnniPr2pYH8wtQ
	xhMJrH9nzzL5MlcT3FbDePIDyCtMwMKYDhMttNAcABQz60nqRopxXy+Mc9WCGmvkX8tdvky8bnP
	xkJ6j9CrBT7VWao7UukB1g8h8RGAeLb+JnL5FF2BdLIrw==
X-Received: by 2002:a05:690c:c513:b0:8b1:368b:392f with SMTP id 00721157ae682-8b3419be4e8mr580207b3.49.1793909243364;
        Thu, 05 Nov 2026 12:07:23 -0800 (PST)
X-Received: by 2002:a05:690c:c513:b0:8b1:368b:392f with SMTP id
 00721157ae682-8b3419be4e8mr579957b3.49.1793909242884; Thu, 05 Nov 2026
 12:07:22 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103023804.8074-1-wuyiqing@cmss.chinamobile.com> <auo_CehOVzTMq6kc@dread>
In-Reply-To: <auo_CehOVzTMq6kc@dread>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 5 Nov 2026 21:07:11 +0100
X-Gm-Features: AclHuK_7bPPStvyJ7t0t9o12YGqSYrx1SyDLCxIY-DGoYpyY0de9k9HjzorVUGE
Message-ID: <CAHc6FU6aE1hdi4zsOgu6LUGJx6CE__PMwOfTY8KMccASRzzRaw@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow writeback from kswapd again
To: Dave Chinner <dgc@kernel.org>
Cc: Yiqing Wu <wuyiqing@cmss.chinamobile.com>, Christian Brauner <brauner@kernel.org>, 
	gfs2@lists.linux.dev, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+5e659793378ad9e06387@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a4Fg2PtUtKarAIw8xaHuMIYbN2qiYkZzdG-VzkxWxtQ_1793909244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:17=E2=80=AFPM Dave Chinner <dgc@kernel.org> wrote:
> On Tue, Nov 03, 2026 at 10:38:04AM +0800, Yiqing Wu wrote:
> > Commit ff59f71f1c95 ("iomap: simplify writepages reclaim guard") remove=
d
> > the PF_KSWAPD exemption from the iomap_writepages() guard on the
> > assumption that kswapd can no longer reach filesystem writeback now
> > that pageout() returns PAGE_ACTIVATE for non-shmem, non-anon folios.
> > That assumption only covers the folio reclaim path.  kswapd can still
> > reach filesystem writeback through the inode shrinkers, and syzbot
> > reports exactly that on GFS2:
> >
> >   WARNING: (current->flags & PF_MEMALLOC) in iomap_writepages
> >   kswapd -> balance_pgdat -> shrink_node -> shrink_slab
> >   -> super_cache_scan -> prune_icache_sb -> evict
> >   -> gfs2_evict_inode -> evict_linked_inode -> gfs2_log_flush
> >   -> gfs2_ordered_write -> filemap_fdatawrite -> do_writepages
> >   -> gfs2_writepages -> iomap_writepages
>
> Oh, that's awful. Nothing should be calling into iomap_writepages
> from reclaim context.
>
> i.e. Doing data writeback from the inode cache shrinker is extremely
> suboptimal for many reasons, so I'd consider this a gfs2 bug, not an
> iomap issue. It's even worse when data writeback is being driven by
> an inode cache shrinker. I'm surprised that lockdep hasn't thrown a
> hissy-fit over this (i.e. inode locks taken in writeback appearing
> both above and below reclaim.
>
> This is the patch series that Jan Kara came up with to deal with
> these issues in inode eviction:
>
> https://lore.kernel.org/linux-fsdevel/20261009133253.20102-1-jack@suse.cz=
/
>
> This allows filesystems to defer inode eviction that might block
> (e.g. due to transaction reservations, journal commits, metadata
> read requirements, data writeback requirements, etc) to a context
> where the work is allowed to block and isn't running under memory
> reclaim context or restrictions.
>
> That patchset is needed for ext4, XFS alreayd does this, and it
> would seem that gfs2 needs it for glock reclaim....

Yes, Jan's deferred inode reclaim patch queue (plus a tiny gfs2 patch
on top) should take care of that.

I see that Jan wanted to send a v4 of this patch queue. Are there any
remaining serious problems?

> > Under memory pressure kswapd evicts GFS2 inodes whose glock is still
> > dirty, and gfs2_evict_inode() -> gfs2_log_flush() ->
> > gfs2_ordered_write() then writes back the ordered data of every inode
> > on sd_log_ordered.  This is long-standing, intentional behaviour: in
> > the default data=3Dordered mode GFS2 must flush dirty data before the
> > log commit that writes the metadata.
>
> It's also long standing, known broken behaviour w.r.t. shrinkers
> running in memory reclaim contexts.
>
> So, why doesn't this warning happen through the direct reclaim path?
> i.e.  what makes only kswapd trigger this?
>
> I see nothing that prevents direct reclaim doing inode eviction
> from triggering this same path through gfs2_evict_inode(). IOWs,
> direct reclaim should also be triggering the warning in
> iomap_writepages(), hence it is not clear to me why re-adding the
> kswapd guard is anything other than a band-aid over the broken code
> in gfs2....

It's also happening under direct reclaim. Here is an attempt at a fix
from before I was aware of Jan's patch queue that describes such a
scenario:

https://lore.kernel.org/gfs2/20260921211712.1563575-1-agruenba@redhat.com/

> > Writeback from kswapd has been
> > explicitly allowed since 2010, when the guard was still in XFS:
> > commit d4f7a5cbd544 ("xfs: allow writeback from kswapd"), because
> > the kswapd stack usage is low and it cannot deadlock on the
> > filesystem.
>
> No, that was a regression fix for turning off all writeback from
> reclaim in XFS as a 'what problems does stopping mm reclaim
> writeback actually cause' experiment. That was the first steps we
> took down the path to get rid of the problematic random dirty page
> writeback issues that memory reclaim had.
>
> IOWs, we didn't want to allow it, but we had to tolerate it because
> the MM behaviour was unfixable at the time. Now that the
> pageout()->.writepage() path for dirty filebacked page writeback is
> gone from the mm, we no longer have to tolerate this behaviour
> and so the guard got removed. It only took 15 years to get to this
> point....
>
> tl;dr: Writeback through iomap in memory reclaim context is -a bug-.
>
> > Beyond the noisy warning the new guard is actively harmful: it returns
> > -EIO on every hit (WARN_ON_ONCE only limits the report), while
> > gfs2_ordered_write() ignores the filemap_fdatawrite() return value, so
> > the log commit proceeds with metadata even though the ordered data was
> > never written, breaking the data-before-metadata ordering guarantee of
> > data=3Dordered mode.
>
> This is definitely a gfs2 bug - writeback can fail for -many-
> reasons, so ignoring IO submission failures when data integrity is
> required is a definitely filesystem bug.
>
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d6e2f1ded5ca..324da0f5cb29 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -2082,7 +2082,7 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
> >        * Writeback from reclaim context should never happen except in t=
he case
> >        * of a VM regression so warn about it and refuse to write the da=
ta.
> >        */
> > -     if (WARN_ON_ONCE((current->flags & PF_MEMALLOC)))
> > +     if (WARN_ON_ONCE((current->flags & PF_MEMALLOC) && !current_is_ks=
wapd()))
> >               return -EIO;
>
> AFAICT, direct reclaim will still trigger this warning and the bad
> gfs2 behaviour, so I'm struggling to see this as anything other than
> shooting the messenger...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> dgc@kernel.org

Thanks,
Andreas

