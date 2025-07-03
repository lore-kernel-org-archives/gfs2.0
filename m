Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E978946C
	for <gfs2@lists.linux.dev>; Thu,  3 Jul 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545021; cv=none; b=dF8NLc1aErYWnLCUueOF3LI5xng+2IJ1FhVdFT+GDRVH1cgIVL5H3yTIE87iWRbiyRe9IzmBFIk79/rxp2bA2VyqjKgSdwGwKnVV9smRoFiZ5xC0SDOkyMmvOdEa/9V4wrCwT7JAR2AgEf/TogzIL9ZoWJ0zWI+KCN4dktgRHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545021; c=relaxed/simple;
	bh=YhSYv4Apjbr3Oj47VGbhmJgYZ9AgT0VyunWVMHcnmU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjvzVNeAqClxDbxOsYVLXbpn+So/8dBT6WS64W1ZZEtH7hT4lltY07TpWpO2ck/J5FWHGcURrJLjHBLdw55uDwiGmEx9Gw88Jst7gr848br2tQkPyuCCx8OzAzPF74RrAY/+TfvPb/MeZangAUTcDasXkqv7rV/7pXbjnUehRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E0FB368C7B; Thu,  3 Jul 2025 14:16:54 +0200 (CEST)
Date: Thu, 3 Jul 2025 14:16:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	hch@lst.de, miklos@szeredi.hu, brauner@kernel.org,
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 03/16] iomap: refactor the writeback interface
Message-ID: <20250703121654.GA19114@lst.de>
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-4-joannelkoong@gmail.com> <20250702171353.GW10009@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171353.GW10009@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 10:13:53AM -0700, Darrick J. Wong wrote:
> > +    int (*writeback_range)(struct iomap_writepage_ctx *wpc,
> > +    		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> 
> Why does @pos change from loff_t to u64 here?  Are we expecting
> filesystems that set FOP_UNSIGNED_OFFSET?

It doesn't really change, it matches what iomap_writepage_map_blocks
was doing.  I guess it simply doesn't fix the existing inconsistency.

> > +    int (*submit_ioend)(struct iomap_writepage_ctx *wpc, int status);
> 
> Nit:   ^^ indenting change here.

Yeah, RST formatting is a mess unfortunately.   I think the problem is
that the exiting code uses 4 space indents.  I wonder if that's required
by %##% RST?

> > +		if (wpc->iomap.type != IOMAP_HOLE)
> > +			*wb_pending = true;
> 
> /me wonders if this should be an outparam of ->writeback_range to signal
> that it actually added the folio to the writeback ioend chain?  Or maybe
> just a boolean in iomap_writepage_ctx that we clear before calling
> ->writeback_range and iomap_add_to_ioend can set it as appropriate?

What's the benefit of that?  A hole pretty clearly signal there is
no writeback here.

> Should this jump label should be named add_to_ioend or something?  We
> already mapped the blocks.  The same applies to the zoned version of
> this function.

The newer version already uses a map_blocks helper for both again.

