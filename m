Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32126A3C
	for <gfs2@lists.linux.dev>; Sat, 20 Jan 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714744; cv=none; b=HrKOv84jYQwYIsXhcAiv2pP6HrqXb+3I9OoItPDqyxEBv+Fyu1mA86NlodOI4jvGAn6zL3dLqQWjDRLizPZMBovjfgZsy5so+XxXb2H1xrjA5XARrYuUhbGU/qQowoOfw/0GkDu53utU/TAA2vDXUC32kFaFKHVQrHCdb30Aqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714744; c=relaxed/simple;
	bh=NqKGUwCmeSBYeVwI2LH1SZi5LBrWxNINm89mGgOOEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfznOMZ27GnaZND7R/upc/5KhFaXKvu1DwqKPulL2mO38LhFE/vnmt83zCusvCnkx8gFPUOvSxv02Gf7M9OJqNuegWdVgf69Ep9RmEGsaiPZy6InCWYUtj7LHURzCvBISX/kPquTN3FnvnvkaRdU34XqyTbDa4Q4JRVW1FN8foE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PSfEKQfU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PSfEKQfU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DBiyLmYCo4YEBhnAJDSS7cLIDTJ7yZdk7iqFZNtpi+8=; b=PSfEKQfUhYqwAZDhLoySzdSQ4A
	VoTMEgIthYDSQ4r6AoelxIa4v2fS5KvfUliF4R0/CPXiaQCj/HY5e6VMh+LSzIgN8i7YmuJrqs0WK
	Uz0NP4LPpEyY3tAFxxBtSES/mjZ55w13dqsITGLtlzpVb5qyLNcpHO5H4xATHpki3W8AETnxpuUHs
	h4HNWVjR6e7LMVVIlg0JAyWs2slIG8kcUW/fQ/82cSqIuCvD+uzbOXvAc5aVFOJI+gjdhOQ/qcj8S
	q0ZLHLalYj4vJ8zKAyvrD62YIF+P/+kAxC1sB//txPLqRhYFjONs/P0YyVoreKaWw84zheTDOaOhd
	E03MnEdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rR0K3-009GJf-1O;
	Sat, 20 Jan 2024 01:38:59 +0000
Date: Sat, 20 Jan 2024 01:38:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240120013859.GA2207555@ZenIV>
References: <20240119212056.805617-1-agruenba@redhat.com>
 <20240120013639.GB2087318@ZenIV>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120013639.GB2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 20, 2024 at 01:36:39AM +0000, Al Viro wrote:
> On Fri, Jan 19, 2024 at 10:20:47PM +0100, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > Al Viro has reported issues with commit dd00aaeb3432 ("gfs2: Use
> > GL_NOBLOCK flag for non-blocking lookups"):
> > 
> > * First, parent can now be NULL and dereferencing it in
> >   gfs2_dir_check(d_inode(parent), &dentry->d_name, ip) isn't going to
> >   work;
> 
> Nit: parent can't be NULL; what can be NULL in RCU mode is d_inode(parent) when
> sampled inside ->d_revalidate().  IOW, it's not d_inode(parent) evaluation
> that breaks, but passing the resulting NULL inode pointer to gfs2_dir_check().

Nevermind, the way it's written parent will be NULL in RCU case.  Sorry about
the noise.
