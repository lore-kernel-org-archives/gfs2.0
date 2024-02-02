Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5B17BB6
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850154; cv=none; b=Ot2SYBaJUPsXbm3RL53CIH6WoY5jsfwMBFU+TvHnc33FGK58/+qAlHYaExhdZJoVVAMCHzCixcPlzzQ25/BGX4MTZAway69MVTsSOKcFke5FXfo4xKzPxsmUbHnngUeHALcWom19sywjjM5Qi6mQ/p1PoMxgGvt4YU/dlZmCxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850154; c=relaxed/simple;
	bh=KvTp6PnkNm2equQRENGf0G9Rl3Zwj6RtiWN8DxRXU8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUdf03PLtVlNO+ZXqRvo+Dkvk+/KO6iGGsL7267WqOH9D6m0tbSP3wqUSw+D6C0gsfG5WIJ5jtGzqk4mi/WCeu+aP6tyCp2SpXfMpLeDpEHiGNfeCyCWHcB3RosXLcRM5eO66jWD0POH38THjPDbxHk7v+va3rv6Ykm6x1OgGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RQPdAXtO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RQPdAXtO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hLigsYGKaLuPhwoyZISiAMt8KCEZ5cIgXPMSzirvRYM=; b=RQPdAXtObA4qEI2bq4zpXm0TLS
	uQpr+6J6X/sk/vxXZizlT7yHv/mlsr108Sb3tVK79bbh0pbZsdqEFmUAuKBnReofva5nrPG4w1pYm
	KEHyub6csQPaU5uRgY0qK7dJlCn+AptdHh4yUr/8w0Qn3NgRFc20WHxHPsWto5SdTDepDisKlYGyy
	xTmjJr0sEK1rQNt34qHGAPIw6Rr5cB29bWhKSLbbW/gPjosAv9Nr07prZD7qBo6Rm2IyTbug1HCPt
	aETJUitHe0WxBjQqPXhmuiU4jTTJ9LnU8RkR0pS/pGCb50gKPyg/Me1qOJ2BK+jHDNY1KDBiHzUZ+
	Klmw0TXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVlh8-003fpN-0Z;
	Fri, 02 Feb 2024 05:02:30 +0000
Date: Fri, 2 Feb 2024 05:02:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240202050230.GA875515@ZenIV>
References: <20240119212056.805617-1-agruenba@redhat.com>
 <20240202042312.GY2087318@ZenIV>
 <20240202045943.GA873800@ZenIV>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202045943.GA873800@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:59:44AM +0000, Al Viro wrote:
> On Fri, Feb 02, 2024 at 04:23:13AM +0000, Al Viro wrote:
> 
> >         if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
> >                 int noblock = may_not_block ? GL_NOBLOCK : 0;
> >                 error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
> >                                            LM_FLAG_ANY | noblock, &i_gh);
> >                 if (error)
> >                         return error;
> >         }
> > 
> > See the problem?  In RCU mode we carefully fetch ->i_gl and verify
> > it's not NULL.  Then we proceed to dereference it again.
> > 
> > IOW, these ip->i_gl below ought to be replaced with gl, or you are
> > risking a compiler fetching the sucker again and getting NULL this
> > time around.
> 
> Wait, what's going on with this part?
>         if (gfs2_holder_initialized(&i_gh))
> 		gfs2_glock_dq_uninit(&i_gh);
> 
> First of all, gfs2_glock_dq_uninit() can bloody well sleep in
> gfs2_glock_dq().  What's more, it drops a reference to ->gh_gl,
> i.e. our gl, in gfs2_holder_uninit().  Where is the matching
> increment of gl's refcount?

The same applies to gfs2_drevalidate(), both before and after your
fixes.  Am I missing something subtle here?
