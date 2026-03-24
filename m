Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCC38550B;
	Tue, 24 Mar 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363577; cv=none; b=Q1tg2OvvRZt4LQ7HQsNSdJvzLM58JdrlYzEiEPmCdTAGjxPJNR7yY3MZ/W4utbRyA7JvG30Vt0NKc2XNbipo9df108exMovMHKQSD4MSBEqne5ghZg0JLyAZoXAvZPkaCN4f7QNL+aeC5v23c6FwgSCllV4Yv77NcxbFj1SvmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363577; c=relaxed/simple;
	bh=UWIV+K/qGtEH7ZKgoJEWzVwKMlwENux1/8Ss70q6l/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh403a5KhUjG8gKWD+jSt9ubABJu5V357wpmEi+a0x4v4PI4eNGD1KPQa/483OMT1kZJtTnFUnobmZi/gO7fqRDeaJ8cIPtG2J5bgWmAKSl7DE8ZrHBU1DYS/ESnIRrg9Xw3d2RZDS7d0dh6MGsIkm1p0qCl6bnkl19d4T28Vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wJ8l0nlZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wJ8l0nlZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cwVVMi7vmxcFXfM9UlzG8aZlAQOKiwb58DkXno89+xY=; b=wJ8l0nlZshfemt8vDF3oDUgt7k
	sf48mSIqk863x0/TEQ0XG3t2PPjT3e2DtOjo7lZIYdOKtEj7szZv4tZVkjJQ1n8RZIajqP6dWekNo
	MCD1f5oXiQBbTgwqINuIRT3eoz17sNg2JRBmcoJO7NeUV7x8eantLcfJNpYBHZoxFPElEFCyxv/JX
	zre2WEPZ/pJoQcZvs0EtWT/Ean5UlkB4VWhnmOaNo2x61rJQmFzJRViDaqYhNOHS/4tCP30KWdaBb
	KBJDj0j/gJits2CTU1bQ1HTjLKCkalod/cgbFs0oG+YWGujUFKSdn4SX8tKWueca7tB15Vrvy78Sc
	oxLVJC5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w531J-0000000EB5J-1ci3;
	Tue, 24 Mar 2026 14:46:13 +0000
Date: Tue, 24 Mar 2026 14:46:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
Subject: Re: [PATCH] gfs2: fix hung task in gfs2_jhead_process_page
Message-ID: <acKjtaMVQS_d0Esi@casper.infradead.org>
References: <20260324033959.1456418-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324033959.1456418-1-kartikey406@gmail.com>

On Tue, Mar 24, 2026 at 09:09:59AM +0530, Deepanshu Kartikey wrote:
> filemap_get_folio() returns an ERR_PTR if the folio is not present
> in the page cache. gfs2_jhead_process_page() does not check the
> return value and passes it directly to folio_wait_locked(), causing
> the kernel task to get stuck in uninterruptible sleep (state D)
> forever, triggering the hung task watchdog.
> 
> This can be triggered by mounting a crafted or corrupted GFS2
> filesystem image.
> 
> Fix this by checking the return value of filemap_get_folio() and
> returning early if the folio is not found.
> 
> Fixes: 240159077d00 ("gfs2: Convert gfs2_jhead_process_page() to use a folio")

No.  That commit only changed the code, it didn't introduce the bug.
f4686c26ecc3 may have introduced it, but I wouldn't swear to it.

I have my doubts that this is the right fix.  If you look at the entire
function, it assumes that the folio was already created and added to
the page cache.  The error should surely be detected earlier, not by
this function.

> Reported-by: syzbot+9013411dc43f3582823a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  fs/gfs2/lops.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 797931eb5845..005584311eff 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -467,6 +467,9 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
>  
>  	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
>  
> +	if (IS_ERR(folio))
> +		return;
> +
>  	folio_wait_locked(folio);
>  	if (!folio_test_uptodate(folio))
>  		*done = true;
> -- 
> 2.43.0
> 
