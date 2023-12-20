Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63604776A;
	Wed, 20 Dec 2023 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFWoN+nu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TAaCCvMwE+eY8DymPOKkhFEiQo679zhyiW9NkuSAD1E=; b=IFWoN+nuPzVZRae2GktEKuruwK
	g0yyCReMdWTFvuyH7FMM6bLD8P9++noONVAu3WaQdh1x7F9U/4PQk4yoEiXm+thkQllMBVArUeQ64
	hle7ctQieHExYQKW87ccnVXfCbKbuS4g9Mz9CMcTYq7ukUp3yMj3+8S0c6/OVF0ez6eUDvJilCCcl
	RHZRoQPJNt+BhKzSnQXzV1ysYm8ZrCVX//laHJcWaRMgQ3EpkZ4b9avqkbojrDj+bv+7LqxBFoe3c
	0mZmkprpWECKuKq27T9wi2lz2PEpQfVk2kZ8SOc3xj3hCjXdmXA+UQld2/hU8IKz9s0twDNXb2kbw
	ug79adQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFz4Z-0047gz-Cc; Wed, 20 Dec 2023 16:05:27 +0000
Date: Wed, 20 Dec 2023 16:05:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Remove use of error flag in journal reads
Message-ID: <ZYMQx2070yb9Vkgs@casper.infradead.org>
References: <20231206195807.764344-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206195807.764344-1-willy@infradead.org>

On Wed, Dec 06, 2023 at 07:58:06PM +0000, Matthew Wilcox (Oracle) wrote:
> Conventionally we use the uptodate bit to signal whether a read
> encountered an error or not.  Use folio_end_read() to set the uptodate
> bit on success.  Also use filemap_set_wb_err() to communicate the errno
> instead of the more heavy-weight mapping_set_error().

Ping?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/lops.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 483f69807062..314ec2a70167 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -391,22 +391,15 @@ static void gfs2_log_write_page(struct gfs2_sbd *sdp, struct page *page)
>   * Simply unlock the pages in the bio. The main thread will wait on them and
>   * process them in order as necessary.
>   */
> -
>  static void gfs2_end_log_read(struct bio *bio)
>  {
> -	struct page *page;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
> +	int error = blk_status_to_errno(bio->bi_status);
> +	struct folio_iter fi;
>  
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		page = bvec->bv_page;
> -		if (bio->bi_status) {
> -			int err = blk_status_to_errno(bio->bi_status);
> -
> -			SetPageError(page);
> -			mapping_set_error(page->mapping, err);
> -		}
> -		unlock_page(page);
> +	bio_for_each_folio_all(fi, bio) {
> +		/* We're abusing wb_err to get the error to gfs2_find_jhead */
> +		filemap_set_wb_err(fi.folio->mapping, error);
> +		folio_end_read(fi.folio, !error);
>  	}
>  
>  	bio_put(bio);
> @@ -475,7 +468,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
>  	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
>  
>  	folio_wait_locked(folio);
> -	if (folio_test_error(folio))
> +	if (!folio_test_uptodate(folio))
>  		*done = true;
>  
>  	if (!*done)
> -- 
> 2.42.0
> 
