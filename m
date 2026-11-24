Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555009;
	b=DgxDFvNQTSzSHcUsv4VZWXPOlGUmTMYec9Pq2qywvv2SHhFjK8TaNGEGBTqTVEBjGEB7
	 dE64rTOk56XDWu4z9UJZ1giRSYC+sg/R1f1a+Wc//WuwzTaTrTD3REl/sYs2UbmzRUF3o
	 NtGotGd7vFC6ijkaIFUvKr+/ixMhrBK8mDCOc6pNX7Ak0s1GwuvJvoSjnlCt7G9/+1UhP
	 XC244+OJI3Yut1TuyYcrzg7Z95AArfR+hmceN3XwN/VsKCwTHek5koISYSNa/ojRWnG2O
	 sv+gnc38dkmzUQPRKp8RN0VgyViJtgyEbPgs4mH8e5pIGbXNlJFZevBXnotu95Y4wZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UJDqH836O3jaf3OpMJYmVvj77+2OHU7GEjQgDNSGG2k=;
	b=QTQk/g11EiD5Ep4Pbx1/x7B/59GetFiRQqxGa8nAKTX8WwIA+82SnjGXMyiOthS8a6hi
	 sMykRS5HL9eNqb5AlJJvoY/ooREZPkVFq2Kkb751Te3aiJ3S4dDCscaxATYHxi+zuaHlj
	 85eeEJr+ijotzzta7/RqzqM8VKeSR0tdeByuS6MK3Py8b4Cj6ARAWF+OV9mT2v7+RnPFW
	 LUSajXwv2nuphcXTRXKqNiKBN2LUw9+ZvAh8b+NBftocgCuVK8R5sRsPSeeKH/CS0Bt3Y
	 pqFAypCKwkg9X/EliwCNG+qI8GbsxBth2obDMCFWhdpzFdQ7Z7dWsPq+37GDeZE1jYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQT6BtKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEF606A6B4
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQT6BtKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B721F000D0;
	Tue, 24 Nov 2026 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555008;
	bh=UJDqH836O3jaf3OpMJYmVvj77+2OHU7GEjQgDNSGG2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AQT6BtKIqzAmbN19kewJJyUg0/rxywIit6/skhSUIvqR790gKgbrsE/7I9EQIVK/v
	 oT4NbH7IscBBfnZ+J9EGByZWMjI+kd/pLCdWiTU8bhXxOxuE822glmu4ZwAzc00NUJ
	 pa0rrNmC5n5CiDPwGhdNEolZ9gLv3DNTUr1tSOP1LmPDK6Ue14XYhYleqLsQSx6anx
	 j6mUeiQ2uq2m+i4kBdWni3i0jKfvFUk6qPGyEQFDfmdWjt0/fWtMpZXjrr8ksRsC+g
	 Y611dMPYMR4S/DG7/JdZVOpQhenqF6JIQEkSiBYq/Sl02hW4H+G+O0EOwIEFCtD2ga
	 rW/G3lpCrNTCw==
Message-ID: <sashiko-outbox-232028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] gfs2: make the log page pool per superblock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tal Zussman" <tz2294@columbia.edu>, "Andreas Gruenbacher" <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>
In-Reply-To: <20261124-gfs2-log-folio-v2-1-f229e90c8285@columbia.edu>
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
 <20261124-gfs2-log-folio-v2-1-f229e90c8285@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:16:48 +0000
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] gfs2: use-after-free on sd_log_buf_pool in gfs2_end_log_write()
  after free_sbd()
--

commit 6dc37dfa05bee3bb13ea4a43812ebcbe3533794a
Author: Tal Zussman <tz2294@columbia.edu>

gfs2: make the log page pool per superblock

This commit replaces the global gfs2_page_pool mempool with a
per-superblock sd_log_buf_pool initialized in gfs2_fill_super() and
destroyed in free_sbd().

> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 6ec47376aecf2..f62a893ce5a2b 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -67,6 +67,7 @@ void free_sbd(struct gfs2_sbd *sdp)
>  {
>  	struct super_block *sb =3D sdp->sd_vfs;
> =20
> +	mempool_exit(&sdp->sd_log_buf_pool);
>  	free_percpu(sdp->sd_lkstats);
>  	sb->s_fs_info =3D NULL;
>  	kfree(sdp);

[Severity: High]
Can free_sbd() destroy sdp->sd_log_buf_pool and free sdp while log bios
carrying pages from sd_log_buf_pool are still in flight?

Previously, gfs2_end_log_write() returned pages to the global
gfs2_page_pool, which stayed alive until module unload.  Now it calls
mempool_free(page, &sdp->sd_log_buf_pool), while free_sbd() runs
mempool_exit(&sdp->sd_log_buf_pool) and kfree(sdp) without waiting for
sdp->sd_log_in_flight via log_flush_wait(sdp).

Two paths can reach free_sbd() with log bios still in flight:

1. During journal recovery, clean_journal() calls gfs2_write_log_header(),
   which allocates a page from sdp->sd_log_buf_pool and submits
   jd->jd_log_bio asynchronously via gfs2_log_submit_write() without
   calling log_flush_wait(sdp).  If a subsequent step in gfs2_fill_super()
   fails after journal replay, or a read-only mount that replayed a
   journal is unmounted (where gfs2_put_super() skips gfs2_make_fs_ro()),
   free_sbd() runs without log_flush_wait(sdp).

2. In __gfs2_log_flush(), if the filesystem is withdrawn after
   lops_before_commit() or gfs2_log_submit_write() has submitted bios
   with pages from sdp->sd_log_buf_pool, it jumps to out_withdraw and
   skips log_write_header() and log_flush_wait(sdp):

fs/gfs2/log.c:__gfs2_log_flush() {
    ...
	lops_before_commit(sdp, tr);
	if (gfs2_withdrawn(sdp))
		goto out_withdraw;
	if (sdp->sd_jdesc)
		gfs2_log_submit_write(&sdp->sd_jdesc->jd_log_bio);
	if (gfs2_withdrawn(sdp))
		goto out_withdraw;
    ...
}

   Subsequent unmount flushes return early because the filesystem is
   withdrawn, so free_sbd() is reached while those bios are still in
   flight.

When the bio completes after free_sbd(), gfs2_end_log_write() hits a
use-after-free on sdp and sdp->sd_log_buf_pool (or dereferences NULL
pool->elements inside mempool_free()).  Calling log_flush_wait(sdp)
before mempool_exit() in free_sbd() would ensure all in-flight log bios
have completed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-gfs2-log-f=
olio-v2-0-f229e90c8285@columbia.edu?part=3D1
