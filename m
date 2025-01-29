Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF61DF250
	for <gfs2@lists.linux.dev>; Wed, 29 Jan 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169411; cv=none; b=T9+bBY3eoqbjw5DimjxMODHUZ9Arhw/Sw6fbQ4mAWg8InF5wr9ZJCC1DWCBi44yS6sc0NvTEE3mYJ3q8Ve+oHQxte4KUhHlPuYGLpwA2ttiBEudZd1VUPaZICpARYEvchzhAt0jUybaVBFsrrJLDcgcJhCvJsJIM0/3535btcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169411; c=relaxed/simple;
	bh=3escXZ70xI/kAiYoAh+7AX3bAL3ZwGiEx/dkOqoc7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+cizBJ8QsRHAuTnqq9Uf14T4Uje3DB9wVxPoMoxRhZFiZOkIBg42yvjbIfogPdQZkS20XI8CmztEaAoj5U27lEA2iJUvytcDJHAvVv1XEnNwLkXn9O5xLS5GMlw0c0DNNMjViHy6BpI1ld/yVMVv37iS+1bIHZvgOeQuDPobtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A808568C4E; Wed, 29 Jan 2025 17:50:03 +0100 (CET)
Date: Wed, 29 Jan 2025 17:50:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] gfs2: switch to lockref_init(..., 1)
Message-ID: <20250129165003.GA12913@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-3-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143353.1892423-3-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 03:33:51PM +0100, Andreas Gruenbacher wrote:
> In qd_alloc(), initialize the lockref count to 1 to cover the common
> case.  Compensate for that in gfs2_quota_init() by adjusting the count
> back down to 0; this only occurs when mounting the filesystem rw.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

