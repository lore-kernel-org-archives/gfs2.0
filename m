Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D415278156
	for <gfs2@lists.linux.dev>; Sat, 12 Sep 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220535; cv=none; b=XTxEpc6Vw/zJ2jsKtcr0ZtDkJJhtaYkYFiZDKwlVAVLRt9ZH7sZKtc5LIHdJpgk6tUmeJb6xYer6UkXLfW5x95zgG1gNrdYuAZRAe3tM1ANl5BW1dI4rVfW3gt/uqrGfa9/81Xz63mIgtaA1lHbINusbHd57dctM147v/G40QaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220535; c=relaxed/simple;
	bh=vsuwVSiplWlIRMCHW7Lp26gGoJvpEBBWupkUOScc2fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyQeud8syRinA5zg2SsOh91yWKTW9Ax0drCLSRHynpR6u5Kr4rSV+nV0eE3RpOrkc3hKdi5qZ2A3Vusq+s2o6ylgWjxrMVOH5O9/SOuAn1QX6qG4MuTrGWo+GtV0OV7NGrTkokSsvq0vGiQrYA9Q110zINRjlbd+C1SJO1JgZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhCYm9Xe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhCYm9Xe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789220532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87yNTtGOMF0MCh3k6ypybUnWZA7MEZgOnf1EeaRqydY=;
	b=NhCYm9XeymYBXjnAqeDjlsq2rc9iNpeQVKn8jinn/KsqWSkuo0yOMYqWf5y+/n9sRd/kCJ
	TfaJ5y/b5GwVeR0N97ZkAvy7aebebjZZ54RZAgf+DEIgdT5JODlBSl23FLGqEwi3CF1sti
	IyqB0L1aVjettNV+3xr5V/BnEJXEKrk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-gKZk0fdvPrKYG5ZffZC-KQ-1; Sat, 12 Sep 2026 09:42:11 -0400
X-MC-Unique: gKZk0fdvPrKYG5ZffZC-KQ-1
X-Mimecast-MFC-AGG-ID: gKZk0fdvPrKYG5ZffZC-KQ_1789220530
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8823e0226edso32019147b3.1
        for <gfs2@lists.linux.dev>; Sat, 12 Sep 2026 06:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220530; x=1789825330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87yNTtGOMF0MCh3k6ypybUnWZA7MEZgOnf1EeaRqydY=;
        b=P+swPjjJvjt5UNH6UnMp543YYVqyKRE0YlPzIURAn1vUDZWm7yxaeee1T2WbFywQNg
         laOz0PcYbG5LcCUsw8R8c+Il4I4Q35jsEjhbjNl3snEfEwAm5eP9QwgmKgJYYBmOROfc
         7sVL5MskjUWVw4Ve6xTwWb2o/wsglY3xD+xie8NleAE3t45+RSSu9yUJGaW9t+PW4yCn
         jzfLi/KQbBAqCgResDcfX1xNlJI9ttmiPcoiRoNBXhW8PwsMDZVqTQaCe21+n/s3lp4j
         I0+oKw00mUGyJegkKbzsMDtENF2yU4E3ZuYr1tf21PUh5fi+cHqt56ULjylLOuQ+0ciY
         xiqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+J0uFg2xvlihREXDCcLNTthadwYV97qoD9FpqHv7A6Hrgm2hu2dEUEqyMvVhKnSroaYdD@lists.linux.dev
X-Gm-Message-State: AFuF++kZ2OuDBdc8H27r0/kJYJeE2J9sTWGS8M3+iBahy8ay24daC6ih
	J9uQfMdkkqqk7TS03Gwaksum9IgB50sTIImugRBIMAQlZ/vEn1QxCi2dZCk41mjo+MbhVG/U4DK
	Wx5bJHtf1Ugi2yOTyHhqMZbB7wwoNAsvuw/sExbKCYyxJB6UjO8hwihM9FUJvPd2HZcGEvdEEWQ
	CqkDLiOKdNoj6NKNIDKvoTd6apJJjQAw==
X-Gm-Gg: AYBFou0CH9iH/nFPlhJALj4/QFDDnti1BTZFvcb5/yysUPuwIbgJgJbJV7xBmWTM+Hy
	n4y2u3x16rjrUb8qkgwm6T/s/Yu/zZHvdNUzh1X1z5z8N9abPkLEXZNaSx4wPuZfUNA+WxDjwLN
	+34Z/f/lg5t/aeiukB24CsOKaPIyv6obUXq+YD1mBVRk02coKMwq7vY+6TV/mhMsGCoE5AtHPFT
	u9rME8IU6uO+Os3RZhMgS0T861CujafAn47KcrFsHvQ
X-Received: by 2002:a05:690e:d43:b0:66f:c1bc:c077 with SMTP id 956f58d0204a3-671246cf55cmr3181932d50.63.1789220530508;
        Sat, 12 Sep 2026 06:42:10 -0700 (PDT)
X-Received: by 2002:a05:690e:d43:b0:66f:c1bc:c077 with SMTP id
 956f58d0204a3-671246cf55cmr3181922d50.63.1789220530046; Sat, 12 Sep 2026
 06:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260912062614.42899-1-kmehltretter@gmail.com>
In-Reply-To: <20260912062614.42899-1-kmehltretter@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 12 Sep 2026 15:41:58 +0200
X-Gm-Features: AcwNN1VkqudTxhzQveFbYQ4CrzcEuW6UG-ETzUb6nXW2-0Rd91KL7t0znM0RfIM
Message-ID: <CAHc6FU6QnSb2fzqJQtpdehiE9DRfCoJY50Nw1YJBo4An=gkKig@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix the return value in gfs2_get_link() kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VdOtNY600hp7PwBVFqEVj0PEOyWqFl1o6nV67C9aiRo_1789220530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 8:26=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
> gfs2_get_link() returns the link target or an error pointer, but its
> kernel-doc still describes an integer status. The mismatch dates back to
> the change in its predecessor's follow_link calling convention.
>
> Describe the returned pointer and error value.
>
> Fixes: 680baacbca69 ("new ->follow_link() and ->put_link() calling conven=
tions")

Actually, the problem was introduced in commit c177c2ac8c5a ("Switch
gfs2 to nd_set_link()"). I've updated the description and applied the
patch to for-next.

Thanks,
Andreas

> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  fs/gfs2/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index f361876c5583353a1196ed35be1c95af33a90c02..d5e03ec89127254654dceaff5=
6322ed617a3400a 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1900,7 +1900,7 @@ static int gfs2_rename2(struct mnt_idmap *idmap, st=
ruct inode *odir,
>   *
>   * This can handle symlinks of any size.
>   *
> - * Returns: 0 on success or error code
> + * Returns: the link target on success, an ERR_PTR() on failure
>   */
>
>  static const char *gfs2_get_link(struct dentry *dentry,
> --
> 2.39.5 (Apple Git-154)
>

