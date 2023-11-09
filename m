Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549853BA
	for <gfs2@lists.linux.dev>; Thu,  9 Nov 2023 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tBz2YcV+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V7XVjzYWSOnWors9qJgYaHQ4LNgHkYieICZjMg/iyds=; b=tBz2YcV+kG0axKMhP0RySHIJNc
	zAuhn/x7JSpBbUVrO6CX1Z2u3/U9UBzfCG5j3gO15M7KCl0D+nUTAmp05TQyupxKQhw4uhBC90+D0
	EYIU/tjCOBZtjBncj6Zz4c1yOfsMtDJGcGBxBM7VDUHIHTuUFIlWUWjxG+hPxo9rYCvoD/+JMBDEU
	y2TcctcnRo9Yq20JI6eEtHoSkKDe6d7KLVcNtRlCRRTaBxJkHqHVG+s11RlDcGAPvIWsTbqxao61E
	hPnslVL4b+ABWA5plBLmf3POJzG/2U7IZD5wtZetWDyhOW1DuFoPcYJ9Yrp3PNqlIRlPXlQ39cs9G
	+fbZGNvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0z2U-005SYB-1n;
	Thu, 09 Nov 2023 07:01:18 +0000
Date: Wed, 8 Nov 2023 23:01:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: peterz@infradead.org, will@kernel.org, gfs2@lists.linux.dev,
	boqun.feng@gmail.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] refcount: move kdoc to header definition
Message-ID: <ZUyDvv0na03qnSH+@infradead.org>
References: <20231106191138.3179599-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106191138.3179599-1-aahringo@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 06, 2023 at 02:11:36PM -0500, Alexander Aring wrote:
> This patch moves the kdoc for refcount_dec_and_lock functionality to
> it's header prototype declarations.

That's not how kerneldoc works.  The comments should be next to the
implementation.

