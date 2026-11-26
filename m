Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733426;
	b=yYA43oXOlkH8Ky8Bdvi9e/AMsQ/Ge4zZZJCKnAbL+hTuKG/PbPzB2bd8YKGHmsXqV0hh
	 fgNl4w28ecEeXSl6BjMTb5EmKF2RwxHXzc+Bp5B+14aj5UaGh24hmNOwsP/Ps5A2OiCDs
	 6eXDzAsQnOHQTZ3dLPPHw4v0K5Y4oPvp0Lxv0wZx9vDoBjdi6C93msTeXXaezEmLqim33
	 qjwE8Os+4fqcvp+7HiMbZhcxN1yL5uLhiPPY0KqtSUBycQNZBNnXJPo847vLCwra+ER8b
	 h/ISlhJnZGpnsLUnw0AV+hTr8ruwnZkTScUPJb7hO/Q3QsG4eQ0bMps5esDTseRRDbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733426;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=XJHUUqPJG742vUDQC9wjPH1jIvh4bumyltu7WWZvqTQ=;
	b=0mT2OPlFzLG0OSmdcdg47Wt7ebmUeSqIXQJxFGok5h2usirqvFLKiYmWwFRd/c8fsGI3
	 GxRdj1CYsCelrEmDTGTF7q5pk+3xHzdQX1cwr+2zSYg68NCp2zScUg/E8AzL+8kscevP6
	 IFIVWKNr1LougjKjdxx0RWFS/CkGElo19L2jT8GGVBU01wM75arzvsR5wcj5C7JdFqan4
	 gDKuZCloykRdxNlHBc/mJA5AN7BAPbvQSayfHXbTJAzNSqJefzAY5nydmgzEyCJ18QAdE
	 YXgLwwpG1x1pkXXT/qKX0qc62ie5g8CYgaJQxIgx+vOqMAq2RhwWAaI0ncn5UThXX/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hpEPG1m8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B72606A321
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 22:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B72606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hpEPG1m8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795733425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJHUUqPJG742vUDQC9wjPH1jIvh4bumyltu7WWZvqTQ=;
	b=hpEPG1m8aAOHMB6Dgs/8RZljY5UJkzoD86aYHbK54TO8xAHXsRcnsWukfqF/Y7yu6avGdY
	TcFPTAJqmIaeMnWbgB9/XguSA2B52WA5aPphHGaFHW25m5iWEFLrDNYbgEl7xVhVZs8Wze
	rvTDCebIPQWqJIDLXQ0s2AcJ9ZCSIEQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-1IMdCPDUOuCGsfsneuUiCA-1; Thu, 26 Nov 2026 22:50:23 +0000
X-MC-Unique: 1IMdCPDUOuCGsfsneuUiCA-1
X-Mimecast-MFC-AGG-ID: 1IMdCPDUOuCGsfsneuUiCA_1795733422
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b4ca583164so80676937b3.0
        for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 14:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795733422; x=1796338222;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJHUUqPJG742vUDQC9wjPH1jIvh4bumyltu7WWZvqTQ=;
        b=FTvQ8bbJEcg9KN3UeX6Gi0XTMU6+tX5kfcUxvH3xx/fUGPE8X0PGfIhrKQG+7bF+jy
         pxlPap8D2i8kzDffRBin2VrZFgvRASri5R0G/hffnFibWdTY6Sv4lBZ15rlbjlQRRtyu
         kL2zYtgKBEbnAN3caLwaZ3K1iy2soeK4PuKira/xkV2/q5auK17RFtGmbZIL1EnDUw+d
         mhqmxBAMdEYYeyL6Fg3+LXlXntChgoqFUFooCtQJBJHvq4m8dKpUG1MAy1srqgEWg7pi
         TbPvnqXgff9VJcWmmJ0dddzbe6OLDS7pF7huxYrgN+bg2kiyWDhAKq3r6iuEoLDiQk7o
         5q5Q==
X-Forwarded-Encrypted: i=1; AL+hErGy1kP+SYH41vNZE32L/LqR1cMryV2jETEPEtn/yBws8X1GDMsUNUnetR+ULd+fXDayS0q6@lists.linux.dev
X-Gm-Message-State: APuU4Z9KTQ5oLJ/+9FY9ky78utkoI0jV/dI8mmEWJQn0aTDzdsCNFa/0
	EOCy0nHCFt56EZUA6BTtwh+RZY6Bz9zlXVwJuukQ+UAue9iHTScDKa354jJwsF2vdNaofsUSWQa
	W+9GSQcuIDqsZ7tm0y1195oHqTODj8W10WHqJBfebehLnJ/MaiGGlZmA+spDgFedGliS7m+KvVL
	EJqbdD5IZwp7l5Vih28oLPbAcGfkaSuQ==
X-Gm-Gg: AZFdTZeie+Jrh90leO3iVLvTdWyJCyVkQWQsT+9CRD9cF02051ota5sPSOigWZ41rY0
	OIrZO970v5x3Duoyr1CFZrlqcsZK32mtVHWi3aCiWAcDAlPAkS0WZtMc1Y9Vws4ngiNBVDlVvV5
	uB3BkViAMCYeblzHGunZF164fuDO0GD+PneDghC4yK2xO2XCN4qunpI0ucX4YBjl+WagxvWp9Vy
	Xm2wKhKFNiFEtawRhlzxui33W36O75c9Tv8aNqycoOaJQ==
X-Received: by 2002:a05:690c:4507:b0:8b3:150b:43e1 with SMTP id 00721157ae682-8b5204b0e0cmr90968657b3.21.1795733422529;
        Thu, 26 Nov 2026 14:50:22 -0800 (PST)
