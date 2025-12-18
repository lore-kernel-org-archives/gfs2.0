Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F961DB54C
	for <gfs2@lists.linux.dev>; Thu, 18 Dec 2025 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038405; cv=none; b=Xz+6QXj7BdARZslF76iVnNnCgxerD+FZuZpxA5JR/rHuYI9jvZKvos1M0/61841+apHEjgSS9NWge8J60OjMWFXPpn8DudAMXvJygodlRu9VEJxTAzb7VWz4f1HOQ+/xHTxTwll+GHvTVTB+lw7cb5ucIyQnosPrrBTsl7lmCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038405; c=relaxed/simple;
	bh=ZBYUW2in9iDytsK8dgp3TVcKqNV9Uzw5cFn++gKN9gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJpUtsFtlbor62MAqg0Us96YMw+HgYGKNCCiIix2u7l0w1n1wFSx1q+VMuMcanRwGma176J9jZK6PExbNyxtyk8FNSh+PQZJpPdNmq4dl6afRZ687lXuyNuxcuWw/5ndGcIqkPYpc7zqXKvV/FS9fJGf8Y+jTLt33P9hka3p0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41DC7227A88; Thu, 18 Dec 2025 07:13:18 +0100 (CET)
Date: Thu, 18 Dec 2025 07:13:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, io-uring@vger.kernel.org,
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 07/10] fs: add a ->sync_lazytime method
Message-ID: <20251218061317.GA2775@lst.de>
References: <20251217061015.923954-1-hch@lst.de> <20251217061015.923954-8-hch@lst.de> <ghtgokkzdo7owrkfkpittqlc6xvjhr5w4eprbq5gcszqpmy7z3@7m3ecvlqfrzu>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghtgokkzdo7owrkfkpittqlc6xvjhr5w4eprbq5gcszqpmy7z3@7m3ecvlqfrzu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 17, 2025 at 01:30:18PM +0100, Jan Kara wrote:
> >  	if (flags & I_DIRTY_INODE) {
> > +		bool was_dirty_time =
> > +			inode_state_read_once(inode) & I_DIRTY_TIME;
> > +
> >  		/*
> >  		 * Inode timestamp update will piggback on this dirtying.
> >  		 * We tell ->dirty_inode callback that timestamps need to
> >  		 * be updated by setting I_DIRTY_TIME in flags.
> >  		 */
> > -		if (inode_state_read_once(inode) & I_DIRTY_TIME) {
> > +		if (was_dirty_time) {
> >  			spin_lock(&inode->i_lock);
> >  			if (inode_state_read(inode) & I_DIRTY_TIME) {
> >  				inode_state_clear(inode, I_DIRTY_TIME);
> >  				flags |= I_DIRTY_TIME;
> > +				was_dirty_time = true;
> 
> This looks bogus. was_dirty_time is already true here. What I think you
> wanted here is to set it to false if locked I_DIRTY_TIME check failed.
> Otherwise the patch looks good.

Or better set it to false at initialization time and only set it to
true here to simply things a bit.  But otherwise: yes.
