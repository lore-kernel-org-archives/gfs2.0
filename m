Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE235506
	for <gfs2@lists.linux.dev>; Wed, 11 Oct 2023 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UI1VydtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DBEC433C9;
	Wed, 11 Oct 2023 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697005456;
	bh=7/uwHN1zSxNRhoc9LRHfanqFBxW8eUQj3CH1DUDb+fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI1VydtMw8z/XJ28RwkF+gggPwKisMi3wpmy55u/uTGtRr/m/B2cl4jFd4Sd3amjf
	 RX7OLS2+FWwxZM8KnMIOhJzY0S1UoR7b0Ouh8Tcq50G/ANbvSFtwvBaw6l7KaYJQhO
	 xKgLRnt1riHbtGWK2WBJbQMEr7mmZPm+9iQa2PLg=
Date: Wed, 11 Oct 2023 08:24:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 3/8] fs: dlm: Remove some useless memset()
Message-ID: <2023101105-flashing-image-8778@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-3-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-3-aahringo@redhat.com>

On Tue, Oct 10, 2023 at 06:04:43PM -0400, Alexander Aring wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> There is no need to clear the buffer used to build the file name.
> 
> snprintf() already guarantees that it is NULL terminated and such a
> (useless) precaution was not done for the first string (i.e
> ls_debug_rsb_dentry)
> 
> So, save a few LoC.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c | 5 -----
>  1 file changed, 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
