Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2A1F09A3
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283322; cv=none; b=SS1vRkTifKVrZJOydkTeHwYGFn0AHYcKpQ1AmkqnPM3KHs8btNEwJxchK3Hi468Ru4iojPoRXcwXC5qh1mtoUMvP9a4w68eZgEB/ZOznk4Jzj+QDR0Oros6qqNAnP3dCcXoTs3dCoWB30s+VcU5X4Ez75b6sZ3sedMyAfAPblcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283322; c=relaxed/simple;
	bh=MjfasbkvLozAuDLUwKNcu2I7syMhRIXzhbBcoZ5SLlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJ6ChbC3pqYNC3rfdJ5uuuwL5vY5FCdi+dBouJslA6tYqk3qqVaDlMA+qqkOHxzfJSL41/wGYKxnTf97i5lVwksszHLhQUWI+4OzldSUSzX2qW4ZpL+KKEvdB6PFMCzTGmCnQt2/svcAn3fJzY2aWYQIll8MaOb34IMKLQhnEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LWUxykxZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LWUxykxZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e0f7b272so721066f8f.0
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742283318; x=1742888118; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czBGFYowHo3rVYg0keX1Lh5CN93SOpTUvsuR1Oss0/w=;
        b=LWUxykxZv0ZlxQbAtHEuBeG+FQsyD4E3Y+u44qSxtZmDqPX1a7RI1TiuZIeTWO1Nh2
         tsk5IKKfyNErqfIfpUbiFYI0IdZK8Xz7Ro5LdzSibe+ik1WT2hUeufuvEcIb70V+f/BM
         XxNgL+QIJDZjkSrt8N7gB/0+RWvlxxFUPl2ULi3H5wznrA4t8ZDGfQPL36OCxSQ/uF2n
         Yop3KJORLAExZy5dUDgmcjYisjW4F74O02GQDA6ppkxO+gzlvaIDEgMM91tJHmlcAR/z
         tlPS2J6a4OZ5TF9pEDQZVn3XSTfa9m04hmTCOiKKCT7M5m/pQHFX5QvAvCrC7dvGANrn
         4SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283318; x=1742888118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czBGFYowHo3rVYg0keX1Lh5CN93SOpTUvsuR1Oss0/w=;
        b=qyFFkFEQbRU+HlzY7Pnd1sL+rEavA2of1n+7SpyKEWWB5fFOb2K9uQ9O1q6q8zeXEy
         mygPduLXoch6zZm7bbsXC6U6iYaUoEl1UyaTSRw0ayYKKcY+mIwHOk4EQ/aIt7qFayBx
         3x+D0EfMXWaZ6Wk0Ds4hMtg6E96+pL8LKyDNV7VUUptW50yJrZPnSXiz10D9DkjndHQR
         iAarFptdDdQR/yuUllzJUBr999JoskGlH0gpmQ0aBLH8H6YmNramLUsICoMYrA7xqwDe
         8yj8DyOrhSIjiJ+JduZK6Tqt4Lfa+MT7E/nVT/qMooGCF8Y/j/vB3Xd1WBKAFxqDQxC2
         fsCQ==
X-Gm-Message-State: AOJu0Yz0ZnqUn5omDTWl1cH9WdHik5sDvS0cNF08D9dUTCn5D7svcVD4
	mkXfQja1+KKVktF5METPuluCroyRPWmnP/H0CJW4R+3BoZZ54qrpmZ/bTX+RufM=
X-Gm-Gg: ASbGnctsyUhfD3MSB9JG8bjd8kp+rdB61sswK0eje5v7/1xyqBXhnhD0Zp98j7+HJFa
	E1auGQ1tI+Y3GH8LEViKWcDvqz6ZN0fDwNlflToVtyEKR804qmNcK6gxARuU8XihzfVG0PuK+Fz
	Wqdr16AVUnQGfZ0ziXhz214OV9ZRwMCHq4v+SsntvMRu5FBZwIq0eHnZnczSso8iBKRC+8s2Gf6
	/RJViQC0QsEiOX0Max/fyAPjpxUHzMAO83PRhBKmXMipNYPSCntogZvymPP55+NkmrashLvjQMH
	Fm1YQdl1+QaktEky9eew9TEUz2OCoz5EuxTWIhAsu9iaLnboCsw=
X-Google-Smtp-Source: AGHT+IHV3lCGc7uDd3jGV+Ctw1AXOpkIxOOnwFxeEB/NPC5g6b9R9qyqsg/J87rt4+g3CggtAfeDVA==
X-Received: by 2002:a5d:5f92:0:b0:38f:27d3:1b44 with SMTP id ffacd0b85a97d-3971cf48debmr6223023f8f.2.1742283317926;
        Tue, 18 Mar 2025 00:35:17 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea0511bsm8358365a12.45.2025.03.18.00.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:35:17 -0700 (PDT)
Message-ID: <ec8715e5-5a0c-414d-b58e-07852cc683b2@suse.com>
Date: Tue, 18 Mar 2025 15:35:13 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm_controld: remove 'detect' mode from config item
 'protocol'
To: teigland@redhat.com, aahringo@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, zzhou@suse.com
References: <20250310073623.18607-1-heming.zhao@suse.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250310073623.18607-1-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping...

On 3/10/25 15:36, Heming Zhao wrote:
> This patch removes the 'detect' mode for the configuration
> item 'protocol'.
> 
> After this patch, dlm 'protocol' behaviors:
> - TCP is now the default protocol.
> - Stop trying to detect:
>    - use dlm.conf or dlm_controld command line to switch from TCP
>      to SCTP.
>    - corosync.conf 'rrp_mode' is not supported in corosync 2.x env.
> - TCP can work with multi-link, but uses only the first ip address
>    from corosync.
> - SCTP can support up to 8 ip addresses.
> 
> Note: This change requires a corresponding update to the dlm kernel
> function dlm_tcp_listen_validate().
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>   dlm_controld/action.c       | 39 ++++++-------------------------------
>   dlm_controld/dlm.conf.5     | 11 ++++++++++-
>   dlm_controld/dlm_controld.8 |  2 +-
>   dlm_controld/main.c         |  4 ++--
>   4 files changed, 19 insertions(+), 37 deletions(-)
> 
