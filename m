Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7732E734
	for <gfs2@lists.linux.dev>; Fri, 14 Nov 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134127; cv=none; b=Q+un5LPYNJd6PH2g9ET/na2k6F33OlqEJeNfMTGp9JJXrzWhuCw6wtCUequ4TRkWpMc7jyRXC6p7n/BUTKY5AyGmoh7k9EuEe0sl97FbVcqyT5lvKTXgrj/fumpfK/U1RUQ6l49RuHM6CglkiyRpQs11MkEgZI/xDdbf10a9nsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134127; c=relaxed/simple;
	bh=BM70eZB9FbP/9B/6S//Ss+GV4VqUXiu6YIrLW20c0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov+NNtdsyaOX2qs0BQhPOafR7AP4WIFFvA5m+UaehmJ9YGFD1m6yw39hmT4RSP0LfyiwRVe8dlD+feF9fPRBgROwyMpIDjCUund5De+T4ln4KsXbKeztlsMkEt05GBlkSca8UQ0n/ZnRVhVHKqb0n5z9ArwrNnD79EMAJ7vMo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBCCD227A88; Fri, 14 Nov 2025 16:28:40 +0100 (CET)
Date: Fri, 14 Nov 2025 16:28:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, io-uring@vger.kernel.org,
	devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: re-enable IOCB_NOWAIT writes to files
Message-ID: <20251114152840.GD30351@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <b7e8d5e3a0ce8da103f4591afc1f4a9c683ef3c7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e8d5e3a0ce8da103f4591afc1f4a9c683ef3c7.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 14, 2025 at 09:04:58AM -0500, Jeff Layton wrote:
> This all looks pretty reasonable to me. There are a few changelog and
> subject line typos, but the code changes look fine. You can add:

Please tell me about them so I can fix them. 

> As far as nfsd's usage of FMODE_NOCMTIME, it looks OK to me. That's
> implemented today by the check in file_modified_flags(), which is
> generic and should work across filesystems.

Nothing requires file_update_time / file_modified_flags are helpers
that a file system may or may not call.  I've not done an audit
if everyone actually uses them.

