Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CC16419
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849988; cv=none; b=sj6Hu++4ihQAluE4M5RvS/96/htvoPjVSkROwnyJ+yCHK08C/5YCnBUij2tp8NNBk93X7hKuUlqMPlPh0N4JUhJstUjT/oeNjWiKq6srt24Vx07QbK5Qx8GR/jpSmtgddTnch6fITjrOGzcI1eIx2Xc2sFlf1faDZjuUevEliak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849988; c=relaxed/simple;
	bh=brJenJ2b96YY/rTiNQwq/ilnX6qpny3eRia8oOQ0D9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYkPZSK6dbeV6m7spZky5TZrW2Q+p4Yin8tse5wZMTdSi0BnnqPwCH0NK3+p4rsfl0yeugPrTCxiCRLYLsHcSOXhNvmwT879hFsujFGrcW+ncO5A5Np6MaalaRbpOugGyjOW1tY56kyASuI7XG37WvYvHBJvTtgIG/5RoD9fMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OhbqlHrb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OhbqlHrb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Am8lkPD8ZiWnLbZ9YkQgb36vGV+2R0DeXWtnwCfSW4=; b=OhbqlHrbJgw/CpszRdi4dqZSYT
	AZAlKvDLkPUJFXAqQyPUDdPbThNTq5a/2b/2jJRYF3wZaXOaw4NYDlcBpJynAQ1e+pCcUK1R8gEOZ
	7p5OSlnCc7cEPZHbCTRvg42Y0+DkJe3dKZXmFxEy9DO/EjPNuuG2FMKVD0dlX2e6Qmnm/QgD6WtyC
	zFYbRiYQt3OXRR2THGCc3pBxKju5TZSKcR/4TjUzOda9hPsk8sp++CZRHFMXwoURRnrOymrw8SBq9
	JPE8TUDilg1dE5i5eDD2dvKhW+mxs+D03tRwyRIivgiwoaorhJmFHTigV6jrC9KdmZisJbv3lCjPu
	3c/UL1UQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVleR-003fj8-2d;
	Fri, 02 Feb 2024 04:59:44 +0000
Date: Fri, 2 Feb 2024 04:59:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240202045943.GA873800@ZenIV>
References: <20240119212056.805617-1-agruenba@redhat.com>
 <20240202042312.GY2087318@ZenIV>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202042312.GY2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:23:13AM +0000, Al Viro wrote:

>         if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
>                 int noblock = may_not_block ? GL_NOBLOCK : 0;
>                 error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
>                                            LM_FLAG_ANY | noblock, &i_gh);
>                 if (error)
>                         return error;
>         }
> 
> See the problem?  In RCU mode we carefully fetch ->i_gl and verify
> it's not NULL.  Then we proceed to dereference it again.
> 
> IOW, these ip->i_gl below ought to be replaced with gl, or you are
> risking a compiler fetching the sucker again and getting NULL this
> time around.

Wait, what's going on with this part?
        if (gfs2_holder_initialized(&i_gh))
		gfs2_glock_dq_uninit(&i_gh);

First of all, gfs2_glock_dq_uninit() can bloody well sleep in
gfs2_glock_dq().  What's more, it drops a reference to ->gh_gl,
i.e. our gl, in gfs2_holder_uninit().  Where is the matching
increment of gl's refcount?
