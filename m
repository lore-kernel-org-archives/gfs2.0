Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F0230D35
	for <gfs2@lists.linux.dev>; Sun, 16 Nov 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763281397; cv=none; b=XZNPMkqbVQAtZ6AFWt+1pLMVEbkyPfdomHlSp3TGQ/FPRpuVanL1TKvMIeDnb99s5l/PxuGAKJXgLwp3xMG7MgRQDjUJDBSPCeiOsqo3ijRAX06fWg5WjbRWWNMkTKcyQLTkeYpqd3xcZ0ox4UR+CBF/q/X1w3XepyxNzwX86TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763281397; c=relaxed/simple;
	bh=C+JcvFRwZHyavGe7kxRswHzD35IQVhdGIfMoOL9ybQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M80tEjPWyAzLDfKD87TY/VrdUrIegBdl9i++rWvH0qkKAwBmalxW6dSl9dzCWU7z+qvSip6iOyb6YVZy27Xn6mSHOvs3lyaIYNhRHaxYF5sZJbYgiUDmdJJU9uZFBYFoUMOVM5yyLAezvtMaCw8U0EbzpjFwsl/B5rUbyN9QmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xvx6DDhm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xvx6DDhm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298039e00c2so42692325ad.3
        for <gfs2@lists.linux.dev>; Sun, 16 Nov 2025 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763281395; x=1763886195; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4MaMBAoduJmljAfpOLsOwZXGopJOVWqjmgthPn26W4=;
        b=xvx6DDhmVGzNpuYtCbx3pErfUdmtpXi+py13gQQ6NdIBrEaQbp34Y/OT2nMgosbX91
         O012Y3BPO7uHxX5jm1YTQDUqVyfQ2sL5m+9nV1Ucq3i/toJMTLvKMhgzNIqO73KgGqkI
         wMzdN89+8aYad8PBWuBx0QOUD2uDwVINHnBGyvFNCyTUuqQ7eLq8z7nGkBtO0YwZyxs4
         dMXogrpGn/nf6nmSLDyByvmI1b1Kj3t+iBwbH37Fff1kSe5G36iCSlsc/oklFZ5ZzPRi
         aEXcvSH41gTiXuSs6hd/Ey7SDAwafW7wz0L3JG2L/ZaF1D5DRTRw0anXC+cR2N/CjuGn
         wjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763281395; x=1763886195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4MaMBAoduJmljAfpOLsOwZXGopJOVWqjmgthPn26W4=;
        b=bQiLqRDgTnzZoa5tmGYsCQzkFZGLJADiygsUmqKebyNkA3Mo9HVVzw2knnoH0NTrtH
         9KSPxqju3ELSdgts6lbsyfSNldj8/RGPu9FUsyX/Ic2xFrLpLm+UjfemtZxEcBuYZF1V
         gLLxxJ67L++woZcIozuADjtm919nW1MNZR4RXzmEVqe2wZnuxTZJLMAj3+OweqKmhCCq
         P7ke1NW6F8Xm+mbQ6n5a7zYNNtHJ/6HogkCKL/QAilI2qpF1umFNj5t8GXF/EWakHPgl
         CFEPVw1txAxPezDj7VNbMXOLGZpxIvBHqZaViBz/9ZlqvrHXJ55emaEZL/zBpfOfPbT/
         oJUA==
X-Forwarded-Encrypted: i=1; AJvYcCVyOnTrzwY/gnwZfHJqEHNLJuLhEvM4XHNMWl9y9eWjVZUTE0a/w9ihnGY7z4gAjNyHQ8ED@lists.linux.dev
X-Gm-Message-State: AOJu0YwKwF8IrEWxBATLt0eNS0uswY8IsuqvmemTnH1HaH2dfYzhCUPL
	7jVNGfhkZdI+mdzRfmahUNgkHW7lSvJAiPQf6oS46MGKTmekwzAFzPMy5zLmkHIkt5A=
X-Gm-Gg: ASbGncv0SjtY+YqIWp8KAYayo6Wzgjlu7exy9ol0si73HoFNdIZw2NHkpdNkKupK2+I
	iNl2JzGRC6MC8MjcyO8f8qVWWM5xLX1lWxDAfkdsygSBgMMYWXeH5Gh0zPMtJSbnJTuGfDneTeS
	XSnfwcQww1SgdCBq5PfwZeJzRIXGPH6G46NARqK11ql+o7gsY7FGkgeB5I4NIP9AizciCRYTY5R
	DTcNMymRimdQ4P7QD6UlqnGZz6uGjtZXYGQtK+uDFog8Nn/8UiDT8auxvPcmI/gbp6xf3R0GO8h
	NqXk0uYq0ztojC2oNXGDACur/YAyB8vcYmIbfxLlJZBCPF/Tk7UzMqIlj8nX0gZtl1iZq2duOwO
	RkQeBzDxqc9xrN4HVNwJBixejdunCym3iBiFUdkMU568ClsWyyYGPVtv9l1ZD+0+D9JCocz2AnB
	Ea0QPGhAQ0e/yeqscIIyF3TQ1AqjYiacFTLnCu45bs322IxdCJjJYrCTc4Kw7FnQ==
X-Google-Smtp-Source: AGHT+IE2kISBEpmbZV/bnZzdrwmOacrEejG6ljtHkn9ZRcGe++TC5tzXGzGVsKaVV/gcvGARY/ZhHw==
X-Received: by 2002:a17:903:41ca:b0:294:ec7d:969c with SMTP id d9443c01a7336-2986a769988mr112616935ad.49.1763281394800;
        Sun, 16 Nov 2025 00:23:14 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29864b00fc9sm79958015ad.40.2025.11.16.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 00:23:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vKY2R-0000000BUhZ-3a27;
	Sun, 16 Nov 2025 19:23:11 +1100
Date: Sun, 16 Nov 2025 19:23:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	io-uring@vger.kernel.org, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: enable non-blocking timestamp updates
Message-ID: <aRmJ728evgFnBLhn@dread.disaster.area>
References: <20251114062642.1524837-1-hch@lst.de>
 <20251114062642.1524837-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114062642.1524837-15-hch@lst.de>

On Fri, Nov 14, 2025 at 07:26:17AM +0100, Christoph Hellwig wrote:
> The lazytime path using generic_update_time can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case.
> 
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iops.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index bd0b7e81f6ab..3d7b89ffacde 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1195,9 +1195,6 @@ xfs_vn_update_time(
>  
>  	trace_xfs_update_time(ip);
>  
> -	if (flags & S_NOWAIT)
> -		return -EAGAIN;
> -
>  	if (inode->i_sb->s_flags & SB_LAZYTIME) {
>  		if (!((flags & S_VERSION) &&
>  		      inode_maybe_inc_iversion(inode, false)))
> @@ -1207,6 +1204,9 @@ xfs_vn_update_time(
>  		log_flags |= XFS_ILOG_CORE;
>  	}
>  
> +	if (flags & S_NOWAIT)
> +		return -EAGAIN;
> +
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
>  	if (error)
>  		return error;

Not sure this is correct - this can now bump iversion and then
return -EAGAIN. That means S_VERSION likely won't be set on the
retry, and we'll go straight through the non-blocking path to
generic_update_time() and skip logging the iversion update....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
