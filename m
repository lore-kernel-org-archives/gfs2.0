Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F317E015;
	Mon, 20 Jan 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386726; cv=none; b=gJD7szjegXbUC2sy5IZeZ+ExvnHoOYySXjtMxZ+lHo6nOuLtw1Q5l9YDSF4f42bBiWGer+ndcNheUncxx2fUSOJbprqRsyi6FPoYrci8pLhmtiRM58rtKC2Gkh80BqOhRXZPlG9pEfVjDQwWAPu6mtwkuky6cCPBII0VsZ8MbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386726; c=relaxed/simple;
	bh=9biNTgBg3G+aozZcqbUVwRcx7rft0IZ1NOZPSRjhCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0oYDURXT0Kaa1qWz74DT1W0kf9aQjtslcIJnugTPPCkVmeX0bgtr9Q0IDB/VjliyCNn5z0FSxbSZUqWxRx8ZZgecRW/zqV3Fr5hCsxbP+hZGM+Nn6ZfIqiqBeM5u6mxC9C0iaJF4DbFBf2ZkXPqbWibcks4YCwccSfwjXA2vFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnGgsoYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnGgsoYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7843C4CEDD;
	Mon, 20 Jan 2025 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386724;
	bh=9biNTgBg3G+aozZcqbUVwRcx7rft0IZ1NOZPSRjhCPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnGgsoYBwimf7CoDV73yDeUTUNyIpqHmdM5jvwm+zs5+ahiOrwipR1b+2LdJQ/qSP
	 Dfu1U5d7+OfPfsMWTm+r13eLA6B6fAaGNrvk0kNZZQJWVnqmAeD6PnF7Zk959aNGle
	 duf8TIXZvQQbWEbbuFW4i/3IrB0VcFlBHIWzUqIzB8m2mexTDczdMvtcYotX5DmOYh
	 VNLDZEC0OlbU5xyFkZP4OUy+N0K2mFGriMa8lw8sdxf053EkCvQhRwNLqJ6Ko/ZM1Z
	 YQGHQB+hdPJLB2RPimg0aAyc/pOjLNrvhiAPAgy2rEjAPI1DYW3tnXQ+H5TAsyrD8P
	 hTXOZpCKOs73Q==
Date: Mon, 20 Jan 2025 16:25:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
Message-ID: <20250120-tragbar-ertrinken-24f2bbc2beb4@brauner>
References: <20250116043226.GA23137@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-9-hch@lst.de>
 <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
 <20250117160352.1881139-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117160352.1881139-1-agruenba@redhat.com>

On Fri, Jan 17, 2025 at 05:03:51PM +0100, Andreas Gruenbacher wrote:
> On Thu, 16 Jan 2025 05:32:26 +0100, Christoph Hellwig <hch@lst.de> wrote:
> > Well, if you can fix it to start with 1 we could start out with 1
> > as the default.  FYI, I also didn't touch the other gfs2 lockref
> > because it initialize the lock in the slab init_once callback and
> > the count on every initialization.
> 
> Sure, can you add the below patch before the lockref_init conversion?
> 
> Thanks,
> Andreas
> 
> --
> 
> gfs2: Prepare for converting to lockref_init
> 
> First, move initializing the glock lockref spin lock from
> gfs2_init_glock_once() to gfs2_glock_get().
> 
> Second, in qd_alloc(), initialize the lockref count to 1 to cover the
> common case.  Compensate for that in gfs2_quota_init() by adjusting the
> count back down to 0; this case occurs only when mounting the filesystem
> rw.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---

Can you send this as a proper separae patch, please?
