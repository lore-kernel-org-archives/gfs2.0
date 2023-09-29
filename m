Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217DC134
	for <gfs2@lists.linux.dev>; Fri, 29 Sep 2023 07:14:56 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1835954066b.1
        for <gfs2@lists.linux.dev>; Fri, 29 Sep 2023 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971695; x=1696576495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2OkkCi3457fhrun/Ka7gKdk+nLLGHEIhC9CyvKi8oA=;
        b=w0KbL6JJ46xq++FmpBQnh+nka4MKnpWbpNYSny8FGS2hd+UiCQ/CPfOCLGr6ZJYojP
         NrpHNSs6U52eEMw8eyfJnSSM4ZNimwIj0i/lJtAnqx9yc5qp9CA4Yv88yZnuXKog4+Sq
         wfB4h6rjd/8Gk/pYnoq7A/PTnHF5zNLqN6i+RyvFvw37mjTI3b1iXFeiZrAPgTAncia9
         Vr+DBstjCsvqa4qKlTwo+wu9uHoNgFzB9e4U2a1ylLKqrUicX7qohpButjVqwLemzVpy
         Yg9DRwtReDXCk7zP5qK5kunBmut9HUGF4cvzr0tL8WwarS1GG7mRJK7r7xUhvyWprsAK
         LQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971695; x=1696576495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2OkkCi3457fhrun/Ka7gKdk+nLLGHEIhC9CyvKi8oA=;
        b=P0NnkE6rMX59OwB9lA3lkobcSSgoFV+66AlWhQcAETxHDjX0JRtCCwEuHlB65Mvo6D
         reM8IU45GbvGq0jEhgZNGJeWbTTx4u3EOZpnhsspPCxzz95Ine7eO+Pi49cJEgUZQIm/
         L/4W34XUklHRGbdkTiyjQxB0an9pPUaFDEPQ1SvXdLJPFBFzG1777fEFJyo6lYWW+O/U
         v8D7GxrOGY6+yAJ43bZc7whSUh6lRSvD3uYk/+bTv4xMNPwDXZh+KtBWp8MehwURFamg
         e3qU1F2Z7AWysUZ8s9ECVmS/7XmhKbs9n91vY7REEfmE4loSdbdUaAchAJ1DW4biq03i
         7Saw==
X-Gm-Message-State: AOJu0Yx3cdFbi21lSH080VeOWQNUv2eS7DbgOY+uLaofqwLihLdnCOKT
	d8kbMppMCvQZ+Y3y7LsIQTRksg==
X-Google-Smtp-Source: AGHT+IGZ/E7+G4cnfaB8C0RTqz4HpzEQLdCBnqk+eAgNYK3UAcdw1uetqgquWBvnEbokDk1wX/u06w==
X-Received: by 2002:a17:906:28e:b0:9ae:552a:3d3f with SMTP id 14-20020a170906028e00b009ae552a3d3fmr3026696ejf.28.1695971695031;
        Fri, 29 Sep 2023 00:14:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b004065d67c3c9sm709048wmq.8.2023.09.29.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:14:54 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:14:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Deepak R Varma <drv@mailo.com>
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] gfs2: Set error on error path
Message-ID: <72de9c2e-7c60-4930-acfb-556a1f0fa4c4@kadam.mountain>
References: <ZRZrUMzweaJeEJuD@runicha.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRZrUMzweaJeEJuD@runicha.com>

On Fri, Sep 29, 2023 at 11:44:40AM +0530, Deepak R Varma wrote:
> Set the error variable inside the error path on failure. Saves
> unnecessary variable assignment during normal execution.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  fs/gfs2/bmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index ef7017fb6951..93bd8ea34444 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -162,9 +162,10 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip)
>  
>  	down_write(&ip->i_rw_mutex);
>  	page = grab_cache_page(inode->i_mapping, 0);
> -	error = -ENOMEM;
> -	if (!page)
> +	if (!page) {
> +		error = -ENOMEM;
>  		goto out;
> +	}

It used to be that the other way was faster?  I'm pretty sure the
compiler can figure it out these days.  Please don't randomly start
changing people's prefered style unless it's drivers/staging/ code.

regards,
dan carpenter

