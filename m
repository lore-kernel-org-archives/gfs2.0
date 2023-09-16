Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E536130
	for <gfs2@lists.linux.dev>; Sat, 16 Sep 2023 03:37:53 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-564b6276941so2236157a12.3
        for <gfs2@lists.linux.dev>; Fri, 15 Sep 2023 20:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694835473; x=1695440273; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MamcEDvOme4a2UOw6srKCp4ogqANdQEsNNNirgmTbh4=;
        b=an2r8klAPs7XL30k1aVDIy07bX11KofNtNJMIneJIkDjFtzFgTMBqnbTErazJV+8FU
         KRQkKkT9BFundSBbfpJQQCj/uBVrBDLkZwHdW+EnL21NwdBP/G9mPIM6Hr8DfjOlMZ1L
         AR74PqzIygoAfcYNAHbhbvsn7BOvnLrRDbe+lMgJaPgY5UsqZWHA2PyO6v2R+X6sTJlI
         ZyfAKsHUdJRIWK1pLgFH9zZ8aMlEOYLq3prJAwKmiSrZ7+wtstXFtmIlzNdo85wMPYNn
         LQPMtWH2PImDVQw79h6IPYrTuZyxARLPULsKOAj2dHyVy+5buNT+dIuMPWY3uKUrmeG2
         +0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694835473; x=1695440273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MamcEDvOme4a2UOw6srKCp4ogqANdQEsNNNirgmTbh4=;
        b=bkmVHPQ+Wqi9cZQtjoYY3CnLj9c5qIWt9O2/GALOzP3ibDMI9cFLtLXIokQEap7MLr
         9RFRTs+77Pt46riiLY4BojnTa8VozrTbJZqnMQoUoEtpGdbaKNMCyYeMAJuKy0kSNo+t
         2jt3WL6G5z+pJS5X0/pvoC9UMyfFOM5KAwvNLDR8oKS2EwvB+8fn0SJDdm+CPzLlPZ0t
         vNbkPI2s3UlmQWDnOqHA4k0tYZoxbChvjvAYz2fxsVsrWeUKlCLcvkXjuSKmO7ccfGQX
         R00wg6Oyrsp2vW1J0jVgUAwYzRclqI4+Q4uj2VHaP7pqqZgXZZ3EJ1f86syLrGGuwXr8
         dzJg==
X-Gm-Message-State: AOJu0YwOit2T7wIUCYVxWbYEKvSTIk02Sv/PNPLMniIOqWEEg8YZiix/
	+SpyFpadFTzy6GUrcnmprw0=
X-Google-Smtp-Source: AGHT+IGn6S2xCOQh//vR4rS05z7qGzMvUp83sDyYD4Ok01CZ3JZk6tO6zadOMbgIsEAl7do7p0V73g==
X-Received: by 2002:a05:6a20:9703:b0:14d:446f:7212 with SMTP id hr3-20020a056a20970300b0014d446f7212mr3607639pzc.46.1694835472990;
        Fri, 15 Sep 2023 20:37:52 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001bdc8a5e96csm4225959plr.169.2023.09.15.20.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 20:37:52 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date: Sat, 16 Sep 2023 11:37:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander Aring <aahringo@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>

On Fri, Sep 15, 2023 at 10:05:06AM -0400, Alexander Aring wrote:
>
> My question is here? Is that allowed to do because a resize event may
> change the order how to iterate over a rhashtable.

Walking over an rhashtable should be a last resort.  There is
no guarantee of stability.

If you skip entries after a resize then you may miss entries.

If you want a stable walk, allocate an extra 8 bytes and use
a linked list.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
