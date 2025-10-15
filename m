Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEC73451
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513358; cv=none; b=IVzpZ2I4AHgoLKOgOuCqUyEkp4kAGbX3qJ4/b+z/lv1sqOTGwOpltP0hlI8EOwp2Q1z8vrmo6eD0NFQTQMrk0FxsuJRd+5RUa/efXGnaRDX6iEWbaSZTecXPfNAnuvOuEE5+xksPv6YMB94YqNMsiX7S/F9772MMiP7A5pyhuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513358; c=relaxed/simple;
	bh=/jqV4kzoi87kR6CjE870xFxBQep7fEAX3ZGebZY8SQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV5JA1jnx2jjX+xMU9iZ6BjLUerRhmNfTmhH4+9Ya54c/FQ9fcGB4Efbt1JIiekVtyHN53keoDi3Ogw42Hs/sfdSF9eXsKKGtX5RcgZLxYi0vkfr2Ikqj6AqfkMPt0vYfjaDCbVDk0ers1FGDseoS7rPIf2rkOPCrEpT9X3+arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66DAC227A88; Wed, 15 Oct 2025 09:29:12 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:29:12 +0200
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
Subject: Re: [PATCH v2 09/16] f2fs: add support in f2fs to handle multiple
 writeback contexts
Message-ID: <20251015072912.GA11294@lst.de>
References: <20251014120845.2361-1-kundan.kumar@samsung.com> <CGME20251014121102epcas5p3280cd3e6bf16a2fb6a7fe483751f07a7@epcas5p3.samsung.com> <20251014120845.2361-10-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-10-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 14, 2025 at 05:38:38PM +0530, Kundan Kumar wrote:
> Add support to handle multiple writeback contexts and check for
> dirty_exceeded across all the writeback contexts.

As said last time, please do a preparation series with all these
cleanups for file systems poking into writeback internals that can
go in ASAP and sets the stage for multithreaded writeback.

