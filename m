Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709F20A5E5
	for <gfs2@lists.linux.dev>; Fri, 14 Nov 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133977; cv=none; b=AzlvHSxB/d2Ms7ZvwNm+rTduJJTKQ+BhMjGdZotNaop8ic5WpLqq0frMwCrhUq3q9kVDFoxHJoNRINv6BAgUPAXclhG08io8tpvTZ+TCr9+ghunZdUdD4mau0oLp+Lc9UPyhIwVctqIvMbTRt1YHeZpLIWeWIWcSR+eFCSQWiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133977; c=relaxed/simple;
	bh=VvRjqszoVk+17tn2dfFxpE53PNejpQcUr9D5zeuyduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC5s1ogckWaa6xeGBE1n69lSxcFz7730MeFTlEBzVR4N/69S1Q6uoP3FxAvMxf+h/9zKCQacZUWvkg0VkAX23iYNnTYhteHgO++VzozsFH5xFHFQ5kedCLtW30TV7Gor5skRi3mwEAdFeWUiw3mQYlzsmj/KP0CCzpUjz0H73/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A538227A88; Fri, 14 Nov 2025 16:26:11 +0100 (CET)
Date: Fri, 14 Nov 2025 16:26:11 +0100
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
Subject: Re: [PATCH 06/14] organgefs: use inode_update_timestamps directly
Message-ID: <20251114152611.GC30351@lst.de>
References: <20251114062642.1524837-1-hch@lst.de> <20251114062642.1524837-7-hch@lst.de> <4990df3273eb868aa21dde745c1ae2636af4cdd8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4990df3273eb868aa21dde745c1ae2636af4cdd8.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 14, 2025 at 09:06:33AM -0500, Jeff Layton wrote:
> Please do fix the spelling of orangefs in the subject line. It'll be
> hard to grep for otherwise...

Ooops, sorry.

