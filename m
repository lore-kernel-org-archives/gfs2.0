Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2A1F19A
	for <gfs2@lists.linux.dev>; Mon,  9 Jun 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749441664; cv=none; b=kFTB3umlVSnngAEq6FKRYrhusHh9nRlKITp7oDEM6dg55xdrHUEEygB+nyAC9jRpP7eQKbqZi4/CeFUwNDut3o6BB5bJcbTgj6LSWwicv5K0MkSbJ/tPwXEEdzcT/lAw//MW3+5Hqk7Us3L5mLlpv0RVXiINWo+orervwVQEsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749441664; c=relaxed/simple;
	bh=MYaJ4/v+wAL52dUFMwiWFuCt2eoCt7JsNodSlWf6DJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvcfzVbVUmXG7PKaKuOC069RnWTFIINKkdKCd5cNf6VpHeYM0CQGMGBhRYCpjpoql14L90ygAXLnGl5AP2AZa8/2Q2tIIyvodMfTvixThjSj5te9FEIVhETWnDip9uMibFglUwt94I8hJZWNrGeJsTMlmliz9SIDXf6M019u4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4222168AFE; Mon,  9 Jun 2025 06:00:57 +0200 (CEST)
Date: Mon, 9 Jun 2025 06:00:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj gupta <anuj1072538@gmail.com>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250609040056.GA26101@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de> <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de> <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com> <20250603140445.GA14351@lst.de> <20250603140513.GB14351@lst.de> <CALYkqXoAGHqGkX9WqEE+yiOftcWkap-ZGH3CSAeFk-cPg4q25A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALYkqXoAGHqGkX9WqEE+yiOftcWkap-ZGH3CSAeFk-cPg4q25A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 06, 2025 at 10:34:42AM +0530, Kundan Kumar wrote:
> Thanks for the suggestion — I agree the default should come from a
> filesystem-level helper, not a mount option.
> 
> I looked into the sysfs override idea, but one challenge is that
> nr_wb_ctx must be finalized before any writes occur. That leaves only
> a narrow window — after the bdi is registered but before any inodes
> are dirtied — where changing it is safe.
> 
> This makes the sysfs knob a bit fragile unless we tightly guard it
> (e.g., mark it read-only after init). A mount option, even just as an
> override, feels simpler and more predictable, since it’s set before
> the FS becomes active.

The mount option has a few issues:

 - the common VFS code only support flags, not value options, so you'd
   have to wire this up in every file system
 - some file system might not want to allow changing it
 - changing it at runtime is actuallyt quite useful

So you'll need to quiesce writeback or maybe even do a full fs freeze
when changing it a runtime, but that seems ok for a change this invasive.
