Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E813148D0
	for <gfs2@lists.linux.dev>; Tue, 25 Nov 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069248; cv=none; b=MV4/Wfgup4ODPfXZfUT+cStlfn2rukRRMfmPezhDUKNnp8p/M2sSCosthA8UI7KcaYIvn0bjm+B8JUj4D1Gc8l0pJ0iEkcwPVdbvVAPL35M2N2tKkXGYu3YZpMQnPyLybePO07LdDVFUpofX1+7exzGzLXfHqf/l7E+2R/uVTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069248; c=relaxed/simple;
	bh=/69+0EJmS2X7ff7j0q4w9PZqnsVx+XZDiBTAryw5GXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTgcaSYtTls+7V+jYteR/JCE7uLBdeJA7R1o89myS6G0TdlVX/4i5Pp26t8yyIK7z0MNQFzOvoIFY/t6A7ZIHx1wIu69AGotWyfp88bdd5tcC3w/RfCWwL0p4lZDvx57NvbS3TzzF9M8WZQwO5E6QJOpPbZUvXRcZPvkOXFjKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1995868C7B; Tue, 25 Nov 2025 12:14:03 +0100 (CET)
Date: Tue, 25 Nov 2025 12:14:02 +0100
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
Subject: Re: re-enable IOCB_NOWAIT writes to files v2
Message-ID: <20251125111402.GB22313@lst.de>
References: <20251120064859.2911749-1-hch@lst.de> <20251125-loten-fabuliert-c0fb6b195b53@brauner>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-loten-fabuliert-c0fb6b195b53@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 25, 2025 at 10:18:32AM +0100, Christian Brauner wrote:
> It's a bit too close to the merge window for my taste and we have about
> 17 pull request topics for this cycle already.
> 
> So I'll take this for vfs-6.20.iomap. As usual I'll create that branch
> now so that the patches don't get lost and will rebase once v6.19-rc1 is
> out.

I can understand that.  Although it would be nice to get the nfsd
and btrfs fixes in, i.e. patch 1-4 (and 5/6 are trivial and would be
neat as well).  I'll need to resend the others anyway based on the
(minor) review feedback, which I'll do right after -rc1.
