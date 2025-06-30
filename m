Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7F25B2F4
	for <gfs2@lists.linux.dev>; Mon, 30 Jun 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286976; cv=none; b=HjcBNISTZOWhpW39MJN5JfoOC1zVhvPoa4gC+eUHyLzfc6DKiKk5GP23Om9pALaGpS1etI/OqhBTekXf3MwnLNLQTdkWyMClhp6NM1HyTd86Y8ZNdOPWV4aURca+ARX4CWN0vwJFWdYt2vDFDYOzjUUbn9XRdHzY3a5aj162wqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286976; c=relaxed/simple;
	bh=4S1Qz8+LByg7GWP4XcSBf1VmSxBsX++A1xQo5Nd84lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSAV9/T/uLm9RJxx/Y80RboXqu5CvSKvRG9yiyyWmKuGf3ldYEHlBNxbsBXDAeO4eOor/Ko70jtFg1UQ5aw3cmT7dTOfRY5mTFVc957YJiwO9jUFJIr/SclPCgt78QBrh4lLsnq82CuikK77Q72rad6vc1i9iP+pWtYZBQjC11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIFpGHH/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIFpGHH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzyNtAG2hFxEy1cV+hJtMOhP7SZEkjB/O/WeifVDoxM=;
	b=ZIFpGHH/POJuulW598IKD2JliRODS+8nuqfrhZHQgY2eV68Yie0Gft81Olcmnnd3uMI3Y4
	z5ovOEgaiw37izWAZlzABQgIF5T7ltN7pt5OHXX7+U72CTVjA7SkSnNEprGveoOHe8NJlh
	MXocSh451OXrkTNoP++Cd4E6tyX39JM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-E_m2XJBHPpCcArfze3mx2g-1; Mon,
 30 Jun 2025 08:36:12 -0400
X-MC-Unique: E_m2XJBHPpCcArfze3mx2g-1
X-Mimecast-MFC-AGG-ID: E_m2XJBHPpCcArfze3mx2g_1751286971
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFD181809C83;
	Mon, 30 Jun 2025 12:36:10 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE51C18003FC;
	Mon, 30 Jun 2025 12:36:08 +0000 (UTC)
Date: Mon, 30 Jun 2025 08:39:46 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 08/12] iomap: move folio_unlock out of
 iomap_writeback_folio
Message-ID: <aGKFkicCr2lWcCwG@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-9-hch@lst.de>
 <aF7JHFdLCi89sFpn@bfoster>
 <20250630054542.GE28532@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054542.GE28532@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jun 30, 2025 at 07:45:42AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 27, 2025 at 12:38:52PM -0400, Brian Foster wrote:
> > > Move unlocking the folio out of iomap_writeback_folio into the caller.
> > > This means the end writeback machinery is now run with the folio locked
> > > when no writeback happend, or writeback completed extremely fast.
> > > 
> > 
> > I notice that folio_end_dropbehind_write() (via folio_end_writeback())
> > wants to trylock the folio in order to do its thing. Is this going to
> > cause issues with that (i.e. prevent invalidations)?
> 
> Good point.  It renders the filemap_end_dropbehind_write call (the
> function got renamed in 6.16-rc) essentially useless.  OTOH this is
> the case where no writeback happened due to a race, so it isn't needed
> to start with.  But it might be worth documenting that fact.
> 

I'll have to read through it again on the next round, but yeah if it's
just a calling context caveat then please do leave a note somewhere that
it's known and why it's ok. Thanks.

Brian

