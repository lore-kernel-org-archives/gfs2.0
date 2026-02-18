Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A2238C29;
	Wed, 18 Feb 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449287; cv=none; b=qaw5rtmHzVoVrAzM/fb0E826TQZumHKp+eyEpDavT6iEcNvO2/JWi1TEDe0Wq9wDmZhkyv23AZkx105J9ZZAsLp6Au2qsaXD2anRoUQfrDC6VXgVGjWvZiXf6048f6sK2uj68FJvd6Cu+r795qKVw+4PE7WsHryPFs7v+pM68ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449287; c=relaxed/simple;
	bh=wVx219ffeza7zC7WT4tOgbnlA8+iRvyvxB9nzEcnhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZHQ9U4fRdo9SU6LZ22czl7fQHt1KnBQ/cf8fIdauTWezyoYnwsBtBdXGYZwtutbeZ1CrzNvy/TxwBWWcNwiPw62IyExKRPAc2Csy+r4BessIrDAJlIDGjazJqpY3iGmjSybyfnz4u46pTH8AYXux+99ffQStucMxC1kH4LCMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EAdn3wEs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EAdn3wEs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdk2bHcjnO4us0TQM2pJRbGWdbcnS5cK+sRumh54uVc=; b=EAdn3wEsQ9i9jM99T30On2Iyh2
	zd0IxI8KfEVa9mwj+pJA3WAbQU37CBiGnecxkN2Sj1P1m3urjc7DjAURw+25EeazK/hnb2FSNycd/
	Rm0gjTxkgq7LLYn6y9+MwHugSWIElX0J4MlGVXsg0/2Ogu/SynyMFRf+nlg5JSC66BzMQ/9fAIFID
	iJ/Hocv9Le7dpuX1kBuLQGUgV2zPNf/jMBNEbxe1ZLDmAMU4MbT/CCBmUlNYLlRQSFPKj6QRTuWRw
	OtToTT2Ckf7kPCII4KL6ObxN5mWwaGN5CYtoBYVS2FWt73Nj4KrdJN00gogezqKx+/sVjQNGw9bJf
	ziPxTNkw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsosd-00000006efG-195J;
	Wed, 18 Feb 2026 21:14:43 +0000
Date: Wed, 18 Feb 2026 21:14:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Fix error pointer dereference
Message-ID: <aZYrw29iK1ak5Npw@casper.infradead.org>
References: <20260218200645.15713-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218200645.15713-1-ethantidmore06@gmail.com>

On Wed, Feb 18, 2026 at 02:06:45PM -0600, Ethan Tidmore wrote:
> The function __filemap_get_folio() can return an error pointer and is
> not checked for one. Add check for error pointer.

Can you explain how __filemap_get_folio() would fail, given the
presence of __GFP_NOFAIL in the GFP flags?

> Detected by Smatch:
> fs/gfs2/meta_io.c:147 gfs2_getbuf() error:
> 'folio' dereferencing possible ERR_PTR()
> 
> Fixes: 0eb751791df86 ("gfs2: convert gfs2_getbuf() to folios")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  fs/gfs2/meta_io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 3c8e4553102d..9c0ba4c3cb29 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -144,6 +144,8 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
>  		folio = __filemap_get_folio(mapping, index,
>  				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>  				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
> +		if (IS_ERR(folio))
> +			return NULL;
>  		bh = folio_buffers(folio);
>  		if (!bh)
>  			bh = create_empty_buffers(folio,
> -- 
> 2.53.0
> 
