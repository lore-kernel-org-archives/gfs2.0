Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733759;
	b=ufWrknI9Z16RFaZVwrdnj3Ye75y5OtQfX32EP+Rv/yhL7FLu9RK/zMWZ/zV3TuQhUuxI
	 qan5IMK7JU173m++bJtTSQu2RAgKU49KZ5ctzVySgI9XCEEz6lUGhP8z/BRS2Fniop+Km
	 K0FVhsvXhgU3xRZIM5Wky8jXdR0aXVjaknvQ0aejY0G9Su4IST/fg3V+aizISZiPu+mOH
	 H7Bzobvbl2r5YoMS9s9I5xHoHL3plfx8D1Ju0kZ5GxQpi5KQdr2EHXtcUh5xlzDXxo2Ej
	 0IRTUD/CjBnrEEBWwAbsLs4SVUrdjlQWmeOUTJ2wN+z0CSACiJffy/dvqfIWw9IhxGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wPi8Yn64kIhoLFg4v44EMqW9wyLI59hGIdDDLkyciE0=;
	b=nzvOnw2rtSYf1DknraE4paul92qKmAURwII7y1tQLm2GH/26GvujKxRIpNdQHk5C4GHP
	 Lm6btOpO1rH2DGpHEioeqNryGeFzOkVB2y/vab+Kj9KtbYh5qH2TxWz+gxoR2oYbOhc5g
	 7MjxVhdCyOIXNlw5rg6TfNbJWMRwGlUb65rDRvBgUuDi5eYTbKpl04gbYeR9KnvmCOgyZ
	 J9eAVD5cmV7l8+wABl0Kk52XfQzNXIet+HqLMnZOgzjmk6UqM+xGDEBhjkrD/Gkzxkp+B
	 on+bkmWGM+7U8dBVEfJX68QRfAk45FewZFEQg/01Bk5+aHTIhIkXbZ8MrB76O9iXEzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLSYa8iY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5E606A31C
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLSYa8iY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9141F00893;
	Thu, 26 Nov 2026 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795733759;
	bh=wPi8Yn64kIhoLFg4v44EMqW9wyLI59hGIdDDLkyciE0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LLSYa8iYEQChzqEnAK2g1oCXkgQUB5NPrZ7RIoazH8Jh8qYwBY0GFjEgupL9Boaqk
	 z7eH1gVSTHy2YTNnDnRNS724SIPIZj0d43O4A5RBl+QFe340fUxItZagpe0R2piWuy
	 C1Y7i07y/BvMU+IEugUDL7LF4YoNi9GFhjlW5/vlCazL53iOiUushdHqpJLZjvmN06
	 qeQukok082hqY2hYGXr9Wy2/It5qXFFZw17IrIiDjkc9LZhCprYmsbYGY5GZ8JRAXa
	 9LlXdXhQ4eiF7PxMKAdhnvEmo3A9lc6qGFRaq7iED6w7RiD0vN+kadK1vYhY/DRnMa
	 qGZW0HfcuOcrA==
Message-ID: <sashiko-outbox-236316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gfs2: wait for bio in gfs2_write_log_header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Gruenbacher" <agruenba@redhat.com>, gfs2@lists.linux.dev
In-Reply-To: <20261126224415.3049791-1-agruenba@redhat.com>
References: <20261126224415.3049791-1-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 22:55:58 +0000
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] gfs2: early withdraw returns in gfs2_write_log_header() skip
  log_flush_wait()
- [Low] gfs2: missing Fixes: trailer for commit 4a3d049db42b in commit
  message
--

commit 189e12a17911781cb0db12a8bd02ce7d201fa367
Author: Andreas Gruenbacher <agruenba@redhat.com>

> gfs2: wait for bio in gfs2_write_log_header
>
> During journal recovery, clean_journal() calls gfs2_write_log_header(),
> which allocates a page from gfs2_page_pool, puts that page in a bio, and
> submits the bio.  If a subsequent step in gfs2_fill_super() fails after
> journal replay, or a read-only mount that replayed a journal is
> unmounted (where gfs2_put_super() skips gfs2_make_fs_ro()), the journal
> glock can get dropped before the bio completes.  Also, if the module is
> immediately removed, gfs2_page_pool can get destroyed before the page is
> freed.
>
> This very unlikely race was pointed out by Sashiko.
>
> Fix by moving the call to log_flush_wait() from log_write_header() to
> gfs2_write_log_header().
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

[Severity: Low]
Should this include a Fixes tag for the commit that moved log_flush_wait()
out of gfs2_write_log_header()?

  Fixes: 4a3d049db42b ("gfs2: Don't wait for journal flush in clean_journal=
")

> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 1baaaf30c4fa6..db40045ee2d0a 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -908,6 +908,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, stru=
ct gfs2_jdesc *jd,
>  	gfs2_log_write(sdp, jd, page, sb->s_blocksize, 0, dblock,
>  		       REQ_OP_WRITE | op_flags);
>  	gfs2_log_submit_write(&jd->jd_log_bio);
> +	log_flush_wait(sdp);
>  }
> =20
>  /**
> @@ -935,7 +936,6 @@ static void log_write_header(struct gfs2_sbd *sdp, u3=
2 flags)
>  			      sdp->sd_log_flush_tail, sdp->sd_log_flush_head,
>  			      flags, op_flags);
>  	gfs2_log_incr_head(sdp);
> -	log_flush_wait(sdp);
>  	log_pull_tail(sdp);
>  	gfs2_log_update_head(sdp);
>  }

[Severity: Medium]
Can moving log_flush_wait(sdp) to the bottom of gfs2_write_log_header()
leave transaction payload bios in flight when the filesystem withdraws?

__gfs2_log_flush() submits payload bios through lops_before_commit() and
gfs2_log_submit_write() before calling log_write_header().  If the
filesystem withdraws before gfs2_write_log_header() reaches
gfs2_log_submit_write() (or if gfs2_get_extent() fails there), the early
returns in gfs2_write_log_header() bypass log_flush_wait(sdp):

fs/gfs2/log.c:gfs2_write_log_header() {
	...
	if (gfs2_withdrawn(sdp))
		return;
	...
		ret =3D gfs2_get_extent(jd->jd_inode, lblock, &dblock, &extlen);
		if (gfs2_assert_withdraw(sdp, ret =3D=3D 0))
			return;
	...
}

Before 4a3d049db42b ("gfs2: Don't wait for journal flush in
clean_journal"), the gfs2_withdrawn(sdp) check jumped to an out label that
still called log_flush_wait(sdp).  Without that wait, __gfs2_log_flush()
finishes while earlier payload bios are still in flight, allowing unmount
and module removal to free sdp and destroy gfs2_page_pool before
gfs2_end_log_write() runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126224415.3049=
791-1-agruenba@redhat.com?part=3D1
