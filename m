Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A51DE3A5
	for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283345; cv=none; b=QiS5f4qjlAH270BMhKPHyXdFiRLCHf6sjqaD+Hv2XHgXzKe+I2EjcmhE6zdS3UDUI5gTmWFW2AsJTW5zQHVNDK1y1JBSPIcavK16ucr7wQvSmzb1d9hRuDJKz/Euex4S8QLfyadLDJQmYDhzDnIIV/TavK7GCbqYvvp+N+6+2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283345; c=relaxed/simple;
	bh=FJ4jE9yFC2nYY5IdygfgK1LO8MdT3twCa6T9958QBH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dycwrlsx7I8erjlUT4TlWKh1mV6uHbxlLd/jZyHwHGN7OaROGnd1NnX0I5+xZRjkdd4+Fxd4KE/YLSHyHYrdrO3Ac9RewYo5MEqCpw9lmt+unSL/VcNdIgoz1dH0ZcALQiBp3Ejw87q7utRgEyi002Nf7yY9W7kwb3l2mcYmJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gQQAhWYZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQQAhWYZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912a28e629so230448f8f.1
        for <gfs2@lists.linux.dev>; Tue, 18 Mar 2025 00:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742283341; x=1742888141; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVACkW8NNNYbNixHmbHNluzqOP05/zeU1eJo6Tuoc/k=;
        b=gQQAhWYZwqbkRGC812R3JIuzrS1016nTuwpckkmPcOc1ifOvIboWbMS+R5Wx+ehJuk
         luPUmxg9qYHCasBuAt7Ek1fx94o7KFoW1evilYAQjKxK/kFMI+vKK5Saletd9nFF+2NR
         UqXxxFoqN1xOmmoeSh6LD/in8WpC68NXroQnPEUDVZXm29nMKTyxnbkDEof4erJcmiTZ
         ulllyy/D7ViHEy5lx8C4u0uG4/iPgzutZxIV/OjETn8Jb5SdWN1HT3mw6wRwjxdVIUyq
         I7g98DoyfS9fDhBZafanD54ZZhEpzrcLfwpr1tde3NeKOdOIUbSLuzNqIM1vQ1sr479Z
         bAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283341; x=1742888141;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVACkW8NNNYbNixHmbHNluzqOP05/zeU1eJo6Tuoc/k=;
        b=tGBnVH05Fj/RCEZNRsFSatYfPvse8Is3d7qWM49EylRSHzDbk3GUwuA4ar5CHZxkbs
         h5IK3K1ITw5DSW0M7kf+mEwaXUDe0ov7A9aJr2jC9hjQq5QYTE215mG7rz2zCSAbu826
         LUVSXToR9xrEiQruSFZHnBkdrxs5m4LoGLizgpU6Z2hQ6VRwI/3N3gYgcr60mBAP5HlX
         bgxbhk65Utz9/+Ybp1Y9Szaae1zzCXpbsjx9ULhFtoQ+eHW06AwHTz+1RpGw750GxICH
         CK2gnMBtmHXsIgg5Iu2NQ37CeDJtWlOm7y8PeKSxUk/3hJyifVg2kL9n5c/HnciPVp/8
         fDDg==
X-Gm-Message-State: AOJu0YwbAP7m4L+HkoO2P3pGnkqpBrj0wLrOk6mC2Ww7lOMXQQDog3Xf
	+ASDGhLptSKfGFgL1GQ3ZZ9RkoJCYEUlxK9PDICU9Rxv/YPbm8S5BrPHZ4gDLXI=
X-Gm-Gg: ASbGncvF7xWq0+pHOoJ45M3E/3rHkoD4UNP4Znl247qLCAuTe/LENBEFj1FtEWwc8rG
	9taZKshfxHf4h/U6fBQQJqn5fapk46Sc6qoY0bm7baWJlIpBp6cu0R4EaAP8e0mfhljfPY1sZIM
	1b+c1xPT6ZFbpptximjYQ83bhjXh542pev6v79fKVocH5DAGAbZgrUwy6m2dFe0qBXJUQShdozr
	gIiNHIXOvCB4JWXyLG12ZHD+wXzJox840KvwGPwhWOPJWAsvF1XJa0p13595lOFgL/A69CCVfn4
	heK7caw2x1fUywMqEc1QT7eWMMpBo4IQSoqjAdbttHX9FUQsP/I=
X-Google-Smtp-Source: AGHT+IHNNm1lRCIk2Xb8sZjAiG+vPzHc9bJaF6PjKSPyJ4exek6vJe2RhIyRS0/ZpSiX8UFMcGHhWw==
X-Received: by 2002:a5d:64a4:0:b0:390:ea34:dff3 with SMTP id ffacd0b85a97d-3971cd57ea3mr5741491f8f.3.1742283341211;
        Tue, 18 Mar 2025 00:35:41 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfb4fsm87535855ad.208.2025.03.18.00.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 00:35:40 -0700 (PDT)
Message-ID: <22ba5d23-ce27-4619-a4d1-407a12add822@suse.com>
Date: Tue, 18 Mar 2025 15:35:37 +0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dlm: make tcp still work in multi-link env
To: teigland@redhat.com, aahringo@redhat.com
Cc: gfs2@lists.linux.dev, glass.su@suse.com, zzhou@suse.com
References: <20250310073623.18607-1-heming.zhao@suse.com>
 <20250310073623.18607-2-heming.zhao@suse.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <20250310073623.18607-2-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping...

On 3/10/25 15:36, Heming Zhao wrote:
> This patch bypasses multi-link errors in TCP mode, allowing dlm
> to operate on the first tcp link.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>   fs/dlm/lowcomms.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index d28141829c05..70abd4da17a6 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1826,8 +1826,8 @@ static int dlm_tcp_listen_validate(void)
>   {
>   	/* We don't support multi-homed hosts */
>   	if (dlm_local_count > 1) {
> -		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
> -		return -EINVAL;
> +		log_print("Detect multi-homed hosts but use only the first IP address.");
> +		log_print("Try SCTP, if you want to enable multi-link.");
>   	}
>   
>   	return 0;

