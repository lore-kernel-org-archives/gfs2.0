Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505F54281E
	for <gfs2@lists.linux.dev>; Thu, 15 Oct 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077806; cv=pass; b=YBOREX84iVcSpXQaCbx78jmlWZ0lpt7c8mMSxr1gq0U/wqSIEjyznvQfSVz4vKWb2aWjEVqhdaWpcnXrz7k5UPAsGnJsV0dO85WjZjeRhkwDowCJu+CBNAGYegWivMx7ElsfMrr6wD0nsoSFc5i6JYisWZCEzT4Z15V7iEFaKtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077806; c=relaxed/simple;
	bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5QYT4L4IkOCh+eZt3Xc2WjVZ5AUvaaRlqVVlK7IJW2QWrwS8buGLqKplN95L/e9cYDoF155S40z3pzjRzQ6YOrMtjLKbcy8Q0SBe9NK0ouL0BUgoKC1qrRT8nAHMnpPtke/oz+ighqPkaF6A/BIXFtB2kltB4qkQUEpUYJpoKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9JljAdn; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9JljAdn"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-677dbe051d4so1789457d50.0
        for <gfs2@lists.linux.dev>; Thu, 15 Oct 2026 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077799; cv=none;
        d=google.com; s=arc-20260327;
        b=JkJFy00SWbT71G1gxOTqkjfVBhe5NFuybYyY8SS2gXgwSLg6OHGiRFHprfhJRcjMvN
         JFRFPrbWxO7JVJDHrLV8L+PG/ozd/TNS7geQETFdsn0YRxcWhi+EUa9xMrJfWPm0j+Sa
         oEQ3RCbihZNo1kqFID+5bWWc+H5ApB3gZEwy2RNGq8fLGk4qEaBoiaDRaSiJwMHJsOsU
         dElPXSCPnbQWpDI+HjGi0geVuomuhtH1OAfjkk+KSO4pt8y0FyaRIucwmsxoK07dRkAf
         klqbzcitlmiRW8xmj7sKAioEkODdaS0K0nAbFMNd3Ge4X/0l031F6CeuXOuyKnRI92kx
         nBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        fh=tEXJk28J8L3y3DxFdqjO3pLnNdRXDdubUg3hGIn8Ycc=;
        b=MlHkfqY+Sdvm2XE4CvZXxEVE1jJFxrGEe2RT2+PWLC6GSE4s8fJsa6gGgHooVYMQWZ
         qx6mKDYMHuWOmCQdWVmrnbPI5j4WKEU+Ph1vUWujedF7mCHwYTbqnEx9EwB5zybI+MdD
         zAGo7Bvi3RE0GPIeVYRDZUfxvE94UN1Vw0YJKf6rk/ums1zl+i3VHmdvKkPIhJGoZC56
         kiX+/+N9u0eVS8cHYnkTEoJ/C4vSrxs7R2cYnlZoSPd3vXEk1k4x7vD+wyi+bREfXqOP
         Mh6VyIHPI/MGgHOL7YSxfTt0FfH/Ljsz3MGC+JJhT6ztrwgxCEUywFOTiJVI9uLeCApL
         a4YQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077799; x=1792682599; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=m9JljAdng9cVm0jl59Xi0MJgyOLq4pvV/3cbwS7gUNtOMsADYPhQRUpizGT9JUi/8o
         vynyWuotid3CxKlt8r8QBWvTjAO5qCp1hAdHF39WiiGeyCcJg6bzkqlVtEtX83nVdcO4
         GBloHhiGD25jEIJxzqYVtCh5at37X2BxebaXwQP7Bum67jZgWE01fXWRxuo7N9V9tZrH
         JUfpPc5taVeuN3GaGUS8kvmJ4VKvRs6ote/4aeE6yBxJGEiznWSE36Xggja4ypHeol6W
         ZRNNLTSuJ1ERG7G76jLMcpE4My8ybd1VBKvREntlQ+pRtcFaNOrKqR3ruLvQ/0GAEI4Z
         0Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077799; x=1792682599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EOHoPv3BQDykUH33A3omRl0PnRrEhVuncaHNdWKUGE=;
        b=dLK6qtXz+4kObUIHKbEgoeEujk/vCyygroiVP3MvWg8Lt6wssVB/0rG34+pjUkDFE8
         J1ODlR/TCkGHGzrv++djHDXEYxrxexgKP51kfcRzeQc/ir9n55syi6tmNr1GDl68Gb+8
         /k4rtPBFOfnEtTb+n/HT7orrWqIYwUckgrapEhr848k6LMVJWgJUvTKQOmFDZgEkd9mq
         o5wq9Rcrf3B20DdiFjjAW8qIsNRPwX77nS/oEku/V9/YYcAtbJL3NO6GF2m2oAbbCRik
         8q02L0ObsosvWk7VLUtSLQsHrWVkH+Gdi2Tmu06VeUCS6yE/Of8ZxwxrDan1NqYSs3q9
         N3pA==
