Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0E2D949B
	for <gfs2@lists.linux.dev>; Mon,  7 Jul 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898497; cv=none; b=GWPGJRAt/8tP3VGd+VgZi4PaAtM8AaQiwA6MZCvicLz6FzVqTIdqZCbDjklh9xAoaffPmsKdtJjVQ8y1gLGAd9rKnxxOHdjk42x48A+yT2M0rBxy00pIqgKpYUqi/Bd0c4TDq0AEkIEb6OLlL89m7rpZXNqoT4wqcTSTJHLCmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898497; c=relaxed/simple;
	bh=oLaPuwfjVO73biwwsB01ZxZBB9jRIqrj9ERo8AWuhBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUR8p5KHyW4eFP6HUZM45wNUtOiIfo8m5LN3QxEWhgo3st4te1A21WQzVXlDVWW+4L/Dy9kUCgXq6PfQQZCfdsSELYGmfOB8C2Wm9ot0l//FuJfRjoTX5z2fKGSZrGG6wjdxahsRqU6W/USoLTYLaHXwyWbqUo4dHVVEJS2EYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B34E68C7B; Mon,  7 Jul 2025 16:28:09 +0200 (CEST)
Date: Mon, 7 Jul 2025 16:28:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>, jack@suse.cz,
	miklos@szeredi.hu, agruenba@redhat.com,
	Trond Myklebust <trondmy@kernel.org>, anna@kernel.org,
	Matthew Wilcox <willy@infradead.org>, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	Jens Axboe <axboe@kernel.dk>, ritesh.list@gmail.com,
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250707142809.GA31459@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org> <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com> <20250702184312.GC9991@frogsfrogsfrogs> <20250703130500.GA23864@lst.de> <CALYkqXqE1dJj7Arqu_Zi4J5mTVhzJQt=kzwjS9QaY5VaFcV3Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYkqXqE1dJj7Arqu_Zi4J5mTVhzJQt=kzwjS9QaY5VaFcV3Lg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 04, 2025 at 12:32:51PM +0530, Kundan Kumar wrote:
> bdi is tied to the underlying block device, and helps for device
> bandwidth specific throttling, dirty ratelimiting etc. Making it per
> superblock will need duplicating the device specific throttling, ratelimiting
> to superblock, which will be difficult.

Yes, but my point is that compared to actually having a high performing
writeback code that doesn't matter.  What is the use case for actually
having production workloads (vs just a root fs and EFI partition) on
a single SSD or hard disk?

> > If someone
> > uses partitions and multiple file systems on spinning rusts these
> > days reducing the number of writeback threads isn't really going to
> > save their day either.
> >
> 
> in this case with single wb thread multiple partitions/filesystems use the
> same bdi, we fall back to base case, will that not help ?

If you multiple file systems sharing a BDI, they can have different
and potentially very different requirements and they can trivially
get in the way.  Or in other words we can't do anything remotely
smart without fully having the file system in charge.
