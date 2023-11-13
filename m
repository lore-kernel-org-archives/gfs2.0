Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7302511D
	for <gfs2@lists.linux.dev>; Mon, 13 Nov 2023 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVDPstfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A1C433C7;
	Mon, 13 Nov 2023 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699910821;
	bh=zhRlX6fbqb46HzJoDlywuWbd5ARstyFmls/0maFAwlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UVDPstfrsG5h4B1sqaxhATVpQi8M4NjLYQSgJ8ajJoPKs+s8FN+UOUtjjXznJo9Lq
	 w6oztGI5GXAV4n5psIixMxiozOvajn4IfwCP/Dn9PFtfFcz5YeEdfM6CWiCRc1FKu8
	 ES6xNlqMbt24nlYjdITNn9uiJC4dghvKuQq7v1qEIIKQr9wjM6cBxoPB9uPezxXmES
	 PQ+w1gUjB7Bn864XMHr+MWGfMGdxwf4ses0+CAISX8XMI+qCbyMfehVDEYKf8YqM80
	 JEV2k5bOh/oBHIsr3OTlni66BusmgmxHsS1W/4so1AY1qZJGHo6acJ8Err2ompazdX
	 BOLi0Bw5H3vNA==
Message-ID: <7d0d278ee30c09c868c59c80ef6a4cf9dee5683c.camel@kernel.org>
Subject: Re: [PATCH v6.7-rc1 2/3] dlm: use FL_SLEEP to determine blocking vs
 non-blocking
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Aring <aahringo@redhat.com>, teigland@redhat.com
Cc: gfs2@lists.linux.dev
Date: Mon, 13 Nov 2023 16:27:00 -0500
In-Reply-To: <20231113212411.4187690-2-aahringo@redhat.com>
References: <20231113212411.4187690-1-aahringo@redhat.com>
	 <20231113212411.4187690-2-aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2023-11-13 at 16:24 -0500, Alexander Aring wrote:
> This patch uses the FL_SLEEP flag in struct file_lock to determine if
> the lock request is a blocking or non-blocking request. Before dlm was
> using IS_SETLKW() was being used which is not usable for lock requests
> coming from lockd when EXPORT_OP_SAFE_ASYNC_LOCK inside the export flags
> is set.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index ee6e0236d4f8..d814c5121367 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -140,7 +140,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 nu=
mber, struct file *file,
>  	op->info.optype		=3D DLM_PLOCK_OP_LOCK;
>  	op->info.pid		=3D fl->fl_pid;
>  	op->info.ex		=3D (fl->fl_type =3D=3D F_WRLCK);
> -	op->info.wait		=3D IS_SETLKW(cmd);
> +	op->info.wait		=3D !!(fl->fl_flags & FL_SLEEP);
>  	op->info.fsid		=3D ls->ls_global_id;
>  	op->info.number		=3D number;
>  	op->info.start		=3D fl->fl_start;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
