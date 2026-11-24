Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555314;
	b=kqAxwlkgFZleFCOc8YwnGeWBvBsYayKF7IwHHsRODN+LAhJYILGZNoHt/MPVTcyGLzK4
	 n2YWwi5BuMgqvCipZR8FjXS4vdJVKE7rgQhEYBnVKFdpqk4GeQQDa8StEyAHfbDSt40g1
	 eH2L7EppHRIadtZNbHi79IMR6QHtxm041BwS+xuJtSj7fjiUflQRB0CEp4fBJlMhhemRw
	 XjslioBdZaKnPXDg5sOg2mdvBzstTinRSutv80cPaTvBjiS4hbTpsjRIubMpp8sjgvfxH
	 9zKsEKJsIE1WrZ9pAOp2kVky7u+o1LUDv0SdK/DWsp5LpEpb5tztazWGZ2wZuIaG38w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CHeLN1LfDGjhTV8o6NiGddyXHKExfbg/vY/tn0htNrU=;
	b=qtZfFIo+EV35zevauG1aR5KOskUkKeArysk3hjE3tjoMwlIlfO1d32muvAahvXZpruiE
	 0CEEegNlhDn6wP/CUMniDus00N9kX3xpgQeKkik1pg33IY22G5hTLDH6TI958Xtsq9s2w
	 K2XuavmODMN3Wx/OND7loCcdcg/ox3zeswaFO6RSrhHLpOJdJ2Bhj2C266SLxtbyKCf0Z
	 EbeyWGhIFmbCmf+lHii2Zt6KNLcEoKVH4ZbFcFrTHZy4+dZqfwyQu8Y/7WGlWjvv9Yr3g
	 UhDfENMg0aCg9HMXZ6quMN4TcFiWcZwRxrQKm/9zMvhw2lwMQjsOhV/vN3NaMMAIpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H+DddsH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F56606A31E
	for <gfs2@lists.linux.dev>; Tue, 24 Nov 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+DddsH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574131F000C6;
	Tue, 24 Nov 2026 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555313;
	bh=CHeLN1LfDGjhTV8o6NiGddyXHKExfbg/vY/tn0htNrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+DddsH/Ksomz/reAWsEiSbZJpQgZekSgI//zqLZTD5RtSnzjE9ED5zCI8bi6pJgr
	 0CTZzakc9kl1fR7MIUKjJHrf00NyPIJWpfLwtrW3GR+un1s8fyAk6lREr3ELSsmDCT
	 qbtZ43XmLS3boobciYf06C98IVjXehjUbjFrYNgLe9mbjpedQG1IWTanuXWE+oNLOM
	 SfKrBb/ur+JnRnXLYMglUiz7c5RI0FQT0Lja5e7gkSi5CvkcNCo2LUwl7LARMwMXjN
	 azY1+tj5lBMEE6NwWvULKoPkA1GZApE6pVmTCtMaJm/sCoR4DxJWZApJvjNWZiOyea
	 FLuLEgAF6Uv3w==
Message-ID: <sashiko-outbox-232037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] gfs2: stop using pages for log buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tal Zussman" <tz2294@columbia.edu>, "Andreas Gruenbacher" <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>
In-Reply-To: <20261124-gfs2-log-folio-v2-2-f229e90c8285@columbia.edu>
References: <20261124-gfs2-log-folio-v2-0-f229e90c8285@columbia.edu>
 <20261124-gfs2-log-folio-v2-2-f229e90c8285@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:21:52 +0000
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
- [Medium] gfs2: use-after-free of sdp in gfs2_end_log_write_buf() on
  teardown
--

commit f7b4eeef3695e09c06bd25c0916b1f82335a68b3
Author: Tal Zussman <tz2294@columbia.edu>

gfs2: stop using pages for log buffers

This commit replaces the per-superblock page mempool for log buffers with a
kmalloc mempool of block-sized buffers and gives pool blocks their own bio
completion handler, gfs2_end_log_write_buf(), splitting bios whenever the
completion handler changes.

> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 7a2c29652feca..156d7c6341ca1 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -196,45 +196,70 @@ static void gfs2_end_log_write_bh(struct gfs2_sbd *=
sdp, struct folio *folio,
>  	} while (bh && size);
>  }
> =20
[ ... ]
> +static void gfs2_end_log_write_buf(struct bio *bio)
> +{
> +	struct gfs2_sbd *sdp =3D bio->bi_private;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	if (bio->bi_status)
> +		gfs2_log_write_error(bio);
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all)
> +		mempool_free(bvec_virt(bvec), &sdp->sd_log_buf_pool);
> +
> +	gfs2_log_write_done(bio);
>  }
> =20
>  /**
> @@ -291,9 +316,9 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd=
 *sdp, u64 blkno,
>   * @flush: Always flush the current bio and allocate a new one?
>   *
>   * If there is a cached bio, then if the next block number is sequential
> - * with the previous one, return it, otherwise flush the bio to the
> - * device. If there is no cached bio, or we just flushed it, then
> - * allocate a new one.
> + * with the previous one and the bio has the same completion handler,
> + * return it, otherwise flush the bio to the device. If there is no
> + * cached bio, or we just flushed it, then allocate a new one.
>   *
>   * Returns: The bio to use for log writes
>   */
> @@ -309,7 +334,7 @@ static struct bio *gfs2_log_get_bio(struct gfs2_sbd *=
sdp, u64 blkno,
> =20
>  		nblk =3D bio_end_sector(bio);
>  		nblk >>=3D sdp->sd_fsb2bb_shift;
> -		if (blkno =3D=3D nblk && !flush)
> +		if (blkno =3D=3D nblk && bio->bi_end_io =3D=3D end_io && !flush)
>  			return bio;
>  		gfs2_log_submit_write(biop);
>  	}

[Severity: Medium]
Can gfs2_end_log_write_buf() and gfs2_log_write_done() use sdp after
free_sbd() has freed it?

Because gfs2_log_get_bio() now submits the current bio whenever
bio->bi_end_io changes between gfs2_end_log_write_buf and
gfs2_end_log_write, lops_before_commit() submits log bios before
__gfs2_log_flush() checks for withdraw:

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

Jumping to out_withdraw skips log_write_header() and log_flush_wait(sdp),
and clean_journal() likewise submits a log header bio via
gfs2_write_log_header() without calling log_flush_wait(sdp).  Neither the
withdrawn unmount path nor free_sbd() waits for sdp->sd_log_in_flight to
reach zero before calling mempool_exit(&sdp->sd_log_buf_pool) and
kfree(sdp):

CPU0                                  CPU1 (bio completion)
__gfs2_log_flush()
  lops_before_commit()
    ...
      gfs2_log_get_bio()
        gfs2_log_submit_write()
  if (gfs2_withdrawn(sdp))
    goto out_withdraw;
...
deactivate_locked_super()
  ...
    free_sbd(sdp)
      mempool_exit(&sdp->sd_log_buf_pool)
      kfree(sdp)
                                      gfs2_end_log_write_buf(bio)
                                        mempool_free(...,
                                          &sdp->sd_log_buf_pool)
                                          <-- use-after-free
                                        gfs2_log_write_done(bio)
                                          atomic_dec_and_test(
                                            &sdp->sd_log_in_flight)

Waiting on log_flush_wait(sdp) before mempool_exit(&sdp->sd_log_buf_pool)
in free_sbd() (and in out_withdraw) would ensure all in-flight log bios
have completed before sdp is torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-gfs2-log-f=
olio-v2-0-f229e90c8285@columbia.edu?part=3D2
