Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF283CD2
	for <gfs2@lists.linux.dev>; Thu,  8 Feb 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414160; cv=none; b=f5y1c+J78mxZ9dP6Y2LSnC1xgUs1GNrGHmz47Ra13VbXkCfs64y1re6f4GXIKyvGTXE97eLsNNEA8eSdpbNGTk+eLIPtzNvSdhulwa+h1Kr4P7gFJ1VweeNZQWfxjQdJdpGqzXb6ujosQQi9jKyfaPezxNP1B3fWbIVwqbc/nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414160; c=relaxed/simple;
	bh=jTyqq1McBzhXuBGoQDTNsRl0bVoBKu3QPqRS+ZSe964=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8ofc3azzWKwSKgpg8hnUwfSb5z+JWQKB+qL0WejbePoYqjqAqgK698XYsmcsIIig45A5gd83EJL+SP2is7O+KkYNKQY2RMrvInnQlhzrlTpOhHuTL49C7zj1kg3UZKqVy/mVmC3jJMantXd2PKYSKTd8IQTlQu7iTgla/G71jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Snc9xgSK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Snc9xgSK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818f3cf00aso565286d6.0
        for <gfs2@lists.linux.dev>; Thu, 08 Feb 2024 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414158; x=1708018958; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE9yJofYcIrp+q8fl2NtOvzDEIFhiUUc4detkUYKRUo=;
        b=Snc9xgSKS9o7e7uBFXj7SDoPZiSw3SYaZUEaf6RTLf34rcNvVkEjYoAuc+mnEGUrLo
         5m9RJufK49RiLeVDsLGRu7d59Wu6eFAc5f2mOvkJGNTRw9KTyKF2Yix5MsNAWZQaOtW1
         bXbsftY0A2ejhUfHCYe7y4T0cc8qsgp6gulaiaOG0Yw3MWc/aeqHSZ1p4Aa0YWkbzAZ6
         Xjk9HIQvNq4HW1W7j2FAtZ/rjpFSi6u7TVk5p6BMTDKWJMUKEZVC0lWy1qWoxqoFelEf
         PEePtypXrX/YZ/7BqzvDbeCSGYGiDQ7VUkuHm/2EXBgpUK8/UPsGhhwQ72+mu3CNKLLi
         0WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414158; x=1708018958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE9yJofYcIrp+q8fl2NtOvzDEIFhiUUc4detkUYKRUo=;
        b=eq3YpjXB4/GWuTEw/mjN2nQ9AowwH/1BJ+elACycbvDVUzKXZbI0CP916WgvQzThvA
         c8A/uAuwN1YlfHQYBmlvKnY2mVsknI6mTEf8CihgOKtv0pdSwyee9VzygeE5d+QGZmpl
         d5vJfNFfd39jkNlFKbaDnFmwDcaJ8dOFcb9haNnUqoWrWym4RHF5ZmHY867KSFwU54Ed
         qWyyf3y6cHeQs2BZWYTIK6wdGT2yCDml2qG7t4b+Y5yksxuyzglhX98uMkGKALxxfem9
         66fAU9eeYcpqQzU/zHUrkKLC/xIKwhzP4KLrDhbk/i6UtyiM9aokiJWR+D/lZUxhLFDW
         wEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh81Kj8e7HBhhfxO4whs09+fSM/DNmXzzNb33DPRCc1zfRGUl5f+C1AF28WwILrchxKTarScFvC7JSaOjGy7xN6jZJXw==
X-Gm-Message-State: AOJu0YzH3ASNBX7Nc7EHnKsmRNGmKOqJyXDSxi+jJ6Rf+a9tA0c+GtHG
	v4tpVsCgapbCopL6tj+Sk0Ivf6yiKRYbYZVmjJ5Bdc6mSM/x+Z4E6fIIboAz6PiL+MUqpjSz2hG
	aSwQoUKllF6lbLdtrHcChmrmQKrnPRYRdYRqA
X-Google-Smtp-Source: AGHT+IHisO4YeJ4HMjJTJ7Pa6g2UoWbHmyDF6/F8nMdBmOGtjRmAF7AXJRfz3Lb4ftoWcIr8EGxQVdi4TlQ13SQyHQk=
X-Received: by 2002:a05:6214:258b:b0:681:78cf:3920 with SMTP id
 fq11-20020a056214258b00b0068178cf3920mr12087645qvb.25.1707414157664; Thu, 08
 Feb 2024 09:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
In-Reply-To: <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
From: Jordan Rife <jrife@google.com>
Date: Thu, 8 Feb 2024 09:42:24 -0800
Message-ID: <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:37=E2=80=AFAM Valentin Kleibel <valentin@vrvis.at>=
 wrote:
>
> Hi Jordan, hi all
>
> > Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> > and 6.6 stable branches,
> > it looks like there is a mismatch here with the dlm_local_addr[0] param=
eter.
> >
> > 6.1
> > ----
> >
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >     addr_len);
> > }
> >
> > 6.6
> > ----
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >     addr_len);
> > }
> >
> > 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on hea=
p) which
> > changed
> >
> > static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > to
> >
> > static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > It looks like kernel_bind() in 6.1 needs to be modified to match.
>
> We tried to apply commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on
> heap) to the debian kernel 6.1.76 and came up with the attached patch.
> Besides the different offsets there is a slight change dlm_tcp_bind()
> where in 6.1.76 kernel_bind() is used instead of sock->ops->bind() in
> the original commit.
>
> This patch solves the issue we experienced.
>
> Thanks for your help,
> Valentin

Good to hear that works for you! We should fix this in the 6.1 stable
kernel as well.

IMO it may be less risky and simpler to fix the backport of my patch
e9cdebbe23f1 ("dlm: use kernel_connect() and
kernel_bind()") and just switch (struct sockaddr *)&dlm_local_addr[0]
to (struct sockaddr *)dlm_local_addr[0]
in the call to kernel_bind() rather than backporting c51c9cd8 (fs:
dlm: don't put dlm_local_addrs on
heap) to 6.1.

I will have some time soon to fix the 6.1 backport, but it may make
sense just to revert in the meantime.

-Jordan
