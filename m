Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136C1953AD
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212952; cv=none; b=jFLhrJYMRUkkfscb/OjCrrrhOZ5ULVeBTlKTso74H4YxdKGfIP1W7NMyIMfxNx9Roiuyi7oNhxnpj8QU21EzqSqvO7UJprk7hFyZ9baFcQLBuzL7vMJM1WYgBYb60w8zvl27C3ZMZp2IcJceheXnzYubT4HVlRRmhxj688pFXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212952; c=relaxed/simple;
	bh=LpyRcD+ea3Jdp/nt2MlljsOpqITTF/5WPLQdiyEFQoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3bEziGcrq0weLBurLhRPnW4bdy68jp+o3Pu8+stdY6j+Bg6OFCis5XQywL/GwYEPI61resXwCSY78auNcMfJBphZ65FDRMan7xqKOkzFl5bCLwnT2xvohGhsl5hvVMQOhh8ZewwqhuM04LVOlG7OWZibBXzZfNR57Ra3Y1iVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fYbHBRx8; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fYbHBRx8"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70b3b62025dso1343739a34.0
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723212950; x=1723817750; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjz2iKWP20OEyPShdLMLvLzhS5bKm3+7Fe0VrhQtc4A=;
        b=fYbHBRx8a2+Piz9Tnv9VmvZmUvNHjX/4+H7lAG3xpZR3FOPofhc/njKGV3ZB3MLnLL
         JpcadiX8Frrv3YceYghimxc8/ieApq6v4S6e2zvD68PiJ2WlIce3OL+LHoEUM/Idx4vL
         AqROHOBsNsFEBq0KJLbOkpjS+ZhqZ4Xz/6St68OZfXIyY4JurIm8e6r6IRyXQTWPdw1n
         dN8VFxkMQMZsXB2V75c4Ror1cciqMwgPZqSpa0I6vBm27U65W4Z5Zho6CIBk5iU91paa
         FYRaSkR/mINPIrgvJ7eKVnDghMhzuZLNOYSzpnK0pbsTtD0iaKswZW+kVCEWAd1I6aMw
         0sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212950; x=1723817750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjz2iKWP20OEyPShdLMLvLzhS5bKm3+7Fe0VrhQtc4A=;
        b=i1b7R0fvRvVzVW2sBROVfW2tX9YW1DoytT284Hjgm2fZgOQiC0oAe/3T8e1+xjvNRb
         dqsFiORgwbPmGpoSlMxjcJKIro5oFrEadzQ6D2vl03ybCf12Gu3BBxqGl5/e78oV0885
         L2li3yYjGRfgOPBamzwNSk1eteOvrsdZiLNelWTYARO0D3Ln3Dju2ZE1SJz9juSZ+4yZ
         c9R2Hml6NXjm30992/eyJi1gklemsYjMaOKHtpq5br1AFEU+fRE9OiXaXEgF+Z+Ban2m
         GNpzfXVBxQfwJCKyGWrctVagsuHqdgNCHrfhnfOAwUlxK4CmiJ0ZqrDMgL8J5aZwjKHQ
         OpIg==
X-Forwarded-Encrypted: i=1; AJvYcCXTnIV+Nfz5GD9VRT8+Az/a7K4nq0W5YFUw0bbHiaSBoCNfon/08Lta/zEU1ldAkCyGSluIkf7MQwsWuD4S0UtkMcxaKw==
X-Gm-Message-State: AOJu0YybiYrCdqdSqu+ZzeK9M7KoI1sdnZqz/2+EwW5s4wEONIXpnpmU
	IixyJy64BDC4C4GIvktL7zNulag9JWGJyATkrVjmqbHcsWZ2a1qfE7Gp6VaQIM8=
X-Google-Smtp-Source: AGHT+IGEYKuTYzX7n9Q4WkJAqsc2BKy4Op03cbPrmVLdwnUtrw0LcKrosgOY3AEQ0Vv59SDfcwKgvw==
X-Received: by 2002:a05:6830:611a:b0:703:5c2d:56a7 with SMTP id 46e09a7af769-70b74879a7cmr2362612a34.24.1723212949757;
        Fri, 09 Aug 2024 07:15:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e1f93sm265995685a.38.2024.08.09.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:15:49 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:15:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20240809141548.GB645452@perftesting>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>
 <ZrVAvQLfP8fNSJwx@dread.disaster.area>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrVAvQLfP8fNSJwx@dread.disaster.area>

On Fri, Aug 09, 2024 at 08:03:41AM +1000, Dave Chinner wrote:
> On Thu, Aug 08, 2024 at 03:27:18PM -0400, Josef Bacik wrote:
> > xfs has it's own handling for write faults, so we need to add the
> > pre-content fsnotify hook for this case.  Reads go through filemap_fault
> > so they're handled properly there.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/xfs/xfs_file.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 4cdc54dc9686..585a8c2eea0f 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1325,14 +1325,28 @@ __xfs_filemap_fault(
> >  	bool			write_fault)
> >  {
> >  	struct inode		*inode = file_inode(vmf->vma->vm_file);
> > +	struct file		*fpin = NULL;
> > +	vm_fault_t		ret;
> >  
> >  	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
> >  
> > -	if (write_fault)
> > -		return xfs_write_fault(vmf, order);
> >  	if (IS_DAX(inode))
> >  		return xfs_dax_read_fault(vmf, order);
> > -	return filemap_fault(vmf);
> > +
> > +	if (!write_fault)
> > +		return filemap_fault(vmf);
> 
> Doesn't this break DAX read faults? i.e. they have to go through
> xfs_dax_read_fault(), not filemap_fault().

Oops my bad, I had it right before then decided to make it cleaner and forgot
what the original code was doing, I'll fix it up, thanks!

Josef
