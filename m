Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30921D6AA
	for <gfs2@lists.linux.dev>; Wed,  7 Jan 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771179; cv=none; b=Azuo3EZQT4xvZy3CEGFvWoIpDXH21ymgOnXBfdVgg+wERKZgQfCsbe2xbcemVVaoYaEqEo7VS90R0Fjr/A9nrwfK8y4yW79o0FkLbNj/Sk2gmGbb9eHQPHX9s4AQVsmugBL0bNWaFLJgwtim/wYy2YWpJfOxqdtHUO/vTyUgt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771179; c=relaxed/simple;
	bh=rcNkEg2r6U/yIEY7iukyvq5YvWXgri4jOz/NbgAd+eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgGtwq4eOWWYjaSfYHBH59873MvHvCeKsPzDpCXAr1yR0KBtrNOkWSA6U3F2jnhsgpYxrij1Q8llvEgXeLXcstpVRuCKST2WHE2M42zWto2h4/c+TnvaEXgD+0NI1ZvBs0tQLbWJ5DzeoFjydvd6whLtM+ml/KgH1CVlwFRihqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C876467373; Wed,  7 Jan 2026 08:32:47 +0100 (CET)
Date: Wed, 7 Jan 2026 08:32:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, io-uring@vger.kernel.org,
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: re-enable IOCB_NOWAIT writes to files v4
Message-ID: <20260107073247.GA17448@lst.de>
References: <20251223003756.409543-1-hch@lst.de> <20251224-zusah-emporsteigen-764a9185a0a1@brauner> <20260106062409.GA16998@lst.de> <20260106-bequem-albatros-3c747261974f@brauner>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-bequem-albatros-3c747261974f@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 06, 2026 at 10:43:49PM +0100, Christian Brauner wrote:
> > Umm, as in my self reply just before heading out for vacation, Julia
> > found issues in it using static type checking tools.  I have a new
> > version that fixes that and sorts out the S_* mess.  So please drop
> > it again for now, I'll resend the fixed version ASAP.
> 
> It has never been pushed nor applied as I saw your mail right before all
> of that.

Thanks.  But maybe you can fix up the applied messages to be more
specific?  We had various issues in the past with them, where they
were sent, but things did not end up in the tree for various reasons.
