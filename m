Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB2224CF
	for <gfs2@lists.linux.dev>; Thu, 12 Oct 2023 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVf9CfxR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MN4aw+H8x9I8ocfXj4qAXW3BVF6ab2jLo4Kywjjo1V0=; b=tVf9CfxRe74OjyfrZRlV28zQ/x
	l/22Z5xW7yh5jD/E4OJvj4hokWO5CB/R2q1J4P+Pe9pfngm6pujhZgR2pLah56JKGmfkhJblzpP4r
	lQlcVa+0rDLNDPWPFi8lfj4VLShDtAxe/xqRWRmavHJceyxJLGsUO0x3m96K4peFCNa2uxExDYXnZ
	vnajkCZGXavD0Vf2iz2Fmx6Qs9JJMpLihddW6frth3Qm85op1kUND8KjvRCTxNYLZy0rKtSA9SVIg
	YBVsQ4NsSXA4V6h+4MOpuS0HM0jpZ1347j/dSpstGHeMiZu+81jEC1/60eQ7vnx4rXgwcNtz5WIwR
	eJdi040A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qqxbP-00027A-QN; Thu, 12 Oct 2023 15:27:55 +0000
Date: Thu, 12 Oct 2023 16:27:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gfs2@lists.linux.dev
Subject: Re: [bug report] gfs2: Convert gfs2_jhead_process_page() to use a
 folio
Message-ID: <ZSgQe27OCfUpmsbS@casper.infradead.org>
References: <fb027038-46ee-49fa-be1f-28926e7e2387@moroto.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb027038-46ee-49fa-be1f-28926e7e2387@moroto.mountain>

On Thu, Oct 12, 2023 at 12:43:34PM +0300, Dan Carpenter wrote:
> Hello Matthew Wilcox (Oracle),
> 
> The patch 240159077d00: "gfs2: Convert gfs2_jhead_process_page() to
> use a folio" from May 13, 2022 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	fs/gfs2/lops.c:485 gfs2_jhead_process_page()
> 	error: 'folio' dereferencing possible ERR_PTR()
> 
> fs/gfs2/lops.c
>     469 static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
>     470                                     struct gfs2_log_header_host *head,
>     471                                     bool *done)
>     472 {
>     473         struct folio *folio;
>     474 
>     475         folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
> 
> Does filemap_get_folio() need to be checked for errors?

In this specific case, we know that the folio is there and will always
be returned.  See the comment on line 484.  Can I annotate this call so
that the tool knows this is a special case and doesn't warn about it?

>     476 
>     477         folio_wait_locked(folio);
>     478         if (folio_test_error(folio))
>     479                 *done = true;
>     480 
>     481         if (!*done)
>     482                 *done = gfs2_jhead_pg_srch(jd, head, &folio->page);
>     483 
>     484         /* filemap_get_folio() and the earlier grab_cache_page() */
> --> 485         folio_put_refs(folio, 2);
>     486 }
> 
> regards,
> dan carpenter
