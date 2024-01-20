Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9597F7
	for <gfs2@lists.linux.dev>; Sat, 20 Jan 2024 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714605; cv=none; b=i1caILTf7LeY86noNSoIRqwxA4zLR8+E1S8WAWq+sdhvG1q5MOuj013HiTi5q/tnVt2eK8UvaT9uJC0E7ikYm9mvsREBf/lBZNyYhW+jZY3xJUf+rnh+Er/4n/DEKIDss4/UzRwKV5mbiJqfO8dSbva2mpAOiRDqxrQR8XdYves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714605; c=relaxed/simple;
	bh=6FoQBw7FoN1CsHh6ay3vwgjzNLfq9zdA+vsvaaEIxS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S23UHXFky59up1iu6g0/jaQtnN2OPXW6PPUsptRGiTA0vb5VFL95JgeYxjehNLTiNHpVGiHWUr/yYVNMZCFEbCQFflzCWkWUFi1lzM/v89dVWLlI++KnOw5ZeKdjPbXBSk0WXRvuZl5beIdhejG5eVd5SGPk+pIAJEK1BKPwUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q77L8tG/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q77L8tG/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L5c+ESrOKNs+qBw2PjCEgj0ZvkhiVH9q5W3F/mfJvGQ=; b=q77L8tG/GyzoReMRAuCVEUyTD3
	TJM6St+0ZuSICSWae3rNRnbyUSiQQ+9P+lAQEMgC56J5VsHxMgn9ZwbKTFEBMkqaDgCJ0ho5VLlJd
	SQ2ZPeqCKEBsFKnC3I20faPJKppiMDPOFXr7RVztL72vqFJOaMGdnJOOeDxhW1+wjRWE2brggO2bI
	7UxIYp6YHqxZ2awV3u6RSrXp+qYoQhOmVDFW/CXv+8LQM/ruHRvEcVS2Jg0aW6K5nXLhRkq06SfqH
	KgPYaDfg37rios6drnCif9p4YclU/whrJ+nO+9uEWl3STq5UnupfFezOYizJ3s3qmF0BZFqSzL7/i
	QRIU9/ug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rR0Hn-009GCu-0J;
	Sat, 20 Jan 2024 01:36:39 +0000
Date: Sat, 20 Jan 2024 01:36:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: Re: [PATCH 0/9] gfs2: Bugs in "Use GL_NOBLOCK flag for non-blocking
 lookups"
Message-ID: <20240120013639.GB2087318@ZenIV>
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

Nit: parent can't be NULL; what can be NULL in RCU mode is d_inode(parent) when
sampled inside ->d_revalidate().  IOW, it's not d_inode(parent) evaluation
that breaks, but passing the resulting NULL inode pointer to gfs2_dir_check().

> * Second, gfs2_dir_check() can still sleep, which breaks LOOKUP_RCU
>   mode.
> 
> These patches should fix both of these problems.  We'll either need
> these fixes added, or commit dd00aaeb3432 reverted for now.
