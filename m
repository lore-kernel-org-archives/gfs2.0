Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EF1AED48
	for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935454; cv=none; b=dwrmCAu5ITD9UKarrZofDah1f11ERk79r33o1ts8bGDhLh7X7rAvEQ5dJvXeh30wPyh80Gfi3YSzA4t9ovkG9wdkBa5TxsH2mT2gW5uy08DmEdKnqS2qLRnGrOzNIDv+x3MvZdkpr5YS7rX2oAUQjjSaeTsQ537KgCSejDj/f54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935454; c=relaxed/simple;
	bh=lfLTdafcsEuGOFPjpMNV0KJ8fzSonvm3FwaiG/nOhSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBMYAZkUKZFzKE3X3B8IYZjaQDkhWSx62IkRBhD6eCVjJZEon7PfalxJStOAxjgpaZ3OTG9mcpNp9k3gdMGQ7RXQb0nQaIHc1IRfPr1Rc9z5lZDfvY4BdWS6c7VxErtC6fPg/HSpAflELXN25AZPZAAH94UMUs6/aQ9CnXzXKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ERICCuMu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ERICCuMu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a66907fa39so31954285a.3
        for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724935452; x=1725540252; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDIUYBC2L7eWcoilq2cxGMLRTB2i97rgqz+O/DAOWVc=;
        b=ERICCuMuqeRPrT2NJKrrNMBZWeGZ5Npp6yAUTECGL/h8XCQPPSv9WUwmqMTV89YbZT
         qMvJpVcKxukB83B/0FeVq/T0fV40xfu9z3zt05t8NCMP2+DEtHJT/4sS8Jvp8CwuFShK
         AwIxodgQrsbscbtvajg+GwEr0Au7iwrJPf95IJFQSD7qTb7eAVMyit9zdIoN6GXI+YNA
         gnzN/qVX998u9detvj7wZzmEd3LZooVTsylhWmiZlNM7lzAPLewF6o04LQ9G6r2Qb4yW
         TOnVUmLEh/bNfkJA6yjZy8fKOyjimdn2qpNUd4AUn2XIdXPEmoDVVImMPnoHJ/oHAAJR
         P96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935452; x=1725540252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDIUYBC2L7eWcoilq2cxGMLRTB2i97rgqz+O/DAOWVc=;
        b=hf4LdFLKSPOJr6Hr5jyCYNMKSLa+aicsrBG3qU0v5VvW9WEJzjpF4f4vYAE8L9owhD
         XP4nySeH5QItSOjOUhvh5tP7xjYfkWkXKU3fM2jzrbfudSKWIHZoj99G2nos5eY9cHmT
         G7+SRkmHiO7xYV+5wVGIIGc/zLQKJT6SVkIgGRJ+ai5vEuhLPTCyUT20+LPzN5DVbDAi
         Gc4D6GywIFj/cyB7qyU8jQybdt6gKjwfkky7JPITLI/ix7sFGgxK3Hrv9rTAjKlNbsk0
         2Ti6KPLOeqf/ozD+S+Nu0cJNzE+rvBM5PBEY2DNOA73uuT8Qek07aPtYzsjZAIO4gQ3y
         Vrpw==
X-Forwarded-Encrypted: i=1; AJvYcCXv0dek1uBlIcjOZ585G2b0MHZpReAKxXaiRcHfezpv7bAWC/swgM7L08GYGa9phQtSZu/f@lists.linux.dev
X-Gm-Message-State: AOJu0YwThBiADyf307i4ZtuqZ4vfOqUbUwKZvUrv0Gsjxdx2EdAwmEZ2
	Ma8VHTzctqt6DMvrykZ52uH0AAtzXxhsVVxiYkFYdikV3pSRdAX48dslOyOxa64WEaz2UECwCh7
	u
X-Google-Smtp-Source: AGHT+IHKcKyxZbUbgoivcvWawCijARBN/hVWbwXg6/SpcUTxZzYYgp0UF6oGOYlxdfUyl58/xqWpDg==
X-Received: by 2002:a05:620a:1a11:b0:79f:84f:809f with SMTP id af79cd13be357-7a8041c6eafmr291062585a.33.1724935451586;
        Thu, 29 Aug 2024 05:44:11 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82744sm4499191cf.12.2024.08.29.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:44:10 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:44:09 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 11/16] fanotify: disable readahead if we have
 pre-content watches
Message-ID: <20240829124409.GB2995802@perftesting>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9a458c9c553c6a8d5416c91650a9b152458459d0.1723670362.git.josef@toxicpanda.com>
 <20240829104805.gu5xt2nruupzt2jm@quack3>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829104805.gu5xt2nruupzt2jm@quack3>

On Thu, Aug 29, 2024 at 12:48:05PM +0200, Jan Kara wrote:
> On Wed 14-08-24 17:25:29, Josef Bacik wrote:
> > With page faults we can trigger readahead on the file, and then
> > subsequent faults can find these pages and insert them into the file
> > without emitting an fanotify event.  To avoid this case, disable
> > readahead if we have pre-content watches on the file.  This way we are
> > guaranteed to get an event for every range we attempt to access on a
> > pre-content watched file.
> > 
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> ...
> 
> > @@ -674,6 +675,14 @@ void page_cache_sync_ra(struct readahead_control *ractl,
> >  {
> >  	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
> >  
> > +	/*
> > +	 * If we have pre-content watches we need to disable readahead to make
> > +	 * sure that we don't find 0 filled pages in cache that we never emitted
> > +	 * events for.
> > +	 */
> > +	if (ractl->file && fsnotify_file_has_pre_content_watches(ractl->file))
> > +		return;
> > +
> 
> There are callers which don't pass struct file to readahead (either to
> page_cache_sync_ra() or page_cache_async_ra()). Luckily these are very few
> - cramfs for a block device (we don't care) and btrfs from code paths like
> send-receive or defrag. Now if you tell me you're fine breaking these
> corner cases for btrfs, I'll take your word for it but it looks like a
> nasty trap to me. Now doing things like defrag or send-receive on offline
> files on HSM managed filesystem doesn't look like a terribly good idea
> anyway so perhaps we just want btrfs to check and refuse such things?
> 

We can't have HSM on a send subvolume because they have to be read only.  I
hadn't thought of defrag, I'll respin and add a patch to disallow defrag on a
file that has content watches.  Thanks,

Josef
