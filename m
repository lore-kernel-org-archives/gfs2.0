Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03227F4D0
	for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759648; cv=none; b=CBLUxzbmgaXuvgT9fnOm+irsbm9bmSXju2d5zp4ddNih5wfC4rFn50OJZKTUKIULyicRz9xFyOUrh8nnntLaHEcW0HFT6tX53PSeuAvUNcJrblBZnCWr5FYMY8f11P8PvLdDWkGXL1OAC4JUPFgySaUu4s80d3awnfukLSMjMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759648; c=relaxed/simple;
	bh=W+CM9mO/ETwaXyRHsX7BAiiGsjxFt5RQdi+vc9rW6+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe89n5GdGFV189FHJBmhiTPcm0U9VFzxQ2uxD/lE13zDcXUngQkeowW3VWo54tqOp12xbFh2eUFRKM13ArLs8T1x5cEnTFU2CwU6ihUibu4uGiEJJgokjJzEooF55Hi+BEZItNoW7LBaRQ6HAinQI+m0xp2s3HFPZNTeGJHFpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S2FReWyM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S2FReWyM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a442a3a2bfso83253461cf.1
        for <gfs2@lists.linux.dev>; Tue, 24 Jun 2025 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1750759645; x=1751364445; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPlvv9Q47LZ5cAIWrnNCm2DnqvLNTn1tPrP8Q6vlz2s=;
        b=S2FReWyMomDU2/cmOZmsB1AZ2+56IrC2b5dyjXmZ0f9r2k/5YkVb1zNXNp79U3CGSI
         G1cTbC3nvH6rO+2lFqoYB4o2oOIzklRjXflJdHuX6/FfLz82aUh/iruiy50aelxfly8F
         VtwyWi0kBjSOgc10Qg9PxuR9yp5KqUm9n3RcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759645; x=1751364445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPlvv9Q47LZ5cAIWrnNCm2DnqvLNTn1tPrP8Q6vlz2s=;
        b=vyBzfAyngZ+5MoSZi5God9WbVTbpMcGEwjz4zeOIu1lROTHY3lf2qT+RjNnfjfs02O
         GmlhRzG51u5N0bQ5Rnu5Ymjkr3cGb2bor3+hMkyEcQMdL7W+DP6cpXBGIzAVtbQU7tQM
         rKIiZ0RRxmuEnOf8zFpz9V4pQs4JjhgBCA9qSGJ/UOLVG5CdYO2tP6VreqBmzkzd3ZtA
         0wPKrbHhp87s7GQ7qjAZ7zpnouK9TZQo3bxnWp6+8ZPEq3wIjVz+50CuX3XIXc+1ADUA
         PKncKwAo+q7k5dnoJEXfhOmx+4DBlYij4s3VRBU5YUObr1pWgVmb2BfFUGxV6NLmjbuG
         55cw==
X-Forwarded-Encrypted: i=1; AJvYcCWPi2dHOOPWr1VusS85vJvKsJW5WzLmTgYykWYDrCTO3T92eZEP6an0Gs847b9ZXr1le3uA@lists.linux.dev
X-Gm-Message-State: AOJu0YzAU+nvSefvdCDfons/ptiWFjTIAWCiGIIuSpfN32c2sd49hM5a
	lt74C8pazyBQ512m6DHslqMWvHsgnGvs2nJXaD/ceJDje7SygR5bWq+fH3hLVV+VzQzpttyc+E6
	SGc0fAyUzChVcs8SCGrU+F4Fa6BYnq5mdgpC461Lmmw==
X-Gm-Gg: ASbGncu1yJMPj6gXffoUWNzzP8FG9uJuOr37rBLN1kDLKaqD9m5aGgGafXJAxvSRrUO
	o65iJ/sNNbTxB6oRgSQCWhA4Nf3OndVsHZjpE6H6FVrGXBvj/7Tb4WOIknjDAaSWWFq6BDX9yog
	/YDRR3Acb4NASIzTxU0GhV65i6UyTuMcbQMlpHaKrhM8QBoTShS5TH8g==
X-Google-Smtp-Source: AGHT+IH0x0+iRHOWa2KqbV5wn8xPjJLoyNs9pTpMyvvOlaqhWqr33e0pXkymA/nSZQXBfDKBFVAgqMyY/CG6d2NNlt8=
X-Received: by 2002:a05:622a:1194:b0:4a4:3be3:6d69 with SMTP id
 d75a77b69052e-4a77a2cf554mr254409501cf.41.1750759645024; Tue, 24 Jun 2025
 03:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com> <20250624022135.832899-13-joannelkoong@gmail.com>
In-Reply-To: <20250624022135.832899-13-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Jun 2025 12:07:14 +0200
X-Gm-Features: AX0GCFu5oKUxjJA2CnW9KEBLReN6IYqX2gQbksH-7WeoCgZJDO5EaGGt1ih0KtE
Message-ID: <CAJfpegt-O3fm9y4=NGWJUqgDOxtTkDBfjPnbDjjLbeuFNhUsUg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, brauner@kernel.org, 
	djwong@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 04:23, Joanne Koong <joannelkoong@gmail.com> wrote:

>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>         struct file *file = iocb->ki_filp;
> @@ -1384,6 +1418,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         struct inode *inode = mapping->host;
>         ssize_t err, count;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> +       bool writeback = false;
>
>         if (fc->writeback_cache) {
>                 /* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1397,8 +1432,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                                                 file_inode(file))) {
>                         goto writethrough;
>                 }
> -
> -               return generic_file_write_iter(iocb, from);
> +               writeback = true;

Doing this in the else branch makes the writethrough label (which is
wrong now) unnecessary.

Thanks,
Miklos
