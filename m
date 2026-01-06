Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EE3090FF
	for <gfs2@lists.linux.dev>; Tue,  6 Jan 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686094; cv=none; b=UKpjnvqv3z3lSKSD2YjuGHTHG0OgEVVcEXGckhsibXFTiBuiNuxla4qL4xKhcmhptlUmVrycmZBzBkWvocMhgPStMG2EdMGJw1nFzyEpgdjllRNq32wWHToJORoElSnbZzJ9WwKPQeuWjiFci94F03EycMeJqeHQRx2jccsDvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686094; c=relaxed/simple;
	bh=uYulOYKKdNPvQlNdH6mFPDAccL0iOzghInuM/33kSCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL9jkZRMK9icnexWr56XpUiBy0cpzZPxc2YXv44oP1gs1nHn1DIN6rIQ/2yGo5v2a6soyNvCbGa3CHA2OCWO5M7ObZ/I48hka0zrJreMaiQZKIm7YATbd2ELzGgo8B0uYRHPx4wUhJjYoM1nbDv800JmgxzJlx+rS1IiOAAGGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6732E6732A; Tue,  6 Jan 2026 08:54:49 +0100 (CET)
Date: Tue, 6 Jan 2026 08:54:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
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
Subject: Re: re-enable IOCB_NOWAIT writes to files v5
Message-ID: <20260106075449.GA19152@lst.de>
References: <20260106074628.1609575-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106074628.1609575-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Sorry, sending this got interrupted by the broken train wifi.
Please look at the immediately following full series instead.

