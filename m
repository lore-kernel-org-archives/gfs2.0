Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97881C9DD6;
	Wed,  7 Aug 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033305; cv=none; b=bd4GFWbYRGmkQfvQnpOl7Ygn7xAcB0HfSMLUvuVgYsMw2v8rQlwrnalcMPdI4o17DAoDrj930tdP5bku6IRwPGlZZ51StquZ9iQy7bGD1RSlYHjuuZWHRP48VCc7EdnZfQZiNz29+vw74a9dvybvA5Mwy/Yuk5PNb7Q+d1uASLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033305; c=relaxed/simple;
	bh=l7TcIO1csvGx6kjhyKUQowUbhqEgKBOmsuZGPcWIBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaZM4Q170q/dnINFEyHmCfnJKRzSlptPICOd2LcZO1ZOFPfdAdTKVa5zKd6+Yv3VRwLj6jWS3RjNcJb1JNr+a2PypcjuGU4ARk8cqBpWolWVUYv6WbYKMdbRHax4jX7rT5zkyU94goSj+u4ZhVGc/yDtgNRFI9lqusDGKDXhqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=enol2k7M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="enol2k7M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=01hbJ+SofGGB7cpRH5QHBvHR4Rahe+jY5XQFkwRfm5E=; b=enol2k7M8rgW8c7JC6r54S5jEg
	D98ssNAta4QCBs14ooQL1rcEFzZveUEgKy7nmcP3M3R12nZKWwkricF1y0jRqNoMYTyQb4SB/dekN
	3zkM7zfATYxR9K218UhBopMJNK3MDHpXav92bkBlpe6z0l82MTUYZQqM0cIkh3cVabUH5lIhLThuf
	WP4mXxjmkhuPXtpAnFS8ccqUxUFmg6lLrDdgDBXti8vP8E9Vv71cuWpkJJ+NyFJ7ZyB4HcgkGDlZU
	tVI35YrkED9bTOSMoZzn1AxY2V3JM6ylhIbQFXq1/QLIWWQvqr7bG25yGDtleXNx4flcVXVEfldaK
	ZGFz2dMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbffi-00000007HGs-28Aq;
	Wed, 07 Aug 2024 12:21:42 +0000
Date: Wed, 7 Aug 2024 13:21:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove uses of aops->writepage from gfs2
Message-ID: <ZrNm1gh6Fsm0tIil@casper.infradead.org>
References: <20240719175105.788253-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719175105.788253-1-willy@infradead.org>

On Fri, Jul 19, 2024 at 06:51:00PM +0100, Matthew Wilcox (Oracle) wrote:
> Hi Andreas,
> 
> Here's my latest attempt to switch gfs2 from ->writepage to
> ->writepages.  I've been a bit more careful this time; I'm not sure
> whether __gfs2_writepage() could call gfs2_aspace_writepage(), but
> this order of patches shouldn't break any bisection.

ping

> Matthew Wilcox (Oracle) (4):
>   gfs2: Add gfs2_aspace_writepages()
>   gfs2: Remove __gfs2_writepage()
>   gfs2: Remove gfs2_jdata_writepage()
>   gfs2: Remove gfs2_aspace_writepage()
> 
>  fs/gfs2/aops.c    | 30 ------------------------------
>  fs/gfs2/log.c     | 12 ++----------
>  fs/gfs2/meta_io.c | 24 +++++++++++++++++-------
>  3 files changed, 19 insertions(+), 47 deletions(-)
> 
> -- 
> 2.43.0
> 
