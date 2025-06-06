Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3628E0F
	for <gfs2@lists.linux.dev>; Fri,  6 Jun 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749212866; cv=none; b=b7Hng7GuHgtGj/frc2EFZbpsAmrYLMCJCdNO9mWSLI0pVa0E/NxZjWPhlQWOnAs6C1AULrmOkIpgV6jFfuIQMiKICkmWuvoKQxMnNUc97wCFKmpkU+yFowVOtmLF91XxYLsPdZNHRw0gwCLuEsnOURrw5d51yj9VZJ74XaSVRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749212866; c=relaxed/simple;
	bh=42toGXAmgyMjHp/IrZ1xXGWOXOsZJu0/2/EJT3oHPc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvPBe3DJn79r2F/HWcq8PpqsfsrzFPlh2mwrPT+D9g5e+PBY7xGhhBgunOT/62Zw+5vwkWsZTS82jyxBqUEUaPHAXJJsQBsxGg5i5luqkWh98fBYUPrfcnKQwu9tpS4AHRNN8X/MjRObXRuTZi96xAI1diru/7mIqWU92ocwvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IhVuvzLQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IhVuvzLQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GSdb0CWvE90OLSAKpqUYkEB8K+S9AnSTrgXrJIugiCs=; b=IhVuvzLQkDbtyvQS5ET6Wxd895
	OBhtsTI9KP+KmS8g+OktDLi+IOpIT6UZpWWM3FbqAZmUfGYQP+3yPPlctXXkBoR/Ufq2SAVR1H1i/
	84TF4cUguiRsO2dAu0bdz2AH9DFv1/WAG9afNiJG+EucBeOnt4jBJj0Qn/rphoW77uAlguhNeVJNz
	6L8UAloJqxR8pX+Rc3b5xD1Q3e782E2SyD0xfNykl9q2N8jXgDk/RnGe5wORPAHmoii/4awqHi9IK
	Zu2+VF5EAIiMDtvwQAsCL7DjdUp8ahTqAVD+V5mKqelPzFAVx+woJYKALrkJt/ewQ6ShooT7NbAf8
	hUF0rdgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNWAe-00000005JNu-2G4b;
	Fri, 06 Jun 2025 12:27:40 +0000
Date: Fri, 6 Jun 2025 13:27:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Su Yue <glass.su@suse.com>
Cc: gfs2@lists.linux.dev, l@damenly.org, agruenba@redhat.com
Subject: Re: [PATCH 2/2] gfs2: do not call gfs2_jdata_writepages for jdata
Message-ID: <aELevNcGGuS5lSSI@casper.infradead.org>
References: <20250606094756.95958-1-glass.su@suse.com>
 <20250606094756.95958-3-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606094756.95958-3-glass.su@suse.com>

On Fri, Jun 06, 2025 at 05:47:56PM +0800, Su Yue wrote:
> +++ b/fs/gfs2/aops.c
> @@ -138,6 +138,46 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
>  	return gfs2_write_jdata_full_folio(folio, wbc);
>  }
>  
> +/**
> + * gfs2_write_jdata_folio - Write folio
> + * @folio: folio to write
> + * @wbc: The writeback control
> + *
> + * Returns: errno
> + *
> + */
> +
> +static int gfs2_write_jdata_folio(struct folio *folio, struct writeback_control *wbc)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	struct gfs2_inode *ip = GFS2_I(inode);
> +	struct gfs2_sbd *sdp = GFS2_SB(inode);
> +
> +	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
> +		goto out;
> +	if (folio_test_checked(folio) || current->journal_info)
> +		goto out_ignore;
> +	return __gfs2_jdata_write_folio(folio, wbc);
> +
> +out_ignore:
> +	folio_redirty_for_writepage(wbc, folio);
> +out:
> +	folio_unlock(folio);
> +	return 0;
> +}
> +
> +int gfs2_write_jdata_folios(struct address_space *mapping, struct writeback_control *wbc)
> +{
> +	struct folio *folio = NULL;
> +	int error;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> +		error = gfs2_write_jdata_folio(folio, wbc);
> +
> +	return error;
> +}

The great thing about using an iterator pattern rather than a callback
pattern is that we don't need this stupid extra function.  So you can
drop patch 1 and just do this:

+	struct inode *inode = mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
+
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+		return -Ewhatever;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		if (folio_test_checked(folio) || current->journal_info)
+			goto ignore;
+		error = __gfs2_jdata_write_folio(folio, wbc);
+		continue;
+
+ignore:
+		folio_redirty_for_writepage(wbc, folio);
+		folio_unlock(folio);
+	}
+
+	return error;
