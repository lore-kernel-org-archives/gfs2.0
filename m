Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828530E0EC
	for <gfs2@lists.linux.dev>; Wed, 19 Nov 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533511; cv=none; b=d+MO0udWoEYoSC3yY3eJbuQ7Q3SRo+jNPSTbcwjH2njJ0B6KAdjyuEYiDQK5rKOWG4V1XmkVhbyllxts9ahRAK3+DaVtf/DaDD3Vie6+PzO0PXFvzGzUeiVVs0ePuDqCs/nnTw7G/Z0W0tY8ztaHdodB3+eCyqiXxOSs1p7QB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533511; c=relaxed/simple;
	bh=AqAHNkrHxx42jEBoafUC+KtV3iXc+xj17wNWRju+99A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQRMGDZYMl90EhUz1KBOUOiJsUGNa8SDev2ba3SeH2HuaFf4SD3G+jfty8GdG//gWr2faHvVy4hdyfJsXPlpTYFNnLv9W8QRQJGx/1vghdwblwhs++MTu4zR6+kxM868Chv4PAYcLOAOGQI3EzznIQ9mmMX3sq1r4cB2AapaWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1E6768AFE; Wed, 19 Nov 2025 07:25:01 +0100 (CET)
Date: Wed, 19 Nov 2025 07:25:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"devel@lists.orangefs.org" <devel@lists.orangefs.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/14] fs: remove inode_update_time
Message-ID: <20251119062501.GA20592@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <20251114062642.1524837-6-hch@lst.de> <813f36d3-2431-4266-bb2e-faa3fc2a8fd7@nvidia.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813f36d3-2431-4266-bb2e-faa3fc2a8fd7@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 06:59:25AM +0000, Chaitanya Kulkarni wrote:
> > -	ret = inode_update_time(inode, sync_mode);
> > +	if (inode->i_op->update_time)
> > +		ret = inode->i_op->update_time(inode, sync_mode);
> > +	else
> > +		generic_update_time(inode, sync_mode);
> >   	mnt_put_write_access_file(file);
> >   	return ret;
> >   }
> 
> do you need to catch the value from generic_update_time() to match
> if case ? although original code was returning 0 for generic_update_time()
> case :

Yes.  It doesn't matter for this series, but it's good future-proofing.

