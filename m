Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C6F9C2
	for <gfs2@lists.linux.dev>; Fri,  2 Feb 2024 04:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847797; cv=none; b=LLEWRRwvq2RHsm636ADX1L1FdLdOUEH4fWOqurtnrpHq1iNLAqoYSbqrtOjp7jibG9vn9ncYnOnVtIlknHtYef9Ek1LA008O6zPbKYwNraYCfbBPhwrv5qiLZHeSkAZzV82TlLM02q39zeMsQbTLTUl32pNVkEelz9RtxiPffLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847797; c=relaxed/simple;
	bh=nPhDwMAebe8pzT/BxDtk06V73FWivvVewMS3CdbDNOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO42w2gw4lok0PSQge0zFwCAQdVhqdAhSJUwOh4Xg9xcO13adlNqbu4hBjjYckv+Ezkddhlpmr5HDCy4wOVHO0wcpaDorZa0twMo2KR5dU0qB/AKfo63rlGVNWaQ2WLphfAnF9mV/fSfqv/UKr0T9R1Qq9mk3pp6pgqZxHPyabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VV06s/8k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VV06s/8k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z3YsO8xFyha5YLQg4i1lpZkWFYobYBK21UqTzfE1ViM=; b=VV06s/8kAEzenWYze+PPZK+DxL
	662mCTKTQaXumfM9s7CDgiF4pOwKLIfgINGof34lRgB28EFvNWS8vcCogAp3PNOU3v1H+a6sFfoBZ
	cydZhkp0G6osKyoSR7lQKbOC3o8qWYsha8oWCuJoqkEpNFvsjwerFDwZpNG8CB07YAIIFSM3xPwmZ
	ZX0INef6KROOvJgRoYa8mFYlTaR0Q90P5DFGl4FjKI6D9tJYq8Gi6TwigJX62DDqU5akBVLI2mkLs
	QT2/JlL0V3aC30gPcGDM54NGD2/WVQ9GMLndxeroUrVo4ljYpv2ItGk4YD7gTpwgC3vnZ9Id34s8/
	8AobhXsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVl56-003ehE-30;
	Fri, 02 Feb 2024 04:23:13 +0000
Date: Fri, 2 Feb 2024 04:23:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240202042312.GY2087318@ZenIV>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 19, 2024 at 10:20:47PM +0100, Andreas Gruenbacher wrote:
> Hello,
> 
> Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
> GL_NOBLOCK flag for non-blocking lookups"):
> 
> * First, parent can now be NULL and dereferencing it in
>   gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
>   work;
> 
> * Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
>   mode.

Looks sane, but there's another piece of fun in gfs_permission():
        gl = rcu_dereference_check(ip->i_gl, !may_not_block);
        if (unlikely(!gl)) {
                /* inode is getting torn down, must be RCU mode */
                WARN_ON_ONCE(!may_not_block);
                return -ECHILD;
        }
        if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
                int noblock = may_not_block ? GL_NOBLOCK : 0;
                error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
                                           LM_FLAG_ANY | noblock, &i_gh);
                if (error)
                        return error;
        }

See the problem?  In RCU mode we carefully fetch ->i_gl and verify
it's not NULL.  Then we proceed to dereference it again.

IOW, these ip->i_gl below ought to be replaced with gl, or you are
risking a compiler fetching the sucker again and getting NULL this
time around.
