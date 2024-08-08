Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576915AADA
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155360; cv=none; b=lzgSOFcvZqsOr/XL/OerBoOhPG7GatdxHrurOcscn1UO0hSgQaHv5yYweCfS0Er3yblnAgEUSECTnbcuQ1qVzFcIeN4ba6N8oRhREyT3sEO5/dZRvea8w825MA1pGgWauh9gvZbDQZjzyZBRRwrOGYysjjHameBtziYQSEJEGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155360; c=relaxed/simple;
	bh=exENGfnpxAkEBxf+oAhPYpjb9Lo66i2NS4XjrUnzyh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuiqQ3glxif/9nbWH0a/0HNyu5967W/yryHPDtJku+dre9miofMCoKWnVkNx9EYyOtCM2fV5M0BW7wkdW/pDayJt3taXFS/mB+j9SrTB+BwQEyGlpeWgfzmicurhq9RpO0CM88cENcb9W0C9m1o27KEXUAYnF2CN/mzwqfDOOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xzTIHyY2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xzTIHyY2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc60c3ead4so12420065ad.0
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723155359; x=1723760159; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPoNozmItBTCtYaD8f/bm1mT3QLydoo7yknEwoaTs1U=;
        b=xzTIHyY2DuQbAsnMld6ae1rJpaIU9eruwzg10mKnv/wOU9Ee8iCSLvVzeUfhzA+1bl
         /i/F0aJmZ2nbMLfsXkkyIDcwQLZb4IgOUG3aWvhCU/cx2C4Ycshfy9RU9eEcXgZ5YjqN
         +inXMNm5CllyD60BljDnZD4xOIzjrgZl2yUeswsTA/M95FDv9r3UdvsxsFGNi/kxQha5
         E9KOZfx5GSKpvjXLZSb8AD2RdDMpRBVw6BLLCMjbu9DVm0G4bKLu7HvWsE96f1fooM/2
         Eoo5qh9qrlVCHT0Wtfxj6ndTnUUorO7M0Q9vQA9qELjLnO782umkSLO7rfsqr+UheNg4
         j4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723155359; x=1723760159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPoNozmItBTCtYaD8f/bm1mT3QLydoo7yknEwoaTs1U=;
        b=HtG0kt74b3jNds9wfhznROsKZa1jknxwgMbmqF4jgeDM61WE98bFC9EG74AdyirMwh
         44dg7KKrrqNDzwvN3cU2Rbi8Jgyp+Qj8Fe45M0RMelkc9rJEZp01+EqmZPqY00mgJ4ce
         K3tLofiT4YYoyknp7oo7IZcSk2FFWK+qp6d/A4Jx3Lqt+hZfGTx5Rvhm04NU9qkwmJxT
         Laah3jhGonwZsQPtNosGuJes2SMBMp94ZOTMgomPD0iPPOupOOee+oK+UR7rDoaZUj3f
         Rml2nCoMewVzTypWuCPXYCu+f3GHUta3YYtIYSAPDpPDw0BHOOJqONhH4xnHTk1wRXEG
         L6fA==
X-Forwarded-Encrypted: i=1; AJvYcCVPQgxjY4lrPGa8vmmOQsB2N21IDWIh7RlSSAHDnSHFNNWRX82zN4OuIGfYddyRVUJYNV6byTdbBhAmrRFCl/ZMZC2nbw==
X-Gm-Message-State: AOJu0YxxKK0RPRKH2LxJ6YUJupLYihaF8C2FU/xfkL6OFd10ME+cOovC
	QEQ0Za/q0RlbnnGs3TqnnVbsTNl9HqukCzxC47Y4YyDkapWlSaoJ08fkk4GGVPg=
X-Google-Smtp-Source: AGHT+IGYb+VJppD0Q3Q/VxC7gerhv3j7lcSOY+aPPjer9GdOi5mky/V7oggcjnnGpaBi8Q6wRw0F5w==
X-Received: by 2002:a17:902:e892:b0:1fc:6a81:c5a1 with SMTP id d9443c01a7336-2009521fa1dmr39597765ad.12.1723155358600;
        Thu, 08 Aug 2024 15:15:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178772sm129200895ad.195.2024.08.08.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 15:15:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scBQJ-00ACjo-2z;
	Fri, 09 Aug 2024 08:15:55 +1000
Date: Fri, 9 Aug 2024 08:15:55 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 00/16] fanotify: add pre-content hooks
Message-ID: <ZrVDm+Tjuv6tWlY3@dread.disaster.area>
References: <cover.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:02PM -0400, Josef Bacik wrote:
> v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/
> 
> v1->v2:
> - reworked the page fault logic based on Jan's suggestion and turned it into a
>   helper.
> - Added 3 patches per-fs where we need to call the fsnotify helper from their
>   ->fault handlers.
> - Disabled readahead in the case that there's a pre-content watch in place.
> - Disabled huge faults when there's a pre-content watch in place (entirely
>   because it's untested, theoretically it should be straightforward to do).
> - Updated the command numbers.
> - Addressed the random spelling/grammer mistakes that Jan pointed out.
> - Addressed the other random nits from Jan.
> 
> --- Original email ---
> 
> Hello,
> 
> These are the patches for the bare bones pre-content fanotify support.  The
> majority of this work is Amir's, my contribution to this has solely been around
> adding the page fault hooks, testing and validating everything.  I'm sending it
> because Amir is traveling a bunch, and I touched it last so I'm going to take
> all the hate and he can take all the credit.

Brave man. :)

> There is a PoC that I've been using to validate this work, you can find the git
> repo here
> 
> https://github.com/josefbacik/remote-fetch
> 
> This consists of 3 different tools.
> 
> 1. populate.  This just creates all the stub files in the directory from the
>    source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
>    recursively create all of the stub files and directories.
> 2. remote-fetch.  This is the actual PoC, you just point it at the source and
>    destination directory and then you can do whatever.  ./remote-fetch ~/linux
>    ~/hsm-linux.
> 3. mmap-validate.  This was to validate the pagefault thing, this is likely what
>    will be turned into the selftest with remote-fetch.  It creates a file and
>    then you can validate the file matches the right pattern with both normal
>    reads and mmap.  Normally I do something like
> 
>    ./mmap-validate create ~/src/foo
>    ./populate ~/src ~/dst
>    ./rmeote-fetch ~/src ~/dst
>    ./mmap-validate validate ~/dst/foo

This smells like something that should be added to fstests.

FWIW, fstests used to have a whole "fake-hsm" infrastructure
subsystem in it for testing DMAPI events used by HSMs. They were
removed in this commit:

commit 6497ede7ad4e9fc8e5a5a121bd600df896b7d9c6
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Thu Feb 11 13:33:38 2021 -0800

    fstests: remove DMAPI tests

    Upstream XFS has never supported DMAPI, so remove the tests for this
    feature.

    Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    Acked-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Eryu Guan <guaneryu@gmail.com>

See ./dmapi/src/sample_hsm/ for the HSM test code that was removed
in that patchset - it might provide some infrastructure that can be
used to test the fanotify HSM event infrastructure without
reinventing the entire wheel...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
