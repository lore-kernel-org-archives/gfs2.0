Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F425B1DA;
	Tue, 26 Aug 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209746; cv=none; b=X5Y+s00OEc1mQdonZSi2noDYaf7of35MI9tfVgynre7sZpxKOFwfoUrpHQ3euaHmt3YBB6EHn5/94i5bLE2EK5b4ScvL7AUBLXwinT1snjBERobIezPRgOWi2QRw0GTKCu3FHDr8EC8mJyfzKDFm1B1xlNktrQ2bzytw8z5wjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209746; c=relaxed/simple;
	bh=HWOCpGfXf3woK38ZXPWu4NoQ25Pi/X52YbYJ7rxrBKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMm94Q3kXxdqFKulqlb3y1POfy+hif706r+Ggm8qE6w7WXIbmExGA+4AucstI9W9D5+RRV20soti1d3qiz/f9XeRTt+/IBd+KX+13+hMudRL+DnJfhCVZ5kghRAJSUq9IuUUAHrfc9qVHE5DrT0nmLgLo+diq8ZwGkdpYIX5NWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PwOgxWE7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PwOgxWE7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=euphb98uatuiM1mOvtuPBsNq81pc2emty5zRAt3Iqis=; b=PwOgxWE7Yu1ngWioI/3rZeS1Fp
	CfI7HQGzIjhdMh6eZKL6XCXjuwrBZbzrH7IBwJ4u/m6az/NWaurt2fviApA6D580yP5kLaAzJ+Am1
	d1J3WwR6AYXCXzVJACJ/cjj0xa9ojrJ1Xh91kt7sA+CDsBkmCVQUVSG3cm6LwE9YvkReg4u7SQ4OP
	r2cZCB/lRZmg07s+YYdetCRvfK7FCwiSnqfiryASeCKHqO1DOnaCiFqpqX5gdD6IfyqrMIT9V7fpR
	IBpeYgrwqiLrguno08bxF95WxGd5Ik92hjywI6H9nYFsOM8nuJEd3c716l6SU39wNRS9yVhFWauAq
	k/lPl8/A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsNa-0000000187u-2oyF;
	Tue, 26 Aug 2025 12:02:22 +0000
Date: Tue, 26 Aug 2025 13:02:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] Documentation: gfs2: Consolidate GFS2 docs into its own
 subdirectory
Message-ID: <aK2iTlkp9iA3zESf@casper.infradead.org>
References: <20250826023913.14888-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826023913.14888-1-bagasdotme@gmail.com>

On Tue, Aug 26, 2025 at 09:39:13AM +0700, Bagas Sanjaya wrote:
> Documentation for GFS2 is scattered in three docs that are in
> Documentation/filesystems/ directory. As these docs are standing out as
> a group, move them into separate gfs2/ subdirectory.

If this is to be done (and I'm not sure that it should be), why preserve
the 'gfs2-' prefix on the file names?  We know the files pertain to
gfs2, they're now in the gfs2 directory.

