Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED33D78
	for <gfs2@lists.linux.dev>; Fri, 29 Sep 2023 07:06:27 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3231d67aff2so10176533f8f.0
        for <gfs2@lists.linux.dev>; Fri, 29 Sep 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971186; x=1696575986; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+codVGGhv2SeiYMJcTB77YXyphBd1FT0aX06zEio1mg=;
        b=iYyVJrYlI6yNP1a0Oo1Tmrgg1DMjfivTf3JhN0PWtGaWz+13tPecETtEFVMKqrMwB5
         wQ+3OvMCA+SOvW3bMv4CKREKP/GYBVOKUAIXzejdaJWIqrrOVv24FykiLDY8o4RTyIoj
         HvMOifuIE6m0Mzr1pUibeOvlEiZlClI7RaM71514jDpyYPOIbjcdVrsT3iDB0BpbQLtR
         yKmhmZjHVq35PRVxDBDz5Za6c1e265F3kfFLFlq55AOUiFhU8ttozYFET4sUJXb9U7I8
         e57eA/kNZV17skXvwuGADIhJGO+k3Kgck5N5BfswWvHA0tL/XBfAv6USe1Er4/ORaliT
         KjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971186; x=1696575986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+codVGGhv2SeiYMJcTB77YXyphBd1FT0aX06zEio1mg=;
        b=AOk1f5X8Yf+Dz7qL8E/p7rPMmm2Iy0mc8pQAQR2uppBhkJ3FWdrRo/1AbHoLlN2dHu
         ydh5rKvR2escdkWKQgiz5xevS8vS12cPdoHNAG9Lsu3570S6Ee3pRl3QAR5tNdvUh9yd
         IXfmYLPO8EM668yOmeTJZjafGGWPT0k4gBEefXZAG2pXJuXGFcb5Kdi9JXkup4/U4RE2
         uQddj7dj8Z49Pwc9xr8E18zBDHWKxM5nt6o232RRLah1IjF1w0FsIG0y3O7vE4L7AAgx
         XLrnJzF4efkePBcnITG1kEEMY00ks91utwAuw3PFeFnHdSZC72Gdch2KArNYLdz3fgML
         IUcw==
X-Gm-Message-State: AOJu0YxVk4EHzVqKzYaraZj6IZcqQDEIC6lv1BtvRb9QvK+BSqUhMDrl
	gnIUav4XDnCCb8H95cH0vooozg==
X-Google-Smtp-Source: AGHT+IHLqhqTQu0Fr5JMPqWwa7uQJwfQRsA/hKEBcTKE77tO24/89NMM282LtWvd6H4sBTkNo0TI5A==
X-Received: by 2002:a05:6000:1085:b0:323:2c39:bb3d with SMTP id y5-20020a056000108500b003232c39bb3dmr2776319wrw.64.1695971186094;
        Fri, 29 Sep 2023 00:06:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q18-20020adfb192000000b0031f8a59dbeasm8634280wra.62.2023.09.29.00.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:06:25 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:06:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Deepak R Varma <drv@mailo.com>
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] gfs2: fix 'passing zero to ERR_PTR()' warning
Message-ID: <a2d702b0-e819-47b0-a945-c2e38a162381@kadam.mountain>
References: <ZRXA7n0wD83zhPxC@runicha.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRXA7n0wD83zhPxC@runicha.com>

On Thu, Sep 28, 2023 at 11:37:42PM +0530, Deepak R Varma wrote:
> Resolve the following Smatch static checker warning:
> 	fs/gfs2/acl.c:54 __gfs2_get_acl() warn: passing zero to 'ERR_PTR'
> 
> by returning NULL when an extended attribute length is zero, instead of
> passing on zero to the ERR_PTR().
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Passing zero to ERR_PTR() is not a bug.

You're patch doesn't change how the code works at all, right?  So it's
like a cleanup patch.  But the code was nicer in the original.

This is just a false positive.  Ignore static checker false positives.
Fix the checker instead.  Although in this case, I can't think of an
easy way fix the checker.  Perhaps don't print a warning if the callers
check for NULL?

The passing zero to ERR_PTR() warning is actually a pretty good
heuristic.  90% of the time in new code this is a real bug.  But in old
code then probably it's 0% real bugs because we've been reviewing these
warnings for over a decade.

I have a blog which might be useful.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

When I'm reviewing this patch I think:
1) Does gfs2_xattr_acl_get() return zero?  And it does.
2) Does that look intentional.  It's harder to tell because there aren't
   comments and it looks like it might be a missing error code.  But
   when you read it closely then actually it does look intentional.
   In terms of Smatch, I consider it "intentional" if there is an
   "error = 0;" within 5 lines for the goto.  (Other languages like Rust
   are better than C because they force everyone to follow the rules.
   #trolling).
3) Do the callers of __gfs2_get_acl() check for NULL and they do.

So this code is fine.

I hope this helps you in your review process.  1)  Ignore old warnings.
2)  Ignore false positives.  3)  If you think it is a bug, then try to
figure out how it will cause a crash.  Look at the caller etc.

regards,
dan carpenter

