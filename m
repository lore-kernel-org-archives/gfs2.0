Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0453324B2C
	for <gfs2@lists.linux.dev>; Wed, 19 Nov 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537389; cv=none; b=ZstuaJdGsZiVyDyRoVGm75q7zHZRcM68tBMzS+ZL5AhHW8PmIeUoWuWKIw/FnoJ2lNMsDaBOvXNnGfVwWp8LTSs6VNca6hqehMuG5RnRBZl5gH939tyxmNihs1pyLpp2JIaI/CrtWluXs7ATHsnTRr4ZVJQkKQPlJz4roD5rdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537389; c=relaxed/simple;
	bh=Ir9vKPk2ue6Qowb7dkYYIpK7Hca70wksIRCj1Rf1biI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIe3/eRWLtSMl2AwPxRJH/Qoz6r6MCdprP3wdVRc/R34CKh3iJFzyShLcWKf+bfwHRmFsf6ZWYGubjyO2tQ0cRyc7Uil3I1JDPvxx6nOVfjVfshOZfGrKoKHWb1ava/wXPVsJPAv4/dkwpDCac4AS432KjxcN/mDunAQMuvlCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D009F68AFE; Wed, 19 Nov 2025 08:29:41 +0100 (CET)
Date: Wed, 19 Nov 2025 08:29:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	io-uring@vger.kernel.org, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: enable non-blocking timestamp updates
Message-ID: <20251119072941.GA22368@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <20251114062642.1524837-15-hch@lst.de> <aRmJ728evgFnBLhn@dread.disaster.area>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRmJ728evgFnBLhn@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Nov 16, 2025 at 07:23:11PM +1100, Dave Chinner wrote:
> On Fri, Nov 14, 2025 at 07:26:17AM +0100, Christoph Hellwig wrote:
> > The lazytime path using generic_update_time can never block in XFS
> > because there is no ->dirty_inode method that could block.  Allow
> > non-blocking timestamp updates for this case.
> > 
> > Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_iops.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index bd0b7e81f6ab..3d7b89ffacde 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1195,9 +1195,6 @@ xfs_vn_update_time(
> >  
> >  	trace_xfs_update_time(ip);
> >  
> > -	if (flags & S_NOWAIT)
> > -		return -EAGAIN;
> > -
> >  	if (inode->i_sb->s_flags & SB_LAZYTIME) {
> >  		if (!((flags & S_VERSION) &&
> >  		      inode_maybe_inc_iversion(inode, false)))
> > @@ -1207,6 +1204,9 @@ xfs_vn_update_time(
> >  		log_flags |= XFS_ILOG_CORE;
> >  	}
> >  
> > +	if (flags & S_NOWAIT)
> > +		return -EAGAIN;
> > +
> >  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
> >  	if (error)
> >  		return error;
> 
> Not sure this is correct - this can now bump iversion and then
> return -EAGAIN. That means S_VERSION likely won't be set on the
> retry, and we'll go straight through the non-blocking path to
> generic_update_time() and skip logging the iversion update....

Thanks.

I'll fix this by propagating S_NOWAIT to inode_update_timestamps.
