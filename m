Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3780C0C
	for <gfs2@lists.linux.dev>; Mon, 21 Oct 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549863; cv=none; b=Ro2/d0adk4v7WXZeE6KMT7X0qXAwZyDpZfaCurvHoONInOvwL+R94eBEJ9S/l8EWwV5SBRZ20GYQj2OumB3b5CzRrFoiuUY+aPBRnxb/QeW+XOyW0dVOhDIj5FvXDfTiP18SrNIBCT5RfYBe4ckSjVUYjtFo561c3nbtvz55KhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549863; c=relaxed/simple;
	bh=02WBLYn5hm46RGjKT09iky3RgWRBw1dRwnKC0MwXA8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgfD5zha6CTTRdfua7E2RuEx2ProS9dOgs0YdL+F3taIEhe2VqazFk/QXNecZLKRi2jP4C8ppnkvSq4WxbLw6n1z9kgkZytKcwRB9TL1dIa1s5nPl7GcXjXuPhgGpZbiVCpfcsg6+AMzX8DtUveL95AC9VKElrE6rrh+/UU0538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HjEWP8dM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HjEWP8dM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so40887795ad.2
        for <gfs2@lists.linux.dev>; Mon, 21 Oct 2024 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729549860; x=1730154660; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpov8qknWLMdPqHJDFq36iRXP4pxjN7UjssnKFRCVMo=;
        b=HjEWP8dMqoSIlEmpGroKoXI2ynCDCNj2qUK4Va8QLYKl3nw0Rfztnlr2I6oys5BRiZ
         KQ6A8F3U8EFOy0frULOYRlQMcp+9kJeWKJovMhNQ3JfUrzEMhmIRMnE5qtFTtk7WSAOm
         KifSxABz98g7cdS0wkGeAZLHMQ75rY4BZF3vcE07wdFYDDl6BmGQDXOq/nGw/T76Sfnq
         7q7FHO5Pvw3YxqMYOUo07Pq1IUHDGaDbO8e4XWFfY3CkzpYJU58WiwwZtmSFks0dR0TN
         GPsp27M/5JF3JGB/J19y1BDiHsb+jJNvFW2T/dy955xws1ZbVFYOiA9nvMt5k8DGuEjL
         uReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549860; x=1730154660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpov8qknWLMdPqHJDFq36iRXP4pxjN7UjssnKFRCVMo=;
        b=T/PFTvxo8Ey8navBT7yaveKnARWLpfuLVrFpojeA/FSRfcfoRlgsMhicdlV+3eWMGI
         oxQZGA6CFAVw7FCZ1eRyX2OcdCqdZ8AkeCr2FZwhxGi47OwXwZ4FlA93W/fFgOQO4Hk6
         /9nqc+jpvtSRyobGphUraywVKFbmFlwHH92kuzPNxfCT3gX4pDQm2IHTiiztEi037nE+
         JG9MzWViQPpzGkFbpmrp7tM+gxybHTYQO87CI+rN7cuoIO7y5RJyEAg6F84InFWHLmTh
         oLj9RTyBPFSWoUWEoXKmlcd29gB605+/neR0X7plgOnhb0NTNW9/uIXKoLtq1z5Ojx+5
         7g1A==
X-Forwarded-Encrypted: i=1; AJvYcCUhScGuLaF53e7HMGojXWatZFObQiF+7Tdk8un4m4etKQyBtFO1skkmjAdHf+kXRFQ0sdOA@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsgw843rEe+/48AHyCI7zPMoQiMJ1mxm12Vq/gkxDopAt8axM0
	c5dv1NKgye0q+AnbLBhXDzNFaRmu8JAHvX35ldHjYQtiCY4zkAuADFTTSB0R/4s=
X-Google-Smtp-Source: AGHT+IGnZvSN/JgkvgxC51U5ZIowUxltQuOXg6wu1T2t8vfivVOuEl4426pU73OYYuA8tQqUXZlpGA==
X-Received: by 2002:a17:902:ce85:b0:20c:c1bc:2253 with SMTP id d9443c01a7336-20e5a8a101dmr167189345ad.32.1729549860470;
        Mon, 21 Oct 2024 15:31:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3ca3sm31011095ad.274.2024.10.21.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:30:59 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t30vQ-003zWR-2L;
	Tue, 22 Oct 2024 09:30:56 +1100
Date: Tue, 22 Oct 2024 09:30:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: writeback_control pointer part of
 iomap_writepage_ctx
Message-ID: <ZxbWINZwAEJEdX7S@dread.disaster.area>
References: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326b2b66114c97b892dbcf83f3d41b86c64e93d6.1729266269.git.rgoldwyn@suse.com>

On Fri, Oct 18, 2024 at 11:55:50AM -0400, Goldwyn Rodrigues wrote:
> Reduces the number of arguments to functions iomap_writepages() and
> all functions in the writeback path which require both wpc and wbc.
> The filesystems need to initialize wpc with wbc before calling
> iomap_writepages().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks reasonable to me - there's only one path this comes in since
we got rid of iomap_writepage()...

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
