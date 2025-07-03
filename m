Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AE2E54C6
	for <gfs2@lists.linux.dev>; Thu,  3 Jul 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545168; cv=none; b=sNwHwcOKNdQ3BXFzMNEB0psGsrPX/EuVUg0GeMeGudORGoW7rQgn3Rxn6sAp39x2/syJphlzkS0ARtricMWBLuyj5b6UOJpzbkbYEQnpO5MOglqmUcffwEjrn9a4EUUfohjZheh0riS9RxTyFzRW+Fx5uaG7NDigY+tonbJolCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545168; c=relaxed/simple;
	bh=IctvpTvjCZ0AmNIvJgrRHYVJcl3Ssd5ljbs5s0DK1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGlNkmaSEq+gheyFxszxvvxKxxtLQEeT2InwToLV3/48C+NubfpU9DN9e3BPAunqRbCqmTZF8xdiqpkktilsfgTnIDnD1PfuCW6myjS6SZWRvQXfEomELVlWyfexTUtifot8ti4ss28aeex0QgvAZJIYXg8FIfWSqrDR02BjK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBB5468C4E; Thu,  3 Jul 2025 14:19:22 +0200 (CEST)
Date: Thu, 3 Jul 2025 14:19:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	hch@lst.de, miklos@szeredi.hu, brauner@kernel.org,
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 04/16] iomap: hide ioends from the generic writeback
 code
Message-ID: <20250703121922.GB19114@lst.de>
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-5-joannelkoong@gmail.com> <20250702173819.GX10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702173819.GX10009@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 10:38:19AM -0700, Darrick J. Wong wrote:
> > -Filesystems that need to update internal bookkeeping (e.g. unwritten
> > -extent conversions) should provide a ``->submit_ioend`` function to
> > -set ``struct iomap_end::bio::bi_end_io`` to its own function.
> > -This function should call ``iomap_finish_ioends`` after finishing its
> > -own work (e.g. unwritten extent conversion).
> > -
> 
> I really wish you wouldn't delete the documentation that talks about
> what sort of things you might do in a ->writeback_submit function.
> That might be obvious to us who've been around for a long time, but I
> don't think that's so obvious to the junior programmers.

Because it's somewhere between wrong and totally arbitrary.  That whole
file is a real pain in the but because of that approach and I really
should have fought against adding it much harder.

> >  /*
> > - * Submit an ioend.
> 
> Please retain the summary.

The summary is split up into comments in the places where it makes
sense now.

> >  
> > -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> > +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> >  new_ioend:
> > -		error = iomap_submit_ioend(wpc, 0);
> > -		if (error)
> > -			return error;
> > -		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> > +		if (ioend) {
> > +			error = wpc->ops->writeback_submit(wpc, 0);
> 
> Should we call ioend_writeback_submit directly if
> !wpc->ops->writeback_submit, to avoid the indirect call hit for simpler
> filesystems?

No.  Compared to all the other indirect calls here it doesn't matter,
and having arbitrary defaults tends to cause problems down the road.

