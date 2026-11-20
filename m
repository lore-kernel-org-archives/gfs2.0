Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179089;
	b=WJ7G/iJ85EueH4B+PAr3owL+NrC3qmjjRLuyzIMi5xvHGaQCzIlS+bPvMoYWQjJRTiPV
	 9CrS9Kit+dKo5kF/jhvjucQpxdcfC0J6pKa1oTh//BWQkOG/W0guHdGC6Y/lsaHzbm9rR
	 33OpHHd5rxr1fRX67JozAOFHpn1J1SAytD8b/drL8uBsQyzrzW07dYJVFJHFxvLeaHN7h
	 PAhNImuwc0WFqgfPi9qYFWHtBh7ZzCwPbAtCLG4To7HUdZBONSW+JtSnCsfF26UpySvOh
	 aDFIU5kHhYJSvNhCCGk0iIE55RpxWkVw1X1p/7928uMyEds4iENBH67IGJ5PSZWryww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179089;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RwK+sZmEfro4R2XrALiEL0NIpL3hInhE+mN5nJsjAK8=;
	b=LlVJTcYWgSJXR4YJp4a/fpYS7W3dPuwWglMcfdL/5tbVXDMZLRQJddUy7xZdZEoaiNYv
	 zO5sV2DqZBlY+PC2vbxwehFHOWYQxn7ZzZGgiTO8+PySg9viabPHmkphtlBUYo4PQhRtJ
	 noIRb/3J7X9Awu9LT6/4f8gAHaiNrVMvaKFdL0zFBfUhlVHMrcnRBBB7trOwODDewlrOG
	 nLAai2VuPchBVPfIyKtxfbnHDrXfVJ+fGl3ppPtcR0QwitHtRD9fgvLKDOHwEQmQODOoX
	 QzZayvVnWP/mGi4YVQPl3WUelpTjxlpqSwUPIjMLh9kMKJ9PpEkcnY6vL62Fo1v/Jng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVboDCpu;
	arc=none smtp.remote-ip=95.215.58.205
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8E60A261C
	for <gfs2@lists.linux.dev>; Fri, 20 Nov 2026 12:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE8E60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVboDCpu
X-Envelope-To: gfs2@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/M71l9OR+PuswlMFy8Wbwhup3v6OafAF4YhJlLt/84U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795179086; v=1; x=1795783886;
 b=CVboDCpuuv2WqQiy/vtf05zSEtSkLQsRJ/djYGgQWt91weN3dja9zelbY5vaAyy3HckRz8nB
 LTBIz+A0NBi0SxrULdX4yPc6ILwbmx6ofWOwOp9UzoFU9UnVUAYdYhC2d48tOPwt0UJKs6MIxos
 hQ8bQNPKUm99WaSVdem1tj90=
X-Envelope-To: gfs2@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 624a9615c12efaf1;
	Fri, 20 Nov 2026 12:51:26 +0000
X-Mizu-Trace-ID: 624a9615c12efaf1
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 13:51:14 +0100
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-block@vger.kernel.org, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 01/13] bdev: Drop pointless loop from
 blkdev_flush_mapping()
Message-ID: <awBAeS9ROaFyOjzB@quentin>
References: <20261116171044.6938-1-jack@suse.cz>
 <20261118145941.1063127-14-jack@suse.cz>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118145941.1063127-14-jack@suse.cz>

On Wed, Nov 18, 2026 at 03:59:35PM +0100, Jan Kara wrote:
> bdev_write_inode() is really odd loop calling write_inode_now(). The
> bdev doesn't have any pages by now and if there are any dirty bits in
> the inode state, they are stale. Just call write_inode_now() once to
> clear them.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

When I looked at the commit that introduced bdev_write_inode()[1], it says
to call write_inode_now() on the final put of the block device. At the
moment, tt looks like we call bdev_write_inode() only when bd_openers is 0.

Looks good,
Reviewed-by: Pankaj Raghav (Samsung) <pankaj.raghav@linux.dev>

--
Pankaj

[1] 564f00f6c03a ("block_dev: only write bdev inode on close")
> ---
>  block/bdev.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index f20f91b3176e..9fa72df4f47a 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -60,24 +60,6 @@ struct block_device *file_bdev(struct file *bdev_file)
>  }
>  EXPORT_SYMBOL(file_bdev);
>  
> -static void bdev_write_inode(struct block_device *bdev)
> -{
> -	struct inode *inode = BD_INODE(bdev);
> -	int ret;
> -
> -	spin_lock(&inode->i_lock);
> -	while (inode_state_read(inode) & I_DIRTY) {
> -		spin_unlock(&inode->i_lock);
> -		ret = write_inode_now(inode, true);
> -		if (ret)
> -			pr_warn_ratelimited(
> -	"VFS: Dirty inode writeback failed for block device %pg (err=%d).\n",
> -				bdev, ret);
> -		spin_lock(&inode->i_lock);
> -	}
> -	spin_unlock(&inode->i_lock);
> -}
> -
>  /* Kill _all_ buffers and pagecache , dirty or not.. */
>  static void kill_bdev(struct block_device *bdev)
>  {
> @@ -755,7 +737,12 @@ static void blkdev_flush_mapping(struct block_device *bdev)
>  	WARN_ON_ONCE(bdev->bd_holders);
>  	sync_blockdev(bdev);
>  	kill_bdev(bdev);
> -	bdev_write_inode(bdev);
> +	/*
> +	 * All data is written out and evicted but inode can have some stale
> +	 * I_DIRTY bits set. Call write_inode_now() to get rid of them so that
> +	 * the inode can be evicted.
> +	 */
> +	write_inode_now(BD_INODE(bdev), 1);
>  }
>  
>  static void blkdev_put_whole(struct block_device *bdev)
> -- 
> 2.53.0
> 
