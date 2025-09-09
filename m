Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768919E7F7
	for <gfs2@lists.linux.dev>; Tue,  9 Sep 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447341; cv=none; b=uBD7LFL2XH7jSmbqo0RLUC0OYt0iKg8fRfJeYRefagjSx0KraHj4RFyMsGT85v7P3xSKc8+B3PKvM7as+CMmobeXNoOBo8mD/nem7CMHmAvL8oclSx8pXemSa3mpyRDk6FYZo3nJkjhjx+RuGyI+QOQlj/ieZibUV6d6F5UK13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447341; c=relaxed/simple;
	bh=yNY8fw4InteYSdfY936nfhJAqT+/k/kI/FOINfsRh9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAKaNVMOw+pBFXo4Aq1ziu+5mdvo5R313PhD/NeO89lhjpF85YRjAqkbyqGI1APy+uE2ulFS3xD3rpU45Q2RWb5VUf/foaYTDGtzWdBz0wnyDCCjvpmD59hfAB+eCHOFFnpjlLR8dnH7vlRDtOSJWpX1k4rDjpD9SwC9Ohn+vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WL43k4ig; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WL43k4ig"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB3F340AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757447338; bh=Yk4GVvae709BxdaTQt9abGt3/TDd6Rj6IquHgMT/iyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WL43k4igNDhSRW3kd+7mVLUSAKN6nv5TFnPzx8unABiikQ/dewnWtuXnBefvbgsNg
	 rMWcqVoudeOb1jSLdodIXoIj+cExNbYN7rVVd9ID7BAz8MLeFqgAEvi11R6Ce/uGen
	 Lz9C2FOaJ8no+be7bKrLhzBARqO/qJwf9AptM7Z/fbauNSJcCpfIjZJY5rc0fgWERG
	 ElsJaurKjMzCfDcPhSEtdqYMnzHeDurqJdHaYVbh2NybpqJK3AW5j2MuN+eLWfhUk8
	 B/5jUpurfhaC6RVE/YZeRK0WuFiFfEyXRseE8EJxNcgz+ZoNGq7ZJUP0xjX5G6iqQj
	 HIN/3sctKRB/Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CB3F340AF9;
	Tue,  9 Sep 2025 19:48:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux GFS2 <gfs2@lists.linux.dev>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Jan Kara <jack@suse.cz>, Bernd Schubert
 <bschubert@ddn.com>, Jeff Layton <jlayton@kernel.org>, James Morse
 <james.morse@arm.com>, Chen Linxuan <chenlinxuan@uniontech.com>, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
In-Reply-To: <20250909014606.15043-1-bagasdotme@gmail.com>
References: <20250909014606.15043-1-bagasdotme@gmail.com>
Date: Tue, 09 Sep 2025 13:48:56 -0600
Message-ID: <874itbv23b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Documentation for GFS2 is scattered in three docs that are in
> Documentation/filesystems/ directory. As these docs are standing out as
> a group, move them into separate gfs2/ subdirectory.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v2 [1]:
>
>   * Do not use wildcard on MAINTAINERS file entry and add review tag (Randy)
>
> [1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotme@gmail.com/
>
>  .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
>  Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
>  .../filesystems/{gfs2.rst => gfs2/overview.rst}      |  6 +++---
>  .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
>  Documentation/filesystems/index.rst                  |  4 +---
>  MAINTAINERS                                          |  2 +-
>  6 files changed, 17 insertions(+), 7 deletions(-)
>  rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
>  create mode 100644 Documentation/filesystems/gfs2/index.rst
>  rename Documentation/filesystems/{gfs2.rst => gfs2/overview.rst} (96%)
>  rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

I'm not sure which tree this is meant to go through ...

I do have one suggestion: the changes seem good as far as I go, but I
would have made gfs2.rst into the new index.rst and avoided creating an
essentially no-content file there.

Thanks,

jon
