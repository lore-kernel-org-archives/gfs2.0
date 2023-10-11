Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6335506
	for <gfs2@lists.linux.dev>; Wed, 11 Oct 2023 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBNO1xa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B6C433C7;
	Wed, 11 Oct 2023 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697005473;
	bh=2T6r6qpJcF0cqjXxOmrf8eKHVmrObSQHPiYsA1oCCMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBNO1xa7qa6/vbkQyCz4q7lR6HnMIol0IA1SUUUM4rI9Hef25dTXJ4QRhD19uzA3M
	 jyS5ZfXtQ4nx2dAR+3+36sSw/xZJNnzSxGjXSzZ8cjXHFcfnrgYCSa17R7PQaWllGQ
	 zJ0tghqcZdKSkIVDZJnWseYOfwZlQzKGMgMGXcX8=
Date: Wed, 11 Oct 2023 08:24:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev,
	christophe.jaillet@wanadoo.fr, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/8] fs: dlm: Fix the size of a buffer in
 dlm_create_debug_file()
Message-ID: <2023101124-overlying-gating-62c8@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-2-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010220448.2978176-2-aahringo@redhat.com>

On Tue, Oct 10, 2023 at 06:04:42PM -0400, Alexander Aring wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 8 is not the maximum size of the suffix used when creating debugfs files.
> 
> Let the compiler compute the correct size, and only give a hint about the
> longest possible string that is used.
> 
> When building with W=1, this fixes the following warnings:
> 
>   fs/dlm/debug_fs.c: In function ‘dlm_create_debug_file’:
>   fs/dlm/debug_fs.c:1020:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
>         |                                                          ^
>   fs/dlm/debug_fs.c:1020:9: note: ‘snprintf’ output between 9 and 73 bytes into a destination of size 72
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:50: error: ‘_queued_asts’ directive output may be truncated writing 12 bytes into a region of size between 8 and 72 [-Werror=format-truncation=]
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
>         |                                                  ^~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:9: note: ‘snprintf’ output between 13 and 77 bytes into a destination of size 72
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
> index e9726c6cbdf2..c93359ceaae6 100644
> --- a/fs/dlm/debug_fs.c
> +++ b/fs/dlm/debug_fs.c
> @@ -973,7 +973,8 @@ void dlm_delete_debug_comms_file(void *ctx)
>  
>  void dlm_create_debug_file(struct dlm_ls *ls)
>  {
> -	char name[DLM_LOCKSPACE_LEN + 8];
> +	/* Reserve enough space for the longest file name */
> +	char name[DLM_LOCKSPACE_LEN + sizeof("_queued_asts")];
>  
>  	/* format 1 */
>  
> -- 
> 2.39.3
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
