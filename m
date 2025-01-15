Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F931D7E3E
	for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972009; cv=none; b=FgaT6zwAKTzMUNgs9jvFWtqNZhSXUqPwzqB2TdKXb8bVfr59wCtBHIgSOGo1swYJX+pWD4tS+8PDV3FEkiHyv042s1CsYsrLqhB03822f47ixPbXvRQw0o+KHX2+Gpnw5u7kNF4SXPpCOdFk4OgIb+MYMIG0nhC/oMsiiT9Igb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972009; c=relaxed/simple;
	bh=obL59OqvVsLb3h0JUfcLhYG6T3UZLnSVbdV4KF6DQRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laAROzX6z31zgh8VLa3qZd0xIPUOkVLM6yBO/AgG3vyBacqm0BuFqilsMYb670x4E3ViJlxUia/mrGA1vc14loIghFl2zivBKQCU0yYE3K4ojjZxtDsPFS0ActAs30G0URQ2dXEjc1y+XX8Yx52PKODDEku51Ymr8xh3kbSZctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DX4z3/AJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DX4z3/AJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2156e078563so964775ad.2
        for <gfs2@lists.linux.dev>; Wed, 15 Jan 2025 12:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736972007; x=1737576807; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=DX4z3/AJ2kXtnqMnznXHKnOrZarI/CO1ukt/nJ+PwWl7s4epMhwEi6FOCytpW2nN4T
         e0yJ7aNyfgG6TyWFS8N8GGhVmoj3Af5D+8/jCJxxnzlT6gGn2rvO5StB9vPCLsau166/
         InuQVq4iX1dCgTYrNR6zbxZIMo11RslSAP6ORL9dBTdXUxBY+Z0Cbd8oB/HeOl5i7tpt
         N2AqHrmlDIIrK7j31Eu9MsrY5H83ZyIoUSzkBb8iO1ypSzXYbKQj38+0eRE8U23oiKrr
         O5ivgEf+TJgJOZd4FOrLDvD/Zlv8upR3LbpIUiezWIHEkxLkCUJFc/LCGX66pGHMFAh3
         Gydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972007; x=1737576807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10HfpUL4vbzTE8z3sE1cNiKFmGmMremYjdqrg8+vicQ=;
        b=b8uXUBWJMSR3T4/mbCa4tw72fJsQzSBxqJAmfTyMLbzlBtOAMCmBlvWzUiJSFe/uaY
         AU4LRqx9+zWbsXYLBhl41OuKSL0c1qWgK8d0deITka+7B9DziXv8BBw1DkfJuXz19Lfx
         qvFRmwks2+OsBxMw3Cy4pvzbkAkkuYKljUHChXm4UBu2OWVOVIpLxRvVA7cdyQd9StFh
         wWAajDj4RT8bhA/dSJd6CrP9cs3xUgg+1fDQAbRdJWYxpHnmvfxjcPuHmzYnZO6Dz3SN
         rx/LzepX34NqNgldH8DfTGcG5e4+XUVHpGNYW6dARpTCHdO+q6sKsLI5CpeESLvZzS+A
         Ptmw==
X-Forwarded-Encrypted: i=1; AJvYcCWeICZUodf6M50NGYpdKO27GFT/R++ia6FCq/Kaa7j/x78n2OJ0FAxyGO/qfqOsmiqgjzcW@lists.linux.dev
X-Gm-Message-State: AOJu0YxdasBHapckz1DWDTNoh6Zy+T6WRm9O5GSCREIwlQHuTfUDrI4V
	yz5/mDEYBpfxyDSS9aRfQ0E1+Ivuo3xzuagEpxST1jm567yGGuFjmE5KKZNMHCY=
X-Gm-Gg: ASbGncsr/+AggqmvdglOWo4MlQgHx2jMJ3Alebda2Q9AoAQOv2IcCJgL7yGi/C0CMpp
	rB/cpKqyTo4s6getdvMpmJSpzPW3h/DbuIUMY7Aw+41JEdgtkzcixuPNPointCCjjTsWIB/XtQN
	qsUMO43LVfX9EdM2hvSpX8R2LYU+Jngd4ycWGMg64B5KKj/AOUCuuaTInUahMGaHekDB4/rzcAu
	k/YOjJI221zEnKJTn0JqSsvzn/hRMvR12WETbZZaJKixzBwqoaYnsJA928eE6a7T5TGGtCQyH+j
	hpRxW7mchBajyLPHHQSotbMxYf0Bez25
X-Google-Smtp-Source: AGHT+IHnPTYH1M0KygFma+wZwcgjOIPDIchY7x9E9r6aOBRHS7OOYUKAFanmi2DmZuTGwBHC8Eg84w==
X-Received: by 2002:a17:903:32ce:b0:215:b8c6:338a with SMTP id d9443c01a7336-21a83f338a5mr470115445ad.4.1736972006983;
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219f0dsm86031465ad.139.2025.01.15.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tY9lT-00000006JFt-3Jp5;
	Thu, 16 Jan 2025 07:13:23 +1100
Date: Thu, 16 Jan 2025 07:13:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4gW4wFx__n6fu0e@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115094702.504610-7-hch@lst.de>

On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dcache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b4d5e9e1e43d..1a01d7a6a7a9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	/* Make sure we always see the terminating NUL character */
>  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
>  
> -	dentry->d_lockref.count = 1;
>  	dentry->d_flags = 0;
> -	spin_lock_init(&dentry->d_lock);

Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...

-Dave.

> +	lockref_init(&dentry->d_lockref, 1);
>  	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
>  	dentry->d_inode = NULL;
>  	dentry->d_parent = dentry;
> -- 
> 2.45.2
> 
> 
> 

-- 
Dave Chinner
david@fromorbit.com
