Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439C1B4257
	for <gfs2@lists.linux.dev>; Wed, 29 Jan 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165460; cv=none; b=df/UQpufeGUiQbbWbk56wF4DC8ckaTJcjSW+8xgnYbyBfdLeWv/G1YT7MspZRETeO0od5gELACIXdp6iyrr8CZ+RKbWsqBB0prh7eKyFvLuNzsgDyCuHay/vHLXmL8nS7IyX8oW/51BufAfaLomC+eoANUYdYu5TsC2/wFOYq88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165460; c=relaxed/simple;
	bh=DTdOdu7VO+UHz3gmFsMZ5Nr7Syh5yplnddC/linvd9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUoPQ1xvR/pBHnq7/Pk1Bb/r8Hu0bBPIxcPFspdudXMYC57qKiLC35wSWbity2LfYNUkLyHQoDSiP+joWOWceG6PdcSXTQN2kWufP6HHtXScE6eIetn7nHGasXPHmJhQSC0xMLK9OHybxfRKm/1pqCfqMJsFV31thhNCYHbxFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 424F668D0D; Wed, 29 Jan 2025 16:44:14 +0100 (CET)
Date: Wed, 29 Jan 2025 16:44:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lockref: remove count argument of lockref_init
Message-ID: <20250129154413.GD7369@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-4-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143353.1892423-4-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe the lockref_init kerneldoc now needs to say that it's initialized
to a hold count of 1?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
