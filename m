Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDC3191D4
	for <gfs2@lists.linux.dev>; Wed, 19 Nov 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533717; cv=none; b=U2yf5scMKw0ZamFnJlfsBfB4ooFEqeQLJoCMKiYNsd0yyBT1/muMDWeHo5qOUSoK5fRl12Gfb2oBi7N1XJkGDnVhANrdWZLWnS02H0xyhMfbR2dcA7HY5vcQ1T7r8lM4hHZgVTxBgwbPUuS6jHcBKSdN4cD0SSwmSkTHzTTxXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533717; c=relaxed/simple;
	bh=uV9aHOFGSAEXlN+kUa3QTGk4uOyacs/HBVBC43oduM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itj0/JZ7bjg2TH+Y44RrDIMY2ocuPAb46DQHG0yoP5JvVz1hxpPxhkdsyk/KzpBqHBGgEGAcvgjoerZlj21ApCNOo1ZdvFAItRdwdZRD1GfzoI0pw4QsjbnXrt4eamD8e2cJ8LRPhiwapOi5CVF47ZF45O49B9KTUoTkU43j38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B98C68AFE; Wed, 19 Nov 2025 07:28:31 +0100 (CET)
Date: Wed, 19 Nov 2025 07:28:30 +0100
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
Subject: Re: [PATCH 10/14] fs: factor out a sync_lazytime helper
Message-ID: <20251119062830.GB20592@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <20251114062642.1524837-11-hch@lst.de> <cff9dffc-dd49-45db-bc47-efab498065c4@nvidia.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff9dffc-dd49-45db-bc47-efab498065c4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 07:38:29AM +0000, Chaitanya Kulkarni wrote:
> 
> This sync_lazytime() will always return false ?
> shouldn't this be returning true at sometime if not then why not
> change return type to void ?
> 
> returning same value doesn't add any value here ..

Yes, it should return true when actually doing work.  So currently the
syncing on final inode eviction is broken, but it looks like non of the
tests actually hits it.

