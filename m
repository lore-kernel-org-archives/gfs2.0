Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0371A680A;
	Mon,  1 Jun 2026 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292823; cv=none; b=Q8kiQS31FzG9imMuEPYA6BvsHAQlXPlhC96Czf5ed9zDkSf042nE6lUqUagmtbY9Nxz5bODj1OzVZ9nHa+FRuaVG+lqCjiBl2qNM3g+AdR66k8RLyTEelq2uPfplHm8Z9i8tijo7REM0gpFwqjqwfp4VEV9sZDIR9NHj+1r3A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292823; c=relaxed/simple;
	bh=ebvo+7Stwwiu9kJCve4vVDLTJDcRURLnzzg8xW7fpB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj7sMGnHLpyI2iIab9XDm7NUiuHgYDWnWNgEd+kVS1C481d+nUqFQRXqtVtCGGFVV5gb3rJiqFRfA8ser3amMYSUAr5K05wvgCDXwnZW5ts57GpwGvvQ21uOnf6XJG2sjTLH5A+kFt6dpZLH3QQwa14MvMuHas4ZQ7h/sLkGKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EWYq0cCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWYq0cCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D91F00899;
	Mon,  1 Jun 2026 05:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780292822;
	bh=rknCMjyFw5GicY8J9tL3c4sxuSkYpgvi2rVaLLFwW+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EWYq0cCWZNFidf/rBVmsLJKmdU0ELN68APKuMexrvyhOXUFBZJzdNu4zULqEE1HPC
	 SyZt5WFyGdJ7Us1HvdP74w65GF0szNgcaudPf/Tz8pLsoBhyoASvWCaoYEWe9dDavB
	 5HiXV4P1oOjAzOADwKJymlPsHKlTkn8Y2zzKdjIw=
Date: Mon, 1 Jun 2026 07:46:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: agruenba@redhat.com, swhiteho@redhat.com, rpeterso@redhat.com,
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhongling0719@126.com
Subject: Re: [PATCH] gfs2: Fix use-after-free in gfs2_remove_from_journal()
Message-ID: <2026060157-ranked-purify-579b@gregkh>
References: <20260601021813.15468-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601021813.15468-1-zenghongling@kylinos.cn>

On Mon, Jun 01, 2026 at 10:18:12AM +0800, Hongling Zeng wrote:
> The function calls brelse(bh) but then continues to access
> the buffer head through bh->b_private, clear_buffer_dirty(),
> and clear_buffer_uptodate().
> 
> After brelse() decreases the reference count, the buffer head
> may be freed, making the subsequent accesses use-after-free.
> 
> Fix by moving the brelse(bh) call to the end of the function,
> after all accesses to bh have been completed.
> 
> Fixes: e93b100931a4 ("GFS2: Fix slab memory leak in gfs2_bufdata")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/gfs2/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 78bba8cc10b8..a92c84146de9 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1038,7 +1038,6 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>  			set_bit(TR_TOUCHED, &tr->tr_flags);
>  		}
>  		was_pinned = 1;
> -		brelse(bh);
>  	}
>  	if (bd) {
>  		if (bd->bd_tr) {
> @@ -1056,6 +1055,8 @@ void gfs2_remove_from_journal(struct buffer_head *bh, int meta)
>  	}
>  	clear_buffer_dirty(bh);
>  	clear_buffer_uptodate(bh);
> +	if (was_pinned)
> +		brelse(bh);
>  }
>  
>  /**
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
