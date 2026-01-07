Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA9225791
	for <gfs2@lists.linux.dev>; Wed,  7 Jan 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771359; cv=none; b=m9FzDM/MbdOLxC8rwF/V/3Qqig5FJJRDS0tiypYlRTZ4v+ni3G1G6Y8o6jjQNyyj+2zWrPtfG4U4A/E9L9Im50mBI6XL6qTsir/UJHS2EcZWEpIySFWFkARGYMlvwgcLXjTzCA7iTl7q45eUwvpjj5Euw1ZdRVYXvk2dN0teusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771359; c=relaxed/simple;
	bh=MYOuB/KZfOgHfaM3iD3cEkrlO8Alm/fztkpNRGJNxs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDoAGS6VM+EN8nsNzBenNGdS8+WmVIF2vDg54nwk6qmJEkGn+U2VTs3qh9irfcKa9gg1HRnGMj1iPjfm4C5xmAzGXlM9ipR2uzHje+3aOCxSbNXM3ksN8Hv2daUVdS+dU+YqI+n1NanYbWGd2luEH2nAHg2wj1yop6sO8U3+DjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5170F227A87; Wed,  7 Jan 2026 08:35:53 +0100 (CET)
Date: Wed, 7 Jan 2026 08:35:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, io-uring@vger.kernel.org,
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/11] fs: refactor ->update_time handling
Message-ID: <20260107073552.GB17448@lst.de>
References: <20260106075008.1610195-1-hch@lst.de> <20260106075008.1610195-6-hch@lst.de> <jlw4ghr5vx32ss576akxes25oodlcx42zak7vjaaktlgn3m3d7@cbpcvx66y7za>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jlw4ghr5vx32ss576akxes25oodlcx42zak7vjaaktlgn3m3d7@cbpcvx66y7za>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 06, 2026 at 12:48:47PM +0100, Jan Kara wrote:
> > +static int inode_update_cmtime(struct inode *inode)
> > +{
> > +	struct timespec64 now = inode_set_ctime_current(inode);
> 
> This needs to be below sampling of ctime. Otherwise inode dirtying will be
> broken...

Fixed.

