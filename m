Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA961683
	for <gfs2@lists.linux.dev>; Tue, 12 Dec 2023 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dT7hUcTd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9GOM1CReQqHO2Eq5TSJ+QFrtD+BDx0i0I5iG3RHOkc=; b=dT7hUcTdggq68z9eTLTpZvkowz
	o0hzxFtGP/1A5CdpXLfKR7IAabXtd6tscvW4EWJ7bqf73me/qP/EdG2B4FI3typytMvICOqncBaZB
	juLPQegmxMqcDjRUgDWRxj7eyVDzzLp60SQCJEDdgc0OscK42Z3kENibYVgGF0I1l4mcAYgv7Nega
	dtBKSq2W5Eht1hqZUznEkZjKNtAWvDjb82DMtqFruzGL7aQEKgH38NdlFfSSWk5+OxXcyVtpRNqmc
	NPwFb5zSyEEcKZJQSk14/2oMDYGzCgMBHQVgCHGvkAUHl3vAl4PoAud1hrwXpknFsKsviOKDCWU7T
	JzSMOq4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rD2ae-00BldE-0K;
	Tue, 12 Dec 2023 13:14:24 +0000
Date: Tue, 12 Dec 2023 05:14:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	roger.pau@citrix.com, colyli@suse.de, kent.overstreet@gmail.com,
	joern@lazybastard.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org,
	chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
	willy@infradead.org, akpm@linux-foundation.org,
	p.raghav@samsung.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 01/18] block: add some bdev apis
Message-ID: <ZXhcsNbvzbArtBUj@infradead.org>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140552.973290-2-yukuai1@huaweicloud.com>
 <20231211165217.fil437byq7w2vcp7@quack3>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211165217.fil437byq7w2vcp7@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 11, 2023 at 05:52:17PM +0100, Jan Kara wrote:
> > +void bdev_associated_mapping(struct block_device *bdev,
> > +			     struct address_space *mapping)
> > +{
> > +	mapping->host = bdev->bd_inode;
> > +}
> 
> Here I'm not sure - is the helper really a win? It seems a bit obscure to
> me. This initialization of another mapping for a bdev looks really special.

If we want to hide bd_inode we'll something like this helper even if
I don't particularly like it either.

But it might be a good idea to move out of this series and into the
follow on removing bd_inode, as it's rather pointless without that
context.
