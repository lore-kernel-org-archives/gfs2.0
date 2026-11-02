Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625084;
	b=Hfd5/rgYUlvZwX6DkNhwEDJNP3Qvdu7R4LpoDqRbnq3zJQkVoOjM6o9+t31RkSZ9xgjj
	 XiPCMCYnXTffy5XG1gQtYDB6dqMDSuw4d+FR8Cfs5GEF6B17HvlpS8VQS2aUQBLt8Tnf1
	 zkKb8tHVaifKm5f3fpzh8sf+9WgKdGqlJwdBBO4y+npwWnctIVN0fWeF+DcIh8f3Lm8LL
	 uYVPwtVeResFzOa2pRWKvq61O2kx/v3r7smWPZe7rhG7k4F3FZ0111S7J9cdJDfFoD3Tu
	 VZOU/Osc6FfV/rsszJTaqSLnvZiAhhhuTy06C0S2SKMrXUElSMm0X2Ty20to69guIqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/KkEapmHmEQSCa+rbG28ksVcUxF90U1MuYpU+KNvA6E=;
	b=JSqtBRTsdfk8h80Xq3jMfN/mi9qNaroJP8PwZqBQBcYDd8ZMvTYblWzlc5Y3FjtHO+Im
	 IdkZCUAkyipUJfJh6KTk5Us5UE3N21OkGP4mw3tGtcbCkcNwZVPHDdr0rfLxIw/vfC7Hq
	 XxBvdYpQCA+xTRs+6QpZWSoVTA06bzH7eGQZezQqq0k/Gl00bxF1Q1uvstpp3sN5fAU3V
	 L7d1Wa1G6skbeXF48F6qxOSja3Asa+VId6Rx1z2m9XT7odijHVKe4b3jnVyWs98bfMPeA
	 YO91EldHtjaR1PR3iKbDcmAE5FdnTZoptneK2pBGV0WqqQfIH/q5wRtonTKis+JPRdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=truenas.com;
	spf=pass smtp.mailfrom=truenas.com;
	dkim=pass header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=FBlFOM5P;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF733606A326
	for <gfs2@lists.linux.dev>; Mon,  2 Nov 2026 13:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF733606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=FBlFOM5P
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so23955035e9.0
        for <gfs2@lists.linux.dev>; Mon, 02 Nov 2026 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1793625077; x=1794229877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/KkEapmHmEQSCa+rbG28ksVcUxF90U1MuYpU+KNvA6E=;
        b=FBlFOM5PxgXWl7q+dQAGI9J1M+IkOppnfj4a+mfY1FwHy55NeYJOMzBEIxq4l0sDqt
         sNTUR66qXE7N304iDPqw6hUjvu+Z5SKj4rWaeTzpvVg6ucHQw4NCF0rQy09atzdZMioc
         moRPwPEVgQ7yKBr7UdIHBOD+sho9ghB+AdFkOrs11BK06JWOjbtzZ3BSX/Rlsa4eob13
         Z8YmEXQ6ZHsHO4CAWMt/q1mvSgYf6++HEVi1KsbUcR40nuPgAVoQQn8M5p01ppqbdre2
         OJPh54nG7/Jfoin+lwaYg7wUmvfT2Gs2dXPJwAyHycAD7i24JJVVhJ5ekr6K05Bshg+e
         p4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625077; x=1794229877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/KkEapmHmEQSCa+rbG28ksVcUxF90U1MuYpU+KNvA6E=;
        b=Wi3qeXqRtXjC7OS1b5rJxvlre1xhtnmo8OPuPDWahV9QBGxXgh6S5vBN465DE6b3D9
         ssjwAZPklYWXjjdSSrBYyjj0dskaAHkVijwdzFhTZ0/rdbm3s3Ky3u6EpnbelAwf3z1x
         VTC2g4rrucowFixbVRf0+KDeKAaMJc4ynh+4L9QuwC0OwVJOAALcUTrwbrZcYjF4MngL
         kTSjj8kfXWEKJF9Tn68BinyNf/oyVPX6mo2H6sbU6SyEgSuWbsMCfxFvcxJyH/6Zgbpo
         6yHiD8ogCmht8FG+jGNyPKladtuPWKU8RfJnUZwKTxhvzypIA/ilQupYr3+XehDiF/r7
         mVPQ==
X-Gm-Message-State: AFq9FYL8FqErh3zmQw3OIwlBvyHknAdSDMl23urIjCLIjwk+5yho3cHI
	5gcZoKIkCFDw72YNxF4iWOaQCqr58gVkIIY2waPh2NnMj70qDM8KNrZfzz+Lv0Jifw==
X-Gm-Gg: AYBFou1Ts6/Ug2A8w1QdupjynJL5HVkjpyxNWFeRE3eTSG4VSbD+9OmgPI3vKGK7B2g
	lB60XxbTG4T07EjfQNcQBhZv+tpP1O1gezkqTR6m5WSZTLEj2uCw9yVGoKmREUaA5iX+WfD4tB/
	ekd/2NB0dAtFvtRC2JdyXLtRo0LrVQTLd4iH0bFcWmICPlxHhoVQjI9GllU50FJ6LT4Cej2pOKt
	PujLAYoHf2NaRWd2e0Iarcc4M4sbIqKbu454WqXBD2Jrt+zBp9VcZgp4T21p9lYKoIv7Yh+SJBX
	KBoG6zoruhJMeGKYovZof8scbXhEyflTJOVHMq8RES5DYbMIirsmmJc/y3X2ZR+aYQO6d6ObiSH
	/X+BsY7NmCwQ/IXvExAFlt++bm1XLoMY5csR1u5o+JwWctkgAiTtdIEOmkn8kPSt4mBCB+5SZZl
	N3FIYbgI6UyYDZnvbSmDM0ZBAxzMu2XPgTfy+GAu5Q4qbvo2lQzwz633uIbo/ITdBI5qbBpay5M
	AZ7vPeKcEMu8aRSGBGWmovtPjKR6yLS6204MOjhAJMTGT6p49QVbuvqyYWbv5aLGR+X4eI+5VT3
	h923Z9g=
X-Received: by 2002:a05:600c:34cf:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4ac150b3d01mr239787765e9.2.1793625076958;
        Mon, 02 Nov 2026 05:11:16 -0800 (PST)
Received: from hamza-PC ([2400:adc1:158:c700::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm439341455e9.3.2026.11.02.05.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:11:13 -0800 (PST)
Date: Mon, 2 Nov 2026 18:11:09 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: Alexander Aring <aahringo@redhat.com>, 
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	caleb.stjohn@truenas.com
Subject: Re: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Message-ID: <auiKrrdwZbPhZamy@hamza-PC>
References: <20261019151627.3324886-1-ameer.hamza@truenas.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019151627.3324886-1-ameer.hamza@truenas.com>

On Mon, Oct 19, 2026 at 08:16:27PM +0500, Ameer Hamza wrote:
> When a local request reuses an inactive rsb, find_rsb_dir() sets
> RSB_MASTER_UNCERTAIN if res_master_nodeid is not our nodeid. This also
> matches an rsb that never got a master (res_master_nodeid 0, res_nodeid
> -1).

Gentle ping.

Thanks,
Ameer Hamza