X-Forwarded-Encrypted: i=1; AKwUvBxDdriIufFBO91lpzy8x93Ho50oD20hmc390lIIUGkhFKoU1GlRhy335DUx3m+yh4kiMykO@lists.linux.dev
X-Gm-Message-State: AFq9FYLkf3MTBdXQ1vODm27E4EKLV9ccwfxCcwcVJRQnzFFT10lf+NDR
	dajT5ZX7Y6J6cvTiI1AlhvgyTzpDj3I4Ke7t3ampu+L2bzGQ3m6PnHX/LNreFucc+igfQLvGKzf
	F/QmgUGhRN5lQYCeSJtNY7kt8Mk2ogV8=
X-Gm-Gg: AYBFou1ktELBrcnjdfuY9EXv/1JvQIK8etBmNpOUXJHYdL9fjQEf9hPWUm4jF4IKbAg
	WUa75JlIchIyiIHeekNKHmcXop0ZAsOhS4W6fEEWavJ0TdA9f7GHjVAH83J4Z5qXJxXllp0q9jZ
	1yHaNdOOeuoAfN0AWoiwjg9Aw/f0qAwlBiOqxHI+t7hoVq5TVkbQO4fUhIPFB8TFog6URXuVLyo
	+y3fDY8gxb962RbnfZrZ+rw1i3uEdnrwDDqyJSSqo5PdDJlMlzVSKzq7WQK1Vd68pP1cMGBYbhR
	Fn+n+lH8MIy2sY3faYilg6WiRqWnXtJGpcWg1YHV5/kO17S3KmyYCNs=
X-Received: by 2002:a05:690e:1286:b0:66f:94c4:51ea with SMTP id
 956f58d0204a3-6793603db52mr5927090d50.47.1792077799474; Thu, 15 Oct 2026
 08:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261015093854.2082600-1-huangsj@hygon.cn> <20261015093854.2082600-2-huangsj@hygon.cn>
In-Reply-To: <20261015093854.2082600-2-huangsj@hygon.cn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK8xZfXzISQM_5AP4aKpkZUrwKcxhhqslcqF8aMXobo6HxWE2h1pVZC0fso
Message-ID: <CAEjxPJ7xgpYOQVRSoBMK-_w4kmrPu_v37iS+q3Oj5TvtKUvJqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, 
	agruenba@redhat.com, mic@digikod.net, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, 
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:44=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
>
> This will be used to replace the explicit sb->s_inodes iteration,
> with the caller supplying a callback function and a private data
> pointer that is passed to the callback along with each inode that is
> iterated.
>
> A single iteration function, super_iter_inodes(), is provided, with
> the iteration mode selected by the INO_ITER_F_UNSAFE flag. The
> INO_ITER_F_REFERENCED flag can additionally restrict the iteration to
> inodes that still have a reference.
>
> Without INO_ITER_F_UNSAFE, the callback is called with a valid,
> unlocked and referenced inode, so any inode operation, including
> blocking operations, is allowed. The iterator is responsible for
> inode lifecycle management, so the callback only needs to implement
> the operation it wants to perform on all inodes.
>
> With INO_ITER_F_UNSAFE set, the inodes are iterated without taking a
> reference and the callback is run in an atomic context that must not
> block. This mode is for internal VFS use only and runs under a RCU
> read lock so that the VFS inode is not freed from under the callback.
> It is needed for operations that require tight control over the state
> of the inodes they operate on.
>
> This mechanism allows the existing sb->s_inodes iteration models to
> be maintained, providing a generic implementation for iterating all
> cached inodes on the superblock.
>
> Signed-off-by: Huang Shijie <huangsj@hygon.cn>

Perhaps SELinux could also use this to replace its own inode walking
logic at the tail of security/selinux/hooks.c:sb_finish_set_opts()?