X-Received: by 2002:a05:690c:4507:b0:8b3:150b:43e1 with SMTP id
 00721157ae682-8b5204b0e0cmr90968587b3.21.1795733422097; Thu, 26 Nov 2026
 14:50:22 -0800 (PST)
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
 <20261124-gfs2-log-folio-v2-1-f229e90c8285@columbia.edu> <sashiko-outbox-232028@kernel.org>
 <3f099de2-4fbb-45b0-ba7f-3a20f6ec7e4a@columbia.edu>
In-Reply-To: <3f099de2-4fbb-45b0-ba7f-3a20f6ec7e4a@columbia.edu>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 23:50:11 +0100
X-Gm-Features: Aa3M54orVwIjaRZfOs4hjRst8QmWhhTw8ndi0KtUDhIgN5-JL5xTvUFzOA8PpQc
Message-ID: <CAHc6FU4=F69DBO9GRAV+2Aoc4mDDp8Sr8A0aDE-Bpbf1_h+jhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gfs2: make the log page pool per superblock
To: Tal Zussman <tz2294@columbia.edu>
Cc: sashiko-reviews@lists.linux.dev, gfs2@lists.linux.dev, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zx3vPSvH0oXA02l__PmJUFUzQLNhbIOZ7NutM0na7pQ_1795733422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 22:55, Tal Zussman <tz2294@columbia.edu> wrote:
> On 11/24/26 4:16 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [High] gfs2: use-after-free on sd_log_buf_pool in gfs2_end_log_write()
> >    after free_sbd()
> > --
> >
> > commit 6dc37dfa05bee3bb13ea4a43812ebcbe3533794a
> > Author: Tal Zussman <tz2294@columbia.edu>
> >
> > gfs2: make the log page pool per superblock
> >
> > This commit replaces the global gfs2_page_pool mempool with a
> > per-superblock sd_log_buf_pool initialized in gfs2_fill_super() and
> > destroyed in free_sbd().
> >
> >> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> >> index 6ec47376aecf2..f62a893ce5a2b 100644
> >> --- a/fs/gfs2/ops_fstype.c
> >> +++ b/fs/gfs2/ops_fstype.c
> >> @@ -67,6 +67,7 @@ void free_sbd(struct gfs2_sbd *sdp)
> >>  {
> >>      struct super_block *sb = sdp->sd_vfs;
> >>
> >> +    mempool_exit(&sdp->sd_log_buf_pool);
> >>      free_percpu(sdp->sd_lkstats);
> >>      sb->s_fs_info = NULL;
> >>      kfree(sdp);
> >
> > [Severity: High]
> > Can free_sbd() destroy sdp->sd_log_buf_pool and free sdp while log bios
> > carrying pages from sd_log_buf_pool are still in flight?
> >
> > Previously, gfs2_end_log_write() returned pages to the global
> > gfs2_page_pool, which stayed alive until module unload.  Now it calls
> > mempool_free(page, &sdp->sd_log_buf_pool), while free_sbd() runs
> > mempool_exit(&sdp->sd_log_buf_pool) and kfree(sdp) without waiting for
> > sdp->sd_log_in_flight via log_flush_wait(sdp).
> >
> > Two paths can reach free_sbd() with log bios still in flight:
> >
> > 1. During journal recovery, clean_journal() calls gfs2_write_log_header(),
> >     which allocates a page from sdp->sd_log_buf_pool and submits
> >     jd->jd_log_bio asynchronously via gfs2_log_submit_write() without
> >     calling log_flush_wait(sdp).  If a subsequent step in gfs2_fill_super()
> >     fails after journal replay, or a read-only mount that replayed a
> >     journal is unmounted (where gfs2_put_super() skips gfs2_make_fs_ro()),
> >     free_sbd() runs without log_flush_wait(sdp).
> >
> > 2. In __gfs2_log_flush(), if the filesystem is withdrawn after
> >     lops_before_commit() or gfs2_log_submit_write() has submitted bios
> >     with pages from sdp->sd_log_buf_pool, it jumps to out_withdraw and
> >     skips log_write_header() and log_flush_wait(sdp):
> >
> > fs/gfs2/log.c:__gfs2_log_flush() {
> >      ...
> >       lops_before_commit(sdp, tr);
> >       if (gfs2_withdrawn(sdp))
> >               goto out_withdraw;
> >       if (sdp->sd_jdesc)
> >               gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
> >       if (gfs2_withdrawn(sdp))
> >               goto out_withdraw;
> >      ...
> > }
> >
> >     Subsequent unmount flushes return early because the filesystem is
> >     withdrawn, so free_sbd() is reached while those bios are still in
> >     flight.
> >
> > When the bio completes after free_sbd(), gfs2_end_log_write() hits a
> > use-after-free on sdp and sdp->sd_log_buf_pool (or dereferences NULL
> > pool->elements inside mempool_free()).  Calling log_flush_wait(sdp)
> > before mempool_exit() in free_sbd() would ensure all in-flight log bios
> > have completed.
> >
> This is mostly pre-existing (and the same issue as the other Sashiko
> report), but I can add a patch at the beginning of the series to fix it.
> I think adding a log_flush_wait() at the start of gfs2_jindex_free() should
> be sufficient.

Yes, it's a pre-existing problem. I've pushed a partial fix to for-next for now:

https://lore.kernel.org/gfs2/20261126224415.3049791-1-agruenba@redhat.com

Thanks,
Andreas

