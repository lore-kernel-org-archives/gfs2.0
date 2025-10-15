Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7116F0FE
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513423; cv=none; b=dbXj9+acCFBN1ql8lHXt15EbTPjmHiL3P03iwrkGE96mh0D+xmI2TaJzCftcWzLTzrSE/b522sHmKubVSS8tJFaNOjxAiAX7u1aONior/JAvONITlaP2tT/VvneF2YP63+UdKjUzik2G6lYELRo90gs7gmoigZ9WZ6ufZFB8diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513423; c=relaxed/simple;
	bh=wwsMcO8kxKDe39xAaR0wfWWvJXHr4ArjIXG9EGSFt8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpUO2vyJqdSKDeOqxKZzeq9Q5G3v+aCvIOfbdHkoWIe0y9oOjyqZDfVw0SaHVJ5jsaKzacEUamifMsqXY4fTEROSRjmUOhzqG/XsIAmXwrNbdwx0ENJBCtl8mAYP/pnT5wDAbnY9KAXPPIHvokWj1l/wUQzm14bn3JR+hoMFrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A8E9227A8E; Wed, 15 Oct 2025 09:30:18 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:30:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 16/16] writeback: added XFS support for matching
 writeback count to allocation group count
Message-ID: <20251015073017.GB11294@lst.de>
References: <20251014120845.2361-1-kundan.kumar@samsung.com> <CGME20251014121135epcas5p2aa801677c0561db10291c51d669873e2@epcas5p2.samsung.com> <20251014120845.2361-17-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-17-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Please split this into the writeback infrastructure and an XFS patch.
Adding infrastructure and the user in the same patch is really annoying
for bisecting, reverting or even just reading commit logs.
